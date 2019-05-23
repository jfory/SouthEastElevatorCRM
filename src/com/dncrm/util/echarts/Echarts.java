package com.dncrm.util.echarts;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import com.dncrm.util.Logger;
import com.dncrm.util.PageData;
import com.github.abel533.echarts.Legend;
import com.github.abel533.echarts.Option;
import com.github.abel533.echarts.axis.Axis;
import com.github.abel533.echarts.axis.CategoryAxis;
import com.github.abel533.echarts.axis.ValueAxis;
import com.github.abel533.echarts.code.Magic;
import com.github.abel533.echarts.code.MarkType;
import com.github.abel533.echarts.code.Tool;
import com.github.abel533.echarts.code.Trigger;
import com.github.abel533.echarts.data.PointData;
import com.github.abel533.echarts.feature.MagicType;
import com.github.abel533.echarts.json.GsonOption;
import com.github.abel533.echarts.series.Bar;
import com.github.abel533.echarts.series.Line;
import com.github.abel533.echarts.series.force.Category;

public class Echarts {

		
	public static void main(String[] args){
		test();
	}
	
	
	public static GsonOption test() {
        GsonOption option = new GsonOption();
        option.title().text("某地区蒸发量和降水量").subtext("纯属虚构");
        option.tooltip().trigger(Trigger.axis);
        option.legend("蒸发量", "降水量");
        option.toolbox().show(true).feature(Tool.mark, Tool.dataView, new MagicType(Magic.line, Magic.bar).show(true), Tool.restore, Tool.saveAsImage);
        option.calculable(true);
        option.xAxis(new CategoryAxis().data("1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月", "11月", "12月"));
        option.yAxis(new ValueAxis());

        Bar bar = new Bar("蒸发量");
        bar.data(2.0, 4.9, 7.0, 23.2, 25.6, 76.7, 135.6, 162.2, 32.6, 20.0, 6.4, 3.3);
        bar.markPoint().data(new PointData().type(MarkType.max).name("最大值"), new PointData().type(MarkType.min).name("最小值"));
        bar.markLine().data(new PointData().type(MarkType.average).name("平均值"));

        Bar bar2 = new Bar("降水量");
        List<Double> list = Arrays.asList(2.6, 5.9, 9.0, 26.4, 28.7, 70.7, 175.6, 182.2, 48.7, 18.8, 6.0, 2.3);
        bar2.setData(list);
        bar2.markPoint().data(new PointData("年最高", 182.2).xAxis(7).yAxis(183).symbolSize(18), new PointData("年最低", 2.3).xAxis(11).yAxis(3));
        bar2.markLine().data(new PointData().type(MarkType.average).name("平均值"));
        option.series(bar, bar2);
        System.out.println(option.toString());
        return option;
    }
	
	/**
	 *设置标题
	 *@param option GsonOption对象
	 *@param text 标题 
	 */
	public void setTitle(GsonOption option,String text){
		option.title().setText(text);
	}
	
	/**
	 *设置报表标题和子标题
	 *@param option GsonOption对象
	 *@param text 标题 
	 *@param subtext 子标题
	 */
	public void setTitle(GsonOption option,String text,String subtext){
		option.title().text(text).subtext(subtext);
	}
	
	/**
	 *设置报表纵坐标单位
	 *@param  option option对象
	 *@param name 纵坐标单位值
	 */
	public void setYAxisName(GsonOption option,String name){
		if(option.yAxis().size()>0){
			option.yAxis().get(0).name(name);
		}else{
			ValueAxis va = new ValueAxis();
			va.name(name);
			option.yAxis(va);
		}
	}
	
	/**
	 *设置报表横坐标单位
	 *@param  
	 */
	public void setXAxisName(GsonOption option,String name){
		if(option.xAxis().size()>0){
			option.xAxis().get(0).name(name);	
		}else{
			CategoryAxis ca = new CategoryAxis();
			ca.name(name);
			option.xAxis(ca);
		}
	}
	
	/**
	 *设置报表横坐标值为季度
	 *@param  
	 */
	public GsonOption setXAxisQuarter(GsonOption option){
		if(!(option.xAxis().size()>0)){
			CategoryAxis ca = new CategoryAxis();
			ca.data(1,2,3,4);
			option.xAxis(ca);
		}
		return option;
	}
	
	/**
	 *设置报表横坐标值为月份
	 *@param  
	 */
	public GsonOption setXAxisMonth(GsonOption option){
		if(!(option.xAxis().size()>0)){
			CategoryAxis ca = new CategoryAxis();
			ca.data(1,2,3,4,5,6,7,8,9,10,11,12);
			option.xAxis(ca);
		}
		return option;
	}
	
	/**
	 *设置横坐标 
	 */
	public void setXAxis(GsonOption option,String dateType){
		CategoryAxis ca = new CategoryAxis();
		if(dateType.equals("month")){
			ca.data(1,2,3,4,5,6,7,8,9,10,11,12);
			option.xAxis(new ArrayList<Axis>());
			option.xAxis(ca);
		}else if(dateType.equals("quarter")){
			ca.data(1,2,3,4);
			option.xAxis(new ArrayList<Axis>());
			option.xAxis(ca);
		}
	}
	
	
	/**
	 *生成option对象 
	 *@param pdList 查询结果集
	 *@param xAxis 结果集中报表横坐标依赖的数据库字段名
	 *@param seriesMap 结果集中报表数据依赖的数据库字段名 和 该字段名对应的legend
	 */
	public Map<String, Object> setOption(List<PageData> pdList,String xAxis,Map<String, String> seriesMap){
		Map<String, Object> data = new HashMap<String, Object>();
		List<Map<String, Object>> series  = new ArrayList<Map<String,Object>>();
		Map<String, Object> legendMap = new HashMap<String, Object>();
		List<String> legendList = new ArrayList<String>();
		Iterator<String> keys = seriesMap.keySet().iterator(); 
		
		while(keys.hasNext()) {
		   String key = (String) keys.next(); 
		   String value=seriesMap.get(key);
		   
		   legendList.add(key);
		   
		   Map<String, Object> map = new HashMap<String, Object>();
		   map.put("name", key);
		   List<String> seriesData = new ArrayList<String>();
		   for(PageData pd : pdList){
				seriesData.add(pd.get(value).toString());
		   }
		   map.put("data", seriesData);
		   series.add(map);
		}
		
		List<String> xAxisList = new ArrayList<String>();
		Map<String, Object> xAxisMap = new HashMap<String, Object>();
		for(PageData pd : pdList){
			xAxisList.add(pd.get(xAxis).toString());
		}
		legendMap.put("data", legendList);
		xAxisMap.put("data", xAxisList);
		data.put("series", series);
		data.put("legend", legendMap);
		data.put("xAxis", xAxisMap);
		return data;
	}
	
	
	
	public GsonOption setOption(List<PageData> list,Map<String, String> legendMap){
		//保存放回结果的option
		GsonOption option = new GsonOption();
		CategoryAxis ca = new CategoryAxis();
		try{
			
			Iterator<String> keys = legendMap.keySet().iterator(); 
			while(keys.hasNext()) {
			   String key = (String) keys.next(); 
			   String value=legendMap.get(key);
			   if(!key.equals("category")){
				   option.legend(key);
				   //创建bar
				   Bar bar = new Bar(key);
				   //创建line
				   Line line = new Line(key);
				   //循环结果集
				   for(PageData pd : list){
					   bar.data(pd.get(value).toString());
					   line.data(pd.get(value).toString());
				   }
				   option.series(bar);
				   option.series(line);
			   }else{
				 //循环结果集,
				   for(PageData pd : list){
					   ca.data(pd.get(value).toString());
				   }
			   }
			}
			option.xAxis(ca.name("xxxxx"));
		    option.yAxis(new ValueAxis());
	        option.toolbox().show(true).feature(Tool.mark, Tool.dataView, new MagicType(Magic.line, Magic.bar).show(false), Tool.restore, Tool.saveAsImage);
	        option.calculable(true);
	        option.tooltip().trigger(Trigger.axis);
		}catch(Exception e){
			System.out.println(e.getMessage());
		}
		return option;
	}
	
	
	public GsonOption setOption(List<PageData> list, String legendName, List<String> xAxis){
		//保存放回结果的option
		GsonOption option = new GsonOption();
		CategoryAxis ca = new CategoryAxis();
		try{
			//String module_name = "qy_module_name";
			
			for(PageData pd : list){
				//legend 
				String moduleName = pd.getString(legendName);
				option.legend(moduleName);
				Bar bar = new Bar(moduleName);
				//循环结果集
				for(String s : xAxis){
					bar.data(pd.get(s));
					//line.data(pd.get(value).toString());
				}
			   option.series(bar);
				
			}
			Object[] xAxisArray = new String[xAxis.size()];
			ca.data(xAxis.toArray(xAxisArray));
			
			option.xAxis(ca.name("xxxxx"));
		    option.yAxis(new ValueAxis());
	        option.toolbox().show(true).feature(Tool.mark, Tool.dataView, new MagicType(Magic.line, Magic.bar).show(true), Tool.restore, Tool.saveAsImage);
	        option.calculable(true);
	        option.tooltip().trigger(Trigger.axis);
		}catch(Exception e){
			System.out.println(e.getMessage());
		}
		return option;
	}
	
	
}
