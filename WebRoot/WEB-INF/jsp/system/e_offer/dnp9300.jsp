<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fns" uri="/WEB-INF/tlds/fns.tld"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>

<head>

<base href="<%=basePath%>">


    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pd.SYSNAME}</title>
    <!-- Check Box -->
    <link href="static/js/iCheck/custom.css" rel="stylesheet">
    <style type="text/css">
        .ztree li span.button.add {
            margin-left: 2px;
            margin-right: -1px;
            background-position: -144px 0;
            vertical-align: top;
            *vertical-align: middle
        }
        
       #tab input:read-write
		{ 
		background-color: rgb(255,255,150);
		}
		#tab input:read-only
		{ 
		background-color: rgb(238,238,238);
		}
    </style>
    <!-- jsp文件头和头部 -->
    <%@ include file="../../system/admin/top.jsp"%> 
    <!-- 日期控件-->
    <script src="static/js/layer/laydate/laydate.js"></script>
    <script src="static/js/installioncount.js?v=1.2"></script>
    <script type="text/javascript">
        var basePath="<%=basePath%>";
        var itemelecount="${itemelecount}";
        var basisDate = {
        		'fbdj':null
        }
    </script>
</head>

<body class="gray-bg">
    <div id="cbjView" class="animated fadeIn"></div>
    <div id="zhjView" class="animated fadeIn"></div>
    <form action="e_offer/${msg}.do" name="dnp9300Form" id="dnp9300Form" method="post">
    <input type="hidden" name="ele_type" id="ele_type" value="DT1">
    <input type="hidden" name="view" id="view" value="${pd.view}">
    <input type="hidden" name="BJC_ID" id="BJC_ID" value="${pd.BJC_ID}">
    <input type="hidden" name="DNP9300_ID" id="DNP9300_ID" value="${pd.DNP9300_ID}">
    <input type="hidden" name="offer_version" id="offer_version" value="${pd.offer_version}">
    <input type="hidden" name="FLAG" id="FLAG" value="${FLAG}">
    <input type="hidden" name="rowIndex" id="rowIndex" value="${pd.rowIndex}">
    <input type="hidden" name="UNSTD" id="UNSTD" value="${pd.UNSTD}">
    <input type="hidden" name="MODELS_ID" id="MODELS_ID" value="${pd.MODELS_ID}">
    <input type="hidden" name="ITEM_ID" id="ITEM_ID" value="${pd.ITEM_ID}">
    <input type="hidden" name="ELEV_IDS" id="ELEV_IDS" value="${pd.ELEV_IDS}">
<%--     <input type="hidden" name="YJSYZKL" id="YJSYZKL" value="${pd.YJSYZKL}"> --%>
    <input type="hidden" name="ZGYJ" id="ZGYJ" value="${pd.ZGYJ}">
    <div class="" style="z-index: -1;margin-top: -20px;">
        <div class="row">
            <div class="col-sm-12" >
                <div class="">
                    <div class="">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="panel panel-primary">
                                    <div class="panel-heading">
                                                                                                                       报价信息
                                        <c:if test="${forwardMsg!='view'}">
                                            <input type="button" value="调用参考报价" onclick="selCbj();" class="btn-sm btn-success">
                                        </c:if>
                                    </div>
                                    <div class="panel-body">
                                        <div class="form-group form-inline">
                                            <label style="width:11%;margin-bottom: 10px"><font color="red">*</font>梯种</label>
                                            <input style="width:20%;" class="form-control" id="tz_" type="text"
									        name="tz_" value="${modelsPd.models_name }" placeholder="这里输入型号名称" required="required">
                                            <!-- <select style="width: 20%;margin-top: 10px" class="form-control m-b" id="tz_" name="tz_">
                                                <option value="DNP9300">DNP9300</option>
                                            </select> -->

                                            <label style="width:11%;margin-bottom: 10px"><font color="red">*</font>倾斜角度:</label>
                                            <select style="width: 20%;" class="form-control" id="BZ_QXJD" name="BZ_QXJD" onchange="setSbj()" required="required">
                                                <option value="">请选择</option>
                                                <option value="35" ${(pd.view=='save'?regelevStandardPd.QXJD:pd.BZ_QXJD)=='35'?'selected':''}>35°</option>
                                                <option value="30" ${(pd.view=='save'?regelevStandardPd.QXJD:pd.BZ_QXJD)=='30'?'selected':''}>30°</option>
                                            </select>

                                            <label style="width:11%;margin-bottom: 10px">梯级宽度(mm):</label>
                                            <select style="width: 20%;" class="form-control" id="BZ_TJKD" name="BZ_TJKD" onchange="setSbj();">
                                                <option value="">请选择</option>
                                                <option value="600" ${(pd.view=='save'?regelevStandardPd.TJKD:pd.BZ_TJKD)=='600'?'selected':''}>600</option>
                                                <option value="800" ${(pd.view=='save'?regelevStandardPd.TJKD:pd.BZ_TJKD)=='800'?'selected':''}>800</option>
                                                <option value="1000" ${(pd.view=='save'?regelevStandardPd.TJKD:pd.BZ_TJKD)=='1000'?'selected':''}>1000</option>
                                            </select>
                                        </div>

                                        <div class="form-group form-inline">
                                            <label style="width:11%;margin-bottom: 10px"><font color="red">*</font>水平梯级数</label>
                                            <select style="width: 20%;" class="form-control" id="BZ_SPTJ" name="BZ_SPTJ" onchange="countZhj()" required="required">
                                                <option value="">请选择</option>
                                                <option value="2" ${(pd.view=='save'?regelevStandardPd.SPTJ:pd.BZ_SPTJ)=='2'?'selected':''}>2</option>
                                                <option value="3" ${(pd.view=='save'?regelevStandardPd.SPTJ:pd.BZ_SPTJ)=='3'?'selected':''}>3</option>
                                            </select>

                                            <label style="width:11%;margin-bottom: 10px"><font color="red">*</font>速度:</label>
                                            <select style="width: 20%;" class="form-control" id="BZ_SD" name="BZ_SD" required="required">
                                                <option value="">--</option>
                                                <option value="0.5" ${(pd.view=='save'?regelevStandardPd.SD:pd.BZ_SD)=='0.5'?'selected':''}>0.5</option>
                                            </select>
                                            <label style="width:11%;margin-bottom: 10px;display: none">规格:</label>
                                            <select class="form-control" style="width:20%;display: none" name="BZ_GG" id="BZ_GG" onchange="setSbj();">
                                                <option value="">请选择</option>
                                            </select>
                                            <label style="width:11%;margin-bottom: 10px"><font color="red">*</font>提升高度:</label>
                                            <input type="text" class="form-control" id="BZ_TSGD" name="BZ_TSGD" value="${pd.BZ_TSGD}"
                                                   onkeyup="tsgdpd();setSbj();" style="width:20%;" placeholder="这里输入提示高度(mm)" required="required">
                                        </div>
                                        <div class="form-group form-inline">
                                            <label style="width:11%;margin-bottom: 10px">数量:</label>
                                            <input type="text" class="form-control" id="DNP9300_SL" name="DNP9300_SL" value="${pd.DNP9300_SL}" readonly="readonly" style="width:20%;">
                                            
                                            <input type="hidden" id="DNP9300_ZK" name="DNP9300_ZK" value="${pd.DNP9300_ZK}">
                                            
                                            <label style="width:11%;margin-bottom: 10px"><font color="red">*</font>土建图图号:</label>
											<input type="text" class="form-control" id="TJTTH" name="TJTTH" required="required" value="${pd.TJTTH}" style="width:20%;">
											<label style="width:11%;margin-bottom: 10px"></font>单价:</label>
											<input type="text" class="form-control" id="DNP9300_DANJIA" name="DNP9300_DANJIA" value="${regelevStandardPd.PRICE}" style="width:20%;" readonly="readonly">
                                        </div>
                                        <div class="form-group form-inline">
                                        	<label style="width:11%;margin-bottom: 10px">佣金使用折扣率:</label>
											<input style="width:20%;margin-bottom: 10px" type="text" class="form-control" name="YJSYZKL" id="YJSYZKL" readonly="readonly" value="${pd.YJSYZKL}">
                                        </div>
                                        <div class="form-group form-inline">
                                            <table class="table table-striped table-bordered table-hover" id="tab" name="tab">
                                                <tr bgcolor="#CCCCCC">
                                                    <th>基价</th>
                                                    <th>选项加价</th>
                                                    <th>折前价</th>
                                                    <th>非标价</th>
                                                    <th>其他费用</th>
                                                    <th>佣金总额</th>
                                                    <!-- <th>是否超标</th> -->
                                                    <th>折扣率(%)</th>
                                                    <th>草签实际单价</th>
                                                    <th>设备实际总价</th>
                                                    <!-- <th>比例(%)</th> -->
                                                    <th>安装费</th>
                                                    <th>运输费</th>
                                                    <th>总报价</th>
                                                </tr>
                                                <tr>
                                                    <!-- 基价 -->
                                                    <td>
                                                      <%-- <input type="text" style='width:50px;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px ' name="FEISHANG_SBJ" id="FEISHANG_SBJ" value="${regelevStandardPd.PRICE}"> --%>
                                                      <input type="text" style="width:100%;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px" 
                                                          name="SBJ_TEMP" id="SBJ_TEMP" readonly="readonly" value="${regelevStandardPd.PRICE*pd.DNP9300_SL}">
                                                    </td>
                                                    <!-- 选项加价 -->
                                                    <td><input type="text" style="width:100%;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px"
                                                         name="XS_XXJJ" id="XS_XXJJ" readonly="readonly" value="${pd.XS_XXJJ}"></td>
                                                    <!-- 折前价 -->
                                                    <td><input type="text" style="width:100%;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px"
                                                         name="XS_ZQJ" id="XS_ZQJ" readonly="readonly" value="${pd.XS_ZQJ}"></td>
                                                    <!-- 非标价 -->
                                                    <td><input type="text" style="width:100%;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px"
                                                         name="XS_FBJ" id="XS_FBJ" readonly="readonly" value="${pd.XS_FBJ}">
                                                    </td>
                                                    <!-- 其他费用 -->
                                                    <td><input type="text" style="width:100%;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px;background-color:yellow;"
                                                         name="XS_QTFY" onkeyup="value=value.replace(/[^\-?\d.]/g,'')" id="XS_QTFY" value="${pd.XS_QTFY}">
                                                    </td>
                                                    <!-- 佣金总额 -->
                                                    <td><input type="text" style="width:100%;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px;background-color:yellow;"
                                                         name="XS_YJZE" onkeyup="value=value.replace(/[^\-?\d.]/g,'')" id="XS_YJZE" value="${pd.XS_YJZE}">
                                                    </td>
                                                    <!-- 是否超标 -->
                                                    <input type="hidden" style="width:45px;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px"
                                                         name="XS_SFCB" id="XS_SFCB" value="${pd.XS_SFCB}" readonly="readonly">
                                                    <%-- <td><input type="text" style="width:45px;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px"
                                                         name="XS_SFCB" id="XS_SFCB" value="${pd.XS_SFCB}" readonly="readonly">
                                                    </td> --%>
                                                    <!-- 折扣率 -->
                                                    <td><input type="text" style="width:100%;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px"
                                                         name="XS_ZKL" id="XS_ZKL" value="${pd.XS_ZKL}" readonly="readonly">
                                                    </td>
                                                    <!-- 草签实际单价 -->
                                                    <td><input type="text" style="width:100%;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px;background-color:yellow; "
                                                     name="XS_CQSJDJ" id="XS_CQSJDJ" onkeyup="JS_SJBJ();" value="${pd.XS_CQSJDJ}"></td>
                                                    <!-- 设备实际报价 -->
                                                    <td><input type="text" style="width:100%;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px"
                                                         name="XS_SBSJBJ" id="XS_SBSJBJ" readonly="readonly" value="${pd.XS_SBSJBJ}"></td>
                                                    <!-- 比例 -->
                                                    <input type="hidden" style="width:45px;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px"
                                                         name="XS_YJBL" id="XS_YJBL" value="${pd.XS_YJBL}" readonly="readonly">
                                                    <%-- <td><input type="text" style="width:45px;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px"
                                                         name="XS_YJBL" id="XS_YJBL" value="${pd.XS_YJBL}" readonly="readonly">
                                                    </td> --%>
                                                    <!-- 安装费 -->
                                                    <td><input type="text" style="width:100%;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px"
                                                         name="XS_AZJ" id="XS_AZJ" value="${pd.XS_AZJ}" readonly="readonly">
                                                    </td>
                                                    <!-- 运输费 -->
                                                    <td><input type="text" style="width:50px;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px"
                                                         name="XS_YSJ" id="XS_YSJ" value="${pd.XS_YSJ}" readonly="readonly">
                                                    </td>
                                                    <!-- 总报价 -->
                                                    <td><input type="text" style="width:75px;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px"
                                                         name="XS_TATOL" id="XS_TATOL" value="${pd.XS_TATOL}" readonly="readonly">
                                                    </td>
                                                    
                                                    <input type="hidden" name="DNP9300_ZHJ" id="DNP9300_ZHJ" value="${pd.DNP9300_ZHJ}">
                                                    <input type="hidden" name="DNP9300_SBJ" id="DNP9300_SBJ" value="${regelevStandardPd.PRICE}">
                                                    <%-- <input type="hidden" name="SBJ_TEMP" id="SBJ_TEMP" value="${regelevStandardPd.PRICE}"> --%>
                                                    <span id="zk_">${pd.DNP9300_ZK}</span>
                                                    <input type="hidden" name="DNP9300_ZHSBJ" id="DNP9300_ZHSBJ" value="${pd.DNP9300_ZHSBJ}">
                                                    <input type="hidden" name="DNP9300_AZF" id="DNP9300_AZF" value="${pd.DNP9300_AZF}" />
                                                    <input type="hidden" name="DNP9300_YSF" id="DNP9300_YSF" value="${pd.DNP9300_YSF}">
                                                    <input type="hidden" name="DNP9300_SJBJ" id="DNP9300_SJBJ" value="${pd.DNP9300_SJBJ}">
                                                </tr>
                                            </table>
                                        </div>

                                        <div class="form-group form-inline">
                                            <ul class="nav nav-tabs">
                                                <li class="active"><a data-toggle="tab" href="#tab-1" class="active">基本参数</a></li> 
                                                <li class=""><a data-toggle="tab" href="#tab-2">部件参数</a></li>
                                                <li class=""><a data-toggle="tab" href="#tab-3">标准功能</a></li>
                                                <li class=""><a data-toggle="tab" href="#tab-4">选配功能</a></li>
                                                <li class=""><a data-toggle="tab" href="#tab-5">环境配置</a></li>
                                                <li class=""><a data-toggle="tab" href="#tab-9">非标</a></li>
                                            </ul>
                                            <div class="tab-content">
                                                <div id="tab-1" class="tab-pane">
                                                    <!-- 基本参数 -->
                                                        <table class="table table-striped table-bordered table-hover" border="1">
                                                          
                                                          <tr>
                                                            <td colspan="2">1.水平跨距(DBE)</td>
                                                            <td>
                                                            	<input type="text" name="BASE_SPKJ" id="BASE_SPKJ" class="form-control" value="${pd.BASE_SPKJ}">mm
                                                            </td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">2.电源-三相电压/照明电压/频率</td>
                                                            <td><input type="hidden" name="BASE_DY" id="BASE_DY" value="380±5%V/220±10%V/50±2%Hz">380±5%V/220±10%V/50±2%Hz</td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">3.安装环境</td>
                                                            <td>
                                                                <select name="BASE_AZHJ" id="BASE_AZHJ" onchange="setCZ(1);editBase('BASE_AZHJ');" class="form-control">
                                                                  <option value="">请选择</option>
                                                                  <option value="室内" ${pd.BASE_AZHJ==null||pd.BASE_AZHJ=='室内'?'selected':''}>室内</option>
                                                                  <option value="半室外配置A" ${pd.BASE_AZHJ=='半室外配置A'?'selected':''}>半室外配置A</option>
                                                                  <option value="半室外配置B" ${pd.BASE_AZHJ=='半室外配置B'?'selected':''}>半室外配置B</option>
                                                                  <option value="全室外配置C" ${pd.BASE_AZHJ=='全室外配置C'?'selected':''}>全室外配置C</option>
                                                                  <option value="全室外配置D" ${pd.BASE_AZHJ=='全室外配置D'?'selected':''}>全室外配置D</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="BASE_AZHJ_TEMP" id="BASE_AZHJ_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td width="117" rowspan="2">8.扶手装置</td>
                                                            <td width="197">扶手类型</td>
                                                            <td>
                                                                <select name="BASE_FSLX" id="BASE_FSLX" class="form-control">
                                                                  <option value="">请选择</option>
                                                                  <option value="苗条型玻璃扶手" ${pd.BASE_FSLX==null||pd.BASE_FSLX=='苗条型玻璃扶手'?'selected':''}>苗条型玻璃扶手</option>
                                                                </select>
                                                            </td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td>扶手高度</td>
                                                            <td>
                                                                <select name="BASE_FSGD" id="BASE_FSGD" onchange="editBase('BASE_FSGD');" class="form-control">
                                                                  <option value="">请选择</option>
                                                                  <option value="900" ${pd.BASE_FSGD==null||pd.BASE_FSGD=='900'?'selected':''}>900</option>
                                                                  <option value="1000" ${pd.BASE_FSGD=='1000'?'selected':''}>1000</option>
                                                                </select>mm
                                                            </td>
                                                            <td><input type="text" name="BASE_FSGD_TEMP" id="BASE_FSGD_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">4.中间支撑数量[水平跨距DBE&gt;15m时至少一个]</td>
                                                            <td>
                                                                <select name="BASE_ZJZCSL" id="BASE_ZJZCSL" onchange="editBase('BASE_ZJZCSL');" class="form-control">
                                                                  <option value="">请选择</option>
                                                                  <option value="0" ${pd.BASE_ZJZCSL==null||pd.BASE_ZJZCSL=='0'?'selected':''}>0个</option>
                                                                  <option value="1" ${pd.BASE_ZJZCSL=='1'?'selected':''}>1个</option>
                                                                  <option value="2" ${pd.BASE_ZJZCSL=='2'?'selected':''}>2个</option>
                                                                  <option value="3" ${pd.BASE_ZJZCSL=='3'?'selected':''}>3个</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="BASE_ZJZCSL_TEMP" id="BASE_ZJZCSL_TEMP" class="form-control"  readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">5.布置形式</td>
                                                            <td>
                                                                <select name="BASE_BZXS" id="BASE_BZXS" class="form-control">
                                                                  <option value="">请选择</option>
                                                                  <option value="单梯" ${pd.BASE_BZXS==null||pd.BASE_BZXS=='单梯'?'selected':''}>单梯</option>
                                                                  <option value="交叉" ${pd.BASE_BZXS=='交叉'?'selected':''}>交叉</option>
                                                                  <option value="连续" ${pd.BASE_BZXS=='连续'?'selected':''}>连续</option>
                                                                  <option value="平行" ${pd.BASE_BZXS=='平行'?'selected':''}>平行</option>
                                                                  <option value="根据土建图" ${pd.BASE_BZXS=='根据土建图'?'selected':''}>根据土建图</option>
                                                                </select>
                                                            </td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">6.运输方式/交货形态(分段数)</td>
                                                            <td>
                                                                <select name="BASE_YSFS" id="BASE_YSFS" class="form-control">
                                                                  <option value="">请选择</option>
                                                                  <option value="卡车" ${pd.BASE_YSFS==null||pd.BASE_YSFS=='卡车'?'selected':''}>卡车</option>
                                                                </select>
                                                                /
                                                                <select name="BASE_JHXT" id="BASE_JHXT" onchange="editBase('BASE_JHXT');" class="form-control">
                                                                  <option value="">请选择</option>
                                                                  <option value="整梯" ${pd.BASE_JHXT==null||pd.BASE_JHXT=='整梯'?'selected':''}>整梯</option>
                                                                  <option value="分2段" ${pd.BASE_JHXT=='分2段'?'selected':''}>分2段</option>
                                                                  <option value="分3段" ${pd.BASE_JHXT=='分3段'?'selected':''}>分3段</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="BASE_JHXT_TEMP" id="BASE_JHXT_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td rowspan="2">7.土建尺寸</td>
                                                            <td><p>上端加长(0~1000mm)[A-600时必须加长417]</p>    </td>
                                                            <td>
                                                                <input type="text" name="BASE_SDJC" id="BASE_SDJC" onkeyup="editBase('BASE_SDJC');" class="form-control" value="${pd.BASE_SDJC}"/>mm
                                                            </td>
                                                            <td><input type="text" name="BASE_SDJC_TEMP" id="BASE_SDJC_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>下端加长(0~1000mm)</td>
                                                            <td>
                                                                <input type="text" name="BASE_XDJC" id="BASE_XDJC" onkeyup="editBase('BASE_XDJC');" class="form-control" value="${pd.BASE_XDJC}"/>mm
                                                            </td>
                                                            <td><input type="text" name="BASE_XDJC_TEMP" id="BASE_XDJC_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                        </table>
                                                    <!-- 基本参数 -->
                                                </div>
                                                <div id="tab-2" class="tab-pane">
                                                    <!-- 部件参数 -->
                                                        <table class="table table-striped table-bordered table-hover" border="1" cellspacing="0">
                                                          <tr>
                                                            <td width="355">1.减速机</td>
                                                            <td width="280">
                                                                <select name="PART_JSJ" id="PART_JSJ" class="form-control"> 
                                                                    <option value="">请选择</option>
                                                                    <option value="涡轮蜗杆" ${pd.PART_JSJ==null||pd.PART_JSJ=='涡轮蜗杆'?'selected':''}>涡轮蜗杆</option>
                                                                </select>
                                                            </td>
                                                            <td width="130">&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td>2.梯级-梯级类型/颜色[自然色仅用于铝梯级]</td>
                                                            <td>
                                                                <select name="PART_TJLX" id="PART_TJLX" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="不锈钢梯级" ${pd.PART_TJLX=='不锈钢梯级'?'selected':''}>不锈钢梯级</option>
                                                                    <option value="铝合金梯级" ${pd.PART_TJLX==null||pd.PART_TJLX=='铝合金梯级'?'selected':''}>铝合金梯级</option>
                                                                </select>/
                                                                <select name="PART_TJYS" id="PART_TJYS" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="自然色" ${pd.PART_TJYS==null||pd.PART_TJYS=='自然色'?'selected':''}>自然色</option>
                                                                    <option value="银灰色" ${pd.PART_TJYS=='银灰色'?'selected':''}>银灰色</option>
                                                                    <option value="黑色" ${pd.PART_TJYS=='黑色'?'selected':''}>黑色</option>
                                                                </select>   
                                                            </td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td>3.梯级-梯级中分线[仅用于铝合金梯级]</td>
                                                            <td>
                                                                <input type="checkbox" value="1" name="PART_TJZFX" id="PART_TJZFX" ${pd.PART_TJZFX=="1"?"checked='checked'":""} />   </td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td>4.梯级-梯级边框材质</td>
                                                            <td>
                                                                <select name="PART_TJBKCZ" id="PART_TJBKCZ" class="form-control">
                                                                    <option value="三边黄色喷漆警戒线-铝合金梯级"${pd.PART_TJBKCZ==null||pd.PART_TJBKCZ=='三边黄色喷漆警戒线-铝合金梯级'?'selected':''}>三边黄色喷漆警戒线-铝合金梯级</option>
                                                                    <option value="三边黄色塑料边框-不锈钢梯级"${pd.PART_TJBKCZ=='三边黄色塑料边框-不锈钢梯级'?'selected':''}>三边黄色塑料边框-不锈钢梯级</option>
                                                                </select>
                                                            </td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td>5.扶手导轨材质</td>
                                                            <td>
                                                                <select name="PART_FSDGCZ" id="PART_FSDGCZ" onchange="editPart('PART_FSDGCZ');" class="form-control">
                                                                  <option value="">请选择</option>
                                                                  <option value="发纹不锈钢" ${pd.PART_FSDGCZ==null||pd.PART_FSDGCZ=='发纹不锈钢'?'selected':''}>发纹不锈钢</option>
                                                                  <option value="发纹不锈钢SUS304" ${pd.PART_FSDGCZ=='发纹不锈钢SUS304'?'selected':''}>发纹不锈钢SUS304</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="PART_FSDGCZ_TEMP" id="PART_FSDGCZ_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>6.扶手带规格/颜色</td>
                                                            <td>
                                                                <select name="PART_FSDGG" id="PART_FSDGG" class="form-control">
                                                                  <option value="">请选择</option>
                                                                  <option value="国内品牌" ${pd.PART_FSDGG==null||pd.PART_FSDGG=='国内品牌'?'selected':''}>国内品牌</option>
                                                                  <option value="外资品牌" ${pd.PART_FSDGG=='外资品牌'?'selected':''}>外资品牌</option>
                                                                </select>
                                                                / 
                                                                <select name="PART_FSDYS" id="PART_FSDYS" onchange="editPart('PART_FSDYS');" class="form-control">
                                                                  <option value="">请选择</option>
                                                                  <option value="黑色" ${pd.PART_FSDYS==null||pd.PART_FSDYS=='黑色'?'selected':''}>黑色</option>
                                                                  <option value="红色" ${pd.PART_FSDYS=='红色'?'selected':''}>红色</option>
                                                                  <option value="蓝色" ${pd.PART_FSDYS=='蓝色'?'selected':''}>蓝色</option>
                                                                </select> 
                                                            </td>
                                                            <td><input type="text" name="PART_FSDYS_TEMP" id="PART_FSDYS_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>7.围裙版材质</td>
                                                            <td>
                                                                <select name="PART_WQBCZ" id="PART_WQBCZ" onchange="editPart('PART_WQBCZ');" class="form-control">
                                                                  <option value="">请选择</option>
                                                                  <option value="发纹不锈钢" ${pd.PART_WQBCZ==null||pd.PART_WQBCZ=='发纹不锈钢'?'selected':''}>发纹不锈钢</option>
                                                                    <option value="发纹不锈钢SUS430" ${pd.PART_WQBCZ=='发纹不锈钢SUS430'?'selected':''}>发纹不锈钢SUS430</option>
                                                                  <option value="发纹不锈钢SUS304" ${pd.PART_WQBCZ=='发纹不锈钢SUS304'?'selected':''}>发纹不锈钢SUS304</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="PART_WQBCZ_TEMP" id="PART_WQBCZ_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>8.内外盖板材质</td>
                                                            <td>
                                                                <select name="PART_NWGBCZ" id="PART_NWGBCZ" onchange="editPart('PART_NWGBCZ');" class="form-control">
                                                                  <option value="">请选择</option>
                                                                  <option value="发纹不锈钢" ${pd.PART_NWGBCZ==null||pd.PART_NWGBCZ=='发纹不锈钢'?'selected':''}>发纹不锈钢</option>
                                                                  <option value="发纹不锈钢SUS430" ${pd.PART_NWGBCZ=='发纹不锈钢SUS430'?'selected':''}>发纹不锈钢SUS430</option>
                                                                  <option value="发纹不锈钢SUS304" ${pd.PART_NWGBCZ=='发纹不锈钢SUS304'?'selected':''}>发纹不锈钢SUS304</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="PART_NWGBCZ_TEMP" id="PART_NWGBCZ_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>9.梳齿踏板及活动盖板</td>
                                                            <td>
                                                                <select name="PART_SCTBJHDGB" id="PART_SCTBJHDGB" onchange="editPart('PART_SCTBJHDGB');" class="form-control">
                                                                  <option value="">请选择</option>
                                                                  <option value="压纹不锈钢,方形花纹" ${pd.PART_SCTBJHDGB==null||pd.PART_SCTBJHDGB=='压纹不锈钢,方形花纹'?'selected':''}>压纹不锈钢,方形花纹</option>
                                                                  <option value="压纹不锈钢,矩形花纹" ${pd.PART_SCTBJHDGB=='压纹不锈钢,矩形花纹'?'selected':''}>压纹不锈钢,矩形花纹</option>
                                                                  <option value="铝合金防滑条纹" ${pd.PART_SCTBJHDGB=='铝合金防滑条纹'?'selected':''}>铝合金防滑条纹</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="PART_SCTBJHDGB_TEMP" id="PART_SCTBJHDGB_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>10.梳齿板</td>
                                                            <td>
                                                                <select name="PART_SCB" id="PART_SCB" onchange="editPart('PART_SCB');" class="form-control">
                                                                  <option value="">请选择</option>
                                                                  <option value="PVC黄色" ${pd.PART_SCB==null||pd.PART_SCB=='PVC黄色'?'selected':''}>PVC黄色</option>
                                                                  <option value="铝合金自然色" ${pd.PART_SCB=='铝合金自然色'?'selected':''}>铝合金自然色</option>
                                                                  <option value="铝合金黄色" ${pd.PART_SCB=='铝合金黄色'?'selected':''}>铝合金黄色</option>
                                                                </select>   
                                                            </td>
                                                            <td><input type="text" name="PART_SCB_TEMP" id="PART_SCB_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>11.启动方式</td>
                                                            <td>
                                                                <select name="PART_QDFS" id="PART_QDFS" onchange="editPart('PART_QDFS');" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="Y-△,正常运行" ${pd.PART_QDFS=='Y-△,正常运行'?'selected':''}>Y-△,正常运行</option>
                                                                    <option value="变频,快、慢节能运行" ${pd.PART_QDFS==null||pd.PART_QDFS=='变频,快、慢节能运行'?'selected':''}>变频,快、慢节能运行</option>
                                                                    <option value="变频,快、慢、停节能运行" ${pd.PART_QDFS=='变频,快、慢、停节能运行'?'selected':''}>变频,快、慢、停节能运行</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="PART_QDFS_TEMP" id="PART_QDFS_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                        </table>
                                                    <!-- 部件参数 -->
                                                </div>
                                                <div id="tab-3" class="tab-pane">
                                                    <!-- 标准功能 -->
                                                    <table class="table table-striped table-bordered table-hover" border="1" cellspacing="0">
                                                        <tr>
                                                            <td>1.急停按钮</td>
                                                            <td>2.钥匙开关</td>
                                                            <td>3.扶手进出口保护开关</td>
                                                            <td>4.梯级链断链保护开关</td>
                                                        </tr>
                                                        <tr>
                                                            <td>5.梯级下陷保护</td>
                                                            <td>6.缺相及错相保护</td>
                                                            <td>7.电机护罩保护</td>
                                                            <td>8.机房护板</td>
                                                        </tr>
                                                        <tr>
                                                            <td>9.电机过载保护</td>
                                                            <td>10.电机过热保护</td>
                                                            <td>11.梳齿保护开关</td>
                                                            <td>12.维修锁定装置</td>
                                                        </tr>
                                                        <tr>
                                                            <td>13.启动警铃</td>
                                                            <td>14.防逆转保护</td>
                                                            <td>15.扶手带防静电轮</td>
                                                            <td>16.工作制动器监控开关</td>
                                                        </tr>
                                                        <tr>
                                                            <td>17.踏板防静电刷</td>
                                                            <td>18.驱动链断链保护</td>
                                                            <td>19.手动检修插座</td>
                                                            <td>20.手动盘车装置</td>
                                                        </tr>
                                                        <tr>
                                                            <td>21.盖板检修开关</td>
                                                            <td>22.围裙毛刷</td>
                                                            <td>23.扶手带速度监控</td>
                                                            <td>24.梯级遗失保护</td>
                                                        </tr>
                                                        <tr>
                                                            <td>25.梯级超速保护</td>
                                                            <td>26.制动距离超限报警</td>
                                                            <td>27.故障显示<span style="color:red;">[控制柜上]</span></td>
                                                            <td>28.梯级间隙照明</td>
                                                        </tr>
                                                        <tr>
                                                            <td>29.上下机房踏板</td>
                                                            <td>30.附加制动器<span style="color:red;">[仅H&gt;6m时为标配]</span></td>
                                                            <td>31.检修手柄</td>
                                                            <td>32.检修行灯</td>
                                                        </tr>
                                                        <tr>
                                                            <td>33.围裙安全装置</td>
                                                            <td>34.扶手带断带保护(电子式)</td>
                                                            <td>35.电缆分段连接器</td>
                                                            <td></td>
                                                        </tr>
                                                    </table>
                                                    <!-- 标准功能 -->
                                                </div>
                                                <div id="tab-4" class="tab-pane">
                                                    <!-- 选配功能 -->
                                                        <table class="table table-striped table-bordered table-hover" border="1" cellspacing="0">
                                                          <tr>
                                                            <td colspan="2">1.安全制动器[提升高度&gt;6m必选]</td>
                                                            <td width="335">
                                                                <input type="checkbox" name="OPT_AQZDQ_TEXT" id="OPT_AQZDQ_TEXT" onclick="editOpt('OPT_AQZDQ');"  ${pd.OPT_ANZDQ=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_ANZDQ" id="OPT_ANZDQ">
                                                            </td>
                                                            <td width="36"><input type="text" name="OPT_AQZDQ_TEMP" id="OPT_AQZDQ_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">2.5个干触点<span style="color: #FF0000">(请非标询价)</span></td>
                                                            <td><input type="checkbox" name="OPT_GCD_TEXT" id="OPT_GCD_TEXT" onclick="editOpt('OPT_GCD');"  ${pd.OPT_GCD=='1'?'checked':''} readonly="readonly"/>
                                                                <input type="hidden" name="OPT_GCD" id="OPT_GCD">
                                                            </td>
                                                            <td><input type="text" name="OPT_GCD_TEMP" id="OPT_GCD_TEMP" class="form-control" readonly="readonly" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">3.故障显示[在外盖板上]</td>
                                                            <td><input type="checkbox" name="OPT_GZXS_TEXT" id="OPT_GZXS_TEXT" onclick="editOpt('OPT_GZXS');"  ${pd.OPT_GZXS=='1'?'checked':''}/>
                                                            <input type="hidden" name="OPT_GZXS" id="OPT_GZXS">
                                                            </td>
                                                            <td><input type="text" name="OPT_GZXS_TEMP" id="OPT_GZXS_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">4.交通流向灯[自启动时为必选]</td>
                                                            <td><input type="checkbox" name="OPT_JTLXD_TEXT" id="OPT_JTLXD_TEXT" onclick="editOpt('OPT_JTLXD');" ${pd.OPT_JTLXD=='1'?'checked':''} />
                                                            <input type="hidden" name="OPT_JTLXD" id="OPT_JTLXD">
                                                            </td>
                                                            <td><input type="text" name="OPT_JTLXD_TEMP" id="OPT_JTLXD_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">5.制动器磨损监控<span style="color: #FF0000">(请非标询价)</span></td>
                                                            <td><input type="checkbox" name="OPT_ZDQMSJK_TEXT" id="OPT_ZDQMSJK_TEXT" onclick="editOpt('OPT_ZDQMSJK');" ${pd.OPT_ZDQMSJK=='1'?'checked':''}  readonly="readonly"/>
                                                                <input type="hidden" name="OPT_ZDQMSJK" id="OPT_ZDQMSJK">
                                                            </td>
                                                            <td><input type="text" name="OPT_ZDQMSJK_TEMP" id="OPT_ZDQMSJK_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">6.自动加油</td>
                                                            <td><input type="checkbox" name="OPT_ZDJY_TEXT" id="OPT_ZDJY_TEXT" onclick="editOpt('OPT_ZDJY');"  ${pd.OPT_ZDJY=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_ZDJY" id="OPT_ZDJY">
                                                            </td>
                                                            <td><input type="text" name="OPT_ZDJY_TEMP" id="OPT_ZDJY_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">7.驱动链链罩</td>
                                                            <td><input type="checkbox" name="OPT_QDLLZ_TEXT" id="OPT_QDLLZ_TEXT" onclick="editOpt('OPT_QDLLZ');"  ${pd.OPT_QDLLZ=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_QDLLZ" id="OPT_QDLLZ">
                                                            </td>
                                                            <td><input type="text" name="OPT_QDLLZ_TEMP" id="OPT_QDLLZ_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">8.LED围裙照明</td>
                                                            <td><input type="checkbox" name="OPT_LEDWQZM_TEXT" id="OPT_LEDWQZM_TEXT" onclick="editOpt('OPT_LEDWQZM');" ${pd.OPT_LEDWQZM=='1'?'checked':''} />
                                                            <input type="hidden" name="OPT_LEDWQZM" id="OPT_LEDWQZM">
                                                            </td>
                                                            <td><input type="text" name="OPT_LEDWQZM_TEMP" id="OPT_LEDWQZM_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">9.梯级防跳保护</td>
                                                            <td><input type="checkbox" name="OPT_TJFTBH_TEXT" id="OPT_TJFTBH_TEXT" onclick="editOpt('OPT_TJFTBH');"  ${pd.OPT_TJFTBH=='1'?'checked':''}/>
                                                            <input type="hidden" name="OPT_TJFTBH" id="OPT_TJFTBH">
                                                            </td>
                                                            <td><input type="text" name="OPT_TJFTBH_TEMP" id="OPT_TJFTBH_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">10.围裙安全装置</td>
                                                            <td><input type="checkbox" name="OPT_WQAQZZ_TEXT" id="OPT_WQAQZZ_TEXT" onclick="editOpt('OPT_WQAQZZ');"  ${pd.OPT_WQAQZZ=='1'?'checked':''} readonly="readonly"/>
                                                            <input type="hidden" name="OPT_WQAQZZ" id="OPT_WQAQZZ">
                                                            </td>
                                                            <td><input type="text" name="OPT_WQAQZZ_TEMP" id="OPT_WQAQZZ_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">11.扶手带断带保护装置</td>
                                                            <td><input type="checkbox" name="OPT_FSDDDBHZZ_TEXT" id="OPT_FSDDDBHZZ_TEXT" onclick="editOpt('OPT_FSDDDBHZZ');" ${pd.OPT_FSDDDBHZZ=='1'?'checked':''} />
                                                            <input type="hidden" name="OPT_FSDDDBHZZ" id="OPT_FSDDDBHZZ">
                                                            </td>
                                                            <td><input type="text" name="OPT_FSDDDBHZZ_TEMP" id="OPT_FSDDDBHZZ_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">12.中段围裙间隙开关</td>
                                                            <td><input type="checkbox" name="OPT_ZDWQJXKG_TEXT" id="OPT_ZDWQJXKG_TEXT" onclick="editOpt('OPT_ZDWQJXKG');"  ${pd.OPT_ZDWQJXKG=='1'?'checked':''}/>
                                                            <input type="hidden" name="OPT_ZDWQJXKG" id="OPT_ZDWQJXKG">
                                                            </td>
                                                            <td><input type="text" name="OPT_ZDWQJXKG_TEMP" id="OPT_ZDWQJXKG_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">13.梳齿照明</td>
                                                            <td><input type="checkbox" name="OPT_SCZM_TEXT" id="OPT_SCZM_TEXT" onclick="editOpt('OPT_SCZM');" ${pd.OPT_SCZM=='1'?'checked':''} />
                                                            <input type="hidden" name="OPT_SCZM" id="OPT_SCZM">
                                                            </td>
                                                            <td><input type="text" name="OPT_SCZM_TEMP" id="OPT_SCZM_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">14.扶手照明<span style="color: #FF0000">(请非标询价)</span></td>
                                                            <td><input type="checkbox" name="OPT_FSZM_TEXT" id="OPT_FSZM_TEXT" onclick="editOpt('OPT_FSZM');" ${pd.OPT_FSZM=='1'?'checked':''}  readonly="readonly"/>
                                                            <input type="hidden" name="OPT_FSZM" id="OPT_FSZM">
                                                            </td>
                                                            <td><input type="text" name="OPT_FSZM_TEMP" id="OPT_FSZM_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">15.电缆分段连接器[桁架分段时选用]</td>
                                                            <td><input type="checkbox" name="OPT_DLFDLJQ_TEXT" id="OPT_DLFDLJQ_TEXT" onclick="editOpt('OPT_DLFDLJQ');"  ${pd.OPT_DLFDLJQ=='1'?'checked':''} readonly="readonly"/>
                                                            <input type="hidden" name="OPT_DLFDLJQ" id="OPT_DLFDLJQ">
                                                            </td>
                                                            <td><input type="text" name="OPT_DLFDLJQ_TEMP" id="OPT_DLFDLJQ_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">16.油水分离器[户外是必选]</td>
                                                            <td><input type="checkbox" name="OPT_YSFLQ_TEXT" id="OPT_YSFLQ_TEXT" onclick="editOpt('OPT_YSFLQ');"  ${pd.OPT_YSFLQ=='1'?'checked':''}/>
                                                            <input type="hidden" name="OPT_YSFLQ" id="OPT_YSFLQ">
                                                            </td>
                                                            <td><input type="text" name="OPT_YSFLQ_TEMP" id="OPT_YSFLQ_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">17.防洪保护[户外是必选]</td>
                                                            <td><input type="checkbox" name="OPT_FHBH_TEXT" id="OPT_FHBH_TEXT" onclick="editOpt('OPT_FHBH');"  ${pd.OPT_FHBH=='1'?'checked':''}/>
                                                            <input type="hidden" name="OPT_FHBH" id="OPT_FHBH">
                                                            </td>
                                                            <td><input type="text" name="OPT_FHBH_TEMP" id="OPT_FHBH_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">18.梯级链防护罩[户外是必选]</td>
                                                            <td><input type="checkbox" name="OPT_TJLFHZ_TEXT" id="OPT_TJLFHZ_TEXT" onclick="editOpt('OPT_TJLFHZ');"  ${pd.OPT_TJLFHZ=='1'?'checked':''}/>
                                                            <input type="hidden" name="OPT_TJLFHZ" id="OPT_TJLFHZ">
                                                            </td>
                                                            <td><input type="text" name="OPT_TJLFHZ_TEMP" id="OPT_TJLFHZ_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                              <td width="110" rowspan="3">19.外装饰<br><span style="color: #FF0000">(请非标询价)</span></td>
                                                            <td width="218">外装饰位置[桁架分段时选用]</td>
                                                            <td>
                                                                <input type="checkbox" name="OPT_WZSWZ_TEXT" value="左侧" onclick="editOpt('OPT_WZSWZ');" ${fn:indexOf(pd.OPT_WZSWZ, '左侧') != -1?'checked':'' } />左侧
                                                                <input type="checkbox" name="OPT_WZSWZ_TEXT" value="右侧" onclick="editOpt('OPT_WZSWZ');"  ${fn:indexOf(pd.OPT_WZSWZ, '右侧') != -1?'checked':'' }/>右侧
                                                                <input type="checkbox" name="OPT_WZSWZ_TEXT" value="底侧" onclick="editOpt('OPT_WZSWZ');"  ${fn:indexOf(pd.OPT_WZSWZ, '底侧') != -1?'checked':'' }/>底侧
                                                                <input type="hidden" name="OPT_WZSWZ" id="OPT_WZSWZ">
                                                            </td>
                                                            <td><input type="text" name="OPT_WZSWZ_TEMP" id="OPT_WZSWZ_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>装饰板材料</td>
                                                            <td>
                                                                <select name="OPT_ZSBCL" id="OPT_ZSBCL" onchange="editOpt('OPT_ZSBCL');" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="钢板" ${pd.OPT_ZSBCL=='钢板'?'selected':''}>钢板</option>
                                                                    <option value="发纹不锈钢" ${pd.OPT_ZSBCL=='发纹不锈钢'?'selected':''}>发纹不锈钢</option>
                                                                    <option value="发纹不锈钢SUS304" ${pd.OPT_ZSBCL=='发纹不锈钢SUS304'?'selected':''}>发纹不锈钢SUS304</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="OPT_ZSBCL_TEMP" id="OPT_ZSBCL_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>装饰板厚度</td>
                                                            <td>
                                                                <select name="OPT_ZSBHD" id="OPT_ZSBHD" onchange="editOpt('OPT_ZSBHD');" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="0.8" ${pd.OPT_ZSBHD=='0.8'?'selected':''}>0.8</option>
                                                                    <option value="1.0" ${pd.OPT_ZSBHD=='1.0'?'selected':''}>1.0</option>
                                                                    <option value="1.2" ${pd.OPT_ZSBHD=='1.2'?'selected':''}>1.2</option>
                                                                </select>
                                                            </td>
                                                            <td><input type="text" name="OPT_ZSBHD_TEMP" id="OPT_ZSBHD_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">20.维修护栏</td>
                                                            <td>
                                                                <input type="text" name="OPT_WXHL" id="OPT_WXHL" onkeyup="editOpt('OPT_WXHL');" class="form-control" value="${pd.OPT_WXHL}">套
                                                            </td>
                                                            <td><input type="text" name="OPT_WXHL_TEMP" id="OPT_WXHL_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">21.吊装钢丝绳</td>
                                                            <td>
                                                                <input type="checkbox" name="OPT_DZGSS_TEXT" id="OPT_DZGSS_TEXT" onclick="editOpt('OPT_DZGSS');"  ${pd.OPT_DZGSS=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_DZGSS" id="OPT_DZGSS">
                                                            </td>
                                                            <td><input type="text" name="OPT_DZGSS_TEMP" id="OPT_DZGSS_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">22.防爬装置</td>
                                                            <td><input type="checkbox" name="OPT_FPZZ_TEXT" id="OPT_FPZZ_TEXT" onclick="editOpt('OPT_FPZZ');"  ${pd.OPT_FPZZ=='1'?'checked':''}/>
                                                            <input type="hidden" name="OPT_FPZZ" id="OPT_FPZZ">
                                                            </td>
                                                            <td><input type="text" name="OPT_FPZZ_TEMP" id="OPT_FPZZ_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr style="display: none">
                                                            <td colspan="2">23.桁架分段段数</td>
                                                            <td>
                                                            <input type="text" name="OPT_HJFDDS" id="OPT_HJFDDS" onkeyup="editOpt('OPT_HJFDDS');" class="form-control" value="${pd.OPT_HJFDDS==null?'1':pd.OPT_HJFDDS}">
                                                            </td>
                                                            <td><input type="text" name="OPT_HJFDDS_TEMP" id="OPT_HJFDDS_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">23.桁架加热<span style="color: #FF0000">&nbsp;&nbsp;(请非标询价)</span></td>
                                                            <td><input type="checkbox" name="OPT_HJJR_TEXT" id="OPT_HJJR_TEXT" onclick="editOpt('OPT_HJJR');"  ${pd.OPT_HJJR=='1'?'checked':''}/>
                                                            <input type="hidden" name="OPT_HJJR" id="OPT_HJJR">
                                                            </td>
                                                            <td><input type="text" name="OPT_HJJR_TEMP" id="OPT_HJJR_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">24.梳齿加热<span style="color: #FF0000">&nbsp;&nbsp;(请非标询价)</span></td>
                                                            <td><input type="checkbox" name="OPT_SCJR_TEXT" id="OPT_SCJR_TEXT" ${pd.OPT_SCJR=='1'?'checked':''} />
                                                            <input type="hidden" name="OPT_SCJR" id="OPT_SCJR">
                                                            </td>
                                                            <td><input type="text" name="OPT_SCJR_TEMP" id="OPT_SCJR_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">25.扶手加热<span style="color: #FF0000">&nbsp;&nbsp;(请非标询价)</span></td>
                                                            <td><input type="checkbox" name="OPT_FSJR_TEXT" id="OPT_FSJR_TEXT" onclick="editOpt('OPT_FSJR');"  ${pd.OPT_FSJR=='1'?'checked':''}/>
                                                            <input type="hidden" name="OPT_FSJR" id="OPT_FSJR">
                                                            </td>
                                                            <td><input type="text" name="OPT_FSJR_TEMP" id="OPT_FSJR_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                        </table>
                                                    <!-- 选配功能 -->
                                                </div>
                                                <div id="tab-5" class="tab-pane">
                                                    <!-- 环境配置 -->
                                                        <table class="table table-striped table-bordered table-hover" border="1" cellspacing="0">
                                                          <tr>
                                                            <td colspan="2">安装环境类型</td>
                                                            <td width="117">半室外配置A</td>
                                                            <td width="117">半室外配置B</td>
                                                            <td width="117">全室外配置C</td>
                                                            <td width="117">全室外配置D</td>
                                                            <td width="12">&nbsp;</td>
                                                            <td width="17">&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">自动加油</td>
                                                            <td><input type="checkbox" checked="checked" disabled="disabled" /></td>
                                                            <td><input name="checkbox" type="checkbox" checked="checked" disabled="disabled" /></td>
                                                            <td><input name="checkbox2" type="checkbox" checked="checked" disabled="disabled" /></td>
                                                            <td><input name="checkbox3" type="checkbox" checked="checked" disabled="disabled" /></td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">IP55电机</td>
                                                            <td><input name="checkbox7" type="checkbox" checked="checked" disabled="disabled" /></td>
                                                            <td><input name="checkbox6" type="checkbox" checked="checked" disabled="disabled" /></td>
                                                            <td><input name="checkbox5" type="checkbox" checked="checked" disabled="disabled" /></td>
                                                            <td><input name="checkbox4" type="checkbox" checked="checked" disabled="disabled" /></td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">IP54控制系统</td>
                                                            <td><input name="checkbox8" type="checkbox" checked="checked" disabled="disabled" /></td>
                                                            <td><input name="checkbox44" type="checkbox" checked="checked" disabled="disabled" /></td>
                                                            <td><input name="checkbox45" type="checkbox" checked="checked" disabled="disabled" /></td>
                                                            <td><input name="checkbox79" type="checkbox" checked="checked" disabled="disabled" /></td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">活动盖板铝基材</td>
                                                            <td><input name="checkbox9" type="checkbox" checked="checked" disabled="disabled" /></td>
                                                            <td><input name="checkbox43" type="checkbox" checked="checked" disabled="disabled" /></td>
                                                            <td><input name="checkbox46" type="checkbox" checked="checked" disabled="disabled" /></td>
                                                            <td><input name="checkbox78" type="checkbox" checked="checked" disabled="disabled" /></td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">室外型扶手带</td>
                                                            <td><input name="checkbox10" type="checkbox" checked="checked" disabled="disabled" /></td>
                                                            <td><input name="checkbox42" type="checkbox" checked="checked" disabled="disabled" /></td>
                                                            <td><input name="checkbox47" type="checkbox" checked="checked" disabled="disabled" /></td>
                                                            <td><input name="checkbox77" type="checkbox" checked="checked" disabled="disabled" /></td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">内外盖板不锈钢SUS304材质</td>
                                                            <td><input name="checkbox11" type="checkbox" checked="checked" disabled="disabled" /></td>
                                                            <td><input name="checkbox41" type="checkbox" checked="checked" disabled="disabled" /></td>
                                                            <td><input name="checkbox48" type="checkbox" checked="checked" disabled="disabled" /></td>
                                                            <td><input name="checkbox76" type="checkbox" checked="checked" disabled="disabled" /></td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">围裙不锈钢SUS304材质</td>
                                                            <td><input name="checkbox12" type="checkbox" checked="checked" disabled="disabled" /></td>
                                                            <td><input name="checkbox40" type="checkbox" checked="checked" disabled="disabled" /></td>
                                                            <td><input name="checkbox49" type="checkbox" checked="checked" disabled="disabled" /></td>
                                                            <td><input name="checkbox75" type="checkbox" checked="checked" disabled="disabled" /></td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">外装饰板不锈钢SUS304材质(若选择外装饰)</td>
                                                            <td><input name="checkbox13" type="checkbox" checked="checked" disabled="disabled" /></td>
                                                            <td><input name="checkbox39" type="checkbox" checked="checked" disabled="disabled" /></td>
                                                            <td><input name="checkbox50" type="checkbox" checked="checked" disabled="disabled" /></td>
                                                            <td><input name="checkbox74" type="checkbox" checked="checked" disabled="disabled" /></td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">扶手导轨不锈钢SUS304材质</td>
                                                            <td><input name="checkbox14" type="checkbox" checked="checked" disabled="disabled" /></td>
                                                            <td><input name="checkbox38" type="checkbox" checked="checked" disabled="disabled" /></td>
                                                            <td><input name="checkbox51" type="checkbox" checked="checked" disabled="disabled" /></td>
                                                            <td><input name="checkbox73" type="checkbox" checked="checked" disabled="disabled" /></td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td width="202" rowspan="2">金属骨架腐蚀保护</td>
                                                            <td width="198">金属骨架喷三遍油漆</td>
                                                            <td><input name="checkbox15" type="checkbox" checked="checked" disabled="disabled" /></td>
                                                            <td><input name="checkbox37" type="checkbox" checked="checked" disabled="disabled" /></td>
                                                            <td><input name="checkbox52" type="checkbox" disabled="disabled"/></td>
                                                            <td><input name="checkbox72" type="checkbox" disabled="disabled"/></td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td width="198">金属骨架热浸镀锌</td>
                                                            <td><input name="checkbox16" type="checkbox" disabled="disabled"/></td>
                                                            <td><input name="checkbox36" type="checkbox" disabled="disabled"/></td>
                                                            <td><input name="checkbox53" type="checkbox" checked="checked" disabled="disabled" /></td>
                                                            <td><input name="checkbox71" type="checkbox" checked="checked" disabled="disabled" /></td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">导轨系统和主传动轴特殊防锈处理</td>
                                                            <td><input name="checkbox17" type="checkbox" checked="checked" disabled="disabled" /></td>
                                                            <td><input name="checkbox35" type="checkbox" checked="checked" disabled="disabled" /></td>
                                                            <td><input name="checkbox54" type="checkbox" checked="checked" disabled="disabled" /></td>
                                                            <td><input name="checkbox70" type="checkbox" checked="checked" disabled="disabled" /></td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">主要部件螺栓螺母达克罗处理</td>
                                                            <td><input name="checkbox18" type="checkbox"  disabled="disabled"/></td>
                                                            <td><input name="checkbox34" type="checkbox"  disabled="disabled"/></td>
                                                            <td><input name="checkbox55" type="checkbox" checked="checked" disabled="disabled" /></td>
                                                            <td><input name="checkbox69" type="checkbox" checked="checked" disabled="disabled" /></td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2"><p>表面特殊处理梯级轴</p>
                                                            <p>驱动链和梯级链链板表面进行特殊防锈处理</p>
                                                            <p>主副轮双重密封</p></td>
                                                            <td><input name="checkbox19" type="checkbox"  disabled="disabled"/></td>
                                                            <td><input name="checkbox32" type="checkbox"  disabled="disabled"/></td>
                                                            <td><input name="checkbox33" type="checkbox" checked="checked" disabled="disabled" /></td>
                                                            <td><input name="checkbox68" type="checkbox" checked="checked" disabled="disabled" /></td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">油水分离器装置</td>
                                                            <td><input name="checkbox20" type="checkbox"  disabled="disabled"/></td>
                                                            <td><input name="checkbox31" type="checkbox"  disabled="disabled"/></td>
                                                            <td><input name="checkbox56" type="checkbox" checked="checked" disabled="disabled" /></td>
                                                            <td><input name="checkbox67" type="checkbox" checked="checked" disabled="disabled" /></td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">防洪保护</td>
                                                            <td><input name="checkbox21" type="checkbox"  disabled="disabled"/></td>
                                                            <td><input name="checkbox30" type="checkbox"  disabled="disabled"/></td>
                                                            <td><input name="checkbox57" type="checkbox" checked="checked" disabled="disabled" /></td>
                                                            <td><input name="checkbox66" type="checkbox" checked="checked" disabled="disabled" /></td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">梯级链防护罩</td>
                                                            <td><input name="checkbox22" type="checkbox"  disabled="disabled"/></td>
                                                            <td><input name="checkbox29" type="checkbox"  disabled="disabled"/></td>
                                                            <td><input name="checkbox58" type="checkbox" checked="checked" disabled="disabled" /></td>
                                                            <td><input name="checkbox65" type="checkbox" checked="checked" disabled="disabled" /></td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">桁架加热</td>
                                                            <td><input name="checkbox23" type="checkbox"  disabled="disabled"/></td>
                                                            <td><input name="checkbox28" type="checkbox"  disabled="disabled"/></td>
                                                            <td><input name="checkbox59" type="checkbox"  disabled="disabled"/></td>
                                                            <td><input name="checkbox64" type="checkbox"  disabled="disabled"/></td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">梳齿加热</td>
                                                            <td><input name="checkbox24" type="checkbox"  disabled="disabled"/></td>
                                                            <td><input name="checkbox27" type="checkbox"  disabled="disabled"/></td>
                                                            <td><input name="checkbox60" type="checkbox"  disabled="disabled"/></td>
                                                            <td><input name="checkbox63" type="checkbox"  disabled="disabled"/></td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                          <tr>
                                                            <td colspan="2">扶手加热</td>
                                                            <td><input name="checkbox25" type="checkbox"  disabled="disabled"/></td>
                                                            <td><input name="checkbox26" type="checkbox"  disabled="disabled"/></td>
                                                            <td><input name="checkbox61" type="checkbox"  disabled="disabled"/></td>
                                                            <td><input name="checkbox62" type="checkbox"  disabled="disabled"/></td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                          </tr>
                                                        </table>
                                                    <div style="color: red;">
                                                        说明：<br>
                                                        半室外配置A【温度范围：＋4℃～40℃，湿度范围：＜80％，有顶蓬围封，不直接暴露于室外】<br>
                                                        半室外配置B【温度范围：-10℃～40℃，湿度范围：＜80％，有顶蓬围封，不直接暴露于室外】<br>
                                                        全室外配置C【温度范围：＋4℃～40℃，湿度范围：＜80％，直接暴露于室外】<br>
                                                        全室外配置D【温度范围：-10℃～40℃，湿度范围：＜80％，直接暴露于室外】
                                                    </div>
                                                    <!-- 环境配置 -->
                                                </div>
                                                <div id="tab-9" class="tab-pane">
                                                	<input type="hidden" id="OPT_FB_TEMP" class="form-control">
                                                    <!-- 非标 -->
                                                    <%@include file="nonstanard_detail.jsp" %>
                                                    <!-- 非标 -->
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="panel panel-primary">
                                    <div class="panel-heading">
                                        备注
                                    </div>
                                    <div class="panel-body">
                                        <textarea style="width:100%" rows="3" cols="1" name="DT_REMARK">${pd.DT_REMARK}</textarea>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="panel panel-primary">
                                    <div class="panel-heading">
                                        安装价格
                                    </div>
                                    <div class="panel-body">
                                        <table class="table table-striped table-bordered table-hover" border="1" cellspacing="0">
	                                      <!-- 基准价 -->
	                                      <tr>
	                                        <td>安装费（基准价）（元/台）</td>
	                                        <td>
	                                            <input type="text" name="JZJ_DTJZJ" id="JZJ_DTJZJ" class="form-control" readonly="readonly" value="${pd.JZJ_DTJZJ }">
	                                            <input type="hidden" id="initFloor" value="${regelevStandardPd.C}"> 
	                                        </td>
	                                        <td>
	                                        是否设备安装一体合同
	                                        </td>
	                                        <td><input type="checkbox" id="JZJ_IS_YTHT" name="JZJ_IS_YTHT" onclick="changeSSCount()" ${pd.JZJ_IS_YTHT=='1'?'checked':'' }>
	                                        	<input type="hidden" name="JZJ_IS_YTHT_VAL" id="JZJ_IS_YTHT_VAL" value="${pd.JZJ_IS_YTHT}">
	                                        </td>
	                                        <td>单台专用税收补偿（元/台）</td>
	                                        <td>
	                                          <input type="text" name="JZJ_SSBC" id="JZJ_SSBC" class="form-control" readonly="readonly" value="${pd.JZJ_SSBC }">    
	                                        </td>
	                                      </tr>
	                                      <tr>
	                                        <td>单台安装费（最终基准价）（元/台）</td>
	                                        <td>
	                                        	<input type="text" name="JZJ_DTZJ" id="JZJ_DTZJ" class="form-control" readonly="readonly" value="${pd.JZJ_DTZJ }">
	                                        </td>
	                                        <td>总价（元）</td>
	                                        <td >
	                                            <input type="text" name="JZJ_AZF" id="JZJ_AZF" class="form-control"  readonly="readonly" value="${pd.JZJ_AZF }">
	                                        </td>
	                                        <td colspan="2"></td>
	                                      </tr>
	                                      <tr>
	                                      	<td colspan="6"></td>
	                                      </tr>
	                                      <!-- 手填价格 -->
	                                      <tr>
	                                        <td>安装费（元/台）</td>
	                                        <td>
	                                            <input type="text" name="ELE_DTAZF" id="ELE_DTAZF" value="${pd.ELE_DTAZF }" 
	                                            onkeyup="value=value.replace(/[^\-?\d.]/g,'')" oninput="countSDPrice();" class="form-control">
	                                        </td>
	                                        <td>政府验收费（元/台）</td>
	                                        <td><input type="text" id="ELE_ZFYSF" NAME="ELE_ZFYSF"  value="${pd.ELE_ZFYSF }"  
	                                        onkeyup="value=value.replace(/[^\-?\d.]/g,'')" oninput="countSDPrice();" class="form-control"></td>
	                                        <td>免保期超出1年计费（元/台）</td>
	                                        <td>
	                                          <input type="text" name="ELE_MBJF" id="ELE_MBJF" value="${pd.ELE_MBJF }" 
	                                          onkeyup="value=value.replace(/[^\-?\d.]/g,'')" oninput="countSDPrice();" class="form-control">    
	                                        </td>
	                                      </tr>
	                                      <tr>
	                                        <td>合同约定其他费用（元/台）</td>
	                                        <td><input type="text" name="ELE_QTSF" id="ELE_QTSF" value="${pd.ELE_QTSF }"
	                                         onkeyup="value=value.replace(/[^\-?\d.]/g,'')" oninput="countSDPrice();" class="form-control"></td>
	                                        <td>安装总价（元/台）</td>
	                                        <td>
	                                            <input type="text" name="ELE_DTZJ" id="ELE_DTZJ" class="form-control" readonly="readonly" value="${pd.ELE_DTZJ }">
	                                        </td>
	                                        <td>安装总价（元）</td>
	                                        <td>
	                                            <input type="text" name="ELE_AZF" id="ELE_AZF" class="form-control" readonly="readonly" value="${pd.ELE_AZF }">
	                                        </td>
	                                      </tr>
                                            <tr>
                                                <td>备注</td>
                                                <td colspan="3"><input type="text" name="ELE_REMARK" id="ELE_REMARK" value="${pd.ELE_REMARK }"
                                                                        class="form-control"></td>
                                                <td colspan="2">
                                                </td>
                                            </tr>
	                                      <tr>
	                                      	<td colspan="6"></td>
	                                      </tr>
	                                      <!-- 其它价格 -->
	                                       <tr>
	                                        <td>工程类型</td>
	                                        <td>
	                                            <select id="OTHP_GCLX" name="OTHP_GCLX" onchange="changeCJPrice();" class="form-control">
                                                	<option value="买断" ${pd.OTHP_GCLX=='买断'?'selected':'' }>买断</option>
                                                	<option value="厂检" ${pd.OTHP_GCLX=='厂检'?'selected':'' }>厂检</option>
                                                	<option value="验收" ${pd.OTHP_GCLX=='验收'?'selected':'' }>验收</option>
                                            	</select>
	                                        </td>
	                                        <td>厂检费（元）</td>
	                                        <td><input type="text" name="OTHP_CJF" id="OTHP_CJF" class="form-control" readonly="readonly" value="${pd.OTHP_CJF }"> </td>
	                                        <td rowspan="2">调试/厂检总价（元）</td>
	                                        <td rowspan="2">
	                                          <input type="text" name="OTHP_ZJ" id="OTHP_ZJ" class="form-control" readonly="readonly" value="${pd.OTHP_ZJ }">    
	                                        </td>
	                                      </tr>
	                                      <tr>
	                                        <td>调试费</td>
	                                        <td>
	                                        	<input type="checkbox" id="OTHP_ISTSF" name="OTHP_ISTSF"  onclick="changeCJPrice();" ${pd.OTHP_ISTSF=='1'?'checked':'' }> 
	                                        	<input type="hidden" id="OTHP_ISTSF_VAL" name="OTHP_ISTSF_VAL" value="${pd.OTHP_ISTSF }">
	                                        </td>
	                                        <td>调试费（元）</td>
	                                        <td><input type="text" name="OTHP_TSF" id="OTHP_TSF" class="form-control" readonly="readonly" value="${pd.OTHP_TSF }"></td>
	                                      </tr>
	                                      <tr>
	                                      	<td colspan="6"></td>
	                                      </tr>
	                                      <tr>
	                                        <td>总价（元）</td>
	                                        <td >
	                                            <input type="text" name="DNP9300_AZF_TEMP" id="DNP9300_AZF_TEMP" class="form-control" readonly="readonly" value="${pd.FEIYUE_AZF }">
	                                        </td>
	                                        <td colspan="4"></td>
	                                      </tr>
	                                    </table> 
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="panel panel-primary">
                                    <div class="panel-heading">
                                        运输价格
                                    </div>
                                    <div class="panel-body">
                                        <div class="form-group form-inline">
                                            <label>运输方式:</label>
                                            <select id="trans_type" class="form-control m-b" name="trans_type" onchange="hideDiv();">
                                                <option value="1" ${pd.trans_type=="1"?"selected":""}>整车</option>
                                                <option value="2" ${pd.trans_type=="2"?"selected":""}>零担</option>
                                                <option value="3" ${pd.trans_type=="3"?"selected":""}>自提</option>
                                            </select>
                                            <span id="qy">
                                            <label>请选择区域:</label>
                                            <select id="province_id" name="province_id" class="form-control m-b" onchange="setCity();">
                                                <option value="">请选择区域</option>
                                                <c:forEach var="province" items="${provinceList}">
                                                    <option value="${province.id }"${pd.province_id==province.id?"selected":""}>${province.name }</option>
                                                </c:forEach>
                                            </select>

                                            <label>请选择目的地:</label>
                                            <select id="destin_id" name="destin_id" class="form-control m-b">
                                                <option value="">请选择目的地</option>
                                                <c:if test="${not empty cityList}">
                                                    <c:forEach var="city" items="${cityList}">
                                                        <option value="${city.id }" ${pd.destin_id==city.id?"selected":""}>${city.name }</option>
                                                    </c:forEach>
                                                </c:if>
                                            </select>
                                             <span id="ld"  ${pd.trans_type!="2"?"style='display:none;'":""}>
                                            <label>吨数:</label>
                                            <input type="text" id="less_num" name="less_num" class="form-control m-b" value="${pd.less_num}">
                                             </span>
                                            </span>
                                        </div>
                                        </div>
                                        <div class="form-group form-inline" id="zc"  ${pd.trans_type!=null&&pd.trans_type!="1"?"style='display:none;'":""}>
                                            <input type="hidden" name="trans_more_car" id="trans_more_car">
                                            <table id="transTable">
                                                <c:if test="${not empty tmc_list}">
                                                    <c:forEach var="tmc" items="${tmc_list}" varStatus="vs">
                                                        <tr>
                                                            <td>
                                                                <label>&nbsp;&nbsp;&nbsp;车型:&nbsp;</label>
                                                                <select class="form-control m-b"name="car_type">
                                                                    <option value="" ${tmc.car_type==""?"selected":""}>请选择车型</option>
                                                                    <option value="5" ${tmc.car_type=="5"?"selected":""}>5T车(6.2-7.2米)</option>
                                                                    <option value="8" ${tmc.car_type=="8"?"selected":""}>8T车(8.2-9.6米)</option>
                                                                    <option value="10" ${tmc.car_type=="10"?"selected":""}>10T车(12.5米)</option>
                                                                    <option value="20" ${tmc.car_type=="20"?"selected":""}>20T车(17.5米)</option>
                                                                </select>
                                                            </td>
                                                            <td>
                                                                <label>&nbsp;&nbsp;&nbsp;数量:&nbsp;</label>
                                                                <input type="text" class="form-control m-b"name="car_num" value="${tmc.car_num}">
                                                            </td>
                                                            <td>
                                                                <c:if test="${vs.index==0}">
                                                                    <input type="button" value="添加" onclick="addRow();" class="btn-sm btn-success m-b">
                                                                </c:if>
                                                                <c:if test="${vs.index!=0}">
                                                                    <input type="button" value="删除" onclick="delRow(this)" class="btn-sm btn-danger m-b">
                                                                </c:if>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </c:if>
                                                <c:if test="${empty tmc_list}">
                                                    <tr>
                                                        <td>
                                                            <label>&nbsp;&nbsp;&nbsp;车型:&nbsp;</label>
                                                            <select class="form-control m-b"name="car_type">
                                                                <option value="">请选择车型</option>
                                                                <option value="5">5T车(6.2-7.2米)</option>
                                                                <option value="8">8T车(8.2-9.6米)</option>
                                                                <option value="10">10T车(12.5米)</option>
                                                                <option value="20">20T车(17.5米)</option>
                                                            </select>
                                                        </td>
                                                        <td>
                                                            <label>&nbsp;&nbsp;&nbsp;数量:&nbsp;</label>
                                                            <input type="text" class="form-control m-b"name="car_num">
                                                        </td>
                                                        <td>
                                                            <input type="button" value="添加" onclick="addRow();" class="btn-sm btn-success m-b">
                                                        </td>
                                                    </tr>
                                                </c:if>
                                            </table>
                                        </div>
                                        <div class="form-group form-inline">
                                            &nbsp;&nbsp;&nbsp;
                                            <input type="button" value="确定" id="setPriceButton" onclick="setPriceTrans();" class="btn-sm btn-warning m-b">
                                            运输价格(元):
                                            <input type="text" id="trans_price" name="trans_price" class="form-control" oninput="countTransPrice()" value="${pd.XS_YSJ}">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>   
    </div>
    </form>

    <tr>
        <td>
            <c:if test="${forwardMsg!='view'}">
                <a class="btn btn-primary" style="width: 150px; height:34px;float:left;margin:0px 10px 30px 10px;"  onclick="save();">保存</a>
            </c:if>
        </td>
        <td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;margin:0px 10px 30px 10px;" onclick="javascript:CloseSUWin('ElevatorParam');">关闭</a></td>
    </tr>

<script src="static/js/sweetalert/sweetalert.min.js"></script>
<script src="static/js/iCheck/icheck.min.js"></script>
<script type="text/javascript">

    $(document).ready(function(){
        $("#tab-1").addClass("active");
        //加载标准价格,初始化关联选项
        editQxjd();
        $("#BZ_GG").val("${regelevStandardPd.GG}");
        var FLAG = $("#FLAG").val();
        if(FLAG=="CBJ"||FLAG=="ZHJ"){
            cbjPrice();
        }
        if("${pd.view}"=="edit"){
            cbjPrice(1);
        }else if("${pd.view}"==""){
            setInitSetting();

            cbjPrice(1);
        }

        var forwardMsg = "${forwardMsg}";
        if(forwardMsg=='view'){
            //查看页面设置disable
            var inputs = document.getElementsByTagName("input");
            for(var i = 0;i<inputs.length;i++){
                inputs[i].setAttribute("disabled","true");
            }
            var textareas = document.getElementsByTagName("textarea");
            for(var i = 0;i<textareas.length;i++){
                textareas[i].setAttribute("disabled","true");
            }
            var selects = document.getElementsByTagName("select");
            for(var i = 0;i<selects.length;i++){
                selects[i].setAttribute("disabled","true");
            }
        }
        countInstallPrice();
        
        //加载运输模块显示 
        if("${pd.trans_type}"!=null && "${pd.trans_type}"!=""){
        	$("#trans_type").val("${pd.trans_type}");
            hideDiv();
        }else{
        	$("#trans_type").val(1);
        }

        updateFbX();
    });

    //关闭当前页面
    function CloseSUWin(id) {
      window.parent.$("#" + id).data("kendoWindow").close();
    }

    //添加行,录入运输
    function addRow(){
        var tr = $("#transTable tr").eq(0).clone();
        $(tr).find("td").eq(0).find("select").eq(0).val("");
        $(tr).find("td").eq(1).find("input").eq(0).val("");
        $(tr).find("td:last").html("").append("<td><input type='button' value='删除' onclick='delRow(this)' class=\"btn-sm btn-danger m-b\"></td>");
        $("#transTable").append(tr);
    }
    //删除行
    function delRow(obj){
        $(obj).parent().parent().parent().remove();
    }

    function tsgdpd() {
    	if(getValueToFloat("#BZ_TSGD")>6000){
            $('#BZ_QXJD').val("30");
            $('#BZ_QXJD').attr("disabled", "disabled");
        } else {
        	$('#BZ_QXJD').removeAttr("disabled");
        }
	}
    
    //计算基础价
    function setSbj()
    {
    	var sl_ = $("#DNP9300_SL").val()==""?0:parseInt($("#DNP9300_SL").val());
    	var models_name = $("#tz_").val();  //型号名称
    	//var gg_ = $("#BZ_GG").val();  //规格
//     	var gg_ = Math.ceil(getValueToFloat("#BZ_TSGD")/100)/10;
    	var gg_ = getValueToFloat("#BZ_TSGD");  //规格 
        var qxjd_ = $("#BZ_QXJD").val();     //倾斜角度 
        var tjkd_ = $("#BZ_TJKD").val();  //梯级宽度
        var price = 0;
        if(gg_=="3.0")
        {var gg=3;}
        else if(gg_=="4.0")
        {var gg=4;}
        else if(gg_=="5.0")
        {var gg=5;}
        else if(gg_=="6.0")
        {var gg=6;}
        else
        {var gg=gg_;}

        try {
            editPart('PART_FSDGCZ');//扶手导轨材质
            editPart('PART_FSDYS');//扶手带颜色
            editPart('PART_WQBCZ');//围裙版材质
            if(getValueToFloat("#BZ_TSGD")>6000){
                if($("#OPT_AQZDQ_TEXT").is(":checked"))$("#OPT_AQZDQ_TEXT").click();
                $("#OPT_AQZDQ_TEXT").click();
            }else {
                if($("#OPT_AQZDQ_TEXT").is(":checked"))$("#OPT_AQZDQ_TEXT").click();
            }
        }catch (e){

        }
        $.post("<%=basePath%>e_offer/setBascPrice_F",
                {
                    "TSGD": gg,
                    "QXJD": qxjd_,
                    "TJKD": tjkd_,
                    "NAME": models_name
                },function(result)
                {
                	console.log(result);
                	if(basisDate.fbdj == null){
                		if(result.msg=="success")
                        {
                        	try{
                        		console.log(result.pd.PRICE*sl_);
                        	    $("#SBJ_TEMP").val(result.pd.PRICE*sl_);
                            }catch (e){
                                $("#SBJ_TEMP").val("0");
                            }
                            cbjPrice();
                            countZhj();
                        }else {
                            $("#SBJ_TEMP").val("0");
                        }
                	} else {
                		
        				$("#SBJ_TEMP").val(basisDate.fbdj*sl_);
        	            $("#DNP9300_DANJIA").val(basisDate.fbdj);
                        cbjPrice();
                        countZhj();
                	}
                    
                });
    }

    //调用参考报价
    function selCbj(){
        var modelsId = $("#MODELS_ID").val();
        //获取当前数量
        var sl_ = $("#DNP9300_SL").val();
        var item_id = $("#ITEM_ID").val();
        var offer_version = $("#offer_version").val();
        $("#cbjView").kendoWindow({
            width: "1000px",
            height: "600px",
            title: "调用参考报价",
            actions: ["Close"],
            content: "<%=basePath%>e_offer/selCbj.do?models=dnp9300&DNP9300_SL="+sl_+
            	"&item_id="+item_id+"&offer_version="+offer_version,
            modal : true,
            visible : false,
            resizable : true
        }).data("kendoWindow").maximize().open();
    }


    //调用参考价时重新计算
    function cbjPrice(tp){
        //基础项
        editBase('BASE_AZHJ',tp);
        editBase('BASE_FSGD',tp);
        editBase('BASE_ZJZCSL',tp);
        editBase('BASE_SDJC',tp);
        editBase('BASE_XDJC',tp);
        editBase('BASE_JHXT',tp);
        //部件参数
        editPart('PART_FSDGCZ',tp);
        editPart('PART_FSDYS',tp);
        editPart('PART_WQBCZ',tp);
        editPart('PART_NWGBCZ',tp);
        editPart('PART_SCTBJHDGB',tp);
        editPart('PART_SCB',tp);
        editPart('PART_QDFS',tp);
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

    //非标,点击添加行
    function addFbRow(){
        var tr = $("#fbTable tr").eq(1).clone();
        $(tr).find("td").eq(0).find("input").eq(0).val("");
        $(tr).find("td").eq(1).find("input").eq(0).val("");
        $(tr).find("td").eq(2).find("input").eq(0).val("");
        $(tr).find("td:last").html("").append("<td><input type='button' value='删除' onclick='delFbRow(this)'></td>");
        $("#fbTable").append(tr);
    }

    //修改角度时
    function editQxjd(){
        var qxjd_ = $("#BZ_QXJD").val();
        if(qxjd_=="35"){
            var appendStr = "<option value=''>请选择</option><option value='3.0'>3.0</option><option value='3.1'>3.1</option><option value='3.2'>3.2</option><option value='3.3'>3.3</option><option value='3.4'>3.4</option><option value='3.5'>3.5</option><option value='3.6'>3.6</option><option value='3.7'>3.7</option><option value='3.8'>3.8</option><option value='3.9'>3.9</option><option value='4.0'>4.0</option><option value='4.1'>4.1</option><option value='4.2'>4.2</option><option value='4.3'>4.3</option><option value='4.4'>4.4</option><option value='4.5'>4.5</option><option value='4.6'>4.6</option><option value='4.7'>4.7</option><option value='4.8'>4.8</option><option value='4.9'>4.9</option><option value='5.0'>5.0</option><option value='5.1'>5.1</option><option value='5.2'>5.2</option><option value='5.3'>5.3</option><option value='5.4'>5.4</option><option value='5.5'>5.5</option><option value='5.6'>5.6</option><option value='5.7'>5.7</option><option value='5.8'>5.8</option><option value='5.9'>5.9</option><option value='6.0'>6.0</option>";
            $("#BZ_GG").empty();
            $("#BZ_GG").append(appendStr);
        }else if(qxjd_=="30"){
            var appendStr = "<option value=''>请选择</option><option value='3.0'>3.0</option><option value='3.1'>3.1</option><option value='3.2'>3.2</option><option value='3.3'>3.3</option><option value='3.4'>3.4</option><option value='3.5'>3.5</option><option value='3.6'>3.6</option><option value='3.7'>3.7</option><option value='3.8'>3.8</option><option value='3.9'>3.9</option><option value='4.0'>4.0</option><option value='4.1'>4.1</option><option value='4.2'>4.2</option><option value='4.3'>4.3</option><option value='4.4'>4.4</option><option value='4.5'>4.5</option><option value='4.6'>4.6</option><option value='4.7'>4.7</option><option value='4.8'>4.8</option><option value='4.9'>4.9</option><option value='5.0'>5.0</option><option value='5.1'>5.1</option><option value='5.2'>5.2</option><option value='5.3'>5.3</option><option value='5.4'>5.4</option><option value='5.5'>5.5</option><option value='5.6'>5.6</option><option value='5.7'>5.7</option><option value='5.8'>5.8</option><option value='5.9'>5.9</option><option value='6.0'>6.0</option><option value='6.1'>6.1</option><option value='6.2'>6.2</option><option value='6.3'>6.3</option><option value='6.4'>6.4</option><option value='6.5'>6.5</option><option value='6.6'>6.6</option><option value='6.7'>6.7</option><option value='6.8'>6.8</option><option value='6.9'>6.9</option><option value='7.0'>7.0</option><option value='7.1'>7.1</option><option value='7.2'>7.2</option><option value='7.3'>7.3</option><option value='7.4'>7.4</option><option value='7.5'>7.5</option>";
            $("#BZ_GG").empty();
            $("#BZ_GG").append(appendStr);
        }
    }


    function countZhj(){
        var sbj_count = 0;

        var base_azhj_temp = getValueToFloat("#BASE_AZHJ_TEMP");
        var base_fsgd_temp = getValueToFloat("#BASE_FSGD_TEMP");
        var base_zjzcsl_temp = getValueToFloat("#BASE_ZJZCSL_TEMP");
        var base_sdjc_temp =  getValueToFloat("#BASE_SDJC_TEMP");
        var base_xdjc_temp =  getValueToFloat("#BASE_XDJC_TEMP");
        var base_jhxt_temp =  getValueToFloat("#BASE_JHXT_TEMP");

        var part_fsdgcz_temp = $("#PART_FSDGCZ_TEMP").val()==""?0:parseInt($("#PART_FSDGCZ_TEMP").val());
        var part_fsdys_temp = $("#PART_FSDYS_TEMP").val()==""?0:parseInt($("#PART_FSDYS_TEMP").val());
        var part_wqbcz_temp = $("#PART_WQBCZ_TEMP").val()==""?0:parseInt($("#PART_WQBCZ_TEMP").val());
        var part_nwgbcz_temp = $("#PART_NWGBCZ_TEMP").val()==""?0:parseInt($("#PART_NWGBCZ_TEMP").val());
        var part_scb_temp = $("#PART_SCB_TEMP").val()==""?0:parseInt($("#PART_SCB_TEMP").val());
        var part_qdfs_temp = $("#PART_QDFS_TEMP").val()==""?0:parseInt($("#PART_QDFS_TEMP").val());
        var part_sctbjhdgb_temp = getValueToFloat("#PART_SCTBJHDGB_TEMP");

        var opt_aqzdq_temp = $("#OPT_AQZDQ_TEMP").val()==""?0:parseInt($("#OPT_AQZDQ_TEMP").val());
        var opt_jtlxd_temp = $("#OPT_JTLXD_TEMP").val()==""?0:parseInt($("#OPT_JTLXD_TEMP").val());
        var opt_zdjy_temp = $("#OPT_ZDJY_TEMP").val()==""?0:parseInt($("#OPT_ZDJY_TEMP").val());
        var opt_ledwqzm_temp = $("#OPT_LEDWQZM_TEMP").val()==""?0:parseInt($("#OPT_LEDWQZM_TEMP").val());
        var opt_tjftbh_temp = $("#OPT_TJFTBH_TEMP").val()==""?0:parseInt($("#OPT_TJFTBH_TEMP").val());
        var opt_zdwqjxkg_temp = $("#OPT_ZDWQJXKG_TEMP").val()==""?0:parseInt($("#OPT_ZDWQJXKG_TEMP").val());
        var opt_sczm_temp = $("#OPT_SCZM_TEMP").val()==""?0:parseInt($("#OPT_SCZM_TEMP").val());
        var opt_wxhl_temp = $("#OPT_WXHL_TEMP").val()==""?0:parseInt($("#OPT_WXHL_TEMP").val());
        var opt_fpzz_temp = $("#OPT_FPZZ_TEMP").val()==""?0:parseInt($("#OPT_FPZZ_TEMP").val());
        var opt_hjfdds_temp = $("#OPT_HJFDDS_TEMP").val()==""?0:parseInt($("#OPT_HJFDDS_TEMP").val());

        //非标选项加价
        var opt_fb_temp = $("#OPT_FB_TEMP").val()==""?0:parseInt($("#OPT_FB_TEMP").val());
        
        /* $("#DNP9300_ZHJ").val("0"); */


        sbj_count = base_azhj_temp+base_fsgd_temp+base_zjzcsl_temp+base_sdjc_temp+base_xdjc_temp+base_jhxt_temp+
            part_fsdgcz_temp+part_fsdys_temp+part_wqbcz_temp+part_nwgbcz_temp+part_scb_temp+part_qdfs_temp
            +opt_aqzdq_temp+opt_jtlxd_temp+opt_zdjy_temp+opt_ledwqzm_temp+opt_tjftbh_temp+opt_zdwqjxkg_temp+part_sctbjhdgb_temp+
            opt_sczm_temp+opt_wxhl_temp+opt_fpzz_temp+opt_hjfdds_temp+opt_fb_temp;

        if(getTagValue("#BZ_SPTJ")=='3'&&getValueToFloat("#BZ_TSGD")<6000){
            sbj_count+=13500*getEleNum();
        }

        //设备标准价格 (选项加价)
        var sbj_temp = parseInt($("#SBJ_TEMP").val());
        $("#XS_XXJJ").val(sbj_count);
        //折前价 =基价+选项加价 
        $("#XS_ZQJ").val(sbj_count+sbj_temp);

        //运输费
        var dnp9300_ysf = $("#DNP9300_YSF").val()==""?0:parseInt($("#DNP9300_YSF").val());
        $("#DNP9300_YSF").val(dnp9300_ysf);
        //安装费
        var dnp9300_azf = $("#DNP9300_AZF_TEMP").val()==""?0:parseInt($("#DNP9300_AZF_TEMP").val());
        $("#DNP9300_AZF").val(dnp9300_azf);

        var dnp9300_zk = parseFloat($("#DNP9300_ZK").val())/100;
        if(!isNaN(dnp9300_zk)){
            var dnp9300_sbj = parseInt($("#SBJ_TEMP").val());
            var dnp9300_sjbj = (dnp9300_sbj+sbj_count+dnp9300_azf+dnp9300_ysf)*dnp9300_zk;
            var dnp9300_zhsbj = dnp9300_sbj*dnp9300_zk;
            $("#DNP9300_SJBJ").val(dnp9300_sjbj);
            $("#DNP9300_ZHSBJ").val(dnp9300_zhsbj);
            $("#zk_").text($("#DNP9300_ZK").val()+"%");
        }
        countInstallPrice();
    }


    //计算基本参数价格
    function editBase(option,tp)
    {
        var price = 0;
        var elenum=getEleNum();
        if(option=="BASE_AZHJ"){
            //安装环境
            var tsgd_ = parseInt($("#BZ_TSGD").val());
            var azhj_ = $("#BASE_AZHJ").val();//安装环境
            var qxjd_ = $("#BZ_QXJD").val();
            var qxprice=0;
            if(qxjd_==30){
                qxprice=1400;
            }else{
                qxprice=1000;
            }
            if(azhj_=="室内"){
                price = 0;
            }else if(azhj_=="半室外配置A"||azhj_=="半室外配置B"){
                 price = Math.ceil((2500*(tsgd_/1000)+39000-((150*(tsgd_/1000)+9540)+2960+550+(650*(tsgd_/1000)+qxprice))+3950)*elenum);
            }else if(azhj_=="全室外配置C"||azhj_=="全室外配置D"){
                price = Math.ceil((2500*(tsgd_/1000)+39000)*elenum);
            }
            $("#BASE_AZHJ_TEMP").val(price);
            if(tp!=1)setchangOpt();
        }else if(option=="BASE_FSGD"){
            //扶手高度
            var fsgd_ = $("#BASE_FSGD").val();
            if(fsgd_=="900"){
                price = 0;
            }else if(fsgd_=="1000"){
                var tsgd_ = parseInt($("#BZ_TSGD").val());
                price = Math.ceil((65*(tsgd_/1000)+850)*elenum);
            }
            $("#BASE_FSGD_TEMP").val(price);
        }else if(option=="BASE_ZJZCSL"){
            //中间支撑数量
            var zjzcsl_ = $("#BASE_ZJZCSL").val();
            if(zjzcsl_=="0"||zjzcsl_==""){
                price = 0;
            }else{
                price = (parseInt(zjzcsl_)*1370)*elenum;
            }
            $("#BASE_ZJZCSL_TEMP").val(price);
        }else if(option=="BASE_SDJC"){
            //上端加长
            var azhj_ = $("#BASE_AZHJ").val();
            var sdjc_=Math.ceil(getValueToFloat("#BASE_SDJC")/100);
            if(azhj_=="室内"){
                price = Math.ceil(370*sdjc_*elenum);
            }else{
                price = Math.ceil(450*sdjc_*elenum);
            }
            $("#BASE_SDJC_TEMP").val(Math.floor(price));
        }else if(option=="BASE_XDJC"){
            //下端加长
            var azhj_ = $("#BASE_AZHJ").val();

            var xdjc_= getValueToFloat("#BASE_XDJC")/100;
            if(azhj_=="室内"){
                price = Math.ceil(370*xdjc_*elenum);
            }else{
                price = Math.ceil(450*xdjc_*elenum);
            }
            $("#BASE_XDJC_TEMP").val(Math.floor(price));
        }else if(option=="BASE_JHXT"){
            //交货形态
            var jhxt_ = $("#BASE_JHXT").val();
            if(jhxt_=="整梯"){
                price = 0;
            }else if(jhxt_=="分2段"){
                price = 2730*elenum;
            }else if(jhxt_=="分3段"){
                price = 5460*elenum;
            }
            $("#BASE_JHXT_TEMP").val(price);
        }

        //计算价格
        countZhj();
    }

    //计算部件参数价格
    function editPart(option,tp){

        var sl_ = parseInt($("#DNP9300_SL").val());

        var price = 0;
        if(option=="PART_FSDGCZ"){
            //扶手导轨材质
            var qxjd_ = $("#BZ_QXJD").val();
            var tsgd_ = parseInt(getValueToFloat("#BZ_TSGD"));
            var fsdgcz_ = $("#PART_FSDGCZ").val();
            if(fsdgcz_=="发纹不锈钢"){
                price = 0;
            }else if(fsdgcz_=="发纹不锈钢SUS304"){
                if(qxjd_=="30"){
                    price = (180*(tsgd_/1000)+1000)*sl_;
                }else if(qxjd_=="35"){
                    price = (160*(tsgd_/1000)+1000)*sl_;
                }
            }
            $("#PART_FSDGCZ_TEMP").val(price);
        }else if(option=="PART_FSDYS"){
            //扶手带颜色
            var tsgd_ = parseInt($("#BZ_TSGD").val());
            var fsdys_ = $("#PART_FSDYS").val();
            if(fsdys_=="黑色"){
                price = 0;
            }else if(fsdys_=="红色"||fsdys_=="蓝色"){
                price = (250*(tsgd_/1000)+630)*sl_;
            }
            $("#PART_FSDYS_TEMP").val(price);
        }else if(option=="PART_WQBCZ"){
            //围裙版材质
            var qxjd_ = $("#BZ_QXJD").val();
            var tsgd_ = parseInt($("#BZ_TSGD").val());
            var wqbcz_ = $("#PART_WQBCZ").val();
            var azhj_ = $("#BASE_AZHJ").val();
                if(wqbcz_=="发纹不锈钢"){
                    price = 0;
                }else if(wqbcz_=="发纹不锈钢SUS304"){
                    if(azhj_==""||azhj_=="室内"){
                        if(qxjd_=="30"){
                            price = (480*(tsgd_/1000)+1000)*sl_;
                        }else if(qxjd_=="35"){
                            price = (460*(tsgd_/1000)+1000)*sl_;
                        }
                    }else{
                        price=0;
                    }
                }else{
                    price = 0;
                }

            $("#PART_WQBCZ_TEMP").val(price);
        }else if(option=="PART_NWGBCZ"){
            //内外盖板材质
            var qxjd_ = $("#BZ_QXJD").val();
            var tsgd_ = parseInt($("#BZ_TSGD").val());
            var nwgbcz_ = $("#PART_NWGBCZ").val();
            var azhj_ = $("#BASE_AZHJ").val();
                if(nwgbcz_=="发纹不锈钢"){
                    price = 0;
                }else if(nwgbcz_=="发纹不锈钢SUS304"){
                    if(qxjd_=="30"){
                        price = (360*(tsgd_/1000)+1000)*sl_;
                    }else if(qxjd_=="35"){
                        price = (300*(tsgd_/1000)+1000)*sl_;
                    }
                }else {
                    price = 0;
                }
            $("#PART_NWGBCZ_TEMP").val(price);
        }else if(option=="PART_SCTBJHDGB"){
            //梳齿踏板及活动盖板
            var tsgd_ = parseInt($("#BZ_TSGD").val());
            var sctbjhdgb_ = $("#PART_SCTBJHDGB").val();
            var azhj_ = $("#BASE_AZHJ").val();
            if(azhj_=="室内"){
                if(sctbjhdgb_==""){
                    price = 0*sl_;
                }else if(sctbjhdgb_=="铝合金防滑条纹"){
                    price = 8000*sl_;
                }else {
                    price=0;
                }
            }else{
                if(sctbjhdgb_==""){
                    price = 0*sl_;
                }else if(sctbjhdgb_=="铝合金防滑条纹"){
                    price = 8000*sl_;
                }else {
                    price=0;
                }
            }
            $("#PART_SCTBJHDGB_TEMP").val(price);
        }else if(option=="PART_SCB"){
            //梳齿板
            var scb_ = $("#PART_SCB").val();
            if(scb_=="PVC黄色"){
                price = 0;
            }else{
                price = 250*sl_;
            }
            $("#PART_SCB_TEMP").val(price);
        }else if(option=="PART_QDFS"){
            //启动方式
            var qdfs_ = $("#PART_QDFS").val();
            if(qdfs_=="变频,快、慢节能运行"){
                price = 0;
            }else if(qdfs_=="变频,快、慢、停节能运行"){
                price = 4000*sl_;
                if(tp!=1){
                    if($("#OPT_JTLXD_TEXT").is(":checked"))$("#OPT_JTLXD_TEXT").click();
                    $("#OPT_JTLXD_TEXT").click();
                }
            }else if(qdfs_=="Y-△,正常运行"){
                price = -2000*sl_;
            }
            editOpt("OPT_JTLXD");
            $("#PART_QDFS_TEMP").val(price);
        }
        //计算价格
        countZhj();
    }

    //计算选配价格
    function editOpt(option){

        var sl_ = parseInt($("#DNP9300_SL").val());

        if(option=="OPT_AQZDQ"){
            //安全制动器
            if($("#OPT_AQZDQ_TEXT").is(":checked")){
                var tsgd_ = parseInt($("#BZ_TSGD").val());
                var azhj_ = $("#BASE_AZHJ").val();
                if(tsgd_>=6000){
                    price = 0;
                }else{
                    if(azhj_=="室内"){
                        price = 7090*sl_;
                    }else{
                        price = 7630*sl_;
                    }
                }
            }else{
                price = 0;
            }
            $("#OPT_AQZDQ_TEMP").val(price);
        }else if(option=="OPT_JTLXD"){
            //交通流向灯
            if($("#OPT_JTLXD_TEXT").is(":checked")){
                var qdfs_ = $("#PART_QDFS").val();
                if(qdfs_=="变频,快、慢、停节能运行"){
                    price = 0;
                }else{
                    price = 1640*sl_;
                }
            }else{
                price = 0;
            }
            $("#OPT_JTLXD_TEMP").val(price);
        }else if(option=="OPT_ZDJY"){
            //自动加油
            var azhj_ = getTagValue("#BASE_AZHJ");//安装环境

            if($("#OPT_ZDJY_TEXT").is(":checked")){
                if(azhj_=="室内"){
                    price=(2700*sl_);
                }else{
                    price =(0);
                }
            }else{
                if(azhj_=="室内"||azhj_==""){
                    price =(0);
                }else{
                    price =(-2700*sl_);
                }
            }

            $("#OPT_ZDJY_TEMP").val(price);
        }else if(option=="OPT_LEDWQZM"){
            //LED围裙照明
            if($("#OPT_LEDWQZM_TEXT").is(":checked")){
                var tsgd_ = parseInt($("#BZ_TSGD").val());
                price = (1090*(tsgd_/1000)+1150)*sl_;
            }else{
                price = 0;
            }
            $("#OPT_LEDWQZM_TEMP").val(price);
        }else if(option=="OPT_TJFTBH"){
            //梯级防跳保护
            if($("#OPT_TJFTBH_TEXT").is(":checked")){
                price = 500*sl_;
            }else{
                price = 0;
            }
            $("#OPT_TJFTBH_TEMP").val(price);
        }else if(option=="OPT_ZDWQJXKG"){
            //中段围裙间隙开关
            if($("#OPT_ZDWQJXKG_TEXT").is(":checked")){
                price = 1000*sl_;
            }else{
                price = 0;
            }
            $("#OPT_ZDWQJXKG_TEMP").val(price);
        }else if(option=="OPT_SCZM"){
            //梳齿照明
            if($("#OPT_SCZM_TEXT").is(":checked")){
                price = 1750*sl_;
            }else{
                price = 0;
            }
            $("#OPT_SCZM_TEMP").val(price);
        }else if(option=="OPT_WXHL"){
            //维修护栏
            var wxhl_ = getValueToFloat("#OPT_WXHL");
            price = 1370*wxhl_;
            $("#OPT_WXHL_TEMP").val(price);
        }else if(option=="OPT_FPZZ"){
            //防爬装置
            if($("#OPT_FPZZ_TEXT").is(":checked")){
                price = 1260*sl_;
            }else{
                price = 0;
            }
            $("#OPT_FPZZ_TEMP").val(price);
        }else if(option=="OPT_HJFDDS"){
            //桁架分段段数
            var hjfdds_ = getValueToFloat("#OPT_HJFDDS");
            price = (2730*(hjfdds_>0?hjfdds_-1:0))*sl_;
            $("#OPT_HJFDDS_TEMP").val(price);
        }else if(option=="OPT_QDLLZ"){
            //驱动链链罩
            var azhj_ = getTagValue("#BASE_AZHJ");//安装环境

            if($("#OPT_QDLLZ_TEXT").is(":checked")){
                if(azhj_=="室内"){
                    price=(0*sl_);
                }else{
                    price =(0);
                }
            }else{
                if(azhj_=="室内"){
                    price =(0);
                }else{
                    price =(0*sl_);
                }
            }

            $("#OPT_QDLLZ_TEMP").val(price);
        }else if(option=="OPT_YSFLQ"){
            //油水分离器
            var azhj_ = getTagValue("#BASE_AZHJ");//安装环境

            if($("#OPT_YSFLQ_TEXT").is(":checked")){
                if(azhj_=="室内"){
                    price=(2960*sl_);
                }else{
                    price =(0);
                }
            }else{
                if(azhj_=="室内"){
                    price =(0);
                }else if(azhj_=="半室外配置A"||azhj_=="半室外配置B"){
                    price=0;
                }else {
                    price =(-2960*sl_);
                }
            }

            $("#OPT_YSFLQ_TEMP").val(price);
        }else if(option=="OPT_FHBH"){
            //防洪保护
            var azhj_ = getTagValue("#BASE_AZHJ");//安装环境

            if($("#OPT_FHBH_TEXT").is(":checked")){
                if(azhj_=="室内"){
                    price=(550*sl_);
                }else{
                    price =(0);
                }
            }else{
                if(azhj_=="室内"){
                    price =(0);
                }else if(azhj_=="半室外配置A"||azhj_=="半室外配置B"){
                    price=0;
                }else{
                    price =(-550*sl_);
                }
            }

            $("#OPT_FHBH_TEMP").val(price);
        }else if(option=="OPT_TJLFHZ"){
            //梯级链防护罩
            var azhj_ = getTagValue("#BASE_AZHJ");//安装环境

            if($("#OPT_TJLFHZ_TEXT").is(":checked")){
                if(azhj_=="室内"){
                    price=(0*sl_);
                }else{
                    price =(0);
                }
            }else{
                if(azhj_=="室内"){
                    price =(0);
                }else{
                    price =(0*sl_);
                }
            }

            $("#OPT_TJLFHZ_TEMP").val(price);
        }
        //计算价格
        countZhj();
    }


    //--
    //运输价格部分
    //隐藏DIV
    function hideDiv(){
        var trans_type = $("#trans_type").val();
        if(trans_type=="1"){
            $("#ld").hide();
            $("#zc").show();
            $("#qy").show();
            $("#trans_price").attr('disabled',false);
        }else if(trans_type=="2"){
            $("#zc").hide();
            $("#ld").show();
            $("#qy").show();
            $("#trans_price").attr('disabled',false);
        }else if(trans_type=="3"){
            $("#zc").hide();
            $("#ld").hide();
            $("#qy").hide();
            $("#trans_price").val(0);
        	$("#XS_YSJ").val(0);
        	$("#DNP9300_YSF").val(0);
            $("#trans_price").attr('disabled',true);
        }
    }

    //设置城市
    function setCity(){
        var province_id = $("#province_id").val();
        if(province_id==""){
            
        }else{
            $.post("<%=basePath%>e_offer/setCity",
                    {
                        "province_id":province_id
                    },
                    function(data){
                        $("#destin_id").empty();
                        $("#destin_id").append("<option value=''>请选择城市</option>");
                        $.each(data,function(key,value){
                            $("#destin_id").append("<option value='"+value.id+"'>"+value.name+"</option>");
                        });
                    }
                );
        }
    }

    //计算运输价格
    function setPriceTrans(){
        var transType = $("#trans_type").val();
        var province_id = $("#province_id").val();
        var destin_id = $("#destin_id").val();
        if(transType=="1"){//整车
            var zcStr = "[";
            $("#transTable tr").each(function(){
                var carType = $(this).find("td").eq("0").find("select").eq("0").val();
                var num = $(this).find("td").eq("1").find("input").eq("0").val();
                zcStr += "{\'carType\':\'"+carType+"\',\'num\':\'"+num+"\'},"
            });
            zcStr = zcStr.substring(0,zcStr.length-1)+"]";
            $.post("<%=basePath%>e_offer/setPriceTrans",
                    {
                        "zcStr": zcStr,
                        "province_id": province_id,
                        "city_id": destin_id,
                        "transType": transType
                    },
                    function(data){
                        $("#trans_price").val(data.countPrice);
                        var transPrice = parseFloat(data.countPrice);
                        $("#DNP9300_YSF").val(transPrice);
                        $("#XS_YSJ").val(transPrice);
                        countZhj();
                        //计算总报价
                    	jsTatol();
                    }
                );
        }else if(transType=="2"){//零担
            var less_num = $("#less_num").val();
            $.post("<%=basePath%>e_offer/setPriceTrans",
                    {
                        "province_id": province_id,
                        "city_id": destin_id,
                        "transType": transType,
                        "less_num": less_num
                    },
                    function(data){
                        $("#trans_price").val(data.countPrice);
                        var transPrice = parseFloat(data.countPrice);
                        $("#DNP9300_YSF").val(transPrice);
                        $("#XS_YSJ").val(transPrice);
                        countZhj();
                        //计算总报价
                    	jsTatol();
                    }
                );
        }else{
        	countZhj();
            //计算总报价
        	jsTatol();
        }

    }



    function save(){
    	
        if(validateIsInput()){
//         	removeAttrDisabled();
        	var index = layer.load(1);
        	var saveFlag = "1";
        	
			$.ajax({
			    type: 'POST',
			    url: '<%=basePath%>e_offerdt/saveDnp9300.do',
			    data: $("#dnp9300Form").dn2_serialize(getSelectDis())+"&saveFlag="+saveFlag,
			    dataType: "JSON",
			    success: function(data) {
			    	layer.close(index);
			    	if(data.code == 1){
			    		updateId(data);
			    		buildofferButton(data);
			    		buildofferInfo(data);
			    		layer.msg('保存成功', {icon: 1});
			    		CloseSUWin('ElevatorParam');
			    	} else {
			    		layer.msg('保存失败', {icon: 2});
			    	}
			    },
			    error: function(data) {
			    	layer.close(index);
			    	layer.msg('操作失败', {icon: 2});
			    }
			});
        }
    }
    function getFBLXJSON() {
    	return ${fns:getDictListJson('fbtype')};
    }
    
    function validateIsInput() {
    	//new 全文NaN判断
       	var ss = true;
        $("input[type='text']").each(function () {
            if ($(this).val()=="NaN") {
            	$(this).focus();
    			$(this).tips({
    				side : 3,
    				msg : "此项为NaN!请复查!",
    				bg : '#AE81FF',
    				time : 3
    			});
    			ss = false;
                return false;
            }
        })
        if(!ss){
        	return false;
        }
        
        if(!validateRequired()){
        	return false;
        }
        
     	//非标json
        $("#UNSTD").val(getJsonStrfb());
        $("#trans_more_car").val(formatTransJson());
        //设置checkbox选中
        if($("#OPT_AQZDQ_TEXT").is(":checked")){
            $("#OPT_ANZDQ").val("1");
        }else{
            $("#OPT_ANZDQ").val("0");
        }
        if($("#OPT_GCD_TEXT").is(":checked")){
            $("#OPT_GCD").val("1");
        }else{
            $("#OPT_GCD").val("0");
        }
        if($("#OPT_GZXS_TEXT").is(":checked")){
            $("#OPT_GZXS").val("1");
        }else{
            $("#OPT_GZXS").val("0");
        }
        if($("#OPT_JTLXD_TEXT").is(":checked")){
            $("#OPT_JTLXD").val("1");
        }else{
            $("#OPT_JTLXD").val("0");
        }
        if($("#OPT_ZDQMSJK_TEXT").is(":checked")){
            $("#OPT_ZDQMSJK").val("1");
        }else{
            $("#OPT_ZDQMSJK").val("0");
        }
        if($("#OPT_ZDJY_TEXT").is(":checked")){
            $("#OPT_ZDJY").val("1");
        }else{
            $("#OPT_ZDJY").val("0");
        }
        if($("#OPT_QDLLZ_TEXT").is(":checked")){
            $("#OPT_QDLLZ").val("1");
        }else{
            $("#OPT_QDLLZ").val("0");
        }
        if($("#OPT_LEDWQZM_TEXT").is(":checked")){
            $("#OPT_LEDWQZM").val("1");
        }else{
            $("#OPT_LEDWQZM").val("0");
        }
        if($("#OPT_TJFTBH_TEXT").is(":checked")){
            $("#OPT_TJFTBH").val("1");
        }else{
            $("#OPT_TJFTBH").val("0");
        }
        if($("#OPT_WQAQZZ_TEXT").is(":checked")){
            $("#OPT_WQAQZZ").val("1");
        }else{
            $("#OPT_WQAQZZ").val("0");
        }
        if($("#OPT_FSDDDBHZZ_TEXT").is(":checked")){
            $("#OPT_FSDDDBHZZ").val("1");
        }else{
            $("#OPT_FSDDDBHZZ").val("0");
        }
        if($("#OPT_ZDWQJXKG_TEXT").is(":checked")){
            $("#OPT_ZDWQJXKG").val("1");
        }else{
            $("#OPT_ZDWQJXKG").val("0");
        }
        if($("#OPT_SCZM_TEXT").is(":checked")){
            $("#OPT_SCZM").val("1");
        }else{
            $("#OPT_SCZM").val("0");
        }
        if($("#OPT_FSZM_TEXT").is(":checked")){
            $("#OPT_FSZM").val("1");
        }else{
            $("#OPT_FSZM").val("0");
        }
        if($("#OPT_DLFDLJQ_TEXT").is(":checked")){
            $("#OPT_DLFDLJQ").val("1");
        }else{
            $("#OPT_DLFDLJQ").val("0");
        }
        if($("#OPT_YSFLQ_TEXT").is(":checked")){
            $("#OPT_YSFLQ").val("1");
        }else{
            $("#OPT_YSFLQ").val("0");
        }
        if($("#OPT_FHBH_TEXT").is(":checked")){
            $("#OPT_FHBH").val("1");
        }else{
            $("#OPT_FHBH").val("0");
        }
        if($("#OPT_TJLFHZ_TEXT").is(":checked")){
            $("#OPT_TJLFHZ").val("1");
        }else{
            $("#OPT_TJLFHZ").val("0");
        }
        if($("#OPT_DZGSS_TEXT").is(":checked")){
            $("#OPT_DZGSS").val("1");
        }else{
            $("#OPT_DZGSS").val("0");
        }
        if($("#OPT_FPZZ_TEXT").is(":checked")){
            $("#OPT_FPZZ").val("1");
        }else{
            $("#OPT_FPZZ").val("0");
        }
        if($("#OPT_HJJR_TEXT").is(":checked")){
            $("#OPT_HJJR").val("1");
        }else{
            $("#OPT_HJJR").val("0");
        }
        if($("#OPT_SCJR_TEXT").is(":checked")){
            $("#OPT_SCJR").val("1");
        }else{
            $("#OPT_SCJR").val("0");
        }
        if($("#OPT_FSJR_TEXT").is(":checked")){
            $("#OPT_FSJR").val("1");
        }else{
            $("#OPT_FSJR").val("0");
        }
        
        $("#OPT_WZSWZ").val(getCheckboxValues("[name='OPT_WZSWZ_TEXT']"));
        //$("#OPT_WZSWZ").val($("[name='OPT_WZSWZ_TEXT']:checked").eq(0).val()==undefined?'':$("[name='OPT_WZSWZ_TEXT']:checked").val());
        
        return true;
    }
    
    function saveOfAjax() {
    	if(validateIsInput()){
           var index = layer.load(1);
			$.ajax({
			    type: 'POST',
			    url: '<%=basePath%>e_offerdt/${msg}.do',
			    data: $("#dnp9300Form").dn2_serialize(getSelectDis()),
			    dataType: "JSON",
			    success: function(data) {
			    	layer.close(index);
			    	if(data.code == 1){
			    		updateId(data);
			    		buildofferButton(data);
			    		buildofferInfo(data);
			    		layer.msg('保存成功', {icon: 1});
			    	} else {
			    		layer.msg('保存失败', {icon: 2});
			    	}
			    },
			    error: function(data) {
			    	layer.close(index);
			    	layer.msg('操作失败', {icon: 2});
			    }
			});
    		
    	}
	}
    
    function updateId(data) {
		if($('#view').val() == 'save' && data){
			$('#view').val('edit');
			$('#DNP9300_ID').val(data.dtCodId);
			$('#BJC_ID').val(data.bjc_id);
		}
	}
    
    /**
    * 非标添加基价时更新单价
    **/
    function updateDANJIA(dj) {
    	if(isNaN(dj)){
    		dj = 0;
    	}
    	var sl_ = $("#DNP9300_SL").val()==""?0:parseInt($("#DNP9300_SL").val());
    	//setTimeout(function(){
			basisDate.fbdj = dj;
			$("#SBJ_TEMP").val(dj*sl_);
	        $("#DNP9300_DANJIA").val(dj);
            cbjPrice();
            countZhj();
	    //},500);
	}
    
   /**
    * 非标删除基价时更新单价
    **/
    function updateDANJIAOfDelete() {
    	basisDate.fbdj = null;
    	setSbj();
 	}
    
  //计算设备实际报价
    function JS_SJBJ()
    {
    	var ShuiLv;//税率
	    $.post("<%=basePath%>e_offer/getShuiLv",
                {
                    "id":"1"
                },function(result)
                {
                    if(result.msg=="success")
                    {
                    	ShuiLv=result.pd.content;
                    	
                    	//草签实际单价
                    	var cqsjdj=getValueToFloat("#XS_CQSJDJ");
                    	//数量
                    	var sl=getValueToFloat("#DNP9300_SL");
                    	//赋值给设备实际报价
                    	$("#XS_SBSJBJ").val(cqsjdj*sl);
                    	
                    	//计算折扣并赋值
                    	var zkl;
                    	var qtfy=getValueToFloat("#XS_QTFY")*ShuiLv;//其他费用
                    	var yjze=getValueToFloat("#XS_YJZE")*ShuiLv;//佣金总额
                    	var sjbj=getValueToFloat("#XS_SBSJBJ");//设备实际报价
                    	var fbj=getValueToFloat("#XS_FBJ");//非标价
                    	var jj=parseInt(getValueToFloat("#SBJ_TEMP"));//基价
                    	var xxjj=parseInt(getValueToFloat("#XS_XXJJ"));//选项加价
                    	var qtfya=getValueToFloat("#XS_QTFY");
                    	var a=sjbj-fbj-qtfy-yjze;
                    	var b=jj+xxjj;
                    	zkl=a/b;
                    	$("#XS_ZKL").val((zkl*100).toFixed(1));
                    	
                    	//计算佣金比例并赋值
                    	var yjbl;
                    	/* var c=sjbj-fbj-qtfy;
                    	yjbl=c/b;
                    	$("#XS_YJBL").val((yjbl*100).toFixed(1)); */
                    	yjbl=$("#XS_YJZE").val()/(sjbj/ShuiLv);
                    	$("#XS_YJBL").val((yjbl*100).toFixed(1));

                    	//计算佣金使用折扣率和最高佣金
                    	var yjsyzkl;
                    	var ZGYJ;
                    	var ZGYJA;
                    	// (实际报价-非标费-其他费用*1.16)/(基价+选项)
                    	var c=sjbj-fbj-(qtfya*ShuiLv);
                    	//alert(sjbj+'-'+fbj+'-('+qtfya+'*'+ShuiLv+')'+'/'+b);
                    	yjsyzkl=c/b;
                    	$("#YJSYZKL").val((yjsyzkl*100).toFixed(1));
                    	
                    	var yjsyzkla = $("#YJSYZKL").val()==""?0:parseInt($("#YJSYZKL").val());
                    	if(yjsyzkla<=65){
                    		ZGYJ=sjbj*0.04/ShuiLv;
                    		$("#ZGYJ").val((ZGYJ).toFixed(1));
                    	}else if(yjsyzkla>65 && yjsyzkla<=70){
                    		ZGYJ=sjbj*0.05/ShuiLv;
                    		$("#ZGYJ").val((ZGYJ).toFixed(1));
                    	}else if(yjsyzkla>70 && yjsyzkla<=75){
                    		ZGYJ=sjbj*0.06/ShuiLv;
                    		$("#ZGYJ").val((ZGYJ).toFixed(1));
                    	}else if(yjsyzkla>75){
                    		//((实际报价*6%)/1.16 +( (实际报价-非标-其他费用*1.16-(基价+选项)*85%)*50%)/1.16
                    		ZGYJ=((sjbj*0.06)/ShuiLv+(sjbj-fbj-(qtfya*ShuiLv)-b*0.85)*0.5)/ShuiLv;
                    		$("#ZGYJ").val((ZGYJ).toFixed(1));
                    	}
                    	
                    	
                    	//判断佣金是否超标并赋值
                    	if(zkl*100<=65)
                    	{
                    		var q=(sjbj*0.4)/ShuiLv;
                    		if(yjze>q)
                    		{
                    			$("#XS_SFCB").val("Y");
                    		}else{$("#XS_SFCB").val("N");}
                    	}
                    	else if(66<=zkl*100<=70)
                    	{
                    		var q=(sjbj*0.5)/ShuiLv;
                    		if(yjze>q)
                    		{
                    			$("#XS_SFCB").val("Y");
                    		}else{$("#XS_SFCB").val("N");}
                    	}
                    	else if(71<=zkl*100<=75)
                    	{
                    		var q=(sjbj*0.6)/ShuiLv;
                    		if(yjze>q)
                    		{
                    			$("#XS_SFCB").val("Y");
                    		}else{$("#XS_SFCB").val("N");}
                    	}
                    	else if(zkl*100>75)
                    	{
                    		var q=(sjbj*0.6)/ShuiLv;
                    		var w=(jj+xxjj)*0.85;
                    		var e=sjbj-fbj-qtfy;
                    		var r=(q+(e-w)*0.5)/ShuiLv;
                    		if(yjze>r)
                    		{
                    			$("#XS_SFCB").val("Y");
                    		}else{$("#XS_SFCB").val("N");}
                    	}
                    	//计算总报价
                    	jsTatol();
                    	
                    	
                    }
                    else
                    {
                    	alert("存在异常，请联系管理员！");
                    }
                    
                });
	  
	  
    	
    }
  
    //计算总报价
    function jsTatol()
    {
    	//计算总报价
    	var sbsjzj_=parseInt(getValueToFloat("#XS_SBSJBJ"));//设备实际总价
    	var qtfy_=parseInt(getValueToFloat("#XS_QTFY"));//其他费用
    	var azf_=parseInt(getValueToFloat("#XS_AZJ"));//安装费
    	var ysf_=parseInt(getValueToFloat("#XS_YSJ"));//运输费
    	var fbj_=parseInt(getValueToFloat("#XS_FBJ"));//非标价格
    	if(isNaN(ysf_))
    	{
    		ysf_=0;
    	}
    	else if(isNaN(azf_))
    	{
    		azf_=0;
    	}
    	else if(isNaN(qtfy_))
    	{
    		qtfy_=0;
    	} 
    	$("#XS_TATOL").val(sbsjzj_+qtfy_+azf_+ysf_+fbj_);
    }
</script>
</body>

</html>
