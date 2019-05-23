package com.dncrm.service.system.elevatorConfig;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.util.PageData;

@Service("elevatorConfigService")
public class ElevatorConfigService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**
	 * 电梯基础配置列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> listPageElevatorBase(Page page) throws Exception{
		return (List<PageData>) dao.findForList("ElevatorConfigMapper.elevatorBaselistPage", page);
	}
	
	/**
	 * 电梯基础配置添加
	 * @param pd
	 * @throws Exception
	 */
	public void elevatorBaseAdd(PageData pd) throws Exception{
		dao.save("ElevatorConfigMapper.elevatorBaseAdd", pd);
	}
	
	/**
	 * 电梯基础配置编辑
	 * @param pd
	 * @throws Exception
	 */
	public void elevatorBaseEdit(PageData pd) throws Exception{
		dao.update("ElevatorConfigMapper.elevatorBaseUpdate", pd);
	}
	
	/**
	 * 电梯基础配置名字是否重复
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData existsElevatorBaseName(PageData pd) throws Exception{
		return (PageData) dao.findForObject("ElevatorConfigMapper.existsElevatorBaseName", pd);
	}
	
	/**
	 * 电梯基础配置删除
	 * @param pd
	 * @throws Exception
	 */
	public void elevatorBaseDeleteById(PageData pd) throws Exception{
		dao.delete("ElevatorConfigMapper.elevatorBaseDeleteById", pd);
	}
	
	/**
	 * 根据ID查询基础配置对象
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findElevatorBaseById(PageData pd) throws Exception{
		return (PageData) dao.findForObject("ElevatorConfigMapper.findElevatorBaseById", pd);
	}
	
	/**
	 * 根据ID查询基础配置集合
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> findElevatorBaseListById(PageData pd) throws Exception{
		return (List<PageData>) dao.findForList("ElevatorConfigMapper.findElevatorBaseListById", pd);
	}
	
	/**
	 * 电梯可选配置列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> listPageElevatorOptional(Page page) throws Exception{
		return (List<PageData>) dao.findForList("ElevatorConfigMapper.elevatorOptionallistPage", page);
	}
	
	/**
	 * 获取所有父类菜单
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findAllParentMenu(PageData pd) throws Exception{
		PageData AA = new PageData();
		PageData BB = new PageData();
		PageData CC = new PageData();
		PageData DD = new PageData();
		List<PageData> allList = new ArrayList<>();
		//查询当前的子类对象
		AA =(PageData) dao.findForObject("ElevatorCascadeMapper.getElevatorCascadeById", pd);
		//判断子类对象是否存在父类并且不是祖父类时
		if(AA != null && !AA.get("parentId").equals("0")){
			//添加到集合
			allList.add(AA);
			//继续查找父类
			BB = (PageData) dao.findForObject("ElevatorCascadeMapper.findAllParentElevatorCascadeByParentId", AA);
			if(BB.get("parentId") != null && !BB.get("parentId").equals("0")){
				allList.add(BB);
				CC = (PageData) dao.findForObject("ElevatorCascadeMapper.findAllParentElevatorCascadeByParentId", BB);
				if(CC.get("parentId") != null && !CC.get("parentId").equals("0")){
					allList.add(CC);
					DD = (PageData) dao.findForObject("ElevatorCascadeMapper.findAllParentElevatorCascadeByParentId", CC);
					if(DD != null && !DD.get("parentId").equals("0")){
						allList.add(DD);
					}
				}
			}
		}
		
		int num = allList.size();
		//判断存在多少级菜单 最大值为4级
		if(allList.size() == 4){
			pd.put("one_menu_id", DD.get("id"));
			pd.put("two_menu_id", CC.get("id"));
			pd.put("three_menu_id", BB.get("id"));
			pd.put("four_menu_id", AA.get("id"));
		}else if(allList.size() == 3){
			pd.put("one_menu_id", CC.get("id"));
			pd.put("two_menu_id", BB.get("id"));
			pd.put("three_menu_id", AA.get("id"));
		}else if(allList.size() == 2){
			pd.put("one_menu_id", BB.get("id"));
			pd.put("two_menu_id", AA.get("id"));
		}else{
			pd.put("one_menu_id", AA.get("id"));
		}
		return pd;
	}
	
	/**
	 * 电梯可选配置添加
	 * @param pd
	 * @throws Exception
	 */
	public void elevatorOptionalAdd(PageData pd) throws Exception{
		dao.save("ElevatorConfigMapper.elevatorOptionalAdd", pd);
	}
	
	/**
	 * 电梯可选配置编辑
	 * @param pd
	 * @throws Exception
	 */
	public void elevatorOptionalEdit(PageData pd) throws Exception{
		dao.update("ElevatorConfigMapper.elevatorOptionalUpdate", pd);
	}
	
	/**
	 * 电梯可选配置名字是否重复
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData existsElevatorOptionalName(PageData pd) throws Exception{
		return (PageData) dao.findForObject("ElevatorConfigMapper.existsElevatorOptionalName", pd);
	}
	
	/**
	 * 电梯可选配置删除
	 * @param pd
	 * @throws Exception
	 */
	public void elevatorOptionalDeleteById(PageData pd) throws Exception{
		dao.delete("ElevatorConfigMapper.elevatorOptionalDeleteById", pd);
	}
	
	/**
	 * 根据ID查询可选配置对象
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findElevatorOptionalById(PageData pd) throws Exception{
		return (PageData) dao.findForObject("ElevatorConfigMapper.findElevatorOptionalById", pd);
	}
	
	/**
	 * 根据ID查询可选配置集合
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> findElevatorOptionalListById(PageData pd) throws Exception{
		return (List<PageData>) dao.findForList("ElevatorConfigMapper.findElevatorOptionalListById", pd);
	}
	
	/**
	 * 根据电梯类型Id查询可选配置集合
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> findElevatorOptionalListByElevatorId(PageData pd) throws Exception{
		return (List<PageData>) dao.findForList("ElevatorConfigMapper.findElevatorOptionalListByElevatorId", pd);
	}
	
	
	
	/**
	 * 电梯非标配置列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> listPageElevatorNonstandard(Page page) throws Exception{
		return (List<PageData>) dao.findForList("ElevatorConfigMapper.elevatorNonstandardlistPage", page);
	}
	
	
	/**
	 * 电梯非标配置添加
	 * @param pd
	 * @throws Exception
	 */
	public void elevatorNonstandardAdd(PageData pd) throws Exception{
		dao.save("ElevatorConfigMapper.elevatorNonstandardAdd", pd);
	}
	
	/**
	 * 电梯非标配置编辑
	 * @param pd
	 * @throws Exception
	 */
	public void elevatorNonstandardEdit(PageData pd) throws Exception{
		dao.update("ElevatorConfigMapper.elevatorNonstandardUpdate", pd);
	}
	
	/**
	 * 电梯非标配置名字是否重复
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData existsElevatorNonstandardName(PageData pd) throws Exception{
		return (PageData) dao.findForObject("ElevatorConfigMapper.existsElevatorNonstandardName", pd);
	}
	
	/**
	 * 电梯非标配置删除
	 * @param pd
	 * @throws Exception
	 */
	public void elevatorNonstandardDeleteById(PageData pd) throws Exception{
		dao.delete("ElevatorConfigMapper.elevatorNonstandardDeleteById", pd);
	}
	
	/**
	 * 根据ID查询非标配置对象
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public PageData findElevatorNonstandardById(PageData pd) throws Exception{
		return (PageData) dao.findForObject("ElevatorConfigMapper.findElevatorNonstandardById", pd);
	}
	
	/**
	 * 根据ID查询非标配置集合
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> findElevatorNonstandardListById(PageData pd) throws Exception{
		return (List<PageData>) dao.findForList("ElevatorConfigMapper.findElevatorNonstandardListById", pd);
	}
	
	/**
	 * 根据电梯类型Id查询非标配置集合
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> findElevatorNonstandardListByElevatorId(PageData pd) throws Exception{
		return (List<PageData>) dao.findForList("ElevatorConfigMapper.findElevatorNonstandardListByElevatorId", pd);
	}
	
	/**
	 * 查询非标配置集合
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	public List<PageData> findElevatorNonstandardList(PageData pd) throws Exception{
		return (List<PageData>) dao.findForList("ElevatorConfigMapper.findElevatorNonstandardList", pd);
	}
	
}
