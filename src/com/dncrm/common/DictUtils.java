package com.dncrm.common;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;

import com.alibaba.fastjson.JSON;
import com.dncrm.entity.Dict;
import com.dncrm.service.system.dict.DictService;
import com.dncrm.util.SpringContextHolder;

/**
 * 字典工具类
 */
public class DictUtils {
	
	private static DictService dictService = SpringContextHolder.getBean(DictService.class);

	public static final String CACHE_DICT_MAP = "dictMap";
	
	public static String getDictLabel(String value, String type, String defaultValue){
		if (StringUtils.isNotBlank(type) && StringUtils.isNotBlank(value)){
			for (Dict dict : getDictList(type)){
				if (type.equals(dict.getType()) && value.equals(dict.getValue())){
					return dict.getName();
				}
			}
		}
		return defaultValue;
	}
	
	public static String getDictLabels(String values, String type, String defaultValue){
		if (StringUtils.isNotBlank(type) && StringUtils.isNotBlank(values)){
			List<String> valueList = new ArrayList<String>();
			for (String value : StringUtils.split(values, ",")){
				valueList.add(getDictLabel(value, type, defaultValue));
			}
			return StringUtils.join(valueList, ",");
		}
		return defaultValue;
	}

	public static String getDictValue(String label, String type, String defaultLabel){
		if (StringUtils.isNotBlank(type) && StringUtils.isNotBlank(label)){
			for (Dict dict : getDictList(type)){
				if (type.equals(dict.getType()) && label.equals(dict.getName())){
					return dict.getValue();
				}
			}
		}
		return defaultLabel;
	}
	
	public static List<Dict> getDictList(String type){
		/*@SuppressWarnings("unchecked")
		Map<String, List<Dict>> dictMap = (Map<String, List<Dict>>)CacheUtils.get(CACHE_DICT_MAP);
		if (dictMap==null){
			dictMap = Maps.newHashMap();
			for (Dict dict : dictDao.findAllList(new Dict())){
				List<Dict> dictList = dictMap.get(dict.getType());
				if (dictList != null){
					dictList.add(dict);
				}else{
					dictMap.put(dict.getType(), Lists.newArrayList(dict));
				}
			}
			CacheUtils.put(CACHE_DICT_MAP, dictMap);
		}
		List<Dict> dictList = dictMap.get(type);*/
		List<Dict> dictList = null;
		try {
			dictList = dictService.findForType(type);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (dictList == null){
			dictList = new ArrayList<Dict>();
		}
		return dictList;
	}
	
	/**
	 * 返回字典列表（JSON）
	 * @param type
	 * @return
	 */
	public static String getDictListJson(String type){
		return JSON.toJSONString(getDictList(type));
	}
	
}
