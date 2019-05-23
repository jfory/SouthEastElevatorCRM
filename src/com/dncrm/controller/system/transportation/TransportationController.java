package com.dncrm.controller.system.transportation;

import com.dncrm.controller.base.BaseController;
import com.dncrm.entity.Page;
import com.dncrm.service.system.transportation.TransportationService;
import com.dncrm.util.*;
import net.sf.json.JSONObject;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by LGD on 2018/04/18.
 * 运输价格报价Controller
 */
@Controller
@RequestMapping("/transportation")
public class TransportationController extends BaseController {

    @Resource(name="transportationService")
    TransportationService transportationService;

    @RequestMapping("/transportationList")
    public ModelAndView transportationList(Page page){
        ModelAndView mv = this.getModelAndView();
        PageData pd = this.getPageData();
        //shiro管理的session
        Subject currentUser = SecurityUtils.getSubject();
        Session session = currentUser.getSession();
        PageData pds = new PageData();
        pds = (PageData) session.getAttribute("userpds");
        String USER_ID = pds.getString("USER_ID");
        try {
            page.setPd(pd);
            List<PageData> nonList = transportationService.listPageTransportation(page);
            mv.setViewName("system/transportation/transportationList");
            mv.addObject("nonstandradList", nonList);
            mv.addObject("pd", pd);
            mv.addObject("page", page);
            mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }

    /**
     *导入Excel到数据库
     */
    @RequestMapping(value="importExcel")
    @ResponseBody
    public Object importExcel(@RequestParam(value = "file") MultipartFile file){
        Map<String, Object> map = new HashMap<String, Object>();
        //获取系统时间
        String df= DateUtil.getTime().toString();
        try{
            if(file!=null && !file.isEmpty()){
                String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE; // 文件上传路径
                String fileName = FileUpload.fileUp(file, filePath, "userexcel"); // 执行上传
                List<PageData> listPd = (List) ObjectExcelRead.readExcel(filePath,fileName, 1, 0, 0);

                map=transportationService.importFileData(listPd);
            }else{
                map.put("msg", "exception");
                map.put("errorMsg", "上传失败");
            }
        }catch(Exception e){
            logger.error(e.getMessage(), e);
            map.put("msg", "exception");
            map.put("errorUpload", "系统错误，请稍后重试！");
        }
        return JSONObject.fromObject(map);
    }

    /**
     * 删除运输价格
     * @return
     */
    @RequestMapping("/delTransportation")
    @ResponseBody
    public Object delTransportation(){
        PageData pd=this.getPageData();
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            String[] ids={};
            if(pd.get("ids")!=null){
                ids=pd.getString("ids").split(",");
            }
            List<String> idslist= Arrays.asList(ids);

            pd.put("ids",idslist);


           transportationService.deleteTransportation(pd);


            map.put("msg", "success");
        }catch (Exception e){
            e.printStackTrace();

            map.put("msg", "failed");
        }

        return JSONObject.fromObject(map);
    }

    @RequestMapping("/preTransportation")
    public ModelAndView preTransportation(){
        ModelAndView mv=new ModelAndView();
        PageData pd=this.getPageData();
        try {
            pd=transportationService.findTransportationById(pd);
            mv.addObject("pd",pd);
            mv.addObject("msg","save");
        }catch (Exception e){
            e.printStackTrace();
        }
        mv.setViewName("system/transportation/transportation_edit");
        return mv;
    }

    @RequestMapping("/save")
    public ModelAndView save(){
        ModelAndView mv=new ModelAndView();
        PageData pd=this.getPageData();

        try {
            transportationService.updateTransportation(pd);
        }catch (Exception e){
            e.printStackTrace();
        }

        mv.addObject("msg","success");
        mv.addObject("id", "EditShops");
        mv.addObject("form", "shopForm");
        mv.setViewName("save_result");
        return mv;
    }

    /* ===============================权限================================== */
    @SuppressWarnings("unchecked")
    public Map<String, String> getHC() {
        Subject currentUser = SecurityUtils.getSubject(); // shiro管理的session
        Session session = currentUser.getSession();
        return (Map<String, String>) session.getAttribute(Const.SESSION_QX);
    }
}
