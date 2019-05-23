package com.dncrm.service.system.e_offer;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;

import org.activiti.engine.IdentityService;
import org.activiti.engine.runtime.ProcessInstance;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dncrm.common.WorkFlow;
import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.util.DateUtil;
import com.dncrm.util.PageData;



@Service("e_offerService")
public class E_offerService 
{
	@Resource(name = "daoSupport")
    private DaoSupport dao;
	
	
//	@KSession("bookprice_ksession")
//	private KieSession kSession;
	
	//private final   KieContainer kContainer =KieServices.Factory.get().getKieClasspathContainer();
		/**
		 * 查询所有报价信息
		 * stone 17.07.05
		 * @param page
		 * @return
		 * @throws Exception
		 */
		 @SuppressWarnings("unchecked")
		public List<PageData> e_offerlistPage(Page page) throws Exception {
		        return (List<PageData>) dao.findForList("E_offerMapper.e_offerlistPage", page);
		    }
		 /**
			 * 查询所有项目状态为~报价 的项目信息
			 * stone 17.07.05
			 * @param page
			 * @return
			 * @throws Exception
			 */
			 @SuppressWarnings("unchecked")
			public List<PageData> itemlistpage(Page page) throws Exception {
			        return (List<PageData>) dao.findForList("E_offerMapper.itemlistPage", page);
			        }
            /**
             * 根据项目编号 获取项目信息
             * stone 17.07.05		
             * @param pd
             * @return
             * @throws Exception
             */
		    public PageData findItemById(PageData pd) throws Exception {
			        return (PageData) dao.findForObject("E_offerMapper.findItemById", pd);
			    }
		    
		    /**
             * 根据id 获取内容
             * sys_util 变量表	
             * @param pd
             * @return
             * @throws Exception
             */
		    public PageData getShuiLv(PageData pd) throws Exception {
			        return (PageData) dao.findForObject("E_offerMapper.getShuiLv", pd);
			    }
		    
		    /**
             * 根据item_id 获取佣金汇总
             * sys_util 变量表	
             * @param pd
             * @return
             * @throws Exception
             */
		    
		    public PageData yongjinHuiZong(PageData pd) throws Exception {
		        return (PageData) dao.findForObject("E_offerMapper.yongjinHuiZong", pd);
		    }
		    
		    /**
			 * 根据项目id获取电梯信息
			 * stone 17.07.14
			 * @param page
			 * @return
			 * @throws Exception
			 */
			 @SuppressWarnings("unchecked")
			public List<PageData> elevatorlistPage(Page page) throws Exception {
			        return (List<PageData>) dao.findForList("E_offerMapper.elevatorlistPage", page);
			        }
			 
			 /**
             * 获取最后一个录入的报价编号
             * stone 17.07.05		
             * @param pd
             * @return
             * @throws Exception
             */
		    public PageData E_offer_NO(PageData pd) throws Exception {
			        return (PageData) dao.findForObject("E_offerMapper.E_offer_NO", pd);
			    }
		    /**
		     * 根据编号删除信息
		     * @param pd the pd
		     * @throws Exception the exception
		     */
		    public void deleteOffer(PageData pd) throws Exception {
		        dao.delete("E_offerMapper.deleteOffer", pd);
		    }
		    
			@Transactional
			public void deleteOfferOfNos(String offer_nos) throws Exception {
				if(StringUtils.isBlank(offer_nos)) {
					return;
				}
				PageData pd = new PageData();
				for (String offer_no : offer_nos.split(",")) {
					pd.put("offer_no", offer_no);
					//PageData offerDetail = findItemInOffer(pd);
					List<PageData> offerList = (List<PageData>) dao.findForList("E_offerMapper.findItemInOffer", pd);
					if(offerList != null && offerList.size() > 0) {
						PageData offerDetail = offerList.get(0);
						if(offerDetail != null && ("1".equals(offerDetail.getString("instance_status")) 
								|| "5".equals(offerDetail.getString("instance_status")))){
							List<PageData> bjc_list = bjc_list(offerDetail);
							for (PageData bjc : bjc_list) {
								deleteBjc(bjc);
							}
							deleteTempElelist(offerDetail);
							deleteOffer(pd);
							deleteTempOffer(pd);
						}
					}
				}
			}
		    
		  //编辑报价信息
		    public void editS(PageData pd) throws Exception
		    {
		    	dao.update("E_offerMapper.editS", pd);
		    }
		    
		    // 补充项目信息
		    public void editItem(PageData pd) throws Exception
		    {
		    	dao.update("E_offerMapper.editItem", pd);
		    
		    }
		    
		  //查询流程是否存在
		    @SuppressWarnings("unchecked")
			public List<PageData> instance_key(PageData pd) throws Exception
		    {
		    	return (List<PageData>) dao.findForList("E_offerMapper.instance_key", pd);
		    }
		    
		  //保存报价信息
		    public void saveS(PageData pd)throws Exception{
		    	dao.save("E_offerMapper.saveS", pd);
		    }


		    
			/**
		     *根据类型查询扶梯配置 
		     */
		    public List<PageData> findEscalatorConfigByType(String type)throws Exception{
		    	return (List<PageData>) dao.findForList("E_offerMapper.findEscalatorConfigByType", type);
		    }
		    
		    public List<PageData> findChildEscalatorConfig(String id)throws Exception{
		    	return (List<PageData>) dao.findForList("E_offerMapper.findChildEscalatorConfig", id);
		    }
		    
		    public Integer findEscalatorStandardPrice(String id)throws Exception{
		    	String price = (String)dao.findForObject("E_offerMapper.findEscalatorStandardPrice", id); 
		    	return Integer.parseInt(price);
		    }
		    
		    public String findEscalatorConfigName(String id)throws Exception{
		    	return (String)dao.findForObject("E_offerMapper.findEscalatorConfigName", id);
		    }
		    
		    /**
		     *查询字段价格类型 
		     */
		    public String findPriceTypeByKeyWord(String keyword)throws Exception{
		    	return (String) dao.findForObject("E_offerMapper.findPriceTypeByKeyWord", keyword);
		    }
		    
		    /**
		     *根据关键字查询价格和加价公式 
		     */
		    public PageData findElevatorKeyword(PageData pd)throws Exception{
		    	
		    	List<PageData> pdList = (List<PageData>)dao.findForList("E_offerMapper.findElevatorKeyword", pd);
		    	return new PageData();
		    }
		    
		    /**
		     *根据字段的选项查询对应价格 
		     */
		    public PageData findPriceOption(PageData pd)throws Exception{
		    	return (PageData)dao.findForObject("E_offerMapper.findPriceOption", pd);
		    }
		    
		    /**
		     *根据字段的选项组查询对应价格总价
		     */
		    public PageData findPriceOptions(PageData pd)throws Exception{
		    	return (PageData)dao.findForObject("E_offerMapper.findPriceOptions", pd);
		    }
		    
		    /**
		     *根据字段名查询对应的加价公式 
		     */
		    public PageData findPriceFormula(PageData pd)throws Exception{
		    	return (PageData)dao.findForObject("E_offerMapper.findPriceFormula", pd);
		    }
		    
		    
		    /**
		     *根据字段名查询对应的单价 
		     */
		    public PageData findPriceUnit(PageData pd)throws Exception{
		    	return (PageData)dao.findForObject("E_offerMapper.findPriceUnit", pd);
		    }
		    
		    
		    /**
		     *保存报价明细 
		     */
		    public void saveEscalator(PageData pd)throws Exception{
		    	dao.save("E_offerMapper.saveEscalator", pd);
		    }
		    
		    
		    /**
		     *根据电梯配置ID查询电梯标准 
		     */
		    public PageData findEscalatorStandard(String id)throws Exception{
		    	return (PageData)dao.findForObject("E_offerMapper.findEscalatorStandard", id);
		    }



		 
		  //根据报价编号查询信息
		    public PageData findOfferById(PageData pd) throws Exception {
		        return (PageData) dao.findForObject("E_offerMapper.findOfferById", pd);
		    }
		    //根据item_id和models_id查询电梯信息
		    @SuppressWarnings("unchecked")
			public List<PageData> findEleBYmodels_id(PageData pd) throws Exception {
		        return (List<PageData>) dao.findForList("E_offerMapper.findEleBYmodels_id", pd);
		    }
		    //修改流程状态
		    public void editInstance_status(PageData pd) throws Exception
		    {
		    	dao.update("E_offerMapper.editInstance_status", pd);
		    }
		    //根据uuid查询信息
		    public PageData findByuuId(PageData pd) throws Exception {
		        return (PageData) dao.findForObject("E_offerMapper.findByuuId", pd);
		    }
		    
		    //查询运输价格
		    public PageData findTrans(PageData pd)throws Exception{
		    	return (PageData)dao.findForObject("E_offerMapper.findTrans", pd);
		    }
		    
		    //查询目的地
		    public List<PageData> findAllDestinByProvinceId(PageData pd)throws Exception{
		    	return (List<PageData>)dao.findForList("E_offerMapper.findAllDestinByProvinceId", pd);
		    }
		    
		    //更新电梯
		    public void updateElevatorDetails(PageData pd)throws Exception{
		    	dao.update("E_offerMapper.updateElevatorDetails", pd);
		    }
		    
		    //保存飞尚梯
		    public void saveFeishang(PageData pd)throws Exception{
		    	dao.save("E_offerMapper.saveFeishang", pd);
		    }
		    
		  //保存飞尚货梯MRL
		    public void saveFeishangMrl(PageData pd)throws Exception{
		    	dao.save("E_offerMapper.saveFeishangMrl", pd);
		    }
		    
		    
	    /**
		 * 根据项目ID获取BJC 信息
		 * stone 17.12.21
		 * @param pd
		 * @return
		 * @throws Exception
		 */
		 @SuppressWarnings("unchecked")
		public List<PageData> bjc_list(PageData pd) throws Exception {
		        return (List<PageData>) dao.findForList("E_offerMapper.bjc_list", pd);
		    }	    
		    
		    
		    //保存飞扬MRL无机房
		    public void saveFeiyangMRL(PageData pd)throws Exception{
		    	dao.save("E_offerMapper.saveFeiyangMRL", pd);
		    }
		    
		    //保存报价池信息
		    public void saveBjc(PageData pd) throws Exception{
		    	
		    	String rs = (String) dao.findForObject("E_offerMapper.findBjcLastIndex", pd);
		    	
		    	if(rs == null || rs.length() <= 0) {
		    		rs = "0";
				}
		    	int lastIndex = Integer.parseInt(rs);
		    	lastIndex += 1;
		    	pd.put("bjc_index", lastIndex);
		    	dao.save("E_offerMapper.saveBjc", pd);
		    	
		    }
		    
		    //保存飞扬消防梯
		    public void saveFeiyangXF(PageData pd)throws Exception{
		    	dao.save("E_offerMapper.saveFeiyangXF", pd);
		    }
		    
		    //保存飞扬3000有机房
		    public void saveFeiyang(PageData pd)throws Exception{
		    	dao.save("E_offerMapper.saveFeiyang", pd);
		    }
		    
		  //保存飞越有机房
		    public void saveFeiyue(PageData pd)throws Exception{
		    	dao.save("E_offerMapper.saveFeiyue", pd);
		    }
		    
		  //保存飞越无机房
		    public void saveFeiyueMRL(PageData pd)throws Exception{
		    	dao.save("E_offerMapper.saveFeiyueMRL", pd);
		    }
		    
		  //保存扶梯
		    public void saveDnp9300(PageData pd)throws Exception{
		    	dao.save("E_offerMapper.saveDnp9300", pd);
		    }
		    
		  //保存人行道
		    public void saveDnr(PageData pd)throws Exception{
		    	dao.save("E_offerMapper.saveDnr", pd);
		    }
		    
		  //保存曳引货梯
		    public void saveShiny(PageData pd)throws Exception{
		    	dao.save("E_offerMapper.saveShiny", pd);
		    }
		    
		    
		    //根据项目ID查询报价池信息
		    public List<PageData> findBjc(PageData pd)throws Exception{
		    	return (List<PageData>)dao.findForList("E_offerMapper.findBjc", pd);
		    }
		    
		  //根据ITEM_ID获取报价池内的折扣和梯型
		    @SuppressWarnings("unchecked")
			public List<PageData> findBjcByItemId(PageData pd)throws Exception{
		    	return (List<PageData>)dao.findForList("E_offerMapper.findBjcByItemId", pd);
		    }
		    
		    //查询飞尚梯参考报价
		    @SuppressWarnings("unchecked")
			public List<PageData> findFeishangCbj(PageData pd)throws Exception{
		
		    	List<PageData> res = null;
				PageData offerDetail = findItemInOfferByItem(pd);
		    	if (offerDetail!=null) {
		    		res = (List<PageData>)dao.findForList("E_offerMapper.findFeishangCbj",pd);
				}else {
					//未保存报价调用
					res = (List<PageData>)dao.findForList("E_offerMapper.findFeishangCbjNewOffer",pd);
					List<PageData> temp = (List<PageData>)dao.findForList("E_offerMapper.findFeishangCbj",pd);
					res.addAll(temp);
					
				}
		    	return res;
		    }
		    //查询飞尚MRL梯参考报价
		    @SuppressWarnings("unchecked")
			public List<PageData> findFeishangMrlCbj(PageData pd)throws Exception{
		
		    	List<PageData> res = null;
				PageData offerDetail = findItemInOfferByItem(pd);
		    	if (offerDetail!=null) {
		    		res = (List<PageData>)dao.findForList("E_offerMapper.findFeishangMrlCbj",pd);
				}else {
					//未保存报价调用
					res = (List<PageData>)dao.findForList("E_offerMapper.findFeishangMrlCbjNewOffer",pd);
					List<PageData> temp = (List<PageData>)dao.findForList("E_offerMapper.findFeishangMrlCbj",pd);
					res.addAll(temp);
					
				}
		    	return res;
		    }
		    
		  //查询飞扬梯参考报价
		    public List<PageData> findFeiyangCbj(PageData pd)throws Exception{
		    	List<PageData> res = null;
				PageData offerDetail = findItemInOfferByItem(pd);
		    	if (offerDetail!=null) {
		    		res = (List<PageData>)dao.findForList("E_offerMapper.findFeiyangCbj",pd);
				}else {
					//未保存报价调用
					res = (List<PageData>)dao.findForList("E_offerMapper.findFeiyangCbjNewOffer",pd);
					List<PageData> temp = (List<PageData>)dao.findForList("E_offerMapper.findFeiyangCbj",pd);
					res.addAll(temp);
				}
		    	return res;
		    }
		  //查询飞扬无机房梯参考报价
		    public List<PageData> findFeiyangMRLCbj(PageData pd)throws Exception{

		    	List<PageData> res = null;
				PageData offerDetail = findItemInOfferByItem(pd);
		    	if (offerDetail!=null) {
		    		res = (List<PageData>)dao.findForList("E_offerMapper.findFeiyangMRLCbj",pd);
				}else {
					//未保存报价调用
					res = (List<PageData>)dao.findForList("E_offerMapper.findFeiyangMRLCbjNewOffer",pd);
					List<PageData> temp = (List<PageData>)dao.findForList("E_offerMapper.findFeiyangMRLCbj",pd);
					res.addAll(temp);
				}
		    	return res;
		    }
		  //查询飞扬消防梯参考报价
		    public List<PageData> findFeiyangXFCbj(PageData pd)throws Exception{
		    	List<PageData> res = null;
				PageData offerDetail = findItemInOfferByItem(pd);
		    	if (offerDetail!=null) {
		    		res = (List<PageData>)dao.findForList("E_offerMapper.findFeiyangXFCbj",pd);
				}else {
					//未保存报价调用
					res = (List<PageData>)dao.findForList("E_offerMapper.findFeiyangXFCbjNewOffer",pd);
					List<PageData> temp = (List<PageData>)dao.findForList("E_offerMapper.findFeiyangXFCbj",pd);
					res.addAll(temp);
				}
		    	return res;
		    }
		  //查询飞越梯参考报价
		    @SuppressWarnings("unchecked")
			public List<PageData> findFeiyueCbj(PageData pd)throws Exception{
		    	List<PageData> res = null;
				PageData offerDetail = findItemInOfferByItem(pd);
		    	if (offerDetail!=null) {
		    		res = (List<PageData>)dao.findForList("E_offerMapper.findFeiyueCbj",pd);
				}else {
					//未保存报价调用
					res = (List<PageData>)dao.findForList("E_offerMapper.findFeiyueCbjNewOffer",pd);
					
					List<PageData> temp = (List<PageData>)dao.findForList("E_offerMapper.findFeiyueCbj",pd);
					res.addAll(temp);
				}
		    	return res;
		    }
		  //查询飞越MRL梯参考报价
		    public List<PageData> findFeiyueMRLCbj(PageData pd)throws Exception{
		    	List<PageData> res = null;
				PageData offerDetail = findItemInOfferByItem(pd);
		    	if (offerDetail!=null) {
		    		res = (List<PageData>)dao.findForList("E_offerMapper.findFeiyueMRLCbj",pd);
				}else {
					//未保存报价调用
					res = (List<PageData>)dao.findForList("E_offerMapper.findFeiyueMRLCbjNewOffer",pd);
					List<PageData> temp = (List<PageData>)dao.findForList("E_offerMapper.findFeiyueMRLCbj",pd);
					res.addAll(temp);
				}
		    	return res;
		    }
		  //查询曳引梯参考报价
		    public List<PageData> findShinyCbj(PageData pd)throws Exception{
		    	List<PageData> res = null;
				PageData offerDetail = findItemInOfferByItem(pd);
		    	if (offerDetail!=null) {
		    		res = (List<PageData>)dao.findForList("E_offerMapper.findShinyCbj",pd);
				}else {
					//未保存报价调用
					res = (List<PageData>)dao.findForList("E_offerMapper.findShinyCbjNewOffer",pd);
					List<PageData> temp = (List<PageData>)dao.findForList("E_offerMapper.findShinyCbj",pd);
					res.addAll(temp);
				}
		    	return res;
		    }
		  //查询曳引梯参考报价
		    public List<PageData> findDnp9300Cbj(PageData pd)throws Exception{
		    	List<PageData> res = null;
				PageData offerDetail = findItemInOfferByItem(pd);
		    	if (offerDetail!=null) {
		    		res = (List<PageData>)dao.findForList("E_offerMapper.findDnp9300Cbj",pd);
				}else {
					//未保存报价调用
					res = (List<PageData>)dao.findForList("E_offerMapper.findDnp9300CbjNewOffer",pd);
					List<PageData> temp = (List<PageData>)dao.findForList("E_offerMapper.findDnp9300Cbj",pd);
					res.addAll(temp);
				}
		    	return res;
		    }
		  //查询曳引梯参考报价
		    public List<PageData> findDnrCbj(PageData pd)throws Exception{
		    	List<PageData> res = null;
				PageData offerDetail = findItemInOfferByItem(pd);
		    	if (offerDetail!=null) {
		    		res = (List<PageData>)dao.findForList("E_offerMapper.findDnrCbj",pd);
				}else {
					//未保存报价调用
					res = (List<PageData>)dao.findForList("E_offerMapper.findDnrCbjNewOffer",pd);
					List<PageData> temp = (List<PageData>)dao.findForList("E_offerMapper.findDnrCbj",pd);
					res.addAll(temp);
				}
		    	return res;
		    }
		    
		  //查询飞尚梯参考报价
		    public List<PageData> findFeishangZhj()throws Exception{
		    	return (List<PageData>)dao.findForList("E_offerMapper.findFeishangZhj", "");
		    }
		  //查询飞扬梯参考报价
		    public List<PageData> findFeiyangZhj()throws Exception{
		    	return (List<PageData>)dao.findForList("E_offerMapper.findFeiyangZhj", "");
		    }
		  //查询飞扬无机房梯参考报价
		    public List<PageData> findFeiyangMRLZhj()throws Exception{
		    	return (List<PageData>)dao.findForList("E_offerMapper.findFeiyangMRLZhj", "");
		    }
		    //查询飞扬消防梯参考报价
		    public List<PageData> findFeiyangXFZhj()throws Exception{
		    	return (List<PageData>)dao.findForList("E_offerMapper.findFeiyangXFZhj", "");
		    }
		  //查询飞越梯参考报价
		    public List<PageData> findFeiyueZhj()throws Exception{
		    	return (List<PageData>)dao.findForList("E_offerMapper.findFeiyueZhj", "");
		    }
		    //查询飞越MRL梯参考报价
		    public List<PageData> findFeiyueMRLZhj()throws Exception{
		    	return (List<PageData>)dao.findForList("E_offerMapper.findFeiyueMRLZhj", "");
		    }
		    //查询曳引梯参考报价
		    public List<PageData> findShinyZhj()throws Exception{
		    	return (List<PageData>)dao.findForList("E_offerMapper.findShinyZhj", "");
		    }
		  //查询扶梯参考报价
		    public List<PageData> findDnp9300Zhj()throws Exception{
		    	return (List<PageData>)dao.findForList("E_offerMapper.findDnp9300Zhj", "");
		    }
		    //查询扶梯参考报价
		    public List<PageData> findDnrZhj()throws Exception{
		    	return (List<PageData>)dao.findForList("E_offerMapper.findDnrZhj", "");
		    }
		    
		  //根据报价池ID查询飞尚COD信息
		    public PageData findFeishangCOD(PageData pd)throws Exception{
		    	return (PageData)dao.findForObject("E_offerMapper.findFeishangCOD", pd);
		    }
		    //根据报价池ID查询飞尚MRLCOD信息
		    public PageData findFeishangMRLCOD(PageData pd)throws Exception{
		    	return (PageData)dao.findForObject("E_offerMapper.findFeishangMRLCOD", pd);
		    }
		    //根据报价池ID查询飞扬COD信息
		    public PageData findFeiyangCOD(PageData pd)throws Exception{
		    	return (PageData)dao.findForObject("E_offerMapper.findFeiyangCOD", pd);
		    }
		  //根据报价池ID查询飞扬无机房COD信息
		    public PageData findFeiyangMRLCOD(PageData pd)throws Exception{
		    	return (PageData)dao.findForObject("E_offerMapper.findFeiyangMRLCOD", pd);
		    }
		    //根据报价池ID查询飞扬消防COD信息
		    public PageData findFeiyangXFCOD(PageData pd)throws Exception{
		    	return (PageData)dao.findForObject("E_offerMapper.findFeiyangXFCOD", pd);
		    }
		    //根据报价池ID查询飞越COD信息
		    public PageData findFeiyueCOD(PageData pd)throws Exception{
		    	return (PageData)dao.findForObject("E_offerMapper.findFeiyueCOD", pd);
		    }
		  //根据报价池ID查询飞越COD信息
		    public PageData findFeiyueMRLCOD(PageData pd)throws Exception{
		    	return (PageData)dao.findForObject("E_offerMapper.findFeiyueMRLCOD", pd);
		    }
		  //根据报价池ID查询SHINYCOD信息
		    public PageData findShinyCOD(PageData pd)throws Exception{
		    	return (PageData)dao.findForObject("E_offerMapper.findShinyCOD", pd);
		    }
		    //根据报价池ID查询SHINYCOD信息
		    public PageData findDnp9300COD(PageData pd)throws Exception{
		    	return (PageData)dao.findForObject("E_offerMapper.findDnp9300COD", pd);
		    }
		  //根据报价池ID查询dnr COD信息
		    public PageData findDnrCOD(PageData pd)throws Exception{
		    	return (PageData)dao.findForObject("E_offerMapper.findDnrCOD", pd);
		    }
		    
		    //根据主键获取飞尚COD
		    public PageData findFeishang(PageData pd)throws Exception{
		    	return (PageData)dao.findForObject("E_offerMapper.findFeishang", pd);
		    }
		    
		    //根据主键获取飞尚货梯MrlCOD
		    public PageData findFeishangMrl(PageData pd)throws Exception{
		    	return (PageData)dao.findForObject("E_offerMapper.findFeishangMrl", pd);
		    }
		    
		  //根据主键获取飞扬COD
		    public PageData findFeiyang(PageData pd)throws Exception{
		    	return (PageData)dao.findForObject("E_offerMapper.findFeiyang", pd);
		    }
		  //根据主键获取飞扬COD
		    public PageData findFeiyangMRL(PageData pd)throws Exception{
		    	return (PageData)dao.findForObject("E_offerMapper.findFeiyangMRL", pd);
		    }
		  //根据主键获取飞扬COD
		    public PageData findFeiyangXF(PageData pd)throws Exception{
		    	return (PageData)dao.findForObject("E_offerMapper.findFeiyangXF", pd);
		    }
		  //根据主键获取飞越COD
		    public PageData findFeiyue(PageData pd)throws Exception{
		    	return (PageData)dao.findForObject("E_offerMapper.findFeiyue", pd);
		    }
		    //根据主键获取飞越mrlCOD
		    public PageData findFeiyueMRL(PageData pd)throws Exception{
		    	return (PageData)dao.findForObject("E_offerMapper.findFeiyueMRL", pd);
		    }
		    //根据主键获取SHINY COD
		    public PageData findShiny(PageData pd)throws Exception{
		    	return (PageData)dao.findForObject("E_offerMapper.findShiny", pd);
		    }
		    
		    //根据主键获取SHINY COD
		    public PageData findHOUSEHOLD(PageData pd)throws Exception{
		    	return (PageData)dao.findForObject("E_offerMapper.findHOUSEHOLD", pd);
		    }
		    
		  //根据主键获取DNP9300 COD
		    public PageData findDnp9300(PageData pd)throws Exception{
		    	return (PageData)dao.findForObject("E_offerMapper.findDnp9300", pd);
		    }
		  //根据主键获取DNR COD
		    public PageData findDnr(PageData pd)throws Exception{
		    	return (PageData)dao.findForObject("E_offerMapper.findDnr", pd);
		    }
		    
		  //根据报价池ID获取型号
		    public PageData findModels(PageData pd)throws Exception{
		    	return (PageData)dao.findForObject("E_offerMapper.findModels", pd);
		    }
		    
		    //更新电梯报价状态信息
		    public void updateDetails(PageData pd)throws Exception{
		    	dao.update("E_offerMapper.updateDetails", pd);
		    }
		    //更新电梯报价状态信息
		    public void updateTempDetails(PageData pd)throws Exception{
		    	dao.update("E_offerMapper.updateTempDetails", pd);
		    }
		    
		    
		    //--编辑部分
		    
		    //编辑报价池
		    public void updateBjc(PageData pd)throws Exception{
		    	dao.update("E_offerMapper.updateBjc", pd);
		    }
		    //编辑飞尚
		    public void updateFeishang(PageData pd)throws Exception{
		    	dao.update("E_offerMapper.updateFeishang", pd);
		    }
		    //编辑飞尚货梯Mrl
		    public void updateFeishangMrl(PageData pd)throws Exception{
		    	dao.update("E_offerMapper.updateFeishangMrl", pd);
		    }
		    
		    //编辑飞扬
		    public void updateFeiyang(PageData pd)throws Exception{
		    	dao.update("E_offerMapper.updateFeiyang", pd);
		    }

		  //编辑飞扬MRL
		    public void updateFeiyangMRL(PageData pd)throws Exception{
		    	dao.update("E_offerMapper.updateFeiyangMRL", pd);
		    }
		    
		  //编辑飞扬消防
		    public void updateFeiyangXF(PageData pd)throws Exception{
		    	dao.update("E_offerMapper.updateFeiyangXF", pd);
		    }
		    
		    //编辑飞越
		    public void updateFeiyue(PageData pd)throws Exception{
		    	dao.update("E_offerMapper.updateFeiyue", pd);
		    }
		    
		    //编辑飞越MRL
		    public void updateFeiyueMRL(PageData pd)throws Exception{
		    	dao.update("E_offerMapper.updateFeiyueMRL", pd);
		    }
		    
		    //编辑家用梯
		    public void updateHOUSEHOLD(PageData pd)throws Exception{
		    	dao.update("E_offerMapper.updateHOUSEHOLD", pd);
		    }
		    
		    //编辑曳引
		    public void updateShiny(PageData pd)throws Exception{
		    	dao.update("E_offerMapper.updateShiny", pd);
		    }
		    
		    //编辑扶梯
		    public void updateDnp9300(PageData pd)throws Exception{
		    	dao.update("E_offerMapper.updateDnp9300", pd);
		    }
		    
		    
		    //编辑人行道
		    public void updateDnr(PageData pd)throws Exception{
		    	dao.update("E_offerMapper.updateDnr", pd);
		    }
		    
		    //删除报价池
		    public void deleteBjc(PageData pd)throws Exception{
		    	dao.delete("E_offerMapper.deleteBjc", pd);
		    }
		    
		    //初始化电梯表状态
		    public void initDetails(PageData pd)throws Exception{
		    	dao.update("E_offerMapper.initDetails", pd);
		    }
		    
		    //根据主键查询报价池信息
		    public PageData selectBjc(PageData pd)throws Exception{
		    	return (PageData)dao.findForObject("E_offerMapper.selectBjc", pd);
		    }
		    
		    //根据报价池ID删除飞尚
		    public void deleteFeishangByBjc(PageData pd)throws Exception{
		    	dao.delete("E_offerMapper.deleteFeishangByBjc", pd);
		    }
		    //根据报价池ID删除飞尚MRL
		    public void deleteFeishangMrlByBjc(PageData pd)throws Exception{
		    	dao.delete("E_offerMapper.deleteFeishangMrlByBjc", pd);
		    }
		    //根据报价池ID删除feiyang
		    public void deleteFeiyangByBjc(PageData pd)throws Exception{
		    	dao.delete("E_offerMapper.deleteFeiyangByBjc", pd);
		    }
		    //根据报价池ID删除feiyangmrl
		    public void deleteFeiyangMRLByBjc(PageData pd)throws Exception{
		    	dao.delete("E_offerMapper.deleteFeiyangMRLByBjc", pd);
		    }
		    //根据报价池ID删除feiyangxf
		    public void deleteFeiyangXFByBjc(PageData pd)throws Exception{
		    	dao.delete("E_offerMapper.deleteFeiyangXFByBjc", pd);
		    }
		    //根据报价池ID删除feiyue
		    public void deleteFeiyueByBjc(PageData pd)throws Exception{
		    	dao.delete("E_offerMapper.deleteFeiyueByBjc", pd);
		    }
		    //根据报价池ID删除feiyuemrl
		    public void deleteFeiyueMRLByBjc(PageData pd)throws Exception{
		    	dao.delete("E_offerMapper.deleteFeiyueMRLByBjc", pd);
		    }
		    //根据报价池ID删除dnp9300
		    public void deleteDnp9300ByBjc(PageData pd)throws Exception{
		    	dao.delete("E_offerMapper.deleteDnp9300ByBjc", pd);
		    }
		    //根据报价池ID删除dnr
		    public void deleteDnrByBjc(PageData pd)throws Exception{
		    	dao.delete("E_offerMapper.deleteDnrByBjc", pd);
		    }
		    //根据报价池ID删除shiny
		    public void deleteShinyByBjc(PageData pd)throws Exception{
		    	dao.delete("E_offerMapper.deleteShinyByBjc", pd);
		    }
		    
		    //根据电梯ID获取eno
		    public PageData selectElevEno(PageData pd)throws Exception{
		    	return (PageData)dao.findForObject("E_offerMapper.selectElevEno", pd);
		    }
		   
		    //根据项目id获取报价池信息
		    @SuppressWarnings("unchecked")
			public List<PageData> getBjsByItem_id(PageData pd) throws Exception {
		        return (List<PageData>) dao.findForList("E_offerMapper.getBjsByItem_id", pd);
		    }

	/**
	 *查询项目电梯总台数
	 */
	public String findItemEleCountNum(PageData pd)throws Exception{
		return (String) dao.findForObject("E_offerMapper.findItemEleCountNum", pd);
	}

	//根据项目id 获取制卡设备 值 
	@SuppressWarnings("unchecked")
	public List<PageData> getFeiyueIC(PageData pd) throws Exception {
	        return (List<PageData>) dao.findForList("E_offerMapper.getFeiyueIC", pd);
	        }
	//根据项目id 获取制卡设备 值 
	@SuppressWarnings("unchecked")
	public List<PageData> getFeiyueMrlIC(PageData pd) throws Exception {
	        return (List<PageData>) dao.findForList("E_offerMapper.getFeiyueMrlIC", pd);
	        }
	//根据项目id 获取制卡设备 值 
	@SuppressWarnings("unchecked")
	public List<PageData> getFeiyangIC(PageData pd) throws Exception {
	        return (List<PageData>) dao.findForList("E_offerMapper.getFeiyangIC", pd);
	        }
	//根据项目id 获取制卡设备 值 
	@SuppressWarnings("unchecked")
	public List<PageData> getFeiyangMrlIC(PageData pd) throws Exception {
	        return (List<PageData>) dao.findForList("E_offerMapper.getFeiyangMrlIC", pd);
	        }
	//根据项目id 获取制卡设备 值 
	@SuppressWarnings("unchecked")
	public List<PageData> getFeiyangXfIC(PageData pd) throws Exception {
	        return (List<PageData>) dao.findForList("E_offerMapper.getFeiyangXfIC", pd);
	        }
	
	
    /**
     * 跟据明细获取id
     * @param details_ids
     * @return
     * @throws Exception
     */
//	public List<PageData> findEleDetailsById(String [] details_ids) throws Exception{
//		return (List<PageData>)dao.findForList("E_offerMapper.findEleDetailsById",details_ids);
//	}
	public List<PageData> findEleDetailsById(String [] details_ids) throws Exception{
		return (List<PageData>)dao.findForList("E_offerMapper.findTempEleDetailsById",details_ids);
	}

//	public void updateEleDetailsENoById(String[] ele_id,String[] eno)throws Exception{
//	    PageData pd=new PageData();
//        if(ele_id!=null&&ele_id.length>0){
//            for (int i=0;i<ele_id.length;i++){
//                pd.put("ele_id",ele_id[i]);
//                pd.put("eno",eno!=null&&eno.length>0?eno[i]:"");
//
//                dao.update("E_offerMapper.updateEleDetailENoById",pd);
//            }
//        }
//    }
	
	public void updateEleDetailsENoById(String[] ele_id,String[] eno)throws Exception{
	    PageData pd=new PageData();
        if(ele_id!=null&&ele_id.length>0){
            for (int i=0;i<ele_id.length;i++){
                pd.put("ele_id",ele_id[i]);
                pd.put("eno",eno!=null&&eno.length>0?eno[i]:"");

                dao.update("E_offerMapper.updateTempEleDetailENoById",pd);
//                dao.update("E_offerMapper.updateBJCEleENoById",pd);
                
            }
        }
    }
	
	public void saveConventionalNonstandard(PageData pd)throws Exception {
		dao.save("E_offerMapper.saveConventionalNonstandard", pd);
	}
	public void updateConventionalNonstandard(PageData pd)throws Exception {
		dao.update("E_offerMapper.updateConventionalNonstandard", pd);
	}
//	新功能----复制报价
	public PageData copyDetail(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		  //根据报价编号查询信息
		PageData offerinfo = FindOfferDetailByOfferNum(pd);
//		offerinfo.put("ITEM_ID", pd.getString("item_id"));
		//根据项目ID查询报价池信息
		List<PageData> list = findBjc(offerinfo);
		FindBjcDetailByItemId(offerinfo);
		
		List<PageData> cbjList = new ArrayList<PageData>();
		for (PageData i : list) {
//			获取报价池内各梯形ID
			String CodId = i.get("ID_").toString();
//			获取报价池内各梯形类型
			String Models = i.getString("MODELS_");
//			if(Models.equals("新飞越")){
//				cbjList = findFeishangCbj();
//			}else if(Models.equals("feiyang")){
//				cbjList = findFeiyangCbj();
//			}else if(Models.equals("feiyangmrl")){
//				cbjList = findFeiyangMRLCbj();
//			}else if(Models.equals("feiyangxf")){
//				cbjList = findFeiyangXFCbj();
//			}else if(Models.equals("feiyue")){ 
//				cbjList = findFeiyueCbj(i);
//			}else if(Models.equals("feiyuemrl")){
//				cbjList = findFeiyueMRLCbj();
//			}else if(Models.equals("shiny")){
//				cbjList = findShinyCbj();
//			}else if(Models.equals("DNP9300")){
//				cbjList = findDnp9300Cbj();
//			}else if(Models.equals("DNR")){
//				cbjList = findDnrCbj();
//			}
		}
		System.out.println(list);
		return null;
	    
	}
	private PageData FindBjcDetailByItemId(PageData offerinfo) throws Exception {
	// TODO Auto-generated method stub
		PageData object = (PageData)dao.findForObject("E_offerMapper.FindBjcDetailByItemId", offerinfo);
		return object;
	
	}
	
	public PageData FindItemDetailByItemId(PageData itemid) throws Exception {
	// TODO Auto-generated method stub
		PageData object = (PageData)dao.findForObject("E_offerMapper.FindItemDetailByItemId", itemid);
		return object;
	
	}
	
	private PageData FindOfferDetailByOfferNum(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		PageData object = (PageData)dao.findForObject("E_offerMapper.FindOfferDetailByOfferNum", pd);
		return object;
	}
//	根据itemId获取最新报价版本号
	public int findLastOffVersion(String sel) throws Exception {
		
		String res = (String) dao.findForObject("E_offerMapper.FindLastOffVersion", sel);
		if(res == null || res.length() <= 0) {
			res = "0";
		}

		int num = Integer.parseInt(res);
		return num;
		// TODO Auto-generated method stub
		
	}
	public void saveTempItem(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		dao.save("E_offerMapper.saveTempItem", pd);
		
	}
	public int findOffVersionByofferno(String offerno) throws Exception {
		// TODO Auto-generated method stub
		String res = (String) dao.findForObject("E_offerMapper.findOffVersionByofferno", offerno);
		if(res == null || res.length() <= 0) {
			res = "0";
		}

		int num = Integer.parseInt(res);
		return num;
	}
	public PageData findItemInOffer(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		PageData res = (PageData) dao.findForObject("E_offerMapper.findItemInOffer", pd);
		return res;
	}
	public PageData findByuuid(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (PageData) dao.findForObject("E_offerMapper.findByuuid", pd);
	}
	@SuppressWarnings("unchecked")
	public List<PageData> ShowItem(Page page) throws Exception {
		// TODO Auto-generated method stub
		 return (List<PageData>) dao.findForList("E_offerMapper.ShowItem", page);
	}
	@SuppressWarnings("unchecked")
	public List<PageData> addelevatorlistPage(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>) dao.findForList("E_offerMapper.addelevatorlistPage", page);
	}
	@SuppressWarnings("unchecked")
	public List<PageData> TempelevatorlistPage(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>) dao.findForList("E_offerMapper.TempelevatorlistPage", page);
	}
	public void copyeleDetailtoTemp(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		dao.save("E_offerMapper.copyeleDetailtoTemp", pd);
	}
	public void reSetele(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		dao.update("E_offerMapper.reSetele",pd);
		
	}
	
    //根据项目id获取报价池信息
    @SuppressWarnings("unchecked")
	public List<PageData> getBjs(PageData pd) throws Exception {
        return (List<PageData>) dao.findForList("E_offerMapper.getBjs", pd);
    }
	
	public PageData findOfferDetailByOfferId(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		 return (PageData) dao.findForObject("E_offerMapper.findOfferDetailByOfferId", pd);

	}

	 //编辑报价信息
    public void editSItemInOffer(PageData pd) throws Exception
    {
    	dao.update("E_offerMapper.editSItemInOffer", pd);
    }
	public void editTempInstance_status(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		dao.update("E_offerMapper.editTempInstance_status", pd);
	}
	@SuppressWarnings("unchecked")
	public List<PageData> e_offerTemplistPage(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>) dao.findForList("E_offerMapper.e_offerTemplistPage", page);
	}
	
	@SuppressWarnings("unchecked")
	public List<PageData> findTempEleDetails(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>) dao.findForList("E_offerMapper.findTempEleDetails", pd);
		
	}
	@SuppressWarnings("unchecked")
	public List<PageData> findTempEleBYmodels_id(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>) dao.findForList("E_offerMapper.findTempEleBYmodels_id", pd);
	}
	public void saveTempelevatorlist(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		dao.save("E_offerMapper.saveTempelevatorlist", pd);
	}
	public void deleteTempOffer(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		dao.delete("E_offerMapper.deleteTempOffer", pd);
		
	}
	
	@SuppressWarnings("unchecked")
	public List<PageData> TempelevatorDeatil(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>) dao.findForList("E_offerMapper.TempelevatorDeatil", page);
	}
	public void deleteTempElelist(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		dao.delete("E_offerMapper.deleteTempElelist", pd);
		
	}

	/**
	 * 导出所有报价信息到Excel
	 * stone 17.07.05
	 * @param page
	 * @return
	 * @throws Exception
	 */
	 @SuppressWarnings("unchecked")
	public List<PageData> findEOfferToExcel(PageData pd) throws Exception {
	      return (List<PageData>) dao.findForList("E_offerMapper.findEOfferToExcel", pd);
	}
 /**
     * 分页显示显示待我处理
     * @param pd
     * @return
     * @throws Exception
     */
    public List<PageData> findAuditOfferPage(PageData pd) throws  Exception{

        return (List<PageData>) dao.findForList("E_offerMapper.findAuditOfferPage", pd);
    }
	public void updateOfferCount(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		dao.update("E_offerMapper.updateOfferCount", pd);
	}
	public void updateTempOfferCount(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		dao.update("E_offerMapper.updateTempOfferCount", pd);
	}
	
    //new初始化电梯表状态
    public void initTempDetails(PageData pd)throws Exception{
    	dao.update("E_offerMapper.initTempDetails", pd);
    }
	public PageData selectTempElevEno(PageData apd) throws Exception {
		// TODO Auto-generated method stub
		return (PageData)dao.findForObject("E_offerMapper.selectTempElevEno", apd);
	}
	
	public void updateBJCEleENoById(String[] ele_id,String[] eno, PageData SelBjcpd)throws Exception{
	    PageData pd=new PageData();
	    String bjcEno = "";
//	    pd.put("bjc_id", bjc_id);
//      pd.put("eno",eno!=null&&eno.length>0?eno[i]:"");
        String enoString = Arrays.toString(eno);
        enoString = enoString.replace("[", "").replace("]", ",");
        enoString = enoString.replace(" ", "");
        PageData bjcDetail = FindBjcByBjcId(SelBjcpd);
        pd.put("eno", enoString.trim());
        pd.put("bjc_id", bjcDetail.get("BJC_ID"));
        if (bjcDetail!=null) {
            dao.update("E_offerMapper.updateBJCEleENoById",pd);
		}

    }
	
	// 补充项目信息
    public void editTempItemZongjie(PageData pd) throws Exception
    {
    	dao.update("E_offerMapper.editTempItemZongjie", pd);
    }
    
	public PageData OfferEleCount(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (PageData) dao.findForObject("E_offerMapper.OfferEleCount", pd);
	}
	public PageData findItemInOfferByItem(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		PageData res = (PageData) dao.findForObject("E_offerMapper.findItemInOfferByItem", pd);
		return res;
	}
	@SuppressWarnings("unchecked")
	public PageData findBJCModelsCount(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		PageData res = new PageData();
		Integer count = 0;
		List<Integer> bjcelenumList= (List<Integer>) dao.findForList("E_offerMapper.findBJCModelsCount", pd);
		for (Integer i : bjcelenumList) {
			count = count +i;
		}
		res.put("BJCmodelsCount", count);
		return res;
		
	}
	@Transactional
	public void updateOfferEle(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		int modifyCount = 0;
		System.out.println(pd);
		int modifyNum = Integer.parseInt(pd.getString("modifyEleNumInput"));
		int modelsNum = Integer.parseInt(pd.getString("modelsNum"));
		
		if (modelsNum>modifyNum) {
			System.out.println("减");
			modifyCount = modelsNum-modifyNum;
			pd.put("modifyCount", modifyCount);
			dao.delete("E_offerMapper.modifyEleDel",pd);
		}else {
			System.out.println("加");
			modifyCount = modifyNum-modelsNum;
			for (int i = 0; i < modifyCount; i++) {
				dao.save("E_offerMapper.modifyEleInsert",pd);
				
			}
			
		}
		
	}
	//根据报价池Id查询报价池内容
    private PageData FindBjcByBjcId(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		PageData BjcDetail = (PageData)dao.findForObject("E_offerMapper.FindBjcByBjcId", pd);
		return BjcDetail;
	}

    public void updateBJCEleENoByBJCId(PageData pd)throws Exception{
		dao.update("E_offerMapper.updateBJCEleENoByBJCId",pd);
    }

	public void delcoc3Count(PageData pd) {
		
		/*System.out.println("start");
		 KieServices ks = KieServices.Factory.get();
 	    KieContainer kContainer = ks.getKieClasspathContainer();
     	KieSession kSession = kContainer.newKieSession("ksession-rules");

         // go !
         Message message = new Message();
         message.setMessage("Hello World");
         message.setStatus(Message.HELLO);
         kSession.insert(message);
         int i = kSession.fireAllRules();
         System.out.println("执行了"+i);*/

	
	}
    
	@Transactional
	public void updateDtDetails(PageData pd) throws Exception{
		String eIds = pd.getString("ELEV_IDS");
		List<String> eIdList = Arrays.asList(eIds.split(","));
		PageData updPd = new PageData();
		updPd.put("list", eIdList);
		updateTempDetails(updPd);
    }
	
	/**
	 * 保存特种梯选项参数
	 * @throws Exception 
	 */
	@Transactional
	public void saveTezhongArg(PageData pd) throws Exception {
		dao.save("E_offerMapper.saveTezhongArg",pd);
	}
	
	//根据codid删除特种梯选项删除
    public void deleteTezhongArgOfCODId(PageData pd)throws Exception{
    	dao.delete("E_offerMapper.deleteTezhongArgOfCODId", pd);
    }
	
	//报价池 汇总计算 
    public PageData setBjcHzJs(PageData hzjsPd) throws Exception{
    	PageData pd=new PageData();
    	
    	pd.put("item_id", hzjsPd.getString("ITEM_ID"));
		pd.put("offer_version", hzjsPd.getString("offer_version"));
		List<PageData> bjcList= getBjs(pd);
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
			if(StringUtils.isNoneBlank(bjc.getString("BJC_SL"))){
				a= a.add(new BigDecimal(bjc.getString("BJC_SL"))); //数量
			}
			if(StringUtils.isNoneBlank(bjc.getString("SBSJZJ"))){
				b=b.add(new BigDecimal(bjc.getString("SBSJZJ"))); //设备实际总价
			}
			if(StringUtils.isNoneBlank(bjc.getString("YJZE"))){
				c = c.add(new BigDecimal(bjc.getString("YJZE")));   //佣金总额
			}
			if(bjc.getString("BJC_AZF")!=null && !"".equals(bjc.getString("BJC_AZF"))){
				d = d.add(new BigDecimal(bjc.getString("BJC_AZF")));//安装费
			}
			if(bjc.getString("BJC_YSF")!=null && !"".equals(bjc.getString("BJC_YSF"))){
				e = e.add(new BigDecimal(bjc.getString("BJC_YSF")));//运输费
			}
			if(bjc.getString("BJC_SJBJ")!=null && !"".equals(bjc.getString("BJC_SJBJ"))){
				f = f.add(new BigDecimal(bjc.getString("BJC_SJBJ")));//总价
			}
			if(bjc.getString("JJ_XXJJ")!=null && !"".equals(bjc.getString("JJ_XXJJ"))){
				g = g.add(new BigDecimal(bjc.getString("JJ_XXJJ")));//基价+选项加价
			}
			if(bjc.getString("SJ_FB_QT")!=null && !"".equals(bjc.getString("SJ_FB_QT"))){
				h = h.add(new BigDecimal(bjc.getString("SJ_FB_QT")));//实际-非标-其他*税率
			}
			if(bjc.getString("SJ_FB_QT_YJ")!=null && !"".equals(bjc.getString("SJ_FB_QT_YJ"))){
				j =j.add(new BigDecimal(bjc.getString("SJ_FB_QT_YJ"))); //实际-非标-其他*税率-佣金*税率
			}
      	}
		pd.put("id","1");
		pd= getShuiLv(pd);
		double ShuiLv=Double.parseDouble(pd.getString("content"));
		
		DecimalFormat df = new DecimalFormat("0.000");//格式化小数    
	
		if(bjcList.size()>0){
			pd.put("COUNT_SL", a);
			pd.put("COUNT_SJZJ", b);
			double count_zk = 0;
			try {
				count_zk = ((j.divide(g,8,BigDecimal.ROUND_HALF_UP)).multiply(new BigDecimal(100))).setScale(1,BigDecimal.ROUND_HALF_UP).doubleValue();
			} catch (Exception e1) {
				e1.printStackTrace();
			}
			pd.put("COUNT_ZK", count_zk);
//			String count_zk=df.format((float)j/g);
//			pd.put("COUNT_ZK", Double.parseDouble(count_zk));
			pd.put("COUNT_YJ", c);
			double count_bl= ((c.divide(b.divide(new BigDecimal(ShuiLv),8,BigDecimal.ROUND_HALF_UP),8,BigDecimal.ROUND_HALF_UP)).multiply(new BigDecimal(100))).setScale(1,BigDecimal.ROUND_HALF_UP).doubleValue();
			pd.put("COUNT_BL", count_bl);
//			String count_bl=df.format((float)c/(b/ShuiLv));
//			pd.put("COUNT_BL", Double.parseDouble(count_bl));
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
    	
		return pd;
    	
    }
    
    /**
     * 根据id获取特种梯
     * 
     * @param pd
     * @return
     * @throws Exception
     */
	public PageData findTezhong(PageData pd) throws Exception {
		return (PageData)dao.findForObject("E_offerMapper.findTezhong", pd);
	}
	
	/**
     * 根据codid获取特种梯选项参数
     * 
     * @param pd
     * @return
     * @throws Exception
     */
	public List<PageData> findTezhongArgs(PageData pd) throws Exception {
		return (List<PageData>)dao.findForList("E_offerMapper.findTezhongArgs", pd);
	}
	
	/**
	 * 根据报价池ID删除特种报价池
	 * @param pd
	 */
	@Transactional
    public void deleteTezhongByBjc(PageData pd)throws Exception{
    	dao.delete("E_offerMapper.deleteTezhongArgByBjc", pd);
    	dao.delete("E_offerMapper.deleteTezhongByBjc", pd);
    }

	public String getOfferNo(PageData pd) throws Exception {
		String offer_no = null;
		String str = new SimpleDateFormat("yyMMdd").format(new Date());
		PageData OfferNo= E_offer_NO(pd);
		if(OfferNo!=null)
		{
			String no=OfferNo.get("offer_no").toString();
			String v = no.substring(no.indexOf("B") + 1);
			String v1 = v.substring(0, 6);
			if(v1.equals(str)){
				DecimalFormat mFormat = new DecimalFormat("000");//确定格式，把1转换为001  
				String a = no.substring(no.indexOf("_") + 1);
				String b = a.substring(0, 3);
				int c=Integer.parseInt(b);
				String d = mFormat.format(c+1);
				offer_no="B"+str+"_"+d+"01";
			}
			else{
				offer_no="B"+str+"_00101";
			}
		}
		else{
			offer_no="B"+str+"_00101";
		}
		return offer_no;
	}
	
	
	@Transactional
	public PageData saveEOffer(PageData pd, String userId, Integer offversion) throws Exception {
		String offer_no = getOfferNo(null);
		//获取系统时间
		String df=DateUtil.getTime().toString(); 

		pd.put("offer_no", offer_no);//报价编号
		
		//报价版本号
		if(offversion == null || offversion == 0) {
			offversion = findLastOffVersion(pd.getString("item_id"));
			offversion += 1;
		}
		pd.put("offer_version",offversion);
		
		//无论是否有货梯存在，都生成流程实例
		pd.put("ZHEKOU",pd.getString("COUNT_ZK"));
		
		//调用生成流程实例
		//新建进入流程
		if (pd.get("copyFlag") == null) {
			PageData iteminfo =  FindItemDetailByItemId(pd);
			pd.putAll(iteminfo);
		}
		String processDefinitionKey = "offer_changguihuoti";   //存放流程的key
		
		PageData offerPd=new PageData();
		offerPd.put("KEY", processDefinitionKey);
		//查询流程是否存在
		List<PageData> straList = instance_key(offerPd);
		if(straList!=null){
			pd.put("offer_id", UUID.randomUUID().toString());
			pd.put("instance_status", 1);          //流程状态 1代表待启动
			pd.put("instance_id", processDefinitionKey);         //流程的key
			pd.put("offer_user", userId);         //录入信息请求启动的用户ID
			pd.put("offer_date", df);              //录入时间
			pd.put("KEY", processDefinitionKey);
			
			//同步保存报价信息
			saveTempItem(pd);
			saveS(pd);
			
			//-----生成流程实例
			WorkFlow workFlow=new WorkFlow();
			IdentityService identityService=workFlow.getIdentityService();
			identityService.setAuthenticatedUserId(userId);
			Object uuId=pd.get("offer_id");
			String businessKey="tb_e_offer.offer_id."+uuId;
			Map<String,Object> variables = new HashMap<String,Object>();
			variables.put("user_id", userId);
			ProcessInstance proessInstance=null; //存放生成的流程实例id
			if(processDefinitionKey!=null && !"".equals(processDefinitionKey)){
				proessInstance = workFlow.getRuntimeService().startProcessInstanceByKey(processDefinitionKey, businessKey, variables);
			}
			if(proessInstance!=null){
				pd.put("instance_id", proessInstance.getId());
				editS(pd);
				editSItemInOffer(pd);
			} else {
				throw new RuntimeException("生成流程实例失败");
			}
			
		} else {
			throw new RuntimeException("流程不存在");
		}
		return pd;
	}
	
	/**
	 * 保存飞尚MRL
	 * 
	 * @param pd 输入的电梯数据
	 * @param bjcPd 输入的报价池数据
	 * @param CountPd 输出的汇总数据
	 * @param userId 当前登陆用户
	 * @param eOfferPd 输出的报价数据
	 * @throws Exception
	 */
	@Transactional
	public void saveFeishangMrl(PageData pd,PageData bjcPd, PageData CountPd, String userId, PageData eOfferPd) throws Exception {
		if(!checkELEVIDS(bjcPd)) {
			pd.put("ELEV_IDS", bjcPd.get("BJC_ELEV"));
		}
		
		dao.save("E_offerMapper.saveFeishangMrl",pd);
		
		pd.put("BJ_DT_ID", pd.getString("FEISHANG_MRL_ID"));
		saveBjcStatic(pd, bjcPd, CountPd, userId, eOfferPd);
	}
	
	/**
     * 
     * 更新飞尚MRL
     * @param pd
     * @param xxArgList 
     * @throws Exception 
     */
	@Transactional
	public void updateFeishangMrl(PageData pd,PageData bjcPd, PageData CountPd) throws Exception {
		
		dao.update("E_offerMapper.updateFeishangMrl",pd);
		
		pd.put("BJ_DT_ID", pd.getString("FEISHANG_MRL_ID"));
		updateBjcStatic(pd, bjcPd, CountPd);
	}
	
	/**
	 * 保存飞尚
	 * 
	 * @param pd 输入的电梯数据
	 * @param bjcPd 输入的报价池数据
	 * @param CountPd 输出的汇总数据
	 * @param userId 当前登陆用户
	 * @param eOfferPd 输出的报价数据
	 * @throws Exception
	 */
	@Transactional
	public void saveFeishang(PageData pd,PageData bjcPd, PageData CountPd, String userId, PageData eOfferPd) throws Exception {
		if(!checkELEVIDS(bjcPd)) {
			pd.put("ELEV_IDS", bjcPd.get("BJC_ELEV"));
		}
		
		dao.save("E_offerMapper.saveFeishang",pd);
		
		pd.put("BJ_DT_ID", pd.getString("FEISHANG_ID"));
		saveBjcStatic(pd, bjcPd, CountPd, userId, eOfferPd);
	}
	
	/**
     * 
     * 更新飞尚
     * @param pd
     * @param xxArgList 
     * @throws Exception 
     */
	@Transactional
	public void updateFeishang(PageData pd,PageData bjcPd, PageData CountPd) throws Exception {
		dao.update("E_offerMapper.updateFeishang",pd);
		
		pd.put("BJ_DT_ID", pd.getString("FEISHANG_ID"));
		updateBjcStatic(pd, bjcPd, CountPd);
	}
	
	/**
	 * 保存飞扬3000
	 * 
	 * @param pd 输入的电梯数据
	 * @param bjcPd 输入的报价池数据
	 * @param CountPd 输出的汇总数据
	 * @param userId 当前登陆用户
	 * @param eOfferPd 输出的报价数据
	 * @throws Exception
	 */
	@Transactional
	public void saveFeiyang(PageData pd,PageData bjcPd, PageData CountPd, String userId, PageData eOfferPd) throws Exception {
		if(!checkELEVIDS(bjcPd)) {
			pd.put("ELEV_IDS", bjcPd.get("BJC_ELEV"));
		}
		
		dao.save("E_offerMapper.saveFeiyang",pd);
		
		pd.put("BJ_DT_ID", pd.getString("FEIYANG_ID"));
		saveBjcStatic(pd, bjcPd, CountPd, userId, eOfferPd);
	}
	
	/**
     * 
     * 更新飞扬3000
     * @param pd
     * @param xxArgList 
     * @throws Exception 
     */
	@Transactional
	public void updateFeiyang(PageData pd,PageData bjcPd, PageData CountPd) throws Exception {
		dao.update("E_offerMapper.updateFeiyang",pd);
		
		pd.put("BJ_DT_ID", pd.getString("FEIYANG_ID"));
		updateBjcStatic(pd, bjcPd, CountPd);
	}
	
	/**
	 * 保存飞扬3000MRL
	 * 
	 * @param pd 输入的电梯数据
	 * @param bjcPd 输入的报价池数据
	 * @param CountPd 输出的汇总数据
	 * @param userId 当前登陆用户
	 * @param eOfferPd 输出的报价数据
	 * @throws Exception
	 */
	@Transactional
	public void saveFeiyangMRL(PageData pd,PageData bjcPd, PageData CountPd, String userId, PageData eOfferPd) throws Exception {
		if(!checkELEVIDS(bjcPd)) {
			pd.put("ELEV_IDS", bjcPd.get("BJC_ELEV"));
		}
		
		dao.save("E_offerMapper.saveFeiyangMRL",pd);
		
		pd.put("BJ_DT_ID", pd.getString("FEIYANGMRL_ID"));
		saveBjcStatic(pd, bjcPd, CountPd, userId, eOfferPd);
	}
	
	/**
     * 
     * 更新飞扬3000
     * @param pd
     * @param xxArgList 
     * @throws Exception 
     */
	@Transactional
	public void updateFeiyangMRL(PageData pd,PageData bjcPd, PageData CountPd) throws Exception {
		dao.update("E_offerMapper.updateFeiyangMRL",pd);
		
		pd.put("BJ_DT_ID", pd.getString("FEIYANGXF_ID"));
		updateBjcStatic(pd, bjcPd, CountPd);
	}
	

	/**
	 * 保存飞扬消防
	 * 
	 * @param pd 输入的电梯数据
	 * @param bjcPd 输入的报价池数据
	 * @param CountPd 输出的汇总数据
	 * @param userId 当前登陆用户
	 * @param eOfferPd 输出的报价数据
	 * @throws Exception
	 */
	@Transactional
	public void saveFeiyangXF(PageData pd,PageData bjcPd, PageData CountPd, String userId, PageData eOfferPd) throws Exception {
		if(!checkELEVIDS(bjcPd)) {
			pd.put("ELEV_IDS", bjcPd.get("BJC_ELEV"));
		}
		
		dao.save("E_offerMapper.saveFeiyangXF",pd);
		
		pd.put("BJ_DT_ID", pd.getString("FEIYANGXF_ID"));
		saveBjcStatic(pd, bjcPd, CountPd, userId, eOfferPd);
	}
	
	/**
     * 
     * 更新飞扬消防
     * @param pd
     * @param xxArgList 
     * @throws Exception 
     */
	@Transactional
	public void updateFeiyangXF(PageData pd,PageData bjcPd, PageData CountPd) throws Exception {
		dao.update("E_offerMapper.updateFeiyangXF",pd);
		
		pd.put("BJ_DT_ID", pd.getString("FEIYANGMRL_ID"));
		updateBjcStatic(pd, bjcPd, CountPd);
	}
	
	/**
	 * 保存飞越
	 * 
	 * @param pd 输入的电梯数据
	 * @param bjcPd 输入的报价池数据
	 * @param CountPd 输出的汇总数据
	 * @param userId 当前登陆用户
	 * @param eOfferPd 输出的报价数据
	 * @throws Exception
	 */
	@Transactional
	public void saveFeiyue(PageData pd,PageData bjcPd, PageData CountPd, String userId, PageData eOfferPd) throws Exception {
		if(!checkELEVIDS(bjcPd)) {
			pd.put("ELEV_IDS", bjcPd.get("BJC_ELEV"));
		}
		
		dao.save("E_offerMapper.saveFeiyue",pd);
		
		pd.put("BJ_DT_ID", pd.getString("FEIYUE_ID"));
		saveBjcStatic(pd, bjcPd, CountPd, userId, eOfferPd);
	}
	
	/**
     * 
     * 更新飞越
     * @param pd
     * @param xxArgList 
     * @throws Exception 
     */
	@Transactional
	public void updateFeiyue(PageData pd,PageData bjcPd, PageData CountPd) throws Exception {
		dao.update("E_offerMapper.updateFeiyue",pd);
		
		pd.put("BJ_DT_ID", pd.getString("FEIYUE_ID"));
		updateBjcStatic(pd, bjcPd, CountPd);
	}
	
	
	@Transactional
	public void saveHouseHold(PageData pd,PageData bjcPd, PageData CountPd, String userId, PageData eOfferPd) throws Exception {
		if(!checkELEVIDS(bjcPd)) {
			pd.put("ELEV_IDS", bjcPd.get("BJC_ELEV"));
		}
		
		PageData models =findModelByid(pd);
		String ele_type = models.getString("ele_type");
		switch (ele_type) {
		case "DT12":
			dao.save("E_offerMapper.saveDELCO",pd);
			pd.put("BJ_DT_ID", pd.getString("HOUSEHOLD_ID"));
			break;
		case "DT13":
			dao.save("E_offerMapper.saveA2",pd);
			break;
		case "DT14":
			dao.save("E_offerMapper.saveA3",pd);
			break;
		default:
			//测试
			dao.save("E_offerMapper.saveDELCO",pd);
			pd.put("BJ_DT_ID", pd.getString("DELCO_ID"));
			break;
		}
		
		saveBjcStatic(pd, bjcPd, CountPd, userId, eOfferPd);
	}
	

	/**
	 * 保存飞越MRL
	 * 
	 * @param pd 输入的电梯数据
	 * @param bjcPd 输入的报价池数据
	 * @param CountPd 输出的汇总数据
	 * @param userId 当前登陆用户
	 * @param eOfferPd 输出的报价数据
	 * @throws Exception
	 */
	@Transactional
	public void saveFeiyueMRL(PageData pd,PageData bjcPd, PageData CountPd, String userId, PageData eOfferPd) throws Exception {
		if(!checkELEVIDS(bjcPd)) {
			pd.put("ELEV_IDS", bjcPd.get("BJC_ELEV"));
		}
		
		dao.save("E_offerMapper.saveFeiyueMRL",pd);
		
		pd.put("BJ_DT_ID", pd.getString("FEIYUEMRL_ID"));
		saveBjcStatic(pd, bjcPd, CountPd, userId, eOfferPd);
	}
	
	/**
     * 
     * 更新飞越MRL
     * @param pd
     * @param xxArgList 
     * @throws Exception 
     */
	@Transactional
	public void updateFeiyueMRL(PageData pd,PageData bjcPd, PageData CountPd) throws Exception {
		dao.update("E_offerMapper.updateFeiyueMRL",pd);
		
		pd.put("BJ_DT_ID", pd.getString("FEIYUEMRL_ID"));
		updateBjcStatic(pd, bjcPd, CountPd);
	}
	
	/**
     * 
     * 更新家用梯
     * @param pd
     * @param xxArgList 
     * @throws Exception 
     */
	@Transactional
	public void updateHOUSEHOLD(PageData pd,PageData bjcPd, PageData CountPd) throws Exception {
		pd.put("models_id", pd.getNoneNULLString("MODELS_ID"));
		PageData models = findModelByid(pd);
		String ele_type = models.getNoneNULLString("ele_type");
		switch (ele_type) {
		case "DT12":
			dao.update("E_offerMapper.updateHOUSEHOLDDelco",pd);
			break;
		case "DT11":
			dao.update("E_offerMapper.updateHOUSEHOLDDelco",pd);
			break;
		case "DT13":
			dao.update("E_offerMapper.updateHOUSEHOLDDelco",pd);
			break;

		default:
			break;
		}
		
		pd.put("BJ_DT_ID", pd.getString("HOUSEHOLD_ID"));
		updateBjcStatic(pd, bjcPd, CountPd);
	}
	

	/**
	 * 保存Dnp9300
	 * 
	 * @param pd 输入的电梯数据
	 * @param bjcPd 输入的报价池数据
	 * @param CountPd 输出的汇总数据
	 * @param userId 当前登陆用户
	 * @param eOfferPd 输出的报价数据
	 * @throws Exception
	 */
	@Transactional
	public void saveDnp9300(PageData pd,PageData bjcPd, PageData CountPd, String userId, PageData eOfferPd) throws Exception {
		if(!checkELEVIDS(bjcPd)) {
			pd.put("ELEV_IDS", bjcPd.get("BJC_ELEV"));
		}
		
		dao.save("E_offerMapper.saveDnp9300",pd);
		
		saveBjcStatic(pd, bjcPd, CountPd, userId, eOfferPd);
	}
	
	/**
     * 
     * 更新Dnp9300
     * @param pd
     * @param xxArgList 
     * @throws Exception 
     */
	@Transactional
	public void updateDnp9300(PageData pd,PageData bjcPd, PageData CountPd) throws Exception {
		dao.update("E_offerMapper.updateDnp9300",pd);
		
		updateBjcStatic(pd, bjcPd, CountPd);
	}
	
	/**
	 * 保存Dnr
	 * 
	 * @param pd 输入的电梯数据
	 * @param bjcPd 输入的报价池数据
	 * @param CountPd 输出的汇总数据
	 * @param userId 当前登陆用户
	 * @param eOfferPd 输出的报价数据
	 * @throws Exception
	 */
	@Transactional
	public void saveDnr(PageData pd,PageData bjcPd, PageData CountPd, String userId, PageData eOfferPd) throws Exception {
		if(!checkELEVIDS(bjcPd)) {
			pd.put("ELEV_IDS", bjcPd.get("BJC_ELEV"));
		}
		
		dao.save("E_offerMapper.saveDnr",pd);
		
		saveBjcStatic(pd, bjcPd, CountPd, userId, eOfferPd);
	}
	
	/**
     * 
     * 更新Dnr
     * @param pd
     * @param xxArgList 
     * @throws Exception 
     */
	@Transactional
	public void updateDnr(PageData pd,PageData bjcPd, PageData CountPd) throws Exception {
		dao.update("E_offerMapper.updateDnr",pd);
		
		updateBjcStatic(pd, bjcPd, CountPd);
	}
	
	/**
	 * 保存曳引货梯 
	 * 
	 * @param pd 输入的电梯数据
	 * @param bjcPd 输入的报价池数据
	 * @param CountPd 输出的汇总数据
	 * @param userId 当前登陆用户
	 * @param eOfferPd 输出的报价数据
	 * @throws Exception
	 */
	@Transactional
	public void saveShiny(PageData pd,PageData bjcPd, PageData CountPd, String userId, PageData eOfferPd) throws Exception {
		if(!checkELEVIDS(bjcPd)) {
			pd.put("ELEV_IDS", bjcPd.get("BJC_ELEV"));
		}
		
		dao.save("E_offerMapper.saveShiny",pd);
		
		pd.put("BJ_DT_ID", pd.getString("SHINY_ID"));
		saveBjcStatic(pd, bjcPd, CountPd, userId, eOfferPd);
	}
	
	/**
     * 
     * 更新曳引货梯
     * @param pd
     * @param xxArgList 
     * @throws Exception 
     */
	@Transactional
	public void updateShiny(PageData pd,PageData bjcPd, PageData CountPd) throws Exception {
		dao.update("E_offerMapper.updateShiny",pd);
		
		pd.put("BJ_DT_ID", pd.getString("SHINY_ID"));
		updateBjcStatic(pd, bjcPd, CountPd);
	}
	
	/**
     * 
     * 保存特种梯
     * @param pd
     * @param xxArgList 
     * @throws Exception 
     */
	@Transactional
	public void saveTezhong(PageData pd, PageData bjcPd, List<PageData> xxArgList, PageData CountPd, String userId, PageData eOfferPd) throws Exception {
		if(!checkELEVIDS(bjcPd)) {
			pd.put("ELEV_IDS", bjcPd.get("BJC_ELEV"));
		}
		
		//保存特种梯
		dao.save("E_offerMapper.saveTezhong",pd);
		
		//保存特种梯参数
		if(xxArgList != null && xxArgList.size() > 0) {
			for (PageData arg : xxArgList) {
				saveTezhongArg(arg);
			}
		}

		saveBjcStatic(pd, bjcPd, CountPd, userId, eOfferPd);
	}
	
	/**
	* 
	* 更新特种梯
	* @param pd
	* @param xxArgList 
	* @throws Exception 
	*/
	@Transactional
	public void updateTezhong(PageData pd,PageData bjcPd, List<PageData> xxArgList, PageData CountPd) throws Exception {
		
		//保存特种梯
		dao.update("E_offerMapper.updateTezhong",pd);
		
		///删除特种梯参数
		deleteTezhongArgOfCODId(new PageData("XXCS_COD_ID", pd.getString("TEZHONG_ID")));
		//保存特种梯参数
		if(xxArgList != null && xxArgList.size() > 0) {
			for (PageData arg : xxArgList) {
				saveTezhongArg(arg);
			}
		}
		
		updateBjcStatic(pd, bjcPd, CountPd);
	}
	
	/**
     * 
     * 保存特种梯
     * @param pd
     * @param xxArgList 
     * @throws Exception 
     */
	@Transactional
	public void saveTezhong(PageData pd,PageData bjcPd, List<PageData> xxArgList, PageData CountPd) throws Exception {
		
		//保存特种梯
		dao.save("E_offerMapper.saveTezhong",pd);
		
		//保存特种梯参数
		if(xxArgList != null && xxArgList.size() > 0) {
			int i = 0;
			for (PageData arg : xxArgList) {
				arg.put("sort", i++);
				saveTezhongArg(arg);
			}
		}
		
		//关联更新电梯报价状态信息 已报
		updateDtDetails(pd);
		
		//保存报价池
    	saveBjc(bjcPd);
		
    	//调用汇总数据方法
    	CountPd = setBjcHzJs(pd);
    	
    	pd.put("item_id", pd.getString("ITEM_ID"));
		PageData offerdetail = findItemInOfferByItem(pd);
		if (offerdetail!=null && !offerdetail.isEmpty()) {
			//编辑报价池后同步更新报价汇总
			CountPd.put("offer_id", offerdetail.get("offer_id"));
    		updateOfferCount(CountPd);
    		updateTempOfferCount(CountPd);
		}
	}
	
	private void saveBjcStatic(PageData pd, PageData bjcPd, PageData CountPd, String userId, PageData eOfferPd)
			throws Exception {
		//保存常规非标
		if(StringUtils.isNoneBlank(pd.getString("BJ_DT_ID"))) {
			saveConventionalNonstandard(pd);
		}
		
		//关联更新电梯报价状态信息 已报
		updateDtDetails(pd);
		
		//保存报价池
    	saveBjc(bjcPd);
    	
		
    	//调用汇总数据方法
    	if(CountPd == null)
    		CountPd = new PageData();
    	CountPd.putAll(setBjcHzJs(pd));
    	
    	pd.put("item_id", pd.getString("ITEM_ID"));
		PageData offerdetail = findItemInOfferByItem(pd);
		if (offerdetail!=null && !offerdetail.isEmpty()) {
			//编辑报价池后同步更新报价汇总
			CountPd.put("offer_id", offerdetail.get("offer_id"));
    		updateOfferCount(CountPd);
    		updateTempOfferCount(CountPd);
		} else {
			//保存梯形不保存报价
			if (pd.get("saveFlag") == null) {
				
				//申请非标保存报价
				if("1".equals(pd.getString("isSaveOffer"))) {
					PageData offerPd = (PageData) dao.findForObject("E_offerMapper.findItemByItemId", pd);
					offerPd.put("COUNT_SL", String.valueOf(CountPd.get("COUNT_SL")));
					offerPd.put("COUNT_SJZJ", String.valueOf(CountPd.get("COUNT_SJZJ")));
					offerPd.put("COUNT_ZK", String.valueOf(CountPd.get("COUNT_ZK")));
					offerPd.put("COUNT_YJ", String.valueOf(CountPd.get("COUNT_YJ")));
					offerPd.put("COUNT_BL", String.valueOf(CountPd.get("COUNT_BL")));
					offerPd.put("COUNT_AZF", String.valueOf(CountPd.get("COUNT_AZF")));
					offerPd.put("COUNT_YSF", String.valueOf(CountPd.get("COUNT_YSF")));
					offerPd.put("COUNT_TATOL", String.valueOf(CountPd.get("COUNT_TATOL")));
					offerPd.put("total", CountPd.get("COUNT_TATOL"));
					if(eOfferPd == null)
						eOfferPd = new PageData();
					eOfferPd.putAll(saveEOffer(offerPd, userId, Integer.valueOf(pd.getString("offer_version"))));
				}
			}
			
			
		}
	}
	
	private void updateBjcStatic(PageData pd, PageData bjcPd, PageData CountPd) throws Exception {
		//更新常规非标
		if(StringUtils.isNoneBlank(pd.getString("BJ_DT_ID"))) {
			updateConventionalNonstandard(pd);
		}
		
		//保存报价池
		updateBjc(bjcPd);
		
    	//调用汇总数据方法
		if(CountPd == null)
    		CountPd = new PageData();
    	CountPd.putAll(setBjcHzJs(pd));
    	
    	pd.put("item_id", pd.getString("ITEM_ID"));
		PageData offerdetail = findItemInOfferByItem(pd);
		if (offerdetail!=null && !offerdetail.isEmpty()) {
			//编辑报价池后同步更新报价汇总
			CountPd.put("offer_id", offerdetail.get("offer_id"));
    		updateOfferCount(CountPd);
    		updateTempOfferCount(CountPd);
		}
	}
	
	/**
	 * 电梯ids和flag查找电梯信息
	 * @throws Exception 
	 */
	public List<PageData> findTempEleDetailsByIdsAndFlag(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("E_offerMapper.findTempEleDetailsByIdsAndFlag", pd);
	}
	
	/**
	 * 验证ELEVIDS是否正确
	 * 
	 * @param bjcPd
	 * @return
	 * @throws Exception 
	 */
	private boolean checkELEVIDS(PageData bjcPd) throws Exception {
		if(bjcPd == null) return true;
		String elevIds = bjcPd.getNoneNULLString("BJC_ELEV");
		Integer sl = Integer.valueOf(bjcPd.getNoneNULLString("BJC_SL"));
		
		String[] AllElevID = elevIds.split(",");
		if(AllElevID != null && AllElevID.length > 0) {
			PageData elevID = new PageData();
			elevID.put("eleIds", AllElevID);
			elevID.put("flag", "1");
			List<PageData> eleYBList = findTempEleDetailsByIdsAndFlag(elevID);
		
			if(eleYBList != null && eleYBList.size() == sl) {
				return true;
			}
		}
		
		String itemId = bjcPd.getNoneNULLString("BJC_ITEM_ID");
		String offerVersion = bjcPd.getNoneNULLString("offer_version");
		String modelsId = bjcPd.getNoneNULLString("BJC_MODELS");
		
		PageData elewb = new PageData();
		elewb.put("models_id", modelsId);
		elewb.put("item_id", itemId);
		elewb.put("offer_version", offerVersion);
		List<PageData> wbEles = findTempEleBYmodels_id(elewb);
		if(sl > wbEles.size()) {
			throw new RuntimeException("报价电梯数量大于电梯数中未报的数量");
		}
		String elevstrID = "";
		String enostr = "";
		for(int i=0;i < sl;i++){
			elevstrID += wbEles.get(i).get("elevID").toString() + ",";
			enostr += wbEles.get(i).getString("eno") + ",";
		}
		bjcPd.put("BJC_ELEV", elevstrID);
		bjcPd.put("BJC_ENO", enostr);
		
		return false;
	}
	
	/**
	 *查询项目电梯总台数
	 * @throws Exception 
	 */
	public String findTempItemEleCountNum(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (String) dao.findForObject("E_offerMapper.findTempItemEleCountNum", pd);
	}
	public PageData findModelByid(PageData pd) throws Exception {
		
		return (PageData) dao.findForObject("E_offerMapper.findModelByid", pd);
		
	}
	

}
