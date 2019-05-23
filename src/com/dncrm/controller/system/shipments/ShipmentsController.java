package com.dncrm.controller.system.shipments;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dncrm.controller.base.BaseController;
import com.dncrm.entity.Page;
import com.dncrm.service.system.consignee.ConsigneeService;
import com.dncrm.service.system.encasement.EncasementService;
import com.dncrm.service.system.shipments.ShipmentsService;
import com.dncrm.util.PageData;

import net.sf.json.JSONObject;

@Controller
@RequestMapping(value = "/shipments")
public class ShipmentsController extends BaseController{

	@Resource(name = "encasementService")
	private EncasementService encasementService;
	
	@Resource(name = "consigneeService")
	private ConsigneeService consigneeService;
	
	@Resource(name = "shipmentsService")
	private ShipmentsService shipmentsService;
	
	/**
	 * 显示出货单列表 (发货状态)
	 * @param page
	 * @return
	 */
	@RequestMapping(value="listConsignee")
	public ModelAndView listConsignee(Page page){
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		pd.put("consignee_state", "3");
		page.setPd(pd);
		try{
			List<PageData> consigneeList = shipmentsService.listPageAllConsignee(page);
			mv.setViewName("system/shipments/consignee_list");
			mv.addObject("consigneeList", consigneeList);
			mv.addObject("pd", pd);
			mv.addObject("page", page);
		}catch(Exception e){
			logger.error(e.getMessage(),e);
		}
		return mv;
	}
	
	/**
	 * 显示电梯详情列表 
	 * @param page
	 * @return
	 */
	@RequestMapping(value="listElevatorDetails")
	public ModelAndView listElevator(){
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		
		List<String> checkedList = new ArrayList<String>();//装取选中的电梯
		try{
			String[] editCheckedElevatorId = consigneeService.findConsigneeObjById(pd).get("elevator_id").toString().split(",");
			for(String str:editCheckedElevatorId){
				checkedList.add(str);
			}
			pd.put("checkedList", checkedList);
			
			List<PageData> elevatorDetailsList = encasementService.listAllElevatorDetails(pd);
			mv.setViewName("system/encasement/elevatorDetails_list");
			mv.addObject("elevatorDetailsList", elevatorDetailsList);
			mv.addObject("pd", pd);
			
		}catch(Exception e){
			logger.error(e.getMessage(),e);
		}
		return mv;
	}
	
	/**
	 * 显示装箱列表 
	 * @param page
	 * @return
	 */
	@RequestMapping(value="listEncasement")
	public ModelAndView listEncasement(Page page){
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		page.setPd(pd);
		try{
			List<PageData> encasementList = encasementService.listPageAllEncasement(page);
			mv.setViewName("system/encasement/encasement_list");
 			mv.addObject("encasementList", encasementList);
			mv.addObject("pd", pd);
			mv.addObject("page", page);
		}catch(Exception e){
			logger.error(e.getMessage(),e);
		}
		return mv;
	}
	
	/**
	 * 跳转到装箱添加页面
	 * @return
	 */
	@RequestMapping(value="goAddCarriage")
	public ModelAndView goAddEncasement(){
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		mv.addObject("pd", pd);
		mv.addObject("msg", "addCarriage");
		mv.setViewName("system/shipments/carriage_edit");
		return mv;
	}
	
	/**
	 * 跳转到出货单编辑页面
	 * @return
	 */
	@RequestMapping(value="goEditCarriage")
	public ModelAndView goEditCarriage(){
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		
		PageData encasement = new PageData();
		try {
			encasement = shipmentsService.findCarriageById(pd);
			mv.addObject("pd",encasement);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		mv.addObject("msg", "editCarriage");
		mv.setViewName("system/shipments/carriage_edit");
		return mv;
	}
	
	/**
	 * 新增出货单
	 * @return
	 */
	@RequestMapping(value="addCarriage")
	public ModelAndView addCarriage(){
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		try {
			encasementService.saveEncasement(pd);
			mv.addObject("msg", "success");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			mv.addObject("msg", "failed");
			mv.addObject("err", "保存失败");
			e.printStackTrace();
		}
		mv.addObject("id", "AddEncasement");
		mv.addObject("form", "encasementForm");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 编辑出货单
	 * @return
	 */
	@RequestMapping(value="editCarriage")
	public ModelAndView editEncasement(){
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		try {
			shipmentsService.editCarriage(pd);
			mv.addObject("id", "EditCarriage");
			mv.addObject("form", "carriageForm");
			mv.addObject("msg", "success");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			mv.addObject("msg", "failed");
			mv.addObject("err", "保存失败");
			e.printStackTrace();
		};
		
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 删除出货单
	 * @param offer_id
	 * @param out
	 */
	@RequestMapping(value = "/EncasementDelete")
	@ResponseBody
	public Object EncasementDelete(){
		Map<String, Object> map = new HashMap<String, Object>();
		JSONObject obj = new JSONObject();
		PageData pd = this.getPageData();
		try{
			
			
			
			encasementService.delEncasement(pd);
			map.put("msg", "success");
			obj = JSONObject.fromObject(map);
		}catch(Exception e){
			map.put("msg", "failed");
			obj = JSONObject.fromObject(map);
			logger.error(e.getMessage(),e);
		}
		return obj;
	}
	
	/**
	 * 批量删除出货单
	 * @return
	 */
	@RequestMapping(value="delAllEncasement")
	@ResponseBody
	public Object delAllEncasement(){
		Map<String, Object> map = new HashMap<String, Object>();
		JSONObject obj = new JSONObject();
        PageData pd = this.getPageData();
        Page page = this.getPage();
        try {
            page.setPd(pd);
            String item_ids = (String) pd.get("item_ids");
            for (String item_id : item_ids.split(",")) {
            	pd.put("encasement_id",  item_id);
            	
    			encasementService.delEncasement(pd);
    			
            }
            map.put("msg", "success");
            obj = JSONObject.fromObject(map);
        } catch (Exception e) {
            map.put("msg", "failed");
            obj = JSONObject.fromObject(map);
        }
        return obj;
	}
	
	/**
	 * 提交到发货管理
	 * @return
	 */
	@RequestMapping(value="subShipping")
	@ResponseBody
	public Object subShipping(){
		Map<String, Object> map = new HashMap<String, Object>();
		try{
			PageData pd = new PageData();
			pd = this.getPageData();
			pd.put("consignee_state", "4");
			encasementService.updateConsigneeState(pd);
			
			//执行发货
			PageData pdData = new PageData();
			pdData.put("shipments_no", "NO");
			pdData.put("item_id", pd.getString("item_id"));
			pdData.put("consignee_id", pd.getString("consignee_id"));
			pdData.put("factory", "1");
			pdData.put("name", "TEST");
			pdData.put("state", "0");
			shipmentsService.saveShipments(pdData);
			
			map.put("msg", "success");
		}catch(Exception e){
			map.put("msg", "faild");
			logger.error(e.getMessage(), e);
		}
		return JSONObject.fromObject(map);
	}
}
