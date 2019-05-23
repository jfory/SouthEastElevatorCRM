package com.dncrm.controller.system.cell;

import com.dncrm.controller.base.BaseController;
import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Page;
import com.dncrm.entity.system.User;
import com.dncrm.service.system.cell.CellService;
import com.dncrm.service.system.houseType.HouseTypeService;
import com.dncrm.util.Const;
import com.dncrm.util.DateUtil;
import com.dncrm.util.FileDownload;
import com.dncrm.util.FileUpload;
import com.dncrm.util.ObjectExcelRead;
import com.dncrm.util.ObjectExcelView;
import com.dncrm.util.PageData;
import com.dncrm.util.PathUtil;
import com.dncrm.util.SelectByRole;

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
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequestMapping("/cell")
@Controller
public class CellController extends BaseController
{
	@Resource(name = "cellService")
	private CellService cellService;
	
	@Resource(name = "housetypeService")
	private HouseTypeService housetypeService;

	// test
	@SuppressWarnings("unused")
	private DaoSupport dao;

	/**
	 * 显示单元基本信息
	 *
	 * @return
	 */
	@RequestMapping("/cell")
	public ModelAndView listStores(Page page) {
		ModelAndView mv = this.getModelAndView();
		SelectByRole sbr = new SelectByRole();
		try {
			PageData pd = this.getPageData();
			List<String> userList = sbr.findUserList(getUser().getUSER_ID());
			pd.put("userList", userList);
			page.setPd(pd);
			/*List<PageData> cellList = cellService.listPdPageCell(page);*/
			List<PageData> cellList = cellService.listPdPageCellByRole(page);
			mv.setViewName("system/cell/cell");
			mv.addObject("cellList", cellList);
			mv.addObject("pd", pd);
			mv.addObject("msg","cell");
			mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	/**
	 * 显示单元基本信息
	 *
	 * @return
	 */
	@RequestMapping("/cell2")
	public ModelAndView listStores2(Page page) {
		ModelAndView mv = this.getModelAndView();
		try {
			PageData pd = this.getPageData();
			page.setPd(pd);
			List<PageData> cellList = cellService.listPdPageCell(page);
			mv.setViewName("system/houses/houses_cell");
			mv.addObject("cellList", cellList);
			mv.addObject("pd", pd);
			mv.addObject(Const.SESSION_QX, this.getHC()); // 按钮权限
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
			pd = cellService.findCellById(pd);
			mv.setViewName("system/cell/cell_edit");
			mv.addObject("pd", pd);
			mv.addObject("msg", "editS");
			
			List<PageData> housesList = cellService.listPdPageHouses(getPage());// 加载楼盘信息
			mv.addObject("housesList", housesList);
			
			// 根据楼盘编号加载属于该楼盘的户型信息
			String houses_id=pd.getString("houses_no");//获取楼盘编号
			PageData houses = new PageData();
			houses.put("houses_id", houses_id);
			List<PageData> houseTypeList = cellService.findhouseTypeById(houses);
			mv.addObject("houseTypeList", houseTypeList);
			
			//根据户型ID 获取属于该户型的解决方案
			String hou_id=pd.getString("house_id");//获取户型编号
			PageData house = new PageData();
			house.put("hou_id", hou_id);
			Page page=new Page();
			page.setPd(house);
			List<PageData> solutionList = cellService.solutionlistPage(page);
			mv.addObject("solutionList", solutionList);
			List<PageData> wellList = cellService.welllistPage(getPage());// 加载井道信息
			mv.addObject("wellList", wellList);
			List<PageData> competitorList = cellService.competitorList(getPage()) ;// 加载竞争对手信息
			mv.addObject("competitorList", competitorList);
			List<PageData> merchantList = cellService.MerchantlistPage(getPage());// 加载小业主信息
			mv.addObject("merchantList", merchantList);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	
	
	/**
	 * 跳到添加页面 并且加载需要的数据到页面
	 * @return
	 */
	@RequestMapping("/goAddS")
	public ModelAndView goAddS() {
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd=this.getPageData();
		Date dt=new Date();
		SimpleDateFormat matter1=new SimpleDateFormat("yyyyMMdd");
	    String time= matter1.format(dt);
		int number=(int)((Math.random()*9+1)*100000);
		String cell_id=("DNC"+time+number);
		try {
			if(!pd.isEmpty())
			{
				//根据户型ID 获取属于该户型的解决方案
				String hou_id=pd.getString("house_id");//获取户型编号
				PageData house = new PageData();
				house.put("hou_id", hou_id);
				Page page=new Page();
				page.setPd(house);
				List<PageData> solutionList = cellService.solutionlistPage(page);
				mv.addObject("solutionList", solutionList);
			}
			List<PageData> houseTypeList = cellService.houseTypelistPage(getPage());// 加载户型信息
			mv.addObject("houseTypeList", houseTypeList);
			List<PageData> housesList = cellService.listPdPageHouses(getPage());// 加载楼盘信息
			mv.addObject("housesList", housesList);
			List<PageData> wellList = cellService.welllistPage(getPage());// 加载井道信息
			mv.addObject("wellList", wellList);
		    List<PageData> competitorList = cellService.competitorList(getPage());// 加载竞争对手信息
			mv.addObject("competitorList", competitorList);
			List<PageData> merchantList = cellService.MerchantlistPage(getPage());// 加载小业主信息
			mv.addObject("merchantList", merchantList);
			
			pd.put("cell_id", cell_id);
			mv.addObject("pd", pd);
			mv.setViewName("system/cell/cell_edit");
			mv.addObject("msg", "saveS");
		    String a=pd.getString("houses_no");
		    if(a!=""||a!=null)
		    {mv.addObject("cell", "houseType");}
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return mv;
	}

	
	/**
	 * 判断单元名称是否唯一
	 *
	 * @param binder
	 */
	@RequestMapping("/CellName")
	@ResponseBody
	public Object CellName() {
		PageData pd = this.getPageData();
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			PageData shop = cellService.findCellByName(pd);
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
	 * 保存新增
	 * @return
	 */
	@RequestMapping("/saveS")
	public ModelAndView saveS() {
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Date dt=new Date();
		SimpleDateFormat matter1=new SimpleDateFormat("yyyyMMdd");
	    String time= matter1.format(dt);
		int number=(int)((Math.random()*9+1)*100000);
		String cell_id=("DNC"+time+number);
		//获取系统时间
		String df=DateUtil.getTime().toString();
		//获取装梯公司信息
		String id=pd.getString("in_option");
		try {
			PageData houses = cellService.findHousesById(pd);//获取楼盘别墅数量
			int num=Integer.parseInt(houses.getString("villadom_num"));
			
			PageData cell=cellService.findCellByHousesId(pd);//获取目前该楼盘单元数量
			Object cellNum=cell.get("cellNum");
			int cellNum2=Integer.parseInt(String.valueOf(cellNum));
			if(cellNum2==num)
			{
				int villadom_num=num+1;
				pd.put("villadom_num", villadom_num);
				cellService.editHouses(pd);//修改楼盘别墅数量
			}
			pd.put("modified_time", df);  
			pd.put("cell_id", cell_id);
			String comp_id="dn001";
			//获取是否有装梯公司字段值
			String install_=pd.getString("install_");
			if(!install_.equals("1"))
			{
				pd.put("comp_name", "");
			}
			else
			{
				if(!id.equals("1"))
				{
					pd.put("comp_name", comp_id);
				}
			}
			PageData shop = cellService.findCellById(pd);
			if (shop != null) {// 判断单元编号
				mv.addObject("msg", "failed");
			} else {
				cellService.saveS(pd);   //保存单元基本信息 
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
		pd = this.getPageData();
		//获取装梯公司信息
		String id=pd.getString("in_option");
		//获取系统时间
		String df=DateUtil.getTime().toString();
		try {
			pd.put("modified_time", df);  
			String comp_id="dn001";
			//获取是否有装梯公司字段值
			String install_=pd.getString("install_");
			if(!install_.equals("1"))
			{
				pd.put("comp_name", "");
			}
			else
			{
				if(!id.equals("1"))
				{
					pd.put("comp_name", comp_id);
				}
			}
			PageData shop = cellService.findCellById(pd);
			if (shop == null) {// 判断这个编号是否存在
				mv.addObject("msg", "failed");
			} else {
			cellService.editS(pd);
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
			cellService.deleteCell(pd);
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
			String cell_ids = (String) pd.get("cell_ids");
			for (String cell_id : cell_ids.split(",")) {
				pd.put("cell_id", cell_id);
				cellService.deleteCell(pd);
			}
			map.put("msg", "success");
		} catch (Exception e) {
			map.put("msg", "failed");
		}
		return JSONObject.fromObject(map);
	}
	
	
	 
    /**
	 * 根据选中的楼盘 ，加载属于该楼盘的户型信息
	 * Stone 2017-04-24
	 * @return
	 */
	@RequestMapping("/SelhuseType")
	@ResponseBody
	public JSONObject SelhouseType(@RequestParam(value = "houses_id")String houses_id) {
		JSONObject result = new JSONObject();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			List<PageData> houseTypeList = cellService.findhouseTypeById(pd);
			result.put("houseTypeList", houseTypeList);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}
		return result;
	}
	
	 /**
		 * 根据选中的户型 ，加载属于该户型的解决方案信息
		 * Stone 2017-05-02
		 * @return
		 */
		@RequestMapping("/selSolution")
		@ResponseBody
		public JSONObject selSolution(@RequestParam(value = "hou_id")String hou_id) {
			JSONObject result = new JSONObject();
			PageData pd = new PageData();
			pd = this.getPageData();
			Page page=new Page();
			try {
				page.setPd(pd);
				List<PageData> solutionList = housetypeService.solutionlistPage(page);
				result.put("solutionList", solutionList);
			} catch (Exception e) {
				logger.error(e.toString(), e);
			}
			return result;
		}
	
	/**
     * 异步上传
     * @param file
     * @return
     */
    @RequestMapping(value = "/upload")
    @ResponseBody
    public Object upload(@RequestParam(value = "file") MultipartFile file){
    	String ffile=DateUtil.getDay(),fileName="";
    	JSONObject result = new JSONObject();
    	if(file!=null && !file.isEmpty()){
    		String filePath = PathUtil.getClasspath().concat(Const.FILEPATHFILE)+"houses/"+ffile;// 文件上传路径
    		fileName = FileUpload.fileUp(file, filePath, this.get32UUID());// 执行上传
    		result.put("success", true);
    		result.put("filePath", "houses/" + ffile + "/" + fileName);   //houses是存放上传的文件的文件夹
    	}else{
    		result.put("errorMsg", "上传失败");
    	}
    	return result;
    }

	
    /**
     * 下载文件
     */
    @RequestMapping(value = "/down")
    public void downExcel(HttpServletRequest request,HttpServletResponse response) throws Exception {
    	String downFile = request.getParameter("downFile");
    	String fileName=request.getParameter("fileName");
        FileDownload.fileDownload(response, PathUtil.getClasspath()
                + Const.FILEPATHFILE + downFile, fileName==null||"".equals(fileName)?downFile:fileName);
    }
   
    /**
	 *导出到Excel 
	 */
	@RequestMapping(value="toExcel")
	public ModelAndView toExcel(){
		ModelAndView mv = new ModelAndView();
		try{
			Map<String, Object> dataMap = new HashMap<String, Object>();
			List<String> titles = new ArrayList<String>();
			titles.add("单元编号");
			titles.add("单元名称");
			titles.add("所属楼盘名称");
			titles.add("井道类型");
			titles.add("装梯公司");
			titles.add("电梯价格from");
			titles.add("电梯价格to");
			titles.add("住户信息描述");
			titles.add("单元房型图附件地址");
			titles.add("录入时间");
			titles.add("电梯品牌");
			titles.add("电梯驱动方式");
			titles.add("是否已装修");
			titles.add("是否预留井道");
			titles.add("顶层高度");
			titles.add("地坑深度");
			titles.add("井道宽");
			titles.add("井道深");
			titles.add("层数");
			titles.add("井道结构");
			titles.add("竞争对手进驻渠道");
			titles.add("型号描述");
			titles.add("配置描述");
			titles.add("图纸");
			titles.add("渠道来源");
			titles.add("现场照片");
			titles.add("解决方案");
			titles.add("所属户型");
			titles.add("供应商信息");
			titles.add("所属业主");
			titles.add("户型解决方案");
			dataMap.put("titles", titles);
			
			List<PageData> itemList = cellService.findCellList();
			List<PageData> varList = new ArrayList<PageData>();
			for(int i = 0; i < itemList.size(); i++){
				PageData vpd = new PageData();
				vpd.put("var1", itemList.get(i).getString("cell_id"));
				vpd.put("var2", itemList.get(i).getString("cell_name"));
				vpd.put("var3", itemList.get(i).getString("houses_name"));
				vpd.put("var4", itemList.get(i).getString("well_name"));
				vpd.put("var5", itemList.get(i).getString("comp_name"));
				vpd.put("var6", itemList.get(i).getString("comp_price_from"));
				vpd.put("var7", itemList.get(i).getString("comp_price_to"));
				vpd.put("var8", itemList.get(i).getString("house_owner_info"));
				vpd.put("var9", itemList.get(i).getString("house_type_img"));
				SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//定义格式，不显示毫秒
				String modified_time = df.format(itemList.get(i).get("modified_time"));
				vpd.put("var10", modified_time);
				vpd.put("var11", itemList.get(i).getString("comp_brand"));
				vpd.put("var12", itemList.get(i).getString("comp_drive_mode"));
				String cell_decorate=itemList.get(i).getString("cell_decorate");
				vpd.put("var13", cell_decorate.equals("1")?"是":"否");
				String cell_Reserved_well=itemList.get(i).getString("cell_Reserved_well");
				vpd.put("var14", cell_Reserved_well.equals("1")?"是":"否");
				vpd.put("var15", itemList.get(i).getString("top_height"));
				vpd.put("var16", itemList.get(i).getString("pit_deepness"));
				vpd.put("var17", itemList.get(i).getString("well_breadth"));
				vpd.put("var18", itemList.get(i).getString("well_deepness"));
				vpd.put("var19", itemList.get(i).getString("tiers"));
				String well_structure=itemList.get(i).getString("well_structure");
				if(well_structure.equals("1"))
				{
					vpd.put("var20", "铝合金框架");
				}else if(well_structure.equals("2"))
				{
					vpd.put("var20", "土建");
				}else if(well_structure.equals("3"))
				{
					vpd.put("var20", "钢结构");
				}else
				{
					vpd.put("var20", "");
				}
				//竞争对手 进驻渠道
				String comp_referral=itemList.get(i).getString("comp_referral");
				if(comp_referral.equals("1"))
				{
					vpd.put("var21", "物业推荐");
				}else if(comp_referral.equals("2"))
				{
					vpd.put("var21", "设计机构");
				}
				else if(comp_referral.equals("3"))
				{
					vpd.put("var21", "业主自行采购");
				}
				else if(comp_referral.equals("4"))
				{
					vpd.put("var21", "电梯代理商");
				}
				else if(comp_referral.equals("5"))
				{
					vpd.put("var21", "朋友推荐");
				}else
				{
					vpd.put("var21", "");
				}
				
				vpd.put("var22", itemList.get(i).getString("comp_model"));
				vpd.put("var23", itemList.get(i).getString("comp_deploy"));
				vpd.put("var24", itemList.get(i).getString("dn_drawing"));
				//东南安装   渠道来源
				String dn_referral=itemList.get(i).getString("dn_referral");
				if(dn_referral.equals("1"))
				{
					vpd.put("var25", "物业推荐");
				}else if(dn_referral.equals("2"))
				{
					vpd.put("var25", "设计机构");
				}
				else if(dn_referral.equals("3"))
				{
					vpd.put("var25", "业主自行采购");
				}
				else if(dn_referral.equals("4"))
				{
					vpd.put("var25", "电梯代理商");
				}
				else if(dn_referral.equals("5"))
				{
					vpd.put("var25", "朋友推荐");
				}else
				{
					vpd.put("var25", "");
				}
				vpd.put("var26", itemList.get(i).getString("dn_picture"));
				vpd.put("var27", itemList.get(i).getString("dn_solution"));
				vpd.put("var28", itemList.get(i).getString("hou_name"));
				vpd.put("var29", itemList.get(i).getString("supplier"));
				vpd.put("var30", itemList.get(i).getString("customer_name"));
				vpd.put("var31", itemList.get(i).getString("so_name"));
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
		//获取系统时间
		String df=DateUtil.getTime().toString();
		try{
			if(file!=null && !file.isEmpty()){
	            String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE; // 文件上传路径
	            String fileName = FileUpload.fileUp(file, filePath, "userexcel"); // 执行上传
				List<PageData> listPd = (List) ObjectExcelRead.readExcel(filePath,fileName, 1, 0, 0);
				
				//保存总错误信息集合
    			List<PageData> allErrList  = new ArrayList<PageData>();
    			//导入全部失败（true）
				boolean allErr=true;
				PageData pd = new PageData();
				for(int i = 0;i<listPd.size();i++)
				{
					//保存该条数据错误信息
					List<PageData> errList = new ArrayList<PageData>();
					
					//楼盘名称-----------检验
					PageData houses=new PageData();//存放楼盘
					PageData hou=new PageData();//存放户型
					PageData cell=new PageData();//存放单元
					String houses_name =listPd.get(i).getString("var1");
					if(houses_name!=null && !houses_name.equals(""))
					{
						PageData housesPd=new PageData();
						housesPd.put("houses_name", houses_name);
						houses=cellService.findHousesByName(housesPd);
					    if(houses==null)
					    {
			        		PageData errPd = new PageData();
	    	        		errPd.put("errMsg", "所属楼盘不存在");
	    	        		errPd.put("errCol", "2");
	    	        		errPd.put("errRow", i+1);
	    	        		errList.add(errPd);
					    }
					    else
					    {
					    	//户型名称------------检验
							String hou_name=listPd.get(i).getString("var2");
							if(hou_name!=null && !hou_name.equals(""))
							{
								PageData houPd=new PageData();
								houPd.put("hou_name", hou_name);
								houPd.put("houses_id", houses.get("houses_no").toString());
								hou=cellService.findHouseTypeByName(houPd);
								if(hou==null)
							    {
					        		PageData errPd = new PageData();
			    	        		errPd.put("errMsg", "所属户型不存在");
			    	        		errPd.put("errCol", "3");
			    	        		errPd.put("errRow", i+1);
			    	        		errList.add(errPd);
							    }
								else
								{
									//单元名称-----------检验
									String cell_name=listPd.get(i).getString("var0");
									if(cell_name!=null && !cell_name.equals(""))
									{
										PageData cellPd=new PageData();
										cellPd.put("houses_no", houses.get("houses_no").toString());
										cellPd.put("hou_id", hou.get("hou_id").toString());
										cellPd.put("cell_name", cell_name);
										cell=cellService.findComp_priceByName(cellPd);
										if(cell!=null)
									    {
							        		PageData errPd = new PageData();
					    	        		errPd.put("errMsg", "单元名称重复");
					    	        		errPd.put("errCol", "1");
					    	        		errPd.put("errRow", i+1);
					    	        		errList.add(errPd);
									    }
									}
									else
									{
										PageData errPd = new PageData();
				    	        		errPd.put("errMsg", "单元名称不能为空");
				    	        		errPd.put("errCol", "1");
				    	        		errPd.put("errRow", i+1);
				    	        		errList.add(errPd);
									}
								}
							}
							else
							{
								PageData errPd = new PageData();
		    	        		errPd.put("errMsg", "户型名称不能为空");
		    	        		errPd.put("errCol", "3");
		    	        		errPd.put("errRow", i+1);
		    	        		errList.add(errPd);
							}
					    }
					}
					else
					{
						PageData errPd = new PageData();
    	        		errPd.put("errMsg", "所属楼盘不能为空");
    	        		errPd.put("errCol", "2");
    	        		errPd.put("errRow", i+1);
    	        		errList.add(errPd);
					}
					
					//井道类型-----------检验
					PageData well=new PageData();
					String well_name= listPd.get(i).getString("var5");
					if(well_name!=null && !well_name.equals(""))
					{
						PageData wellPd=new PageData();
						wellPd.put("well_name", well_name);
						well=cellService.findWellByName(wellPd);
						if(well==null)
					    {
			        		PageData errPd = new PageData();
	    	        		errPd.put("errMsg", "井道类型不存在");
	    	        		errPd.put("errCol", "6");
	    	        		errPd.put("errRow", i+1);
	    	        		errList.add(errPd);
					    }
					}
					else
					{
						PageData errPd = new PageData();
    	        		errPd.put("errMsg", "井道类型不能为空");
    	        		errPd.put("errCol", "6");
    	        		errPd.put("errRow", i+1);
    	        		errList.add(errPd);
					}
					
					//所属业主----------检验
					PageData customer=new PageData();
					String customer_name= listPd.get(i).getString("var3");
					if(customer_name!=null && !customer_name.equals(""))
					{
						PageData customerPd=new PageData();
						customerPd.put("customer_name", customer_name);
						customer=cellService.findCustomerByName(customerPd);
						if(customer==null)
					    {
			        		PageData errPd = new PageData();
	    	        		errPd.put("errMsg", "所属业主不存在");
	    	        		errPd.put("errCol", "4");
	    	        		errPd.put("errRow", i+1);
	    	        		errList.add(errPd);
					    }
					}
					
					//装梯公司
					String so_name = null;//户型解决方案
					String comp_name=listPd.get(i).getString("var6");//装梯公司
					if(!comp_name.equals("") && comp_name!=null)
					{
						if(comp_name.equals("东南安装"))
						{
							//如果是东南安装  查询户型解决方案
							comp_name="dn001";
							String jiejue=listPd.get(i).getString("var4");
							PageData souPd=new PageData();
							souPd.put("so_name", jiejue);
							PageData sou=cellService.findSolutionByName(souPd);
							if(sou!=null)
							{
								so_name=sou.get("so_id").toString();
							}
							else
							{
				        		PageData errPd = new PageData();
		    	        		errPd.put("errMsg", "户型解决方案不存在");
		    	        		errPd.put("errCol", "5");
		    	        		errPd.put("errRow", i+1);
		    	        		errList.add(errPd);
							}
						}
						else
						{
							PageData compPd=new PageData();
							compPd.put("comp_name", comp_name);
							PageData comp=cellService.findCompetitorByName(compPd);
							if(comp!=null)
							{
								comp_name=comp.get("comp_id").toString();
							}
							else
							{
				        		PageData errPd = new PageData();
		    	        		errPd.put("errMsg", "竞争对手不存在");
		    	        		errPd.put("errCol", "");
		    	        		errPd.put("errRow", i+1);
		    	        		errList.add(errPd);
							}
						}
					}
					else
					{
						so_name="";
						comp_name="";
					}
					
					 //是否已装饰----------检验
			        String cell_decorate=listPd.get(i).getString("var7");
			        if(cell_decorate.equals("是"))
			        {
			        	pd.put("cell_decorate", "1");
			        }else if(cell_decorate.equals("否"))
			        {
			        	pd.put("cell_decorate", "2");
			        }else
			        {
			        	PageData errPd = new PageData();
	    	        	errPd.put("errMsg", "填写参数错误");
	    	        	errPd.put("errCol", "8");
	    	        	errPd.put("errRow", i+1);
	    	        	errList.add(errPd);
			        }
			        //是否预留井道-----------检验
			        String cell_Reserved_well=listPd.get(i).getString("var8");
			        if(cell_Reserved_well.equals("是"))
			        {
			        	pd.put("cell_Reserved_well", "1");
			        }else if(cell_Reserved_well.equals("否"))
			        {
			        	pd.put("cell_Reserved_well", "2");
			        }else
			        {
			        	PageData errPd = new PageData();
	    	        	errPd.put("errMsg", "填写的参数错误");
	    	        	errPd.put("errCol", "9");
	    	        	errPd.put("errRow", i+1);
	    	        	errList.add(errPd);
			        }
			        //↑↑↑-------------------字段检验结束-------------------↑↑↑
			        
			        //↓↓↓----如果字段检验没有错误，执行保存操作----↓↓↓
				   if(errList.size()==0)
			       {
					   Date dt=new Date();
						SimpleDateFormat matter1=new SimpleDateFormat("yyyyMMdd");
						String time= matter1.format(dt);
						int number=(int)((Math.random()*9+1)*100000);
						String cell_id=("DNC"+time+number);
				        pd.put("cell_id", cell_id);
				        pd.put("cell_name", listPd.get(i).getString("var0"));
				        pd.put("houses_name", houses.get("houses_no").toString());//所属楼盘
				        pd.put("hou_id", hou.get("hou_id").toString());//所属户型
				        pd.put("customer_no",customer.get("customer_no").toString());//所属业主
				        pd.put("solution_no", so_name);//户型解决方案
				        pd.put("cell_well",  well.get("well_id").toString());//井道类型
				        pd.put("comp_name", comp_name);//装梯公司
				        pd.put("comp_price_from", listPd.get(i).get("var9"));
				        pd.put("comp_price_to", listPd.get(i).get("var10"));
				        pd.put("house_owner_info", listPd.get(i).getString("var11"));
				        pd.put("house_type_json", listPd.get(i).getString("var12"));
				        pd.put("modified_time", df);//
				        pd.put("comp_brand", listPd.get(i).getString("var13"));
				        pd.put("comp_drive_mode",  listPd.get(i).getString("var14"));
				        pd.put("top_height", listPd.get(i).getString("var15"));
				        pd.put("pit_deepness", listPd.get(i).getString("var16"));
				        pd.put("well_breadth", listPd.get(i).getString("var17"));
				        pd.put("well_deepness", listPd.get(i).getString("var18"));
				        pd.put("tiers", listPd.get(i).getString("var19"));
				        pd.put("well_structure", listPd.get(i).getString("var20"));
				        pd.put("comp_referral", listPd.get(i).getString("var21"));
				        pd.put("comp_model", listPd.get(i).getString("var22"));
				        pd.put("comp_deploy", listPd.get(i).getString("var23"));
				        pd.put("dn_drawing_json", listPd.get(i).getString("var24"));
				        pd.put("dn_referral", listPd.get(i).getString("var25"));
				        pd.put("dn_picture_json", listPd.get(i).getString("var26"));
				        pd.put("dn_solution_json", listPd.get(i).getString("var27"));
				        pd.put("supplierJSON", listPd.get(i).getString("var28"));	
					   allErr = false;
			        	//保存至数据库
			           cellService.saveS(pd);
			       }
				   else
				   {
    	        		for(PageData dataPd : errList){
    	        			allErrList.add(dataPd);
    	        		}
    	        	}
				   
				}
				//↑↑↑----------循环结束------------↑↑↑
				//判断总错误数
				if(allErrList.size()==0){
        			map.put("msg", "success");
    			}else{
    				if(allErr){
    					//导入全部失败
            			map.put("msg", "allErr");
    				}else{
    					//部分导入成功，部分导入失败
    					map.put("msg", "error");
    				}
    				//执行完操作之后抛出报错集合
        			String errStr = "";
        			errStr += "总错误:"+allErrList.size();
        			for(PageData forPd : allErrList){
        				errStr += "\n错误类型:"+forPd.getString("errMsg")+";行数:"+forPd.get("errRow").toString()+";列数:"+forPd.getString("errCol");
        			}
        			map.put("errorUpload", errStr);
    			}
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
    /* ===============================用户================================== */

	
}
