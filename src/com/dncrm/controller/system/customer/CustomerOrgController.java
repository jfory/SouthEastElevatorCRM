package com.dncrm.controller.system.customer;

import com.dncrm.controller.base.BaseController;
import com.dncrm.entity.Page;
import com.dncrm.service.system.customer.CustomerService;
import com.dncrm.service.system.department.DepartmentService;
import com.dncrm.service.system.position.PositionService;
import com.dncrm.util.Const;
import com.dncrm.util.PageData;
import com.dncrm.util.tree.ConvertPageDataToList;
import com.dncrm.util.tree.MultipleTree;
import com.dncrm.util.tree.Node;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;

import java.util.*;

@RequestMapping("/customerOrg")
@Controller
public class CustomerOrgController extends BaseController {
	@Resource(name="customerService")
	private CustomerService customerService;

    /**
     * 显示组织列表
     *
     * @return
     */
    @RequestMapping("/listCustomerOrg")
    public ModelAndView listCustomerOrG() {
        ModelAndView mv = this.getModelAndView();
        try {
        	mv.setViewName("system/customer/customer_org_list");
            mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
            List<PageData> companys = customerService.findAllCustomerCompany();
            if (companys.size() > 0) {
                JSONArray companysObject = JSONArray.fromObject(companys);
                mv.addObject("companys", companysObject);
            }else{
                mv.addObject("companys", "\"\"");
            }
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }
    
    
    /**
     * 跳到编辑页面
     *
     * @return
     */
    @RequestMapping("/goEditCustomerOrg")
    public ModelAndView goEditCustomerOrg() {
        ModelAndView mv = new ModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        try {
	        pd = customerService.findCustomerCompanyById(pd);
            PageData parentPd = customerService.findCompanyParent(pd);
            if(parentPd!=null){
	            pd.put("pId", parentPd.get("id").toString());
	            pd.put("pName", parentPd.get("name").toString());
	         }else{
	        	 mv.addObject("isParent", "true");
	         }
	        mv.setViewName("system/customer/customer_org_edit");
	        mv.addObject("msg", "editCustomerOrg");
	        
        	List<PageData> companys = customerService.findCustomerCompanys(pd);
            if (companys.size() > 0) {
                JSONArray companysObject = JSONArray.fromObject(companys);
                mv.addObject("companys", companysObject);
            }else{
                mv.addObject("companys", "\"\"");
            }
        }catch (Exception e){
            logger.error(e.toString(), e);
        }
        mv.addObject("pd", pd);
        mv.addObject("operateType","edit");
        return mv;
    }
    
    /**
     * 跳到新增页面
     *
     * @return
     */
    @RequestMapping("/goAddCustomerOrg")
    public ModelAndView goAddCustomerOrg() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("system/customer/customer_org_edit");
        mv.addObject("msg", "addCustomerOrg");
        try {
        	List<PageData> companys = customerService.findAllCustomerCompany();
            if (companys.size() > 0) {
                JSONArray companysObject = JSONArray.fromObject(companys);
                mv.addObject("companys", companysObject);
            }else{
                mv.addObject("companys", "\"\"");
                mv.addObject("isEmpty", "empty");
            }
        }catch (Exception e){
            logger.error(e.toString(), e);
        }
        mv.addObject("operateType","add");
        return mv;
    }
    
    /**
     * 保存新增
     *
     * @return
     */
    @RequestMapping("/addCustomerOrg")
    public ModelAndView addCustomerOrg() {
        ModelAndView mv = new ModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        pd.put("pId", (String)pd.get("add_pId"));
        try {
        	customerService.insertCustomerCompany(pd);
            mv.addObject("msg","success");
        }catch (Exception e){
            logger.error(e.toString(), e);
            mv.addObject("msg","error");
        }
        mv.addObject("id", "editCustomerOrg");
        mv.addObject("form", "customerOrgForm");
        mv.setViewName("save_result");
        return mv;
    }
    
    
    
    /**
     * 保存编辑
     *
     * @return
     */
    @RequestMapping("/editCustomerOrg")
    public ModelAndView editCustomerOrg() {
        ModelAndView mv = new ModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        try {
        	customerService.updateCustomerCompany(pd);
            mv.addObject("msg","success");
        }catch (Exception e){
            logger.error(e.toString(), e);
            mv.addObject("msg","error");
        }
        mv.addObject("pd", pd);
        mv.addObject("id", "editCustomerOrg");
        mv.addObject("form", "customerOrgForm");
        mv.setViewName("save_result");
        mv.setViewName("save_result");
        return mv;
    }
    
    /**
     * 执行删除
     *
     * @return
     */
    @RequestMapping("/delCustomerOrg")
    @ResponseBody
    public Object delCustomerOrg() {
        Map<String,Object> map = new HashMap<String,Object>();
        ModelAndView mv = new ModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        try {
        	customerService.deleteCustomerCompany(pd);
            map.put("msg","success");
        }catch (Exception e){
            logger.error(e.toString(), e);
            map.put("msg","error");
            map.put("err","删除失败");
        }
        return JSONObject.fromObject(map);
    }
    
    
    /**
     * 获取权限
     *
     * @return
     */
    /* ===============================权限================================== */
    public Map<String, String> getHC() {
        Subject currentUser = SecurityUtils.getSubject(); // shiro管理的session
        Session session = currentUser.getSession();
        return (Map<String, String>) session.getAttribute(Const.SESSION_QX);
    }
    /* ===============================权限================================== */
}
