package com.dncrm.service.system.collect;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.util.PageData;


@Service("collectService")
public class CollectService {

	@Resource(name="daoSupport")
	private DaoSupport dao;
	
	
	/**
	 *根据角色分级查询应收款列表
	 */
	public List<PageData> collectListByRole(Page page)throws Exception{
		return (List<PageData>)dao.findForList("CollectMapper.collectListByRole", page);
	}
	
	/**
	 *应收款列表 
	 */
	public List<PageData> collectList(Page page)throws Exception{
		return (List<PageData>)dao.findForList("CollectMapper.collectList", page);
	}
	
	/**
	 *删除 
	 */
	public void delCollectById(String id)throws Exception{
		dao.delete("CollectMapper.delCollectById", id);
	}
	
	
	/**
	 *保存 
	 */
	public void saveCollect(PageData pd)throws Exception{
		dao.save("CollectMapper.saveCollect", pd);
	}
	
	/**
	 *根据id查询 
	 */
	public PageData findCollectById(String id)throws Exception{
		return (PageData)dao.findForObject("CollectMapper.findCollectById", id);
	}
	
	/**
	 *查询tb_collect_money 
	 */
	public PageData findCollectMoneyById(String id)throws Exception{
		return (PageData)dao.findForObject("CollectMapper.findCollectMoneyById", id);
	}
	
	/**
	 *insert tb_collect_set 
	 */
	public void saveCollectSet(PageData pd)throws Exception{
		dao.save("CollectMapper.saveCollectSet", pd);
	}
	
	/**
	 *查询当前收款信息总需收款金额
	 */
	public String findTotalById(String id)throws Exception{
		return (String)dao.findForObject("CollectMapper.findTotalById", id);
	}
	
	/**
	 *根据id查询项目类型 
	 */
	public String findItemTypeById(String id)throws Exception{
		return (String)dao.findForObject("CollectMapper.findItemTypeById", id);
	}
	
	/**
	 *根据付款id查询代理商id 
	 */
	public String findAgentIdById(String id)throws Exception{
		return (String)dao.findForObject("CollectMapper.findAgentIdById", id);
	}
	
	/**
	 *根据代理商id查询代理商额度 
	 */
	public String findAgentQuota(String agent_id)throws Exception{
		return (String)dao.findForObject("CollectMapper.findAgentQuota", agent_id);
	}
	
	/**
	 *根据代理商ID查询已使用额度 
	 */
	public String findUsedTotalByAgentId(String agent_id)throws Exception{
		return (String)dao.findForObject("CollectMapper.findUsedTotalByAgentId", agent_id);
	}
	
	/**
	 *保存代理商额度使用记录 
	 */
	public void saveHisAgent(PageData pd)throws Exception{
		dao.save("CollectMapper.saveHisAgent", pd);
	}
	
	/**
	 *修改额度记录表cm_id 关联到付款记录
	 */
	public void editCmId(PageData pd)throws Exception{
		dao.update("CollectMapper.editCmId", pd);
	}
	
	/**
	 *根据付款id查询所有付款记录 
	 */
	public List<PageData> findCollectMoneyByCid(String c_id)throws Exception{
		return (List<PageData>)dao.findForList("CollectMapper.findCollectMoneyByCid", c_id);
	}
	
	/**
	 *根据付款id查询已付款总额 
	 */
	public String findPayTotal(String c_id)throws Exception{
		return (String)dao.findForObject("CollectMapper.findPayTotal", c_id);
	}
	
	/**
	 * 
	 */
	public List<PageData> findOffset(String c_id)throws Exception{
		return (List<PageData>)dao.findForList("CollectMapper.findOffset", c_id);
	}
	
	
	/**
	 * 修改额度使用记录为已到款
	 */
	public void editHisAgentStatus(String id)throws Exception{
		dao.update("CollectMapper.editHisAgentStatus", id);
	}
	
	/**
	 *根据项目id查询电梯列表 
	 */
	public List<PageData> findElevatorByItemId(String item_id)throws Exception{
		return (List<PageData>)dao.findForList("CollectMapper.findElevatorByItemId", item_id);
	}
	
	/**
	 *保存电梯 
	 */
	public void saveStage(PageData pd)throws Exception{
		dao.save("CollectMapper.saveStage", pd);
	}
	
	/**
	 *根据项目id查阶段款 
	 */
	public PageData findCollectSetByItemId(String item_id)throws Exception{
		return (PageData)dao.findForObject("CollectMapper.findCollectSetByItemId", item_id);
	}
	
	/**
	 *根据项目id和阶段查询登记历史列表 
	 */
	public List<PageData> findCollectInfoByPd(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("CollectMapper.findCollectInfoByPd", pd);
	}
	
	/**
	 *保存登记款 
	 */
	public void saveCollectInfo(PageData pd)throws Exception{
		dao.save("CollectMapper.saveCollectInfo", pd);
	}
	
	/**
	 *根据项目id和阶段查询已录入应收款的电梯 
	 */
	public List<PageData> findCollectEleByPd(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("CollectMapper.findCollectEleByPd", pd);
	}
	
	
	/**
	 *根据id和类型查询工厂/代理商额度 
	 */
	public String findQuotaSetByPd(PageData pd)throws Exception{
		return (String)dao.findForObject("CollectMapper.findQuotaSetByPd", pd);
	}
	
	/**
	 *修改额度 
	 */
	public void editQuotaSet(PageData pd)throws Exception{
		dao.update("ColectMapper.editQuotaSet", pd);
	}
	
	//--------------------------  1.16  -----------------------------------
	/**
	 *查询用来核销额度的分款资金记录 
	 */
	public List<PageData> findCollectInfoForQuot()throws Exception{
		return (List<PageData>)dao.findForList("CollectMapper.findCollectInfoForQuota", "");
	}
	
	/**
	 *更新核销资金认领状态 
	 */
	public void editInfoStatus(String uuid)throws Exception{
		dao.update("CollectMapper.editInfoStatus", uuid);
	}
	
	/**
	 *插入认领资金记录 
	 */
	public void saveCollectClaim(PageData pd)throws Exception{
		dao.save("CollectMapper.saveCollectClaim", pd);
	}
	
	/**
	 *查询认领资金记录 
	 */
	public List<PageData> findCollectClaimList()throws Exception{
		return (List<PageData>)dao.findForList("CollectMapper.findCollectClaimList", "");
	}
	
	/**
	 *根据分款信息查到该代理商所有分款信息中使用额度的记录
	 */
	public List<PageData> findOffsetListByInfo(String info_id)throws Exception{
		return (List<PageData>)dao.findForList("CollectMapper.findOffsetListByInfo", info_id);
	}
	
	/**
	 *保存核销额度信息 
	 */
	public void saveOffsetStage(PageData pd)throws Exception{
		dao.save("CollectMapper.saveOffsetStage", pd);
	}
	
	/**
	 *根据外键和类型查询当前额度 
	 */
	public String findQuotaSet(PageData pd)throws Exception{
		return (String)dao.findForObject("CollectMapper.findQuotaSet", pd);
	}
	
	/**
	 *修改额度 
	 */
	public void updateQuotaSet(PageData pd)throws Exception{
		dao.update("CollectMapper.updateQuotaSet", pd);
	}
	
	/**
	 *根据tb_collect_info主键查到代理商id
	 */
	public String findAgentByInfoId(String info_id)throws Exception{
		return (String)dao.findForObject("CollectMapper.findAgentByInfoId", info_id);
	}
	
	/**
	 *根据tb_collect_info主键查询此次额度记录 
	 */
	public String findMoneyByInfoId(String info_id)throws Exception{
		return (String)dao.findForObject("CollectMapper.findMoneyByInfoId", info_id);
	}
	
	/**
	 *修改此次分款信息为已核销(status=3) 
	 */
	public void updateInfoStatus(String info_id) throws Exception{
		dao.update("CollectMapper.updateInfoStatus", info_id);
	}
	
	/**
	 *根据项目id和阶段查询录入的应收款电梯信息 
	 */
	public List<PageData> findElevatorStage(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("CollectMapper.findElevatorStage", pd);
	}
	
	public List<PageData> findElevatorStageForEdit(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("CollectMapper.findElevatorStageForEdit", pd);
	}
	
	/**
	 *修改应收款 
	 */
	public void editCollectSet(PageData pd)throws Exception{
		dao.update("CollectMapper.editCollectSet", pd);
	}
	
	/**
	 *修改应收款时删除阶段电梯数据 
	 */
	public void deleteCollectStage(PageData pd)throws Exception{
		dao.delete("CollectMapper.deleteCollectStage", pd);
	}
	
	
	/**
	 *查询项目合同类型 
	 */
	public String findItemContractType(String item_id)throws Exception{
		return (String)dao.findForObject("CollectMapper.findItemContractType", item_id);
	}
	
	/**
	 *根据合同类型查询项目列表
	 */
	public List<PageData> findItemListByContractType(String contract_type)throws Exception{
		return (List<PageData>)dao.findForList("CollectMapper.findItemListByContractType", contract_type);
	}
}
