package com.dncrm.controller.system.consignee;

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
import com.dncrm.util.PageData;

import net.sf.json.JSONObject;

@Controller
@RequestMapping(value = "/consignee")
public class ConsigneeController extends BaseController{

	@Resource(name = "consigneeService")
	private ConsigneeService consigneeService;
	
	/**
	 *显示项目列表 
	 * @throws Exception 
	 */
	@RequestMapping(value="listItem")
	public ModelAndView listItem(Page page) throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		//将当前登录人添加至列表查询条件
		//pd.put("input_user", getUser().getUSER_ID());
        page.setPd(pd);
        try{
			List<PageData> itemList = consigneeService.listPageAllItem(page);
			mv.setViewName("system/consignee/item_list");
			mv.addObject("itemList",itemList);
			mv.addObject("pd",pd);
			mv.addObject("page",page);
			//mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
        }catch(Exception e){
        	logger.error(e.getMessage(),e);
        }
		return mv;
	}
	
	/**
	 * 显示出货单列表 (未发货状态)
	 * @param page
	 * @return
	 */
	@RequestMapping(value="listConsignee")
	public ModelAndView listConsignee(Page page){
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		pd.put("consignee_state", "1");
		page.setPd(pd);
		try{
			List<PageData> consigneeList = consigneeService.listPageAllConsignee(page);
			mv.setViewName("system/consignee/consignee_list");
			mv.addObject("consigneeList", consigneeList);
			mv.addObject("pd", pd);
			mv.addObject("page", page);
		}catch(Exception e){
			logger.error(e.getMessage(),e);
		}
		return mv;
	}
	
	/**
	 * 跳转到出货单添加页面
	 * @return
	 */
	@RequestMapping(value="goAddConsignee")
	public ModelAndView goAddConsignee(){
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		List<String> checkedList = new ArrayList<String>();//装取选中的多选框
		try {
			//选中的多选框
			List<PageData> elevatorDetailsCheckList = consigneeService.findElevatorDetailsListCheckedByItemId(pd);
			for(PageData pds:elevatorDetailsCheckList){
				if(pds.get("elevator_id")!=null){
					String[] elevatorId = pds.getString("elevator_id").split(",");
					for(String elevator_id:elevatorId){
						checkedList.add(elevator_id);
					}
				}
			}
			
			List<PageData> elevatorDetailsList = consigneeService.findElevatorDetailsListByItemId(checkedList);
			mv.addObject("elevatorDetailsList",elevatorDetailsList);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		mv.addObject("pd", pd);
		mv.addObject("msg", "addConsignee");
		mv.setViewName("system/consignee/consignee_edit");
		return mv;
	}
	
	/**
	 * 跳转到出货单编辑页面
	 * @return
	 */
	@RequestMapping(value="goEditConsignee")
	public ModelAndView goEditConsignee(){
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		PageData consignee = new PageData();
		try {
			//编辑版
			List<String> editElevatorIds = new ArrayList<String>();
			String editIds = consigneeService.findEditElevatorIds(pd);
			if(editIds!=null){
				String[] ids = editIds.split(",");
				for(String id : ids){
					editElevatorIds.add(id);
				}
			}
			/*List<PageData> elevatorDetailsList = consigneeService.findElevatorDetailsListByItemIds(checkedList);*/
			PageData pdData = new PageData();
			pdData.put("list", editElevatorIds);
			pdData.put("item_id", pd.getString("item_id"));
			List<PageData> elevatorDetailsList = consigneeService.findElevatorDetailsListForEdit(pdData);
			mv.addObject("elevatorDetailsList",elevatorDetailsList);
			
			consignee = consigneeService.findConsigneeObjById(pd);
			String elevator_id = consignee.getString("elevator_id");
			String[] elevatorIds = elevator_id.split(",");
			mv.addObject("elevatorIds",elevatorIds);
			mv.addObject("pd",consignee);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		mv.addObject("msg", "editConsignee");
		mv.setViewName("system/consignee/consignee_edit");
		return mv;
	}
	
	/**
	 * 新增出货单
	 * @return
	 */
	@RequestMapping(value="addConsignee")
	public ModelAndView addConsignee(){
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		try {
			consigneeService.saveConsignee(pd);
			mv.addObject("msg", "success");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			mv.addObject("msg", "failed");
			mv.addObject("err", "保存失败");
			e.printStackTrace();
		}
		mv.addObject("id", "AddConsignee");
		mv.addObject("form", "consigneeForm");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 编辑出货单
	 * @return
	 */
	@RequestMapping(value="editConsignee")
	public ModelAndView editConsignee(){
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		try {
			consigneeService.editConsignee(pd);
			mv.addObject("id", "EditConsignee");
			mv.addObject("form", "consigneeForm");
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
	@RequestMapping(value = "/ConsigneeDelete")
	@ResponseBody
	public Object ConsigneeDelete(){
		Map<String, Object> map = new HashMap<String, Object>();
		JSONObject obj = new JSONObject();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			
			
			consigneeService.delConsignee(pd);
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
	@RequestMapping(value="delAllConsignee")
	@ResponseBody
	public Object delAllConsignee(){
		Map<String, Object> map = new HashMap<String, Object>();
		JSONObject obj = new JSONObject();
        PageData pd = this.getPageData();
        Page page = this.getPage();
        try {
            page.setPd(pd);
            String item_ids = (String) pd.get("item_ids");
            for (String item_id : item_ids.split(",")) {
            	pd.put("consignee_id",  item_id);
            	
    			consigneeService.delConsignee(pd);
    			
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
	 * 提交到装箱管理
	 * @return
	 */
	@RequestMapping(value="subBoxManage")
	@ResponseBody
	public Object subBoxManage(){
		Map<String, Object> map = new HashMap<String, Object>();
		try{
			PageData pd = new PageData();
			pd = this.getPageData();
			pd.put("consignee_state", "2");
			consigneeService.updateConsigneeState(pd);
			map.put("msg", "success");
		}catch(Exception e){
			map.put("msg", "faild");
			logger.error(e.getMessage(), e);
		}
		return JSONObject.fromObject(map);
	}
}
