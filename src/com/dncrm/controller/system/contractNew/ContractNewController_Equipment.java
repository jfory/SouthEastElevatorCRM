package com.dncrm.controller.system.contractNew;

import com.dncrm.common.MailConfig;
import com.dncrm.common.DictUtils;
import com.dncrm.common.WordViewNew;
import com.dncrm.common.WorkFlow;
import com.dncrm.common.getCODdata;
import com.dncrm.common.getContractData;
import com.dncrm.controller.base.BaseController;
import com.dncrm.entity.Dict;
import com.dncrm.entity.Page;
import com.dncrm.entity.system.User;
import com.dncrm.listener.workflow.CheckTerm;
import com.dncrm.service.system.city.CityService;
import com.dncrm.service.system.contract.ContractService;
import com.dncrm.service.system.contractNew.ContractNewService;
import com.dncrm.service.system.contractNewAz.ContractNewAzService;
import com.dncrm.service.system.customer.CustomerService;
import com.dncrm.service.system.e_offer.E_offerService;
import com.dncrm.service.system.item.ItemService;
import com.dncrm.service.system.synUser.synUserService;
import com.dncrm.service.system.sysAgent.SysAgentService;
import com.dncrm.util.*;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.activiti.engine.IdentityService;
import org.activiti.engine.history.HistoricProcessInstance;
import org.activiti.engine.history.HistoricTaskInstance;
import org.activiti.engine.impl.identity.Authentication;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.*;


@Controller
@RequestMapping("/contractNew")
public class ContractNewController_Equipment extends BaseController {
    private String Globalprofit;

    @Resource(name = "e_offerService")
    private E_offerService e_offerService;

    @Resource(name = "contractService")
    private ContractService contractService;

    @Resource(name = "contractNewService")
    private ContractNewService contractNewService;

    @Resource(name = "contractNewAzService")
    private ContractNewAzService contractNewAzService;

    @Resource(name = "synUserService")
    private synUserService synUserservice;

    @Resource(name = "customerService")
    private CustomerService customerService;
    @Resource(name = "cityService")
    private CityService cityService;
    @Resource(name = "itemService")
    private ItemService itemService;
    
    @Resource(name="sysAgentService")
	private SysAgentService sysAgentService;

    /**
     * 页面:设备合同管理
     * 合同信息列表
     */
    @RequestMapping("/contractNew")
    public ModelAndView listItem(Page page) throws Exception {
        ModelAndView mv = this.getModelAndView();
        SelectByRole sbr = new SelectByRole();
        PageData pd = this.getPageData();
        try {
            //将当前登录人添加至列表查询条件
            pd.put("input_user", getUser().getUSER_ID());
            List<String> userList = sbr.findUserList(getUser().getUSER_ID());
            pd.put("userList", userList);
            page.setPd(pd);
            List<PageData> contractNewList = contractNewService.SoContractlistPage(page);
            if (!contractNewList.isEmpty()) {
                for (PageData con : contractNewList) {
                    String ACT_KEY = con.getString("ACT_KEY");
                    if (ACT_KEY != null && !"".equals(ACT_KEY)) {
                        WorkFlow workFlow = new WorkFlow();
                        List<Task> task = workFlow.getTaskService().createTaskQuery().processInstanceId(ACT_KEY).active().list();
                        if (task != null && task.size() > 0) {
                            for (Task task1 : task) {
                                con.put("task_id", task1.getId());
                                con.put("task_name", task1.getName());
                            }
                        }
                    }
                }
            }

            //跳转位置
            mv.addObject("pd", pd);
            mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
            mv.addObject("contractNewList", contractNewList);
            mv.setViewName("system/contractNew/contractNewDevice");
        } catch (Exception e) {
            // TODO: handle exception
        }
        return mv;
    }

    /**
     * 页面:报价列表
     * 功能:获取报价信息
     */
    @RequestMapping(value = "goAddContract")
    public ModelAndView goAddContract(Page page) {
        ModelAndView mv = new ModelAndView();
        SelectByRole sbr = new SelectByRole();
        PageData pd = new PageData();
        pd = this.getPageData();

        try {
            pd.put("input_user", getUser().getUSER_ID());
            List<String> userList = sbr.findUserList(getUser().getUSER_ID());
            pd.put("userList", userList);
            page.setPd(pd);
            //(new)获取全部报价信息
//			List<PageData> e_offerList = contractNewService.e_offerlistPage(page);
            List<PageData> e_offerList = contractNewService.findEofferContract(page);

            //跳转位置
            mv.setViewName("system/contractNew/contractNewQuoteSelect_edit");
            mv.addObject("e_offerList", e_offerList);
            mv.addObject("pd", pd);
            mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }

    /**
     * 页面:新增合同信息
     * 功能:录入合同信息
     */
    @RequestMapping(value = "goPickContract")
    public ModelAndView goPickContract() {
        ModelAndView mv = new ModelAndView();
        PageData pd = new PageData();
        PageData pd1 = new PageData();
        PageData bjje = new PageData();
        pd = this.getPageData();
        pd1 = this.getPageData();
        // 获取年月日
        Date dt = new Date();
        SimpleDateFormat matter1 = new SimpleDateFormat("yyyyMMdd");
        String time = matter1.format(dt);
        int number = (int) ((Math.random() * 9 + 1) * 100); // 生成随机6位数字
        String HT_NO = ("SO" + time + number); // 拼接为合同编号
        try {
            //付款方式
            List<PageData> dfkfslist = contractNewService.findFkfsByOfferNo(pd);

            pd.put("sequence_type", "contractNew");
            HT_NO = contractNewService.getSequence(pd).getString("billno");
            //项目信息

//			pd=contractNewService.findItemById(pd);
            pd = e_offerService.findItemInOffer(pd);

            PageData detailForContract = contractNewService.findItemDetailForContract(pd);
            pd.putAll(detailForContract);
//			pd1 = itemService.findItemAndAddressById(pd1);
            //电梯信息
            List<PageData> dtxxlist = DTXX(pd);


            //电梯总数
//			PageData dtnum= contractNewService.findElevByItemId(pd);
//			PageData dtnum= contractNewService.findElevCount(pd);
            PageData dtnum = e_offerService.OfferEleCount(pd);
            //报价总金额
//			PageData bjje=contractNewService.findOfferByItemId(pd);
            bjje.putAll(pd);

            pd.put("item_area", pd.get("item_area"));
            pd.put("HT_ITEM_ID", pd.get("item_id").toString());
            pd.put("HT_OFFER_ID", bjje.get("offer_id").toString());
            pd.put("HT_NO", HT_NO);
//			pd.put("DT_NUM", dtnum.get("DTNUM").toString());
            pd.put("DT_NUM", dtnum.get("YNum").toString());//电梯总数
            pd.put("TOTAL", bjje.get("COUNT_TATOL").toString());//报价总金额
            pd.put("offer_id", bjje.get("offer_id").toString());//报价id
            pd.put("COUNT_AZF", bjje.get("COUNT_AZF").toString());//安装费

            pd.put("HT_MBQX", bjje.get("SWXX_MBQX").toString());//免保期限
            pd.put("HT_ZBJBL", bjje.get("SWXX_ZBJBL").toString());//质保金比例
            //加载客户信息-用于最终用户
            List<PageData> customerList = customerService.findCustomerInfo();
            if (customerList.size() == 0) {
                mv.addObject("showAddEndUser", true);
            }
            mv.addObject("customerList", customerList);


            /*PageData org = itemService.findOrderOrg(pd);
            if (org != null) {
                pd.put("selorder_org", org.get("customer_name"));
            }*/
            
            if(contractNewService.isOfferMDOfItemIdAndVersion(pd)) {
            	mv.addObject("isOfferMD", "1");
            }

            //加载国家
            List<PageData> countryList = cityService.findAllCountry();
            mv.addObject("countryList", countryList);
            //加载省份
            List<PageData> provinceList = cityService.findAllProvince();
            mv.addObject("provinceList", provinceList);
            //加载城市
            List<PageData> cityList = cityService.findAllCityByProvinceId(pd);
            mv.addObject("cityList", cityList);
            //加载郡县
            List<PageData> coundtyList = cityService.findAllCountyByCityId(pd);
            mv.addObject("coundtyList", coundtyList);

            mv.addObject("pd", pd);
            mv.addObject("dtxxlist", dtxxlist);
            mv.addObject("dfkfslist", dfkfslist);
            mv.addObject("msg", "save");
            mv.setViewName("system/contractNew/contractNewInformation_edit");
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }

        return mv;
    }


    /**
     * 页面:合同信息
     * 功能:跳到编辑合同页面
     */
    @RequestMapping(value = "goedit")
    public ModelAndView goedit() {
        ModelAndView mv = new ModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        try {
            //根据UUID获取合同信息
            pd = contractNewService.findSoConByUUid(pd);
            pd.put("offer_id", pd.get("HT_OFFER_ID").toString());
            pd.put("item_id", pd.get("HT_ITEM_ID").toString());
            //(new,先根据报价id拿出版本号,项目id,再去找对应的项目信息)项目信息
//			PageData Itempd=contractNewService.findItemById(pd);
            PageData offerDetail = e_offerService.findOfferDetailByOfferId(pd);
            PageData Itempd = contractNewService.findItemDetailForContract(offerDetail);
            //电梯信息
            List<PageData> dtxxlist = contractNewService.findDtInfoByHtId(pd);
            //付款方式
            List<PageData> dfkfslist = contractNewService.findFkfsByHtId(pd);

            //电梯总数
//			PageData dtnum= contractNewService.findElevByItemId(pd);
//			PageData dtnum= contractNewService.findElevCount(offerDetail);
            PageData dtnum = e_offerService.OfferEleCount(offerDetail);
            //报价总金额
//			PageData bjje=contractNewService.findOfferByItemId(pd);
            PageData bjje = e_offerService.findItemInOffer(offerDetail);

            pd.put("item_no", Itempd.get("item_no").toString());
            pd.put("item_name", Itempd.get("item_name").toString());
            pd.put("customer_name", Itempd.get("customer_name") == null ? "" : Itempd.get("customer_name").toString());
            pd.put("province_name", Itempd.get("province_name").toString());
            pd.put("city_name", Itempd.get("city_name").toString());
            pd.put("county_name", Itempd.get("county_name").toString());
            pd.put("address_info", Itempd.get("address_info").toString());
            pd.put("customer_no", Itempd.get("customer_no").toString());
//			pd.put("DT_NUM", dtnum.get("DTNUM").toString());
            pd.put("DT_NUM", dtnum.get("YNum").toString());//电梯总数
            pd.put("TOTAL", bjje.get("total").toString());//报价总金额
            pd.put("offer_id", bjje.get("offer_id").toString());//报价id
            pd.put("sale_type", Itempd.getString("sale_type"));//销售类型
            pd.put("order_org", Itempd.getString("order_org"));//订购单位
            pd.put("address_id", Itempd.get("address_id").toString());//地址
            pd.put("province_id", Itempd.get("province_id").toString());//省
            pd.put("city_id", Itempd.get("city_id").toString());//市
            pd.put("county_id", Itempd.get("county_id").toString());//区

            pd.put("HT_MBQX", bjje.get("SWXX_MBQX").toString());//免保期限
            pd.put("HT_ZBJBL", bjje.get("SWXX_ZBJBL").toString());//质保金比例

            //加载客户信息-用于最终用户
            List<PageData> customerList = customerService.findCustomerInfo();
            if (customerList.size() == 0) {
                mv.addObject("showAddEndUser", true);
            }

            /*PageData org = itemService.findOrderOrg(offerDetail);
            if (org != null) {
                pd.put("selorder_org", org.get("customer_name"));
            }*/


            //加载国家
            List<PageData> countryList = cityService.findAllCountry();
            mv.addObject("countryList", countryList);
            //加载省份
            List<PageData> provinceList = cityService.findAllProvince();
            mv.addObject("provinceList", provinceList);
            //加载城市
            List<PageData> cityList = cityService.findAllCityByProvinceId(pd);
            mv.addObject("cityList", cityList);
            //加载郡县
            List<PageData> coundtyList = cityService.findAllCountyByCityId(pd);
            mv.addObject("coundtyList", coundtyList);

            mv.addObject("customerList", customerList);
            mv.addObject("pd", pd);
            mv.addObject("dtxxlist", dtxxlist);
            mv.addObject("dfkfslist", dfkfslist);
            mv.addObject("msg", "edit");
            mv.setViewName("system/contractNew/contractNewInformation_edit");
        } catch (Exception e) {
            // TODO: handle exception
        }

        return mv;
    }

    /**
     * 页面:合同信息
     * 功能:跳到查看 合同页面
     */
    @RequestMapping(value = "goView")
    public ModelAndView goView() {
        ModelAndView mv = new ModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        String CNUpdate = pd.getString("CNUpdate");
        try {
            //根据UUID获取合同信息
            pd = contractNewService.findSoConByUUid(pd);
            pd.put("offer_id", pd.get("HT_OFFER_ID").toString());
            pd.put("item_id", pd.get("HT_ITEM_ID").toString());

//			(new,先根据报价id拿出版本号,项目id,再去找对应的项目信息)项目信息
//			PageData Itempd=contractNewService.findItemById(pd);
            PageData offerDetail = e_offerService.findOfferDetailByOfferId(pd);
            PageData Itempd = contractNewService.findItemDetailForContract(offerDetail);
            //电梯信息
            List<PageData> dtxxlist = contractNewService.findDtInfoByHtId(pd);
            //付款方式
            List<PageData> dfkfslist = contractNewService.findFkfsByHtId(pd);

            //电梯总数
//			PageData dtnum= contractNewService.findElevByItemId(pd);
//			PageData dtnum= contractNewService.findElevCount(offerDetail);
            PageData dtnum = e_offerService.OfferEleCount(offerDetail);
            //报价总金额
//			PageData bjje=contractNewService.findOfferByItemId(pd);
            PageData bjje = e_offerService.findItemInOffer(offerDetail);

            pd.put("item_no", Itempd.get("item_no").toString());
            pd.put("item_name", Itempd.get("item_name").toString());
            pd.put("customer_name", Itempd.get("customer_name").toString());
            pd.put("province_name", Itempd.get("province_name").toString());
            pd.put("city_name", Itempd.get("city_name").toString());
            pd.put("county_name", Itempd.get("county_name").toString());
            pd.put("address_info", Itempd.get("address_info").toString());
            pd.put("sale_type", Itempd.getString("sale_type"));
            pd.put("order_org", Itempd.getString("order_org"));//订购单位
//			pd.put("DT_NUM", dtnum.get("DTNUM").toString());
            pd.put("DT_NUM", dtnum.get("YNum").toString());//电梯总数
            pd.put("TOTAL", bjje.get("total").toString());//报价总金额
            pd.put("offer_id", bjje.get("offer_id").toString());//报价id
            pd.put("customer_no", Itempd.get("customer_no").toString());
            pd.put("address_id", Itempd.get("address_id").toString());//地址
            pd.put("province_id", Itempd.get("province_id").toString());//省
            pd.put("city_id", Itempd.get("city_id").toString());//市
            pd.put("county_id", Itempd.get("county_id").toString());//区


            PageData org = itemService.findOrderOrg(offerDetail);
            if (org != null) {
                pd.put("selorder_org", org.get("customer_name"));
            }
            pd.put("order_org_contact", offerDetail.get("order_org_contact"));
            pd.put("order_org_phone", offerDetail.get("order_org_phone"));
            pd.put("design_name", offerDetail.get("design_name"));
            pd.put("design_address", offerDetail.get("design_address"));
            pd.put("design_phone", offerDetail.get("design_phone"));
            pd.put("design_fax", offerDetail.get("design_fax"));
            //加载客户信息-用于最终用户
            List<PageData> customerList = customerService.findCustomerInfo();
            if (customerList.size() == 0) {
                mv.addObject("showAddEndUser", true);
            }
            pd.put("user_id", pd.get("INPUT_USER"));
            PageData sysuser = synUserservice.findUserByUserid(pd);
            pd.put("apply_user", sysuser.get("NAME"));

            //加载国家
            List<PageData> countryList = cityService.findAllCountry();
            mv.addObject("countryList", countryList);
            //加载省份
            List<PageData> provinceList = cityService.findAllProvince();
            mv.addObject("provinceList", provinceList);
            //加载城市
            List<PageData> cityList = cityService.findAllCityByProvinceId(pd);
            mv.addObject("cityList", cityList);
            //加载郡县
            List<PageData> coundtyList = cityService.findAllCountyByCityId(pd);
            
            if("4".equals(pd.getString("ACT_STATUS")) && "1".equals(CNUpdate)) {
                mv.addObject("CNUpdate", "1");
            }
            
            if(isQxViableMLR()) {
            	mv.addObject("isQxViableMLR", "1");
            }
            
            mv.addObject("coundtyList", coundtyList);
            mv.addObject("customerList", customerList);
            mv.addObject("pd", pd);
            mv.addObject("dtxxlist", dtxxlist);
            mv.addObject("dfkfslist", dfkfslist);
            mv.addObject("msg", "view");
            mv.setViewName("system/contractNew/contractNewInformation_edit");
            
            Map<String, String> hc = getHC();
            hc.put("cha", "1");
            mv.addObject(Const.SESSION_QX, hc); // 按钮权限
            
        } catch (Exception e) {
            e.printStackTrace();
            // TODO: handle exception
        }

        return mv;
    }


    //根据项目ID获取电梯信息
    public List<PageData> DTXX(PageData pd) {
        List<PageData> DtxxList = new ArrayList<>();
        try {

//			List<PageData> Dtlist=contractNewService.findBJCByItemId(pd);
            List<PageData> Dtlist = contractNewService.findBJCBYItemidoff(pd);
            for (PageData dtPd : Dtlist) {
                PageData elevPd = new PageData();
                String dtids = dtPd.getString("BJC_ELEV");
                List<String> eIdList = Arrays.asList(dtids.split(","));

                elevPd.put("list", eIdList);
                List<PageData> elevList = contractNewService.findElevById(elevPd);
                for (PageData ePd : elevList) {
                    String DT_TX;
                    String DT_CZM;
                    String dtlx = ePd.get("elevator_id").toString();
                    if (!dtlx.equals("4")) {
                        String models_name = dtPd.get("models_name").toString();
                        String BJC_ZZ = (dtPd.get("BJC_ZZ") == null ? "" : dtPd.get("BJC_ZZ")).toString();
                        String BJC_SD = (dtPd.get("BJC_SD") == null ? "" : dtPd.get("BJC_SD")).toString();
                        DT_TX = dtPd.get("BJC_ZZ") == null ? models_name : models_name + " " + BJC_ZZ + "kg" + " " + BJC_SD + "m/s";

                        String BJC_C = (dtPd.get("BJC_C") == null ? "" : dtPd.get("BJC_C")).toString();
                        String BJC_Z = (dtPd.get("BJC_Z") == null ? "" : dtPd.get("BJC_Z")).toString();
                        String BJC_M = (dtPd.get("BJC_M") == null ? "" : dtPd.get("BJC_M")).toString();
                        DT_CZM = dtPd.get("BJC_C") == null ? dtPd.get("BJC_TSGD").toString() : BJC_C + "/" + BJC_Z + "/" + BJC_M;
                    } else {
                        DT_TX = dtPd.get("models_name").toString();

                        DT_CZM = dtPd.get("BJC_TSGD").toString();
                    }

                    int sbzj = Integer.parseInt(dtPd.get("SBSJZJ").toString());//设备价
                    int anf = Integer.parseInt(dtPd.get("BJC_AZF").toString());//安装费
                    int ysf = Integer.parseInt(dtPd.get("BJC_YSF").toString());//运输费
                    BigDecimal zj = new BigDecimal(dtPd.get("BJC_SJBJ").toString());//运输费
                    int sl = Integer.parseInt(dtPd.get("BJC_SL").toString());
                    double DT_SBDJ = sbzj / sl; //单台设备价
                    double DT_AZDJ = anf / sl;  //单台安装费
                    double DT_YSJ = ysf / sl;   //单台运输费
                    double DT_XJ = DT_SBDJ + DT_AZDJ + DT_YSJ;

                    //Map<String,String> dtmap=contractNewService.getSequenceByDt(ePd.getString("ele_type"));

                    PageData elpd = new PageData();
                    //elpd.put("DT_UUID",UUID.randomUUID().toString());//编号
                    elpd.put("DT_NO", "");//编号
                    elpd.put("ele_type", ePd.getString("ele_type"));//产品代码
                    elpd.put("DT_TX", DT_TX);//梯型
                    elpd.put("DT_TH", ePd.get("eno").toString());//梯号
                    elpd.put("DT_CZM", DT_CZM);//层站门（提升高度）
                    elpd.put("DT_SBDJ", DT_SBDJ);//设备单价
                    elpd.put("DT_AZDJ", DT_AZDJ);//安装单价
                    elpd.put("DT_YSJ", DT_YSJ);//运输单价
                    elpd.put("DT_XJ", zj.divide(new BigDecimal(sl), 2, BigDecimal.ROUND_HALF_UP));//小计
                    elpd.put("DT_BJC_ID", dtPd.getString("BJC_ID"));
                    elpd.put("DT_ELEV_ID", ePd.get("id"));

                    DtxxList.add(elpd);
                }
            }

        } catch (Exception e) {
            // TODO 自动生成的 catch 块
            e.printStackTrace();
        }

        return DtxxList;
    }

    //保存设备合同新增
    @RequestMapping("/save")
    public ModelAndView save() {
        ModelAndView mv = new ModelAndView();
        PageData pd = new PageData();
        String df = DateUtil.getTime().toString(); //获取系统时间

        pd = this.getPageData();
        Subject currentUser = SecurityUtils.getSubject();
        Session session = currentUser.getSession();
        PageData pds = new PageData();
        pds = (PageData) session.getAttribute("userpds");
        String USER_ID = pds.getString("USER_ID");

        try {
            PageData offerDetail = e_offerService.findOfferDetailByOfferId(pd);

            //合同审核流程 key
            String processDefinitionKey = "ContractNew";
            pd.put("KEY", processDefinitionKey);
            //查询流程是否存在
            List<PageData> SoContractList = contractNewService.SelAct_Key(pd);
            if (SoContractList != null) {
                pd.put("HT_UUID", UUID.randomUUID().toString());
                pd.put("ACT_KEY", processDefinitionKey);
                pd.put("ACT_STATUS", "1");
                pd.put("INPUT_USER", USER_ID);
                pd.put("INPUT_TIME", df);

                //保存电梯信息
                String jsonDt = pd.get("jsonDt").toString();
                PageData DtPd = new PageData();
                JSONArray jsonArray = JSONArray.fromObject(jsonDt);
                for (int i = 0; i < jsonArray.size(); i++) {
                    JSONObject jsonObj = jsonArray.getJSONObject(i);
                    System.out.println(jsonObj.getString("ele_type"));
                    String dtno = jsonObj.get("DT_NO").toString();
                    if (StringUtils.isBlank(dtno)) {
                        Map<String, String> dtmap = contractNewService.getSequenceByDt(jsonObj.getString("ele_type"));
                        dtno = dtmap.get("DT_NO").toString();
                    }
                    DtPd.put("DT_UUID", UUID.randomUUID().toString());
                    DtPd.put("DT_NO", dtno);
                    DtPd.put("DT_TX", jsonObj.get("DT_TX").toString());
                    DtPd.put("DT_TH", jsonObj.get("DT_TH").toString());
                    DtPd.put("DT_CZM", jsonObj.get("DT_CZM").toString());
                    DtPd.put("DT_SBDJ", jsonObj.get("DT_SBDJ").toString());
                    DtPd.put("DT_AZDJ", jsonObj.get("DT_AZDJ").toString());
                    DtPd.put("DT_YSJ", jsonObj.get("DT_YSJ").toString());
                    DtPd.put("DT_XJ", jsonObj.get("DT_XJ").toString());
                    DtPd.put("DT_HT_ID", pd.get("HT_UUID").toString());
                    DtPd.put("DT_BJC_ID", jsonObj.get("DT_BJC_ID").toString());
                    DtPd.put("DT_ELEV_ID", jsonObj.get("DT_ELEV_ID").toString());
                    //保存电梯信息
                    contractNewService.saveDt(DtPd);
                }

                //保存付款方式
                String jsonFkfs = pd.get("jsonFkfs").toString();
                PageData FkfsPd = new PageData();
                JSONArray jsonArray2 = JSONArray.fromObject(jsonFkfs);
                for (int i = 0; i < jsonArray2.size(); i++) {
                    JSONObject jsonObj = jsonArray2.getJSONObject(i);

                    FkfsPd.put("FKFS_UUID", UUID.randomUUID().toString());
                    FkfsPd.put("FKFS_QS", jsonObj.get("FKFS_QS").toString());
                    FkfsPd.put("FKFS_KX", jsonObj.get("FKFS_KX").toString());
                    FkfsPd.put("FKFS_PDRQ", jsonObj.get("FKFS_PDRQ").toString());
                    FkfsPd.put("FKFS_PCRQ", jsonObj.get("FKFS_PCRQ").toString());
                    FkfsPd.put("FKFS_FKBL", jsonObj.get("FKFS_FKBL").toString());
                    FkfsPd.put("FKFS_JE", jsonObj.get("FKFS_JE").toString());
                    FkfsPd.put("FKFS_BZ", jsonObj.get("FKFS_BZ").toString());
                    FkfsPd.put("FKFS_ZT", "1"); //状态1 未生成应收款信息
                    FkfsPd.put("FKFS_HT_UUID", pd.get("HT_UUID").toString());
                    FkfsPd.put("FKFS_FKTS", jsonObj.get("FKFS_FKTS").toString());
                    //保存付款方式
                    contractNewService.saveFkfs(FkfsPd);
                }

                //如果设备合同类型 = 1.设备安装分开
                if (pd.get("HT_TYPE").toString().equals("1")) {
                    //保存安装合同信息
                    saveAz(pd);
                }

                //处理最终用户字符串
                String end_user = pd.containsKey("end_user") ? pd.get("end_user").toString() : "";
                pd.put("end_user", end_user.replace(("_" + (pd.containsKey("customer_no") ? pd.get("customer_no").toString() : "")), ""));
//				contractNewService.updateCustomerName(pd);
//				pd.remove("ACT_KEY");
                offerDetail.putAll(pd);
                contractNewService.updateTempCustomerName(offerDetail);
                //保存合同信息
                contractNewService.save(offerDetail);
                //(new)更新对应报价的项目名
                contractNewService.updateItemNameForContract(offerDetail);
//				contractNewService.updateTempItemNameForContract(pd);

                PageData addressPd = new PageData();
                addressPd.clear();
                addressPd.put("id", pd.get("address_id").toString());
                addressPd.put("province_id", pd.get("province_id") == null ? "" : pd.get("province_id").toString());
                addressPd.put("city_id", pd.get("city_id") == null ? "" : pd.get("city_id").toString());
                addressPd.put("county_id", pd.get("county_id") == null ? "" : pd.get("county_id").toString());
                addressPd.put("address_info", pd.get("address_info") == null ? "" : pd.get("address_info").toString());
                addressPd.put("address_name", pd.get("address_name") == null ? "" : pd.get("address_name").toString());
                itemService.editItemAddressById(addressPd);

                mv.addObject("msg", "success");

            } else {
                mv.addObject("msg", "流程不存在");
            }
//			PageData offerpd=contractNewService.findOfferById(pd);
//			PageData offerpd=contractNewService.findIteminOfferById(pd);

            //流程使用类
            CheckTerm checkTerm = new CheckTerm();
            if (offerDetail != null) {
                checkTerm.setChargesstatus(offerDetail.getString("YJSFCB"));//佣金超标
                checkTerm.setAlldiscount(Double.parseDouble(offerDetail.getString("COUNT_ZK")));
                checkTerm.setChangguidiscount(Double.parseDouble(offerDetail.getString("COUNT_ZK")));
            }

            //-----生成流程实例
            WorkFlow workFlow = new WorkFlow();
            IdentityService identityService = workFlow.getIdentityService();
            identityService.setAuthenticatedUserId(USER_ID);
            Object uuId = pd.get("HT_UUID");
            String businessKey = "tb_so_contract.HT_UUID." + uuId;
            //为超时发送邮件任务放入配置
            String IntervalTime = MailConfig.IntervalTime;
			String tomail = MailConfig.tomail;
			String emailForm = MailConfig.emailForm;
            Map<String, Object> variables = new HashMap<String, Object>();
            variables.put("user_id", USER_ID);
            variables.put("HT_UUID", uuId);
            variables.put("checkTerm", checkTerm);
            variables.put("TaskItem", offerDetail.get("item_name"));
            
			variables.put("IntervalTime", IntervalTime);
			variables.put("tomail", tomail);
			variables.put("emailForm", emailForm);
            ProcessInstance proessInstance = null; //存放生成的流程实例id
            if (processDefinitionKey != null && !"".equals(processDefinitionKey)) {
                proessInstance = workFlow.getRuntimeService().startProcessInstanceByKey(processDefinitionKey, businessKey, variables);
                System.out.println(proessInstance);
            }
            if (proessInstance != null) {
                PageData aPd = new PageData();
                aPd.put("ACT_KEY", proessInstance.getId());
                aPd.put("HT_UUID", pd.get("HT_UUID").toString());
                //修改报价信息  （流程的key该为流程实例id）
                contractNewService.editAct_Key(aPd);

                //判断如果是提交进来的 启动流程
                if ("TJ".equals(pd.getString("type"))) {
                    //调用启动设备合同流程的方法
                    applyTJ(proessInstance.getId(), pd.get("HT_UUID").toString());
                }


                mv.addObject("msg", "success");
            } else {
                //删除电梯信息
                contractNewService.deleteDtInfo(pd);
                //删除付款方式
                contractNewService.deleteFkfs(pd);
                //删除合同信息
                contractNewService.deleteContract(pd);
                mv.addObject("msg", "failed");
                mv.addObject("err", "没有生成流程实例");
            }

        } catch (Exception e) {
            // TODO 自动生成的 catch 块
            e.printStackTrace();
        }
        mv.addObject("id", "InformationHTML");
        mv.addObject("form", "ContractNewForm");
        mv.setViewName("save_result");
        return mv;
    }

    /**
     * 如果设备合同类型是 安装合同分开
     * 生成安装合同信息
     *
     * @return
     */
    public ModelAndView saveAz(PageData pd) {
        ModelAndView mv = new ModelAndView();
        PageData Azpd = new PageData();
        String df = DateUtil.getTime().toString(); //获取系统时间

        // 获取年月日
        Date dt = new Date();
        SimpleDateFormat matter1 = new SimpleDateFormat("yyyyMMdd");
        String time = matter1.format(dt);
        int number = (int) ((Math.random() * 9 + 1) * 100); // 生成随机3位数字
        String AZ_NO = ("AZ" + time + number); // 拼接为合同编号

        Subject currentUser = SecurityUtils.getSubject();
        Session session = currentUser.getSession();
        PageData pds = new PageData();
        pds = (PageData) session.getAttribute("userpds");
        String USER_ID = pds.getString("USER_ID");
        try {
            //合同审核流程 key
            String processDefinitionKey = "ContractNewAZ";
            Azpd.put("KEY", processDefinitionKey);
            //查询流程是否存在
            List<PageData> SoContractList = contractNewService.SelAct_Key(Azpd);
            if (SoContractList != null) {
                PageData offerPd = e_offerService.findOfferDetailByOfferId(pd);

                offerPd = e_offerService.findByuuId(pd);
                String count_azf = offerPd.getString("COUNT_AZF");
                BigDecimal count_azf_bd = new BigDecimal(count_azf == null || "".equals(count_azf) ? "0" : count_azf);

                String az_uuid = UUID.randomUUID().toString();
                Azpd.put("AZ_UUID", az_uuid);
                Azpd.put("AZ_NO", AZ_NO);
                Azpd.put("item_id", pd.get("item_id").toString());
                Azpd.put("offer_id", pd.get("offer_id").toString());
                Azpd.put("AZ_QDRQ", pd.get("HT_QDRQ").toString());
                Azpd.put("AZ_MBQX", pd.get("HT_MBQX").toString());
                Azpd.put("AZ_JHFS", pd.get("HT_JHFS").toString());
                Azpd.put("AZ_ZBJBL", pd.get("HT_ZBJBL").toString());
                Azpd.put("AZ_LXR", pd.get("HT_LXR").toString());
                Azpd.put("AZ_LXDH", pd.get("HT_LXDH").toString());
                Azpd.put("AZ_YJKGRQ", pd.get("HT_YJKGRQ").toString());
                Azpd.put("AZ_FJSC", pd.get("HT_FJSC").toString());
                Azpd.put("AZ_WJLX", pd.get("HT_WJLX").toString());
                Azpd.put("AZ_YJSGZQ", pd.get("HT_YJSGZQ").toString());
                Azpd.put("AZ_BZ", pd.get("HT_BZ").toString());
                Azpd.put("ACT_KEY", processDefinitionKey);
                Azpd.put("ACT_STATUS", "1");
                Azpd.put("INPUT_USER", USER_ID);
                Azpd.put("INPUT_TIME", df);
                Azpd.put("customer_name", pd.get("customer_name").toString());
                Azpd.put("item_name", pd.get("item_name").toString());
                Azpd.put("DTNUM", pd.get("DTNUM").toString());
                BigDecimal coutbl = new BigDecimal(offerPd.getString("SWXX_FKBL_DJ") == null ||
                        "".equals(offerPd.getString("SWXX_FKBL_DJ")) ? "0" : offerPd.getString("SWXX_FKBL_DJ")).add(
                        new BigDecimal(offerPd.getString("SWXX_FKBL_FHQ") == null ||
                                "".equals(offerPd.getString("SWXX_FKBL_FHQ")) ? "0" : offerPd.getString("SWXX_FKBL_FHQ"))
                ).add(
                        new BigDecimal(offerPd.getString("SWXX_FKBL_HDGD") == null ||
                                "".equals(offerPd.getString("SWXX_FKBL_HDGD")) ? "0" : offerPd.getString("SWXX_FKBL_HDGD"))
                ).add(
                        new BigDecimal(offerPd.getString("SWXX_FKBL_YSHG") == null ||
                                "".equals(offerPd.getString("SWXX_FKBL_YSHG")) ? "0" : offerPd.getString("SWXX_FKBL_YSHG"))
                ).add(
                        new BigDecimal(offerPd.getString("SWXX_FKBL_ZBJBL") == null ||
                        "".equals(offerPd.getString("SWXX_FKBL_ZBJBL")) ? "0" : offerPd.getString("SWXX_FKBL_ZBJBL"))
                );
                Azpd.put("TOTAL", count_azf_bd.toString());
                Azpd.put("PRICE", count_azf_bd.multiply(coutbl.divide(new BigDecimal(100))).setScale(2, BigDecimal.ROUND_UP).floatValue());
                Azpd.put("AZ_YJYSRQ", pd.get("HT_YJYSRQ").toString());
                Azpd.put("AZ_YJFFRQ", pd.get("HT_YJFHRQ").toString());
                Azpd.put("AZ_YJZBJRQ", pd.get("HT_YJZBJRQ").toString());
                Azpd.put("HT_UUID", pd.get("HT_UUID").toString());

                //保存合同信息
                contractNewAzService.save(Azpd);


                PageData FkfsPd = new PageData();
                BigDecimal fkbl;
                int qs = 0;

                //定金 合同签订日期
                if (offerPd.getString("SWXX_FKBL_DJ") != null &&
                        !"".equals(offerPd.getString("SWXX_FKBL_DJ"))) {
                    qs++;
                    FkfsPd.put("FKFS_UUID", UUID.randomUUID().toString());
                    FkfsPd.put("FKFS_QS", qs);//期数
                    FkfsPd.put("FKFS_KX", "1");//款项
                    FkfsPd.put("FKFS_PDRQ", "1");//判断日期
                    FkfsPd.put("FKFS_PCRQ", "");//偏差日期
                    fkbl = new BigDecimal(offerPd.getString("SWXX_FKBL_DJ") == null ||
                            "".equals(offerPd.getString("SWXX_FKBL_DJ")) ? "0" : offerPd.getString("SWXX_FKBL_DJ"));
                    FkfsPd.put("FKFS_FKBL", fkbl);//付款比例
                    FkfsPd.put("FKFS_JE", count_azf_bd.multiply((fkbl.divide(new BigDecimal("100")))).setScale(2, BigDecimal.ROUND_UP).toString());//金额
                    FkfsPd.put("FKFS_BZ", "");//备注
                    FkfsPd.put("FKFS_ZT", "1"); //状态1 未生成应收款信息
                    FkfsPd.put("FKFS_HT_UUID", az_uuid);
                    FkfsPd.put("FKFS_FKTS", offerPd.getString("SWXX_FKBL_DJ_DAY"));
                    //保存付款方式
                    contractNewService.saveFkfs(FkfsPd);
                }

                //安装发货款  预计发货日期  发货前
                // todo 暂时屏蔽，不知是否需要
				/*FkfsPd.put("FKFS_UUID", UUID.randomUUID().toString());
				FkfsPd.put("FKFS_QS", "1");//期数
				FkfsPd.put("FKFS_KX", "5");//款项
				FkfsPd.put("FKFS_PDRQ", "1");//判断日期
				FkfsPd.put("FKFS_PCRQ", "");//偏差日期
				fkbl=new BigDecimal(offerPd.getString("SWXX_FKBL_FHQ")==null||
						"".equals(offerPd.getString("SWXX_FKBL_FHQ"))?"0":offerPd.getString("SWXX_FKBL_FHQ"));
				FkfsPd.put("FKFS_FKBL", fkbl);//付款比例
				FkfsPd.put("FKFS_JE", count_azf_bd.multiply((fkbl.divide(new BigDecimal("100")))).setScale(2,BigDecimal.ROUND_UP).toString());//金额
				FkfsPd.put("FKFS_BZ", "");//备注
				FkfsPd.put("FKFS_ZT", "1"); //状态1 未生成应收款信息
				FkfsPd.put("FKFS_HT_UUID", az_uuid);
				//保存付款方式
				contractNewService.saveFkfs(FkfsPd);*/
                if (offerPd.getString("SWXX_FKBL_FHQ") != null &&
                        !"".equals(offerPd.getString("SWXX_FKBL_FHQ"))) {
                    qs++;
                    FkfsPd.put("FKFS_UUID", UUID.randomUUID().toString());
                    FkfsPd.put("FKFS_QS", qs);//期数
    				FkfsPd.put("FKFS_KX", "5");//款项
    				FkfsPd.put("FKFS_PDRQ", "2");//判断日期
                    FkfsPd.put("FKFS_PCRQ", "");//偏差日期
                    fkbl = new BigDecimal(offerPd.getString("SWXX_FKBL_FHQ") == null ||
                            "".equals(offerPd.getString("SWXX_FKBL_FHQ")) ? "0" : offerPd.getString("SWXX_FKBL_FHQ"));
                    FkfsPd.put("FKFS_FKBL", fkbl);//付款比例
                    FkfsPd.put("FKFS_JE", count_azf_bd.multiply((fkbl.divide(new BigDecimal("100")))).setScale(2, BigDecimal.ROUND_UP).toString());//金额
                    FkfsPd.put("FKFS_BZ", "");//备注
                    FkfsPd.put("FKFS_ZT", "1"); //状态1 未生成应收款信息
                    FkfsPd.put("FKFS_HT_UUID", az_uuid);
                    FkfsPd.put("FKFS_FKTS", offerPd.getString("SWXX_FKBL_FHQ_DAY"));
                    //保存付款方式
                    contractNewService.saveFkfs(FkfsPd);
                }


                //安装开工款  预计进场日期  货到工地
                if (offerPd.getString("SWXX_FKBL_HDGD") != null &&
                        !"".equals(offerPd.getString("SWXX_FKBL_HDGD"))) {
                    qs++;
                    FkfsPd.put("FKFS_UUID", UUID.randomUUID().toString());
                    FkfsPd.put("FKFS_QS", qs);//期数
                    FkfsPd.put("FKFS_KX", "6");//款项
                    FkfsPd.put("FKFS_PDRQ", "4");//判断日期
                    FkfsPd.put("FKFS_PCRQ", "");//偏差日期
                    fkbl = new BigDecimal(offerPd.getString("SWXX_FKBL_HDGD") == null ||
                            "".equals(offerPd.getString("SWXX_FKBL_HDGD")) ? "0" : offerPd.getString("SWXX_FKBL_HDGD"));
                    FkfsPd.put("FKFS_FKBL", fkbl);//付款比例
                    FkfsPd.put("FKFS_JE", count_azf_bd.multiply((fkbl.divide(new BigDecimal("100")))).setScale(2, BigDecimal.ROUND_UP).toString());//金额
                    FkfsPd.put("FKFS_BZ", "");//备注
                    FkfsPd.put("FKFS_ZT", "1"); //状态1 未生成应收款信息
                    FkfsPd.put("FKFS_HT_UUID", az_uuid);
                    FkfsPd.put("FKFS_FKTS", offerPd.getString("SWXX_FKBL_HDGD_DAY"));
                    //保存付款方式
                    contractNewService.saveFkfs(FkfsPd);
                }

                //验收款  预计验收日期  验收合格
                if (offerPd.getString("SWXX_FKBL_YSHG") != null &&
                        !"".equals(offerPd.getString("SWXX_FKBL_YSHG"))) {
                    qs++;
                    FkfsPd.put("FKFS_UUID", UUID.randomUUID().toString());
                    FkfsPd.put("FKFS_QS", qs);//期数
                    FkfsPd.put("FKFS_KX", "7");//款项
                    FkfsPd.put("FKFS_PDRQ", "5");//判断日期
                    FkfsPd.put("FKFS_PCRQ", "");//偏差日期
                    fkbl = new BigDecimal(offerPd.getString("SWXX_FKBL_YSHG") == null ||
                            "".equals(offerPd.getString("SWXX_FKBL_YSHG")) ? "0" : offerPd.getString("SWXX_FKBL_YSHG"));
                    FkfsPd.put("FKFS_FKBL", fkbl);//付款比例
                    FkfsPd.put("FKFS_JE", count_azf_bd.multiply((fkbl.divide(new BigDecimal("100")))).setScale(2, BigDecimal.ROUND_UP).toString());//金额
                    FkfsPd.put("FKFS_BZ", "");//备注
                    FkfsPd.put("FKFS_ZT", "1"); //状态1 未生成应收款信息
                    FkfsPd.put("FKFS_HT_UUID", az_uuid);
                    FkfsPd.put("FKFS_FKTS", offerPd.getString("SWXX_FKBL_YSHG_DAY"));
                    //保存付款方式
                    contractNewService.saveFkfs(FkfsPd);
                }

                //质保金 免保期限
                if (offerPd.getString("SWXX_FKBL_ZBJBL") != null &&
                        !"".equals(offerPd.getString("SWXX_FKBL_ZBJBL"))) {
                    qs++;
                    FkfsPd.put("FKFS_UUID", UUID.randomUUID().toString());
                    FkfsPd.put("FKFS_QS", qs);//期数
                    FkfsPd.put("FKFS_KX", "8");//款项
                    FkfsPd.put("FKFS_PDRQ", "6");//判断日期
                    FkfsPd.put("FKFS_PCRQ", "");//偏差日期
                    fkbl = new BigDecimal(offerPd.getString("SWXX_FKBL_ZBJBL") == null ||
                            "".equals(offerPd.getString("SWXX_FKBL_ZBJBL")) ? "0" : offerPd.getString("SWXX_FKBL_ZBJBL"));
                    FkfsPd.put("FKFS_FKBL", fkbl);//付款比例
                    FkfsPd.put("FKFS_JE", count_azf_bd.multiply((fkbl.divide(new BigDecimal("100")))).setScale(2, BigDecimal.ROUND_UP).toString());//金额
                    FkfsPd.put("FKFS_BZ", "");//备注
                    FkfsPd.put("FKFS_ZT", "1"); //状态1 未生成应收款信息
                    FkfsPd.put("FKFS_HT_UUID", az_uuid);
                    FkfsPd.put("FKFS_FKTS", offerPd.getString("SWXX_FKBL_ZBJBL_DAY"));
                    //保存付款方式
                    contractNewService.saveFkfs(FkfsPd);
                }

                mv.addObject("msg", "success");
            } else {
                mv.addObject("msg", "流程不存在");
            }

            //-----生成流程实例
            WorkFlow workFlow = new WorkFlow();
            IdentityService identityService = workFlow.getIdentityService();
            identityService.setAuthenticatedUserId(USER_ID);
            Object uuId = Azpd.get("AZ_UUID");
            String businessKey = "tb_az_contract.AZ_UUID." + uuId;
            Map<String, Object> variables = new HashMap<String, Object>();
            variables.put("user_id", USER_ID);
            ProcessInstance proessInstance = null; //存放生成的流程实例id
            if (processDefinitionKey != null && !"".equals(processDefinitionKey)) {
                proessInstance = workFlow.getRuntimeService().startProcessInstanceByKey(processDefinitionKey, businessKey, variables);
            }
            if (proessInstance != null) {
                PageData aPd = new PageData();
                aPd.put("ACT_KEY", proessInstance.getId());
                aPd.put("AZ_UUID", Azpd.get("AZ_UUID").toString());
                //修改报价信息  （流程的key该为流程实例id）
                contractNewAzService.editAct_Key(aPd);
				/*//判断如果是提交进来的 启动流程
				if("TJ".equals(pd.getString("type")))
				{
					//调用启动安装合同流程的方法
					applyTJAZ(proessInstance.getId(),Azpd.get("AZ_UUID").toString());
				}
				*/

                mv.addObject("msg", "success");
            } else {
                //删除合同信息
                contractNewAzService.deleteContract(Azpd);
                mv.addObject("msg", "failed");
                mv.addObject("err", "没有生成流程实例");
            }

        } catch (Exception e) {
            // TODO 自动生成的 catch 块
            e.printStackTrace();
        }
        mv.addObject("id", "InformationHTML");
        mv.addObject("form", "ContractNewAzForm");
        mv.setViewName("save_result");
        return mv;
    }


    //保存设备合同   编辑
    @RequestMapping("/edit")
    public ModelAndView setContract() {
        ModelAndView mv = new ModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        try {
            //删除付款方式
            contractNewService.deleteFkfs(pd);
            //保存付款方式
            String jsonFkfs = pd.get("jsonFkfs").toString();
            PageData FkfsPd = new PageData();
            JSONArray jsonArray2 = JSONArray.fromObject(jsonFkfs);
            for (int i = 0; i < jsonArray2.size(); i++) {
                JSONObject jsonObj = jsonArray2.getJSONObject(i);

                FkfsPd.put("FKFS_UUID", UUID.randomUUID().toString());
                FkfsPd.put("FKFS_QS", jsonObj.get("FKFS_QS").toString());
                FkfsPd.put("FKFS_KX", jsonObj.get("FKFS_KX").toString());
                FkfsPd.put("FKFS_PDRQ", jsonObj.get("FKFS_PDRQ").toString());
                FkfsPd.put("FKFS_PCRQ", jsonObj.get("FKFS_PCRQ").toString());
                FkfsPd.put("FKFS_FKBL", jsonObj.get("FKFS_FKBL").toString());
                FkfsPd.put("FKFS_JE", jsonObj.get("FKFS_JE").toString());
                FkfsPd.put("FKFS_BZ", jsonObj.get("FKFS_BZ").toString());
                FkfsPd.put("FKFS_ZT", "1"); //状态1 未生成应收款信息
                FkfsPd.put("FKFS_HT_UUID", pd.get("HT_UUID").toString());
                FkfsPd.put("FKFS_FKTS", jsonObj.get("FKFS_FKTS").toString());
                //保存付款方式
                contractNewService.saveFkfs(FkfsPd);
            }
            //设备合同总价变更后修改 安装合同总价格
            String a = pd.get("TOTAL").toString();
            String b = pd.get("PRICE").toString();
            Double AzPrice = Double.parseDouble(a) - Double.parseDouble(b);
            pd.put("AzPrice", AzPrice);
            //contractNewAzService.editPrice(pd);

            //处理最终用户字符串
            String end_user = pd.containsKey("end_user") ? pd.get("end_user").toString() : "";
            pd.put("end_user", end_user.replace(("_" + (pd.containsKey("customer_no") ? pd.get("customer_no").toString() : "")), ""));
//			contractNewService.updateCustomerName(pd);
            contractNewService.updateTempCustomerNameOfOfferId(pd);

            //编辑 合同信息
            contractNewService.edit(pd);
            contractNewService.updateItemNameForContract(pd);

            PageData addressPd = new PageData();
            addressPd.clear();
            addressPd.put("id", pd.get("address_id").toString());
            addressPd.put("province_id", pd.get("province_id") == null ? "" : pd.get("province_id").toString());
            addressPd.put("city_id", pd.get("city_id") == null ? "" : pd.get("city_id").toString());
            addressPd.put("county_id", pd.get("county_id") == null ? "" : pd.get("county_id").toString());
            addressPd.put("address_info", pd.get("address_info") == null ? "" : pd.get("address_info").toString());
            addressPd.put("address_name", pd.get("address_name") == null ? "" : pd.get("address_name").toString());
            itemService.editItemAddressById(addressPd);

            //更新电梯信息
            String jsonDt = pd.get("jsonDt").toString();
            JSONArray jsonArray = JSONArray.fromObject(jsonDt);
            contractNewService.updateDTXX(jsonArray, pd.getString("HT_UUID"));


            mv.addObject("msg", "success");
        } catch (Exception e) {
            // TODO 自动生成的 catch 块
            e.printStackTrace();
        }
        mv.addObject("id", "InformationHTML");
        mv.addObject("form", "ContractNewForm");
        mv.setViewName("save_result");
        return mv;
    }

    /**
     * 删除数据
     *
     * @param
     */
    @RequestMapping("/Delect")
    @ResponseBody
    public Object Delect() {
        PageData pd = this.getPageData();
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            //删除电梯信息
            contractNewService.deleteDtInfo(pd);
            //删除付款方式
            contractNewService.deleteFkfs(pd);
            //删除合同信息
            contractNewService.deleteContract(pd);
            map.put("msg", "success");
        } catch (Exception e) {
            map.put("msg", "failed");
        }
        return JSONObject.fromObject(map);
    }

    /**
     * 启动流程
     *
     * @return
     */
    @RequestMapping("/apply")
    @ResponseBody
    public Object apply() {
        PageData pd = new PageData();
        pd = this.getPageData();
        Map<String, Object> map = new HashMap<>();
        try {
        	//付款方式
            List<PageData> dfkfslist = contractNewService.findFkfsByHtId(pd);
            if(dfkfslist == null || dfkfslist.size() == 0) {
                map.put("msg", "failed");
                map.put("err", "请添加付款方式");
                return JSONObject.fromObject(map);
            }
        	
            //shiro管理的session
            Subject currentUser = SecurityUtils.getSubject();
            Session session = currentUser.getSession();
            PageData pds = new PageData();
            pds = (PageData) session.getAttribute("userpds");
            String USER_ID = pds.getString("USER_ID");              //当前登录用户的ID
            String ACT_KEY = pd.getString("ACT_KEY");       //流程实例id
            
            // 如果流程的实例id存在，启动流程 
            if (ACT_KEY != null && !"".equals(ACT_KEY)) {
                WorkFlow workFlow = new WorkFlow();
                // 用来设置启动流程的人员ID，引擎会自动把用户ID保存到activiti:initiator中
                workFlow.getIdentityService().setAuthenticatedUserId(USER_ID);
                Task task = workFlow.getTaskService().createTaskQuery().processInstanceId(ACT_KEY).singleResult();
                Map<String, Object> variables = new HashMap<String, Object>();
                //设置任务角色
                workFlow.getTaskService().setAssignee(task.getId(), USER_ID);
                //签收任务
                workFlow.getTaskService().claim(task.getId(), USER_ID);
                //设置流程变量
                variables.put("action", "提交申请");
                
                String comment = "";
                Object object = pd.get("HT_REMARK");
                if (object != null) {
                    comment = pd.getString("HT_REMARK");
                }
                workFlow.getTaskService().addComment(task.getId(), null, comment);
                workFlow.getTaskService().setVariablesLocal(task.getId(), variables);
                pd.put("ACT_STATUS", 2);   //流程状态  2代表流程启动,等待审核
                //更新流程状态
                contractNewService.editAct_Status(pd);
                workFlow.getTaskService().complete(task.getId());
                //获取下一个任务的信息
                Task tasks = workFlow.getTaskService().createTaskQuery().processInstanceId(ACT_KEY).list().get(0);
                map.put("task_name", tasks.getName());
                map.put("status", "1");
            }
            if ((ACT_KEY != null && !"".equals(ACT_KEY))) {
                map.put("status", "3");
            }
            map.put("msg", "success");
        } catch (Exception e) {
            logger.error(e.toString(), e);
            map.put("msg", "failed");
            map.put("err", "系统错误");
        }
        return JSONObject.fromObject(map);
    }


    /**
     * 启动流程
     *
     * @param ACT_KEYTJ
     * @param HT_UUID
     * @return
     */
    @RequestMapping("/applyTJ")
    @ResponseBody
    public Object applyTJ(String ACT_KEYTJ, String HT_UUID) {
        PageData pd = new PageData();
        //pd = this.getPageData();
        pd.put("HT_UUID", HT_UUID);
        pd.put("ACT_KEY", ACT_KEYTJ);
        Map<String, Object> map = new HashMap<>();
        try {
            //shiro管理的session
            Subject currentUser = SecurityUtils.getSubject();
            Session session = currentUser.getSession();
            PageData pds = new PageData();
            pds = (PageData) session.getAttribute("userpds");
            String USER_ID = pds.getString("USER_ID");              //当前登录用户的ID
            String ACT_KEY = pd.getString("ACT_KEY");       //流程实例id
            // 如果流程的实例id存在，启动流程
            if (ACT_KEY != null && !"".equals(ACT_KEY)) {
                WorkFlow workFlow = new WorkFlow();
                // 用来设置启动流程的人员ID，引擎会自动把用户ID保存到activiti:initiator中
                workFlow.getIdentityService().setAuthenticatedUserId(USER_ID);
                Task task = workFlow.getTaskService().createTaskQuery().processInstanceId(ACT_KEY).singleResult();
                Map<String, Object> variables = new HashMap<String, Object>();
                //设置任务角色
                workFlow.getTaskService().setAssignee(task.getId(), USER_ID);
                //签收任务
                workFlow.getTaskService().claim(task.getId(), USER_ID);
                //设置流程变量
                variables.put("action", "提交申请");

                String comment = "";
                workFlow.getTaskService().addComment(task.getId(), null, comment);
                workFlow.getTaskService().setVariablesLocal(task.getId(), variables);
                pd.put("ACT_STATUS", 2);   //流程状态  2代表流程启动,等待审核
                //更新流程状态
                contractNewService.editAct_Status(pd);
                workFlow.getTaskService().complete(task.getId());
                //获取下一个任务的信息
                /*Task tasks = workFlow.getTaskService().createTaskQuery().processInstanceId(ACT_KEY).singleResult();
                map.put("task_name",tasks.getName());
                map.put("status", "1");*/
            }
            if ((ACT_KEY != null && !"".equals(ACT_KEY))) {
                map.put("status", "3");
            }
            map.put("msg", "success");
        } catch (Exception e) {
            logger.error(e.toString(), e);
            map.put("msg", "failed");
            map.put("err", "系统错误");
        }
        return JSONObject.fromObject(map);
    }


    /**
     * 启动流程
     *
     * @return
     */
    @RequestMapping("/applyTJAZ")
    @ResponseBody
    public Object applyTJAZ(String ACT_KEYTJ, String AZ_UUID) {
        PageData pd = new PageData();
        /*pd = this.getPageData();*/
        pd.put("AZ_UUID", AZ_UUID);
        pd.put("ACT_KEY", ACT_KEYTJ);
        Map<String, Object> map = new HashMap<>();
        try {
            //shiro管理的session
            Subject currentUser = SecurityUtils.getSubject();
            Session session = currentUser.getSession();
            PageData pds = new PageData();
            pds = (PageData) session.getAttribute("userpds");
            String USER_ID = pds.getString("USER_ID");              //当前登录用户的ID
            String ACT_KEY = pd.getString("ACT_KEY");       //流程实例id
            // 如果流程的实例id存在，启动流程
            if (ACT_KEY != null && !"".equals(ACT_KEY)) {
                WorkFlow workFlow = new WorkFlow();
                // 用来设置启动流程的人员ID，引擎会自动把用户ID保存到activiti:initiator中
                workFlow.getIdentityService().setAuthenticatedUserId(USER_ID);
                Task task = workFlow.getTaskService().createTaskQuery().processInstanceId(ACT_KEY).singleResult();
                Map<String, Object> variables = new HashMap<String, Object>();
                //设置任务角色
                workFlow.getTaskService().setAssignee(task.getId(), USER_ID);
                //签收任务
                workFlow.getTaskService().claim(task.getId(), USER_ID);
                //设置流程变量
                variables.put("action", "提交申请");
                String comment = "";
                workFlow.getTaskService().addComment(task.getId(), null, comment);
                workFlow.getTaskService().setVariablesLocal(task.getId(), variables);
                pd.put("ACT_STATUS", 2);   //流程状态  2代表流程启动,等待审核
                //更新流程状态
                contractNewAzService.editAct_Status(pd);
                workFlow.getTaskService().complete(task.getId());
                //获取下一个任务的信息
                 /*Task tasks = workFlow.getTaskService().createTaskQuery().processInstanceId(ACT_KEY).singleResult();
                 map.put("task_name",tasks.getName());
                 map.put("status", "1");*/
            }
            if ((ACT_KEY != null && !"".equals(ACT_KEY))) {
                map.put("status", "3");
            }
            map.put("msg", "success");
        } catch (Exception e) {
            logger.error(e.toString(), e);
            map.put("msg", "failed");
            map.put("err", "系统错误");
        }
        return JSONObject.fromObject(map);
    }

    /**
     * 显示待我处理的
     *
     * @param page
     * @return
     */
    @RequestMapping(value = "/ContractAudit")
    public ModelAndView listPendingContractor(Page page) {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        try {
            //shiro管理的session
            Subject currentUser = SecurityUtils.getSubject();
            Session session = currentUser.getSession();
            PageData pds = new PageData();
            pds = (PageData) session.getAttribute("userpds");
            String USER_ID = pds.getString("USER_ID");
            page.setPd(pds);
            mv.setViewName("system/contractNew/contractNew_Audit");
            mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
            //存放任务集合
            List<PageData> ContractList = new ArrayList<>();
            WorkFlow workFlow = new WorkFlow();
            // 等待处理的任务
            int zCount = 0;
            //设置分页数据
            int firstResult;//开始游标
            int maxResults;//结束游标
            int showCount = page.getShowCount();//默认为10
            int currentPage = page.getCurrentPage();//默认为0
            if (currentPage == 0) {//currentPage为0时，页面第一次加载或者刷新
                firstResult = currentPage;//从0开始
                currentPage += 1;//当前为第一页
                maxResults = showCount;
            } else {
                firstResult = showCount * (currentPage - 1);
                maxResults = firstResult + showCount;
            }
            List<Task> toHandleListCount = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID).processDefinitionKey("ContractNew").orderByTaskCreateTime().desc().active().list();
            List<Task> toHandleList = workFlow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID).processDefinitionKey("ContractNew").orderByTaskCreateTime().desc().active().listPage(firstResult, maxResults);
            for (Task task : toHandleList) {
                PageData e_offer = new PageData();
                String processInstanceId = task.getProcessInstanceId();
                ProcessInstance processInstance = workFlow.getRuntimeService().createProcessInstanceQuery().processInstanceId(processInstanceId).active().singleResult();
                String businessKey = processInstance.getBusinessKey();
                if (!StringUtils.isEmpty(businessKey)) {
                    //leave.leaveId.
                    String[] info = businessKey.split("\\.");
                    e_offer.put(info[1], info[2]);
                    if (e_offer.get("HT_UUID") != "" && e_offer.get("HT_UUID") != null) {
                    	  /*if (pd.getString("flag")!=null &&pd.getString("flag").equals("shouye")) {
                        	  if(e_offer.getNoneNULLString("HT_UUID").equals(pd.get("HT_UUID"))) {
                        		  //根据uuiid查询信息
                                  e_offer=contractNewService.findSoConByUUid(e_offer);
                                  if (e_offer==null) break;
                                  e_offer.put("task_name",task.getName());
                                  e_offer.put("task_id",task.getId());
                                  if(task.getAssignee()!=null){
                                	  e_offer.put("type","1");//待处理
                                  }else{
                                	  e_offer.put("type","0");//待签收
                                  }
                                  ContractList.add(e_offer);
                            	  break;
                        	  } else {
                        		  continue;
                        	  }
                          }*/

                        //根据uuiid查询信息
                        e_offer = contractNewService.findSoConByUUid(e_offer);
                        if (e_offer == null) continue;
                        e_offer.put("task_name", task.getName());
                        e_offer.put("task_id", task.getId());
                        if (task.getAssignee() != null) {
                            e_offer.put("type", "1");//待处理
                        } else {
                            e_offer.put("type", "0");//待签收
                        }
                        ContractList.add(e_offer);
                    }

                }

            }

            zCount = toHandleList.size();
            //设置分页数据
            int totalResult = toHandleListCount.size();
            if (totalResult <= showCount) {
                page.setTotalPage(1);
            } else {
                int count = Integer.valueOf(totalResult / showCount);
                int mod = totalResult % showCount;
                if (mod > 0) {
                    count = count + 1;
                }
                page.setTotalPage(count);
            }
            page.setTotalResult(totalResult);
            page.setCurrentResult(ContractList.size());
            page.setCurrentPage(currentPage);
            page.setShowCount(showCount);
            page.setEntityOrField(true);
            //如果有多个form,设置第几个,从0开始
            page.setFormNo(0);
            page.setPageStrForActiviti(page.getPageStrForActiviti());
            mv.addObject("page", null);
            //待处理任务的count
            pd.put("count", ContractList.size());
            pd.put("isActive2", "1");
            mv.addObject("pd", pd);
            mv.addObject("ContractList", ContractList);
            mv.addObject("userpds", pds);
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }

    /**
     * 签收任务
     *
     * @return
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/claim")
    @ResponseBody
    public Object claim() {
        Map map = new HashMap();
        PageData pd = new PageData();
        pd = this.getPageData();
        try {
            //shiro管理的session
            Subject currentUser = SecurityUtils.getSubject();
            Session session = currentUser.getSession();
            PageData pds = new PageData();
            pds = (PageData) session.getAttribute("userpds");

            WorkFlow workFlow = new WorkFlow();
            String task_id = pd.getString("task_id");
            String user_id = pds.getString("USER_ID");
            workFlow.getTaskService().claim(task_id, user_id);
            map.put("msg", "success");
        } catch (Exception e) {
            map.put("msg", "failed");
            map.put("err", "签收失败");
            logger.error(e.toString(), e);
        }
        return JSONObject.fromObject(map);
    }

    /**
     * 跳到办理任务页面
     *
     * @return
     * @throws Exception
     */
    @RequestMapping("/goHandStra")
    public ModelAndView goHandleAgent() throws Exception {
        ModelAndView mv = new ModelAndView();
        PageData pd = this.getPageData();
//        PageData pd1 = this.getPageData();
        WorkFlow workFlow = new WorkFlow();
        String task_id = pd.get("task_id").toString();


        //根据UUID获取合同信息
        pd = contractNewService.findSoConByUUid(pd);

        pd.put("item_id", pd.get("HT_ITEM_ID").toString());
        pd.put("offer_id", pd.get("HT_OFFER_ID"));

        Task task = workFlow.getTaskService().createTaskQuery().taskId(task_id).singleResult();
        if (task.getTaskDefinitionKey().equals("businesstask")) {//商务评审
            pd.put("dfkey", task.getTaskDefinitionKey());
        } else if (task.getTaskDefinitionKey().equals("engineetask")) {//工程部评审
            pd.put("dfkey", task.getTaskDefinitionKey());
        } else if (task.getTaskDefinitionKey().equals("techtask")) {//技术评审
            pd.put("dfkey", task.getTaskDefinitionKey());
        }
        PageData offerdetail = contractNewService.findIteminOfferById(pd);
        pd.putAll(offerdetail);

        //项目信息
//			PageData Itempd=contractNewService.findItemById(pd);
        PageData Itempd = contractNewService.findTempItemdetail(pd);
//			pd1 = itemService.findItemAndAddressById(pd1);
        //电梯信息
        List<PageData> dtxxlist = contractNewService.findDtInfoByHtId(pd);
        //付款方式
        List<PageData> dfkfslist = contractNewService.findFkfsByHtId(pd);

        //电梯总数
//			PageData dtnum= contractNewService.findElevByItemId(pd);
        PageData dtnum = e_offerService.OfferEleCount(offerdetail);
        //报价总金额
//			PageData bjje=contractNewService.findOfferByItemId(pd);

//			pd.put("item_no", offerdetail.get("item_no").toString());
//			pd.put("item_name", offerdetail.get("item_name").toString());
//			pd.put("customer_name", offerdetail.get("customer_name").toString());
        pd.put("province_name", Itempd.get("province_name").toString());
        pd.put("city_name", Itempd.get("city_name").toString());
        pd.put("county_name", Itempd.get("county_name").toString());
        pd.put("address_info", Itempd.get("address_info").toString());
//			pd.put("DT_NUM", dtnum.get("DTNUM").toString());
        pd.put("DT_NUM", dtnum.get("YNum").toString());//电梯总数
//			pd.put("TOTAL", bjje.get("total").toString());//报价总金额
//			pd.put("offer_id", bjje.get("offer_id").toString());//报价id
//			pd.put("customer_no", Itempd.get("customer_no").toString());
        pd.put("address_id", Itempd.get("address_id").toString());//地址
        pd.put("province_id", Itempd.get("province_id").toString());//省
        pd.put("city_id", Itempd.get("city_id").toString());//市
        pd.put("county_id", Itempd.get("county_id").toString());//区
        pd.put("task_id", task_id);//
        //加载客户信息-用于最终用户
        List<PageData> customerList = customerService.findCustomerInfo();
        if (customerList.size() == 0) {
            mv.addObject("showAddEndUser", true);
        }

        //加载国家
        List<PageData> countryList = cityService.findAllCountry();
        mv.addObject("countryList", countryList);
        //加载省份
        List<PageData> provinceList = cityService.findAllProvince();
        mv.addObject("provinceList", provinceList);
        //加载城市
        List<PageData> cityList = cityService.findAllCityByProvinceId(pd);
        mv.addObject("cityList", cityList);
        //加载郡县
        List<PageData> coundtyList = cityService.findAllCountyByCityId(pd);
        mv.addObject("coundtyList", coundtyList);

        mv.addObject("customerList", customerList);
//			System.out.println(pd);
        mv.addObject("pd", pd);
        mv.addObject("dtxxlist", dtxxlist);
        mv.addObject("dfkfslist", dfkfslist);
        mv.addObject("msg", "view");
        mv.setViewName("system/contractNew/contractNew_Handle");
        mv.addObject("pd", pd);
        
        Map<String, String> hc = getHC();
        hc.put("cha", "1");
        mv.addObject(Const.SESSION_QX, hc); // 按钮权限
        
        return mv;
    }

    /**
     * 办理任务
     *
     * @return
     */
    @RequestMapping("/handleAgent")
    public ModelAndView handleAgent() {
        ModelAndView mv = new ModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        try {
            //shiro管理的session
            Subject currentUser = SecurityUtils.getSubject();
            Session session = currentUser.getSession();
            PageData pds = new PageData();
            pds = (PageData) session.getAttribute("userpds");

            // 办理任务
            WorkFlow workFlow = new WorkFlow();
            String task_id = pd.getString("task_id");
            String user_id = pds.getString("USER_ID");
            Map<String, Object> variables = new HashMap<String, Object>();
            boolean isApproved = false;
            boolean isEnd = false;
            String action = pd.getString("action");
            @SuppressWarnings("unused")
            int status;
            Task task = workFlow.getTaskService().createTaskQuery().taskId(task_id).singleResult();
            variables = workFlow.getTaskService().getVariables(task_id);
            if (action.equals("approve")) {
                if (task.getTaskDefinitionKey().equals("EndTask")) {
                    status = 2;    //已完成
                    pd.put("ACT_STATUS", 4);             //流程状态   4.已通过
                    isApproved = true;
                    isEnd = true;
                    contractNewService.editAct_Status(pd);  //修改流程状态
                    //流程审核通过生成应收款记录
                    setYSK(pd);
                } else if (task.getTaskDefinitionKey().equals("techtask")) {
                    variables.put("agreecount", ((Integer) variables.get("agreecount") + 1));
                    pd.put("ACT_STATUS", 3);             //流程状态  3.审核中
                    isApproved = true;
                    contractNewService.editAct_Status(pd);  //修改流程状态

                    //更新附件
                    contractNewService.updateUploadForID(pd);

                } else if (task.getTaskDefinitionKey().equals("businesstask")) {
                    String nextlevel = pd.getString("nextlevel");
                    CheckTerm checkTerm = (CheckTerm) variables.get("checkTerm");
                    checkTerm.setApprove(checkTerm.isApprove() ? true : false);
                    checkTerm.setNextlevel(nextlevel.equals("0") ? false : true);

                    variables.put("checkTerm", checkTerm);
                    pd.put("ACT_STATUS", 3);             //流程状态  3.审核中
                    isApproved = true;
                    contractNewService.editAct_Status(pd);  //修改流程状态
                } else if (task.getTaskDefinitionKey().equals("engineetask")) {
                    String profit = pd.getString("profit");
                    PageData pd1 = new PageData();
                    pd1 = this.getPageData();
                    pd1.put("HT_MLR", profit);


                    contractNewService.updateMLR(pd1);
                    Integer flag = null;
                    if (StringUtils.isNoneBlank(profit)) {
                        flag = Integer.parseInt(profit);
                        if (flag > 32) {
                            profit = "1";
                        } else {
                            profit = "0";
                        }
                    } else {
                        profit = "1";
                    }

                    CheckTerm checkTerm = (CheckTerm) variables.get("checkTerm");
                    checkTerm.setApprove(checkTerm.isApprove() ? true : false);

                    checkTerm.setProfit(profit);

                    variables.put("mll", flag);
                    variables.put("checkTerm", checkTerm);
                    pd.put("ACT_STATUS", 3);                    //流程状态  3.审核中
                    isApproved = true;
                    contractNewService.editAct_Status(pd);  //修改流程状态
                } else {

                    CheckTerm checkTerm = (CheckTerm) variables.get("checkTerm");
                    checkTerm.setApprove(checkTerm.isApprove() ? true : false);
                    variables.put("checkTerm", checkTerm);
                    pd.put("ACT_STATUS", 3);             //流程状态  3.审核中
                    isApproved = true;
                    contractNewService.editAct_Status(pd);  //修改流程状态
                }
            } else if (action.equals("reject")) {
                //pd.put("ACT_STATUS",5);             //流程状态  5代表 被驳回
                variables.put("approved", false);
                //contractNewService.editAct_Status(pd);  //修改流程状态

                CheckTerm checkTerm = (CheckTerm) variables.get("checkTerm");
                checkTerm.setApprove(false);
                variables.put("checkTerm", checkTerm);
            }
            String comment = (String) pd.get("comment");
            if (isApproved) {
                variables.put("action", "批准");
            } else {
                variables.put("action", "驳回");
            }
            if (isEnd) {
                variables.put("action", "通过,流程结束！");
            }
            //使得task_id与流程变量关联,查询历史记录时可以通过task_id查询到操作变量,必须使用setVariableLocal方法
            workFlow.getTaskService().setVariablesLocal(task_id, variables);
            Authentication.setAuthenticatedUserId(user_id);
            workFlow.getTaskService().addComment(task_id, null, comment);
            workFlow.getTaskService().complete(task_id, variables);
            mv.addObject("msg", "success");
        } catch (Exception e) {
            mv.addObject("msg", "failed");
            mv.addObject("err", "办理失败！");
            logger.error(e.toString(), e);
        }
        mv.addObject("id", "handleLeave");
        mv.addObject("form", "handleLeaveForm");
        mv.setViewName("save_result");
        return mv;
    }

    /**
     * 根据付款方式 生成应收款
     *
     * @param pd
     */
    public void setYSK(PageData pd) {
        try {
            PageData YskPd = new PageData();
            //根据id获取合同信息
            pd = contractNewService.findSoConByUUid(pd);
            //根据合同ID获取付款方式信息
            List<PageData> dfkfslist = contractNewService.findFkfsByHtId(pd);
            for (PageData fkfs : dfkfslist) {
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
     * 重新提交流程
     *
     * @return
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/restartAgent")
    @ResponseBody
    public Object restartAgent() {
        Map map = new HashMap();
        PageData pd = new PageData();
        pd = this.getPageData();
        try {
        	//付款方式
            List<PageData> dfkfslist = contractNewService.findFkfsByHtId(pd);
            if(dfkfslist == null || dfkfslist.size() == 0) {
                map.put("msg", "failed");
                map.put("err", "请添加付款方式");
                return JSONObject.fromObject(map);
            }
        	
            //shiro管理的session
            Subject currentUser = SecurityUtils.getSubject();
            Session session = currentUser.getSession();
            PageData pds = new PageData();
            pds = (PageData) session.getAttribute("userpds");
            WorkFlow workFlow = new WorkFlow();
            String task_id = pd.getString("task_id");  //流程id
            String user_id = pds.getString("USER_ID");
            workFlow.getTaskService().claim(task_id, user_id);
            Map<String, Object> variables = new HashMap<String, Object>();
            variables.put("action", "重新提交");
            //使得task_id与流程变量关联,查询历史记录时可以通过task_id查询到操作变量,必须使用setVariableLocal方法
            workFlow.getTaskService().setVariablesLocal(task_id, variables);
            Authentication.setAuthenticatedUserId(user_id);
            //处理任务
            workFlow.getTaskService().complete(task_id);
            //更新业务数据的状态
            pd.put("ACT_STATUS", 2); //流程状态 2.待审核
            contractNewService.editAct_Status(pd);  //修改流程状态
            map.put("msg", "success");
        } catch (Exception e) {
            map.put("msg", "failed");
            map.put("err", "重新提交失败");
            logger.error(e.toString(), e);
        }
        return JSONObject.fromObject(map);
    }

    /**
     * 显示我已经处理的任务
     *
     * @return
     */
    @RequestMapping("/listDoneOffer")
    public ModelAndView listDoneE_offer(Page page) {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        try {
            //shiro管理的session
            Subject currentUser = SecurityUtils.getSubject();
            Session session = currentUser.getSession();
            PageData pds = new PageData();
            pds = (PageData) session.getAttribute("userpds");
            String USER_ID = pds.getString("USER_ID");
            page.setPd(pds);
            mv.setViewName("system/contractNew/contractNew_Audit");
            mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
            WorkFlow workFlow = new WorkFlow();
            // 已处理的任务集合
            List<PageData> ContractList = new ArrayList<>();
            List<HistoricTaskInstance> list = new ArrayList<HistoricTaskInstance>();
            HashMap<String, HistoricTaskInstance> map = new HashMap<String, HistoricTaskInstance>();

            //获取已处理的任务
            List<HistoricTaskInstance> historicTaskInstances = workFlow.getHistoryService().createHistoricTaskInstanceQuery().taskAssignee(USER_ID).processDefinitionKey("ContractNew").orderByTaskCreateTime().desc().list();
            //移除重复的
            for (HistoricTaskInstance instance : historicTaskInstances) {
                String processInstanceId = instance.getProcessInstanceId();
                HistoricProcessInstance historicProcessInstance = workFlow.getHistoryService().createHistoricProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
                String businessKey = historicProcessInstance.getBusinessKey();
                map.put(businessKey, instance);
            }

            @SuppressWarnings("rawtypes")
            Iterator iter = map.entrySet().iterator();
            while (iter.hasNext()) {
                @SuppressWarnings("rawtypes")
                Map.Entry entry = (Map.Entry) iter.next();
                list.add((HistoricTaskInstance) entry.getValue());
            }
            //设置分页数据
            int firstResult;//开始游标
            int maxResults;//结束游标
            int showCount = page.getShowCount();//默认为10
            int currentPage = page.getCurrentPage();//默认为0
            if (currentPage == 0) {//currentPage为0时，页面第一次加载或者刷新
                firstResult = currentPage;//从0开始
                currentPage += 1;//当前为第一页
                maxResults = showCount;
            } else {
                firstResult = showCount * (currentPage - 1);
                maxResults = firstResult + showCount;
            }
            //int listCount =(list.size()<=maxResults?list.size():maxResults);
            int listCount = list.size();
            //从分页参数开始
            for (int i = firstResult; i < listCount; i++) {
                HistoricTaskInstance historicTaskInstance = list.get(i);
                PageData stra = new PageData();
                String processInstanceId = historicTaskInstance.getProcessInstanceId();
                HistoricProcessInstance historicProcessInstance = workFlow.getHistoryService().createHistoricProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
                String businessKey = historicProcessInstance.getBusinessKey();
                if (!StringUtils.isEmpty(businessKey)) {
                    //leave.leaveId.
                    String[] info = businessKey.split("\\.");
                    stra.put(info[1], info[2]);
                    if (stra.get("HT_UUID") != "" && stra.get("HT_UUID") != null) {
                        stra = contractNewService.findSoConByUUid(stra);

                        //检查申请者是否是本人,如果是,跳过
                        //if (stra==null||stra.getString("INPUT_USER").equals(USER_ID))
                        //continue;
                        //查询当前流程是否还存在
                        List<ProcessInstance> runing = workFlow.getRuntimeService().createProcessInstanceQuery().processInstanceId(processInstanceId).list();
                        if (stra != null) {
                            if (runing == null || runing.size() <= 0) {
                                stra.put("isRuning", 0);
                            } else {
                                stra.put("isRuning", 1);
                                //正在运行,查询当前的任务信息
                                List<Task> lista = workFlow.getTaskService().createTaskQuery().processInstanceId(processInstanceId).list();
                                if (lista != null && lista.size() > 1) {
                                    Task task = lista.get(0);
                                    stra.put("task_name", task.getName());
                                    stra.put("task_id", task.getId());
                                } else {
                                    Task task = workFlow.getTaskService().createTaskQuery().processInstanceId(processInstanceId).singleResult();
                                    stra.put("task_name", task.getName());
                                    stra.put("task_id", task.getId());
                                }
                            }
                            ContractList.add(stra);
                        }
                    }

                }
            }
            //设置分页数据
            int totalResult = list.size();
            if (totalResult <= showCount) {
                page.setTotalPage(1);
            } else {
                int count = Integer.valueOf(totalResult / showCount);
                int mod = totalResult % showCount;
                if (mod > 0) {
                    count = count + 1;
                }
                page.setTotalPage(count);
            }
            page.setTotalResult(totalResult);
            page.setCurrentResult(ContractList.size());
            page.setCurrentPage(currentPage);
            page.setShowCount(showCount);
            page.setEntityOrField(true);
            //如果有多个form,设置第几个,从0开始
            page.setFormNo(1);
            page.setPageStrForActiviti(page.getPageStrForActiviti());
            mv.addObject("page", null);
            //待处理任务的count
            WorkFlow workflow = new WorkFlow();
            List<Task> toHandleListCount = workflow.getTaskService().createTaskQuery().taskCandidateOrAssigned(USER_ID).orderByTaskCreateTime().desc().active().list();
            pd.put("count1", ContractList.size());
            pd.put("isActive3", "1");
            mv.addObject("pd", pd);
            mv.addObject("ContractList", ContractList);
            mv.addObject("userpds", pds);
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }

    /**
     * COD
     *
     * @return
     */
    @RequestMapping(value = "goCODContract")
    public ModelAndView goCODContract() throws Exception {
        SelectByRole sbr = new SelectByRole();
        PageData pd = this.getPageData();
        //将当前登录人添加至列表查询条件
        pd.put("input_user", getUser().getUSER_ID());
        List<String> userList = sbr.findUserList(getUser().getUSER_ID());
        pd.put("userList", userList);
        ModelAndView mv = new ModelAndView();
        Map<String, Integer> qx = new HashMap<String, Integer>();
        qx.put("cha", 1);
        List<Map> cods = new ArrayList<Map>();
        try {
            pd.put("offer_id", pd.get("HT_OFFER_ID"));
            PageData offerDetail = e_offerService.findOfferDetailByOfferId(pd);
            pd.put("offer_version", offerDetail.get("offer_version"));
            List<PageData> CodList = contractNewService.getCODContract(pd);
            try {
                for (int i = 0; i < CodList.size(); i++) {
                    Map<String, Object> cod = new HashMap<String, Object>();
                    cod.put("TX", CodList.get(i).getString("MODELS_NAME"));
                    cod.put("TS", CodList.get(i).getString("BJC_SL"));
                    cod.put("HT_UUID", pd.get("HT_UUID"));
                    cod.put("BJC_COD_ID", CodList.get(i).getString("BJC_COD_ID"));
                    cods.add(cod);
                }
            } catch (Exception e) {
                logger.error(e.getMessage(), e);
            }
        } catch (Exception ee) {
            logger.error(ee.getMessage(), ee);
        }

        mv.addObject("QX", qx);
        mv.addObject("contractNewListCOD", cods);
        mv.setViewName("system/contractNew/contractCOD");
        return mv;
    }

    /**
     * 查看报价信息
     * Stone 17.08.11
     *
     * @param
     * @return
     */
    @RequestMapping("/SeeEoffer")
    public ModelAndView SeeEoffer() {
        ModelAndView mv = this.getModelAndView();
        PageData pd = this.getPageData();
        PageData selBjcPd = new PageData();
        selBjcPd.put("ITEM_ID", pd.get("item_id").toString());
        try {
            //报价信息，以及项目信息
//			pd=contractNewService.findOfferById(pd);
            pd = e_offerService.findOfferDetailByOfferId(pd);
            //List<PageData> bjcList = e_offerService.findBjc(selBjcPd);
            List<PageData> bjcList = e_offerService.bjc_list(pd);
            Page page = new Page();
            page.setPd(pd);
//			所属该项目的电梯信息
//			List<PageData> elevatorList=e_offerService.elevatorlistPage(page);
            List<PageData> elevatorList = e_offerService.TempelevatorlistPage(page);
            mv.addObject("elevatorList", elevatorList);
            mv.addObject("bjcList", bjcList);
            mv.setViewName("system/e_offer/e_offer_check");
            mv.addObject("pd", pd);
            mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
            mv.addObject("msg", "saveS");
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }

    /* ===============================用户查询权限================================== */
    public List<String> getRoleSelect() {
        Subject currentUser = SecurityUtils.getSubject(); // shiro管理的session
        Session session = currentUser.getSession();
        return (List<String>) session.getAttribute(Const.SESSION_ROLE_SELECT);
    }

    public String getRoleType() {
        Subject currentUser = SecurityUtils.getSubject();
        Session session = currentUser.getSession();
        return (String) session.getAttribute(Const.SESSION_ROLE_TYPE);
    }

    /* ===============================权限================================== */
    @SuppressWarnings("unchecked")
    public Map<String, String> getHC() {
        Subject currentUser = SecurityUtils.getSubject(); // shiro管理的session
        Session session = currentUser.getSession();
        return (Map<String, String>) session.getAttribute(Const.SESSION_QX);
    }

    /* ===============================用户================================== */
    public User getUser() {
        Subject currentUser = SecurityUtils.getSubject(); // shiro管理的session
        Session session = currentUser.getSession();
        return (User) session.getAttribute(Const.SESSION_USER);
    }

    /**
     * 导出到Word
     */
    @RequestMapping(value = "toCOD")
    public ModelAndView toCOD() throws Exception {
        SelectByRole sbr = new SelectByRole();
        PageData pd = this.getPageData();
        Map<String, Object> model = new HashMap<>();
        //将当前登录人添加至列表查询条件
        pd.put("input_user", getUser().getUSER_ID());
        int sum = Integer.parseInt((String) pd.get("sum"));
        List<String> userList = sbr.findUserList(getUser().getUSER_ID());
        pd.put("userList", userList);

        ModelAndView mv = null;
        try {
            List<PageData> etList = contractNewService.getElevatorType(pd);
            logger.info(etList.get(0).getString("MODELS_ID"));

            //飞尚有机房
            if (etList.size() > 0 && etList.get(0).getString("ele_type").equals("DT3")) {
                try {
                    List<PageData> codList = contractNewService.printFEISHANG_COD(pd);
                    Integer BJC_SL = Integer.valueOf((String) codList.get(0).get("BJC_SL"));
                    //电梯信息
                    List<PageData> dtxxlist = contractNewService.findDtInfoByHtId(pd);
                    //合同号更换为电梯信息中的合同号
                    StringBuilder sb = new StringBuilder();
                    for (int i = sum; i < BJC_SL + sum; i++) {
                        sb.append(dtxxlist.get(i).get("DT_NO"));
                        if (i != BJC_SL + sum - 1) {
                            sb.append(",");
                        }
                    }
                    codList.get(0).put("BJC_ENO", sb.toString());
                    //通过省份ID获取省份名称
                    List<PageData> list = cityService.findProvinceById(pd);
                    //添加省份信息
                    if (list != null && !list.isEmpty()) {
                        model.put("name", list.get(0).getNoneNULLString("name"));
                    }
                    if (codList.size() > 0) {
                        mv = getCODdata.GetFEI_SHANG(codList);
                    }
                } catch (Exception e) {
                    logger.error(e.getMessage(), e);
                }
            }

            //飞尚无机房
            if (etList.size() > 0 && etList.get(0).getString("ele_type").equals("DT10")) {
                try {
                    List<PageData> codList = contractNewService.printFEISHANG_COD_MRL(pd);
                    Integer BJC_SL = Integer.valueOf((String) codList.get(0).get("BJC_SL"));
                    //电梯信息
                    List<PageData> dtxxlist = contractNewService.findDtInfoByHtId(pd);
                    //合同号更换为电梯信息中的合同号
                    StringBuilder sb = new StringBuilder();
                    for (int i = sum; i < BJC_SL + sum; i++) {
                        sb.append(dtxxlist.get(i).get("DT_NO"));
                        if (i != BJC_SL + sum - 1) {
                            sb.append(",");
                        }
                    }
                    codList.get(0).put("BJC_ENO", sb.toString());
                    //通过省份ID获取省份名称
                    List<PageData> list = cityService.findProvinceById(pd);
                    //添加省份信息
                    if (list != null && !list.isEmpty()) {
                        model.put("name", list.get(0).getNoneNULLString("name"));
                    }
                    if (codList.size() > 0) {
                        mv = getCODdata.GetFEI_SHANG_MRL(codList);
                    }
                } catch (Exception e) {
                    logger.error(e.getMessage(), e);
                }
            }

            //飞弈曳引货梯
            if (etList.size() > 0 && etList.get(0).getString("ele_type").equals("DT9")) {
                try {
                    List<PageData> codList = contractNewService.printSHINY_COD(pd);
                    PageData pd1 = codList.get(0);
                    Integer BJC_SL = Integer.valueOf((String) pd1.get("BJC_SL"));
                    //电梯信息
                    List<PageData> dtxxlist = contractNewService.findDtInfoByHtId(pd);
                    //合同号更换为电梯信息中的合同号
                    StringBuilder sb = new StringBuilder();
                    for (int i = sum; i < BJC_SL + sum; i++) {
                        sb.append(dtxxlist.get(i).get("DT_NO"));
                        if (i != BJC_SL + sum - 1) {
                            sb.append(",");
                        }
                    }
                    pd1.put("BJC_ENO", sb.toString());
                    //通过省份ID获取省份名称
                    List<PageData> list = cityService.findProvinceById(pd);
                    //添加省份信息
                    if (list != null && !list.isEmpty()) {
                        model.put("name", list.get(0).getNoneNULLString("name"));
                    }
                    if (codList.size() > 0) {
                        mv = getCODdata.GetSHINY(codList);
                    }
                } catch (Exception e) {
                    logger.error(e.getMessage(), e);
                }
            }

            //新飞越
            if (etList.size() > 0 && etList.get(0).getString("ele_type").equals("DT7")) {
                try {
                    List<PageData> codList = contractNewService.printFEIYUE_COD(pd);
                    Integer BJC_SL = Integer.valueOf((String) codList.get(0).get("BJC_SL"));
                    //电梯信息
                    List<PageData> dtxxlist = contractNewService.findDtInfoByHtId(pd);
                    //合同号更换为电梯信息中的合同号
                    StringBuilder sb = new StringBuilder();
                    for (int i = sum; i < BJC_SL + sum; i++) {
                        sb.append(dtxxlist.get(i).get("DT_NO"));
                        if (i != BJC_SL + sum - 1) {
                            sb.append(",");
                        }
                    }
                    codList.get(0).put("BJC_ENO", sb.toString());
                    String type = "有机房";
                    //通过省份ID获取省份名称
                    List<PageData> list = cityService.findProvinceById(pd);
                    //添加省份信息
                    if (list != null && !list.isEmpty()) {
                        model.put("name", list.get(0).getNoneNULLString("name"));
                    }
                    if (codList.size() > 0) {
                        mv = getCODdata.GetFEIYUE(codList, type);
                    }
                } catch (Exception e) {
                    logger.error(e.getMessage(), e);
                }
            }


            //新飞越MRL
            if (etList.size() > 0 && etList.get(0).getString("ele_type").equals("DT8")) {
                try {
                    List<PageData> codList = contractNewService.printFeiYueMRL_COD(pd);
                    PageData pd1 = codList.get(0);
                    Integer BJC_SL = Integer.valueOf((String) pd1.get("BJC_SL"));
                    //电梯信息
                    List<PageData> dtxxlist = contractNewService.findDtInfoByHtId(pd);
                    //合同号更换为电梯信息中的合同号
                    StringBuilder sb = new StringBuilder();
                    for (int i = sum; i < BJC_SL + sum; i++) {
                        sb.append(dtxxlist.get(i).get("DT_NO"));
                        if (i != BJC_SL + sum - 1) {
                            sb.append(",");
                        }
                    }
                    pd1.put("BJC_ENO", sb.toString());
                    String type = "无机房";
                    pd1.put("name", pd1.get("NAME"));
                    if (codList.size() > 0) {
                        mv = getCODdata.GetFEIYUE(codList, type);
                    }
                } catch (Exception e) {
                    logger.error(e.getMessage(), e);
                }
            }

            //飞扬3000+mrl
            if (etList.size() > 0 && etList.get(0).getString("ele_type").equals("DT5")) {
                try {
                    List<PageData> codList = contractNewService.printFEIYANG_MRL_COD(pd);
                    PageData pd1 = codList.get(0);
                    Integer BJC_SL = Integer.valueOf((String) pd1.get("BJC_SL"));
                    //电梯信息
                    List<PageData> dtxxlist = contractNewService.findDtInfoByHtId(pd);
                    //合同号更换为电梯信息中的合同号
                    StringBuilder sb = new StringBuilder();
                    for (int i = sum; i < BJC_SL + sum; i++) {
                        sb.append(dtxxlist.get(i).get("DT_NO"));
                        if (i != BJC_SL + sum - 1) {
                            sb.append(",");
                        }
                    }
                    pd1.put("BJC_ENO", sb.toString());
                    //通过省份ID获取省份名称
                    List<PageData> list = cityService.findProvinceById(pd);
                    //添加省份信息
                    if (list != null && !list.isEmpty()) {
                        model.put("name", list.get(0).getNoneNULLString("name"));
                    }
                    if (codList.size() > 0) {
                        mv = getCODdata.GetFEIYANG_MRL(codList);
                    }
                } catch (Exception e) {
                    logger.error(e.getMessage(), e);
                }
            }

//            Ascend2018
            if (etList.size() > 0 && etList.get(0).getString("ele_type").equals("DT4")) {
                try {
                    List<PageData> codList = contractNewService.printFEIYANG_COD(pd);
                    PageData pd1 = codList.get(0);
                    Integer BJC_SL = Integer.valueOf((String) pd1.get("BJC_SL"));
                    //电梯信息
                    List<PageData> dtxxlist = contractNewService.findDtInfoByHtId(pd);
                    //合同号更换为电梯信息中的合同号
                    StringBuilder sb = new StringBuilder();
                    for (int i = sum; i < BJC_SL + sum; i++) {
                        sb.append(dtxxlist.get(i).get("DT_NO"));
                        if (i != BJC_SL + sum - 1) {
                            sb.append(",");
                        }
                    }
                    pd1.put("BJC_ENO", sb.toString());
                    //通过省份ID获取省份名称
                    List<PageData> list = cityService.findProvinceById(pd);
                    //添加省份信息
                    if (list != null && !list.isEmpty()) {
                        model.put("name", list.get(0).getNoneNULLString("name"));
                    }
                    if (codList.size() > 0) {
                        mv = getCODdata.GetFEIYANG(codList);
                    }
                } catch (Exception e) {
                    logger.error(e.getMessage(), e);
                }
            }

            //飞扬消防梯
            if (etList.size() > 0 && etList.get(0).getString("ele_type").equals("DT6")) {
                try {
                    List<PageData> codList = contractNewService.printFEIYANGXF_COD(pd);
                    PageData pd1 = codList.get(0);
                    Integer BJC_SL = Integer.valueOf((String) pd1.get("BJC_SL"));
                    //电梯信息
                    List<PageData> dtxxlist = contractNewService.findDtInfoByHtId(pd);
                    //合同号更换为电梯信息中的合同号
                    StringBuilder sb = new StringBuilder();
                    for (int i = sum; i < BJC_SL + sum; i++) {
                        sb.append(dtxxlist.get(i).get("DT_NO"));
                        if (i != BJC_SL + sum - 1) {
                            sb.append(",");
                        }
                    }
                    pd1.put("BJC_ENO", sb.toString());
                    //通过省份ID获取省份名称
                    List<PageData> list = cityService.findProvinceById(pd);
                    //添加省份信息
                    if (list != null && !list.isEmpty()) {
                        model.put("name", list.get(0).getNoneNULLString("name"));
                    }
                    if (codList.size() > 0) {
                        mv = getCODdata.GetFEIYANGXF(codList);
                    }
                } catch (Exception e) {
                    logger.error(e.getMessage(), e);
                }
            }

            //DNP9300
            if (etList.size() > 0 && etList.get(0).getString("ele_type").equals("DT1")) {
                try {
                    List<PageData> codList = contractNewService.printDNP9300_COD(pd);
                    PageData pd1 = codList.get(0);
                    Integer BJC_SL = Integer.valueOf((String) pd1.get("BJC_SL"));
                    //电梯信息
                    List<PageData> dtxxlist = contractNewService.findDtInfoByHtId(pd);
                    //合同号更换为电梯信息中的合同号
                    StringBuilder sb = new StringBuilder();
                    for (int i = sum; i < BJC_SL + sum; i++) {
                        sb.append(dtxxlist.get(i).get("DT_NO"));
                        if (i != BJC_SL + sum - 1) {
                            sb.append(",");
                        }
                    }
                    pd1.put("BJC_ENO", sb.toString());
                    //通过省份ID获取省份名称
                    List<PageData> list = cityService.findProvinceById(pd);
                    //添加省份信息
                    if (list != null && !list.isEmpty()) {
                        model.put("name", list.get(0).getNoneNULLString("name"));
                    }
                    if (codList.size() > 0) {
                        mv = getCODdata.GetDNP9300(codList);
                    }
                } catch (Exception e) {
                    logger.error(e.getMessage(), e);
                }
            }

            //DNR人行道
            if (etList.size() > 0 && etList.get(0).getString("ele_type").equals("DT2")) {
                try {
                    List<PageData> codList = contractNewService.printDNR_COD(pd);
                    Integer BJC_SL = Integer.valueOf((String) codList.get(0).get("BJC_SL"));
                    //电梯信息
                    List<PageData> dtxxlist = contractNewService.findDtInfoByHtId(pd);
                    //合同号更换为电梯信息中的合同号
                    StringBuilder sb = new StringBuilder();
                    for (int i = sum; i < BJC_SL + sum; i++) {
                        sb.append(dtxxlist.get(i).get("DT_NO"));
                        if (i != BJC_SL + sum - 1) {
                            sb.append(",");
                        }
                    }
                    codList.get(0).put("BJC_ENO", sb.toString());
                    //通过省份ID获取省份名称
                    List<PageData> list = cityService.findProvinceById(pd);
                    //添加省份信息
                    if (list != null && !list.isEmpty()) {
                        model.put("name", list.get(0).getNoneNULLString("name"));
                    }
                    if (codList.size() > 0) {
                        mv = getCODdata.GetDNR(codList);
                    }
                } catch (Exception e) {
                    logger.error(e.getMessage(), e);
                }
            }
        } catch (Exception ee) {
            logger.error(ee.getMessage(), ee);
        }

        return mv;
    }

    /**
     * 输出设备合同
     */
    @RequestMapping(value = "toContractDevice")
    public ModelAndView toContractDevice(Page page) throws Exception {
        SelectByRole sbr = new SelectByRole();
        PageData pd = this.getPageData();
        //将当前登录人添加至列表查询条件
        pd.put("input_user", getUser().getUSER_ID());
        List<String> userList = sbr.findUserList(getUser().getUSER_ID());
        pd.put("userList", userList);
//        page.setPd(pd);
        String item_id = pd.getString("item_id");
        PageData kehu = new PageData();// 存放客户信息的 pd
        PageData pdelev = new PageData(); // 电梯信息pd
        List<PageData> listelev = new ArrayList<>();
        List<PageData> listfkfs = new ArrayList<>();//付款方式
        Map<String, Object> map = new HashMap<String, Object>();
        ModelAndView mv = null;
        try {
//	        	try{
//	        		List<PageData> CDList = contractNewService.printContractDevice(pd);
//	        		if(CDList.size() > 0) {
//	        			mv = getContractData.GetContractDevice(CDList);
//	        		}
//	        }catch(Exception e){
//	        		logger.error(e.getMessage(),e);
//	        }
            pd = contractService.findSoContractById(pd);// 根据设备合同编号查询设备合同信息和项目信息
            PageData org = itemService.findOrderOrg(pd);
            if (org != null) {
                pd.put("selorder_org", org.get("customer_name"));
            }
            
            ModelAndView jffbht = getFirstPartyHtfj(pd.getString("HT_FJSC_JSON"));
            if(jffbht != null) {
            	return jffbht;
            }
            PageData pdItem = new PageData();
            pdItem = contractService.findByoffer_Id(new PageData("offer_id", pd.get("HT_OFFER_ID")));
            String type = pdItem.getString("customer_type"); // 客户类型
            String kehu_id = pdItem.getString("customer_id"); // 客户编号
            kehu.put("kehu_id", kehu_id); // 给pd客户的编号
            if (type.equals("Ordinary")) {
                kehu = contractService.findByOrdinary(kehu);
            } else if (type.equals("Merchant")) {
                kehu = contractService.findByMerchant(kehu);
            } else if (type.equals("Core")) {
                kehu = contractService.findByCore(kehu);
            }
            // 电梯信息
            pdelev.put("item_id", item_id);// 添加项目id
            pdelev.put("HT_UUID", pd.get("HT_UUID"));
            //listelev = contractService.findByElev(pdelev);  //重写
            listelev = contractService.findByElevl(pdelev);
            listfkfs = contractService.findByFkfs(pdelev);

            mv = getContractData.GetContractDevice(pd, kehu, listelev, listfkfs);
        } catch (Exception ee) {
            logger.error(ee.getMessage(), ee);
        }

        return mv;
    }

    private ModelAndView getFirstPartyHtfj(String htfjscjson) {
    	ModelAndView mv = null;
    	if(StringUtils.isNoneBlank(htfjscjson)) {
    		try {
				JSONArray htfjscjsonArray = JSONArray.fromObject(htfjscjson);
				for (int i = 0; i < htfjscjsonArray.size(); i++) {
				    JSONObject jsonObj = htfjscjsonArray.getJSONObject(i);
				    if("4".equals(jsonObj.getString("HT_WJLX"))//甲方合同
				    		|| "2".equals(jsonObj.getString("HT_WJLX"))) { //非标合同
					    String filename = jsonObj.getString("FILENAME");
					    String filepath = jsonObj.getString("HT_FJSC");
					    int suffix = filepath.lastIndexOf(".");
					    if(suffix != -1 && ".docx".equals(filepath.substring(suffix).toLowerCase())) {
				    		return new ModelAndView(new WordViewNew(filename,  PathUtil.getClasspath()
					                + Const.FILEPATHFILE + filepath), null);
					    } else {
					    	
					    }
				    }
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
    	}
        
    	return mv;
    }
    
    /**
     * 输出价格表
     */
    @RequestMapping(value = "toPriceList")
    public ModelAndView toPriceList() throws Exception {
        SelectByRole sbr = new SelectByRole();
        PageData pd = this.getPageData();
        //将当前登录人添加至列表查询条件
        pd.put("input_user", getUser().getUSER_ID());
        List<String> userList = sbr.findUserList(getUser().getUSER_ID());
        pd.put("userList", userList);
//        page.setPd(pd);
        ModelAndView mv = null;
//        logger.info(page);
        try {
            try {
                List<PageData> CDList = contractNewService.printPriceList(pd);
                if (CDList.size() > 0) {
                    mv = getContractData.toPriceList(CDList);
                }
            } catch (Exception e) {
                logger.error(e.getMessage(), e);
            }
        } catch (Exception ee) {
            logger.error(ee.getMessage(), ee);
        }

        return mv;
    }

    /**
     * 导出到Excel
     */
    @RequestMapping(value = "toExcel")
    public ModelAndView toExcel() {
        ModelAndView mv = new ModelAndView();
        try {
            Map<String, Object> dataMap = new HashMap<String, Object>();
            List<String> titles = new ArrayList<String>();
            titles.add("合同编号");
            titles.add("项目名称");
            titles.add("报价编号");
            titles.add("报价版本");
            titles.add("客户名称");
            titles.add("最终用户");
            titles.add("客户编号");
            titles.add("业务员");
            titles.add("电梯台数");
            titles.add("报价总额");
            titles.add("合同总价格");
            titles.add("状态");
            titles.add("安装地址");
            titles.add("合同签订日期");
            titles.add("免保期限(年)");
            titles.add("交货方式");
            titles.add("联系人");
            titles.add("联系电话");
            titles.add("合同类型");
            titles.add("预计发货日期");
            titles.add("预计开工日期");
            titles.add("预计施工周期(天)");
            titles.add("预计供货周期(天)");
            titles.add("交货日期");
            titles.add("预计验收日期");
            titles.add("预计质保金收款日期");
            titles.add("预计信用证收款日期");
            titles.add("买断");
            titles.add("毛利润");
            titles.add("备注");
            titles.add("录入人");
            titles.add("录入时间");

            dataMap.put("titles", titles);

            PageData pd = this.getPageData();
            //将当前登录人添加至列表查询条件
            pd.put("input_user", getUser().getUSER_ID());
            List<String> userList = new SelectByRole().findUserList(getUser().getUSER_ID());
            pd.put("userList", userList);
            /*List<PageData> itemList = itemService.findItemList();*/
            List<PageData> contractNewList = contractNewService.findContractNewExcel(pd);
            List<PageData> varList = new ArrayList<PageData>();
            for (int i = 0; i < contractNewList.size(); i++) {
                PageData contractNew = contractNewList.get(i);
                PageData vpd = new PageData();
                vpd.put("var1", contractNew.getString("HT_NO"));
                vpd.put("var2", contractNew.getString("item_name"));
                vpd.put("var3", contractNew.getString("offer_no"));
                vpd.put("var4", contractNew.getString("offer_version"));
                vpd.put("var5", contractNew.getString("customer_namex"));
                vpd.put("var6", contractNew.getString("end_name"));
                vpd.put("var7", contractNew.getString("customer_no"));
                vpd.put("var8", contractNew.getString("USER_NAME"));
                vpd.put("var9", contractNew.getString("DT_NUM"));
                vpd.put("var10", contractNew.getString("TOTAL"));
                vpd.put("var11", contractNew.getString("PRICE"));
                String ACTSTATUS = contractNew.getString("ACT_STATUS");
                if ("1".equals(ACTSTATUS)) {
                    vpd.put("var12", "新建");
                } else if ("2".equals(ACTSTATUS)) {
                    vpd.put("var12", "待审核");
                } else if ("3".equals(ACTSTATUS)) {
                    vpd.put("var12", "审核中");
                } else if ("4".equals(ACTSTATUS)) {
                    vpd.put("var12", "已通过");
                } else if ("5".equals(ACTSTATUS)) {
                    vpd.put("var12", "不通过");
                } else {
                    vpd.put("var12", "");
                }
                vpd.put("var13", contractNew.getString("item_install_address_excel"));
                vpd.put("var14", contractNew.getString("HT_QDRQ"));
                vpd.put("var15", StringUtils.isBlank(contractNew.getString("HT_MBQX")) ? "1" : contractNew.getString("HT_MBQX"));
                String HTJHFS = contractNew.getString("HT_JHFS");
                if ("1".equals(HTJHFS) || StringUtils.isBlank(HTJHFS)) {
                    vpd.put("var16", "乙方代办运输");
                } else if ("2".equals(HTJHFS)) {
                    vpd.put("var16", "甲方自提");
                } else {
                    vpd.put("var16", "");
                }
                vpd.put("var17", contractNew.getString("HT_LXR"));
                vpd.put("var18", contractNew.getString("HT_LXDH"));
                String HTTYPE = contractNew.getString("HT_TYPE");
                if ("1".equals(HTTYPE)) {
                    vpd.put("var19", "设备安装分开");
                } else if ("2".equals(HTTYPE)) {
                    vpd.put("var19", "一体式");
                } else {
                    vpd.put("var19", "");
                }
                vpd.put("var20", contractNew.getString("HT_YJFHRQ"));
                vpd.put("var21", contractNew.getString("HT_YJKGRQ"));
                vpd.put("var22", contractNew.getString("HT_YJSGZQ"));
                vpd.put("var23", contractNew.getString("HT_YJGHZQ"));
                vpd.put("var24", contractNew.getString("HT_JHRQ"));
                vpd.put("var25", contractNew.getString("HT_YJYSRQ"));
                vpd.put("var26", contractNew.getString("HT_YJZBJRQ"));
                vpd.put("var27", contractNew.getString("HT_YJXYZRQ"));
                vpd.put("var28", "1".equals(contractNew.getString("HT_SFMD_TEXT")) ? "是" : "否");
                vpd.put("var29", contractNew.getString("HT_MLR"));
                vpd.put("var30", contractNew.getString("HT_BZ"));
                vpd.put("var31", contractNew.getString("USER_NAME"));
                vpd.put("var32", contractNew.getString("INPUT_TIME"));

                varList.add(vpd);
            }
            dataMap.put("varList", varList);
            ObjectExcelView erv = new ObjectExcelView();
            mv = new ModelAndView(erv, dataMap);
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
        }
        return mv;
    }

    /**
     * 是否存在电梯合同号
     */
    @RequestMapping(value = "isExistDTHTH")
    @ResponseBody
    public Object isExistDTHTH(String DT_NO) {
        try {
            boolean existDTHTH = contractNewService.isExistDTHTH(DT_NO);
            return existDTHTH;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    /**
     * 页面:设备合同管理
     * 合同信息列表
     */
    @RequestMapping("/contractNewUpload")
    public ModelAndView contractNewUpload(Page page) throws Exception{
    	ModelAndView mv = this.getModelAndView();
        SelectByRole sbr = new SelectByRole();
        PageData pd = this.getPageData();
        try {
            //将当前登录人添加至列表查询条件
            pd.put("input_user", getUser().getUSER_ID());
            List<String> userList = sbr.findUserList(getUser().getUSER_ID());
            pd.put("userList", userList);
            pd.put("ACT_STATUS", "4");
            page.setPd(pd);
            List<PageData> contractNewList = contractNewService.SoContractlistPage(page);

            //跳转位置
            mv.addObject("pd", pd);
            mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
            mv.addObject("contractNewList", contractNewList);
            mv.setViewName("system/contractNew/contractNewDeviceupload");
        } catch (Exception e) {
            // TODO: handle exception
        }
        return mv;
    }
    
    
    @RequestMapping("saveOfHThtfj")
    @ResponseBody
    public Map<String, Object> saveOfHThtfj(){
    	Map<String, Object> resultMap = new HashMap<String, Object>();
        PageData pd = this.getPageData();
        
        String fj = pd.getString("hthtfj");
        if(StringUtils.isNoneBlank(fj)) {
        	
        	try {
        		PageData fjPd = new PageData();
        		fjPd.put("HT_UUID", pd.getString("HT_UUID"));
        		fjPd.put("CONTRACT_ATTA_JSON", fj);
				contractNewService.updateHThtfj(fjPd);
				
				
			} catch (Exception e) {
				e.printStackTrace();
			}
        	
        }
        
        
        resultMap.put("code", "1");
    	
    	return resultMap;
    }
    
    /**
     * 判断当前用户角色毛利润可见
     * 
     * @return
     */
    private boolean isQxViableMLR() {
    	List<Dict> dictList = DictUtils.getDictList("lookqx_mlr");
    	String roleId = getUser().getROLE_ID();
    	//StringBuffer where = new StringBuffer();
    	StringBuffer inwhere = new StringBuffer();
    	PageData wherePd = new PageData();
    	List<PageData> zwherePd = new ArrayList<PageData>();
    	for (Dict dict : dictList) {
    		String roleName = dict.getName();
    		String judge = dict.getValue();
    		if("like".equals(judge)) {
    			PageData w = new PageData();
    			w.put("whereType", "like");
    			w.put("whereValue", roleName);
    			zwherePd.add(w);
    		} else if("=".equals(judge)) {
    			if(inwhere.length() != 0) {
    				inwhere.append(",");
    			}
    			inwhere.append(roleName);
    		}
		}
    	if(inwhere.length() != 0) {
    		PageData w = new PageData();
			w.put("whereType", "in");
			w.put("whereValue", inwhere.toString());
			zwherePd.add(w);
    	}
    	if(zwherePd.size() == 0) {
    		return true;
    	}
    	wherePd.put("childrenWhere", zwherePd);
    	wherePd.put("role_id", roleId);
    	try {
			List<PageData> roleOfRoleIds = contractNewService.findRoleOfwherePd(wherePd);
			if(roleOfRoleIds != null && roleOfRoleIds.size() > 0) {
				return true;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
    	
    	return false;
    }
    
    @RequestMapping(value="getOrderOrg")
	@ResponseBody
	public Map<String, Object> getOrderOrg(){
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = new PageData();
		List<PageData> orderOrgList = new ArrayList<PageData>();
		try{
			pd = this.getPageData();
			String saleType = pd.get("sale_type").toString();
			if(saleType.equals("1")){
				orderOrgList = sysAgentService.findAgentIdAndNameList();
			}else if(saleType.equals("2")||saleType.equals("3")){
				orderOrgList = customerService.findCustomerIdAndNameList();
			}
			map.put("orderOrgs", orderOrgList);
			map.put("msg", "success");
		}catch(Exception e){
			map.put("msg", "faild");
			logger.error(e.getMessage(), e);
		}
		return map;
	}


}