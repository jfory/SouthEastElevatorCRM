package com.dncrm.controller.system.menu;

import com.dncrm.controller.base.BaseController;
import com.dncrm.entity.system.Menu;
import com.dncrm.service.system.menu.MenuService;
import com.dncrm.util.PageData;
import net.sf.json.JSONArray;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.List;

/**
 * 类名称：MenuController
 * 创建人：Simon
 * 创建时间：2014年7月1日
 */
@Controller
@RequestMapping(value = "/menu")
public class MenuController extends BaseController {

    @Resource(name = "menuService")
    private MenuService menuService;

    /**
     * 显示菜单列表
     *
     * @param model
     * @return
     */
    @RequestMapping
    public ModelAndView list() throws Exception {
        ModelAndView mv = this.getModelAndView();
        try {
            List<Menu> menuList = menuService.listAllParentMenu();
            mv.addObject("menuList", menuList);
            mv.setViewName("system/menu/menu_list");
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }

        return mv;
    }

    /**
     * 请求新增菜单页面
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "/toAdd")
    public ModelAndView toAdd() throws Exception {
        ModelAndView mv = this.getModelAndView();
        try {
            List<Menu> menuList = menuService.listAllParentMenu();
            mv.addObject("menuList", menuList);
            mv.setViewName("system/menu/menu_add");
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }

    /**
     * 保存菜单信息
     *
     * @param menu
     * @param model
     * @return
     */
    @RequestMapping(value = "/add")
    public ModelAndView add(Menu menu) throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        try {
            menu.setMENU_ID(String.valueOf(Integer.parseInt(menuService.findMaxId(pd).get("MID").toString()) + 1));


            String PARENT_ID = menu.getPARENT_ID();
            if (!"0".equals(PARENT_ID)) {
                //处理菜单类型====
                pd.put("MENU_ID", PARENT_ID);
                pd = menuService.getMenuById(pd);
                menu.setMENU_TYPE(pd.getString("MENU_TYPE"));
                //处理菜单类型====
            }
            menuService.saveMenu(menu);
            mv.addObject("msg", "success");
        } catch (Exception e) {
            logger.error(e.toString(), e);
            mv.addObject("msg", "failed");
        }

        mv.setViewName("save_result");
        return mv;

    }

    /**
     * 请求编辑菜单页面
     *
     * @param
     * @return
     */
    @RequestMapping(value = "/toEdit")
    public ModelAndView toEdit(String MENU_ID) throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        try {
            pd = this.getPageData();
            pd.put("MENU_ID", MENU_ID);
            pd = menuService.getMenuById(pd);
            List<Menu> menuList = menuService.listAllParentMenu();
            mv.addObject("menuList", menuList);
            mv.addObject("pd", pd);
            mv.setViewName("system/menu/menu_edit");
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }

    /**
     * 请求编辑菜单图标页面
     *
     * @param
     * @return
     */
    @RequestMapping(value = "/toEditicon")
    public ModelAndView toEditicon(String MENU_ID) throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        try {
            pd = this.getPageData();
            pd.put("MENU_ID", MENU_ID);
            mv.addObject("pd", pd);
            mv.setViewName("system/menu/menu_icon");
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }

    /**
     * 保存菜单图标 (顶部菜单)
     *
     * @param
     * @return
     */
    @RequestMapping(value = "/editicon")
    public ModelAndView editicon() throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        try {
            pd = this.getPageData();
            pd = menuService.editicon(pd);
            mv.addObject("msg", "success");
        } catch (Exception e) {
            logger.error(e.toString(), e);
            mv.addObject("msg", "failed");
        }
        mv.setViewName("save_result");
        return mv;
    }

    /**
     * 保存编辑
     *
     * @param
     * @return
     */
    @RequestMapping(value = "/edit")
    public ModelAndView edit() throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        try {
            pd = this.getPageData();

            String PARENT_ID = pd.getString("PARENT_ID");
            if (null == PARENT_ID || "".equals(PARENT_ID)) {
                PARENT_ID = "0";
                pd.put("PARENT_ID", PARENT_ID);
            }

            if ("0".equals(PARENT_ID)) {
                //处理菜单类型====
                menuService.editType(pd);
                //处理菜单类型====
            }

            pd = menuService.edit(pd);
            mv.addObject("msg", "success");
        } catch (Exception e) {
            logger.error(e.toString(), e);
            mv.addObject("msg", "failed");
        }
        mv.setViewName("save_result");
        return mv;
    }

    /**
     * 获取当前菜单的所有子菜单
     *
     * @param menuId
     * @param response
     */
    @RequestMapping(value = "/sub")
    public void getSub(@RequestParam String MENU_ID, HttpServletResponse response) throws Exception {
        try {
            List<Menu> subMenu = menuService.listSubMenuByParentId(MENU_ID);
            JSONArray arr = JSONArray.fromObject(subMenu);
            PrintWriter out;

            response.setCharacterEncoding("utf-8");
            out = response.getWriter();
            String json = arr.toString();
            out.write(json);
            out.flush();
            out.close();
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
    }

    /**
     * 删除菜单
     *
     * @param menuId
     * @param out
     */
    @RequestMapping(value = "/del")
    public void delete(@RequestParam String MENU_ID, PrintWriter out) throws Exception {

        try {
            menuService.deleteMenuById(MENU_ID);
            out.write("success");
            out.flush();
            out.close();
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }

    }
}
