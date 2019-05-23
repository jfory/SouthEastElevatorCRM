package com.dncrm.service.system.transportation;

import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.util.PageData;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by LGD on 2018/04/18.
 * 运输价格service
 */
@Service("transportationService")
public class TransportationService {

    @Resource(name = "daoSupport")
    private DaoSupport dao;

    public List<PageData> listPageTransportation(Page page) throws Exception {
        return (List<PageData>) dao.findForList("TransportationMapper.listPagefindTransportation", page);
    }

    public PageData findTransportationById(PageData pd)throws Exception{
        return (PageData) dao.findForObject("TransportationMapper.findTransportationById",pd);
    }

    public void save(PageData pd)throws Exception{

    }

    /**
     * 删除运输价格
     * @param pd
     * @throws Exception
     */
    public void deleteTransportation(PageData pd) throws Exception{
        dao.delete("TransportationMapper.deleteDestinationByTid",pd);
        dao.delete("TransportationMapper.deleteTransportation",pd);
    }

    @Transactional(propagation = Propagation.REQUIRED)
    public int saveDestination(PageData pd) throws Exception{
       return  (Integer) dao.save("TransportationMapper.saveDestination",pd);
    }
    @Transactional(propagation = Propagation.REQUIRED)
    public Map importFileData(List<PageData> listPd) throws Exception{
        Map<String, Object> map = new HashMap<String, Object>();
        //保存错误信息集合
        List<PageData> allErrList = new ArrayList<PageData>();
        if(listPd!=null&&listPd.size()>0){
            Boolean allErr = true;
            for(int i=0;i<listPd.size();i++){
                List<PageData> errList = new ArrayList<PageData>();
                PageData pageData=listPd.get(i);
                //第一列 区域
                String province_name=pageData.getString("var0");//区域
                String province_id="";//区域ID，用于保存目的地、运输价格信息
                if(province_name==null||"".equals(province_name)){//判断是否为空
                    errList.add(setErrorPd("区域不能为空!",1,i));
                    allErrList.addAll(errList);continue;
                }else {
                    //获取区域ID如果为空则表示区域错误
                    province_id= (String) dao.findForObject("TransportationMapper.findProvinceIdByName",pageData);
                    if(province_id==null||"".equals(province_id)){
                        errList.add(setErrorPd("区域/省份不存在,请检查数据或者到城市管理添加省份!",1,i));
                        allErrList.addAll(errList);continue;
                    }
                    pageData.put("province_id",province_id);//将区域ID加入到pd
                }
                //第二列 目的地
                String city_name=pageData.getString("var1");//目的地
                String city_id="";//目的地ID,用于保存运输价格信息
                if(city_name==null||"".equals(city_name)){
                    errList.add(setErrorPd("目的地不能为空!",2,i));
                    allErrList.addAll(errList);continue;
                }else {
                    if(province_id!=null&&!"".equals(province_id)){
                        city_id=(String) dao.findForObject("TransportationMapper.findCityIdByName",pageData);
                        if(city_id==null||"".equals(city_id)){//查不到目的地,手动保存进去
                            PageData citypd=new PageData();
                            citypd.put("province_id",province_id);
                            citypd.put("name",city_name);
                            saveDestination(citypd);
                            city_id=citypd.get("id").toString();
                        }
                        pageData.put("city_id",city_id);//将目的地ID加入到pd
                    }else {
                        errList.add(setErrorPd("目的地对应区域不能为空!",2,i));
                        allErrList.addAll(errList);continue;
                    }
                }
                //判断数据是否存在
                if(city_id!=null&&province_id!=null&&!"".equals(city_id)&&!"".equals(province_id)){
                    Integer isexist=(Integer) dao.findForObject("TransportationMapper.countTransportationData",pageData);
                    if(isexist!=null&&isexist>0){
                        errList.add(setErrorPd("对应目的地运输价信息已存在!",3,i));
                        allErrList.addAll(errList);continue;
                    }
                }
                //第三列~第九列，暂时无需校验
                //保存数据
                if(errList.size()==0){
                    allErr=false;
                    pageData.put("more_carLoad_time",pageData.get("var2"));
                    pageData.put("five_t",pageData.get("var3"));
                    pageData.put("eight_t",pageData.get("var4"));
                    pageData.put("ten_t",pageData.get("var5"));
                    pageData.put("twenty_t",pageData.get("var6"));
                    pageData.put("less_carLoad",pageData.get("var7"));
                    pageData.put("less_carLoad_time",pageData.get("var8"));
                    dao.save("TransportationMapper.save",pageData);
                }else {
                    allErrList.addAll(errList);
                }

            }
            if(allErrList.size()==0){
                map.put("msg", "success");
            }else{
                if(allErr){
                    map.put("msg", "allErr");
                }else{
                    map.put("msg", "error");
                }
                String errStr = "共出错"+allErrList.size()+"行\n";
                for(PageData forPd : allErrList){
                    errStr += "错误类型:"+forPd.getString("errMsg")+";行数:"+forPd.get("errRow").toString()+";列数:"+forPd.getString("errCol")+"\n";
                }
                errStr += "总错误:"+allErrList.size();
                map.put("errorUpload", errStr);
            }
        }else {
            map.put("msg", "error");
            map.put("errorUpload", "没有可导入数据！");
        }

        return map;
    }

    /**
     * 根据参数返回错误Map
     * @param errMsg 错误信息
     * @param errCol 错误列号
     * @param errRow 错误行号-1(剔除了标题)
     * @return
     */
    private PageData setErrorPd(String errMsg,Integer errCol,Integer errRow){
        PageData repd=new PageData();
        repd.put("errMsg", errMsg);
        repd.put("errCol",errCol==null?"":errCol.toString());
        repd.put("errRow",errRow==null?"":Integer.toString(errRow+1));
        return repd;
    }

    public void updateTransportation(PageData pd)throws Exception{
        dao.update("TransportationMapper.updateTransportation",pd);
    }
}
