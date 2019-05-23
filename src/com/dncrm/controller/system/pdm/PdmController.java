package com.dncrm.controller.system.pdm;

import com.dncrm.controller.base.BaseController;
import com.dncrm.entity.Page;
import com.dncrm.entity.system.User;
import com.dncrm.service.system.pdm.PdmService;
import com.dncrm.util.Const;
import com.dncrm.util.FileUpload;
import com.dncrm.util.ObjectExcelRead;
import com.dncrm.util.PageData;
import com.dncrm.util.PathUtil;

import net.sf.json.JSONObject;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;

import java.text.SimpleDateFormat;
import java.util.*;

@RequestMapping("/pdm")
@Controller
public class PdmController extends BaseController {
	
	@Resource(name="pdmService")
	private PdmService pdmService;
	
	/**
	 *跳转页面 
	 */
	@RequestMapping(value="pdmView")
	public ModelAndView pdmView(Page page){
		ModelAndView mv = new ModelAndView();
		try{
			List<PageData> logList = pdmService.listPagefindPdmLog(page);
			mv.addObject("logList", logList);
			mv.addObject("page", page);
			mv.setViewName("system/pdm/pdm_view");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	
	/**
	 *跳转到GCXM())
	 */
	@RequestMapping(value="toGCXM")
	public ModelAndView toGCXM(Page page){
		ModelAndView mv = new ModelAndView();
		try{
			List<PageData> GCXM = pdmService.listPageGCXMLog(page);
			mv.addObject("active", "1");
			mv.addObject("GCXM", GCXM);
			mv.setViewName("system/pdm/pdm_view");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	} 
	
	/**
	 *跳转到XMPZ
	 */
	@RequestMapping(value="toXMPZ")
	public ModelAndView toXMPZ(Page page){
		ModelAndView mv = new ModelAndView();
		try{
			List<PageData> XMPZ = pdmService.listPageXMPZLog(page);
			mv.addObject("active", "2");
			mv.addObject("XMPZ", XMPZ);
			mv.setViewName("system/pdm/pdm_view");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *跳转到XMPZCS 
	 */
	@RequestMapping(value="toXMPZCS")
	public ModelAndView toXMPZCS(Page page){
		ModelAndView mv = new ModelAndView();
		try{
			List<PageData> XMPZCS = pdmService.listPageXMPZCSLog(page);
			mv.addObject("active","3");
			mv.addObject("XMPZCS", XMPZCS);
			mv.setViewName("system/pdm/pdm_view");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *跳转到DZGX 
	 */
	@RequestMapping(value="toDZGX")
	public ModelAndView toDZGX(Page page){
		ModelAndView mv = new ModelAndView();
		try{
			List<PageData> DZGX = pdmService.listPageDZGXLog(page);
			mv.addObject("active", "4");
			mv.addObject("DZGX", DZGX);
			mv.setViewName("system/pdm/pdm_view");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *上传本地数据 
	 */
	@RequestMapping(value="uploadGCXM")
	@ResponseBody
	public Object uploadData(){
		Map<String, Object> map = new HashMap<String, Object>();
		try{
			//获取本地数据
			List<PageData> pdList = pdmService.findGCXMForPdm();
			//保存上传的信息到tb_pdm_log
			PageData logPd = new PageData();
			String userId = getUser().getUSER_ID();
			for(PageData pd : pdList){
				//放入CRM上传时间和上传人员
				String nowTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
				if(pd.containsKey("D_GCXM_XMKGRQ")&&"".equals(pd.get("D_GCXM_XMKGRQ").toString())){
					pd.remove("D_GCXM_XMKGRQ");
				}
				if(pd.containsKey("D_GCXM_YJSXRQ")&&"".equals(pd.get("D_GCXM_YJSXRQ").toString())){
					pd.remove("D_GCXM_YJSXRQ");
				}
				if(pd.containsKey("D_GCXM_TYRQ")&&"".equals(pd.get("D_GCXM_TYRQ").toString())){
					pd.remove("D_GCXM_TYRQ");
				}
				pd.put("D_GCXM_U_MODIFYDATE", nowTime);
				pd.put("D_GCXM_U_MODIFYUSER", userId);
				//放入PDM
				pdmService.saveDGCXM(pd);
				//添加log
				logPd.put("no", pd.get("D_GCXM_XMID").toString());
				logPd.put("input_date", nowTime);
				logPd.put("input_user", userId);
				logPd.put("status", "0");
				pdmService.saveGCXMLog(logPd);
			}
			map.put("msg", "success");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return JSONObject.fromObject(map);
	}
	
	
	/**
	 *项目配置表上传数据 
	 */
	@RequestMapping(value="uploadXMPZ")
	@ResponseBody
	public Object uploadXMPZ(){
		PageData pd = new PageData();
		Map<String, Object> map = new HashMap<String, Object>();
		try{
			List<PageData> listPd = pdmService.findDataXMPZ();
			PageData logPd = new PageData();
			if(listPd!=null&&listPd.size()>0){
				String userId = getUser().getUSER_ID();
				for(PageData dataPd : listPd){
					String nowTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
					pd.put("D_XMPZ_ZLH", dataPd.get("no").toString());
					pd.put("D_XMPZ_XMID", dataPd.get("item_no").toString());
					pd.put("D_XMPZ_KHID", dataPd.get("customer_no").toString());
					pd.put("D_XMPZ_U_MODIFYDATE", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
					pd.put("D_XMPZ_U_MODIFYUSER", getUser().getUSER_ID());
					pdmService.saveDXMPZ(pd);
					pd.clear();
					//添加log
					logPd.put("no", dataPd.get("no").toString());
					logPd.put("input_date", nowTime);
					logPd.put("input_user", userId);
					logPd.put("status", "0");
					pdmService.saveXMPZLog(logPd);
				}
			}
			map.put("msg", "success");
		}catch(Exception e){
			map.put("msg", "error");
			logger.error(e.getMessage(), e);
		}
		return JSONObject.fromObject(map);
	}
	
	/**
	 *项目配置参数表上传数据 
	 */
	@RequestMapping(value="uploadXMPZCS")
	@ResponseBody
	public Object uploadXMPZCS(){
		PageData pd = new PageData();
		Map<String, Object> map = new HashMap<String, Object>();
		try{
			PageData logPd = new PageData();
			List<PageData> listPd = pdmService.findDataXMPZCS();
			if(listPd!=null&&listPd.size()>0){
				String userId = getUser().getUSER_ID();
				for(PageData dataPd : listPd){
					String nowTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
					pd.put("D_XMPZCS", dataPd.get("no").toString());
					pdmService.saveDXMPZCS(pd);
					pd.clear();
					//添加log
					logPd.put("no", dataPd.get("no").toString());
					logPd.put("input_date", nowTime);
					logPd.put("input_user", userId);
					logPd.put("status", "0");
					pdmService.saveXMPZCSLog(logPd);
				}
			}
			map.put("msg", "success");
		}catch(Exception e){
			map.put("msg", "error");
			logger.error(e.getMessage(), e);
		}
		return JSONObject.fromObject(map);
	}
	
	/**
	 * 基础关系对照表上传数据
	 */
	@RequestMapping(value="uploadDZGX")
	@ResponseBody
	public Object uploadDZGX(){
		PageData pd = new PageData();
		Map<String, Object> map = new HashMap<String, Object>();
		try{
			List<PageData> listPd = pdmService.findDataDZGX();
			PageData logPd = new PageData();
			if(listPd!=null&&listPd.size()>0){
				String userId = getUser().getUSER_ID();
				for(PageData dataPd : listPd){
					String nowTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
					pd.put("D_DZGX_U_BMID", dataPd.get("no").toString());
					pd.put("D_DZGX_U_BMMC", dataPd.get("name").toString());
					pd.put("D_DZGX_LX", dataPd.get("type").toString());
					pd.put("D_DZGX_U_WHR", getUser().getUSER_ID());
					pd.put("D_DZGX_U_WHRJ", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
					pdmService.saveDDZGX(pd);
					pd.clear();
					//添加log
					logPd.put("no", dataPd.get("no").toString());
					logPd.put("input_date", nowTime);
					logPd.put("input_user", userId);
					logPd.put("status", "0");
					pdmService.saveDZGXLog(logPd);
				}
			}
			map.put("msg", "success");
		}catch(Exception e){
			map.put("msg", "error");
			logger.error(e.getMessage(), e);
		}
		return JSONObject.fromObject(map);
	}
	
	

    /**
     * 获取权限
     *
     * @return
     */
    /* ===============================权限================================== */
    public Map<String, String> getHC() {
        Subject currentUser = SecurityUtils.getSubject(); // shiro管理的session
        Session session = currentUser.getSession();
        return (Map<String, String>) session.getAttribute(Const.SESSION_QX);
    }
    /* ===============================权限================================== */ 
    /* ===============================用户================================== */
    public User getUser() {
        Subject currentUser = SecurityUtils.getSubject(); // shiro管理的session
        Session session = currentUser.getSession();
        return (User) session.getAttribute(Const.SESSION_USER);
    }	
    /* ===============================用户================================== */

}
