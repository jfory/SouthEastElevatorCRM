package com.dncrm.controller.system.collect;

import com.dncrm.controller.base.BaseController;
import com.dncrm.entity.Page;
import com.dncrm.entity.system.User;
import com.dncrm.service.system.collect.CollectService;
import com.dncrm.service.system.item.ItemService;
import com.dncrm.util.Const;
import com.dncrm.util.PageData;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.*;

import javax.annotation.Resource;

@RequestMapping("/collect")
@Controller
public class CollectController extends BaseController {
	
	@Resource(name="collectService")
	CollectService collectService;
	@Resource(name="itemService")
	ItemService itemService;
	
	/**
	 *收款记录列表
	 */
	@RequestMapping(value="collectList")
	public ModelAndView collectList(Page page){
		ModelAndView mv = new ModelAndView();
		try{
			/*List<PageData> collectList = collectService.collectList(page);*/
			PageData pd = new PageData();
			List<String> userList = getRoleSelect();
			String roleType = getRoleType();
			pd.put("userList", userList);
			pd.put("roleType", roleType);
			page.setPd(pd);
			List<PageData> collectList = collectService.collectListByRole(page);
			mv.addObject("collectList", collectList);
			mv.setViewName("system/collect/collect_list");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
		
	}
	
	
	/**
	 *跳转到新增 
	 */
	@RequestMapping(value="goAddCollect")
	public ModelAndView goAddCollect(){
		ModelAndView mv = new ModelAndView();
		PageData pd;
		try{
			pd = this.getPageData();
			List<PageData> itemList = new ArrayList<PageData>();
			String contract_type = pd.get("contract_type").toString();
			if("1".equals(contract_type)){//安装合同
				itemList = collectService.findItemListByContractType("1");
			}else if("2".equals(contract_type)){//销售合同
				itemList = collectService.findItemListByContractType("2");
			}else if("3".equals(contract_type)){//安装销售合同
				itemList = collectService.findItemListByContractType("3");
			}
			mv.addObject("itemList", itemList);
			mv.addObject("msg", "saveCollect");
			mv.addObject("contract_type", contract_type);
			mv.setViewName("system/collect/collect_edit");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *录入电梯 
	 */
	@RequestMapping(value="setElevator")
	public ModelAndView setElevator(){
		ModelAndView mv = new ModelAndView();
		List<PageData> elevatorList = new ArrayList<PageData>();
		PageData pd;
		try{
			pd = this.getPageData();
			String item_id = pd.get("item_id").toString();
			String operateType = pd.get("operateType").toString();
			String stage = pd.get("stage").toString();
			if("sel".equals(operateType)){
				elevatorList = collectService.findElevatorStage(pd);
			}else{
				elevatorList = collectService.findElevatorByItemId(item_id);
			}
			
			mv.addObject("stage", stage);
			mv.addObject("elevatorList", elevatorList);
			mv.setViewName("system/collect/elevator");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *保存电梯 
	 */
	@RequestMapping(value="saveElevator")
	public ModelAndView saveElevator(){
		ModelAndView mv = new ModelAndView();
		//List<PageData> resultList = new ArrayList<PageData>();
		PageData pd;
		try{
			pd = this.getPageData();
			String data = pd.get("data").toString();
			String stage = pd.get("stage").toString();
			Integer total = 0;
			JSONArray jsonArray = JSONArray.fromObject(data);
			/*PageData dataPd = new PageData();*/
			/*dataPd.put("stage", stage);*/
			for(int i=0;i<jsonArray.size();i++){
				JSONObject jsonObj = jsonArray.getJSONObject(i);
				/*dataPd.put("details_id", jsonObj.get("details_id").toString());
				dataPd.put("total", jsonObj.get("total").toString());
				dataPd.put("id", this.get32UUID());*/
				total += jsonObj.getInt("total");
				//resultList.add(dataPd);
				/*collectService.saveStage(dataPd);*/
			}
			
			//mv.addObject("resultList", resultList);

			mv.addObject("page", "set");
			mv.addObject("msg", "success");
			mv.addObject("data", data);
			mv.addObject("stage", stage);
			mv.addObject("total", total);
			mv.addObject("id", "Elevator");
			mv.setViewName("system/collect/save_result");
		}catch(Exception e){
			mv.addObject("msg", "error");
			logger.error(e.getMessage(), e);
		}
		return mv;
		
	}
	
	
	/**
	 *保存新增 
	 */
	@RequestMapping(value="saveCollect")
	public ModelAndView saveCollect(){
		ModelAndView mv = new ModelAndView();
		PageData pd;
		try{

			pd = this.getPageData();
			
			//保存对应的电梯
			PageData dataPd = new PageData();
			List<String> list = new ArrayList<String>();
			list.add("product_data");
			list.add("shipment_data");
			list.add("install_data");
			list.add("adjust_data");
			list.add("accept_data");
			list.add("remit_data");
			list.add("quality_data");
			for(String str : list){
				JSONArray jsonArray = JSONArray.fromObject(pd.get(str).toString());
				for(int i=0;i<jsonArray.size();i++){
					JSONObject jsonObj = jsonArray.getJSONObject(i);
					dataPd.put("details_id", jsonObj.get("details_id").toString());
					dataPd.put("total", jsonObj.get("total").toString());
					dataPd.put("id", this.get32UUID());
					dataPd.put("stage", str.substring(0, str.lastIndexOf("_")));
					collectService.saveStage(dataPd);
				}
			}
			
			//保存项目款设置
			pd.put("id", this.get32UUID());
			collectService.saveCollectSet(pd);
			
			//保存项目应收款
			PageData collectPd = new PageData();
			String item_id = pd.get("item_id").toString();
			String collect_total = pd.get("total").toString();
			//根据销售类型判断是否是代理商项目
			String sale_type = itemService.findSaleTypeById(item_id);
			if("1".equals(sale_type)){
				//经销
				collectPd.put("item_type", "0");//非代理商项目
			}else if("2".equals(sale_type)||"3".equals(sale_type)){
				//直销/代销
				collectPd.put("item_type", "1");//设置代理商项目
			}
			collectPd.put("id", this.get32UUID());
			collectPd.put("item_id", item_id);
			collectPd.put("collect_total", collect_total);
			collectPd.put("USER_ID", getUser().getUSER_ID());
			collectPd.put("status", "0");
			collectService.saveCollect(collectPd);
			mv.addObject("msg", "success");
			mv.addObject("form", "CollectForm");
			mv.addObject("id", "EditCollect");
			mv.setViewName("save_result");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *跳转修改/查看 
	 */
	@RequestMapping(value="goEditCollect")
	public ModelAndView goEditCollect(){
		ModelAndView mv = new ModelAndView();
		PageData pd;
		try{
			pd = this.getPageData();
			String id = pd.get("id").toString();
			collectService.findCollectById(id);
			mv.addObject("pd", pd);
			mv.addObject("msg", "editCollect");
			mv.setViewName("system/collect/collect_edit");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *保存修改 
	 */
	@RequestMapping(value="editCollect")
	public ModelAndView editCollect(){
		ModelAndView mv = new ModelAndView();
		PageData pd;
		try{
			pd = this.getPageData();
			
			//保存对应的电梯
			PageData dataPd = new PageData();
			List<String> list = new ArrayList<String>();
			list.add("product_data");
			list.add("shipment_data");
			list.add("install_data");
			list.add("adjust_data");
			list.add("accept_data");
			list.add("remit_data");
			list.add("quality_data");
			for(String str : list){
				JSONArray jsonArray = JSONArray.fromObject(pd.get(str).toString());
				for(int i=0;i<jsonArray.size();i++){
					JSONObject jsonObj = jsonArray.getJSONObject(i);
					dataPd.put("details_id", jsonObj.get("details_id").toString());
					dataPd.put("total", jsonObj.get("total").toString());
					dataPd.put("id", this.get32UUID());
					dataPd.put("stage", str.substring(0, str.lastIndexOf("_")));
					collectService.deleteCollectStage(dataPd);
					collectService.saveStage(dataPd);
				}
			}
			
			//保存项目款设置
			/*pd.put("id", this.get32UUID());
			collectService.saveCollectSet(pd);*/
			collectService.editCollectSet(pd);
			
			mv.addObject("msg", "success");
			mv.addObject("form", "CollectForm");
			mv.addObject("id", "EditCollect");
			mv.setViewName("save_result");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *获取项目列表 
	 */
	@RequestMapping(value="findItemOption")
	@ResponseBody
	public Object findItemOption(){
		Map<String, Object> map = new HashMap<String, Object>();
		try{
			List<PageData> itemList = itemService.findItemList();
			map.put("itemList", itemList);
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return JSONObject.fromObject(map);
	}
	
	/**
	 * 删除
	 */
	@RequestMapping(value="delCollect")
	public Object delCollect(){
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd;
		try{
			pd = this.getPageData();
			String id = pd.get("id").toString();
			collectService.delCollectById(id);
			map.put("msg", "success");
		}catch(Exception e){
			map.put("msg", "faild");
			logger.error(e.getMessage(), e);
		}
		return JSONObject.fromObject(map);
	}
	
	/**
	 *跳转到收款页面 
	 */
	@RequestMapping(value="goCollect")
	public ModelAndView goCollect(){
		ModelAndView mv = new ModelAndView();
		PageData pd;
		try{
			pd = this.getPageData();
			String c_id = pd.get("id").toString();
			List<PageData> collectMoneyList = collectService.findCollectMoneyByCid(c_id);
			String total = collectService.findTotalById(c_id);
			String payTotal = collectService.findPayTotal(c_id);
			String itemType = collectService.findItemTypeById(c_id);
			mv.addObject("c_id", c_id);//付款id
			mv.addObject("total", total);//应收款总额
			mv.addObject("payTotal", payTotal);//已收款总额
			mv.addObject("itemType", itemType);//是否是代理商项目
			mv.addObject("collectMoneyList", collectMoneyList);//收款记录/历史 集合
			mv.setViewName("system/collect/collect_money");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *保存收款 
	 */
	@RequestMapping(value="saveCollectMoney")
	public ModelAndView saveCollectMoney(){
		ModelAndView mv = new ModelAndView();
		PageData pd;
		try{
			
			pd = this.getPageData();
			String cmId = this.get32UUID();
			pd.put("id", cmId);
			pd.put("USER_ID", getUser().getUSER_ID());
			
			
			//判断项目类型是否是代理商
			String c_id = pd.get("c_id").toString();
			String itemType= collectService.findItemTypeById(c_id);
			//保存此次额度使用记录主键,关联到付款记录表
			String hisAgentId = this.get32UUID();
			if("1".equals(itemType)){
				//如果是代理商项目
				
				//如果是额度支付
				String payment = pd.get("payment").toString();
				if("1".equals(payment)){
					//此次付款使用额度
					String total = pd.get("total").toString();
					
					//获取代理商id
					String agent_id = collectService.findAgentIdById(c_id);
					//查询总额度
					String agentTotal = collectService.findAgentQuota(agent_id);
					//查询已使用额度
					String usedTotal = collectService.findUsedTotalByAgentId(agent_id);
					
					
					PageData hisAgentPd = new PageData(); 
					//是否超出额度
					if(Integer.parseInt(agentTotal)<(Integer.parseInt(usedTotal)+Integer.parseInt(total))){
						//如果超出额度
						hisAgentPd.put("id", hisAgentId);
						hisAgentPd.put("agent_id", agent_id);
						hisAgentPd.put("cm_id", cmId);
						hisAgentPd.put("total", total);
						hisAgentPd.put("type", "2");//2:虚拟额度类型
						hisAgentPd.put("status", "0");//0:未到款
					}else{
						//如果未超出额度
						hisAgentPd.put("id", hisAgentId);
						hisAgentPd.put("agent_id", agent_id);
						hisAgentPd.put("cm_id", cmId);
						hisAgentPd.put("total", total);
						hisAgentPd.put("type", "1");//1:普通额度类型
						hisAgentPd.put("status", "0");//0:未到款
					}
					
					//保存额度使用记录
					collectService.saveHisAgent(hisAgentPd);
				}
			}
			
			//保存此次付款记录
			collectService.saveCollectSet(pd);

			mv.addObject("msg", "success");
			mv.addObject("form", "CollectForm");
			mv.addObject("id", "Collect");
			mv.setViewName("save_result");
		}catch(Exception e){
			mv.addObject("msg", "err");
			logger.error(e.getMessage(), e);
		}
		return mv;
		
	}
	
	@RequestMapping(value="goOffset")
	public ModelAndView goOffset(){
		ModelAndView mv = new ModelAndView();
		PageData pd;
		try{
			pd = this.getPageData();
			String id = pd.get("id").toString();
			List<PageData> offsetList = collectService.findOffset(id);
			mv.addObject("offsetList", offsetList);
			mv.setViewName("system/collect/offset");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	
	@RequestMapping(value="offset")
	@ResponseBody
	public Object offset(){
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd;
		try{
			pd = this.getPageData();
			String id = pd.get("id").toString();
			collectService.editHisAgentStatus(id);
			map.put("msg", "success");
		}catch(Exception e){
			map.put("msg", "error");
			logger.error(e.getMessage(), e);
		}
		return JSONObject.fromObject(map);
	}

	
	/**
	 *跳转阶段付款状态列表 
	 */
	@RequestMapping(value="goCollectSet")
	public ModelAndView goSel(){
		ModelAndView mv = new ModelAndView();
		PageData pd;
		try{
			pd = this.getPageData();
			String item_id = pd.get("item_id").toString();
			PageData dataPd = collectService.findCollectSetByItemId(item_id);
			
			//
			Map<String, String> pds = new HashMap<String, String>();
			pd.put("stage", "product");
			String product_data = collectService.findElevatorStageForEdit(pd).toString();
			pd.put("stage", "shipment");
			String shipment_data = collectService.findElevatorStageForEdit(pd).toString();
			pd.put("stage", "install");
			String install_data = collectService.findElevatorStageForEdit(pd).toString();
			pd.put("stage", "adjust");
			String adjust_data = collectService.findElevatorStageForEdit(pd).toString();
			pd.put("stage", "accept");
			String accept_data = collectService.findElevatorStageForEdit(pd).toString();
			pd.put("stage", "remit");
			String remit_data = collectService.findElevatorStageForEdit(pd).toString();
			pd.put("stage", "quality");
			String quality_data = collectService.findElevatorStageForEdit(pd).toString();
			pds.put("product_data", product_data);
			pds.put("shipment_data", shipment_data);
			pds.put("install_data", install_data);
			pds.put("adjust_data", adjust_data);
			pds.put("accept_data", accept_data);
			pds.put("remit_data", remit_data);
			pds.put("quality_data", quality_data);
			
			mv.addObject("pd", dataPd);
			mv.addObject("pds", pds);
			mv.addObject("msg", "editCollect");
			mv.addObject("operateType", "sel");
			mv.setViewName("system/collect/collect_edit");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *登记款 
	 */
	@RequestMapping(value="setInfo")
	public ModelAndView setInfo(){
		ModelAndView mv = new ModelAndView();
		PageData pd;
		try{
			pd = this.getPageData();
			String stage = pd.get("stage").toString();
			String item_id = pd.get("item_id").toString();
			String flag = pd.get("flag").toString();
			
			List<PageData> infoList = collectService.findCollectInfoByPd(pd);
			mv.addObject("infoList", infoList);
			String viewName = "";
			
			if("1".equals(flag)){
				viewName = "system/collect/collect_info";
			}else if("2".equals(flag)){
				List<PageData> eleList = collectService.findCollectEleByPd(pd);
				mv.addObject("eleList", eleList);
				viewName = "system/collect/collect_ele";
			}
			mv.addObject("pd", pd);
			mv.setViewName(viewName);
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *保存登记款 
	 */
	@RequestMapping(value="saveInfo")
	public ModelAndView saveInfo(){
		ModelAndView mv = new ModelAndView();
		PageData pd;
		try{
			pd = this.getPageData();
			pd.put("id", this.get32UUID());
			pd.put("USER_ID", getUser().getUSER_ID());
			collectService.saveCollectInfo(pd);

			mv.addObject("page", "info");
			mv.addObject("msg", "success");
			mv.addObject("id", "SetInfo");
			mv.setViewName("system/collect/save_result");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	
	//-------------------------  1.16  ------------------------
	@RequestMapping(value="listInfoForQuota")
	public ModelAndView listInfoForQuota(){
		ModelAndView mv = new ModelAndView();
		try{
			List<PageData> pd = collectService.findCollectInfoForQuot();
			mv.addObject("infoList", pd);
			mv.addObject("active", "1");
			mv.setViewName("system/quota/offset_list");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	@RequestMapping(value="claimInfo")
	@ResponseBody
	public Object claimInfo(){
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd;
		try{
			pd = this.getPageData();
			String uuid = pd.get("uuid").toString();
			collectService.editInfoStatus(uuid);
			
			PageData dataPd = new PageData();
			dataPd.put("id", this.get32UUID());
			dataPd.put("info_id", uuid);
			collectService.saveCollectClaim(dataPd);
			
			map.put("msg", "success");
		}catch(Exception e){
			map.put("msg", "err");
			logger.error(e.getMessage(), e);
		}
		return JSONObject.fromObject(map);
	}
	
	@RequestMapping(value="listQuota")
	public ModelAndView listQuota(){
		ModelAndView mv = new ModelAndView();
		try{
			List<PageData> pd = collectService.findCollectClaimList();
			mv.addObject("quotaList", pd);
			mv.addObject("active", "2");
			mv.setViewName("system/quota/offset_list");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	@RequestMapping(value="offsetQuota")
	public ModelAndView offsetQuota(){
		ModelAndView mv = new ModelAndView();
		PageData pd;
		try{
			pd = this.getPageData();
			String info_id = pd.get("info_id").toString();
			List<PageData> pdList = collectService.findOffsetListByInfo(info_id);
			mv.addObject("offsetList", pdList);
			mv.setViewName("system/quota/offset");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	@RequestMapping(value="offsetStage")
	@ResponseBody
	public Object offsetStage(){
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd;
		try{
			pd = this.getPageData();
			
			//保存核销记录
			String info_id = pd.get("info_id").toString();
			PageData dataPd = new PageData();
			dataPd.put("id", this.get32UUID());
			dataPd.put("info_id", info_id);
			dataPd.put("USER_ID", this.getUser().getUSER_ID());
			collectService.saveOffsetStage(dataPd);
			
			//修改额度
			String agent_id = collectService.findAgentByInfoId(info_id);
			PageData agentPd = new PageData();
			agentPd.put("f_id", agent_id);
			agentPd.put("type", "agent");
			Integer quota = Integer.parseInt(collectService.findQuotaSet(agentPd));//当前额度
			
			Integer money = Integer.parseInt(collectService.findMoneyByInfoId(info_id).toString());
			
			quota = quota+money;
			
			agentPd.put("quota", quota);
			
			collectService.updateQuotaSet(agentPd);
			
			//更新分款状态为已核销
			collectService.updateInfoStatus(info_id);
			
			map.put("msg", "success");
		}catch(Exception e){
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
    /* ===============================用户查询权限================================== */
    public List<String> getRoleSelect() {
        Subject currentUser = SecurityUtils.getSubject(); // shiro管理的session
        Session session = currentUser.getSession();
        return (List<String>) session.getAttribute(Const.SESSION_ROLE_SELECT);
    }
    public String getRoleType(){
    	Subject currentUser = SecurityUtils.getSubject();
    	Session session = currentUser.getSession();
    	return (String)session.getAttribute(Const.SESSION_ROLE_TYPE);
    }
/* ===============================用户================================== */
}
