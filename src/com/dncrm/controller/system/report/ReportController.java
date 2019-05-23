package com.dncrm.controller.system.report;

import java.io.InputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.dncrm.common.DictUtils;
import com.dncrm.common.ExcelView;
import com.dncrm.controller.base.BaseController;
import com.dncrm.entity.Dict;
import com.dncrm.entity.Indicator.IndicatorModel;
import com.dncrm.service.system.department.DepartmentService;
import com.dncrm.service.system.elevatorManage.ElevatorManageService;
import com.dncrm.service.system.houses.HousesService;
import com.dncrm.service.system.report.ReportService;
import com.dncrm.util.Const;
import com.dncrm.util.DateUtil;
import com.dncrm.util.FileUpload;
import com.dncrm.util.ObjectExcelRead;
import com.dncrm.util.ObjectExcelView;
import com.dncrm.util.PageData;
import com.dncrm.util.PathUtil;
import com.dncrm.util.UuidUtil;
import com.dncrm.util.inputReportExcelView;
import com.dncrm.util.echarts.Echarts;
import com.dncrm.util.tree.ConvertPageDataToList;
import com.dncrm.util.tree.MultipleTree;
import com.dncrm.util.tree.Node;
import com.github.abel533.echarts.json.GsonOption;
import com.google.gson.Gson;

import net.sf.json.JSONObject;


@RequestMapping("/report")
@Controller
public class ReportController extends BaseController {

    @Resource(name = "reportService")
    private ReportService reportService;
    
    @Resource(name = "housesService")
	private HousesService housesService;
    
    @Autowired
    private ElevatorManageService elevatorManageService;
    
    @Autowired
    private DepartmentService departmentService;
    
    @RequestMapping(value = "reportInfo")
    public ModelAndView reportInfo() {
        ModelAndView mv = new ModelAndView();
        try {
            mv.setViewName("system/report/report");
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
        }
        return mv;
    }

    /**
     * 根据选择类型生成报表数据
     */
    @RequestMapping(value = "setByType", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public Object setByType() {
        PageData pd = new PageData();
        GsonOption option = new GsonOption();
        Echarts echarts = new Echarts();
        try {
            pd = this.getPageData();
            List<PageData> list = new ArrayList<PageData>();
            String type = pd.get("type").toString();
            String xAxisName = "";
            String yAxisName = "(Num)";
            if (type.equals("year")) {
                list = reportService.customerYearNum();
                xAxisName = "(年)";
            } else if (type.equals("month")) {
                String year = new SimpleDateFormat("yyyy").format(new Date());
                list = reportService.customerMonthNum(year);
                //option = echarts.setXAxisMonth(option);
                xAxisName = "(月份)";
            } else if (type.equals("quarter")) {
                String year = new SimpleDateFormat("yyyy").format(new Date());
                list = reportService.customerQuarterNum(year);
                //option = echarts.setXAxisQuarter(option);
                xAxisName = "(季度)";
            }
            Map<String, String> legendMap = new HashMap<String, String>();
            legendMap.put("category", "date");
            legendMap.put("战略客户", "coreNum");
            legendMap.put("小业主", "merchantNum");
            legendMap.put("开发商", "ordinaryNum");
            option = echarts.setOption(list, legendMap);
            echarts.setYAxisName(option, yAxisName);
            echarts.setXAxisName(option, xAxisName);

        } catch (Exception e) {
            logger.error(e.getMessage(), e);
        }
        return option.toString();
    }
    
    
    @RequestMapping(value = "/projectForecast")
    	public ModelAndView projectForecast(){
    		ModelAndView mv = new ModelAndView();
    		Date dt=new Date();
    	    SimpleDateFormat matter3=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    	    String thisTime= matter3.format(dt);//当前系统时间
    		try {
    			PageData pd = this.getPageData();
    			/*List<PageData> models = elevatorManageService.listAllModels();
	            if (models.size() > 0) {
	                //构建多叉数
	                MultipleTree tree = new MultipleTree();
	                List<HashMap<String, String>> dataList = ConvertPageDataToList.make(models);
	                Node node = tree.makeTreeWithOderNo(dataList, 1);
	                mv.addObject("models", node);
	            }*/
    			mv.setViewName("system/report/projectForecast");
			} catch (Exception e) {
				logger.error(e.getMessage(), e);
			}
    		return mv;
    	}
    
    @RequestMapping(value = "/ContractRollingReport")
    public ModelAndView contractRollingReport(){
    	ModelAndView mv = new ModelAndView();
    	try {
    		mv.setViewName("system/report/ContractRollingReport");
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
		}
    	return mv ;
    }
    
    //项目预测表导入Excel到数据库 
    @RequestMapping(value="/importExcel")
    @ResponseBody
    public Object importExcel(@RequestParam(value = "file") MultipartFile file){
    	Map<String, Object> map = new HashMap<String, Object>();
		try{
			if(file!=null && !file.isEmpty()){
	            String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE; // 文件上传路径
	            String fileName = FileUpload.fileUp(file, filePath, "userexcel"); // 执行上传
				List<PageData> listPd = (List) ObjectExcelRead.readExcel(filePath,fileName, 1, 0, 0);
				//保存全部错误信息集合
    			List<PageData> allErrList  = new ArrayList<PageData>();
    			List<PageData> savePd  = new ArrayList<PageData>();
				//导入全部失败（true）
				boolean allErr=true;
				SimpleDateFormat vFormat = new SimpleDateFormat("yyyy-MM");
				vFormat.setLenient(false);
				
				List<Dict> dictList = DictUtils.getDictList("bb_qu_yymk");
				
				for(int i = 0;i<listPd.size();i++){
					String customer_area_ordinary =listPd.get(i).getString("var0");
					String year=listPd.get(i).getString("var1");
					String month=listPd.get(i).getString("var2");
					String num=listPd.get(i).getString("var3");
					
					if(StringUtils.isBlank(customer_area_ordinary)
							&& StringUtils.isBlank(year)
							&& StringUtils.isBlank(month)
							&& StringUtils.isBlank(num)) {
						continue;
					}
					
					boolean boolHouses=true;
					PageData pd = new PageData();
					//保存本次for数据错误结合
					List<PageData> errList  = new ArrayList<PageData>();
					//所属区域-----------------验证
					if(customer_area_ordinary==null || customer_area_ordinary.equals("")){
		        		PageData errPd = new PageData();
    	        		errPd.put("errMsg", "区域不能为空！");
    	        		errPd.put("errCol", "1");
    	        		errPd.put("errRow", i+1);
    	        		errList.add(errPd);
					}
					else{
						
						for (Dict dict : dictList) {
							if(customer_area_ordinary.equals(dict.getName())
									|| customer_area_ordinary.equals(dict.getExtend_s1())) {
								
								pd.put("dictVal", dict.getValue());
								pd.put("forecast_name", customer_area_ordinary);
								
								boolHouses = false;
								break;
							}
						}
						
						//PageData quyuPd=new PageData();
						//quyuPd.put("Department_name", customer_area_ordinary);
						
						//PageData quyu=housesService.findDepartmentByName(quyuPd);
						if(!boolHouses){
							//boolHouses=true;
				        	//pd.put("customer_area_ordinary", quyu.get("id").toString());//区域
						} else{
							//boolHouses=false;
							//保存具体的字段的错误信息
			        		PageData errPd = new PageData();
	    	        		errPd.put("errMsg", "区域不存在！");
	    	        		errPd.put("errCol", "1");
	    	        		errPd.put("errRow", i+1);
	    	        		errList.add(errPd);
						}
					}
					
					//年份----------------验证
					if(year==null || year.equals("")) {
						PageData errPd = new PageData();
    	        		errPd.put("errMsg", "年份不能为空！");
    	        		errPd.put("errCol", "2");
    	        		errPd.put("errRow", i+1);
    	        		errList.add(errPd);
					}
					
					//月份----------------验证
					if(month == null || month.equals("")){
						PageData errPd = new PageData();
    	        		errPd.put("errMsg", "月份不能为空！");
    	        		errPd.put("errCol", "3");
    	        		errPd.put("errRow", i+1);
    	        		errList.add(errPd);
					}
					
					//try {
						vFormat.parse(year+"-"+month);
						
					/*} catch (Exception e) {
						PageData errPd = new PageData();
    	        		errPd.put("errMsg", year+"-"+month + " 不是有效的年月！");
    	        		errPd.put("errCol", "2-3");
    	        		errPd.put("errRow", i+1);
    	        		errList.add(errPd);
					}*/
					//项目预测数----------------验证
					//if(num==null || num.equals("")){
					//	PageData errPd = new PageData();
    	        	//	errPd.put("errMsg", "项目预测数不能为空！");
    	        	//	errPd.put("errCol", "4");
    	        	//	errPd.put("errRow", i+1);
    	        	//	errList.add(errPd);
					//}
					if(!StringUtils.isNumeric(num)){
						PageData errPd = new PageData();
    	        		errPd.put("errMsg", "项目预测数只能是纯数字！");
    	        		errPd.put("errCol", "4");
    	        		errPd.put("errRow", i+1);
    	        		errList.add(errPd);
					}
					//提交时间-------------验证
					//String subdate= listPd.get(i).getString("var4");
					//if(subdate==null || subdate.equals(""))
					//{
					//	PageData errPd = new PageData();
    	        	//	errPd.put("errMsg", "提交时间不能为空！");
    	        	//	errPd.put("errCol", "5");
    	        	//	errPd.put("errRow", i+1);
    	        	//	errList.add(errPd);
					//}
		        	//以上验证楼盘相关字段---------- 结束
					
					//如果没有错误信息执行保存操作
					if(errList.size()==0){
						 /*//获取系统当前登陆人
						Subject currentUser = SecurityUtils.getSubject();
				        Session session = currentUser.getSession();
						User user=(User) session.getAttribute(Const.SESSION_USER);
					    String user_id=user.getUSER_ID();*/
					    //获取系统时间
						String df=DateUtil.getTime().toString();
						Date date = new Date();
						SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddhhmmssSS");
//						String  formDate =sdf.format(date);
//						String no = formDate.substring(4);
//						String changedid=DigestUtils.md5Hex(no);
			        	pd.put("projectForecast_id", UuidUtil.get32UUID());
			        	//pd.put("department_id", listPd.get(i).getString("var0"));
			        	pd.put("years", year);
			        	pd.put("months", month);
			        	pd.put("num", num);
			        	pd.put("submit", df);
		        		//保存至数据库
			        	//reportService.saveS(pd);
			        	savePd.add(pd);
					} else {
    	        		for(PageData dataPd : errList){
    	        			allErrList.add(dataPd);
    	        		}
    	        	}	
				}
				
				if(savePd.size() > 0) {
					reportService.saveProjectForecastForList(savePd);
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
	    		map.put("errorUpload", "上传失败,没有数据！");
	    	}
		}
		catch (ParseException e) {
			logger.error(e.getMessage(), e);
			map.put("msg", "exception");
			map.put("errorUpload", "有非法日期，请检查重试！");
		}
		catch(Exception e){
			logger.error(e.getMessage(), e);
			map.put("msg", "exception");
			map.put("errorUpload", "系统错误，请稍后重试！");
		}
		return JSONObject.fromObject(map);
    }	
    
    

    @RequestMapping(value = "/inputReport")
    public ModelAndView inputReport() {
        ModelAndView mv = new ModelAndView();
        try {
            mv.setViewName("system/report/inputReport");
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
        }
        return mv;
    }

    @RequestMapping(value = "/itemDetailReport")
    public ModelAndView itemDetailRepor() {
        ModelAndView mv = new ModelAndView();
        try {
            mv.setViewName("system/report/itemDetailReport");
            List<PageData> models = elevatorManageService.listAllModels();
            if (models.size() > 0) {
                //构建多叉数
                MultipleTree tree = new MultipleTree();
                List<HashMap<String, String>> dataList = ConvertPageDataToList.make(models);
                Node node = tree.makeTreeWithOderNo(dataList, 1);
                mv.addObject("models", node);
            }
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
        }
        return mv;
    }

    @RequestMapping(value = "/itemTrendReport")
    public ModelAndView itemTrendRepor() {
        ModelAndView mv = new ModelAndView();
        try {
            mv.setViewName("system/report/itemTrendReport");
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
        }
        return mv;
    }

    @RequestMapping(value = "/toInputReportExcel")
    public ModelAndView toInputReportExcel() {
        ModelAndView mv = new ModelAndView();
        PageData pd = this.getPageData();

        try {
            Map<String, Object> dataMap = new HashMap<String, Object>();

            List<String> titles = new ArrayList<String>();
            titles.add("录入时间：");
            titles.add(pd.getNoneNULLString("input_date_start"));
            titles.add(pd.getNoneNULLString("input_date_end"));
            titles.add("区域/总部");
            titles.add("分公司");
            titles.add("使用人数");
            titles.add("录入普通客户");
            titles.add("录入战略客户");
            titles.add("项目报备录入");
            titles.add("报价录入");
            titles.add("非标申请");
            titles.add("设备合同录入");
            titles.add("安装合同录入");
            titles.add("开票申请");
            titles.add("来款数据录入");
            dataMap.put("titles", titles);

            List<PageData> varList = new ArrayList<PageData>();
            List<PageData> inputReports = reportService.findInputReport(pd);

            Integer zloginusercount = 0;
            Integer zcustomerordinarycount = 0;
            Integer zcustomercorecount = 0;
            Integer zitemcount = 0;
            Integer zoffercount = 0;
            Integer znonstandradcount = 0;
            Integer zsocontractcount = 0;
            Integer zazcontractcount = 0;
            Integer invoicecount = 0;
            Integer lkcount = 0;
            for (int i = 0, len = inputReports.size(); i < len; i++) {
                PageData ir = inputReports.get(i);
                PageData vpd = new PageData();
                String aName = ir.getNoneNULLString("aName");
                String sName = ir.getNoneNULLString("sName");
                if ("".equals(aName) && "".equals(sName)) {
                    aName = "未知";
                    sName = "未知";
                }
                vpd.put("var1", aName);
                vpd.put("var2", sName);
                vpd.put("var3", ir.get("loginusercount"));
                vpd.put("var4", ir.get("customerordinarycount"));
                vpd.put("var5", ir.get("customercorecount"));
                vpd.put("var6", ir.get("itemcount"));
                vpd.put("var7", ir.get("offercount"));
                vpd.put("var8", ir.get("nonstandradcount"));
                vpd.put("var9", ir.get("socontractcount"));
                vpd.put("var10", ir.get("azcontractcount"));
                vpd.put("var11", ir.get("invoicecount"));
                vpd.put("var12", ir.get("lkcount"));

                zloginusercount += (Integer) ir.get("loginusercount");
                zcustomerordinarycount += (Integer) ir.get("customerordinarycount");
                zcustomercorecount += (Integer) ir.get("customercorecount");
                zitemcount += (Integer) ir.get("itemcount");
                zoffercount += (Integer) ir.get("offercount");
                znonstandradcount += (Integer) ir.get("nonstandradcount");
                zsocontractcount += (Integer) ir.get("socontractcount");
                zazcontractcount += (Integer) ir.get("azcontractcount");
                invoicecount += (Integer) ir.get("invoicecount");
                lkcount += (Integer) ir.get("lkcount");

                varList.add(vpd);
            }
            PageData vpd = new PageData();
            vpd.put("var1", "合计");
            vpd.put("var2", "");
            vpd.put("var3", zloginusercount);
            vpd.put("var4", zcustomerordinarycount);
            vpd.put("var5", zcustomercorecount);
            vpd.put("var6", zitemcount);
            vpd.put("var7", zoffercount);
            vpd.put("var8", znonstandradcount);
            vpd.put("var9", zsocontractcount);
            vpd.put("var10", zazcontractcount);
            vpd.put("var11", invoicecount);
            vpd.put("var12", lkcount);
            varList.add(vpd);

            dataMap.put("varList", varList);
            inputReportExcelView erv = new inputReportExcelView();
            mv = new ModelAndView(erv, dataMap);
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
        }
        return mv;
    }
    
    
    @RequestMapping(value = "/toContracTreviewExcel")
    public ModelAndView toContracTreviewExcel(){
    	ModelAndView mv = new ModelAndView();
        PageData pd = this.getPageData();
        Map<String, Object> model = new HashMap<>();
    	try {
    		List<PageData> list = reportService.findcontractRollingRepor(pd);
    		List<String> titles = new ArrayList<String>();
            titles.add("累计时间：");
            String date = pd.getNoneNULLString("date");
            String year = date.substring(0,4);
            titles.add(year+"-01-01");
            titles.add(date);
            String mon = pd.getNoneNULLString("month");
            int month = Integer.valueOf(mon);
            titles.add("营运模块");
            for (int i = 0; i < month; i++) {
				if(i>=9){
					titles.add("P"+(i+1));
				}else{
					titles.add("P0"+(i+1));
				}
			}
            model.put("titles", titles);
            List<PageData> varList = new ArrayList<PageData>();
            long[] months = new long[month];
            for (int i = 0, len = list.size(); i < len; i++) {
                PageData ir = list.get(i);
                PageData vpd = new PageData();
                String qy_module_value = ir.getNoneNULLString("qy_module_value");
                vpd.put("var1", qy_module_value);
                for (long j = 1; j <= month; j++) {
					if(j>=10){
						vpd.put(("var"+(j+1)), ir.get("P"+j));
					}else{
						vpd.put(("var"+(j+1)),ir.get("P0"+j));
					}
				}
                
             for(int j = 0 ; j < months.length ; j++){
                	if(j>=9){
                		months[j] += (Long)ir.get((("P")+(j+1)));
                	}else{
                		months[j] += (Long)ir.get((("P0")+(j+1)));
                	}
                }
                varList.add(vpd);
            }
            
            PageData vpd = new PageData();
            vpd.put("var1", "合计");
            for (int j = 0; j < months.length; j++) {
					vpd.put(("var"+(j+2)), months[j]);
			}
            varList.add(vpd);
            
            model.put("varList", varList);
            inputReportExcelView erv = new inputReportExcelView();
            mv = new ModelAndView(erv, model);
		} catch (Exception e) {
			 logger.error(e.getMessage(), e);
		}
    	return mv;
    }

    @RequestMapping(value = "/ContractReport")
    public ModelAndView ContractReport() {
        ModelAndView mv = new ModelAndView();
        try {
        	Gson gson = new Gson();
        	Calendar cale = null;
        	cale = Calendar.getInstance();  
        	int date = cale.get(Calendar.DATE);
            int year = cale.get(Calendar.YEAR);  
            
            int month = cale.get(Calendar.MONTH) + 1;   
            PageData pd = new PageData();
            PageData seasonpd = new PageData();
            String StartDate = String.valueOf(year)+"-"+String.valueOf(month)+"-"+"01";
            String EndDate = String.valueOf(year)+"-"+String.valueOf(month)+"-"+"31";
            String ContractStatus = "4";
            
            int SeasonStartint = 0;
            int SeasonEndint = 0;
            if (month==1||month==4||month==7||month==10) {
            	SeasonStartint = month;
            	SeasonEndint = month+2;
			}else if(month==2||month==5||month==8||month==11){
				SeasonStartint = month-1;
            	SeasonEndint = month+1;
			}else
			{
				SeasonStartint = month-2;
				SeasonEndint = month;
			}
            String SeasonStartDate = String.valueOf(year)+"-"+String.valueOf(SeasonStartint)+"-"+"01";
            String SeasonEndtDate = String.valueOf(year)+"-"+String.valueOf(SeasonEndint)+"-"+"31";
            
            pd.put("StartDate", StartDate);
            pd.put("EndDate", EndDate);
            pd.put("ContractStatus", ContractStatus);
            PageData report = reportService.listContractReport(pd);
            pd.putAll(report);
            String reportJson = gson.toJson(report);
            mv.addObject("pd", pd);
            mv.addObject(reportJson);
            mv.setViewName("system/report/contractReport");
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
        }
        return mv;
    }
    
    @RequestMapping(value = "/SearchContractReport")
    @ResponseBody
    public String SearchContractReport(String input_date_start, String input_date_end) {
        String reportJson = "";
        try {
            Gson gson = new Gson();
            PageData pd = new PageData();
            PageData seasonpd = new PageData();
            
            Calendar cale = null;
        	cale = Calendar.getInstance();  
        	int date = cale.get(Calendar.DATE);
            int year = cale.get(Calendar.YEAR);
            int month = cale.get(Calendar.MONTH) + 1;
            String StartDate = String.valueOf(year)+"-"+String.valueOf(month)+"-"+"01";
            String EndDate = String.valueOf(year)+"-"+String.valueOf(month)+"-"+"31";
            String ContractStatus = "4";
            
            if (input_date_start!=null&&input_date_start.length()>0) {
            	StartDate = input_date_start;
                EndDate = input_date_end;
                ContractStatus = "4";
			}
            
            
            pd.put("StartDate", StartDate);
            pd.put("EndDate", EndDate);
            pd.put("ContractStatus", ContractStatus);
            PageData report = reportService.listContractReport(pd);
            reportJson = gson.toJson(report);
            return reportJson;
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
        }
        return reportJson;
    }

    @RequestMapping(value = "sreachItemTrendReport", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public Object sreachItemTrendReport() {
        PageData pd = this.getPageData();
        GsonOption option = new GsonOption();
        Echarts echarts = new Echarts();

        try {
            Date date = null;
            if (!"".equals(pd.getNoneNULLString("input_date"))) {
                date = DateUtil.fomatDate(pd.getNoneNULLString("input_date"));
            }
            if (date == null) {
                date = new Date();
            }

            String xAxisName = "(月份)";
            String yAxisName = "(项目数)";
            List<PageData> list = reportService.findItemTrendRepor(pd);
            List<String> xAxis = new ArrayList<String>();

            int month = date.getMonth() + 1;
            for (int i = 1; i <= month; i++) {
                String xp = "P".concat(String.valueOf(i));
                if (i < 10) {
                    xp = "P0".concat(String.valueOf(i));
                }
                xAxis.add(xp);
            }
            option = echarts.setOption(list, "qy_module_name", xAxis);
            echarts.setYAxisName(option, yAxisName);
            echarts.setXAxisName(option, xAxisName);

        } catch (Exception e) {
            e.printStackTrace();
        }
        //System.out.println(option.toString());
        return option.toString();
    }

    @RequestMapping(value = "/toItemDetailReportExcel")
    public ModelAndView toItemDetailReportExcel() {
        ModelAndView mv = new ModelAndView();
        PageData pd = this.getPageData();
        Map<String, Object> model = new HashMap<>();
        try {
            //获取项目报备报表数据
            Map<String, Map<String, int[][]>> map = reportService
                    .printItemDetailRepor(pd);
            //计算区域、月份、年份总计数
            int areaSum[][][] = new int[4][12][3];
            int monthSum[][] = new int[12][2];
            int yearSum[][] = new int[4][2];
            //所有子公司的指标总数
            int indicatorSum = 0;
            int i = 0;
            for (Map.Entry<String, Map<String, int[][]>> mapEntry : map.entrySet()) {
                for (Map.Entry<String, int[][]> innerMapEntry : mapEntry.getValue().entrySet()) {
                    for (int j = 0; j < 12; j++) {
                        areaSum[i][j][0] = areaSum[i][j][0] + innerMapEntry.getValue()[j][0];
                        areaSum[i][j][1] = areaSum[i][j][1] + innerMapEntry.getValue()[j][1];
                    }
                    areaSum[i][0][2] = areaSum[i][0][2] + innerMapEntry.getValue()[0][2];
                }
                indicatorSum = indicatorSum + areaSum[i][0][2];
                i++;
            }
            for (int q = 0; q < 12; q++) {
                int temp[] = new int[2];
                for (int w = 0; w < 4; w++) {
                    temp[0] = areaSum[w][q][0] + temp[0];
                    temp[1] = areaSum[w][q][1] + temp[1];
                }
                monthSum[q][0] = temp[0];
                monthSum[q][1] = temp[1];
            }
            for (int k = 0; k < 4; k++) {
                int temp[] = new int[2];
                for (int m = 0; m < 12; m++) {
                    temp[0] = temp[0] + areaSum[k][m][0];
                    temp[1] = temp[1] + areaSum[k][m][1];
                }
                yearSum[k][0] = temp[0];
                yearSum[k][1] = temp[1];
            }
            //筛选条件
            model.put("exportTime", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
            model.put("genjinstatus_text", pd.getNoneNULLString("genjinstatus_text").isEmpty() ? "未选择" : pd.getNoneNULLString("genjinstatus_text"));
            model.put("elevator_text", pd.getNoneNULLString("elevator_text").isEmpty() ? "未选择" : pd.getNoneNULLString("elevator_text"));
            model.put("sale_type_text", pd.getNoneNULLString("sale_type_text").isEmpty() ? "未选择" : pd.getNoneNULLString("sale_type_text"));
            model.put("order_org_text", pd.getNoneNULLString("order_org_text").isEmpty() ? "未选择" : pd.getNoneNULLString("order_org_text"));
            //统计总数
            model.put("yearSum", yearSum);
            model.put("monthSum", monthSum);
            model.put("sum", areaSum);
            model.put("indicatorSum", indicatorSum);
            model.put("map", map);
            model.put("excelType", "itemDetailReport");
            //导出Excel
            String strdlx = PathUtil.getClasspath() + Const.FILEPATHFILE + "Report/项目报备明细统计报表.xlsx";
            mv = new ModelAndView(new ExcelView("Document", strdlx), model);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return mv;
    }
    
    @RequestMapping(value = "/toIndicatorTemplate")
    public ModelAndView toIndicatorTemplate() {
        String strdlx = PathUtil.getClasspath() + Const.FILEPATHFILE
                + "Report/项目报备指标导入模板.xlsx";
        Map model = new HashMap();
        return new ModelAndView(new ExcelView("Document", strdlx), model);
    }
    
    @RequestMapping(value = "/importIndicator", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> ImportIndicator(@RequestParam("excel") MultipartFile excel) throws Exception {

        Map<String, Object> result = new HashMap<>();

        try {
            //检测文件合法性
            if (excel == null) {
                result.put("result", "error");
                result.put("msg", "上传文件不存在");
                return result;
            }
            String name = excel.getOriginalFilename();
            long size = excel.getSize();
            if (name == null || name.isEmpty() || size == 0) {
                result.put("result", "error");
                result.put("msg", "上传文件为空");
                return result;
            }

            //解析文件
            InputStream inputStream = excel.getInputStream();
            Workbook workbook = new XSSFWorkbook(inputStream);
            Sheet sheet = workbook.getSheetAt(0);

            //得到Excel的行数
            int totalRows = sheet.getPhysicalNumberOfRows();
            int totalCells = 0;

            //得到Excel的列数(前提是有行数)
            if (totalRows >= 1 && sheet.getRow(0) != null) {
                totalCells = sheet.getRow(0).getPhysicalNumberOfCells();
            }

            List<IndicatorModel> indicatorModelList = new ArrayList<>();

            //循环Excel行数，从第二行开始。标题不入库
            for (int r = 1; r < totalRows; r++) {
                IndicatorModel indicatorModel = new IndicatorModel();
                Row row = sheet.getRow(r);
                if (row != null) {
                    for (int c = 0; c < totalCells; c++) {
                        Cell cell = row.getCell(c);
                        if (cell != null) {
                            switch (c) {
                                case 0:
                                    //分公司
                                    indicatorModel.setDepartment_name(cell.getStringCellValue());
                                    break;

                                case 1:
                                    //年份
                                    if (cell.getCellTypeEnum().equals(CellType.NUMERIC)) {
                                        indicatorModel.setIndicator_year((int) cell
                                                .getNumericCellValue());
                                    } else {
                                        result.put("result", "error");
                                        result.put("msg", "年份列中存在非纯数字的单元格，请检查并重新输入");
                                        return result;
                                    }
                                    break;

                                case 2:
                                    //指标
                                    if (cell.getCellTypeEnum().equals(CellType.NUMERIC)) {
                                        indicatorModel.setIndicator_num(String.valueOf((int) cell.getNumericCellValue()));
                                    } else {
                                        result.put("result", "error");
                                        result.put("msg", "指标列中存在非纯数字的单元格，请检查并重新输入");
                                        return result;
                                    }
                                    break;

                                case 3:
                                    //创建时间
                                    indicatorModel.setIndicator_date(cell.getDateCellValue());
                            }
                        }
                    }
                    indicatorModelList.add(indicatorModel);
                }
            }

            for (IndicatorModel indicatorModel : indicatorModelList) {
                //检测分公司是否存在，并获取分公司ID
                PageData pageData = new PageData();
                pageData.put("name", indicatorModel.getDepartment_name());
                PageData departmentPageData = departmentService.getDepartmentByName(pageData);
                if (departmentPageData != null) {
                    indicatorModel.setDepartment_id((String) departmentPageData.get("id"));
                    //为指标配置UUID
                    indicatorModel.setIndicator_id(UUID.randomUUID().toString());
                } else {
                    result.put("result", "error");
                    result.put("msg", "没有找到" + indicatorModel.getDepartment_name()
                            + "的记录，请检查分公司名称是否正确");
                    return result;
                }
            }

            //批量插入数据库
            reportService.insertIndicatorBatch(indicatorModelList);
            result.put("result", "success");
        } catch (Exception e) {
            result.put("result", "error");
            result.put("msg", "出现异常：" + e.toString());
        }
        return result;
    }

    @RequestMapping(value = "/toItemTrendReportExcel")
    public ModelAndView toItemTrendReportExcel() {
        ModelAndView mv = new ModelAndView();
        PageData pd = this.getPageData();
        Map<String, Object> dataMap = new HashMap<String, Object>();

        List<String> plist = new ArrayList<String>();
        List<String> titles = new ArrayList<String>();
        titles.add("营运模块");

        Date date = null;
        if (!"".equals(pd.getNoneNULLString("input_date"))) {
            date = DateUtil.fomatDate(pd.getNoneNULLString("input_date"));
        }
        if (date == null) {
            date = new Date();
        }
        int month = date.getMonth() + 1;
        for (int i = 1; i <= month; i++) {
            String xp = "P".concat(String.valueOf(i));
            if (i < 10) {
                xp = "P0".concat(String.valueOf(i));
            }
            titles.add(xp);
            plist.add(xp);
        }
        dataMap.put("titles", titles);

        List<PageData> varList = new ArrayList<PageData>();

        try {

            List<PageData> ItemTrendReport = reportService.findItemTrendRepor(pd);

            for (int i = 0, len = ItemTrendReport.size(); i < len; i++) {
                PageData itr = ItemTrendReport.get(i);
                PageData vpd = new PageData();
                vpd.put("var1", itr.getNoneNULLString("qy_module_name"));
                for (int j = 0; j < plist.size(); j++) {
                    vpd.put("var" + (j + 2), (Long) itr.get(plist.get(j)));
                }

                varList.add(vpd);
            }
            String[] word = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P"};
            PageData vpd = new PageData();
            vpd.put("var1", "区域合计");
            for (int j = 0; j < plist.size(); j++) {
                String w = word[j + 1];
                vpd.put("var" + (j + 2), "=SUM(" + w + "2:" + w + "" + (ItemTrendReport.size() + 1) + ")");
            }
            varList.add(vpd);

            dataMap.put("varList", varList);
            ObjectExcelView erv = new ObjectExcelView();
            mv = new ModelAndView(erv, dataMap);
        } catch (Exception e) {
            e.printStackTrace();
        }


        return mv;
    }

    @SuppressWarnings("deprecation")
    @RequestMapping(value = "/toContractReportExcel")
    public ModelAndView toContractReportExcel() {
        ModelAndView mv = new ModelAndView();
        PageData pd = this.getPageData();
        PageData seasonpd = new PageData();
        try {

            Calendar cale = null;
        	cale = Calendar.getInstance();  
        	int date = cale.get(Calendar.DATE);
        	//获取当前年月
            int year = cale.get(Calendar.YEAR);
            int month = cale.get(Calendar.MONTH) + 1;
            String StartDate = String.valueOf(year)+"-"+String.valueOf(month)+"-"+"01";
            String EndDate = String.valueOf(year)+"-"+String.valueOf(month)+"-"+"31";
            
            //计算季节范围
            int SeasonStartint = 0;
            int SeasonEndint = 0;
            String SeasonNUm = "";
            if (month==1||month==4||month==7||month==10) {
            	SeasonStartint = month;
            	SeasonEndint = month+2;
			}else if(month==2||month==5||month==8||month==11){
				SeasonStartint = month-1;
            	SeasonEndint = month+1;
			}else
			{
				SeasonStartint = month-2;
				SeasonEndint = month;
			}
            //第N季度
            if (month>0 && month<=3) {
            	SeasonNUm = "1";
			}else if(month>3 && month<=6){
				SeasonNUm = "2";
			}else if(month>6 && month<=9){
				SeasonNUm = "3";
			}else if(month>9 && month<=12){
				SeasonNUm = "4";
			}
            String SeasonStartDate = String.valueOf(year)+"-"+String.valueOf(SeasonStartint)+"-"+"01";
            String SeasonEndtDate = String.valueOf(year)+"-"+String.valueOf(SeasonEndint)+"-"+"31";
            
            //如果有输入查询时间
            if (pd.getNoneNULLString("input_date_start")!=null&&pd.getNoneNULLString("input_date_start").length()>0) {
            	StartDate = pd.getNoneNULLString("input_date_start");
                EndDate = pd.getNoneNULLString("input_date_end");
                Date fomatDate = DateUtil.fomatDate(pd.getNoneNULLString("input_date_start"));
                month = fomatDate.getMonth() + 1;
			}
            Map<String, Object> dataMap = new HashMap<String, Object>();
            
            List<String> titles = new ArrayList<String>();
            titles.add("合同评审报表：");
            titles.add("统计时间范围：");
            if (pd.getNoneNULLString("input_date_start")!=null&&pd.getNoneNULLString("input_date_start").length()>0) {
            	String fanwei = pd.getNoneNULLString("input_date_start")+" - "+pd.getNoneNULLString("input_date_end");
            	titles.add(fanwei);
//            	titles.add(pd.getNoneNULLString("input_date_start"));
//                titles.add(pd.getNoneNULLString("input_date_end"));
			}else {
				titles.add("当月");
			}
            titles.add("区域");
            titles.add("P" + month + "项目评审数");
            titles.add("P" + month + "评审台数");
            titles.add("P" + month + "合同已输出项目数");
            titles.add("P" + month + "合同已输出台数");
            titles.add("Q" + SeasonNUm + "项目评审数");
            titles.add("Q" + SeasonNUm + "评审台数");
            titles.add("Q" + SeasonNUm + "合同已输出项目数");
            titles.add("Q" + SeasonNUm + "合同已输出台数");
            dataMap.put("titles", titles);

            pd.put("StartDate", StartDate);
            pd.put("EndDate", EndDate);
            pd.put("ContractStatus", "4");
            
            seasonpd.put("StartDate", SeasonStartDate);
            seasonpd.put("EndDate", SeasonEndtDate);
            seasonpd.put("ContractStatus", "4");
            PageData report = reportService.listContractReport(pd);
            PageData seasonRes = reportService.listContractReport(seasonpd);

            List<PageData> varList = new ArrayList<PageData>();
            PageData vpdeast = new PageData();
            PageData vpdsouth = new PageData();
            PageData vpdwest = new PageData();
            PageData vpdnorth = new PageData();
            PageData vpdsuzhou = new PageData();
            PageData vpdzhanlve = new PageData();
            PageData vpdguoji = new PageData();
            PageData vpdjunmin = new PageData();
            PageData vpdcount = new PageData();
            

            vpdeast.put("var1", "东区");
            vpdeast.put("var2", report.get("east_item_count"));
            vpdeast.put("var3", report.get("east_itemdt_count"));
            vpdeast.put("var4", report.get("east_Contract_count"));
            vpdeast.put("var5", report.get("east_dt_count"));
            vpdeast.put("var6", seasonRes.get("east_item_count"));
            vpdeast.put("var7", seasonRes.get("east_itemdt_count"));
            vpdeast.put("var8", seasonRes.get("east_Contract_count"));
            vpdeast.put("var9", seasonRes.get("east_dt_count"));
            varList.add(vpdeast);
            vpdsouth.put("var1", "南区");
            vpdsouth.put("var2", report.get("south_item_count"));
            vpdsouth.put("var3", report.get("south_itemdt_count"));
            vpdsouth.put("var4", report.get("south_Contract_count"));
            vpdsouth.put("var5", report.get("south_dt_count"));
            vpdsouth.put("var6", seasonRes.get("south_item_count"));
            vpdsouth.put("var7", seasonRes.get("south_itemdt_count"));
            vpdsouth.put("var8", seasonRes.get("south_Contract_count"));
            vpdsouth.put("var9", seasonRes.get("south_dt_count"));
            varList.add(vpdsouth);
            vpdwest.put("var1", "西区");
            vpdwest.put("var2", report.get("west_item_count"));
            vpdwest.put("var3", report.get("west_itemdt_count"));
            vpdwest.put("var4", report.get("west_Contract_count"));
            vpdwest.put("var5", report.get("west_dt_count"));
            vpdwest.put("var6", seasonRes.get("west_item_count"));
            vpdwest.put("var7", seasonRes.get("west_itemdt_count"));
            vpdwest.put("var8", seasonRes.get("west_Contract_count"));
            vpdwest.put("var9", seasonRes.get("west_dt_count"));
            varList.add(vpdwest);
            vpdnorth.put("var1", "北区");
            vpdnorth.put("var2", report.get("north_item_count"));
            vpdnorth.put("var3", report.get("north_itemdt_count"));
            vpdnorth.put("var4", report.get("north_Contract_count"));
            vpdnorth.put("var5", report.get("north_dt_count"));
            vpdnorth.put("var6", seasonRes.get("north_item_count"));
            vpdnorth.put("var7", seasonRes.get("north_itemdt_count"));
            vpdnorth.put("var8", seasonRes.get("north_Contract_count"));
            vpdnorth.put("var9", seasonRes.get("north_dt_count"));
            varList.add(vpdnorth);
            vpdsuzhou.put("var1", "加盟商(苏州多美适)");
            vpdsuzhou.put("var2", report.get("suzhou_Item_count"));
            vpdsuzhou.put("var3", report.get("suzhou_Itemdt_count"));
            vpdsuzhou.put("var4", report.get("suzhou_Contract_count"));
            vpdsuzhou.put("var5", report.get("suzhou_dt_count"));
            vpdsuzhou.put("var6", seasonRes.get("suzhou_Item_count"));
            vpdsuzhou.put("var7", seasonRes.get("suzhou_Itemdt_count"));
            vpdsuzhou.put("var8", seasonRes.get("suzhou_Contract_count"));
            vpdsuzhou.put("var9", seasonRes.get("suzhou_dt_count"));
            varList.add(vpdsuzhou);
            vpdguoji.put("var1", "国际部");
            vpdguoji.put("var2", report.get("guoji_Item_count"));
            vpdguoji.put("var3", report.get("guoji_Itemdt_count"));
            vpdguoji.put("var4", report.get("guoji_Contract_count"));
            vpdguoji.put("var5", report.get("guoji_dt_count"));
            vpdguoji.put("var6", seasonRes.get("guoji_Item_count"));
            vpdguoji.put("var7", seasonRes.get("guoji_Itemdt_count"));
            vpdguoji.put("var8", seasonRes.get("guoji_Contract_count"));
            vpdguoji.put("var9", seasonRes.get("guoji_dt_count"));
            varList.add(vpdguoji);
            vpdzhanlve.put("var1", "战略客户部");
            vpdzhanlve.put("var2", report.get("zhanlve_Item_count"));
            vpdzhanlve.put("var3", report.get("zhanlve_Itemdt_count"));
            vpdzhanlve.put("var4", report.get("zhanlve_Contract_count"));
            vpdzhanlve.put("var5", report.get("zhanlve_dt_count"));
            vpdzhanlve.put("var6", seasonRes.get("zhanlve_Item_count"));
            vpdzhanlve.put("var7", seasonRes.get("zhanlve_Itemdt_count"));
            vpdzhanlve.put("var8", seasonRes.get("zhanlve_Contract_count"));
            vpdzhanlve.put("var9", seasonRes.get("zhanlve_dt_count"));
            varList.add(vpdzhanlve);
            vpdjunmin.put("var1", "军民融合部");
            vpdjunmin.put("var2", report.get("junmin_Item_count"));
            vpdjunmin.put("var3", report.get("junmin_Itemdt_count"));
            vpdjunmin.put("var4", report.get("junmin_Contract_count"));
            vpdjunmin.put("var5", report.get("junmin_dt_count"));
            vpdjunmin.put("var6", seasonRes.get("junmin_Item_count"));
            vpdjunmin.put("var7", seasonRes.get("junmin_Itemdt_count"));
            vpdjunmin.put("var8", seasonRes.get("junmin_Contract_count"));
            vpdjunmin.put("var9", seasonRes.get("junmin_dt_count"));
            varList.add(vpdjunmin);
            vpdcount.put("var1", "合计");
            vpdcount.put("var2", report.get("All_item_count"));
            vpdcount.put("var3", report.get("All_Itemdt_count"));
            vpdcount.put("var4", report.get("All_Contract_count"));
            vpdcount.put("var5", report.get("All_dt_count"));
            vpdcount.put("var6", seasonRes.get("All_item_count"));
            vpdcount.put("var7", seasonRes.get("All_Itemdt_count"));
            vpdcount.put("var8", seasonRes.get("All_Contract_count"));
            vpdcount.put("var9", seasonRes.get("All_dt_count"));
            varList.add(vpdcount);

            dataMap.put("varList", varList);
            inputReportExcelView erv = new inputReportExcelView();
            mv = new ModelAndView(erv, dataMap);
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
        }
        return mv;


    }
    
	@RequestMapping(value = "/ItemRollingReport")
    public ModelAndView ItemRollingReport() {
        ModelAndView mv = new ModelAndView();
       
        mv.setViewName("system/report/itemRollingreport");
       
        return mv;
    }
    	
    	
    @SuppressWarnings("deprecation")
    @RequestMapping(value = "/toitemRollingReportExcel")
    public ModelAndView toitemRollingReportExcel() {
        ModelAndView mv = new ModelAndView();
        PageData pd = this.getPageData();
        
        try {

            Calendar cale = null;
        	cale = Calendar.getInstance();  
        	int date = cale.get(Calendar.DATE);
        	//获取当前年月
            int year = cale.get(Calendar.YEAR);
            int month = cale.get(Calendar.MONTH) + 1;
            String StartDate = String.valueOf(year)+"-"+String.valueOf(month)+"-"+"01";
            String EndDate = String.valueOf(year)+"-"+String.valueOf(month)+"-"+"31";
            
            //如果有输入查询时间
            if (pd.getNoneNULLString("input_date_start")!=null&&pd.getNoneNULLString("input_date_start").length()>0) {
            	StartDate = pd.getNoneNULLString("input_date_start");
                EndDate = pd.getNoneNULLString("input_date_end");
                Date fomatDate = DateUtil.fomatDate(pd.getNoneNULLString("input_date_start"));
                month = fomatDate.getMonth() + 1;
			}
            Map<String, Object> dataMap = new HashMap<String, Object>();
            
            List<String> titles = new ArrayList<String>();
            titles.add("项目滚动进度报表：");
            titles.add("统计时间范围：");
            if (pd.getNoneNULLString("input_date_start")!=null&&pd.getNoneNULLString("input_date_start").length()>0) {
            	String fanwei = pd.getNoneNULLString("input_date_start")+" - "+pd.getNoneNULLString("input_date_end");
            	titles.add(fanwei);
			}else {
				titles.add("当月");
			}
            titles.add("营运区域");
            titles.add("丢失");
            titles.add("延后");
            titles.add("考察入围");
            titles.add("最终入围");
            titles.add("中标通知书");
            titles.add("合同谈判");
            titles.add("合同评审");
            titles.add("等待订金");
            titles.add("订金付出");
            titles.add("订金收到");
            titles.add("合计");

            dataMap.put("titles", titles);

            pd.put("StartDate", StartDate);
            pd.put("EndDate", EndDate);
            int[][] report = reportService.listItemRolling(pd);
            String[] Arealist = new String[] {"东区营销中心","南区营销中心","西区营销中心","北区营销中心",
    				"苏州多美适","国际部","战略客户","军民融合部"};
            List<PageData> varList = new ArrayList<PageData>();
            int vpsum = 0;
           PageData vpcount = new PageData();
            for (int i = 0; i < 8; i++) {
                PageData vpd = new PageData();
                int horizontalcount = 0;
                
                //放入区域
                vpd.put("var1", Arealist[i]);
                	for (int j = 0; j <10; j++) {
                		//水平合计
        				horizontalcount += report[i][j];
        				vpd.put("var"+(j+2), report[i][j]);
        				vpd.put("var12", horizontalcount);
        				vpsum+=horizontalcount;
        			}
        			varList.add(vpd);
    		}
            //计算垂直合计
            int count[] = new int[10];
            for(int i = 0; i < report.length; i++) {
            	  for(int j = 0; j < report[0].length; j++) {
            		  count[j] += report[i][j];
            		  
            	  }
        	}
            
            
            for (int i = 0; i < count.length; i++) {
				vpcount.put("var"+(i+2), count[i]);
//				if (i==9) {
//					vpcount.put("var"+(i+3), vpsum);
//				}
				
			}
            vpcount.put("var1", "合计");
            varList.add(vpcount);
            dataMap.put("varList", varList);
            inputReportExcelView erv = new inputReportExcelView();
            mv = new ModelAndView(erv, dataMap);
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
        }
        return mv;


    }
    
    
    @SuppressWarnings("deprecation")
    @RequestMapping(value = "/SearchItemRolling")
    @ResponseBody
    public int[][] SearchItemRolling() {
        ModelAndView mv = new ModelAndView();
        PageData pd = this.getPageData();
            Calendar cale = null;
        	cale = Calendar.getInstance();  
        	int date = cale.get(Calendar.DATE);
        	//获取当前年月
            int year = cale.get(Calendar.YEAR);
            int month = cale.get(Calendar.MONTH) + 1;
            String StartDate = String.valueOf(year)+"-"+String.valueOf(month)+"-"+"01";
            String EndDate = String.valueOf(year)+"-"+String.valueOf(month)+"-"+"31";
            
            //如果有输入查询时间
            if (pd.getNoneNULLString("input_date_start")!=null&&pd.getNoneNULLString("input_date_start").length()>0) {
            	StartDate = pd.getNoneNULLString("input_date_start");
                EndDate = pd.getNoneNULLString("input_date_end");
                Date fomatDate = DateUtil.fomatDate(pd.getNoneNULLString("input_date_start"));
                month = fomatDate.getMonth() + 1;
			}
            pd.put("StartDate", StartDate);
            pd.put("EndDate", EndDate);
            Map<String, Object> dataMap = new HashMap<String, Object>();
            
            
            int[][] report = null;
			try {
				report = reportService.listItemRolling(pd);
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return report;
    }
    
    
<<<<<<< HEAD
    @RequestMapping(value = "/SearchItemRollingBycondition")
    @ResponseBody
    public int[] SearchItemRollingBycondition(String StartDate,String EndDate,String areaSelect) throws Exception {
        PageData pd = this.getPageData();
        StartDate = pd.getNoneNULLString("input_date_start");
        EndDate = pd.getNoneNULLString("input_date_end");
        
            pd.put("StartDate", StartDate);
            pd.put("EndDate", EndDate);
            pd.put("areaSelect", areaSelect);
            
            
            int[] report = null;
			report = reportService.listItemRollingByCondition(pd);
			
=======
    @SuppressWarnings("deprecation")
    @RequestMapping(value = "/SearchItemRollingBycondition")
    @ResponseBody
    public int[] SearchItemRollingBycondition() {
        ModelAndView mv = new ModelAndView();
        PageData pd = this.getPageData();
            Calendar cale = null;
        	cale = Calendar.getInstance();  
        	int date = cale.get(Calendar.DATE);
        	//获取当前年月
            int year = cale.get(Calendar.YEAR);
            int month = cale.get(Calendar.MONTH) + 1;
            String StartDate = String.valueOf(year)+"-"+String.valueOf(month)+"-"+"01";
            String EndDate = String.valueOf(year)+"-"+String.valueOf(month)+"-"+"31";
            
            //如果有输入查询时间
            if (pd.getNoneNULLString("input_date_start")!=null&&pd.getNoneNULLString("input_date_start").length()>0) {
            	StartDate = pd.getNoneNULLString("input_date_start");
                EndDate = pd.getNoneNULLString("input_date_end");
                Date fomatDate = DateUtil.fomatDate(pd.getNoneNULLString("input_date_start"));
                month = fomatDate.getMonth() + 1;
			}
            pd.put("StartDate", StartDate);
            pd.put("EndDate", EndDate);
            Map<String, Object> dataMap = new HashMap<String, Object>();
            
            
            int[] report = null;
			try {
				report = reportService.listItemRollingByCondition(pd);
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
>>>>>>> 84ecd0dc1cb9b626ed6f32a72eec5d5a6005d642
			return report;
    }
    
    
    
    @RequestMapping(value = "/toProjectForecastExcel")
    public ModelAndView toProjectForecastExcel() {
        ModelAndView mv = new ModelAndView();
        PageData pd = this.getPageData();
        Map<String, Object> dataMap = new HashMap<String, Object>();
        List<String> dateList = new ArrayList<String>();
        List<String> titles = new ArrayList<String>();
        List<PageData> varList = new ArrayList<PageData>();
    	
        try {
        	
        	Date date = null;
            if (!"".equals(pd.getNoneNULLString("input_date"))) {
                date = DateUtil.fomatDate(pd.getNoneNULLString("input_date"));
            }
            if (date == null) {
                date = new Date();
            }
            titles.add("统计时间：");
            titles.add(new SimpleDateFormat("yyyy-MM-dd").format(date));
            titles.add("");
            
            titles.add("营运模块");

            int year = 1900 + date.getYear();
            int month = date.getMonth() + 1;
            for (int i = 1; i <= month; i++) {
                String xp = "P".concat(String.valueOf(i));
                if (i < 10) {
                    xp = "P0".concat(String.valueOf(i));
                }
                if(i == month) {
                	xp = "当月 " + xp;
                }
                titles.add(xp);
                dateList.add(year+"-"+i);
            }
            
            //后两个月
            for (int i = 1; i <= 2; i++) {
            	int  h = month + i;
            	int y = year;
				if(h > 12) {
					h -= 12;
					y += 1;
				}
				String xp = "P".concat(String.valueOf(h));
                if (h < 10) {
                    xp = "P0".concat(String.valueOf(h));
                }
                titles.add(xp);
                dateList.add(y+"-"+h);
			}
            
            dataMap.put("titles", titles);
            
            String yymk = pd.getNoneNULLString("yymk");
            
            List<Dict> dictList = DictUtils.getDictList("bb_qu_yymk");

			List<PageData> projectForecasts = reportService.findProjectForecastReport(pd);
            String[] yymkArray = yymk.split(",");
            for (int i = 0; i < yymkArray.length; i++) {
				String dicValue = yymkArray[i];
				PageData vpd = new PageData();
                vpd.put("var1", getDictNameOfValue(dictList, dicValue));
				
				for (int j = 0; j < dateList.size(); j++) {
					String d = dateList.get(j);
					String[] ss = d.split("-");
					String y = ss[0];
					String m = ss[1];
					Integer count = 0;
					for (PageData pf : projectForecasts) {
						
						if(pf.getNoneNULLString("dictVal").equals(dicValue)
								&& pf.getNoneNULLString("years").equals(y)
								&& pf.getNoneNULLString("re_month").equals(m)) {
							
							count = Integer.valueOf(String.valueOf(pf.get("num")));
							
							projectForecasts.remove(pf);
							break;
						}
						
					}

	                vpd.put("var" + (j + 2), count);
					
				}
				varList.add(vpd);
			}
            String[] word = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P"};
            PageData vpd = new PageData();
            vpd.put("var1", "区域合计");
            for (int j = 0; j < dateList.size(); j++) {
                String w = word[j + 1];
                vpd.put("var" + (j + 2), "=SUM(" + w + "5:" + w + "" + (yymkArray.length + 4) + ")");
            }
            varList.add(vpd);
            
            dataMap.put("varList", varList);
            inputReportExcelView erv = new inputReportExcelView();
            mv = new ModelAndView(erv, dataMap);
		} catch (Exception e) {
			e.printStackTrace();
		}
        
        return mv;
    }
    
    @RequestMapping(value = "sreachProjectForecastReport", produces = "text/html;charset=UTF-8")
    @ResponseBody
    public Object sreachProjectForecastReport() {
        PageData pd = this.getPageData();
        GsonOption option = new GsonOption();
        Echarts echarts = new Echarts();
        List<String> dateList = new ArrayList<String>();

        try {
            Date date = null;
            if (!"".equals(pd.getNoneNULLString("input_date"))) {
                date = DateUtil.fomatDate(pd.getNoneNULLString("input_date"));
            }
            if (date == null) {
                date = new Date();
            }
            
            int year = 1900 + date.getYear();
            int month = date.getMonth() + 1;
            
            String xAxisName = "(月份)";
            String yAxisName = "(项目数)";
            List<String> xAxis = new ArrayList<String>();

            for (int i = 1; i <= month; i++) {
                String xp = "P".concat(String.valueOf(i));
                if (i < 10) {
                    xp = "P0".concat(String.valueOf(i));
                }
                if(i == month) {
                	xp = "当月 " + xp;
                }
                xAxis.add(xp);
                dateList.add(year+"-"+i);
            }
            
            //后两个月
            for (int i = 1; i <= 2; i++) {
            	int  h = month + i;
            	int y = year;
				if(h > 12) {
					h -= 12;
					y += 1;
				}
				String xp = "P".concat(String.valueOf(h));
                if (h < 10) {
                    xp = "P0".concat(String.valueOf(h));
                }
                
                if(h < month) {
                	xp = y + " " + xp;
                }
                
                xAxis.add(xp);
                dateList.add(y+"-"+h);
			}
            
            String yymk = pd.getNoneNULLString("yymk");
            
            List<Dict> dictList = DictUtils.getDictList("bb_qu_yymk");

			List<PageData> projectForecasts = reportService.findProjectForecastReport(pd);
            String[] yymkArray = yymk.split(",");
            List<PageData> pfList = new ArrayList<PageData>();
            for (int i = 0; i < yymkArray.length; i++) {
				String dicValue = yymkArray[i];
				PageData pfpd = new PageData();
				pfpd.put("qy_module_name", getDictNameOfValue(dictList, dicValue));
				
				for (int j = 0; j < dateList.size(); j++) {
					String d = dateList.get(j);
					String x = xAxis.get(j);
					String[] ss = d.split("-");
					String y = ss[0];
					String m = ss[1];
					Integer count = 0;
					for (PageData pf : projectForecasts) {
						
						if(pf.getNoneNULLString("dictVal").equals(dicValue)
								&& pf.getNoneNULLString("years").equals(y)
								&& pf.getNoneNULLString("re_month").equals(m)) {
							
							count = Integer.valueOf(String.valueOf(pf.get("num")));
							
							projectForecasts.remove(pf);
							break;
						}
						
					}

					pfpd.put(x, count);
					
				}
				pfList.add(pfpd);
			}
            
            option = echarts.setOption(pfList, "qy_module_name", xAxis);
            echarts.setYAxisName(option, yAxisName);
            echarts.setXAxisName(option, xAxisName);

        } catch (Exception e) {
            e.printStackTrace();
        }
        //System.out.println(option.toString());
        return option.toString();
    }
    
    private String getDictNameOfValue(List<Dict> dictList, String v) {
    	for (Dict dict : dictList) {
			if(StringUtils.equals(dict.getValue(), v)) {
				return dict.getName();
			}
		}
    	return "";
    }
    
    /* ===============================用户查询权限================================== */
    public List<String> getRoleSelect() {
        Subject currentUser = SecurityUtils.getSubject(); // shiro管理的session
        Session session = currentUser.getSession();
        System.out.println("==================size: "+((List<String>)session.getAttribute(Const.SESSION_ROLE_SELECT)).size());
        return (List<String>) session.getAttribute(Const.SESSION_ROLE_SELECT);
    }

}
