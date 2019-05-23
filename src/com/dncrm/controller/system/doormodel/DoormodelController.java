package com.dncrm.controller.system.doormodel;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dncrm.controller.base.BaseController;
import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.service.system.doormodel.DoormodelService;
import com.dncrm.util.Const;
import com.dncrm.util.PageData;

import net.sf.json.JSONObject;

@RequestMapping("/doormodel")
@Controller
public class DoormodelController extends BaseController
{
	@Resource(name = "doormodelService")
	private DoormodelService doormodelService;

	// test
	@SuppressWarnings("unused")
	private DaoSupport dao;
	
	/**
	 * 显示户型类型信息
	 *
	 * @return
	 */
	@RequestMapping("/doormodel")
	public ModelAndView listDoorModel(Page page) {
		ModelAndView mv = this.getModelAndView();
		try {
			PageData pd = this.getPageData();
			page.setPd(pd);
			List<PageData> doormodelList = doormodelService.doormodellistPage(page);
			mv.setViewName("system/doormodel/doormodel");
			mv.addObject("doormodelList", doormodelList);
			mv.addObject("pd", pd);
			mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}

		return mv;
	}

	
	/**
	 * 跳到添加页面
	 * @return
	 */

	@RequestMapping("/goAddS")
	public ModelAndView goAddS() {
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		try {
		mv.setViewName("system/doormodel/doormodel_edit");
		mv.addObject("msg", "saveS");
		mv.addObject("pd", pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	
	/**
	 * 跳到编辑页面
	 *
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/goEditS")
	public ModelAndView goEditS() throws Exception {
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			pd = doormodelService.findDoorModelById(pd);
			mv.setViewName("system/doormodel/doormodel_edit");
			mv.addObject("pd", pd);
			mv.addObject("msg", "editS");
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	
	
	/**
	 * 删除一条数据
	 *
	 * @param binder
	 */
	@RequestMapping("/delShop")
	@ResponseBody
	public Object delShop() {
		PageData pd = this.getPageData();
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			Page page = this.getPage();
			page.setPd(pd);
			doormodelService.deleteDoorModel(pd);
			map.put("msg", "success");
		} catch (Exception e) {
			map.put("msg", "failed");
		}
		return JSONObject.fromObject(map);
	}

	/**
	 * 删除多条数据
	 *
	 * @param binder
	 */
	@RequestMapping("/deleteAllS")
	@ResponseBody
	public Object delShops() throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = this.getPageData();
		Page page = this.getPage();
		try {
			page.setPd(pd);
			String house_ids = (String) pd.get("house_ids");
			for (String house_id : house_ids.split(",")) {
				pd.put("house_id", house_id);
				doormodelService.deleteDoorModel(pd);
			}
			map.put("msg", "success");
		} catch (Exception e) {
			map.put("msg", "failed");
		}
		return JSONObject.fromObject(map);
	}
	
	
	/**
	 * 保存新增
	 *
	 * @return
	 */
	@RequestMapping("/saveS")
	public ModelAndView saveS() {
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		Page page = this.getPage();
		try {
			pd = this.getPageData();
			PageData shop = doormodelService.findDoorModelById(pd);
			if (shop != null) {// 判断门店编号
				mv.addObject("msg", "failed");
			} else {
				doormodelService.saveS(pd);   //保存楼盘基本信息 
				mv.addObject("msg", "success");
			}
		} catch (Exception e) {
			mv.addObject("msg", "failed");
		}
		mv.addObject("id", "EditShops");
		mv.addObject("form", "shopForm");
		mv.setViewName("save_result");

		return mv;
	}
	
	/**
	 * 保存编辑
	 *
	 * @return
	 */
	@RequestMapping("/editS")
	public ModelAndView editS() throws Exception {
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		try {
			pd = this.getPageData();
			PageData shop = doormodelService.findDoorModelById(pd);
			if (shop == null) {// 判断这个编号是否存在
				mv.addObject("msg", "failed");
			} else {
			doormodelService.editS(pd);
			mv.addObject("msg", "success");
			}
		} 
		catch (Exception e)
		{
			mv.addObject("msg", "failed");
		}
		mv.addObject("id", "EditShops");
		mv.addObject("form", "shopForm");
		mv.setViewName("save_result");

		return mv;
	}
	
	/**
	 * 判断井道类型编号是否唯一
	 *
	 * @param binder
	 */
	@RequestMapping("/hasShop")
	@ResponseBody
	public Object hasShop() {
		PageData pd = this.getPageData();
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			PageData shop = doormodelService.findDoorModelById(pd);
			if (shop != null) {
				map.put("msg","error");
			} else {
				map.put("msg", "success");
			}
		} catch (Exception e) {
			map.put("msg", "error");
		}
		return JSONObject.fromObject(map);
	}
	
	/**
	 * 判断楼盘名称是否唯一
	 *
	 * @param binder
	 */
	@RequestMapping("/doormodelName")
	@ResponseBody
	public Object doormodelName() {
		PageData pd = this.getPageData();
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			PageData shop = doormodelService.findDoorModelByName(pd);
			if (shop != null) {
				map.put("msg","error");
			} else {
				map.put("msg", "success");
			}
		} catch (Exception e) {
			map.put("msg", "error");
		}
		return JSONObject.fromObject(map);
	}
	
	
	/* ===============================权限================================== */
	@SuppressWarnings("unchecked")
	public Map<String, String> getHC() {
		Subject currentUser = SecurityUtils.getSubject(); // shiro管理的session
		Session session = currentUser.getSession();
		return (Map<String, String>) session.getAttribute(Const.SESSION_QX);
	}
	
}
