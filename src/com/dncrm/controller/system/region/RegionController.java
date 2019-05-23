package com.dncrm.controller.system.region;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.dncrm.controller.base.BaseController;
import com.dncrm.service.system.region.RegionService;
import com.dncrm.util.Const;
import com.dncrm.util.FileUpload;
import com.dncrm.util.ObjectExcelRead;
import com.dncrm.util.ObjectExcelView;
import com.dncrm.util.PageData;
import com.dncrm.util.PathUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@RequestMapping("/region")
@Controller
public class RegionController extends BaseController {
    @Resource(name = "regionService")
    private RegionService regionService;

    /**
     * 显示地区列表
     *
     * @return
     */
    @RequestMapping("/listRegions")
    public ModelAndView listRegions() {
        ModelAndView mv = this.getModelAndView();
        try {
            mv.setViewName("system/region/region_list");
            mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
            List<PageData> regions = regionService.listAllRegions();
            JSONArray jsonObject =  JSONArray.fromObject(regions);
            mv.addObject("regions", jsonObject);
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }
    
    /**
     * 新增一条数据
     *
     * @param binder
     */
    @RequestMapping("/addRegion")
    @ResponseBody
    public Object addRegion() {
        PageData pd = this.getPageData();
        Map<String, Object> map = new HashMap<String, Object>();
        try {
        	int id = regionService.addRegion(pd);
            if (id!=0) {
            	map.put("msg", "success");
            	map.put("id", id);
			}else{
				map.put("msg", "failed");
				map.put("err", "新增失败");
			}
        } catch (Exception e) {
            map.put("msg", "failed");
            map.put("err", "系统错误");
        }
        return JSONObject.fromObject(map);
    }
    /**
     * 删除一条数据
     *
     * @param binder
     */
    @RequestMapping("/delRegion")
    @ResponseBody
    public Object delRegion() {
        PageData pd = this.getPageData();
        Map<String, Object> map = new HashMap<String, Object>();
        try {
        	int id = regionService.delRegion(pd);
            if (id!=0) {
            	map.put("msg", "success");
			}else{
				map.put("msg", "failed");
				map.put("err", "删除失败");
			}
        } catch (Exception e) {
            map.put("msg", "failed");
            map.put("err", "系统错误");
        }
        return JSONObject.fromObject(map);
    }
    /**
     * 修改一条数据
     *
     * @param binder
     */
    @RequestMapping("/editRegion")
    @ResponseBody
    public Object editRegion() {
        PageData pd = this.getPageData();
        Map<String, Object> map = new HashMap<String, Object>();
        try {
        	int id = regionService.editRegion(pd);
            if (id!=0) {
            	map.put("msg", "success");
			}else{
				map.put("msg", "failed");
				map.put("err", "修改失败");
			}
        } catch (Exception e) {
            map.put("msg", "failed");
            map.put("err", "系统错误");
        }
        return JSONObject.fromObject(map);
    }
    
    /**
     *导出tb_region 
     */
    @RequestMapping(value="toExcelRegion")
    public ModelAndView toExcelRegion(){
    	ModelAndView mv = new ModelAndView();
		try{
    		Map<String, Object> dataMap = new HashMap<String, Object>();
			List<String> titles = new ArrayList<String>();
			titles.add("地区id");
			titles.add("地区名");
			titles.add("父级id");
			dataMap.put("titles", titles);
			
			List<PageData> regionList = regionService.findRegionList();
			List<PageData> varList = new ArrayList<PageData>();
			for(int i = 0; i < regionList.size(); i++){
				PageData vpd = new PageData();
				vpd.put("var1", regionList.get(i).containsKey("id")?regionList.get(i).get("id").toString():"");
				vpd.put("var2", regionList.get(i).containsKey("name")?regionList.get(i).get("name").toString():"");
				vpd.put("var3", regionList.get(i).containsKey("pId")?regionList.get(i).get("pId").toString():"");
				varList.add(vpd);
			}
			dataMap.put("varList", varList);
			ObjectExcelView erv = new ObjectExcelView();
			mv = new ModelAndView(erv, dataMap);
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
    	}
    	return mv;
    }
    
    /**
     *导入tb_region 
     */
    @RequestMapping(value="importExcelRegion")
    @ResponseBody
    public Object importExcelRegion(@RequestParam(value="file") MultipartFile file){
    	Map<String, Object> map = new HashMap<String, Object>();
    	try{
    		if(file!=null && !file.isEmpty()){
    			String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE;//文件上传路径
    			String fileName = FileUpload.fileUp(file, filePath, "userexcel");//执行上传
    			
    			List<PageData> listPd = (List)ObjectExcelRead.readExcel(filePath, fileName, 1, 0, 0);
    			PageData pd = new PageData();
    			for(int i= 0;i<listPd.size();i++){
    	        	pd.put("name", listPd.get(i).get("var1").toString());
    	        	pd.put("pId", listPd.get(i).get("var2").toString());
    	        	//保存至数据库
    	        	regionService.saveRegion(pd);
    			}
    			map.put("msg", "success");
    		}else{
    			map.put("errorMsg", "上传失败");
    		}
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
    	}
    	return JSONObject.fromObject(map);
    }
    
    /* ===============================权限================================== */
    public Map<String, String> getHC() {
        Subject currentUser = SecurityUtils.getSubject(); // shiro管理的session
        Session session = currentUser.getSession();
        return (Map<String, String>) session.getAttribute(Const.SESSION_QX);
    }
    /* ===============================权限================================== */
}
