$(function() {
	try {
		$("[name='TMXHZZ_TWZHXH']:checked").val()?'':$("[name='TMXHZZ_TWZHXH']").eq(0).click()
	} catch (e) {console.log(e);}
	countAllAZF();
	$("#BZ_C").change(function() {
		countAllAZF();
	});
	$("#OPT_GTMS_TEXT").change(function(){
        countInstallPrice();
	});
	$("#XS_YJZE").keyup(function(){
		JS_SJBJ();
	});
	
	var jsfb=eval($("#UNSTD").val());
	
	initLxValue();
	if(jsfb&&jsfb.length>0){
        var fbhtml='';
        
        //兼容之前的非标
        if(jsfb[0].nonstandrad_price != '' 
        	&& jsfb[0].nonstandrad_sprice != ''
        		&& !jsfb[0].nonstandrad_ZJ){
        	for(var i=0;i<jsfb.length;i++){
        		fbhtml+='<tr>' +
		            '<td style="width:5%;text-align: center;">'+(i+1)+'</td>' +
                    '<td style="text-align: center;"><span class="fblx"></span></td>' +
		            '<td><input type="hidden" name="master_id" value=""/><input type="text" class="form-control" name="nonstandrad_describe" readonly="readonly" value="'+jsfb[i].nonstandrad_describe+'"></td>' +
		            '<td><input type="text" class="form-control" name="nonstandrad_handle" readonly="readonly" value="'+jsfb[i].nonstandrad_handle+'"></td>' +
		            '<td style="display: none"><input type="text" class="form-control" name="nonstandrad_price" readonly="readonly" value=""></td>' +
		            '<td><input type="text" class="form-control" name="nonstandrad_DTBJ" readonly="readonly" value=""></td>' +
		            '<td><input type="text" class="form-control" name="nonstandrad_ZJ" readonly="readonly" value="'+jsfb[i].nonstandrad_sprice+'"></td>' +
		            '<td style="display: none"><input type="text" class="form-control" name="nonstandrad_sprice" value=""  oninput="setFBPrice();"></td>' +
		            '<td><span class="iskdz">否</span></td>' +
		            '<td><textarea name="nonstandrad_BZ" class="form-control" rows="1" cols="15" style="margin: 0px 0px 0px 0px;resize:vertical;" readonly="readonly" >'+jsfb[i].nonstandrad_price+'</textarea></td>' +
		            '<td><input type="button" value="删除" onclick="delFbRow(this);"></td>' +
		            '</tr>';
        	}
        } else {
        	for(var i=0;i<jsfb.length;i++){
            	var mid = jsfb[i].master_id;
            	if(!mid)mid="";
            	fbhtml+='<tr>' +
    	            '<td style="width:5%;text-align: center;">'+(i+1)+'</td>' +
                    '<td style="text-align: center;"><span class="fblx">'+setfblx(jsfb[i].nonstandrad_spec)+'</span></td>' +
    	            '<td><input type="hidden" name="master_id" value="'+mid+'"/><input type="text" class="form-control" name="nonstandrad_describe" readonly="readonly" value="'+jsfb[i].nonstandrad_describe+'"></td>' +
    	            '<td><input type="text" class="form-control" name="nonstandrad_handle" readonly="readonly" value="'+jsfb[i].nonstandrad_handle+'"></td>' +
    	            '<td style="display: none"><input type="text" class="form-control" name="nonstandrad_price" readonly="readonly" value="'+jsfb[i].nonstandrad_price+'"></td>' +
    	            '<td><input type="text" class="form-control" name="nonstandrad_DTBJ" readonly="readonly" value="'+jsfb[i].nonstandrad_DTBJ+'"></td>' +
    	            '<td><input type="text" class="form-control" name="nonstandrad_ZJ" readonly="readonly" value="'+jsfb[i].nonstandrad_ZJ+'"></td>' +
    	            '<td style="display: none"><input type="text" class="form-control" name="nonstandrad_sprice" value=""  oninput="setFBPrice();"></td>' +
    	            '<td><span class="iskdz">'+(jsfb[i].nonstandrad_KDZ=="1"?'是':(jsfb[i].nonstandrad_KDZ=="2"?'否':''))+'</span></td>' +
    	            '<td><textarea name="nonstandrad_BZ" class="form-control" rows="1" cols="15" style="margin: 0px 0px 0px 0px;resize:vertical;" readonly="readonly" >'+jsfb[i].nonstandrad_BZ+'</textarea></td>' +
    	            '<td><input type="button" value="删除" onclick="delFbRow(this);"></td>' +
    	            '</tr>';
            }
        }
        
        $("#fbbody").append(fbhtml);
        
        js_zj();

        countFBPrice();
        
        iaHasFB();
	}
});
/**
 * 基准费计价
 * 
 * @returns
 */
function countInstallPrice() {
	var ELE_NUM = getEleNum();// 电梯数量
	var SBJ = 0;// 设备价
	var CGJ = 0;// 超高选项
	var GTMJ = 0;// 贯通门选项
	var JZJ = 0, SSBCJ = 0, DTZJ = 0, JZAZF = 0;// 基准价，税收补偿价，单台总价，基准总价
	var ssPersent = 0.06;
	var persent = getAZFPersent();
	
	
	// 设备价
	SBJ = getValueToFloat(getElementIdName(3));
	//单台基价
	var SINGLE_SBJ= Math.ceil(SBJ/ELE_NUM);
	// 超高选项
	CGJ = getValueToFloat("#BASE_CCJG");
	// 单台超高加价
	var SINGLE_CGJ = Math.ceil(CGJ/ELE_NUM);
	
	// 贯通门选项
	// TODO 贯通门数有问题需要修改
	GTMJ = getValueToFloat("#OPT_GTMJXJMBF_TEMP")
			+ getValueToFloat("#OPT_GTMTMBF_TEMP")
			+ getValueToFloat("#OPT_GTMTMBF_TEMP");
	//						  单台基价  +单台超高价+贯通价格*80%*108%*18%   
	var New_JZJ = Math.ceil((SINGLE_SBJ+SINGLE_CGJ+GTMJ)*0.8*1.08*persent);
	JZJ = parseFloat((((SBJ/ELE_NUM) + CGJ + GTMJ) * persent).toFixed(2));
	$("#JZJ_DTJZJ").val(New_JZJ);
	if ($("#JZJ_IS_YTHT").is(":checked")) {// 一体合同需要专用税
		SSBCJ = parseFloat((New_JZJ * ssPersent).toFixed(2));
		$("#JZJ_SSBC").val(SSBCJ);
	} else {
		SSBCJ = 0;
		$("#JZJ_SSBC").val(SSBCJ);
	}
	DTZJ = parseFloat(parseFloat(New_JZJ) + parseFloat(SSBCJ));// 单台总价
	$("#JZJ_DTZJ").val(DTZJ);
	JZAZF = parseFloat((DTZJ * ELE_NUM).toFixed(2));
	$("#JZJ_AZF").val(JZAZF);
}
/**
 * 修改是否一体合同时计价
 * 
 * @returns
 */
function changeSSCount() {
	var ssPersent = 0.06;// 税收补偿百分比
	var ELE_NUM = getEleNum();// 电梯数量
	var JZJ = 0, SSBCJ = 0, DTZJ = 0, JZAZF = 0;// 基准价，税收补偿价，单台总价，基准总价
	JZJ = getValueToFloat("#JZJ_DTJZJ");
	if ($("#JZJ_IS_YTHT").is(":checked")) {// 一体合同需要专用税
		SSBCJ = parseFloat((JZJ * ssPersent).toFixed(2));
		$("#JZJ_SSBC").val(SSBCJ);
		$("#JZJ_IS_YTHT_VAL").val("1");
	} else {
		SSBCJ = 0;
		$("#JZJ_SSBC").val(SSBCJ);
		$("#JZJ_IS_YTHT_VAL").val("0");
	}
	DTZJ = parseFloat((parseFloat(JZJ) + parseFloat(SSBCJ)).toFixed(4));// 单台总价
	$("#JZJ_DTZJ").val(DTZJ);
	JZAZF = parseFloat((DTZJ * ELE_NUM).toFixed(2));
	$("#JZJ_AZF").val(JZAZF);
}
/**
 * 手动填写价格时去计算价格
 * 
 * @returns
 */
function countSDPrice() {
	var ELE_NUM = getEleNum();// 电梯数量
	var ELE_DTAZF = getValueToFloat("#ELE_DTAZF");// 安装费
	var ELE_ZFYSF = getValueToFloat("#ELE_ZFYSF");// 政府验收费
	var ELE_MBJF = getValueToFloat("#ELE_MBJF");// 免保期超出1年计费
	var ELE_QTSF = getValueToFloat("#ELE_QTSF");// 合同约定其他费用
	var ELE_DTZJ = parseFloat((ELE_DTAZF + ELE_ZFYSF + ELE_MBJF + ELE_QTSF)
			.toFixed(4));
	$("#ELE_DTZJ").val(ELE_DTZJ);
	var ELE_AZF = parseFloat((ELE_DTZJ * ELE_NUM).toFixed(4));
	$("#ELE_AZF").val(ELE_AZF);
	countAZF();// 计算总价
}
/**
 * 修改工程类型时修改厂检费，当修改调试费时修改厂检费
 * 
 * @returns
 */
function changeCJPrice() {
	var ELE_NUM = getEleNum();// 电梯数量
	var OTHP_GCLX = $("#OTHP_GCLX").val();// 工程类型
	var floorVal = getValueToFloat("#BZ_C");// 电梯层数
	if (floorVal == 0) {
		floorVal = getValueToFloat("#initFloor");
	}
	var OTHP_CJF = 0;

		try{
            if(itemelecount&&!isNaN(itemelecount)){
                itemelecount=parseFloat(itemelecount);
            }else {
                itemelecount=ELE_NUM;
            }
		}catch(e) {
			itemelecount=ELE_NUM;
		}


	if (OTHP_GCLX == "买断") {
		if (itemelecount <= 9) {// 1-9 1000/台
			OTHP_CJF = parseFloat((1000 * ELE_NUM).toFixed(4));
		} else if (itemelecount <= 50) {// 10-50 500/台
			OTHP_CJF = parseFloat((500 * ELE_NUM).toFixed(4));
		} else {// >=51 25000
			OTHP_CJF = Math.ceil(25000/itemelecount*ELE_NUM);
		}
	} else {
		OTHP_CJF = 0;
	}
	$("#OTHP_CJF").val(OTHP_CJF);
	// 调试费
	var OTHP_TSF = 0;
	if ($("#OTHP_ISTSF").is(":checked")) {
		if (itemelecount <= 9) {// 1-9 1500/台
			OTHP_TSF = parseFloat((1500 * ELE_NUM).toFixed(4));
		} else if (itemelecount <= 50) {// 10-50 1000/台
			OTHP_TSF = parseFloat((1000 * ELE_NUM).toFixed(4));
		} else {// >=51 500/台
			OTHP_TSF = parseFloat((500 * ELE_NUM).toFixed(4));
		}
		$("#OTHP_ISTSF_VAL").val("1");
	} else {
		OTHP_TSF = 0;
		$("#OTHP_ISTSF_VAL").val("0");
	}
	$("#OTHP_TSF").val(OTHP_TSF);

	$("#OTHP_ZJ").val(parseFloat((OTHP_TSF + OTHP_CJF).toFixed(4)));
	countAZF();// 计算总价
}

/**
 * 设置报价池跟总价的安装费
 * 
 * @returns
 */
function countAZF() {
	$(getElementIdName(1))
			.val(
					parseFloat((getValueToFloat("#OTHP_ZJ") + getValueToFloat("#ELE_AZF"))
							.toFixed(4)));
	$(getElementIdName(2))
			.val(
					parseFloat((getValueToFloat("#OTHP_ZJ") + getValueToFloat("#ELE_AZF"))
							.toFixed(4)));
    $(getElementIdName(4))
        .val(
            parseFloat((getValueToFloat("#OTHP_ZJ") + getValueToFloat("#ELE_AZF"))
                .toFixed(4)));
}
/**
 * 计算全部安装费用
 * 
 * @returns
 */
function countAllAZF() {
	countInstallPrice();
	countSDPrice();
	changeCJPrice();
	countAZF();
}

/**
 * 根据梯型获取对应ID
 * 
 * @param type
 *            1:总价id；2:报价池ID；3:设备基础价ID
 * @returns
 */
function getElementIdName(type) {
	var tz_ = getTz();
	if (type == 1) {// 总价id
		switch (tz_) {
		case "新飞越":
			return "#FEIYUE_AZF_TEMP";
			break;
		case "新飞越MRL":
			return "#FEIYUEMRL_AZF_TEMP";
			break;
		case "DNP9300":
			return "#DNP9300_AZF_TEMP";
			break;
		case "DNR":
			return "#DNR_AZF_TEMP";
			break;
		case "飞尚":
			return "#FEISHANG_AZF_TEMP";
			break;
		case "飞扬消防梯":
			return "#FEIYANGXF_AZF_TEMP";
			break;
		case "飞扬3000+MRL":
			return "#FEIYANGMRL_AZF_TEMP";
			break;
		case "飞扬3000+":
			return "#FEIYANG_AZF_TEMP";
			break;
		case "曳引货梯":
			return "#SHINY_AZF_TEMP";
			break;
        case "DT10"://飞尚MRL
			return "#FEISHANG_MRL_AZF_TEMP";
			break;
        case "DT12"://家用梯DELCO
			return "#HOUSEHOLD_AZF_TEMP";
			break;
		default:
			return '#BASE_AZF_TEMP';
			break;
		}
	} else if (type == 2) {// 报价池总价ID
		switch (tz_) {
		case "新飞越":
			return "#FEIYUE_AZF";
			break;
		case "新飞越MRL":
			return "#FEIYUEMRL_AZF";
			break;
		case "DNP9300":
			return "#DNP9300_AZF";
			break;
		case "DNR":
			return "#DNR_AZF";
			break;
		case "飞尚":
			return "#FEISHANG_AZF";
			break;
		case "飞扬消防梯":
			return "#FEIYANGXF_AZF";
			break;
		case "飞扬3000+MRL":
			return "#FEIYANGMRL_AZF";
			break;
		case "飞扬3000+":
			return "#FEIYANG_AZF";
			break;
		case "曳引货梯":
			return "#SHINY_AZF";
			break;
        case "DT10"://飞尚MRL
            return "#FEISHANG_MRL_AZF";
            break;
        case "DT12"://家用梯DELCO
			return "#HOUSEHOLD_AZF";
			break;
		default:
			return '#BASE_AZF';
			break;
		}
	} else if (type == 3) {// 设备基本价ID
		switch (tz_) {
		case "新飞越":
			return "#SBJ_TEMP";
			break;
		case "新飞越MRL":
			return "#SBJ_TEMP";
			break;
		case "DNP9300":
			return "#SBJ_TEMP";
			break;
		case "DNR":
			return "#SBJ_TEMP";
			break;
		case "飞尚":
			return "#SBJ_TEMP";
			break;
		case "飞扬消防梯":
			return "#SBJ_TEMP";
			break;
		case "飞扬3000+MRL":
			return "#SBJ_TEMP";
			break;
		case "飞扬3000+":
			return "#SBJ_TEMP";
			break;
		case "曳引货梯":
			return "#SBJ_TEMP";
			break;
        case "DT10"://飞尚MRL
            return "#SBJ_TEMP";
            break;
        case "DT12"://家用梯DELCO
            return "#SBJ_TEMP";
            break;
		default:
			return '#BASE_AZF';
			break;
		}
	} else if (type == 4) {// 报价池总价ID
        switch (tz_) {
            case "新飞越":
                return "#XS_AZJ";
                break;
            case "新飞越MRL":
                return "#XS_AZJ";
                break;
            case "DNP9300":
                return "#XS_AZJ";
                break;
            case "DNR":
                return "#XS_AZJ";
                break;
            case "飞尚":
                return "#FEISHANG_AZJ";
                break;
            case "飞扬消防梯":
                return "#FEIYANG_XF_AZJ";
                break;
            case "飞扬3000+MRL":
                return "#XS_AZJ";
                break;
            case "飞扬3000+":
                return "#XS_AZJ";
                break;
            case "曳引货梯":
                return "#XS_AZJ";
                break;
            case "DT10"://飞尚MRL
                return "#FEISHANG_MRL_AZJ";
                break;
            case "DT12"://家用梯
                return "#XS_AZJ";
                break;
            default:
                return "#BASE_AZJ";
                break;
        }
    }
}
/**
 * 根据电梯类型与层数计算税收比例
 * 
 * @returns
 */
function getAZFPersent() {
	var tz_ = getTz();
	var floorVal = getValueToFloat("#BZ_C");// 电梯层数
	if (floorVal == 0) {
		floorVal = getValueToFloat("#initFloor");
	}
	if (tz_ == "新飞越" || tz_ == "新飞越MRL" || tz_ == "飞尚" || tz_ == "飞扬消防梯"||tz_=="DT12"
			|| tz_ == "飞扬3000+MRL" || tz_ == "飞扬3000+" || tz_ == "曳引货梯"||tz_=="DT10"||tz_=="DT14") {// 直梯
		if (floorVal <= 15) {
			return 0.18;
		} else if (floorVal <= 20) {
			return 0.20;
		} else {
			return 0.24;
		}
	} else {// 扶梯
		return 0.15;
	}
}
/**
 * 非标申请功能
 */
function addFB(type, typeValue){
	if(!validateIsSelect()){
		return;
	}
	if(validateIsSave(type)){
		return;
	}
	
	if("save" == $('#view').val()){
		layer.confirm('报价没有保存，是否保存？', {
            btn: ['保存','取消'], title: "提示"
        }, function(index){
        	layer.close(index);
        	saveOfAjax();
        	//save();
        	
        }, function(){});
		return;
	}
	
    var parmJson=formatFBJson();

	var url=basePath+"nonStandrad/preEditNonStandrad.do?models=feiyue&btype="+type+"&btypev="+typeValue+"&"+parmJson;
	$("#zhjView").kendoWindow({
        width: "1000px",
        height: "600px",
        title: "非标申请",
        actions: ["Close"],
        content: url,
        modal : true,
        visible : false,
        resizable : true
    }).data("kendoWindow").maximize().open();

}
/**
 * 格式化申请非标数据
 */
function formatFBJson() {
    var reJson={};
    reJson.item_id=getTagValue("#ITEM_ID");//项目ID
    reJson.models_id=getTagValue("#MODELS_ID");//梯种ID
    reJson.rated_load=getTagValue("#BZ_ZZ");//载重
    reJson.lift_c=getTagValue("#BZ_C");//层
    reJson.lift_z=getTagValue("#BZ_Z");//站
    reJson.lift_m=getTagValue("#BZ_M");//门
    reJson.lift_speed=getTagValue("#BZ_SD");//速度
    reJson.pit_depth=getTagValue("#BASE_DKSD");//底坑深度
    reJson.headroom_height=getTagValue("#BASE_DCGD");//顶层高度
    reJson.traveling_height=getTagValue("#BASE_TSGD")==''?getTagValue("#BZ_TSGD"):getTagValue("#BASE_TSGD");//提升高度
    reJson.well_depth=getTagValue("#BASE_JDZG");//井道总高
    reJson.lift_num= "1";//台数
    reJson.opening_width=getTagValue("#BZ_KMKD");//开门尺寸
    reJson.car_size=getTagValue("#BASE_JXGG");//轿厢规格
    reJson.lift_angle=getTagValue("#BZ_QXJD");//角度
    reJson.step_width=getTagValue("#BZ_TBKD");//梯级宽度
    reJson.BZ_TSGD=getTagValue("#BZ_TSGD");//扶梯/人行道提升高度
    reJson.BZ_GG=getTagValue("#BZ_GG");//规格
    reJson.MODELS_ID=getTagValue("#MODELS_ID");//规格
	if(reJson.step_width==null||reJson.step_width==""){
        reJson.step_width=getTagValue("#BZ_TJKD");//梯级宽度
	}	
    reJson.JDK=getTagValue("#BASE_JDK");//井道宽
    reJson.JDS=getTagValue("#BASE_JDS");//井道深
	//新增
	reJson.BZ_KMXS=getTagValue("#BZ_KMXS");//开门形式
	reJson.BZ_SPTJ=getTagValue("#BZ_SPTJ");//水平梯级
    reJson.TJTTH=getTagValue("#TJTTH");//井道深
    reJson.car_height=getTagValue("input[name=BASE_JXGD]:checked");//轿厢高度
    var returnStr=(JSON.stringify(reJson)).replace(/","/g,"&");
    returnStr=returnStr.replace(/":"/g,"=");
    returnStr=returnStr.replace(/{"/g,"");
    returnStr=returnStr.replace(/"}/g,"");
    return returnStr;
}
function selFB(){
	if(!validateIsSelect()){
		return;
	}
	
    var parmJson=formatFBJson();
    var models_id=getTagValue("#MODELS_ID");
    var item_id=getTagValue("#ITEM_ID");
    var tz_=getTagValue("#tz_");
    var BZ_ZZ=getTagValue("#BZ_ZZ");
    var BZ_SD=getTagValue("#BZ_SD");
    var BZ_KMXS=getTagValue("#BZ_KMXS");
    var BZ_C=getTagValue("#BZ_C");
    var BZ_Z=getTagValue("#BZ_Z");
    var BZ_M=getTagValue("#BZ_M");
    var BZ_KMKD=getTagValue("#BZ_KMKD");
    var DT_SL=getTagValue("#DT_SL");
    var BZ_QXJD=getTagValue("#BZ_QXJD");
    var BZ_TJKD=getTagValue("#BZ_TJKD");
    var BZ_SPTJ=getTagValue("#BZ_SPTJ");
    var BZ_TSGD=getTagValue("#BZ_TSGD");
    if (typeof(BZ_QXJD)=="undefined"||BZ_QXJD==""||BZ_QXJD.length==0) {
        var url=basePath+"nonStandrad/eOfferStandradList.do?MODELS_ID="+
        models_id+"&item_id="+item_id+"&tz_="+tz_+"&BZ_ZZ="+BZ_ZZ+"&BZ_SD="+
        BZ_SD+"&BZ_KMXS="+BZ_KMXS+"&BZ_KMKD="+BZ_KMKD+"&BZ_C="+BZ_C+"&BZ_Z="+BZ_Z+
        "&BZ_M="+BZ_M+"&DT_SL="+DT_SL;
	}else{
	    var url=basePath+"nonStandrad/eOfferStandradList.do?MODELS_ID="+
	    models_id+"&item_id="+item_id+"&tz_="+tz_+"&BZ_SD="+BZ_SD+"&DT_SL="+DT_SL+
	    "&BZ_QXJD="+BZ_QXJD+"&BZ_TJKD="+BZ_TJKD+"&BZ_SPTJ="+BZ_SPTJ+"&BZ_TSGD="+BZ_TSGD;
	}
    
//    var url=basePath+"nonStandrad/eOfferStandradList.do?MODELS_ID="+models_id+"&item_id="+item_id;
//    var url=basePath+"nonStandrad/eOfferStandradList.do?MODELS_ID="+
//    models_id+"&item_id="+item_id+"&tz_="+tz_+"&BZ_ZZ="+BZ_ZZ+"&BZ_SD="+
//    BZ_SD+"&BZ_KMXS="+BZ_KMXS+"&BZ_KMKD="+BZ_KMKD+"&BZ_C="+BZ_C+"&BZ_Z="+BZ_Z+
//    "&BZ_M="+BZ_M+"&DT_SL="+DT_SL;
    $("#zhjView").kendoWindow({
        width: "1000px",
        height: "600px",
        title: "非标调用",
        actions: ["Close"],
        content: url,
        modal : true,
        visible : false,
        resizable : true
    }).data("kendoWindow").maximize().open();

}

function validateIsSelect() {
	if ($("#BZ_ZZ")[0] && ($("#BZ_ZZ").val() == "" || $("#BZ_ZZ").val() == null)) {
		$("#BZ_ZZ").focus();
		$("#BZ_ZZ").tips({
			side : 3,
			msg : "内容不能为空！",
			bg : '#AE81FF',
			time : 3
		});
		return false;
	}

	if ($("#BZ_SD").val() == "") {
		$("#BZ_SD").focus();
		$("#BZ_SD").tips({
			side : 3,
			msg : "内容不能为空！",
			bg : '#AE81FF',
			time : 3
		});
		return false;
	}
	if ($("#BZ_C").val() == "") {
		$("#BZ_C").focus();
		$("#BZ_C").tips({
			side : 3,
			msg : "内容不能为空！",
			bg : '#AE81FF',
			time : 3
		});
		return false;
	}
	
	if ($("#BZ_Z").val() == "") {
		$("#BZ_Z").focus();
		$("#BZ_Z").tips({
			side : 3,
			msg : "内容不能为空！",
			bg : '#AE81FF',
			time : 3
		});
		return false;
	}
	
	if ($("#BZ_M").val() == "") {
		$("#BZ_M").focus();
		$("#BZ_M").tips({
			side : 3,
			msg : "内容不能为空！",
			bg : '#AE81FF',
			time : 3
		});
		return false;
	}

	if ($("#BZ_KMKD").val() == "") {
		$("#BZ_KMKD").focus();
		$("#BZ_KMKD").tips({
			side : 3,
			msg : "内容不能为空！",
			bg : '#AE81FF',
			time : 3
		});
		return false;
	}

	if ($("#BZ_KMKD").val() == "") {
		$("#BZ_KMKD").focus();
		$("#BZ_KMKD").tips({
			side : 3,
			msg : "内容不能为空！",
			bg : '#AE81FF',
			time : 3
		});
		return false;
	}

	if ($("#BZ_QXJD").val() == "") {
		$("#BZ_QXJD").focus();
		$("#BZ_QXJD").tips({
			side : 3,
			msg : "内容不能为空！",
			bg : '#AE81FF',
			time : 3
		});
		return false;
	}

	/*if ($("#BZ_TBKD").val() == "") {
		$("#BZ_TBKD").focus();
		$("#BZ_TBKD").tips({
			side : 3,
			msg : "内容不能为空！",
			bg : '#AE81FF',
			time : 3
		});
		return false;
	}*/

	if ($("#BZ_TJKD").val() == "") {
		$("#BZ_TJKD").focus();
		$("#BZ_TJKD").tips({
			side : 3,
			msg : "内容不能为空！",
			bg : '#AE81FF',
			time : 3
		});
		return false;
	}

	if ($("#BZ_TSGD").val() == "") {
		$("#BZ_TSGD").focus();
		$("#BZ_TSGD").tips({
			side : 3,
			msg : "内容不能为空！",
			bg : '#AE81FF',
			time : 3
		});
		return false;
	}
	
	return true;
}

function validateIsSave(btype) {
	
	if(btype){
		/*if("save" == $('#view').val()){
			layer.confirm('报价没有保存，是否保存？', {
	            btn: ['保存','取消']
	        }, function(){
	            layer.msg('的确很重要', {icon: 1});
	        }, function(){
	            
	        });
			return true;
		}*/
	}
	return false;
}

function countFBPrice(){
	var elenum=getEleNum();
    $("[name='nonstandrad_price']").each(function(idx){
        if($(this).val()!=''&&!isNaN($(this).val())){
            if($("[name='nonstandrad_sprice']").eq(idx).val()==''){
                $($("[name='nonstandrad_sprice']")[idx]).val(parseFloat((parseFloat($(this).val())*elenum).toFixed(4)));
            }
        }else {
            if($("[name='nonstandrad_sprice']").eq(idx).val()==''){
                $($("[name='nonstandrad_sprice']")[idx]).val(0);
            }
        }
    });
    setFBPrice();
    //放入价格
    countZhj();
    
    JS_SJBJ();
}
function setFBPrice() {
    var fbprice=0;
    var fbxxprice=0;
    var sl_ = parseInt_DN($("#HOUSEHOLD_SL").val());
    
    $("[name='nonstandrad_ZJ']").each(function(idx){
    	var _fblx = $(this).parents("tr").find("span.fblx").html();
		if(!teShuNonJJ(setfblxValue(_fblx))){
			//$("[name='nonstandrad_sprice']").each(function(idx){
	    	var iskdz = $(this).parents("tr").find(".iskdz").html();
	        if($(this).val()!='' && iskdz == '否'){
	            fbprice+=$(this).val()==''||isNaN($(this).val())?0:parseFloat($(this).val());
	        } else if($(this).val()!='' && iskdz == '是'){
	        	fbxxprice+=$(this).val()==''||isNaN($(this).val())?0:parseFloat($(this).val());
	        }
		}
    });
    fbprice = parseInt((fbprice).toFixed(0));

    //非标加价
    var CGFB_JXCLBH_TEMP =getValueToFloat("#CGFB_JXCLBH_TEMP");
    var CGFB_MTBHSUS304_TEMP =getValueToFloat("#CGFB_MTBHSUS304_TEMP");
    var CGFB_MTBH443_TEMP =getValueToFloat("#CGFB_MTBH443_TEMP");
    var CGFB_MTBH15SUS304_TEMP =getValueToFloat("#CGFB_MTBH15SUS304_TEMP");
    var CGFB_MTBH1215_TEMP =getValueToFloat("#CGFB_MTBH1215_TEMP");
    var CGFB_JXHL_TEMP =getValueToFloat("#CGFB_JXHL_TEMP");
    var CGFB_DLSB_TEMP =getValueToFloat("#CGFB_DLSB_TEMP");
    var CGFB_DZCZ_TEMP =getValueToFloat("#CGFB_DZCZ_TEMP");
    var CGFB_KMGD_TEMP =getValueToFloat("#CGFB_KMGD_TEMP");
    var CGFB_DKIP65_TEMP =getValueToFloat("#CGFB_DKIP65_TEMP");
    var CGFB_PKM_TEMP =getValueToFloat("#CGFB_PKM_TEMP");
    var CGFB_GTJX_TEMP =getValueToFloat("#CGFB_GTJX_TEMP");
    var CGFB_ZFSZ2000_TEMP =getValueToFloat("#CGFB_ZFSZ2000_TEMP");
    var CGFB_ZFSZ3000_TEMP =getValueToFloat("#CGFB_ZFSZ3000_TEMP");
    var CGFB_ZFSZAQB_TEMP =getValueToFloat("#CGFB_ZFSZAQB_TEMP");
    var CGFB_JXCC_TEMP =getValueToFloat("#CGFB_JXCC_TEMP");
    var CGFB_TDYJ_TEMP =getValueToFloat("#CGFB_TDYJ_TEMP");
    var CGFB_JJFAJMK_TEMP =getValueToFloat("#CGFB_JJFAJMK_TEMP");
    var CGFB_JJFACXK_TEMP =getValueToFloat("#CGFB_JJFACXK_TEMP");
    var CGFB_JJFACXK_TEMP =getValueToFloat("#CGFB_JJFACXK_TEMP");
    var CGFB_JJFACXK_TEMP =getValueToFloat("#CGFB_JJFACXK_TEMP");
    //家用梯半非标选项
    var base_kzgwz_fbtemp=parseInt_DN($("#BASE_KZGWZ_TEMP").val());
    if (base_kzgwz_fbtemp/sl_==1000) {
    	base_kzgwz_fbtemp = 1000;
	}
    var base_jxgd_fbtemp = parseInt_DN($("#BASE_JXGD_TEMP").val());//等于3000不可打折
    if ((base_jxgd_fbtemp/sl_)==3000) {
    	base_jxgd_fbtemp = 3000;
	}
    var opt_fyhtyjfxgb_temp = parseInt_DN($("#OPT_FYHTYJFXGB_TEMP").val());//飞弈货梯有机房新国标

    var fbj_temp=CGFB_JXCLBH_TEMP+CGFB_MTBHSUS304_TEMP+CGFB_MTBH443_TEMP+CGFB_MTBH15SUS304_TEMP+CGFB_MTBH1215_TEMP
        +CGFB_JXHL_TEMP+CGFB_DLSB_TEMP+CGFB_DZCZ_TEMP+CGFB_KMGD_TEMP+CGFB_DKIP65_TEMP+CGFB_PKM_TEMP+CGFB_GTJX_TEMP
        +CGFB_ZFSZ2000_TEMP+CGFB_ZFSZ3000_TEMP+CGFB_JXCC_TEMP+CGFB_ZFSZAQB_TEMP+CGFB_TDYJ_TEMP
        +CGFB_JJFAJMK_TEMP+CGFB_JJFACXK_TEMP+base_kzgwz_fbtemp+base_jxgd_fbtemp+opt_fyhtyjfxgb_temp;
    try {
        $("#XS_FBJ").val(parseFloat((fbprice+fbj_temp).toFixed(4)));
    }catch(e) {}
    try {
        $("#FEISHANG_FBJ").val(parseFloat((fbprice+fbj_temp).toFixed(4)));
    }catch(e) {}
    try {
        $("#FEIYANG_XF_FBJ").val(parseFloat((fbprice+fbj_temp).toFixed(4)));
    }catch(e) {}
    try {
        $("#FEISHANG_MRL_FBJ").val(parseFloat((fbprice+fbj_temp).toFixed(4)));
    }catch(e) {}
    
    //非标选项加价
    try {
        $("#OPT_FB_TEMP").val(parseInt((fbxxprice).toFixed(0)));
    }catch(e) {}
    
}

//非标,点击删除行
function delFbRow(obj){
	var s = setfblxValue($(obj).parent().parent().find("span.fblx").html());
	var v = $(obj).parent().parent().find("[name='nonstandrad_describe']").val();
	
    $(obj).parent().parent().remove();
    
    js_xh();
    js_zj();
    
    countFBPrice();
    
    iaHasFB();
    
    fbUnSetter(s,v);
    
    //updateFbXForS(s);
    updateFbX();
}

function js_xh(){
	var trs = $("#fbbody tr");
	for (var i = 0; i < trs.length; i++) {
		trs.eq(i).find("td:first").html(i+1);
	}
}

function js_zj(){
	var trs = $("#fbbody tr");
	var dtbj = 0;
	var zj = 0;
	var zj_kdz = 0;
	var zj_bkdz = 0;
	var sl = getEleNum();
	for (var i = 0; i < trs.length; i++) {
		/*var _fblx = trs.eq(i).find("td span.fblx").html();
		if(teShuNonJJ(setfblxValue(_fblx))){
			continue;
		}*/
		
		var _dtbj = trs.eq(i).find("td input[name='nonstandrad_DTBJ']").val();
		var _zj = trs.eq(i).find("td input[name='nonstandrad_ZJ']").val();
		var _kdz = trs.eq(i).find("td .iskdz").html();
		if(_dtbj =='' || isNaN(_dtbj)) _dtbj = 0;
		if(_zj =='' || isNaN(_zj)) _zj = 0;
		
		//var _zj = round(parseFloat(_dtbj) * sl, -1);
		
		dtbj += parseFloat(_dtbj);
		zj += parseFloat(_zj);
		
		//trs.eq(i).find("td input[name='nonstandrad_ZJ']").val(_zj);
		if(_kdz == "是"){
			zj_kdz += parseFloat(_zj);
		} else if(_kdz == "否"){
			zj_bkdz += parseFloat(_zj);
		}
	}
	$("#fbhj_dtbj").html(numberFixed(dtbj));
	$("#fbhj_zj").html(numberFixed(zj));
	
	$("#zj_kdz").html(numberFixed(zj_kdz));
	$("#zj_bkdz").html(numberFixed(zj_bkdz));
}

/**
 * 忽略加价
 * @param type
 * @returns
 */
function teShuNonJJ(type) {
	if(type == "4"){//基价
		return true;
	}
	
	
	return false;
}

function numberFixed(value) {
  var valueStr = value.toString()
  if (valueStr.indexOf('.') !== -1 && valueStr.split('.')[1].length > 1) {
    return value.toFixed(1)
  } else {
    return value
  }  
}

function countTransPrice() {
	var transPrice=getValueToFloat("#trans_price");
	try {$("#DNP9300_YSF").val(transPrice);}catch (e){}
	try {$("#XS_YSJ").val(transPrice);}catch (e){}
	try {$("#DNR_YSF").val(transPrice);}catch (e){}
	try {$("#FEIYUE_YSF").val(transPrice);}catch (e){}
	try {$("#FEISHANG_YSJ").val(transPrice);}catch (e){}
	try {$("#FEISHANG_MRL_YSJ").val(transPrice);}catch (e){}
	try {$("#FEIYANGMRL_YSF").val(transPrice);}catch (e){}
	try {$("#FEIYANG_XF_YSJ").val(transPrice);}catch (e){}
	try {$("#FEIYUEMRL_YSF").val(transPrice);}catch (e){}
	try {$("#SHINY_YSF").val(transPrice);}catch (e){}
	try {$("#FEIYANG_YSF").val(transPrice);}catch (e){}
	try {$("#BASE_YSF").val(transPrice);}catch (e){}//特种
	try {$("#HOUSEHOLD_YSF").val(transPrice);}catch (e){}//特种
    countZhj();
    //计算总报价
    jsTatol();
}

//扶梯DNP9300
/**
 * 根据安装环境设置选配功能
 */
function setchangOpt(){
    var azhj_ = getTagValue("#BASE_AZHJ");//安装环境
    if(azhj_=="室内"||azhj_==""){
        if($("#OPT_ZDJY_TEXT").is(":checked"))$("#OPT_ZDJY_TEXT").click();
        if($("#OPT_QDLLZ_TEXT").is(":checked"))$("#OPT_QDLLZ_TEXT").click();
        if($("#OPT_YSFLQ_TEXT").is(":checked"))$("#OPT_YSFLQ_TEXT").click();
        if($("#OPT_FHBH_TEXT").is(":checked"))$("#OPT_FHBH_TEXT").click();
        if($("#OPT_TJLFHZ_TEXT").is(":checked"))$("#OPT_TJLFHZ_TEXT").click();
    }else{
    	if(!$("#OPT_ZDJY_TEXT").is(":checked"))$("#OPT_ZDJY_TEXT").click();
        if(!$("#OPT_QDLLZ_TEXT").is(":checked"))$("#OPT_QDLLZ_TEXT").click();
        if(!$("#OPT_YSFLQ_TEXT").is(":checked"))$("#OPT_YSFLQ_TEXT").click();
        if(!$("#OPT_FHBH_TEXT").is(":checked"))$("#OPT_FHBH_TEXT").click();
        if(!$("#OPT_TJLFHZ_TEXT").is(":checked"))$("#OPT_TJLFHZ_TEXT").click();
    }
    //基础项
    //editBase('BASE_AZHJ');
    editBase('BASE_FSGD');
    editBase('BASE_ZJZCSL');
    editBase('BASE_SDJC');
    editBase('BASE_XDJC');
    editBase('BASE_JHXT');
    //部件参数
    editPart('PART_FSDGCZ');
    editPart('PART_FSDYS');
    editPart('PART_WQBCZ');
    editPart('PART_NWGBCZ');
    editPart('PART_SCTBJHDGB');
    editPart('PART_SCB');
    editPart('PART_QDFS');
    //选配项
    editOpt('OPT_AQZDQ');
    editOpt('OPT_JTLXD');
    editOpt('OPT_ZDJY');
    editOpt('OPT_LEDWQZM');
    editOpt('OPT_TJFTBH');
    editOpt('OPT_ZDWQJXKG');
    editOpt('OPT_SCZM');
    editOpt('OPT_WXHL');
    editOpt('OPT_FPZZ');
    editOpt('OPT_HJFDDS');
}

function setInitSetting(){
    //	if(!$("#OPT_AQZDQ_TEXT").is(":checked"))$("#OPT_AQZDQ_TEXT").click();
    //if(!$("#OPT_GCD_TEXT").is(":checked"))$("#OPT_GCD_TEXT").click();
    //if(!$("#OPT_ZDQMSJK_TEXT").is(":checked"))$("#OPT_ZDQMSJK_TEXT").click();
    if(!$("#OPT_WQAQZZ_TEXT").is(":checked"))$("#OPT_WQAQZZ_TEXT").click();
    //if(!$("#OPT_FSZM_TEXT").is(":checked"))$("#OPT_FSZM_TEXT").click();
   	if(!$("#OPT_DLFDLJQ_TEXT").is(":checked"))$("#OPT_DLFDLJQ_TEXT").click();
    //$("#OPT_AQZDQ_TEXT").attr("disabled","disabled");
    //$("#OPT_GCD_TEXT").attr("disabled","disabled");
    //$("#OPT_ZDQMSJK_TEXT").attr("disabled","disabled");
    $("#OPT_WQAQZZ_TEXT").attr("disabled","disabled");
    //$("#OPT_FSZM_TEXT").attr("disabled","disabled");
    $("#OPT_DLFDLJQ_TEXT").attr("disabled","disabled");
}

function setCZ(opt){
	if(opt==1){
        //安装环境
        var azhj_ = $("#BASE_AZHJ").val();//安装环境
        if(azhj_=="室内"||azhj_==""){
            $("#PART_WQBCZ").val("发纹不锈钢");
        }else{
            $("#PART_WQBCZ").val("发纹不锈钢SUS304");
        }
	}
}

//设置DNR
/**
 * 计算人行道功率
 */
function countPowerDNR() {
    //启动方式
    var qdfs_= getTagValue("#PART_QDFS");
    var qxjd_= getTagValue("#BZ_QXJD");//倾斜角度
    var tbkd_= getTagValue("#BZ_TBKD");//踏板宽度
    var tsgd_=getValueToFloat("#BZ_TSGD");//提升高度
    if(qdfs_=="变频,快、慢节能运行"||qdfs_=="变频,快、慢、停节能运行"){
    	var  gonglv_=getPower(qxjd_,tbkd_,tsgd_);
        $("#PART_BPGNGL").val(gonglv_==0?"":gonglv_);
        $("#PART_BPGNGL_TEMP").val(0);
        editPart('PART_BPGNGL');
    }else {
        $("#PART_BPGNGL").val("");
        $("#PART_BPGNGL_TEMP").val(0);
    }
}

function getPower(qxjd_,tbkd_,tsgd_) {
    ntsgd_=Math.ceil(tsgd_/100)/10;
    var gl_=0;
  if(tbkd_=="800"){
      	if ((qxjd_=='10'&&ntsgd_<=3.5)||(qxjd_=='11'&&ntsgd_<=3.6)||(qxjd_=='12'&&ntsgd_<=3.8)){gl_=5.5;}
      	else if((qxjd_=='10'&&ntsgd_<=5.1)||(qxjd_=='11'&&ntsgd_<=5.2)||(qxjd_=='12'&&ntsgd_<=5.3)){ gl_=7.5;}
      	else if((qxjd_=='10'&&ntsgd_<=7.0)||(qxjd_=='11'&&ntsgd_<=7.3)||(qxjd_=='12'&&ntsgd_<=7.5)){gl_=11;}
      	else if((qxjd_=='10'&&ntsgd_<=7.5)||(qxjd_=='11'&&ntsgd_<=7.5)){gl_=15;}
        else{gl_=0;}
  }
    if(tbkd_=="1000"){
        if ((qxjd_=='10'&&ntsgd_<=2.8)||(qxjd_=='11'&&ntsgd_<=2.9)||(qxjd_=='12'&&ntsgd_<=3.0)){gl_=5.5;}
        else if((qxjd_=='10'&&ntsgd_<=3.8)||(qxjd_=='11'&&ntsgd_<=3.9)||(qxjd_=='12'&&ntsgd_<=4.0)){ gl_=7.5;}
        else if((qxjd_=='10'&&ntsgd_<=5.6)||(qxjd_=='11'&&ntsgd_<=5.8)||(qxjd_=='12'&&ntsgd_<=6.0)){gl_=11;}
        else if((qxjd_=='10'&&ntsgd_<=6.5)||(qxjd_=='11'&&ntsgd_<=6.5)||(qxjd_=='12'&&ntsgd_<=6.6)){gl_=15;}
        else{gl_=0;}
    }
    return gl_;
}

/**
 * 格式化申请非标数据
 */
function formatTransJson() {
    var jsonarry=new Array();
    $("[name='car_type']").each(function(idx){
        var reJson={};
        reJson.car_type=$("[name='car_type']").eq(idx).val();
        reJson.car_num=$("[name='car_num']").eq(idx).val();
        jsonarry[idx]=reJson;
	});
    // console.log(jsonarry);
    // console.log((JSON.stringify(jsonarry)).replace(/"/g,"\'"));
    return (JSON.stringify(jsonarry)).replace(/"/g,"\'");
}

function validateRequired() {
	var result=true;
	$('[required="required"]').each(function (idx) {
		if($(this).val()==''){
			if($($(this).parents(".tab-pane")).attr("id")){
				$('[href="#'+$($(this).parents(".tab-pane")).attr("id")+'"]').tab("show");
			}
            $(this).focus();
            $(this).tips({
                side: 3,
                msg: "内容不能为空！",
                bg: '#AE81FF',
                time: 2
            });
            result=false;
            return false;
		}
    });
	return result;
}

/**
 * 根据标签获取对象值
 * @param tagname
 * @returns {string}
 */
function getTagValue(tagname) {
    if($(tagname).val()==undefined){
        return "";
    }else{
       return $(tagname).val().toString();
    }
}

/**
 * 根据参数获取对应输入框值的FLOAT格式
 *
 * @param attrName 对象标签
 *            对象属性 ID CLASS NAME
 * @returns float类型数值
 */
function getValueToFloat(attrName) {
    return (!$(attrName).val() || $(attrName).val() == '' || isNaN($(attrName)
        .val())) ? 0 : parseFloat($(attrName).val());
}
/**
 * 根据梯型获取电梯数量
 *
 * @returns
 */
function getEleNum() {
    var tz_ = $("#tz_").val();
    if (getValueToFloat("#FEIYUE_SL")>0) {
        return getValueToFloat("#FEIYUE_SL");
    } else if (getValueToFloat("#FEIYUEMRL_SL")>0) {
        return getValueToFloat("#FEIYUEMRL_SL");
    } else if (getValueToFloat("#DNP9300_SL")>0) {
        return getValueToFloat("#DNP9300_SL");
    } else if (getValueToFloat("#DNR_SL")>0) {
        return getValueToFloat("#DNR_SL");
    } else if (getValueToFloat("#FEISHANG_SL")>0) {
        return getValueToFloat("#FEISHANG_SL");
    } else if (getValueToFloat("#FEIYANGXF_SL")>0) {
        return getValueToFloat("#FEIYANGXF_SL");
    } else if (getValueToFloat("#FEIYANGMRL_SL")>0) {
        return getValueToFloat("#FEIYANGMRL_SL");
    } else if (getValueToFloat("#FEIYANG_SL")>0) {
        return getValueToFloat("#FEIYANG_SL");
    } else if (getValueToFloat("#SHINY_SL")>0) {
        return getValueToFloat("#SHINY_SL");
    }else if (getValueToFloat("#FEISHANG_MRL_SL")>0) {
        return getValueToFloat("#FEISHANG_MRL_SL");
    }else if (getValueToFloat("#HOUSEHOLD_SL")>0) {
        return getValueToFloat("#HOUSEHOLD_SL");
    }else if (getValueToFloat("#BASE_SL")>0) {
        return getValueToFloat("#BASE_SL");
    }else{
        return 1;
    }
}

/**
 * 获取电梯类型
 * @returns {*}
 */
function getTz() {
    if (getTagValue("#ele_type")=='DT7') {
        return "新飞越";
    } else if (getTagValue("#ele_type")=='DT8') {
        return "新飞越MRL";
    } else if (getTagValue("#ele_type")=='DT1') {
        return "DNP9300";
    } else if (getTagValue("#ele_type")=='DT2') {
        return "DNR";
    } else if (getTagValue("#ele_type")=='DT3') {
        return "飞尚";
    } else if (getTagValue("#ele_type")=='DT6') {
        return "飞扬消防梯";
    } else if (getTagValue("#ele_type")=='DT5') {
        return "飞扬3000+MRL";
    } else if (getTagValue("#ele_type")=='DT4') {
        return "飞扬3000+";
    } else if (getTagValue("#ele_type")=='DT9') {
        return "曳引货梯";
    }else if (getTagValue("#ele_type")=='DT10') {
        return "DT10";
    }else if (getTagValue("#ele_type")=='DT14') {
        return "DT14";
    }else if (getTagValue("#ele_type")=='DT12') {
        return "DT12";
    }else{
        return '0';
    }
}

/**
 * 非标类型
 * 
 * @returns
 */
function initLxValue() {
	basisDate.Lxs = {
		JX:'2',//轿厢	
		KMCC:'3',//开门尺寸
		JJ:'4',//基价
	};
}

/**
 * 初始化轿厢下拉框
 * @param BASE_JXGG
 * @param isCheck 轿厢特殊加价，1=国标逻辑针对货梯（飞尚、飞弈） 2=新飞越（有机房&无机房）特殊加价
 * @returns
 */
function initBindSelect(BASE_JXGG, isCheck) {
	
	var lx = basisDate.Lxs.JX;
	var jxgg = [];
	var bjxgg = BASE_JXGG;
	var mulItdragonData = $('#BASE_JXGG').find("option");
	for (var i = 0, len = mulItdragonData.length; i < len; i++) {
		var va = mulItdragonData.eq(i).val();
		if(va != ''){
			jxgg.push(va);
		}
	}
	var BASEJXGG = $('#BASE_JXGG').select2({
    	tags: true
   	});
	
	setEngine(lx,isCheck);
	if("2" == isCheck){
		saveSelectBoxValue(jxgg);
	}
	
	getFbOptionOfLx(lx).updateBox = function() {
		if(getFbOptionOfLx(lx).value == 0){
			if(getJSONOfLx(lx).value.length > 0){//没有非标但申请了非标时
				$('#CGFB_JXCC').val("0");
	    		$('#BASE_JXGG_FBTEXT').hide();
			} else {
				$('#BASE_JXGG').trigger("change");
			}
            editMTBH('CGFB_JXCC');
		}
	}
	
	if(bjxgg != '' && $.inArray(bjxgg, jxgg) == -1){
		BASEJXGG.append(`<option value="`+BASE_JXGG+`" selected>`+BASE_JXGG+`</option>`);
		if("1" == isCheck){
			checkStandardArea({
				lx:lx,
				h:$('#BASE_JXGG'),
				val:bjxgg,
				isShowTip:false,
				nonOver: function() {
					$('#CGFB_JXCC').val("1");
		    		$('#BASE_JXGG_FBTEXT').show();
				},
				over: function() {
					$('#CGFB_JXCC').val("0");
		    		$('#BASE_JXGG_FBTEXT').hide();
				}
			});
		} else if("2" == isCheck){
			setFeuyueJxJJ(0);
			checkJXSelectBoxInput({
				ele:$('#BASE_JXGG'), 
				value:bjxgg,
				isShowTip:false,
				nonFB:function(price) {
    				//没有非标
    				setFeuyueJxJJ(price);
    				$('#CGFB_JXCC').val("1");
    			}, 
    			isFB:function() {
    				//非标
    				$('#CGFB_JXCC').val("0");
    				getFbOptionOfLx(lx).value = 1;//轿厢标志为非标
    				showFbLabel(lx, $('#BASE_JXGG'));
    				
    			}, 
    			checkerror:function() {
    				//输入不规范
    				getFbOptionOfLx(lx).value = 2;//轿厢标志为非标
    				showFbLabel(lx, $('#BASE_JXGG'));
    				
    			}, 
    			standardvalue:function() {
    				//输入是标准值
    				$('#CGFB_JXCC').val("0");
    			}
			});
		} else {
			$('#CGFB_JXCC').val("1");
			$('#BASE_JXGG_FBTEXT').show();
		}
	}
    BASEJXGG.val(bjxgg);
    BASEJXGG.on("change", function (e) {
    	var _val = BASEJXGG.val();
    	
    	if("1" == isCheck){
    		getFbOptionOfLx(lx).value = 0;
			$('#CGFB_JXCC').val("0");
    		$('#BASE_JXGG_FBTEXT').hide();
    		removeFbLabel(lx, $('#BASE_JXGG'));
    		if(_val != '' && $.inArray(_val, jxgg) == -1){
    			/*getFbOptionOfLx(lx).value = 0;
    	    	removeFbLabel(lx, $('#BASE_JXGG'))
    	    	
    			checkJXFB($('#BASE_JXGG'),_val, function() {//没有超出国标允许的轿厢面积的非标

    				$('#CGFB_JXCC').val("1");
    	    		$('#BASE_JXGG_FBTEXT').show();
    				
				}, function() {//超出国标允许的轿厢面积的非标
					$('#CGFB_JXCC').val("0");
		    		$('#BASE_JXGG_FBTEXT').hide();
					
		    		getFbOptionOfLx(lx).value = 1;//轿厢标志为非标
		    		
		    		showFbLabel(lx, $('#BASE_JXGG'));
				});*/
    			checkStandardArea({
					lx:lx,
					h:$('#BASE_JXGG'),
					val:_val,
					nonOver: function() {
						if(!isApplyFB(lx)){
		    				$('#CGFB_JXCC').val("1");
		    	    		$('#BASE_JXGG_FBTEXT').show();
						}
					}
				});
    		}
    	} else if("2" == isCheck){
    		getFbOptionOfLx(lx).value = 0;
			$('#CGFB_JXCC').val("0");
    		removeFbLabel(lx, $('#BASE_JXGG'));
    		if(_val != '' && $.inArray(_val, jxgg) == -1){
    			setFeuyueJxJJ(0);
    			checkJXSelectBoxInput({
    				ele:$('#BASE_JXGG'), 
    				value:_val, 
    				nonFB:function(price) {
    					if(!isApplyFB(lx)){
            				//没有非标
            				setFeuyueJxJJ(price);
            				$('#CGFB_JXCC').val("1");
    					}
        			}, 
        			isFB:function() {
        				//非标
        				$('#CGFB_JXCC').val("0");
        				getFbOptionOfLx(lx).value = 1;//轿厢标志为非标
        				showFbLabel(lx, $('#BASE_JXGG'));
        				
        			}, 
        			checkerror:function() {
        				//输入不规范
        				getFbOptionOfLx(lx).value = 2;//轿厢标志为非标
        				showFbLabel(lx, $('#BASE_JXGG'));
        				
        			}, 
        			standardvalue:function() {
        				//输入是标准值
        			}
    			});
    		}
    	} else {
    		if(_val != '' && $.inArray(_val, jxgg) == -1){
        		$('#CGFB_JXCC').val("1");
        		$('#BASE_JXGG_FBTEXT').show();
        	} else {
    			$('#CGFB_JXCC').val("0");
        		$('#BASE_JXGG_FBTEXT').hide();
        	}
    	}
        editMTBH('CGFB_JXCC');
    });
    
    //载重改变事件
    if("1" == isCheck){
    	$('#BZ_ZZ').on("change", function() {
    		var _val = BASEJXGG.val();
    		getFbOptionOfLx(lx).value = 0;
			$('#CGFB_JXCC').val("0");
    		$('#BASE_JXGG_FBTEXT').hide();
    		removeFbLabel(lx, $('#BASE_JXGG'));
    		if(_val != '' && $.inArray(_val, jxgg) == -1){
				checkStandardArea({
					lx:lx,
					h:$('#BASE_JXGG'),
					val:_val,
					nonOver: function() {
						if(!isApplyFB(lx)){
		    				$('#CGFB_JXCC').val("1");
		    	    		$('#BASE_JXGG_FBTEXT').show();
						}
						
					}
				});
    		}
            editMTBH('CGFB_JXCC');
		});
	} else if("2" == isCheck){
		$('#BZ_ZZ').on("change", function() {
    		var _val = BASEJXGG.val();
    		getFbOptionOfLx(lx).value = 0;
			$('#CGFB_JXCC').val("0");
    		$('#BASE_JXGG_FBTEXT').hide();
    		removeFbLabel(lx, $('#BASE_JXGG'));
    		if(_val != '' && $.inArray(_val, jxgg) == -1){
    			setFeuyueJxJJ(0);
    			checkJXSelectBoxInput({
    				ele:$('#BASE_JXGG'), 
    				value:_val, 
    				nonFB:function(price) {
						if(!isApplyFB(lx)){
	        				//没有非标
	        				setFeuyueJxJJ(price);
	        				$('#CGFB_JXCC').val("1");
						}
        			}, 
        			isFB:function() {
        				//非标
        				$('#CGFB_JXCC').val("0");
        				getFbOptionOfLx(lx).value = 1;//轿厢标志为非标
        				showFbLabel(lx, $('#BASE_JXGG'));
        				
        			}, 
        			checkerror:function() {
        				//输入不规范
        				getFbOptionOfLx(lx).value = 2;//轿厢标志为非标
        				showFbLabel(lx, $('#BASE_JXGG'));
        				
        			}, 
        			standardvalue:function() {
        				//输入是标准值
        			}
    			});
    		}
            editMTBH('CGFB_JXCC');
		});
	}
    
}

function bindSelect2AndInitDate(ele, val) {
	if(val && val != ''){
		var eleSelect = ele.select2({
	    	tags: true,
	        data: [{id: val, text: val, selected:true}]
	   	});
	} else {
		var eleSelect = ele.select2({
	    	tags: true
	   	});
	}
	
	
	/*if(val != ''){
		var eValue = [];
		var mulItdragonData = ele.find("option");
		for (var i = 0, len = mulItdragonData.length; i < len; i++) {
			var va = mulItdragonData.eq(i).val();
			if(va != ''){
				eValue.push(va);
			}
		}
		if($.inArray(val, eValue) == -1){
			eleSelect.append(`<option value="`+val+`" selected>`+val+`</option>`);
		}
	}*/
	
}

function getCheckboxValues(tagname) {
	var number = '';
	$(tagname).each(function(k){
		if(this.checked){
			if(k == 0){
		        number = $(this).val();
		    }else{
		        number += ','+$(this).val();
		    }
		}
	})
	return number;
}

/**
 * 减门
 * @param sbj_jj 基价
 * @param c_ 层
 * @param z_ 站
 * @param m_ 门
 * @param _jj 减价
 * @returns
 */
function subDoor(sbj_jj, c_, z_, m_, _jj) {
	var price = 0;
	if(c_ > m_ && m_ <= z_){//当门<层，并且 门<=站时，基价+((层-门)*对应减价))
		price = sbj_jj + ((c_ - m_) * _jj);
	} else if(c_ > m_ && m_ > z_){//当门>层，并且 门>站时，基价+((层-门+(门-站))*对应减价)
		price = sbj_jj + (((c_ - m_) + (m_ - z_)) * _jj);
	} else {
		price = sbj_jj;
	}
	return price;
}

function parseInt_DN(i) {
	var _i = parseInt(i);
	return isNaN(_i)?0:_i;
}

function round(number, precision) {
    return Math.round(+number + 'e' + precision) / Math.pow(10, precision);
    //same as:
    //return Number(Math.round(+number + 'e' + precision) + 'e-' + precision);
}



/**
 * 是否有非标
 * @returns
 */
function iaHasFB() {
	var trs = $("#fbbody tr");
	if(trs.length > 0){
		$("#tz_").attr("readonly", "readonly");
		$("#BZ_ZZ").attr("disabled", "disabled");
		$("#BZ_SD").attr("disabled", "disabled");
		//$("#BZ_KMXS").attr("disabled", "disabled");
		$("#BZ_KMKD").attr("disabled", "disabled");
		$("#BZ_C").attr("disabled", "disabled");
		$("#BZ_Z").attr("disabled", "disabled");
		$("#BZ_M").attr("disabled", "disabled");
		$("#BZ_TSGD").attr("readonly", "readonly");
		//$("#BZ_TBKD").attr("disabled", "disabled");
		$("#BZ_TJKD").attr("disabled", "disabled");
		$("#BZ_QXJD").attr("disabled", "disabled");
	} else {
		$("#tz_").removeAttr("readonly");
		$("#BZ_ZZ").removeAttr("disabled");
		$("#BZ_SD").removeAttr("disabled");
		//$("#BZ_KMXS").removeAttr("disabled");
		$("#BZ_KMKD").removeAttr("disabled");
		$("#BZ_C").removeAttr("disabled");
		$("#BZ_Z").removeAttr("disabled");
		$("#BZ_M").removeAttr("disabled");
		$("#BZ_TSGD").removeAttr("readonly");
		//$("#BZ_TBKD").removeAttr("disabled");
		$("#BZ_TJKD").removeAttr("disabled");
		$("#BZ_QXJD").removeAttr("disabled");
	}
}
/**
 * 提交放开select
 * @returns
 */
function removeAttrDisabled(){
	$("#tz_").removeAttr("disabled");
	$("#BZ_ZZ").removeAttr("disabled");
	$("#BZ_SD").removeAttr("disabled");
	//$("#BZ_KMXS").removeAttr("disabled");
	$("#BZ_KMKD").removeAttr("disabled");
	$("#BZ_C").removeAttr("disabled");
	$("#BZ_Z").removeAttr("disabled");
	$("#BZ_M").removeAttr("disabled");
	$("#BZ_TSGD").removeAttr("disabled");
	//$("#BZ_TBKD").removeAttr("disabled");
	$("#BZ_TJKD").removeAttr("disabled");
	$("#BZ_QXJD").removeAttr("disabled");
	
	$('#BASE_JXGG').removeAttr("disabled");
	$('#BASE_KMCC').removeAttr("disabled");
	
	/*$("select[disabled=disabled]").each(function() {
		alert($(this).val());
		if (parseInt($(this).val()) != -1) {
			$(this).removeAttr("disabled");
 
		}
	 });*/

}

function getSelectDis() {
	return ['BZ_ZZ','BZ_SD','BZ_KMKD','BZ_C','BZ_Z','BZ_M','BZ_TSGD','BZ_TJKD','BZ_QXJD','BASE_JXGG','BASE_KMCC'];
}

/**
 * 添加非标添加选项
 * @param s
 * @param v
 * @returns
 */
function fbSetter(s, v, dj, idx, num) {
	
	if(basisDate.Lxs.JX == s){
		/*if(!$('#BASE_JXGG')[0])return;
		var BASEJXGG = $('#BASE_JXGG').select2({
	    	tags: true
	   	});
		if(BASEJXGG.val() != v){
			BASEJXGG.val(v).trigger("change");
			if(BASEJXGG.val() == null){
				BASEJXGG.append(`<option value="`+v+`" selected>`+v+`</option>`);
			}
		}
		BASEJXGG.attr("disabled", "disabled");
		if(document.getElementById("BASE_JXGG_FBTEXT").style.display != 'none'){
			$('#CGFB_JXCC').val("0");
			$('#BASE_JXGG_FBTEXT').hide();
	        editMTBH('CGFB_JXCC');
		}*/
		
		//getFbDetails().push({
		//	'position': idx + 1,
		//	'des': v,
		//	'price': dj * num
		//});
		getJSONOfLx(s).value.push({
			'position': idx + 1,
			'des': v,
			'price': dj * num
		});
		
	} else if(basisDate.Lxs.KMCC == s){
		/*var BASEKMCC = $('#BASE_KMCC');
		if(BASEKMCC.length > 0){
			if(BASEKMCC.val() != v){
				BASEKMCC.val(v);
				if(BASEKMCC.val() == null){
					BASEKMCC.append(`<option value="`+v+`" selected>`+v+`</option>`);
				}
			}
			BASEKMCC.attr("disabled", "disabled");
		}*/
		getJSONOfLx(s).value.push({
			'position': idx + 1,
			'des': v,
			'price': dj * num
		});
	} else if(basisDate.Lxs.JJ == s){
		//基价
		if(dj){
			updateDANJIA(dj);
		}
	}
	
}

/**
 * 删除非标时移除disabled
 * @param s
 * @param v
 * @returns
 */
function fbUnSetter(s,v) {
	
	if(basisDate.Lxs.JX == s){
		/*if(!$('#BASE_JXGG')[0])return;
		$('#BASE_JXGG').removeAttr("disabled");
		$('#BASE_JXGG').select2({
	    	tags: true
	   	}).val("").trigger("change");*/
	} else if(basisDate.Lxs.KMCC == s){
		/*if(!$('#BASE_KMCC')[0])return;
		$('#BASE_KMCC').removeAttr("disabled");
		$('#BASE_KMCC').val("");
		removeSelectOpen("BASE_KMCC",v);*/
	} else if(basisDate.Lxs.JJ == s){//基价
		updateDANJIAOfDelete();
	}
	
}


function setfblx(v) {
	/*if("1" == v){
		return "其他";
	} else if("2" == v){
		return "轿厢尺寸非标";
	} else if("3" == v){
		return "开门宽度非标";
	}*/
	return getFBLXName(v);
}

function setfblxValue(v) {
	/*if("其他" == v){
		return "1";
	} else if("轿厢尺寸非标" == v){
		return "2";
	} else if("开门宽度非标" == v){
		return "3";
	}*/
	return getFBLXValue(v);
}

function getFBLXName(value) {
	var _name = value;
	var fblx = getFBLXJSON();
	if(fblx && value){
		$.each(fblx, function(i, item){
			if(item.value == value){
				_name = item.name;
				return ;
			}
		});
	}
	return _name;
}

function getFBLXValue(name) {
	var _value = name;
	var fblx = getFBLXJSON();
	if(fblx && name){
		$.each(fblx, function(i, item){      
			if(item.name == name){
				_value = item.value;
				return ;
			}
		});
	}
	return _value;
}


/**
 * 根据类型更新选中
 * @returns
 */
function updateFbX() {
	
	var seles = [];
	var num = getEleNum();
	//getFbDetails().length = 0;
	clearFbJSONData();
	$("#fbTable [name='nonstandrad_describe']").each(function(idx){
		var s = setfblxValue($($("span.fblx")[idx]).html());
		/*if($.inArray(s, seles) == -1){
			var _dj = $("#fbTable input[name='nonstandrad_DTBJ']").eq(idx).val()
			fbSetter(s, $(this).val(), _dj, idx, num);
			seles.push(s);
		}*/
		var _dj = $("#fbTable input[name='nonstandrad_DTBJ']").eq(idx).val()
		fbSetter(s, $(this).val(), _dj, idx, num);
	});
	
	updateInputBox();
}
/**
 * 根据类型更新选中
 * @param _s
 * @returns
 */
function updateFbXForS(_s) {

	var seles = [];
	var num = getEleNum();
	$("#fbTable [name='nonstandrad_describe']").each(function(idx){
		var s = setfblxValue($($("span.fblx")[idx]).html());
		if(s == _s && $.inArray(s, seles) == -1){
			var _dj = $("#fbTable input[name='nonstandrad_DTBJ']").eq(idx).val()
			fbSetter(s, $(this).val(), _dj, idx, num);
			seles.push(s);
			return;
		}
	});
	
}
/**
 * 下拉框是否存在某值
 * @param id
 * @param value
 * @returns
 */
function isExistOption(id,value) {  
	var isExist = false;
	var count = $('#'+id).find('option').length;
	for(var i=count - 1;i >= 0;i--){     
		if($('#'+id).get(0).options[i].value == value){     
			isExist = true;     
			break;     
		}     
	}
	return isExist;  
} 

/**
 * 根据值移除下拉框option
 * @param id
 * @param value
 * @returns
 */
function removeSelectOpen(id, value) {
	var count = $('#'+id).find('option').length;
	for(var i=count - 1;i >= 0;i--){     
		if($('#'+id).get(0).options[i].value == value){     
			$('#'+id).get(0).options[i].remove();
			break;     
		}     
	}
}

/**
 * 根据类型获取JSON对象
 * @param lx
 * @returns
 */
function getJSONOfLx(lx) {
	if(!basisDate.fbDetails){
		basisDate.fbDetails = {}
	}
	if(!lx){
		lx = '-1';
	}
	
	var lxJName = 'temp';
	if(basisDate.Lxs.JX == lx){//轿厢
		lxJName = 'jxfbDetails'
	} else if(basisDate.Lxs.KMCC == lx){//开门尺寸
		lxJName = 'kmccfbDetails'
	}

	if(!basisDate.fbDetails[lxJName] || !basisDate.fbDetails[lxJName].value){
		basisDate.fbDetails[lxJName] = {
				lx:lx,
				value:[]
		};
	}
	return basisDate.fbDetails[lxJName];
}

function getLxHtMLname(lx) {
	switch (lx) {
	case basisDate.Lxs.JX:
		return "#BASE_JXGG";
		break;
	case basisDate.Lxs.KMCC:
		return "#BASE_KMCC";
		break;
	default:
		return "";
		break;
	}
}

/**
 * 清除非标申请的数据
 * @returns
 */
function clearFbJSONData() {
	var fd = basisDate.fbDetails;
	$.each(fd, function(i,v) {
		if(!$.isEmptyObject(v)){
			var lx = v.lx;
			basisDate.fbDetails[i] = {
					lx:lx,
					value:[]
			}
		}
	});
}

/**
 * 更新非标标志是否显示
 * @returns
 */
function updateInputBox() {
	
	var fd = basisDate.fbDetails;
	
	if(fd){
		//$('.dn-fb-lb').remove();
		$.each(fd, function(i,v) {
			var lx = v.lx;
			var lxV = v.value;
			var h = $(getLxHtMLname(lx));//获取类型对应的html标签
			if(h && h.length > 0){
				if(lxV && lxV.length > 0){
					/*if(h.siblings('.dn-fb-lb').length == 0){
						if(h.next('span.select2').length > 0 && h.hasClass("select2-hidden-accessible")){
							h.next('span.select2').after('<span class="label label-danger onPointer dn-fb-lb" onclick="showLabelDetails(\''+lx+'\',\'非标详情\');" title="点击查看详情">非 标</span>');
						} else {
							h.after('<span class="label label-danger onPointer dn-fb-lb" onclick="showLabelDetails(\''+lx+'\',\'非标详情\');" title="点击查看详情">非 标</span>');
						}
					}*/
					showFbLabel(lx,h);
				} else {
					if(!getFbOptionOfLx(lx).value || getFbOptionOfLx(lx).value == 0){//类型是否需要非标,不需要移除 非标 标志
			    		removeFbLabel(lx, h);
					}
				}
				
				//更新界面 方法
				if(getFbOptionOfLx(lx).updateBox &&  'function' == typeof getFbOptionOfLx(lx).updateBox){
					getFbOptionOfLx(lx).updateBox();
				}
				
			}
		});
	}
}

function updateInputBoxOfLx(lx) {
	
	var fd = basisDate.fbDetails;
	
	if(fd){
		var h = $(getLxHtMLname(lx));//获取类型对应的html标签
		if(h && h.length > 0){
			if(lxV && lxV.length > 0){
				showFbLabel(lx,h);
			} else {
				if(!getFbOptionOfLx(lx).value || getFbOptionOfLx(lx).value == 0){//类型是否需要非标,不需要移除 非标 标志
		    		removeFbLabel(lx, h);
				}
			}
		}
	}
}

/**
 * 获取非标json
 * @returns
 */
function getJsonStrfb() {
	//非标
    var jsonStrfb = "[";

    $("#fbTable [name='nonstandrad_describe']").each(function(idx){
    	var kdz = $($("span.iskdz")[idx]).html()=='是'?'1':($($("span.iskdz")[idx]).html()=='否'?'2':'');
        jsonStrfb+= "{\'master_id\':\'"+$(this).siblings("[name='master_id']").val()+
        	"\',\'nonstandrad_describe\':\'"+$(this).val()+
            "\',\'nonstandrad_spec\':\'"+setfblxValue($($("span.fblx")[idx]).html())+
            "\',\'nonstandrad_price\':\'"+$($("[name='nonstandrad_price']")[idx]).val()+
            "\',\'nonstandrad_sprice\':\'"+$($("[name='nonstandrad_sprice']")[idx]).val()+
            "\',\'nonstandrad_handle\':\'"+$($("[name='nonstandrad_handle']")[idx]).val()+
            "\',\'nonstandrad_DTBJ\':\'"+$($("[name='nonstandrad_DTBJ']")[idx]).val()+
            "\',\'nonstandrad_ZJ\':\'"+$($("[name='nonstandrad_ZJ']")[idx]).val()+
            "\',\'nonstandrad_KDZ\':\'"+kdz+
            "\',\'nonstandrad_BZ\':\'"+$($("[name='nonstandrad_BZ']")[idx]).val().replace(/'/g, ' ').replace(/{/g, ' ').replace(/}/g, ' ').replace(/[/g, ' ').replace(/]/g, ' ')+
            "\'},";
    })
    jsonStrfb = (jsonStrfb.length>1?jsonStrfb.substring(0,jsonStrfb.length-1): jsonStrfb)+"]";
    return jsonStrfb;
}

/**
 * 更新报价编辑页按钮数据
 * @param data
 * @returns
 */
function buildofferButton(data) {
	if(!data){
		return;
	}
	
	var dtCodId = data.dtCodId;
	var bjc_id = data.bjc_id;
	var modelsId = data.modelsId;
	var elevIds = data.elevIds;
	var srPd = data.srPd;
	var rowIndex = data.rowIndex;
	var CountPd = data.CountPd;
	var c_ = srPd.c_;
	var z_ = srPd.z_;
	var m_ = srPd.m_;
	var sbj_ = srPd.sbj_;
	var zk_ = srPd.zk_;
	var yjze_ = srPd.yjze_;
	var yjbl_ = srPd.yjbl_;
	var sjbj_ = srPd.sjbj_;
	var ele_azf_ = srPd.ele_azf_;
	var azf_ = srPd.azf_;
	var ysf_ = srPd.ysf_;
	var tsf_ = srPd.tsf_;
	var cjf_ = srPd.cjf_;
	
	var buttonStr = "<button class='btn  btn-primary btn-sm' title='编辑' onclick=\"toEdit(this,'"+dtCodId+"','"+modelsId+"','"+bjc_id+"')\" type='button'>编辑</button>"
				+ " <button class='btn  btn-danger btn-sm' title='删除' onclick=\"deleteRow(this,'"+elevIds+"')\" type='button'>删除</button>"
				+" <button class='btn btn-info btn-sm' title='梯号设置' style='margin-left:5px;' type='button'" +
				" onclick=\"setENoRow(this,'"+elevIds+"','"+bjc_id+"')\">梯号设置</button>";
	
	rowIndex = parseInt(rowIndex)+1;
	window.parent.$("#tab1").find("tr").eq(rowIndex).find("td").eq(0).find("input").eq(0).val(bjc_id);
	window.parent.$("#tab1").find("tr").eq(rowIndex).find("td").eq(2).text(c_+"/"+z_+"/"+m_);
	window.parent.$("#tab1").find("tr").eq(rowIndex).find("td").eq(3).text(sbj_);
	window.parent.$("#tab1").find("tr").eq(rowIndex).find("td").eq(4).text(zk_);
	window.parent.$("#tab1").find("tr").eq(rowIndex).find("td").eq(5).text(yjze_);
	window.parent.$("#tab1").find("tr").eq(rowIndex).find("td").eq(6).text(yjbl_);
	window.parent.$("#tab1").find("tr").eq(rowIndex).find("td").eq(7).text(ele_azf_);
	window.parent.$("#tab1").find("tr").eq(rowIndex).find("td").eq(8).text(tsf_);
	window.parent.$("#tab1").find("tr").eq(rowIndex).find("td").eq(9).text(cjf_);
	window.parent.$("#tab1").find("tr").eq(rowIndex).find("td").eq(10).text(ysf_);
	window.parent.$("#tab1").find("tr").eq(rowIndex).find("td").eq(11).text(sjbj_);
	window.parent.$("#tab1").find("tr").eq(rowIndex).find("td").eq(12).text("").append(buttonStr);
	
	var COUNT_SL    = CountPd.COUNT_SL;
	var COUNT_SJZJ  = CountPd.COUNT_SJZJ;
	var COUNT_ZK    = CountPd.COUNT_ZK;
	var COUNT_YJ    = CountPd.COUNT_YJ;
	var COUNT_BL    = CountPd.COUNT_BL;
	var COUNT_AZF   = CountPd.COUNT_AZF;
	var COUNT_YSF   = CountPd.COUNT_YSF;
	var COUNT_TATOL = CountPd.COUNT_TATOL;
	
	window.parent.$('#tab1 tr:last').find('td').eq(1).text(COUNT_SL);
	window.parent.$('#tab1 tr:last').find('td').eq(3).text(COUNT_SJZJ);
	window.parent.$('#tab1 tr:last').find('td').eq(4).text(COUNT_ZK);
	window.parent.$('#tab1 tr:last').find('td').eq(5).text(COUNT_YJ);
	window.parent.$('#tab1 tr:last').find('td').eq(6).text(COUNT_BL);
	window.parent.$('#tab1 tr:last').find('td').eq(7).find("input[name=TB_COUNT_AZF]").val(COUNT_AZF);
	window.parent.$('#tab1 tr:last').find('td').eq(10).text(COUNT_YSF);
	window.parent.$('#tab1 tr:last').find('td').eq(11).text(COUNT_TATOL);
	
	if('function' == typeof window.parent.initCJFTSF){
		window.parent.initCJFTSF();
	}
	
}

/**
 * 更新报价编辑页数据
 * @param data
 * @returns
 */
function buildofferInfo(data){
	if(!data || !data.eOfferPd || $.isEmptyObject(data.eOfferPd)){
		return;
	}
	var parentEle = window.parent;
	var eOffer = data.eOfferPd;
	
	var ofId = parentEle.$("#offer_id").val();
	var actionIndex = parentEle.$("#e_offerForm").attr("action").indexOf('save');
	if(ofId == '' && actionIndex != -1){
		parentEle.$("#e_offerForm").attr("action", data.eOfferAction);
		parentEle.$("#offer_no").val(eOffer.offer_no);
		parentEle.$("#offer_id").val(eOffer.offer_id);
		parentEle.$("#instance_status").val(eOffer.instance_status);
		parentEle.$("#instance_id").val(eOffer.instance_id);
		parentEle.$("#offer_user").val(eOffer.offer_user);
		parentEle.$("#offer_date").val(eOffer.offer_date);
		parentEle.$("#KEY").val(eOffer.KEY);
		parentEle.$("#order_org").val(eOffer.order_org);
	}
}

////////非标标志 start

/**
 * 非标标志，点击弹出内容
 * @param lx
 * @param title
 * @returns
 */
function showLabelDetails(lx, title) {
	if(!title)
		title = '信息';
	
	var	content = '';
	content += getLabelTipInfo(lx);
	content += '<table class="table table-bordered"><tr><th>位置</th><th>非标描述</th><th>总价</th></tr>';
	var d = getJSONOfLx(lx);
	if(d){
		$.each(d.value, function(i,v){
			content += '<tr><td>'+v.position+'</td><td>'+v.des+'</td><td>'+v.price+'</td></tr>';
		});
	}
	content += '</table>';
	
	layer.open({
		type: 1,
		area: ['460px', '200px'],
		shade: false,
		title:title,
		content: content
	});
}

function getLabelTipInfo(lx) {
	switch (lx) {
	case basisDate.Lxs.JX:
		if(getFbOptionOfLx(lx).value == 1){
			var t = '';
			var len = getJSONOfLx(lx).value.length;
			if(len > 0){
				//t = "<span style='margin-left: 5px;color:green;'>(已申请)</span>";
				return showLabelTipTitle('success', getTitleDetailed(lx));
			} else {
				//t = "<span style='margin-left: 5px;color:red;'>(未申请)</span>";
				return showLabelTipTitle('danger', getTitleDetailed(lx));
			}
			//return "<h4 style='color:red;margin-left: 5px;display:inline;'>提示：超出国标，请非标询价</h4>"+t;
		} else if(getFbOptionOfLx(lx).value == 2){
			var len = getJSONOfLx(lx).value.length;
			if(len > 0){
				return showLabelTipTitle('success', '所填规格不规范，系统无法检测，请非标询价');
			} else {
				return showLabelTipTitle('danger', '所填规格不规范，系统无法检测，请非标询价');
			}
		}
		
		return "";
		break;

	default:
		return "";
		break;
	}
}

function showLabelTipTitle(t, title) {
	var alertType = 'alert-success';
	var a = '(已申请)';
	switch (t) {
	case 'success':
		alertType = 'alert-success';
		a = '(已申请)';
		break;
	case 'danger':
		alertType = 'alert-danger';
		a = '(未申请)';
		break;
	}
	return '<div class="alert '+alertType+'" role="alert" style="padding-top:8px;padding-bottom:8px;margin-bottom:0;">'+title+' '+a+'</div>';
	
	
}

function getTitleDetailed(lx) {
	switch (lx) {
	case basisDate.Lxs.JX:
		var e = getEngine(lx);
		if("1" == e){
			return "所填规格超出国标，请非标询价";
		} else if("2" == e){
			return "所填规格非标准加价，请非标询价";
		}
		break;

	default:
		break;
	}
}

/**
 * 显示非标的标志
 * @param lx
 * @param h
 * @returns
 */
function showFbLabel(lx, h, title) {
	if(!showFbLabelToTd(lx, h, title) && h.siblings('.dn-fb-lb').length == 0){
		var _title = title||'非标详情';
		
		if(h.next('span.select2').length > 0 && h.hasClass("select2-hidden-accessible")){
			h.next('span.select2').after('<span class="label label-danger dn-fb-lb" style="cursor: pointer;margin-left: 5px;" onclick="showLabelDetails(\''+lx+'\',\''+_title+'\');" title="点击查看详情">非 标</span>');
		} else {
			h.after('<span class="label label-danger dn-fb-lb" style="cursor: pointer;margin-left: 5px;" onclick="showLabelDetails(\''+lx+'\',\''+_title+'\');" title="点击查看详情">非 标</span>');
		}
	}
}

function showFbLabelToTd(lx, h, title) {
	var f = false;
	if(h.parent('td').length > 0){
		var t = h.parents("tr").children("td").eq(0);
		if(t){
			f = true;
			if(t.children(".dn-fb-lb").length == 0){
				t.css({
					position: "relative"
				});
				var _title = title||'非标详情';
				t.append('<span class="label label-danger dn-fb-lb" style="cursor: pointer;margin-left: 5px;position: absolute;top:0;right:0;" onclick="showLabelDetails(\''+lx+'\',\''+_title+'\');" title="点击查看详情">非 标</span>');
			}
		}
		
	}
	return f;
}


/**
 * 根据lx与name值移除非标的标志
 * @param lx
 * @param h
 * @returns
 */
function removeFbLabel(lx, h) {
	if(!removeFbLabelToTd(lx, h) && h.siblings('.dn-fb-lb').length > 0){
		
		if(getJSONOfLx(lx).value.length > 0){
			return;
		}
		h.siblings('.dn-fb-lb').remove();
	}
}

function removeFbLabelToTd(lx, h) {
	var f = false;
	if(h.parent('td').length > 0){
		var t = h.parents("tr").children("td").eq(0);
		if(t){
			f = true;
			if(t.children(".dn-fb-lb").length > 0){
				
				if(getJSONOfLx(lx).value.length > 0){
					return f;
				}
				
				t.css({
					position: "static"
				});
				t.children(".dn-fb-lb").remove();
			}
		}
		
	}
	return f;
}

/**
 * 根据类型获取非标JSON对象，输入内容是否必须申请非标
 * @param lx
 * @returns
 */
function getFbOptionOfLx(lx) {
	if(!basisDate.fbOption){
		basisDate.fbOption = {}
	}
	if(!lx){
		lx = '-1';
	}
	
	var lxJName = 'temp';
	if(basisDate.Lxs.JX == lx){//轿厢
		lxJName = 'jxfbDetails'
	} else if(basisDate.Lxs.KMCC == lx){//开门尺寸
		lxJName = 'kmccfbDetails'
	}
	if(!basisDate.fbOption[lxJName]){
		basisDate.fbOption[lxJName] = {
				lx:lx,
				value:0 //0=不是非标，1=非标，2=无法检测，非标
		};
	}
	return basisDate.fbOption[lxJName];
}

/**
 * 是否申请了非标
 * 
 * @returns
 */
function isApplyFB(lx) {
	return getJSONOfLx(lx).value.length > 0;
}

////////非标标志 end

function setEngine(lx, v) {
	if(lx && v){
		if(!basisDate.fbEngine){
			basisDate.fbEngine = {};
		}
		basisDate.fbEngine[lx] = v;
	}
}

function getEngine(lx) {
	if(lx){
		if(basisDate.fbEngine && basisDate.fbEngine[lx]){
			return basisDate.fbEngine[lx];
		}
	}
	return '';
}

////////国标允许的轿厢面积对应的载重下轿厢尺寸的变化 (货梯 飞尚，飞弈) start

/**
 * 检测是否超出国标，货梯，飞尚，飞弈
 * @param lx 所属类型
 * @param h 标签jQuery对象
 * @param val 判断值
 * @param nonOver 没有超出返回
 * @param over 超出返回
 * @returns
 */
function checkStandardArea(options) {
	var defaults = {
			lx:null,
			h:null,
			val:null,
			isShowTip:true,
			nonOver: function(price) {},
			over: function() {},
			checkerror: function() {},
			standardvalue: function() {}
	}
	var _options = options || {};
	var settings = $.extend(defaults, _options);

	//getFbOptionOfLx(lx).value = 0;
	//removeFbLabel(lx, h)
	
	checkJXFB(settings.h,settings.val,settings.isShowTip, function() {//没有超出国标允许的轿厢面积的非标
		settings.nonOver();
	}, function() {//超出国标允许的轿厢面积的非标
		getFbOptionOfLx(settings.lx).value = 1;//轿厢标志为非标
		showFbLabel(settings.lx, settings.h);
		settings.over();
	}, function() {//输入不符合
		getFbOptionOfLx(settings.lx).value = 2;//输入不规范，为非标
		showFbLabel(settings.lx, settings.h);
		if('function' == typeof settings.checkerror){
			settings.checkerror();
		}
	});
}

/**
 * 轿厢载重范围JSON，超出需要非标询价
 * @returns
 */
function getJXSF() {
	return {
		'maxZz':2500,//最大载重 ()
		'maxZzQuantity':0.0016,//m2/kg  每增加1kg载重，面积就增加0.0016平方米，（当载重超过最大值时，没增加100kg,面积增加0.16平方米）
		'jxStandard':{//额定载重量 : 轿厢最大有效面积
			'225':0.37,'300':0.90,'375':1.10,'400':1.17,'450':1.30,'525':1.45,'600':1.60,'630':1.66,'675':1.75,'750':1.90,'800':2.00,'825':2.05,
			'900':2.20,'975':2.35,'1000':2.40,'1050':2.50,'1125':2.65,'1200':2.80,'1250':2.90,'1275':2.95,'1350':3.10,'1425':3.25,'1500':3.40,'1600':3.56,
			'2000':4.20,'2500':5.00
		}
	};
}


/**
 * 检查国标允许的轿厢面积
 * @param ele
 * @param value
 * @param nonFB
 * @param isFB
 * @returns
 */
function checkJXFB(ele, value, isShowTip, nonFB, isFB, checkerror) {
	var jxjson = getJXSF();
	if(!value || value == null) return;
	var vArray = getSpValue(value);
	if(vArray == null){
		if(isShowTip){
			showTip(ele);
		}
		checkerror();
		return;
	}
	var mj = parseFloat((parseInt(vArray[0])*parseInt(vArray[1])) / 1000000).toFixed(2);
	var zz = getValueToFloat('#BZ_ZZ');//载重
	
	var standardMj = 0;
	if(zz > jxjson.maxZz){
		//载重超过2500。。。。。。。
		var diff = zz - jxjson.maxZz;
		standardMj = (diff * jxjson.maxZzQuantity) + jxjson.jxStandard[jxjson.maxZz];
		
	} else {
		standardMj = jxjson.jxStandard[zz];//标准面积
	}
	if(standardMj){
		if(standardMj >= mj){
			
			nonFB();
			
		} else {
			//非标。。。。
			isFB();
		}
	} else {
		//非标。。。。。
		isFB();
	}
}


/**
 * 获取输入值，输入不规范返回null
 * @param value
 * @returns
 */
function getSpValue(value) {
	
	var index = value.indexOf('*');
	if(index != -1){
		var w = value.substring(0, index);
		if(!/^[0-9]+(mm)?$/.test(w)){
			return null;
		}
		w = w.replace(/mm$/,'');
		var s = '';
		for (var i = (index + 1); i < value.length; i++) {
			var _v = value.charAt(i);
			if(isNaN(parseInt(_v))){
				break;
			} else {
				s += _v;
			}
		}
		if(!/^[0-9]+$/.test(s)){
			return null;
		}
		return [w,s];
	}
	return null;
}



/**
 * 轿厢输入不规范提示信息
 * @param ele
 * @returns
 */
function showTip(ele) {
	var _ele = ele;
	if(_ele.next('span.select2').length > 0 && _ele.hasClass("select2-hidden-accessible")){
		_ele = $(ele).next('span.select2');
	}
	layer.tips('输入格式错误，请按照规范输入，轿厢宽度（CW）*轿厢深度（CD），如1100*2100', _ele,{
		  tips: [1, '#3595CC'],area: ['480px', 'auto']
	});
}


////////国标允许的轿厢面积对应的载重下轿厢尺寸的变化 (货梯 飞尚，飞弈)  end


////////轿厢   2=新飞越（有机房&无机房）特殊加价 start

function saveSelectBoxValue(array) {
	/*if($.isArray(array)){
		var feiyueJXv = [];
		$.each(array, function(i,v) {
			var j = v.indexOf('×');
			if(j != -1){
				var w = v.substring(0, j);//宽
				if(/^[0-9]+$/.test(w)){
					var j2 = v.indexOf('(');
					if(j2 != -1){
						var d = v.substring((j+1), j2);//深
						if(/^[0-9]+$/.test(d)){
							var j3 = v.indexOf('k');
							if(j3 != -1){
								var zz = v.substring((j2+1), j3);//载重
								if(/^[0-9]+$/.test(d)){
									feiyueJXv.push(JSON.parse('{"zz'+zz+'":{"w":"'+w+'","d":"'+d+'"}}'));
								}
							}
						}
					}
				}
			}
			
		});
		alert(JSON.stringify(feiyueJXv.zz630));
	}*/
	
	var feiyueJXv = {
			"630":{
				"w":1100,
				"d":1400
			},
			"800":{
				"w":1350,
				"d":1400
			},
			"1000":{
				"w":1600,
				"d":1400
			},
			"1150":{
				"w":1800,
				"d":1500
			}
	};
	basisDate.feiyueJXv = feiyueJXv;
}


function checkJXSelectBoxInput(options) {
	var defaults = {
			ele:null,
			value:null,
			isShowTip:true,
			nonFB: function(price) {},
			isFB: function() {},
			checkerror: function() {},
			standardvalue: function() {}
	}
	var _options = options || {};
	var settings = $.extend(defaults, _options);

	if(settings.value == null || settings.value == '') return;
	
	var vArray = getSpValue(settings.value);
	if(vArray == null){
		if(settings.isShowTip){
			showTip(settings.ele);
		}
		settings.checkerror();
		return;
	}
	var w = vArray[0];
	var d = vArray[1];
	
	var zz = getValueToFloat('#BZ_ZZ');//载重
	var standardWD = basisDate.feiyueJXv[zz];
	if(standardWD){
		var standardW = standardWD.w;
		var standardD = standardWD.d;
		
		if(w > standardW || d > standardD){
			
			//2）轿厢宽度和深度尺寸非标时：630-1150KG  发纹不锈钢 1790元/台  指宽度加大 and 深度加大；or 宽度加大 and 深度缩小；or 宽度缩小 and 深度加大，
			if((w > standardW && d > standardD) 
					|| (w > standardW && d < standardD)
					|| (w < standardW && d > standardD)){
				settings.nonFB(1790);
			} else {
				//1）轿厢宽度或深度尺寸非标时：630-1150KG  发纹不锈钢 1360元/台  指宽度加大 or 深度加大
				settings.nonFB(1360);
			}
		} else if(w < standardW || d < standardD){
			if(w < standardW && d < standardD){
				//3）轿厢宽度和深度尺寸均非标缩小：发纹不锈钢/喷涂   420元/台  宽度缩小 and 深度均缩小
				settings.nonFB(420);
			} else if((w < standardW && d == standardD) || (w == standardW && d < standardD)){
				//4）轿厢宽度或深度尺寸均非标缩小：发纹不锈钢/喷涂   280元/台  宽度缩小 and 深度标准；or 宽度标准 and 深度缩小 两种情况
				settings.nonFB(280);
			} else {
				settings.isFB();
			}
			
		} else if(w == standardW && d == standardD){
			settings.standardvalue();
		} else {
			settings.isFB();
		}
	} else {
		settings.isFB();
	}
}

/**
 * 保存新飞越轿厢加价
 * @param value
 * @returns
 */
function setFeuyueJxJJ(value) {
	if(value){
		basisDate.feiyueJXPrice = value;
	}
}
/**
 * 获取新飞越轿厢加价
 * @returns
 */
function getFeuyueJxJJ() {
	return basisDate.feiyueJXPrice;
}

////////轿厢   2=新飞越（有机房&无机房）特殊加价 end
