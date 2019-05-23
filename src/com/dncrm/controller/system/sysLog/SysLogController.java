package com.dncrm.controller.system.sysLog;

import com.dncrm.controller.base.BaseController;
import com.dncrm.entity.Page;
import com.dncrm.service.system.region.RegionService;
import com.dncrm.service.system.sysLog.SysLogService;
import com.dncrm.service.system.sysUser.sysUserService;
import com.dncrm.util.*;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
@RequestMapping(value = "/sysLog")
public class SysLogController extends BaseController{

	@Resource(name = "sysLogService")
    private SysLogService sysLogService;
	@Resource(name = "regionService")
	private RegionService regionService;
	@Resource(name = "sysUserService")
	private sysUserService sysUserService;
	 /**
     * 显示日志列表
     *
     * @return
     */
    @RequestMapping(value = "/logList")
    public ModelAndView list(Page page) throws Exception {
        ModelAndView mv = this.getModelAndView();
        
        try {
            PageData pd = this.getPageData();
            page.setPd(pd);
            List<PageData> logList = sysLogService.listPdPageLog(page);
            mv.addObject("logList", logList);
            mv.addObject("page", page);
            mv.addObject("log_title", pd.get("log_title"));
            mv.addObject("log_type", pd.get("log_type"));
            mv.addObject("log_create_by", pd.get("log_create_by"));
            mv.addObject("log_create_role", pd.get("log_create_role"));
            mv.setViewName("system/log/log");
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }

        return mv;
    }
    
    /**
     * 请求跳转日志新增页面
     */
    @RequestMapping(value = "/toAdd")
    public ModelAndView toAdd(){
    	ModelAndView mv = this.getModelAndView();
    	try {
			// 加载地区列表
			List<PageData> regions = regionService.listAllRegions();
            JSONArray jsonObject =  JSONArray.fromObject(regions);
            mv.addObject("regions", jsonObject);
			mv.addObject("msg", "add");
			mv.addObject("HasSameKey", "false");
			mv.setViewName("system/log/log_edit");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return mv;
	}

	/**
	 * 请求跳转日志编辑页面
	 * @param log_no
	 * @return
	 */
	@RequestMapping(value = "/toEdit")
	public ModelAndView toEidt(String log_no){
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		try {
			List<PageData> list = sysLogService.findLogById(log_no);
			// 加载地区列表
			List<PageData> regions = regionService.listAllRegions();
            JSONArray jsonObject =  JSONArray.fromObject(regions);
            mv.addObject("regions", jsonObject);
			 mv.addObject("HasSameKey", "false");
	         mv.addObject("msg", "edit");
	         mv.addObject("pd", list.get(0));
	         mv.setViewName("system/log/log_edit");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	return mv;
    }
    
    /**
     * 请求跳转日志查看页面
     * @param log_no
     * @return
     */
    @RequestMapping(value = "/toView")
    public ModelAndView toView(String log_no){
    	ModelAndView mv = this.getModelAndView();
    	PageData pd = this.getPageData();
    	try {
			List<PageData> list = sysLogService.findLogById(log_no);
			 mv.addObject("HasSameKey", "false");
	         mv.addObject("msg", "edit");
	         mv.addObject("pd", list.get(0));
	         mv.setViewName("system/log/log_view");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	return mv;
    }
    
    /**
     * 保存日志
     * @throws Exception 
     */
    @RequestMapping(value = "/add")
    public ModelAndView add() throws Exception{
    	ModelAndView mv = this.getModelAndView();
    	PageData pd = this.getPageData();
    	List list = null;
        if (list.isEmpty()) {
            mv.addObject("id", "AddLog");
            mv.addObject("form", "logForm");
            mv.addObject("msg", "success");
        } else {
            mv.addObject("HasSameKey", "true");
            mv.addObject("msg", "add");
            mv.addObject("pd", pd);
            mv.setViewName("system/log/log_edit");
            return mv;
        }
        mv.setViewName("save_result");
    	return mv;
    }
    
    /**
     * 异步上传
     * @param file
     * @return
     */
    @RequestMapping(value = "/upload")
    @ResponseBody
    public Object upload(@RequestParam(value = "file") MultipartFile file){
    	String ffile=DateUtil.getDay(),fileName="";
    	JSONObject result = new JSONObject();
    	if(file!=null && !file.isEmpty()){
    		String filePath = PathUtil.getClasspath().concat(Const.FILEPATHFILE)+"Log/"+ffile;// 文件上传路径
    		fileName = FileUpload.fileUp(file, filePath, this.get32UUID());// 执行上传
    		result.put("success", true);
    		result.put("filePath", "Log/" + ffile + "/" + fileName);
    	}else{
    		result.put("errorMsg", "上传失败");
    	}
    	return result;
    }
    
    /**
     * 编辑日志
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/edit")
    public ModelAndView edit() throws Exception{
    	ModelAndView mv = this.getModelAndView();
    	PageData pd = this.getPageData();
    	List list = null;
    	if(list.isEmpty()){
    		sysLogService.logUpdate(pd);
    		mv.addObject("id", "EditLog");
    		mv.addObject("form", "logForm");
    		mv.addObject("msg", "success");
    	}else{
    		mv.addObject("HasSameKey", "true");
            mv.addObject("msg", "edit");
            mv.addObject("pd", pd);
            mv.setViewName("system/log/log_edit");
            return mv;
    	}
    	mv.setViewName("save_result");
     	return mv;
    }
    
    /**
     * 删除日志
     * @param log_no
     * @param out
     * @return
     */
    @RequestMapping(value = "/del")
    public void delete(String log_no,PrintWriter out){
    	try {
			sysLogService.logDeleteById(log_no);
			out.write("success");
			out.flush();
			out.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
    
    /**
     * 批量删除日志
     * @return
     */
    @RequestMapping(value = "/delAll")
    @ResponseBody
    public Object deleteAll(){
    	Map<String,Object> map = new HashMap<String,Object>();
    	List<PageData> pdList = new ArrayList<PageData>();
    	PageData pd = new PageData();
    	try {
	    	pd = this.getPageData();
	    	String DATA_IDS = pd.getString("DATA_IDS");
	    	if(!"".equals(DATA_IDS) && DATA_IDS!=null){
	    		String[] ArrayDATA_IDS = DATA_IDS.split(",");
				sysLogService.logDeleteAll(ArrayDATA_IDS);
				pd.put("msg", "ok");
			}else{
				pd.put("msg", "no");
			}
	    	pdList.add(pd);
	    	map.put("list", pdList);
    	}catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	return AppUtil.returnObject(pd, map);
    }
    
    /**
     * 下载文件
     */
    @RequestMapping(value = "/down")
    public void downExcel(HttpServletRequest request,HttpServletResponse response) throws Exception {
    	String downFile = request.getParameter("downFile");
        FileDownload.fileDownload(response, PathUtil.getClasspath()
                + Const.FILEPATHFILE + downFile, downFile);

    }
}
