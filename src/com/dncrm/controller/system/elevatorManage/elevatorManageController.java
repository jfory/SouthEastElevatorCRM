package com.dncrm.controller.system.elevatorManage;

import com.dncrm.controller.base.BaseController;
import com.dncrm.service.system.elevatorManage.ElevatorManageService;
import com.dncrm.util.Const;
import com.dncrm.util.PageData;
import com.dncrm.util.tree.ConvertPageDataToList;
import com.dncrm.util.tree.MultipleTree;
import com.dncrm.util.tree.Node;
import net.sf.json.JSONObject;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.*;

@Controller
@RequestMapping(value = "/elevatorManage")
public class elevatorManageController extends BaseController {

    //保存所有子节点
    private List<PageData> childModels = new ArrayList<PageData>();

    @Autowired
    private ElevatorManageService elevatorManageService;

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

    /**
     * 显示梯种列表
     *
     * @return
     */
    @RequestMapping("/listModels")
    public ModelAndView listPositions() {
        ModelAndView mv = this.getModelAndView();
        try {
            mv.setViewName("system/modelsManage/modelsManage");
            mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
            List<PageData> models = elevatorManageService.listAllModels();
            if (models.size() > 0) {
                //构建多叉数
                MultipleTree tree = new MultipleTree();
                List<HashMap<String, String>> dataList = ConvertPageDataToList.make(models);
                Node node = tree.makeTreeWithOderNo(dataList, 1);
                mv.addObject("models", node);
            } else {
                mv.addObject("models", models);
            }
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }

    /**
     * 跳到新增页面
     *
     * @return
     */
    @RequestMapping("/goAddModel")
    public ModelAndView goAddModel() {
        ModelAndView mv = this.getModelAndView();
        try {
            mv.setViewName("system/modelsManage/modelsEdit");
            mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
            List<PageData> models = elevatorManageService.listAllModels();
            mv.addObject("msg", "addModel");
            mv.addObject("operateType", "add");
            if (models.size() > 0) {
                //构建多叉数
                MultipleTree tree = new MultipleTree();
                List<HashMap<String, String>> dataList = ConvertPageDataToList.make(models);
                Node node = tree.makeTreeWithOderNo(dataList, 1);
                mv.addObject("models", node);
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
    @RequestMapping("/goEditModel")
    public ModelAndView goEditModel() {
        ModelAndView mv = new ModelAndView();
        List<String> ids = new ArrayList<>();
        PageData pd = this.getPageData();
        mv.setViewName("system/modelsManage/modelsEdit");
        mv.addObject("msg", "editModel");
        try {
            //获取当前选中对象
            pd = elevatorManageService.getModelsById(pd).get(0);
            //获取当前选中对象的所有子级对象
            List<PageData> childPds = getAllModels(pd);
            for (PageData childPd : childPds) {
                ids.add(childPd.getString("id"));
            }
            //排除当前对象
            ids.add((String) pd.get("models_id"));
            //初始化全局变量
            this.childModels = new ArrayList<PageData>();
            //获取当前选中对象的父级对象
            PageData parentPd = elevatorManageService.findParentModels(pd);
            if (parentPd != null) {
                pd.put("parent_id", (String) parentPd.get("models_id"));
                pd.put("parent_name", (String) parentPd.get("models_name"));
            } else {
                pd.put("parent_id", "0");
                pd.put("parent_name", "");
            }
            //获取除开该对象的所有其他对象
            List<PageData> otherModels = elevatorManageService
                    .findOtherModels(ids);
            if (otherModels.size() > 0) {
                //构建多叉数
                MultipleTree tree = new MultipleTree();
                List<HashMap<String, String>> dataList = ConvertPageDataToList
                        .make(otherModels);
                Node node = tree.makeTreeWithOderNo(dataList, 1);
                mv.addObject("models", node);
            }
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        mv.addObject("operateType", "edit");
        mv.addObject("pd", pd);
        return mv;
    }

    /**
     * 保存新增
     *
     * @return
     */
    @RequestMapping("/addModel")
    public ModelAndView addModel() {
        ModelAndView mv = new ModelAndView();
        PageData pd = this.getPageData();
        try {
            PageData pageData = elevatorManageService.findParentModels(pd);
            if (pageData != null) {
                pd.put("level", String.valueOf(Integer
                        .valueOf((String) pageData.get("level")) + 1));
            }
            pd.put("id", this.get32UUID());
            elevatorManageService.insertModel(pd);
            mv.addObject("msg", "success");
        } catch (Exception e) {
            logger.error(e.toString(), e);
            mv.addObject("msg", "error");
        }
        mv.addObject("pd", pd);
        mv.addObject("form", "modelForm");
        mv.addObject("id", "editModel");
        mv.setViewName("save_result");
        return mv;
    }

    /**
     * 保存编辑
     *
     * @return
     */
    @RequestMapping("/editModel")
    public ModelAndView editModel() {
        ModelAndView mv = new ModelAndView();
        PageData pd = this.getPageData();
        try {
            PageData pageData = elevatorManageService.findParentModels(pd);
            if (pageData != null) {
                pd.put("level", String.valueOf(Integer
                        .valueOf((String) pageData.get("level")) + 1));
            }
            elevatorManageService.updateParentModel(pd);
            mv.addObject("msg", "success");
        } catch (Exception e) {
            logger.error(e.toString(), e);
            mv.addObject("msg", "error");
        }
        mv.addObject("pd", pd);
        mv.addObject("form", "modelForm");
        mv.addObject("id", "editModel");
        mv.setViewName("save_result");
        return mv;
    }


    /**
     * 递归获取所有子节点
     */
    public List<PageData> getAllModels(PageData pd) throws Exception {
        List<PageData> pdList = elevatorManageService.findAllChildModels(pd);
        if (pdList.size() > 0) {
            for (PageData childPd : pdList) {
                childModels.add(childPd);
                getAllModels(childPd);
            }
        }
        return childModels;
    }

    /**
     * 删除一条数据
     */
    @RequestMapping("/delModel")
    @ResponseBody
    public Object delModel() {
        PageData pd = this.getPageData();
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            List<PageData> childModels = elevatorManageService.findAllChildModels(pd);
            int modelsCount = childModels == null ? 0 : childModels.size();
            if (modelsCount <= 0) {
                elevatorManageService.delModel(pd);
                map.put("msg", "success");
            } else {
                map.put("msg", "failed");
                map.put("err", "删除失败,有子级部门或职位不可删除");
            }
        } catch (Exception e) {
            map.put("msg", "error");
            map.put("err", "系统错误");
        }
        return JSONObject.fromObject(map);
    }
}
