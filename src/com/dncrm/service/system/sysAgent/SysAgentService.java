package com.dncrm.service.system.sysAgent;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.util.PageData;

@Service("sysAgentService")
public class SysAgentService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	public List<PageData> listPdPageAgentByRole(Page page)throws Exception{
		return (List<PageData>) dao.findForList("AgentMapper.agentlistPageByRole", page);
	}
	
	public List<PageData> listPdPageAgent(Page page) throws Exception{
		return (List<PageData>) dao.findForList("AgentMapper.agentlistPage", page);
	}
	
	public List<PageData> findAgentList(PageData pd) throws Exception{
		return (List<PageData>) dao.findForList("AgentMapper.findAgentList", pd);
	}
	
	public List<PageData> listPdPageContractorByRole(Page page)throws Exception{
		return (List<PageData>) dao.findForList("AgentMapper.contractorlistPageByRole", page);
	}
	
	public List<PageData> listPdPageContractor(Page page) throws Exception{
		return (List<PageData>) dao.findForList("AgentMapper.contractorlistPage", page);
	}
	
	public void agentAdd(PageData pd) throws Exception{
		dao.save("AgentMapper.agentAdd", pd);
	}
	
	public List<PageData> existsLicenseNo(PageData pd) throws Exception{
		return (List<PageData>) dao.findForList("AgentMapper.existsLicenseNo", pd);
	}
	
	 /**
     * 判断代理商名称是否唯一
     */
    public PageData findAgentByName(PageData pd) throws Exception {
        return (PageData) dao.findForObject("AgentMapper.findAgentByName", pd);
    }
	
	public void agentUpdate(PageData pd) throws Exception{
		dao.update("AgentMapper.agentUpdate", pd);
	}
	
	public void updateAgentApproval(PageData pd) throws Exception {
        dao.update("AgentMapper.updateAgentApproval", pd);
    }
	
	public void agentDeleteById(String agent_no) throws Exception{
		dao.delete("AgentMapper.agentDeleteById", agent_no);
	}
	public List<PageData> findAgentById(String agent_no) throws Exception{
		return (List<PageData>) dao.findForList("AgentMapper.findAgentById", agent_no);
	}
	
	public PageData findAById(PageData pd) throws Exception {
        return (PageData) dao.findForObject("AgentMapper.findAById", pd);
    }
	
	public PageData findById(PageData pd) throws Exception {
        return (PageData) dao.findForObject("AgentMapper.findById", pd);
    }
	
	public PageData findByName(PageData pd) throws Exception{
		return (PageData) dao.findForObject("AgentMapper.findByName", pd);
	}
	
	/*
	 * 获取用户职位和机构 
	 */
	public PageData findUserPositionAndDepartment(PageData pd) throws Exception{
		return (PageData) dao.findForObject("AgentMapper.findUserPositionAndDepartment", pd);
	}
	
	/*
	* 批量删除
	*/
	public void agentDeleteAll(String[] ArrayDATA_IDS) throws Exception{
		dao.delete("AgentMapper.agentDeleteAll", ArrayDATA_IDS);
	}
	
	public Integer findMinYearItem()throws Exception{
		String minYear = (String)dao.findForObject("AgentMapper.findMinYearItem", "");
		return Integer.parseInt(minYear);
	}
	
	public List<PageData> agentYearNum(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("AgentMapper.agentYearNum", pd);
	}
	
	public List<PageData> agentMonthNum(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("AgentMapper.agentMonthNum", pd);
	}
	
	public List<PageData> agentQuarterNum(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("AgentMapper.agentQuarterNum", pd);
	}
	
	
	 
	/*
	 *查询代理商id和name列表 -arisu 
	 */
	public List<PageData> findAgentIdAndNameList()throws Exception{
		return (List<PageData>)dao.findForList("AgentMapper.findAgentIdAndNameList", "");
	}
	
	/*
	 *查询有安装资质的分包商id和name列表 -arisu 
	 */
	public List<PageData> findAgentListWithInstall()throws Exception{
		return (List<PageData>)dao.findForList("AgentMapper.findAgentListWithInstall", "");
	}
	//根据公司name获取id （导入）
	 public PageData findDepartmentByName(PageData pd) throws Exception {
	        return (PageData) dao.findForObject("AgentMapper.findDepartmentByName", pd);
	    }
	 /**
	     * 分页显示显示待我处理的合同
	     * @param pd
	     * @return
	     * @throws Exception
	     */
	    public List<PageData> findAuditAgentPage(PageData pd) throws  Exception{

	        return (List<PageData>) dao.findForList("AgentMapper.findAuditAgentPage", pd);
	    }
}
