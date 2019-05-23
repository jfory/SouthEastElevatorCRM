package com.dncrm.controller.system.outsource;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.dncrm.controller.base.BaseController;
import com.dncrm.entity.Page;
import com.dncrm.service.system.outsource.OutsourceService;
import com.dncrm.util.PageData;

@RequestMapping(value="/outsource")
@Controller
public class OutsourceController extends BaseController {
	
	@Resource(name="outsourceService")
	private OutsourceService outsourceService;
	
	@RequestMapping(value="outsourceList")
	public ModelAndView outsourceList(Page page){
		ModelAndView mv = new ModelAndView();
		try{
			/*List<PageData> osList = outsourceService.listPageOutsource(page);*/
			List<PageData> itemList = outsourceService.listPageItem(page);
			mv.addObject("itemList", itemList);
			mv.setViewName("system/outsource/outsource_list");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	@RequestMapping(value="goAddOutsource")
	public ModelAndView goAddOutsource(){
		ModelAndView mv = new ModelAndView();
		try{
			
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
}