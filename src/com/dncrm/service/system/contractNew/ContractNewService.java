package com.dncrm.service.system.contractNew;

import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.service.system.contractNewAz.ContractNewAzService;
import com.dncrm.service.system.e_offer.E_offerService;
import com.dncrm.util.PageData;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.Map.Entry;

/**
 *类名:contractNewService
 *创建人:stone
 *创建时间:2018年1月18日 
 */
@Service("contractNewService")
public class ContractNewService 
{
    @Resource(name="daoSupport")
    private DaoSupport dao;

	@Resource(name="contractNewAzService")
	private ContractNewAzService contractNewAzService;

	@Resource(name="e_offerService")
	private E_offerService e_offerService;
    
    /**
	 * 查询所有合同信息
	 */
	 @SuppressWarnings("unchecked")
	public List<PageData> SoContractlistPage(Page page) throws Exception {
	        return (List<PageData>) dao.findForList("ContractNewMapper.SoContractlistPage", page);
	    }
	 
	 /**
	 * 查询不存在合同表的报价信息
	 */
	 @SuppressWarnings("unchecked")
	public List<PageData> e_offerlistPage(Page page) throws Exception {
	        return (List<PageData>) dao.findForList("ContractNewMapper.e_offerlistPage", page);
	    }
	 
	 /**
     * 根据合同UUID 获取合同信息
     */
    public PageData findSoConByUUid(PageData pd) throws Exception {
	        return (PageData) dao.findForObject("ContractNewMapper.findSoConByUUid", pd);
	    }
	 
    /**
     * 根据项目编号 获取项目信息
     */
    public PageData findItemById(PageData pd) throws Exception {
	        return (PageData) dao.findForObject("ContractNewMapper.findItemById", pd);
	    }
    
    /**
     * 根据项目编号 获取电梯信息
     */
    @SuppressWarnings("unchecked")
	public List<PageData> findBJCByItemId(PageData pd) throws Exception {
	        return (List<PageData>) dao.findForList("ContractNewMapper.findBJCByItemId", pd);
	    }
		
    
    /**
     * 根据电梯ID 获取电梯信息
     */
    @SuppressWarnings("unchecked")
	public List<PageData> findElevById(PageData pd) throws Exception {
	        return (List<PageData>) dao.findForList("ContractNewMapper.findElevById", pd);
	    }
  
    /**
     * 根据项目id 获取电梯数量
     */
    public PageData findElevByItemId(PageData pd) throws Exception {
	        return (PageData) dao.findForObject("ContractNewMapper.findElevByItemId", pd);
	    }
    

    /**
     * 根据报价id 获取电梯数量
     */
    public PageData findElevByOfferId(PageData pd) throws Exception {
	        return (PageData) dao.findForObject("ContractNewMapper.findElevByOfferId", pd);
	    }
    
    /**
     * 根据项目id 获取报价金额
     */
    public PageData findOfferByItemId(PageData pd) throws Exception {
        return (PageData) dao.findForObject("ContractNewMapper.findOfferByItemId", pd);
    }
  
    /**
     * 根据合同id获取 tb_so_dtinfo信息
     */
    @SuppressWarnings("unchecked")
	public List<PageData> findDtInfoByHtId(PageData pd) throws Exception {
	        return (List<PageData>) dao.findForList("ContractNewMapper.findDtInfoByHtId", pd);
	    }
    
    /**
     * 根据合同id获取 tb_so_fkfs
     */
    @SuppressWarnings("unchecked")
	public List<PageData> findFkfsByHtId(PageData pd) throws Exception {
	        return (List<PageData>) dao.findForList("ContractNewMapper.findFkfsByHtId", pd);
	    }
    
    /**
     * 根据合同ID 删除 tb_so_dtInfo
     */
    public void deleteDtInfo(PageData pd) throws Exception {
        dao.delete("ContractNewMapper.deleteDtInfo", pd);
    }
    
    /**
     * 根据HT_UUID 删除tb_so_fkfs
     */
    public void deleteFkfs(PageData pd) throws Exception {
        dao.delete("ContractNewMapper.deleteFkfs", pd);
    }
    
    /**
     * 根据HT_UUID 删除tb_so_contract 
     */
    public void deleteContract(PageData pd) throws Exception {
        dao.delete("ContractNewMapper.deleteContract", pd);
    }
    
    //保存 新增合同信息
    public void save(PageData pd)throws Exception{
    	dao.save("ContractNewMapper.save", pd);
    }
    
    //保存 电梯信息
    public void saveDt(PageData pd)throws Exception{
    	dao.save("ContractNewMapper.saveDt", pd);
    }
    
    //保存 电梯信息
    public void updateDt(PageData pd)throws Exception{
    	dao.save("ContractNewMapper.updateDt", pd);
    }
    
    //保存 付款方式
    public void saveFkfs(PageData pd)throws Exception{
    	dao.save("ContractNewMapper.saveFkfs", pd);
    }
    
    //编辑合同信息
    public void edit(PageData pd) throws Exception
    {
    	dao.update("ContractNewMapper.edit", pd);
    }

    //更新项目以及报价的项目名称
	public void updateItemNameForContract(PageData pd)throws Exception{
    	dao.update("ContractNewMapper.updateItemNameForContract",pd);
	}
    
    /*
	 *获取梯形
	 */
    @SuppressWarnings("unchecked")
	public List<PageData> getElevatorType(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ContractNewMapper.getElevatorType", pd);
	}
	
	/*
	 *飞尚COD输出
	 */
    @SuppressWarnings("unchecked")
	public List<PageData> printFEISHANG_COD(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ContractNewMapper.printFEISHANG_COD", pd);
	}
    /*
	 *飞尚无机房COD输出
	 */
    @SuppressWarnings("unchecked")
	public List<PageData> printFEISHANG_COD_MRL(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ContractNewMapper.printFEISHANG_COD_MRL", pd);
	}
	/*
	 *飞逸COD输出
	 */
    @SuppressWarnings("unchecked")
	public List<PageData> printSHINY_COD(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ContractNewMapper.printSHINY_COD", pd);
	}
	
	/*
	 *新飞越COD输出
	 */
    @SuppressWarnings("unchecked")
	public List<PageData> printFEIYUE_COD(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ContractNewMapper.printFEIYUE_COD", pd);
	}
    
    /*
	 *新飞越MRLCOD输出
	 */
    @SuppressWarnings("unchecked")
	public List<PageData> printFeiYueMRL_COD(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ContractNewMapper.printFeiYueMRL_COD", pd);
	}
	
	/*
	 *飞扬3000+无机房COD输出
	 */
    @SuppressWarnings("unchecked")
	public List<PageData> printFEIYANG_MRL_COD(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ContractNewMapper.printFEIYANG_MRL_COD", pd);
	}
	
	/*
	 *飞扬3000小机房COD输出
	 */
    @SuppressWarnings("unchecked")
	public List<PageData> printFEIYANG_COD(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ContractNewMapper.printFEIYANG_COD", pd);
	}
	
	/*
	 *飞扬消防梯COD输出
	 */
    @SuppressWarnings("unchecked")
	public List<PageData> printFEIYANGXF_COD(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ContractNewMapper.printFEIYANGXF_COD", pd);
	}
	
	/*
	 *扶梯COD输出
	 */
    @SuppressWarnings("unchecked")
	public List<PageData> printDNP9300_COD(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ContractNewMapper.printDNP9300_COD", pd);
	}
	
	/*
	 *人行道COD输出
	 */
    @SuppressWarnings("unchecked")
	public List<PageData> printDNR_COD(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ContractNewMapper.printDNR_COD", pd);
	}
    
    //查询流程是否存在
    @SuppressWarnings("unchecked")
	public List<PageData> SelAct_Key(PageData pd) throws Exception
    {
    	return (List<PageData>) dao.findForList("ContractNewMapper.SelAct_Key", pd);
    }
    
    //修改流程key
    public void editAct_Key(PageData pd) throws Exception
    {
    	dao.update("ContractNewMapper.editAct_Key", pd);
    }
    
    //修改流程状态
	@Transactional
    public void editAct_Status(PageData pd) throws Exception
    {
    	dao.update("ContractNewMapper.editAct_Status", pd);
    }
    
    //根据报价id查询信息
    public PageData findOfferById(PageData pd) throws Exception {
        return (PageData) dao.findForObject("ContractNewMapper.findOfferById", pd);
    }
    
    /*
	 *价格表输出
	 */
    @SuppressWarnings("unchecked")
	public List<PageData> printPriceList(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ContractNewMapper.printPriceList", pd);
	}
    
    /*
	 *获取COD项目
	 */
    @SuppressWarnings("unchecked")
	public List<PageData> getCODContract(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ContractNewMapper.getCODContract", pd);
	}
    
    /*
	 *获取合同信息
	 */
    @SuppressWarnings("unchecked")
	public List<PageData> printContractDevice(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ContractNewMapper.printContractDevice", pd);
	}
	/**
	 * 获取sequence
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData getSequence(PageData pd) throws Exception {
		return (PageData) dao.findForObject("ContractNewMapper.getSequence", pd);
	}

	/**
	 * 更新项目报备，报价池 客户名称
	 * @param pd
	 * @throws Exception
	 */
	public void updateCustomerName(PageData pd)throws Exception{
		dao.update("ContractNewMapper.updateItemCustomerName",pd);
	}

	public List<PageData> findFkfsByOfferNo(PageData pd)throws Exception {
		return (List<PageData>) dao.findForList("ContractNewMapper.findFkfsByOfferNo", pd);
	}

	@Transactional
	public Map<String,String> getSequenceByDt(String eleType)throws Exception{
	    Map<String,String> reMap=new HashMap<String,String>();
	    Map<String,String> map=new HashMap<>();
	    map.put("ele_type",eleType);
		Map<String,String> dmap=(Map<String,String>)dao.findForObject("ContractNewMapper.getDTtypeValue",map);
		if(dmap!=null&&dmap.get("ele_code")!=null){
			reMap.put("ele_code",dmap.get("ele_code"));
			map.put("ele_type",dmap.get("ele_code"));
		}

        dao.update("ContractNewMapper.updateThenGetELeValue",map);
        if(map!=null&&map.get("current_value")!=null){
        	reMap.put("detail_value",map.get("current_value"));
		}
		map.put("ele_type","DTXX");
		dao.update("ContractNewMapper.updateThenGetELeValue",map);
		if(map!=null&&map.get("current_value")!=null)reMap.put("master_value",map.get("current_value").toString());
		if(reMap.get("detail_value")!=null&&reMap.get("master_value")!=null){
			reMap.put("DT_NO",getPreNo()+reMap.get("master_value")+reMap.get("ele_code")+reMap.get("detail_value"));
		}
	    return reMap;
    }

    public String getPreNo(){
		StringBuffer restr=new StringBuffer();
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy");
		int cvalue=Integer.parseInt(sdf.format(new Date()))-1934;
		if(cvalue>=65&&cvalue<=90){
			char rev=(char)cvalue;
			restr.append(rev);
		}else if(cvalue>90){
			int len=(cvalue-65)/26;
			restr.append((char)(len+64));
			len=(cvalue-65)%26;
			restr.append((char)(len+65));
		}
		return restr.toString();
	}

	/**
	 * 根据付款方式 生成应收款
	 * @param pd
	 */
	public void setYSK(PageData pd)
	{
		try
		{
			PageData YskPd=new PageData();
			//根据id获取合同信息
			pd=this.findSoConByUUid(pd);
			//根据合同ID获取付款方式信息
			List<PageData> dfkfslist=this.findFkfsByHtId(pd);
			for(PageData fkfs : dfkfslist)
			{
				YskPd.put("YSK_UUID", UUID.randomUUID().toString());
				YskPd.put("YSK_HT_ID", fkfs.get("FKFS_HT_UUID").toString());
				YskPd.put("YSK_ITEM_ID", pd.get("HT_ITEM_ID").toString());
				YskPd.put("YSK_FKFS_ID", fkfs.get("FKFS_UUID").toString());
				YskPd.put("YSK_QS", fkfs.get("FKFS_QS").toString());
				YskPd.put("YSK_KX", fkfs.get("FKFS_KX").toString());
				YskPd.put("YSK_YSJE", fkfs.get("FKFS_JE").toString());
				YskPd.put("YSK_YSRQ", fkfs.get("FKFS_PDRQ").toString());
				YskPd.put("YSK_PCTS", fkfs.get("FKFS_PCRQ").toString());
				YskPd.put("YSK_KP_ID", "");
				YskPd.put("YSK_LK_ID", "");
				YskPd.put("YSK_BZ", fkfs.get("FKFS_BZ").toString());
				YskPd.put("YSK_AZ_NO", pd.get("HT_NO").toString());
				YskPd.put("item_name", pd.get("item_name").toString());
				contractNewAzService.saveYsk(YskPd);

			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 查询所有合同信息
	 */
	 @SuppressWarnings("unchecked")
	public List<PageData> findContractNewExcel(PageData pd) throws Exception {
	        return (List<PageData>) dao.findForList("ContractNewMapper.findContractNewExcel", pd);
	  }
	
	public void updateMLR(PageData pd1) throws Exception {
		
		dao.update("ContractNewMapper.updateContractMLR",pd1);
	}

	@SuppressWarnings("unchecked")
	public List<PageData> findEofferContract(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>) dao.findForList("ContractNewMapper.findEofferContract", page);
	}

	@SuppressWarnings("unchecked")
	public List<PageData> findBJCBYItemidoff(PageData pd) throws Exception {
		
		// TODO Auto-generated method stub
		return (List<PageData>) dao.findForList("ContractNewMapper.findBJCBYItemidoff", pd);
	}

	public PageData findElevCount(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (PageData) dao.findForObject("ContractNewMapper.findElevCount", pd);
	}

	public PageData findItemDetailForContract(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		 return (PageData) dao.findForObject("ContractNewMapper.findItemDetailForContract", pd);
	}
	public PageData findItemDetailForOfferId(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		 return (PageData) dao.findForObject("ContractNewMapper.findItemDetailForOfferId", pd);
	}
    //new更新项目以及报价的项目名称
	public void updateTempItemNameForContract(PageData pd)throws Exception{
    	dao.update("ContractNewMapper.updateTempItemNameForContract",pd);
	}
	
	/**
	 * 更新项目报备，报价池 客户名称
	 * @param pd
	 * @throws Exception
	 */
	public void updateTempCustomerName(PageData pd)throws Exception{
		dao.update("ContractNewMapper.updateTempItemCustomerName",pd);
	}
	
	/**
	 * 更新项目报备，报价池 客户名称
	 * @param pd
	 * @throws Exception
	 */
	public void updateTempCustomerNameOfOfferId(PageData pd)throws Exception{
		dao.update("ContractNewMapper.updateTempItemCustomerNameOfOfferId",pd);
	}
	
	public PageData findIteminOfferById(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (PageData) dao.findForObject("ContractNewMapper.findIteminOfferById", pd);
	}

	public PageData findTempElevByItemId(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (PageData) dao.findForObject("ContractNewMapper.findTempElevByItemId", pd);
	}

	public PageData findTempItemdetail(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (PageData) dao.findForObject("ContractNewMapper.findTempItemdetail", pd);
	}
	
	/**
     * 分页显示显示待我处理的合同
     * @param pd
     * @return
     * @throws Exception
     */
    public List<PageData> findAuditContractNewPage(PageData pd) throws  Exception{

        return (List<PageData>) dao.findForList("ContractNewMapper.findAuditContractNewPage", pd);
    }
	
    //更新 电梯 梯号 信息
    @Transactional
    public void updateDTXX(JSONArray jsonArray, String HT_UUID)throws Exception{
		PageData DtPd = new PageData();
    	Map<String,String> bjcmap = new HashMap<String, String>();
		String[] elev_id = new String[jsonArray.size()];
		String[] elev_eno = new String[jsonArray.size()];
		for(int i =0;i<jsonArray.size();i++){
			JSONObject jsonObj = jsonArray.getJSONObject(i);
			DtPd.put("DT_UUID", jsonObj.get("DT_UUID").toString());
			DtPd.put("DT_NO", jsonObj.get("DT_NO").toString());
			DtPd.put("DT_TH", jsonObj.get("DT_TH").toString());
			DtPd.put("DT_HT_ID", HT_UUID);
			DtPd.put("DT_BJC_ID", jsonObj.get("DT_BJC_ID").toString());
			DtPd.put("DT_ELEV_ID", jsonObj.get("DT_ELEV_ID").toString());
			//更新电梯信息
			updateDt(DtPd);
			
			String bjceno = bjcmap.get(DtPd.getString("DT_BJC_ID"));
			if(bjceno != null) {
				bjceno += DtPd.getString("DT_TH") + ",";
			} else {
				bjceno = DtPd.getString("DT_TH") + ",";
			}
			bjcmap.put(DtPd.getString("DT_BJC_ID"), bjceno);
			
			elev_id[i] = DtPd.getString("DT_ELEV_ID");
			elev_eno[i] = DtPd.getString("DT_TH");
		}
		e_offerService.updateEleDetailsENoById(elev_id, elev_eno);
		PageData bjcenoPd = new PageData();
		for (Entry<String, String> enos : bjcmap.entrySet()) {
			bjcenoPd.put("BJC_ENO", enos.getValue());
			bjcenoPd.put("BJC_ID", enos.getKey());
			e_offerService.updateBJCEleENoByBJCId(bjcenoPd);
		}
    	
    }

    /**
     * 根据合同id更新附件信息
     * @param pd
     * @throws Exception 
     */
	public void updateUploadForID(PageData pd) throws Exception {
		dao.update("ContractNewMapper.updateUploadForID",pd);
	}
	

    /**
     * 根据合同id更新附件信息
     * @param pd
     * @throws Exception 
     */
	public boolean isExistDTHTH(String DT_NO) throws Exception {
		Integer count = (Integer) dao.findForObject("ContractNewMapper.isExistDTHTH",DT_NO);
		if(count > 0) {
			return true;
		}
		return false;
	}
	
	public void updateHThtfj(PageData pd) throws Exception {
		dao.update("ContractNewMapper.updateHThtfj",pd);
		
		//更新项目状态
		PageData sbhtpd = (PageData) dao.findForObject("ContractNewMapper.findHtDJLK", pd);
		if(sbhtpd != null && StringUtils.isNoneBlank(sbhtpd.getString("HT_UUID"))) {
			String json = sbhtpd.getNoneNULLString("CONTRACT_ATTA_JSON");
			String je = sbhtpd.getNoneNULLString("LK_LKJE");
			if(StringUtils.isNoneBlank(je) && StringUtils.isNoneBlank(json)
					&& !"[]".equals(json)) {
				
				PageData hpd = new PageData();
				hpd.put("CONTRACT_STATUS", "1");
				hpd.put("HT_UUID", pd.get("HT_UUID"));
				dao.update("ContractNewMapper.updateContractStatus", hpd);
				
			} else {
				PageData hpd = new PageData();
				hpd.put("CONTRACT_STATUS", "0");
				hpd.put("HT_UUID", pd.get("HT_UUID"));
				dao.update("ContractNewMapper.updateContractStatus", hpd);
			}
			
		} else {//没有定金项
			PageData htpd = findSoConByUUid(pd);
			if(htpd != null) {
				String json = htpd.getNoneNULLString("CONTRACT_ATTA_JSON");
				if(StringUtils.isNoneBlank(json)&& !"[]".equals(json)) {
					
					PageData hpd = new PageData();
					hpd.put("CONTRACT_STATUS", "1");
					hpd.put("HT_UUID", pd.get("HT_UUID"));
					dao.update("ContractNewMapper.updateContractStatus", hpd);
				} else {
					PageData hpd = new PageData();
					hpd.put("CONTRACT_STATUS", "0");
					hpd.put("HT_UUID", pd.get("HT_UUID"));
					dao.update("ContractNewMapper.updateContractStatus", hpd);
				}
			}
			
			
		}
		
		
	}
	
	/**
     * 根据合同id更新附件信息
     * @param pd
     * @throws Exception 
     */
	public boolean isOfferMDOfItemIdAndVersion(PageData pd) throws Exception {
		Integer count = (Integer) dao.findForObject("ContractNewMapper.isOfferMDOfItemIdAndVersion", pd);
		if(count > 0) {
			return true;
		}
		return false;
	}
	
	public List<PageData> findRoleOfwherePd(PageData pd) throws Exception{
		return (List<PageData>) dao.findForList("ContractNewMapper.findRoleOfwherePd", pd);
	}
	
    
}
    

