package com.dncrm.controller.system.position;

import com.dncrm.controller.base.BaseController;
import com.dncrm.service.system.department.DepartmentService;
import com.dncrm.service.system.position.PositionService;
import com.dncrm.util.Const;
import com.dncrm.util.FileUpload;
import com.dncrm.util.ObjectExcelRead;
import com.dncrm.util.ObjectExcelView;
import com.dncrm.util.PageData;
import com.dncrm.util.PathUtil;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;

import java.util.*;

@RequestMapping("/position")
@Controller
public class PositionController extends BaseController {
    @Resource(name = "positionService")
    private PositionService positionService;
    @Resource(name = "departmentService")
    private DepartmentService departmentService;

    /**
     * 显示部门列表
     *
     * @return
     */
    @RequestMapping("/listPositions")
    public ModelAndView listPositions() {
        ModelAndView mv = this.getModelAndView();
        try {
            mv.setViewName("system/position/position_list");
            mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
            List<PageData> positions = departmentService.listAllDepartmentsAndPositions();
            if (positions.size() > 0) {
                //构建多叉数
                List<HashMap<String, String>> dataList = new ArrayList<HashMap<String, String>>();
                MultipleTree tree = new MultipleTree();
                HashMap skins = new HashMap();
                skins.put("department","parentSkin");
                skins.put("position","leafSkin");
                dataList = ConvertPageDataToList.makeWithNodeTypeAndIconSkin(positions,skins);
                Node node = tree.makeTreeWithOderNo(dataList, 1);
                mv.addObject("positions", node);
            } else {
                mv.addObject("positions", positions);
            }
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }

    /**
     * 获取所有数据
     *
     */
    @RequestMapping("/getAllPositions")
    @ResponseBody
    public Object getAllPositions() {
        PageData pd = this.getPageData();
        Map<String, Object> map = new HashMap<String, Object>();
        JSONArray json = new JSONArray();
        try {
            List<PageData> positions = departmentService.listAllDepartmentsAndPositions();

            if (positions.size() > 0) {
                //构建多叉数
                List<HashMap<String, String>> dataList = new ArrayList<HashMap<String, String>>();
                MultipleTree tree = new MultipleTree();
                HashMap skins = new HashMap();
                skins.put("department","parentSkin");
                skins.put("position","leafSkin");
                dataList = ConvertPageDataToList.makeWithNodeTypeAndIconSkin(positions,skins);
                Node node = tree.makeTreeWithOderNo(dataList, 1);
                map.put("msg","success");
                map.put("positions",node.toString());

            } else {
                map.put("msg","failed");
                map.put("err","没有数据了");
            }
        } catch (Exception e) {
            map.put("msg","系统错误");
        }
        return JSONObject.fromObject(map);
    }
    /**
     * 跳到添加页面
     *
     * @return
     */
    @RequestMapping("/goAddPosition")
    public ModelAndView goAddPosition() {
        ModelAndView mv = new ModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        mv.setViewName("system/position/position_edit");
        mv.addObject("msg", "addPosition");
        try {
            List<PageData> departments = departmentService.listAllDepartments();
            if (departments.size() > 0) {
                //构建多叉数
                List<HashMap<String, String>> dataList = new ArrayList<HashMap<String, String>>();
                MultipleTree tree = new MultipleTree();
                dataList = ConvertPageDataToList.makeWithNodeTypeAndIconSkin2(departments,"defaultSkin","department");
                Node node = tree.makeTreeWithOderNo(dataList, 1);
                mv.addObject("departments", node);
            } else {
                mv.addObject("departments", departments);
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
    @RequestMapping("/addPosition")
    public ModelAndView addPosition() {
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
                String id = positionService.addPosition(pd);
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
        mv.addObject("id", "AddPosition");
        mv.addObject("form", "positionForm");
        mv.setViewName("save_result");
        return mv;
    }
    /**
     * 跳到编辑页面
     *
     * @return
     */
    @RequestMapping("/goEditPosition")
    public ModelAndView goEditPosition() {
        ModelAndView mv = new ModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        String parentName = (String)pd.get("parentName");
        mv.setViewName("system/position/position_edit");
        mv.addObject("msg", "editPosition");
        try {
            pd = positionService.getPositionById(pd);
            pd.put("parentName",parentName);
            List<PageData> departments = departmentService.listAllDepartments();
            if (departments.size() > 0) {
                //构建多叉数
                List<HashMap<String, String>> dataList = new ArrayList<HashMap<String, String>>();
                MultipleTree tree = new MultipleTree();
                dataList = ConvertPageDataToList.makeWithNodeTypeAndIconSkin2(departments,"defaultSkin","department");
                Node node = tree.makeTreeWithOderNo(dataList, 1);
                mv.addObject("departments", node);
            } else {
                mv.addObject("departments", departments);
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
    @RequestMapping("/editPosition")
    public ModelAndView editPosition() {
        PageData pd = this.getPageData();
        ModelAndView mv = this.getModelAndView();
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            int id = positionService.editPosition(pd);
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
        mv.addObject("id", "EditPosition");
        mv.addObject("form", "positionForm");
        mv.setViewName("save_result");
        return mv;
    }
    /**
     * 删除一条数据
     *
     */
    @RequestMapping("/delPosition")
    @ResponseBody
    public Object delPosition() {
        PageData pd = this.getPageData();
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            int id = positionService.delPosition(pd);
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
     *导出tb_position 
     */
    @RequestMapping(value="toExcelPosition")
    public ModelAndView toExcelPosition(){
    	ModelAndView mv = new ModelAndView();
		try{
    		Map<String, Object> dataMap = new HashMap<String, Object>();
			List<String> titles = new ArrayList<String>();
			titles.add("职位id");
			titles.add("所属部门");
			titles.add("排序编号");
			titles.add("职位名称");
			titles.add("创建时间");
			titles.add("是否是主管职位");
			titles.add("类型");
			dataMap.put("titles", titles);
			
			List<PageData> positionList = positionService.findPositionList();
			List<PageData> varList = new ArrayList<PageData>();
			for(int i = 0; i < positionList.size(); i++){
				PageData vpd = new PageData();
				vpd.put("var1", positionList.get(i).get("id").toString());
				vpd.put("var2", positionList.get(i).get("dname").toString());
				vpd.put("var3", positionList.get(i).get("orderNo").toString());
				vpd.put("var4", positionList.get(i).get("name").toString());
				vpd.put("var5", positionList.get(i).get("create_time").toString());
				String is_manager=positionList.get(i).get("is_manager").toString();
				vpd.put("var6", is_manager.equals("1")?"是":"否");
				String type=positionList.get(i).get("type").toString();
				vpd.put("var7", type.equals("9")?"职位":"");
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
     *导入tb_position 
     */
    @RequestMapping(value="importExcelPosition")
    @ResponseBody
    public Object importExcelPosition(@RequestParam(value="file") MultipartFile file){
    	Map<String, Object> map = new HashMap<String, Object>();
    	try{
    		if(file!=null && !file.isEmpty()){
    			String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE;//文件上传路径
    			String fileName = FileUpload.fileUp(file, filePath, "userexcel");//执行上传
    			
    			List<PageData> listPd = (List)ObjectExcelRead.readExcel(filePath, fileName, 1, 0, 0);
    			PageData pd = new PageData();
    			for(int i= 0;i<listPd.size();i++){
    				/*pd.put("id", this.get32UUID());*/
    				pd.put("id", UUID.randomUUID().toString());
    	        	pd.put("parentId", listPd.get(i).getString("var0"));
    	        	pd.put("orderNo", listPd.get(i).getString("var1"));
    	        	pd.put("name", listPd.get(i).getString("var2"));
    	        	pd.put("create_time", listPd.get(i).getString("var3"));
    	        	pd.put("is_manager", listPd.get(i).getString("var4"));
    	        	pd.put("type", listPd.get(i).getString("var5"));
    	        	//保存至数据库
    	        	positionService.savePosition(pd);
    			}
    			map.put("msg", "success");
    		}else{
    			map.put("errorMsg", "上传失败");
    		}
    	}catch(Exception e){
    		logger.error(e.getMessage(), e);
    	}
    	return JSONObject.fromObject(map);
    }

//    /**
//     * 修改一条数据
//     *
//     */
//    @RequestMapping("/editPosition")
//    @ResponseBody
//    public Object editPosition() {
//        PageData pd = this.getPageData();
//        Map<String, Object> map = new HashMap<String, Object>();
//        try {
//            int id = positionService.editPosition(pd);
//            if (id != 0) {
//                map.put("msg", "success");
//            } else {
//                map.put("msg", "failed");
//                map.put("err", "修改失败");
//            }
//        } catch (Exception e) {
//            map.put("msg", "failed");
//            map.put("err", "系统错误");
//        }
//        return JSONObject.fromObject(map);
//    }

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
