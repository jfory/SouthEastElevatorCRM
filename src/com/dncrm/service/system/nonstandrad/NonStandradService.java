package com.dncrm.service.system.nonstandrad;


import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.entity.nonstandrad.NonStandrad;
import com.dncrm.util.PageData;
import com.dncrm.util.Tools;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("nonStandradService")
public class NonStandradService {

    @Resource(name = "daoSupport")
    private DaoSupport dao;

    /**
     * 查询列表
     * @param page
     * @return
     * @throws Exception
     */
    public List<PageData> listPagenonStandradList(Page page) throws Exception{
        return (List<PageData>) dao.findForList("NonStandradMapper.listPagefindnonStandrad", page);
    }

    /**
     * 查询项目信息
     * @param pd
     * @return
     * @throws Exception
     */
    public PageData findItemMsg(PageData pd) throws Exception{
        return (PageData) dao.findForObject("NonStandradMapper.findItemMsg", pd);
    }

    /**
     * 保存非标主表
     * @param nonStandrad
     * @throws Exception
     */
    public void  saveMaster(NonStandrad nonStandrad) throws Exception{
        dao.save("NonStandradMapper.saveMaster",nonStandrad);
    }

    /**
     * 修改附件 土建图图号 备注
     * @param nonStandrad
     * @throws Exception
     */
    public void updateMasterUTB(PageData pd) throws Exception{
        dao.update("NonStandradMapper.updateMasterUTB",pd);
    }
    
    /**
     * 修改附件上传
     * @param nonStandrad
     * @throws Exception
     */
    public void updateMasterNonUpload(PageData pd) throws Exception{
        dao.update("NonStandradMapper.updateMasterNonUpload",pd);
    }
    
    /**
     * 保存非标明细
     * @param nonStandrad
     * @throws Exception
     */
    public void  saveDetail(NonStandrad nonStandrad) throws Exception{
        if (nonStandrad!=null&&nonStandrad.getNonstandrad_describe()!=null){
            if(nonStandrad.getNonstandrad_describe().length==1){
                Map<String,Object> nondetail=new HashMap<String,Object>();
                nondetail.put("master_id",nonStandrad.getNon_standrad_id());//非标描述
                nondetail.put("nonstandrad_describe", java.net.URLDecoder.decode(Tools.getValueOfArray(nonStandrad.getNonstandrad_describe(), 0),"UTF-8"));//非标描述
                nondetail.put("nonstandrad_spec", Tools.getValueOfArray(nonStandrad.getNonstandrad_spec(), 0));//规格
                nondetail.put("nonstandrad_price", Tools.getValueOfArray(nonStandrad.getNonstandrad_price(), 0));//价格
                nondetail.put("nonstandrad_date", Tools.getValueOfArray(nonStandrad.getNonstandrad_date(), 0));//交货期
                nondetail.put("nonstandrad_cost", Tools.getValueOfArray(nonStandrad.getNonstandrad_cost(), 0));//成本
                nondetail.put("nonstandrad_handle",java.net.URLDecoder.decode(Tools.getValueOfArray(nonStandrad.getNonstandrad_handle(), 0)));//成本
                nondetail.put("nonstandrad_cycle",Tools.getValueOfArray(nonStandrad.getNonstandrad_cycle(),0));//成本
                
                nondetail.put("nonstandrad_CJ",Tools.getValueOfArray(nonStandrad.getNonstandrad_CJ(), 0));//差价
                nondetail.put("nonstandrad_JCB",Tools.getValueOfArray(nonStandrad.getNonstandrad_JCB(),0));//加成本
                nondetail.put("nonstandrad_JJ",Tools.getValueOfArray(nonStandrad.getNonstandrad_JJ(),0));//加价
                nondetail.put("nonstandrad_JLDW",Tools.getValueOfArray(nonStandrad.getNonstandrad_JLDW(),0));//计量单位
                nondetail.put("nonstandrad_DTYL",Tools.getValueOfArray(nonStandrad.getNonstandrad_DTYL(),0));//单台用量
                nondetail.put("nonstandrad_DTBJ",Tools.getValueOfArray(nonStandrad.getNonstandrad_DTBJ(),0));//单台报价
                nondetail.put("nonstandrad_ZJ",Tools.getValueOfArray(nonStandrad.getNonstandrad_ZJ(),0));//总价
                nondetail.put("nonstandrad_KDZ",Tools.getValueOfArray(nonStandrad.getNonstandrad_KDZ(),0));//可打折
                nondetail.put("nonstandrad_BZ",java.net.URLDecoder.decode(Tools.getValueOfArray(nonStandrad.getNonstandrad_BZ(),0)));//备注
                nondetail.put("nonstandrad_valid",Tools.getValueOfArray(nonStandrad.getNonstandrad_valid(),0));//有效

                dao.save("NonStandradMapper.saveDetail",nondetail);
            }else {
                for (int i=0;i<nonStandrad.getNonstandrad_describe().length;i++){
                    Map<String,Object> nondetail=new HashMap<String,Object>();
                    nondetail.put("master_id",nonStandrad.getNon_standrad_id());//非标描述
                    nondetail.put("nonstandrad_describe",java.net.URLDecoder.decode(Tools.getValueOfArray(nonStandrad.getNonstandrad_describe(),i)));//非标描述
                    nondetail.put("nonstandrad_spec",Tools.getValueOfArray(nonStandrad.getNonstandrad_spec(),i));//规格
                    nondetail.put("nonstandrad_price",Tools.getValueOfArray(nonStandrad.getNonstandrad_price(),i));//价格
                    nondetail.put("nonstandrad_date",Tools.getValueOfArray(nonStandrad.getNonstandrad_date(),i));//交货期
                    nondetail.put("nonstandrad_cost",Tools.getValueOfArray(nonStandrad.getNonstandrad_cost(),i));//成本
                    nondetail.put("nonstandrad_handle",java.net.URLDecoder.decode(Tools.getValueOfArray(nonStandrad.getNonstandrad_handle(),i)));//成本
                    nondetail.put("nonstandrad_cycle",nonStandrad.getNonstandrad_cycle()[i]);//成本

                    nondetail.put("nonstandrad_CJ",Tools.getValueOfArray(nonStandrad.getNonstandrad_CJ(),i));//差价
                    nondetail.put("nonstandrad_JCB",Tools.getValueOfArray(nonStandrad.getNonstandrad_JCB(),i));//加成本
                    nondetail.put("nonstandrad_JJ",Tools.getValueOfArray(nonStandrad.getNonstandrad_JJ(),i));//加价
                    nondetail.put("nonstandrad_JLDW",Tools.getValueOfArray(nonStandrad.getNonstandrad_JLDW(),i));//计量单位
                    nondetail.put("nonstandrad_DTYL",Tools.getValueOfArray(nonStandrad.getNonstandrad_DTYL(),i));//单台用量
                    nondetail.put("nonstandrad_DTBJ",Tools.getValueOfArray(nonStandrad.getNonstandrad_DTBJ(),i));//单台报价
                    nondetail.put("nonstandrad_ZJ",Tools.getValueOfArray(nonStandrad.getNonstandrad_ZJ(), i));//总价
                    nondetail.put("nonstandrad_KDZ",Tools.getValueOfArray(nonStandrad.getNonstandrad_KDZ(),i));//可打折
                    nondetail.put("nonstandrad_BZ",java.net.URLDecoder.decode(Tools.getValueOfArray(nonStandrad.getNonstandrad_BZ(),i)));//备注
                    nondetail.put("nonstandrad_valid",Tools.getValueOfArray(nonStandrad.getNonstandrad_valid(),i));//有效

                    dao.save("NonStandradMapper.saveDetail",nondetail);
                }
            }

        }
    }

    /**
     * 根据ID获取非标信息
     * @param pd
     * @return
     * @throws Exception
     */
    public PageData findNonStandradMasterById(PageData pd) throws  Exception{

        return (PageData) dao.findForObject("NonStandradMapper.findNonStandradMasterById", pd);
    }
    
    /**
     * 分页显示显示待我处理的合同
     * @param pd
     * @return
     * @throws Exception
     */
    public List<PageData> findAuditNonstandradPage(PageData pd) throws  Exception{

        return (List<PageData>) dao.findForList("NonStandradMapper.findAuditNonstandradPage", pd);
    }
    
    /**
     * 分页显示已办处理的合同
     * @param pd
     * @return
     * @throws Exception
     */
    public List<PageData> findDoneAuditNonstandradPage(PageData pd) throws  Exception{

        return (List<PageData>) dao.findForList("NonStandradMapper.findDoneAuditNonstandradPage", pd);
    }

    /**
     * 根据主表ID获取非标明细
     * @param pd
     * @return
     * @throws Exception
     */
    public List<PageData> listNonStandradDetailList(PageData pd) throws Exception{
        return (List<PageData>) dao.findForList("NonStandradMapper.listNonStandradDetailList", pd);
    }

    /**
     * 更新主表
     * @param nonStandrad
     * @throws Exception
     */
    public void  updateMaster(NonStandrad nonStandrad) throws Exception{
        dao.save("NonStandradMapper.updateMaster",nonStandrad);
    }

    public void  updateMasterInstance(PageData pd) throws Exception{
        dao.save("NonStandradMapper.updateMasterInstance",pd);
    }
    /**
     * 删除明细表
     * @param nonStandrad
     * @throws Exception
     */
    public void  deleteDetail(NonStandrad nonStandrad) throws Exception{
        dao.delete("NonStandradMapper.deleteDetail",nonStandrad);
    }
    public List<PageData>  findDetailListForMasterId(PageData pd) throws Exception{
       return (List<PageData>)dao.findForList("NonStandradMapper.findDetailListForMasterId",pd);
    }

    public void  deleteBatchDetail(PageData pd) throws Exception{
        dao.delete("NonStandradMapper.deleteBatchDetail",pd);
    }
    public void  deleteBatchMaster(PageData pd) throws Exception{
        dao.delete("NonStandradMapper.deleteBatchMaster",pd);
    }

    /**
     * 根据roleID获取当前登陆人所属部门
     * @param roleids
     * @return
     * @throws Exception
     */
    public List<PageData> getParentRoleByUserid(List <String> roleids) throws Exception{
        return (List<PageData>)dao.findForList("NonStandradMapper.getParentRoleByUserid",roleids);
    }

	public List<PageData> getNonStandradHandle(PageData pd) throws Exception {
		return (List<PageData>)dao.findForList("NonStandradMapper.getNonStandradHandle",pd);
	}

	@SuppressWarnings("unchecked")
	public List<PageData> listTempPagenonStandradList(Page page) throws Exception {
		// TODO Auto-generated method stub
		return (List<PageData>) dao.findForList("NonStandradMapper.listTempPagenonStandradList", page);
	}

	public List<PageData> findNonStandradToExcel(PageData pd) throws Exception {
		return (List<PageData>)dao.findForList("NonStandradMapper.findNonStandradToExcel",pd);
	}
	
	public List<PageData> findDefinitionIdForUserId(PageData pd) throws Exception{
        return (List<PageData>) dao.findForList("NonStandradMapper.findDefinitionIdForUserId", pd);
    }

	public List<PageData> findUserForRoleName(PageData pd) throws Exception{
        return (List<PageData>) dao.findForList("NonStandradMapper.findUserForRoleName", pd);
    }
	
	@Transactional
	public void  updateDetail(NonStandrad nonStandrad) throws Exception{
        deleteDetail(nonStandrad);
        saveDetail(nonStandrad);
    }

	@Transactional
	public void  updateNonStandrad(PageData pd, NonStandrad nonStandrad) throws Exception{
		//修改附件上传
    	updateMasterUTB(pd);
    	//
        deleteDetail(nonStandrad);
        saveDetail(nonStandrad);
    }
	
	@Transactional
	public void  updateAuditNonStandrad(PageData pd, NonStandrad nonStandrad) throws Exception{
		deleteDetail(nonStandrad);
        saveDetail(nonStandrad);
        updateMasterInstance(pd);//修改流程状态
	}
	
	public List<PageData> findBjcsForMasterIdAndItemId(PageData pd) throws Exception{
        return (List<PageData>) dao.findForList("NonStandradMapper.findBjcsForMasterIdAndItemId", pd);
    }
}
