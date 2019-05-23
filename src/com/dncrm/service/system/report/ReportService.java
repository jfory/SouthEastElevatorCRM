package com.dncrm.service.system.report;

import com.dncrm.dao.DaoSupport;
import com.dncrm.entity.Indicator.IndicatorModel;
import com.dncrm.util.PageData;
import net.sf.json.JSONArray;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.*;

@Service("reportService")
public class ReportService {

    @Resource(name = "daoSupport")
    private DaoSupport dao;

    public void insertIndicatorBatch(List<IndicatorModel> indicatorModels) throws Exception {
        dao.save("IndicatorMapper.insertIndicatorBatch", indicatorModels);
    }

    public PageData selectIndicatorByCondition(PageData pageData) throws Exception {
        List<PageData> list = (List<PageData>) dao.findForList("IndicatorMapper.selectIndicatorByCondition", pageData);
        if (list == null || list.size() == 0) {
            return null;
        }
        return list.get(0);
    }

    public List<PageData> customerYearNum() throws Exception {
        return (List<PageData>) dao.findForList("ReportMapper.customerYearNum", "");
    }

    public List<PageData> customerMonthNum(String year) throws Exception {
        return (List<PageData>) dao.findForList("ReportMapper.customerMonthNum", year);
    }

    public List<PageData> customerQuarterNum(String year) throws Exception {
        return (List<PageData>) dao.findForList("ReportMapper.customerQuarterNum", year);
    }

    public List<PageData> findInputReport(PageData pd) throws Exception {
        return (List<PageData>) dao.findForList("ReportMapper.findInputReport", pd);
    }
    
    public PageData listContractReport(PageData pd) throws Exception {
        // TODO Auto-generated method stub

        PageData contractRS = (PageData) dao.findForObject("ReportMapper.listContractReport", pd);
        PageData ItemRS = (PageData) dao.findForObject("ReportMapper.listItemReport", pd);
        contractRS.putAll(ItemRS);
        return contractRS;

    }
    
  //根据区域name获取id （导入）
	 public PageData findDepartmentByName(PageData pd) throws Exception {
	        return (PageData) dao.findForObject("ReportMapper.findDepartmentByName", pd);
	    }
	 
	 /**
	     * 保存新增
	     *
	     * @param pd the pd
	     * @throws Exception the exception
	     */
	    public void saveS(PageData pd) throws Exception {
	        dao.save("ReportMapper.saveS", pd);
	    }

    public List<PageData> findItemTrendRepor(PageData pd) throws Exception {
        return (List<PageData>) dao.findForList("ReportMapper.findItemTrendRepor", pd);
    }
    
    public List<PageData> findcontractRollingRepor(PageData pd) throws Exception {
        return (List<PageData>) dao.findForList("ReportMapper.findcontractRollingRepor", pd);
    }
    
    /**
     * 递归获取所有子节点公司信息
     *
     * @param result
     * @param data
     */
    private void getAllSubCompany(List<PageData> result, List<PageData> data) throws Exception {
        for (PageData pageData : data) {
            PageData temp = new PageData();
            temp.put("parentId", pageData.getNoneNULLString("id"));
            temp.put("type", "10");
            List<PageData> subAreaData = (List<PageData>) dao
                    .findForList("DepartmentMapper.selectDepartmentByCondition", temp);
            if (subAreaData == null || subAreaData.isEmpty()) {
                result.add(pageData);
            } else {

                getAllSubCompany(result, subAreaData);
            }
        }
    }

    @SuppressWarnings("unchecked")
	public Map<String, Map<String, int[][]>> printItemDetailRepor(PageData pd) throws Exception {
        Map<String, Map<String, int[][]>> map = new HashMap<>();
        //查询营销区域
        PageData areaPageData = new PageData();
        areaPageData.put("type", "8");
        List<PageData> areaData = (List<PageData>) dao.findForList("DepartmentMapper.getDepartmentsByType", areaPageData);
        for (PageData area : areaData) {
            //筛选营销中心四个区域
            if (area.getNoneNULLString("name").endsWith("营销中心")) {
                //根据营销中心的ID查找所有最底层子公司节点
                List<PageData> result = new ArrayList<>();
                PageData pageData = new PageData();
                pageData.put("parentId", area.getNoneNULLString("id"));
                pageData.put("type", "10");
                List<PageData> data = (List<PageData>) dao.findForList("DepartmentMapper.selectDepartmentByCondition", pageData);
                getAllSubCompany(result, data);
                Map<String, int[][]> subMap = new HashMap<>();
                for (PageData subArea : result) {
                    int count[][] = new int[12][3];
                    //获取子公司的全年新增梯种
                    pd.put("department_id", subArea.getNoneNULLString("id"));
                    pd.put("indicator_year", Calendar.getInstance().get(Calendar.YEAR));
                    PageData indicatorData = selectIndicatorByCondition(pd);
                    if (indicatorData == null) {
                        count[0][2] = 0;
                    } else {
                        count[0][2] = indicatorData.getNoneNULLString("indicator_num")
                                .isEmpty() ? 0 : Integer.parseInt(indicatorData
                                .getNoneNULLString("indicator_num"));
                    }
                    //根据子公司的ID，获取所有相关的项目
                    pd.put("item_sub_branch", subArea.getNoneNULLString("id"));
                    List<PageData> items = (List<PageData>) dao
                            .findForList("ItemMapper.findItemsByCondition", pd);
                    //构造12个月的数组，分别记录每个公司从第1月到12月的项目报备明细记录（项目数和台数）以及全年新增梯种
                    for (PageData itemData : items) {
                        //根据跟进状态进行筛选
                        if (!itemData.getNoneNULLString("GJ_json").isEmpty()) {
                            JSONArray GJ_JSON = JSONArray.fromObject(itemData.getNoneNULLString("GJ_json"));
                            if (!pd.getNoneNULLString("genjinstatus").isEmpty()) {
                                //获取跟进状态
                                if (GJ_JSON == null || GJ_JSON.size() == 0 ||
                                        !GJ_JSON.getJSONObject(GJ_JSON.size() - 1).has("genjinstatus") ||
                                        GJ_JSON.getJSONObject(GJ_JSON.size() - 1).getString("genjinstatus").isEmpty()) {
                                    //不限制跟进状态类型
                                } else {
                                    if (!pd.getNoneNULLString("genjinstatus")
                                            .equals(GJ_JSON.getJSONObject(GJ_JSON.size() - 1)
                                                    .getString("genjinstatus"))) {
                                        //不符合选中的跟进状态条件
                                        continue;
                                    }
                                }
                            }
                        }
                        String inputDate = itemData.getNoneNULLString("input_date");
                        Date date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(inputDate);
                        Calendar calendar = Calendar.getInstance();
                        calendar.setTime(date);
                        //查找项目下的电梯信息
                        pd.remove("item_sub_branch");
                        pd.put("item_id", itemData.getNoneNULLString("item_id"));
                        List<PageData> elevatorInfoData = (List<PageData>) dao
                                .findForList("ElevatorInfoMapper.findElevatorDetailsListByCondition", pd);
                        if (elevatorInfoData.size() > 0) {
                            //对应月份的项目数添加1
                            count[calendar.get(Calendar.MONTH)][0]++;
                            //对应月份的电梯台数
                            count[calendar.get(Calendar.MONTH)][1] += elevatorInfoData.size();
                        }
                    }
                    subMap.put(subArea.getNoneNULLString("name"), count);
                }
                map.put(area.getNoneNULLString("name"), subMap);

            }
        }
        return map;
    }

	public int[][] listItemRolling(PageData pd) throws Exception {
        // TODO Auto-generated method stub
		
		
		@SuppressWarnings("unchecked")
		List<PageData> list = (List<PageData>) dao.findForList("ReportMapper.listItemRolling", pd);
		String Resarea = "";
		String genjinStatus ="";
		int[][] rsMap = new int[8][10];

		for (PageData respd : list) {
			Resarea = respd.getNoneNULLString("depname");
			genjinStatus =respd.getNoneNULLString("gjstatus");
			rsMap = ItemRollingcount(Resarea,genjinStatus,rsMap);

		}
		
        return rsMap;

    }
	
	public int[][] ItemRollingcount(String Resarea,String genjinStatus,int[][]rs) {
		switch (Resarea) {
		case "东区营销中心":
			//跟进状态判断
			Resarea = "0";
			break;
		case "南区营销中心":
			//跟进状态判断
			Resarea = "1";
			break;
		case "西区营销中心":
			//跟进状态判断
			Resarea = "2";
			break;
		case "北区营销中心":
			//跟进状态判断
			Resarea = "3";
			break;
		case "苏州多美适":
			//跟进状态判断
			Resarea = "4";
			break;
		case "国际部":
			//跟进状态判断
			Resarea = "5";
			break;
		case "战略客户部":
			//跟进状态判断
			Resarea = "6";
			break;
		case "军民融合部":
			//跟进状态判断
			Resarea = "7";
			break;
		}
		for (int i = 0; i < 8; i++) {
			for (int j = 0; j <10; j++) {
				if (Resarea.equals(String.valueOf(i)) && genjinStatus.equals(String.valueOf(j+1))) {
					rs[i][j] = rs[i][j]+1;
				}
			}
			
		}
		return rs;
		
	}
<<<<<<< HEAD
	
	public int[] listItemRollingByCondition(PageData pd) throws Exception {
		
		@SuppressWarnings("unchecked")
		List<PageData> list = (List<PageData>) dao.findForList("ReportMapper.listItemRolling", pd);
		int diushi = 0;
		int yanchi = 0;
		int kaocharuwei = 0;
		int zuizhongruwei = 0;
		int zhongbiaotongzhishu = 0;
		int hetongtanpan = 0;
		int hetongpingshen = 0;
		int dengdaidingjin = 0;
		int dingjinfuchu = 0;
		int dingjinshoudao = 0;
		
		for (PageData rs : list) {
			switch (rs.getNoneNULLString("gjstatus")) {
			case "1":
				diushi+=1;
				break;
			case "2":
				yanchi+=1;
				break;
			case "3":
				kaocharuwei+=1;
				break;
			case "4":
				zuizhongruwei+=1;
				break;
			case "5":
				zhongbiaotongzhishu+=1;
				break;
			case "6":
				hetongtanpan+=1;
				break;
			case "7":
				hetongpingshen+=1;
				break;
			case "8":
				dengdaidingjin+=1;
				break;
			case "9":
				dingjinfuchu+=1;
				break;
			case "10":
				dingjinshoudao+=1;
				break;
			default:
				break;
			}
		}
		int res[] = new int[] {diushi,yanchi,kaocharuwei,zuizhongruwei,zhongbiaotongzhishu,
				hetongtanpan,hetongpingshen,dengdaidingjin,dingjinfuchu,dingjinshoudao};
		return res;
=======
	public int[] listItemRollingByCondition(PageData pd) throws Exception {
		
		List<PageData> list = (List<PageData>) dao.findForList("ReportMapper.listItemRollingByCondition", pd);
		return null;
>>>>>>> 84ecd0dc1cb9b626ed6f32a72eec5d5a6005d642
	}


	public void saveProjectForecastForList(List<PageData> savePd) throws Exception {
		if(savePd != null && savePd.size() > 0) {
			for (PageData pd : savePd) {
				saveS(pd);
			}
		}
	}

	//获取项目预测数据
	public List<PageData> findProjectForecastReport(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("ReportMapper.findProjectForecastReport", pd);
	}

}
