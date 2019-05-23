package com.dncrm.common;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.dncrm.entity.Dict;
import com.dncrm.entity.nonstandrad.NonS;
import com.dncrm.entity.nonstandrad.NonStandardBean;
import com.dncrm.entity.nonstandrad.NormalNonStandardBean;
import com.dncrm.util.Const;
import com.dncrm.util.PageData;
import com.dncrm.util.PathUtil;
import com.dncrm.util.Tools;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

public class getCODdata {

    //飞尚有机
    public static ModelAndView GetFEI_SHANG(List<PageData> CodList) throws Exception {
        ModelAndView mv = null;
        PageData pd = CodList.get(0);
        Map<String, Object> model = new HashMap<>();
        model.put("HT_NO", pd.get("HT_NO"));
        model.put("BJC_SL", pd.get("BJC_SL"));
        model.put("BJC_ENO", pd.get("BJC_ENO"));
        model.put("user_name", pd.getNoneNULLString("user_name"));
        model.put("TJTTH", pd.get("TJTTH") != null ? pd.get("TJTTH") : "");
        model.put("OFFER_VERSION", StringUtils.isBlank(pd.getString("offer_version")) ? "01" : pd.get("offer_version"));
        model.put("name", pd.get("name"));
        model.put("customer_name", pd.getNoneNULLString("customer_name"));
        model.put("end_name", pd.getNoneNULLString("end_name"));
        model.put("item_name", pd.get("item_name"));
        model.put("HT_JHRQ", pd.get("HT_JHRQ"));
        model.put("V011", pd.get("BZ_ZZ"));
        model.put("V012", pd.get("BZ_SD"));
        model.put("V013", pd.get("BZ_KMXS"));
        model.put("G01", "  ");
        model.put("G02", "  ");
        model.put("G03", "  ");
        model.put("G04", "  ");
        if (pd.getString("BASE_KZFS") != null && pd.getString("BASE_KZFS").indexOf("单台") > -1) model.put("G01", " √ ");
        if (pd.getString("BASE_KZFS") != null && pd.getString("BASE_KZFS").indexOf("两台并联") > -1)
            model.put("G02", " √ ");
        if (pd.getString("BASE_KZFS") != null && pd.getString("BASE_KZFS").indexOf("三台群控") > -1)
            model.put("G03", " √ ");
        if (pd.getString("BASE_KZFS") != null && pd.getString("BASE_KZFS").indexOf("四台群控") > -1)
            model.put("G04", " √ ");
        model.put("G05", "  ");
        model.put("G06", "  ");
        model.put("G07", "  ");
        if (pd.getString("BASE_JDJG") != null && pd.getString("BASE_JDJG").indexOf("全混凝土") > -1)
            model.put("G05", " √ ");
        if (pd.getString("BASE_JDJG") != null && pd.getString("BASE_JDJG").indexOf("框架结构") > -1)
            model.put("G06", " √ ");
        if (pd.getString("BASE_JDJG") != null && pd.getString("BASE_JDJG").indexOf("钢结构") > -1) model.put("G07", " √ ");
        model.put("G08", "  ");
        model.put("G09", "  ");
        model.put("G10", "  ");
        model.put("G11", "  ");
        model.put("G99", "  ");
        model.put("G100", "  ");
        model.put("G101", "  ");
        if (pd.getString("BASE_JXGD") != null && pd.getString("BASE_JXGD").indexOf("1000kg-2300mm") > -1)
            model.put("G08", " √ ");
        if (pd.getString("BASE_JXGD") != null && pd.getString("BASE_JXGD").indexOf("2000~3000kg-2200mm") > -1)
            model.put("G09", " √ ");
        if (pd.getString("BASE_JXGD") != null && pd.getString("BASE_JXGD").indexOf("4000~5000kg-2400mm") > -1)
            model.put("G11", " √ ");
        if (pd.getString("BASE_JXGD") != null && pd.getString("BASE_JXGD").indexOf("2000~3000kg-2300mm") > -1)
            model.put("G10", " √ ");
        if (pd.getString("BASE_JXGD") != null && pd.getString("BASE_JXGD").indexOf("2000~3000kg-2400mm") > -1)
            model.put("G99", " √ ");
        if (pd.getString("BASE_JXGD") != null && pd.getString("BASE_JXGD").indexOf("4000~5000kg-2500mm") > -1)
            model.put("G100", " √ ");
        if (pd.getString("BASE_JXGD") != null && pd.getString("BASE_JXGD").indexOf("4000~5000kg-2600mm") > -1)
            model.put("G101", " √ ");
        if (pd.getString("BASE_MLX") != null) {
            model.put("G12", " √ ");
        } else {
            model.put("G12", "  ");
        }
        if (pd.getString("BASE_MBH") != null) {
            model.put("G120", " √ ");
        } else {
            model.put("G120", "  ");
        }
        model.put("G13", "  ");
        model.put("G14", "  ");
        model.put("V029", "");
        if (pd.getString("BASE_JDCZQHD") != null && pd.getString("BASE_JDCZQHD").equals("250")) {
            model.put("G13", " √ ");
        } else {
            model.put("G14", " √ ");
            model.put("V029", pd.getString("BASE_JDCZQHD"));
        }
        model.put("G15", "  ");
        model.put("G16", "  ");
        model.put("G17", "  ");
        model.put("G18", "  ");
        model.put("G19", "  ");
        model.put("G20", "  ");
        model.put("G21", "  ");
        model.put("G22", "  ");
        model.put("G23", "  ");
        model.put("G24", "  ");
        model.put("G25", "  ");
        model.put("G26", "  ");
        model.put("G27", "  ");
        model.put("G28", "  ");
        if (pd.getString("OPT_XFLD") != null && pd.getString("OPT_XFLD").equals("1")) model.put("G15", " √ ");
        if (pd.getString("OPT_SJCZ") != null && pd.getString("OPT_SJCZ").equals("1")) model.put("G16", " √ ");
        if (pd.getString("OPT_XFYYX") != null && pd.getString("OPT_XFYYX").equals("1")) model.put("G17", " √ ");
        if (pd.getString("OPT_SZTJMSJ") != null && pd.getString("OPT_SZTJMSJ").equals("1")) model.put("G18", " √ ");
        if (pd.getString("OPT_JXDZZ") != null && pd.getString("OPT_JXDZZ").equals("1")) model.put("G19", " √ ");
        if (pd.getString("OPT_BAJK") != null && pd.getString("OPT_BAJK").equals("1")) model.put("G20", " √ ");
        if (pd.getString("OPT_CCTVDL") != null && pd.getString("OPT_CCTVDL").equals("1")) model.put("G21", " √ ");
        if (pd.getString("OPT_YYBZ") != null && pd.getString("OPT_YYBZ").equals("1")) model.put("G22", " √ ");
        if (pd.getString("OPT_TDYJJY") != null && pd.getString("OPT_TDYJJY").equals("1")) model.put("G23", " √ ");
        if (pd.getString("OPT_FDLCZ") != null && pd.getString("OPT_FDLCZ").equals("1")) model.put("G24", " √ ");
        if (pd.getString("OPT_DJGRBH") != null && pd.getString("OPT_DJGRBH").equals("1")) model.put("G25", " √ ");
        if (pd.getString("OPT_XJX") != null && pd.getString("OPT_XJX").equals("1")) model.put("G26", " √ ");
        if (pd.getString("OPT_WLW") != null && pd.getString("OPT_WLW").equals("1")) model.put("G27", " √ ");
        if (pd.getString("OPT_JJBYDYCZZZ") != null && pd.getString("OPT_JJBYDYCZZZ").equals("1"))
            model.put("G28", " √ ");
        model.put("G29", "  ");
        model.put("G30", "  ");
        if ("分线制".equals(pd.getString("DZJKSDJXT_DJTXFS"))) model.put("G29", " √ ");
        if ("总线制".equals(pd.getString("DZJKSDJXT_DJTXFS"))) model.put("G30", " √ ");
        model.put("G31", "  ");
        model.put("G32", "  ");
        model.put("G33", "  ");
        model.put("G34", "  ");
        model.put("G35", "  ");
        model.put("G36", "  ");
        model.put("G37", "  ");
        model.put("G38", "  ");
        if (pd.getString("JXZH_JM") != null && pd.getString("JXZH_JM").indexOf("喷涂") > -1) model.put("G31", " √ ");
        if (pd.getString("JXZH_JM") != null && pd.getString("JXZH_JM").indexOf("不锈钢") > -1) model.put("G32", " √ ");
        if (pd.getString("JXZH_QWB") != null && pd.getString("JXZH_QWB").indexOf("喷涂") > -1) model.put("G33", " √ ");
        if (pd.getString("JXZH_QWB") != null && pd.getString("JXZH_QWB").indexOf("不锈钢") > -1) model.put("G34", " √ ");
        if (pd.getString("JXZH_CWB") != null && pd.getString("JXZH_CWB").indexOf("喷涂") > -1) model.put("G35", " √ ");
        if (pd.getString("JXZH_CWB") != null && pd.getString("JXZH_CWB").indexOf("不锈钢") > -1) model.put("G36", " √ ");
        if (pd.getString("JXZH_HWB") != null && pd.getString("JXZH_HWB").indexOf("喷涂") > -1) model.put("G37", " √ ");
        if (pd.getString("JXZH_HWB") != null && pd.getString("JXZH_HWB").indexOf("不锈钢") > -1) model.put("G38", " √ ");
        model.put("G39", "  ");
        model.put("G40", "  ");
        if (pd.getString("JXZH_JDZH") != null && pd.getString("JXZH_JDZH").indexOf("悬吊式") > -1) model.put("G39", " √ ");
        if (pd.getString("JXZH_JDZH") != null && pd.getString("JXZH_JDZH").indexOf("单顶式") > -1) model.put("G40", " √ ");
        model.put("G41", "  ");
        model.put("G42", "  ");
        model.put("G43", "  ");
        if (pd.getString("JXZH_DBXH") != null && pd.getString("JXZH_DBXH").indexOf("PVC地板革") < 0 && pd.getString("JXZH_DBXH").indexOf("碳钢花纹钢板") < 0) {
            model.put("G43", " √ ");
            model.put("V062", pd.getString("JXZH_DBXH"));
        } else {
            if (pd.getString("JXZH_DBXH") != null && pd.getString("JXZH_DBXH").indexOf("PVC地板革") > -1)
                model.put("G41", " √ ");
            if (pd.getString("JXZH_DBXH") != null && pd.getString("JXZH_DBXH").indexOf("碳钢花纹钢板") > -1)
                model.put("G42", " √ ");
            model.put("V062", "  ");
        }
        model.put("G44", "  ");
        model.put("G45", "  ");
        if (pd.getString("JXZH_FZTXH") != null) {
            model.put("G45", " √ ");
            model.put("V063", pd.getString("JXZH_FZTXH"));
        } else {
            model.put("G44", " √ ");
            model.put("V063", "");
        }
        model.put("G46", "  ");
        model.put("G47", "  ");
        model.put("G48", "  ");
        if (pd.getString("JXZH_FZTAZWZ1") != null && pd.getString("JXZH_FZTAZWZ1").indexOf("后围壁") > -1)
            model.put("G46", " √ ");
        if (pd.getString("JXZH_FZTAZWZ2") != null && pd.getString("JXZH_FZTAZWZ2").indexOf("左围壁") > -1)
            model.put("G47", " √ ");
        if (pd.getString("JXZH_FZTAZWZ3") != null && pd.getString("JXZH_FZTAZWZ3").indexOf("右围壁") > -1)
            model.put("G48", " √ ");
        model.put("G49", "  ");
        model.put("G50", "  ");
        if (pd.getString("TMMT_SCTMMT") != null && pd.getString("TMMT_SCTMMT").indexOf("喷涂") > -1)
            model.put("G49", " √ ");
        if (pd.getString("TMMT_SCTMMT") != null && pd.getString("TMMT_SCTMMT").indexOf("不锈钢") > -1)
            model.put("G50", " √ ");
        model.put("G51", "  ");
        model.put("G52", "  ");
        if (pd.getString("TMMT_FSCTMMT") != null && pd.getString("TMMT_FSCTMMT").indexOf("喷涂") > -1)
            model.put("G51", " √ ");
        if (pd.getString("TMMT_FSCTMMT") != null && pd.getString("TMMT_FSCTMMT").indexOf("不锈钢") > -1)
            model.put("G52", " √ ");
        model.put("G53", "  ");
        model.put("G54", "  ");
        model.put("V078", "  ");
        model.put("V079", "  ");
        model.put("V080", "  ");
        model.put("V081", "  ");
        model.put("V082", "  ");
        model.put("V083", "  ");
        if (pd.getString("CZP_CZPXH") != null && pd.getString("CZP_CZPXH").indexOf("JFCOP19H-C") > -1) {
            model.put("G53", " √ ");
            model.put("V078", pd.getString("CZP_XS"));
            model.put("V079", pd.getString("CZP_AN"));
            model.put("V080", pd.getString("CZP_CZ"));
        }
        if (pd.getString("CZP_CZPXH") != null && pd.getString("CZP_CZPXH").indexOf("JFCOP19H-E") > -1) {
            model.put("G54", " √ ");
            model.put("V081", pd.getString("CZP_XS"));
            model.put("V082", pd.getString("CZP_AN"));
            model.put("V083", pd.getString("CZP_CZ"));
        }
        model.put("G55", pd.getString("CZP_CZPWZ"));
        if (pd.getString("CZP_CZPWZ") != null && pd.getString("CZP_CZPWZ").indexOf("左前") > -1) model.put("G55", " √ ");
        if (pd.getString("CZP_CZPWZ") != null && pd.getString("CZP_CZPWZ").indexOf("深轿厢") > -1) model.put("G56", " √ ");
        if (pd.getString("CZP_CZPWZ") != null && pd.getString("CZP_CZPWZ").indexOf("左侧") > -1) model.put("G57", " √ ");
        if (pd.getString("CZP_CZPWZ") != null && pd.getString("CZP_CZPWZ").indexOf("左前") > -1) model.put("G58", " √ ");
        model.put("G59", "  ");
        model.put("G60", "  ");
        model.put("V092", "  ");
        model.put("V093", "  ");
        model.put("V094", "  ");
        model.put("V095", "  ");
        model.put("V096", "  ");
        model.put("V097", "  ");
        if (pd.getString("TMXHZZ_TWZHXH") != null && pd.getString("TMXHZZ_TWZHXH").indexOf("JFCOP19H-C1") > -1) {
            model.put("G59", " √ ");
            model.put("V092", pd.getString("TMXHZZ_XS"));
            model.put("V093", pd.getString("TMXHZZ_AN"));
            model.put("V094", pd.getString("TMXHZZ_CZ"));

            /*model.put("V098", pd.getString("TMXHZZ_ZDJC"));
            model.put("V099", pd.getString("TMXHZZ_MCGS"));
            model.put("V100", pd.getString("TMXHZZ_FJSM"));
            model.put("V102", "  ");
            model.put("V103", "  ");
            model.put("V104", "  ");*/
        }
        if (pd.getString("TMXHZZ_TWZHXH") != null && pd.getString("TMXHZZ_TWZHXH").indexOf("JFCOP19H-E1") > -1) {
            model.put("G60", " √ ");
            model.put("V095", pd.getString("TMXHZZ_XS"));
            model.put("V096", pd.getString("TMXHZZ_AN"));
            model.put("V097", pd.getString("TMXHZZ_CZ"));

            /*model.put("V098", "  ");
            model.put("V099", "  ");
            model.put("V100", "  ");
            model.put("V102", pd.getString("TMXHZZ_ZDJC"));
            model.put("V103", pd.getString("TMXHZZ_MCGS"));
            model.put("V104", pd.getString("TMXHZZ_FJSM"));*/
        }
        model.put("G70", "");
        model.put("G71", "");
        if ("1".equals(pd.getString("TMXHZZ_TWZHXS"))) {
            model.put("G70", " √ ");

            model.put("V098", pd.getString("TMXHZZ_ZDJC"));
            model.put("V099", pd.getString("TMXHZZ_MCGS"));
            model.put("V100", pd.getString("TMXHZZ_FJSM"));
            model.put("V102", "  ");
            model.put("V103", "  ");
            model.put("V104", "  ");
        } else if ("2".equals(pd.getString("TMXHZZ_TWZHXS"))) {
            model.put("G71", " √ ");

            model.put("V098", "  ");
            model.put("V099", "  ");
            model.put("V100", "  ");
            model.put("V102", pd.getString("TMXHZZ_ZDJC"));
            model.put("V103", pd.getString("TMXHZZ_MCGS"));
            model.put("V104", pd.getString("TMXHZZ_FJSM"));
        } else {
            model.put("V098", "");
            model.put("V099", "");
            model.put("V100", "");
            model.put("V102", "");
            model.put("V103", "");
            model.put("V104", "");
        }

        model.put("V027", pd.get("BASE_KMKD"));
        model.put("V031", pd.get("BZ_C"));
        model.put("V032", pd.get("BZ_Z"));
        model.put("V033", pd.get("BZ_M"));
        model.put("BASE_KZXT", pd.get("BASE_KZXT"));
        model.put("V014", pd.get("BASE_KZFS"));
        model.put("BASE_YYZJ", pd.get("BASE_YYZJ"));
        model.put("V024", pd.get("BASE_QGLJJ"));
        model.put("V026", pd.get("BASE_JXGG"));
        model.put("V027", pd.get("BASE_KMCC"));
        model.put("V028", pd.get("BASE_JXRKSL"));
        model.put("V034", pd.get("BASE_JDK"));
        model.put("V035", pd.get("BASE_JDS"));
        model.put("V030", pd.get("BASE_TSGD"));
        model.put("V036", pd.get("BASE_DKSD"));
        model.put("V037", pd.get("BASE_DCGD"));
        //model.put("V035", pd.get("BASE_JDZG"));
        model.put("V038", pd.get("BASE_JZZT"));
        model.put("V039", pd.get("BASE_LCBJ"));
//		model.put("???", pd.get("BASE_DGZJ"));
//		model.put("???", pd.get("OPT_SZTJMSJ"));
//		model.put("???", pd.get("OPT_TWXFYFW"));
//		model.put("???", pd.get("OPT_LOPAN"));
//		model.put("?", pd.get("OPT_LOPANGS"));
//		model.put("?", pd.get("OPT_GTJX"));
//		model.put("?", pd.get("OPT_GTCS"));
        model.put("V056", pd.get("DZJKSDJXT_DJDDTTS"));
        model.put("V057", "");

        if (pd.getString("JXZH_JM") != null && pd.getString("JXZH_JM").indexOf("不锈钢") > -1) {
            model.put("V058", "  ");
        } else {
            model.put("V058", pd.get("JXZH_JMSBH"));
        }

        if (pd.getString("JXZH_QWB") != null && pd.getString("JXZH_QWB").indexOf("不锈钢") > -1) {
            model.put("V059", "  ");
        } else {
            model.put("V059", pd.get("JXZH_QWBSBH"));
        }

        if (pd.getString("JXZH_CWB") != null && pd.getString("JXZH_CWB").indexOf("不锈钢") > -1) {
            model.put("V060", "  ");
        } else {
            model.put("V060", pd.get("JXZH_CWBSBH"));
        }

        if (pd.getString("JXZH_HWB") != null && pd.getString("JXZH_HWB").indexOf("不锈钢") > -1) {
            model.put("V061", "  ");
        } else {
            model.put("V061", pd.get("JXZH_HWBSBH"));
        }

//		model.put("???", pd.get("JXZH_BXGDD"));
//		model.put("???", pd.get("JXZH_BXGDB"));
//		model.put("???", pd.get("JXZH_BGJ"));
        model.put("JXZH_DBZXHD", pd.get("JXZH_DBZXHD"));
//		model.put("???", pd.get("TMMT_FWBXGTM"));
//		model.put("???", pd.get("TMMT_FWBXGXMT"));
//		model.put("???", pd.get("TMMT_DMT"));
        model.put("V072", " ");
        if (pd.getString("TMMT_SCTMMT") != null && pd.getString("TMMT_SCTMMT").indexOf("不锈钢") > -1) {
            model.put("V072", " ");
        } else if (pd.getString("TMMT_SCTMMT") != null && pd.getString("TMMT_SCTMMT").indexOf("喷涂") > -1) {
            model.put("V072", pd.get("TMMT_SCSBH"));
        }

        if (pd.getString("TMMT_SCTMMT") != null && pd.getString("TMMT_SCTMMT").indexOf("喷涂") > -1) {
            model.put("V073", pd.get("TMMT_SCSL"));
            model.put("V074", " ");
        } else if (pd.getString("TMMT_SCTMMT") != null && pd.getString("TMMT_SCTMMT").indexOf("不锈钢") > -1) {
            model.put("V073", " ");
            model.put("V074", pd.get("TMMT_SCSL"));
        }

        if (pd.getString("TMMT_FSCTMMT") != null && pd.getString("TMMT_FSCTMMT").indexOf("喷涂") > -1) {
            model.put("V076", pd.get("TMMT_FSCSL"));
            model.put("V077", " ");

        } else if (pd.getString("TMMT_FSCTMMT") != null && pd.getString("TMMT_FSCTMMT").indexOf("不锈钢") > -1) {
            model.put("V076", " ");
            model.put("V077", pd.get("TMMT_FSCSL"));
        }

        model.put("V075", " ");
        if (pd.getString("TMMT_FSCTMMT") != null && pd.getString("TMMT_FSCTMMT").indexOf("不锈钢") > -1) {
            model.put("V075", " ");
        } else if (pd.getString("TMMT_FSCTMMT") != null && pd.getString("TMMT_FSCTMMT").indexOf("喷涂") > -1) {
            model.put("V075", pd.get("TMMT_FSCSBH"));
        }

        model.put("G61", "1".equals(pd.get("OPT_TWXFYFW")) ? " √ " : "");
        model.put("G62", pd.getNoneNULLString("OPT_LOPAN"));
        model.put("G63", pd.getNoneNULLString("OPT_LOPANGS"));
        model.put("G64", "1".equals(pd.get("OPT_GTJX")) ? " √ " : "");

        model.put("G65", pd.getNoneNULLString("TMMT_PTDMT"));
        model.put("G66", pd.getNoneNULLString("DMT_SL"));
        model.put("G67", pd.getNoneNULLString("FSC_DMT"));
        model.put("G68", pd.getNoneNULLString("FSC_DMT_SL"));

        model.put("CZP_CZPLX", pd.get("CZP_CZPLX"));
        model.put("TMXHZZ_TWZHLX", pd.get("TMXHZZ_TWZHLX"));
        model.put("TMXHZZ_TWZHXS", pd.get("TMXHZZ_TWZHXS"));

        //常规非标
        setCGFBWordList(model, pd);
        setCgfb(model, pd);

        model.put("BZ01", pd.getString("DT_REMARK") != null ? pd.getString("DT_REMARK") : "");
        String unstd = pd.getString("UNSTD");
        JSONArray jsonA = JSON.parseArray(unstd);

        setFBXQWordList(model, pd, jsonA);

        String strdlx = PathUtil.getClasspath() + Const.FILEPATHFILE + "COD/飞尚GL freight_COD.docx";
        mv = new ModelAndView(new WordView("GL freight_COD", strdlx), model);
        return mv;
    }

    //飞尚无机
    public static ModelAndView GetFEI_SHANG_MRL(List<PageData> CodList) throws Exception {
        ModelAndView mv = null;
        PageData pd = CodList.get(0);
        Map<String, Object> model = new HashMap<>();
        model.put("HT_NO", pd.get("HT_NO"));
        model.put("BJC_SL", pd.get("BJC_SL"));
        model.put("BJC_ENO", pd.get("BJC_ENO"));
        model.put("user_name", pd.getNoneNULLString("user_name"));
        model.put("TJTTH", pd.get("TJTTH") != null ? pd.get("TJTTH") : "");
        model.put("OFFER_VERSION", StringUtils.isBlank(pd.getString("offer_version")) ? "01" : pd.get("offer_version"));
        model.put("name", pd.get("name"));
        model.put("customer_name", pd.getNoneNULLString("customer_name"));
        model.put("end_name", pd.getNoneNULLString("end_name"));
        model.put("item_name", pd.get("item_name"));
        model.put("HT_JHRQ", pd.get("HT_JHRQ"));
        model.put("V011", pd.get("BZ_ZZ"));
        model.put("V012", pd.get("BZ_SD"));
        model.put("V013", pd.get("BZ_KMXS"));
        model.put("G01", "  ");
        model.put("G02", "  ");
        model.put("G03", "  ");
        model.put("G04", "  ");
        if (pd.getString("BASE_KZFS") != null && pd.getString("BASE_KZFS").indexOf("单台") > -1) model.put("G01", " √ ");
        if (pd.getString("BASE_KZFS") != null && pd.getString("BASE_KZFS").indexOf("两台并联") > -1)
            model.put("G02", " √ ");
        if (pd.getString("BASE_KZFS") != null && pd.getString("BASE_KZFS").indexOf("三台群控") > -1)
            model.put("G03", " √ ");
        if (pd.getString("BASE_KZFS") != null && pd.getString("BASE_KZFS").indexOf("四台群控") > -1)
            model.put("G04", " √ ");
        model.put("G05", "  ");
        model.put("G06", "  ");
        model.put("G07", "  ");
        if (pd.getString("BASE_JDJG") != null && pd.getString("BASE_JDJG").indexOf("全混凝土") > -1)
            model.put("G05", " √ ");
        if (pd.getString("BASE_JDJG") != null && pd.getString("BASE_JDJG").indexOf("框架结构") > -1)
            model.put("G06", " √ ");
        if (pd.getString("BASE_JDJG") != null && pd.getString("BASE_JDJG").indexOf("钢结构") > -1) model.put("G07", " √ ");
        model.put("G08", "  ");
        model.put("G09", "  ");
        model.put("G10", "  ");
        model.put("G11", "  ");
        model.put("G99", "  ");
        model.put("G100", "  ");
        model.put("G101", "  ");
        if (pd.getString("BASE_JXGD") != null && pd.getString("BASE_JXGD").indexOf("1000kg-2300mm") > -1)
            model.put("G08", " √ ");
        if (pd.getString("BASE_JXGD") != null && pd.getString("BASE_JXGD").indexOf("2000~3000kg-2200mm") > -1)
            model.put("G09", " √ ");
        if (pd.getString("BASE_JXGD") != null && pd.getString("BASE_JXGD").indexOf("4000~5000kg-2400mm") > -1)
            model.put("G11", " √ ");
        if (pd.getString("BASE_JXGD") != null && pd.getString("BASE_JXGD").indexOf("2000~3000kg-2300mm") > -1)
            model.put("G10", " √ ");
        if (pd.getString("BASE_JXGD") != null && pd.getString("BASE_JXGD").indexOf("2000~3000kg-2400mm") > -1)
            model.put("G99", " √ ");
        if (pd.getString("BASE_JXGD") != null && pd.getString("BASE_JXGD").indexOf("4000~5000kg-2500mm") > -1)
            model.put("G100", " √ ");
        if (pd.getString("BASE_JXGD") != null && pd.getString("BASE_JXGD").indexOf("4000~5000kg-2600mm") > -1)
            model.put("G101", " √ ");
        if (pd.getString("BASE_MLX") != null) {
            model.put("G12", " √ ");
        } else {
            model.put("G12", "  ");
        }
        if (pd.getString("BASE_MBH") != null) {
            model.put("G120", " √ ");
        } else {
            model.put("G120", "  ");
        }
        model.put("G13", "  ");
        model.put("G14", "  ");
        model.put("V029", "");
        if (pd.getString("BASE_JDCZQHD") != null && pd.getString("BASE_JDCZQHD").equals("250")) {
            model.put("G13", " √ ");
        } else {
            model.put("G14", " √ ");
            model.put("V029", pd.getString("BASE_JDCZQHD"));
        }
        model.put("G15", "  ");
        model.put("G16", "  ");
        model.put("G17", "  ");
        model.put("G18", "  ");
        model.put("G19", "  ");
        model.put("G20", "  ");
        model.put("G21", "  ");
        model.put("G22", "  ");
        model.put("G23", "  ");
        model.put("G24", "  ");
        model.put("G25", "  ");
        model.put("G26", "  ");
        model.put("G27", "  ");
        model.put("G28", "  ");
        if (pd.getString("OPT_XFLD") != null && pd.getString("OPT_XFLD").equals("1")) model.put("G15", " √ ");
        if (pd.getString("OPT_SJCZ") != null && pd.getString("OPT_SJCZ").equals("1")) model.put("G16", " √ ");
        if (pd.getString("OPT_XFYYX") != null && pd.getString("OPT_XFYYX").equals("1")) model.put("G17", " √ ");
        if ("1".equals(pd.getString("OPT_SZTJMSJ"))) model.put("G18", " √ ");
        if (pd.getString("OPT_JXDZZ") != null && pd.getString("OPT_JXDZZ").equals("1")) model.put("G19", " √ ");
        if (pd.getString("OPT_BAJK") != null && pd.getString("OPT_BAJK").equals("1")) model.put("G20", " √ ");
        if (pd.getString("OPT_CCTVDL") != null && pd.getString("OPT_CCTVDL").equals("1")) model.put("G21", " √ ");
        if (pd.getString("OPT_YYBZ") != null && pd.getString("OPT_YYBZ").equals("1")) model.put("G22", " √ ");
        if (pd.getString("OPT_TDYJJY") != null && pd.getString("OPT_TDYJJY").equals("1")) model.put("G23", " √ ");
        if (pd.getString("OPT_FDLCZ") != null && pd.getString("OPT_FDLCZ").equals("1")) model.put("G24", " √ ");
        if (pd.getString("OPT_DJGRBH") != null && pd.getString("OPT_DJGRBH").equals("1")) model.put("G25", " √ ");
        if (pd.getString("OPT_XJX") != null && pd.getString("OPT_XJX").equals("1")) model.put("G26", " √ ");
        if (pd.getString("OPT_WLW") != null && pd.getString("OPT_WLW").equals("1")) model.put("G27", " √ ");
        if (pd.getString("OPT_JJBYDYCZZZ") != null && pd.getString("OPT_JJBYDYCZZZ").equals("1"))
            model.put("G28", " √ ");
        model.put("G29", "  ");
        model.put("G30", "  ");
        if (pd.getString("DZJKSDJXT_DJTXFS") != null && pd.getString("DZJKSDJXT_DJTXFS").equals("分线制"))
            model.put("G29", " √ ");
        if (pd.getString("DZJKSDJXT_DJTXFS") != null && pd.getString("DZJKSDJXT_DJTXFS").equals("总线制"))
            model.put("G30", " √ ");
        model.put("G31", "  ");
        model.put("G32", "  ");
        model.put("G33", "  ");
        model.put("G34", "  ");
        model.put("G35", "  ");
        model.put("G36", "  ");
        model.put("G37", "  ");
        model.put("G38", "  ");
        if (pd.getString("JXZH_JM") != null && pd.getString("JXZH_JM").indexOf("喷涂") > -1) model.put("G31", " √ ");
        if (pd.getString("JXZH_JM") != null && pd.getString("JXZH_JM").indexOf("不锈钢") > -1) model.put("G32", " √ ");
        if (pd.getString("JXZH_QWB") != null && pd.getString("JXZH_QWB").indexOf("喷涂") > -1) model.put("G33", " √ ");
        if (pd.getString("JXZH_QWB") != null && pd.getString("JXZH_QWB").indexOf("不锈钢") > -1) model.put("G34", " √ ");
        if (pd.getString("JXZH_CWB") != null && pd.getString("JXZH_CWB").indexOf("喷涂") > -1) model.put("G35", " √ ");
        if (pd.getString("JXZH_CWB") != null && pd.getString("JXZH_CWB").indexOf("不锈钢") > -1) model.put("G36", " √ ");
        if (pd.getString("JXZH_HWB") != null && pd.getString("JXZH_HWB").indexOf("喷涂") > -1) model.put("G37", " √ ");
        if (pd.getString("JXZH_HWB") != null && pd.getString("JXZH_HWB").indexOf("不锈钢") > -1) model.put("G38", " √ ");
        model.put("G39", "  ");
        model.put("G40", "  ");
        if (pd.getString("JXZH_JDZH") != null && pd.getString("JXZH_JDZH").indexOf("悬吊式") > -1) model.put("G39", " √ ");
        if (pd.getString("JXZH_JDZH") != null && pd.getString("JXZH_JDZH").indexOf("单顶式") > -1) model.put("G40", " √ ");
        model.put("G41", "  ");
        model.put("G42", "  ");
        model.put("G43", "  ");
        if (pd.getString("JXZH_DBXH") != null && pd.getString("JXZH_DBXH").indexOf("PVC地板革") < 0 && pd.getString("JXZH_DBXH").indexOf("碳钢花纹钢板") < 0) {
            model.put("G43", " √ ");
            model.put("V062", pd.getString("JXZH_DBXH"));
        } else {
            if (pd.getString("JXZH_DBXH") != null && pd.getString("JXZH_DBXH").indexOf("PVC地板革") > -1)
                model.put("G41", " √ ");
            if (pd.getString("JXZH_DBXH") != null && pd.getString("JXZH_DBXH").indexOf("碳钢花纹钢板") > -1)
                model.put("G42", " √ ");
            model.put("V062", "  ");
        }
        model.put("G44", "  ");
        model.put("G45", "  ");
        if (pd.getString("JXZH_FZTXH") != null) {
            model.put("G45", " √ ");
            model.put("V063", pd.getString("JXZH_FZTXH"));
        } else {
            model.put("G44", " √ ");
            model.put("V063", "");
        }
        model.put("G46", "  ");
        model.put("G47", "  ");
        model.put("G48", "  ");
        if (pd.getString("JXZH_FZTAZWZ1") != null && pd.getString("JXZH_FZTAZWZ1").indexOf("后围壁") > -1)
            model.put("G46", " √ ");
        if (pd.getString("JXZH_FZTAZWZ2") != null && pd.getString("JXZH_FZTAZWZ2").indexOf("左围壁") > -1)
            model.put("G47", " √ ");
        if (pd.getString("JXZH_FZTAZWZ3") != null && pd.getString("JXZH_FZTAZWZ3").indexOf("右围壁") > -1)
            model.put("G48", " √ ");
        model.put("G49", "  ");
        model.put("G50", "  ");
        if (pd.getString("TMMT_SCTMMT") != null && pd.getString("TMMT_SCTMMT").indexOf("喷涂") > -1)
            model.put("G49", " √ ");
        if (pd.getString("TMMT_SCTMMT") != null && pd.getString("TMMT_SCTMMT").indexOf("不锈钢") > -1)
            model.put("G50", " √ ");
        model.put("G51", "  ");
        model.put("G52", "  ");
        if (pd.getString("TMMT_FSCTMMT") != null && pd.getString("TMMT_FSCTMMT").indexOf("喷涂") > -1)
            model.put("G51", " √ ");
        if (pd.getString("TMMT_FSCTMMT") != null && pd.getString("TMMT_FSCTMMT").indexOf("不锈钢") > -1)
            model.put("G52", " √ ");
        model.put("G53", "  ");
        model.put("G54", "  ");
        model.put("V078", "  ");
        model.put("V079", "  ");
        model.put("V080", "  ");
        model.put("V081", "  ");
        model.put("V082", "  ");
        model.put("V083", "  ");
        if (pd.getString("CZP_CZPXH") != null && pd.getString("CZP_CZPXH").indexOf("JFCOP19H-C") > -1) {
            model.put("G53", " √ ");
            model.put("V078", pd.getString("CZP_XS"));
            model.put("V079", pd.getString("CZP_AN"));
            model.put("V080", pd.getString("CZP_CZ"));
        }
        if (pd.getString("CZP_CZPXH") != null && pd.getString("CZP_CZPXH").indexOf("JFCOP19H-E") > -1) {
            model.put("G54", " √ ");
            model.put("V081", pd.getString("CZP_XS"));
            model.put("V082", pd.getString("CZP_AN"));
            model.put("V083", pd.getString("CZP_CZ"));
        }
        model.put("G55", pd.getString("CZP_CZPWZ"));
        if (pd.getString("CZP_CZPWZ") != null && pd.getString("CZP_CZPWZ").indexOf("左前") > -1) model.put("G55", " √ ");
        if (pd.getString("CZP_CZPWZ") != null && pd.getString("CZP_CZPWZ").indexOf("深轿厢") > -1) model.put("G56", " √ ");
        if (pd.getString("CZP_CZPWZ") != null && pd.getString("CZP_CZPWZ").indexOf("左侧") > -1) model.put("G57", " √ ");
        if (pd.getString("CZP_CZPWZ") != null && pd.getString("CZP_CZPWZ").indexOf("左前") > -1) model.put("G58", " √ ");
        model.put("G59", "  ");
        model.put("G60", "  ");
        model.put("V092", "  ");
        model.put("V093", "  ");
        model.put("V094", "  ");
        model.put("V095", "  ");
        model.put("V096", "  ");
        model.put("V097", "  ");
        if (pd.getString("TMXHZZ_TWZHXH") != null && pd.getString("TMXHZZ_TWZHXH").indexOf("JFCOP19H-C1") > -1) {
            model.put("G59", " √ ");
            model.put("V092", pd.getString("TMXHZZ_XS"));
            model.put("V093", pd.getString("TMXHZZ_AN"));
            model.put("V094", pd.getString("TMXHZZ_CZ"));

            /*model.put("V098", pd.getString("TMXHZZ_ZDJC"));
            model.put("V099", pd.getString("TMXHZZ_MCGS"));
            model.put("V100", pd.getString("TMXHZZ_FJSM"));
            model.put("V102", "  ");
            model.put("V103", "  ");
            model.put("V104", "  ");*/
        }
        if (pd.getString("TMXHZZ_TWZHXH") != null && pd.getString("TMXHZZ_TWZHXH").indexOf("JFCOP19H-E1") > -1) {
            model.put("G60", " √ ");
            model.put("V095", pd.getString("TMXHZZ_XS"));
            model.put("V096", pd.getString("TMXHZZ_AN"));
            model.put("V097", pd.getString("TMXHZZ_CZ"));

            /*model.put("V098", "  ");
            model.put("V099", "  ");
            model.put("V100", "  ");
            model.put("V102", pd.getString("TMXHZZ_ZDJC"));
            model.put("V103", pd.getString("TMXHZZ_MCGS"));
            model.put("V104", pd.getString("TMXHZZ_FJSM"));*/
        }

        model.put("G70", "");
        model.put("G71", "");
        if ("1".equals(pd.getString("TMXHZZ_TWZHXS"))) {
            model.put("G70", " √ ");

            model.put("V098", pd.getString("TMXHZZ_ZDJC"));
            model.put("V099", pd.getString("TMXHZZ_MCGS"));
            model.put("V100", pd.getString("TMXHZZ_FJSM"));
            model.put("V102", "  ");
            model.put("V103", "  ");
            model.put("V104", "  ");
        } else if ("2".equals(pd.getString("TMXHZZ_TWZHXS"))) {
            model.put("G71", " √ ");

            model.put("V098", "  ");
            model.put("V099", "  ");
            model.put("V100", "  ");
            model.put("V102", pd.getString("TMXHZZ_ZDJC"));
            model.put("V103", pd.getString("TMXHZZ_MCGS"));
            model.put("V104", pd.getString("TMXHZZ_FJSM"));
        }else {
            model.put("V098", "");
            model.put("V099", "");
            model.put("V100", "");
            model.put("V102", "");
            model.put("V103", "");
            model.put("V104", "");
        }


        model.put("V027", pd.get("BASE_KMKD"));
        model.put("V031", pd.get("BZ_C"));
        model.put("V032", pd.get("BZ_Z"));
        model.put("V033", pd.get("BZ_M"));
        model.put("BASE_KZXT", pd.get("BASE_KZXT"));
        model.put("V014", pd.get("BASE_KZFS"));
        model.put("BASE_YYZJ", pd.get("BASE_YYZJ"));
        model.put("V024", pd.get("BASE_QGLJJ"));
        model.put("V026", pd.get("BASE_JXGG"));
        model.put("V027", pd.get("BASE_KMCC"));
        model.put("V028", pd.get("BASE_JXRKSL"));
        model.put("V034", pd.get("BASE_JDK"));
        model.put("V035", pd.get("BASE_JDS"));
        model.put("V030", pd.get("BASE_TSGD"));
        model.put("V036", pd.get("BASE_DKSD"));
        model.put("V037", pd.get("BASE_DCGD"));
        //model.put("V035", pd.get("BASE_JDZG"));
        model.put("V038", pd.get("BASE_JZZT"));
        model.put("V039", pd.get("BASE_LCBJ"));
//		model.put("???", pd.get("BASE_DGZJ"));
//		model.put("???", pd.get("OPT_SZTJMSJ"));
//		model.put("???", pd.get("OPT_TWXFYFW"));
//		model.put("???", pd.get("OPT_LOPAN"));
//		model.put("?", pd.get("OPT_LOPANGS"));
//		model.put("?", pd.get("OPT_GTJX"));
//		model.put("?", pd.get("OPT_GTCS"));
        model.put("V056", pd.get("DZJKSDJXT_DJDDTTS"));
        model.put("V057", "");
        if (pd.getString("JXZH_JM") != null && pd.getString("JXZH_JM").indexOf("不锈钢") > -1) {
            model.put("V058", "  ");
        } else {
            model.put("V058", pd.get("JXZH_JMSBH"));
        }

        if (pd.getString("JXZH_QWB") != null && pd.getString("JXZH_QWB").indexOf("不锈钢") > -1) {
            model.put("V059", "  ");
        } else {
            model.put("V059", pd.get("JXZH_QWBSBH"));
        }

        if (pd.getString("JXZH_CWB") != null && pd.getString("JXZH_CWB").indexOf("不锈钢") > -1) {
            model.put("V060", "  ");
        } else {
            model.put("V060", pd.get("JXZH_CWBSBH"));
        }

        if (pd.getString("JXZH_HWB") != null && pd.getString("JXZH_HWB").indexOf("不锈钢") > -1) {
            model.put("V061", "  ");
        } else {
            model.put("V061", pd.get("JXZH_HWBSBH"));
        }

//		model.put("???", pd.get("JXZH_BXGDD"));
//		model.put("???", pd.get("JXZH_BXGDB"));
//		model.put("???", pd.get("JXZH_BGJ"));
        model.put("JXZH_DBZXHD", pd.getNoneNULLString("JXZH_DBZXHD"));
//		model.put("???", pd.get("TMMT_FWBXGTM"));
//		model.put("???", pd.get("TMMT_FWBXGXMT"));
//		model.put("???", pd.get("TMMT_DMT"));
        model.put("V072", " ");
        if (pd.getString("TMMT_SCTMMT") != null && pd.getString("TMMT_SCTMMT").indexOf("不锈钢") > -1) {
            model.put("V072", " ");
        } else if (pd.getString("TMMT_SCTMMT") != null && pd.getString("TMMT_SCTMMT").indexOf("喷涂") > -1) {
            model.put("V072", pd.get("TMMT_SCSBH"));
        }

        if (pd.getString("TMMT_SCTMMT") != null && pd.getString("TMMT_SCTMMT").indexOf("喷涂") > -1) {
            model.put("V073", pd.get("TMMT_SCSL"));
            model.put("V074", " ");
        } else if (pd.getString("TMMT_SCTMMT") != null && pd.getString("TMMT_SCTMMT").indexOf("不锈钢") > -1) {
            model.put("V073", " ");
            model.put("V074", pd.get("TMMT_SCSL"));
        }

        if (pd.getString("TMMT_FSCTMMT") != null && pd.getString("TMMT_FSCTMMT").indexOf("喷涂") > -1) {
            model.put("V076", pd.get("TMMT_FSCSL"));
            model.put("V077", " ");

        } else if (pd.getString("TMMT_FSCTMMT") != null && pd.getString("TMMT_FSCTMMT").indexOf("不锈钢") > -1) {
            model.put("V076", " ");
            model.put("V077", pd.get("TMMT_FSCSL"));
        }

        model.put("V075", " ");
        if (pd.getString("TMMT_FSCTMMT") != null && pd.getString("TMMT_FSCTMMT").indexOf("不锈钢") > -1) {
            model.put("V075", " ");
        } else if (pd.getString("TMMT_FSCTMMT") != null && pd.getString("TMMT_FSCTMMT").indexOf("喷涂") > -1) {
            model.put("V075", pd.get("TMMT_FSCSBH"));
        }
        model.put("CZP_CZPLX", pd.get("CZP_CZPLX"));
        model.put("TMXHZZ_TWZHLX", pd.get("TMXHZZ_TWZHLX"));
        model.put("TMXHZZ_TWZHXS", pd.get("TMXHZZ_TWZHXS"));
        model.put("BZ01", pd.getString("DT_REMARK") != null ? pd.getString("DT_REMARK") : "");
        String unstd = pd.getString("UNSTD");
        JSONArray jsonA = JSON.parseArray(unstd);

        model.put("G61", "1".equals(pd.get("OPT_TWXFYFW")) ? " √ " : "");
        model.put("G62", pd.getNoneNULLString("OPT_LOPAN"));
        model.put("G63", pd.getNoneNULLString("OPT_LOPANGS"));
        model.put("G64", "1".equals(pd.get("OPT_GTJX")) ? " √ " : "");

        model.put("G65", pd.getNoneNULLString("TMMT_PTDMT"));
        model.put("G66", pd.getNoneNULLString("DMT_SL"));
        model.put("G67", pd.getNoneNULLString("FSC_DMT"));
        model.put("G68", pd.getNoneNULLString("FSC_DMT_SL"));

        model.put("V090", pd.getNoneNULLString("BASE_JJXF"));

        //常规非标
        setCGFBWordList(model, pd);
        setCgfb(model, pd);

        //非标需求
        setFBXQWordList(model, pd, jsonA);

        String strdlx = PathUtil.getClasspath() + Const.FILEPATHFILE + "COD/飞尚GL freight MRL_COD .docx";
        mv = new ModelAndView(new WordView("GL freight MRL_COD", strdlx), model);
        return mv;
    }

    //飞逸
    public static ModelAndView GetSHINY(List<PageData> CodList) throws Exception {
        ModelAndView mv = null;
        PageData pd = CodList.get(0);
        Map<String, Object> model = new HashMap<>();
        model.put("HT_NO", pd.get("HT_NO"));
        model.put("BJC_SL", pd.get("BJC_SL"));
        model.put("BJC_ENO", pd.get("BJC_ENO"));
        model.put("TJTTH", pd.get("TJTTH"));
        model.put("OFFER_VERSION", StringUtils.isBlank(pd.getString("offer_version")) ? "01" : pd.get("offer_version"));
        model.put("name", pd.get("name"));
        model.put("customer_name", pd.get("customer_name"));
        model.put("item_name", pd.get("item_name"));
        model.put("HT_JHRQ", pd.get("HT_JHRQ"));

        model.put("BZ_ZZ", pd.get("BZ_ZZ"));
        model.put("BZ_SD", pd.get("BZ_SD"));
        model.put("BZ_KMKD", pd.get("BZ_KMKD"));
        model.put("BZ_KMXS", pd.get("BZ_KMXS"));
        model.put("BZ_KMGD", pd.get("BZ_KMGD"));
        model.put("BASE_KMXS", pd.get("BASE_KMXS"));
        model.put("BASE_KMKD", pd.get("BASE_KMKD"));
        model.put("BZ_C", pd.get("BZ_C"));
        model.put("BZ_Z", pd.get("BZ_Z"));
        model.put("BZ_M", pd.get("BZ_M"));
        model.put("BASE_JXCRKSL",pd.get("BASE_JXCRKSL"));
        model.put("BASE_KZXT", pd.get("BASE_KZXT"));
        model.put("BASE_KZFS", pd.get("BASE_KZFS"));
        model.put("BASE_YYZJ", pd.get("BASE_YYZJ"));
        model.put("BASE_QGLJJ", pd.get("BASE_QGLJJ"));
        model.put("BASE_JXGG", pd.get("BASE_JXGG"));
        model.put("BASE_JXGD", pd.get("BASE_JXGD"));
        model.put("BASE_HTDM", pd.get("BASE_HTDM"));
        model.put("BASE_MJXH", pd.get("BASE_MJXH"));
        model.put("BASE_MBHFS", pd.get("BASE_MBHFS"));
        model.put("BASE_JDJG", pd.get("BASE_JDJG"));
        model.put("BASE_JDCZQHD", pd.get("BASE_JDCZQHD"));
        model.put("BASE_JDK", pd.get("BASE_JDK"));
        model.put("BASE_JDS", pd.get("BASE_JDS"));
        model.put("BASE_TSGD", pd.get("BASE_TSGD"));
        model.put("BASE_DKSD", pd.get("BASE_DKSD"));
        model.put("BASE_DCGD", pd.get("BASE_DCGD"));
        model.put("BASE_JDZG", pd.get("BASE_JDZG"));
        model.put("BASE_JZZT", pd.get("BASE_JZZT"));
        model.put("BASE_LCBJ", pd.get("BASE_LCBJ"));
        model.put("BASE_DGZJ", pd.get("BASE_DGZJ"));
        model.put("OPT_JFGT", pd.get("OPT_JFGT"));
        model.put("OPT_COP", pd.get("OPT_COP"));
        model.put("OPT_WZYCOPMWAN", pd.get("OPT_WZYCOPMWAN"));
        model.put("OPT_GBSCJRCZXCOP", pd.get("OPT_GBSCJRCZXCOP"));
        model.put("OPT_LOP", pd.get("OPT_LOP"));
        model.put("OPT_FDLCZ", pd.get("OPT_FDLCZ"));
        model.put("OPT_TDJJJY", pd.get("OPT_TDJJJY"));
        model.put("OPT_YSJCZ", pd.get("OPT_YSJCZ"));
        model.put("OPT_CCTVDL", pd.get("OPT_CCTVDL"));
        model.put("OPT_JJBYDYCZZZ", pd.get("OPT_JJBYDYCZZZ"));
        model.put("OPT_JXDZZ", pd.get("OPT_JXDZZ"));
        model.put("OPT_ZPC", pd.get("OPT_ZPC"));
        model.put("OPT_YCJSJKZB", pd.get("OPT_YCJSJKZB"));
        model.put("OPT_YYBZ", pd.get("OPT_YYBZ"));
        model.put("OPT_HJZDFHJZ", pd.get("OPT_HJZDFHJZ"));
        model.put("OPT_BAJK", pd.get("OPT_BAJK"));
        model.put("OPT_DJGRBH", pd.get("OPT_DJGRBH"));
        model.put("OPT_XFLD", pd.get("OPT_XFLD"));
        model.put("OPT_TWXFYFW", pd.get("OPT_TWXFYFW"));
        model.put("DZJKSDJXT_DJTXFS", pd.get("DZJKSDJXT_DJTXFS"));
        model.put("DZJKSDJXT_TQZDSBH", pd.get("DZJKSDJXT_TQZDSBH"));
        model.put("JXZH_JM", pd.get("JXZH_JM"));
        model.put("JXZH_JMSBH", pd.get("JXZH_JMSBH"));
        model.put("JXZH_QWB", pd.get("JXZH_QWB"));
        model.put("JXZH_QWBSBH", pd.get("JXZH_QWBSBH"));
        model.put("JXZH_CWB", pd.get("JXZH_CWB"));
        model.put("JXZH_CWBSBH", pd.get("JXZH_CWBSBH"));
        model.put("JXZH_HWB", pd.get("JXZH_HWB"));
        model.put("JXZH_HWBSBH", pd.get("JXZH_HWBSBH"));
        model.put("JXZH_JDZH", pd.get("JXZH_JDZH"));
        model.put("JXZH_JDAQC", pd.get("JXZH_JDAQC"));

        model.put("JXZH_DBXH", pd.get("JXZH_DBXH"));
        model.put("JXZH_DBZXHD", pd.get("JXZH_DBZXHD"));
        model.put("JXZH_FZTXH", pd.get("JXZH_FZTXH"));
        String JXZHFZTAZWZ = "";
        if (!"".equals(pd.getNoneNULLString("JXZH_FZTAZWZ1"))) {
            JXZHFZTAZWZ += pd.getNoneNULLString("JXZH_FZTAZWZ1");
        }
        if (!"".equals(pd.getNoneNULLString("JXZH_FZTAZWZ2"))) {
            if (!"".equals(JXZHFZTAZWZ))
                JXZHFZTAZWZ += ",";
            JXZHFZTAZWZ += pd.getNoneNULLString("JXZH_FZTAZWZ2");
        }
        if (!"".equals(pd.getNoneNULLString("JXZH_FZTAZWZ3"))) {
            if (!"".equals(JXZHFZTAZWZ))
                JXZHFZTAZWZ += ",";
            JXZHFZTAZWZ += pd.getNoneNULLString("JXZH_FZTAZWZ3");
        }
        model.put("JXZH_FZTAZWZ", JXZHFZTAZWZ);
        model.put("JXZH_BGJ", pd.get("JXZH_BGJ"));
        model.put("JXZH_YLZHZL", pd.get("JXZH_YLZHZL"));
        model.put("TMMT_SCTMMTCZXMK", pd.get("TMMT_SCTMMTCZXMK"));
        model.put("TMMT_FSCTMMTCZXMK", pd.get("TMMT_FSCTMMTCZXMK"));
        model.put("TMMT_XMKCZS", pd.get("TMMT_XMKCZS"));
        model.put("TMMT_XMKLM", pd.get("TMMT_XMKLM"));
        model.put("TMMT_SCTMMTCZDMK", pd.get("TMMT_SCTMMTCZDMK"));
        model.put("TMMT_FSCTMMTCZDMK", pd.get("TMMT_FSCTMMTCZDMK"));
        model.put("TMMT_DMKCZS", pd.get("TMMT_DMKCZS"));
        model.put("TMMT_DMKLM", pd.get("TMMT_DMKLM"));
        model.put("TMMT_TMCZ", pd.get("TMMT_TMCZ"));
        model.put("TMMT_FSCTMCZ", pd.get("TMMT_FSCTMCZ"));
        model.put("TMMT_CZS", pd.get("TMMT_CZS"));
        model.put("TMMT_LM", pd.get("TMMT_LM"));

        model.put("CZP_CZPLX", pd.get("CZP_CZPLX"));
        model.put("CZP_CZPXH", pd.get("CZP_CZPXH"));
        model.put("CZP_XS", pd.get("CZP_XS"));
        model.put("CZP_AN", pd.get("CZP_AN"));
        model.put("CZP_CZ", pd.get("CZP_CZ"));
        model.put("CZP_CZPWZ", pd.get("CZP_CZPWZ"));
        model.put("TMXHZZ_TWZHLX", pd.get("TMXHZZ_TWZHLX"));
        model.put("TMXHZZ_TWZHXH", pd.get("TMXHZZ_TWZHXH"));
        model.put("TMXHZZ_SL", pd.get("TMXHZZ_SL"));
        model.put("TMXHZZ_XS", pd.get("TMXHZZ_XS"));
        model.put("TMXHZZ_AN", pd.get("TMXHZZ_AN"));
        model.put("TMXHZZ_CZ", pd.get("TMXHZZ_CZ"));
        model.put("TMXHZZ_TWZHXS", pd.get("TMXHZZ_TWZHXS"));
        model.put("TMXHZZ_ZDJC", pd.get("TMXHZZ_ZDJC"));
        model.put("TMXHZZ_FJSM", pd.get("TMXHZZ_FJSM"));

        model.put("TMMT_SCTMMTCZXMKSBH", pd.getNoneNULLString("TMMT_SCTMMTCZXMKSBH"));
        model.put("TMMT_FSCTMMTCZXMKSBH", pd.getNoneNULLString("TMMT_FSCTMMTCZXMKSBH"));
        model.put("TMMT_SCTMMTCZDMKSBH", pd.getNoneNULLString("TMMT_SCTMMTCZDMKSBH"));
        model.put("TMMT_FSCTMMTCZDMKSBH", pd.getNoneNULLString("TMMT_FSCTMMTCZDMKSBH"));
        model.put("TMMT_TMCZSBH", pd.getNoneNULLString("TMMT_TMCZSBH"));
        model.put("TMMT_FSCTMCZSBH", pd.getNoneNULLString("TMMT_FSCTMCZSBH"));
        model.put("BZ01", pd.getString("DT_REMARK") != null ? pd.getString("DT_REMARK") : "");

        //非规需求
        String unstd = pd.getString("UNSTD");
        System.out.println(unstd);
        JSONArray jsonA = JSON.parseArray(unstd);
       // 非规需求
        setFbxq(model, pd, jsonA);

        //设置Excel类型
        model.put("excelType", "feiyi");

//        for (int i = 0; i < jsonA.size(); i++) {
//            JSONObject jsonO = jsonA.getJSONObject(i);
//            String xh = "00" + (i + 1);
//            model.put("NR" + xh.substring(xh.length() - 2, xh.length()), jsonO.getString("nonstandrad_describe"));
//        }
//        for (int i = 0; i < jsonA.size(); i++) {
//            JSONObject jsonO = jsonA.getJSONObject(i);
//            String xh = "00" + (i + 1);
//            model.put("PSDH" + xh.substring(xh.length() - 2, xh.length()), jsonO.getString("master_id") != null ? jsonO.getString("master_id") : "");
//        }

        String strdlx = PathUtil.getClasspath() + Const.FILEPATHFILE + "COD/飞逸SHINY-F_COD.xlsx";
        mv = new ModelAndView(new ExcelView("Document", strdlx), model);
        return mv;
    }

    //飞越系列COD输出
    public static ModelAndView GetFEIYUE(List<PageData> CodList, String type) throws Exception {
        ModelAndView mv = null;
        PageData pd = CodList.get(0);
        Map<String, Object> model = new HashMap<>();
        model.put("HT_NO", pd.get("HT_NO"));
        model.put("BJC_SL", pd.get("BJC_SL"));
        model.put("BJC_ENO", pd.get("BJC_ENO"));
        model.put("TJTTH", pd.get("TJTTH"));
        model.put("OFFER_VERSION", StringUtils.isBlank(pd.getString("offer_version")) ? "01" : pd.get("offer_version"));
        model.put("name", pd.get("name"));
        model.put("customer_name", pd.get("customer_name"));
        model.put("item_name", pd.get("item_name"));
        model.put("HT_JHRQ", pd.get("HT_JHRQ"));
        model.put("V005", type);
        model.put("V006", pd.get("BZ_ZZ"));
        model.put("V008", pd.get("BZ_SD"));
        model.put("V010", pd.get("BZ_C"));
        model.put("V013", pd.get("BZ_Z"));
        model.put("V016", pd.get("BASE_JDJG"));
        model.put("V018", pd.get("BASE_QGLJJ"));
        model.put("V020", pd.get("BZ_KMXS"));
        model.put("V022", pd.get("BZ_KMKD"));
        model.put("V023", pd.get("BZ_KMGD"));
        model.put("V025", pd.get("BASE_KZFS"));
        model.put("V026", pd.get("BASE_HTDM"));
        model.put("V027", pd.get("BASE_JXGG"));
        model.put("V029", pd.get("BASE_JXGD"));
        model.put("V030", pd.get("BASE_JDCZQHD"));

        model.put("BASE_TSGD", pd.get("BASE_TSGD"));
        model.put("BASE_JDK", pd.get("BASE_JDK"));
        model.put("BASE_JDS", pd.get("BASE_JDS"));
        model.put("BASE_DCGD", pd.get("BASE_DCGD"));
        model.put("BASE_DKSD", pd.get("BASE_DKSD"));
        model.put("V031", pd.get("BASE_LCBJ"));

        //改
        Object TMMTSCMK = pd.get("TMMT_SCMK");
        if ("小门框".equals(TMMTSCMK)) {
            model.put("V032", "首层小门框（标配）");
        } else if ("大门框".equals(TMMTSCMK)) {
            model.put("V032", "首层大门框（选配）");
        } else {
            model.put("V032", "");
        }
        Object TMMTQYCMK = pd.get("TMMT_QYCMK");
        if ("小门框".equals(TMMTQYCMK)) {
            model.put("V033", "其余小门框（标配）");
        } else if ("大门框".equals(TMMTQYCMK)) {
            model.put("V033", "其余大门框（选配）");
        } else {
            model.put("V033", "");
        }
        model.put("V034", pd.get("TMMT_SCMKGBSBH"));
        model.put("V035", pd.get("TMMT_SCTMCZ"));
        model.put("V036", pd.get("TMMT_QYCTMCZ"));
        model.put("V037", pd.get("TMMT_QYCTMGBSBH"));

        model.put("V038", pd.get("JXZH_JMZH"));
        model.put("V039", pd.get("JXZH_JMSBH"));
        model.put("V040", pd.get("JXZH_QWB"));
        model.put("V041", pd.get("JXZH_QWBSBH"));
        model.put("V042", pd.get("JXZH_CWB"));
        model.put("V043", pd.get("JXZH_CWBSBH"));
        model.put("V044", pd.get("JXZH_HWB"));
        model.put("V045", pd.get("JXZH_HWBSBH"));

        //model.put("V046", pd.get("JXZH_ZSDD"));
        model.put("V046", pd.get("JXZH_JDZH"));
        model.put("V047", pd.get("JXZH_DBXH"));

        model.put("V048", pd.get("JXZH_DBZXHD"));
        model.put("V049", pd.get("JXZH_YLZHZL"));

        model.put("V050", pd.get("JXZH_FSXH"));

        //扶手安装位置
        StringBuilder sb = new StringBuilder();

        boolean needToAddComma = false;

        if ("1".equals(pd.getNoneNULLString("JXZH_FSAZWZ_H"))) {
            sb.append("后围壁");
            needToAddComma = true;
        }
        if ("1".equals(pd.getNoneNULLString("JXZH_FSAZWZ_Z"))) {
            if (needToAddComma) {
                sb.append(",");
            }
            sb.append("左围壁");
            needToAddComma = true;
        }
        if ("1".equals(pd.getNoneNULLString("JXZH_FSAZWZ_Y"))) {
//            if (needToAddComma) {
//                sb.append(",");
//            }
//            sb.append("JXZH_FSAZWZ_Y");
        	if (needToAddComma) {
                sb.append(",");
            }
            sb.append("右围壁");
        }

        model.put("V051", sb.toString());

        model.put("V052", pd.get("JXZH_AQC"));
        model.put("V053", pd.get("CZP_CZPXH"));
        model.put("V054", pd.get("CZP_CZPWZ"));
        model.put("V055", pd.get("CZP_CZPSL"));

        model.put("V056", pd.get(""));
        model.put("V057", pd.get("TMXHZZ_GBSCJRCZX"));
        model.put("V058", pd.get("TMXHZZ_GBSCJRCZX_WZ"));
        model.put("V059", pd.get("TMXHZZ_TWZHXH"));
        model.put("V060", pd.get("TMXHZZ_TWZHSL"));

        model.put("BASE_KMXS", pd.get("BASE_KMXS"));
        model.put("BZ_C", pd.get("BZ_C"));
        model.put("BZ_Z", pd.get("BZ_Z"));
        model.put("BZ_M", pd.get("BZ_M"));
        model.put("BASE_KZXT", pd.get("BASE_KZXT"));
        model.put("BASE_JXGD", pd.get("BASE_JXGD"));
        model.put("BASE_MLXMBH", pd.get("BASE_MLXMBH"));
        model.put("BASE_JDK", pd.get("BASE_JDK"));
        model.put("BASE_JDS", pd.get("BASE_JDS"));
        model.put("BASE_TSGD", pd.get("BASE_TSGD"));
        model.put("BASE_DKSD", pd.get("BASE_DKSD"));
        model.put("BASE_DCGD", pd.get("BASE_DCGD"));
        model.put("BASE_JDZG", pd.get("BASE_JDZG"));
        model.put("BASE_JZZT", pd.get("BASE_JZZT"));
        model.put("BASE_DGZJ", pd.get("BASE_DGZJ"));
        model.put("OPT_LTBL", pd.get("OPT_LTBL"));
        model.put("OPT_TDJJJY", pd.get("OPT_TDJJJY"));
        model.put("OPT_JXDZZ", pd.get("OPT_JXDZZ"));
        model.put("OPT_SJCZ", pd.get("OPT_SJCZ"));
        model.put("OPT_CCTVDL", pd.get("OPT_CCTVDL"));
        model.put("OPT_DJGRBH", pd.get("OPT_DJGRBH"));
        model.put("OPT_BAJK", pd.get("OPT_BAJK"));
        model.put("OPT_MBCAN", pd.get("OPT_MBCAN"));
        model.put("OPT_KMZPC", pd.get("OPT_KMZPC"));
        model.put("OPT_QPGM", pd.get("OPT_QPGM"));
        model.put("OPT_YCJK", pd.get("OPT_YCJK"));
        model.put("OPT_JFGT", pd.get("OPT_JFGT"));
        model.put("OPT_ICK", pd.get("OPT_ICK"));
        model.put("OPT_ICKZKSB", pd.get("OPT_ICKZKSB"));
        model.put("OPT_ICKKP", pd.get("OPT_ICKKP"));

        model.put("OPT_GTMJXJMBF", pd.get("OPT_GTMJXJMBF"));
        model.put("OPT_GTMTMBF", pd.get("OPT_GTMTMBF"));
        model.put("OPT_GTMS", pd.get("OPT_GTMS"));
        model.put("DZJKSDJXT_DJTXFS", pd.get("DZJKSDJXT_DJTXFS"));
        model.put("DZJKSDJXT_DJTS", pd.get("DZJKSDJXT_DJTS"));
        model.put("DZJKSDJXT_JKSMJPZ", pd.get("DZJKSDJXT_JKSMJPZ"));
        model.put("JXZH_JM", pd.get("JXZH_JM"));
        model.put("JXZH_JMZH", pd.get("JXZH_JMZH"));
        model.put("JXZH_JXZH", pd.get("JXZH_JXZH"));
        model.put("JXZH_JDZH", pd.get("JXZH_JDZH"));
        model.put("JXZH_ZSDD", pd.get("JXZH_ZSDD"));
        model.put("JXZH_AQC", pd.get("JXZH_AQC"));
        model.put("JXZH_BGJ", pd.get("JXZH_BGJ"));
        model.put("TMMT_SCMK", pd.get("TMMT_SCMK"));
        model.put("TMMT_SCMKCZ", pd.get("TMMT_SCMKCZ"));
        model.put("TMMT_SCMKGBSBH", pd.get("TMMT_SCMKGBSBH"));
        model.put("TMMT_QYCMK", pd.get("TMMT_QYCMK"));
        model.put("TMMT_QYCMKCZ", pd.get("TMMT_QYCMKCZ"));
        model.put("TMMT_QYCMKGBSBH", pd.get("TMMT_QYCMKGBSBH"));
        model.put("TMMT_SCTMCZ", pd.get("TMMT_SCTMCZ"));
        model.put("TMMT_SCTMGBSBH", pd.get("TMMT_SCTMGBSBH"));
        model.put("TMMT_QYCTMCZ", pd.get("TMMT_QYCTMCZ"));
        model.put("TMMT_QYCTMGBSBH", pd.get("TMMT_QYCTMGBSBH"));
        model.put("CZP_XS", pd.get("CZP_XS"));
        model.put("CZP_AN", pd.get("CZP_AN"));
        model.put("CZP_CZ", pd.get("CZP_CZ"));
        model.put("CZP_CZPSL", pd.get("CZP_CZPSL"));
        model.put("TMXHZZ_TWZHSL", pd.get("TMXHZZ_TWZHSL"));
        model.put("TMXHZZ_TWZHXH", pd.get("TMXHZZ_TWZHXH"));
        model.put("TMXHZZ_XS", pd.get("TMXHZZ_XS"));
        model.put("TMXHZZ_AN", pd.get("TMXHZZ_AN"));
        model.put("TMXHZZ_CZ", pd.get("TMXHZZ_CZ"));
        model.put("TMXHZZ_ZDJC", pd.get("TMXHZZ_ZDJC"));
        model.put("TMXHZZ_MCGS", pd.get("TMXHZZ_MCGS"));
        model.put("TMXHZZ_FJSM", pd.get("TMXHZZ_FJSM"));
        model.put("TMXHZZ_GBSCJRCZX", pd.get("TMXHZZ_GBSCJRCZX"));
        model.put("BZ01", pd.getString("DT_REMARK") != null ? pd.getString("DT_REMARK") : "");

        String unstd = pd.getString("UNSTD");
        JSONArray jsonA = JSON.parseArray(unstd);
        String xh = "";
        String gg = "";

        //常规非标
        setCgfb(model, pd);

        //非标需求
        setFbxq(model, pd, jsonA);

        //设置Excel类型
        model.put("excelType", "feiyue");

//        for (int i = 0; i < jsonA.size(); i++) {
//            xh = "00" + (i + 1);
//            gg = "00" + (i + 1);
//            if (jsonA.size() > i) {
//                JSONObject jsonO = jsonA.getJSONObject(i);
//                model.put("NR" + xh.substring(xh.length() - 2, xh.length()), jsonO.getString("nonstandrad_describe"));
//
//                model.put("PSDH" + gg.substring(gg.length() - 2, gg.length()), jsonO.getString("master_id") != null ? jsonO.getString("master_id") : "");
//            } else {
//                model.put("NR" + xh.substring(xh.length() - 2, xh.length()), "");
//                model.put("PSDH" + gg.substring(gg.length() - 2, gg.length()), "");
//            }
//
//        }

        String strdlx = PathUtil.getClasspath() + Const.FILEPATHFILE + "COD/新飞越_COD.xlsx";
        mv = new ModelAndView(new ExcelView("Document", strdlx), model);
        return mv;
    }

    //飞扬3000+mrl
    public static ModelAndView GetFEIYANG_MRL(List<PageData> CodList) throws Exception {
        ModelAndView mv = null;
        PageData pd = CodList.get(0);
        Map<String, Object> model = new HashMap<>();
//		文档标签初始化
        String xh = "";
        for (int i = 1; i < 120; i++) {
            xh = "000" + i;
            model.put("V" + xh.substring(xh.length() - 3, xh.length()), "");
            model.put("G" + xh.substring(xh.length() - 2, xh.length()), "");
        }
        model.put("HT_NO", pd.get("HT_NO"));
        model.put("BJC_SL", pd.get("BJC_SL"));
        model.put("BJC_ENO", pd.get("BJC_ENO"));
        model.put("TJTTH", pd.get("TJTTH") != null ? pd.get("TJTTH") : "");
        model.put("OFFER_VERSION", StringUtils.isBlank(pd.getString("offer_version")) ? "01" : pd.get("offer_version"));
        model.put("name", pd.get("name"));
        model.put("customer_name", pd.get("customer_name"));
        model.put("item_name", pd.get("item_name"));
        model.put("HT_JHRQ", pd.get("HT_JHRQ"));
        model.put("V011", pd.get("BZ_ZZ"));
        model.put("V012", pd.get("BZ_SD"));
        model.put("V013", pd.get("BZ_KMXS"));
        model.put("BASE_KZXT", pd.get("BASE_KZXT"));
        if (pd.getString("BASE_KZFS") != null && pd.getString("BASE_KZFS").indexOf("单台") > -1) model.put("G01", " √ ");
        if (pd.getString("BASE_KZFS") != null && pd.getString("BASE_KZFS").indexOf("两台并联") > -1)
            model.put("G02", " √ ");
        if (pd.getString("BASE_KZFS") != null && pd.getString("BASE_KZFS").indexOf("三台群控") > -1)
            model.put("G03", " √ ");
        if (pd.getString("BASE_KZFS") != null && pd.getString("BASE_KZFS").indexOf("四台群控") > -1)
            model.put("G04", " √ ");
        model.put("BASE_YYZJ", pd.getNoneNULLString("BASE_YYZJ"));
        if (pd.getString("BASE_JDJG") != null && pd.getString("BASE_JDJG").indexOf("全混凝土") > -1)
            model.put("G05", " √ ");
        if (pd.getString("BASE_JDJG") != null && pd.getString("BASE_JDJG").indexOf("框架结构") > -1)
            model.put("G06", " √ ");
        if (pd.getString("BASE_JDJG") != null && pd.getString("BASE_JDJG").indexOf("钢结构") > -1) model.put("G07", " √ ");
        if (pd.getString("BASE_QGLJJ") != null && pd.getString("BASE_QGLJJ") != "")
            model.put("V024", pd.get("BASE_QGLJJ"));
        if (pd.getString("BASE_JXGG") != null && pd.getString("BASE_JXGG") != "")
            model.put("V026", pd.get("BASE_JXGG"));
        if (pd.getString("BASE_JXGD") != null && pd.getString("BASE_JXGD").indexOf("2400") > -1)
            model.put("G08", " √ ");
        if (pd.getString("BASE_JXGD") != null && pd.getString("BASE_JXGD").indexOf("2500") > -1)
            model.put("G09", " √ ");
        if (pd.getString("BASE_JXGD") != null && pd.getString("BASE_JXGD").indexOf("2700") > -1)
            model.put("G10", " √ ");
        if (pd.getString("BASE_JXGD") != null && pd.getString("BASE_JXGD").indexOf("2800") > -1)
            model.put("G11", " √ ");
        if (pd.getString("BASE_KMCC") != null && pd.getString("BASE_KMCC") != "")
            model.put("V027", pd.get("BASE_KMCC"));

        if (pd.getNoneNULLString("BASE_MLXMBH").indexOf("PM门机/2D光幕") > -1) {
            model.put("G12", " √ ");
        } else if (pd.getNoneNULLString("BASE_MLXMBH").indexOf("VVVF门机/2D光幕") > -1) {
            model.put("G13", " √ ");
            model.put("V030", "VVVF门机");
        }

        if (pd.getString("BASE_JDCZQHD") != null && pd.getString("BASE_JDCZQHD").equals("250")) {
            model.put("G14", " √ ");
        } else {
            model.put("G15", " √ ");
            model.put("V031", pd.getString("BASE_JDCZQHD"));
        }
        model.put("V032", pd.get("BASE_TSGD"));
        model.put("V033", pd.get("BZ_C"));
        model.put("V034", pd.get("BZ_Z"));
        model.put("V035", pd.get("BZ_M"));
        model.put("V036", pd.get("BASE_JDK"));
        model.put("V037", pd.get("BASE_JDS"));
        model.put("V038", pd.get("BASE_DKSD"));
        model.put("V039", pd.get("BASE_DCGD"));
        model.put("V040", pd.get("BASE_JZZT"));
        model.put("V041", pd.get("BASE_LCBJ"));
        if (pd.getString("OPT_MWAN") != null && pd.getString("OPT_MWAN").equals("1")) model.put("G16", " √ ");
        if (pd.getString("OPT_HJZDFHJZ") != null && pd.getString("OPT_HJZDFHJZ").equals("1")) model.put("G17", " √ ");
        if (pd.getString("OPT_XFYYX") != null && pd.getString("OPT_XFYYX").equals("1")) model.put("G18", " √ ");
        if (pd.getString("OPT_JXDZZ") != null && pd.getString("OPT_JXDZZ").equals("1")) model.put("G19", " √ ");
        if (pd.getString("OPT_CCTVDL") != null && pd.getString("OPT_CCTVDL").equals("1")) model.put("G20", " √ ");
        if (pd.getString("OPT_TDJJJY") != null && pd.getString("OPT_TDJJJY").equals("1")) model.put("G21", " √ ");
        if (pd.getString("OPT_DJGRBH") != null && pd.getString("OPT_DJGRBH").equals("1")) model.put("G22", " √ ");
        if (pd.getString("OPT_KQJHZZ") != null && pd.getString("OPT_KQJHZZ").equals("1")) model.put("G23", " √ ");
        model.put("G24", pd.getString("OPT_NMYKJAN").equals("") ? "" : pd.get("OPT_NMYKJAN") + "个");
        if (pd.getString("OPT_FDLCZ") != null && pd.getString("OPT_FDLCZ").equals("1")) model.put("G25", " √ ");
        if (pd.getString("OPT_ZPC") != null && pd.getString("OPT_ZPC").equals("1")) model.put("G26", " √ ");
        if (pd.getString("OPT_BAJK") != null && pd.getString("OPT_BAJK").equals("1")) model.put("G27", " √ ");
        if (pd.getString("OPT_YYBZ") != null && pd.getString("OPT_YYBZ").equals("1")) model.put("G28", " √ ");
        if (pd.getString("OPT_QPGM") != null && pd.getString("OPT_QPGM").equals("1")) model.put("G29", " √ ");
        if (pd.getString("OPT_DLFW") != null && pd.getString("OPT_DLFW").equals("1")) model.put("G30", " √ ");
        if (pd.getString("OPT_KMBC") != null && pd.getString("OPT_KMBC").equals("1")) model.put("G31", " √ ");
        if (pd.getString("OPT_DZYX") != null && pd.getString("OPT_DZYX").equals("1")) model.put("G32", " √ ");
        if (pd.getString("OPT_NLHK") != null && pd.getString("OPT_NLHK").equals("1")) model.put("G33", " √ ");
        if (pd.getString("DZJKSDJXT_DJTXFS") != null && pd.getString("DZJKSDJXT_DJTXFS").indexOf("无线") > -1)
            model.put("G34", " √ ");
        if (pd.getString("DZJKSDJXT_DJTXFS") != null && pd.getString("DZJKSDJXT_DJTXFS").indexOf("总线") > -1)
            model.put("G35", " √ ");
        if (pd.getString("DZJKSDJXT_DJTXFS") != null && pd.getString("DZJKSDJXT_DJTXFS").indexOf("分线") > -1)
            model.put("G99", " √ ");
        if (pd.getString("DZJKSDJXT_DJTS") != null && pd.getString("DZJKSDJXT_DJTS") != "")
            model.put("V050", pd.get("DZJKSDJXT_DJTS"));
        if (pd.getString("JXZH_JMZH") != null && pd.getString("JXZH_JMZH") != "")
            model.put("G36", pd.getString("JXZH_JMZH"));
        if (pd.getString("JXZH_JMSBH") != null && pd.getString("JXZH_JMSBH") != "")
            model.put("G37", pd.getString("JXZH_JMSBH"));

        if (pd.getString("JXZH_JM") != null && pd.getString("JXZH_JM").indexOf("喷涂") > -1) model.put("G38", " √ ");
        if (pd.getString("JXZH_QWB") != null && pd.getString("JXZH_QWB").indexOf("发纹") > -1) model.put("G39", " √ ");
        if (pd.getString("JXZH_QWB") != null && pd.getString("JXZH_QWB").indexOf("镜面") > -1) model.put("G40", " √ ");
        if (pd.getString("JXZH_QWB") != null && pd.getString("JXZH_QWB").indexOf("喷涂") > -1) model.put("G41", " √ ");
        if (pd.getString("JXZH_CWB") != null && pd.getString("JXZH_CWB").indexOf("发纹") > -1) model.put("G42", " √ ");
        if (pd.getString("JXZH_CWB") != null && pd.getString("JXZH_CWB").indexOf("镜面") > -1) model.put("G43", " √ ");
        if (pd.getString("JXZH_CWB") != null && pd.getString("JXZH_CWB").indexOf("喷涂") > -1) model.put("G44", " √ ");
        if (pd.getString("JXZH_HWB") != null && pd.getString("JXZH_HWB").indexOf("发纹") > -1) model.put("G45", " √ ");
        if (pd.getString("JXZH_HWB") != null && pd.getString("JXZH_HWB").indexOf("镜面") > -1) model.put("G46", " √ ");
        if (pd.getString("JXZH_HWB") != null && pd.getString("JXZH_HWB").indexOf("喷涂") > -1) model.put("G47", " √ ");
        if (pd.getString("JXZH_JMSBH") != null && pd.getString("JXZH_JMSBH") != "")
            model.put("V052", pd.get("JXZH_JMSBH"));
        if (pd.getString("JXZH_QWBSBH") != null && pd.getString("JXZH_QWBSBH") != "")
            model.put("V053", pd.get("JXZH_QWBSBH"));
        if (pd.getString("JXZH_CWBSBH") != null && pd.getString("JXZH_CWBSBH") != "")
            model.put("V054", pd.get("JXZH_CWBSBH"));
        if (pd.getString("JXZH_HWBSBH") != null && pd.getString("JXZH_HWBSBH") != "")
            model.put("V055", pd.get("JXZH_HWBSBH"));
        if (pd.getString("JXZH_JDZH") != null && pd.getString("JXZH_JDZH").indexOf("悬吊式") > -1) model.put("G48", " √ ");
        if (pd.getString("JXZH_JDZH") != null && pd.getString("JXZH_JDZH").indexOf("集成式") > -1)
            model.put("V056", " √ ");
        if (pd.getString("JXZH_JDZH") != null && pd.getString("JXZH_JDZH").indexOf("悬吊式") > -1)
            model.put("V057", " √ ");
        if (pd.getString("JXZH_AQC") != null && pd.getString("JXZH_AQC").indexOf("有") > -1) model.put("G50", " √ ");
        if (pd.getString("JXZH_AQC") != null && pd.getString("JXZH_AQC").indexOf("无") > -1) model.put("G49", " √ ");
        if (pd.getString("JXZH_DBXH") != null && pd.getString("JXZH_DBXH") != "")
            model.put("JXZH_DBXH", pd.get("JXZH_DBXH"));
        if (pd.getString("JXZH_DBZXHD") != null && pd.getString("JXZH_DBZXHD") != "")
            model.put("JXZH_DBZXHD", pd.get("JXZH_DBZXHD"));
        else model.put("JXZH_DBZXHD", "");
        if (pd.getString("JXZH_YLZHZL") != null && pd.getString("JXZH_YLZHZL") != "")
            model.put("V059", pd.get("JXZH_YLZHZL"));
        if (pd.getString("JXZH_FSXH") != null) {
            model.put("V060", pd.getString("JXZH_FSXH"));
        } else {
            model.put("G53", " √ ");
        }

        //if(pd.getString("JXZH_FSAZWZ") != null && pd.getString("JXZH_FSAZWZ").indexOf("后围壁") >-1 )model.put("G54", " √ ");
        //if(pd.getString("JXZH_FSAZWZ") != null && pd.getString("JXZH_FSAZWZ").indexOf("左围壁") >-1 )model.put("G55", " √ ");
        //if(pd.getString("JXZH_FSAZWZ") != null && pd.getString("JXZH_FSAZWZ").indexOf("右围壁") >-1 )model.put("G56", " √ ");

        if ("1".equals(pd.getString("JXZH_FSAZWZ_H"))) model.put("G54", " √ ");
        if ("1".equals(pd.getString("JXZH_FSAZWZ_Z"))) model.put("G55", " √ ");
        if ("1".equals(pd.getString("JXZH_FSAZWZ_Y"))) model.put("G56", " √ ");

        //if(pd.getString("TMMT_SCTMMT") != null && pd.getString("TMMT_SCTMMT").indexOf("发纹") >-1 )model.put("G49", " √ ");
        //if(pd.getString("TMMT_SCTMMT") != null && pd.getString("TMMT_SCTMMT").indexOf("镜面") >-1 )model.put("G50", " √ ");
        //if(pd.getString("TMMT_SCTMMT") != null && pd.getString("TMMT_SCTMMT").indexOf("喷涂") >-1 )model.put("G50", " √ ");
        //if(pd.getString("TMMT_SCSBH")!= null && pd.getString("TMMT_SCSBH")!="")model.put("V071", pd.get("TMMT_SCSBH"));
        //if(pd.getString("TMMT_FSCTMMT") != null && pd.getString("TMMT_FSCTMMT").indexOf("发纹") >-1 )model.put("G49", " √ ");
        //if(pd.getString("TMMT_FSCTMMT") != null && pd.getString("TMMT_FSCTMMT").indexOf("镜面") >-1 )model.put("G50", " √ ");
        //if(pd.getString("TMMT_FSCTMMT") != null && pd.getString("TMMT_FSCTMMT").indexOf("喷涂") >-1 )model.put("G50", " √ ");

        if (pd.getString("TMMT_SCTMMT") != null && pd.getString("TMMT_SCTMMT").indexOf("发纹") > -1) {
            model.put("G57", " √ ");
            model.put("V069", pd.get("FDMT_SL"));
        }
        if (pd.getString("TMMT_SCTMMT") != null && pd.getString("TMMT_SCTMMT").indexOf("镜面") > -1) {
            model.put("G58", " √ ");
            model.put("V070", pd.get("FDMT_SL"));
        }
        if (pd.getString("TMMT_SCTMMT") != null && pd.getString("TMMT_SCTMMT").indexOf("喷涂") > -1) {
            model.put("G59", " √ ");
            model.put("V072", pd.get("FDMT_SL"));
        }
        if (pd.getString("TMMT_SCSBH") != null && pd.getString("TMMT_SCSBH") != "")
            model.put("V071", pd.get("TMMT_SCSBH"));
        if (pd.getString("TMMT_FSCTMMT") != null && pd.getString("TMMT_FSCTMMT").indexOf("喷涂") > -1) {
            model.put("G60", " √ ");
            model.put("V076", pd.get("FSCFDMT_SL"));
        }
        if (pd.getString("TMMT_FSCTMMT") != null && pd.getString("TMMT_FSCTMMT").indexOf("镜面") > -1) {
            model.put("G61", " √ ");
            model.put("V077", pd.get("FSCFDMT_SL"));
        }
        if (pd.getString("TMMT_FSCTMMT") != null && pd.getString("TMMT_FSCTMMT").indexOf("发纹") > -1) {
            model.put("G62", " √ ");
            model.put("V078", pd.get("FSCFDMT_SL"));
        }


        if (pd.getString("TMMT_FSCSBH") != null && pd.getString("TMMT_FSCSBH") != "")
            model.put("V075", pd.get("TMMT_FSCSBH"));
        if (pd.getString("CZP_CZPXH") != null && pd.getString("CZP_CZPXH").equals("JFCOP09H-D1")) {
            model.put("G63", " √ ");
            model.put("V081", pd.getString("CZP_XS"));
            model.put("V082", pd.getString("CZP_AN"));
            model.put("V083", pd.getString("CZP_CZ"));
        }
        if (pd.getString("CZP_CZPXH") != null && pd.getString("CZP_CZPXH").equals("JFCOP09H-D")) {
            model.put("G64", " √ ");
            model.put("V084", pd.getString("CZP_XS"));
            model.put("V085", pd.getString("CZP_AN"));
            model.put("V086", pd.getString("CZP_CZ"));
        }
        if (pd.getString("CZP_CZPWZ") != null && pd.getString("CZP_CZPWZ") != "")
            model.put("V087", pd.getString("CZP_CZPWZ"));
        if (pd.getString("TMXHZZ_TWZHXH") != null && pd.getString("TMXHZZ_TWZHXH").indexOf("JFHB09H-D1") > -1) {
            model.put("G68", " √ ");
            model.put("V097", pd.getString("TMXHZZ_XS"));
            model.put("V098", pd.getString("TMXHZZ_AN"));
            model.put("V099", pd.getString("TMXHZZ_CZ"));
        }
        if (pd.getString("TMXHZZ_TWZHXH") != null && pd.getString("TMXHZZ_TWZHXH").indexOf("JFHB09H-D") > -1) {
            model.put("G69", " √ ");
            model.put("V100", pd.getString("TMXHZZ_XS"));
            model.put("V101", pd.getString("TMXHZZ_AN"));
            model.put("V102", pd.getString("TMXHZZ_CZ"));
        }
        if (pd.getString("TMXHZZ_TWZHXS_XX") != null && pd.getString("TMXHZZ_TWZHXS_XX").indexOf("单个") > -1) {
            model.put("G82", " √ ");
            if (pd.getString("TMXHZZ_ZDJC") != null && pd.getString("TMXHZZ_ZDJC") != "")
                model.put("V105", pd.getString("TMXHZZ_ZDJC"));
            if (pd.getString("TMXHZZ_MCGS") != null && pd.getString("TMXHZZ_MCGS") != "")
                model.put("V106", pd.getString("TMXHZZ_MCGS"));
            if (pd.getString("TMXHZZ_FJSM") != null && pd.getString("TMXHZZ_FJSM") != "")
                model.put("V107", pd.getString("TMXHZZ_FJSM"));
        }
        if (pd.getString("TMXHZZ_TWZHXS_XX") != null && pd.getString("TMXHZZ_TWZHXS_XX").indexOf("合用") > -1) {
            model.put("G83", " √ ");
            if (pd.getString("TMXHZZ_ZDJC") != null && pd.getString("TMXHZZ_ZDJC") != "")
                model.put("V109", pd.getString("TMXHZZ_ZDJC"));
            if (pd.getString("TMXHZZ_MCGS") != null && pd.getString("TMXHZZ_MCGS") != "")
                model.put("V110", pd.getString("TMXHZZ_MCGS"));
            if (pd.getString("TMXHZZ_FJSM") != null && pd.getString("TMXHZZ_FJSM") != "")
                model.put("V111", pd.getString("TMXHZZ_FJSM"));
        }

        if (!"".equals(pd.getNoneNULLString("FSC_DMT"))) {
            model.put("G84", " √ ");
            model.put("G85", pd.getNoneNULLString("FSC_DMT"));
        }
        if ("1".equals(pd.getString("TMXHZZ_WZYCOPMWAN"))) {
            model.put("V112", " √ ");
        }
        if ("1".equals(pd.getString("TMXHZZ_GBSCJRCZX"))) {
            model.put("V113", " √ ");
        }

        model.put("G86", pd.getNoneNULLString("FSCDMT_SL"));

        //常规非标
        setCGFBWordList(model, pd);
        setCgfb(model, pd);

        model.put("BZ01", pd.getString("DT_REMARK") != null ? pd.getString("DT_REMARK") : "");
        String unstd = pd.getString("UNSTD");
        JSONArray jsonA = JSON.parseArray(unstd);
        String gg = "";

        //非标需求
        setFBXQWordList(model, pd, jsonA);

        String strdlx = PathUtil.getClasspath() + Const.FILEPATHFILE + "COD/Ascend 3000+ MRL_COD.docx";
        mv = new ModelAndView(new WordView("Ascend3000+MRL", strdlx), model);
        return mv;
    }

    //飞扬2018小机房
    public static ModelAndView GetFEIYANG(List<PageData> CodList) throws Exception {
        ModelAndView mv = null;
        PageData pd = CodList.get(0);
        Map<String, Object> model = new HashMap<>();
//		文档标签初始化
        String xh = "";
        for (int i = 1; i < 130; i++) {
            xh = "000" + i;
            model.put("V" + xh.substring(xh.length() - 3, xh.length()), "");
            model.put("G" + xh.substring(xh.length() - 2, xh.length()), "  ");
        }
        model.put("HT_NO", pd.get("HT_NO"));
        model.put("BJC_SL", pd.get("BJC_SL"));
        model.put("BJC_ENO", pd.get("BJC_ENO"));
        model.put("TJTTH", pd.get("TJTTH") != null ? pd.get("TJTTH") : "");
        model.put("OFFER_VERSION", StringUtils.isBlank(pd.getString("offer_version")) ? "01" : pd.get("offer_version"));
        model.put("name", pd.getNoneNULLString("name"));
        model.put("customer_name", pd.get("customer_name"));
        model.put("item_name", pd.get("item_name"));
        model.put("HT_JHRQ", pd.get("HT_JHRQ"));
        model.put("V011", pd.get("BZ_ZZ"));
        model.put("V012", pd.get("BZ_SD"));
        model.put("V013", pd.get("BZ_KMXS"));
        /*model.put("BASE_KZXT", pd.get("BASE_KZXT").equals("")?"":pd.get("BASE_KZXT"));*/
        if (pd.getString("BASE_KZFS") != null && pd.getString("BASE_KZFS").indexOf("单台") > -1) model.put("G01", " √ ");
        if (pd.getString("BASE_KZFS") != null && pd.getString("BASE_KZFS").indexOf("两台并联") > -1)
            model.put("G02", " √ ");
        if (pd.getString("BASE_KZFS") != null && pd.getString("BASE_KZFS").indexOf("三台群控") > -1)
            model.put("G03", " √ ");
        if (pd.getString("BASE_KZFS") != null && pd.getString("BASE_KZFS").indexOf("四台群控") > -1)
            model.put("G04", " √ ");
        if (pd.getString("BASE_YYZJ") != null && pd.getString("BASE_YYZJ") != "")
            model.put("BASE_YYZJ", pd.get("BASE_YYZJ"));
        if (pd.getString("BASE_JDJG") != null && pd.getString("BASE_JDJG").indexOf("全混凝土") > -1)
            model.put("G05", " √ ");
        if (pd.getString("BASE_JDJG") != null && pd.getString("BASE_JDJG").indexOf("框架结构") > -1)
            model.put("G06", " √ ");
        if (pd.getString("BASE_JDJG") != null && pd.getString("BASE_JDJG").indexOf("钢结构") > -1) model.put("G07", " √ ");
        if (pd.getString("BASE_QGLJJ") != null && pd.getString("BASE_QGLJJ") != "")
            model.put("V024", pd.get("BASE_QGLJJ"));
        if (pd.getString("BASE_JXGG") != null && pd.getString("BASE_JXGG") != "")
            model.put("V026", pd.get("BASE_JXGG"));
        if (pd.getString("BASE_JXGD") != null && pd.getString("BASE_JXGD").indexOf("2300") > -1)
            model.put("G08", " √ ");
        if (pd.getString("BASE_JXGD") != null && pd.getString("BASE_JXGD").indexOf("2500") > -1)
            model.put("G09", " √ ");
        if (pd.getString("BASE_JXGD") != null && pd.getString("BASE_JXGD").indexOf("2400") > -1)
            model.put("G10", " √ ");
        if (pd.getString("BASE_JXGD") != null && pd.getString("BASE_JXGD").indexOf("2600") > -1)
            model.put("G11", " √ ");
        if (pd.getString("BASE_JXGD") != null && pd.getString("BASE_JXGD").indexOf("2700") > -1)
        	model.put("G111", " √ ");
        if (pd.getString("BASE_KMCC") != null && pd.getString("BASE_KMCC") != "")
            model.put("V027", pd.get("BASE_KMCC"));

        if ("PM门机/2D光幕".equals(pd.getString("BASE_MLXMBH"))) {
            model.put("G12", " √ ");
        } else {
            if (StringUtils.isNoneBlank(pd.getString("BASE_MLXMBH"))) {
                model.put("V030", pd.getString("BASE_MLXMBH"));
                model.put("G13", " √ ");
            }
        }
        if (pd.getString("BASE_JDCZQHD") != null && pd.getString("BASE_JDCZQHD").equals("250")) {
            model.put("G14", " √ ");
        } else {
            model.put("G15", " √ ");
            model.put("V031", pd.getString("BASE_JDCZQHD").equals("") ? "" : pd.get("BASE_JDCZQHD"));
        }
        model.put("V032", pd.get("BASE_TSGD"));
        model.put("V033", pd.get("BZ_C"));
        model.put("V034", pd.get("BZ_Z"));
        model.put("V035", pd.get("BZ_M"));
        model.put("V036", pd.get("BASE_JDK"));
        model.put("V037", pd.get("BASE_JDS"));
        model.put("V038", pd.get("BASE_DKSD"));
        model.put("V039", pd.get("BASE_DCGD"));
        model.put("V040", pd.get("BASE_JZZT"));
        model.put("V041", pd.get("BASE_LCBJ"));
        if (pd.getString("OPT_MWAN") != null && pd.getString("OPT_MWAN").equals("1")) model.put("G16", " √ ");
        if (pd.getString("OPT_HJZDFHJZ") != null && pd.getString("OPT_HJZDFHJZ").equals("1")) model.put("G17", " √ ");
        if (pd.getString("OPT_XFYYX") != null && pd.getString("OPT_XFYYX").equals("1")) model.put("G18", " √ ");
        if (pd.getString("OPT_JXDZZ") != null && pd.getString("OPT_JXDZZ").equals("1")) model.put("G19", " √ ");
        if (pd.getString("OPT_CCTVDL") != null && pd.getString("OPT_CCTVDL").equals("1")) model.put("G20", " √ ");
        if (pd.getString("OPT_TDJJJY") != null && pd.getString("OPT_TDJJJY").equals("1")) model.put("G21", " √ ");
        if (pd.getString("OPT_DJGRBH") != null && pd.getString("OPT_DJGRBH").equals("1")) model.put("G22", " √ ");
        if (pd.getString("OPT_KQJHZZ") != null && pd.getString("OPT_KQJHZZ").equals("1")) model.put("G23", " √ ");

        model.put("G24", pd.getString("OPT_NMYKJAN").equals("") ? "" : pd.get("OPT_NMYKJAN") + "个");
        if (pd.getString("OPT_FDLCZ") != null && pd.getString("OPT_FDLCZ").equals("1")) model.put("G25", " √ ");
        if (pd.getString("OPT_ZPC") != null && pd.getString("OPT_ZPC").equals("1")) model.put("G26", " √ ");
        if (pd.getString("OPT_BAJK") != null && pd.getString("OPT_BAJK").equals("1")) model.put("G27", " √ ");
        if (pd.getString("OPT_YYBZ") != null && pd.getString("OPT_YYBZ").equals("1")) model.put("G28", " √ ");
        if (pd.getString("OPT_QPGM") != null && pd.getString("OPT_QPGM").equals("1")) model.put("G29", " √ ");
        if (pd.getString("OPT_DLFW") != null && pd.getString("OPT_DLFW").equals("1")) model.put("G30", " √ ");
        if (pd.getString("OPT_KMBC") != null && pd.getString("OPT_KMBC").equals("1")) model.put("G31", " √ ");
        if (pd.getString("OPT_DZYX") != null && pd.getString("OPT_DZYX").equals("1")) model.put("G32", " √ ");
        if (pd.getString("OPT_NLHK") != null && pd.getString("OPT_NLHK").equals("1")) model.put("G33", " √ ");
        if (pd.getString("DZJKSDJXT_DJTXFS") != null && pd.getString("DZJKSDJXT_DJTXFS").indexOf("分线") > -1)
            model.put("G34", " √ ");
        if (pd.getString("DZJKSDJXT_DJTXFS") != null && pd.getString("DZJKSDJXT_DJTXFS").indexOf("总线") > -1)
            model.put("G35", " √ ");
        if (pd.getString("DZJKSDJXT_DJTS") != null && pd.getString("DZJKSDJXT_DJTS") != "")
            model.put("V050", pd.get("DZJKSDJXT_DJTS"));
        if (pd.getString("JXZH_JMZH") != null && pd.getString("JXZH_JMZH") != "")
            model.put("G36", pd.getString("JXZH_JMZH"));
        if (pd.getString("JXZH_JMSBH") != null && pd.getString("JXZH_JMSBH") != "")
            model.put("G37", pd.getString("JXZH_JMSBH"));
        //if(pd.getString("JXZH_JMZH") != null && pd.getString("JXZH_JMZH").indexOf("喷涂") >-1 )model.put("G38", " √ ");
        if (pd.getString("JXZH_QWB") != null && pd.getString("JXZH_QWB").indexOf("发纹") > -1) model.put("G39", " √ ");
        if (pd.getString("JXZH_QWB") != null && pd.getString("JXZH_QWB").indexOf("镜面") > -1) model.put("G40", " √ ");
        if (pd.getString("JXZH_QWB") != null && pd.getString("JXZH_QWB").indexOf("喷涂") > -1) model.put("G41", " √ ");
        if (pd.getString("JXZH_CWB") != null && pd.getString("JXZH_CWB").indexOf("发纹") > -1) model.put("G42", " √ ");
        if (pd.getString("JXZH_CWB") != null && pd.getString("JXZH_CWB").indexOf("镜面") > -1) model.put("G43", " √ ");
        if (pd.getString("JXZH_CWB") != null && pd.getString("JXZH_CWB").indexOf("喷涂") > -1) model.put("G44", " √ ");
        if (pd.getString("JXZH_HWB") != null && pd.getString("JXZH_HWB").indexOf("发纹") > -1) model.put("G45", " √ ");
        if (pd.getString("JXZH_HWB") != null && pd.getString("JXZH_HWB").indexOf("镜面") > -1) model.put("G46", " √ ");
        if (pd.getString("JXZH_HWB") != null && pd.getString("JXZH_HWB").indexOf("喷涂") > -1) model.put("G47", " √ ");
        if (pd.getString("JXZH_JMSBH") != null && pd.getString("JXZH_JMSBH") != "")
            model.put("V052", pd.get("JXZH_JMSBH"));
        if (pd.getString("JXZH_QWBSBH") != null && pd.getString("JXZH_QWBSBH") != "")
            model.put("V053", pd.get("JXZH_QWBSBH"));
        if (pd.getString("JXZH_CWBSBH") != null && pd.getString("JXZH_CWBSBH") != "")
            model.put("V054", pd.get("JXZH_CWBSBH"));
        if (pd.getString("JXZH_HWBSBH") != null && pd.getString("JXZH_HWBSBH") != "")
            model.put("V055", pd.get("JXZH_HWBSBH"));

        if (pd.getString("JXZH_JDZH") != null && pd.getString("JXZH_JDZH").equals("悬吊式:JF-CL20(450-2000kg标准)"))
            model.put("G48", " √ ");

        else if (pd.getString("JXZH_JDZH") != null && pd.getString("JXZH_JDZH").indexOf("集成式") > -1)
            model.put("V056", " √ ");
        else if (pd.getString("JXZH_JDZH") != null && pd.getString("JXZH_JDZH").indexOf("悬吊式") > -1)
            model.put("V057", " √ ");
        if (pd.getString("JXZH_AQC") != null && pd.getString("JXZH_AQC").indexOf("有") > -1) model.put("G50", " √ ");
        if (pd.getString("JXZH_AQC") != null && pd.getString("JXZH_AQC").indexOf("无") > -1) model.put("G49", " √ ");
        if (pd.getString("JXZH_DBXH") != null && pd.getString("JXZH_DBXH") != "")
            model.put("JXZH_DBXH", pd.get("JXZH_DBXH"));
        else model.put("JXZH_DBXH", "");
        if (pd.getString("JXZH_DBZXHD") != null && pd.getString("JXZH_DBZXHD") != "")
            model.put("JXZH_DBZXHD", pd.get("JXZH_DBZXHD"));
        else model.put("JXZH_DBZXHD", "");
        if (pd.getString("JXZH_YLZHZL") != null && pd.getString("JXZH_YLZHZL") != "")
            model.put("V059", pd.get("JXZH_YLZHZL"));
        if (pd.getString("JXZH_FSXH") != null) {
            model.put("V060", pd.get("JXZH_FSXH"));
        } else {
            model.put("G53", " √ ");
        }


        //if(pd.getString("JXZH_FSAZWZ") != null && pd.getString("JXZH_FSAZWZ").indexOf("后围壁") >-1 )model.put("G54", " √ ");
        //if(pd.getString("JXZH_FSAZWZ") != null && pd.getString("JXZH_FSAZWZ").indexOf("左围壁") >-1 )model.put("G55", " √ ");
        //if(pd.getString("JXZH_FSAZWZ") != null && pd.getString("JXZH_FSAZWZ").indexOf("右围壁") >-1 )model.put("G56", " √ ");
        if ("1".equals(pd.getString("JXZH_FSAZWZ_H"))) model.put("G54", " √ ");
        if ("1".equals(pd.getString("JXZH_FSAZWZ_Z"))) model.put("G55", " √ ");
        if ("1".equals(pd.getString("JXZH_FSAZWZ_Y"))) model.put("G56", " √ ");
        if (pd.getString("TMMT_SCTMMT") != null && pd.getString("TMMT_SCTMMT").indexOf("发纹") > -1) {
            model.put("G57", " √ ");
            model.put("V069", pd.getNoneNULLString("FDMT_SL"));
        }
        if (pd.getString("TMMT_SCTMMT") != null && pd.getString("TMMT_SCTMMT").indexOf("镜面") > -1) {
            model.put("G58", " √ ");
            model.put("V070", pd.get("FDMT_SL"));
        }
        if (pd.getString("TMMT_SCTMMT") != null && pd.getString("TMMT_SCTMMT").indexOf("喷涂") > -1) {
            model.put("G59", " √ ");
            model.put("V072", pd.get("FDMT_SL"));
        }
        if (pd.getString("TMMT_SCSBH") != null && pd.getString("TMMT_SCSBH") != "")
            model.put("V071", pd.get("TMMT_SCSBH"));
        if (pd.getString("TMMT_FSCTMMT") != null && pd.getString("TMMT_FSCTMMT").indexOf("喷涂") > -1) {
            model.put("G60", " √ ");
            model.put("V076", pd.getNoneNULLString("FSCFDMT_SL"));
        }
        if (pd.getString("TMMT_FSCTMMT") != null && pd.getString("TMMT_FSCTMMT").indexOf("镜面") > -1) {
            model.put("G61", " √ ");
            model.put("V077", pd.get("FSCFDMT_SL"));
        }
        if (pd.getString("TMMT_FSCTMMT") != null && pd.getString("TMMT_FSCTMMT").indexOf("发纹") > -1) {
            model.put("G62", " √ ");
            model.put("V078", pd.get("FSCFDMT_SL"));
        }
        if (pd.getString("TMMT_FSCSBH") != null && pd.getString("TMMT_FSCSBH") != "")
            model.put("V075", pd.get("TMMT_FSCSBH"));
        if (pd.getString("CZP_CZPWZ") != null && pd.getString("CZP_CZPWZ") != "") model.put("G65", pd.get("CZP_CZPWZ"));

        if (pd.getString("TMXHZZ_TWZHLX") != null && pd.getString("TMXHZZ_TWZHLX").indexOf("无底盒") > -1)
            model.put("G80", " √ ");
        if (pd.getString("TMXHZZ_TWZHLX") != null && pd.getString("TMXHZZ_TWZHLX").indexOf("有底盒") > -1)
            model.put("G81", " √ ");

        if (pd.getString("CZP_CZPXH") != null && pd.getString("CZP_CZPXH").indexOf("JFCOP14H-D1") > -1) {
            model.put("G63", " √ ");
            model.put("V081", pd.getString("CZP_XS"));
            model.put("V082", pd.getString("CZP_AN"));
            model.put("V083", pd.getString("CZP_CZ"));
        }
        if (pd.getString("CZP_CZPXH") != null && pd.getString("CZP_CZPXH").indexOf("JFCOP14H-D") > -1) {
            model.put("G64", " √ ");
            model.put("V084", pd.getString("CZP_XS"));
            model.put("V085", pd.getString("CZP_AN"));
            model.put("V086", pd.getString("CZP_CZ"));
        }
        model.put("V087", pd.getString("CZP_CZPWZ"));
        if (pd.getString("TMXHZZ_TWZHXH") != null && pd.getString("TMXHZZ_TWZHXH").indexOf("JFHB14H-D1") > -1) {
            model.put("G68", " √ ");
            model.put("V097", pd.getString("TMXHZZ_XS"));
            model.put("V098", pd.getString("TMXHZZ_AN"));
            model.put("V099", pd.getString("TMXHZZ_CZ"));
        }
        if (pd.getString("TMXHZZ_TWZHXH") != null && pd.getString("TMXHZZ_TWZHXH").indexOf("JFHB09H-D") > -1) {
            model.put("G69", " √ ");
            model.put("V100", pd.getString("TMXHZZ_XS"));
            model.put("V101", pd.getString("TMXHZZ_AN"));
            model.put("V102", pd.getString("TMXHZZ_CZ"));
        }

        if (pd.getString("TMXHZZ_TWZHXS_XX") != null && pd.getString("TMXHZZ_TWZHXS_XX").indexOf("单个") > -1) {
            model.put("G82", " √ ");
            if (pd.getString("TMXHZZ_ZDJC") != null && pd.getString("TMXHZZ_ZDJC") != "")
                model.put("V105", pd.getString("TMXHZZ_ZDJC"));
            if (pd.getString("TMXHZZ_MCGS") != null && pd.getString("TMXHZZ_MCGS") != "")
                model.put("V106", pd.getString("TMXHZZ_MCGS"));
            if (pd.getString("TMXHZZ_FJSM") != null && pd.getString("TMXHZZ_FJSM") != "")
                model.put("V107", pd.getString("TMXHZZ_FJSM"));
        }
        if (pd.getString("TMXHZZ_TWZHXS_XX") != null && pd.getString("TMXHZZ_TWZHXS_XX").indexOf("合用") > -1) {
            model.put("G83", " √ ");
            if (pd.getString("TMXHZZ_ZDJC") != null && pd.getString("TMXHZZ_ZDJC") != "")
                model.put("V108", pd.getString("TMXHZZ_ZDJC"));
            if (pd.getString("TMXHZZ_MCGS") != null && pd.getString("TMXHZZ_MCGS") != "")
                model.put("V109", pd.getString("TMXHZZ_MCGS"));
            if (pd.getString("TMXHZZ_FJSM") != null && pd.getString("TMXHZZ_FJSM") != "")
                model.put("V120", pd.getString("TMXHZZ_FJSM"));
        }
        if ("1".equals(pd.getString("TMXHZZ_WZYCOPMWAN"))) {
            model.put("V121", " √ ");
        }
        if ("1".equals(pd.getString("TMXHZZ_GBSCJRCZX"))) {
            model.put("V122", " √ ");
        }

        model.put("G84", "1".equals(pd.getString("OPT_JFGT")) ? " √ " : "");
        model.put("G85", "1".equals(pd.getString("OPT_ICKZKSB")) ? " √ " : "");
        model.put("G86", pd.getNoneNULLString("OPT_PTDTKT"));
        model.put("G87", "1".equals(pd.getString("OPT_JKGM")) ? " √ " : "");
        model.put("G88", "1".equals(pd.getString("OPT_GTMJXJMBF")) ? " √ " : "");
        model.put("G89", pd.getNoneNULLString("OPT_GTMS"));
        model.put("G90", "1".equals(pd.getString("OPT_DJT")) ? " √ " : "");
        model.put("G91", pd.getNoneNULLString("OPT_CMZH"));
        model.put("G92", "1".equals(pd.getNoneNULLString("OPT_ICK")) ? "刷卡后手动选择到达楼层" : "2".equals(pd.getNoneNULLString("OPT_ICK")) ? "刷卡后自动选择到达楼层" : "");
        model.put("G93", pd.getNoneNULLString("OPT_ICKKP"));
        model.put("G94", pd.getNoneNULLString("OPT_ZYFTSDTKT"));
        model.put("G95", "1".equals(pd.getString("OPT_JKYYJ")) ? " √ " : "");
        model.put("G96", pd.getNoneNULLString("OPT_GTMTMBF"));

        //常规非标
        setCgfb(model, pd);
        setCGFBWordList(model, pd);

        model.put("BZ01", pd.getString("DT_REMARK") != null ? pd.getString("DT_REMARK") : "");
        String unstd = pd.getString("UNSTD");
        JSONArray jsonA = JSON.parseArray(unstd);
        String gg = "";

        //非标需求
        setFBXQWordList(model, pd, jsonA);

        String strdlx = PathUtil.getClasspath() + Const.FILEPATHFILE + "COD/Ascend 3000+_COD.docx";
        mv = new ModelAndView(new WordView("Ascend2018", strdlx), model);
        return mv;
    }

    //飞扬消防梯 cod输出
    public static ModelAndView GetFEIYANGXF(List<PageData> CodList) throws Exception {
        ModelAndView mv = null;
        PageData pd = CodList.get(0);
        Map<String, Object> model = new HashMap<>();
//		文档标签初始化
        String xh = "";
        for (int i = 1; i < 130; i++) {
            xh = "000" + i;
            model.put("V" + xh.substring(xh.length() - 3, xh.length()), "");
            model.put("G" + xh.substring(xh.length() - 2, xh.length()), "  ");
        }
        model.put("HT_NO", pd.get("HT_NO"));
        model.put("BJC_SL", pd.get("BJC_SL"));
        model.put("BJC_ENO", pd.get("BJC_ENO"));
        model.put("TJTTH", pd.get("TJTTH") != null ? pd.get("TJTTH") : "");
        model.put("OFFER_VERSION", StringUtils.isBlank(pd.getString("offer_version")) ? "01" : pd.get("offer_version"));
        model.put("name", pd.get("name"));
        model.put("customer_name", pd.get("customer_name"));
        model.put("item_name", pd.get("item_name"));
        model.put("HT_JHRQ", pd.get("HT_JHRQ"));
        model.put("V011", pd.get("BZ_ZZ"));
        model.put("V012", pd.get("BZ_SD"));
        model.put("V013", pd.get("BZ_KMXS"));
        model.put("BASE_KZXT", pd.get("BASE_KZXT"));
        if (pd.getString("BASE_KZFS") != null && pd.getString("BASE_KZFS").indexOf("单台") > -1) model.put("G01", " √ ");
        if (pd.getString("BASE_KZFS") != null && pd.getString("BASE_KZFS").indexOf("两台并联") > -1)
            model.put("G02", " √ ");
        if (pd.getString("BASE_KZFS") != null && pd.getString("BASE_KZFS").indexOf("三台群控") > -1)
            model.put("G03", " √ ");
        if (pd.getString("BASE_KZFS") != null && pd.getString("BASE_KZFS").indexOf("四台群控") > -1)
            model.put("G04", " √ ");
        model.put("BASE_YYZJ", pd.get("BASE_YYZJ"));
        if (pd.getString("BASE_JDJG") != null && pd.getString("BASE_JDJG").indexOf("全混凝土") > -1)
            model.put("G05", " √ ");
        if (pd.getString("BASE_JDJG") != null && pd.getString("BASE_JDJG").indexOf("框架结构") > -1)
            model.put("G06", " √ ");
        if (pd.getString("BASE_JDJG") != null && pd.getString("BASE_JDJG").indexOf("钢结构") > -1) model.put("G07", " √ ");
        model.put("V024", pd.get("BASE_QGLJJ"));
        model.put("V026", pd.get("BASE_JXGG"));
        if (pd.getString("BASE_JXGD") != null && pd.getString("BASE_JXGD").indexOf("2400") > -1)
            model.put("G08", " √ ");
        if (pd.getString("BASE_JXGD") != null && pd.getString("BASE_JXGD").indexOf("2500") > -1)
            model.put("G09", " √ ");
        if (pd.getString("BASE_JXGD") != null && pd.getString("BASE_JXGD").indexOf("2300") > -1)
            model.put("G10", " √ ");
        if (pd.getString("BASE_JXGD") != null && pd.getString("BASE_JXGD").indexOf("2500") > -1)
            model.put("G11", " √ ");
        model.put("V027", pd.get("BASE_KMCC"));
        if (pd.getString("BASE_MLXMBH") != null) {
            model.put("V029", pd.getString("BASE_MLXMBH"));
        }
        if (pd.getString("BASE_JDCZQHD") != null && pd.getString("BASE_JDCZQHD").equals("250")) {
            model.put("G14", " √ ");
        } else {
            model.put("G15", " √ ");
            model.put("V030", pd.getString("BASE_JDCZQHD"));
        }
        model.put("V032", pd.get("BASE_TSGD"));
        model.put("V033", pd.get("BZ_C"));
        model.put("V034", pd.get("BZ_Z"));
        model.put("V035", pd.get("BZ_M"));
        model.put("V036", pd.get("BASE_JDK"));
        model.put("V037", pd.get("BASE_JDS"));
        model.put("V038", pd.get("BASE_DKSD"));
        model.put("V039", pd.get("BASE_DCGD"));
        model.put("V040", pd.get("BASE_JZZT"));
        model.put("V041", pd.get("BASE_LCBJ"));
        if (pd.getString("OPT_MWAN") != null && pd.getString("OPT_MWAN").equals("1")) model.put("G16", " √ ");
        if (pd.getString("OPT_HJZDFHJZ") != null && pd.getString("OPT_HJZDFHJZ").equals("1")) model.put("G17", " √ ");
        if (pd.getString("OPT_XFYYX") != null && pd.getString("OPT_XFYYX").equals("1")) model.put("G18", " √ ");
        if (pd.getString("OPT_JXDZZ") != null && pd.getString("OPT_JXDZZ").equals("1")) model.put("G19", " √ ");
        if (pd.getString("OPT_CCTVDL") != null && pd.getString("OPT_CCTVDL").equals("1")) model.put("G20", " √ ");
        if (pd.getString("OPT_TDJJJY") != null && pd.getString("OPT_TDJJJY").equals("1")) model.put("G21", " √ ");
        if (pd.getString("OPT_DJGRBH") != null && pd.getString("OPT_DJGRBH").equals("1")) model.put("G22", " √ ");
        if (pd.getString("OPT_KQJHZZ") != null && pd.getString("OPT_KQJHZZ").equals("1")) model.put("G23", " √ ");
        if (pd.getString("OPT_NMYKJAN") != null && pd.getString("OPT_NMYKJAN").equals("1")) model.put("G24", " √ ");
        if (pd.getString("OPT_FDLCZ") != null && pd.getString("OPT_FDLCZ").equals("1")) model.put("G25", " √ ");
        if (pd.getString("OPT_ZPC") != null && pd.getString("OPT_ZPC").equals("1")) model.put("G26", " √ ");
        if (pd.getString("OPT_BAJK") != null && pd.getString("OPT_BAJK").equals("1")) model.put("G27", " √ ");
        if (pd.getString("OPT_YYBZ") != null && pd.getString("OPT_YYBZ").equals("1")) model.put("G28", " √ ");
        if (pd.getString("OPT_QPGM") != null && pd.getString("OPT_QPGM").equals("1")) model.put("G29", " √ ");
        if (pd.getString("OPT_DLFW") != null && pd.getString("OPT_DLFW").equals("1")) model.put("G30", " √ ");
        if (pd.getString("OPT_KMBC") != null && pd.getString("OPT_KMBC").equals("1")) model.put("G31", " √ ");
        if (pd.getString("OPT_DZYX") != null && pd.getString("OPT_DZYX").equals("1")) model.put("G32", " √ ");
        if (pd.getString("OPT_NLHK") != null && pd.getString("OPT_NLHK").equals("1")) model.put("G33", " √ ");
        if (pd.getString("DZJKSDJXT_DJTXFS") != null && pd.getString("DZJKSDJXT_DJTXFS").indexOf("一对一") > -1)
            model.put("G34", " √ ");
        if (pd.getString("DZJKSDJXT_DJTXFS") != null && pd.getString("DZJKSDJXT_DJTXFS").indexOf("一对多") > -1)
            model.put("G35", " √ ");
        model.put("V050", pd.get("DZJKSDJXT_DJTS"));

        if (pd.getString("JXZH_JMZH") != null && pd.getString("JXZH_JMZH") != "")
            model.put("G36", pd.getString("JXZH_JMZH"));
        if (pd.getString("JXZH_JMSBH") != null && pd.getString("JXZH_JMSBH") != "")
            model.put("G37", pd.getString("JXZH_JMSBH"));

        if (pd.getString("JXZH_JM") != null && pd.getString("JXZH_JM").indexOf("喷涂") > -1) model.put("G38", " √ ");
        if (pd.getString("JXZH_QWB") != null && pd.getString("JXZH_QWB").indexOf("SUS304") > -1)
            model.put("G39", " √ ");
        if (pd.getString("JXZH_QWB") != null && pd.getString("JXZH_QWB").indexOf("镜面") > -1) model.put("G40", " √ ");
        if (pd.getString("JXZH_QWB") != null && pd.getString("JXZH_QWB").indexOf("喷涂") > -1) model.put("G41", " √ ");
        if (pd.getString("JXZH_CWB") != null && pd.getString("JXZH_CWB").indexOf("SUS304") > -1)
            model.put("G42", " √ ");
        if (pd.getString("JXZH_CWB") != null && pd.getString("JXZH_CWB").indexOf("镜面") > -1) model.put("G43", " √ ");
        if (pd.getString("JXZH_CWB") != null && pd.getString("JXZH_CWB").indexOf("喷涂") > -1) model.put("G44", " √ ");
        if (pd.getString("JXZH_HWB") != null && pd.getString("JXZH_HWB").indexOf("SUS304") > -1)
            model.put("G45", " √ ");
        if (pd.getString("JXZH_HWB") != null && pd.getString("JXZH_HWB").indexOf("镜面") > -1) model.put("G46", " √ ");
        if (pd.getString("JXZH_HWB") != null && pd.getString("JXZH_HWB").indexOf("喷涂") > -1) model.put("G47", " √ ");
        model.put("V052", pd.get("JXZH_JMSBH"));
        model.put("V053", pd.get("JXZH_QWBSBH"));
        model.put("V054", pd.get("JXZH_CWBSBH"));
        model.put("V055", pd.get("JXZH_HWBSBH"));
        if (pd.getString("JXZH_JDZH") != null && pd.getString("JXZH_JDZH").indexOf("集成式") > -1) model.put("G48", " √ ");
        if (pd.getString("JXZH_JDZH") != null && pd.getString("JXZH_JDZH").indexOf("悬吊式") > -1)
            model.put("V056", " √ ");

        if (pd.getString("JXZH_AQC") != null && pd.getString("JXZH_AQC").indexOf("有") > -1) model.put("G50", " √ ");
        if (pd.getString("JXZH_AQC") != null && pd.getString("JXZH_AQC").indexOf("无") > -1) model.put("G49", " √ ");
        model.put("JXZH_DBXH", pd.get("JXZH_DBXH"));
        model.put("JXZH_DBZXHD", pd.get("JXZH_DBZXHD"));
        model.put("V059", pd.get("JXZH_YLZHZL"));
        if (pd.getString("JXZH_FSXH") != null) {
            model.put("V060", pd.getString("JXZH_FSXH"));
        } else {
            model.put("G53", " √ ");
        }

        //if(pd.getString("JXZH_FSAZWZ") != null && pd.getString("JXZH_FSAZWZ").indexOf("后围壁") >-1 )model.put("G54", " √ ");
        //if(pd.getString("JXZH_FSAZWZ") != null && pd.getString("JXZH_FSAZWZ").indexOf("左围壁") >-1 )model.put("G55", " √ ");
        //if(pd.getString("JXZH_FSAZWZ") != null && pd.getString("JXZH_FSAZWZ").indexOf("右围壁") >-1 )model.put("G56", " √ ");

        if ("1".equals(pd.getString("JXZH_FSAZWZ_H"))) model.put("G54", " √ ");
        if ("1".equals(pd.getString("JXZH_FSAZWZ_Z"))) model.put("G55", " √ ");
        if ("1".equals(pd.getString("JXZH_FSAZWZ_Y"))) model.put("G56", " √ ");
        if (pd.getString("TMMT_SCTMMT") != null && pd.getString("TMMT_SCTMMT").indexOf("发纹") > -1) {
            model.put("G57", " √ ");
            model.put("V069", pd.get("FDMT_SL"));
        }
        if (pd.getString("TMMT_SCTMMT") != null && pd.getString("TMMT_SCTMMT").indexOf("镜面") > -1) {
            model.put("G58", " √ ");
            model.put("V070", pd.get("FDMT_SL"));
        }
        if (pd.getString("TMMT_SCTMMT") != null && pd.getString("TMMT_SCTMMT").indexOf("喷涂") > -1) {
            model.put("G59", " √ ");
            model.put("V072", pd.get("FDMT_SL"));
        }
        if (pd.getString("TMMT_SCSBH") != null && pd.getString("TMMT_SCSBH") != "")
            model.put("V071", pd.get("TMMT_SCSBH"));
        if (pd.getString("TMMT_FSCTMMT") != null && pd.getString("TMMT_FSCTMMT").indexOf("喷涂") > -1) {
            model.put("G60", " √ ");
            model.put("V076", pd.get("FSCFDMT_SL"));
        }
        if (pd.getString("TMMT_FSCTMMT") != null && pd.getString("TMMT_FSCTMMT").indexOf("镜面") > -1) {
            model.put("G61", " √ ");
            model.put("V077", pd.get("FSCFDMT_SL"));
        }
        if (pd.getString("TMMT_FSCTMMT") != null && pd.getString("TMMT_FSCTMMT").indexOf("发纹") > -1) {
            model.put("G62", " √ ");
            model.put("V078", pd.get("FSCFDMT_SL"));
        }
        model.put("V075", pd.get("TMMT_FSCSBH") != null ? pd.get("TMMT_FSCSBH") : "");
        if (pd.getString("CZP_CZPXH") != null) {
            model.put("G63", " √ ");
            model.put("V0101", pd.getString("CZP_CZPXH"));
            model.put("V081", pd.getString("CZP_XS"));
            model.put("V082", pd.getString("CZP_AN"));
            model.put("V083", pd.getString("CZP_CZ"));
        } else {
            model.put("V0101", "");
        }

        model.put("V087", pd.getString("CZP_CZPWZ"));
        if (pd.getString("TMXHZZ_TWZHXH") != null && pd.getString("TMXHZZ_TWZHXH").indexOf("JFHB09H-D1") > -1) {
            model.put("G68", " √ ");
            model.put("V097", pd.getString("TMXHZZ_XS"));
            model.put("V098", pd.getString("TMXHZZ_AN"));
            model.put("V099", pd.getString("TMXHZZ_CZ"));
        }

        model.put("V105", pd.getString("TMXHZZ_ZDJC"));
        model.put("V106", pd.getString("TMXHZZ_MCGS"));
        model.put("V107", pd.getString("TMXHZZ_FJSM"));

        //常规非标
        setCgfb(model, pd);
        setCGFBWordList(model, pd);

        model.put("BZ01", pd.getString("DT_REMARK") != null ? pd.getString("DT_REMARK") : "");
        String unstd = pd.getString("UNSTD");
        JSONArray jsonA = JSON.parseArray(unstd);
        setFBXQWordList(model, pd, jsonA);
        
        /*String gg = "";
        for (int i = 0; i < 18; i++) {
            xh = "00" + (i + 1);
            gg = "00" + (i + 1);
            if (jsonA.size() > i) {
                JSONObject jsonO = jsonA.getJSONObject(i);
                model.put("NR" + xh.substring(xh.length() - 2, xh.length()), jsonO.getString("nonstandrad_describe"));
                gg = "00" + (i + 1);
                model.put("PSDH" + gg.substring(gg.length() - 2, gg.length()), jsonO.getString("master_id") != null ? jsonO.getString("master_id") : "");
            } else {
                model.put("NR" + xh.substring(xh.length() - 2, xh.length()), "");

                model.put("PSDH" + gg.substring(gg.length() - 2, gg.length()), "");
            }
        }*/
        model.put("BASE_YYZJ", "");
        model.put("CZP_CZPLX", pd.get("CZP_CZPLX") != null ? pd.get("CZP_CZPLX") : "");
        model.put("TMXHZZ_TWZHLX", pd.get("TMXHZZ_TWZHLX") != null ? pd.get("TMXHZZ_TWZHLX") : "");

        String strdlx = PathUtil.getClasspath() + Const.FILEPATHFILE + "COD/Ascend FFE_COD.docx";
        mv = new ModelAndView(new WordView("Document", strdlx), model);
        return mv;
    }

    //dnp9300
    public static ModelAndView GetDNP9300(List<PageData> CodList) throws Exception {
        ModelAndView mv = null;
        PageData pd = CodList.get(0);
        Map<String, Object> model = new HashMap<>();
//		文档标签初始化
        String xh = "";
        for (int i = 1; i < 15; i++) {
            xh = "000" + i;
            model.put("G" + xh.substring(xh.length() - 2, xh.length()), "  ");
        }
        model.put("HT_NO", pd.get("HT_NO"));
        model.put("BJC_SL", pd.get("BJC_SL"));
        model.put("BJC_ENO", pd.get("BJC_ENO"));
        model.put("TJTTH", pd.get("TJTTH"));
        model.put("OFFER_VERSION", StringUtils.isBlank(pd.getString("offer_version")) ? "01" : pd.get("offer_version"));
        model.put("name", pd.get("name"));
        model.put("customer_name", pd.get("customer_name"));
        model.put("item_name", pd.get("item_name"));
        model.put("HT_JHRQ", pd.get("HT_JHRQ"));

        model.put("BZ_QXJD", pd.get("BZ_QXJD") != null ? pd.get("BZ_QXJD") : "");
        model.put("BZ_TJKD", pd.get("BZ_TJKD") != null ? pd.get("BZ_TJKD") : "");
        model.put("BZ_SPTJ", pd.get("BZ_SPTJ") != null ? pd.get("BZ_SPTJ") : "");
        model.put("BZ_TSGD", pd.get("BZ_TSGD") != null ? pd.get("BZ_TSGD") : "");
        model.put("BASE_SPKJ", pd.get("BASE_SPKJ") != null ? pd.get("BASE_SPKJ") : "");
        model.put("BZ_SD", pd.get("BZ_SD") != null ? pd.get("BZ_SD") : "");
        model.put("BASE_DY", pd.get("BASE_DY") != null ? pd.get("BASE_DY") : "");
        model.put("BASE_AZHJ", pd.get("BASE_AZHJ") != null ? pd.get("BASE_AZHJ") : "");
        model.put("BASE_FSLX", pd.get("BASE_FSLX") != null ? pd.get("BASE_FSLX") : "");
        model.put("BASE_FSGD", pd.get("BASE_FSGD") != null ? pd.get("BASE_FSGD") : "");
        model.put("BASE_ZJZCSL", pd.get("BASE_ZJZCSL") != null ? pd.get("BASE_ZJZCSL") : "");
        model.put("BASE_BZXS", pd.get("BASE_BZXS") != null ? pd.get("BASE_BZXS") : "");
        model.put("BASE_YSFS", pd.get("BASE_YSFS") != null ? pd.get("BASE_YSFS") : "");
        model.put("BASE_JHXT", pd.get("BASE_JHXT") != null ? pd.get("BASE_JHXT") : "");
        model.put("BASE_SDJC", pd.get("BASE_SDJC") != null ? pd.get("BASE_SDJC") : "");
        model.put("BASE_XDJC", pd.get("BASE_XDJC") != null ? pd.get("BASE_XDJC") : "");

        model.put("PART_JSJ", pd.get("PART_JSJ") != null ? pd.get("PART_JSJ") : "");
        model.put("PART_TJLX", pd.get("PART_TJLX") != null ? pd.get("PART_TJLX") : "");
        model.put("PART_TJYS", pd.get("PART_TJYS") != null ? pd.get("PART_TJYS") : "");
        model.put("PART_TJZFX", "1".equals(pd.get("PART_TJZFX")) ? " √ " : "");
        model.put("PART_TJBKCZ", pd.get("PART_TJBKCZ") != null ? pd.get("PART_TJBKCZ") : "");
        model.put("PART_FSDGCZ", pd.get("PART_FSDGCZ") != null ? pd.get("PART_FSDGCZ") : "");
        model.put("PART_FSDGG", pd.get("PART_FSDGG") != null ? pd.get("PART_FSDGG") : "");
        model.put("PART_FSDYS", pd.get("PART_FSDYS") != null ? pd.get("PART_FSDYS") : "");
        model.put("PART_WQBCZ", pd.get("PART_WQBCZ") != null ? pd.get("PART_WQBCZ") : "");
        model.put("PART_NWGBCZ", pd.get("PART_NWGBCZ") != null ? pd.get("PART_NWGBCZ") : "");
        model.put("PART_SCTBJHDGB", pd.get("PART_SCTBJHDGB") != null ? pd.get("PART_SCTBJHDGB") : "");
        model.put("PART_SCB", pd.get("PART_SCB") != null ? pd.get("PART_SCB") : "");
        model.put("PART_QDFS", pd.get("PART_QDFS") != null ? pd.get("PART_QDFS") : "");

        if (pd.getString("OPT_ANZDQ") != null && pd.getString("OPT_ANZDQ").equals("1")) model.put("G01", " √ ");
        if (pd.getString("OPT_GCD") != null && pd.getString("OPT_GCD").equals("1")) model.put("G02", " √ ");
        if (pd.getString("OPT_JTLXD") != null && pd.getString("OPT_JTLXD").equals("1")) model.put("G03", " √ ");
        if (pd.getString("OPT_ZDQMSJK") != null && pd.getString("OPT_ZDQMSJK").equals("1")) model.put("G04", " √ ");
        if (pd.getString("OPT_ZDJY") != null && pd.getString("OPT_ZDJY").equals("1")) model.put("G05", " √ ");
        if (pd.getString("OPT_QDLLZ") != null && pd.getString("OPT_QDLLZ").equals("1")) model.put("G06", " √ ");
        if (pd.getString("OPT_LEDWQZM") != null && pd.getString("OPT_LEDWQZM").equals("1")) model.put("G07", " √ ");
        if (pd.getString("OPT_TJFTBH") != null && pd.getString("OPT_TJFTBH").equals("1")) model.put("G08", " √ ");
        if (pd.getString("OPT_FSDDDBHZZ") != null && pd.getString("OPT_FSDDDBHZZ").equals("1")) model.put("G09", " √ ");
        if (pd.getString("OPT_ZDWQJXKG") != null && pd.getString("OPT_ZDWQJXKG").equals("1")) model.put("G10", " √ ");
        if (pd.getString("OPT_SCZM") != null && pd.getString("OPT_SCZM").equals("1")) model.put("G11", " √ ");
        if (pd.getString("OPT_YSFLQ") != null && pd.getString("OPT_YSFLQ").equals("1")) model.put("G12", " √ ");
        if (pd.getString("OPT_FHBH") != null && pd.getString("OPT_FHBH").equals("1")) model.put("G13", " √ ");
        if (pd.getString("OPT_TJLFHZ") != null && pd.getString("OPT_TJLFHZ").equals("1")) model.put("G14", " √ ");
        model.put("OPT_WZSWZ", pd.get("OPT_WZSWZ") != null ? pd.get("OPT_WZSWZ") : "");
        model.put("OPT_ZSBCL", pd.get("OPT_ZSBCL") != null ? pd.get("OPT_ZSBCL") : "");
        model.put("OPT_ZSBHD", pd.get("OPT_ZSBHD") != null ? pd.get("OPT_ZSBHD") : "");
        model.put("V036", pd.get("OPT_WXHL") != null ? pd.get("OPT_WXHL") : "");
        if (pd.getString("OPT_DZGSS") != null && pd.getString("OPT_DZGSS").equals("1")) model.put("OPT_DZGSS", " √ ");
        else model.put("OPT_DZGSS", "");
        if (pd.getString("OPT_FPZZ") != null && pd.getString("OPT_FPZZ").equals("1")) model.put("OPT_FPZZ", " √ ");
        else model.put("OPT_FPZZ", "");
        if (pd.getString("OPT_HJJR") != null && pd.getString("OPT_HJJR").equals("1")) model.put("OPT_HJJR", " √ ");
        else model.put("OPT_HJJR", "");
        if (pd.getString("OPT_SCJR") != null && pd.getString("OPT_SCJR").equals("1")) model.put("OPT_SCJR", " √ ");
        else model.put("OPT_SCJR", "");
        if (pd.getString("OPT_FSJR") != null && pd.getString("OPT_FSJR").equals("1")) model.put("OPT_FSJR", " √ ");
        else model.put("OPT_FSJR", "");

        model.put("OPT_GZXS", "1".equals(pd.get("OPT_GZXS")) ? " √ " : "");
        model.put("OPT_WQAQZZ", "1".equals(pd.get("OPT_WQAQZZ")) ? " √ " : "");
        model.put("OPT_FSZM", "1".equals(pd.get("OPT_FSZM")) ? " √ " : "");
        model.put("OPT_DLFDLJQ", "1".equals(pd.get("OPT_DLFDLJQ")) ? " √ " : "");

        model.put("BZ01", pd.get("DT_REMARK") != null ? pd.get("DT_REMARK") : "");
        String unstd = pd.getString("UNSTD");
        JSONArray jsonA = JSON.parseArray(unstd);

        //非标需求
        setFBXQWordList(model, pd, jsonA);

        String strdlx = PathUtil.getClasspath() + Const.FILEPATHFILE + "COD/DNP9300_COD.docx";
        mv = new ModelAndView(new WordView("Document", strdlx), model);
        return mv;
    }

    //dnr人行道
    public static ModelAndView GetDNR(List<PageData> CodList) throws Exception {
        ModelAndView mv = null;
        PageData pd = CodList.get(0);
        Map<String, Object> model = new HashMap<>();
//		文档标签初始化
        String xh = "";
        for (int i = 1; i < 15; i++) {
            xh = "000" + i;
            model.put("G" + xh.substring(xh.length() - 2, xh.length()), "　");
        }
        model.put("HT_NO", pd.get("HT_NO"));
        model.put("BJC_SL", pd.get("BJC_SL"));
        model.put("BJC_ENO", pd.get("BJC_ENO"));
        model.put("TJTTH", pd.get("TJTTH"));
        model.put("OFFER_VERSION", StringUtils.isBlank(pd.getString("offer_version")) ? "01" : pd.get("offer_version"));
        model.put("name", pd.get("name"));
        model.put("customer_name", pd.get("customer_name"));
        model.put("item_name", pd.get("item_name"));
        model.put("HT_JHRQ", pd.get("HT_JHRQ"));

        model.put("BZ_QXJD", pd.get("BZ_QXJD") != null ? pd.get("BZ_QXJD") : "");
        model.put("BZ_TBKD", pd.get("BZ_TBKD") != null ? pd.get("BZ_TBKD") : "");
        model.put("BZ_TSGD", pd.get("BZ_TSGD") != null ? pd.get("BZ_TSGD") : "");
        model.put("BASE_SPKJ", pd.get("BASE_SPKJ") != null ? pd.get("BASE_SPKJ") : "");
        model.put("BZ_SD", pd.get("BZ_SD") != null ? pd.get("BZ_SD") : "");
        model.put("BASE_DY", pd.get("BASE_DY") != null ? pd.get("BASE_DY") : "");
        model.put("BASE_AZHJ", pd.get("BASE_AZHJ") != null ? pd.get("BASE_AZHJ") : "");
        model.put("BASE_FSLX", pd.get("BASE_FSLX") != null ? pd.get("BASE_FSLX") : "");
        model.put("BASE_FSGD", pd.get("BASE_FSGD") != null ? pd.get("BASE_FSGD") : "");
        model.put("BASE_ZJZCSL", pd.get("BASE_ZJZCSL") != null ? pd.get("BASE_ZJZCSL") : "");
        model.put("BASE_BZXS", pd.get("BASE_BZXS") != null ? pd.get("BASE_BZXS") : "");
        model.put("BASE_YSFS", pd.get("BASE_YSFS") != null ? pd.get("BASE_YSFS") : "");
        model.put("BASE_JHXT", pd.get("BASE_JHXT") != null ? pd.get("BASE_JHXT") : "");
        model.put("BASE_SDJC", pd.get("BASE_SDJC") != null ? pd.get("BASE_SDJC") : "");

        model.put("PART_JSJ", pd.get("PART_JSJ") != null ? pd.get("PART_JSJ") : "");
        model.put("PART_TJLX", pd.get("PART_TJLX") != null ? pd.get("PART_TJLX") : "");
        model.put("PART_TJYS", pd.get("PART_TJYS") != null ? pd.get("PART_TJYS") : "");
        model.put("PART_FSDGCZ", pd.get("PART_FSDGCZ") != null ? pd.get("PART_FSDGCZ") : "");
        model.put("PART_FSDGG", pd.get("PART_FSDGG") != null ? pd.get("PART_FSDGG") : "");
        model.put("PART_FSDYS", pd.get("PART_FSDYS") != null ? pd.get("PART_FSDYS") : "");
        model.put("PART_WQBCZ", pd.get("PART_WQBCZ") != null ? pd.get("PART_WQBCZ") : "");
        model.put("PART_NWGBCZ", pd.get("PART_NWGBCZ") != null ? pd.get("PART_NWGBCZ") : "");
        model.put("PART_SCTBJHDGB", pd.get("PART_SCTBJHDGB") != null ? pd.get("PART_SCTBJHDGB") : "");
        model.put("PART_SCB", pd.get("PART_SCB") != null ? pd.get("PART_SCB") : "");
        model.put("PART_QDFS", pd.get("PART_QDFS") != null ? pd.get("PART_QDFS") : "");

        if (pd.getString("OPT_ANZDQ") != null && pd.getString("OPT_ANZDQ").equals("1")) model.put("G01", " √ ");
        if (pd.getString("OPT_GCD") != null && pd.getString("OPT_GCD").equals("1")) model.put("G02", " √ ");
        if (pd.getString("OPT_GZXS") != null && pd.getString("OPT_GZXS").equals("1")) model.put("G03", " √ ");
        if (pd.getString("OPT_JTLXD") != null && pd.getString("OPT_JTLXD").equals("1")) model.put("G04", " √ ");
        if (pd.getString("OPT_ZDQMSJK") != null && pd.getString("OPT_ZDQMSJK").equals("1")) model.put("G05", " √ ");
        if (pd.getString("OPT_ZDJY") != null && pd.getString("OPT_ZDJY").equals("1")) model.put("G06", " √ ");
        if (pd.getString("OPT_QDLLZ") != null && pd.getString("OPT_QDLLZ").equals("1")) model.put("G07", " √ ");
        if (pd.getString("OPT_LEDWQZM") != null && pd.getString("OPT_LEDWQZM").equals("1")) model.put("G08", " √ ");
        if (pd.getString("OPT_WQAQZZ") != null && pd.getString("OPT_WQAQZZ").equals("1")) model.put("G09", " √ ");
        if (pd.getString("OPT_FSDDDBHZZ") != null && pd.getString("OPT_FSDDDBHZZ").equals("1")) model.put("G10", " √ ");
        if (pd.getString("OPT_ZDWQJXKG") != null && pd.getString("OPT_ZDWQJXKG").equals("1")) model.put("G11", " √ ");
        if (pd.getString("OPT_SCZM") != null && pd.getString("OPT_SCZM").equals("1")) model.put("G12", " √ ");
        if (pd.getString("OPT_DLFDLJQ") != null && pd.getString("OPT_DLFDLJQ").equals("1")) model.put("G13", " √ ");

        model.put("OPT_WZSWZ", pd.get("OPT_WZSWZ") != null ? pd.get("OPT_WZSWZ") : "");
        model.put("OPT_ZSBCL", pd.get("OPT_ZSBCL") != null ? pd.get("OPT_ZSBCL") : "");
        model.put("OPT_ZSBHD", pd.get("OPT_ZSBHD") != null ? pd.get("OPT_ZSBHD") : "");
        model.put("V036", pd.get("OPT_WXHL") != null ? pd.get("OPT_WXHL") : "");
        model.put("OPT_JXSB", pd.get("OPT_JXSB") != null ? pd.get("OPT_JXSB") : "");
        model.put("OPT_JXXD", pd.get("OPT_JXXD") != null ? pd.get("OPT_JXXD") : "");
        if (pd.get("OPT_DZGSS") != null && pd.getString("OPT_DZGSS").equals("1")) {
            model.put("OPT_DZGSS", " √ ");
        } else {
            model.put("OPT_DZGSS", "");
        }
        if (pd.get("OPT_FPZZ") != null && pd.getString("OPT_FPZZ").equals("1")) {
            model.put("OPT_FPZZ", " √ ");
        } else {
            model.put("OPT_FPZZ", "");
        }
        if (pd.get("OPT_FZDK") != null && pd.getString("OPT_FZDK").equals("1")) {
            model.put("OPT_FZDK", " √ ");
        } else {
            model.put("OPT_FZDK", "");
        }
        if (pd.get("OPT_ZJJT") != null && pd.getString("OPT_ZJJT").equals("1")) {
            model.put("OPT_ZJJT", " √ ");
        } else {
            model.put("OPT_ZJJT", "");
        }
        if (pd.get("OPT_EWJT") != null && pd.getString("OPT_EWJT").equals("1")) {
            model.put("OPT_EWJT", " √ ");
        } else {
            model.put("OPT_EWJT", "");
        }

        model.put("BZ01", pd.get("DT_REMARK") != null ? pd.get("DT_REMARK") : "");
        String unstd = pd.getString("UNSTD");
        JSONArray jsonA = JSON.parseArray(unstd);

        setFBXQWordList(model, pd, jsonA);

        String strdlx = PathUtil.getClasspath() + Const.FILEPATHFILE + "COD/DNR_COD.docx";
        mv = new ModelAndView(new WordView("Document", strdlx), model);
        return mv;
    }

    
    private static void setCGFBWordList(Map<String, Object> model, PageData pd) {
        List<NormalNonStandardBean> list = new ArrayList<>();
        if (!pd.getNoneNULLString("CGFB_JXCLBH").isEmpty()) {
            list.add(new NormalNonStandardBean("轿厢壁材料变化（标配1.2m符合减震不锈钢）"
                    , pd.getNoneNULLString("CGFB_JXCLBH") + "门"));
        }
        if (!pd.getNoneNULLString("CGFB_MTBH443").isEmpty()) {
            list.add(new NormalNonStandardBean("轿门、厅门、门套的材料变化（标配首层为1.2m复合减震不锈钢），由减震复合不锈钢变更为443发纹不锈钢"
                    , pd.getNoneNULLString("CGFB_MTBH443") + "门"));
        }
        if (!pd.getNoneNULLString("CGFB_MTBHSUS304").isEmpty()) {
            list.add(new NormalNonStandardBean("轿门、厅门、门套的材料变化（标配首层为1.2m复合减震不锈钢），由减震复合不锈钢变更为SUS304发纹不锈钢"
                    , pd.getNoneNULLString("CGFB_MTBHSUS304") + "门"));
        }
        if (!pd.getNoneNULLString("CGFB_MTBH15SUS304").isEmpty()) {
            list.add(new NormalNonStandardBean("轿门、厅门、门套的材料变化（标配首层为1.2m复合减震不锈钢），由减震复合不锈钢变更为1.5mmSUS304发纹不锈钢"
                    , pd.getNoneNULLString("CGFB_MTBH15SUS304") + "门"));
        }
        if (!pd.getNoneNULLString("CGFB_MTBH1215").isEmpty()) {
            list.add(new NormalNonStandardBean("轿门、厅门、门套的材料变化（标配首层为1.2m复合减震不锈钢），减震复合不锈钢厚度由1.2mm增加到1.5mm"
                    , pd.getNoneNULLString("CGFB_MTBH1215") + "门"));
        }
        if ("1".equals(pd.get("CGFB_JXHL"))) {
            list.add(new NormalNonStandardBean("轿厢护栏加高到1100mm", "高度700mm-1100mm"));
        }
        if (!pd.getNoneNULLString("CGFB_DLSB").isEmpty()) {
            list.add(new NormalNonStandardBean("大理石地板价格", pd.getNoneNULLString("CGFB_DLSB")));
        }
        if ("1".equals(pd.get("CGFB_DZCZ"))) {
            list.add(new NormalNonStandardBean("对重侧置或担架梯", "对重在井道侧面，有机房电梯"));
        }
        if ("1".equals(pd.get("CGFB_KMGD"))) {
            list.add(new NormalNonStandardBean("开门高度2000", "高度增加2000"));
        }
        if ("1".equals(pd.get("CGFB_DKIP65"))) {
            list.add(new NormalNonStandardBean("地坑IP65", "IP65防水"));
        }
        if ("1".equals(pd.get("CGFB_PKM"))) {
            list.add(new NormalNonStandardBean("旁开门", "开门由中分门变为旁开门"));
        }
        if (!pd.getNoneNULLString("CGFB_GTJX").isEmpty()) {
            list.add(new NormalNonStandardBean("贯通轿厢增加一个COP", pd.getNoneNULLString("CGFB_GTJX")));
        }
        if (!pd.getNoneNULLString("CGFB_ZFSZ2000").isEmpty()) {
            list.add(new NormalNonStandardBean("中分双折开门尺寸非标", pd.getNoneNULLString("CGFB_ZFSZ2000")));
        }
        if (!pd.getNoneNULLString("CGFB_ZFSZ3000").isEmpty()) {
            list.add(new NormalNonStandardBean("中分双折开门尺寸非标", pd.getNoneNULLString("CGFB_ZFSZ3000")));
        }
        if ("1".equals(pd.get("CGFB_ZFSZAQB"))) {
            list.add(new NormalNonStandardBean("中分双折门加安全触板", "增加安全触板功能"));
        }

        if (list.size() == 0) {
            list.add(new NormalNonStandardBean("", ""));
        }

        model.put("cgfb", list);
    }

    private static void setCgfb(Map<String, Object> model, PageData pd) {
        //常规非标
        model.put("CGFB_JXCLBH", pd.getNoneNULLString("CGFB_JXCLBH"));
        model.put("CGFB_MTBH443", pd.getNoneNULLString("CGFB_MTBH443"));
        model.put("CGFB_MTBHSUS304", pd.getNoneNULLString("CGFB_MTBHSUS304"));
        model.put("CGFB_MTBH15SUS304", pd.getNoneNULLString("CGFB_MTBH15SUS304"));
        model.put("CGFB_MTBH1215", pd.getNoneNULLString("CGFB_MTBH1215"));
        model.put("CGFB_JXHL", "1".equals(pd.get("CGFB_JXHL")) ? "1" : "");
        model.put("CGFB_DLSB", pd.getNoneNULLString("CGFB_DLSB"));
        model.put("CGFB_DZCZ", "1".equals(pd.get("CGFB_DZCZ")) ? "1" : "");
        model.put("CGFB_KMGD", "1".equals(pd.get("CGFB_KMGD")) ? "1" : "");
        model.put("CGFB_DKIP65", "1".equals(pd.get("CGFB_DKIP65")) ? "1" : "");
        model.put("CGFB_PKM", "1".equals(pd.get("CGFB_PKM")) ? "1" : "");
        model.put("CGFB_GTJX", pd.getNoneNULLString("CGFB_GTJX"));
        model.put("CGFB_ZFSZ2000", pd.getNoneNULLString("CGFB_ZFSZ2000"));
        model.put("CGFB_ZFSZ3000", pd.getNoneNULLString("CGFB_ZFSZ3000"));
        model.put("CGFB_ZFSZAQB", "1".equals(pd.get("CGFB_ZFSZAQB")) ? "1" : "");
        model.put("CGFB_TDYJ", pd.getNoneNULLString("CGFB_TDYJ"));
        model.put("CGFB_JJFAJMK", "1".equals(pd.get("CGFB_JJFAJMK")) ? "1" : "");
        model.put("CGFB_JJFACXK", pd.getNoneNULLString("CGFB_JJFACXK"));

        if (model.get("CGFB_JXCLBH").toString().isEmpty()
                && model.get("CGFB_MTBH443").toString().isEmpty()
                && model.get("CGFB_MTBHSUS304").toString().isEmpty()
                && model.get("CGFB_MTBH15SUS304").toString().isEmpty()
                && model.get("CGFB_MTBH1215").toString().isEmpty()
                && model.get("CGFB_JXHL").toString().isEmpty()
                && model.get("CGFB_DLSB").toString().isEmpty()
                && model.get("CGFB_DZCZ").toString().isEmpty()
                && model.get("CGFB_KMGD").toString().isEmpty()
                && model.get("CGFB_DKIP65").toString().isEmpty()
                && model.get("CGFB_PKM").toString().isEmpty()
                && model.get("CGFB_GTJX").toString().isEmpty()
                && model.get("CGFB_ZFSZ2000").toString().isEmpty()
                && model.get("CGFB_ZFSZ3000").toString().isEmpty()
                && model.get("CGFB_ZFSZAQB").toString().isEmpty()
                && model.get("CGFB_TDYJ").toString().isEmpty()
                && model.get("CGFB_JJFAJMK").toString().isEmpty()
                && model.get("CGFB_JJFACXK").toString().isEmpty()) {
            model.put("showCGFBEmptyRow", true);
        } else {
            model.put("showCGFBEmptyRow", false);
        }
    }

    private static void setFbxq(Map<String, Object> model, PageData pd, JSONArray jsonA) {
        //非标需求

        List<NonStandardBean> list = new ArrayList<>();
        List<Dict> dictList = DictUtils.getDictList("fbtype");
        Map<String, NonS> fbMap = new LinkedHashMap<String, NonS>();
        
        String temp =null;
        int count = 0;
        //String ss2 = null;
        String s = null;
        for (int i = 0; i < jsonA.size(); i++) {
            JSONObject jsonO = jsonA.getJSONObject(i);
            if (jsonO.size() > 0) {
                String    s1 = getDictNameOfValue(dictList, jsonO.getString("nonstandrad_spec"));
                String    s2 = jsonO.getString("nonstandrad_describe");
                String    s3 = jsonO.getString("master_id") != null ? jsonO.getString("master_id") : "";
                if(StringUtils.isBlank(s1) && StringUtils.isBlank(s2)) {
                	continue;
                }
                String k = "";
                if(StringUtils.isNoneBlank(s1)) {
                	k = s1 + "-" + s3;
                    
                } else {
                	//空类型不合并
                	k = "..FB.."+i+ "-" + s3;
                }
                NonS c = fbMap.get(k);
                if(c != null) {
                	c.setContent(c.getContent() + "\n\n" + s2);
                	c.setCount(c.getCount()+1);
                } else {
                	c = new NonS();
                	c.setContent(s2);
                	c.setCount(1);
                }
                fbMap.put(k, c);
                /*if(s1.equals(temp)){
                	s1 = "";
                	s3 = "";
                	s += "\n\n";
                	s += s2;
                }else{
                	temp = s1;
                	s = s2;
                }
                list.add(new NonStandardBean(s1, s,s3));*/
            }
        }
        
        for (Entry<String, NonS> fb : fbMap.entrySet()) {
        	String k = fb.getKey();
        	String[] a = k.split("-");
        	String spec = Tools.getValueOfArray(a, 0);
        	String master_id = Tools.getValueOfArray(a, 1);
        	if(spec.indexOf("..FB..") == 0) {
        		spec = "";
        	}
        	NonS c = fb.getValue();
        	list.add(new NonStandardBean(spec, c.getContent(), master_id));
        	int zc = c.getCount();
        	for (int j = 1; j < zc; j++) {
            	list.add(new NonStandardBean("", "", ""));
			}
		}
        
        model.put("psdh", list);
    }
    
    private static void setFBXQWordList(Map<String, Object> model, PageData pd
            , JSONArray jsonA) {
        List<NonStandardBean> nonStandardBeans = new ArrayList<>();
        List<Dict> dictList = DictUtils.getDictList("fbtype");
        Map<String, String> fbMap = new LinkedHashMap<String, String>();
        
        for (int i = 0; i < jsonA.size(); i++) {
            JSONObject jsonO = jsonA.getJSONObject(i);
            if (jsonO.size() > 0) {
            	String    s1 = getDictNameOfValue(dictList, jsonO.getString("nonstandrad_spec"));
                String    s2 = jsonO.getString("nonstandrad_describe");
                String    s3 = jsonO.getString("master_id") != null ? jsonO.getString("master_id") : "";
                if(StringUtils.isBlank(s1) && StringUtils.isBlank(s2)) {
                	continue;
                }
                String k = "";
                if(StringUtils.isNoneBlank(s1)) {
                	k = s1 + "-" + s3;
                    
                } else {
                	//空类型不合并
                	k = "..FB.."+i+ "-" + s3;
                }
                String c = fbMap.get(k);
                if(c != null) {
                	s2 = c + "\r\r" + s2;
                }
                fbMap.put(k, s2);
            	
            }
        }
        
        for (Entry<String, String> fb : fbMap.entrySet()) {
        	String k = fb.getKey();
        	String[] a = k.split("-");
        	String spec = Tools.getValueOfArray(a, 0);
        	String master_id = Tools.getValueOfArray(a, 1);
        	if(spec.indexOf("..FB..") == 0) {
        		spec = "";
        	}

            NonStandardBean nonStandardBean = new NonStandardBean();
            nonStandardBean.setContent(spec);
            nonStandardBean.setNumber(master_id);
            nonStandardBean.setNonstandrad(fb.getValue());
            nonStandardBeans.add(nonStandardBean);
		}
        
        
        if (nonStandardBeans.isEmpty()) {
            NonStandardBean nonStandardBean = new NonStandardBean();
            nonStandardBean.setContent("");
            nonStandardBean.setNumber("");
            nonStandardBean.setNonstandrad("");
            nonStandardBeans.add(nonStandardBean);
        }
        model.put("nonStandardBeans", nonStandardBeans);
    }
    
    private static String getDictNameOfValue(List<Dict> dictList, String v) {
    	for (Dict dict : dictList) {
			if(StringUtils.equals(dict.getValue(), v)) {
				return dict.getName();
			}
		}
    	return v;
    }
    
}
