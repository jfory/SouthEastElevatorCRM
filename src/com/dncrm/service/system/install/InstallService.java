package com.dncrm.service.system.install;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.util.PageData;


/**
 *创建人:arisu 
 *创建时间:2016/11/30
 *类名:InstallService
 *描述:安装管理service 
 */
@Service("installService")
public class InstallService {
	
	@Resource(name="daoSupport")
	private DaoSupport dao;
	
	
	public List<PageData> findInstallList(Page page)throws Exception{
		return (List<PageData>)dao.findForList("InstallMapper.findInstallList", page);
	}
	
	public void saveInstall(PageData pd)throws Exception{
		dao.save("InstallMapper.saveInstall", pd);
	}
	
	public PageData findInstallById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("InstallMapper.findInstallById", pd);
	}
	
	public void deleteInstall(PageData pd)throws Exception{
		dao.delete("InstallMapper.deleteInstall", pd);
	}
	
	
	public List<PageData> findConsigneeList(String item_id)throws Exception{
		return (List<PageData>)dao.findForList("InstallMapper.findConsigneeList", item_id);
	}
	
	public List<PageData> findShipmentsList(String item_id)throws Exception{
		return (List<PageData>)dao.findForList("InstallMapper.findShipmentsList", item_id);
	}
	
	public void updateShipmentsState(PageData pd)throws Exception{
		dao.update("InstallMapper.updateShipmentsState", pd);
	}
	
	public List<PageData> findEncasementListByShipments(String consignee_id)throws Exception{
		return (List<PageData>)dao.findForList("InstallMapper.findEncasementListByShipments", consignee_id);
	}
	
	public List<PageData> findEncasementListByReceive(String consignee_id)throws Exception{
		return (List<PageData>)dao.findForList("InstallMapper.findEncasementListByReceive", consignee_id);
	}
	
	public PageData findEncasement(String encasement_id)throws Exception{
		return(PageData)dao.findForObject("InstallMapper.findEncasement", encasement_id);
	}
	
	public void saveReceive(PageData pd)throws Exception{
		dao.save("InstallMapper.saveReceive", pd);
	}
	
	public List<PageData> findReceiveList(String item_id)throws Exception{
		return (List<PageData>)dao.findForList("InstallMapper.findReceiveList", item_id);
	}
	
	public void saveUnbox(PageData pd)throws Exception{
		dao.save("InstallMapper.saveUnbox", pd);
	}
	
	public List<PageData> findUnboxListByUser(String USER_ID)throws Exception{
		return (List<PageData>)dao.findForList("InstallMapper.findUnboxListByUser", USER_ID);
	}
	
	public List<PageData> findSupplementList(String USER_ID)throws Exception{
		return (List<PageData>)dao.findForList("InstallMapper.findSupplementList", USER_ID);
	}
	
	public List<PageData> findUnboxSupplement(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("InstallMapper.findUnboxSupplement", pd);
	}
	
	public void saveSupplement(PageData pd)throws Exception{
		dao.save("InstallMapper.saveSupplement", pd);
	}
	
	public void updateUnboxStatus(PageData pd)throws Exception{
		dao.update("InstallMapper.updateUnboxStatus", pd);
	}
	
	public void updateUnboxStatusBySupplement(PageData pd)throws Exception{
		dao.update("InstallMapper.updateUnboxStatusBySupplement", pd);
	}
	
	public void updateUnboxStatusByDetails(PageData pd)throws Exception{
		dao.update("InstallMapper.updateUnboxStatusByDetails", pd);
	}
	
	public void updateUnboxStatusByWork(PageData pd)throws Exception{
		dao.update("InstallMapper.updateUnboxStatusByWork", pd);
	}
	
	public String findFactoryTypeByBoxId(String id)throws Exception{
		return (String)dao.findForObject("InstallMapper.findFactoryTypeByBoxId", id);
	}
	
	public void updateSupplementInstance(PageData pd)throws Exception{
		dao.update("InstallMapper.updateSupplementInstance", pd);
	}
	
	public PageData findSupplementById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("InstallMapper.findSupplementById", pd);
	}
	
	public List<PageData> findInstallElevator(String item_id)throws Exception{
		return (List<PageData>)dao.findForList("InstallMapper.findInstallElevator", item_id);
	}
	
	public String findCheckJsonByModelsId(String models_id)throws Exception{
		return (String)dao.findForObject("InstallMapper.findCheckJsonByModelsId", models_id);
	}
	
	public void saveStandardQC(PageData pd)throws Exception{
		dao.save("InstallMapper.saveStandardQC", pd);
	}
	
	public List<PageData> findInstallDetailsByItemId(String item_id)throws Exception{
		return (List<PageData>)dao.findForList("InstallMapper.findInstallDetailsByItemId", item_id);
	}
	
	public void saveAdjustApply(PageData pd)throws Exception{
		dao.save("InstallMapper.saveAdjustApply", pd);
	}
	
	public void updateEncasementReceive(PageData pd)throws Exception{
		dao.update("InstallMapper.updateEncasementReceive", pd);
	}
	
	public List<PageData> findStandard(Page page)throws Exception{
		return (List<PageData>)dao.findForList("InstallMapper.findStandard", page);
	}
	
	public List<PageData> findModelsListByElevatorType(String elevator_id)throws Exception{
		return (List<PageData>)dao.findForList("InstallMapper.findModelsListByElevatorType", elevator_id);
	}
	
	public void saveStandard(PageData pd)throws Exception{
		dao.save("InstallMapper.saveStandard", pd);
	}
	
	public List<PageData> findAdjustApplyList()throws Exception{
		return (List<PageData>)dao.findForList("InstallMapper.findAdjustApplyList", "");
	}
	
	public void claimAdjustApply(PageData pd)throws Exception{
		dao.update("InstallMapper.claimAdjustApply", pd);
	}
	
	public void updateAjustApplyStatus(PageData pd)throws Exception{
		dao.update("InstallMapper.updateAdjustApplyStatus", pd);
	}
	
	public List<PageData> findAdjustApplyListDone()throws Exception{
		return (List<PageData>)dao.findForList("InstallMapper.findAdjustApplyListDone", "");
	}
	
	public void saveWorkAdjust(PageData pd)throws Exception{
		dao.save("InstallMapper.saveWorkAdjust", pd);
	}
	
	public List<PageData> findUserList()throws Exception{
		return (List<PageData>)dao.findForList("InstallMapper.findUserList", "");
	}
	
	public String findWorkIdByApplyAndDetails(PageData pd)throws Exception{
		return (String)dao.findForObject("InstallMapper.findWorkIdByApplyAndDetails", pd);
	}
	
	public String findModelsIdByDetails(String id)throws Exception{
		return (String)dao.findForObject("InstallMapper.findModelsIdByDetails", id);
	}
	
	public void saveAdjustReport(PageData pd)throws Exception{
		dao.save("InstallMapper.saveAdjustReport", pd);
	}
	
	public void saveCorrectDefault(PageData pd)throws Exception{
		dao.save("InstallMapper.saveCorrectDefault", pd);
	}
	
	public List<PageData> findCorrectList(Page page)throws Exception{
		return (List<PageData>)dao.findForList("InstallMapper.findCorrectList", page);
	}
	
	public List<PageData> findCorrectDoneList(Page page)throws Exception{
		return (List<PageData>)dao.findForList("InstallMapper.findCorrectDoneList", page);
	}
	
	public void saveCorrectReport(PageData pd)throws Exception{
		dao.save("InstallMapper.saveCorrectReport", pd);
	}
	
	public void updateCorrectInit(PageData pd)throws Exception{
		dao.update("InstallMapper.updateCorrectInit", pd);
	}
	
	public void saveGovAccept(PageData pd)throws Exception{
		dao.save("InstallMapper.saveGovAccept", pd);
	}
	public void updateCorrectStatus(PageData pd)throws Exception{
		dao.update("InstallMapper.updateCorrectStatus", pd);
	}
}
