package com.dncrm.service.system.synUser;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.entity.system.User;
import com.dncrm.util.PageData;


@Service("synUserService")
public class synUserService {

    @Resource(name = "daoSupport")
    private DaoSupport dao;

    
    public synUserService(){
    	dao = new DaoSupport();
    }
    //======================================================================================

    /*
    * 查询列表
    */
    public List<PageData> findAllUser() throws Exception {
        return (List<PageData>) dao.findForList("SynUserMapper.findAllUser","");
    }
    //新增
    public void insertSynUser(PageData pd) throws Exception{
    	dao.save("SynUserMapper.insertSynUser", pd);
    }
    //修改
    public void editById(PageData pd)throws Exception{
    	dao.update("SynUserMapper.editById", pd);
    }
    //删除
    public void deleteById(PageData pd)throws Exception{
    	dao.delete("SynUserMapper.deleteById",pd);
    }
    //查询
    public PageData findById(PageData pd)throws Exception{
    	return (PageData)dao.findForObject("SynUserMapper.findById", pd);
    }
    //查询登录名和密码
    public PageData getUserByNameAndPwd(PageData pd)throws Exception{
    	return (PageData)dao.findForObject("SynUserMapper.getUserByNameAndPwd", pd);
    }
    //更新最后登录时间
    public void updateLastLogin(PageData pd)throws Exception{
    	dao.update("SynUserMapper.updateLastLogin", pd);
    }
    //列表同步日志
    public List<PageData> findAllSynLog(Page page)throws Exception{
    	return (List<PageData>) dao.findForList("SynUserLogMapper.listPageSynLog", page);
    }
    //新增同步日志
    public void insertSynLog(PageData pd)throws Exception{
    	dao.save("SynUserLogMapper.insertSynLog", pd);
    }
  //本地同步数据同步至系统用户表
    public List<PageData> findSysUserBySynCode()throws Exception{
    	return (List<PageData>)dao.findForList("SynUserMapper.findSysUserBySynCode", "");
    }
    
    //查询已同步至syn但未同步至系统用户表的数据
    public List<PageData> findBySynStatus()throws Exception{
    	return (List<PageData>)dao.findForList("SynUserMapper.findBySynStatus","");
    }
    
    //根据操作id更改日志表同步状态
    public void updateSynStatus(PageData pd)throws Exception{
    	dao.update("SynUserLogMapper.updateSynStatus", pd);
    }
    //更改日志表同步状态
    public void updateStatus(PageData pd)throws Exception{
        dao.update("SynUserLogMapper.updateStatus", pd);
    }
    //根据Code查询log信息
    public PageData findByCode(PageData pd)throws Exception{
        return (PageData)dao.findForObject("SynUserLogMapper.findByCode", pd);
    }

	public PageData findUserByUserid(PageData pd) throws Exception {
		// TODO Auto-generated method stub
		return (PageData)dao.findForObject("SynUserMapper.findUserByUserid", pd);
	}
}
