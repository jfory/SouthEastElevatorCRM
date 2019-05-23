package com.dncrm.common;

public class Change {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		System.out.println(numtochinese("3234590.00"));
	}

	/**
	* @param args
	*/
	public static String numtochinese(String input) {
		String s1 = "零壹贰叁肆伍陆柒捌玖";
		String s4 = "分角整元拾佰仟万拾佰仟亿拾佰仟";
		String temp = "";
		String result = "";
		if (input == null)
			return "输入字串不是数字串只能包括以下字符（'0'～'9'，'.')，输入字串最大只能精确到仟亿，小数点只能两位！";
		temp = input.trim();
		float f;
		try {
			f = Float.parseFloat(temp);
		} catch (Exception e) {
			return "输入字串不是数字串只能包括以下字符（'0'～'9'，'.')，输入字串最大只能精确到仟亿，小数点只能两位！";
		}
		int len = 0;
		if (temp.indexOf(".") == -1)
			len = temp.length();
		else
			len = temp.indexOf(".");
		if (len > s4.length() - 3)
			return ("输入字串最大只能精确到仟亿，小数点只能两位！");
		int n1, n2 = 0;
		String num = "";
		String unit = "";
		for (int i = 0; i < temp.length(); i++) {
			if (i > len + 2) {
				break;
			}
			if (i == len) {
				continue;
			}
			n1 = Integer.parseInt(String.valueOf(temp.charAt(i)));
			num = s1.substring(n1, n1 + 1);
			n1 = len - i + 2;
			unit = s4.substring(n1, n1 + 1);
			result = result.concat(num).concat(unit);
		}
		if ((len == temp.length()) || (len == temp.length() - 1))
			result = result.concat("整");
		if (len == temp.length() - 2)
			result = result.concat("零分");
		
		result=result.replace("零角","");
		result=result.replace("零分","");
		
		return result;
	}
}
