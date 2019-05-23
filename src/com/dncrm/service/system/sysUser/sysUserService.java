package com.dncrm.service.system.sysUser;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.entity.system.User;
import com.dncrm.util.PageData;


@Service("sysUserService")
public class sysUserService {

    @Resource(name = "daoSupport")
    private DaoSupport dao;

    //======================================================================================

    /*
    * 通过id获取数据
    */
    public PageData findByUiId(PageData pd) throws Exception {
        return (PageData) dao.findForObject("UserXMapper.findByUiId", pd);
    }

    /*
    * 通过loginname获取数据
    */
    public PageData findByUId(PageData pd) throws Exception {
        return (PageData) dao.findForObject("UserXMapper.findByUId", pd);
    }
    
    public List<PageData> findToDelSyn() throws Exception {
        return (List<PageData>) dao.findForList("UserXMapper.findToDelSyn", "");
    }
    
    /*
     * 通过loginname修改数据
     */
     public void updateByUId(PageData pd) throws Exception {
         dao.update("UserXMapper.updateByUId", pd);
     }
     
     /*
      * 通过loginname删除数据
      */
      public void deleteByUId(PageData pd) throws Exception {
          dao.delete("UserXMapper.deleteByUId", pd);
      }

    /*
    * 通过邮箱获取数据
    */
    public PageData findByUE(PageData pd) throws Exception {
        return (PageData) dao.findForObject("UserXMapper.findByUE", pd);
    }

    /*
    * 通过编号获取数据
    */
    public PageData findByUN(PageData pd) throws Exception {
        return (PageData) dao.findForObject("UserXMapper.findByUN", pd);
    }

    /*
    * 保存用户
    */
    public void saveU(PageData pd) throws Exception {
        dao.save("UserXMapper.saveU", pd);
    }

    /*
    * 修改用户
    */
    public void editU(PageData pd) throws Exception {
        dao.update("UserXMapper.editU", pd);
    }

    /*
    * 换皮肤
    */
    public void setSKIN(PageData pd) throws Exception {
        dao.update("UserXMapper.setSKIN", pd);
    }

    /*
    * 删除用户
    */
    public void deleteU(PageData pd) throws Exception {
        dao.delete("UserXMapper.deleteU", pd);
    }

    /*
    * 批量删除用户
    */
    public void deleteAllU(String[] USER_IDS) throws Exception {
        dao.delete("UserXMapper.deleteAllU", USER_IDS);
    }

    /*
    *用户列表(用户组)
    */
    public List<PageData> listPdPageUser(Page page) throws Exception {
        return (List<PageData>) dao.findForList("UserXMapper.userlistPage", page);
    }

    /*
    *用户列表(全部)
    */
    public List<PageData> listAllUser(PageData pd) throws Exception {
        return (List<PageData>) dao.findForList("UserXMapper.listAllUser", pd);
    }

    /*
    *用户列表(供应商用户)
    */
    public List<PageData> listGPdPageUser(Page page) throws Exception {
        return (List<PageData>) dao.findForList("UserXMapper.userGlistPage", page);
    }

    /*
    * 保存用户IP
    */
    public void saveIP(PageData pd) throws Exception {
        dao.update("UserXMapper.saveIP", pd);
    }

    /*
    * 登录判断
    */
    public PageData getUserByNameAndPwd(PageData pd) throws Exception {
        return (PageData) dao.findForObject("UserXMapper.getUserInfo", pd);
    }

    /*
    * 跟新登录时间
    */
    public void updateLastLogin(PageData pd) throws Exception {
        dao.update("UserXMapper.updateLastLogin", pd);
    }

    /*
    *通过id获取数据
    */
    public User getUserAndRoleById(String USER_ID) throws Exception {
        return (User) dao.findForObject("UserMapper.getUserAndRoleById", USER_ID);
    }
    
    /*
     *通过封装的UserBean pd获取数据
     */
     public User getUserAndRoleByPd(PageData pd) throws Exception {
         return (User) dao.findForObject("UserMapper.getUserAndRoleByPd", pd);
     }

    /*
    *通过id获取头像
    */
    public PageData getUserAvatarById(String USER_ID) throws Exception {
        return (PageData) dao.findForObject("UserXMapper.getUserAvatarById", USER_ID);
    }

    /*
    * 更新用户头像
    */
    public void updateAvatar(PageData pd) throws Exception {
        dao.update("UserXMapper.updateAvatar", pd);
    }

    /*
   * 查询用户的主管
   */
    public List<PageData> findManagerByUserId(PageData pd) throws Exception {
        return (List<PageData>) dao.findForList("UserXMapper.findManagerByUserId", pd);
    }

    /*
     * 查询所有用户,没有where条件
     */
    public List<PageData> findAllUser()throws Exception{
    	return (List<PageData>)dao.findForList("UserXMapper.findAllUser", "");
    }
    
    /*
     *查询admin之外的所有用户 
     */
    public List<PageData> findAllUserNotAdmin()throws Exception{
    	return (List<PageData>)dao.findForList("UserXMapper.findAllUserNotAdmin", "");
    }
    
    /*
     * 修改用户角色
     */
    public void updateUserRoleByUserIds(PageData pd)throws Exception{
    	dao.update("UserXMapper.updateUserRoleByUserIds", pd);
    }
    /*
     * 修改用户变更角色
     */
    public void updateUserRoleByChange(PageData pd)throws Exception{
    	dao.update("UserXMapper.updateUserRoleByChange", pd);
    }
    
    /*
     *根据用户名查询用户 
     */
    public List<PageData> findUserListByName(PageData pd)throws Exception{
    	return (List<PageData>)dao.findForList("UserXMapper.findUserListByName", pd);
    }
    
    /*
     *编辑角色成员
     */
    public void editRoleUser(PageData pd)throws Exception{
    	dao.update("UserXMapper.editRoleUser", pd);
    }
    
    /*
     *查询用户id,姓名,职位,电话列表 
     */
    public List<PageData> findUserInfo()throws Exception{
    	return (List<PageData>)dao.findForList("UserXMapper.findUserInfo", "");
    }
    //根据用户id查出用户所属部门
    public List<PageData> findUserDepartment(String id)throws Exception{
    	return (List<PageData>)dao.findForList("UserXMapper.findUserDepartment", id);
    }
    
    /*
     *根据用户id查询姓名,职位,电话 
     */
    public PageData findUserInfoByUid(PageData pd)throws Exception{
    	return (PageData)dao.findForObject("UserXMapper.findUserInfoByUid", pd);
    }
    
    /**
     *查询职位对应的所有非重复用户
     *@param positionId:职位字符串,多个职位逗号分隔
     *@return  用户id的hashSet
     */
    
    public HashSet<String> getUserIdByPosition(String positionId)throws Exception{
    	PageData pd = new PageData();
    	HashSet<String> userIds = new HashSet<String>();
    	try{
    		if(positionId.lastIndexOf(",")>-1){
    			for(String position : positionId.split(",")){
    				pd.put("POSITION_ID", position);
    				List<PageData> list = (List<PageData>)dao.findForList("UserMapper.getUserIdByPosition", pd);
    				for(PageData userPd : list){
    					userIds.add(userPd.get("USER_ID").toString());
    				}
    			}
    		}else{
    			pd.put("POSITION_ID", positionId);
    			List<PageData> list = (List<PageData>)dao.findForList("UserMapper.getUserIdByPosition", pd);
				for(PageData userPd : list){
					userIds.add(userPd.get("USER_ID").toString());
				}
    		}
    		return userIds;
    	}catch(Exception e){
    		e.printStackTrace();
    		return new HashSet<String>();
    	}
    }
    
    public List<String> getUserIdByPositionList(List<String> list)throws Exception{
    	return (List<String>)dao.findForList("UserMapper.getUserIdByPositionList", list);
    }
    
    public String findRoleIdByUserId(String str)throws Exception{
    	return (String)dao.findForObject("UserXMapper.findRoleIdByUserId", str);
    }
    //根据用户id查询所在部门
    public String findPositionIdByUserId(String str)throws Exception{
    	return (String)dao.findForObject("UserXMapper.findUserDepartment", str);
    }
   

}
