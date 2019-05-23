package com.dncrm.controller.system.e_offer;

import java.io.FileOutputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;

import org.activiti.engine.IdentityService;
import org.activiti.engine.history.HistoricProcessInstance;
import org.activiti.engine.history.HistoricTaskInstance;
import org.activiti.engine.impl.identity.Authentication;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dncrm.common.MailConfig;
import com.dncrm.common.WorkFlow;
import com.dncrm.common.aspect.Log;
import com.dncrm.controller.base.BaseController;
import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.entity.system.User;
import com.dncrm.service.system.basicPrice.BasicPriceService;
import com.dncrm.service.system.city.CityService;
import com.dncrm.service.system.e_offer.E_offerService;
import com.dncrm.service.system.item.ItemService;
import com.dncrm.service.system.models.ModelsService;
import com.dncrm.service.system.regelevStandard.RegelevStandardService;
import com.dncrm.service.system.synUser.synUserService;
import com.dncrm.util.Const;
import com.dncrm.util.DateUtil;
import com.dncrm.util.ObjectExcelView;
import com.dncrm.util.PageData;
import com.dncrm.util.SelectByRole;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Font;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@RequestMapping("/e_offer")
@Controller
public class E_offerController extends BaseController
{
	//引入service层
    @Resource(name="e_offerService")
	private E_offerService e_offerService;
	@Resource(name="cityService")
	private CityService cityService;
	@Resource(name="modelsService")
	private ModelsService modelsService;
	@Resource(name="regelevStandardService")
	private RegelevStandardService regelevStandardService;
	
	@Resource(name="basicPriceService")
	private BasicPriceService basicPriceService;
	@Resource(name="itemService")
	private ItemService itemService;
	
	@Resource(name="synUserService")
	private synUserService synUserservice;
	
    // test
 	@SuppressWarnings("unused")
 	private DaoSupport dao;
 	
    /**
     * 显示全部报价信息
     * Stone 17.07.05
     * @param page
     * @return
     */
	@RequestMapping("/e_offerList")
	public ModelAndView listStores(Page page) {
		ModelAndView mv = this.getModelAndView();
		SelectByRole sbr = new SelectByRole();
		PageData pd = this.getPageData();
		 //shiro管理的session
 		Subject currentUser = SecurityUtils.getSubject();
 		Session session = currentUser.getSession();
 		PageData pds = new PageData();
 		pds = (PageData) session.getAttribute("userpds");
 		String USER_ID = pds.getString("USER_ID");
		try {
			/*List<String> userList = getRoleSelect();
    		String roleType = getRoleType();
    		pd.put("userList", userList);
    		pd.put("roleType", roleType);*/
    		//将当前登录人添加至列表查询条件
    		pd.put("input_user", getUser().getUSER_ID());
    		List<String> userList = sbr.findUserList(getUser().getUSER_ID());
    		pd.put("userList", userList);
    		page.setPd(pd);
//			List<PageData> e_offerList = e_offerService.e_offerlistPage(page);
			List<PageData> e_offerList = e_offerService.e_offerTemplistPage(page);

			if(!e_offerList.isEmpty()){
              	for(PageData con : e_offerList){
              		String instance_id = con.getString("instance_id");
              		if(instance_id!=null && !"".equals(instance_id)){
              			WorkFlow workFlow = new WorkFlow();
              			List<Task> task = workFlow.getTaskService().createTaskQuery().processInstanceId(instance_id).active().list();
              			if(task!=null&& task.size()>0){
              				for(Task task1:task)
              				{
              				con.put("task_id",task1.getId());
              				con.put("task_name",task1.getName());
              				}
              			}
              		}
              	}
              }
			mv.setViewName("system/e_offer/e_offer");
			mv.addObject("e_offerList", e_offerList);
			mv.addObject("pd", pd);
    		mv.addObject("page", page);
            mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}
	//根据项目 id 判断制卡设备加价
	@RequestMapping(value="zksbjj")
	@ResponseBody
	public Object ZKSBJJ(){
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = this.getPageData();
		try{//1
			String COD_ID=pd.getString("codId");
			List<PageData> feiyueList=e_offerService.getFeiyueIC(pd);
			boolean fyisNull = false;
			if(feiyueList.size()>0)
			{
				for(int i=0;i<feiyueList.size();i++)
				{
					String zksb=feiyueList.get(i).getString("OPT_ICKZKSB");
					String codid=feiyueList.get(i).getString("FEIYUE_ID");
					if("0".equals(zksb) || "".equals(zksb))
					{
						fyisNull=true;
					}else if(codid.equals(COD_ID) && "1".equals(zksb)){
						fyisNull=true;
					}
				}
			}else{
				fyisNull=true;
			}
			//2
			List<PageData> feiyueMrlList=e_offerService.getFeiyueMrlIC(pd);
			boolean fymisNull = false;
			if(feiyueMrlList.size()>0)
			{
				for(int i=0;i<feiyueMrlList.size();i++)
				{
					String zksb=feiyueMrlList.get(i).getString("OPT_ICKZKSB");
					String codid=feiyueMrlList.get(i).getString("FEIYUEMRL_ID");
					if("0".equals(zksb) || "".equals(zksb))
					{
						fymisNull=true;
					}else if(codid.equals(COD_ID) && "1".equals(zksb)){
						fymisNull=true;
					}
				}
			}else{
				fymisNull=true;
			}

			//3
			List<PageData> feiyangList=e_offerService.getFeiyangIC(pd);
			boolean fyaisNull = false;
			if(feiyangList.size()>0)
			{
				for(int i=0;i<feiyangList.size();i++)
				{
					String zksb=feiyangList.get(i).getString("OPT_ICKZKSB");
					String codid=feiyangList.get(i).getString("FEIYANG_ID");
					if("0".equals(zksb) || "".equals(zksb))
					{
						fyaisNull=true;
					}else if(COD_ID!=null&&COD_ID.equals(codid) && "1".equals(zksb)){
						fyaisNull=true;
					}
				}
			}else{
				fyaisNull=true;
			}
			//4
			List<PageData> feiyangMrlList=e_offerService.getFeiyangMrlIC(pd);
			boolean fyamisNull = false;
			if(feiyangMrlList.size()>0)
			{
				for(int i=0;i<feiyangMrlList.size();i++)
				{
					String zksb=feiyangMrlList.get(i).getString("OPT_ICKZKSB");
					String codid=feiyangMrlList.get(i).getString("FEIYANGMRL_ID");
					if("0".equals(zksb) || "".equals(zksb))
					{
						fyamisNull=true;
					}else if(codid.equals(COD_ID) && "1".equals(zksb)){
						fyamisNull=true;
					}
				}
			}else{
				fyamisNull=true;
			}
			//5
			List<PageData> feiyangXfList=e_offerService.getFeiyangXfIC(pd);
			boolean fyaxisNull = false;
			if(feiyangXfList.size()>0)
			{
				for(int i=0;i<feiyangXfList.size();i++)
				{
					String zksb=feiyangXfList.get(i).getString("OPT_ICKZKSB");
					String codid=feiyangXfList.get(i).getString("FEIYANGXF_ID");
					if("0".equals(zksb) || "".equals(zksb))
					{
						fyaxisNull=true;
					}else if(codid.equals(COD_ID) && "1".equals(zksb)){
						fyaxisNull=true;
					}
				}
			}else{
				fyaxisNull=true;
			}

			if(fyisNull && fymisNull && fyaisNull && fyamisNull && fyaxisNull)
			{
				map.put("msg","yes");
			}else{
				map.put("msg","no");
			}
			
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return map;
	}
	
	
	/**
     * 显示全部状态为 报价  的项目信息
     * Stone 17.07.05
     * @param page
     * @return
     */
	@RequestMapping("/itemList")
	public ModelAndView Itemlist(Page page) {
		ModelAndView mv = this.getModelAndView();
		SelectByRole sbr = new SelectByRole();
		try {
			PageData pd = this.getPageData();
			//将当前登录人添加至列表查询条件
    		pd.put("input_user", getUser().getUSER_ID());
    		List<String> userList = sbr.findUserList(getUser().getUSER_ID());
    		pd.put("userList", userList);
			page.setPd(pd);
//			List<PageData> itemList = e_offerService.itemlistpage(page);
			List<PageData> itemList = e_offerService.ShowItem(page);
			mv.setViewName("system/e_offer/e_offer_item");
			mv.addObject("itemList", itemList);
			mv.addObject("pd", pd);
			mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}
	/**
     * 对项目进行报价
     * 请求跳转（新增报价页面）
     * Stone 17.07.05
     * @param
     * @return
     */
	@RequestMapping("/addEoffer")
	public ModelAndView addEoffer() {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		PageData celarelePd = this.getPageData();
		
			try {
				pd=e_offerService.findItemById(pd);//项目信息
				e_offerService.reSetele(pd);
				Page page=new Page();
				
				//获取所选项目最新版本号
				int offversion = e_offerService.findLastOffVersion(pd.getString("item_id"));
				offversion += 1;
				pd.put("offer_version", offversion);
				
				
				//查找是否存在相同项目下一版本电梯信息有则删除
				celarelePd.put("item_id", pd.get("item_id"));
				celarelePd.put("offer_version", offversion);
				List<PageData> nextversionEle = e_offerService.findTempEleDetails(celarelePd);
				if (nextversionEle != null && !nextversionEle.isEmpty()) {
					e_offerService.deleteTempElelist(celarelePd);
				}

				
				//查找是否存在未保存报价但已添加报价池内容,有则删除记录
				List<PageData> temp_bjclist = e_offerService.bjc_list(pd);
				String modelsName;
				if (temp_bjclist.size()>0) {
					for (PageData i : temp_bjclist) {
						modelsName = i.getString("MODELS_NAME");
						PageData modelsPd = e_offerService.findModels(i);
						String ele_type = modelsPd.getString("ele_type");
						
			    		if(ele_type.equals("DT3")){
			    			e_offerService.deleteFeishangByBjc(pd);
			    		}else if(ele_type.equals("DT4")){
			    			e_offerService.deleteFeiyangByBjc(pd);
			    		}else if(ele_type.equals("DT5")){
			    			e_offerService.deleteFeiyangMRLByBjc(pd);
			    		}else if(ele_type.equals("DT6")){
			    			e_offerService.deleteFeiyangXFByBjc(pd);
			    		}else if(ele_type.equals("DT7")){
			    			e_offerService.deleteFeiyueByBjc(pd);
			    		}else if(ele_type.equals("DT8")){
			    			e_offerService.deleteFeiyueMRLByBjc(pd);
			    		}else if(ele_type.equals("DT1")){
			    			e_offerService.deleteDnp9300ByBjc(pd);
			    		}else if(ele_type.equals("DT2")){
			    			e_offerService.deleteDnrByBjc(pd);
			    		}else if(ele_type.equals("DT9")){
			    			e_offerService.deleteShinyByBjc(pd);
			    		}
						
//			    		if(modelsName.equals("飞尚曳引货梯")){
//			    			e_offerService.deleteFeishangByBjc(pd);
//			    		}else if(modelsName.equals("飞扬3000+")){
//			    			e_offerService.deleteFeiyangByBjc(pd);
//			    		}else if(modelsName.equals("飞扬3000+MRL")){
//			    			e_offerService.deleteFeiyangMRLByBjc(pd);
//			    		}else if(modelsName.equals("飞扬消防梯")){
//			    			e_offerService.deleteFeiyangXFByBjc(pd);
//			    		}else if(modelsName.equals("新飞越")){
//			    			e_offerService.deleteFeiyueByBjc(pd);
//			    		}else if(modelsName.equals("新飞越MRL")){
//			    			e_offerService.deleteFeiyueMRLByBjc(pd);
//			    		}else if(modelsName.equals("DNP9300")){
//			    			e_offerService.deleteDnp9300ByBjc(pd);
//			    		}else if(modelsName.equals("DNR")){
//			    			e_offerService.deleteDnrByBjc(pd);
//			    		}else if(modelsName.equals("曳引货梯")){
//			    			e_offerService.deleteShinyByBjc(pd);
//			    		}
			    		e_offerService.deleteBjc(i);
			    		modelsName = null;
					}
					e_offerService.reSetele(pd);
					
				}
				
				page.setPd(pd);

				//根据itemid复制项目电梯表信息到中间表保存
				e_offerService.copyeleDetailtoTemp(pd);
				PageData org = itemService.findOrderOrg(pd);
				if (org!=null) {
					pd.put("selorder_org", org.get("customer_name"));
				}
				//所属该项目的电梯信息
				List<PageData> elevatorList=e_offerService.addelevatorlistPage(page);
				
//				List<PageData> elevatorList=e_offerService.elevatorlistPage(page);
				//根据项目id查询报价池
				List<PageData> bjcList = e_offerService.bjc_list(pd);
				mv.addObject("bjcList", bjcList);
				PageData elev=new PageData();
				for(int i=0;i<elevatorList.size();i++)
				{
					String elevID="";
					elev.put("item_id",elevatorList.get(i).get("item_id").toString());
					elev.put("models_id",elevatorList.get(i).get("models_id").toString());
					elev.put("offer_version", offversion);
					//根据item_id和models_id获取电梯ID
//					List<PageData> elevList =  e_offerService.findEleBYmodels_id(elev);
					List<PageData> elevList =  e_offerService.findTempEleBYmodels_id(elev);
					
					for(int j=0;j<elevList.size();j++)
					{
						if(j+1<elevList.size())
						{
							elevID+=elevList.get(j).get("elevID").toString()+",";
						}
						else
						{
							elevID+=elevList.get(j).get("elevID").toString();
						}
					}
					elevatorList.get(i).put("elevID", elevID);
				}
				mv.addObject("elevatorList", elevatorList);
				
				String offer_no = null;
				String str = new SimpleDateFormat("yyMMdd").format(new Date());
				PageData OfferNo=e_offerService.E_offer_NO(pd);
				if(OfferNo!=null)
				{
					String no=OfferNo.get("offer_no").toString();
					String v = no.substring(no.indexOf("B") + 1);
					String v1 = v.substring(0, 6);
					if(v1.equals(str))
					{
						DecimalFormat mFormat = new DecimalFormat("000");//确定格式，把1转换为001  
						String a = no.substring(no.indexOf("_") + 1);
						String b = a.substring(0, 3);
						int c=Integer.parseInt(b);
						String d = mFormat.format(c+1);
						offer_no="B"+str+"_"+d+"01";
					}
					else
					{
						offer_no="B"+str+"_00101";
					}
				}
				else
				{
					offer_no="B"+str+"_00101";
				}
				
				pd.put("offer_no", offer_no);//报价编号
				mv.setViewName("system/e_offer/e_offer_edit");
				mv.addObject("pd", pd);
				mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
				mv.addObject("msg","saveS");
			} catch (Exception e) {
				logger.error(e.toString(), e);
			}
		
		return mv;
	}
	/**
     * 查看报价信息
     * Stone 17.08.11
     * @param
     * @return
     */
	@RequestMapping("/SeeEoffer")
	public ModelAndView SeeEoffer() {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		PageData Userpd = this.getPageData();
		PageData selBjcPd = new PageData();
		/*selBjcPd.put("ITEM_ID", pd.get("item_id").toString());*/
		try {
			//报价信息，以及项目信息
//			pd=e_offerService.findOfferById(pd);
			pd=e_offerService.findItemInOffer(pd);
			/*List<PageData> bjcList = e_offerService.findBjc(selBjcPd);*/
			PageData org = itemService.findOrderOrg(pd);
			if (org != null) {
				pd.put("selorder_org", org.get("customer_name"));
			}
			pd.put("offer_version", e_offerService.findOffVersionByofferno(pd.getString("offer_no")));
			List<PageData> bjcList = e_offerService.bjc_list(pd);
			Page page=new Page();
			page.setPd(pd);
			List<PageData> elevatorList=e_offerService.TempelevatorlistPage(page);//所属该项目的电梯信息
//			pd.put("user_id", pd.get("offer_user"));
//			Userpd = synUserservice.findUserByUserid(pd);
//			pd.put("apply_name", Userpd.get("NAME"));
	        mv.addObject("elevatorList", elevatorList);
	        mv.addObject("bjcList", bjcList);
			mv.setViewName("system/e_offer/e_offer_check");
			mv.addObject("pd", pd);
			Map<String, String> hc = getHC();
	        hc.put("cha", "1");
			mv.addObject(Const.SESSION_QX, hc); // 按钮权限
			mv.addObject("msg","saveS");
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	/**
     * 编辑报价信息
     * Stone 17.08.11
     * @param
     * @return
     */
	@RequestMapping("/editEoffer")
	public ModelAndView editEoffer() {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		PageData selBjcPd = new PageData();
		/*selBjcPd.put("ITEM_ID", pd.get("item_id").toString());*/
		try {
			//报价信息，以及项目信息
//			pd=e_offerService.findOfferById(pd);
			pd=e_offerService.findItemInOffer(pd);
//			pd.put("offer_version", e_offerService.findOffVersionByofferno(pd.getString("offer_no")));
			
			/*List<PageData> bjcList = e_offerService.findBjc(selBjcPd);*/
			List<PageData> bjcList = e_offerService.bjc_list(pd);
			Page page=new Page();
			page.setPd(pd);
			List<PageData> elevatorList=e_offerService.TempelevatorlistPage(page);//所属该项目的电梯信息

			PageData elev = new PageData();
			for(int i=0;i<elevatorList.size();i++)
			{
				String elevID="";
				elev.put("item_id",elevatorList.get(i).get("item_id").toString());
				elev.put("models_id",elevatorList.get(i).get("models_id").toString());
				elev.put("offer_version",pd.get("offer_version"));
				//根据item_id和models_id获取电梯ID
//				List<PageData> elevList =  e_offerService.findEleBYmodels_id(elev);
				List<PageData> elevList =  e_offerService.findTempEleBYmodels_id(elev);
				for(int j=0;j<elevList.size();j++)
				{
					if(j+1<elevList.size())
					{
						elevID+=elevList.get(j).get("elevID").toString()+",";
					}
					else
					{
						elevID+=elevList.get(j).get("elevID").toString();
					}
				}
				elevatorList.get(i).put("elevID", elevID);
			}
			
			PageData org = itemService.findOrderOrg(pd);
			if (org!=null) {
				pd.put("selorder_org", org.get("customer_name"));
			}
			
	        mv.addObject("elevatorList", elevatorList);
	        mv.addObject("bjcList", bjcList);
			mv.setViewName("system/e_offer/e_offer_edit");
			mv.addObject("pd", pd);
			mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
			mv.addObject("msg","edit");
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	
	/**
     * 保存   编辑报价信息
     * @return
     */
	@Log(module="edit", title="报价管理-修改", ext_idTitle="?1",ext_idParam="offer_id", ext_contentTitle="修改报价id：?1",ext_contentParam="offer_id")
	@RequestMapping("/edit")
	public ModelAndView edit() 
	{
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd=this.getPageData();
		
		//获取系统时间
		String df=DateUtil.getTime().toString(); 
		//获取系统当前登录人
		Subject currentUser=SecurityUtils.getSubject();
		Session session=currentUser.getSession();
		PageData pds=new PageData();
		pds=(PageData) session.getAttribute("userpds");
		String USER_ID=pds.getString("USER_ID");
		
		try 
		{
			pd.put("modify_date", df);
			pd.put("modify_user", USER_ID);
//			同步更新报价信息
			e_offerService.editS(pd);
			e_offerService.editSItemInOffer(pd);
			
			if("TJ".equals(pd.getString("type")))
			{
				String offer_id=pd.getString("offer_id");
				String instance_id=pd.getString("instance_id");
//				String offer_version = qdPd.getString("offer_version");
				apply(offer_id,instance_id);//启动流程
			}
			
			mv.addObject("msg", "success");
						
		} catch (Exception e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		mv.addObject("id", "addOffer");
		mv.addObject("form", "shopForm");
		mv.setViewName("save_result");
		return mv;
	}
	
//	---->去修改报价电梯数量页面
	@RequestMapping(value="GoupdateOfferEleNum")
	public ModelAndView GoupdateOfferEleNum(){
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try{
			
			PageData BJCmodelsCount = e_offerService.findBJCModelsCount(pd);
//			System.out.println(BJCmodelsCount);
			pd.put("BJCmodelsCount", BJCmodelsCount.get("BJCmodelsCount"));
			
			mv.addObject("pd", pd);
			mv.setViewName("system/e_offer/e_offer_updateele");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
//	新功能---->修改报价电梯数量
	@RequestMapping(value="/updateOfferEleNum")
	@ResponseBody
	public String updateOfferEleNum(){
		PageData pd = new PageData();
		pd = this.getPageData();
		try{
			e_offerService.updateOfferEle(pd);
			return "success";
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return "fail";
	}
	
	
	/**
     *	新功能----- 复制新建报价信息
     * ljh 18.08.30
     * @param
     * @return
     */
	@RequestMapping("/copyEoffer")
	public ModelAndView copyEoffer() {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		PageData selBjcPd = new PageData();
		PageData celarelePd = new PageData();
		PageData elepd = new PageData();
		Page page=new Page();
		Subject currentUser = SecurityUtils.getSubject();
 		Session session = currentUser.getSession();
 		PageData pds = new PageData();
 		pds = (PageData) session.getAttribute("userpds");
 		String USER_ID = pds.getString("USER_ID");
 		List<PageData> e_offerList = null;
 		SelectByRole sbr = new SelectByRole();
		
		/*selBjcPd.put("ITEM_ID", pd.get("item_id").toString());*/
		try {
			//报价信息，以及项目信息
			pd=e_offerService.findItemInOffer(pd);
			
			List<PageData> bjcList = e_offerService.bjc_list(pd);
			
			page.setPd(pd);
//			List<PageData> elevatorList=e_offerService.TempelevatorlistPage(page);
			List<PageData> elevatordetails=e_offerService.TempelevatorDeatil(page);//所属该项目的电梯信息
			
			//复制前删除下一版本电梯信息
			int tempoffver = Integer.parseInt(pd.getString("offer_version"));
			celarelePd.put("offer_version", tempoffver+1);
			celarelePd.put("item_id", pd.get("item_id"));
			List<PageData> nextversionEle = e_offerService.findTempEleDetails(celarelePd);
			if (nextversionEle != null && !nextversionEle.isEmpty()) {
				e_offerService.deleteTempElelist(celarelePd);
			}

	        PageData elev=new PageData();
			for(int i=0;i<elevatordetails.size();i++)
			{
				
				//复制插入电梯表
				int off = e_offerService.findLastOffVersion(elevatordetails.get(i).getString("item_id"));
				elevatordetails.get(i).put("offer_version", off+1);
				
				PageData data = elevatordetails.get(i);
//				System.out.println(data);
				e_offerService.saveTempelevatorlist(data);
				data = null;
				
			}
			
			pd.remove("offer_no");
			pd.remove("offer_id");
			pd.remove("offer_version");
			String offer_no = null;
			String str = new SimpleDateFormat("yyMMdd").format(new Date());
			PageData OfferNo=e_offerService.E_offer_NO(pd);
			if(OfferNo!=null)
			{
				String no=OfferNo.get("offer_no").toString();
				String v = no.substring(no.indexOf("B") + 1);
				String v1 = v.substring(0, 6);
				if(v1.equals(str))
				{
					DecimalFormat mFormat = new DecimalFormat("000");//确定格式，把1转换为001  
					String a = no.substring(no.indexOf("_") + 1);
					String b = a.substring(0, 3);
					int c=Integer.parseInt(b);
					String d = mFormat.format(c+1);
					offer_no="B"+str+"_"+d+"01";
				}
				else
				{
					offer_no="B"+str+"_00101";
				}
			}
			else
			{
				offer_no="B"+str+"_00101";
			}
	        
			pd.put("offer_no", offer_no);//报价编号
//			pd.put("offer_id", UUID.randomUUID().toString());
			int lastOffVersion = e_offerService.findLastOffVersion(pd.getString("item_id"));
			lastOffVersion +=1;
			pd.put("offer_version", lastOffVersion);
			selBjcPd.put("item_id", pd.getString("item_id"));
			selBjcPd.put("offer_version", lastOffVersion);
			//查找是否存在未保存报价但已添加报价池内容,有则删除记录
			List<PageData> temp_bjclist = e_offerService.bjc_list(selBjcPd);
			String modelsName;
			if (temp_bjclist.size()>0) {
				for (PageData i : temp_bjclist) {
					modelsName = i.getString("MODELS_NAME");
					PageData modelsPd = e_offerService.findModels(i);
					String ele_type = modelsPd.getString("ele_type");
					
		    		if(ele_type.equals("DT3")){
		    			e_offerService.deleteFeishangByBjc(pd);
		    		}else if(ele_type.equals("DT4")){
		    			e_offerService.deleteFeiyangByBjc(pd);
		    		}else if(ele_type.equals("DT5")){
		    			e_offerService.deleteFeiyangMRLByBjc(pd);
		    		}else if(ele_type.equals("DT6")){
		    			e_offerService.deleteFeiyangXFByBjc(pd);
		    		}else if(ele_type.equals("DT7")){
		    			e_offerService.deleteFeiyueByBjc(pd);
		    		}else if(ele_type.equals("DT8")){
		    			e_offerService.deleteFeiyueMRLByBjc(pd);
		    		}else if(ele_type.equals("DT1")){
		    			e_offerService.deleteDnp9300ByBjc(pd);
		    		}else if(ele_type.equals("DT2")){
		    			e_offerService.deleteDnrByBjc(pd);
		    		}else if(ele_type.equals("DT9")){
		    			e_offerService.deleteShinyByBjc(pd);
		    		}
		    		else if(ele_type.equals("DT10")){
		    			e_offerService.deleteFeishangMrlByBjc(pd);
		    		}
		    		e_offerService.deleteBjc(i);
		    		modelsName = null;
				}
				
			}
			
			//获取下一版本电梯信息			
			List<PageData> nextOffEleDetail = e_offerService.findTempEleDetails(selBjcPd);
			
			//遍历Copytarget的报价池信息,为新建的报价插入一样的报价池
			for (PageData bjc : bjcList) {
				
				String bjc_ele_id= "";
				String bjc_ele_eno= "";
				Integer dtsl = Integer.valueOf(bjc.getString("BJC_SL"));
				if(dtsl > nextOffEleDetail.size()) {
    				dtsl = nextOffEleDetail.size();
    			}
				List<String> elelist = new ArrayList<String>();
				if(StringUtils.isNoneBlank(bjc.getString("BJC_ENO"))) {
					String[] eles = bjc.getString("BJC_ENO").split(",");
					elelist = Arrays.asList(eles);
				}
				
				for (int i = 0; i < nextOffEleDetail.size(); i++) {
					PageData ele = nextOffEleDetail.get(i);
					String ele_models_id = ele.getString("models_id");
					String ele_item_id = ele.getString("item_id");
					int ele_offer_version = Integer.parseInt(ele.getString("offer_version"));
					String ele_eno = ele.getString("eno");
					String ele_flag = ele.getString("flag");
					
					
					if(bjc.getString("BJC_MODELS").equals(ele_models_id)&&ele_flag.equals("2")&&
							((elelist.size() == 0 &&  StringUtils.isBlank(ele_eno)) || elelist.contains(ele_eno))&&
							bjc.getString("BJC_ITEM_ID").equals(ele_item_id) &&
							dtsl > 0
							)
					{
						
						
						if(bjc_ele_id.length() == 0) {
							bjc_ele_id = String.valueOf(ele.get("id"));
						} else {
							bjc_ele_id += ","+String.valueOf(ele.get("id"));
						}
						if(bjc_ele_eno.length() == 0) {
							bjc_ele_eno = ele.getString("eno");
						} else {
							bjc_ele_eno += ","+ele.getString("eno");
						}
						
						dtsl--;
						nextOffEleDetail.remove(i);
						i--;
					}		 
					
					
					
				}
				
				bjc.put("BJC_ENO", bjc_ele_eno);
				bjc.put("BJC_ELEV", bjc_ele_id);
				bjc.getString("BJC_COD_ID");
				PageData BjcmodelsDetail = e_offerService.findModels(bjc);
				String Tempuuid = this.get32UUID();
				String TempbjcId = this.get32UUID();
				
				if (BjcmodelsDetail!=null) {
					String dt_type = BjcmodelsDetail.getString("ele_type");
					if(dt_type.equals("DT3")){
		    			bjc.put("FEISHANG_ID", bjc.get("BJC_COD_ID"));
		    			PageData findFeishang = e_offerService.findFeishang(bjc);
		    			bjc.put("BJC_COD_ID", Tempuuid);
		    			
		    			findFeishang.put("FEISHANG_ID",Tempuuid);
		    			findFeishang.put("OTHP_ISTSF_VAL", findFeishang.getNoneNULLString("OTHP_ISTSF"));
		    			e_offerService.saveFeishang(findFeishang);
		    			findFeishang.put("BJ_DT_ID",Tempuuid);
			    		e_offerService.saveConventionalNonstandard(findFeishang);
		    		}else if(dt_type.equals("DT4")){
		    			bjc.put("FEIYANG_ID", bjc.get("BJC_COD_ID"));
		    			PageData findFeiyang = e_offerService.findFeiyang(bjc);
		    			bjc.put("BJC_COD_ID", Tempuuid);
		    			
		    			findFeiyang.put("FEIYANG_ID",Tempuuid);
		    			//调试费重新赋值
		    			findFeiyang.put("OTHP_ISTSF_VAL", findFeiyang.getNoneNULLString("OTHP_ISTSF"));
		    			e_offerService.saveFeiyang(findFeiyang);
		    			findFeiyang.put("BJ_DT_ID",Tempuuid);
			    		e_offerService.saveConventionalNonstandard(findFeiyang);
		    		}else if(dt_type.equals("DT5")){
		    			bjc.put("FEIYANGMRL_ID", bjc.get("BJC_COD_ID"));
		    			PageData findFeiyangMRL = e_offerService.findFeiyangMRL(bjc);
		    			bjc.put("BJC_COD_ID", Tempuuid);
		    			
		    			findFeiyangMRL.put("FEIYANGMRL_ID",Tempuuid);
		    			//调试费重新赋值
		    			findFeiyangMRL.put("OTHP_ISTSF_VAL", findFeiyangMRL.getNoneNULLString("OTHP_ISTSF"));
		    			e_offerService.saveFeiyangMRL(findFeiyangMRL);
		    			findFeiyangMRL.put("BJ_DT_ID",Tempuuid);
			    		e_offerService.saveConventionalNonstandard(findFeiyangMRL);
		    		}else if(dt_type.equals("DT6")){
		    			bjc.put("FEIYANGXF_ID", bjc.get("BJC_COD_ID"));
		    			PageData findFeiyangXF = e_offerService.findFeiyangXF(bjc);
		    			bjc.put("BJC_COD_ID", Tempuuid);
		    			
		    			findFeiyangXF.put("FEIYANGXF_ID",Tempuuid);
		    			//调试费重新赋值
		    			findFeiyangXF.put("OTHP_ISTSF_VAL", findFeiyangXF.getNoneNULLString("OTHP_ISTSF"));
		    			e_offerService.saveFeiyangXF(findFeiyangXF);
		    			findFeiyangXF.put("BJ_DT_ID",Tempuuid);
			    		e_offerService.saveConventionalNonstandard(findFeiyangXF);
		    		}else if(dt_type.equals("DT7")){
		    			bjc.put("FEIYUE_ID", bjc.get("BJC_COD_ID"));
		    			//找出梯形信息,更新id后重新插入
		    			PageData findFeiyue = e_offerService.findFeiyue(bjc);
		    			bjc.put("BJC_COD_ID", Tempuuid);
		    			
		    			findFeiyue.put("FEIYUE_ID",Tempuuid);	
		    			//调试费重新赋值
		    			findFeiyue.put("OTHP_ISTSF_VAL", findFeiyue.getNoneNULLString("OTHP_ISTSF"));
		    			e_offerService.saveFeiyue(findFeiyue);
		    			findFeiyue.put("BJ_DT_ID",Tempuuid);
			    		e_offerService.saveConventionalNonstandard(findFeiyue);
		    		}else if(dt_type.equals("DT8")){
		    			bjc.put("FEIYUEMRL_ID", bjc.get("BJC_COD_ID"));
		    			//找出梯形信息,更新id后重新插入
		    			PageData findFeiyueMRL = e_offerService.findFeiyueMRL(bjc);
		    			bjc.put("BJC_COD_ID", Tempuuid);

		    			findFeiyueMRL.put("FEIYUEMRL_ID",Tempuuid);	
		    			//调试费重新赋值
		    			findFeiyueMRL.put("OTHP_ISTSF_VAL", findFeiyueMRL.getNoneNULLString("OTHP_ISTSF"));
		    			e_offerService.saveFeiyueMRL(findFeiyueMRL);
		    			findFeiyueMRL.put("BJ_DT_ID",Tempuuid);
			    		e_offerService.saveConventionalNonstandard(findFeiyueMRL);
		    		}else if(dt_type.equals("DT1")){
		    			bjc.put("DNP9300_ID", bjc.get("BJC_COD_ID"));
		    			PageData findDNP9300 = e_offerService.findDnp9300(bjc);
		    			bjc.put("BJC_COD_ID", Tempuuid);
		    			
		    			findDNP9300.put("DNP9300_ID",Tempuuid);
		    			//调试费重新赋值
		    			findDNP9300.put("OTHP_ISTSF_VAL", findDNP9300.getNoneNULLString("OTHP_ISTSF"));
		    			e_offerService.saveDnp9300(findDNP9300);
		    			findDNP9300.put("BJ_DT_ID",Tempuuid);
			    		e_offerService.saveConventionalNonstandard(findDNP9300);
		    		}else if(dt_type.equals("DT2")){
		    			bjc.put("DNR_ID", bjc.get("BJC_COD_ID"));
		    			PageData findDNR = e_offerService.findDnr(bjc);
		    			bjc.put("BJC_COD_ID", Tempuuid);
		    			
		    			findDNR.put("DNR_ID",Tempuuid);
		    			//调试费重新赋值
		    			findDNR.put("OTHP_ISTSF_VAL", findDNR.getNoneNULLString("OTHP_ISTSF"));
		    			e_offerService.saveDnr(findDNR);
		    			findDNR.put("BJ_DT_ID",Tempuuid);
			    		e_offerService.saveConventionalNonstandard(findDNR);
		    		}else if(dt_type.equals("DT9")){
		    			bjc.put("SHINY_ID", bjc.get("BJC_COD_ID"));
		    			PageData findShiny = e_offerService.findShiny(bjc);
		    			bjc.put("BJC_COD_ID", Tempuuid);
		    			
		    			findShiny.put("SHINY_ID",Tempuuid);
		    			//调试费重新赋值
		    			findShiny.put("OTHP_ISTSF_VAL", findShiny.getNoneNULLString("OTHP_ISTSF"));
		    			e_offerService.saveShiny(findShiny);
		    			findShiny.put("BJ_DT_ID",Tempuuid);
			    		e_offerService.saveConventionalNonstandard(findShiny);
		    		}else if(dt_type.equals("DT10")){
		    			bjc.put("FEISHANG_MRL_ID", bjc.get("BJC_COD_ID"));
		    			PageData findFeishangMrl = e_offerService.findFeishangMrl(bjc);
		    			bjc.put("BJC_COD_ID", Tempuuid);
		    			
		    			findFeishangMrl.put("FEISHANG_MRL_ID",Tempuuid);
		    			//调试费重新赋值
		    			findFeishangMrl.put("OTHP_ISTSF_VAL", findFeishangMrl.getNoneNULLString("OTHP_ISTSF"));
		    			e_offerService.saveFeishangMrl(findFeishangMrl);
		    			findFeishangMrl.put("BJ_DT_ID",Tempuuid);
			    		e_offerService.saveConventionalNonstandard(findFeishangMrl);
		    		}else if(dt_type.equals("DT12")||dt_type.equals("DT11")||dt_type.equals("DT13")){
		    			bjc.put("HOUSEHOLD_ID", bjc.get("BJC_COD_ID"));
		    			
		    			switch (dt_type) {
						case "DT12":
							bjc.put("eletbname", "tb_delco");
							break;
						case "DT11":
							bjc.put("eletbname", "A2");
							break;
						case "DT13":
							bjc.put("eletbname", "A3");
							break;
						default:
							break;
						}
		    			PageData Household = e_offerService.findHOUSEHOLD(bjc);
		    			bjc.put("BJC_COD_ID", Tempuuid);
		    			
		    			Household.put("FEISHANG_MRL_ID",Tempuuid);
		    			e_offerService.saveFeishangMrl(Household);
		    			Household.put("BJ_DT_ID",Tempuuid);
			    		e_offerService.saveConventionalNonstandard(Household);
		    		}
				}
				
	    		bjc.put("offer_version", lastOffVersion);
    			bjc.put("BJC_ID", TempbjcId);
    			bjc.put("item_id", bjc.get("BJC_ITEM_ID"));
    			e_offerService.saveBjc(bjc);
			}
			//还原未报台数
			e_offerService.reSetele(pd);
			pd.put("copyFlag", "IsCopy");
			this.liucheng(pd);
			bjcList = e_offerService.bjc_list(pd);
			page.setPd(pd);
			List<PageData> elevatorList=e_offerService.TempelevatorlistPage(page);//所属该项目的电梯信息
			PageData selelev = new PageData(); 
			for(int i=0;i<elevatorList.size();i++)
			{
				String elevID="";
				selelev.put("item_id",elevatorList.get(i).get("item_id").toString());
				selelev.put("models_id",elevatorList.get(i).get("models_id").toString());
				selelev.put("offer_version",pd.get("offer_version"));
				//根据item_id和models_id获取电梯ID
//				List<PageData> elevList =  e_offerService.findEleBYmodels_id(elev);
				List<PageData> elevList =  e_offerService.findTempEleBYmodels_id(selelev);
				for(int j=0;j<elevList.size();j++)
				{
					if(j+1<elevList.size())
					{
						elevID+=elevList.get(j).get("elevID").toString()+",";
					}
					else
					{
						elevID+=elevList.get(j).get("elevID").toString();
					}
				}
				elevatorList.get(i).put("elevID", elevID);
			}
			
	        mv.addObject("elevatorList", elevatorList);
	        mv.addObject("bjcList", bjcList);
			mv.setViewName("system/e_offer/e_offer_edit");
			mv.addObject("pd", pd);
			mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
			mv.addObject("msg","edit");
			
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	
	/**
	 *查询 参考报价 
	 */
	@RequestMapping(value="selCbj")
	public ModelAndView selCbj(){
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		List<PageData> cbjList = new ArrayList<PageData>();
		try{
			pd = this.getPageData();
			
			String models = pd.getString("models");
			Subject currentUser=SecurityUtils.getSubject();
			Session session=currentUser.getSession();
			PageData userpd=new PageData();
			userpd=(PageData) session.getAttribute("userpds");
			String USER_ID=userpd.getString("USER_ID");
			pd.put("user_id", USER_ID);
			
			//将当前登录人添加至列表查询条件
			pd.put("input_user", getUser().getUSER_ID());
			List<String> userList = new SelectByRole().findUserList(getUser().getUSER_ID());
			pd.put("userList", userList);

			if(models.equals("feishang")){
				cbjList = e_offerService.findFeishangCbj(pd);
			}else if(models.equals("feiyang")){
				cbjList = e_offerService.findFeiyangCbj(pd);
			}else if(models.equals("feiyangmrl")){
				cbjList = e_offerService.findFeiyangMRLCbj(pd);
			}else if(models.equals("feiyangxf")){
				cbjList = e_offerService.findFeiyangXFCbj(pd);
			}else if(models.equals("feiyue")){
				cbjList = e_offerService.findFeiyueCbj(pd);
			}else if(models.equals("feiyuemrl")){
				cbjList = e_offerService.findFeiyueMRLCbj(pd);
			}else if(models.equals("shiny")){
				cbjList = e_offerService.findShinyCbj(pd);
			}else if(models.equals("dnp9300")){
				cbjList = e_offerService.findDnp9300Cbj(pd);
			}else if(models.equals("dnr")){
				cbjList = e_offerService.findDnrCbj(pd);
			}else if(models.equals("feishangmrl")){
				cbjList = e_offerService.findFeishangMrlCbj(pd);
			}
			
			
			mv.addObject("cbjList", cbjList);
			mv.addObject("pd", pd);
			mv.setViewName("system/e_offer/cbj_list");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	/**
	 *调用装潢价格
	 */
	@RequestMapping(value="selZhj")
	public ModelAndView selZhj(){
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		List<PageData> zhjList = new ArrayList<PageData>();
		try{
			pd = this.getPageData();
			String models = pd.getString("models");
			if(models.equals("feishang")){
				zhjList = e_offerService.findFeishangZhj();
			}else if(models.equals("feiyang")){
				zhjList = e_offerService.findFeiyangZhj();
			}else if(models.equals("feiyangmrl")){
				zhjList = e_offerService.findFeiyangMRLZhj();
			}else if(models.equals("feiyangxf")){
				zhjList = e_offerService.findFeiyangXFZhj();
			}else if(models.equals("feiyue")){
				zhjList = e_offerService.findFeiyueZhj();
			}else if(models.equals("feiyuemrl")){
				zhjList = e_offerService.findFeiyueMRLZhj();
			}else if(models.equals("shiny")){
				zhjList = e_offerService.findShinyZhj();
			}
			mv.addObject("zhjList", zhjList);
			mv.addObject("pd", pd);
			mv.setViewName("system/e_offer/zhj_list");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	
	/**
	 * 删除数据
	 * @param
	 */
	@Log(module="delete", title="报价管理-删除", ext_idTitle="?1",ext_idParam="offer_no", ext_contentTitle="删除报价编号：?1",ext_contentParam="offer_no")
	@RequestMapping("/delE_offer")
	@ResponseBody
	public Object delE_offer() {
		PageData pd = this.getPageData();
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			PageData offerDetail = e_offerService.findItemInOffer(pd);
			List<PageData> bjc_list = e_offerService.bjc_list(offerDetail);
			for (PageData bjc : bjc_list) {
				e_offerService.deleteBjc(bjc);
			}
			
			e_offerService.deleteTempElelist(offerDetail);
			e_offerService.deleteOffer(pd);
			e_offerService.deleteTempOffer(pd);

			map.put("msg", "success");
		} catch (Exception e) {
			map.put("msg", "failed");
		}
		return JSONObject.fromObject(map);
	}
	/**
	 * 删除多条数据
	 * @param 
	 */
	@Log(module="delete", title="报价管理-批量删除", ext_idTitle="?1",ext_idParam="offer_nos", ext_contentTitle="删除报价编号：?1",ext_contentParam="offer_nos")
	@RequestMapping("/deleteAllS")
	@ResponseBody
	public Object delE_Offer() throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = this.getPageData();
		//Page page = this.getPage();
		try {
			//page.setPd(pd);
			String offer_nos = (String) pd.get("offer_nos");
			/*for (String offer_no : offer_nos.split(",")) {
				pd.put("offer_no", offer_no);
				e_offerService.deleteOffer(pd);
			}*/
			e_offerService.deleteOfferOfNos(offer_nos);
			map.put("msg", "success");
		} catch (Exception e) {
			map.put("msg", "failed");
		}
		return JSONObject.fromObject(map);
	}
	
	/**
     * 保存新增报价信息
     * @return
     */
	@RequestMapping("/saveS")
	public ModelAndView saveS() 
	{
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		String df=DateUtil.getTime().toString(); //获取系统时间
		
		pd=this.getPageData();
		Subject currentUser=SecurityUtils.getSubject();
		Session session=currentUser.getSession();
		PageData pds=new PageData();
		pds=(PageData) session.getAttribute("userpds");
		String USER_ID=pds.getString("USER_ID");
		try 
		{
			//保存报价信息时，生成报价编号
			String offer_no = null;
			String str = new SimpleDateFormat("yyMMdd").format(new Date());
			PageData OfferNo=e_offerService.E_offer_NO(pd);
			if(OfferNo!=null)
			{
				String no=OfferNo.get("offer_no").toString();
				String v = no.substring(no.indexOf("B") + 1);
				String v1 = v.substring(0, 6);
				if(v1.equals(str))
				{
					DecimalFormat mFormat = new DecimalFormat("000");//确定格式，把1转换为001  
					String a = no.substring(no.indexOf("_") + 1);
					String b = a.substring(0, 3);
					int c=Integer.parseInt(b);
					String d = mFormat.format(c+1);
					offer_no="B"+str+"_"+d+"01";
				}
				else
				{
					offer_no="B"+str+"_00101";
				}
			}
			else
			{
				offer_no="B"+str+"_00101";
			}
			
			pd.put("offer_no", offer_no);//报价编号
			Page page = new Page();
			//所属该项目的电梯信息
			int offversion = e_offerService.findLastOffVersion(pd.getString("item_id"));
			
			offversion += 1;
			pd.put("offer_version",offversion);
			page.setPd(pd);

			
//			List<PageData> elevatorList=e_offerService.addelevatorlistPage(page);
//			for (PageData i : elevatorList) { 
//				itemService.saveTempElevatorDetails(i);
//			}
			
			
			//获取项目包含的报价池信息
			List<PageData> bjcList=e_offerService.bjc_list(pd);

			//无论是否有货梯存在，都生成流程实例
			pd.put("ZHEKOU",pd.getString("COUNT_ZK"));	
			//调用生成流程实例
			PageData qdPd=new PageData();
			qdPd=liucheng(pd);
			mv.addObject("msg", "success");
			
			//判断如果是提交进来的 启动流程
			if("TJ".equals(pd.getString("type")))
			{
				String offer_id=qdPd.getString("offer_id");
				String instance_id=qdPd.getString("instance_id");
//				String offer_version = qdPd.getString("offer_version");
				apply(offer_id,instance_id);//启动流程
			}
			//保存报价成功后还原电梯已报未报
			e_offerService.reSetele(pd);
		} catch (Exception e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		mv.addObject("id", "addOffer");
		mv.addObject("form", "shopForm");
		mv.setViewName("save_result");
		return mv;
	}
	
	//生成流程实例
	public PageData liucheng(PageData pd)
	{
		Page copyPd = new Page();
		copyPd.setPd(pd);
		
		
		
		ModelAndView mv=new ModelAndView();
		//获取系统时间
		String df=DateUtil.getTime().toString(); 
		//获取系统当前登录人
		Subject currentUser=SecurityUtils.getSubject();
		Session session=currentUser.getSession();
		PageData pds=new PageData();
		pds=(PageData) session.getAttribute("userpds");
		String USER_ID=pds.getString("USER_ID");
		
		
		try 
		{
			
			//获取项目包含的梯种 根据梯种启动流程
			List<PageData> bjcList=e_offerService.bjc_list(pd);
//			e_offerService.findBjcByItemId(pd);
			String changguihuoti=null;
			String changguifeihuoti=null;
			//新建进入流程
			if (pd.get("copyFlag") == null) {
				PageData iteminfo = e_offerService.FindItemDetailByItemId(pd);
				pd.putAll(iteminfo);
			}

			

			for(PageData con : bjcList)
			{	
				String elevator_name = con.getString("MODELS_NAME");
				
				if(elevator_name.indexOf("货梯")!=-1)
				{
					changguihuoti="1";
				}else {
					changguifeihuoti="1";
				}
				
			}
			
			//-----------------生成流程相关
			String processDefinitionKey="";   //存放流程的key
			
			processDefinitionKey="offer_changguihuoti";
			//根据梯种启动流程
			/*if(changguihuoti!=null)
			{
				processDefinitionKey="offer_changguihuoti";
			}
			else if(changguifeihuoti!=null)
			{
				processDefinitionKey="offer_changguifeihuoti";
			}*/
			
			PageData offerPd=new PageData();
			offerPd.put("KEY", processDefinitionKey);
			//查询流程是否存在
			List<PageData> straList = e_offerService.instance_key(offerPd);
			if(straList!=null)
			{
				pd.put("offer_id", UUID.randomUUID().toString());
				pd.put("instance_status", 1);          //流程状态 1代表待启动
				pd.put("instance_id",processDefinitionKey);         //流程的key
				pd.put("offer_user", USER_ID);         //录入信息请求启动的用户ID
				pd.put("offer_date", df);              //录入时间
				pd.put("KEY", processDefinitionKey);
				
				//同步保存报价信息
				e_offerService.saveTempItem(pd);
				e_offerService.saveS(pd);
			}
			else
			{
				mv.addObject("msg", "流程不存在");
			}
			
			String IntervalTime = MailConfig.IntervalTime;
			String tomail = MailConfig.tomail;
			String emailForm = MailConfig.emailForm;
			
			//-----生成流程实例
			WorkFlow workFlow=new WorkFlow();
			IdentityService identityService=workFlow.getIdentityService();
			identityService.setAuthenticatedUserId(USER_ID);
			Object uuId=pd.get("offer_id");
			String businessKey="tb_e_offer.offer_id."+uuId;
			Map<String,Object> variables = new HashMap<String,Object>();
			variables.put("user_id", USER_ID);
			variables.put("IntervalTime", IntervalTime);
			variables.put("tomail", tomail);
			variables.put("emailForm", emailForm);
			variables.put("TaskItem", pd.get("item_name"));
			ProcessInstance proessInstance=null; //存放生成的流程实例id
			if(processDefinitionKey!=null && !"".equals(processDefinitionKey))
			{
				proessInstance = workFlow.getRuntimeService().startProcessInstanceByKey(processDefinitionKey, businessKey, variables);
			}
			if(proessInstance!=null)
			{
				pd.put("instance_id", proessInstance.getId());
				//修改报价信息  （流程的key该为流程实例id）
				e_offerService.editS(pd);
				//(new同步更新tb_iteminoffer)修改报价信息  （流程的key该为流程实例id）
				e_offerService.editSItemInOffer(pd);
				//补充项目信息
//				e_offerService.editItem(pd);
				mv.addObject("msg", "success");
			}
			else
			{
				e_offerService.deleteOffer(pd);//删除报价信息
				e_offerService.deleteTempOffer(pd);
				e_offerService.deleteTempElelist(pd);
				mv.addObject("msg", "failed");
				mv.addObject("err", "没有生成流程实例");
			}
			
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			e.printStackTrace();
		}
		return pd;
	}
	
	
	
	
	
	
	
	/**
	 * 启动流程
	 * @return
	 * @throws Exception 
	 */
    @RequestMapping("/apply")
    @ResponseBody
    public Object apply(String offer_id,String instance_id){
    	PageData pd=new PageData();
    	pd = this.getPageData();
    	PageData bjpd=new PageData();
    	pd.put("offer_id", offer_id);
    	pd.put("instance_id", instance_id);

    	Map<String,Object> map = new HashMap<>();
    	try{
			PageData offerDetail = e_offerService.findOfferDetailByOfferId(pd);
			offerDetail.remove("offer_id");
			offerDetail.remove("instance_id");
			
			pd.putAll(offerDetail);
            bjpd=e_offerService.findByuuId(pd);
    		//System.out.println(bjpd.getString("SWXX_DJ").equals("")?"0":bjpd.getString("SWXX_DJ"));
    		
    		if(bjpd.getString("sale_type").equals("2")||bjpd.getString("sale_type").equals("3")) {
					int anzhuangDJ=Integer.parseInt(bjpd.getString("SWXX_FKBL_DJ").equals("")?"0":bjpd.getString("SWXX_FKBL_DJ"));
					int anzhuangFHK=Integer.parseInt(bjpd.getString("SWXX_FKBL_FHQ").equals("")?"0":bjpd.getString("SWXX_FKBL_FHQ"));
					int anzhuangHDGD=Integer.parseInt(bjpd.getString("SWXX_FKBL_HDGD").equals("")?"0":bjpd.getString("SWXX_FKBL_HDGD"));
					int anzhuangCount=anzhuangDJ+anzhuangFHK+anzhuangHDGD;
					

					
					
					
					
    			//alert('直销，代销');
    			if(
					(Integer.parseInt(bjpd.getString("SWXX_DJ").equals("")?"0":bjpd.getString("SWXX_DJ"))>= 5 && 
					Integer.parseInt(bjpd.getString("SWXX_FHK").equals("")?"0":bjpd.getString("SWXX_FHK"))+Integer.parseInt(bjpd.getString("SWXX_DJ").equals("")?"0":bjpd.getString("SWXX_DJ"))
					+Integer.parseInt(bjpd.getString("SWXX_PCK").equals("")?"0":bjpd.getString("SWXX_PCK")) >=70 &&
					Integer.parseInt(bjpd.getString("SWXX_ZBJBL").equals("")?"0":bjpd.getString("SWXX_ZBJBL")) <= 5)||
					 (Integer.parseInt(bjpd.getString("SWXX_DJ").equals("")?"0":bjpd.getString("SWXX_DJ")) < 5 &&
					Integer.parseInt(bjpd.getString("SWXX_FHK").equals("")?"0":bjpd.getString("SWXX_FHK"))+Integer.parseInt(bjpd.getString("SWXX_DJ").equals("")?"0":bjpd.getString("SWXX_DJ"))
					+Integer.parseInt(bjpd.getString("SWXX_PCK").equals("")?"0":bjpd.getString("SWXX_PCK")) < 70 && 
					Integer.parseInt(bjpd.getString("SWXX_ZBJBL").equals("")?"0":bjpd.getString("SWXX_ZBJBL")) > 5)||
					(anzhuangCount >= 50 && 
						Integer.parseInt(bjpd.getString("SWXX_FKBL_YSHG").equals("")?"0":bjpd.getString("SWXX_FKBL_YSHG")) >= 50)||
						(anzhuangCount < 50 && 
						Integer.parseInt(bjpd.getString("SWXX_FKBL_YSHG").equals("")?"0":bjpd.getString("SWXX_FKBL_YSHG")) < 50)
							
						){
    					//alert("直销，代销，能提交");
    				    System.out.println("直销，代销，能提交");
    			}else{
//    				System.out.println("abc");
    				map.put("msg", "numerror");
    	            map.put("err", "数值错误");
    	            return JSONObject.fromObject(map);
    			}
    			
    		}else if(bjpd.getString("sale_type").equals("1")){
    			int dj=Integer.parseInt(bjpd.getString("SWXX_DJ").equals("")?"0":bjpd.getString("SWXX_DJ"));
        		int pck=Integer.parseInt(bjpd.getString("SWXX_PCK").equals("")?"0":bjpd.getString("SWXX_PCK"));
        		int fhk=Integer.parseInt(bjpd.getString("SWXX_FHK").equals("")?"0":bjpd.getString("SWXX_FHK"));
    			int c=dj+pck+fhk;
    			if(dj>=5 && pck>=20 && c==100){
					//alert("经销，能提交");
			        System.out.println("符合条件，可以能提交");
				}else if(dj<5 && pck<20 && c<100){
					//alert("经销，能提交");
			        System.out.println("符合条件，可以能提交");
				}else{
					//alert("经销，不能提交");
					map.put("msg", "numerror");
		            map.put("err", "数值错误");
		            return JSONObject.fromObject(map);
				}
    		}
    		
    		//shiro管理的session
            Subject currentUser = SecurityUtils.getSubject();
            Session session = currentUser.getSession();
            PageData pds = new PageData();
            pds = (PageData) session.getAttribute("userpds");
            String USER_ID = pds.getString("USER_ID");              //当前登录用户的ID
            /*String instance_id = pd.getString("instance_id"); */      //流程实例id
            
            int zhekou = 0;
            PageData offerPd = e_offerService.findByuuId(pd);
            String KEY=offerPd.getString("OFFER_KEY");
            if(KEY.equals("offer_changguihuoti"))
            {
            	String ZHEKOU=offerPd.getString("COUNT_ZK");
            	Double ZK = Double.parseDouble(ZHEKOU);
				if(ZK>=50)
				{
					zhekou=2;
				}
				else
				{
					zhekou=3;
				}
            	
            }
            else if(KEY.equals("offer_changguifeihuoti"))
            {
            	String ZHEKOU=offerPd.getString("COUNT_ZK");
            	Double ZK = Double.parseDouble(ZHEKOU);
				if(ZK>=50)
				{
					zhekou=2;
				}
				else
				{
					zhekou=3;
				}
            }
            
            
            // 如果流程的实例id存在，启动流程
            if(instance_id!=null && !"".equals(instance_id)){
            	WorkFlow workFlow = new WorkFlow();
            	// 用来设置启动流程的人员ID，引擎会自动把用户ID保存到activiti:initiator中
            	workFlow.getIdentityService().setAuthenticatedUserId(USER_ID);
            	Task task = workFlow.getTaskService().createTaskQuery().processInstanceId(instance_id).singleResult();
//            	task.getTaskDefinitionKey().equals("usertask1") &&
        		if("1".equals(offerPd.getString("instance_status"))
        				|| "5".equals(offerPd.getString("instance_status"))) {
        			Map<String,Object> variables = new HashMap<String,Object>();
                	//设置任务角色
                	workFlow.getTaskService().setAssignee(task.getId(), USER_ID);
                	//签收任务
                	workFlow.getTaskService().claim(task.getId(), USER_ID);
                	//设置流程变量
                	variables.put("action", "提交申请");
                	if("5".equals(offerPd.getString("instance_status"))) {
                		variables.put("action", "重新提交");
                	}
                	variables.put("approved", true);
                    variables.put("zhekou", zhekou);
                    String  comment = pd.getString("offer_remark");
                    
                    workFlow.getTaskService().setVariablesLocal(task.getId(),variables);
                    Authentication.setAuthenticatedUserId(USER_ID);
                    workFlow.getTaskService().addComment(task.getId(),null,comment);
                    workFlow.getTaskService().complete(task.getId(),variables);
                    
                	/*workFlow.getTaskService().setVariablesLocal(task.getId(), variables);*/
                	pd.put("instance_status", 2);   //流程状态  2代表流程启动,等待审核
                	e_offerService.editInstance_status(pd);//更新流程状态
                	e_offerService.editTempInstance_status(pd);
                	/*workFlow.getTaskService().complete(task.getId());*/
                	
                	//跳过任务
                	//获取申请人的待办任务列表
                	Task task1 = null;
                	List<Task> todoList = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID).active()
                			.orderByTaskCreateTime().desc().listPage(0, 1);
                	for (Task tmp : todoList) {
                		if(tmp.getProcessInstanceId().equals(instance_id)){
                			task1 = tmp;
                			break;
                		}
                	}
                	if(!"1".equals(USER_ID) && task1 != null) {
                		Map<String,Object> variables1 = new HashMap<String,Object>();
                		pd.put("instance_status",3);             //流程状态  3.审核中
                		variables1.put("approved", true);
                		e_offerService.editInstance_status(pd);  //修改流程状态
                		e_offerService.editTempInstance_status(pd);
                		variables1.put("action","跳过任务");
                		//设置任务角色
                		//workFlow.getTaskService().setAssignee(task1.getId(), USER_ID);
                		//签收任务
                		workFlow.getTaskService().claim(task1.getId(), USER_ID);
                		//使得task_id与流程变量关联,查询历史记录时可以通过task_id查询到操作变量,必须使用setVariableLocal方法
                		workFlow.getTaskService().setVariablesLocal(task1.getId(),variables1);
                		workFlow.getTaskService().complete(task1.getId(),variables1);
                	}
                	
                	//获取下一个任务的信息
                    Task tasks = workFlow.getTaskService().createTaskQuery().processInstanceId(instance_id).singleResult();
                    map.put("task_name",tasks.getName());
                    map.put("status", "1");
        		} else {
        			//获取下一个任务的信息
                    Task tasks = workFlow.getTaskService().createTaskQuery().processInstanceId(instance_id).singleResult();
                    map.put("task_name",tasks.getName());
                    map.put("status", "1");
        		}
            	
            }
            if((instance_id !=null && !"".equals(instance_id))){
            	map.put("status", "3");
            }
            map.put("msg", "success");
    	}catch(Exception e){
    		logger.error(e.toString(), e);
            map.put("msg", "failed");
            map.put("err", "系统错误");
    	}
    	return JSONObject.fromObject(map);
    }

    /**
     * 显示待我处理的
     * @param page
     * @return
     */
    @RequestMapping(value= "/e_offerAudit")
    public ModelAndView listPendingContractor(Page page){
    	  ModelAndView mv = this.getModelAndView();
          PageData pd = new PageData();
          pd = this.getPageData();
          SelectByRole sbr = new SelectByRole();
          try{
        	  //shiro管理的session
              Subject currentUser = SecurityUtils.getSubject();
              Session session = currentUser.getSession();
              PageData pds = new PageData();
              pds = (PageData) session.getAttribute("userpds");
              String USER_ID = pds.getString("USER_ID");
              page.setPd(pds);
              mv.setViewName("system/e_offer/e_offer_audit");
              mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
              //存放任务集合
              List<PageData> e_offers = new ArrayList<>();
              WorkFlow workFlow = new WorkFlow();


			 List<String> userList = sbr.findUserList(getUser().getUSER_ID());


              // 等待处理的任务
              //设置分页数据
              int firstResult;//开始游标
              int maxResults;//结束游标
              int showCount = page.getShowCount();//默认为10
              int currentPage = page.getCurrentPage();//默认为0
              if (currentPage==0) {//currentPage为0时，页面第一次加载或者刷新
                  firstResult = currentPage;//从0开始
                  currentPage+=1;//当前为第一页
                  maxResults = showCount;
              }else{
                  firstResult = showCount*(currentPage-1);
                  maxResults = firstResult+showCount;
              }
              //List<Task> toHandleListCount = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID).processDefinitionKey("offer_changguihuoti").orderByTaskCreateTime().desc().active().list();
              List<Task> toHandleList = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID).processDefinitionKey("offer_changguihuoti").orderByTaskCreateTime().desc().active().list();

              for (Task task : toHandleList) {
                  PageData e_offer = new PageData();
                  String processInstanceId = task.getProcessInstanceId();
                  ProcessInstance processInstance = workFlow.getRuntimeService().createProcessInstanceQuery().processInstanceId(processInstanceId).active().singleResult();
                  String businessKey = processInstance.getBusinessKey();
                  if (!StringUtils.isEmpty(businessKey)){
                      //leave.leaveId.
                      String[] info = businessKey.split("\\.");
                      e_offer.put(info[1],info[2]);
                      e_offer.put("userList", userList);
 					 //new判断是否首页进来
 					 if (pd.getString("flag")!=null &&pd.getString("flag").equals("shouye")) {
 						 if(e_offer!=null && e_offer.getNoneNULLString("offer_id").equals(pd.get("offer_id"))) {
 							 e_offer = e_offerService.findByuuId(pd);
 		                   	  if(e_offer!=null  && StringUtils.isNoneBlank(e_offer.getString("item_name"))){
 		                           	e_offer.put("task_name",task.getName());
 		     						  e_offer.put("task_id",task.getId());
 		     						  if(task.getAssignee()!=null){
 		     							  e_offer.put("type","1");//待处理
 		     						  }else{
 		     							  e_offer.put("type","0");//待签收
 		     						  }
 		     						  e_offers.add(e_offer);
 		                   	  }
 		                   	  break;
 						 } else {
 							 continue;
 						 }
                      }
                     
                      //根据uuiid查询信息
                      e_offer = e_offerService.findByuuId(e_offer);
                      if(e_offer!=null && StringUtils.isNoneBlank(e_offer.getString("item_name"))){
                      	e_offer.put("task_name",task.getName());
						  e_offer.put("task_id",task.getId());
						  if(task.getAssignee()!=null){
							  e_offer.put("type","1");//待处理
						  }else{
							  e_offer.put("type","0");//待签收
						  }
						  e_offers.add(e_offer);
                      }else {
						  continue;
					  }
                      
                  }
             }
                 
            /* List<Task> toHandleListCount2 = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID).processDefinitionKey("offer_changguifeihuoti").orderByTaskCreateTime().desc().active().list();
             List<Task> toHandleList2 = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID).processDefinitionKey("offer_changguifeihuoti").orderByTaskCreateTime().desc().active().listPage(firstResult, maxResults);
                for (Task task : toHandleList2) {
                 PageData e_offer = new PageData();
                 String processInstanceId = task.getProcessInstanceId();
                 ProcessInstance processInstance = workFlow.getRuntimeService().createProcessInstanceQuery().processInstanceId(processInstanceId).active().singleResult();
                 String businessKey = processInstance.getBusinessKey();
                 if (!StringUtils.isEmpty(businessKey)){
                     //leave.leaveId.
                     String[] info = businessKey.split("\\.");
                     e_offer.put(info[1],info[2]);
                     //根据uuiid查询信息
                     e_offer = e_offerService.findByuuId(e_offer);
                     e_offer.put("task_name",task.getName());
                     e_offer.put("task_id",task.getId());
                     if(task.getAssignee()!=null){
                   	  e_offer.put("type","1");//待处理
                     }else{
                   	  e_offer.put("type","0");//待签收
                     }
                 }
                 e_offers.add(e_offer);
             }*/
                 
              //设置分页数据
              int totalResult = toHandleList.size();/*+toHandleListCount2.size()*/
              if (totalResult<=showCount) {
                  page.setTotalPage(1);
              }else{
                  int count = Integer.valueOf(totalResult/showCount);
                  int  mod= totalResult%showCount;
                  if (mod>0) {
                      count =count+1;
                  }
                  page.setTotalPage(count);
              }
              page.setTotalResult(totalResult);
              page.setCurrentResult(e_offers.size());
              page.setCurrentPage(currentPage);
              page.setShowCount(showCount);
              page.setEntityOrField(true);
              //如果有多个form,设置第几个,从0开始
              page.setFormNo(0);
              //page.setPageStrForActiviti(page.getPageStrForActiviti());
              mv.addObject("page", null);
              //待处理任务的count
              pd.put("count",e_offers.size());
              pd.put("isActive2","1");
              mv.addObject("pd",pd);
              mv.addObject("e_offers", e_offers);
              mv.addObject("userpds", pds);
          }catch(Exception e){
        	  logger.error(e.toString(), e);
          }
          return mv;
    }
    /**
     * 签收任务
     *
     * @return
     */
    @SuppressWarnings("unchecked")
	@RequestMapping("/claim")
    @ResponseBody
    public Object claim() {
        Map map = new HashMap();
        PageData pd = new PageData();
        pd = this.getPageData();
        try {
            //shiro管理的session
            Subject currentUser = SecurityUtils.getSubject();
            Session session = currentUser.getSession();
            PageData pds = new PageData();
            pds = (PageData) session.getAttribute("userpds");
            
            WorkFlow workFlow = new WorkFlow();
            String task_id = pd.getString("task_id");
            String user_id = pds.getString("USER_ID");	
            workFlow.getTaskService().claim(task_id,user_id);
            
            Task task = workFlow.getTaskService().createTaskQuery().taskId(task_id).singleResult();
            if(task != null && StringUtils.isNoneBlank(task.getAssignee())) {
                map.put("msg","success");
            } else {
                map.put("msg","failed");
                map.put("err","签收失败");
            }
            
        } catch (Exception e) {
            map.put("msg","failed");
            map.put("err","签收失败");
            logger.error(e.toString(), e);
        }
        return JSONObject.fromObject(map);
    }
    
    
    /**
     * 跳到录入总结页面
     * @return
     * @throws Exception
     */
    @RequestMapping("/ZongJie")
    public ModelAndView ZongJie() throws Exception {
        ModelAndView mv = new ModelAndView();
        PageData pd = this.getPageData();
        
        try 
        {
        	PageData offDetail = e_offerService.findItemInOffer(pd);
        	if (offDetail != null && offDetail.size()>0) {
				pd = offDetail;
			}else
			{
	        	//报价信息，以及项目信息
				pd=itemService.findItemById(pd);
			}
			
        	String user_ID = getUser().getUSER_ID();
        	if(pd.getNoneNULLString("offer_user").equals(user_ID)
        			|| pd.getNoneNULLString("input_user").equals(user_ID)) {
        		
        		pd.put("isCurrentUser", "1");
        	}
        	
			mv.addObject("pd", pd);
	        mv.setViewName("system/e_offer/e_offer_zongjie");
			mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
        
        return mv;
    }
    
    
  
	/**
     * 保存  录入总结
     * @return
     */
	@RequestMapping("/saveZongJie")
	public ModelAndView saveZongJie() 
	{
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd=this.getPageData();
		try 
		{
			if (pd.getString("type").equals("TJ")) {
				pd.put("zongjieflag","1");
			}else {
				pd.put("zongjieflag","0");
			}
			//查找是否存在该报价,如存在直接修改tb_iteminoffer,
			//不存在则修改tb_item,为新建报价
			PageData offerdetail = e_offerService.findItemInOffer(pd);
			if (offerdetail!=null&&offerdetail.size()>0) {
				e_offerService.editTempItemZongjie(pd);
			}else {
				//补充项目信息
				e_offerService.editItem(pd);
			}
			mv.addObject("msg", "success");
						
		} catch (Exception e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		mv.addObject("id", "EditShops");
		mv.addObject("form", "zongJieForm");
		mv.setViewName("save_result");
		return mv;
	}
	
	
    /**
     * 跳到办理任务页面
     * @return
     * @throws Exception
     */
    @RequestMapping("/goHandStra")
    public ModelAndView goHandleAgent() throws Exception {
        ModelAndView mv = new ModelAndView();
        PageData pd = this.getPageData();
        String task_id=pd.getString("task_id");
        try 
        {
        	//报价信息，以及项目信息
			pd=e_offerService.findItemInOffer(pd);
			/*List<PageData> bjcList = e_offerService.findBjc(selBjcPd);*/
			List<PageData> bjcList = e_offerService.bjc_list(pd);
			Page page=new Page();
			page.setPd(pd);
			List<PageData> elevatorList=e_offerService.TempelevatorlistPage(page);
			mv.addObject("elevatorList", elevatorList);
	        mv.addObject("bjcList", bjcList);
	        mv.setViewName("system/e_offer/e_offer_handle");
	        pd.put("task_id", task_id);
			mv.addObject("pd", pd);
			Map<String, String> hc = getHC();
	        hc.put("cha", "1");
			mv.addObject(Const.SESSION_QX, hc); // 按钮权限
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
        
        return mv;
    }
    /**
     * 办理任务
     * @return
     */
    @RequestMapping("/handleAgent")
    public ModelAndView handleAgent(){
    	ModelAndView mv = new ModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        try{
        	 //shiro管理的session
            Subject currentUser = SecurityUtils.getSubject();
            Session session = currentUser.getSession();
            PageData pds = new PageData();
            pds = (PageData) session.getAttribute("userpds");
            
            // 办理任务
            WorkFlow workFlow = new WorkFlow();
            String task_id = pd.getString("task_id");
            String user_id = pds.getString("USER_ID");
            Map<String,Object> variables = new HashMap<String ,Object>();
            boolean isApproved = false;
            boolean isEnd=false;
            String action = pd.getString("action");
            @SuppressWarnings("unused")
			int status;
            if (action.equals("approve")){
                Task task = workFlow.getTaskService().createTaskQuery().taskId(task_id).singleResult();
                if(task.getTaskDefinitionKey().equals("ZiGongSiTask"))
                {
                	 status = 2;    //已完成
                     pd.put("instance_status",4);             //流程状态   4.已通过
                     variables.put("approved", true);
                     isApproved=true;
                     isEnd=true;
                     e_offerService.editInstance_status(pd);  //修改流程状态
                     e_offerService.editTempInstance_status(pd); //修改流程状态
                }
                else if(task.getTaskDefinitionKey().equals("YingXiaoTask"))
                {
                	 status = 2;    //已完成
                     pd.put("instance_status",4);             //流程状态   4.已通过
                     variables.put("approved", true);
                     isApproved=true;
                     isEnd=true;
                     e_offerService.editInstance_status(pd);  //修改流程状态
                     e_offerService.editTempInstance_status(pd); //修改流程状态
                }
                else if(task.getTaskDefinitionKey().equals("GuFenTask"))
                {
                	 status = 2;    //已完成
                     pd.put("instance_status",4);             //流程状态   4.已通过
                     variables.put("approved", true);
                     isApproved=true;
                     isEnd=true;
                     e_offerService.editInstance_status(pd);  //修改流程状态
                     e_offerService.editTempInstance_status(pd); //修改流程状态
                }
                else
                {
                	status = 2;    //已完成
                    pd.put("instance_status",3);             //流程状态  3.审核中
                    variables.put("approved", true);
                    isApproved=true;
                    e_offerService.editInstance_status(pd);  //修改流程状态
                    e_offerService.editTempInstance_status(pd); //修改流程状态
                }
            }else if(action.equals("reject")) {
                status = 4;   
                pd.put("instance_status",5);             //流程状态  5代表 被驳回
                variables.put("approved", false);
                e_offerService.editInstance_status(pd);  //修改流程状态
                e_offerService.editTempInstance_status(pd); //修改流程状态
            }
            String  comment = (String) pd.get("comment");
            if (isApproved){
                variables.put("action","批准");
            }else{
                variables.put("action","驳回");
            }
            if(isEnd)
            {
            	variables.put("action","通过,流程结束！");
            }
            //使得task_id与流程变量关联,查询历史记录时可以通过task_id查询到操作变量,必须使用setVariableLocal方法
            workFlow.getTaskService().setVariablesLocal(task_id,variables);
            Authentication.setAuthenticatedUserId(user_id);
            workFlow.getTaskService().addComment(task_id,null,comment);
            workFlow.getTaskService().complete(task_id,variables);
            mv.addObject("msg", "success");
        }catch(Exception e){
        	 mv.addObject("msg", "failed");
             mv.addObject("err", "办理失败！");
             logger.error(e.toString(), e);
        }
        mv.addObject("id", "handleLeave");
        mv.addObject("form", "handleLeaveForm");
        mv.setViewName("save_result");
    	return mv;
    }
    
    /**
     * 显示我已经处理的任务
     *
     * @return
     */
    @RequestMapping("/listDoneOffer")
    public ModelAndView listDoneE_offer(Page page) {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        try {
            //shiro管理的session
            Subject currentUser = SecurityUtils.getSubject();
            Session session = currentUser.getSession();
            PageData pds = new PageData();
            pds = (PageData) session.getAttribute("userpds");
            String USER_ID = pds.getString("USER_ID");
            page.setPd(pds);
            mv.setViewName("system/e_offer/e_offer_audit");
            mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
            WorkFlow workFlow = new WorkFlow();
            // 已处理的任务集合
            List<PageData> e_offers = new ArrayList<>();
            List<HistoricTaskInstance> list = new ArrayList<HistoricTaskInstance>();
            HashMap<String,HistoricTaskInstance> map = new HashMap<String,HistoricTaskInstance>();
            
            //获取已处理的任务
            List<HistoricTaskInstance> historicTaskInstances = workFlow.getHistoryService().createHistoricTaskInstanceQuery().taskAssignee(USER_ID).processDefinitionKey("offer_changguihuoti").orderByTaskCreateTime().desc().list();
            //移除重复的
            for (HistoricTaskInstance instance:historicTaskInstances)
            {
                String processInstanceId = instance.getProcessInstanceId();
                HistoricProcessInstance historicProcessInstance = workFlow.getHistoryService().createHistoricProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
                String businessKey = historicProcessInstance.getBusinessKey();
                map.put(businessKey,instance);
            }
            
            /*//获取已处理的任务
            List<HistoricTaskInstance> historicTaskInstances2 = workFlow.getHistoryService().createHistoricTaskInstanceQuery().taskAssignee(USER_ID).processDefinitionKey("offer_changguifeihuoti").orderByTaskCreateTime().desc().list();
            //移除重复的
            for (HistoricTaskInstance instance:historicTaskInstances2)
            {
                String processInstanceId = instance.getProcessInstanceId();
                HistoricProcessInstance historicProcessInstance = workFlow.getHistoryService().createHistoricProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
                String businessKey = historicProcessInstance.getBusinessKey();
                map.put(businessKey,instance);
            }*/
            
            @SuppressWarnings("rawtypes")
			Iterator iter = map.entrySet().iterator();
            while (iter.hasNext()){
                @SuppressWarnings("rawtypes")
				Map.Entry entry = (Map.Entry) iter.next();
                list.add((HistoricTaskInstance)entry.getValue());
            }
            //设置分页数据
            int firstResult;//开始游标
            int maxResults;//结束游标
            int showCount = page.getShowCount();//默认为10
            int currentPage = page.getCurrentPage();//默认为0
            if (currentPage==0) {//currentPage为0时，页面第一次加载或者刷新
                firstResult = currentPage;//从0开始
                currentPage+=1;//当前为第一页
                maxResults = showCount;
            }else{
                firstResult = showCount*(currentPage-1);
                maxResults = firstResult+showCount;
            }
            //int listCount =(list.size()<=maxResults?list.size():maxResults);
            int listCount = list.size();
            //从分页参数开始
            for (int i = firstResult; i <listCount ; i++) {
                HistoricTaskInstance historicTaskInstance = list.get(i);
                PageData stra = new PageData();
                String processInstanceId = historicTaskInstance.getProcessInstanceId();
                HistoricProcessInstance historicProcessInstance = workFlow.getHistoryService().createHistoricProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
                String businessKey = historicProcessInstance.getBusinessKey();
                if (!StringUtils.isEmpty(businessKey)){
                        //leave.leaveId.
                        String[] info = businessKey.split("\\.");
                        stra.put(info[1],info[2]);
                        stra = e_offerService.findByuuId(stra);
                        //检查申请者是否是本人,如果是,跳过
                        if (stra==null
                        		|| "".equals(stra.getNoneNULLString("offer_id"))
                        		||stra.getNoneNULLString("offer_user").equals(USER_ID))
                        continue;
                        //查询当前流程是否还存在
                        List<ProcessInstance> runing = workFlow.getRuntimeService().createProcessInstanceQuery().processInstanceId(processInstanceId).list();
                        if (stra!=null) {
                        	if (runing==null||runing.size()<=0){
                        		stra.put("isRuning",0);
                            }else{
                            	stra.put("isRuning",1);
                                //正在运行,查询当前的任务信息
                                Task task = workFlow.getTaskService().createTaskQuery().processInstanceId(processInstanceId).singleResult();
                                stra.put("task_name",task.getName());
                                stra.put("task_id",task.getId());
                            }
                            e_offers.add(stra);
						}
                }
            }
            //设置分页数据
            int totalResult = list.size();
            if (totalResult<=showCount) {
                page.setTotalPage(1);
            }else{
                int count = Integer.valueOf(totalResult/showCount);
                int  mod= totalResult%showCount;
                if (mod>0) {
                    count =count+1;
                }
                page.setTotalPage(count);
            }
            page.setTotalResult(totalResult);
            page.setCurrentResult(e_offers.size());
            page.setCurrentPage(currentPage);
            page.setShowCount(showCount);
            page.setEntityOrField(true);
            //如果有多个form,设置第几个,从0开始
            page.setFormNo(1);
            page.setPageStrForActiviti(page.getPageStrForActiviti());
            mv.addObject("page", null);
            //待处理任务的count
            pd.put("count1",e_offers.size());
            pd.put("isActive3","1");
            mv.addObject("pd",pd);
            mv.addObject("e_offers", e_offers);
            mv.addObject("userpds", pds);
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }
    
    /**
     * 重新提交流程
     *
     * @return
     */
    @SuppressWarnings("unchecked")
	@RequestMapping("/restartAgent")
    @ResponseBody
    public Object restartAgent() {
        Map map = new HashMap();
        PageData pd = new PageData();
        pd = this.getPageData();
        try {
            //shiro管理的session
            Subject currentUser = SecurityUtils.getSubject();
            Session session = currentUser.getSession();
            PageData pds = new PageData();
            pds = (PageData) session.getAttribute("userpds");
            WorkFlow workFlow = new WorkFlow();
            String task_id = pd.getString("task_id");  //流程id
            String user_id = pds.getString("USER_ID");
            
            int zhekou = 0;
            PageData offerPd = e_offerService.findByuuId(pd);
            String KEY=offerPd.getString("OFFER_KEY");
            if(KEY.equals("offer_changguihuoti"))
            {
            	String ZHEKOU=offerPd.getString("COUNT_ZK");
            	Double ZK = Double.parseDouble(ZHEKOU);
				if(ZK>=50)
				{
					zhekou=2;
				}
				else
				{
					zhekou=3;
				}
            	
            }
            else if(KEY.equals("offer_changguifeihuoti"))
            {
            	String ZHEKOU=offerPd.getString("COUNT_ZK");
            	Double ZK = Double.parseDouble(ZHEKOU);
				if(ZK>=50)
				{
					zhekou=2;
				}
				else
				{
					zhekou=3;
				}
            }
            
            Task task = workFlow.getTaskService().createTaskQuery().taskId(task_id).singleResult();
            if(StringUtils.isNoneBlank(task.getAssignee())) {
            	workFlow.getTaskService().setAssignee(task_id,user_id);
            } else {
            	workFlow.getTaskService().claim(task_id,user_id);
            }
            
            //workFlow.getTaskService().claim(task_id,user_id);
            Map<String,Object> variables = new HashMap<String,Object>();
            variables.put("action","重新提交");
			variables.put("approved", true);
			variables.put("zhekou", zhekou);
            //使得task_id与流程变量关联,查询历史记录时可以通过task_id查询到操作变量,必须使用setVariableLocal方法
            workFlow.getTaskService().setVariablesLocal(task_id,variables);
			Map<String,Object> obj=workFlow.getTaskService().getVariables(task_id);
            Authentication.setAuthenticatedUserId(user_id);
            //处理任务
            workFlow.getTaskService().complete(task_id,obj);
        	//更新业务数据的状态
        	pd.put("instance_status", 2); //流程状态 2.待审核
        	e_offerService.editInstance_status(pd);  //修改流程状态
        	e_offerService.editTempInstance_status(pd);  //修改流程状态
            map.put("msg","success");
        } catch (Exception e) {
            map.put("msg","failed");
            map.put("err","重新提交失败");
            logger.error(e.toString(), e);
        }
        return JSONObject.fromObject(map);
    }
    
    @RequestMapping(value = "trunTask")
    @ResponseBody
    public Map<String, Object> trunTask() {
    	Map<String, Object> returnMap = new HashMap<String, Object>();
    	PageData pd = this.getPageData();
    	WorkFlow workFlow = new WorkFlow();
    	String task_id = pd.getString("task_id");
    	String user_id = pd.getString("user_id");
    	
    	returnMap.put("code", "0");
    	if(StringUtils.isNoneBlank(task_id)
    			&& StringUtils.isNoneBlank(user_id)) {
    		
    		Task task = workFlow.getTaskService().createTaskQuery().taskId(task_id).singleResult();
    		if(task != null) {
    			
    			workFlow.getTaskService().setAssignee(task_id, user_id);
    			
    			returnMap.put("code", "1");
    		}
    	}
    	
    	return returnMap;
    }
    
    /**
     *跳转到常规梯报价单页面 
     */
    @RequestMapping(value="offerView")
    public ModelAndView offerView(){
    	ModelAndView mv = new ModelAndView();
    	PageData pd = new PageData();
    	try{
    		pd = this.getPageData();
    		
    		PageData offerDetail = e_offerService.findItemInOffer(pd);
    		
    		//(new)获取当前报价版本号,用作复制报价后编辑
    		if (offerDetail!=null && !offerDetail.isEmpty()) {
    			pd.put("offer_version", offerDetail.get("offer_version"));
    			String itemelecount=e_offerService.findTempItemEleCountNum(pd);
    			mv.addObject("itemelecount",itemelecount);
    		}else {
    			String itemelecount=e_offerService.findItemEleCountNum(pd);
    			mv.addObject("itemelecount",itemelecount);
    		}
//			}else {
//				e_offerService.findLastOffVersion(sel);
//			}
    		
    		pd.put("models_id", pd.getString("MODELS_ID"));
    		PageData modelsPd = modelsService.findModelsById(pd);
    		//电梯型号标识
    		String ele_type = modelsPd.getString("ele_type");
    		String forwardMsg = pd.getString("forwardMsg");
			mv.addObject("forwardMsg", forwardMsg);
			
			mv.addObject("ele_type", ele_type);
			if(ele_type.equals("DT10")){
    			//根据COD查询对应梯种的电梯标准信息
    			modelsPd.put("ID", modelsPd.getString("standard_id"));
    			PageData regelevStandardPd = regelevStandardService.findById(modelsPd);
    			mv.addObject("regelevStandardPd", regelevStandardPd);
    			//放入COD信息
    			mv.addObject("modelsPd", modelsPd);
    			if(pd.containsKey("COD_ID")){
    				String rowIndex = pd.getString("rowIndex");
    				String codId = pd.getString("COD_ID");
    				String bjcId = pd.getString("BJC_ID");
    				pd.put("FEISHANG_MRL_ID", codId);
    				PageData findFeishangMrl = e_offerService.findFeishangMrl(pd);
    				pd.putAll(findFeishangMrl);
    				
    				pd.put("BJC_ID", bjcId);
    				//(new)获取当前报价版本号,用作复制报价后编辑
    	    		if (offerDetail!=null && !offerDetail.isEmpty()) {
    	    			pd.put("offer_version", offerDetail.get("offer_version"));
    				}
    				pd.put("rowIndex", rowIndex);
    				pd.put("view", "edit");
    			}else{
        			pd.put("FEISHANG_MRL_SL", pd.get("OFFER_NUM").toString());
        			pd.put("view", "save");
    			}
    			mv.addObject("pd", pd);
    			mv.addObject("msg", "saveFeishangMrl");
    			mv.setViewName("system/e_offer/feishang_mrl");
    		}else if(ele_type.equals("DT3")){
    			//根据COD查询对应梯种的电梯标准信息
    			modelsPd.put("ID", modelsPd.getString("standard_id"));
    			PageData regelevStandardPd = regelevStandardService.findById(modelsPd);
    			mv.addObject("regelevStandardPd", regelevStandardPd);
    			//放入COD信息
    			mv.addObject("modelsPd", modelsPd);
    			if(pd.containsKey("COD_ID")){
    				String rowIndex = pd.getString("rowIndex");
    				String codId = pd.getString("COD_ID");
    				String bjcId = pd.getString("BJC_ID");
    				pd.put("FEISHANG_ID", codId);
    				PageData findFeishang = e_offerService.findFeishang(pd);
    				pd.putAll(findFeishang);
    				
    				pd.put("BJC_ID", bjcId);
    				//(new)获取当前报价版本号,用作复制报价后编辑
    	    		if (offerDetail!=null && !offerDetail.isEmpty()) {
    	    			pd.put("offer_version", offerDetail.get("offer_version"));
    				}
    				pd.put("rowIndex", rowIndex);
    				pd.put("view", "edit");
    			}else{
        			pd.put("FEISHANG_SL", pd.get("OFFER_NUM").toString());
        			pd.put("view", "save");
    			}
    			mv.addObject("pd", pd);
    			mv.addObject("msg", "saveFeishang");
    			mv.setViewName("system/e_offer/feishang");
    		}else if(ele_type.equals("DT5")){
    			//根据COD查询对应梯种的电梯标准信息
    			modelsPd.put("ID", modelsPd.getString("standard_id"));
    			PageData regelevStandardPd = regelevStandardService.findById(modelsPd);
    			mv.addObject("regelevStandardPd", regelevStandardPd);
    			//放入COD信息
    			mv.addObject("modelsPd", modelsPd);
    			if(pd.containsKey("COD_ID")){
    				String rowIndex = pd.getString("rowIndex");
    				String codId = pd.getString("COD_ID");
    				String bjcId = pd.getString("BJC_ID");
    				pd.put("FEIYANGMRL_ID", codId);
    				PageData findFeiyangMRL = e_offerService.findFeiyangMRL(pd);
    				pd.putAll(findFeiyangMRL);
    				
    				pd.put("BJC_ID", bjcId);
    				//(new)获取当前报价版本号,用作复制报价后编辑
    	    		if (offerDetail!=null && !offerDetail.isEmpty()) {
    	    			pd.put("offer_version", offerDetail.get("offer_version"));
    				}
    				pd.put("rowIndex", rowIndex);
    				pd.put("view", "edit");
    			}else{
        			pd.put("FEIYANGMRL_SL", pd.get("OFFER_NUM").toString());
        			pd.put("view", "save");
    			}
    			mv.addObject("pd", pd);
    			mv.addObject("msg", "saveFeiyangMRL");
    			mv.setViewName("system/e_offer/feiyang3000_mrl");
    		}else if(ele_type.equals("DT4")){
    			//根据COD查询对应梯种的电梯标准信息
    			modelsPd.put("ID", modelsPd.getString("standard_id"));
    			PageData regelevStandardPd = regelevStandardService.findById(modelsPd);
    			mv.addObject("regelevStandardPd", regelevStandardPd);
    			//放入COD信息
    			mv.addObject("modelsPd", modelsPd);
    			if(pd.containsKey("COD_ID")){
    				String rowIndex = pd.getString("rowIndex");
    				String codId = pd.getString("COD_ID");
    				String bjcId = pd.getString("BJC_ID");
    				pd.put("FEIYANG_ID", codId);
    				PageData findFeiyang = e_offerService.findFeiyang(pd);
    				pd.putAll(findFeiyang);
    				pd.put("BJC_ID", bjcId);
    				//(new)获取当前报价版本号,用作复制报价后编辑
    	    		if (offerDetail!=null && !offerDetail.isEmpty()) {
    	    			pd.put("offer_version", offerDetail.get("offer_version"));
    				}
    				pd.put("rowIndex", rowIndex);
    				pd.put("view", "edit");
    			}else{
        			pd.put("FEIYANG_SL", pd.get("OFFER_NUM").toString());
        			pd.put("view", "save");
    			}
    			mv.addObject("pd", pd);
    			mv.addObject("msg", "saveFeiyang");
    			mv.setViewName("system/e_offer/feiyang3000");
    		}else if(ele_type.equals("DT6")){
    			//根据COD查询对应梯种的电梯标准信息
    			modelsPd.put("ID", modelsPd.getString("standard_id"));
    			PageData regelevStandardPd = regelevStandardService.findById(modelsPd);
    			mv.addObject("regelevStandardPd", regelevStandardPd);
    			//放入COD信息
    			mv.addObject("modelsPd", modelsPd);
    			if(pd.containsKey("COD_ID")){
    				String rowIndex = pd.getString("rowIndex");
    				String codId = pd.getString("COD_ID");
    				String bjcId = pd.getString("BJC_ID");
    				pd.put("FEIYANGXF_ID", codId);
    				PageData findFeiyangXF = e_offerService.findFeiyangXF(pd);
    				pd.putAll(findFeiyangXF);
    				
    				pd.put("BJC_ID", bjcId);
    				//(new)获取当前报价版本号,用作复制报价后编辑
    	    		if (offerDetail!=null && !offerDetail.isEmpty()) {
    	    			pd.put("offer_version", offerDetail.get("offer_version"));
    				}
    				pd.put("rowIndex", rowIndex);
    				pd.put("view", "edit");
    			}else{
        			pd.put("FEIYANGXF_SL", pd.get("OFFER_NUM").toString());
        			pd.put("view", "save");
    			}
    			mv.addObject("pd", pd);
    			mv.addObject("msg", "saveFeiyangXF");
    			mv.setViewName("system/e_offer/feiyang_xf");
    		}else if(ele_type.equals("DT7")){
    			//根据COD查询对应梯种的电梯标准信息
    			modelsPd.put("ID", modelsPd.getString("standard_id"));
    			PageData regelevStandardPd = regelevStandardService.findById(modelsPd);
    			mv.addObject("regelevStandardPd", regelevStandardPd);
    			//放入COD信息
    			mv.addObject("modelsPd", modelsPd);
	    		//(new)获取当前报价版本号,用作复制报价后编辑
	    		if (offerDetail!=null && !offerDetail.isEmpty()) {
	    			pd.put("offer_version", offerDetail.get("offer_version"));
				}
    			if(pd.containsKey("COD_ID")){
    				String rowIndex = pd.getString("rowIndex");
    				String codId = pd.getString("COD_ID");
    				String bjcId = pd.getString("BJC_ID");
    				pd.put("FEIYUE_ID", codId);
    				PageData findFeiyue = e_offerService.findFeiyue(pd);
    				pd.putAll(findFeiyue);
    				pd.put("BJC_ID", bjcId);
    				//(new)获取当前报价版本号,用作复制报价后编辑
    	    		if (offerDetail!=null && !offerDetail.isEmpty()) {
    	    			pd.put("offer_version", offerDetail.get("offer_version"));
    				}
    				pd.put("rowIndex", rowIndex);
    				pd.put("view", "edit");
    			}else{
        			pd.put("FEIYUE_SL", pd.get("OFFER_NUM").toString());
        			pd.put("view", "save");
    			}
    			mv.addObject("pd", pd);
    			mv.addObject("msg", "saveFeiyue");
    			mv.setViewName("system/e_offer/feiyue");
    		}else if(ele_type.equals("DT8")){
    			//根据COD查询对应梯种的电梯标准信息
    			modelsPd.put("ID", modelsPd.getString("standard_id"));
    			PageData regelevStandardPd = regelevStandardService.findById(modelsPd);
    			mv.addObject("regelevStandardPd", regelevStandardPd);
    			//放入COD信息
    			mv.addObject("modelsPd", modelsPd);
    			if(pd.containsKey("COD_ID")){
    				String rowIndex = pd.getString("rowIndex");
    				String codId = pd.getString("COD_ID");
    				String bjcId = pd.getString("BJC_ID");
    				pd.put("FEIYUEMRL_ID", codId);
    				PageData findFeiyueMRL = e_offerService.findFeiyueMRL(pd);
    				pd.putAll(findFeiyueMRL);
    				pd.put("BJC_ID", bjcId);
    				//(new)获取当前报价版本号,用作复制报价后编辑
    	    		if (offerDetail!=null && !offerDetail.isEmpty()) {
    	    			pd.put("offer_version", offerDetail.get("offer_version"));
    				}
    				pd.put("rowIndex", rowIndex);
    				pd.put("view", "edit");
    			}else{
        			pd.put("FEIYUEMRL_SL", pd.get("OFFER_NUM").toString());
        			pd.put("view", "save");
    			}
    			mv.addObject("pd", pd);
    			mv.addObject("msg", "saveFeiyueMRL");
    			mv.setViewName("system/e_offer/feiyue_mrl");
    		}else if(ele_type.equals("DT1")){
    			//根据COD查询对应梯种的电梯标准信息
    			modelsPd.put("ID", modelsPd.getString("standard_id"));
    			PageData regelevStandardPd = regelevStandardService.findById2(modelsPd);
    			mv.addObject("regelevStandardPd", regelevStandardPd);
    			//放入COD信息
    			mv.addObject("modelsPd", modelsPd);
    			if(pd.containsKey("COD_ID")){
    				String rowIndex = pd.getString("rowIndex");
    				String codId = pd.getString("COD_ID");
    				String bjcId = pd.getString("BJC_ID");
    				pd.put("DNP9300_ID", codId);
    				PageData findDnp9300 = e_offerService.findDnp9300(pd);
    				pd.putAll(findDnp9300);
    				
    				pd.put("BJC_ID", bjcId);
    				//(new)获取当前报价版本号,用作复制报价后编辑
    	    		if (offerDetail!=null && !offerDetail.isEmpty()) {
    	    			pd.put("offer_version", offerDetail.get("offer_version"));
    				}
    				pd.put("rowIndex", rowIndex);
    				pd.put("view", "edit");
    			}else{
        			pd.put("DNP9300_SL", pd.get("OFFER_NUM").toString());
					pd.put("view", "save");
    			}
    			mv.addObject("pd", pd);
    			mv.addObject("msg", "saveDnp9300");
    			mv.setViewName("system/e_offer/dnp9300");
    		}else if(ele_type.equals("DT2")){
    			//根据COD查询对应梯种的电梯标准信息
    			modelsPd.put("ID", modelsPd.getString("standard_id"));
    			PageData regelevStandardPd = regelevStandardService.findById2(modelsPd);
    			mv.addObject("regelevStandardPd", regelevStandardPd);
    			//放入COD信息
    			mv.addObject("modelsPd", modelsPd);
    			if(pd.containsKey("COD_ID")){
    				String rowIndex = pd.getString("rowIndex");
    				String codId = pd.getString("COD_ID");
    				String bjcId = pd.getString("BJC_ID");
    				pd.put("DNR_ID", codId);
    				PageData findDnr = e_offerService.findDnr(pd);
    				pd.putAll(findDnr);
    				
    				pd.put("BJC_ID", bjcId);
    				//(new)获取当前报价版本号,用作复制报价后编辑
    	    		if (offerDetail!=null && !offerDetail.isEmpty()) {
    	    			pd.put("offer_version", offerDetail.get("offer_version"));
    				}
    				pd.put("rowIndex", rowIndex);
    				pd.put("view", "edit");
    			}else{
        			pd.put("DNR_SL", pd.get("OFFER_NUM").toString());
					pd.put("view", "save");
    			}
    			mv.addObject("pd", pd);
    			mv.addObject("msg", "saveDnr");
    			mv.setViewName("system/e_offer/dnr");
    		}else if(ele_type.equals("DT9")){
    			//根据COD查询对应梯种的电梯标准信息
    			modelsPd.put("ID", modelsPd.getString("standard_id"));
    			PageData regelevStandardPd = regelevStandardService.findById(modelsPd);
    			mv.addObject("regelevStandardPd", regelevStandardPd);
    			//放入COD信息
    			mv.addObject("modelsPd", modelsPd);
    			if(pd.containsKey("COD_ID")){
    				String rowIndex = pd.getString("rowIndex");
    				String codId = pd.getString("COD_ID");
    				String bjcId = pd.getString("BJC_ID");
    				pd.put("SHINY_ID", codId);
    				PageData findShiny = e_offerService.findShiny(pd);
    				pd.putAll(findShiny);
    				pd.put("BJC_ID", bjcId);
    				//(new)获取当前报价版本号,用作复制报价后编辑
    	    		if (offerDetail!=null && !offerDetail.isEmpty()) {
    	    			pd.put("offer_version", offerDetail.get("offer_version"));
    				}
    				pd.put("rowIndex", rowIndex);
    				pd.put("view", "edit");
    			}else{
        			pd.put("SHINY_SL", pd.get("OFFER_NUM").toString());
        			pd.put("view", "save");
    			}
    			mv.addObject("pd", pd); 
    			mv.addObject("msg", "saveShiny");
    			mv.setViewName("system/e_offer/shiny");
    		}else if(ele_type.equals("DT12")||ele_type.equals("DT11")||ele_type.equals("DT13")){
    			//根据COD查询对应梯种的电梯标准信息
    			modelsPd.put("ID", modelsPd.getString("standard_id"));
    			PageData regelevStandardPd = regelevStandardService.findById3(modelsPd);
    			mv.addObject("regelevStandardPd", regelevStandardPd);
//    			//放入COD信息
    			mv.addObject("modelsPd", modelsPd);
    			if(pd.containsKey("COD_ID")){
    				String rowIndex = pd.getString("rowIndex");
    				String codId = pd.getString("COD_ID");
    				String bjcId = pd.getString("BJC_ID");
    				pd.put("household_id", codId);
    				switch (ele_type) {
					case "DT12":
						pd.put("eletbname", "tb_delco");
						PageData household = e_offerService.findHOUSEHOLD(pd);
	    				pd.putAll(household);
						break;
					case "DT11"://A2
						pd.put("eletbname", "tb_A2");
						PageData A2 = e_offerService.findHOUSEHOLD(pd);
	    				pd.putAll(A2);
						break;
					case "DT13"://A3
						pd.put("eletbname", "tb_A3");
						PageData A3 = e_offerService.findHOUSEHOLD(pd);
	    				pd.putAll(A3);
						break;
					default:
						break;
					}
    				
    				pd.put("BJC_ID", bjcId);
    				//(new)获取当前报价版本号,用作复制报价后编辑
    	    		if (offerDetail!=null && !offerDetail.isEmpty()) {
    	    			pd.put("offer_version", offerDetail.get("offer_version"));
    				}
    				pd.put("rowIndex", rowIndex);
    				pd.put("view", "edit");
    			}else{
        			pd.put("HOUSEHOLD_SL", pd.get("OFFER_NUM").toString());
        			pd.put("view", "save");
    			}
    			mv.addObject("pd", pd); 
    			mv.setViewName("system/e_offer/delcoc3");
    		}else if(isTezhongdt(ele_type)){
    			//根据COD查询对应梯种的电梯标准信息
    			PageData regelevStandardPd = new PageData();//临时测试
    			mv.addObject("regelevStandardPd", regelevStandardPd);
//    			//放入COD信息
    			mv.addObject("modelsPd", modelsPd);
    			if(pd.containsKey("COD_ID")){
    				String rowIndex = pd.getString("rowIndex");
    				String codId = pd.getString("COD_ID");
    				String bjcId = pd.getString("BJC_ID");
    				pd.put("TEZHONG_ID", codId);
    				PageData findTezhong = e_offerService.findTezhong(pd);
    				pd.putAll(findTezhong);
    				List<PageData> tezhongArgs = e_offerService.findTezhongArgs(pd);
    				pd.put("tezhongArgs", tezhongArgs);
    				pd.put("BJC_ID", bjcId);
    				//(new)获取当前报价版本号,用作复制报价后编辑
    	    		if (offerDetail!=null && !offerDetail.isEmpty()) {
    	    			pd.put("offer_version", offerDetail.get("offer_version"));
    				}
    				pd.put("rowIndex", rowIndex);
    				pd.put("view", "edit");
    			}else{
        			pd.put("BASE_SL", pd.get("OFFER_NUM").toString());
        			pd.put("view", "save");
    			}
    			mv.addObject("pd", pd); 
    			mv.addObject("msg", "saveTezhong");
    			mv.setViewName("system/e_offer/elevator_nonstanard");
    		}
			//加载省份
			List<PageData> provinceList=cityService.findYSFProvince();
			mv.addObject("provinceList", provinceList);
			//加载城市
			List<PageData> cityList=e_offerService.findAllDestinByProvinceId(pd);
			mv.addObject("cityList", cityList);
			if(pd!=null&&pd.get("trans_more_car")!=null&&pd.get("trans_more_car")!=""){
				JSONArray jsonArray=JSONArray.fromObject(pd.get("trans_more_car"));
				mv.addObject("tmc_list",jsonArray);
			}
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
    	}
    	return mv;
    }
    
    //根据电梯ID获取电梯eno
//    public String elevNo(String elevIds)
//    {
//    	String AllElevNos ="";
//    	String[] AllElevID=elevIds.split(","); 
//		
//	    for(int i=0;i<AllElevID.length;i++)
//	    {
//	    	PageData apd=new PageData();
//	    	apd.put("id", AllElevID[i]);
//	    	try {
//				PageData EnoPd=e_offerService.selectElevEno(apd);
//				AllElevNos+=EnoPd.getString("eno")+",";
//			} catch (Exception e) {
//				// TODO 自动生成的 catch 块
//				e.printStackTrace();
//			}
//	    	
//	    }
//		return AllElevNos;
//    	
//    }
    
    //根据电梯ID获取电梯eno
    public String elevNo(String elevIds)
    {
    	String AllElevNos ="";
    	String[] AllElevID=elevIds.split(","); 
		
	    for(int i=0;i<AllElevID.length;i++)
	    {
	    	PageData apd=new PageData();
	    	apd.put("id", AllElevID[i]);
	    	try {
				PageData EnoPd=e_offerService.selectTempElevEno(apd);
				AllElevNos+=EnoPd.getString("eno")+",";
			} catch (Exception e) {
				// TODO 自动生成的 catch 块
				e.printStackTrace();
			}
	    	
	    }
		return AllElevNos;
    	
    }
    
    
    //保存 飞越
    @RequestMapping(value="saveFeiyue")
    public ModelAndView saveFeiyue(){
    	ModelAndView mv = new ModelAndView();
    	PageData pd = new PageData();
		pd = this.getPageData();
		
		//feishangId,modelsId,bjcId,elevIds新增/编辑页面关闭之后重新给报价池页面的button赋值
    	String feiyueId = "";
    	String modelsId = "";
    	String bjcId = "";
    	String elevIds = "";
    	try{

    		if(pd.getString("view").equals("edit")){
    			feiyueId = pd.getString("FEIYUE_ID");
    			modelsId = pd.getString("MODELS_ID");
    			bjcId = pd.getString("BJC_ID");
    			elevIds = pd.getString("ELEV_IDS");
    			//调用获取电梯eno方法
    			String elevNo=elevNo(elevIds);
    			
    			e_offerService.updateFeiyue(pd);
    			
    			pd.put("BJ_DT_ID",feiyueId);
	    		e_offerService.updateConventionalNonstandard(pd);
	    		
    			//关联更新报价池
    			PageData bjcPd = new PageData();

    			bjcPd.put("offer_version", pd.getString("offer_version"));
    			bjcPd.put("BJC_ENO", elevNo);
	        	bjcPd.put("BJC_ID", pd.getString("BJC_ID"));
	        	bjcPd.put("BJC_COD_ID", pd.getString("FEIYUE_ID"));
	        	bjcPd.put("BJC_ITEM_ID", pd.get("ITEM_ID").toString());
	        	bjcPd.put("BJC_ELEV", pd.get("ELEV_IDS").toString());
	        	bjcPd.put("BJC_MODELS", pd.get("MODELS_ID").toString());
	        	bjcPd.put("BJC_ZHSBJ", pd.get("FEIYUE_ZHSBJ").toString());
	        	bjcPd.put("BJC_SL", pd.get("FEIYUE_SL").toString());
	        	bjcPd.put("BJC_ZZ", pd.get("BZ_ZZ").toString());
	        	bjcPd.put("BJC_SD", pd.get("BZ_SD").toString());
	        	bjcPd.put("BJC_C", pd.get("BZ_C").toString());
	        	bjcPd.put("BJC_Z", pd.get("BZ_Z").toString());
	        	bjcPd.put("BJC_M", pd.get("BZ_M").toString());
	        	bjcPd.put("BJC_TSGD", pd.get("BASE_TSGD").toString());
	        	
	        	bjcPd.put("BJC_SBJ", pd.get("XS_SBSJBJ").toString());//设备实际报价
	        	bjcPd.put("BJC_ZK", pd.get("XS_ZKL").toString());//折扣
	        	bjcPd.put("SBSJZJ", pd.get("XS_SBSJBJ").toString());//设备实际总价
	        	bjcPd.put("YJZE", pd.get("XS_YJZE").toString());//佣金总额
	        	bjcPd.put("YJBL", pd.get("XS_YJBL").toString());//佣金比例
	        	bjcPd.put("BJC_AZF", pd.get("XS_AZJ").toString());//安装费
	        	bjcPd.put("BJC_YSF", pd.get("XS_YSJ").toString());//运输费
	        	bjcPd.put("BJC_SJBJ", pd.get("XS_TATOL").toString());//实际报价
	        	bjcPd.put("YJSYZKL", pd.get("YJSYZKL").toString());
	        	bjcPd.put("ZGYJ", pd.get("ZGYJ").toString());
	        	PageData hzPd=setHzBjc(pd);
	        	bjcPd.put("JJ_XXJJ", hzPd.getString("JJ_XXJJ"));//基价+选项加价
	        	bjcPd.put("SJ_FB_QT", hzPd.getString("SJ_FB_QT"));//实际-非标-其他*1.17
	        	bjcPd.put("SJ_FB_QT_YJ", hzPd.getString("SJ_FB_QT_YJ"));//实际-非标-其他*1.17-佣金*1.17
	        	e_offerService.updateBjc(bjcPd);
	        	mv.addObject("bjc_id", pd.getString("BJC_ID"));
    		}else{
	    		feiyueId = this.get32UUID();
	    		pd.put("FEIYUE_ID", feiyueId);
	    		e_offerService.saveFeiyue(pd);
	    		pd.put("BJ_DT_ID",feiyueId);
	    		e_offerService.saveConventionalNonstandard(pd);
	    		//关联更新电梯报价状态信息
	        	updateDetails(pd);
	        	//关联保存报价池
	        	String bjc_id = this.get32UUID();
    			//button赋值部分
    			modelsId = pd.getString("MODELS_ID");
    			bjcId = bjc_id;
    			elevIds = pd.getString("ELEV_IDS");
    			//调用获取电梯eno方法
    			String elevNo=elevNo(elevIds);
    			
	        	PageData bjcPd = new PageData();
	        	bjcPd.put("BJC_ENO", elevNo);
	        	bjcPd.put("BJC_ID", bjc_id);
	        	bjcPd.put("bjc_id", bjc_id);
	        	bjcPd.put("item_id", pd.get("ITEM_ID").toString());
	        	bjcPd.put("BJC_COD_ID", feiyueId);
	        	bjcPd.put("BJC_ITEM_ID", pd.get("ITEM_ID").toString());
	        	bjcPd.put("BJC_ELEV", pd.get("ELEV_IDS").toString());
	        	bjcPd.put("BJC_MODELS", pd.get("MODELS_ID").toString());
	        	bjcPd.put("BJC_ZHSBJ", pd.get("FEIYUE_ZHSBJ").toString());
	        	bjcPd.put("BJC_SL", pd.get("FEIYUE_SL").toString());
	        	bjcPd.put("BJC_ZZ", pd.get("BZ_ZZ").toString());
	        	bjcPd.put("BJC_SD", pd.get("BZ_SD").toString());
	        	bjcPd.put("BJC_C", pd.get("BZ_C").toString());
	        	bjcPd.put("BJC_Z", pd.get("BZ_Z").toString());
	        	bjcPd.put("BJC_M", pd.get("BZ_M").toString());
	        	bjcPd.put("BJC_TSGD", pd.get("BASE_TSGD").toString());
	        	
	        	bjcPd.put("BJC_SBJ", pd.get("XS_SBSJBJ").toString());//设备实际报价
	        	bjcPd.put("BJC_ZK", pd.get("XS_ZKL").toString());//折扣
	        	bjcPd.put("SBSJZJ", pd.get("XS_SBSJBJ").toString());//设备实际总价
	        	bjcPd.put("YJZE", pd.get("XS_YJZE").toString());//佣金总额
	        	bjcPd.put("YJBL", pd.get("XS_YJBL").toString());//佣金比例
	        	bjcPd.put("BJC_AZF", pd.get("XS_AZJ").toString());//安装费
	        	bjcPd.put("BJC_YSF", pd.get("XS_YSJ").toString());//运输费
	        	bjcPd.put("BJC_SJBJ", pd.get("XS_TATOL").toString());//实际报价
	        	bjcPd.put("YJSYZKL", pd.get("YJSYZKL").toString());
	        	bjcPd.put("ZGYJ", pd.get("ZGYJ").toString());
	        	PageData hzPd=setHzBjc(pd);
	        	bjcPd.put("JJ_XXJJ", hzPd.getString("JJ_XXJJ"));//基价+选项加价
	        	bjcPd.put("SJ_FB_QT", hzPd.getString("SJ_FB_QT"));//实际-非标-其他*1.17
	        	bjcPd.put("SJ_FB_QT_YJ", hzPd.getString("SJ_FB_QT_YJ"));//实际-非标-其他*1.17-佣金*1.17
	        	
	        	bjcPd.put("offer_version", pd.getString("offer_version"));
	        	
	        	e_offerService.saveBjc(bjcPd);
	        	mv.addObject("bjc_id", bjc_id);
    		}
        	PageData srPd = new PageData();
        	srPd.put("c_", pd.getString("BZ_C"));
        	srPd.put("z_", pd.getString("BZ_Z"));
        	srPd.put("m_", pd.getString("BZ_M"));
        	srPd.put("zhsbj_", pd.getString("FEIYANGMRL_ZHSBJ"));
        	srPd.put("rowIndex", pd.getString("rowIndex"));
        	srPd.put("sbj_", pd.getString("XS_SBSJBJ"));//+
        	srPd.put("zk_", pd.getString("XS_ZKL"));//+
        	srPd.put("sjbj_", pd.getString("XS_TATOL"));//+
        	srPd.put("azf_", pd.getString("XS_AZJ"));//+
        	srPd.put("ysf_", pd.getString("XS_YSJ"));//+
        	srPd.put("yjze_", pd.getString("XS_YJZE"));//+
        	srPd.put("yjbl_", pd.getString("XS_YJBL"));//+
        	//调用汇总数据方法
        	PageData CountPd=setBjcHzJs(pd);
    		//根据报价编号查找报价表,如果存在即为编辑进来
        	pd.put("item_id", pd.getString("ITEM_ID"));
    		PageData offerdetail = e_offerService.findItemInOfferByItem(pd);
    		if (offerdetail!=null && !offerdetail.isEmpty()) {
    	   		//(new)编辑报价池后同步更新报价汇总
    			CountPd.put("offer_id", offerdetail.get("offer_id"));
        		e_offerService.updateOfferCount(CountPd);
        		e_offerService.updateTempOfferCount(CountPd);
//        		e_offerService.initDetails(CountPd);
			}
        	
        	mv.addObject("CountPd", CountPd);
        	mv.addObject("srPd", srPd);
        	mv.addObject("pd", pd);
        	mv.addObject("id", "ElevatorParam");
        	//重写编辑和删除的button
        	String editButtonStr = "<button class='btn  btn-primary btn-sm' title='编辑' onclick=\\\"toEdit(this,'"+feiyueId+"','"+modelsId+"','"+bjcId+"')\\\" type='button'>编辑</button>";
        	String deleteButtonStr = "<button class='btn  btn-danger btn-sm' title='删除' onclick=\\\"deleteRow(this,'"+elevIds+"')\\\" type='button'>删除</button>";
			String setButtonStr="<button class='btn btn-info btn-sm' title='梯号设置' style='margin-left:5px;' type='button'" +
					" onclick=\\\"setENoRow(this,'"+elevIds+"','"+bjcId+"')\\\">梯号设置</button>";
			mv.addObject("buttonStr", editButtonStr+deleteButtonStr+setButtonStr);
    		mv.setViewName("system/e_offer/save_result");
    	}catch(Exception e){
    		logger.error(e.getMessage());
    	}
    	return mv;
    }
    //保存 飞越_MRL
    @RequestMapping(value="saveFeiyueMRL")
    public ModelAndView saveFeiyueMRL(){
    	ModelAndView mv = new ModelAndView();
    	PageData pd = new PageData();
		pd = this.getPageData();
		//feishangId,modelsId,bjcId,elevIds新增/编辑页面关闭之后重新给报价池页面的button赋值
    	String feiyuemrlId = "";
    	String modelsId = "";
    	String bjcId = "";
    	String elevIds = "";
    	try{
    		if(pd.getString("view").equals("edit")){
    			feiyuemrlId = pd.getString("FEIYUEMRL_ID");
				modelsId = pd.getString("MODELS_ID");
				bjcId = pd.getString("BJC_ID");
				elevIds = pd.getString("ELEV_IDS");
				//调用获取电梯eno方法
    			String elevNo=elevNo(elevIds);
				
    			e_offerService.updateFeiyueMRL(pd);
    			
    			pd.put("BJ_DT_ID",feiyuemrlId);
	    		e_offerService.updateConventionalNonstandard(pd);
    			//关联更新报价池
	        	PageData bjcPd = new PageData();
	        	bjcPd.put("offer_version", pd.getString("offer_version"));
	        	bjcPd.put("BJC_ENO", elevNo);
	        	bjcPd.put("BJC_ID", pd.getString("BJC_ID"));
	        	bjcPd.put("BJC_COD_ID", pd.getString("FEIYUEMRL_ID"));
	        	bjcPd.put("BJC_ITEM_ID", pd.get("ITEM_ID").toString());
	        	bjcPd.put("BJC_ELEV", pd.get("ELEV_IDS").toString());
	        	bjcPd.put("BJC_MODELS", pd.get("MODELS_ID").toString());
	        	bjcPd.put("BJC_ZHSBJ", pd.get("FEIYUEMRL_ZHSBJ").toString());
	        	bjcPd.put("BJC_SL", pd.get("FEIYUEMRL_SL").toString());
	        	bjcPd.put("BJC_ZZ", pd.get("BZ_ZZ").toString());
	        	bjcPd.put("BJC_SD", pd.get("BZ_SD").toString());
	        	bjcPd.put("BJC_C", pd.get("BZ_C").toString());
	        	bjcPd.put("BJC_Z", pd.get("BZ_Z").toString());
	        	bjcPd.put("BJC_M", pd.get("BZ_M").toString());
	        	bjcPd.put("BJC_TSGD", pd.get("BASE_TSGD").toString());
	        	
	        	bjcPd.put("BJC_SBJ", pd.get("XS_SBSJBJ").toString());//设备实际报价
	        	bjcPd.put("BJC_ZK", pd.get("XS_ZKL").toString());//折扣
	        	bjcPd.put("SBSJZJ", pd.get("XS_SBSJBJ").toString());//设备实际总价
	        	bjcPd.put("YJZE", pd.get("XS_YJZE").toString());//佣金总额
	        	bjcPd.put("YJBL", pd.get("XS_YJBL").toString());//佣金比例
	        	bjcPd.put("BJC_AZF", pd.get("XS_AZJ").toString());//安装费
	        	bjcPd.put("BJC_YSF", pd.get("XS_YSJ").toString());//运输费
	        	bjcPd.put("BJC_SJBJ", pd.get("XS_TATOL").toString());//实际报价
	        	bjcPd.put("YJSYZKL", pd.get("YJSYZKL").toString());
	        	bjcPd.put("ZGYJ", pd.get("ZGYJ").toString());
	        	PageData hzPd=setHzBjc(pd);
	        	bjcPd.put("JJ_XXJJ", hzPd.getString("JJ_XXJJ"));//基价+选项加价
	        	bjcPd.put("SJ_FB_QT", hzPd.getString("SJ_FB_QT"));//实际-非标-其他*1.17
	        	bjcPd.put("SJ_FB_QT_YJ", hzPd.getString("SJ_FB_QT_YJ"));//实际-非标-其他*1.17-佣金*1.17
	        	e_offerService.updateBjc(bjcPd);
	        	mv.addObject("bjc_id", pd.getString("BJC_ID"));
    		}else{
	    		feiyuemrlId = this.get32UUID();
	    		pd.put("FEIYUEMRL_ID", feiyuemrlId);
	    		e_offerService.saveFeiyueMRL(pd);
	    		//关联更新电梯报价状态信息
	        	updateDetails(pd);
	        	
	        	pd.put("BJ_DT_ID",feiyuemrlId);
	    		e_offerService.saveConventionalNonstandard(pd);
	        	//关联保存报价池
	        	String bjc_id = this.get32UUID();
    			//button赋值部分
    			modelsId = pd.getString("MODELS_ID");
    			bjcId = bjc_id;
    			elevIds = pd.getString("ELEV_IDS");
    			//调用获取电梯eno方法
    			String elevNo=elevNo(elevIds);
    			
	        	PageData bjcPd = new PageData();
	        	bjcPd.put("BJC_ENO", elevNo);
	        	bjcPd.put("BJC_ID", bjc_id);
	        	bjcPd.put("BJC_COD_ID", feiyuemrlId);
	        	bjcPd.put("BJC_ITEM_ID", pd.get("ITEM_ID").toString());
	        	bjcPd.put("BJC_ELEV", pd.get("ELEV_IDS").toString());
	        	bjcPd.put("BJC_MODELS", pd.get("MODELS_ID").toString());
	        	bjcPd.put("BJC_ZHSBJ", pd.get("FEIYUEMRL_ZHSBJ").toString());
	        	bjcPd.put("BJC_SL", pd.get("FEIYUEMRL_SL").toString());
	        	bjcPd.put("BJC_ZZ", pd.get("BZ_ZZ").toString());
	        	bjcPd.put("BJC_SD", pd.get("BZ_SD").toString());
	        	bjcPd.put("BJC_C", pd.get("BZ_C").toString());
	        	bjcPd.put("BJC_Z", pd.get("BZ_Z").toString());
	        	bjcPd.put("BJC_M", pd.get("BZ_M").toString());
	        	bjcPd.put("BJC_TSGD", pd.get("BASE_TSGD").toString());
	        	bjcPd.put("item_id", pd.get("ITEM_ID").toString());
	        	bjcPd.put("bjc_id", bjc_id);
	        	bjcPd.put("BJC_SBJ", pd.get("XS_SBSJBJ").toString());//设备实际报价
	        	bjcPd.put("BJC_ZK", pd.get("XS_ZKL").toString());//折扣
	        	bjcPd.put("SBSJZJ", pd.get("XS_SBSJBJ").toString());//设备实际总价
	        	bjcPd.put("YJZE", pd.get("XS_YJZE").toString());//佣金总额
	        	bjcPd.put("YJBL", pd.get("XS_YJBL").toString());//佣金比例
	        	bjcPd.put("BJC_AZF", pd.get("XS_AZJ").toString());//安装费
	        	bjcPd.put("BJC_YSF", pd.get("XS_YSJ").toString());//运输费
	        	bjcPd.put("BJC_SJBJ", pd.get("XS_TATOL").toString());//实际报价
	        	bjcPd.put("YJSYZKL", pd.get("YJSYZKL").toString());
	        	bjcPd.put("ZGYJ", pd.get("ZGYJ").toString());
	        	PageData hzPd=setHzBjc(pd);
	        	bjcPd.put("JJ_XXJJ", hzPd.getString("JJ_XXJJ"));//基价+选项加价
	        	bjcPd.put("SJ_FB_QT", hzPd.getString("SJ_FB_QT"));//实际-非标-其他*1.17
	        	bjcPd.put("SJ_FB_QT_YJ", hzPd.getString("SJ_FB_QT_YJ"));//实际-非标-其他*1.17-佣金*1.17
	        	bjcPd.put("offer_version", pd.getString("offer_version"));
	        	
	        	e_offerService.saveBjc(bjcPd);
	        	mv.addObject("bjc_id", bjc_id);
    		}
        	PageData srPd = new PageData();
        	srPd.put("c_", pd.getString("BZ_C"));
        	srPd.put("z_", pd.getString("BZ_Z"));
        	srPd.put("m_", pd.getString("BZ_M"));
        	srPd.put("zhsbj_", pd.getString("FEIYANGMRL_ZHSBJ"));
        	srPd.put("rowIndex", pd.getString("rowIndex"));
        	srPd.put("sbj_", pd.getString("XS_SBSJBJ"));//+
        	srPd.put("zk_", pd.getString("XS_ZKL"));//+
        	srPd.put("sjbj_", pd.getString("XS_TATOL"));//+
        	srPd.put("azf_", pd.getString("XS_AZJ"));//+
        	srPd.put("ysf_", pd.getString("XS_YSJ"));//+
        	srPd.put("yjze_", pd.getString("XS_YJZE"));//+
        	srPd.put("yjbl_", pd.getString("XS_YJBL"));//+
        	//调用汇总数据方法
        	PageData CountPd=setBjcHzJs(pd);
    		//根据报价编号查找报价表,如果存在即为编辑进来
        	pd.put("item_id", pd.getString("ITEM_ID"));
    		PageData offerdetail = e_offerService.findItemInOfferByItem(pd);
    		if (offerdetail!=null && !offerdetail.isEmpty()) {
    	   		//(new)编辑报价池后同步更新报价汇总
    			CountPd.put("offer_id", offerdetail.get("offer_id"));
        		e_offerService.updateOfferCount(CountPd);
        		e_offerService.updateTempOfferCount(CountPd);
//        		e_offerService.initDetails(CountPd);
			}
        	mv.addObject("CountPd", CountPd);
        	mv.addObject("srPd", srPd);
        	mv.addObject("pd", pd);
        	mv.addObject("id", "ElevatorParam");
        	//重写编辑和删除的button
        	String editButtonStr = "<button class='btn  btn-primary btn-sm' title='编辑' onclick=\\\"toEdit(this,'"+feiyuemrlId+"','"+modelsId+"','"+bjcId+"')\\\" type='button'>编辑</button>";
        	String deleteButtonStr = "<button class='btn  btn-danger btn-sm' title='删除' onclick=\\\"deleteRow(this,'"+elevIds+"')\\\" type='button'>删除</button>";
			String setButtonStr="<button class='btn btn-info btn-sm' title='梯号设置' style='margin-left:5px;' type='button'" +
					" onclick=\\\"setENoRow(this,'"+elevIds+"','"+bjcId+"')\\\">梯号设置</button>";
			mv.addObject("buttonStr", editButtonStr+deleteButtonStr+setButtonStr);
    		mv.setViewName("system/e_offer/save_result");
    	}catch(Exception e){
    		logger.error(e.getMessage());
    	}
    	return mv;
    }
    
    //保存新增 飞扬消防梯
    @RequestMapping(value="saveFeiyangXF")
    public ModelAndView saveFeiyangXF(){
    	ModelAndView mv = new ModelAndView();
    	PageData pd = new PageData();
		pd = this.getPageData();
		//feishangId,modelsId,bjcId,elevIds新增/编辑页面关闭之后重新给报价池页面的button赋值
    	String feiyangxfId = "";
    	String modelsId = "";
    	String bjcId = "";
    	String elevIds = "";
    	try{
    		if(pd.getString("view").equals("edit")){
    			feiyangxfId = pd.getString("FEIYANGXF_ID");
    			modelsId = pd.getString("MODELS_ID");
    			bjcId = pd.getString("BJC_ID");
    			elevIds = pd.getString("ELEV_IDS");
    			//调用获取电梯eno方法
    			String elevNo=elevNo(elevIds);
    			//编辑飞尚
    			e_offerService.updateFeiyangXF(pd);
    			
    			pd.put("BJ_DT_ID",feiyangxfId);
	    		e_offerService.updateConventionalNonstandard(pd);
    			//关联更新报价池信息
    			PageData bjcPd = new PageData();
    			bjcPd.put("offer_version", pd.getString("offer_version"));
    			bjcPd.put("BJC_ENO", elevNo);
	        	bjcPd.put("BJC_ID", pd.getString("BJC_ID"));
	        	bjcPd.put("BJC_COD_ID", pd.getString("FEIYANGXF_ID"));
	        	bjcPd.put("BJC_ITEM_ID", pd.get("ITEM_ID").toString());
	        	bjcPd.put("BJC_ELEV", pd.get("ELEV_IDS").toString());
	        	bjcPd.put("BJC_MODELS", pd.get("MODELS_ID").toString());
	        	bjcPd.put("BJC_ZHJ", pd.get("FEIYANGXF_ZHJ").toString());
	        	bjcPd.put("BJC_ZHSBJ", pd.get("FEIYANGXF_ZHSBJ").toString());
	        	bjcPd.put("BJC_SJBJ", pd.get("FEIYANGXF_SJBJ").toString());
	        	bjcPd.put("BJC_SL", pd.get("FEIYANGXF_SL").toString());
	        	bjcPd.put("BJC_ZZ", pd.get("BZ_ZZ").toString());
	        	bjcPd.put("BJC_SD", pd.get("BZ_SD").toString());
	        	bjcPd.put("BJC_C", pd.get("BZ_C").toString());
	        	bjcPd.put("BJC_Z", pd.get("BZ_Z").toString());
	        	bjcPd.put("BJC_M", pd.get("BZ_M").toString());
	        	bjcPd.put("BJC_TSGD", pd.get("BASE_TSGD").toString());
	        	bjcPd.put("BJC_SBJ", pd.get("FEIYANG_XF_SBSJBJ").toString());//设备实际报价
	        	bjcPd.put("BJC_ZK", pd.get("FEIYANG_XF_ZKL").toString());//折扣
	        	bjcPd.put("SBSJZJ", pd.get("FEIYANG_XF_SBSJBJ").toString());//设备实际总价
	        	bjcPd.put("YJZE", pd.get("FEIYANG_XF_YJZE").toString());//佣金总额
	        	bjcPd.put("YJBL", pd.get("FEIYANG_XF_YJBL").toString());//佣金比例
	        	bjcPd.put("BJC_AZF", pd.get("FEIYANG_XF_AZJ").toString());//安装费
	        	bjcPd.put("BJC_YSF", pd.get("FEIYANG_XF_YSJ").toString());//运输费
	        	bjcPd.put("BJC_SJBJ", pd.get("FEIYANG_XF_TATOL").toString());//实际报价
	        	bjcPd.put("YJSYZKL", pd.get("YJSYZKL").toString());
	        	bjcPd.put("ZGYJ", pd.get("ZGYJ").toString());
	        	//↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
	        	int jj=Integer.parseInt(pd.getString("SBJ_TEMP"));//基价
	        	int xxjj=Integer.parseInt(pd.getString("FEIYANG_XF_XXJJ"));//选项加价
	        	int fbj=0;
	        	if(pd.getString("FEIYANG_XF_FBJ")!=null && !"".equals(pd.getString("FEIYANG_XF_FBJ")))
	        	{
	        		fbj=Integer.parseInt(pd.getString("FEIYANG_XF_FBJ"));//非标价
	        	}
	        	
	        	PageData pdSl=new PageData();
	        	pdSl.put("id","1");
	        	try {
	        		pdSl= e_offerService.getShuiLv(pdSl);
	    		} catch (Exception e) {
	    			// TODO 自动生成的 catch 块
	    			e.printStackTrace();
	    		}
	        	double ShuiLv=Double.parseDouble(pdSl.getString("content"));
	        	
	        	int qtfy=Integer.parseInt(pd.getString("FEIYANG_XF_QTFY"));//其他费用
	        	int yjze=Integer.parseInt(pd.getString("FEIYANG_XF_YJZE"));//佣金总额
	        	int sjbj=Integer.parseInt(pd.getString("FEIYANG_XF_SBSJBJ"));//实际报价
	        	int jj_xxjj=jj+xxjj;
	        	int yjzkl=(int) (sjbj-fbj-qtfy*ShuiLv);
	        	int zkl=(int) (sjbj-fbj-qtfy*ShuiLv-yjze*ShuiLv);
	        	//↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑
	        	bjcPd.put("JJ_XXJJ", String.valueOf(jj_xxjj));//基价+选项加价
	        	bjcPd.put("SJ_FB_QT", String.valueOf(yjzkl));//实际-非标-其他*1.17
	        	bjcPd.put("SJ_FB_QT_YJ",String.valueOf(zkl));//实际-非标-其他*1.17-佣金*1.17
	        	
	        	e_offerService.updateBjc(bjcPd);
	        	mv.addObject("bjc_id", pd.getString("BJC_ID"));
    		}else{
	    		feiyangxfId = this.get32UUID();
	    		pd.put("FEIYANGXF_ID", feiyangxfId);
	    		e_offerService.saveFeiyangXF(pd);
	    		
	    		pd.put("BJ_DT_ID",feiyangxfId);
	    		e_offerService.saveConventionalNonstandard(pd);
	    		//关联更新电梯报价状态信息
	        	updateDetails(pd);
	        	//关联保存报价池
	        	String bjc_id = this.get32UUID();
    			//button赋值部分
    			modelsId = pd.getString("MODELS_ID");
    			bjcId = bjc_id;
    			elevIds = pd.getString("ELEV_IDS");
    			//调用获取电梯eno方法
    			String elevNo=elevNo(elevIds);
    			
	        	PageData bjcPd = new PageData();
	        	bjcPd.put("BJC_ENO", elevNo);
	        	bjcPd.put("BJC_ID", bjc_id);
	        	bjcPd.put("BJC_COD_ID", feiyangxfId);
	        	bjcPd.put("BJC_ITEM_ID", pd.get("ITEM_ID").toString());
	        	bjcPd.put("BJC_ELEV", pd.get("ELEV_IDS").toString());
	        	bjcPd.put("BJC_MODELS", pd.get("MODELS_ID").toString());
	        	bjcPd.put("BJC_ZHJ", pd.get("FEIYANGXF_ZHJ").toString());
	        	bjcPd.put("BJC_ZHSBJ", pd.get("FEIYANGXF_ZHSBJ").toString());
	        	bjcPd.put("BJC_SL", pd.get("FEIYANGXF_SL").toString());
	        	bjcPd.put("BJC_ZZ", pd.get("BZ_ZZ").toString());
	        	bjcPd.put("BJC_SD", pd.get("BZ_SD").toString());
	        	bjcPd.put("BJC_C", pd.get("BZ_C").toString());
	        	bjcPd.put("BJC_Z", pd.get("BZ_Z").toString());
	        	bjcPd.put("BJC_M", pd.get("BZ_M").toString());
	        	bjcPd.put("BJC_TSGD", pd.get("BASE_TSGD").toString());
	        	bjcPd.put("bjc_id", bjc_id);
	        	bjcPd.put("item_id", pd.get("ITEM_ID").toString());
	        	bjcPd.put("BJC_SBJ", pd.get("FEIYANG_XF_SBSJBJ").toString());//设备实际报价
	        	bjcPd.put("BJC_ZK", pd.get("FEIYANG_XF_ZKL").toString());//折扣
	        	bjcPd.put("SBSJZJ", pd.get("FEIYANG_XF_SBSJBJ").toString());//设备实际总价
	        	bjcPd.put("YJZE", pd.get("FEIYANG_XF_YJZE").toString());//佣金总额
	        	bjcPd.put("YJBL", pd.get("FEIYANG_XF_YJBL").toString());//佣金比例
	        	bjcPd.put("BJC_AZF", pd.get("FEIYANG_XF_AZJ").toString());//安装费
	        	bjcPd.put("BJC_YSF", pd.get("FEIYANG_XF_YSJ").toString());//运输费
	        	bjcPd.put("BJC_SJBJ", pd.get("FEIYANG_XF_TATOL").toString());//实际报价
	        	bjcPd.put("YJSYZKL", pd.get("YJSYZKL").toString());
	        	bjcPd.put("ZGYJ", pd.get("ZGYJ").toString());
	        	//↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
	        	int jj=Integer.parseInt(pd.getString("SBJ_TEMP"));//基价
	        	int xxjj=Integer.parseInt(pd.getString("FEIYANG_XF_XXJJ"));//选项加价
	        	int fbj=0;
	        	if(pd.getString("FEIYANG_XF_FBJ")!=null && !"".equals(pd.getString("FEIYANG_XF_FBJ")))
	        	{
	        		fbj=Integer.parseInt(pd.getString("FEIYANG_XF_FBJ"));//非标价
	        	}
	        	
	        	PageData pdSl=new PageData();
	        	pdSl.put("id","1");
	        	try {
	        		pdSl= e_offerService.getShuiLv(pdSl);
	    		} catch (Exception e) {
	    			// TODO 自动生成的 catch 块
	    			e.printStackTrace();
	    		}
	        	double ShuiLv=Double.parseDouble(pdSl.getString("content"));
	        	
	        	int qtfy=Integer.parseInt(pd.getString("FEIYANG_XF_QTFY"));//其他费用
	        	int yjze=Integer.parseInt(pd.getString("FEIYANG_XF_YJZE"));//佣金总额
	        	int sjbj=Integer.parseInt(pd.getString("FEIYANG_XF_SBSJBJ"));//实际报价
	        	int jj_xxjj=jj+xxjj;
	        	int yjzkl=(int) (sjbj-fbj-qtfy*ShuiLv);
	        	int zkl=(int) (sjbj-fbj-qtfy*ShuiLv-yjze*ShuiLv);
	        	//↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑
	        	bjcPd.put("JJ_XXJJ", jj_xxjj);//基价+选项加价
	        	bjcPd.put("SJ_FB_QT", yjzkl);//实际-非标-其他*税率
	        	bjcPd.put("SJ_FB_QT_YJ",zkl);//实际-非标-其他*税率-佣金*税率
	        	bjcPd.put("offer_version", pd.getString("offer_version"));
	        	
	        	
	        	e_offerService.saveBjc(bjcPd);
	        	mv.addObject("bjc_id", bjc_id);
    		}
        	PageData srPd = new PageData();
        	srPd.put("c_", pd.getString("BZ_C"));
        	srPd.put("z_", pd.getString("BZ_Z"));
        	srPd.put("m_", pd.getString("BZ_M"));
        	srPd.put("sbj_", pd.getString("FEIYANG_XF_SBSJBJ"));//+
        	srPd.put("zk_", pd.getString("FEIYANG_XF_ZKL"));//+
        	srPd.put("zhsbj_", pd.getString("FEIYANGXF_ZHSBJ"));
        	srPd.put("sjbj_", pd.getString("FEIYANG_XF_TATOL"));//+
        	srPd.put("rowIndex", pd.getString("rowIndex"));
        	srPd.put("azf_", pd.getString("FEIYANG_XF_AZJ"));
        	srPd.put("ysf_", pd.getString("FEIYANG_XF_YSJ"));
        	srPd.put("yjze_", pd.getString("FEIYANG_XF_YJZE"));
        	srPd.put("yjbl_", pd.getString("FEIYANG_XF_YJBL"));
        	//调用汇总数据方法
        	PageData CountPd=setBjcHzJs(pd);
        	mv.addObject("CountPd", CountPd);
        	mv.addObject("srPd", srPd);
        	mv.addObject("pd", pd);
        	mv.addObject("id", "ElevatorParam");
        	//重写编辑和删除的button
        	String editButtonStr = "<button class='btn  btn-primary btn-sm' title='编辑' onclick=\\\"toEdit(this,'"+feiyangxfId+"','"+modelsId+"','"+bjcId+"')\\\" type='button'>编辑</button>";
        	String deleteButtonStr = "<button class='btn  btn-danger btn-sm' title='删除' onclick=\\\"deleteRow(this,'"+elevIds+"')\\\" type='button'>删除</button>";
			String setButtonStr="<button class='btn btn-info btn-sm' title='梯号设置' style='margin-left:5px;' type='button'" +
					" onclick=\\\"setENoRow(this,'"+elevIds+"','"+bjcId+"')\\\">梯号设置</button>";
			mv.addObject("buttonStr", editButtonStr+deleteButtonStr+setButtonStr);
    		mv.setViewName("system/e_offer/save_result");
    	}catch(Exception e){
    		logger.error(e.getMessage());
    	}
    	return mv;
    }
    
    //报价池汇总需要的数据
    public PageData setHzBjc(PageData hzPd)
    {
    	int jj=0;
    	if(hzPd.getString("SBJ_TEMP")!=null && !"".equals(hzPd.getString("SBJ_TEMP")))
    	{
    		jj=Integer.parseInt(hzPd.getString("SBJ_TEMP"));//基价
    	}
    	int xxjj=0;
    	if(hzPd.getString("XS_XXJJ")!=null && !"".equals(hzPd.getString("XS_XXJJ")))
    	{
    		xxjj=Integer.parseInt(hzPd.getString("XS_XXJJ"));//选项加价
    	}
    	int fbj=0;
    	if(hzPd.getString("XS_FBJ")!=null && !"".equals(hzPd.getString("XS_FBJ")))
    	{
    		fbj=Integer.parseInt(hzPd.getString("XS_FBJ"));//非标价
    	}
    	int qtfy=0;
    	if(hzPd.getString("XS_QTFY")!=null && !"".equals(hzPd.getString("XS_QTFY")))
    	{
    		qtfy=Integer.parseInt(hzPd.getString("XS_QTFY"));//其他费用
    	}
    	int yjze=0;
    	if(hzPd.getString("XS_YJZE")!=null && !"".equals(hzPd.getString("XS_YJZE")))
    	{
    		yjze=Integer.parseInt(hzPd.getString("XS_YJZE"));//佣金总额
    	}
    	int sjbj=0;
    	if(hzPd.getString("XS_SBSJBJ")!=null && !"".equals(hzPd.getString("XS_SBSJBJ")))
    	{
    		sjbj=Integer.parseInt(hzPd.getString("XS_SBSJBJ"));//佣金总额
    	}
    	PageData pd=new PageData();
    	pd.put("id","1");
    	try {
			pd= e_offerService.getShuiLv(pd);
		} catch (Exception e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
    	double ShuiLv=Double.parseDouble(pd.getString("content"));
    	int jj_xxjj=jj+xxjj;
    	int yjzkl=(int) (sjbj-fbj-qtfy*ShuiLv);
    	int zkl=(int) (sjbj-fbj-qtfy*ShuiLv-yjze*ShuiLv);
    	hzPd.put("JJ_XXJJ", String.valueOf(jj_xxjj));//基价+选项加价
    	hzPd.put("SJ_FB_QT", String.valueOf(yjzkl));//实际-非标-其他*税率
    	hzPd.put("SJ_FB_QT_YJ", String.valueOf(zkl));//实际-非标-其他*税率-佣金*税率
		return hzPd;
    	
    }
    
    //报价池 汇总计算 
    public PageData setBjcHzJs(PageData hzjsPd)
    {
    	PageData pd=new PageData();
    	try {
    		
    		pd.put("item_id", hzjsPd.getString("ITEM_ID"));
    		pd.put("offer_version", hzjsPd.getString("offer_version"));
			List<PageData> bjcList=e_offerService.getBjs(pd);
			BigDecimal a=new BigDecimal(0);
			BigDecimal b=new BigDecimal(0);
			BigDecimal c=new BigDecimal(0);
			BigDecimal d=new BigDecimal(0);
			BigDecimal e=new BigDecimal(0);
			BigDecimal f=new BigDecimal(0);
			BigDecimal g=new BigDecimal(0);
			BigDecimal h=new BigDecimal(0);
			BigDecimal j=new BigDecimal(0);
			for(PageData bjc : bjcList){
				if(bjc.getString("BJC_SL")!=null && !"".equals(bjc.getString("BJC_SL")))
				{
					a= a.add(new BigDecimal(bjc.getString("BJC_SL"))); //数量
				}
				if(bjc.getString("SBSJZJ")!=null && !"".equals(bjc.getString("SBSJZJ")))
				{
					b=b.add(new BigDecimal(bjc.getString("SBSJZJ"))); //设备实际总价
				}
				if(bjc.getString("YJZE")!=null && !"".equals(bjc.getString("YJZE")))
				{
					c = c.add(new BigDecimal(bjc.getString("YJZE")));   //佣金总额
				}
				if(bjc.getString("BJC_AZF")!=null && !"".equals(bjc.getString("BJC_AZF")))
				{
					d = d.add(new BigDecimal(bjc.getString("BJC_AZF")));//安装费
				}
				if(bjc.getString("BJC_YSF")!=null && !"".equals(bjc.getString("BJC_YSF")))
				{
					e = e.add(new BigDecimal(bjc.getString("BJC_YSF")));//运输费
				}
				if(bjc.getString("BJC_SJBJ")!=null && !"".equals(bjc.getString("BJC_SJBJ")))
				{
					f = f.add(new BigDecimal(bjc.getString("BJC_SJBJ")));//总价
				}
				if(bjc.getString("JJ_XXJJ")!=null && !"".equals(bjc.getString("JJ_XXJJ")))
				{
					g = g.add(new BigDecimal(bjc.getString("JJ_XXJJ")));//基价+选项加价
				}
				if(bjc.getString("SJ_FB_QT")!=null && !"".equals(bjc.getString("SJ_FB_QT")))
				{
					h = h.add(new BigDecimal(bjc.getString("SJ_FB_QT")));//实际-非标-其他*税率
				}
				if(bjc.getString("SJ_FB_QT_YJ")!=null && !"".equals(bjc.getString("SJ_FB_QT_YJ")))
				{
					j =j.add(new BigDecimal(bjc.getString("SJ_FB_QT_YJ"))); //实际-非标-其他*税率-佣金*税率
				}
          	}
			pd.put("id","1");
			pd= e_offerService.getShuiLv(pd);
			double ShuiLv=Double.parseDouble(pd.getString("content"));
			
			DecimalFormat df = new DecimalFormat("0.000");//格式化小数    
		
			if(bjcList.size()>0)
			{
				pd.put("COUNT_SL", a);
				pd.put("COUNT_SJZJ", b);
				double count_zk = 0;
				try {
					count_zk = ((j.divide(g,8,BigDecimal.ROUND_HALF_UP)).multiply(new BigDecimal(100))).setScale(1,BigDecimal.ROUND_HALF_UP).doubleValue();
				} catch (Exception e1) {
					e1.printStackTrace();
				}
				pd.put("COUNT_ZK", count_zk);
//				String count_zk=df.format((float)j/g);
//				pd.put("COUNT_ZK", Double.parseDouble(count_zk));
				pd.put("COUNT_YJ", c);
				double count_bl= ((c.divide(b.divide(new BigDecimal(ShuiLv),8,BigDecimal.ROUND_HALF_UP),8,BigDecimal.ROUND_HALF_UP)).multiply(new BigDecimal(100))).setScale(1,BigDecimal.ROUND_HALF_UP).doubleValue();
				pd.put("COUNT_BL", count_bl);
//				String count_bl=df.format((float)c/(b/ShuiLv));
//				pd.put("COUNT_BL", Double.parseDouble(count_bl));
				pd.put("COUNT_AZF", d);
				pd.put("COUNT_YSF", e);
				pd.put("COUNT_TATOL", f);
			}else{
				pd.put("COUNT_SL", "0");
				pd.put("COUNT_SJZJ", "0");
				pd.put("COUNT_ZK", "0");
				pd.put("COUNT_YJ", "0");
				pd.put("COUNT_BL", "0");
				pd.put("COUNT_AZF", "0");
				pd.put("COUNT_YSF", "0");
				pd.put("COUNT_TATOL", "0");
			}
			
		} catch (Exception e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		return pd;
    	
    }
    
    
    /**
     * 关联更新电梯状态 
     */
    public void updateDetails(PageData pd){
    	try{
    		String eIds = pd.getString("ELEV_IDS");
    		List<String> eIdList = Arrays.asList(eIds.split(","));
    		PageData updPd = new PageData();
    		updPd.put("list", eIdList);
    		e_offerService.updateTempDetails(updPd);
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
    	}
    }
    //保存 飞尚曳引货梯
    @RequestMapping(value="saveFeishang")
    public ModelAndView saveFeishang(){
    	ModelAndView mv = new ModelAndView();
    	PageData pd = new PageData();
    	pd = this.getPageData();
    	//超出高度价格加入到实际报价
    	/*Double SJBJ = Double.parseDouble(pd.get("FEISHANG_SBSJBJ").toString());
    	Double CCJG = Double.parseDouble(pd.getString("BASE_CCJG"));
    	pd.put("FEISHANG_SBSJBJ", SJBJ+CCJG);*/
    	//feishangId,modelsId,bjcId,elevIds新增/编辑页面关闭之后重新给报价池页面的button赋值
    	String feishangId = "";
    	String modelsId = "";
    	String bjcId = "";
    	String elevIds = "";
    	try{
    		if(pd.getString("view").equals("edit")){
    			feishangId = pd.getString("FEISHANG_ID");
    			modelsId = pd.getString("MODELS_ID");
    			bjcId = pd.getString("BJC_ID");
    			elevIds = pd.getString("ELEV_IDS");
    			//调用获取电梯eno方法
    			String elevNo=elevNo(elevIds);
    			//编辑飞尚
    			e_offerService.updateFeishang(pd);
    			
    			pd.put("BJ_DT_ID",feishangId);
	    		e_offerService.updateConventionalNonstandard(pd);
    			//关联更新报价池信息
    			PageData bjcPd = new PageData();
    			bjcPd.put("BJC_ENO", elevNo);
    			bjcPd.put("offer_version", pd.getString("offer_version"));
	        	bjcPd.put("BJC_ID", pd.getString("BJC_ID"));
	        	bjcPd.put("BJC_COD_ID", pd.getString("FEISHANG_ID"));
	        	bjcPd.put("BJC_ITEM_ID", pd.get("ITEM_ID").toString());
	        	bjcPd.put("BJC_ELEV", pd.get("ELEV_IDS").toString());
	        	bjcPd.put("BJC_MODELS", pd.get("MODELS_ID").toString());
	        	bjcPd.put("BJC_ZHJ", pd.get("FEISHANG_ZHJ").toString());
	        	bjcPd.put("BJC_SBJ", pd.get("FEISHANG_SBSJBJ").toString());
	        	bjcPd.put("SBSJZJ", pd.get("FEISHANG_SBSJBJ").toString());
	        	bjcPd.put("BJC_ZK", pd.get("FEISHANG_ZKL").toString());
	        	bjcPd.put("YJZE", pd.get("FEISHANG_YJZE").toString());
	        	bjcPd.put("YJBL", pd.get("FEISHANG_YJBL").toString());
	        	bjcPd.put("BJC_AZF", pd.get("FEISHANG_AZJ").toString());
	        	bjcPd.put("BJC_YSF", pd.get("FEISHANG_YSJ").toString());
	        	bjcPd.put("BJC_SJBJ", pd.get("FEISHANG_TATOL").toString());
	        	bjcPd.put("BJC_SL", pd.get("FEISHANG_SL").toString());
	        	bjcPd.put("BJC_ZZ", pd.get("BZ_ZZ").toString());
	        	bjcPd.put("BJC_SD", pd.get("BZ_SD").toString());
	        	bjcPd.put("BJC_C", pd.get("BZ_C").toString());
	        	bjcPd.put("BJC_Z", pd.get("BZ_Z").toString());
	        	bjcPd.put("BJC_M", pd.get("BZ_M").toString());
	        	bjcPd.put("BJC_TSGD", pd.get("BASE_TSGD").toString());
	        	//↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
	        	int jj=Integer.parseInt(pd.getString("SBJ_TEMP"));//基价
	        	int xxjj=Integer.parseInt(pd.getString("FEISHANG_XXJJ"));//选项加价
	        	int fbj=0;
	        	if(pd.getString("FEISHANG_FBJ")!=null && !"".equals(pd.getString("FEISHANG_FBJ")))
	        	{
	        		fbj=Integer.parseInt(pd.getString("FEISHANG_FBJ"));//非标价
	        	}
	        	
	        	PageData pdSl=new PageData();
	        	pdSl.put("id","1");
	        	try {
	        		pdSl= e_offerService.getShuiLv(pdSl);
	    		} catch (Exception e) {
	    			// TODO 自动生成的 catch 块
	    			e.printStackTrace();
	    		}
	        	double ShuiLv=Double.parseDouble(pdSl.getString("content"));
	        	
	        	int qtfy=Integer.parseInt(pd.getString("FEISHANG_QTFY"));//其他费用
	        	int yjze=Integer.parseInt(pd.getString("FEISHANG_YJZE"));//佣金总额
	        	int sjbj=Integer.parseInt(pd.getString("FEISHANG_SBSJBJ"));//实际报价
	        	bjcPd.put("YJSYZKL", pd.get("YJSYZKL").toString());
	        	bjcPd.put("ZGYJ", pd.get("ZGYJ").toString());
	        	int jj_xxjj=jj+xxjj;
	        	int yjzkl=(int) (sjbj-fbj-qtfy*ShuiLv);
	        	int zkl=(int) (sjbj-fbj-qtfy*ShuiLv-yjze*ShuiLv);
	        	//↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑
	        	bjcPd.put("JJ_XXJJ", String.valueOf(jj_xxjj));//基价+选项加价
	        	bjcPd.put("SJ_FB_QT", String.valueOf(yjzkl));//实际-非标-其他*1.17
	        	bjcPd.put("SJ_FB_QT_YJ",String.valueOf(zkl));//实际-非标-其他*1.17-佣金*1.17
	        	e_offerService.updateBjc(bjcPd);
	        	mv.addObject("bjc_id", pd.getString("BJC_ID"));
    		}else{
    			//新增飞尚
	    		feishangId = this.get32UUID();
	    		pd.put("FEISHANG_ID", feishangId);
	        	e_offerService.saveFeishang(pd);
	        	
	        	pd.put("BJ_DT_ID",feishangId);
	    		e_offerService.saveConventionalNonstandard(pd);
	        	//关联更新电梯报价状态信息
	        	updateDetails(pd);
	        	//关联保存报价池
	        	String bjc_id = this.get32UUID();
	        	//button赋值部分
    			modelsId = pd.getString("MODELS_ID");
    			bjcId = bjc_id;
    			elevIds = pd.getString("ELEV_IDS");
    			//调用获取电梯eno方法
    			String elevNo=elevNo(elevIds);
    			
	        	PageData bjcPd = new PageData();
	        	bjcPd.put("BJC_ENO", elevNo);
	        	bjcPd.put("BJC_ID", bjc_id);
	        	bjcPd.put("BJC_COD_ID", feishangId);
	        	bjcPd.put("BJC_ITEM_ID", pd.get("ITEM_ID").toString());
	        	bjcPd.put("item_id", pd.get("ITEM_ID").toString());
	        	bjcPd.put("bjc_id", bjc_id);
	        	bjcPd.put("BJC_ELEV", pd.get("ELEV_IDS").toString());
	        	bjcPd.put("BJC_MODELS", pd.get("MODELS_ID").toString());
	        	bjcPd.put("BJC_ZHJ", pd.get("FEISHANG_ZHJ").toString());//装潢价
	        	bjcPd.put("BJC_SBJ", pd.get("FEISHANG_SBSJBJ").toString());//设备实际报价
	        	bjcPd.put("BJC_ZK", pd.get("FEISHANG_ZKL").toString());//折扣
	        	bjcPd.put("BJC_ZHSBJ", pd.get("FEISHANG_ZHSBJ").toString());//折后设备价
	        	bjcPd.put("BJC_AZF", pd.get("FEISHANG_AZJ").toString());
	        	bjcPd.put("BJC_YSF", pd.get("FEISHANG_YSJ").toString());
	        	bjcPd.put("BJC_SJBJ", pd.get("FEISHANG_TATOL").toString());//实际报价
	        	bjcPd.put("BJC_SL", pd.get("FEISHANG_SL").toString());
	        	bjcPd.put("BJC_ZZ", pd.get("BZ_ZZ").toString());
	        	bjcPd.put("BJC_SD", pd.get("BZ_SD").toString());
	        	bjcPd.put("BJC_C", pd.get("BZ_C").toString());
	        	bjcPd.put("BJC_Z", pd.get("BZ_Z").toString());
	        	bjcPd.put("BJC_M", pd.get("BZ_M").toString());
	        	bjcPd.put("BJC_TSGD", pd.get("BASE_TSGD").toString());
	        	bjcPd.put("SBSJZJ", pd.get("FEISHANG_SBSJBJ").toString());//设备实际总价
	        	bjcPd.put("YJZE", pd.get("FEISHANG_YJZE").toString());//佣金总额
	        	bjcPd.put("YJBL", pd.get("FEISHANG_YJBL").toString());//佣金比例
	        	//↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
	        	int jj=Integer.parseInt(pd.getString("SBJ_TEMP"));//基价
	        	int xxjj=Integer.parseInt(pd.getString("FEISHANG_XXJJ"));//选项加价
	        	int fbj=0;
	        	if(pd.getString("FEISHANG_FBJ")!=null && !"".equals(pd.getString("FEISHANG_FBJ")))
	        	{
	        		fbj=Integer.parseInt(pd.getString("FEISHANG_FBJ"));//非标价
	        	}
	        	
	        	PageData pdSl=new PageData();
	        	pdSl.put("id","1");
	        	try {
	        		pdSl= e_offerService.getShuiLv(pdSl);
	    		} catch (Exception e) {
	    			// TODO 自动生成的 catch 块
	    			e.printStackTrace();
	    		}
	        	double ShuiLv=Double.parseDouble(pdSl.getString("content"));
	        	
	        	int qtfy=Integer.parseInt(pd.getString("FEISHANG_QTFY"));//其他费用
	        	int yjze=Integer.parseInt(pd.getString("FEISHANG_YJZE"));//佣金总额
	        	int sjbj=Integer.parseInt(pd.getString("FEISHANG_SBSJBJ"));//实际报价
	        	bjcPd.put("YJSYZKL", pd.get("YJSYZKL").toString());
	        	bjcPd.put("ZGYJ", pd.get("ZGYJ").toString());
	        	int jj_xxjj=jj+xxjj;
	        	int yjzkl=(int) (sjbj-fbj-qtfy*ShuiLv);
	        	int zkl=(int) (sjbj-fbj-qtfy*ShuiLv-yjze*ShuiLv);
	        	//↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑
	        	bjcPd.put("JJ_XXJJ", String.valueOf(jj_xxjj));//基价+选项加价
	        	bjcPd.put("SJ_FB_QT", String.valueOf(yjzkl));//实际-非标-其他*1.17
	        	bjcPd.put("SJ_FB_QT_YJ",String.valueOf(zkl));//实际-非标-其他*1.17-佣金*1.17
	        	bjcPd.put("offer_version", pd.getString("offer_version"));
	        	
	        	e_offerService.saveBjc(bjcPd);
	        	mv.addObject("bjc_id", bjc_id);
    		}
    		PageData srPd = new PageData();//save_result.jsp
        	srPd.put("c_", pd.getString("BZ_C"));
        	srPd.put("z_", pd.getString("BZ_Z"));
        	srPd.put("m_", pd.getString("BZ_M"));
        	srPd.put("sbj_", pd.getString("FEISHANG_SBSJBJ"));
        	srPd.put("zk_", pd.getString("FEISHANG_ZKL"));
        	srPd.put("zhsbj_", pd.getString("FEISHANG_ZHSBJ"));
        	srPd.put("sjbj_", pd.getString("FEISHANG_TATOL"));
        	srPd.put("azf_", pd.getString("FEISHANG_AZJ"));
        	srPd.put("ysf_", pd.getString("FEISHANG_YSJ"));
        	srPd.put("yjze_", pd.getString("FEISHANG_YJZE"));
        	srPd.put("yjbl_", pd.getString("FEISHANG_YJBL"));
        	srPd.put("rowIndex", pd.getString("rowIndex"));
        	//调用汇总数据方法
        	PageData CountPd=setBjcHzJs(pd);
    		//根据报价编号查找报价表,如果存在即为编辑进来
        	pd.put("item_id", pd.getString("ITEM_ID"));
    		PageData offerdetail = e_offerService.findItemInOfferByItem(pd);
    		if (offerdetail!=null && !offerdetail.isEmpty()) {
    	   		//(new)编辑报价池后同步更新报价汇总
    			CountPd.put("offer_id", offerdetail.get("offer_id"));
        		e_offerService.updateOfferCount(CountPd);
        		e_offerService.updateTempOfferCount(CountPd);
//        		e_offerService.initDetails(CountPd);
			}
        	mv.addObject("CountPd", CountPd);
        	mv.addObject("srPd", srPd);
        	mv.addObject("pd", pd);
        	mv.addObject("id", "ElevatorParam");
        	//重写编辑和删除的button
        	String editButtonStr = "<button class='btn  btn-primary btn-sm' title='编辑' onclick=\\\"toEdit(this,'"+feishangId+"','"+modelsId+"','"+bjcId+"')\\\" type='button'>编辑</button>";
        	String deleteButtonStr = "<button class='btn  btn-danger btn-sm' title='删除' onclick=\\\"deleteRow(this,'"+elevIds+"')\\\" type='button'>删除</button>";
			String setButtonStr="<button class='btn btn-info btn-sm' title='梯号设置' style='margin-left:5px;' type='button'" +
					" onclick=\\\"setENoRow(this,'"+elevIds+"','"+bjcId+"')\\\">梯号设置</button>";
			mv.addObject("buttonStr", editButtonStr+deleteButtonStr+setButtonStr);
    		mv.setViewName("system/e_offer/save_result");
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
    	}
    	return mv;
    }
    
    //保存 飞尚货梯MRL
    @RequestMapping(value="saveFeishangMrl")
    public ModelAndView saveFeishangMrl(){
    	ModelAndView mv = new ModelAndView();
    	PageData pd = new PageData();
    	pd = this.getPageData();
    	String feishangId = "";
    	String modelsId = "";
    	String bjcId = "";
    	String elevIds = "";
    	try{
    		if(pd.getString("view").equals("edit")){
    			feishangId = pd.getString("FEISHANG_MRL_ID");
    			modelsId = pd.getString("MODELS_ID");
    			bjcId = pd.getString("BJC_ID");
    			elevIds = pd.getString("ELEV_IDS");
    			//调用获取电梯eno方法
    			String elevNo=elevNo(elevIds);
    			//编辑飞尚
    			e_offerService.updateFeishangMrl(pd);
    			
    			pd.put("BJ_DT_ID",feishangId);
	    		e_offerService.updateConventionalNonstandard(pd);
    			//关联更新报价池信息
    			PageData bjcPd = new PageData();
    			bjcPd.put("offer_version", pd.getString("offer_version"));
    			bjcPd.put("BJC_ENO", elevNo);
	        	bjcPd.put("BJC_ID", pd.getString("BJC_ID"));
	        	bjcPd.put("BJC_COD_ID", pd.getString("FEISHANG_MRL_ID"));
	        	bjcPd.put("BJC_ITEM_ID", pd.get("ITEM_ID").toString());
	        	bjcPd.put("BJC_ELEV", pd.get("ELEV_IDS").toString());
	        	bjcPd.put("BJC_MODELS", pd.get("MODELS_ID").toString());
	        	bjcPd.put("BJC_ZHJ", pd.get("FEISHANG_MRL_ZHJ").toString());
	        	bjcPd.put("BJC_SBJ", pd.get("FEISHANG_MRL_SBSJBJ").toString());
	        	bjcPd.put("SBSJZJ", pd.get("FEISHANG_MRL_SBSJBJ").toString());
	        	bjcPd.put("BJC_ZK", pd.get("FEISHANG_MRL_ZKL").toString());
	        	bjcPd.put("YJZE", pd.get("FEISHANG_MRL_YJZE").toString());
	        	bjcPd.put("YJBL", pd.get("FEISHANG_MRL_YJBL").toString());
	        	bjcPd.put("BJC_AZF", pd.get("FEISHANG_MRL_AZJ").toString());
	        	bjcPd.put("BJC_YSF", pd.get("FEISHANG_MRL_YSJ").toString());
	        	bjcPd.put("BJC_SJBJ", pd.get("FEISHANG_MRL_TATOL").toString());
	        	bjcPd.put("BJC_SL", pd.get("FEISHANG_MRL_SL").toString());
	        	bjcPd.put("BJC_ZZ", pd.get("BZ_ZZ").toString());
	        	bjcPd.put("BJC_SD", pd.get("BZ_SD").toString());
	        	bjcPd.put("BJC_C", pd.get("BZ_C").toString());
	        	bjcPd.put("BJC_Z", pd.get("BZ_Z").toString());
	        	bjcPd.put("BJC_M", pd.get("BZ_M").toString());
	        	bjcPd.put("BJC_TSGD", pd.get("BASE_TSGD").toString());
	        	//↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
	        	int jj=Integer.parseInt(pd.getString("SBJ_TEMP"));//基价
	        	int xxjj=Integer.parseInt(pd.getString("FEISHANG_MRL_XXJJ"));//选项加价
	        	int fbj=0;
	        	if(pd.getString("FEISHANG_MRL_FBJ")!=null && !"".equals(pd.getString("FEISHANG_MRL_FBJ")))
	        	{
	        		fbj=Integer.parseInt(pd.getString("FEISHANG_MRL_FBJ"));//非标价
	        	}
	        	
	        	PageData pdSl=new PageData();
	        	pdSl.put("id","1");
	        	try {
	        		pdSl= e_offerService.getShuiLv(pdSl);
	    		} catch (Exception e) {
	    			e.printStackTrace();
	    		}
	        	double ShuiLv=Double.parseDouble(pdSl.getString("content"));
	        	
	        	int qtfy=Integer.parseInt(pd.getString("FEISHANG_MRL_QTFY"));//其他费用
	        	int yjze=Integer.parseInt(pd.getString("FEISHANG_MRL_YJZE"));//佣金总额
	        	int sjbj=Integer.parseInt(pd.getString("FEISHANG_MRL_SBSJBJ"));//实际报价
	        	bjcPd.put("YJSYZKL", pd.get("YJSYZKL").toString());
	        	bjcPd.put("ZGYJ", pd.get("ZGYJ").toString());
	        	int jj_xxjj=jj+xxjj;
	        	int yjzkl=(int) (sjbj-fbj-qtfy*ShuiLv);
	        	int zkl=(int) (sjbj-fbj-qtfy*ShuiLv-yjze*ShuiLv);
	        	//↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑
	        	bjcPd.put("JJ_XXJJ", String.valueOf(jj_xxjj));//基价+选项加价
	        	bjcPd.put("SJ_FB_QT", String.valueOf(yjzkl));//实际-非标-其他*1.17
	        	bjcPd.put("SJ_FB_QT_YJ",String.valueOf(zkl));//实际-非标-其他*1.17-佣金*1.17
	        	e_offerService.updateBjc(bjcPd);
	        	mv.addObject("bjc_id", pd.getString("BJC_ID"));
    		}else{
    			//新增飞尚
	    		feishangId = this.get32UUID();
	    		pd.put("FEISHANG_MRL_ID", feishangId);
	        	e_offerService.saveFeishangMrl(pd);
	        	
	        	pd.put("BJ_DT_ID",feishangId);
	    		e_offerService.saveConventionalNonstandard(pd);
	        	//关联更新电梯报价状态信息
	        	updateDetails(pd);
	        	//关联保存报价池
	        	String bjc_id = this.get32UUID();
	        	//button赋值部分
    			modelsId = pd.getString("MODELS_ID");
    			bjcId = bjc_id;
    			elevIds = pd.getString("ELEV_IDS");
    			//调用获取电梯eno方法
    			String elevNo=elevNo(elevIds);
    			
	        	PageData bjcPd = new PageData();
	        	bjcPd.put("BJC_ENO", elevNo);
	        	bjcPd.put("BJC_ID", bjc_id);
	        	bjcPd.put("bjc_id", bjc_id);
	        	bjcPd.put("item_id", pd.get("ITEM_ID").toString());
	        	bjcPd.put("BJC_COD_ID", feishangId);
	        	bjcPd.put("BJC_ITEM_ID", pd.get("ITEM_ID").toString());
	        	bjcPd.put("BJC_ELEV", pd.get("ELEV_IDS").toString());
	        	bjcPd.put("BJC_MODELS", pd.get("MODELS_ID").toString());
	        	bjcPd.put("BJC_ZHJ", pd.get("FEISHANG_MRL_ZHJ").toString());//装潢价
	        	bjcPd.put("BJC_SBJ", pd.get("FEISHANG_MRL_SBSJBJ").toString());//设备实际报价
	        	bjcPd.put("BJC_ZK", pd.get("FEISHANG_MRL_ZKL").toString());//折扣
	        	bjcPd.put("BJC_ZHSBJ", pd.get("FEISHANG_MRL_ZHSBJ").toString());//折后设备价
	        	bjcPd.put("BJC_AZF", pd.get("FEISHANG_MRL_AZJ").toString());
	        	bjcPd.put("BJC_YSF", pd.get("FEISHANG_MRL_YSJ").toString());
	        	bjcPd.put("BJC_SJBJ", pd.get("FEISHANG_MRL_TATOL").toString());//实际报价
	        	bjcPd.put("BJC_SL", pd.get("FEISHANG_MRL_SL").toString());
	        	bjcPd.put("BJC_ZZ", pd.get("BZ_ZZ").toString());
	        	bjcPd.put("BJC_SD", pd.get("BZ_SD").toString());
	        	bjcPd.put("BJC_C", pd.get("BZ_C").toString());
	        	bjcPd.put("BJC_Z", pd.get("BZ_Z").toString());
	        	bjcPd.put("BJC_M", pd.get("BZ_M").toString());
	        	bjcPd.put("BJC_TSGD", pd.get("BASE_TSGD").toString());
	        	bjcPd.put("SBSJZJ", pd.get("FEISHANG_MRL_SBSJBJ").toString());//设备实际总价
	        	bjcPd.put("YJZE", pd.get("FEISHANG_MRL_YJZE").toString());//佣金总额
	        	bjcPd.put("YJBL", pd.get("FEISHANG_MRL_YJBL").toString());//佣金比例
	        	bjcPd.put("YJSYZKL", pd.get("YJSYZKL").toString());
	        	bjcPd.put("ZGYJ", pd.get("ZGYJ").toString());
	        	//↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
	        	int jj=Integer.parseInt(pd.getString("SBJ_TEMP"));//基价
	        	int xxjj=Integer.parseInt(pd.getString("FEISHANG_MRL_XXJJ"));//选项加价
	        	int fbj=0;
	        	if(pd.getString("FEISHANG_MRL_FBJ")!=null && !"".equals(pd.getString("FEISHANG_MRL_FBJ")))
	        	{
	        		fbj=Integer.parseInt(pd.getString("FEISHANG_MRL_FBJ"));//非标价
	        	}
	        	
	        	PageData pdSl=new PageData();
	        	pdSl.put("id","1");
	        	try {
	        		pdSl= e_offerService.getShuiLv(pdSl);
	    		} catch (Exception e) {
	    			// TODO 自动生成的 catch 块
	    			e.printStackTrace();
	    		}
	        	double ShuiLv=Double.parseDouble(pdSl.getString("content"));
	        	
	        	int qtfy=Integer.parseInt(pd.getString("FEISHANG_MRL_QTFY"));//其他费用
	        	int yjze=Integer.parseInt(pd.getString("FEISHANG_MRL_YJZE"));//佣金总额
	        	int sjbj=Integer.parseInt(pd.getString("FEISHANG_MRL_SBSJBJ"));//实际报价
	        	bjcPd.put("YJSYZKL", pd.get("YJSYZKL").toString());
	        	bjcPd.put("ZGYJ", pd.get("ZGYJ").toString());
	        	int jj_xxjj=jj+xxjj;
	        	int yjzkl=(int) (sjbj-fbj-qtfy*ShuiLv);
	        	int zkl=(int) (sjbj-fbj-qtfy*ShuiLv-yjze*ShuiLv);
	        	//↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑
	        	bjcPd.put("JJ_XXJJ", String.valueOf(jj_xxjj));//基价+选项加价
	        	bjcPd.put("SJ_FB_QT", String.valueOf(yjzkl));//实际-非标-其他*1.17
	        	bjcPd.put("SJ_FB_QT_YJ",String.valueOf(zkl));//实际-非标-其他*1.17-佣金*1.17
	        	bjcPd.put("offer_version", pd.getString("offer_version"));
	        	
	        	e_offerService.saveBjc(bjcPd);
	        	mv.addObject("bjc_id", bjc_id);
    		}
    		PageData srPd = new PageData();//save_result.jsp
        	srPd.put("c_", pd.getString("BZ_C"));
        	srPd.put("z_", pd.getString("BZ_Z"));
        	srPd.put("m_", pd.getString("BZ_M"));
        	srPd.put("sbj_", pd.getString("FEISHANG_MRL_SBSJBJ"));
        	srPd.put("zk_", pd.getString("FEISHANG_MRL_ZKL"));
        	srPd.put("zhsbj_", pd.getString("FEISHANG_MRL_ZHSBJ"));
        	srPd.put("sjbj_", pd.getString("FEISHANG_MRL_TATOL"));
        	srPd.put("azf_", pd.getString("FEISHANG_MRL_AZJ"));
        	srPd.put("ysf_", pd.getString("FEISHANG_MRL_YSJ"));
        	srPd.put("yjze_", pd.getString("FEISHANG_MRL_YJZE"));
        	srPd.put("yjbl_", pd.getString("FEISHANG_MRL_YJBL"));
        	srPd.put("rowIndex", pd.getString("rowIndex"));
        	//调用汇总数据方法
        	PageData CountPd=setBjcHzJs(pd);
    		//根据报价编号查找报价表,如果存在即为编辑进来
        	pd.put("item_id", pd.getString("ITEM_ID"));
    		PageData offerdetail = e_offerService.findItemInOfferByItem(pd);
    		if (offerdetail!=null && !offerdetail.isEmpty()) {
    	   		//(new)编辑报价池后同步更新报价汇总
    			CountPd.put("offer_id", offerdetail.get("offer_id"));
        		e_offerService.updateOfferCount(CountPd);
        		e_offerService.updateTempOfferCount(CountPd);
//        		e_offerService.initDetails(CountPd);
			}
        	mv.addObject("CountPd", CountPd);
        	mv.addObject("srPd", srPd);
        	mv.addObject("pd", pd);
        	mv.addObject("id", "ElevatorParam");
        	//重写编辑和删除的button
        	String editButtonStr = "<button class='btn  btn-primary btn-sm' title='编辑' onclick=\\\"toEdit(this,'"+feishangId+"','"+modelsId+"','"+bjcId+"')\\\" type='button'>编辑</button>";
        	String deleteButtonStr = "<button class='btn  btn-danger btn-sm' title='删除' onclick=\\\"deleteRow(this,'"+elevIds+"')\\\" type='button'>删除</button>";
			String setButtonStr="<button class='btn btn-info btn-sm' title='梯号设置' style='margin-left:5px;' type='button'" +
					" onclick=\\\"setENoRow(this,'"+elevIds+"','"+bjcId+"')\\\">梯号设置</button>";
			mv.addObject("buttonStr", editButtonStr+deleteButtonStr+setButtonStr);
    		mv.setViewName("system/e_offer/save_result");
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
    	}
    	return mv;
    }
    
    //保存新增 飞扬3000+MRL
    @RequestMapping(value="saveFeiyangMRL")
    public ModelAndView saveFeiyangMRL(){
    	ModelAndView mv = new ModelAndView();
    	PageData pd = new PageData();
    	pd = this.getPageData();
    	//feishangId,modelsId,bjcId,elevIds新增/编辑页面关闭之后重新给报价池页面的button赋值
    	String feiyangMrlId = "";
    	String modelsId = "";
    	String bjcId = "";
    	String elevIds = "";
    	try{
    		if(pd.getString("view").equals("edit")){
    			feiyangMrlId = pd.getString("FEIYANGMRL_ID");
				modelsId = pd.getString("MODELS_ID");
				bjcId = pd.getString("BJC_ID");
				elevIds = pd.getString("ELEV_IDS");
				//调用获取电梯eno方法
    			String elevNo=elevNo(elevIds);
				
	    		e_offerService.updateFeiyangMRL(pd);
	    		
	    		pd.put("BJ_DT_ID",feiyangMrlId);
	    		e_offerService.updateConventionalNonstandard(pd);
	    		//关联更新报价池信息
    			PageData bjcPd = new PageData();
    			bjcPd.put("offer_version", pd.getString("offer_version"));
    			bjcPd.put("BJC_ENO", elevNo);
	        	bjcPd.put("BJC_ID", pd.getString("BJC_ID"));
	        	bjcPd.put("BJC_COD_ID", pd.getString("FEIYANGMRL_ID"));
	        	bjcPd.put("BJC_ITEM_ID", pd.get("ITEM_ID").toString());
	        	bjcPd.put("BJC_ELEV", pd.get("ELEV_IDS").toString());
	        	bjcPd.put("BJC_MODELS", pd.get("MODELS_ID").toString());
	        	bjcPd.put("BJC_ZHJ", pd.get("FEIYANGMRL_ZHJ").toString());
	        	bjcPd.put("BJC_ZHSBJ", pd.get("FEIYANGMRL_ZHSBJ").toString());
	        	bjcPd.put("BJC_SL", pd.get("FEIYANGMRL_SL").toString());
	        	bjcPd.put("BJC_ZZ", pd.get("BZ_ZZ").toString());
	        	bjcPd.put("BJC_SD", pd.get("BZ_SD").toString());
	        	bjcPd.put("BJC_C", pd.get("BZ_C").toString());
	        	bjcPd.put("BJC_Z", pd.get("BZ_Z").toString());
	        	bjcPd.put("BJC_M", pd.get("BZ_M").toString());
	        	bjcPd.put("BJC_TSGD", pd.get("BASE_TSGD").toString());
	        	bjcPd.put("bjc_id", pd.getString("BJC_ID"));
	        	bjcPd.put("item_id", pd.get("ITEM_ID").toString());
	        	bjcPd.put("BJC_SBJ", pd.get("XS_SBSJBJ").toString());//设备实际报价
	        	bjcPd.put("BJC_ZK", pd.get("XS_ZKL").toString());//折扣
	        	bjcPd.put("SBSJZJ", pd.get("XS_SBSJBJ").toString());//设备实际总价
	        	bjcPd.put("YJZE", pd.get("XS_YJZE").toString());//佣金总额
	        	bjcPd.put("YJBL", pd.get("XS_YJBL").toString());//佣金比例
	        	bjcPd.put("BJC_AZF", pd.get("XS_AZJ").toString());//安装费
	        	bjcPd.put("BJC_YSF", pd.get("XS_YSJ").toString());//运输费
	        	bjcPd.put("BJC_SJBJ", pd.get("XS_TATOL").toString());//实际报价
	        	bjcPd.put("YJSYZKL", pd.get("YJSYZKL").toString());
	        	bjcPd.put("ZGYJ", pd.get("ZGYJ").toString());
	        	PageData hzPd=setHzBjc(pd);
	        	bjcPd.put("JJ_XXJJ", hzPd.getString("JJ_XXJJ"));//基价+选项加价
	        	bjcPd.put("SJ_FB_QT", hzPd.getString("SJ_FB_QT"));//实际-非标-其他*1.17
	        	bjcPd.put("SJ_FB_QT_YJ", hzPd.getString("SJ_FB_QT_YJ"));//实际-非标-其他*1.17-佣金*1.17
	        	e_offerService.updateBjc(bjcPd);
	        	mv.addObject("bjc_id", pd.getString("BJC_ID"));
    		}else{
    			//保存飞扬MRL
	    		feiyangMrlId = this.get32UUID();
	    		pd.put("FEIYANGMRL_ID", feiyangMrlId);
	        	e_offerService.saveFeiyangMRL(pd);
	        	
	        	pd.put("BJ_DT_ID",feiyangMrlId);
	    		e_offerService.saveConventionalNonstandard(pd);
	        	//关联更新电梯报价状态信息
	        	updateDetails(pd);
	        	//关联保存报价池
	        	String bjc_id = this.get32UUID();
    			//button赋值部分
    			modelsId = pd.getString("MODELS_ID");
    			bjcId = bjc_id;
    			elevIds = pd.getString("ELEV_IDS");
    			//调用获取电梯eno方法
    			String elevNo=elevNo(elevIds);
    			
	        	PageData bjcPd = new PageData();
	        	bjcPd.put("BJC_ENO", elevNo);
	        	bjcPd.put("BJC_ID", bjc_id);
	        	bjcPd.put("BJC_COD_ID", feiyangMrlId);
	        	bjcPd.put("BJC_ITEM_ID", pd.get("ITEM_ID").toString());
	        	bjcPd.put("BJC_ELEV", pd.get("ELEV_IDS").toString());
	        	bjcPd.put("BJC_MODELS", pd.get("MODELS_ID").toString());
	        	bjcPd.put("BJC_ZHJ", pd.get("FEIYANGMRL_ZHJ").toString());
	        	bjcPd.put("BJC_ZHSBJ", pd.get("FEIYANGMRL_ZHSBJ").toString());
	        	bjcPd.put("BJC_SL", pd.get("FEIYANGMRL_SL").toString());
	        	bjcPd.put("BJC_ZZ", pd.get("BZ_ZZ").toString());
	        	bjcPd.put("BJC_SD", pd.get("BZ_SD").toString());
	        	bjcPd.put("BJC_C", pd.get("BZ_C").toString());
	        	bjcPd.put("BJC_Z", pd.get("BZ_Z").toString());
	        	bjcPd.put("BJC_M", pd.get("BZ_M").toString());
	        	bjcPd.put("BJC_TSGD", pd.get("BASE_TSGD").toString());
	        	bjcPd.put("bjc_id", bjc_id);
	        	bjcPd.put("item_id", pd.get("ITEM_ID").toString());
	        	bjcPd.put("BJC_SBJ", pd.get("XS_SBSJBJ").toString());//设备实际报价
	        	bjcPd.put("BJC_ZK", pd.get("XS_ZKL").toString());//折扣
	        	bjcPd.put("SBSJZJ", pd.get("XS_SBSJBJ").toString());//设备实际总价
	        	bjcPd.put("YJZE", pd.get("XS_YJZE").toString());//佣金总额
	        	bjcPd.put("YJBL", pd.get("XS_YJBL").toString());//佣金比例
	        	bjcPd.put("BJC_AZF", pd.get("XS_AZJ").toString());//安装费
	        	bjcPd.put("BJC_YSF", pd.get("XS_YSJ").toString());//运输费
	        	bjcPd.put("BJC_SJBJ", pd.get("XS_TATOL").toString());//实际报价
	        	bjcPd.put("YJSYZKL", pd.get("YJSYZKL").toString());
	        	bjcPd.put("ZGYJ", pd.get("ZGYJ").toString());
	        	PageData hzPd=setHzBjc(pd);
	        	bjcPd.put("JJ_XXJJ", hzPd.getString("JJ_XXJJ"));//基价+选项加价
	        	bjcPd.put("SJ_FB_QT", hzPd.getString("SJ_FB_QT"));//实际-非标-其他*1.17
	        	bjcPd.put("SJ_FB_QT_YJ", hzPd.getString("SJ_FB_QT_YJ"));//实际-非标-其他*1.17-佣金*1.17
	        	bjcPd.put("offer_version", pd.getString("offer_version"));
	        	
	        	e_offerService.saveBjc(bjcPd);
	        	mv.addObject("bjc_id", bjc_id);
    		}
        	//放入saveresult信息
        	PageData srPd = new PageData();
        	srPd.put("c_", pd.getString("BZ_C"));
        	srPd.put("z_", pd.getString("BZ_Z"));
        	srPd.put("m_", pd.getString("BZ_M"));
        	srPd.put("zhsbj_", pd.getString("FEIYANGMRL_ZHSBJ"));
        	srPd.put("rowIndex", pd.getString("rowIndex"));
        	srPd.put("sbj_", pd.getString("XS_SBSJBJ"));//+
        	srPd.put("zk_", pd.getString("XS_ZKL"));//+
        	srPd.put("sjbj_", pd.getString("XS_TATOL"));//+
        	srPd.put("azf_", pd.getString("XS_AZJ"));//+
        	srPd.put("ysf_", pd.getString("XS_YSJ"));//+
        	srPd.put("yjze_", pd.getString("XS_YJZE"));//+
        	srPd.put("yjbl_", pd.getString("XS_YJBL"));//+
        	//调用汇总数据方法
        	PageData CountPd=setBjcHzJs(pd);
        	mv.addObject("CountPd", CountPd);
        	mv.addObject("srPd", srPd);
        	mv.addObject("pd", pd);
        	mv.addObject("id", "ElevatorParam");
        	//重写编辑和删除的button
        	String editButtonStr = "<button class='btn  btn-primary btn-sm' title='编辑' onclick=\\\"toEdit(this,'"+feiyangMrlId+"','"+modelsId+"','"+bjcId+"')\\\" type='button'>编辑</button>";
        	String deleteButtonStr = "<button class='btn  btn-danger btn-sm' title='删除' onclick=\\\"deleteRow(this,'"+elevIds+"')\\\" type='button'>删除</button>";
			String setButtonStr="<button class='btn btn-info btn-sm' title='梯号设置' style='margin-left:5px;' type='button'" +
					" onclick=\\\"setENoRow(this,'"+elevIds+"','"+bjcId+"')\\\">梯号设置</button>";
			mv.addObject("buttonStr", editButtonStr+deleteButtonStr+setButtonStr);
    		mv.setViewName("system/e_offer/save_result");
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
    	}
    	return mv;
    }
    //保存 飞扬3000+
    @RequestMapping(value="saveFeiyang")
    public ModelAndView saveFeiyang(){
    	ModelAndView mv = new ModelAndView();
    	PageData pd = new PageData();
    	pd = this.getPageData();
    	//feishangId,modelsId,bjcId,elevIds新增/编辑页面关闭之后重新给报价池页面的button赋值
    	String feiyangId = "";
    	String modelsId = "";
    	String bjcId = "";
    	String elevIds = "";
    	try{
    		if(pd.getString("view").equals("edit")){
    			feiyangId = pd.getString("FEIYANG_ID");
    			modelsId = pd.getString("MODELS_ID");
    			bjcId = pd.getString("BJC_ID");
    			elevIds = pd.getString("ELEV_IDS");
    			//调用获取电梯eno方法
    			String elevNo=elevNo(elevIds);
    			//编辑飞扬
    			e_offerService.updateFeiyang(pd);
    			pd.put("BJ_DT_ID",feiyangId);
	    		e_offerService.updateConventionalNonstandard(pd);
    			//关联更新报价池信息
    			PageData bjcPd = new PageData();
    			bjcPd.put("offer_version", pd.getString("offer_version"));
    			bjcPd.put("BJC_ENO", elevNo);
	        	bjcPd.put("BJC_ID", pd.getString("BJC_ID"));
	        	bjcPd.put("BJC_COD_ID", pd.getString("FEIYANG_ID"));
	        	bjcPd.put("BJC_ITEM_ID", pd.get("ITEM_ID").toString());
	        	bjcPd.put("BJC_ELEV", pd.get("ELEV_IDS").toString());
	        	bjcPd.put("BJC_MODELS", pd.get("MODELS_ID").toString());
	        	bjcPd.put("BJC_ZHJ", pd.get("FEIYANG_ZHJ").toString());
	        	bjcPd.put("BJC_ZHSBJ", pd.get("FEIYANG_ZHSBJ").toString());
	        	bjcPd.put("BJC_SL", pd.get("FEIYANG_SL").toString());
	        	bjcPd.put("BJC_ZZ", pd.get("BZ_ZZ").toString());
	        	bjcPd.put("BJC_SD", pd.get("BZ_SD").toString());
	        	bjcPd.put("BJC_C", pd.get("BZ_C").toString());
	        	bjcPd.put("BJC_Z", pd.get("BZ_Z").toString());
	        	bjcPd.put("BJC_M", pd.get("BZ_M").toString());
	        	bjcPd.put("BJC_TSGD", pd.get("BASE_TSGD").toString());
	        	
	        	bjcPd.put("BJC_SBJ", pd.get("XS_SBSJBJ").toString());//设备实际报价
	        	bjcPd.put("BJC_ZK", pd.get("XS_ZKL").toString());//折扣
	        	bjcPd.put("SBSJZJ", pd.get("XS_SBSJBJ").toString());//设备实际总价
	        	bjcPd.put("YJZE", pd.get("XS_YJZE").toString());//佣金总额
	        	bjcPd.put("YJBL", pd.get("XS_YJBL").toString());//佣金比例
	        	bjcPd.put("BJC_AZF", pd.get("XS_AZJ").toString());//安装费
	        	bjcPd.put("BJC_YSF", pd.get("XS_YSJ").toString());//运输费
	        	bjcPd.put("BJC_SJBJ", pd.get("XS_TATOL").toString());//实际报价
	        	bjcPd.put("YJSYZKL", pd.get("YJSYZKL").toString());
	        	bjcPd.put("ZGYJ", pd.get("ZGYJ").toString());
	        	PageData hzPd=setHzBjc(pd);
	        	bjcPd.put("JJ_XXJJ", hzPd.getString("JJ_XXJJ"));//基价+选项加价
	        	bjcPd.put("SJ_FB_QT", hzPd.getString("SJ_FB_QT"));//实际-非标-其他*1.17
	        	bjcPd.put("SJ_FB_QT_YJ", hzPd.getString("SJ_FB_QT_YJ"));//实际-非标-其他*1.17-佣金*1.17
	        	e_offerService.updateBjc(bjcPd);
	        	mv.addObject("bjc_id", pd.getString("BJC_ID"));
    		}else{
    			//新增保存飞扬
        		feiyangId = this.get32UUID();
        		pd.put("FEIYANG_ID", feiyangId);
            	e_offerService.saveFeiyang(pd);	  
            	
            	pd.put("BJ_DT_ID",feiyangId);
	    		e_offerService.saveConventionalNonstandard(pd);
            	//关联更新电梯报价状态信息
	        	updateDetails(pd);
	        	//关联保存报价池
	        	String bjc_id = this.get32UUID();
    			//button赋值部分
    			modelsId = pd.getString("MODELS_ID");
    			bjcId = bjc_id;
    			elevIds = pd.getString("ELEV_IDS");
    			//调用获取电梯eno方法
    			String elevNo=elevNo(elevIds);
    			
	        	PageData bjcPd = new PageData();
	        	bjcPd.put("BJC_ENO", elevNo);
	        	bjcPd.put("BJC_ID", bjc_id);
	        	bjcPd.put("BJC_COD_ID", feiyangId);
	        	bjcPd.put("BJC_ITEM_ID", pd.get("ITEM_ID").toString());
	        	bjcPd.put("BJC_ELEV", pd.get("ELEV_IDS").toString());
	        	bjcPd.put("BJC_MODELS", pd.get("MODELS_ID").toString());
	        	bjcPd.put("BJC_ZHJ", pd.get("FEIYANG_ZHJ").toString());
	        	bjcPd.put("BJC_ZHSBJ", pd.get("FEIYANG_ZHSBJ").toString());
	        	bjcPd.put("BJC_SL", pd.get("FEIYANG_SL").toString());
	        	bjcPd.put("BJC_ZZ", pd.get("BZ_ZZ").toString());
	        	bjcPd.put("BJC_SD", pd.get("BZ_SD").toString());
	        	bjcPd.put("BJC_C", pd.get("BZ_C").toString());
	        	bjcPd.put("BJC_Z", pd.get("BZ_Z").toString());
	        	bjcPd.put("BJC_M", pd.get("BZ_M").toString());
	        	bjcPd.put("BJC_TSGD", pd.get("BASE_TSGD").toString());
	        	bjcPd.put("bjc_id", bjc_id);
	        	bjcPd.put("item_id", pd.get("ITEM_ID").toString());
	        	bjcPd.put("BJC_SBJ", pd.get("XS_SBSJBJ").toString());//设备实际报价
	        	bjcPd.put("BJC_ZK", pd.get("XS_ZKL").toString());//折扣
	        	bjcPd.put("SBSJZJ", pd.get("XS_SBSJBJ").toString());//设备实际总价
	        	bjcPd.put("YJZE", pd.get("XS_YJZE").toString());//佣金总额
	        	bjcPd.put("YJBL", pd.get("XS_YJBL").toString());//佣金比例
	        	bjcPd.put("BJC_AZF", pd.get("XS_AZJ").toString());//安装费
	        	bjcPd.put("BJC_YSF", pd.get("XS_YSJ").toString());//运输费
	        	bjcPd.put("BJC_SJBJ", pd.get("XS_TATOL").toString());//实际报价
	        	bjcPd.put("YJSYZKL", pd.get("YJSYZKL").toString());
	        	bjcPd.put("ZGYJ", pd.get("ZGYJ").toString());
	        	PageData hzPd=setHzBjc(pd);
	        	bjcPd.put("JJ_XXJJ", hzPd.getString("JJ_XXJJ"));//基价+选项加价
	        	bjcPd.put("SJ_FB_QT", hzPd.getString("SJ_FB_QT"));//实际-非标-其他*1.17
	        	bjcPd.put("SJ_FB_QT_YJ", hzPd.getString("SJ_FB_QT_YJ"));//实际-非标-其他*1.17-佣金*1.17
	        	bjcPd.put("offer_version", pd.getString("offer_version"));
	        	
	        	e_offerService.saveBjc(bjcPd);
	        	mv.addObject("bjc_id", bjc_id);
    		}
        	PageData srPd = new PageData();
        	srPd.put("c_", pd.getString("BZ_C"));
        	srPd.put("z_", pd.getString("BZ_Z"));
        	srPd.put("m_", pd.getString("BZ_M"));
        	srPd.put("zhsbj_", pd.getString("FEIYANGMRL_ZHSBJ"));
        	srPd.put("rowIndex", pd.getString("rowIndex"));
        	srPd.put("sbj_", pd.getString("XS_SBSJBJ"));//+
        	srPd.put("zk_", pd.getString("XS_ZKL"));//+
        	srPd.put("sjbj_", pd.getString("XS_TATOL"));//+
        	srPd.put("azf_", pd.getString("XS_AZJ"));//+
        	srPd.put("ysf_", pd.getString("XS_YSJ"));//+
        	srPd.put("yjze_", pd.getString("XS_YJZE"));//+
        	srPd.put("yjbl_", pd.getString("XS_YJBL"));//+
        	//调用汇总数据方法
        	PageData CountPd=setBjcHzJs(pd);
    		//根据报价编号查找报价表,如果存在即为编辑进来
        	pd.put("item_id", pd.getString("ITEM_ID"));
    		PageData offerdetail = e_offerService.findItemInOfferByItem(pd);
    		if (offerdetail!=null && !offerdetail.isEmpty()) {
    	   		//(new)编辑报价池后同步更新报价汇总
    			CountPd.put("offer_id", offerdetail.get("offer_id"));
        		e_offerService.updateOfferCount(CountPd);
        		e_offerService.updateTempOfferCount(CountPd);
//        		e_offerService.initDetails(CountPd);
			}
        	mv.addObject("CountPd", CountPd);
        	mv.addObject("srPd", srPd);
        	mv.addObject("pd", pd);
        	mv.addObject("id", "ElevatorParam");
        	//重写编辑和删除的button
        	String editButtonStr = "<button class='btn  btn-primary btn-sm' title='编辑' onclick=\\\"toEdit(this,'"+feiyangId+"','"+modelsId+"','"+bjcId+"')\\\" type='button'>编辑</button>";
        	String deleteButtonStr = "<button class='btn  btn-danger btn-sm' title='删除' onclick=\\\"deleteRow(this,'"+elevIds+"')\\\" type='button'>删除</button>";
			String setButtonStr="<button class='btn btn-info btn-sm' title='梯号设置' style='margin-left:5px;' type='button'" +
					" onclick=\\\"setENoRow(this,'"+elevIds+"','"+bjcId+"')\\\">梯号设置</button>";
			mv.addObject("buttonStr", editButtonStr+deleteButtonStr+setButtonStr);
    		mv.setViewName("system/e_offer/save_result");
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
    	}
    	return mv;
    }
    
    //保存扶梯 DNP9300
    @RequestMapping(value="saveDnp9300")
    public ModelAndView saveDnp9300(){
    	ModelAndView mv = new ModelAndView();
    	PageData pd = new PageData();
		pd = this.getPageData();
		//feishangId,modelsId,bjcId,elevIds新增/编辑页面关闭之后重新给报价池页面的button赋值
    	String dnp9300Id = "";
    	String modelsId = "";
    	String bjcId = "";
    	String elevIds = "";
    	try{
    		if(pd.getString("view").equals("edit")){
    			dnp9300Id = pd.getString("DNP9300_ID");
				modelsId = pd.getString("MODELS_ID");
				bjcId = pd.getString("BJC_ID");
				elevIds = pd.getString("ELEV_IDS");
				//调用获取电梯eno方法
    			String elevNo=elevNo(elevIds);
				
    			e_offerService.updateDnp9300(pd);
	        	//关联保存报价池
	        	PageData bjcPd = new PageData();
	        	bjcPd.put("offer_version", pd.getString("offer_version"));
	        	bjcPd.put("BJC_ENO", elevNo);
	        	bjcPd.put("BJC_ID", pd.getString("BJC_ID"));
	        	bjcPd.put("BJC_COD_ID", pd.getString("DNP9300_ID"));
	        	bjcPd.put("BJC_ITEM_ID", pd.get("ITEM_ID").toString());
	        	bjcPd.put("BJC_ELEV", pd.get("ELEV_IDS").toString());
	        	bjcPd.put("BJC_MODELS", pd.get("MODELS_ID").toString());
	        	bjcPd.put("BJC_ZHSBJ", pd.get("DNP9300_ZHSBJ").toString());
	        	bjcPd.put("BJC_SL", pd.get("DNP9300_SL").toString());
	        	bjcPd.put("BJC_SD", pd.get("BZ_SD").toString());
	        	bjcPd.put("BJC_TSGD", pd.get("BZ_TSGD").toString());
	        	
	        	bjcPd.put("BJC_SBJ", pd.get("XS_SBSJBJ").toString());//设备实际报价
	        	bjcPd.put("BJC_ZK", pd.get("XS_ZKL").toString());//折扣
	        	bjcPd.put("SBSJZJ", pd.get("XS_SBSJBJ").toString());//设备实际总价
	        	bjcPd.put("YJZE", pd.get("XS_YJZE").toString());//佣金总额
	        	bjcPd.put("YJBL", pd.get("XS_YJBL").toString());//佣金比例
	        	bjcPd.put("BJC_AZF", pd.get("XS_AZJ").toString());//安装费
	        	bjcPd.put("BJC_YSF", pd.get("XS_YSJ").toString());//运输费
	        	bjcPd.put("BJC_SJBJ", pd.get("XS_TATOL").toString());//实际报价
	        	bjcPd.put("YJSYZKL", pd.get("YJSYZKL").toString());
	        	bjcPd.put("ZGYJ", pd.get("ZGYJ").toString());
	        	PageData hzPd=setHzBjc(pd);
	        	bjcPd.put("JJ_XXJJ", hzPd.getString("JJ_XXJJ"));//基价+选项加价
	        	bjcPd.put("SJ_FB_QT", hzPd.getString("SJ_FB_QT"));//实际-非标-其他*1.17
	        	bjcPd.put("SJ_FB_QT_YJ", hzPd.getString("SJ_FB_QT_YJ"));//实际-非标-其他*1.17-佣金*1.17
	        	e_offerService.updateBjc(bjcPd);
	        	mv.addObject("bjc_id", pd.getString("BJC_ID"));
    		}else{
	    		dnp9300Id = this.get32UUID();
	    		pd.put("DNP9300_ID", dnp9300Id);
	    		e_offerService.saveDnp9300(pd);
	    		//关联更新电梯报价状态信息
	        	updateDetails(pd);
	        	//关联保存报价池
	        	String bjc_id = this.get32UUID();
    			//button赋值部分
    			modelsId = pd.getString("MODELS_ID");
    			bjcId = bjc_id;
    			elevIds = pd.getString("ELEV_IDS");
    			//调用获取电梯eno方法
    			String elevNo=elevNo(elevIds);
    			
	        	PageData bjcPd = new PageData();
	        	bjcPd.put("BJC_ENO", elevNo);
	        	bjcPd.put("BJC_ID", bjc_id);
	        	bjcPd.put("BJC_COD_ID", dnp9300Id);
	        	bjcPd.put("BJC_ITEM_ID", pd.get("ITEM_ID").toString());
	        	bjcPd.put("BJC_ELEV", pd.get("ELEV_IDS").toString());
	        	bjcPd.put("BJC_MODELS", pd.get("MODELS_ID").toString());
	        	bjcPd.put("BJC_ZHSBJ", pd.get("DNP9300_ZHSBJ").toString());
	        	bjcPd.put("BJC_SL", pd.get("DNP9300_SL").toString());
	        	bjcPd.put("BJC_SD", pd.get("BZ_SD").toString());
	        	bjcPd.put("BJC_TSGD", pd.get("BZ_TSGD").toString());
	        	bjcPd.put("bjc_id", bjc_id);
	        	bjcPd.put("item_id", pd.get("ITEM_ID").toString());
	        	bjcPd.put("BJC_SBJ", pd.get("XS_SBSJBJ").toString());//设备实际报价
	        	bjcPd.put("BJC_ZK", pd.get("XS_ZKL").toString());//折扣
	        	bjcPd.put("SBSJZJ", pd.get("XS_SBSJBJ").toString());//设备实际总价
	        	bjcPd.put("YJZE", pd.get("XS_YJZE").toString());//佣金总额
	        	bjcPd.put("YJBL", pd.get("XS_YJBL").toString());//佣金比例
	        	bjcPd.put("BJC_AZF", pd.get("XS_AZJ").toString());//安装费
	        	bjcPd.put("BJC_YSF", pd.get("XS_YSJ").toString());//运输费
	        	bjcPd.put("BJC_SJBJ", pd.get("XS_TATOL").toString());//实际报价
	        	bjcPd.put("YJSYZKL", pd.get("YJSYZKL").toString());
	        	bjcPd.put("ZGYJ", pd.get("ZGYJ").toString());
	        	PageData hzPd=setHzBjc(pd);
	        	bjcPd.put("JJ_XXJJ", hzPd.getString("JJ_XXJJ"));//基价+选项加价
	        	bjcPd.put("SJ_FB_QT", hzPd.getString("SJ_FB_QT"));//实际-非标-其他*1.17
	        	bjcPd.put("SJ_FB_QT_YJ", hzPd.getString("SJ_FB_QT_YJ"));//实际-非标-其他*1.17-佣金*1.17
	        	bjcPd.put("offer_version", pd.getString("offer_version"));
	        	
	        	e_offerService.saveBjc(bjcPd);
	        	mv.addObject("bjc_id", bjc_id);
    		}
        	PageData srPd = new PageData();
        	srPd.put("c_", "--");
        	srPd.put("z_", "--");
        	srPd.put("m_", "--");
        	srPd.put("zhsbj_", pd.getString("FEIYANGMRL_ZHSBJ"));
        	srPd.put("rowIndex", pd.getString("rowIndex"));
        	srPd.put("sbj_", pd.getString("XS_SBSJBJ"));//+
        	srPd.put("zk_", pd.getString("XS_ZKL"));//+
        	srPd.put("sjbj_", pd.getString("XS_TATOL"));//+
        	srPd.put("azf_", pd.getString("XS_AZJ"));//+
        	srPd.put("ysf_", pd.getString("XS_YSJ"));//+
        	srPd.put("yjze_", pd.getString("XS_YJZE"));//+
        	srPd.put("yjbl_", pd.getString("XS_YJBL"));//+
        	//调用汇总数据方法
        	PageData CountPd=setBjcHzJs(pd);
    		//根据报价编号查找报价表,如果存在即为编辑进来
        	pd.put("item_id", pd.getString("ITEM_ID"));
    		PageData offerdetail = e_offerService.findItemInOfferByItem(pd);
    		if (offerdetail!=null && !offerdetail.isEmpty()) {
    	   		//(new)编辑报价池后同步更新报价汇总
    			CountPd.put("offer_id", offerdetail.get("offer_id"));
        		e_offerService.updateOfferCount(CountPd);
        		e_offerService.updateTempOfferCount(CountPd);
//        		e_offerService.initDetails(CountPd);
			}
        	mv.addObject("CountPd", CountPd);
        	mv.addObject("srPd", srPd);
        	mv.addObject("pd", pd);
        	mv.addObject("id", "ElevatorParam");
        	//重写编辑和删除的button
        	String editButtonStr = "<button class='btn  btn-primary btn-sm' title='编辑' onclick=\\\"toEdit(this,'"+dnp9300Id+"','"+modelsId+"','"+bjcId+"')\\\" type='button'>编辑</button>";
        	String deleteButtonStr = "<button class='btn  btn-danger btn-sm' title='删除' onclick=\\\"deleteRow(this,'"+elevIds+"')\\\" type='button'>删除</button>";
        	String setButtonStr="<button class='btn btn-info btn-sm' title='梯号设置' style='margin-left:5px;' type='button'" +
					" onclick=\\\"setENoRow(this,'"+elevIds+"','"+bjcId+"')\\\">梯号设置</button>";
        	mv.addObject("buttonStr", editButtonStr+deleteButtonStr+setButtonStr);
    		mv.setViewName("system/e_offer/save_result");
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
    	}
    	return mv;
    }
    //保存 DNR
    @RequestMapping(value="saveDnr")
    public ModelAndView saveDnr(){
    	ModelAndView mv = new ModelAndView();
    	PageData pd = new PageData();
		pd = this.getPageData();
		//feishangId,modelsId,bjcId,elevIds新增/编辑页面关闭之后重新给报价池页面的button赋值
    	String dnrId = "";
    	String modelsId = "";
    	String bjcId = "";
    	String elevIds = "";
    	try{
    		if(pd.getString("view").equals("edit")){
    			dnrId = pd.getString("DNR_ID");
				modelsId = pd.getString("MODELS_ID");
				bjcId = pd.getString("BJC_ID");
				elevIds = pd.getString("ELEV_IDS");
				//调用获取电梯eno方法
    			String elevNo=elevNo(elevIds);
				
    			e_offerService.updateDnr(pd);
    			//关联保存报价池
	        	PageData bjcPd = new PageData();
	        	bjcPd.put("offer_version", pd.getString("offer_version"));
	        	bjcPd.put("BJC_ENO", elevNo);
	        	bjcPd.put("BJC_ID", pd.getString("BJC_ID"));
	        	bjcPd.put("BJC_COD_ID", pd.getString("DNR_ID"));
	        	bjcPd.put("BJC_ITEM_ID", pd.get("ITEM_ID").toString());
	        	bjcPd.put("BJC_ELEV", pd.get("ELEV_IDS").toString());
	        	bjcPd.put("BJC_MODELS", pd.get("MODELS_ID").toString());
	        	bjcPd.put("BJC_ZHSBJ", pd.get("DNR_ZHSBJ").toString());
	        	bjcPd.put("BJC_SL", pd.get("DNR_SL").toString());
	        	bjcPd.put("BJC_SD", pd.get("BZ_SD").toString());
	        	bjcPd.put("BJC_TSGD", pd.get("BZ_TSGD").toString());
	        	
	        	bjcPd.put("BJC_SBJ", pd.get("XS_SBSJBJ").toString());//设备实际报价
	        	bjcPd.put("BJC_ZK", pd.get("XS_ZKL").toString());//折扣
	        	bjcPd.put("SBSJZJ", pd.get("XS_SBSJBJ").toString());//设备实际总价
	        	bjcPd.put("YJZE", pd.get("XS_YJZE").toString());//佣金总额
	        	bjcPd.put("YJBL", pd.get("XS_YJBL").toString());//佣金比例
	        	bjcPd.put("BJC_AZF", pd.get("XS_AZJ").toString());//安装费
	        	bjcPd.put("BJC_YSF", pd.get("XS_YSJ").toString());//运输费
	        	bjcPd.put("BJC_SJBJ", pd.get("XS_TATOL").toString());//实际报价
	        	bjcPd.put("YJSYZKL", pd.get("YJSYZKL").toString());
	        	bjcPd.put("ZGYJ", pd.get("ZGYJ").toString());
	        	PageData hzPd=setHzBjc(pd);
	        	bjcPd.put("JJ_XXJJ", hzPd.getString("JJ_XXJJ"));//基价+选项加价
	        	bjcPd.put("SJ_FB_QT", hzPd.getString("SJ_FB_QT"));//实际-非标-其他*1.17
	        	bjcPd.put("SJ_FB_QT_YJ", hzPd.getString("SJ_FB_QT_YJ"));//实际-非标-其他*1.17-佣金*1.17
	        	e_offerService.updateBjc(bjcPd);
	        	mv.addObject("bjc_id", pd.getString("BJC_ID"));
    		}else{
	    		dnrId = this.get32UUID();
	    		pd.put("DNR_ID", dnrId);
	    		e_offerService.saveDnr(pd);
	    		//关联更新电梯报价状态信息
	        	updateDetails(pd);
	        	//关联保存报价池
	        	String bjc_id = this.get32UUID();
    			//button赋值部分
    			modelsId = pd.getString("MODELS_ID");
    			bjcId = bjc_id;
    			elevIds = pd.getString("ELEV_IDS");
    			//调用获取电梯eno方法
    			String elevNo=elevNo(elevIds);
    			
	        	PageData bjcPd = new PageData();
	        	bjcPd.put("BJC_ENO", elevNo);
	        	bjcPd.put("BJC_ID", bjc_id);
	        	bjcPd.put("BJC_COD_ID", dnrId);
	        	bjcPd.put("BJC_ITEM_ID", pd.get("ITEM_ID").toString());
	        	bjcPd.put("BJC_ELEV", pd.get("ELEV_IDS").toString());
	        	bjcPd.put("BJC_MODELS", pd.get("MODELS_ID").toString());
	        	bjcPd.put("BJC_ZHSBJ", pd.get("DNR_ZHSBJ").toString());
	        	bjcPd.put("BJC_SL", pd.get("DNR_SL").toString());
	        	bjcPd.put("BJC_SD", pd.get("BZ_SD").toString());
	        	bjcPd.put("BJC_TSGD", pd.get("BZ_TSGD").toString());
	        	bjcPd.put("bjc_id", bjc_id);
	        	bjcPd.put("item_id", pd.get("ITEM_ID").toString());
	        	bjcPd.put("BJC_SBJ", pd.get("XS_SBSJBJ").toString());//设备实际报价
	        	bjcPd.put("BJC_ZK", pd.get("XS_ZKL").toString());//折扣
	        	bjcPd.put("SBSJZJ", pd.get("XS_SBSJBJ").toString());//设备实际总价
	        	bjcPd.put("YJZE", pd.get("XS_YJZE").toString());//佣金总额
	        	bjcPd.put("YJBL", pd.get("XS_YJBL").toString());//佣金比例
	        	bjcPd.put("BJC_AZF", pd.get("XS_AZJ").toString());//安装费
	        	bjcPd.put("BJC_YSF", pd.get("XS_YSJ").toString());//运输费
	        	bjcPd.put("BJC_SJBJ", pd.get("XS_TATOL").toString());//实际报价
	        	bjcPd.put("YJSYZKL", pd.get("YJSYZKL").toString());
	        	bjcPd.put("ZGYJ", pd.get("ZGYJ").toString());
	        	PageData hzPd=setHzBjc(pd);
	        	bjcPd.put("JJ_XXJJ", hzPd.getString("JJ_XXJJ"));//基价+选项加价
	        	bjcPd.put("SJ_FB_QT", hzPd.getString("SJ_FB_QT"));//实际-非标-其他*1.17
	        	bjcPd.put("SJ_FB_QT_YJ", hzPd.getString("SJ_FB_QT_YJ"));//实际-非标-其他*1.17-佣金*1.17
	        	bjcPd.put("offer_version", pd.getString("offer_version"));
	        	
	        	e_offerService.saveBjc(bjcPd);
	        	mv.addObject("bjc_id", bjc_id);
    		}
        	PageData srPd = new PageData();
        	srPd.put("c_", "--");
        	srPd.put("z_", "--");
        	srPd.put("m_", "--");
        	srPd.put("zhsbj_", pd.getString("FEIYANGMRL_ZHSBJ"));
        	srPd.put("rowIndex", pd.getString("rowIndex"));
        	srPd.put("sbj_", pd.getString("XS_SBSJBJ"));//+
        	srPd.put("zk_", pd.getString("XS_ZKL"));//+
        	srPd.put("sjbj_", pd.getString("XS_TATOL"));//+
        	srPd.put("azf_", pd.getString("XS_AZJ"));//+
        	srPd.put("ysf_", pd.getString("XS_YSJ"));//+
        	srPd.put("yjze_", pd.getString("XS_YJZE"));//+
        	srPd.put("yjbl_", pd.getString("XS_YJBL"));//+
        	//调用汇总数据方法
        	PageData CountPd=setBjcHzJs(pd);
    		//根据报价编号查找报价表,如果存在即为编辑进来
        	pd.put("item_id", pd.getString("ITEM_ID"));
    		PageData offerdetail = e_offerService.findItemInOfferByItem(pd);
    		if (offerdetail!=null && !offerdetail.isEmpty()) {
    	   		//(new)编辑报价池后同步更新报价汇总
    			CountPd.put("offer_id", offerdetail.get("offer_id"));
        		e_offerService.updateOfferCount(CountPd);
        		e_offerService.updateTempOfferCount(CountPd);
//        		e_offerService.initDetails(CountPd);
			}
        	mv.addObject("CountPd", CountPd);
        	mv.addObject("srPd", srPd);
        	mv.addObject("pd", pd);
        	mv.addObject("id", "ElevatorParam");
        	//重写编辑和删除的button
        	String editButtonStr = "<button class='btn  btn-primary btn-sm' title='编辑' onclick=\\\"toEdit(this,'"+dnrId+"','"+modelsId+"','"+bjcId+"')\\\" type='button'>编辑</button>";
        	String deleteButtonStr = "<button class='btn  btn-danger btn-sm' title='删除' onclick=\\\"deleteRow(this,'"+elevIds+"')\\\" type='button'>删除</button>";
			String setButtonStr="<button class='btn btn-info btn-sm' title='梯号设置' style='margin-left:5px;' type='button'" +
					" onclick=\\\"setENoRow(this,'"+elevIds+"','"+bjcId+"')\\\">梯号设置</button>";
			mv.addObject("buttonStr", editButtonStr+deleteButtonStr+setButtonStr);
    		mv.setViewName("system/e_offer/save_result");
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
    	}
    	return mv;
    }
    
    //保存曳引货梯 
    @RequestMapping(value="saveShiny")
    public ModelAndView saveShiny(){
    	ModelAndView mv = new ModelAndView();
    	PageData pd = new PageData();
		pd = this.getPageData();
		//feishangId,modelsId,bjcId,elevIds新增/编辑页面关闭之后重新给报价池页面的button赋值
    	String shinyId = "";
    	String modelsId = "";
    	String bjcId = "";
    	String elevIds = "";
    	try{
    		if(pd.getString("view").equals("edit")){
    			shinyId = pd.getString("SHINY_ID");
    			modelsId = pd.getString("MODELS_ID");
    			bjcId = pd.getString("BJC_ID");
    			elevIds = pd.getString("ELEV_IDS");
    			//调用获取电梯eno方法
    			String elevNo=elevNo(elevIds);
    			
    			e_offerService.updateShiny(pd);
    			
    			pd.put("BJ_DT_ID",shinyId);
	    		e_offerService.updateConventionalNonstandard(pd);
    			//关联保存报价池
	        	PageData bjcPd = new PageData();
	        	bjcPd.put("offer_version", pd.getString("offer_version"));
	        	bjcPd.put("BJC_ENO", elevNo);
	        	bjcPd.put("BJC_ID", pd.getString("BJC_ID"));
	        	bjcPd.put("BJC_COD_ID", pd.getString("SHINY_ID"));
	        	bjcPd.put("BJC_ITEM_ID", pd.get("ITEM_ID").toString());
	        	bjcPd.put("BJC_ELEV", pd.get("ELEV_IDS").toString());
	        	bjcPd.put("BJC_MODELS", pd.get("MODELS_ID").toString());
	        	bjcPd.put("BJC_ZHSBJ", pd.get("SHINY_ZHSBJ").toString());
	        	bjcPd.put("BJC_SL", pd.get("SHINY_SL").toString());
	        	bjcPd.put("BJC_ZZ", pd.get("BZ_ZZ").toString());
	        	bjcPd.put("BJC_SD", pd.get("BZ_SD").toString());
	        	bjcPd.put("BJC_C", pd.get("BZ_C").toString());
	        	bjcPd.put("BJC_Z", pd.get("BZ_Z").toString());
	        	bjcPd.put("BJC_M", pd.get("BZ_M").toString());
	        	bjcPd.put("BJC_TSGD", pd.get("BASE_TSGD").toString());
	        	
	        	bjcPd.put("BJC_SBJ", pd.get("XS_SBSJBJ").toString());//设备实际报价
	        	bjcPd.put("BJC_ZK", pd.get("XS_ZKL").toString());//折扣
	        	bjcPd.put("SBSJZJ", pd.get("XS_SBSJBJ").toString());//设备实际总价
	        	bjcPd.put("YJZE", pd.get("XS_YJZE").toString());//佣金总额
	        	bjcPd.put("YJBL", pd.get("XS_YJBL").toString());//佣金比例
	        	bjcPd.put("BJC_AZF", pd.get("XS_AZJ").toString());//安装费
	        	bjcPd.put("BJC_YSF", pd.get("XS_YSJ").toString());//运输费
	        	bjcPd.put("BJC_SJBJ", pd.get("XS_TATOL").toString());//实际报价
	        	bjcPd.put("YJSYZKL", pd.get("YJSYZKL").toString());
	        	bjcPd.put("ZGYJ", pd.get("ZGYJ").toString());
	        	PageData hzPd=setHzBjc(pd);
	        	bjcPd.put("JJ_XXJJ", hzPd.getString("JJ_XXJJ"));//基价+选项加价
	        	bjcPd.put("SJ_FB_QT", hzPd.getString("SJ_FB_QT"));//实际-非标-其他*1.17
	        	bjcPd.put("SJ_FB_QT_YJ", hzPd.getString("SJ_FB_QT_YJ"));//实际-非标-其他*1.17-佣金*1.17
	        	e_offerService.updateBjc(bjcPd);
	        	mv.addObject("bjc_id", pd.getString("BJC_ID"));
    		}else{
	    		shinyId = this.get32UUID();
	    		pd.put("SHINY_ID", shinyId);
	    		e_offerService.saveShiny(pd);
	    		
	    		pd.put("BJ_DT_ID",shinyId);
	    		e_offerService.saveConventionalNonstandard(pd);
	    		//关联更新电梯报价状态信息
	        	updateDetails(pd);
	        	//关联保存报价池
	        	String bjc_id = this.get32UUID();
    			//button赋值部分
    			modelsId = pd.getString("MODELS_ID");
    			bjcId = bjc_id;
    			elevIds = pd.getString("ELEV_IDS");
    			//调用获取电梯eno方法
    			String elevNo=elevNo(elevIds);
	        	PageData bjcPd = new PageData();
	        	bjcPd.put("BJC_ENO", elevNo);
	        	bjcPd.put("BJC_ID", bjc_id);
	        	bjcPd.put("BJC_COD_ID", shinyId);
	        	bjcPd.put("BJC_ITEM_ID", pd.get("ITEM_ID").toString());
	        	bjcPd.put("BJC_ELEV", pd.get("ELEV_IDS").toString());
	        	bjcPd.put("BJC_MODELS", pd.get("MODELS_ID").toString());
	        	bjcPd.put("BJC_ZHSBJ", pd.get("SHINY_ZHSBJ").toString());
	        	bjcPd.put("BJC_SL", pd.get("SHINY_SL").toString());
	        	bjcPd.put("BJC_ZZ", pd.get("BZ_ZZ").toString());
	        	bjcPd.put("BJC_SD", pd.get("BZ_SD").toString());
	        	bjcPd.put("BJC_C", pd.get("BZ_C").toString());
	        	bjcPd.put("BJC_Z", pd.get("BZ_Z").toString());
	        	bjcPd.put("BJC_M", pd.get("BZ_M").toString());
	        	bjcPd.put("BJC_TSGD", pd.get("BASE_TSGD").toString());
	        	bjcPd.put("item_id", pd.get("item_id").toString());
	        	bjcPd.put("bjc_id", bjc_id);
	        	bjcPd.put("BJC_SBJ", pd.get("XS_SBSJBJ").toString());//设备实际报价
	        	bjcPd.put("BJC_ZK", pd.get("XS_ZKL").toString());//折扣
	        	bjcPd.put("SBSJZJ", pd.get("XS_SBSJBJ").toString());//设备实际总价
	        	bjcPd.put("YJZE", pd.get("XS_YJZE").toString());//佣金总额
	        	bjcPd.put("YJBL", pd.get("XS_YJBL").toString());//佣金比例
	        	bjcPd.put("BJC_AZF", pd.get("XS_AZJ").toString());//安装费
	        	bjcPd.put("BJC_YSF", pd.get("XS_YSJ").toString());//运输费
	        	bjcPd.put("BJC_SJBJ", pd.get("XS_TATOL").toString());//实际报价
	        	bjcPd.put("YJSYZKL", pd.get("YJSYZKL").toString());
	        	bjcPd.put("ZGYJ", pd.get("ZGYJ").toString());
	        	PageData hzPd=setHzBjc(pd);
	        	bjcPd.put("JJ_XXJJ", hzPd.getString("JJ_XXJJ"));//基价+选项加价
	        	bjcPd.put("SJ_FB_QT", hzPd.getString("SJ_FB_QT"));//实际-非标-其他*1.17
	        	bjcPd.put("SJ_FB_QT_YJ", hzPd.getString("SJ_FB_QT_YJ"));//实际-非标-其他*1.17-佣金*1.17
	        	bjcPd.put("offer_version", pd.getString("offer_version"));
	        	
	        	e_offerService.saveBjc(bjcPd);
	        	mv.addObject("bjc_id", bjc_id);
    		}
        	PageData srPd = new PageData();
        	srPd.put("c_", pd.getString("BZ_C"));
        	srPd.put("z_", pd.getString("BZ_Z"));
        	srPd.put("m_", pd.getString("BZ_M"));
        	srPd.put("zhsbj_", pd.getString("FEIYANGMRL_ZHSBJ"));
        	srPd.put("rowIndex", pd.getString("rowIndex"));
        	srPd.put("sbj_", pd.getString("XS_SBSJBJ"));//+
        	srPd.put("zk_", pd.getString("XS_ZKL"));//+
        	srPd.put("sjbj_", pd.getString("XS_TATOL"));//+
        	srPd.put("azf_", pd.getString("XS_AZJ"));//+
        	srPd.put("ysf_", pd.getString("XS_YSJ"));//+
        	srPd.put("yjze_", pd.getString("XS_YJZE"));//+
        	srPd.put("yjbl_", pd.getString("XS_YJBL"));//+
        	//调用汇总数据方法
        	PageData CountPd=setBjcHzJs(pd);
    		//根据报价编号查找报价表,如果存在即为编辑进来
        	pd.put("item_id", pd.getString("ITEM_ID"));
    		PageData offerdetail = e_offerService.findItemInOfferByItem(pd);
    		if (offerdetail!=null && !offerdetail.isEmpty()) {
    	   		//(new)编辑报价池后同步更新报价汇总
    			CountPd.put("offer_id", offerdetail.get("offer_id"));
        		e_offerService.updateOfferCount(CountPd);
        		e_offerService.updateTempOfferCount(CountPd);
//        		e_offerService.initDetails(CountPd);
			}
        	mv.addObject("CountPd", CountPd);
        	mv.addObject("srPd", srPd);
        	mv.addObject("pd", pd);
        	mv.addObject("id", "ElevatorParam");
        	//重写编辑和删除的button
        	String editButtonStr = "<button class='btn  btn-primary btn-sm' title='编辑' onclick=\\\"toEdit(this,'"+shinyId+"','"+modelsId+"','"+bjcId+"')\\\" type='button'>编辑</button>";
        	String deleteButtonStr = "<button class='btn  btn-danger btn-sm' title='删除' onclick=\\\"deleteRow(this,'"+elevIds+"')\\\" type='button'>删除</button>";
			String setButtonStr="<button class='btn btn-info btn-sm' title='梯号设置' style='margin-left:5px;' type='button'" +
					" onclick=\\\"setENoRow(this,'"+elevIds+"','"+bjcId+"')\\\">梯号设置</button>";
			mv.addObject("buttonStr", editButtonStr+deleteButtonStr+setButtonStr);
    		mv.setViewName("system/e_offer/save_result");
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
    	}
    	return mv;
    }
    
    //保存特种电梯
    /*@RequestMapping(value="saveTezhong")
    public ModelAndView saveTezhong() {
    	ModelAndView mv = new ModelAndView();
    	PageData pd = new PageData();
		pd = this.getPageData();
		String tezhongId = "";
    	String modelsId = "";
    	String bjcId = "";
    	String elevIds = "";
    	PageData CountPd = null;
    	
    	try {
	    	if(pd.getString("view").equals("edit")) {
	    		
	    		tezhongId = pd.getString("TEZHONG_ID");
    			modelsId = pd.getString("MODELS_ID");
    			bjcId = pd.getString("BJC_ID");
    			elevIds = pd.getString("ELEV_IDS");
    			
    			List<PageData> xxArgList = new ArrayList<PageData>();
	    		String xxArgJson = pd.getNoneNULLString("xxArgJson");
	    		if(!"".equals(xxArgJson)) {
	    			JSONArray argJsonArray = JSONArray.fromObject(xxArgJson);
	    			for (int i = 0, len = argJsonArray.size(); i < len; i++) {
	                    JSONObject jsonObj = argJsonArray.getJSONObject(i);
	    				PageData argpd = new PageData();
	    				argpd.put("XXCS_ID", this.get32UUID());
	    				
	    				argpd.put("XXCS_TYPE", jsonObj.getString("XXCS_TYPE"));
	    				argpd.put("XXCS_DESCRIBE", jsonObj.getString("XXCS_DESCRIBE"));
	    				argpd.put("XXCS_PRICE", jsonObj.getString("XXCS_PRICE"));
	    				argpd.put("XXCS_KDZ", jsonObj.getString("XXCS_KDZ"));
	    				argpd.put("XXCS_BZ", jsonObj.getString("XXCS_BZ"));
	    				
	    				argpd.put("XXCS_COD_ID", tezhongId);
	    				argpd.put("XXCS_ITEM_ID", pd.get("ITEM_ID"));
	    				argpd.put("XXCS_MODELS", pd.get("MODELS_ID"));
	
	    				xxArgList.add(argpd);
	    			}
	    		}
    			
    			//调用获取电梯eno方法
    			String elevNo=elevNo(elevIds);
    			
    			//关联保存报价池
	        	PageData bjcPd = new PageData();
	        	bjcPd.put("offer_version", pd.getString("offer_version"));
	        	bjcPd.put("BJC_ENO", elevNo);
	        	bjcPd.put("BJC_ID", pd.getString("BJC_ID"));
	        	bjcPd.put("BJC_COD_ID", tezhongId);
	        	bjcPd.put("BJC_ITEM_ID", pd.getString("ITEM_ID"));
	        	bjcPd.put("BJC_ELEV", pd.getString("ELEV_IDS"));
	        	bjcPd.put("BJC_MODELS", pd.getString("MODELS_ID"));
	        	bjcPd.put("BJC_ZHSBJ", pd.getString("BASE_ZHSBJ"));
	        	bjcPd.put("BJC_SL", pd.getString("BASE_SL"));
	        	bjcPd.put("BJC_ZZ", pd.getString("BZ_ZZ"));
	        	bjcPd.put("BJC_SD", pd.getString("BZ_SD"));
	        	bjcPd.put("BJC_C", pd.getString("BZ_C"));
	        	bjcPd.put("BJC_Z", pd.getString("BZ_Z"));
	        	bjcPd.put("BJC_M", pd.getString("BZ_M"));
	        	bjcPd.put("BJC_TSGD", pd.getString("BASE_TSGD"));
	        	
	        	bjcPd.put("BJC_SBJ", pd.getString("BASE_SBSJBJ"));//设备实际报价
	        	bjcPd.put("BJC_ZK", pd.getString("BASE_ZKL"));//折扣
	        	bjcPd.put("SBSJZJ", pd.getString("BASE_SBSJBJ"));//设备实际总价
	        	bjcPd.put("YJZE", pd.getString("BASE_YJZE"));//佣金总额
	        	bjcPd.put("YJBL", pd.getString("BASE_YJBL"));//佣金比例
	        	bjcPd.put("BJC_AZF", pd.getString("BASE_AZJ"));//安装费
	        	bjcPd.put("BJC_YSF", pd.getString("BASE_YSJ"));//运输费
	        	bjcPd.put("BJC_SJBJ", pd.getString("BASE_TATOL"));//实际报价
	        	bjcPd.put("YJSYZKL", pd.getString("YJSYZKL"));
	        	bjcPd.put("ZGYJ", pd.getString("ZGYJ"));
	        	PageData hzPd=setHzBjc(pd);
	        	bjcPd.put("JJ_XXJJ", hzPd.getString("JJ_XXJJ"));//基价+选项加价
	        	bjcPd.put("SJ_FB_QT", hzPd.getString("SJ_FB_QT"));//实际-非标-其他*1.17
	        	bjcPd.put("SJ_FB_QT_YJ", hzPd.getString("SJ_FB_QT_YJ"));//实际-非标-其他*1.17-佣金*1.17
	        	
    			e_offerService.updateTezhong(pd, bjcPd, xxArgList, CountPd);
    			
	        	mv.addObject("bjc_id", pd.getString("BJC_ID"));
	    		
	    	} else {
	    		tezhongId = this.get32UUID();
	    		pd.put("TEZHONG_ID", tezhongId);
				
	    		List<PageData> xxArgList = new ArrayList<PageData>();
	    		String xxArgJson = pd.getNoneNULLString("xxArgJson");
	    		if(!"".equals(xxArgJson)) {
	    			JSONArray argJsonArray = JSONArray.fromObject(xxArgJson);
	    			for (int i = 0, len = argJsonArray.size(); i < len; i++) {
	                    JSONObject jsonObj = argJsonArray.getJSONObject(i);
	    				PageData argpd = new PageData();
	    				argpd.put("XXCS_ID", this.get32UUID());
	    				
	    				argpd.put("XXCS_TYPE", jsonObj.getString("XXCS_TYPE"));
	    				argpd.put("XXCS_DESCRIBE", jsonObj.getString("XXCS_DESCRIBE"));
	    				argpd.put("XXCS_PRICE", jsonObj.getString("XXCS_PRICE"));
	    				argpd.put("XXCS_KDZ", jsonObj.getString("XXCS_KDZ"));
	    				argpd.put("XXCS_BZ", jsonObj.getString("XXCS_BZ"));
	    				
	    				argpd.put("XXCS_COD_ID", tezhongId);
	    				argpd.put("XXCS_ITEM_ID", pd.get("ITEM_ID"));
	    				argpd.put("XXCS_MODELS", pd.get("MODELS_ID"));
	
	    				xxArgList.add(argpd);
	    			}
	    		}
	    		
	        	//关联保存报价池
	        	String bjc_id = this.get32UUID();
				//button赋值部分
				modelsId = pd.getString("MODELS_ID");
				bjcId = bjc_id;
				elevIds = pd.getString("ELEV_IDS");
				//调用获取电梯eno方法
				String elevNo=elevNo(elevIds);
	        	PageData bjcPd = new PageData();
	        	bjcPd.put("BJC_ENO", elevNo);
	        	bjcPd.put("BJC_ID", bjc_id);
	        	bjcPd.put("BJC_COD_ID", tezhongId);
	        	bjcPd.put("BJC_ITEM_ID", pd.getString("ITEM_ID"));
	        	bjcPd.put("BJC_ELEV", pd.getString("ELEV_IDS"));
	        	bjcPd.put("BJC_MODELS", pd.getString("MODELS_ID"));
	        	bjcPd.put("BJC_ZHSBJ", pd.getString("BASE_ZHSBJ"));
	        	bjcPd.put("BJC_SL", pd.getString("BASE_SL"));
	        	bjcPd.put("BJC_ZZ", pd.getString("BZ_ZZ"));
	        	bjcPd.put("BJC_SD", pd.getString("BZ_SD"));
	        	bjcPd.put("BJC_C", pd.getString("BZ_C"));
	        	bjcPd.put("BJC_Z", pd.getString("BZ_Z"));
	        	bjcPd.put("BJC_M", pd.getString("BZ_M"));
	        	bjcPd.put("BJC_TSGD", pd.getString("BASE_TSGD"));
	        	
	        	bjcPd.put("BJC_SBJ", pd.getString("BASE_SBSJBJ"));//设备实际报价
	        	bjcPd.put("BJC_ZK", pd.getString("BASE_ZKL"));//折扣
	        	bjcPd.put("SBSJZJ", pd.getString("BASE_SBSJBJ"));//设备实际总价
	        	bjcPd.put("YJZE", pd.getString("BASE_YJZE"));//佣金总额
	        	bjcPd.put("YJBL", pd.getString("BASE_YJBL"));//佣金比例
	        	bjcPd.put("BJC_AZF", pd.getString("BASE_AZJ"));//安装费
	        	bjcPd.put("BJC_YSF", pd.getString("BASE_YSJ"));//运输费
	        	bjcPd.put("BJC_SJBJ", pd.getString("BASE_TATOL"));//实际报价
	        	bjcPd.put("YJSYZKL", pd.getString("YJSYZKL"));
	        	bjcPd.put("ZGYJ", pd.getString("ZGYJ"));
	        	PageData hzPd=setHzBjc(pd);
	        	bjcPd.put("JJ_XXJJ", hzPd.getString("JJ_XXJJ"));//基价+选项加价
	        	bjcPd.put("SJ_FB_QT", hzPd.getString("SJ_FB_QT"));//实际-非标-其他*1.17
	        	bjcPd.put("SJ_FB_QT_YJ", hzPd.getString("SJ_FB_QT_YJ"));//实际-非标-其他*1.17-佣金*1.17
	        	bjcPd.put("offer_version", pd.getString("offer_version"));
	        	
	        	//保存特种电梯
				e_offerService.saveTezhong(pd, bjcPd, xxArgList, CountPd);
	        	mv.addObject("bjc_id", bjc_id);
				
	    	}
	    	PageData srPd = new PageData();
	    	srPd.put("c_", pd.getString("BZ_C"));
	    	srPd.put("z_", pd.getString("BZ_Z"));
	    	srPd.put("m_", pd.getString("BZ_M"));
	    	srPd.put("zhsbj_", pd.getString("BASE_ZHSBJ"));
	    	srPd.put("rowIndex", pd.getString("rowIndex"));
	    	srPd.put("sbj_", pd.getString("BASE_SBSJBJ"));//+
	    	srPd.put("zk_", pd.getString("BASE_ZKL"));//+
	    	srPd.put("sjbj_", pd.getString("BASE_TATOL"));//+
	    	srPd.put("azf_", pd.getString("BASE_AZJ"));//+
	    	srPd.put("ysf_", pd.getString("BASE_YSJ"));//+
	    	srPd.put("yjze_", pd.getString("BASE_YJZE"));//+
	    	srPd.put("yjbl_", pd.getString("BASE_YJBL"));//+
	    	
	    	mv.addObject("CountPd", CountPd);
	    	mv.addObject("srPd", srPd);
	    	mv.addObject("pd", pd);
	    	mv.addObject("id", "ElevatorParam");
	    	//重写编辑和删除的button
	    	String editButtonStr = "<button class='btn  btn-primary btn-sm' title='编辑' onclick=\\\"toEdit(this,'"+tezhongId+"','"+modelsId+"','"+bjcId+"')\\\" type='button'>编辑</button>";
	    	String deleteButtonStr = "<button class='btn  btn-danger btn-sm' title='删除' onclick=\\\"deleteRow(this,'"+elevIds+"')\\\" type='button'>删除</button>";
			String setButtonStr="<button class='btn btn-info btn-sm' title='梯号设置' style='margin-left:5px;' type='button'" +
					" onclick=\\\"setENoRow(this,'"+elevIds+"','"+bjcId+"')\\\">梯号设置</button>";
			mv.addObject("buttonStr", editButtonStr+deleteButtonStr+setButtonStr);
			mv.setViewName("system/e_offer/save_result");
    	} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return mv;
    }*/
    
    /**
     * 调用参考报价
     */
    @RequestMapping(value="setCbj")
    public ModelAndView setCbj(){
    	ModelAndView mv = new ModelAndView();
    	mv.addObject("FLAG", "CBJ");
    	PageData pd = this.getPageData();
    	String bjc_id = pd.getString("BJC_ID");
    	pd.put("BJC_ID", pd.getString("CBJ_BJC_ID"));
    	PageData codPd = new PageData();
    	PageData modelsPd = new PageData();
    	PageData regelevStandardPd = new PageData();
    	try{
    		//根据报价池ID获取COD数据
    		String MODELS = pd.getString("MODELS");
    		if(MODELS.equals("FEISHANG")){
				codPd = e_offerService.findFeishangCOD(pd);
				//页面赋值防止调用前页面hidden值被覆盖
				codPd.put("FEISHANG_ID", pd.getString("FEISHANG_ID"));
				codPd.put("BJC_ID", bjc_id);
				codPd.put("ITEM_ID", pd.getString("ITEM_ID"));
				codPd.put("ELEV_IDS", pd.getString("ELEV_IDS"));
				codPd.put("FEISHANG_SL", pd.getString("FEISHANG_SL"));
				codPd.put("rowIndex", pd.getString("rowIndex"));
				codPd.put("offer_version", pd.getString("offer_version"));
				modelsPd = e_offerService.findModels(pd);
				regelevStandardPd = regelevStandardService.findByModelsId(modelsPd);
				
				PageData offerDetail = e_offerService.findItemInOfferByItem(codPd);
	    		//防止丢失项目台数
	    		if (offerDetail!=null && !offerDetail.isEmpty()) {
	    			String itemelecount=e_offerService.findTempItemEleCountNum(offerDetail);
	    			mv.addObject("itemelecount",itemelecount);
	    		}else {
	    			String itemelecount=e_offerService.findItemEleCountNum(codPd);
	    			mv.addObject("itemelecount",itemelecount);
	    		}
				
				if(StringUtils.isNoneBlank(codPd.getString("FEISHANG_ID"))) {
					codPd.put("view", "edit");
				} else {
					codPd.put("view", "save");
				}
				mv.addObject("pd", codPd);
    			mv.addObject("modelsPd", modelsPd);
    			mv.addObject("regelevStandardPd", regelevStandardPd);
    			mv.addObject("msg", "saveFeishang");
    			mv.setViewName("system/e_offer/feishang");
    		}else if(MODELS.equals("FEISHANGMRL")){
				codPd = e_offerService.findFeishangMRLCOD(pd);
				//页面赋值防止调用前页面hidden值被覆盖
				codPd.put("FEISHANGMRL_ID", pd.getString("FEISHANGMRL_ID"));
				codPd.put("BJC_ID", bjc_id);
				codPd.put("ITEM_ID", pd.getString("ITEM_ID"));
				codPd.put("ELEV_IDS", pd.getString("ELEV_IDS"));
				codPd.put("FEISHANGMRL_SL", pd.getString("FEISHANGMRL_SL"));
				codPd.put("rowIndex", pd.getString("rowIndex"));
				codPd.put("offer_version", pd.getString("offer_version"));
				
				PageData offerDetail = e_offerService.findItemInOfferByItem(codPd);
	    		//防止丢失项目台数
	    		if (offerDetail!=null && !offerDetail.isEmpty()) {
	    			String itemelecount=e_offerService.findTempItemEleCountNum(offerDetail);
	    			mv.addObject("itemelecount",itemelecount);
	    		}else {
	    			String itemelecount=e_offerService.findItemEleCountNum(codPd);
	    			mv.addObject("itemelecount",itemelecount);
	    		}
				
				modelsPd = e_offerService.findModels(pd);
				regelevStandardPd = regelevStandardService.findByModelsId(modelsPd);
				if(StringUtils.isNoneBlank(codPd.getString("FEISHANGMRL_ID"))) {
					codPd.put("view", "edit");
				} else {
					codPd.put("view", "save");
				}
				mv.addObject("pd", codPd);
    			mv.addObject("modelsPd", modelsPd);
    			mv.addObject("regelevStandardPd", regelevStandardPd);
    			mv.addObject("msg", "saveFeishangMrl");
    			mv.setViewName("system/e_offer/feishang_mrl");
			}else if(MODELS.equals("FEIYANG")){
				codPd = e_offerService.findFeiyangCOD(pd);
				//页面赋值防止调用前页面hidden值被覆盖
				codPd.put("FEIYANG_ID", pd.getString("FEIYANG_ID"));
				codPd.put("BJC_ID", bjc_id);
				codPd.put("ITEM_ID", pd.getString("ITEM_ID"));
				codPd.put("ELEV_IDS", pd.getString("ELEV_IDS"));
				codPd.put("FEIYANG_SL", pd.getString("FEIYANG_SL"));
				codPd.put("rowIndex", pd.getString("rowIndex"));
				codPd.put("offer_version", pd.getString("offer_version"));
				
				PageData offerDetail = e_offerService.findItemInOfferByItem(codPd);
	    		//防止丢失项目台数
	    		if (offerDetail!=null && !offerDetail.isEmpty()) {
	    			String itemelecount=e_offerService.findTempItemEleCountNum(offerDetail);
	    			mv.addObject("itemelecount",itemelecount);
	    		}else {
	    			String itemelecount=e_offerService.findItemEleCountNum(codPd);
	    			mv.addObject("itemelecount",itemelecount);
	    		}
				
				modelsPd = e_offerService.findModels(pd);
				regelevStandardPd = regelevStandardService.findByModelsId(modelsPd);
				if(StringUtils.isNoneBlank(codPd.getString("FEIYANG_ID"))) {
					codPd.put("view", "edit");
				} else {
					codPd.put("view", "save");
				}
				mv.addObject("pd", codPd);
    			mv.addObject("modelsPd", modelsPd);
    			mv.addObject("regelevStandardPd", regelevStandardPd);
    			mv.addObject("msg", "saveFeiyang");
    			mv.setViewName("system/e_offer/feiyang3000");
			}else if(MODELS.equals("FEIYANGMRL")){
				codPd = e_offerService.findFeiyangMRLCOD(pd);
				//页面赋值防止调用前页面hidden值被覆盖
				codPd.put("FEIYANGMRL_ID", pd.getString("FEIYANGMRL_ID"));
				codPd.put("BJC_ID", bjc_id);
				codPd.put("ITEM_ID", pd.getString("ITEM_ID"));
				codPd.put("ELEV_IDS", pd.getString("ELEV_IDS"));
				codPd.put("FEIYANGMRL_SL", pd.getString("FEIYANGMRL_SL"));
				codPd.put("rowIndex", pd.getString("rowIndex"));
				codPd.put("offer_version", pd.getString("offer_version"));
				modelsPd = e_offerService.findModels(pd);
				
				PageData offerDetail = e_offerService.findItemInOfferByItem(codPd);
	    		//防止丢失项目台数
	    		if (offerDetail!=null && !offerDetail.isEmpty()) {
	    			String itemelecount=e_offerService.findTempItemEleCountNum(offerDetail);
	    			mv.addObject("itemelecount",itemelecount);
	    		}else {
	    			String itemelecount=e_offerService.findItemEleCountNum(codPd);
	    			mv.addObject("itemelecount",itemelecount);
	    		}
				
				regelevStandardPd = regelevStandardService.findByModelsId(modelsPd);
				if(StringUtils.isNoneBlank(codPd.getString("FEIYANGMRL_ID"))) {
					codPd.put("view", "edit");
				} else {
					codPd.put("view", "save");
				}
				mv.addObject("pd", codPd);
				mv.addObject("modelsPd", modelsPd);
				mv.addObject("regelevStandardPd", regelevStandardPd);
				mv.addObject("msg", "saveFeiyangMRL");
				mv.setViewName("system/e_offer/feiyang3000_mrl");
			}else if(MODELS.equals("FEIYANGXF")){
				codPd = e_offerService.findFeiyangXFCOD(pd);
				//页面赋值防止调用前页面hidden值被覆盖
				codPd.put("FEIYANGXF_ID", pd.getString("FEIYANGXF_ID"));
				codPd.put("BJC_ID", bjc_id);
				codPd.put("ITEM_ID", pd.getString("ITEM_ID"));
				codPd.put("ELEV_IDS", pd.getString("ELEV_IDS"));
				codPd.put("FEIYANGXF_SL", pd.getString("FEIYANGXF_SL"));
				codPd.put("rowIndex", pd.getString("rowIndex"));
				codPd.put("offer_version", pd.getString("offer_version"));
				
				PageData offerDetail = e_offerService.findItemInOfferByItem(codPd);
	    		//防止丢失项目台数
	    		if (offerDetail!=null && !offerDetail.isEmpty()) {
	    			String itemelecount=e_offerService.findTempItemEleCountNum(offerDetail);
	    			mv.addObject("itemelecount",itemelecount);
	    		}else {
	    			String itemelecount=e_offerService.findItemEleCountNum(codPd);
	    			mv.addObject("itemelecount",itemelecount);
	    		}
				
				modelsPd = e_offerService.findModels(pd);
				regelevStandardPd = regelevStandardService.findByModelsId(modelsPd);
				if(StringUtils.isNoneBlank(codPd.getString("FEIYANGXF_ID"))) {
					codPd.put("view", "edit");
				} else {
					codPd.put("view", "save");
				}
				mv.addObject("pd", codPd);
				mv.addObject("modelsPd", modelsPd);
				mv.addObject("regelevStandardPd", regelevStandardPd);
				mv.addObject("msg", "saveFeiyangXF");
				mv.setViewName("system/e_offer/feiyang_xf");
			}else if(MODELS.equals("FEIYUE")){
				codPd = e_offerService.findFeiyueCOD(pd);
				//页面赋值防止调用前页面hidden值被覆盖
				codPd.put("FEIYUE_ID", pd.getString("FEIYUE_ID"));
				codPd.put("BJC_ID", bjc_id);
				codPd.put("ITEM_ID", pd.getString("ITEM_ID"));
				codPd.put("ELEV_IDS", pd.getString("ELEV_IDS"));
				codPd.put("FEIYUE_SL", pd.getString("FEIYUE_SL"));
				codPd.put("rowIndex", pd.getString("rowIndex"));
				codPd.put("offer_version", pd.getString("offer_version"));
				codPd.put("item_id", pd.getString("ITEM_ID"));
				PageData offerDetail = e_offerService.findItemInOfferByItem(codPd);
	    		//防止丢失项目台数
	    		if (offerDetail!=null && !offerDetail.isEmpty()) {
	    			String itemelecount=e_offerService.findTempItemEleCountNum(offerDetail);
	    			mv.addObject("itemelecount",itemelecount);
	    		}else {
	    			String itemelecount=e_offerService.findItemEleCountNum(codPd);
	    			mv.addObject("itemelecount",itemelecount);
	    		}
				
				modelsPd = e_offerService.findModels(pd);
				regelevStandardPd = regelevStandardService.findByModelsId(modelsPd);
				if(StringUtils.isNoneBlank(codPd.getString("FEIYUE_ID"))) {
					codPd.put("view", "edit");
				} else {
					codPd.put("view", "save");
				}
				mv.addObject("pd", codPd);
				mv.addObject("modelsPd", modelsPd);
				mv.addObject("regelevStandardPd", regelevStandardPd);
				mv.addObject("msg", "saveFeiyue");
				mv.setViewName("system/e_offer/feiyue");
			}else if(MODELS.equals("FEIYUEMRL")){
				codPd = e_offerService.findFeiyueMRLCOD(pd);
				//页面赋值防止调用前页面hidden值被覆盖
				codPd.put("FEIYUEMRL_ID", pd.getString("FEIYUEMRL_ID"));
				codPd.put("BJC_ID", bjc_id);
				codPd.put("ITEM_ID", pd.getString("ITEM_ID"));
				codPd.put("ELEV_IDS", pd.getString("ELEV_IDS"));
				codPd.put("FEIYUEMRL_SL", pd.getString("FEIYUEMRL_SL"));
				codPd.put("rowIndex", pd.getString("rowIndex"));
				codPd.put("offer_version", pd.getString("offer_version"));
				
				PageData offerDetail = e_offerService.findItemInOfferByItem(codPd);
	    		//防止丢失项目台数
	    		if (offerDetail!=null && !offerDetail.isEmpty()) {
	    			String itemelecount=e_offerService.findTempItemEleCountNum(offerDetail);
	    			mv.addObject("itemelecount",itemelecount);
	    		}else {
	    			String itemelecount=e_offerService.findItemEleCountNum(codPd);
	    			mv.addObject("itemelecount",itemelecount);
	    		}
	    		
				modelsPd = e_offerService.findModels(pd);
				regelevStandardPd = regelevStandardService.findByModelsId(modelsPd);
				if(StringUtils.isNoneBlank(codPd.getString("FEIYUEMRL_ID"))) {
					codPd.put("view", "edit");
				} else {
					codPd.put("view", "save");
				}
				mv.addObject("pd", codPd);
				mv.addObject("modelsPd", modelsPd);
				mv.addObject("regelevStandardPd", regelevStandardPd);
				mv.addObject("msg", "saveFeiyueMRL");
				mv.setViewName("system/e_offer/feiyue_mrl");
			}else if(MODELS.equals("SHINY")){
				codPd = e_offerService.findShinyCOD(pd);
				//页面赋值防止调用前页面hidden值被覆盖
				codPd.put("SHINY_ID", pd.getString("SHINY_ID"));
				codPd.put("BJC_ID", bjc_id);
				codPd.put("ITEM_ID", pd.getString("ITEM_ID"));
				codPd.put("ELEV_IDS", pd.getString("ELEV_IDS"));
				codPd.put("SHINY_SL", pd.getString("SHINY_SL"));
				codPd.put("rowIndex", pd.getString("rowIndex"));
				codPd.put("offer_version", pd.getString("offer_version"));
				modelsPd = e_offerService.findModels(pd);
				
				PageData offerDetail = e_offerService.findItemInOfferByItem(codPd);
	    		//防止丢失项目台数
	    		if (offerDetail!=null && !offerDetail.isEmpty()) {
	    			String itemelecount=e_offerService.findTempItemEleCountNum(offerDetail);
	    			mv.addObject("itemelecount",itemelecount);
	    		}else {
	    			String itemelecount=e_offerService.findItemEleCountNum(codPd);
	    			mv.addObject("itemelecount",itemelecount);
	    		}
				
				regelevStandardPd = regelevStandardService.findByModelsId(modelsPd);
				if(StringUtils.isNoneBlank(codPd.getString("SHINY_ID"))) {
					codPd.put("view", "edit");
				} else {
					codPd.put("view", "save");
				}
				mv.addObject("pd", codPd);
				mv.addObject("modelsPd", modelsPd);
				mv.addObject("regelevStandardPd", regelevStandardPd);
				mv.addObject("msg", "saveShiny");
				mv.setViewName("system/e_offer/shiny");
			}else if(MODELS.equals("DNP9300")){
				codPd = e_offerService.findDnp9300COD(pd);
				//页面赋值防止调用前页面hidden值被覆盖
				codPd.put("DNP9300_ID", pd.getString("DNP9300_ID"));
				codPd.put("BJC_ID", bjc_id);
				codPd.put("ITEM_ID", pd.getString("ITEM_ID"));
				codPd.put("ELEV_IDS", pd.getString("ELEV_IDS"));
				codPd.put("DNP9300_SL", pd.getString("DNP9300_SL"));
				codPd.put("rowIndex", pd.getString("rowIndex"));
				codPd.put("offer_version", pd.getString("offer_version"));
				modelsPd = e_offerService.findModels(pd);
				
				PageData offerDetail = e_offerService.findItemInOfferByItem(codPd);
	    		//防止丢失项目台数
	    		if (offerDetail!=null && !offerDetail.isEmpty()) {
	    			String itemelecount=e_offerService.findTempItemEleCountNum(offerDetail);
	    			mv.addObject("itemelecount",itemelecount);
	    		}else {
	    			String itemelecount=e_offerService.findItemEleCountNum(codPd);
	    			mv.addObject("itemelecount",itemelecount);
	    		}
				
				regelevStandardPd = regelevStandardService.findByModelsId2(modelsPd);
				if(StringUtils.isNoneBlank(codPd.getString("DNP9300_ID"))) {
					codPd.put("view", "edit");
				} else {
					codPd.put("view", "save");
				}
				mv.addObject("pd", codPd);
				mv.addObject("modelsPd", modelsPd);
				mv.addObject("regelevStandardPd", regelevStandardPd);
				mv.addObject("msg", "saveDnp9300");
				mv.setViewName("system/e_offer/dnp9300");
			}else if(MODELS.equals("DNR")){
				codPd = e_offerService.findDnrCOD(pd);
				//页面赋值防止调用前页面hidden值被覆盖
				codPd.put("DNR_ID", pd.getString("DNR_ID"));
				codPd.put("BJC_ID", bjc_id);
				codPd.put("ITEM_ID", pd.getString("ITEM_ID"));
				codPd.put("ELEV_IDS", pd.getString("ELEV_IDS"));
				codPd.put("DNR_SL", pd.getString("DNR_SL"));
				codPd.put("rowIndex", pd.getString("rowIndex"));
				codPd.put("offer_version", pd.getString("offer_version"));
				modelsPd = e_offerService.findModels(pd);
				
				PageData offerDetail = e_offerService.findItemInOfferByItem(codPd);
	    		//防止丢失项目台数
	    		if (offerDetail!=null && !offerDetail.isEmpty()) {
	    			String itemelecount=e_offerService.findTempItemEleCountNum(offerDetail);
	    			mv.addObject("itemelecount",itemelecount);
	    		}else {
	    			String itemelecount=e_offerService.findItemEleCountNum(codPd);
	    			mv.addObject("itemelecount",itemelecount);
	    		}
				
				regelevStandardPd = regelevStandardService.findByModelsId2(modelsPd);
				if(StringUtils.isNoneBlank(codPd.getString("DNR_ID"))) {
					codPd.put("view", "edit");
				} else {
					codPd.put("view", "save");
				}				
				mv.addObject("pd", codPd);
				mv.addObject("modelsPd", modelsPd);
				mv.addObject("regelevStandardPd", regelevStandardPd);
				mv.addObject("msg", "saveDnr");
				mv.setViewName("system/e_offer/dnr");
			}
    		mv.addObject("cbjFlag","1");
    		//加载省份
			List<PageData> provinceList=cityService.findYSFProvince();
			mv.addObject("provinceList", provinceList);
			//加载城市
			List<PageData> cityList=e_offerService.findAllDestinByProvinceId(codPd);
			mv.addObject("cityList", cityList);
			if(codPd!=null&&codPd.get("trans_more_car")!=null){
				JSONArray jsonArray=JSONArray.fromObject(codPd.get("trans_more_car"));
				mv.addObject("tmc_list",jsonArray);
			}
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
    	}
    	return mv;
    } 
    
    
    /**
     * 调用装潢价格
     */
    @RequestMapping(value="setZhj")
    public ModelAndView setZhj(){
    	ModelAndView mv = new ModelAndView();
    	mv.addObject("FLAG", "ZHJ");
    	PageData pd = this.getPageData();
    	PageData codPd = new PageData();
    	PageData regelevStandardPd = new PageData();
    	try{
    		//根据报价池ID获取COD数据
    		String MODELS = pd.getString("MODELS");
    		if(MODELS.equals("FEISHANG")){
    				pd.put("FEISHANG_ID", pd.getString("ID"));
    				//查询出装潢价格调用对象的COD
    				codPd = e_offerService.findFeishang(pd);
    				//放入装潢价格部分
    				pd.put("JXZH_JM", codPd.containsKey("JXZH_JM")?codPd.getString("JXZH_JM").toString():"");
    				pd.put("JXZH_JMSBH", codPd.containsKey("JXZH_JMSBH")?codPd.getString("JXZH_JMSBH").toString():"");
    				pd.put("JXZH_QWB", codPd.containsKey("JXZH_QWB")?codPd.getString("JXZH_QWB").toString():"");
    				pd.put("JXZH_QWBSBH", codPd.containsKey("JXZH_QWBSBH")?codPd.getString("JXZH_QWBSBH").toString():"");
    				pd.put("JXZH_CWB", codPd.containsKey("JXZH_CWB")?codPd.getString("JXZH_CWB").toString():"");
    				pd.put("JXZH_CWBSBH", codPd.containsKey("JXZH_CWBSBH")?codPd.getString("JXZH_CWBSBH").toString():"");
    				pd.put("JXZH_HWB", codPd.containsKey("JXZH_HWB")?codPd.getString("JXZH_HWB").toString():"");
    				pd.put("JXZH_HWBSBH", codPd.containsKey("JXZH_HWBSBH")?codPd.getString("JXZH_HWBSBH").toString():"");
    				pd.put("JXZH_JDZH", codPd.containsKey("JXZH_JDZH")?codPd.getString("JXZH_JDZH").toString():"");
    				pd.put("JXZH_BXGDD", codPd.containsKey("JXZH_BXGDD")?codPd.getString("JXZH_BXGDD").toString():"");
    				pd.put("JXZH_BXGDB", codPd.containsKey("JXZH_BXGDB")?codPd.getString("JXZH_BXGDB").toString():"");
    				pd.put("JXZH_BGJ", codPd.containsKey("JXZH_BGJ")?codPd.getString("JXZH_BGJ").toString():"");
    				pd.put("JXZH_DBXH", codPd.containsKey("JXZH_DBXH")?codPd.getString("JXZH_DBXH").toString():"");
    				pd.put("JXZH_DBZXHD", codPd.containsKey("JXZH_DBZXHD")?codPd.getString("JXZH_DBZXHD").toString():"");
    				pd.put("JXZH_FZTXH", codPd.containsKey("JXZH_FZTXH")?codPd.getString("JXZH_FZTXH").toString():"");
    				pd.put("JXZH_FZTAZWZ", codPd.containsKey("JXZH_FZTAZWZ")?codPd.getString("JXZH_FZTAZWZ").toString():"");
    				/*codPd.put("FEISHANG_SL", pd.get("FEISHANG_SL").toString());
    				codPd.put("FEISHANG_ZK", pd.get("FEISHANG_ZK").toString());*/
    				regelevStandardPd.put("ZZ", pd.getString("BZ_ZZ"));
    				regelevStandardPd.put("SD", pd.getString("BZ_SD"));
    				regelevStandardPd.put("KMXS", pd.getString("BZ_KMXS"));
    				regelevStandardPd.put("KMKD", pd.getString("BZ_KMKD"));
    				regelevStandardPd.put("C", pd.getString("BZ_C"));
    				regelevStandardPd.put("Z", pd.getString("BZ_Z"));
    				regelevStandardPd.put("M", pd.getString("BZ_M"));
    				regelevStandardPd.put("PRICE", pd.getString("FEISHANG_SBJ"));
        			mv.addObject("pd", pd);
        			mv.addObject("regelevStandardPd", regelevStandardPd);
        			mv.addObject("msg", "saveFeishang");
        			mv.setViewName("system/e_offer/feishang");
    		}else if(MODELS.equals("FEIYANG")){
    			pd = this.getPageData();
				pd.put("FEIYANG_ID", pd.getString("ID"));
				codPd = e_offerService.findFeiyang(pd);//放入装潢价格部分
				pd.put("JXZH_JM", codPd.containsKey("JXZH_JM")?codPd.getString("JXZH_JM").toString():"");
				pd.put("JXZH_JMSBH", codPd.containsKey("JXZH_JMSBH")?codPd.getString("JXZH_JMSBH").toString():"");
				pd.put("JXZH_JMZH", codPd.containsKey("JXZH_JMZH")?codPd.getString("JXZH_JMZH").toString():"");
				pd.put("JXZH_JXZH", codPd.containsKey("JXZH_JXZH")?codPd.getString("JXZH_JXZH").toString():"");
				pd.put("JXZH_QWB", codPd.containsKey("JXZH_QWB")?codPd.getString("JXZH_QWB").toString():"");
				pd.put("JXZH_QWBSBH", codPd.containsKey("JXZH_QWBSBH")?codPd.getString("JXZH_QWBSBH").toString():"");
				pd.put("JXZH_CWB", codPd.containsKey("JXZH_CWB")?codPd.getString("JXZH_CWB").toString():"");
				pd.put("JXZH_CWBSBH", codPd.containsKey("JXZH_CWBSBH")?codPd.getString("JXZH_CWBSBH").toString():"");
				pd.put("JXZH_HWB", codPd.containsKey("JXZH_HWB")?codPd.getString("JXZH_HWB").toString():"");
				pd.put("JXZH_HWBSBH", codPd.containsKey("JXZH_HWBSBH")?codPd.getString("JXZH_HWBSBH").toString():"");
				pd.put("JXZH_JDZH", codPd.containsKey("JXZH_JDZH")?codPd.getString("JXZH_JDZH").toString():"");
				pd.put("JXZH_ZSDD", codPd.containsKey("JXZH_ZSDD")?codPd.getString("JXZH_ZSDD").toString():"");
				pd.put("JXZH_AQC", codPd.containsKey("JXZH_AQC")?codPd.getString("JXZH_AQC").toString():"");
				pd.put("JXZH_BGJ", codPd.containsKey("JXZH_BGJ")?codPd.getString("JXZH_BGJ").toString():"");
				pd.put("JXZH_DBXH", codPd.containsKey("JXZH_DBXH")?codPd.getString("JXZH_DBXH").toString():"");
				pd.put("JXZH_DBZXHD", codPd.containsKey("JXZH_DBZXHD")?codPd.getString("JXZH_DBZXHD").toString():"");
				pd.put("JXZH_YLZHZL", codPd.containsKey("JXZH_YLZHZL")?codPd.getString("JXZH_YLZHZL").toString():"");
				pd.put("JXZH_FSXH", codPd.containsKey("JXZH_FSXH")?codPd.getString("JXZH_FSXH").toString():"");
				pd.put("JXZH_FSAZWZ", codPd.containsKey("JXZH_FSAZWZ")?codPd.getString("JXZH_FSAZWZ").toString():"");
				/*codPd.put("FEIYANG_SL", pd.getString("FEIYANG_SL"));
				codPd.put("FEIYANG_ZK", pd.getString("FEIYANG_ZK"));*/
				regelevStandardPd.put("ZZ", pd.getString("BZ_ZZ"));
				regelevStandardPd.put("SD", pd.getString("BZ_SD"));
				regelevStandardPd.put("KMXS", pd.getString("BZ_KMXS"));
				regelevStandardPd.put("KMKD", pd.getString("BZ_KMKD"));
				regelevStandardPd.put("C", pd.getString("BZ_C"));
				regelevStandardPd.put("Z", pd.getString("BZ_Z"));
				regelevStandardPd.put("M", pd.getString("BZ_M"));
				regelevStandardPd.put("PRICE", pd.getString("FEIYANG_SBJ"));
    			mv.addObject("pd", pd);
    			mv.addObject("regelevStandardPd", regelevStandardPd);
    			mv.addObject("msg", "saveFeiyang");
    			mv.setViewName("system/e_offer/feiyang3000");
			}else if(MODELS.equals("FEIYANGMRL")){
				pd = this.getPageData();
				pd.put("FEIYANGMRL_ID", pd.getString("ID"));
				codPd = e_offerService.findFeiyangMRL(pd);
				pd.put("JXZH_JM", codPd.containsKey("JXZH_JM")?codPd.getString("JXZH_JM").toString():"");
				pd.put("JXZH_JMSBH", codPd.containsKey("JXZH_JMSBH")?codPd.getString("JXZH_JMSBH").toString():"");
				pd.put("JXZH_JMZH", codPd.containsKey("JXZH_JMZH")?codPd.getString("JXZH_JMZH").toString():"");
				pd.put("JXZH_JXZH", codPd.containsKey("JXZH_JXZH")?codPd.getString("JXZH_JXZH").toString():"");
				pd.put("JXZH_QWB", codPd.containsKey("JXZH_QWB")?codPd.getString("JXZH_QWB").toString():"");
				pd.put("JXZH_QWBSBH", codPd.containsKey("JXZH_QWBSBH")?codPd.getString("JXZH_QWBSBH").toString():"");
				pd.put("JXZH_CWB", codPd.containsKey("JXZH_CWB")?codPd.getString("JXZH_CWB").toString():"");
				pd.put("JXZH_CWBSBH", codPd.containsKey("JXZH_CWBSBH")?codPd.getString("JXZH_CWBSBH").toString():"");
				pd.put("JXZH_HWB", codPd.containsKey("JXZH_HWB")?codPd.getString("JXZH_HWB").toString():"");
				pd.put("JXZH_HWBSBH", codPd.containsKey("JXZH_HWBSBH")?codPd.getString("JXZH_HWBSBH").toString():"");
				pd.put("JXZH_JDZH", codPd.containsKey("JXZH_JDZH")?codPd.getString("JXZH_JDZH").toString():"");
				pd.put("JXZH_ZSDD", codPd.containsKey("JXZH_ZSDD")?codPd.getString("JXZH_ZSDD").toString():"");
				pd.put("JXZH_AQC", codPd.containsKey("JXZH_AQC")?codPd.getString("JXZH_AQC").toString():"");
				pd.put("JXZH_BGJ", codPd.containsKey("JXZH_BGJ")?codPd.getString("JXZH_BGJ").toString():"");
				pd.put("JXZH_DBXH", codPd.containsKey("JXZH_DBXH")?codPd.getString("JXZH_DBXH").toString():"");
				pd.put("JXZH_DBZXHD", codPd.containsKey("JXZH_DBZXHD")?codPd.getString("JXZH_DBZXHD").toString():"");
				pd.put("JXZH_YLZHZL", codPd.containsKey("JXZH_YLZHZL")?codPd.getString("JXZH_YLZHZL").toString():"");
				pd.put("JXZH_FSXH", codPd.containsKey("JXZH_FSXH")?codPd.getString("JXZH_FSXH").toString():"");
				pd.put("JXZH_FSAZWZ", codPd.containsKey("JXZH_FSAZWZ")?codPd.getString("JXZH_FSAZWZ").toString():"");
				/*codPd.put("FEIYANGMRL_SL", pd.getString("FEIYANGMRL_SL"));
				codPd.put("FEIYANGMRL_ZK", pd.getString("FEIYANGMRL_ZK"));*/
				regelevStandardPd.put("ZZ", pd.getString("BZ_ZZ"));
				regelevStandardPd.put("SD", pd.getString("BZ_SD"));
				regelevStandardPd.put("KMXS", pd.getString("BZ_KMXS"));
				regelevStandardPd.put("KMKD", pd.getString("BZ_KMKD"));
				regelevStandardPd.put("C", pd.getString("BZ_C"));
				regelevStandardPd.put("Z", pd.getString("BZ_Z"));
				regelevStandardPd.put("M", pd.getString("BZ_M"));
				regelevStandardPd.put("PRICE", pd.getString("FEIYANGMRL_SBJ"));
				mv.addObject("pd", pd);
				mv.addObject("regelevStandardPd", regelevStandardPd);
				mv.addObject("msg", "saveFeiyangMRL");
				mv.setViewName("system/e_offer/feiyang3000_mrl");
			}else if(MODELS.equals("FEIYANGXF")){
				pd = this.getPageData();
				pd.put("FEIYANGXF_ID", pd.getString("ID"));
				codPd = e_offerService.findFeiyangXF(pd);
				pd.put("JXZH_JM", codPd.containsKey("JXZH_JM")?codPd.getString("JXZH_JM").toString():"");
				pd.put("JXZH_JMSBH", codPd.containsKey("JXZH_JMSBH")?codPd.getString("JXZH_JMSBH").toString():"");
				pd.put("JXZH_JMZH", codPd.containsKey("JXZH_JMZH")?codPd.getString("JXZH_JMZH").toString():"");
				pd.put("JXZH_JXZH", codPd.containsKey("JXZH_JXZH")?codPd.getString("JXZH_JXZH").toString():"");
				pd.put("JXZH_QWB", codPd.containsKey("JXZH_QWB")?codPd.getString("JXZH_QWB").toString():"");
				pd.put("JXZH_QWBSBH", codPd.containsKey("JXZH_QWBSBH")?codPd.getString("JXZH_QWBSBH").toString():"");
				pd.put("JXZH_CWB", codPd.containsKey("JXZH_CWB")?codPd.getString("JXZH_CWB").toString():"");
				pd.put("JXZH_CWBSBH", codPd.containsKey("JXZH_CWBSBH")?codPd.getString("JXZH_CWBSBH").toString():"");
				pd.put("JXZH_HWB", codPd.containsKey("JXZH_HWB")?codPd.getString("JXZH_HWB").toString():"");
				pd.put("JXZH_HWBSBH", codPd.containsKey("JXZH_HWBSBH")?codPd.getString("JXZH_HWBSBH").toString():"");
				pd.put("JXZH_JDZH", codPd.containsKey("JXZH_JDZH")?codPd.getString("JXZH_JDZH").toString():"");
				pd.put("JXZH_ZSDD", codPd.containsKey("JXZH_ZSDD")?codPd.getString("JXZH_ZSDD").toString():"");
				pd.put("JXZH_BGJ", codPd.containsKey("JXZH_BGJ")?codPd.getString("JXZH_BGJ").toString():"");
				pd.put("JXZH_DBXH", codPd.containsKey("JXZH_DBXH")?codPd.getString("JXZH_DBXH").toString():"");
				pd.put("JXZH_DBZXHD", codPd.containsKey("JXZH_DBZXHD")?codPd.getString("JXZH_DBZXHD").toString():"");
				pd.put("JXZH_YLZHZL", codPd.containsKey("JXZH_YLZHZL")?codPd.getString("JXZH_YLZHZL").toString():"");
				pd.put("JXZH_FSXH", codPd.containsKey("JXZH_FSXH")?codPd.getString("JXZH_FSXH").toString():"");
				pd.put("JXZH_FSAZWZ", codPd.containsKey("JXZH_FSAZWZ")?codPd.getString("JXZH_FSAZWZ").toString():"");
				/*codPd.put("FEIYANGXF_SL", pd.getString("FEIYANGXF_SL"));
				codPd.put("FEIYANGXF_ZK", pd.getString("FEIYANGXF_ZK"));*/
				regelevStandardPd.put("ZZ", pd.getString("BZ_ZZ"));
				regelevStandardPd.put("SD", pd.getString("BZ_SD"));
				regelevStandardPd.put("KMXS", pd.getString("BZ_KMXS"));
				regelevStandardPd.put("KMKD", pd.getString("BZ_KMKD"));
				regelevStandardPd.put("C", pd.getString("BZ_C"));
				regelevStandardPd.put("Z", pd.getString("BZ_Z"));
				regelevStandardPd.put("M", pd.getString("BZ_M"));
				regelevStandardPd.put("PRICE", pd.getString("FEIYANGXF_SBJ"));
				mv.addObject("pd", pd);
				mv.addObject("regelevStandardPd", regelevStandardPd);
				mv.addObject("msg", "saveFeiyangXF");
				mv.setViewName("system/e_offer/feiyang_xf");
			}else if(MODELS.equals("FEIYUE")){
				pd = this.getPageData();
				pd.put("FEIYUE_ID", pd.getString("ID"));
				codPd = e_offerService.findFeiyue(pd);
				pd.put("JXZH_JM", codPd.containsKey("JXZH_JM")?codPd.getString("JXZH_JM").toString():"");
				pd.put("JXZH_JMSBH", codPd.containsKey("JXZH_JMSBH")?codPd.getString("JXZH_JMSBH").toString():"");
				pd.put("JXZH_JMZH", codPd.containsKey("JXZH_JMZH")?codPd.getString("JXZH_JMZH").toString():"");
				pd.put("JXZH_JXZH", codPd.containsKey("JXZH_JXZH")?codPd.getString("JXZH_JXZH").toString():"");
				pd.put("JXZH_QWB", codPd.containsKey("JXZH_QWB")?codPd.getString("JXZH_QWB").toString():"");
				pd.put("JXZH_QWBSBH", codPd.containsKey("JXZH_QWBSBH")?codPd.getString("JXZH_QWBSBH").toString():"");
				pd.put("JXZH_CWB", codPd.containsKey("JXZH_CWB")?codPd.getString("JXZH_CWB").toString():"");
				pd.put("JXZH_CWBSBH", codPd.containsKey("JXZH_CWBSBH")?codPd.getString("JXZH_CWBSBH").toString():"");
				pd.put("JXZH_HWB", codPd.containsKey("JXZH_HWB")?codPd.getString("JXZH_HWB").toString():"");
				pd.put("JXZH_HWBSBH", codPd.containsKey("JXZH_HWBSBH")?codPd.getString("JXZH_HWBSBH").toString():"");
				pd.put("JXZH_JDZH", codPd.containsKey("JXZH_JDZH")?codPd.getString("JXZH_JDZH").toString():"");
				pd.put("JXZH_ZSDD", codPd.containsKey("JXZH_ZSDD")?codPd.getString("JXZH_ZSDD").toString():"");
				pd.put("JXZH_AQC", codPd.containsKey("JXZH_AQC")?codPd.getString("JXZH_AQC").toString():"");
				pd.put("JXZH_BGJ", codPd.containsKey("JXZH_BGJ")?codPd.getString("JXZH_BGJ").toString():"");
				pd.put("JXZH_DBXH", codPd.containsKey("JXZH_DBXH")?codPd.getString("JXZH_DBXH").toString():"");
				pd.put("JXZH_DBZXHD", codPd.containsKey("JXZH_DBZXHD")?codPd.getString("JXZH_DBZXHD").toString():"");
				pd.put("JXZH_YLZHZL", codPd.containsKey("JXZH_YLZHZL")?codPd.getString("JXZH_YLZHZL").toString():"");
				pd.put("JXZH_FSXH", codPd.containsKey("JXZH_FSXH")?codPd.getString("JXZH_FSXH").toString():"");
				pd.put("JXZH_FSAZWZ", codPd.containsKey("JXZH_FSAZWZ")?codPd.getString("JXZH_FSAZWZ").toString():"");
				/*codPd.put("FEIYUE_SL", pd.getString("FEIYUE_SL"));
				codPd.put("FEIYUE_ZK", pd.getString("FEIYUE_ZK"));*/
				regelevStandardPd.put("ZZ", pd.getString("BZ_ZZ"));
				regelevStandardPd.put("SD", pd.getString("BZ_SD"));
				regelevStandardPd.put("KMXS", pd.getString("BZ_KMXS"));
				regelevStandardPd.put("KMKD", pd.getString("BZ_KMKD"));
				regelevStandardPd.put("C", pd.getString("BZ_C"));
				regelevStandardPd.put("Z", pd.getString("BZ_Z"));
				regelevStandardPd.put("M", pd.getString("BZ_M"));
				regelevStandardPd.put("PRICE", pd.getString("FEIYUE_SBJ"));
				mv.addObject("pd", pd);
				mv.addObject("regelevStandardPd", regelevStandardPd);
				mv.addObject("msg", "saveFeiyue");
				mv.setViewName("system/e_offer/feiyue");
			}else if(MODELS.equals("FEIYUEMRL")){
				pd = this.getPageData();
				pd.put("FEIYUEMRL_ID", pd.getString("ID"));
				codPd = e_offerService.findFeiyueMRL(pd);
				pd.put("JXZH_JM", codPd.containsKey("JXZH_JM")?codPd.getString("JXZH_JM").toString():"");
				pd.put("JXZH_JMSBH", codPd.containsKey("JXZH_JMSBH")?codPd.getString("JXZH_JMSBH").toString():"");
				pd.put("JXZH_JMZH", codPd.containsKey("JXZH_JMZH")?codPd.getString("JXZH_JMZH").toString():"");
				pd.put("JXZH_JXZH", codPd.containsKey("JXZH_JXZH")?codPd.getString("JXZH_JXZH").toString():"");
				pd.put("JXZH_QWB", codPd.containsKey("JXZH_QWB")?codPd.getString("JXZH_QWB").toString():"");
				pd.put("JXZH_QWBSBH", codPd.containsKey("JXZH_QWBSBH")?codPd.getString("JXZH_QWBSBH").toString():"");
				pd.put("JXZH_CWB", codPd.containsKey("JXZH_CWB")?codPd.getString("JXZH_CWB").toString():"");
				pd.put("JXZH_CWBSBH", codPd.containsKey("JXZH_CWBSBH")?codPd.getString("JXZH_CWBSBH").toString():"");
				pd.put("JXZH_HWB", codPd.containsKey("JXZH_HWB")?codPd.getString("JXZH_HWB").toString():"");
				pd.put("JXZH_HWBSBH", codPd.containsKey("JXZH_HWBSBH")?codPd.getString("JXZH_HWBSBH").toString():"");
				pd.put("JXZH_JDZH", codPd.containsKey("JXZH_JDZH")?codPd.getString("JXZH_JDZH").toString():"");
				pd.put("JXZH_ZSDD", codPd.containsKey("JXZH_ZSDD")?codPd.getString("JXZH_ZSDD").toString():"");
				pd.put("JXZH_AQC", codPd.containsKey("JXZH_AQC")?codPd.getString("JXZH_AQC").toString():"");
				pd.put("JXZH_BGJ", codPd.containsKey("JXZH_BGJ")?codPd.getString("JXZH_BGJ").toString():"");
				pd.put("JXZH_DBXH", codPd.containsKey("JXZH_DBXH")?codPd.getString("JXZH_DBXH").toString():"");
				pd.put("JXZH_DBZXHD", codPd.containsKey("JXZH_DBZXHD")?codPd.getString("JXZH_DBZXHD").toString():"");
				pd.put("JXZH_YLZHZL", codPd.containsKey("JXZH_YLZHZL")?codPd.getString("JXZH_YLZHZL").toString():"");
				pd.put("JXZH_FSXH", codPd.containsKey("JXZH_FSXH")?codPd.getString("JXZH_FSXH").toString():"");
				pd.put("JXZH_FSAZWZ", codPd.containsKey("JXZH_FSAZWZ")?codPd.getString("JXZH_FSAZWZ").toString():"");
				/*codPd.put("FEIYUEMRL_SL", pd.getString("FEIYUEMRL_SL"));
				codPd.put("FEIYUEMRL_ZK", pd.getString("FEIYUEMRL_ZK"));*/
				regelevStandardPd.put("ZZ", pd.getString("BZ_ZZ"));
				regelevStandardPd.put("SD", pd.getString("BZ_SD"));
				regelevStandardPd.put("KMXS", pd.getString("BZ_KMXS"));
				regelevStandardPd.put("KMKD", pd.getString("BZ_KMKD"));
				regelevStandardPd.put("C", pd.getString("BZ_C"));
				regelevStandardPd.put("Z", pd.getString("BZ_Z"));
				regelevStandardPd.put("M", pd.getString("BZ_M"));
				regelevStandardPd.put("PRICE", pd.getString("FEIYUEMRL_SBJ"));
				mv.addObject("pd", pd);
				mv.addObject("regelevStandardPd", regelevStandardPd);
				mv.addObject("msg", "saveFeiyueMRL");
				mv.setViewName("system/e_offer/feiyue_mrl");
			}else if(MODELS.equals("SHINY")){
				pd = this.getPageData();
				pd.put("SHINY_ID", pd.getString("ID"));
				codPd = e_offerService.findShiny(pd);
				pd.put("JXZH_JM", codPd.containsKey("JXZH_JM")?codPd.getString("JXZH_JM").toString():"");
				pd.put("JXZH_JMSBH", codPd.containsKey("JXZH_JMSBH")?codPd.getString("JXZH_JMSBH").toString():"");
				pd.put("JXZH_QWB", codPd.containsKey("JXZH_QWB")?codPd.getString("JXZH_QWB").toString():"");
				pd.put("JXZH_QWBSBH", codPd.containsKey("JXZH_QWBSBH")?codPd.getString("JXZH_QWBSBH").toString():"");
				pd.put("JXZH_CWB", codPd.containsKey("JXZH_CWB")?codPd.getString("JXZH_CWB").toString():"");
				pd.put("JXZH_CWBSBH", codPd.containsKey("JXZH_CWBSBH")?codPd.getString("JXZH_CWBSBH").toString():"");
				pd.put("JXZH_HWB", codPd.containsKey("JXZH_HWB")?codPd.getString("JXZH_HWB").toString():"");
				pd.put("JXZH_HWBSBH", codPd.containsKey("JXZH_HWBSBH")?codPd.getString("JXZH_HWBSBH").toString():"");
				pd.put("JXZH_JDZH", codPd.containsKey("JXZH_JDZH")?codPd.getString("JXZH_JDZH").toString():"");
				pd.put("JXZH_JDAQC", codPd.containsKey("JXZH_JDAQC")?codPd.getString("JXZH_JDAQC").toString():"");
				pd.put("JXZH_DBXH", codPd.containsKey("JXZH_DBXH")?codPd.getString("JXZH_DBXH").toString():"");
				pd.put("JXZH_DBZXHD", codPd.containsKey("JXZH_DBZXHD")?codPd.getString("JXZH_DBZXHD").toString():"");
				pd.put("JXZH_FZTXH", codPd.containsKey("JXZH_FSXH")?codPd.getString("JXZH_FSXH").toString():"");
				pd.put("JXZH_FZTAZWZ", codPd.containsKey("JXZH_FSAZWZ")?codPd.getString("JXZH_FSAZWZ").toString():"");
				pd.put("JXZH_BGJ", codPd.containsKey("JXZH_BGJ")?codPd.getString("JXZH_BGJ").toString():"");
				/*codPd.put("SHINY_SL", pd.getString("SHINY_SL"));
				codPd.put("SHINY_ZK", pd.getString("SHINY_ZK"));*/
				regelevStandardPd.put("ZZ", pd.getString("BZ_ZZ"));
				regelevStandardPd.put("SD", pd.getString("BZ_SD"));
				regelevStandardPd.put("KMXS", pd.getString("BZ_KMXS"));
				regelevStandardPd.put("KMKD", pd.getString("BZ_KMKD"));
				regelevStandardPd.put("C", pd.getString("BZ_C"));
				regelevStandardPd.put("Z", pd.getString("BZ_Z"));
				regelevStandardPd.put("M", pd.getString("BZ_M"));
				regelevStandardPd.put("PRICE", pd.getString("SHINY_SBJ"));
				mv.addObject("pd", pd);
				mv.addObject("regelevStandardPd", regelevStandardPd);
				mv.addObject("msg", "saveShiny");
				mv.setViewName("system/e_offer/shiny");
			}
    		//加载省份
			List<PageData> provinceList=cityService.findYSFProvince();
			mv.addObject("provinceList", provinceList);
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
    	}
    	return mv;
    } 
    
    
    /**
     * 删除报价池信息
     */
    @RequestMapping(value="deleteBjc")
    @ResponseBody
    public Object deleteBjc(){
    	Map<String, Object> map = new HashMap<String, Object>();
    	PageData pd = this.getPageData();
    	try{
    		PageData bjcPd = e_offerService.selectBjc(pd);
    		//根据报价编号查找报价表,如果存在即为编辑进来
    		PageData offerdetail = e_offerService.findItemInOffer(pd);
    		//电梯id
    		List<String> eIdList = Arrays.asList(bjcPd.getString("BJC_ELEV").split(","));
    		pd.put("list", eIdList);
    		PageData modelsPd = e_offerService.findModels(pd);
    		String ele_type = modelsPd.getString("ele_type");
    		String modelsName = modelsPd.getString("models_name");
 
    		if(ele_type.equals("DT3")){
    			e_offerService.deleteFeishangByBjc(pd);
    		}else if(ele_type.equals("DT4")){
    			e_offerService.deleteFeiyangByBjc(pd);
    		}else if(ele_type.equals("DT5")){
    			e_offerService.deleteFeiyangMRLByBjc(pd);
    		}else if(ele_type.equals("DT6")){
    			e_offerService.deleteFeiyangXFByBjc(pd);
    		}else if(ele_type.equals("DT7")){
    			e_offerService.deleteFeiyueByBjc(pd);
    		}else if(ele_type.equals("DT8")){
    			e_offerService.deleteFeiyueMRLByBjc(pd);
    		}else if(ele_type.equals("DT1")){
    			e_offerService.deleteDnp9300ByBjc(pd);
    		}else if(ele_type.equals("DT2")){
    			e_offerService.deleteDnrByBjc(pd);
    		}else if(ele_type.equals("DT9")){
    			e_offerService.deleteShinyByBjc(pd);
    		}else if(ele_type.equals("DT10")){
    			e_offerService.deleteFeishangMrlByBjc(pd);
    		}else if(isTezhongdt(ele_type)){
    			e_offerService.deleteTezhongByBjc(pd);
    		}
    		
//    		if(modelsName.equals("飞尚曳引货梯")){
//    			e_offerService.deleteFeishangByBjc(pd);
//    		}else if(modelsName.equals("飞扬3000+")){
//    			e_offerService.deleteFeiyangByBjc(pd);
//    		}else if(modelsName.equals("飞扬3000+MRL")){
//    			e_offerService.deleteFeiyangMRLByBjc(pd);
//    		}else if(modelsName.equals("飞扬消防梯")){
//    			e_offerService.deleteFeiyangXFByBjc(pd);
//    		}else if(modelsName.equals("新飞越")){
//    			e_offerService.deleteFeiyueByBjc(pd);
//    		}else if(modelsName.equals("新飞越MRL")){
//    			e_offerService.deleteFeiyueMRLByBjc(pd);
//    		}else if(modelsName.equals("DNP9300")){
//    			e_offerService.deleteDnp9300ByBjc(pd);
//    		}else if(modelsName.equals("DNR")){
//    			e_offerService.deleteDnrByBjc(pd);
//    		}else if(modelsName.equals("曳引货梯")){
//    			e_offerService.deleteShinyByBjc(pd);
//    		}
    		
    		
			e_offerService.deleteBjc(pd);
			//初始化电梯可报未报
			if(eIdList != null && eIdList.size() > 0) {
				e_offerService.initDetails(pd);
				e_offerService.initTempDetails(pd);
			}
			
			
			//调用汇总数据方法
			PageData apd=new PageData();
			apd.put("ITEM_ID", bjcPd.getString("BJC_ITEM_ID"));
			apd.put("offer_version", bjcPd.get("offer_version"));
        	PageData CountPd=setBjcHzJs(apd);
    		if (offerdetail!=null && !offerdetail.isEmpty()) {
    	   		//(new)删除报价池后同步更新报价汇总
    			CountPd.put("offer_id", offerdetail.get("offer_id"));
        		e_offerService.updateOfferCount(CountPd);
        		e_offerService.updateTempOfferCount(CountPd);
//        		e_offerService.initDetails(CountPd);
			}
        	map.put("CountPd", CountPd);
    		map.put("msg", "success");
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
    	}
    	return JSONObject.fromObject(map);
    }
    
    
    /**
     *跳转到家用梯报价单页面 
     */
    @RequestMapping(value="homeelevParam")
    public ModelAndView homeelevParam(){
    	ModelAndView mv = new ModelAndView();
    	PageData pd = new PageData();
    	try{
    		pd = this.getPageData();
    		//获取电梯id
			String elev_ids = pd.getString("elev_ids");
			//获取该行数的下标
			String rowIndex = pd.getString("rowIndex");
			//获取标准型号id
			String models_id = pd.getString("modelsId");
			//获取数量
			Integer offer_num = Integer.parseInt(pd.getString("offer_num"));
			mv.setViewName("system/e_offer/homeelev");
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
    	}
    	return mv;
    }
	
	/**
	 *跳转到扶梯报价单页面 
	 */
	@RequestMapping(value="escalatorParam")
	public ModelAndView escalatorParam(){
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			//获取电梯id
			String elev_ids = pd.getString("elev_ids");
			//获取该行数的下标
			String rowIndex = pd.getString("rowIndex");
			//获取标准型号id
			String models_id = pd.getString("modelsId");
			//获取数量
			Integer offer_num = Integer.parseInt(pd.getString("offer_num"));
			//获取设备名
			String name = e_offerService.findEscalatorConfigName(models_id);
			//加载设备基础价
			Integer price = e_offerService.findEscalatorStandardPrice(models_id);
			//计算基础设备总价格
			Integer countBasePrice = offer_num*price;
			//获取电梯标准信息
			PageData stdPd = e_offerService.findEscalatorStandard(models_id);
			
			//获取折扣
			//--
			//基础报价信息部分放入PD
			PageData basePd = new PageData();
			basePd.put("rowIndex", (Integer.parseInt(rowIndex)+1));
			basePd.put("models_id", models_id);
			basePd.put("elev_ids", elev_ids);
			basePd.put("offer_num", offer_num);
			basePd.put("price", price);
			basePd.put("name", name);
			basePd.put("stdPd", stdPd);
			basePd.put("countBasePrice", countBasePrice);
			
			//加载省份
			List<PageData> provinceList=cityService.findYSFProvince();
			mv.addObject("provinceList", provinceList);
			//加载城市
			List<PageData> cityList=cityService.findAllCityByProvinceId(pd);
			mv.addObject("cityList", cityList);
			
			mv.addObject("basePd", basePd);
			mv.setViewName("system/e_offer/escalator");
			
			mv.addObject("msg", "escalatorAdd");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	
	/**
	 *查询价格 
	 */
	@RequestMapping(value="setPrice")
	@ResponseBody
	public Object setPrice(){
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		PageData dataPd = new PageData();
		try{
			pd = this.getPageData();
			String keyword = pd.getString("keyword");
			String price_type= e_offerService.findPriceTypeByKeyWord(keyword);
			if(price_type.equals("1")){//选项类型,总价
				dataPd = e_offerService.findPriceOption(pd);
				//获取该选项总价
				float price = Float.parseFloat((String)dataPd.get("price"));
				//获取单位
				String unit = (String)dataPd.get("unit");
				//获取备注
				String remark = (String)dataPd.get("remark");
				//获取交货期
				String dlvr_date = (String)dataPd.get("dlvr_date");
				
				//计算总价之后放入map
				map.put("price", price);
				map.put("unit", unit==null?"--":unit);
				map.put("remark", remark==null?"--":remark);
				map.put("dlvr_date", dlvr_date==null?"--":dlvr_date);
			}else if(price_type.equals("2")){//单价
				dataPd = e_offerService.findPriceUnit(pd);
				//获取单价
				float unitPrice = Float.parseFloat((String)dataPd.get("price"));
				//获取数量
				Integer num = Integer.parseInt((String)pd.get("param"));
				//获取单位
				String unit = (String)dataPd.get("unit");
				//获取备注
				String remark = (String)dataPd.get("remark");
				//获取交货期
				String dlvr_date = (String)dataPd.get("dlvr_date");
				
				//计算总价之后放入map
				map.put("price", unitPrice*num);
				map.put("unit", unit==null?"--":unit);
				map.put("remark", remark==null?"--":remark);
				map.put("dlvr_date", dlvr_date==null?"--":dlvr_date);
			}else if(price_type.equals("0")){//加价公式
				dataPd = e_offerService.findPriceFormula(pd);
				//获取加价公式
				String formula = (String)dataPd.get("formula");
				//获取页面传入参数
				String param = (String)pd.get("param");
				//获取单位
				String unit = (String)dataPd.get("unit");
				//获取备注
				String remark = (String)dataPd.get("remark");
				//获取交货期
				String dlvr_date = (String)dataPd.get("dlvr_date");
				formula = formula.replaceAll("H", param);
				ScriptEngineManager manager = new ScriptEngineManager();  
		        ScriptEngine engine = manager.getEngineByName("js");  
				float price = Float.parseFloat(engine.eval(formula).toString());
				
				//计算总价之后放入map
				map.put("price", price);
				map.put("unit", unit==null?"--":unit);
				map.put("remark", remark==null?"--":remark);
				map.put("dlvr_date", dlvr_date==null?"--":dlvr_date);
			}else if(price_type.equals("3")){//单价选项,固定数量为1
				dataPd = e_offerService.findPriceUnit(pd);
				//获取单价
				float price = Float.parseFloat((String)dataPd.get("price"));
				//获取单位
				String unit = (String)dataPd.get("unit");
				//获取备注
				String remark = (String)dataPd.get("remark");
				//获取交货期
				String dlvr_date = (String)dataPd.get("dlvr_date");
				
				//计算总价之后放入map
				map.put("price", price);
				map.put("unit", unit==null?"--":unit);
				map.put("remark", remark==null?"--":remark);
				map.put("dlvr_date", dlvr_date==null?"--":dlvr_date);
			}else if(price_type.equals("4")){//选项类型,多选
				String param = pd.get("param").toString();
				List<String> paramList = Arrays.asList(param.split(","));
				pd.put("list", paramList);
				dataPd = e_offerService.findPriceOptions(pd);
				//获取单价
				if(dataPd!=null){
					float price = Float.parseFloat(dataPd.get("price").toString());
					//计算总价之后放入map
					map.put("price", price);
				}else{
					map.put("price", "--");
				}
			}
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return map;
	}
	
	@RequestMapping(value="escalatorAdd")
	public ModelAndView escalatorAdd(){
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		try{
			//获取页面
			pd = this.getPageData();
			//拼接基本参数json
			String BASE_SPTJ = pd.get("BASE_SPTJ").toString();
			String BASE_TSGD = pd.get("BASE_TSGD").toString();
			String BASE_SPKJ = pd.get("BASE_SPKJ").toString();
			String BASE_YXSD = pd.get("BASE_YXSD").toString();
			String BASE_SXDY = pd.get("BASE_SXDY").toString();
			String BASE_ZMDY = pd.get("BASE_ZMDY").toString();
			String BASE_PL = pd.get("BASE_PL").toString();
			String BASE_AZHJ = pd.get("BASE_AZHJ").toString();
			String BASE_FSLX = pd.get("BASE_FSLX").toString();
			String BASE_FSGD = pd.get("BASE_FSGD").toString();
			String BASE_ZJZCSL = pd.get("BASE_ZJZCSL").toString();
			String BASE_BZXS = pd.get("BASE_BZXS").toString();
			String BASE_YSFS = pd.get("BASE_YSFS").toString();
			String BASE_JHXT = pd.get("BASE_JHXT").toString();
			String BASE_TJSDJC = pd.get("BASE_TJSDJC").toString();
			String BASE_TJXDJC = pd.get("BASE_TJXDJC").toString();
			String baseJsonStr = "{'BASE_SPTJ':'"+BASE_SPTJ+"','BASE_TSGD':'"+BASE_TSGD+"','BASE_SPKJ':'"+BASE_SPKJ+"','BASE_YXSD':'"+BASE_YXSD+"','BASE_SXDY':'"
					+BASE_SXDY+"','BASE_ZMDY':'"+BASE_ZMDY+"','BASE_PL':'"+BASE_PL+"','BASE_AZHJ':'"+BASE_AZHJ+"','BASE_FSLX':'"+BASE_FSLX+"','BASE_FSGD':'"
					+BASE_FSGD+"','BASE_ZJZCSL':'"+BASE_ZJZCSL+"','BASE_BZXS':'"+BASE_BZXS+"','BASE_YSFS':'"+BASE_YSFS+"','BASE_JHXT':'"+BASE_JHXT+"','BASE_TJSDJC':'"
					+BASE_TJSDJC+"','BASE_TJXDJC':'"+BASE_TJXDJC+"'}";
			System.out.println(baseJsonStr);
			
			//拼接部件参数json
			String PART_JSJ = pd.get("PART_JSJ").toString();
			String PART_TJLX = pd.get("PART_TJLX").toString();
			String PART_TJYS = pd.get("PART_TJYS").toString();
			String PART_TJZFX = pd.containsKey("PART_TJZFX")?pd.get("PART_TJZFX").toString():"0";
			String PART_TJBKCZ = pd.get("PART_TJBKCZ").toString();
			String PART_FSDGCZ = pd.get("PART_FSDGCZ").toString();
			String PART_FSDGG = pd.get("PART_FSDGG").toString();
			String PART_WQBCZ = pd.get("PART_WQBCZ").toString();
			String PART_NWGBCZ = pd.get("PART_NWGBCZ").toString();
			String PART_SCTBJHDGB = pd.get("PART_SCTBJHDGB").toString();
			String PART_SCB = pd.get("PART_SCB").toString();
			String PART_QDFS = pd.get("PART_QDFS").toString();
			String partJsonStr = "{'PART_JSJ':'"+PART_JSJ+"','PART_TJLX':'"+PART_TJLX+"','PART_TJYS':'"+PART_TJYS+"','PART_TJZFX':'"+PART_TJZFX+"','PART_TJBKCZ':'"
					+PART_TJBKCZ+"','PART_FSDGCZ':'"+PART_FSDGCZ+"','PART_FSDGG':'"+PART_FSDGG+"','PART_WQBCZ':'"+PART_WQBCZ+"','PART_NWGBCZ':'"
					+PART_NWGBCZ+"','PART_SCTBJHDGB':'"+PART_SCTBJHDGB+"','PART_SCB':'"+PART_SCB+"','PART_QDFS':'"+PART_QDFS+"'}";
			System.out.println(partJsonStr);
			
			//保存标准参数json
			String STD_JTAN = pd.containsKey("STD_JTAN")?pd.get("STD_JTAN").toString():"0";
			String STD_YSKG = pd.containsKey("STD_YSKG")?pd.get("STD_YSKG").toString():"0";
			String STD_FSJCKBHKG = pd.containsKey("STD_FSJCKBHKG")?pd.get("STD_FSJCKBHKG").toString():"0";
			String STD_TJLDLBHKG = pd.containsKey("STD_TJLDLBHKG")?pd.get("STD_TJLDLBHKG").toString():"0";
			String STD_TJXXBH = pd.containsKey("STD_TJXXBH")?pd.get("STD_TJXXBH").toString():"0";
			String STD_QXJCXBH = pd.containsKey("STD_QXJCXBH")?pd.get("STD_QXJCXBH").toString():"0";
			String STD_DJHZBH = pd.containsKey("STD_DJHZBH")?pd.get("STD_DJHZBH").toString():"0";
			String STD_JFHB = pd.containsKey("STD_JFHB")?pd.get("STD_JFHB").toString():"0";
			String STD_DJGZBH = pd.containsKey("STD_DJGZBH")?pd.get("STD_DJGZBH").toString():"0";
			String STD_DJGRBH = pd.containsKey("STD_DJGRBH")?pd.get("STD_DJGRBH").toString():"0";
			String STD_SCBHKG = pd.containsKey("STD_SCBHKG")?pd.get("STD_SCBHKG").toString():"0";
			String STD_WXSDZZ = pd.containsKey("STD_WXSDZZ")?pd.get("STD_WXSDZZ").toString():"0";
			String STD_QDJL = pd.containsKey("STD_QDJL")?pd.get("STD_QDJL").toString():"0";
			String STD_FNZBH = pd.containsKey("STD_FNZBH")?pd.get("STD_FNZBH").toString():"0";
			String STD_FSDFJDL = pd.containsKey("STD_FSDFJDL")?pd.get("STD_FSDFJDL").toString():"0";
			String STD_GZZDQJKKG = pd.containsKey("STD_GZZDQJKKG")?pd.get("STD_GZZDQJKKG").toString():"0";
			String STD_TJFJDS = pd.containsKey("STD_TJFJDS")?pd.get("STD_TJFJDS").toString():"0";
			String STD_QDLDLBH = pd.containsKey("STD_QDLDLBH")?pd.get("STD_QDLDLBH").toString():"0";
			String STD_SDJXCZ = pd.containsKey("STD_SDJXCZ")?pd.get("STD_SDJXCZ").toString():"0";
			String STD_SDPCZZ = pd.containsKey("STD_SDPCZZ")?pd.get("STD_SDPCZZ").toString():"0";
			String STD_GBJXKG = pd.containsKey("STD_GBJXKG")?pd.get("STD_GBJXKG").toString():"0";
			String STD_WQMS = pd.containsKey("STD_WQMS")?pd.get("STD_WQMS").toString():"0";
			String STD_FSDSDJK = pd.containsKey("STD_FSDSDJK")?pd.get("STD_FSDSDJK").toString():"0";
			String STD_TJYSBH = pd.containsKey("STD_TJYSBH")?pd.get("STD_TJYSBH").toString():"0";
			String STD_TJCSBH = pd.containsKey("STD_TJCSBH")?pd.get("STD_TJCSBH").toString():"0";
			String STD_ZDJLCXBJ = pd.containsKey("STD_ZDJLCXBJ")?pd.get("STD_ZDJLCXBJ").toString():"0";
			String STD_GZXS = pd.containsKey("STD_GZXS")?pd.get("STD_GZXS").toString():"0";
			String STD_TJJXZM = pd.containsKey("STD_TJJXZM")?pd.get("STD_TJJXZM").toString():"0";
			String STD_SXJFTB = pd.containsKey("STD_SXJFTB")?pd.get("STD_SXJFTB").toString():"0";
			String STD_FJZDQ = pd.containsKey("STD_FJZDQ")?pd.get("STD_FJZDQ").toString():"0";
			String STD_JXSB = pd.containsKey("STD_JXSB")?pd.get("STD_JXSB").toString():"0";
			String STD_JXXD = pd.containsKey("STD_JXXD")?pd.get("STD_JXXD").toString():"0";
			String STD_WQAQZZ = pd.containsKey("STD_WQAQZZ")?pd.get("STD_WQAQZZ").toString():"0";
			String STD_FSDDDBH = pd.containsKey("STD_FSDDDBH")?pd.get("STD_FSDDDBH").toString():"0";
			String STD_DLFDLJQ = pd.containsKey("STD_DLFDLJQ")?pd.get("STD_DLFDLJQ").toString():"0";

			String stdJsonStr = "{'STD_JTAN':'"+STD_JTAN+"','STD_YSKG':'"+STD_YSKG+"','STD_FSJCKBHKG':'"+STD_FSJCKBHKG+"','STD_TJLDLBHKG':'"+STD_TJLDLBHKG+"','STD_TJXXBH':'"
					+STD_TJXXBH+"','STD_QXJCXBH':'"+STD_QXJCXBH+"','STD_DJHZBH':'"+STD_DJHZBH+"','STD_JFHB':'"+STD_JFHB+"','STD_DJGZBH':'"
					+STD_DJGZBH+"','STD_DJGRBH':'"+STD_DJGRBH+"','STD_SCBHKG':'"+STD_SCBHKG+"','STD_WXSDZZ':'"+STD_WXSDZZ+"','STD_QDJL':'"
					+STD_QDJL+"'STD_FNZBH':'"+STD_FNZBH+"','STD_FSDFJDL':'"+STD_FSDFJDL+"','STD_GZZDQJKKG':'"+STD_GZZDQJKKG+"','STD_TJFJDS':'"+STD_TJFJDS+"','STD_QDLDLBH':'"
					+STD_QDLDLBH+"','STD_SDJXCZ':'"+STD_SDJXCZ+"','STD_SDPCZZ':'"+STD_SDPCZZ+"','STD_GBJXKG':'"+STD_GBJXKG+"','STD_WQMS':'"+STD_WQMS+"','STD_FSDSDJK':'"
					+STD_FSDSDJK+"','STD_TJYSBH':'"+STD_TJYSBH+"','STD_TJCSBH':'"+STD_TJCSBH+"','STD_ZDJLCXBJ':'"+STD_ZDJLCXBJ+"','STD_GZXS':'"+STD_GZXS+"','STD_TJJXZM':'"
					+STD_TJJXZM+"','STD_SXJFTB':'"+STD_SXJFTB+"','STD_FJZDQ':'"+STD_FJZDQ+"','STD_JXSB':'"+STD_JXSB+"','STD_JXXD':'"+STD_JXXD+"','STD_WQAQZZ':'"
					+STD_WQAQZZ+"','STD_FSDDDBH':'"+STD_FSDDDBH+"','STD_DLFDLJQ':'"+STD_DLFDLJQ+"'}";
			System.out.println(stdJsonStr);
			
			//保存选配参数
			String OPT_AQZDQ = pd.containsKey("OPT_AQZDQ")?pd.get("OPT_AQZDQ").toString():"0";
			String OPT_GCD = pd.containsKey("OPT_GCD")?pd.get("OPT_GCD").toString():"0";
			String OPT_JTLXD = pd.containsKey("OPT_JTLXD")?pd.get("OPT_JTLXD").toString():"0";
			String OPT_ZDQMSJK = pd.containsKey("OPT_ZDQMSJK")?pd.get("OPT_ZDQMSJK").toString():"0";
			String OPT_ZDJY = pd.containsKey("OPT_ZDJY")?pd.get("OPT_ZDJY").toString():"0";
			String OPT_QDLLZ = pd.containsKey("OPT_QDLLZ")?pd.get("OPT_QDLLZ").toString():"0";
			String OPT_WQZM = pd.containsKey("OPT_WQZM")?pd.get("OPT_WQZM").toString():"0";
			String OPT_TJFTBH = pd.containsKey("OPT_TJFTBH")?pd.get("OPT_TJFTBH").toString():"0";
			String OPT_FSDDDBHZZ = pd.containsKey("OPT_FSDDDBHZZ")?pd.get("OPT_FSDDDBHZZ").toString():"0";
			String OPT_ZDWQJXKG = pd.containsKey("OPT_ZDWQJXKG")?pd.get("OPT_ZDWQJXKG").toString():"0";
			String OPT_SCZM = pd.containsKey("OPT_SCZM")?pd.get("OPT_SCZM").toString():"0";
			String OPT_YSFLQ = pd.containsKey("OPT_YSFLQ")?pd.get("OPT_YSFLQ").toString():"0";
			String OPT_FHBH = pd.containsKey("OPT_FHBH")?pd.get("OPT_FHBH").toString():"0";
			String OPT_TJLFHZ = pd.containsKey("OPT_TJLFHZ")?pd.get("OPT_TJLFHZ").toString():"0";
			String OPT_WZSWZ = pd.get("OPT_WZSWZ").toString();
			String OPT_ZSBCL = pd.get("OPT_ZSBCL").toString();
			String OPT_ZSBHD = pd.get("OPT_ZSBHD").toString();
			String OPT_WXHL = pd.get("OPT_WXHL").toString();
			String OPT_DZGSS = pd.get("OPT_DZGSS").toString();
			String OPT_FPZZ = pd.containsKey("OPT_FPZZ")?pd.get("OPT_FPZZ").toString():"0";
			String OPT_HJJR = pd.containsKey("OPT_HJJR")?pd.get("OPT_HJJR").toString():"0";
			String OPT_SCJR = pd.containsKey("OPT_SCJR")?pd.get("OPT_SCJR").toString():"0";
			String OPT_FSJR = pd.containsKey("OPT_FSJR")?pd.get("OPT_FSJR").toString():"0";
			String optJsonStr = "{'OPT_AQZDQ':'"+OPT_AQZDQ+"','OPT_GCD':'"+OPT_GCD+"','OPT_JTLXD':'"+OPT_JTLXD+"','OPT_ZDQMSJK':'"+OPT_ZDQMSJK+"','OPT_ZDJY':'"
					+OPT_ZDJY+"','OPT_QDLLZ':'"+OPT_QDLLZ+"','OPT_WQZM':'"+OPT_WQZM+"','OPT_TJFTBH':'"+OPT_TJFTBH+"','OPT_FSDDDBHZZ':'"
					+OPT_FSDDDBHZZ+"','OPT_ZDWQJXKG':'"+OPT_ZDWQJXKG+"','OPT_SCZM':'"+OPT_SCZM+"','OPT_YSFLQ':'"+OPT_YSFLQ+"','OPT_FHBH':'"
					+OPT_FHBH+"'OPT_TJLFHZ':'"+OPT_TJLFHZ+"','OPT_WZSWZ':'"+OPT_WZSWZ+"','OPT_ZSBCL':'"+OPT_ZSBCL+"','OPT_ZSBHD':'"+OPT_ZSBHD+"','OPT_WXHL':'"
					+OPT_WXHL+"','OPT_DZGSS':'"+OPT_DZGSS+"','OPT_FPZZ':'"+OPT_FPZZ+"','OPT_HJJR':'"+OPT_HJJR+"','OPT_SCJR':'"+OPT_SCJR+"','OPT_FSJR':'"
					+OPT_FSJR+"'}";
			System.out.println(optJsonStr);
			
			//保存室内外环境参数
			String ENV_ZDJY = pd.get("ENV_ZDJY_VAL").toString();
			String ENV_DJ = pd.get("ENV_DJ_VAL").toString();
			String ENV_KZXT = pd.get("ENV_KZXT_VAL").toString();
			String ENV_HDGBLJC = pd.get("ENV_HDGBLJC_VAL").toString();
			String ENV_SWXFSD = pd.get("ENV_SWXFSD_VAL").toString();
			String ENV_NWGBBXG = pd.get("ENV_NWGBBXG_VAL").toString();
			String ENV_WQBXG = pd.get("ENV_WQBXG_VAL").toString();
			String ENV_WZSBBXG = pd.get("ENV_WZSBBXG_VAL").toString();
			String ENV_FSDGBXG = pd.get("ENV_FSDGBXG_VAL").toString();
			String ENV_JSGJPSBYQ = pd.get("ENV_JSGJPSBYQ_VAL").toString();
			String ENV_JSGJRJDX = pd.get("ENV_JSGJRJDX_VAL").toString();
			String ENV_FXCL = pd.get("ENV_FXCL_VAL").toString();
			String ENV_DKLCL = pd.get("ENV_DKLCL_VAL").toString();
			String ENV_BQZ = pd.get("ENV_BQZ_VAL").toString();
			String ENV_YSFLQZZ = pd.get("ENV_YSFLQZZ_VAL").toString();
			String ENV_FHBH = pd.get("ENV_FHBH_VAL").toString();
			String ENV_TJLFHZ = pd.get("ENV_TJLFHZ_VAL").toString();
			String ENV_HJJR = pd.get("ENV_HJJR_VAL").toString();
			String ENV_SCJR = pd.get("ENV_SCJR_VAL").toString();
			String ENV_FSJR = pd.get("ENV_FSJR_VAL").toString();

			String envJsonStr = "{'ENV_ZDJY':'"+ENV_ZDJY+"','ENV_DJ':'"+ENV_DJ+"','ENV_KZXT':'"+ENV_KZXT+"','ENV_HDGBLJC':'"+ENV_HDGBLJC+"','ENV_SWXFSD':'"
					+ENV_SWXFSD+"','ENV_NWGBBXG':'"+ENV_NWGBBXG+"','ENV_WQBXG':'"+ENV_WQBXG+"','ENV_WZSBBXG':'"+ENV_WZSBBXG+"','ENV_FSDGBXG':'"
					+ENV_FSDGBXG+"','ENV_JSGJPSBYQ':'"+ENV_JSGJPSBYQ+"','ENV_JSGJRJDX':'"+ENV_JSGJRJDX+"','ENV_FXCL':'"+ENV_FXCL+"','ENV_DKLCL':'"
					+ENV_DKLCL+"'ENV_BQZ':'"+ENV_BQZ+"','ENV_YSFLQZZ':'"+ENV_YSFLQZZ+"','ENV_FHBH':'"+ENV_FHBH+"','ENV_TJLFHZ':'"+ENV_TJLFHZ+"','ENV_HJJR':'"
					+ENV_HJJR+"','ENV_SCJR':'"+ENV_SCJR+"','ENV_FSJR':'"+ENV_FSJR+"'}";
			System.out.println(envJsonStr);
			//保存报价明细
			//e_offerService.saveEscalator(pd);
			//是否有非标项
			
			String rowIndex = pd.get("rowIndex").toString();
			String elev_ids = pd.get("elev_ids").toString();
			String models_id = pd.get("models_id").toString();
			String esca_angle = pd.get("esca_angle").toString();
			String esca_spec = pd.get("esca_spec").toString();
			String esca_width = pd.get("esca_width").toString();
			String esca_num = pd.get("esca_num").toString();
			String discount = pd.get("discount").toString();
			String floor = pd.get("floor").toString();
			String eqpt_price = pd.get("eqpt_price").toString();
			String disc_price = pd.get("disc_price").toString();
			String install_price = pd.get("install_price").toString();
			String trans_price = pd.get("trans_price").toString();
			String last_offer = pd.get("last_offer").toString();
			
			//清单数据拼接json,编辑/保存用
			/*String jsonStr = "{'models_id':"+models_id+"','elev_ids':'"+elev_ids+"','rowIndex':'"+rowIndex+"','esca_angle':'"+esca_angle+"','esca_spec':'"+esca_spec+"','esca_width':'"+esca_width+"','esca_num':'"
					+esca_num+"','discount':'"+discount+"','floor':'"+floor+"','eqpt_price':'"+eqpt_price+"','disc_price':'"+disc_price+"','install_price':'"+install_price+"','trans_price':'"+trans_price+"','last_offer':'"+last_offer+"',"
					+"'esca_base':'"+baseJsonStr+"','esca_part':'"+partJsonStr+"','esca_std':'"+stdJsonStr+"','esca_opt':'"+optJsonStr+"','esca_env':'"+envJsonStr+"'}";*/
			String jsonStr = "{\\\"models_id\\\":\\\""+models_id+"\\\",\\\"elev_ids\\\":\\\""+elev_ids+"\\\",\\\"rowIndex\\\":\\\""+rowIndex+"\\\",\\\"esca_angle\\\":\\\""+esca_angle+"\\\",\\\"esca_spec\\\":\\\""+esca_spec+"\\\",\\\"esca_width\\\":\\\""+esca_width+"\\\",\\\"esca_num\\\":\\\""
					+esca_num+"\\\",\\\"discount\\\":\\\""+discount+"\\\",\\\"floor\\\":\\\""+floor+"\\\",\\\"eqpt_price\\\":\\\""+eqpt_price+"\\\",\\\"disc_price\\\":\\\""+disc_price+"\\\",\\\"install_price\\\":\\\""+install_price+"\\\",\\\"trans_price\\\":\\\""+trans_price+"\\\",\\\"last_offer\\\":\\\""+last_offer+"\\\","
					+"\\\"esca_base\\\":\\\""+baseJsonStr+"\\\",\\\"esca_part\\\":\\\""+partJsonStr+"\\\",\\\"esca_std\\\":\\\""+stdJsonStr+"\\\",\\\"esca_opt\\\":\\\""+optJsonStr+"\\\",\\\"esca_env\\\":\\\""+envJsonStr+"\\\"}";
			System.out.println(jsonStr);
			
			mv.addObject("jsonStr", jsonStr);
			mv.addObject("escalatorPd", pd);
			mv.addObject("rowIndex", rowIndex);
			mv.addObject("floor", floor);
			mv.addObject("discount", discount);
			mv.addObject("eqpt_price", eqpt_price);
			mv.addObject("disc_price", disc_price);
			mv.addObject("install_price", install_price);
			mv.addObject("trans_price", trans_price);
			mv.addObject("last_offer", last_offer);
			mv.addObject("id", "ElevatorParam");
			mv.setViewName("system/e_offer/save_result");
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return mv;
	}
	
	
	//改变省份联动城市
	@RequestMapping(value="setCity")
	@ResponseBody
	public Object setCity(){
		JSONArray result = new JSONArray();
		try{
			PageData pd = this.getPageData();
			List<PageData> destinList = e_offerService.findAllDestinByProvinceId(pd);
			result.addAll(destinList);
			return result;
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return result;
	}
	
	/**
	 *计算运输价格 
	 */
	@RequestMapping(value="setPriceTrans")
	@ResponseBody
	public Object setPriceTrans(){
		HashMap<String, Object> map = new HashMap<String, Object>();
		try{
			Integer countPrice = 0;
			PageData pd = this.getPageData();
			String transType= pd.get("transType").toString();
			PageData transPd = e_offerService.findTrans(pd);
			if(transType.equals("1")){//整车
				String zcStr = pd.get("zcStr").toString();
				JSONArray jsonArray = JSONArray.fromObject(zcStr);
				for(int i =0;i<jsonArray.size();i++){
					JSONObject jsonObj = jsonArray.getJSONObject(i);
					String carType = jsonObj.get("carType").toString();
					Integer num = Integer.parseInt(jsonObj.get("num").toString());
					Integer price = 0;
					if(carType.equals("5")){
						price = Integer.parseInt(transPd.get("five_t").toString());
					}else if(carType.equals("8")){
						price = Integer.parseInt(transPd.get("eight_t").toString());
					}else if(carType.equals("10")){
						price = Integer.parseInt(transPd.get("ten_t").toString());
					}else if(carType.equals("20")){
						price = Integer.parseInt(transPd.get("twenty_t").toString());
					}
					countPrice += price*num;
				}
			}else if(transType.equals("2")){//零担
				Integer price = Integer.parseInt(transPd.get("less_carLoad").toString());
				Integer less_num = Integer.parseInt(pd.get("less_num").toString());
				countPrice = price*less_num;
			}
			map.put("countPrice", countPrice);
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return JSONObject.fromObject(map);
	}

    // 生成报价价格表
	@RequestMapping("/offer_count")
	@ResponseBody
	public Object transformPDf() throws DocumentException, IOException {
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String, Object> map = new HashMap<String, Object>();
		//pdf------
		Document doc = new Document();
		PdfWriter writer = PdfWriter.getInstance(doc, new FileOutputStream("C:\\text.pdf")); // 创建pdf文件
		BaseFont bfTitle = BaseFont.createFont("C:/WINDOWS/Fonts/SIMSUN.TTC,1", BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
		Font title = new Font(bfTitle, 18, Font.BOLD);// 标题字体
		Font mintitle = new Font(bfTitle, 14, Font.NORMAL);// 小标题字体
		Font titleFont = new Font(bfTitle, 12, Font.NORMAL);// 内容字体
		
		doc.open(); 
		Paragraph titleP = new Paragraph("项目报价价格表\n\n", mintitle);
		titleP.setAlignment(titleP.ALIGN_CENTER);
		doc.add(titleP);
		
		PdfPTable table = new PdfPTable(12); // 创建表格对象 12代表列
		PdfPCell cell = new PdfPCell();
		table.setWidthPercentage(100);
		table.setWidthPercentage(100);
		// 第0行
		table.addCell(new Paragraph("梯号", titleFont)); 
		table.addCell(new Paragraph("型号", titleFont));
		table.addCell(new Paragraph("载重", titleFont)); 
		table.addCell(new Paragraph("速度", titleFont)); 
		table.addCell(new Paragraph("层站", titleFont)); 
		table.addCell(new Paragraph("提升高度", titleFont)); 
		table.addCell(new Paragraph("数量", titleFont)); 
		table.addCell(new Paragraph("设备费单价", titleFont)); 
		table.addCell(new Paragraph("安装费单价", titleFont)); 
		table.addCell(new Paragraph("运保费单价", titleFont)); 
		table.addCell(new Paragraph("单价", titleFont)); 
		table.addCell(new Paragraph("总价", titleFont)); 
		
		
		//查询出该项目的报价信息
		try 
		{
			List<PageData> bjc_list=e_offerService.bjc_list(pd);
			
			for(int i=0;i<bjc_list.size();i++)
			{
				PageData pdel = bjc_list.get(i);
				double JCJ =Double.parseDouble(pdel.getString("BJC_SBJ"));//基础价格
				double ZHJ =Double.parseDouble(pdel.getString("BJC_ZHJ"));//装潢价
				double SBJ=JCJ+ZHJ; //设备价
				
				double AZJ=Double.parseDouble(pdel.getString("BJC_AZF"));//安装价
				double YSJ=Double.parseDouble(pdel.getString("BJC_YSF"));//运输价
				double DJ=AZJ+YSJ+SBJ;//最终单价
				
				table.addCell(new Paragraph("" + pdel.getString("BJC_ELEV"), titleFont)); //梯号
				table.addCell(new Paragraph("" + pdel.getString("BJC_MODELS"), titleFont));//型号
				table.addCell(new Paragraph("" + pdel.getString("BJC_ZZ"), titleFont));//载重
				table.addCell(new Paragraph("" + pdel.getString("BJC_SD"), titleFont));//速度
				table.addCell(new Paragraph("" + pdel.getString("BJC_C")+"/"+pdel.getString("BJC_Z"), titleFont));
				table.addCell(new Paragraph("" + pdel.getString("BJC_TSGD"), titleFont));//提升高度
				table.addCell(new Paragraph("" + pdel.getString("BJC_SL"), titleFont));//数量
				table.addCell(new Paragraph("" + SBJ, titleFont));//设备费单价
				table.addCell(new Paragraph("" + pdel.getString("BJC_AZF"), titleFont));//安装费
				table.addCell(new Paragraph("" + pdel.getString("BJC_YSF"), titleFont));//运输费
				table.addCell(new Paragraph("" + DJ, titleFont));//单价
				table.addCell(new Paragraph("" + pdel.getString("BJC_SJBJ"), titleFont));//总价
				
			}
			
		} catch (Exception e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
		
		// 合计
		PdfPCell cell13 = new PdfPCell(new Phrase("合计", titleFont));
		PdfPCell cell14 = new PdfPCell(new Phrase("", titleFont));
		PdfPCell cell15 = new PdfPCell(new Phrase("", titleFont));
		PdfPCell cell16 = new PdfPCell(new Phrase("", titleFont));
		PdfPCell cell17 = new PdfPCell(new Phrase("", titleFont));
		PdfPCell cell18 = new PdfPCell(new Phrase("", titleFont));
		PdfPCell cell19 = new PdfPCell(new Phrase("", titleFont));
		PdfPCell cell20 = new PdfPCell(new Phrase("", titleFont));
		PdfPCell cell21 = new PdfPCell(new Phrase("", titleFont));
		PdfPCell cell22 = new PdfPCell(new Phrase("", titleFont));
		PdfPCell cell23 = new PdfPCell(new Phrase("", titleFont));
		PdfPCell cell24 = new PdfPCell(new Phrase("", titleFont));
		table.addCell(cell13);
		table.addCell(cell14);
		table.addCell(cell15);
		table.addCell(cell16);
		table.addCell(cell17);
		table.addCell(cell18);
		table.addCell(cell19);
		table.addCell(cell20);
		table.addCell(cell21);
		table.addCell(cell22);
		table.addCell(cell23);
		table.addCell(cell24);
		
		// 总计
		PdfPCell cell25 = new PdfPCell(new Phrase("总计:", titleFont));
		cell25.setColspan(12);
		table.addCell(cell25);
		
		
		doc.add(table);
		
		String sixteen = "";
		doc.add(new Paragraph(sixteen, mintitle));
		
		doc.close();
		
		return JSONObject.fromObject(map); 
	}
	
	/**
	 *获取基础价格维护(直梯)
	 */
	@RequestMapping(value="setBascPrice")
	@ResponseBody
	public Object setBascPrice(){
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = this.getPageData();
		try{
			pd=basicPriceService.setBasicPrice(pd);
			map.put("msg", "success");
			map.put("pd", pd);
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return map;
	}
	
	/**
	 *获取税率
	 */
	@RequestMapping(value="getShuiLv")
	@ResponseBody
	public Object getShuiLv(){
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = this.getPageData();
		try{
			pd= e_offerService.getShuiLv(pd);
			map.put("msg", "success");
			map.put("pd", pd);
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return map;
	}
	
	/**
	 *获取是否超标
	 *当"是否发货前付清"为“是”时，付款方式佣金 = （设备实际总价*1% ）/1.16
     *当"是否发货前付清"为“否”时，付款方式佣金 = 0
     *当 佣金总额>（最高佣金（各梯型的合计）+付款方式佣金）：佣金是否超标：Y  否则为：N
	 */
	@RequestMapping(value="shiFouChaoBiao")
	@ResponseBody
	public Object shiFouChaoBiao(){
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = this.getPageData();
		try{
			//存储是否发货前付清字段 1：是，2：否
			String flag=pd.getString("flag");
			//找到设备实际总价和最高佣金和佣金总额
			pd= e_offerService.yongjinHuiZong(pd);
			
			if(pd.getString("BJC_ITEM_ID") == null) {
				map.put("msg", "notbjcItem");
				map.put("pd", pd);
				return map;
			}
			
			/*System.out.println(pd.getDouble("SBSJZJ"));
			System.out.println(Double.valueOf(pd.getString("content")).doubleValue());
			System.out.println(pd.getDouble("YJZE"));
			System.out.println(pd.getDouble("ZGYJ"));
			System.out.println((pd.getDouble("SBSJZJ")*0.01)/Double.valueOf(pd.getString("content")).doubleValue());*/
			//找到付款方式佣金并赋值
			double fkfsyj;
			if(flag.equals("1")) {
				fkfsyj=(pd.getDouble("SBSJZJ")*0.01)/Double.valueOf(pd.getString("content")).doubleValue();
			}else {
				fkfsyj=0;
			}
			//判断是否超标
            if(pd.getDouble("YJZE")>(pd.getDouble("ZGYJ")+fkfsyj)){
            	pd.put("shifouchaobiao", "Y");
            }else {
            	pd.put("shifouchaobiao", "N");
            }
            		
			
			map.put("msg", "success");
			map.put("pd", pd);
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return map;
	}
	
	/**
	 *获取基础价格维护(扶梯)
	 */
	@RequestMapping(value="setBascPrice_F")
	@ResponseBody
	public Object setBascPrice_F(){
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = this.getPageData();
		try{
			pd=basicPriceService.setBasicPrice_F(pd);
			map.put("msg", "success");
			map.put("pd", pd);
		}catch(Exception e){
			logger.error(e.getMessage(), e);
		}
		return map;
	}

	/**
	 * 进入设置梯号页面
	 * @param detail_ids
	 * @return
	 */
	@RequestMapping("/preSetEleENo")
	public ModelAndView preSetEleENo(String detail_ids,String bjc_id){
		ModelAndView mv=new ModelAndView();
		PageData pd = this.getPageData();
		pd.put("bjc_id", bjc_id);
		if(detail_ids!=null&&detail_ids.length()>0&&!",".equals(detail_ids)){
			try {
				List<PageData> eleList=e_offerService.findEleDetailsById(detail_ids.split(","));
				mv.addObject("elelist",eleList);
			}catch (Exception e){
				e.printStackTrace();
			}
		}
		mv.addObject("pd",pd);
		mv.setViewName("system/e_offer/setEleENo");
		return  mv;
	}

	/**
	 * 设置梯号
	 * @param
	 * @return
	 */
	@RequestMapping("/editEleENo")
	public ModelAndView editEleENo(String[] ele_id,String[] eno){
		ModelAndView mv=new ModelAndView();
			try {
				PageData pd = this.getPageData();
				e_offerService.updateEleDetailsENoById(ele_id,eno);
				e_offerService.updateBJCEleENoById(ele_id,eno,pd);
				mv.addObject("msg", "success");
				mv.addObject("id", "SetElevNo");
				mv.setViewName("system/nonStandrad/save_result");
			}catch (Exception e){
				e.printStackTrace();
			}
		return  mv;
	}
	
	/**
	 *导出到Excel 
	 */
	@RequestMapping(value="toExcel")
	public ModelAndView toExcel(){
		ModelAndView mv = new ModelAndView();
		try{
			Map<String, Object> dataMap = new HashMap<String, Object>();
			List<String> titles = new ArrayList<String>();
			titles.add("报价编号");
			titles.add("版本");
			titles.add("项目名称");
			titles.add("销售类型");
			titles.add("客户名称");
			titles.add("业务员");
			titles.add("电梯台数");
			titles.add("报价台数");
			titles.add("设备实际总价");
			titles.add("折扣");
			titles.add("佣金总额");
			titles.add("佣金比例");
			titles.add("安装费");
			titles.add("运输费");
			titles.add("总报价");
			titles.add("是否发货前付清");
			titles.add("佣金是否超标");
			titles.add("审核状态");
			titles.add("投标保函-比例");
			titles.add("投标保函-时效");
			titles.add("预付款保函-比例");
			titles.add("预付款保函-时效");
			titles.add("履约保函-比例");
			titles.add("履约保函-时效");
			titles.add("质量保函-比例");
			titles.add("质量保函-时效");
			titles.add("免保期限（年）");
			titles.add("设备付款-定金付款天数");
			titles.add("设备付款-定金付款比例");
			titles.add("设备付款-排产款付款天数");
			titles.add("设备付款-排产款付款比例");
			titles.add("设备付款-发货款付款天数");
			titles.add("设备付款-发货款付款比例");
			titles.add("设备付款-货到工地款付款天数");
			titles.add("设备付款-货到工地款付款比例");
			titles.add("设备付款-验收款付款天数");
			titles.add("设备付款-验收款付款比例");
			titles.add("设备付款-质保金付款天数");
			titles.add("设备付款-质保金付款比例");
			titles.add("设备付款-信用证付款天数");
			titles.add("设备付款-信用证付款比例");
			titles.add("安装付款-定金付款天数");
			titles.add("安装付款-定金付款比例");
			titles.add("安装付款-发货前付款天数");
			titles.add("安装付款-发货前付款比例");
			titles.add("安装付款-货到工地付款天数");
			titles.add("安装付款-货到工地付款比例");
			titles.add("安装付款-验收合格付款天数");
			titles.add("安装付款-验收合格付款比例");
			titles.add("安装付款-质保金付款天数");
			titles.add("安装付款-质保金付款比例");
			titles.add("录入人");
			titles.add("录入时间");
			
			dataMap.put("titles", titles);
			
			PageData pd = this.getPageData();
			//将当前登录人添加至列表查询条件
			pd.put("input_user", getUser().getUSER_ID());
			List<String> userList = new SelectByRole().findUserList(getUser().getUSER_ID());
			pd.put("userList", userList);
			/*List<PageData> itemList = itemService.findItemList();*/
			List<PageData> eOfferList = e_offerService.findEOfferToExcel(pd);
			List<PageData> varList = new ArrayList<PageData>();
			for(int i = 0; i < eOfferList.size(); i++){
				PageData eOffer = eOfferList.get(i);
				PageData vpd = new PageData();
				vpd.put("var1", eOffer.getString("offer_no"));
				vpd.put("var2", eOffer.getString("offer_version"));
				vpd.put("var3", eOffer.getString("item_name"));
				String saleType = eOffer.getString("sale_type");
				if("1".equals(saleType)) {
					vpd.put("var4", "经销");
				} else if("2".equals(saleType)) {
					vpd.put("var4", "直销");
				} else if("3".equals(saleType)) {
					vpd.put("var4", "代销");
				} else {
					vpd.put("var4", "");
				}
				vpd.put("var5", eOffer.getString("customer_name"));
				vpd.put("var6", eOffer.getString("USERNAME"));
				vpd.put("var7", (Long)eOffer.get("num"));
				vpd.put("var8", Long.valueOf(eOffer.getString("COUNT_SL")));
				vpd.put("var9", eOffer.getString("COUNT_SJZJ"));
				vpd.put("var10", eOffer.getString("COUNT_ZK"));
				vpd.put("var11", eOffer.getString("COUNT_YJ"));
				vpd.put("var12", eOffer.getString("COUNT_BL"));
				vpd.put("var13", eOffer.getString("COUNT_AZF"));
				vpd.put("var14", eOffer.getString("COUNT_YSF"));
				vpd.put("var15", eOffer.getString("COUNT_TATOL"));
				String SWXX_SFFHQFQ = eOffer.getString("SWXX_SFFHQFQ");
				if("1".equals(SWXX_SFFHQFQ)) {
					vpd.put("var16", "是");
				} else if("2".equals(SWXX_SFFHQFQ)) {
					vpd.put("var16", "否");
				} else {
					vpd.put("var16", "");
				} 
				vpd.put("var17", eOffer.getString("YJSFCB"));
				String instanceStatus = eOffer.getString("instance_status");
				if("1".equals(instanceStatus)) {
					vpd.put("var18", "待启动");
				} else if("2".equals(instanceStatus)) {
					vpd.put("var18", "待审核");
				} else if("3".equals(instanceStatus)) {
					vpd.put("var18", "审核中");
				} else if("4".equals(instanceStatus)) {
					vpd.put("var18", "已通过");
				} else if("5".equals(instanceStatus)) {
					vpd.put("var18", "被驳回");
				} else if("6".equals(instanceStatus)) {
					vpd.put("var18", "已通过");
				} else {
					vpd.put("var18", "");
				}
				vpd.put("var19", eOffer.getString("SWXX_TBBH_BL"));
				vpd.put("var20", eOffer.getString("SWXX_TBBH_SX"));
				vpd.put("var21", eOffer.getString("SWXX_YFKBH_BL"));
				vpd.put("var22", eOffer.getString("SWXX_YFKBH_SX"));
				vpd.put("var23", eOffer.getString("SWXX_LYBH_BL"));
				vpd.put("var24", eOffer.getString("SWXX_LYBH_SX"));
				vpd.put("var25", eOffer.getString("SWXX_ZLBH_BL"));
				vpd.put("var26", eOffer.getString("SWXX_ZLBH_BL"));
				vpd.put("var27", eOffer.getString("SWXX_MBQX"));
				
				vpd.put("var28", eOffer.getString("SWXX_DJ_DAY"));
				vpd.put("var29", eOffer.getString("SWXX_DJ"));
				vpd.put("var30", eOffer.getString("SWXX_PCK_DAY"));
				vpd.put("var31", eOffer.getString("SWXX_PCK"));
				vpd.put("var32", eOffer.getString("SWXX_FHK_DAY"));
				vpd.put("var33", eOffer.getString("SWXX_FHK"));
				vpd.put("var34", eOffer.getString("SWXX_HDGDK_DAY"));
				vpd.put("var35", eOffer.getString("SWXX_HDGDK"));
				vpd.put("var36", eOffer.getString("SWXX_YSK_DAY"));
				vpd.put("var37", eOffer.getString("SWXX_YSK"));
				vpd.put("var38", eOffer.getString("SWXX_ZBJBL_DAY"));
				vpd.put("var39", eOffer.getString("SWXX_ZBJBL"));
				vpd.put("var40", eOffer.getString("SWXX_XYZ_DAY"));
				vpd.put("var41", eOffer.getString("SWXX_XYZ"));
				
				vpd.put("var42", eOffer.getString("SWXX_FKBL_DJ_DAY"));
				vpd.put("var43", eOffer.getString("SWXX_FKBL_DJ"));
				vpd.put("var44", eOffer.getString("SWXX_FKBL_FHQ_DAY"));
				vpd.put("var45", eOffer.getString("SWXX_FKBL_FHQ"));
				vpd.put("var46", eOffer.getString("SWXX_FKBL_HDGD_DAY"));
				vpd.put("var47", eOffer.getString("SWXX_FKBL_HDGD"));
				vpd.put("var48", eOffer.getString("SWXX_FKBL_YSHG_DAY"));
				vpd.put("var49", eOffer.getString("SWXX_FKBL_YSHG"));
				vpd.put("var50", eOffer.getString("SWXX_FKBL_ZBJBL_DAY"));
				vpd.put("var51", eOffer.getString("SWXX_FKBL_ZBJBL"));
				vpd.put("var52", eOffer.getString("USERNAME"));
				vpd.put("var53", eOffer.getString("offer_date"));
				
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
	
	@RequestMapping("/droolsCount")
	@ResponseBody
	public String droolsCount(String MdType,String Zz){
		
		PageData pd = this.getPageData();
		e_offerService.delcoc3Count(pd);
		
		return null;
		
	}

	@RequestMapping(value="toElevatorNonstanard")
	public ModelAndView toElevatorNonstanard() {
    	ModelAndView mv = new ModelAndView();

		PageData pd = this.getPageData();
		mv.setViewName("system/e_offer/elevator_nonstanard");
		mv.addObject("pd", pd);
		return mv;
	}
	
	/**
	 * 是否是特种电梯
	 * 
	 * @return
	 */
	private boolean isTezhongdt(String eleType) {
		if(StringUtils.isNoneBlank(eleType)) {
			List<String> eleList = new ArrayList<String>();
			eleList.add("DT14");
			eleList.add("DT15");
			eleList.add("DT16");
			eleList.add("DT17");
			eleList.add("DT18");
			eleList.add("DT19");
			eleList.add("DT20");
			eleList.add("DT21");
			eleList.add("DT22");
			if(eleList.contains(eleType)) {
				return true;
			}
		}
		
		return false;
	}
	
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
	/* ===============================权限================================== */
	@SuppressWarnings("unchecked")
	public Map<String, String> getHC() {
		Subject currentUser = SecurityUtils.getSubject(); // shiro管理的session
		Session session = currentUser.getSession();
		return (Map<String, String>) session.getAttribute(Const.SESSION_QX);
	}
	/* ===============================用户================================== */
    public User getUser() {
        Subject currentUser = SecurityUtils.getSubject(); // shiro管理的session
        Session session = currentUser.getSession();
        return (User) session.getAttribute(Const.SESSION_USER);
    }
}
