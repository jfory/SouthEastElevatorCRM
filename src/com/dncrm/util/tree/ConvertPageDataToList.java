package com.dncrm.util.tree;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.dncrm.util.PageData;
import com.dncrm.util.StringUtil;
import com.dncrm.util.Tools;

public class ConvertPageDataToList {
	
	public static List<HashMap<String, String>>make(List<PageData> pageDatas){
		//构建多叉数
        List<HashMap<String, String>> dataList = new ArrayList<HashMap<String, String>>();
        for (PageData pageData : pageDatas) {
        	HashMap<String, String> dataRecord = new HashMap<String, String>();
        	dataRecord.put("id", (String) pageData.get("id"));
        	dataRecord.put("name", (String)pageData.get("name"));
			dataRecord.put("parentId", (String)pageData.get("parentId"));
			dataRecord.put("orderNo", pageData.get("orderNo").toString());
			dataList.add(dataRecord);
		}
		return dataList;
	}
	public static List<HashMap<String, String>>makeWithNodeType(List<PageData> pageDatas,String nodeType){
		//构建多叉数
		List<HashMap<String, String>> dataList = new ArrayList<HashMap<String, String>>();
		for (PageData pageData : pageDatas) {
			HashMap<String, String> dataRecord = new HashMap<String, String>();
			dataRecord.put("id", (String) pageData.get("id"));
			dataRecord.put("name", (String)pageData.get("name"));
			dataRecord.put("parentId", (String)pageData.get("parentId"));
			dataRecord.put("orderNo", Integer.toString((Integer)pageData.get("orderNo")));
			dataRecord.put("nodeType", nodeType);
			dataList.add(dataRecord);
		}
		return dataList;
	}
	public static List<HashMap<String, String>>makeIncludeNodeType(List<PageData> pageDatas){
		//构建多叉数
		List<HashMap<String, String>> dataList = new ArrayList<HashMap<String, String>>();
		for (PageData pageData : pageDatas) {
			HashMap<String, String> dataRecord = new HashMap<String, String>();
			dataRecord.put("id", (String) pageData.get("id"));
			dataRecord.put("name", (String)pageData.get("name"));
			dataRecord.put("parentId", (String)pageData.get("parentId"));
			dataRecord.put("orderNo", Integer.toString((Integer)pageData.get("orderNo")));
			dataRecord.put("nodeType",(String)pageData.get("nodeType"));
			dataList.add(dataRecord);
		}
		return dataList;
	}
	public static List<HashMap<String, String>>makeWithNodeTypeAndIconSkin(List<PageData> pageDatas,HashMap<String,String> skins){
		//构建多叉数
		List<HashMap<String, String>> dataList = new ArrayList<HashMap<String, String>>();
		for (PageData pageData : pageDatas) {
			HashMap<String, String> dataRecord = new HashMap<String, String>();
			dataRecord.put("id", (String) pageData.get("id"));
			dataRecord.put("name", (String)pageData.get("name"));
			dataRecord.put("parentId", (String)pageData.get("parentId"));
			dataRecord.put("orderNo", Integer.toString((Integer)pageData.get("orderNo")));

			String nodeType = (String)pageData.get("nodeType");
			dataRecord.put("nodeType",nodeType);
			if (skins.containsKey(nodeType)){
				dataRecord.put("iconSkin","\""+skins.get(nodeType)+"\"");
			}else{
				dataRecord.put("iconSkin",null);
			}
			dataList.add(dataRecord);
		}
		return dataList;
	}
	public static List<HashMap<String, String>>makeWithNodeTypeAndIconSkin2(List<PageData> pageDatas,String skin,String nodeType){
		//构建多叉数
		List<HashMap<String, String>> dataList = new ArrayList<HashMap<String, String>>();
		for (PageData pageData : pageDatas) {
			HashMap<String, String> dataRecord = new HashMap<String, String>();
			dataRecord.put("id", (String) pageData.get("id"));
			dataRecord.put("name", (String)pageData.get("name"));
			dataRecord.put("parentId", (String)pageData.get("parentId"));
			dataRecord.put("orderNo", Integer.toString((Integer)pageData.get("orderNo")));
			dataRecord.put("nodeType",nodeType);
			dataRecord.put("iconSkin","\""+skin+"\"");
			dataList.add(dataRecord);
		}
		return dataList;
	}
	
	public static List<HashMap<String, String>>makeWithNodeTypeAndIconSkin3(List<PageData> pageDatas,HashMap<String,String> skins){
		//构建多叉数
		List<HashMap<String, String>> dataList = new ArrayList<HashMap<String, String>>();
		for (PageData pageData : pageDatas) {
			HashMap<String, String> dataRecord = new HashMap<String, String>();
			dataRecord.put("id", (String) pageData.get("id"));
			dataRecord.put("name", (String)pageData.get("name"));
			dataRecord.put("parentId", (String)pageData.get("parentId"));
			dataRecord.put("orderNo", (String)pageData.get("orderNo"));

			String nodeType = (String)pageData.get("type");
			dataRecord.put("nodeType", nodeType);
			if (skins.containsKey(nodeType)){
				dataRecord.put("iconSkin","\""+skins.get(nodeType)+"\"");
			}else{
				dataRecord.put("iconSkin",null);
			}
			dataList.add(dataRecord);
		}
		return dataList;
	}
	
	
	public static List<HashMap<String, String>>makeWithType(List<PageData> pageDatas){
		//构建多叉数
        List<HashMap<String, String>> dataList = new ArrayList<HashMap<String, String>>();
        for (PageData pageData : pageDatas) {
        	HashMap<String, String> dataRecord = new HashMap<String, String>();
        	dataRecord.put("id", (String) pageData.get("id"));
        	dataRecord.put("name", (String)pageData.get("name"));
			dataRecord.put("parentId", (String)pageData.get("parentId"));
			dataRecord.put("orderNo", pageData.get("orderNo").toString());
			dataRecord.put("nodeType", pageData.get("type").toString());
			dataList.add(dataRecord);
		}
		return dataList;
	}
}
