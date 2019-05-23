package com.dncrm.common;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.servlet.ModelAndView;

import com.dncrm.util.Const;
import com.dncrm.util.PageData;
import com.dncrm.util.PathUtil;
import com.dncrm.util.StringUtil;
import com.dncrm.util.Tools;

public class getContractData {
	public static ModelAndView GetContractDevice(PageData pd,PageData kehu,List<PageData> listelev, List<PageData> listfkfs) throws Exception{
		ModelAndView mv = null;
		Map<String, Object> model = new HashMap<>();
		String HT_SFMD=pd.getString("HT_SFMD") != null?pd.getString("HT_SFMD"):"2";
		
		model.put("V001", pd.getString("HT_NO") != null?pd.getString("HT_NO"):"");
		model.put("V002", pd.getString("item_name") != null?pd.getString("item_name"):"");
		model.put("V003", pd.getString("selorder_org") != null?pd.getString("selorder_org"):"");
		model.put("V070", kehu.getString("name") != null?kehu.getString("name"):"");
		model.put("V004", kehu.getString("address") != null?kehu.getString("address"):"");
		model.put("V005", kehu.getString("phone") != null?kehu.getString("phone"):"");
		model.put("V006", kehu.getString("fax") != null?kehu.getString("fax"):"");
		model.put("V007", kehu.getString("postcode") != null?kehu.getString("postcode"):"");
		model.put("V008", kehu.getString("bank") != null?kehu.getString("bank"):"");
		model.put("V009", kehu.getString("bank_no") != null?kehu.getString("bank_no"):"");
		model.put("V010", kehu.getString("tax") != null?kehu.getString("tax"):"");
		model.put("V011", kehu.getString("contact") != null?kehu.getString("contact"):"");
		model.put("V013", kehu.getString("contact_phone") != null?kehu.getString("contact_phone"):"");
		model.put("V014", pd.getString("province_name") != null?pd.getString("province_name"):"");
		model.put("V015", pd.getString("city_name") != null?pd.getString("city_name"):"");
		model.put("V016", pd.getString("county_name") != null?pd.getString("county_name"):"");
		model.put("V017", pd.getString("address_info") != null?pd.getString("address_info"):"");
//		model.put("V026", CDList.get(0).get("customer_name"));
//		model.put("V027", CDList.get(0).get("customer_contact_ordinary"));
//		model.put("V028", CDList.get(0).get("contact_phone_ordinary"));
//		model.put("V029", CDList.get(0).get("item_install_address"));
		if(listelev.size() > 0) {
			List ll = new ArrayList();
			int j = 1;
			double t_xj = 0;
			for (int i = 0; i < listelev.size(); i++) {
				PageData pdel = listelev.get(i);
				Map<String, Object> submodel = new HashMap<>();
				submodel.put("VL01_01", j);
				submodel.put("VL01_02", pdel.getString("DT") != null?pdel.getString("DT"):"");
				submodel.put("VL01_03", pdel.getString("DT_TX") != null?pdel.getString("DT_TX"):"");
				submodel.put("VL01_04", pdel.getString("DT_CZM") != null?pdel.getString("DT_CZM"):"");
				submodel.put("VL01_05", "1");
				submodel.put("VL01_06", pdel.getString("DT_SBDJ") != null?pdel.getString("DT_SBDJ"):"");
				submodel.put("VL01_07", pdel.get("DT_XJ") != null?pdel.get("DT_XJ"):"");
				submodel.put("VL01_08", pdel.get("CJF") != null?pdel.get("CJF"):"");
				t_xj += Double.parseDouble(pdel.get("DT_XJ").toString());
				j++;
				ll.add(submodel);
			}
			model.put("list",ll);
			model.put("VL0101",NumberToCN.numtochinese(String.valueOf(t_xj)));
			model.put("VL0102",t_xj);
		}
		
		if(listfkfs.size() > 0) {
			List ff = new ArrayList();
			int j = 1;
			String fs="";
			String fsbl="";
			String fsje="";
			String fkts="";
			//String BAJBL=pd.getString("HT_ZBJBL");
			String MSQX=pd.getString("HT_MBQX");
			String TOTAL=pd.getString("TOTAL");
			//获取各种付款日期
			String SWXX_DJ_DAY=pd.getString("SWXX_DJ_DAY");//定金
			String SWXX_PCK_DAY=pd.getString("SWXX_PCK_DAY");//排产投产款
			String SWXX_FHK_DAY=pd.getString("SWXX_FHK_DAY");//发货款
			String SWXX_HDGDK_DAY=pd.getString("SWXX_HDGDK_DAY");//货到工地
			String SWXX_YSK_DAY=pd.getString("SWXX_YSK_DAY");//验收
			String SWXX_ZBJBL_DAY=pd.getString("SWXX_ZBJBL_DAY");//质保金
			
			for (int i = 0; i < listfkfs.size(); i++) {
				PageData pdel = listfkfs.get(i);
				Map<String, Object> submodel1 = new HashMap<>();
				fs=pdel.getString("FKFS_KX");
				fkts = pdel.getNoneNULLString("FKFS_FKTS");
				fsbl=pdel.getString("FKFS_FKBL");
				fsje=pdel.getString("FKFS_JE");
				if(fs.equals("1")) {
					submodel1.put("FK01_01", j+")第"+j+"期款：在本合同签订之日起"+fkts+"天内，甲方应向乙方支付本合同设备总价款的"+fsbl+""
							+ "%，计人民币（大写）："+NumberToCN.numtochinese(String.valueOf(fsje))+"。"
									+ "若合同履行，则定金抵作本合同的货款。甲方逾期给付的，则合同的交货期予以顺延。");
				}else if (fs.equals("2")) {
					submodel1.put("FK01_01", j+")第"+j+"期款：甲方须在提货前 "+fkts+"天之前，向乙方支付合同设备总价的"+fsbl+""
							+ "%，计人民币（大写）："+NumberToCN.numtochinese(String.valueOf(fsje))+"。作为投产款。"
									+ "甲方逾期给付的，则合同的预定交货期予以顺延。");
				}else if (fs.equals("3")) {
					submodel1.put("FK01_01", j+")第"+j+"期款：在满足工厂生产周期的前提下，甲方须在约定的交货日期前 "+fkts+"天之前，向乙方支付设备提货款，合同设备总价的"+fsbl+""
							+ "%，计人民币（大写）："+NumberToCN.numtochinese(String.valueOf(fsje))+"。乙方收到此款项后，根据本合同约定的交货周期安排发运。"
									+ "甲方逾期给付的，则合同的交货周期予以顺延。");
				}else if (fs.equals("4")){
					submodel1.put("FK01_01", j+")第"+j+"期款：货到工地"+fkts+"天内，甲方向乙方支付合同设备总价的"+fsbl+""
							+ "%，计人民币（大写）："+NumberToCN.numtochinese(String.valueOf(fsje))+"。作为货到工地款。"
									+ "甲方逾期给付的，则合同的交货周期予以顺延。");
				}else if (fs.equals("7")){
					submodel1.put("FK01_01", j+")第"+j+"期款：电梯安装调试完毕并经相关政府主管部门验收合格后"+fkts+"天内，甲方应向乙方支付本合同设备总价的"+fsbl+""
							+ "%，计人民币（大写）："+NumberToCN.numtochinese(String.valueOf(fsje))+"。作为验收合格后款。"
									+ "甲方逾期给付的，则合同的交货周期予以顺延。");
				}else  if (fs.equals("8")){
					submodel1.put("FK01_01", j+")第"+j+"期款：合同设备总价的"+fsbl+""
							+ "%，计人民币（大写）："+NumberToCN.numtochinese(String.valueOf(fsje))+"。作为质保金"
									+ ",甲方应在"+MSQX+"年质保期满后"+fkts+"天内支付给乙方。");
				}else {
					submodel1.put("FK01_01", " ");
				}
				j++;
				ff.add(submodel1);
			}
			model.put("list1",ff);
			
			model.put("FK01_02",j-1);
			model.put("FK01_04",TOTAL);
		}
		String strdlx;
		if(HT_SFMD.equals("1")) {
			 strdlx = PathUtil.getClasspath()+Const.FILEPATHFILE+"Contract/电（扶）梯设备买断销售合同常规梯&开发商修订版.docx";
		}else {
			 strdlx = PathUtil.getClasspath()+Const.FILEPATHFILE+"Contract/QR-HT01电（扶）梯设备定作合同修订版.docx";
		}
		
		String fileName = pd.getString("item_name");
		if(StringUtils.isBlank(fileName)) {
			fileName = "Document";
		}
		
		mv = new ModelAndView(new WordView(fileName,strdlx), model);
		return mv;
	}
	
	public static ModelAndView GetContractInstallation(PageData pd,PageData kehu,List<PageData> listelev, List<PageData> listfkfs) throws Exception{
		ModelAndView mv = null;
		Map<String, Object> model = new HashMap<>();
		model.put("V001", pd.getString("AZ_NO") != null?pd.getString("AZ_NO"):"");
		model.put("V002", pd.getString("item_name") != null?pd.getString("item_name"):"");
		model.put("V003", kehu.getString("name") != null?kehu.getString("name"):"");
		model.put("V004", kehu.getString("address") != null?kehu.getString("address"):"");
		model.put("V005", kehu.getString("phone") != null?kehu.getString("phone"):"");
		model.put("V006", kehu.getString("fax") != null?kehu.getString("fax"):"");
		model.put("V007", kehu.getString("postcode") != null?kehu.getString("postcode"):"");
		model.put("V008", kehu.getString("bank") != null?kehu.getString("bank"):"");
		model.put("V009", kehu.getString("bank_no") != null?kehu.getString("bank_no"):"");
		model.put("V010", kehu.getString("tax") != null?kehu.getString("tax"):"");
		model.put("V011", kehu.getString("contact") != null?kehu.getString("contact"):"");
		model.put("V013", kehu.getString("contact_phone") != null?kehu.getString("contact_phone"):"");
		model.put("V014", pd.getString("province_name") != null?pd.getString("province_name"):"");
		model.put("V015", pd.getString("city_name") != null?pd.getString("city_name"):"");
		model.put("V016", pd.getString("county_name") != null?pd.getString("county_name"):"");
		model.put("V017", pd.getString("address_info") != null?pd.getString("address_info"):"");
		model.put("V018", pd.getString("AZ_LXR") != null?pd.getString("AZ_LXR"):"");
		model.put("V019", pd.getString("AZ_LXDH") != null?pd.getString("AZ_LXDH"):"");
		if(listelev.size() > 0) {
			List ll = new ArrayList();
			int j = 1;
			double t_xj = 0;
			int t_num = 0;
			for (int i = 0; i < listelev.size(); i++) {
				PageData pdel = listelev.get(i);
				Map<String, Object> submodel = new HashMap<>();
				submodel.put("VL01_01", pd.getString("AZ_NO") != null?pd.getString("AZ_NO"):"");
				submodel.put("VL01_02", pdel.getString("DT") != null?pdel.getString("DT"):"");
				submodel.put("VL01_03", pdel.getString("DT_TX") != null?pdel.getString("DT_TX"):"");
				submodel.put("VL01_04", pdel.getString("DT_CZM") != null?pdel.getString("DT_CZM"):"");
				//submodel.put("VL01_05", pdel.getString("GD") != null?pdel.getString("GD"):"");
				submodel.put("VL01_05", pdel.getString("BJC_TSGD") != null?pdel.getString("BJC_TSGD"):"");
				submodel.put("VL01_06", "1");
				submodel.put("VL01_07", pdel.getString("DT_AZDJ") != null?pdel.getString("DT_AZDJ"):"");
				submodel.put("VL01_08", pdel.get("DT_AZDJ") != null?pdel.get("DT_AZDJ"):"");
				t_num += Integer.parseInt("1");
				t_xj += Double.parseDouble(pdel.get("DT_AZDJ").toString());
				j++;
				ll.add(submodel);
			}
			model.put("list",ll);
			model.put("VL0103",NumberToCN.numtochinese(String.valueOf(t_xj)));
			model.put("VL0102",t_xj);
			model.put("VL0101",t_num);
		}
		
		
		// 新增表格对需要显示的付款方式进行输出
		if(listfkfs.size() > 0) {
			List ff = new ArrayList();
			int j = 1;
			String fs="";
			String fsbl="";
			String fsje="";
			//免税期限
			String MSQX=pd.getString("AZ_MBQX");
			//获取各种安装合同付款日期
			String SWXX_FKBL_DJ_DAY=pd.getString("SWXX_FKBL_DJ_DAY");//定金
			//String SWXX_FKBL_FHQ_DAY=pd.getString("SWXX_FKBL_FHQ_DAY");//付款前
			String SWXX_FKBL_HDGD_DAY=pd.getString("SWXX_FKBL_HDGD_DAY");//货到工地
			String SWXX_FKBL_YSHG_DAY=pd.getString("SWXX_FKBL_YSHG_DAY");//验收
			String SWXX_FKBL_ZBJBL_DAY=pd.getString("SWXX_FKBL_ZBJBL_DAY");//质保金
		    //循环遍历对需要显示的付款方式行进赋值输出
			for (int i = 0; i < listfkfs.size(); i++) {
				PageData pdel = listfkfs.get(i);
				Map<String, Object> submodel1 = new HashMap<>();
				fs=pdel.getString("FKFS_KX");
				fsbl=pdel.getString("FKFS_FKBL");
				fsje=pdel.getString("FKFS_JE");
				if(fs.equals("1")) {
					submodel1.put("FK01_01", j+"、第"+j+"期款：在本合同签订之日起"+SWXX_FKBL_DJ_DAY+"天内，甲方应向乙方支付本合同总额的"+fsbl+""
							+ "%，计人民币（大写）："+NumberToCN.numtochinese(String.valueOf(fsje))+"整。"
									+ "作为合同定金。若合同履行，则定金抵作本合同的货款。");
				}else if (fs.equals("6")) {
					submodel1.put("FK01_01", j+"、第"+j+"期款：甲方在双方约定的安装开工日期前 "+SWXX_FKBL_HDGD_DAY+"天，向乙方支付安装费总额的"+fsbl+""
							+ "%，计人民币（大写）："+NumberToCN.numtochinese(String.valueOf(fsje))+"整。"
									+ "在收到款项且确认工地具备安装条件后，乙方安排发运，并于货到工地及甲方通知后10天内进场安装。");
				}else if (fs.equals("7")) {
					submodel1.put("FK01_01", j+"、第"+j+"期款：电（扶）梯安装调试完成，在通过政府部门验收合格后 "+SWXX_FKBL_YSHG_DAY+"日内， 甲方按照合同要求向乙方支付剩余的"+fsbl+""
							+ "%安装费，计人民币（大写）："+NumberToCN.numtochinese(String.valueOf(fsje))+"整。此款支付最迟不超过货到工地后4个月。"
									+ "乙方收到合同规定的款额后3日内与甲方办理电（扶）梯移交手续。");
				}else  if (fs.equals("8")){
					submodel1.put("FK01_01", j+"、第"+j+"期款：合同设备总价的"+fsbl+""
							+ "%，计人民币（大写）："+NumberToCN.numtochinese(String.valueOf(fsje))+"整。作为质保金"
									+ ",甲方应在"+MSQX+"年质保期满后"+SWXX_FKBL_ZBJBL_DAY+"天内支付给乙方。");
				}else {
					submodel1.put("FK01_01", " ");
				}
				j++;
				ff.add(submodel1);
			}
			//list对应word的表格，只有在wrod中表格形式才会循环输出
			model.put("list1",ff);
			
			
		}
		
		String fileName = pd.getString("item_name");
		if(StringUtils.isBlank(fileName)) {
			fileName = "Document";
		}
		
		String strdlx = PathUtil.getClasspath()+Const.FILEPATHFILE+"Contract/QR-HT04电（扶）梯设备安装合同修订版.docx";
		mv = new ModelAndView(new WordView(fileName,strdlx), model);
		return mv;
	}
	
	public static ModelAndView GetContractModify(PageData contractInfo, List<PageData> dtInfoList) throws Exception{
		ModelAndView mv = null;
		Map<String, Object> model = new HashMap<>();
		model.put("V001", contractInfo.get("squence"));
		model.put("V002", contractInfo.get("customer_name"));
//		model.put("V003", CMList.get(0).get("customer_name"));
		model.put("V004", contractInfo.get("ht_so_qdrq"));
		model.put("V007", contractInfo.get("item_name"));
		model.put("V008", contractInfo.get("ht_no"));
		model.put("V009", contractInfo.get("reason"));
		model.put("VL01_01", contractInfo.get("modify_number"));
		model.put("VL01_02", contractInfo.getNoneNULLString("prev_content"));
		model.put("VL01_03", contractInfo.getNoneNULLString("content"));
		List ll = new ArrayList();
		List ll2 = new ArrayList();
		Map<String, Object> submodel = new HashMap<>();
		
		double prevTotal = 0;
		double modifyTotal = 0;
		long changeTotal = 0;
		for (PageData mpd : dtInfoList) {
			String tx = mpd.getString("DT_TX");
			String cpmc = tx.substring(0, tx.indexOf(" ") == -1?0:tx.indexOf(" "));

			submodel = new HashMap<>();
			submodel.put("VL02_01", contractInfo.getNoneNULLString("prev_ht_no"));
			submodel.put("VL02_02", cpmc);
			submodel.put("VL02_03", tx);
			submodel.put("VL02_04", mpd.getString("DT_SBDJ"));
			submodel.put("VL02_05", "1");
			submodel.put("VL02_06", mpd.getString("DT_XJ"));
			ll.add(submodel);
			
			submodel = new HashMap<>();
			submodel.put("VL03_01", contractInfo.getString("modify_number"));
			submodel.put("VL03_02", cpmc);
			submodel.put("VL03_03", tx);
			submodel.put("VL03_04", mpd.getString("modify_sbdj"));
			submodel.put("VL03_05", "1");
			submodel.put("VL03_06", mpd.getString("modify_total"));
			ll2.add(submodel);
			
			String sbdj = mpd.getString("DT_SBDJ");
			String sbdjChange = mpd.getString("modify_sbdj");
			String azdj = mpd.getString("DT_AZDJ");
			String azdjChange = mpd.getString("modify_azdj");
			BigDecimal changeTotalDe = (new BigDecimal(sbdjChange).subtract(new BigDecimal(sbdj))).add(new BigDecimal(azdjChange).subtract(new BigDecimal(azdj)));
			changeTotal = changeTotalDe.longValue();
			
			prevTotal += Double.parseDouble(mpd.getString("DT_XJ"));
			modifyTotal += Double.parseDouble(mpd.getString("modify_total"));
		}
		model.put("VL0201", dtInfoList.size());
		model.put("VL0301", dtInfoList.size());
		model.put("VL0202", NumberToCN.numtochinese(String.valueOf(prevTotal)));
		model.put("VL0302", NumberToCN.numtochinese(String.valueOf(modifyTotal)));
		
		model.put("list",ll);
		model.put("list2",ll2);
		model.put("V011", changeTotal);
		model.put("V012", contractInfo.getNoneNULLString("date_deli"));
		
		String year = "";
		String month = "";
		String day = "";
		String qdrq = contractInfo.getNoneNULLString("ht_qdrq");
		if(StringUtil.isNoneBlank(qdrq)) {
			String[] qdrqArray = qdrq.split("-");
			year = Tools.getValueOfArray(qdrqArray, 0);
			month = Tools.getValueOfArray(qdrqArray, 1);
			day = Tools.getValueOfArray(qdrqArray, 2);
		}
		
		model.put("V013", year);
		model.put("V014", month);
		model.put("V015", day);
		
		model.put("V016", year);
		model.put("V017", month);
		model.put("V018", day);
		
		String strdlx = PathUtil.getClasspath()+Const.FILEPATHFILE+"Contract/变更协议模板.docx";
		mv = new ModelAndView(new WordView("Document",strdlx), model);
		return mv;
	}
	
	public static ModelAndView toPriceList(List<PageData> CodList) throws Exception{
		ModelAndView mv = null;
		Map<String, Object> model = new HashMap<>();
		
		List vls = new ArrayList();
		int T_BJC_SL = 0;
		double T_SBJ = 0;
		double T_BJC_AZF = 0;
		double T_BJC_YSF = 0;
		double T_DJ = 0;
		double T_BJC_SJBJ = 0;
		double T_BJC_TSF = 0;
		double T_BJC_CJF = 0;
		for(int i = 0;i<CodList.size();i++) {
			Map row = new HashMap();
			
			double ZHJ=0.00;
			if(CodList.get(i).getString("BJC_ZHJ")==null||"".equals(CodList.get(i).getString("BJC_ZHJ"))) {

			}else {
				ZHJ =Double.parseDouble(CodList.get(i).getString("BJC_ZHJ"))/Integer.parseInt(CodList.get(i).getString("BJC_SL"));//装潢价
			}
			double JCJ =Double.parseDouble(CodList.get(i).getString("BJC_SBJ"))/Integer.parseInt(CodList.get(i).getString("BJC_SL"));//基础价格
			
			double SBJ=JCJ+ZHJ; //设备价
			
			double AZJ=Double.parseDouble(CodList.get(i).getString("BJC_AZF"))/Integer.parseInt(CodList.get(i).getString("BJC_SL"));//安装价
			double YSJ=Double.parseDouble(CodList.get(i).getString("BJC_YSF"))/Integer.parseInt(CodList.get(i).getString("BJC_SL"));//运输价
			double DJ=AZJ+YSJ+SBJ;//最终单价
			
			row.put("BJC_ELEV", CodList.get(i).getString("BJC_ENO"));//梯号
			row.put("BJC_MODELS", CodList.get(i).getString("MODELS_NAME"));//型号
			row.put("BJC_ZZ", CodList.get(i).getString("BJC_ZZ_TBKD"));//载重
			row.put("BJC_SD", CodList.get(i).getString("BJC_SD"));//速度
			row.put("BJC_CZ", CodList.get(i).getString("BJC_CZ_QXJD"));//层站
			row.put("BJC_TSGD", CodList.get(i).get("BJC_TSGD_Q"));//提升高度
			row.put("BJC_SL", Integer.parseInt(CodList.get(i).getString("BJC_SL")));//数量
			T_BJC_SL += Integer.parseInt(CodList.get(i).getString("BJC_SL"));
			row.put("SBJ", new DecimalFormat(",##0.00").format(SBJ));//设备费单价
			T_SBJ += SBJ;
			row.put("BJC_AZF", new DecimalFormat(",##0.00").format(Double.parseDouble(CodList.get(i).getString("ELE_AZF"))/Integer.parseInt(CodList.get(i).getString("BJC_SL"))));//安装费
			T_BJC_AZF += Double.parseDouble(CodList.get(i).getString("ELE_AZF"))/Integer.parseInt(CodList.get(i).getString("BJC_SL"));
			row.put("BJC_YSF", new DecimalFormat(",##0.00").format(Double.parseDouble(CodList.get(i).getString("BJC_YSF"))/Integer.parseInt(CodList.get(i).getString("BJC_SL"))));//运输费
			T_BJC_YSF += Double.parseDouble(CodList.get(i).getString("BJC_YSF"))/Integer.parseInt(CodList.get(i).getString("BJC_SL"));
			row.put("DJ", new DecimalFormat(",##0.00").format(DJ));//单价
			T_DJ += DJ;
			row.put("BJC_SJBJ", new DecimalFormat(",##0.00").format(Double.parseDouble(CodList.get(i).getString("BJC_SJBJ"))));//总价
			T_BJC_SJBJ += Double.parseDouble(CodList.get(i).getString("BJC_SJBJ"));
			
			//调式费
			row.put("OTHP_TSF", new DecimalFormat(",##0.00").format(Double.parseDouble(CodList.get(i).getString("OTHP_TSF"))/Integer.parseInt(CodList.get(i).getString("BJC_SL"))));
			T_BJC_TSF += Double.parseDouble(CodList.get(i).getString("OTHP_TSF"))/Integer.parseInt(CodList.get(i).getString("BJC_SL"));
			//厂检费
			row.put("OTHP_CJF", new DecimalFormat(",##0.00").format(Double.parseDouble(CodList.get(i).getString("OTHP_CJF"))/Integer.parseInt(CodList.get(i).getString("BJC_SL"))));
			T_BJC_CJF += Double.parseDouble(CodList.get(i).getString("OTHP_CJF"))/Integer.parseInt(CodList.get(i).getString("BJC_SL"));
			
			vls.add(row);
		}
		model.put("VLS01", vls);
		model.put("T_BJC_SL", T_BJC_SL);
		model.put("T_SBJ", new DecimalFormat(",##0.00").format(T_SBJ));
		model.put("T_BJC_AZF", new DecimalFormat(",##0.00").format(T_BJC_AZF));
		model.put("T_BJC_YSF", new DecimalFormat(",##0.00").format(T_BJC_YSF));
		model.put("T_DJ", new DecimalFormat(",##0.00").format(T_DJ));
		model.put("T_BJC_SJBJ", new DecimalFormat(",##0.00").format(T_BJC_SJBJ));

		model.put("T_BJC_TSF", new DecimalFormat(",##0.00").format(T_BJC_TSF));
		model.put("T_BJC_CJF", new DecimalFormat(",##0.00").format(T_BJC_CJF));
		
        model.put("isUpdateFormula", "1");
		
//		mv = new ModelAndView(new ExcelView("filename","/Users/XeonChan/Documents/价格表模版.xlsx"), model);
		String strdlx = PathUtil.getClasspath()+Const.FILEPATHFILE+"价格表模版.xlsx";
		mv = new ModelAndView(new ExcelView("Document",strdlx), model);
		return mv;
	}
}
