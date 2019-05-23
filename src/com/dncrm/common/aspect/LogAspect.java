package com.dncrm.common.aspect;

import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.Signature;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.alibaba.fastjson.JSON;
import com.dncrm.service.system.sysLog.SysLogService;

@Aspect
@Component
public class LogAspect {
	
	@Autowired
	private SysLogService sysLogService;
	
	// 配置接入点，即为所要记录的action操作目录
    @Pointcut("execution(* com.dncrm.controller..*.*(..))")
    private void aspectMethod() {
    }
	
    @Around("aspectMethod() && @annotation(com.dncrm.common.aspect.Log)")
    public Object around(ProceedingJoinPoint pjp) throws Throwable{
    	
    	HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes())
                .getRequest();
    	
    	// 拦截的实体类，就是当前正在执行的controller
        Object target = pjp.getTarget();
        // 拦截的方法名称。当前正在执行的方法
        String methodName = pjp.getSignature().getName();
        // 拦截的方法参数
        Object[] args = pjp.getArgs();
        
        // 拦截的放参数类型
        Signature sig = pjp.getSignature();
        MethodSignature msig = null;
        if (!(sig instanceof MethodSignature)) {
            throw new IllegalArgumentException("该注解只能用于方法");
        }
        msig = (MethodSignature) sig;
        Class[] parameterTypes = msig.getMethod().getParameterTypes();

        Object object = null;
        // 获得被拦截的方法
        Method method = null;
    	
        try {
            method = target.getClass().getMethod(methodName, parameterTypes);
        } catch (NoSuchMethodException e1) {
            e1.printStackTrace();
        } catch (SecurityException e1) {
            e1.printStackTrace();
        }
    	// 获取方法（此为自定义注解） 
    	Log op = method.getAnnotation(Log.class);
        
        if (null != method && op != null) {
        	String module = op.module();
        	String title = op.title();
        	String idTitle = op.ext_idTitle();
        	String[] idParam = op.ext_idParam();
        	String contentTitle = op.ext_contentTitle();
        	String[] contentParam = op.ext_contentParam();

        	//接受客户端的数据
            Map<String,String[]> map = request.getParameterMap();
            // 解决获取参数乱码
            /*Map<String,String[]> newmap = new HashMap<String,String[]>();   
            for(Map.Entry<String, String[]> entry : map.entrySet()){
	            String name = entry.getKey();
	            String values[] = entry.getValue();
	            if(values==null){
	                newmap.put(name, new String[]{});
	                continue;
	            }
	            String newvalues[] = new String[values.length];
	            for(int i=0; i<values.length;i++){
	            	String value = values[i];
	            	value = new String(value.getBytes("iso8859-1"),request.getCharacterEncoding());
	            	newvalues[i] = value; //解决乱码后封装到Map中
	            }
	            newmap.put(name, newvalues);
            }*/
            
            String loggingId = idTitle;
            String logging = contentTitle;
            String params = "";
            
            if(idParam != null && idParam.length > 0) {
            	for (int i = 0; i < idParam.length; i++) {
					String im = idParam[i];
		            String[] s = map.get(im);
		            loggingId = loggingId.replaceAll("[?]"+(i+1), s != null?StringUtils.join(s, ","):"");
					
				}
            }
            
            if(contentParam != null && contentParam.length > 0) {
            	for (int i = 0; i < contentParam.length; i++) {
					String im = contentParam[i];
		            String[] s = map.get(im);
		            logging = logging.replaceAll("[?]"+(i+1), s != null?StringUtils.join(s, ","):"");
					
				}
            }
            
            params = JSON.toJSONString(map);
            
            
            try {

            	object = pjp.proceed();
			} catch (Exception e) {
				
			}
            
        	try {
				sysLogService.logAdd(module, title, loggingId, logging, params, request);
			} catch (Exception e) {
				e.printStackTrace();
			}
        } else {
        	object = pjp.proceed();
        }
        
    	
		return object;
    }
    
	
}
