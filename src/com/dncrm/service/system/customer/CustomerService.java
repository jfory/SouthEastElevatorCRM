package com.dncrm.service.system.customer;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.util.PageData;

/**
 *类名:CustomerService
 *创建人:arisu
 *创建时间:2016年8月18日 
 */
@Service("customerService")
public class CustomerService {

	@Resource(name="daoSupport")
	private DaoSupport dao;
	
	//根据角色分级列表所有用户
	public List<PageData> listCustomerByRole(Page page)throws Exception{
		return (List<PageData>)dao.findForList("CustomerMapper.listPageAllCustomerByRole", page);
	}
	
	//列表所有类别用户
	public List<PageData> listCustomer(Page page) throws Exception{
		return (List<PageData>) dao.findForList("CustomerMapper.listPageAllCustomer", page);
	}
	//列表客户拜访记录
	public List<PageData> listCustomerVisit(Page page) throws Exception{
		return (List<PageData>) dao.findForList("listPageAllCustomerVisit", page);
	}
	
	public PageData findByPd(PageData pd)throws Exception{
		String mapperName = "findCustomer"+pd.getString("customer_type");
		return (PageData)dao.findForObject(mapperName, pd);
	}
	public PageData findById(PageData pd)throws Exception{
		String mapperName = "findCustomer"+pd.getString("customer_type")+"ById";
		return (PageData)dao.findForObject(mapperName, pd);
	}
	//保存
	public void saveCustomer(PageData pd,String addType) throws Exception{
		String mapperName = "saveCustomer"+addType;
		dao.save(mapperName, pd);
	}
	//删除
	public void deleteCustomer(PageData pd,String deleteType) throws Exception{
		String mapperName = "deleteCustomer"+deleteType;
		dao.delete(mapperName, pd);
	}
	//修改
	public void editCustomer(PageData pd,String updateType)throws Exception{
		String mapperName = "editCustomer"+updateType;
		dao.update(mapperName, pd);
	}
	//列表战略客户/客户集团信息
	public List<PageData> listCoreCustomer() throws Exception{
		return (List<PageData>)dao.findForList("findCoreCustomerId", "");
	}
	//列表普通客户
	public List<PageData> listOrdinaryCustomer() throws Exception{
		return (List<PageData>)dao.findForList("findOrdinaryCustomerId", "");
	}
	//列表小业主客户
	public List<PageData> listMerchantCustomer() throws Exception{
		return (List<PageData>)dao.findForList("findMerchantCustomerId", "");
	}
	//保存客户拜访记录
	public void saveCustomerVisit(PageData pd) throws Exception{
		dao.save("saveCustomerVisit", pd);
	}
	//查询拜访
	public PageData findCustomerVisitById(PageData pd) throws Exception{
		return (PageData)dao.findForObject("customerVisitMapper.findCustomerVisitById", pd);
	}
	
	//修改拜访
	public void updateCustomerVisitById(PageData pd)throws Exception{
		dao.update("customerVisitMapper.editCustomerVisitById", pd);
	}
	//删除拜访
	public void deleteCustomerVisitById(PageData pd)throws Exception{
		dao.delete("customerVisitMapper.delCustomerVisitById", pd);
	}
	//判断决策层是否为空
	public String isDecisionNull(PageData pd,String decisionNum) throws Exception{
		String mapperName = "isDecision"+decisionNum+"Null";
		return (String)dao.findForObject(mapperName, pd);
	}
	
	//检测客户名称--针对新增,不检测当前输入框客户名称
	public boolean checkCustomerName(PageData pd)throws Exception{
		String mapperName = "findCustomerByName"+pd.getString("customer_type");
		List<PageData> pdList = (List<PageData>)dao.findForList(mapperName, pd);
		return pdList.isEmpty();
	}
	
	//检测客户名称--针对修改,检测当前输入框名称是否修改
	public boolean checkCustomerOldName(PageData pd)throws Exception{
		String mapperName = "findCustomerByOldName"+pd.getString("customer_type");
		List<PageData> pdList = (List<PageData>) dao.findForList(mapperName, pd);
		return pdList.isEmpty();
	}
	
	//查询跟进业务员列表,用于开发商页面显示
	public List<PageData> findCustomerRespondDeveloper()throws Exception{
		return (List<PageData>)dao.findForList("findCustomerRespondDeveloper", "");
	}
	
	//查询集采负责人列表,用于战略客户页面列表
	public List<PageData> findCustomerContactCore()throws Exception{
		return (List<PageData>)dao.findForList("findCustomerContactCore", "");
	}
	
	//查询客户所属公司结构
	public List<PageData> findAllCustomerCompany()throws Exception{
		return (List<PageData>)dao.findForList("findAllCustomerCompany", "");
	}
	
	//查询除开此节点的其他所有节点
	public List<PageData> findCustomerCompanys(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("findCustomerCompanys", pd);
	}
	
	//修改客户公司节点
	public void updateCustomerCompany(PageData pd)throws Exception{
		dao.update("updateCustomerCompany", pd);
	}
	
	//增加客户公司节点
	public void insertCustomerCompany(PageData pd)throws Exception{
		dao.save("insertCustomerCompany", pd);
	}
	//删除客户公司节点
	public void deleteCustomerCompany(PageData pd)throws Exception{
		dao.delete("deleteCustomerCompany", pd);
	}
	
	//根据id查询客户节点
	public PageData findCustomerCompanyById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("findCustomerCompanyById", pd);
	}
	//根据id查询父节点
	public PageData findCompanyParent(PageData pd)throws Exception{
		return (PageData)dao.findForObject("findCompanyParent", pd);
	}
	
	//查询普通客户类型
	public List<PageData> findOrdinaryTypeList()throws Exception{
		return (List<PageData>)dao.findForList("findOrdinaryTypeList", "");
	}
	
	//查询检测客户类型名称
	public List<PageData> findOrdinaryTypeByName(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("findOrdinaryTypeByName", pd);
	}
	//查询检测客户类型名称
	public List<PageData> findOrdinaryTypeByOldName(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("findOrdinaryTypeByOldName", pd);
	}
	//查询客户行业
	public List<PageData> findTradeTypeList()throws Exception{
		return (List<PageData>)dao.findForList("findTradeTypeList", "");
	}
	
	//查询检测客户行业名称
	public List<PageData> findTradeTypeByName(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("findTradeTypeByName", pd);
	}
	//查询检测客户行业名称
	public List<PageData> findTradeTypeByOldName(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("findTradeTypeByOldName", pd);
	}
	
	//新增客户类型
	public void saveOrdinaryType(PageData pd)throws Exception{
		dao.save("ordinaryTypeMapper.saveOrdinaryType", pd);
	}
	
	//新增客户行业
	public void saveTradeType(PageData pd)throws Exception{
		dao.save("tradeTypeMapper.saveTradeType", pd);
	}
	
	//编辑客户类型
	public void editOrdinaryType(PageData pd)throws Exception{
		dao.update("ordinaryTypeMapper.editOrdinaryType", pd);
	}
	
	//编辑客户行业
	public void editTradeType(PageData pd)throws Exception{
		dao.update("tradeTypeMapper.editTradeType", pd);
	}
	
	//删除客户类型
	public void delOrdinaryType(PageData pd)throws Exception{
		dao.delete("ordinaryTypeMapper.delOrdinaryType", pd);
	}
	//删除客户行业
	public void delTradeType(PageData pd)throws Exception{
		dao.delete("tradeTypeMapper.delTradeType", pd);
	}
	
	//根据id查询客户类型
	public PageData findOrdinaryById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("ordinaryTypeMapper.findOrdinaryById", pd);
	}
	//根据id查询客户行业
	public PageData findTradeById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("tradeTypeMapper.findTradeById", pd);
	}
	
	//查询战略客户信息列表
	public List<PageData> listPageCustomerCore(Page page)throws Exception{
		return (List<PageData>)dao.findForList("customerCoreMapper.listPageCustomerCore", page);
	}
	
	/**
	 *根据角色分级查询战略客户信息列表 
	 */
	public List<PageData> listPageCustomerCoreByRole(Page page)throws Exception{
		return (List<PageData>)dao.findForList("customerCoreMapper.listPageCustomerCoreByRole", page);
	}
	
	//查询是否可以删除客户类型
	public boolean ifDelTradeType(PageData pd)throws Exception{
		return ((List<PageData>)dao.findForList("customerOrdinaryMapper.ifDelTradeType", pd)).size()>0;
	}
	
	//查询是否可以删除客户行业
	public boolean ifDelOrdinaryType(PageData pd)throws Exception{
		return ((List<PageData>)dao.findForList("customerOrdinaryMapper.ifDelOrdinaryType", pd)).size()>0;
	}
	
	//union查询所有客户的基本信息
	public List<PageData> findCustomerInfo()throws Exception{
		return (List<PageData>)dao.findForList("CustomerMapper.findCustomerInfo", "");
	}
	//查询所有客户id和name列表
	public List<PageData> findCustomerIdAndNameList()throws Exception{
		return (List<PageData>)dao.findForList("CustomerMapper.findCustomerIdAndNameList", "");
	}
	
	public Integer findMinYearCustomer()throws Exception{
		String minYear =  (String)dao.findForObject("CustomerMapper.findMinYearCustomer", "");
		return Integer.parseInt(minYear);
	}
	
	public List<PageData> customerYearNum(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("CustomerMapper.customerYearNum", pd);
	}
	
	public List<PageData> customerMonthNum(String year)throws Exception{
		return (List<PageData>)dao.findForList("CustomerMapper.customerMonthNum", year);
	}
	
	public List<PageData> customerQuarterNum(String year)throws Exception{
		return (List<PageData>)dao.findForList("CustomerMapper.customerQuarterNum", year);
	}
	
	
	//导出用sql
	public List<PageData> findCustomerOrdinaryList()throws Exception{
		return (List<PageData>)dao.findForList("CustomerMapper.findCustomerOrdinaryList", "");
	}
	public List<PageData> findCustomerMerchantList()throws Exception{
		return (List<PageData>)dao.findForList("CustomerMapper.findCustomerMerchantList", "");
	}
	public List<PageData> findCustomerCoreList()throws Exception{
		return (List<PageData>)dao.findForList("CustomerMapper.findCustomerCoreList", "");
	}
	
	//导入用sql
	public void saveOrdinaryImportExcel(PageData pd)throws Exception{
		dao.save("CustomerMapper.saveOrdinaryImportExcel", pd);
	}
	public void saveMerchantImportExcel(PageData pd)throws Exception{
		dao.save("CustomerMapper.saveMerchantImportExcel", pd);
	}
	public void saveCoreImportExcel(PageData pd)throws Exception{
		dao.save("CustomerMapper.saveCoreImportExcel", pd);
	}
	
	//-------个人用户
	//添加
	public void saveCustomerPerson(PageData pd)throws Exception{
		dao.save("customerPersonMapper.saveCustomerPerson", pd);
	}
	
	/**
	 *导出客户类型信息 
	 */
	public List<PageData> findOrdinaryTypeForExcel()throws Exception{
		return (List<PageData>) dao.findForList("ordinaryTypeMapper.findOrdinaryTypeForExcel", "");
	}
	
	/**
	 *导入客户类型信息 
	 */
	public void saveOrdinaryTypeForExcel(PageData pd)throws Exception{
		dao.save("ordinaryTypeMapper.saveOrdinaryTypeForExcel", pd);
	}
	
	
	/**
	 *导出客户行业 
	 */
	public List<PageData> findTradeTypeForExcel()throws Exception{
		return (List<PageData>) dao.findForList("tradeTypeMapper.findTradeTypeForExcel", "");
	}
	
	/**
	 *导入客户行业 
	 */
	public void saveTradeTypeForExcel(PageData pd)throws Exception{
		dao.save("tradeTypeMapper.saveTradeTypeForExcel", pd);
	}
	
	/**
	 *导出客户拜访记录 
	 */
	public List<PageData> findCustomerVisitForExcel(String customer_id)throws Exception{
		return (List<PageData>) dao.findForList("customerCoreMapper.findCustomerVisitForExcel", customer_id);
	} 
	
	/**
	 *导入客户拜访记录 
	 */
	public void saveCustomerVisitImportExcel(PageData pd)throws Exception{
		dao.save("customerCoreMapper.saveCustomerVisitImportExcel", pd);
	}
	
	
	/**
	 *导出普通客户 
	 */
	public List<PageData> findCustomerOrdinaryToExcel()throws Exception{
		return (List<PageData>) dao.findForList("CustomerMapper.findCustomerOrdinaryToExcel", "");
	}
	
	/**
	 *导出小业主 
	 */
	public List<PageData> findCustomerMerchantToExcel()throws Exception{
		return (List<PageData>) dao.findForList("CustomerMapper.findCustomerMerchantToExcel", "");
	}
	
	/**
	 *导出战略客户 
	 **/
	public List<PageData> findCustomerCoreToExcel()throws Exception{
		return (List<PageData>) dao.findForList("CustomerMapper.findCustomerCoreToExcel", "");
	}

	/**
	 * 
	 */
	public String findTradeId(String name)throws Exception{
		return (String)dao.findForObject("CustomerMapper.findTradeId", name);
	}
	
	
	/**
	 * 
	 */
	public String findOrdinaryId(String type)throws Exception{
		return (String)dao.findForObject("CustomerMapper.findOrdinaryId", type);
	}
	
	/**
	 * 
	 */
	public String findDepartmentId(String name)throws Exception{
		return (String) dao.findForObject("CustomerMapper.findDepartmentId", name);
	}
	
	/**
	 *判断普通客户名称是否重复 
	 *重复返回true
	 */
	public Boolean checkExistOname(String customer_name)throws Exception{
		String num = (String)dao.findForObject("CustomerMapper.checkExistOname", customer_name);
		if(num.equals("0")){
			return false;
		}else{
			return true;
		}
	}
	
	public Boolean checkExistMname(String customer_name)throws Exception{
		String num = (String)dao.findForObject("CustomerMapper.checkExistMname", customer_name);
		if(num.equals("0")){
			return false;
		}else{
			return true;
		}
	}
	
	public Boolean checkExistCname(String customer_name)throws Exception{
		String num = (String)dao.findForObject("CustomerMapper.checkExistCname", customer_name);
		if(num.equals("0")){
			return false;
		}else{
			return true;
		}
	}
	
	/**
	 *判断客户行业是否存在 
	 *存在返回true
	 */
	public Boolean checkTrade(String name)throws Exception{
		String num = (String)dao.findForObject("CustomerMapper.checkTrade", name);
		if(num.equals("0")){
			return false;
		}else{
			return true;
		}
	}
	
	/**
	 *判断客户类型是否存在
	 *存在返回true 
	 */
	public Boolean checkOrdinary(String type)throws Exception{
		String num = (String)dao.findForObject("CustomerMapper.checkOrdinary", type);
		if(num.equals("0")){
			return false;
		}else{
			return true;
		}
	}
	
	
	/**
	 *判断部门是否存在
	 *存在返回true 
	 */
	public Boolean checkDepartment(String name)throws Exception{
		String num = (String)dao.findForObject("CustomerMapper.checkDepartment", name);
		if(num.equals("0")){
			return false;
		}else{
			return true;
		}
	}
	
	public Boolean checkExistCollector(String name)throws Exception{
		String num = (String)dao.findForObject("CustomerMapper.checkExistCollector", name);
		if(num.equals("0")){
			return false;
		}else{
			return true;
		}
	}
	
	public String findHousesNo(String name)throws Exception{
		return (String)dao.findForObject("CustomerMapper.findHousesNo", name);
	}
	
	public String findUserId(String name)throws Exception{
		return (String)dao.findForObject("CustomerMapper.findUserId", name);
	}
	
	
}
