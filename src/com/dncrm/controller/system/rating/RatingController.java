package com.dncrm.controller.system.rating;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


import com.dncrm.controller.base.BaseController;
import com.dncrm.entity.Page;
import com.dncrm.service.system.rating.RatingService;
import com.dncrm.util.AppUtil;
import com.dncrm.util.PageData;


import net.sf.json.JSONObject;

@Controller
@RequestMapping(value = "/rating")
public class RatingController extends BaseController{

	@Resource(name ="ratingService")
	private RatingService ratingService;
	
	@RequestMapping(value = "/ratingList")
	public ModelAndView ratingList(Page page){
		ModelAndView mv = new ModelAndView();
		try {
			PageData pd = this.getPageData();
			page.setPd(pd);
			List<PageData> ratingList = ratingService.listPdPageRating(page);
			mv.addObject("ratingList", ratingList);
	        mv.addObject("page", page);
	        mv.addObject("rating", pd.get("rating"));
	        mv.setViewName("system/rating/rating");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			logger.error(e.toString(), e);
		}
		
       
        
		return mv;
	}
	
	/**
     * 请求跳转信用等级新增页面
     */
    @RequestMapping(value = "/toRatingAdd")
    public ModelAndView toContractorAdd(){
    	ModelAndView mv = this.getModelAndView();
    	
    	try {
           
			mv.addObject("msg", "add");
			mv.addObject("HasSameKey", "false");
			mv.setViewName("system/rating/rating_edit");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	return mv;
    }
    
    /**
     * 信用等级是否存在重复
     * @param request
     * @return
     */
    @RequestMapping(value = "/existsRating")
    @ResponseBody
    public Object existsRating(){
    	
    	PageData pd = this.getPageData();
    	
    	JSONObject result = new JSONObject();
    	try {
			List<PageData> list = ratingService.existsRating(pd);
			if(list.isEmpty()){
				result.put("success", true);
			}else{
				result.put("errorMsg", "信用等级已重复,请从新输入");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	return result;
    }
    
    /**
     * 保存信用等级
     * @throws Exception 
     */
    @RequestMapping(value = "/add")
    public ModelAndView add(HttpServletRequest request) throws Exception{
    	ModelAndView mv = this.getModelAndView();
    	PageData pd = this.getPageData();
    	try{
	    	pd.put("id", UUID.randomUUID().toString());
	    	//信用等级是否存在重复
	    	List<PageData> list = ratingService.existsRating(pd);
	    	if (list.isEmpty()) {
	    		ratingService.ratingAdd(pd);
	    		mv.addObject("msg", "success");
	    		
	    	}
    	}catch(Exception e){
    		mv.addObject("msg", "failed");
            mv.addObject("err", "保存失败！");
    	}
    	
    	
        mv.addObject("id", "AddRating");
		mv.addObject("form", "ratingForm");
        mv.setViewName("save_result");
    	return mv;
    }
    
    /**
     * 请求跳转信用等级编辑页面
     * @param agent_no
     * @return
     */
    @RequestMapping(value = "/toEdit")
    public ModelAndView toEidt(String id){
    	ModelAndView mv = this.getModelAndView();
    	PageData pd = this.getPageData();
    	try {
			List<PageData> list = ratingService.findRatingById(id);
			
           
			mv.addObject("HasSameKey", "false");
	        mv.addObject("msg", "edit");
	        mv.addObject("pd", list.get(0));
	        mv.setViewName("system/rating/rating_edit");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	return mv;
    }
    
    /**
     * 编辑信用等级
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/edit")
    public ModelAndView edit() throws Exception{
    	ModelAndView mv = this.getModelAndView();
    	PageData pd = this.getPageData();
    	
    	//信用等级是否存在重复
    	List<PageData> list = ratingService.existsRating(pd);
    	if(list.isEmpty()){
    		ratingService.ratingUpdate(pd);
    		mv.addObject("id", "EditRating");
    		mv.addObject("form", "ratingForm");
    		mv.addObject("msg", "success");
    	}else{
    		mv.addObject("HasSameKey", "true");
            mv.addObject("msg", "edit");
            mv.addObject("pd", pd);
            mv.setViewName("system/agent/agent_edit");
            return mv;
    	}
    	mv.setViewName("save_result");
     	return mv;
    }
    
    /**
     * 删除信用等级
     * @param id
     * @param out
     * @return
     */
    @RequestMapping(value = "/del")
    public void delete(String id,PrintWriter out){
    	try {
			List<PageData> list = ratingService.findRatingById(id);
			PageData pd = list.get(0);
			
			ratingService.ratingDeleteById(id);
			out.write("success");
			out.flush();
			out.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
    
    /**
     * 批量删除代理商
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
	    		//批量删除流程
	    		String[] ArrayDATA_IDS = DATA_IDS.split(",");
	    		
	    		ratingService.ratingDeleteAll(ArrayDATA_IDS);
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
}
