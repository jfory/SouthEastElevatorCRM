package com.dncrm.controller.system.regelevStandard;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.dncrm.controller.base.BaseController;
import com.dncrm.entity.Page;
import com.dncrm.service.system.models.ModelsService;
import com.dncrm.service.system.regelevStandard.RegelevStandardService;
import com.dncrm.util.PageData;


@Controller
@RequestMapping(value = "/regelevStandard")
public class RegelevStandardController extends BaseController{

	@Resource(name = "regelevStandardService")
	private RegelevStandardService regelevStandardService;
	
	
	
	/**
	 * 电梯标准价格列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "regelevStandardList")
	public ModelAndView elevatorStandardList(Page page) throws Exception{
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		page.setPd(pd);
		List<PageData> regelevStandardList = regelevStandardService.listPageRegelevStandard(page);
		mv.addObject("regelevStandardList", regelevStandardList);
		mv.setViewName("system/regelevStandard/regelevStandard");
		return mv;
	}
	
	/**
	 * 跳转到电梯标准价格添加页面
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "goAddRegelevStandard")
	public ModelAndView goAddElevatorStandard() throws Exception{
		ModelAndView mv = new ModelAndView();
		Page page=new Page();
		try{
			List<PageData> modelsList=regelevStandardService.modelsList(page);
			mv.addObject("modelsList", modelsList);
		}catch (Exception e) {
			logger.error(e.getMessage(), e);
		}
		//跳转新增页面,弹出框选择cod
		mv.setViewName("system/regelevStandard/models_list");
		return mv;
	}
	
	/**
	 *跳转cod标准页面 
	 */
	@RequestMapping(value = "goAddStandard")
	public ModelAndView goAddStandard(){
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		try{
			String modelsName = pd.getString("models_name");
			if(modelsName.equals("DT10")){
				mv.addObject("msg", "addRegelevStandard");
				mv.setViewName("system/regelevStandard/feishang_mrl_std_edit");
			}else if(modelsName.equals("DT3")){
				mv.addObject("msg", "addRegelevStandard");
				mv.setViewName("system/regelevStandard/feishang_std_edit");
			}else if(modelsName.equals("DT4")){
				mv.addObject("msg", "addRegelevStandard");
				mv.setViewName("system/regelevStandard/feiyang3000_std_edit");
			}else if(modelsName.equals("DT5")){
				mv.addObject("msg", "addRegelevStandard");
				mv.setViewName("system/regelevStandard/feiyang3000_mrl_std_edit");
			}else if(modelsName.equals("DT6")){
				mv.addObject("msg", "addRegelevStandard");
				mv.setViewName("system/regelevStandard/feiyang_xf_std_edit");
			}else if(modelsName.equals("DT7")){
				mv.addObject("msg", "addRegelevStandard");
				mv.setViewName("system/regelevStandard/feiyue_std_edit");
			}else if(modelsName.equals("DT8")){
				mv.addObject("msg", "addRegelevStandard");
				mv.setViewName("system/regelevStandard/feiyue_mrl_std_edit");
			}else if(modelsName.equals("DT1")){
				mv.addObject("msg", "addEscalatorStandard");
				mv.setViewName("system/regelevStandard/dnp9300_std_edit");
			}else if(modelsName.equals("DT2")){
				mv.addObject("msg", "addEscalatorStandard");
				mv.setViewName("system/regelevStandard/dnr_std_edit");
			}else if(modelsName.equals("DT9")){
				mv.addObject("msg", "addRegelevStandard");
				mv.setViewName("system/regelevStandard/shiny_std_edit");
			}
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 * 电梯标准价格保存
	 * @return
	 */
	@RequestMapping(value = "addRegelevStandard")
	public ModelAndView addElevatorStandard(){
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		try {
			pd.put("ID", this.get32UUID());
			pd.put("TYPE", "1");
			regelevStandardService.regelevStandardAdd(pd);
			mv.addObject("msg", "success");
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg", "failed");
			mv.addObject("err", "保存失败");
		}
		mv.addObject("id", "AddRegelevStandard");
		mv.addObject("from", "regelevStandardForm");
		mv.setViewName("save_result");
		return mv;
	}
	
	
	/**
	 *电梯标准价格保存-扶梯 
	 */
	@RequestMapping(value = "addEscalatorStandard")
	public ModelAndView addEscalatorStandard(){
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		try {
			pd.put("ID", this.get32UUID());
			pd.put("TYPE", "1");
			regelevStandardService.escalatorStandardAdd(pd);
			mv.addObject("msg", "success");
		} catch (Exception e) {
			e.printStackTrace();
			mv.addObject("msg", "failed");
			mv.addObject("err", "保存失败");
		}
		mv.addObject("id", "AddRegelevStandard");
		mv.addObject("from", "regelevStandardForm");
		mv.setViewName("save_result");
		return mv;
	}
	
}
