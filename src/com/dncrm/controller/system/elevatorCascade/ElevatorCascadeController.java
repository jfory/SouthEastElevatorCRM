package com.dncrm.controller.system.elevatorCascade;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.dncrm.controller.base.BaseController;
import com.dncrm.entity.Page;
import com.dncrm.service.system.elevatorCascade.ElevatorCascadeService;
import com.dncrm.service.system.item.ElevatorService;
import com.dncrm.util.Const;
import com.dncrm.util.FileUpload;
import com.dncrm.util.ObjectExcelRead;
import com.dncrm.util.ObjectExcelView;
import com.dncrm.util.PageData;
import com.dncrm.util.PathUtil;
import com.dncrm.util.UuidUtil;
import com.dncrm.util.tree.ConvertPageDataToList;
import com.dncrm.util.tree.MultipleTree;
import com.dncrm.util.tree.Node;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping(value = "/elevatorCascade")
public class ElevatorCascadeController extends BaseController{

	@Resource(name = "elevatorCascadeService")
	private ElevatorCascadeService elevatorCascadeService;
	
	@Resource(name = "elevatorService")
	private ElevatorService elevatorService;
	
	/**
	 * 电梯级联分页列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value ="listElevatorCascade")
	public ModelAndView elevatorCascadeList() throws Exception{
		ModelAndView mv = this.getModelAndView();
        try {
        	//电梯类型集合
        	List<PageData> elevatorList = elevatorService.findAllElevator();
            mv.setViewName("system/elevatorCascade/elevatorCascade_list");
            mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
            List<PageData> elevatorCascade = elevatorCascadeService.listAllElevatorCascade();
            if (elevatorCascade.size() > 0) {
                //构建多叉数
                List<HashMap<String, String>> dataList = new ArrayList<HashMap<String, String>>();
                MultipleTree tree = new MultipleTree();
                
                dataList = ConvertPageDataToList.makeIncludeNodeType(elevatorCascade);
                Node node = tree.makeTreeWithOderNo(dataList, 1);
                mv.addObject("elevatorCascade", node);
            } else {
                mv.addObject("elevatorCascade", elevatorCascade);
            }
            mv.addObject("elevatorList", elevatorList);
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        
		return mv;
	}
	
	/**
     * 跳到添加页面
     *
     * @return
     */
    @RequestMapping("/goAddElevatorCascade")
    public ModelAndView goAddPosition() {
        ModelAndView mv = new ModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        mv.setViewName("system/elevatorCascade/elevatorCascade_edit");
        mv.addObject("msg", "addElevatorCascade");
        try {
        	//电梯类型集合
        	List<PageData> elevatorList = elevatorService.findAllElevator();
            List<PageData> elevatorCascade = elevatorCascadeService.listAllElevatorCascade();
            if (elevatorCascade.size() > 0) {
                //构建多叉数
                List<HashMap<String, String>> dataList = new ArrayList<HashMap<String, String>>();
                MultipleTree tree = new MultipleTree();
                dataList = ConvertPageDataToList.makeWithNodeTypeAndIconSkin2(elevatorCascade,"defaultSkin","department");
                Node node = tree.makeTreeWithOderNo(dataList, 1);
                mv.addObject("elevatorCascade", node);
                mv.addObject("elevatorList",elevatorList);
            } else {
                mv.addObject("elevatorCascade", elevatorCascade);
            }
        }catch (Exception e){
            logger.error(e.toString(), e);
        }
        mv.addObject("pd", pd);
        return mv;
    }
    
    /**
     * 新增一条数据
     *
     */
    @RequestMapping("/addElevatorCascade")
    public ModelAndView addElevatorCascade() {
        PageData pd = this.getPageData();
        ModelAndView mv = this.getModelAndView();
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            String parentId = (String) pd.get("parentId");
            if (parentId == null || parentId=="") {
                map.put("msg", "failed");
                map.put("err", "父类ID不存在");
            } else {
                pd.put("id",UUID.randomUUID().toString());
                String id = elevatorCascadeService.addElevatorCascade(pd);
                if (id != "-1") {
                    mv.addObject("msg", "success");
                } else {
                    mv.addObject("msg", "failed");
                    mv.addObject("err", "保存失败！");
                }
            }

        } catch (Exception e) {
            mv.addObject("msg", "failed");
            mv.addObject("err", "系统错误！");
        }
        mv.addObject("id", "AddElevatorCascade");
        mv.addObject("form", "elevatorCascadeForm");
        mv.setViewName("save_result");
        return mv;
    }
    
    /**
     * 跳到编辑页面
     *
     * @return
     */
    @RequestMapping("/goEditElevatorCascade")
    public ModelAndView goEditElevatorCascade() {
        ModelAndView mv = new ModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        String parentName = (String)pd.get("parentName");
        mv.setViewName("system/elevatorCascade/elevatorCascade_edit");
        mv.addObject("msg", "editElevatorCascade");
        try {
        	//电梯类型集合
        	List<PageData> elevatorList = elevatorService.findAllElevator();
            pd = elevatorCascadeService.getElevatorCascadeById(pd);
            pd.put("parentName",parentName);
            List<PageData> elevatorCascade = elevatorCascadeService.listAllElevatorCascade();
            if (elevatorCascade.size() > 0) {
                //构建多叉数
                List<HashMap<String, String>> dataList = new ArrayList<HashMap<String, String>>();
                MultipleTree tree = new MultipleTree();
                dataList = ConvertPageDataToList.makeWithNodeTypeAndIconSkin2(elevatorCascade,"defaultSkin","department");
                Node node = tree.makeTreeWithOderNo(dataList, 1);
                mv.addObject("elevatorCascade", node);
            } else {
                mv.addObject("elevatorCascade", elevatorCascade);
            }
            mv.addObject("elevatorList", elevatorList);
        }catch (Exception e){
            logger.error(e.toString(), e);
        }
        mv.addObject("pd", pd);
        return mv;
    }
	
    /**
     * 新增一条数据
     *
     */
    @RequestMapping("/editElevatorCascade")
    public ModelAndView editElevatorCascade() {
        PageData pd = this.getPageData();
        ModelAndView mv = this.getModelAndView();
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            int id = elevatorCascadeService.editElevatorCascade(pd);
            if (id >0) {
                mv.addObject("msg", "success");
            } else {
                mv.addObject("msg", "failed");
                mv.addObject("err", "更新失败！");
            }
        } catch (Exception e) {
            mv.addObject("msg", "failed");
            mv.addObject("err", "系统错误！");
        }
        mv.addObject("id", "EditElevatorCascade");
        mv.addObject("form", "elevatorCascadeForm");
        mv.setViewName("save_result");
        return mv;
    }
    /**
     * 删除一条数据
     *
     */
    @RequestMapping("/delElevatorCascade")
    @ResponseBody
    public Object delElevatorCascade() {
        PageData pd = this.getPageData();
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            int id = elevatorCascadeService.delElevatorCascade(pd);
            if (id != 0) {
                map.put("msg", "success");
            } else {
                map.put("msg", "failed");
                map.put("err", "删除失败");
            }
        } catch (Exception e) {
            map.put("msg", "failed");
            map.put("err", "系统错误");
        }
        return JSONObject.fromObject(map);
    }
    
    /**
	 *点击区域输入框节点查询该节点是最终子节点
	 * @throws Exception 
	 */
	@RequestMapping(value="/checkElevatorCascadeNode")
	@ResponseBody
	public Object checkElevatorCascadeNode() throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		PageData pd = this.getPageData();
		List<PageData> elevatorCascadeList = elevatorCascadeService.elevatorCascadeListByParentId(pd);
		if(elevatorCascadeList.size() == 0 ){
			map.put("msg", "success");
		}else{
			map.put("msg", "faild");
		}
		JSONObject obj = JSONObject.fromObject(map);
		return obj;
	}
	
	/**
	 *导出到Excel 
	 */
	@RequestMapping(value="toExcel")
	public ModelAndView toExcel(){
		PageData pd = this.getPageData();
		ModelAndView mv = new ModelAndView();
		try{
			Map<String, Object> dataMap = new HashMap<String, Object>();
			List<String> titles = new ArrayList<String>();
			//电梯速度参数导出
			
			titles.add("名称");
			titles.add("排序");
			titles.add("父类ID");
			titles.add("创建时间");
			titles.add("电梯类型ID");
			dataMap.put("titles", titles);
			List<PageData> itemList = elevatorCascadeService.listAllElevatorCascade();
			List<PageData> varList = new ArrayList<PageData>();
			for(int i = 0; i < itemList.size(); i++){
				PageData vpd = new PageData();
				vpd.put("var1", itemList.get(i).getString("name"));
				vpd.put("var2", itemList.get(i).get("orderNo").toString());
				vpd.put("var3", itemList.get(i).getString("parentId"));
				vpd.put("var4", itemList.get(i).getString("create_time"));
				vpd.put("var5", itemList.get(i).getString("elevator_id"));
				varList.add(vpd);
			}
			dataMap.put("varList", varList);
			ObjectExcelView erv = new ObjectExcelView();
			mv = new ModelAndView(erv, dataMap);
			
			
			
		}catch(Exception e){
			logger.error(e.getMessage(), e);
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
		PageData pd = this.getPageData();
		try{
			if(file!=null && !file.isEmpty()){
	            String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE; // 文件上传路径
	            String fileName = FileUpload.fileUp(file, filePath, "userexcel"); // 执行上传
				List<PageData> listPd = (List) ObjectExcelRead.readExcel(filePath,fileName, 1, 0, 0);
				PageData pds = new PageData();
				//速度参数导入
				
				for(int i = 0;i<listPd.size();i++){
					if(listPd.get(i).get("var0") != null && !listPd.get(i).get("var0").equals("")){
						pds.put("name", listPd.get(i).getString("var0"));//
						pds.put("orderNo", listPd.get(i).getString("var1"));//
						pds.put("parentId", listPd.get(i).getString("var2"));//
						pds.put("create_time", listPd.get(i).getString("var3"));//
						pds.put("elevator_id", listPd.get(i).getString("var4"));//
						//保存速度参数至数据库
						elevatorCascadeService.addElevatorCascade(pds);
					}
				}
				
				map.put("success", true);
	    	}else{
	    		map.put("errorMsg", "上传失败");
	    	}
		}catch(Exception e){
			logger.error(e.getMessage(), e);
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
