package com.dncrm.controller.system.e_offer;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dncrm.controller.base.BaseController;
import com.dncrm.entity.system.User;
import com.dncrm.service.system.e_offer.E_offerService;
import com.dncrm.util.Const;
import com.dncrm.util.PageData;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@RequestMapping("/e_offerdt")
@Controller
public class E_offerDtController extends BaseController {

	//引入service层
    @Resource(name="e_offerService")
	private E_offerService e_offerService;
	
	
	//保存 飞尚货梯MRL
    @RequestMapping(value="saveFeishangMrl")
    @ResponseBody
    public Map<String, Object> saveFeishangMrl(){
    	PageData pd = new PageData();
    	pd = this.getPageData();
    	Map<String, Object> returnMap = new HashMap<String, Object>();
    	
    	String userId = getUser().getUSER_ID();
    	String feishangId = "";
    	String modelsId = "";
    	String bjcId = "";
    	String elevIds = "";
    	//调用汇总数据方法
    	PageData CountPd = new PageData();
    	PageData eOfferPd = new PageData();
    	try{
    		if(pd.getString("view").equals("edit")){
    			feishangId = pd.getString("FEISHANG_MRL_ID");
    			modelsId = pd.getString("MODELS_ID");
    			bjcId = pd.getString("BJC_ID");
    			elevIds = pd.getString("ELEV_IDS");
    			//调用获取电梯eno方法
    			String elevNo=elevNo(elevIds);
    			
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
	        	if(pd.getString("FEISHANG_MRL_FBJ")!=null && !"".equals(pd.getString("FEISHANG_MRL_FBJ"))){
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
	        	
	        	e_offerService.updateFeishangMrl(pd, bjcPd, CountPd);
    		}else{
    			//新增飞尚
	    		feishangId = this.get32UUID();
	    		pd.put("FEISHANG_MRL_ID", feishangId);
	        	
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

	        	pd.put("isSaveOffer", "1");
	        	e_offerService.saveFeishangMrl(pd, bjcPd, CountPd, userId, eOfferPd);
	        	returnMap.put("eOfferPd", eOfferPd);
	        	returnMap.put("eOfferAction", "e_offer/edit.do");
    		}
    		PageData srPd = new PageData();//save_result.jsp
        	srPd.put("c_", pd.getString("BZ_C"));
        	srPd.put("z_", pd.getString("BZ_Z"));
        	srPd.put("m_", pd.getString("BZ_M"));
        	srPd.put("sbj_", pd.getString("FEISHANG_MRL_SBSJBJ"));
        	srPd.put("zk_", pd.getString("FEISHANG_MRL_ZKL"));
        	srPd.put("zhsbj_", pd.getString("FEISHANG_MRL_ZHSBJ"));
        	srPd.put("sjbj_", pd.getString("FEISHANG_MRL_TATOL"));
        	srPd.put("ele_azf_", pd.getString("ELE_AZF"));
        	srPd.put("azf_", pd.getString("FEISHANG_MRL_AZJ"));
        	srPd.put("ysf_", pd.getString("FEISHANG_MRL_YSJ"));
        	srPd.put("yjze_", pd.getString("FEISHANG_MRL_YJZE"));
        	srPd.put("yjbl_", pd.getString("FEISHANG_MRL_YJBL"));
        	srPd.put("tsf_", pd.getString("OTHP_TSF"));
        	srPd.put("cjf_", pd.getString("OTHP_CJF"));
        	srPd.put("rowIndex", pd.getString("rowIndex"));
        	
        	returnMap.put("dtCodId", feishangId);
        	returnMap.put("bjc_id", bjcId);
        	returnMap.put("modelsId", modelsId);
        	returnMap.put("elevIds", elevIds);
        	returnMap.put("CountPd", CountPd);
        	returnMap.put("srPd", srPd);
        	returnMap.put("rowIndex", pd.getString("rowIndex"));
        	returnMap.put("code", 1);
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
        	returnMap.put("code", 0);
    	}
    	return returnMap;
    }
    
  //保存 飞尚曳引货梯
    @RequestMapping(value="saveFeishang")
    @ResponseBody
    public Map<String, Object> saveFeishang(){
    	PageData pd = new PageData();
    	pd = this.getPageData();
    	Map<String, Object> returnMap = new HashMap<String, Object>();
    	//超出高度价格加入到实际报价
    	/*Double SJBJ = Double.parseDouble(pd.get("FEISHANG_SBSJBJ").toString());
    	Double CCJG = Double.parseDouble(pd.getString("BASE_CCJG"));
    	pd.put("FEISHANG_SBSJBJ", SJBJ+CCJG);*/
    	//feishangId,modelsId,bjcId,elevIds新增/编辑页面关闭之后重新给报价池页面的button赋值
    	String userId = getUser().getUSER_ID();
    	String feishangId = "";
    	String modelsId = "";
    	String bjcId = "";
    	String elevIds = "";
    	//调用汇总数据方法
    	PageData CountPd = new PageData();
    	PageData eOfferPd = new PageData();
    	try{
    		if(pd.getString("view").equals("edit")){
    			feishangId = pd.getString("FEISHANG_ID");
    			modelsId = pd.getString("MODELS_ID");
    			bjcId = pd.getString("BJC_ID");
    			elevIds = pd.getString("ELEV_IDS");
    			//调用获取电梯eno方法
    			String elevNo=elevNo(elevIds);
    			
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
	        	if(pd.getString("FEISHANG_FBJ")!=null && !"".equals(pd.getString("FEISHANG_FBJ"))){
	        		fbj=Integer.parseInt(pd.getString("FEISHANG_FBJ"));//非标价
	        	}
	        	
	        	PageData pdSl=new PageData();
	        	pdSl.put("id","1");
	        	try {
	        		pdSl= e_offerService.getShuiLv(pdSl);
	    		} catch (Exception e) {
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
	        	
	        	e_offerService.updateFeishang(pd, bjcPd, CountPd);
    		}else{
    			//新增飞尚
	    		feishangId = this.get32UUID();
	    		pd.put("FEISHANG_ID", feishangId);
	    		
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
	        	if(pd.getString("FEISHANG_FBJ")!=null && !"".equals(pd.getString("FEISHANG_FBJ"))){
	        		fbj=Integer.parseInt(pd.getString("FEISHANG_FBJ"));//非标价
	        	}
	        	
	        	PageData pdSl=new PageData();
	        	pdSl.put("id","1");
	        	try {
	        		pdSl= e_offerService.getShuiLv(pdSl);
	    		} catch (Exception e) {
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
	        	
	        	pd.put("isSaveOffer", "1");
	        	e_offerService.saveFeishang(pd, bjcPd, CountPd, userId, eOfferPd);
	        	returnMap.put("eOfferPd", eOfferPd);
	        	returnMap.put("eOfferAction", "e_offer/edit.do");
    		}
    		PageData srPd = new PageData();//save_result.jsp
        	srPd.put("c_", pd.getString("BZ_C"));
        	srPd.put("z_", pd.getString("BZ_Z"));
        	srPd.put("m_", pd.getString("BZ_M"));
        	srPd.put("sbj_", pd.getString("FEISHANG_SBSJBJ"));
        	srPd.put("zk_", pd.getString("FEISHANG_ZKL"));
        	srPd.put("zhsbj_", pd.getString("FEISHANG_ZHSBJ"));
        	srPd.put("sjbj_", pd.getString("FEISHANG_TATOL"));
        	srPd.put("ele_azf_", pd.getString("ELE_AZF"));
        	srPd.put("azf_", pd.getString("FEISHANG_AZJ"));
        	srPd.put("ysf_", pd.getString("FEISHANG_YSJ"));
        	srPd.put("yjze_", pd.getString("FEISHANG_YJZE"));
        	srPd.put("yjbl_", pd.getString("FEISHANG_YJBL"));
        	srPd.put("tsf_", pd.getString("OTHP_TSF"));
        	srPd.put("cjf_", pd.getString("OTHP_CJF"));
        	srPd.put("rowIndex", pd.getString("rowIndex"));
        	
        	returnMap.put("dtCodId", feishangId);
        	returnMap.put("bjc_id", bjcId);
        	returnMap.put("modelsId", modelsId);
        	returnMap.put("elevIds", elevIds);
        	returnMap.put("CountPd", CountPd);
        	returnMap.put("srPd", srPd);
        	returnMap.put("rowIndex", pd.getString("rowIndex"));
        	returnMap.put("code", 1);
    	}catch(Exception e){
        	returnMap.put("code", 0);
    		logger.error(e.getMessage(), e);
    	}
    	return returnMap;
    }
    
    
  //保存 飞扬3000+
    @RequestMapping(value="saveFeiyang")
    @ResponseBody
    public Map<String, Object> saveFeiyang(){
    	PageData pd = new PageData();
    	pd = this.getPageData();
    	Map<String, Object> returnMap = new HashMap<String, Object>();
    	//feishangId,modelsId,bjcId,elevIds新增/编辑页面关闭之后重新给报价池页面的button赋值
    	String userId = getUser().getUSER_ID();
    	String feiyangId = "";
    	String modelsId = "";
    	String bjcId = "";
    	String elevIds = "";
    	//调用汇总数据方法
    	PageData CountPd = new PageData();
    	PageData eOfferPd = new PageData();
    	try{
    		if(pd.getString("view").equals("edit")){
    			feiyangId = pd.getString("FEIYANG_ID");
    			modelsId = pd.getString("MODELS_ID");
    			bjcId = pd.getString("BJC_ID");
    			elevIds = pd.getString("ELEV_IDS");
    			//调用获取电梯eno方法
    			String elevNo=elevNo(elevIds);
    			
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
	        	PageData hzPd= setHzBjc(pd);
	        	bjcPd.put("JJ_XXJJ", hzPd.getString("JJ_XXJJ"));//基价+选项加价
	        	bjcPd.put("SJ_FB_QT", hzPd.getString("SJ_FB_QT"));//实际-非标-其他*1.17
	        	bjcPd.put("SJ_FB_QT_YJ", hzPd.getString("SJ_FB_QT_YJ"));//实际-非标-其他*1.17-佣金*1.17
	        	
	        	e_offerService.updateFeiyang(pd, bjcPd, CountPd);
    		}else{
    			//新增保存飞扬
        		feiyangId = this.get32UUID();
        		pd.put("FEIYANG_ID", feiyangId);
            	
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

	        	pd.put("isSaveOffer", "1");
	        	e_offerService.saveFeiyang(pd, bjcPd, CountPd, userId, eOfferPd);
	        	returnMap.put("eOfferPd", eOfferPd);
	        	returnMap.put("eOfferAction", "e_offer/edit.do");
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
        	srPd.put("ele_azf_", pd.getString("ELE_AZF"));
        	srPd.put("azf_", pd.getString("XS_AZJ"));//+
        	srPd.put("ysf_", pd.getString("XS_YSJ"));//+
        	srPd.put("yjze_", pd.getString("XS_YJZE"));//+
        	srPd.put("yjbl_", pd.getString("XS_YJBL"));//+
        	srPd.put("tsf_", pd.getString("OTHP_TSF"));
        	srPd.put("cjf_", pd.getString("OTHP_CJF"));
        	
        	returnMap.put("dtCodId", feiyangId);
        	returnMap.put("bjc_id", bjcId);
        	returnMap.put("modelsId", modelsId);
        	returnMap.put("elevIds", elevIds);
        	returnMap.put("CountPd", CountPd);
        	returnMap.put("srPd", srPd);
        	returnMap.put("rowIndex", pd.getString("rowIndex"));
        	returnMap.put("code", 1);
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
        	returnMap.put("code", 0);
    	}
    	return returnMap;
    }
    
  //保存新增 飞扬3000+MRL
    @RequestMapping(value="saveFeiyangMRL")
    @ResponseBody
    public Map<String, Object> saveFeiyangMRL(){
    	PageData pd = new PageData();
    	pd = this.getPageData();
    	Map<String, Object> returnMap = new HashMap<String, Object>();
    	//feishangId,modelsId,bjcId,elevIds新增/编辑页面关闭之后重新给报价池页面的button赋值
    	String userId = getUser().getUSER_ID();
    	String feiyangMrlId = "";
    	String modelsId = "";
    	String bjcId = "";
    	String elevIds = "";
    	//调用汇总数据方法
    	PageData CountPd = new PageData();
    	PageData eOfferPd = new PageData();
    	try{
    		if(pd.getString("view").equals("edit")){
    			feiyangMrlId = pd.getString("FEIYANGMRL_ID");
				modelsId = pd.getString("MODELS_ID");
				bjcId = pd.getString("BJC_ID");
				elevIds = pd.getString("ELEV_IDS");
				//调用获取电梯eno方法
    			String elevNo=elevNo(elevIds);
				
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
	        	
	        	e_offerService.updateFeiyangMRL(pd, bjcPd, CountPd);
    		}else{
    			//保存飞扬MRL
	    		feiyangMrlId = this.get32UUID();
	    		pd.put("FEIYANGMRL_ID", feiyangMrlId);
	    		
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
	        	
	        	pd.put("isSaveOffer", "1");
	        	e_offerService.saveFeiyangMRL(pd, bjcPd, CountPd, userId, eOfferPd);
	        	returnMap.put("eOfferPd", eOfferPd);
	        	returnMap.put("eOfferAction", "e_offer/edit.do");
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
        	srPd.put("ele_azf_", pd.getString("ELE_AZF"));
        	srPd.put("azf_", pd.getString("XS_AZJ"));//+
        	srPd.put("ysf_", pd.getString("XS_YSJ"));//+
        	srPd.put("yjze_", pd.getString("XS_YJZE"));//+
        	srPd.put("yjbl_", pd.getString("XS_YJBL"));//+
        	srPd.put("tsf_", pd.getString("OTHP_TSF"));
        	srPd.put("cjf_", pd.getString("OTHP_CJF"));
        	
        	returnMap.put("dtCodId", feiyangMrlId);
        	returnMap.put("bjc_id", bjcId);
        	returnMap.put("modelsId", modelsId);
        	returnMap.put("elevIds", elevIds);
        	returnMap.put("CountPd", CountPd);
        	returnMap.put("srPd", srPd);
        	returnMap.put("rowIndex", pd.getString("rowIndex"));
        	returnMap.put("code", 1);
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
        	returnMap.put("code", 0);
    	}
    	return returnMap;
    }
	
  //保存新增 飞扬消防梯
    @RequestMapping(value="saveFeiyangXF")
    @ResponseBody
    public Map<String, Object> saveFeiyangXF(){
    	PageData pd = new PageData();
		pd = this.getPageData();
    	Map<String, Object> returnMap = new HashMap<String, Object>();
		//feishangId,modelsId,bjcId,elevIds新增/编辑页面关闭之后重新给报价池页面的button赋值
    	String userId = getUser().getUSER_ID();
    	String feiyangxfId = "";
    	String modelsId = "";
    	String bjcId = "";
    	String elevIds = "";
    	//调用汇总数据方法
    	PageData CountPd = new PageData();
    	PageData eOfferPd = new PageData();
    	try{
    		if(pd.getString("view").equals("edit")){
    			feiyangxfId = pd.getString("FEIYANGXF_ID");
    			modelsId = pd.getString("MODELS_ID");
    			bjcId = pd.getString("BJC_ID");
    			elevIds = pd.getString("ELEV_IDS");
    			//调用获取电梯eno方法
    			String elevNo=elevNo(elevIds);
    			
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

	        	e_offerService.updateFeiyangXF(pd, bjcPd, CountPd);
    		}else{
	    		feiyangxfId = this.get32UUID();
	    		pd.put("FEIYANGXF_ID", feiyangxfId);
	    		
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
	        	if(pd.getString("FEIYANG_XF_FBJ")!=null && !"".equals(pd.getString("FEIYANG_XF_FBJ"))){
	        		fbj=Integer.parseInt(pd.getString("FEIYANG_XF_FBJ"));//非标价
	        	}
	        	
	        	PageData pdSl=new PageData();
	        	pdSl.put("id","1");
	        	try {
	        		pdSl= e_offerService.getShuiLv(pdSl);
	    		} catch (Exception e) {
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

	        	pd.put("isSaveOffer", "1");
	        	e_offerService.saveFeiyangXF(pd, bjcPd, CountPd, userId, eOfferPd);
	        	returnMap.put("eOfferPd", eOfferPd);
	        	returnMap.put("eOfferAction", "e_offer/edit.do");
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
        	srPd.put("ele_azf_", pd.getString("ELE_AZF"));
        	srPd.put("azf_", pd.getString("FEIYANG_XF_AZJ"));
        	srPd.put("ysf_", pd.getString("FEIYANG_XF_YSJ"));
        	srPd.put("yjze_", pd.getString("FEIYANG_XF_YJZE"));
        	srPd.put("yjbl_", pd.getString("FEIYANG_XF_YJBL"));
        	srPd.put("tsf_", pd.getString("OTHP_TSF"));
        	srPd.put("cjf_", pd.getString("OTHP_CJF"));

        	returnMap.put("dtCodId", feiyangxfId);
        	returnMap.put("bjc_id", bjcId);
        	returnMap.put("modelsId", modelsId);
        	returnMap.put("elevIds", elevIds);
        	returnMap.put("CountPd", CountPd);
        	returnMap.put("srPd", srPd);
        	returnMap.put("rowIndex", pd.getString("rowIndex"));
        	returnMap.put("code", 1);
    	}catch(Exception e){
    		logger.error(e.getMessage());
        	returnMap.put("code", 0);
    	}
    	return returnMap;
    }
    
  //保存 飞越
    @RequestMapping(value="saveFeiyue")
    @ResponseBody
    public Map<String, Object> saveFeiyue(){
    	PageData pd = new PageData();
		pd = this.getPageData();
    	Map<String, Object> returnMap = new HashMap<String, Object>();
		//feishangId,modelsId,bjcId,elevIds新增/编辑页面关闭之后重新给报价池页面的button赋值
    	String userId = getUser().getUSER_ID();
    	String feiyueId = "";
    	String modelsId = "";
    	String bjcId = "";
    	String elevIds = "";
    	//调用汇总数据方法
    	PageData CountPd = new PageData();
    	PageData eOfferPd = new PageData();
    	try{

    		if(pd.getString("view").equals("edit")){
    			feiyueId = pd.getString("FEIYUE_ID");
    			modelsId = pd.getString("MODELS_ID");
    			bjcId = pd.getString("BJC_ID");
    			elevIds = pd.getString("ELEV_IDS");
    			//调用获取电梯eno方法
    			String elevNo=elevNo(elevIds);
    			
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
	        	
	        	e_offerService.updateFeiyue(pd, bjcPd, CountPd);
	        	
    		}else{
	    		feiyueId = this.get32UUID();
	    		pd.put("FEIYUE_ID", feiyueId);
	    		
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
	        	
	        	pd.put("isSaveOffer", "1");
	        	e_offerService.saveFeiyue(pd, bjcPd, CountPd, userId, eOfferPd);
	        	returnMap.put("eOfferPd", eOfferPd);
	        	returnMap.put("eOfferAction", "e_offer/edit.do");
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
        	srPd.put("ele_azf_", pd.getString("ELE_AZF"));
        	srPd.put("azf_", pd.getString("XS_AZJ"));//+
        	srPd.put("ysf_", pd.getString("XS_YSJ"));//+
        	srPd.put("yjze_", pd.getString("XS_YJZE"));//+
        	srPd.put("yjbl_", pd.getString("XS_YJBL"));//+
        	srPd.put("tsf_", pd.getString("OTHP_TSF"));
        	srPd.put("cjf_", pd.getString("OTHP_CJF"));

        	returnMap.put("dtCodId", feiyueId);
        	returnMap.put("bjc_id", bjcId);
        	returnMap.put("modelsId", modelsId);
        	returnMap.put("elevIds", elevIds);
        	returnMap.put("CountPd", CountPd);
        	returnMap.put("srPd", srPd);
        	returnMap.put("rowIndex", pd.getString("rowIndex"));
        	returnMap.put("code", 1);
    	}catch(Exception e){
    		logger.error(e.getMessage());
        	returnMap.put("code", 0);
    	}
    	return returnMap;
    }
    
  //保存 家用梯
    @RequestMapping(value="saveHousehold")
    @ResponseBody
    public Map<String, Object> saveHousehold(){
    	PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("models_id", pd.getNoneNULLString("MODELS_ID"));
    	Map<String, Object> returnMap = new HashMap<String, Object>();
		//feishangId,modelsId,bjcId,elevIds新增/编辑页面关闭之后重新给报价池页面的button赋值
    	String userId = getUser().getUSER_ID();
    	String HOUSEHOLD_ID = "";
    	String modelsId = "";
    	String bjcId = "";
    	String elevIds = "";
    	//调用汇总数据方法
    	PageData CountPd = new PageData();
    	PageData eOfferPd = new PageData();
    	try{

    		if(pd.getString("view").equals("edit")){
    			HOUSEHOLD_ID = pd.getString("HOUSEHOLD_ID");
    			modelsId = pd.getString("MODELS_ID");
    			bjcId = pd.getString("BJC_ID");
    			elevIds = pd.getString("ELEV_IDS");
    			//调用获取电梯eno方法
    			String elevNo=elevNo(elevIds);
    			
    			//关联更新报价池
    			PageData bjcPd = new PageData();
    			bjcPd.put("offer_version", pd.getString("offer_version"));
    			bjcPd.put("BJC_ENO", elevNo);
	        	bjcPd.put("BJC_ID", pd.getString("BJC_ID"));
	        	bjcPd.put("BJC_COD_ID", pd.getString("HOUSEHOLD_SL"));
	        	bjcPd.put("BJC_ITEM_ID", pd.get("ITEM_ID").toString());
	        	bjcPd.put("BJC_ELEV", pd.get("ELEV_IDS").toString());
	        	bjcPd.put("BJC_MODELS", pd.get("MODELS_ID").toString());
	        	bjcPd.put("BJC_ZHSBJ", "0");
	        	bjcPd.put("BJC_SL", pd.get("HOUSEHOLD_SL").toString());
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
	        	
	        	e_offerService.updateHOUSEHOLD(pd, bjcPd, CountPd);
	        	
    		}else{
    			HOUSEHOLD_ID = this.get32UUID();
	    		
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
	        	bjcPd.put("BJC_COD_ID", HOUSEHOLD_ID);
	        	bjcPd.put("BJC_ITEM_ID", pd.get("ITEM_ID").toString());
	        	bjcPd.put("BJC_ELEV", pd.get("ELEV_IDS").toString());
	        	bjcPd.put("BJC_MODELS", pd.get("MODELS_ID").toString());
	        	bjcPd.put("BJC_ZHSBJ", "0");
	        	bjcPd.put("BJC_SL", pd.get("HOUSEHOLD_SL").toString());
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
	        	
	        	pd.put("isSaveOffer", "1");
	        	pd.put("HOUSEHOLD_ID", HOUSEHOLD_ID);
	        	e_offerService.saveHouseHold(pd, bjcPd, CountPd, userId, eOfferPd);
	        	returnMap.put("eOfferPd", eOfferPd);
	        	returnMap.put("eOfferAction", "e_offer/edit.do");
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
        	srPd.put("ele_azf_", pd.getString("ELE_AZF"));
        	srPd.put("azf_", pd.getString("XS_AZJ"));//+
        	srPd.put("ysf_", pd.getString("XS_YSJ"));//+
        	srPd.put("yjze_", pd.getString("XS_YJZE"));//+
        	srPd.put("yjbl_", pd.getString("XS_YJBL"));//+
        	srPd.put("tsf_", pd.getString("OTHP_TSF"));
        	srPd.put("cjf_", pd.getString("OTHP_CJF"));

        	returnMap.put("dtCodId", HOUSEHOLD_ID);
        	returnMap.put("bjc_id", bjcId);
        	returnMap.put("modelsId", modelsId);
        	returnMap.put("elevIds", elevIds);
        	returnMap.put("CountPd", CountPd);
        	returnMap.put("srPd", srPd);
        	returnMap.put("rowIndex", pd.getString("rowIndex"));
        	returnMap.put("code", 1);
    	}catch(Exception e){
    		e.printStackTrace();
    		logger.error(e.getMessage());
        	returnMap.put("code", 0);
    	}
    	return returnMap;
    }
	
  //保存 飞越_MRL
    @RequestMapping(value="saveFeiyueMRL")
    @ResponseBody
    public Map<String, Object> saveFeiyueMRL(){
    	PageData pd = new PageData();
		pd = this.getPageData();
    	Map<String, Object> returnMap = new HashMap<String, Object>();
		//feishangId,modelsId,bjcId,elevIds新增/编辑页面关闭之后重新给报价池页面的button赋值
    	String userId = getUser().getUSER_ID();
    	String feiyuemrlId = "";
    	String modelsId = "";
    	String bjcId = "";
    	String elevIds = "";
    	//调用汇总数据方法
    	PageData CountPd = new PageData();
    	PageData eOfferPd = new PageData();
    	try{
    		if(pd.getString("view").equals("edit")){
    			feiyuemrlId = pd.getString("FEIYUEMRL_ID");
				modelsId = pd.getString("MODELS_ID");
				bjcId = pd.getString("BJC_ID");
				elevIds = pd.getString("ELEV_IDS");
				//调用获取电梯eno方法
    			String elevNo=elevNo(elevIds);
				
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
	        	
	        	e_offerService.updateFeiyueMRL(pd, bjcPd, CountPd);
    		}else{
	    		feiyuemrlId = this.get32UUID();
	    		pd.put("FEIYUEMRL_ID", feiyuemrlId);
	        	
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
	        	
	        	pd.put("isSaveOffer", "1");
	        	e_offerService.saveFeiyueMRL(pd, bjcPd, CountPd, userId, eOfferPd);
	        	returnMap.put("eOfferPd", eOfferPd);
	        	returnMap.put("eOfferAction", "e_offer/edit.do");
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
        	srPd.put("ele_azf_", pd.getString("ELE_AZF"));
        	srPd.put("azf_", pd.getString("XS_AZJ"));//+
        	srPd.put("ysf_", pd.getString("XS_YSJ"));//+
        	srPd.put("yjze_", pd.getString("XS_YJZE"));//+
        	srPd.put("yjbl_", pd.getString("XS_YJBL"));//+
        	srPd.put("tsf_", pd.getString("OTHP_TSF"));
        	srPd.put("cjf_", pd.getString("OTHP_CJF"));

        	returnMap.put("dtCodId", feiyuemrlId);
        	returnMap.put("bjc_id", bjcId);
        	returnMap.put("modelsId", modelsId);
        	returnMap.put("elevIds", elevIds);
        	returnMap.put("CountPd", CountPd);
        	returnMap.put("srPd", srPd);
        	returnMap.put("rowIndex", pd.getString("rowIndex"));
        	returnMap.put("code", 1);
    	}catch(Exception e){
        	returnMap.put("code", 0);
    		logger.error(e.getMessage());
    	}
    	return returnMap;
    }
    
  //保存扶梯 DNP9300
    @RequestMapping(value="saveDnp9300")
    @ResponseBody
    public Map<String, Object> saveDnp9300(){
    	PageData pd = new PageData();
		pd = this.getPageData();
    	Map<String, Object> returnMap = new HashMap<String, Object>();
		//feishangId,modelsId,bjcId,elevIds新增/编辑页面关闭之后重新给报价池页面的button赋值
    	String userId = getUser().getUSER_ID();
    	String dnp9300Id = "";
    	String modelsId = "";
    	String bjcId = "";
    	String elevIds = "";
    	//调用汇总数据方法
    	PageData CountPd = new PageData();
    	PageData eOfferPd = new PageData();
    	try{
    		if(pd.getString("view").equals("edit")){
    			dnp9300Id = pd.getString("DNP9300_ID");
				modelsId = pd.getString("MODELS_ID");
				bjcId = pd.getString("BJC_ID");
				elevIds = pd.getString("ELEV_IDS");
				//调用获取电梯eno方法
    			String elevNo=elevNo(elevIds);
				
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
	        	
	        	e_offerService.updateDnp9300(pd, bjcPd, CountPd);
    		}else{
	    		dnp9300Id = this.get32UUID();
	    		pd.put("DNP9300_ID", dnp9300Id);
	    		
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
	        	
	        	pd.put("isSaveOffer", "1");
	        	e_offerService.saveDnp9300(pd, bjcPd, CountPd, userId, eOfferPd);
	        	returnMap.put("eOfferPd", eOfferPd);
	        	returnMap.put("eOfferAction", "e_offer/edit.do");
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
        	srPd.put("ele_azf_", pd.getString("ELE_AZF"));
        	srPd.put("azf_", pd.getString("XS_AZJ"));//+
        	srPd.put("ysf_", pd.getString("XS_YSJ"));//+
        	srPd.put("yjze_", pd.getString("XS_YJZE"));//+
        	srPd.put("yjbl_", pd.getString("XS_YJBL"));//+
        	srPd.put("tsf_", pd.getString("OTHP_TSF"));
        	srPd.put("cjf_", pd.getString("OTHP_CJF"));
        	
        	returnMap.put("dtCodId", dnp9300Id);
        	returnMap.put("bjc_id", bjcId);
        	returnMap.put("modelsId", modelsId);
        	returnMap.put("elevIds", elevIds);
        	returnMap.put("CountPd", CountPd);
        	returnMap.put("srPd", srPd);
        	returnMap.put("rowIndex", pd.getString("rowIndex"));
        	returnMap.put("code", 1);
    	}catch(Exception e){
        	returnMap.put("code", 0);
    		logger.error(e.getMessage(), e);
    	}
    	return returnMap;
    }
    
  //保存 DNR
    @RequestMapping(value="saveDnr")
    @ResponseBody
    public Map<String, Object> saveDnr(){
    	PageData pd = new PageData();
		pd = this.getPageData();
    	Map<String, Object> returnMap = new HashMap<String, Object>();
		//feishangId,modelsId,bjcId,elevIds新增/编辑页面关闭之后重新给报价池页面的button赋值
    	String userId = getUser().getUSER_ID();
    	String dnrId = "";
    	String modelsId = "";
    	String bjcId = "";
    	String elevIds = "";
    	//调用汇总数据方法
    	PageData CountPd = new PageData();
    	PageData eOfferPd = new PageData();
    	try{
    		if(pd.getString("view").equals("edit")){
    			dnrId = pd.getString("DNR_ID");
				modelsId = pd.getString("MODELS_ID");
				bjcId = pd.getString("BJC_ID");
				elevIds = pd.getString("ELEV_IDS");
				//调用获取电梯eno方法
    			String elevNo=elevNo(elevIds);
				
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
	        	
	        	e_offerService.updateDnr(pd, bjcPd, CountPd);
    		}else{
	    		dnrId = this.get32UUID();
	    		pd.put("DNR_ID", dnrId);
	    		
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
	        	
	        	pd.put("isSaveOffer", "1");
	        	e_offerService.saveDnr(pd, bjcPd, CountPd, userId, eOfferPd);
	        	returnMap.put("eOfferPd", eOfferPd);
	        	returnMap.put("eOfferAction", "e_offer/edit.do");
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
        	srPd.put("ele_azf_", pd.getString("ELE_AZF"));
        	srPd.put("azf_", pd.getString("XS_AZJ"));//+
        	srPd.put("ysf_", pd.getString("XS_YSJ"));//+
        	srPd.put("yjze_", pd.getString("XS_YJZE"));//+
        	srPd.put("yjbl_", pd.getString("XS_YJBL"));//+
        	srPd.put("tsf_", pd.getString("OTHP_TSF"));
        	srPd.put("cjf_", pd.getString("OTHP_CJF"));
        	
        	returnMap.put("dtCodId", dnrId);
        	returnMap.put("bjc_id", bjcId);
        	returnMap.put("modelsId", modelsId);
        	returnMap.put("elevIds", elevIds);
        	returnMap.put("CountPd", CountPd);
        	returnMap.put("srPd", srPd);
        	returnMap.put("rowIndex", pd.getString("rowIndex"));
        	returnMap.put("code", 1);
    	}catch(Exception e){
        	returnMap.put("code", 0);
    		logger.error(e.getMessage(), e);
    	}
    	return returnMap;
    }
    
  //保存曳引货梯 
    @RequestMapping(value="saveShiny")
    @ResponseBody
    public Map<String, Object> saveShiny(){
    	PageData pd = new PageData();
		pd = this.getPageData();
    	Map<String, Object> returnMap = new HashMap<String, Object>();
		//feishangId,modelsId,bjcId,elevIds新增/编辑页面关闭之后重新给报价池页面的button赋值
    	String userId = getUser().getUSER_ID();
    	String shinyId = "";
    	String modelsId = "";
    	String bjcId = "";
    	String elevIds = "";
    	//调用汇总数据方法
    	PageData CountPd = new PageData();
    	PageData eOfferPd = new PageData();
    	try{
    		if(pd.getString("view").equals("edit")){
    			shinyId = pd.getString("SHINY_ID");
    			modelsId = pd.getString("MODELS_ID");
    			bjcId = pd.getString("BJC_ID");
    			elevIds = pd.getString("ELEV_IDS");
    			//调用获取电梯eno方法
    			String elevNo=elevNo(elevIds);
    			
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
	        	
	        	e_offerService.updateShiny(pd, bjcPd, CountPd);
    		}else{
	    		shinyId = this.get32UUID();
	    		pd.put("SHINY_ID", shinyId);
	    		
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

	        	pd.put("isSaveOffer", "1");
	        	e_offerService.saveShiny(pd, bjcPd, CountPd, userId, eOfferPd);
	        	returnMap.put("eOfferPd", eOfferPd);
	        	returnMap.put("eOfferAction", "e_offer/edit.do");
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
        	srPd.put("ele_azf_", pd.getString("ELE_AZF"));
        	srPd.put("azf_", pd.getString("XS_AZJ"));//+
        	srPd.put("ysf_", pd.getString("XS_YSJ"));//+
        	srPd.put("yjze_", pd.getString("XS_YJZE"));//+
        	srPd.put("yjbl_", pd.getString("XS_YJBL"));//+
        	srPd.put("tsf_", pd.getString("OTHP_TSF"));
        	srPd.put("cjf_", pd.getString("OTHP_CJF"));

        	returnMap.put("dtCodId", shinyId);
        	returnMap.put("bjc_id", bjcId);
        	returnMap.put("modelsId", modelsId);
        	returnMap.put("elevIds", elevIds);
        	returnMap.put("CountPd", CountPd);
        	returnMap.put("srPd", srPd);
        	returnMap.put("rowIndex", pd.getString("rowIndex"));
        	returnMap.put("code", 1);
    	}catch(Exception e){
        	returnMap.put("code", 0);
    		logger.error(e.getMessage(), e);
    	}
    	return returnMap;
    }
    
  //保存特种电梯
    @RequestMapping(value="saveTezhong")
    @ResponseBody
    public Map<String, Object> saveTezhong() {
    	PageData pd = new PageData();
		pd = this.getPageData();
    	Map<String, Object> returnMap = new HashMap<String, Object>();
    	String userId = getUser().getUSER_ID();
		String tezhongId = "";
    	String modelsId = "";
    	String bjcId = "";
    	String elevIds = "";
    	//调用汇总数据方法
    	PageData CountPd = new PageData();
    	PageData eOfferPd = new PageData();
    	
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
	    				
	    				argpd.put("XXCS_MASTER_ID", jsonObj.getString("XXCS_MASTER_ID"));
	    				argpd.put("XXCS_DETAIL_ID", jsonObj.getString("XXCS_DETAIL_ID"));
	    				argpd.put("XXCS_TYPE", jsonObj.getString("XXCS_TYPE"));
	    				argpd.put("XXCS_DESCRIBE", jsonObj.getString("XXCS_DESCRIBE"));
	    				argpd.put("XXCS_DJ", jsonObj.getString("XXCS_DJ"));
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

	    				argpd.put("XXCS_MASTER_ID", jsonObj.getString("XXCS_MASTER_ID"));
	    				argpd.put("XXCS_DETAIL_ID", jsonObj.getString("XXCS_DETAIL_ID"));
	    				argpd.put("XXCS_TYPE", jsonObj.getString("XXCS_TYPE"));
	    				argpd.put("XXCS_DESCRIBE", jsonObj.getString("XXCS_DESCRIBE"));
	    				argpd.put("XXCS_DJ", jsonObj.getString("XXCS_DJ"));
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
	        	e_offerService.saveTezhong(pd, bjcPd, xxArgList, CountPd, userId, eOfferPd);
	        	returnMap.put("eOfferPd", eOfferPd);
	        	returnMap.put("eOfferAction", "e_offer/edit.do");
				
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
        	srPd.put("ele_azf_", pd.getString("ELE_AZF"));
	    	srPd.put("azf_", pd.getString("BASE_AZJ"));//+
	    	srPd.put("ysf_", pd.getString("BASE_YSJ"));//+
	    	srPd.put("yjze_", pd.getString("BASE_YJZE"));//+
	    	srPd.put("yjbl_", pd.getString("BASE_YJBL"));//+
        	srPd.put("tsf_", pd.getString("OTHP_TSF"));
        	srPd.put("cjf_", pd.getString("OTHP_CJF"));
	    	
	    	returnMap.put("dtCodId", tezhongId);
        	returnMap.put("bjc_id", bjcId);
        	returnMap.put("modelsId", modelsId);
        	returnMap.put("elevIds", elevIds);
        	returnMap.put("CountPd", CountPd);
        	returnMap.put("srPd", srPd);
        	returnMap.put("rowIndex", pd.getString("rowIndex"));
        	returnMap.put("code", 1);
    	} catch (Exception e) {
        	returnMap.put("code", 0);
			e.printStackTrace();
		}
		
		
		return returnMap;
    }
    
    //根据电梯ID获取电梯eno
    public String elevNo(String elevIds){
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
				e.printStackTrace();
			}
	    	
	    }
		return AllElevNos;
    	
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
	
	/* ===============================用户查询权限================================== */
	public List<String> getRoleSelect() {
		Subject currentUser = SecurityUtils.getSubject(); // shiro管理的session
		Session session = currentUser.getSession();
		return (List<String>) session.getAttribute(Const.SESSION_ROLE_SELECT);
	}

	public String getRoleType() {
		Subject currentUser = SecurityUtils.getSubject();
		Session session = currentUser.getSession();
		return (String) session.getAttribute(Const.SESSION_ROLE_TYPE);
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
