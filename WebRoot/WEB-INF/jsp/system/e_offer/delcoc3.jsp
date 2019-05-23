<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	<link href="static/css/select2/select2.min.css" rel="stylesheet">
    <style type="text/css">
        .ztree li span.button.add {
            margin-left: 2px;
            margin-right: -1px;
            background-position: -144px 0;
            vertical-align: top;
            *vertical-align: middle
        }
    </style>
    <!-- jsp文件头和头部 -->
    <%@ include file="../../system/admin/top.jsp"%> 
    <!-- 日期控件-->
    <script src="static/js/layer/laydate/laydate.js"></script>
	<script src="static/js/select2/select2.min.js"></script>
    <script src="static/js/installioncount.js"></script>
    <script type="text/javascript">
    var basePath="<%=basePath%>";
    var itemelecount="${itemelecount}";
    var sl_ = "${pd.HOUSEHOLD_SL}";
    var ele_type="${modelsPd.ele_type}";
    var basisDate = {
        'fbdj': null
    }
    </script>
</head>

<body class="gray-bg">
    <div id="cbjView" class="animated fadeIn"></div>
    <div id="zhjView" class="animated fadeIn"></div>
    <form action="e_offer/${msg}.do" name="HouseholdForm" id="HouseholdForm" method="post">
    <input type="hidden" name="ele_type" id="ele_type" value="${modelsPd.ele_type}">
    <input type="hidden" name="offer_version" id="offer_version" value="${pd.offer_version}">
    <input type="hidden" name="view" id="view" value="${pd.view}">
    <input type="hidden" name="BJC_ID" id="BJC_ID" value="${pd.BJC_ID}">
    <input type="hidden" name="DELCOC3_ID" id="DELCOC3_ID" value="${pd.DELCOC3_ID}">
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
                                <div class="form-group form-inline">
                                    <div class="panel-heading" style="background-color: #1AB394;">
                                        <font color="white">报价信息</font>
                                        <c:if test="${forwardMsg!='view'}">
<!--                                             <input type="button" value="装潢价格" onclick="selZhj();" class="btn-sm btn-success"> -->
                                            <input type="button" value="调用参考报价" onclick="selCbj();" class="btn-sm btn-success">
                                        </c:if>
                                    </div>
                                    
                                    	<table class="table" style="width: 100%;border-width: 0px;">
                                    		<tr>
                                    			<td style="width: 25%;"><label style="width: 40%;">梯种</label>
                                    				<input style="width:50%;" class="form-control" id="tz_" type="text"
	                                                   name="tz_" value="${modelsPd.models_name }" readonly="readonly"
	                                                   required="required">
                                    			</td>
                                    			<td style="width: 25%;"><label style="width: 40%;"><font color="red">*</font>载重</label>
                                    				<c:if test="${modelsPd.ele_type=='DT12'}">
	                                    				<select style="width: 50%;" class="form-control" id="BZ_ZZ" name="BZ_ZZ" onchange="editZz(this)" required="required">
			                                                <option value="">请选择</option>
			                                                <option value="320" ${pd.BZ_ZZ=='320'?'selected':''}>320</option>
			                                                <option value="400" ${pd.BZ_ZZ=='400'?'selected':''}>400</option>
			                                                <option value="450" ${pd.BZ_ZZ=='450'?'selected':''}>450</option>
			                                            </select>
		                                            </c:if>
		                                            <c:if test="${modelsPd.ele_type=='DT11'}">
	                                    				<select style="width: 50%;" class="form-control" id="BZ_ZZ" name="BZ_ZZ" onchange="editZz(this)" required="required">
			                                                <option value="">请选择</option>
			                                                <option value="260" ${pd.BZ_ZZ=='260'?'selected':''}>260</option>
			                                                <option value="320" ${pd.BZ_ZZ=='320'?'selected':''}>320</option>
			                                                <option value="400" ${pd.BZ_ZZ=='400'?'selected':''}>400</option>
			                                            </select>
		                                            </c:if>
                                    			</td>
                                    			<td style="width: 25%;"><label style="width: 40%;"><font color="red">*</font>速度</label>
                                    				<c:if test="${modelsPd.ele_type=='DT12'}">
		                                   				<select style="width: 50%;" class="form-control" id="BZ_SD" name="BZ_SD" onchange="editSd();" required="required">
			                                                <option value="">请选择</option>
			                                                <option value="0.4" ${pd.BZ_SD=='0.4'?'selected':''}>0.4</option>
			                                                <option value="0.5" ${pd.BZ_SD=='0.5'?'selected':''}>0.5</option>
			                                                <option value="1.0" ${pd.BZ_SD=='1.0'?'selected':''}>1.0</option>
			                                            </select>
		                                            </c:if>
		                                            <c:if test="${modelsPd.ele_type=='DT11'}">
		                                   				<select style="width: 50%;" class="form-control" id="BZ_SD" name="BZ_SD" onchange="editSd();" required="required">
			                                                <option value="">请选择</option>
			                                                <option value="0.2" ${pd.BZ_SD=='0.2'?'selected':''}>0.2</option>
			                                                <option value="0.3" ${pd.BZ_SD=='0.3'?'selected':''}>0.3</option>
			                                            </select>
		                                            </c:if>
                                    			</td>
                                    			<td style="width: 65%;"><label style="width: 25%;"><font color="red">*</font>层站门</label>
                                    				<c:if test="${modelsPd.ele_type=='DT12'}">
	                                    				<select class="form-control" style="width:20%" name="BZ_C" id="BZ_C" onchange="editC();$('#ELE_C').html(this.value);$('#BZ_Z').change();$('#BZ_M').change()">
			                                                <option value="">请选择</option>
			                                                <option value="2">2</option>
			                                                <option value="3">3</option>
			                                                <option value="4">4</option>
			                                                <option value="5">5</option>
			                                                <option value="6">6</option>
			                                                <option value="7">7</option>
			                                                <option value="8">8</option>
			                                            </select>
			                                            <select class="form-control" style="width:20%" name="BZ_Z" id="BZ_Z" onchange="setSbj();$('#ELE_Z').html(this.value)">
			                                                <option value="">请选择</option>
			                                                <option value="2">2</option>
			                                                <option value="3">3</option>
			                                                <option value="4">4</option>
			                                                <option value="5">5</option>
			                                                <option value="6">6</option>
			                                                <option value="7">7</option>
			                                                <option value="8">8</option>
			                                            </select>
			                                            <select class="form-control" style="width:20%" name="BZ_M" id="BZ_M" onchange="setMPrice();$('#ELE_M').html(this.value)">
			                                                <option value="">请选择</option>
			                                                <option value="2">2</option>
			                                                <option value="3">3</option>
			                                                <option value="4">4</option>
			                                                <option value="5">5</option>
			                                                <option value="6">6</option>
			                                                <option value="7">7</option>
			                                                <option value="8">8</option>
			                                            </select>
		                                            </c:if>
		                                            <c:if test="${modelsPd.ele_type=='DT11'}">
		                                            	<select class="form-control" style="width:20%" name="BZ_C" id="BZ_C" onchange="editC();$('#ELE_C').html(this.value);$('#BZ_Z').change();$('#BZ_M').change()">
			                                                <option value="">请选择</option>
			                                                <option value="2">2</option>
			                                                <option value="3">3</option>
			                                                <option value="4">4</option>
			                                            </select>
			                                            <select class="form-control" style="width:20%" name="BZ_Z" id="BZ_Z" onchange="setSbj();$('#ELE_Z').html(this.value)">
			                                                <option value="">请选择</option>
			                                                <option value="2">2</option>
			                                                <option value="3">3</option>
			                                                <option value="4">4</option>
			                                            </select>
			                                            <select class="form-control" style="width:20%" name="BZ_M" id="BZ_M" onchange="setMPrice();$('#ELE_M').html(this.value)">
			                                                <option value="">请选择</option>
			                                                <option value="2">2</option>
			                                                <option value="3">3</option>
			                                                <option value="4">4</option>
			                                            </select>
		                                            </c:if>
                                    			</td>
                                    		</tr>
                                    		<tr>
                                    			<td style="width: 25%;"><label style="width: 40%;">数量</label>
                                    				<input type="text" class="form-control" id="HOUSEHOLD_SL" name="HOUSEHOLD_SL"
                                                   value="${pd.HOUSEHOLD_SL}" readonly="readonly" style="width:50%;">
                                           		<input type="hidden" class="form-control" id="DT_SL" name="DT_SL"
                                                   value="${pd.HOUSEHOLD_SL}" readonly="readonly" style="width:45%;">
                                    			</td>
                                    			<td style="width: 25%;">
                                    				<c:if test="${modelsPd.ele_type=='DT12'}">
	                                    				<label style="width: 40%;"><font color="red">*</font>开门形式</label>
	                                    				 <select style="width: 50%;" class="form-control" id="BZ_KMXS" name="BZ_KMXS"
				                                                    required="required">
			                                                <option value="中分(标配)" ${pd.BZ_KMXS=='中分(标配)'?'selected':''}>中分(标配)</option>
			                                                <option value="旁开(选配)" ${pd.BZ_KMXS=='旁开(选配)'?'selected':''}>旁开(选配)</option>
			                                            </select>
		                                            </c:if>
		                                            <c:if test="${modelsPd.ele_type=='DT11'}">
	                                    				<label style="width: 40%;"><font color="red">*</font>开门形式</label>
	                                    				<select style="width: 50%;" class="form-control" id="BZ_KMXS" name="BZ_KMXS"
				                                                    required="required" onchange="SetKMXS()">
			                                                <option value="无轿门(标准)" ${pd.BZ_KMXS=='无轿门(标准)'?'selected':''}>无轿门(标准)</option>
			                                                <option value="手拉式层门" ${pd.BZ_KMXS=='手拉式层门'?'selected':''}>手拉式层门</option>
			                                                <option style="color: red;" value="折叠轿门(非标)" ${pd.BZ_KMXS=='折叠轿门(非标)'?'selected':''}>折叠轿门(非标)</option>
			                                            </select>
			                                            <input hidden="hidden" id="BZ_KMXS_TEMP" name = "BZ_KMXS_TEMP">
		                                            </c:if>
                                    			</td>
                                    			<td style="width: 25%;"><label style="width: 40%;"><font color="red">*</font>开门宽度</label>
	                                    			<c:if test="${modelsPd.ele_type=='DT12'}">
	                                    				<select style="width: 50%;" class="form-control" id="BZ_KMKD" name="BZ_KMKD"
	                                                    onchange="setMPrice();" required="required">
			                                                <option value="">请选择</option>
			                                                <option value="700" ${pd.BZ_KMKD=='700'?'selected':''}>700</option>
			                                                <option value="800" ${pd.BZ_KMKD=='800'?'selected':''}>800</option>
			                                            </select>
			                                        </c:if>
			                                        <c:if test="${modelsPd.ele_type=='DT11'}">
	                                    				<select style="width: 50%;" class="form-control" id="BZ_KMKD" name="BZ_KMKD"
	                                                    onchange="setMPrice();" required="required">
			                                                <option value="">请选择</option>
			                                                <option value="750" ${pd.BZ_KMKD=='750'?'selected':''}>750</option>
			                                                <option value="950" ${pd.BZ_KMKD=='950'?'selected':''}>950</option>
			                                            </select>
			                                        </c:if>
                                    			</td>
                                    			<td style="width: 25%;"><label style="width: 25%;"><font color="red">*</font>开门高度</label>
                                    				<input type="text" class="form-control" id="BZ_KMGD" name="BZ_KMGD"
                                                   required="required" value="${pd.view== 'edit'?pd.BZ_KMGD:'2000'}"
                                                   style="width:60%;">
                                    			</td>
                                    		</tr>
                                    		<tr>
                                    			<td style="width: 25%;">
                                    				<label style="width: 40%;">单价</label>
                                    				<input type="text" class="form-control" id="DANJIA" name="DANJIA"
                                                    	value="${regelevStandardPd.PRICE}" readonly="readonly"
                                                    	style="width:50%;">
                                    			</td>
                                    			<td style="width: 25%;">
                                    				<label style="width: 40%;">佣金折扣使用率:</label>
                                    				<input type="text" style="width: 50%;" class="form-control" name="YJSYZKL"
                                                   		id="YJSYZKL" readonly="readonly" value="${pd.YJSYZKL}">
                                    			</td>
                                    			<td style="width: 25%;">
                                    				<label style="width: 40%;"><font color="red">*</font>土建图号</label>
                                    				<input type="text" class="form-control" id="TJTTH" name="TJTTH"
                                                   		required="required" value="${pd.TJTTH}" style="width:50%;">
                                    			</td>
                                    			<td style="width: 25%;">
                                    			</td>
                                    		</tr>
                                    	</table>
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
                                                          name="SBJ_TEMP" id="SBJ_TEMP" readonly="readonly" value="${regelevStandardPd.PRICE*pd.HOUSEHOLD_SL}">
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
                                                         name="XS_QTFY" id="XS_QTFY" onkeyup="JS_SJBJ();" value="${pd.XS_QTFY}">
                                                    </td>
                                                    <!-- 佣金总额 -->
                                                    <td><input type="text" style="width:100%;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px;background-color:yellow;"
                                                         name="XS_YJZE" id="XS_YJZE" onkeyup="JS_SJBJ();" value="${pd.XS_YJZE}">
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
                                                    <td><input type="text" style="width:100%;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px;background-color:yellow;"
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
                                                    <td><input type="text" style="width:100%;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px"
                                                         name="XS_YSJ" id="XS_YSJ" value="${pd.XS_YSJ}" readonly="readonly">
                                                    </td>
                                                    <!-- 总报价 -->
                                                    <td><input type="text" style="width:100%;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px"
                                                         name="XS_TATOL" id="XS_TATOL" value="${pd.XS_TATOL}" readonly="readonly">
                                                    </td>
                                                    
                                                    <input type="hidden"  name="HOUSEHOLD_ZHJ" id="HOUSEHOLD_ZHJ" value="${pd.HOUSEHOLD_ZHJ}">
                                                    <input type="hidden"  name="HOUSEHOLD_SBJ" id="HOUSEHOLD_SBJ" value="${regelevStandardPd.PRICE}">
                                                    <%-- <input type="hidden" name="SBJ_TEMP" id="SBJ_TEMP" value="${regelevStandardPd.PRICE}"> --%>
                                                    <span id="zk_">${pd.HOUSEHOLD_ZK}</span>
                                                    <input type="hidden"  name="HOUSEHOLD_ZHSBJ" id="HOUSEHOLD_ZHSBJ" value="${pd.HOUSEHOLD_ZHSBJ}">
                                                    <input type="hidden" name="HOUSEHOLD_AZF" id="HOUSEHOLD_AZF" value="${pd.HOUSEHOLD_AZF}"/>
                                                    <input type="hidden"  name="HOUSEHOLD_YSF" id="HOUSEHOLD_YSF" value="${pd.HOUSEHOLD_YSF}">
                                                    <input type="hidden"  name="HOUSEHOLD0_SJBJ" id="HOUSEHOLD_SJBJ" value="${pd.HOUSEHOLD_SJBJ}">
                                                    <input type="hidden" style="width: 11%" class="form-control" id="HOUSEHOLD_ZK"
                                                   		name="HOUSEHOLD_ZK" value="${pd.HOUSEHOLD_ZK}">
                                                </tr>
                                            </table>
                                        </div>

                                        <div class="form-group form-inline">
                                            <ul class="nav nav-tabs">
                                                <li class="active"><a data-toggle="tab" href="#tab-1" class="active">整机规格</a></li> 
                                                <li class=""><a data-toggle="tab" href="#tab-5">轿厢规格</a></li>
                                                <li class=""><a data-toggle="tab" href="#tab-2">标准功能</a></li>
                                                <li class=""><a data-toggle="tab" href="#tab-3">可选功能</a></li>
                                               	<c:if test="${modelsPd.ele_type=='DT12'}">
                                               		<li class=""><a data-toggle="tab" href="#tab-4">机能</a></li>
                                                </c:if>
                                                <c:if test="${modelsPd.ele_type=='DT11'}">
                                                	<li class=""><a data-toggle="tab" href="#tab-7">各停站分布及厅门布置</a></li>
                                                </c:if>
                                                <c:if test="${modelsPd.ele_type=='DT11'}">
                                                	<li class=""><a data-toggle="tab" href="#tab-8">井道框架装饰</a></li>
                                                </c:if>
                                                <c:if test="${modelsPd.ele_type=='DT12'}">
                                                	<li class=""><a data-toggle="tab" href="#tab-6">层站规格</a></li>
                                                </c:if>
                                                <li class=""><a data-toggle="tab" href="#tab-9">非标</a></li>
                                                <li class=""><a data-toggle="tab" href="#tab-10">常规非标</a></li>
                                            </ul>
                                            <div class="tab-content">
                                                <div id="tab-1" class="tab-pane">
                                                    <!-- 基本参数 -->
                                                    <c:if test="${modelsPd.ele_type=='DT12'}">
                                                        <table class="table table-striped table-bordered table-hover" border="1" cellspacing="0">
                                                          <tr>
                                                            <td width="173">产品系列</td>
                                                            <td colspan="2">
                                                            	<c:if test="${modelsPd.ele_type=='DT12'}">
	                                                                <select name="BASE_KZXT" id="BASE_KZXT" class="form-control" style="width: 30%;">
	                                                                    <option value="DELCO-C3 龙门架自动门 主机上置AS380串行系统">DELCO-C3 龙门架自动门 主机上置AS380串行系统</option>
	                                                                </select>
                                                                </c:if>
                                                            </td>
                                                            <td width="180">加价</td>
                                                          </tr>
                                                          <tr>
                                                            <td width="173">执行标准</td>
                                                            <td colspan="2">
                                                                <select name="BASE_KZXT" id="BASE_ZXBJ" class="form-control" style="width: 30%;">
                                                                    <option value="A参考标准GB/T 21739">A参考标准GB/T 21739</option>
                                                                </select>
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td width="173">轿厢宽</td>
                                                            <td colspan="2">
                                                            	 <!-- 标准：(320kg,)950*1200,950*1000(400),950*1200,1000*1250,1100*1400(450kg)
                                                            			1100*1200 其他情况统一加价2000 -->
                                                               	<select name="BASE_JXK" id="BASE_JXK" class="form-control" style="width: 30%;" onchange="editZJGG('BASE_JXKS')">
                                                                	<option value="" ${pd.BASE_JXK==''?'checked':''}>特殊</option>
                                                                    <option value="800(320kg)" ${pd.BASE_JXK=='800(320kg)'?'checked':''}>800(320kg)</option>
                                                                    <option value="950(320kg\400kg)" ${pd.BASE_JXK=='950(320kg\\400kg)'?'checked':''}>950(320kg\400kg)</option>
                                                                    <option value="1000(400kg)" ${pd.BASE_JXK=='1000(400kg)'?'checked':''}>1000(400kg)</option>
                                                                    <option value="1100(400kg\450kg)" ${pd.BASE_JXK=='1100(400kg\\450kg)'?'checked':''}>1100(400kg\450kg)</option>
                                                                </select>
                                                            </td>
                                                            <td rowspan="2">
                                                            	<input type="text" class="form-control" id="BASE_JXKS_TEMP" 
                                                            		name="BASE_JXKS_TEMP"readonly="readonly">
                                                            </td>
                                                          </tr>
                                                          <tr>
                                                            <td width="173">轿厢深</td>
                                                            <!-- 标准：(320kg,)950*1200,950*1000(400),950*1200,1000*1250,1100*1400(450kg)
                                                            1100*1200 其他情况统一加价2000 -->
                                                            <td colspan="2">
                                                                <select name="BASE_JXS" id="BASE_JXS" class="form-control" style="width:30%" onchange="editZJGG('BASE_JXKS')">
                                                                	<option value="" ${pd.BASE_JXS==''?'checked':''}>特殊</option>
                                                                    <option value="1000(320kg)" ${pd.BASE_JXS=='1000(320kg)'?'checked':''}>1000(320kg)</option>
                                                                    <option value="1200(320\400kg\450kg)" ${pd.BASE_JXS=='1200(320\\400kg\\450kg)'?'checked':''}>1200(320\400kg\450kg)</option>
                                                                    <option value="1250(400kg)" ${pd.BASE_JXS=='1250(400kg)'?'checked':''}>1250(400kg)</option>
                                                                    <option value="1400(400kg)" ${pd.BASE_JXS=='1400(400kg)'?'checked':''}>1400(400kg)</option>
                                                                    <option value="1050(320kg)" ${pd.BASE_JXS=='1050(320kg)'?'checked':''}>1050(320kg)</option>
                                                                </select>
                                                            </td>
                                                          </tr>
                                                          <tr>
                                                            <td>轿厢总高</td>
                                                            <td colspan="2">
	                                                            <!-- 2300加2000块可打折,2400加3000不可打折 -->
                                                            	<input type="radio" name="BASE_JXGD" onclick="editZJGG('BASE_JXGD')"
                                                                       value="" ${pd.BASE_JXGD==''?'checked':''}/>特殊
                                                                <input type="radio" name="BASE_JXGD" onclick="editZJGG('BASE_JXGD')"
                                                                       value="2100" ${pd.BASE_JXGD=='2100'?'checked':''}/>2100mm
                                                                <input type="radio" name="BASE_JXGD" onclick="editZJGG('BASE_JXGD')"
                                                                       value="2200" ${pd.BASE_JXGD=='2200'?'checked':''}/>2200mm
                                                                <input type="radio" name="BASE_JXGD" onclick="editZJGG('BASE_JXGD')"
                                                                       value="2300" ${pd.BASE_JXGD=='2300'?'checked':''}/>2300mm
                                                                <input type="radio" name="BASE_JXGD" onclick="editZJGG('BASE_JXGD')"
                                                                       value="2400" ${pd.BASE_JXGD=='2400'?'checked':''}/>2400mm
                                                            </td>
                                                            <td>
                                                            	<input type="text" class="form-control" id="BASE_JXGD_TEMP"
                                                            		name="BASE_JXGD_TEMP" readonly="readonly">
                                                   			</td>
                                                          </tr>
                                                          <tr>
                                                            <td>出入口宽</td>
                                                            <!-- 不计价 -->
                                                            <td colspan="2">
                                                            	<input type="radio" name="BASE_CRKK"
                                                                       value="" ${pd.BASE_CRKK==''?'checked':''}/>特殊
                                                                <input type="radio" name="BASE_CRKK"
                                                                       value="700" ${pd.BASE_CRKK=='800'?'checked':''}/>700mm
                                                                <input type="radio" name="BASE_CRKK"
                                                                       value="800" ${pd.BASE_CRKK=='800'?'checked':''}/>800mm
                                                            </td>
                                                            <td>
                                                   			</td>
                                                          </tr>
                                                          <tr>
                                                            <td>出入口高</td>
                                                            <!-- 标准2000，选项2100需选项加价400元/层 -->
                                                            <td colspan="2">
                                                                <input type="radio" name="BASE_CRKG" onclick="editZJGG('BASE_CRKG')"
                                                                       value="2000" ${pd.BASE_CRKG=='2000'?'checked':''}/>标准2000mm
                                                                <input type="radio" name="BASE_CRKG" onclick="editZJGG('BASE_CRKG')"
                                                                       value="2100" ${pd.BASE_CRKG=='2100'?'checked':''}/>2100mm
                                                                <input type="radio" name="BASE_CRKG" onclick="editZJGG('BASE_CRKG')"
                                                                       value="" ${pd.BASE_CRKG==''?'checked':''}/>特殊
                                                            </td>
                                                            <td>
                                                            	<input type="text" class="form-control" id="BASE_CRKG_TEMP"
                                                            		name="BASE_CRKG_TEMP" readonly="readonly">
                                                            </td>
                                                          </tr>
                                                          <tr>
                                                            <td>门口配置型式：</td>
                                                            <!-- D双出入口,TH贯通,加价10000 -->
                                                            <td colspan="2">
                                                                <input type="radio" name="BASE_MKPZXS" onclick="editZJGG('BASE_MKPZXS')"
                                                                       value="单出入口" ${pd.BASE_MKPZXS=='单出入口'?'checked':''}/>单出入口
                                                                <input type="radio" name="BASE_MKPZXS" onclick="editZJGG('BASE_MKPZXS')"
                                                                       value="双出入口" ${pd.BASE_MKPZXS=='双出入口'?'checked':''}/>双出入口
                                                                <input type="radio" name="BASE_MKPZXS" onclick="editZJGG('BASE_MKPZXS')"
                                                                       value="贯通门" ${pd.BASE_MKPZXS=='贯通门'?'checked':''}/>贯通门
                                                                <input type="radio" name="BASE_MKPZXS" onclick="editZJGG('BASE_MKPZXS')"
                                                                       value="特殊" ${pd.BASE_MKPZXS=='特殊'?'checked':''}/>特殊
                                                            </td>
                                                            <td>
                                                            	<input type="text" class="form-control" id="BASE_MKPZXS_TEMP"
                                                            		name="BASE_MKPZXS_TEMP" readonly="readonly">
                                                            </td>
                                                          </tr>
                                                          <tr>
                                                            <td>开门方式</td>
                                                            <!-- 2S，加1000/台+950*层数，当门口配置型式选择D或TH时，加价2000/台+950*层数 -->
                                                            <td colspan="2">
                                                                <input type="radio" name="BASE_KMFS" onclick="editZJGG('BASE_KMFS')"
                                                                       value="两扇中分(标准)" ${pd.BASE_KMFS=='两扇中分(标准)'?'checked':''}/>两扇中分(标准)
                                                                <input type="radio" name="BASE_KMFS" onclick="editZJGG('BASE_KMFS')"
                                                                       value="两扇旁开(选项)" ${pd.BASE_KMFS=='两扇旁开(选项)'?'checked':''}/>两扇旁开(选项)
                                                                <input type="radio" name="BASE_KMFS" onclick="editZJGG('BASE_KMFS')"
                                                                       value="四扇中分" ${pd.BASE_KMFS=='四扇中分'?'checked':''}/>四扇中分
                                                                <input type="radio" name="BASE_KMFS" onclick="editZJGG('BASE_KMFS')"
                                                                       value="三扇旁开" ${pd.BASE_KMFS=='三扇旁开'?'checked':''}/>三扇旁开
                                                            </td>
                                                            <td>
                                                            	<input type="text" class="form-control" id="BASE_KMFS_TEMP"
                                                            		name="BASE_KMFS_TEMP" readonly="readonly">
                                                            </td>
                                                          </tr>
                                                          <tr>
                                                            <td>开门方向(由厅外朝轿内看开门时门的运动方向)</td>
                                                            <!-- 不计价 -->
                                                            <td colspan="2">
                                                                <input type="radio" name="BASE_KMFX"
                                                                       value="中分门" ${pd.BASE_KMFX=='中分门'?'checked':''}/>中分门
                                                                <input type="radio" name="BASE_KMFX"
                                                                       value="左开门" ${pd.BASE_KMFX=='左开门'?'checked':''}/>左开门
                                                                <input type="radio" name="BASE_KMFX"
                                                                       value="右开门" ${pd.BASE_KMFX=='右开门'?'checked':''}/>右开门
                                                                <input type="radio" name="BASE_KMFX"
                                                                       value="特殊" ${pd.BASE_MKPZXS=='特殊'?'checked':''}/>特殊
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td>控制柜位置</td>
                                                            <!-- 特殊加1000，且不能打折 -->
                                                            <td colspan="2">
                                                                <input type="radio" name="BASE_KZGWZ" onclick="editZJGG('BASE_KZGWZ')"
                                                                       value="中分门" ${pd.BASE_KZGWZ=='顶层门口旁'?'checked':''}/>顶层门口旁
                                                                <input type="radio" name="BASE_KZGWZ" onclick="editZJGG('BASE_KZGWZ')"
                                                                       value="特殊" ${pd.BASE_KZGWZ=='特殊'?'checked':''}/>特殊
                                                            </td>
                                                            <td>
                                                            	<input type="text" class="form-control" id="BASE_KZGWZ_TEMP"
                                                            		name="BASE_KZGWZ_TEMP" readonly="readonly">
                                                            </td>
                                                          </tr>
                                                          <tr>
                                                            <td>井道结构</td>
                                                            <td colspan="2">
                                                                <input type="radio" name="BASE_JDJG" value="钢筋混凝土" ${pd.BASE_JDJG=='钢筋混凝土'?'checked':''}/>
                                                                	钢筋混凝土
                                                                <input type="radio" name="BASE_JDJG" value="圈梁结构" ${pd.BASE_JDJG=='圈梁结构'?'checked':''}/>
                                                                	圈梁结构
                                                                <input type="radio" name="BASE_JDJG" value="钢结构" ${pd.BASE_JDJG=='钢结构'?'checked':''}/>
                                                               		 钢结构
                                                              	<input type="radio" name="BASE_JDJG" value="特殊" ${pd.BASE_JDJG=='特殊'?'checked':''}/>
                                                               		 特殊
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td>电梯行程</td>
                                                            <td colspan="2">
                                                                <font color="red">*</font><input name="BASE_TSGD" id="BASE_TSGD" onkeyup="setJdzg();" type="text" class="form-control"  value="${pd.BASE_TSGD}" placeholder="必填" required="required"/>mm
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td>井道尺寸HW*HD</td>
                                                            <td colspan="2">
                                                                <input name="BASE_JDK" id="BASE_JDK" type="text" class="form-control" style="width: 10%" value="${pd.BASE_JDK}"/>
                                                                mm宽×
                                                                <input name="BASE_JDS" id="BASE_JDS" type="text" class="form-control" style="width: 10%" value="${pd.BASE_JDS}"/>
                                                                mm深
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td>底坑深度(mm) && 顶层高度(mm)</td>
                                                            <!-- 如填非300-500，则提示需非标询价 -->
                                                            <td colspan="2">
                                                                <p>
                                                                  <font color="red">*</font>底坑深度:<input name="BASE_DKSD" id="BASE_DKSD" type="text"  onkeyup="setJdzg();" class="form-control" value="${pd.BASE_DKSD}" placeholder="必填" required="required"/>mm
                                                                </p>
                                                                <p>
                                                                  <font color="red">*</font>顶层高度:<input name="BASE_DCGD" id="BASE_DCGD" type="text"  onkeyup="setJdzg();" class="form-control" value="${pd.BASE_DCGD}" placeholder="必填" required="required"/>mm
                                                                </p>
                                                            </td>
                                                            <td>
                                                                                                                                      超出:
                                                              <input name="BASE_CCGD" id="BASE_CCGD" type="text" style="width:60%" class="form-control" value="${pd.BASE_CCGD}" readonly="readonly"/>mm
                                                               &nbsp;&nbsp;                                                                                                                   
                                                                                                                                      加价:
                                                              <input name="BASE_CCJG" id="BASE_CCJG" type="text" style="width:60%" class="form-control" value="${pd.BASE_CCJG}" readonly="readonly"/>元
                                                            </td>
                                                          </tr>
                                                          <tr>
                                                            <td>井道全高(mm)</td>
                                                            <!-- 底坑深度+顶层高度 -->
                                                            <td colspan="2">
                                                                <input name="BASE_JDZG" id="BASE_JDZG" type="text" class="form-control" value="${pd.BASE_JDZG}" readonly="readonly"/>
                                                            </td>
                                                            <td>
                                                                <input type="hidden" name="BASE_JDZG_TEMP" id="BASE_JDZG_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>动力电源(V)</td>
                                                            <td colspan="2">
                                                                <input type="radio" name="BASE_DLDY" value="380(三相)" ${pd.BASE_DLDY=='380(三相)'?'checked':''}/>
                                                                	380(三相)
                                                                <input type="radio" name="BASE_DLDY" value="220(单相)" ${pd.BASE_DLDY=='220(单相)'?'checked':''}/>
                                                                	220(单相)
                                                              	<input type="radio" name="BASE_DLDY" value="特殊" ${pd.BASE_DLDY=='特殊'?'checked':''}/>
                                                               		 特殊
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                        </table>
                                                    </c:if>
                                                    <c:if test="${modelsPd.ele_type=='DT11'}">
                                                    <!-- A2基本参数 -->
                                                    	<table class="table table-striped table-bordered table-hover" border="1" cellspacing="0">
                                                          	<tr>
	                                                            <td width="173">产品系列</td>
	                                                            <td colspan="2">
	                                                                <select name="BASE_KZXT" id="BASE_KZXT" class="form-control" style="width: 30%;">
	                                                                    <option value="液压泵站(主机)">液压泵站(主机)</option>
	                                                                </select>
	                                                            </td>
	                                                            <td width="180">加价</td>
                                                          	</tr>
                                                          	<tr>
	                                                          	<td width="173">驱动系统</td>
	                                                            <td colspan="2">
		                                                            <select name="BASE_QDXT" id="BASE_QDXT" class="form-control" style="width: 30%;">
		                                                            	<option value="液压泵站(主机)">液压泵站(主机)</option>
		                                                            </select>
	                                                            </td>
	                                                            <td></td>
                                                          	</tr>
                                                        	<tr>
	                                                          	<td width="173">井道结构</td>
	                                                            <td colspan="2">
		                                                            <select name="BASE_JDJG" id="BASE_JDJG" class="form-control" onchange="editZJGG('BASE_JDJG')" style="width: 30%;">
		                                                            	<option value="铝合金框架(东南提供，室外梯防水客户自理)">铝合金框架(东南提供，室外梯防水客户自理)</option>
		                                                            	<option value="钢结构井道(用户提供)">钢结构井道(用户提供)</option>
		                                                            	<option value="砖混井道">砖混井道</option>
		                                                            </select>
		                                                            <label id="BASE_JDJG_LABEL" name ="BASE_JDJG_LABEL" style="color: red;display: none;">请填写井道框架装饰页签</label>
	                                                            </td>
                                                          	</tr>
                                                          	<tr>
	                                                          	<td width="173">动力电压</td>
	                                                            <td colspan="2">
		                                                            <select name="BASE_DLDY" id="BASE_DLDY" class="form-control" style="width: 30%;">
		                                                            	<option value="单相电压 220V±7％ 50HZ">单相电压 220V±7％ 50HZ</option>
		                                                            	<option value="三相电压 380V±7％ 50HZ">三相电压 380V±7％ 50HZ</option>
		                                                            </select>
		                                                            <label id="BASE_DLDY_LABEL" name ="BASE_DLDY_LABEL" 
		                                                            	style="color: red;display: none;">注：当电梯额定速度为0.3m/s，电压必须为三相380V。</label>
	                                                            </td>
                                                          	</tr>
                                                          	<tr>
	                                                          	<td width="173">照明电压</td>
	                                                            <td colspan="2">
		                                                            <select name="BASE_ZMDY" id="BASE_ZMDY" class="form-control" style="width: 30%;">
		                                                            	<option value="220V±7％ 50HZ">220V±7％ 50HZ</option>
		                                                            </select>
	                                                            </td>
                                                          	</tr>
                                                          <tr>
                                                            <td width="173">执行标准</td>
                                                            <td colspan="2">
                                                                <select name="BASE_KZXT" id="BASE_ZXBJ" class="form-control" style="width: 30%;">
                                                                    <option value="A参考标准GB/T 21739">A参考标准GB/T 21739</option>
                                                                </select>
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                          	<td width="173">油缸位置</td>
                                                            <td colspan="2">
	                                                            <select name="BASE_YGWZ" id="BASE_YGWZ" class="form-control" style="width: 30%;">
	                                                            	<option value="油缸左置" ${pd.BASE_YGWZ=='油缸左置'?'checked':''}>油缸左置</option>
	                                                            	<option value="油缸右置" ${pd.BASE_YGWZ=='油缸右置'?'checked':''}>油缸右置</option>
	                                                            	<option value="油缸后置" ${pd.BASE_YGWZ=='油缸后置'?'checked':''}>油缸后置</option>
	                                                            </select>
                                                            </td>
                                                          </tr>
                                                          <tr>
                                                          	<td width="173">油缸类型</td>
                                                            <td colspan="2">
	                                                            <select name="BASE_YGLX" id="BASE_YGLX" class="form-control" style="width: 30%;" onchange="editZJGG('BASE_YGLX')">
	                                                            	<!-- 不可打折 -->
	                                                            	<option value="请选择">请选择</option>
	                                                            	<option value="单节缸" ${pd.BASE_YGLX=='单节缸'?'checked':''}>单节缸</option>
	                                                            	<option value="对接缸" ${pd.BASE_YGLX=='对接缸'?'checked':''}>对接缸</option>
	                                                            </select>
                                                            </td>
                                                            <td>
                                                            	<input type="text" class="form-control" id="BASE_YGLX_TEMP" 
                                                            		name="BASE_YGLX_TEMP"readonly="readonly">
                                                            </td>
                                                          </tr>
                                                          <tr>
                                                            <td width="173">轿厢宽</td>
                                                            <td colspan="2">
                                                               	<select name="BASE_JXK" id="BASE_JXK" class="form-control" style="width: 30%;" onchange="editZJGG('BASE_JXKS')">
                                                                	<option value="" ${pd.BASE_JXK==''?'checked':''}>特殊</option>
                                                                    <option value="800(260kg)" ${pd.BASE_JXK=='800(260kg)'?'checked':''}>800(260kg)</option>
                                                                    <option value="1000(260kg)" ${pd.BASE_JXK=='1000(260kg)'?'checked':''}>1000(260kg)</option>
                                                                    <option value="1250(320kg)" ${pd.BASE_JXK=='1250(320kg)'?'checked':''}>1250(320kg)</option>
                                                                    <option value="1250(400kg)" ${pd.BASE_JXK=='1250(400kg)'?'checked':''}>1250(400kg)</option>
                                                                    <option value="800(320kg)" ${pd.BASE_JXK=='800(320kg)'?'checked':''}>800(320kg)</option>
                                                                    <option value="1000(400kg)" ${pd.BASE_JXK=='1000(400kg)'?'checked':''}>1000(400kg)</option>
                                                                    <option value="1000(320kg)" ${pd.BASE_JXK=='1000(320kg)'?'checked':''}>1000(320kg)</option>
                                                                    <option value="800(400kg)" ${pd.BASE_JXK=='800(400kg)'?'checked':''}>800(400kg)</option>
                                                                </select>
                                                            </td>
                                                            <td rowspan="2">
                                                            	<input type="text" class="form-control" id="BASE_JXKS_TEMP" 
                                                            		name="BASE_JXKS_TEMP"readonly="readonly">
                                                            </td>
                                                          </tr>
                                                          <tr>
                                                            <td width="173">轿厢深</td>
                                                            <!-- 标准：(320kg,)950*1200,950*1000(400),950*1200,1000*1250,1100*1400(450kg)
                                                            1100*1200 其他情况统一加价2000 -->
                                                            <td colspan="2">
                                                               	<select name="BASE_JXS" id="BASE_JXS" class="form-control" style="width: 30%;" onchange="editZJGG('BASE_JXKS')">
                                                                	<option value="" ${pd.BASE_JXK==''?'checked':''}>特殊</option>
                                                                    <option value="800(260kg)" ${pd.BASE_JXK=='800(260kg)'?'checked':''}>800(260kg)</option>
                                                                    <option value="1000(260kg)" ${pd.BASE_JXK=='1000(260kg)'?'checked':''}>1000(260kg)</option>
                                                                    <option value="1250(320kg)" ${pd.BASE_JXK=='1250(320kg)'?'checked':''}>1250(320kg)</option>
                                                                    <option value="1250(400kg)" ${pd.BASE_JXK=='1250(400kg)'?'checked':''}>1250(400kg)</option>
                                                                    <option value="800(320kg)" ${pd.BASE_JXK=='800(320kg)'?'checked':''}>800(320kg)</option>
                                                                    <option value="1000(400kg)" ${pd.BASE_JXK=='1000(400kg)'?'checked':''}>1000(400kg)</option>
                                                                    <option value="1000(320kg)" ${pd.BASE_JXK=='1000(320kg)'?'checked':''}>1000(320kg)</option>
                                                                    <option value="800(400kg)" ${pd.BASE_JXK=='800(400kg)'?'checked':''}>800(400kg)</option>
                                                                </select>
                                                            </td>
                                                          </tr>
                                                          <tr>
                                                            <td>轿厢总高</td>
                                                            <td colspan="2">
                                                            	<input type="radio" name="BASE_JXGD" onclick="editZJGG('BASE_JXGD')"
                                                                       value="" ${pd.BASE_JXGD==''?'checked':''}/>特殊
                                                                <input type="radio" name="BASE_JXGD" onclick="editZJGG('BASE_JXGD')"
                                                                       value="2100" ${pd.BASE_JXGD=='2100'?'checked':''}/>2100mm
                                                                <input type="radio" name="BASE_JXGD" onclick="editZJGG('BASE_JXGD')"
                                                                       value="2200" ${pd.BASE_JXGD=='2200'?'checked':''}/>2200mm
                                                                <input type="radio" name="BASE_JXGD" onclick="editZJGG('BASE_JXGD')"
                                                                       value="2000" ${pd.BASE_JXGD=='2000'?'checked':''}/>2000mm
                                                            </td>
                                                            <td>
                                                            	<input type="text" class="form-control" id="BASE_JXGD_TEMP"
                                                            		name="BASE_JXGD_TEMP" readonly="readonly">
                                                   			</td>
                                                          </tr>
                                                          <tr>
	                                                          <td>轿厢布置型式</td>
	                                                          <td colspan="2" >
		                                                          <select name="BASE_JXBZXS" id="BASE_JXBZXS" onchange="editJxzh('BASE_JXBZXS');" class="form-control">
			                                                      <option value="单开门(标准)" ${pd.BASE_JXBZXS=='单开门(标准)'?'selected':'' }>单开门(标准)</option>
			                                                      <option value="贯通开门(非标)" ${pd.BASE_JXBZXS=='贯通开门(非标)'?'selected':'' }>贯通开门(非标)</option>
			                                                      <option value="直角开门(非标)" ${pd.BASE_JXBZXS=='直角开门(非标)'?'selected':'' }>直角开门(非标)</option>
			                                                      </select>
	                                                          </td>
	                                                          <td>
		                                                          <input type="text" name="BASE_JXBZXS_TEMP" id="BASE_JXBZXS_TEMP" 
		                                                          	class="form-control" readonly="readonly">
	                                                          </td>
	                                                      </tr>
	                                                      <tr>
	                                                          <td>闭门器类型</td>
	                                                          <td colspan="2" >
		                                                          <select name="BASE_BMQLX" id="BASE_BMQLX" class="form-control">
			                                                      	<option value="DBQ-02内置式(标准)" ${pd.BASE_JXBZXS=='DBQ-02内置式(标准)'?'selected':'' }>DBQ-02内置式(标准)</option>
			                                                      	<option value="DBQ-01外置式(非标)" ${pd.BASE_JXBZXS=='DBQ-01外置式(非标)'?'selected':'' }>DBQ-01外置式(非标)</option>
			                                                      </select>
	                                                          </td>
	                                                          <td></td>
	                                                      </tr>
                                                          <tr>
                                                            <td>电梯行程</td>
                                                            <td colspan="2">
                                                                <font color="red">*</font><input name="BASE_TSGD" id="BASE_TSGD" onkeyup="setJdzg();" type="text" class="form-control"  value="${pd.BASE_TSGD}" placeholder="必填" required="required"/>mm
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td>井道尺寸HW*HD</td>
                                                            <td colspan="2">
                                                                <input name="BASE_JDK" id="BASE_JDK" type="text" class="form-control" style="width: 10%" value="${pd.BASE_JDK}"/>
                                                                mm宽×
                                                                <input name="BASE_JDS" id="BASE_JDS" type="text" class="form-control" style="width: 10%" value="${pd.BASE_JDS}"/>
                                                                mm深
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                            <td>底坑深度(mm) && 顶层高度(mm)</td>
                                                            <!-- 如填非300-500，则提示需非标询价 -->
                                                            <td colspan="2">
                                                                <p>
                                                                  <font color="red">*</font>底坑深度:<input name="BASE_DKSD" id="BASE_DKSD" type="text"  onkeyup="setJdzg();" class="form-control" value="${pd.BASE_DKSD}" placeholder="必填" required="required"/>mm
                                                                </p>
                                                                <p>
                                                                  <font color="red">*</font>顶层高度:<input name="BASE_DCGD" id="BASE_DCGD" type="text"  onkeyup="setJdzg();" class="form-control" value="${pd.BASE_DCGD}" placeholder="必填" required="required"/>mm
                                                                </p>
                                                            </td>
                                                            <td>
                                                                                                                                      超出:
                                                              <input name="BASE_CCGD" id="BASE_CCGD" type="text" style="width:60%" class="form-control" value="${pd.BASE_CCGD}" readonly="readonly"/>mm
                                                               &nbsp;&nbsp;                                                                                                                   
                                                                                                                                      加价:
                                                              <input name="BASE_CCJG" id="BASE_CCJG" type="text" style="width:60%" class="form-control" value="${pd.BASE_CCJG}" readonly="readonly"/>元
                                                            </td>
                                                          </tr>
                                                          <tr>
                                                            <td>井道全高(mm)</td>
                                                            <!-- 底坑深度+顶层高度 -->
                                                            <td colspan="2">
                                                                <input name="BASE_JDZG" id="BASE_JDZG" type="text" class="form-control" value="${pd.BASE_JDZG}" readonly="readonly"/>
                                                            </td>
                                                            <td>
                                                                <input type="hidden" name="BASE_JDZG_TEMP" id="BASE_JDZG_TEMP" class="form-control" readonly="readonly"></td>
                                                          </tr>
                                                          <tr>
                                                            <td>动力电源(V)</td>
                                                            <td colspan="2">
                                                                <input type="radio" name="BASE_DLDY" value="380(三相)" ${pd.BASE_DLDY=='380(三相)'?'checked':''}/>
                                                                	380(三相)
                                                                <input type="radio" name="BASE_DLDY" value="220(单相)" ${pd.BASE_DLDY=='220(单相)'?'checked':''}/>
                                                                	220(单相)
                                                              	<input type="radio" name="BASE_DLDY" value="特殊" ${pd.BASE_JDJG=='特殊'?'checked':''}/>
                                                               		 特殊
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                        </table>
                                                    </c:if>
                                                    <!-- 基本参数 -->
                                                </div>
                                                <div id="tab-2" class="tab-pane">
                                                    <!-- 标准功能 -->
                                                    <c:if test="${modelsPd.ele_type=='DT12'}">
                                                        <table class="table table-striped table-bordered table-hover" border="1" cellspacing="0">
                                                          <tr>
                                                            <td colspan="4"><label>标准功能及代码</label></td>
                                                          </tr>
                                                          <tr>
                                                            <td width="62">1</td>
                                                            <td width="224">光幕保护</td>
                                                            <td width="42">9</td>
                                                            <td width="241">运行超时保护</td>
                                                          </tr>
                                                          <tr>
                                                            <td>2</td>
                                                            <td>超载保护</td>
                                                            <td>10</td>
                                                            <td>逆向运行保护</td>
                                                          </tr>
                                                          <tr>
                                                            <td>3</td>
                                                            <td>超速保护</td>
                                                            <td>11</td>
                                                            <td>终端限位保护</td>
                                                          </tr>
                                                          <tr>
                                                            <td>4</td>
                                                            <td>防打滑保护</td>
                                                            <td>12</td>
                                                            <td>主回路故障保护</td>
                                                          </tr>
                                                          <tr>
                                                            <td>5</td>
                                                            <td>层门机电联锁保护</td>
                                                            <td>13</td>
                                                            <td>断、错相保护</td>
                                                          </tr>
                                                          <tr>
                                                            <td>6</td>
                                                            <td>门锁异常保护</td>
                                                            <td>14</td>
                                                            <td>一键呼叫功能</td>
                                                          </tr>
                                                          <tr>
                                                            <td>7</td>
                                                            <td>门区外不开门保护</td>
                                                            <td>15</td>
                                                            <td>停电应急照明功能</td>
                                                          </tr>
                                                          <tr>
                                                            <td>8</td>
                                                            <td>电机过热保护</td>
                                                           	<td>16</td>
                                                           	<td>轿厢节电控制功能</td>
                                                          </tr>
                                                        </table>
                                                    </c:if>
                                                    <c:if test="${modelsPd.ele_type=='DT11'}">
                                                        <table class="table table-striped table-bordered table-hover" border="1" cellspacing="0">
                                                          <tr>
                                                            <td colspan="6"><label>标准功能及代码</label></td>
                                                          </tr>
                                                          <tr>
                                                            <td width="62">1</td>
                                                            <td width="224">自动信号运行</td>
                                                            <td width="42">10</td>
                                                            <td width="224">自动油温保护</td>
                                                            <td width="42">19</td>
                                                            <td width="224">管道破裂保护</td>
                                                          </tr>
                                                          <tr>
                                                            <td>2</td>
                                                            <td>安全光幕保护</td>
                                                            <td>11</td>
                                                            <td>电机热保护</td>
                                                            <td>20</td>
                                                            <td>断相错相保护</td>
                                                          </tr>
                                                          <tr>
                                                            <td>3</td>
                                                            <td>紧急呼叫</td>
                                                            <td>12</td>
                                                            <td>自动平返层</td>
                                                          	<td>21</td>
                                                            <td>手动上升/下降</td>
                                                          </tr>
                                                          <tr>
                                                            <td>4</td>
                                                            <td>停电指示平层功能</td>
                                                            <td>13</td>
                                                            <td>超时保护</td>
                                                            <td>22</td>
                                                            <td>终端防越程保护</td>
                                                          </tr>
                                                          <tr>
                                                            <td>5</td>
                                                            <td>轿内锁梯(儿童锁)</td>
                                                            <td>14</td>
                                                            <td>电机不运行保护</td>
                                                            <td>23</td>
                                                            <td>自动返基站</td>
                                                          </tr>
                                                          <tr>
                                                            <td>6</td>
                                                            <td>关闭外召</td>
                                                            <td>15</td>
                                                            <td>接触器防粘连保护</td>
                                                            <td>24</td>
                                                            <td>一键呼叫功能</td>
                                                          </tr>
                                                          <tr>
                                                            <td>7</td>
                                                            <td>应急照明</td>
                                                            <td>16</td>
                                                            <td>楼层显示和运行方向指示</td>
                                                            <td>25</td>
                                                            <td>三方对讲</td>
                                                          </tr>
                                                          <tr>
                                                            <td>8</td>
                                                            <td>超载保护</td>
                                                           	<td>17</td>
                                                           	<td>节电功能</td>
                                                           	<td>26</td>
                                                           	<td>轿内急停功能</td>
                                                          </tr>
                                                          <tr>
                                                            <td>9</td>
                                                            <td>电磁门刀控制</td>
                                                           	<td>18</td>
                                                           	<td>轿内应急自救下降功能</td>
                                                           	<td>27</td>
                                                           	<td>保养提示</td>
                                                          </tr>
                                                        </table>
                                                    </c:if>
                                                    <!-- 标准功能 -->
                                                </div>
                                                <div id="tab-3" class="tab-pane">
                                                    <!-- 可选功能 -->
                                                    	<c:if test="${modelsPd.ele_type=='DT12'}">
	                                                        <table class="table table-striped table-bordered table-hover" border="1" cellspacing="0">
	                                                        	<tr>
		                                                            <td><label>序号</label></td>
		                                                            <td><label>功能</label></td>
		                                                            <td><label>有</label></td>
		                                                            <td><label>加价</label></td>
	                                                         	</tr>
		                                                    	<tr>
		                                                        	<td>1</td>
		                                                            <td>远程服务功能</td>
		                                                            <!-- 加价5000*台数 -->
		                                                            <td>
		                                                                <input name="OPT_YCFW_TEXT" id="OPT_YCFW_TEXT" type="checkbox" onclick="editOpt('OPT_YCFW');" ${pd.OPT_YCFW=='1'?'checked':''}/>
																		<input type="hidden" name="OPT_YCFW" id="OPT_JXDZZ">
		                                                            </td>
		                                                            <td><input type="text" name="OPT_YCFW_TEMP" id="OPT_YCFW_TEMP" class="form-control" readonly="readonly"></td>
	                                                     		<tr>
		                                                            <td>2</td>
		                                                            <td>停电自动平层(ARD)功能</td>
		                                                            <!-- 加价5500*台数 -->
		                                                            <td>
		                                                                <input name="OPT_TDTC_TEXT" id="OPT_TDTC_TEXT" type="checkbox" onclick="editOpt('OPT_TDTC');"  ${pd.OPT_TDTC=='1'?'checked':''}/>
		                                                                <input type="hidden" name="OPT_TDTC" id="OPT_TDTC">
		                                                            </td>
		                                                            <td><input type="text" name="OPT_TDTC_TEMP" id="OPT_TDTC_TEMP" class="form-control" readonly="readonly"></td>
	                                                        	</tr>
	                                                        </table>
                                                        </c:if>
                                                        <c:if test="${modelsPd.ele_type=='DT11'}">
	                                                        <table class="table table-striped table-bordered table-hover" border="1" cellspacing="0">
	                                                        	<tr>
		                                                            <td><label>序号</label></td>
		                                                            <td><label>功能</label></td>
		                                                            <td><label>有</label></td>
		                                                            <td><label>加价</label></td>
	                                                         	</tr>
		                                                    	<tr>
		                                                        	<td>1</td>
		                                                            <td>智能语音提示功能</td>
		                                                            <td>
		                                                                <input name="OPT_YYTS_TEXT" id="OPT_YYTS_TEXT" type="checkbox" onclick="editOpt('OPT_YYTS');" ${pd.OPT_YYTS=='1'?'checked':''}/>
																		<input type="hidden" name="OPT_YYTS" id="OPT_YYTS">
		                                                            </td>
		                                                            <td><input type="text" name="OPT_YYTS_TEMP" id="OPT_YYTS_TEMP" class="form-control" readonly="readonly"></td>
	                                                     		<tr>
		                                                            <td>2</td>
		                                                            <td>四方对讲</td>
		                                                            <td>
		                                                                <input name="OPT_SFDJ_TEXT" id="OPT_SFDJ_TEXT" type="checkbox" onclick="editOpt('OPT_SFDJ');"  ${pd.OPT_SFDJ=='1'?'checked':''}/>
		                                                                <input type="hidden" name="OPT_SFDJ" id="OPT_SFDJ">
		                                                            </td>
		                                                            <td><input type="text" name="OPT_SFDJ_TEMP" id="OPT_SFDJ_TEMP" class="form-control" readonly="readonly"></td>
	                                                        	</tr>
	                                                        	<tr>
		                                                            <td>3</td>
		                                                            <td>本层免打扰功能</td>
		                                                            <td>
		                                                                <input name="OPT_BCMDR_TEXT" id="OPT_BCMDR_TEXT" type="checkbox" onclick="editOpt('OPT_BCMDR');"  ${pd.OPT_SFDJ=='1'?'checked':''}/>
		                                                                <input type="hidden" name="OPT_BCMDR" id="OPT_BCMDR">
		                                                            </td>
		                                                            <td><input type="text" name="OPT_BCMDR_TEMP" id="OPT_BCMDR_TEMP" class="form-control" readonly="readonly"></td>
	                                                        	</tr>
	                                                        	<tr>
		                                                            <td>4</td>
		                                                            <td>公共层厅外专用</td>
		                                                            <td>
		                                                                <input name="OPT_GGCTW_TEXT" id="OPT_GGCTW_TEXT" type="checkbox" onclick="editOpt('OPT_GGCTW');"  ${pd.OPT_GGCTW=='1'?'checked':''}/>
		                                                                <input type="hidden" name="OPT_GGCTW" id="OPT_GGCTW">
		                                                            </td>
		                                                            <td><input type="text" name="OPT_GGCTW_TEMP" id="OPT_GGCTW_TEMP" class="form-control" readonly="readonly"></td>
	                                                        	</tr>
	                                                        	<tr>
		                                                            <td>5</td>
		                                                            <td>油温冷却器</td>
		                                                            <td>
		                                                                <input name="OPT_YWLQ_TEXT" id="OPT_YWLQ_TEXT" type="checkbox" onclick="editOpt('OPT_YWLQ');"  ${pd.OPT_YWLQ=='1'?'checked':''}/>
		                                                                <input type="hidden" name="OPT_YWLQ" id="OPT_YWLQ">
		                                                            </td>
		                                                            <td><input type="text" name="OPT_YWLQ_TEMP" id="OPT_YWLQ_TEMP" class="form-control" readonly="readonly"></td>
	                                                        	</tr>
	                                                        	<tr>
		                                                            <td>6</td>
		                                                            <td>油温加热器</td>
		                                                            <td>
		                                                                <input name="OPT_YWJR_TEXT" id="OPT_YWJR_TEXT" type="checkbox" onclick="editOpt('OPT_YWJR');"  ${pd.OPT_YWJR=='1'?'checked':''}/>
		                                                                <input type="hidden" name="OPT_YWJR" id="OPT_YWJR">
		                                                            </td>
		                                                            <td><input type="text" name="OPT_YWJR_TEMP" id="OPT_YWJR_TEMP" class="form-control" readonly="readonly"></td>
	                                                        	</tr>
	                                                        	<tr>
		                                                            <td>7</td>
		                                                            <td>厅外IC刷卡</td>
		                                                            <td>
		                                                            	<font>刷卡楼层:</font>
		                                                                <input name="OPT_TWSK_SKLC" id="OPT_TWSK_SKLC" type="text" value="${pd.OPT_TWSK_SKLC}"/>
		                                                                <font>个数:</font>
		                                                                <input name="OPT_TWSK_SKGS" id="OPT_TWSK_SKGS" type="text" onkeyup="editOpt('OPT_TWSK');" value="${pd.OPT_TWSK_SKGS}"/>
		                                                            </td>
		                                                            <td><input type="text" name="OPT_TWSK_TEMP" id="OPT_TWSK_TEMP" class="form-control" readonly="readonly"></td>
	                                                        	</tr>
	                                                        	<tr>
		                                                            <td>7</td>
		                                                            <td>厅外指纹识别</td>
		                                                            <td>
		                                                            	<font>控制楼名:</font>
		                                                                <input name="OPT_TWZW_KZLC" id="OPT_TWZW_KZLC" type="text" value="${pd.OPT_TWZW_KZLC}"/>
		                                                                <font>个数:</font>
		                                                                <input name="OPT_TWZW_KZGS" id="OPT_TWZW_KZGS" type="text" onkeyup="editOpt('OPT_TWZW');" value="${pd.OPT_TWZW_KZGS}"/>
		                                                            </td>
		                                                            <td><input type="text" name="OPT_TWZW_TEMP" id="OPT_TWSK_TEMP" class="form-control" readonly="readonly"></td>
	                                                        	</tr>
	                                                        	<tr>
		                                                            <td>8</td>
		                                                            <td>远程服务</td>
		                                                            <td>
		                                                                <input name="OPT_YCFW_TEXT" id="OPT_YCFW_TEXT" type="checkbox" onclick="editOpt('OPT_YCFW');"  ${pd.OPT_YCFW=='1'?'checked':''}/>
		                                                                <input type="hidden" name="OPT_YCFW" id="OPT_YCFW">
		                                                            </td>
		                                                            <td><input type="text" name="OPT_YCFW_TEMP" id="OPT_YCFW_TEMP" class="form-control" readonly="readonly"></td>
	                                                        	</tr>
	                                                        	<tr>
		                                                            <td>9</td>
		                                                            <td>故障历史记录</td>
		                                                            <td>
		                                                                <input name="OPT_GZLS_TEXT" id="OPT_GZLS_TEXT" type="checkbox" onclick="editOpt('OPT_GZLS');"  ${pd.OPT_GZLS=='1'?'checked':''}/>
		                                                                <input type="hidden" name="OPT_GZLS" id="OPT_GZLS">
		                                                            </td>
		                                                            <td><input type="text" name="OPT_GZLS_TEMP" id="OPT_GZLS_TEMP" class="form-control" readonly="readonly"></td>
	                                                        	</tr>
	                                                        	<tr>
		                                                            <td>10</td>
		                                                            <td>厅外指纹识别</td>
		                                                            <td>
		                                                            	<font>个数:</font>
		                                                                <input type="text" name="OPT_ZWSB" id="OPT_ZWSB" value="${pd.OPT_ZWSB}">
		                                                            </td>
		                                                            <td><input type="text" name="OPT_ZWSB_TEMP" id="OPT_ZWSB_TEMP" class="form-control" readonly="readonly"></td>
	                                                        	</tr>
	                                                        	<tr>
		                                                            <td>11</td>
		                                                            <td>真彩液晶显示</td>
		                                                            <td>
		                                                                <input name="OPT_ZCYJ_TEXT" id="OPT_ZCYJ_TEXT" type="checkbox" onclick="editOpt('OPT_GZLS');"  ${pd.OPT_ZCYJ=='1'?'checked':''}/>
		                                                                <input type="hidden" name="OPT_ZCYJ" id="OPT_ZCYJ">
		                                                            </td>
		                                                            <td><font color="red">请非标询价</font></td>
	                                                        	</tr>
	                                                        	<tr>
	                                                        </table>
                                                        </c:if>
                                                    <!-- 可选功能 -->
                                                </div>
                                                <div id="tab-4" class="tab-pane">
                                                    <!-- 机能 -->
                                                   	<table class="table table-striped table-bordered table-hover" border="1" cellspacing="0">
	                                                    <tr>
	                                                    	<td><label>机能模块</label></td>
	                                                    	<td colspan="2"><label>选项</label></td>
	                                                    	<td width="180px;"><label>加价</label></td>
	                                                    </tr>
		                                                <tr>
				                                            <td>联络配置</td>
				                                            <!-- A不加价，其他非标 -->
				                                            <td colspan="2">
						                                        <input name="JN_LLSZ" type="radio" value="单台" 
						                                        	onclick="editJN('JN_LLSZ');" ${pd.JN_LLSZ=='单台'?'checked':''}/>单台
						                                        	&nbsp;&nbsp;&nbsp;
						                                        <input name="JN_LLSZ" type="radio" value="多台(需提供数量)" 
						                                        	onclick="editJN('JN_LLSZ');" ${pd.JN_LLSZ=='多台(需提供数量)'?'checked':''}/>多台(需提供数量)
						                                        	&nbsp;&nbsp;&nbsp;
						                                        <input name="JN_LLSZ" type="radio" value="分组(需具体描述)" 
						                                        	onclick="editJN('JN_LLSZ');" ${pd.JN_LLSZ==''?'checked':''}/>分组(需具体描述)
				                                            </td>
				                                            <td><label style="color: red;display: none;" id="JN_LLSZ_Label">请非标询价</label></td>
		                                                </tr>
		                                                <tr>
				                                            <td>对讲系统</td>
				                                            <!-- B加价1000 -->
				                                            <td colspan="2">
						                                        <input name="JN_DJXT" type="radio" value="四方通话" 
						                                        	onclick="editJN('JN_DJXT');" ${pd.JN_DJXT=='四方通话'?'checked':''}/>四方通话
						                                        	&nbsp;
						                                        <input name="JN_DJXT" type="radio" value="五方通话" 
						                                        	onclick="editJN('JN_DJXT');" ${pd.JN_DJXT=='五方通话'?'checked':''}/>五方通话(需提供数量)
						                                        	&nbsp;
						                                        <input name="JN_DJXT" type="radio" value="T特殊" 
						                                        	onclick="editJN('JN_DJXT');" ${pd.JN_DJXT==''?'checked':''}/>T特殊
				                                            </td>
				                                            <td>
				                                            	<input name="JN_DJXT_TEMP" id="JN_DJXT_TEMP" type="text" 
				                                            		class="form-control" readonly="readonly"/>
				                                            </td>
		                                                </tr>
		                                                <tr>
				                                            <td>基站位置(楼名)</td>
				                                            <!-- 不计价  不输入则默认为N,COD导出注意-->
				                                            <td colspan="2">
		                                    					<p>在<input type="text" name = "JN_JZWZTEXT" id="JN_JZWZTEXT" value="N">楼</p>
				                                            </td>
				                                            <td></td>
		                                                </tr>
		                                                <tr>
				                                            <td>操作方式</td>
				                                            <!-- B,C加价2500/个，DE，加4000/个 -->
				                                            <td colspan="1">
						                                        <input name="JN_CZFS" type="radio" value="自动" 
						                                        	onclick="editJN('JN_CZFS');" ${pd.JN_CZFS=='自动'?'checked':''}/>自动
						                                        	&nbsp;
						                                        <input name="JN_CZFS" type="radio" value="轿内刷卡" 
						                                        	onclick="editJN('JN_CZFS');" ${pd.JN_CZFS=='轿内刷卡'?'checked':''}/>轿内刷卡
						                                        	&nbsp;
						                                        <input name="JN_CZFS" type="radio" value="厅外刷卡" 
						                                        	onclick="editJN('JN_CZFS');" ${pd.JN_CZFS==''?'checked':''}/>厅外刷卡&nbsp;
					                                        	<input name="JN_CZFS" type="radio" value="轿内指纹识别" 
						                                        	onclick="editJN('JN_CZFS');" ${pd.JN_CZFS==''?'checked':''}/>轿内指纹识别&nbsp;
					                                        	<input name="JN_CZFS" type="radio" value="厅外指纹识别" 
						                                        	onclick="editJN('JN_CZFS');" ${pd.JN_CZFS==''?'checked':''}/>厅外指纹识别
				                                            </td>
				                                            <td>
				                                        		控制楼层:<input name="JN_CZFSTEXT1" id="JN_CZFSTEXT1" value="${pd.JN_CZFSTEXT1}" disabled="disabled">
				                                        		个数:<input name="JN_CZFSTEXT2" id="JN_CZFSTEXT2" value="${pd.JN_CZFSTEXT2}" onkeyup="editJN('JN_CZFS');">
				                                            </td>
				                                            <td>
				                                            	<input name="JN_CZFS_TEMP" id="JN_CZFS_TEMP" type="text" 
				                                            		class="form-control" readonly="readonly"/>
				                                            </td>
		                                                </tr>
                                                    </table>
                                                    <!-- 机能END -->
                                                </div>
                                                <div id="tab-7" class="tab-pane">
                                                	<!-- A2各停站分布及厅门布置 -->
                                                	<table class="table table-striped table-bordered table-hover" border="1" cellspacing="0">
                                                		<tr>
                                                            <td colspan="7"><label>各停站分布及厅门布置</label></td>
                                                        </tr>
                                                        <tr>
                                                        	<td>层站</td>
                                                        	<td>底坑</td>
                                                        	<td>(1)</td>
                                                        	<td>(2)</td>
                                                        	<td>(3)</td>
                                                        	<td>(4)</td>
                                                        	<td>顶层</td>
                                                        </tr>
                                                        <tr>
                                                        	<td>层站间距(mm)</td>
                                                        	<td><input type="text" id="GTZFB_JJ1" onkeyup="editGTZFB();" name="GTZFB_JJ1"></td>
                                                        	<td><input type="text" id="GTZFB_JJ2"  name="GTZFB_JJ2"></td>
                                                        	<td><input type="text" id="GTZFB_JJ3" name="GTZFB_JJ3"></td>
                                                        	<td><input type="text" id="GTZFB_JJ4" name="GTZFB_JJ4"></td>
                                                        	<td><input type="text" id="GTZFB_JJ5" name="GTZFB_JJ5"></td>
                                                        	<td><input type="text" id="GTZFB_JJ6" name="GTZFB_JJ6"></td>
                                                        </tr>
                                                        <tr>
                                                        	<td>停站标记</td>
                                                        	<td><input type="text" id="GTZFB_BJ1" name="GTZFB_BJ1"></td>
                                                        	<td><input type="text" id="GTZFB_BJ2" name="GTZFB_BJ2"></td>
                                                        	<td><input type="text" id="GTZFB_BJ3" name="GTZFB_BJ3"></td>
                                                        	<td><input type="text" id="GTZFB_BJ4" name="GTZFB_BJ4"></td>
                                                        	<td><input type="text" id="GTZFB_BJ5" name="GTZFB_BJ5"></td>
                                                        	<td><input type="text" id="GTZFB_BJ6" name="GTZFB_BJ6"></td>
                                                        </tr>
                                                        <tr>
                                                        	<td colspan="1">加价</td>
                                                        	<td colspan="6">
                                                        		<input name="GTZFB_TEMP" id="GTZFB_TEMP" type="text" 
				                                            		class="form-control" readonly="readonly"/>
                                                        	</td>
                                                        </tr>
                                                        <tr>
                                                        	<td colspan="7">
                                                        		<font color="red">注:停站标记中如有盲层请加圈注明。如1、2、③、4,其中3为盲层</font>
                                                        	</td>
                                                        </tr>
                                                	</table>
                                                </div>
                                                <div id="tab-8" class="tab-pane">
                                                	<!-- 井道框架装饰 -->
                                                	<table class="table table-striped table-bordered table-hover" border="1" cellspacing="0">
                                                        <tr>
                                                            <td colspan="2"><label>井道框架装饰</label></td>
                                                            <td colspan="2"><label>选项</label></td>
                                                            <td style="width: 180px;"><label>加价</label></td>
                                                       	</tr>
                                                       	<tr>
                                                        	<td colspan="5" style="color: red">
                                                        		<label>注：框架井道宜安装在室内环境；如安装在室外，框架及电梯电气设备防水需用户自理。</label>
                                                        	</td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2">框架型材</td>
                                                            <td colspan="2">
                                                               	<select name=JDKJZS_KJXC id="JDKJZS_KJXC" class="form-control" style="width: 40%;" onchange="editJDKJ('KJXC')">
                                                                	<option value="" ${pd.JDKJZS_KJXC==''?'checked':''}>请选择</option>
                                                                	<option value="DBC-01米白色" ${pd.JDKJZS_KJXC=='DBC-01米白色'?'checked':''}>DBC-01米白色</option>
                                                                	<option value="DBC-02红棕色胡桃木纹" ${pd.JDKJZS_KJXC=='DBC-02红棕色胡桃木纹'?'checked':''}>DBC-02红棕色胡桃木纹</option>
                                                                	<option value="DBC-08香槟色" ${pd.JDKJZS_KJXC=='DBC-08香槟色'?'checked':''}>DBC-08香槟色</option>
                                                                	<option value="DBC-09银白氧化" ${pd.JDKJZS_KJXC=='DBC-09银白氧化'?'checked':''}>DBC-09银白氧化</option>
                                                                	<option value="DBC-11褐色樱桃木纹" ${pd.JDKJZS_KJXC=='DBC-11褐色樱桃木纹'?'checked':''}>DBC-11褐色樱桃木纹</option>
                                                                	<option value="DBC-12玫瑰金色" ${pd.JDKJZS_KJXC=='DBC-12玫瑰金色'?'checked':''}>DBC-12玫瑰金色</option>
                                                                	<option value="DBC-16黑色亚光" ${pd.JDKJZS_KJXC=='DBC-16黑色亚光'?'checked':''}>DBC-16黑色亚光</option>
                                                                	<option value="DBC-10黑色亮光" ${pd.JDKJZS_KJXC=='DBC-10黑色亮光'?'checked':''}>DBC-10黑色亮光</option>
                                                                </select>
                                                            </td>
                                                            <td>
                                                            	<input type="text" class="form-control" id="JDKJZS_KJXC_TEMP" 
                                                            		name="JDKJZS_KJXC_TEMP"readonly="readonly">
                                                            </td>
                                                        </tr>	
                                                        
                                                        <!-- ----开始 -->
                                                        	<tr>
																<td rowspan="16" style="width: 12%;">井道框架装饰</td>
																<td rowspan="4" style="width: 10%;">左侧壁</td>
															</tr>
															<tr>
																<td><p style="font-weight: bold;">
																		<input name="JDKJZS_RADIOLEFT" type="radio" onclick="editJDKJ('JDKJZS_RADIOLEFT');" 
																			value="玻璃" ${pd.JDKJZS_RADIOLEFT=='玻璃'?'checked':''}/>玻璃:
																	</p>
																	<select name="JDKJZS_LEFT1" id="JDKJZS_LEFT1" style="width: 40%;" class="form-control" disabled="disabled" onchange="editJDKJ('LEFT');">
		                                                        		<option value="" ${pd.JDKJZS_LEFT==''?'selected':'' }>请选择</option>
		                                                        		<option value="DBM-73蒙砂玻璃" ${pd.JDKJZS_LEFT=='DBM-73蒙砂玻璃'?'selected':'' }>DBM-73蒙砂玻璃</option>
		                                                        		<option value="DBM-74白色丝印" ${pd.JDKJZS_LEFT=='DBM-74白色丝印'?'selected':'' }>DBM-74白色丝印</option>
		                                                        		<option value="DBM-01透明玻璃" ${pd.JDKJZS_LEFT=='DBM-01透明玻璃'?'selected':'' }>DBM-01透明玻璃</option>
		                                                        		<option value="DBM-122凤尾" ${pd.JDKJZS_LEFT=='DBM-122凤尾'?'selected':'' }>DBM-122凤尾</option>
		                                                        	</select>
																</td>
																<td rowspan="16" colspan="2">
																	<input type="text" name="JDKJZS_TEMP" id="JDKJZS_TEMP" 
	                                                          			class="form-control" readonly="readonly">
	                                                          		<input hidden="hiddden" id = "JDKJZS_LEFT" name = "JDKJZS_LEFT">
                                                          			<input hidden="hiddden" id = "JDKJZS_RIGHT" name = "JDKJZS_RIGHT">
                                                          			<input hidden="hiddden" id = "JDKJZS_BACK" name = "JDKJZS_BACK">
                                                          			<input hidden="hiddden" id = "JDKJZS_AHEAD" name = "JDKJZS_AHEAD">
                                                         		</td>
															</tr>
															<tr>
																<td><p style="font-weight: bold;">
																		<input name="JDKJZS_RADIOLEFT" type="radio" onclick="editJDKJ('JDKJZS_RADIOLEFT');" 
																			value="框架玻璃用户自理" ${pd.JDKJZS_RADIOLEFT=='框架玻璃用户自理'?'checked':''}/>框架玻璃用户自理:
																	</p>
																	<input type="text" name="JDKJZS_YHZL_LEFT" id="JDKJZS_YHZL_LEFT" onkeyup="editJDKJ('LEFT')"
																		disabled="disabled" style="width: 40%;" value="${pd.JDKJZS_LEFT}" class="form-control">
                                                         		</td>
															</tr>
															<tr>
																<td><p style="font-weight: bold;">
																		<input name="JDKJZS_RADIOLEFT" type="radio" onclick="editJDKJ('JDKJZS_RADIOLEFT');" 
																			value="密度板" ${pd.JDKJZS_RADIOLEFT=='密度板'?'checked':''}/>密度板:
																	</p>
																	<select name="JDKJZS_LEFT3" id="JDKJZS_LEFT3" style="width: 40%;" class="form-control" disabled="disabled" onchange="editJDKJ('LEFT')">
		                                                        		<option value="" ${pd.JDKJZS_LEFT==''?'selected':'' }>请选择</option>
		                                                        		<option value="DBB-01印象阳光" ${pd.JDKJZS_LEFT=='DBB-01印象阳光'?'selected':'' }>DBB-01印象阳光</option>
		                                                        		<option value="DBB-03雪后草原" ${pd.JDKJZS_LEFT=='DBB-03雪后草原'?'selected':'' }>DBB-03雪后草原</option>
		                                                        		<option value="DBB-06世纪通道" ${pd.JDKJZS_LEFT=='DBB-06世纪通道'?'selected':'' }>DBB-06世纪通道</option>
		                                                        		<option value="DBB-12竹叶弄影" ${pd.JDKJZS_LEFT=='DBB-12竹叶弄影'?'selected':'' }>DBB-12竹叶弄影</option>
		                                                        		<option value="DBB-16银色月痕" ${pd.JDKJZS_LEFT=='DBB-16银色月痕'?'selected':'' }>DBB-16银色月痕</option>
		                                                        	</select>
																</td>
															</tr>
															<tr>
																<td rowspan="4" style="width: 10%;">右侧壁</td>
															</tr>
															<tr>
																<td><p style="font-weight: bold;">
																		<input name="JDKJZS_RADIORIGHT" type="radio" onclick="editJDKJ('JDKJZS_RADIORIGHT');" 
																			value="玻璃" ${pd.JDKJZS_RADIORIGHT=='玻璃'?'checked':''}/>玻璃:
																	</p>
																	<select name="JDKJZS_RIGHT1" id="JDKJZS_RIGHT1" style="width: 40%;" class="form-control" disabled="disabled" onchange="editJDKJ('RIGHT')">
		                                                        		<option value="" ${pd.JDKJZS_RIGHT1==''?'selected':'' }>请选择</option>
		                                                        		<option value="DBM-73蒙砂玻璃" ${pd.JDKJZS_RIGHT=='DBM-73蒙砂玻璃'?'selected':'' }>DBM-73蒙砂玻璃</option>
		                                                        		<option value="DBM-74白色丝印" ${pd.JDKJZS_RIGHT=='DBM-74白色丝印'?'selected':'' }>DBM-74白色丝印</option>
		                                                        		<option value="DBM-01透明玻璃" ${pd.JDKJZS_RIGHT=='DBM-01透明玻璃'?'selected':'' }>DBM-01透明玻璃</option>
		                                                        		<option value="DBM-122凤尾" ${pd.JDKJZS_RIGHT=='DBM-122凤尾'?'selected':'' }>DBM-122凤尾</option>
		                                                        	</select>
																</td>
															</tr>
															<tr>
																<td><p style="font-weight: bold;">
																		<input name="JDKJZS_RADIORIGHT" type="radio" onclick="editJDKJ('JDKJZS_RADIORIGHT');" 
																			value="框架玻璃用户自理" ${pd.JDKJZS_RADIORIGHT=='框架玻璃用户自理'?'checked':''}/>框架玻璃用户自理:
																	</p>
																	<input type="text" name="JDKJZS_YHZL_RIGHT" id="JDKJZS_YHZL_RIGHT" onkeyup="editJDKJ('RIGHT')"
	                                                          			disabled="disabled" style="width: 40%;" value="${pd.JDKJZS_RIGHT}" class="form-control">
                                                         		</td>
															</tr>
															<tr>
																<td><p style="font-weight: bold;">
																		<input name="JDKJZS_RADIORIGHT" type="radio" onclick="editJDKJ('JDKJZS_RADIORIGHT');" 
																			value="密度板" ${pd.JDKJZS_RADIORIGHT=='密度板'?'checked':''}/>密度板:
																	</p>
																	<select name="JDKJZS_RIGHT3" id="JDKJZS_RIGHT3" style="width: 40%;" class="form-control" disabled="disabled" onchange="editJDKJ('RIGHT')">
		                                                        		<option value="" ${pd.JDKJZS_RIGHT3==''?'selected':'' }>请选择</option>
		                                                        		<option value="DBB-01印象阳光" ${pd.JDKJZS_RIGHT=='DBB-01印象阳光'?'selected':'' }>DBB-01印象阳光</option>
		                                                        		<option value="DBB-03雪后草原" ${pd.JDKJZS_RIGHT=='DBB-03雪后草原'?'selected':'' }>DBB-03雪后草原</option>
		                                                        		<option value="DBB-06世纪通道" ${pd.JDKJZS_RIGHT=='DBB-06世纪通道'?'selected':'' }>DBB-06世纪通道</option>
		                                                        		<option value="DBB-12竹叶弄影" ${pd.JDKJZS_RIGHT=='DBB-12竹叶弄影'?'selected':'' }>DBB-12竹叶弄影</option>
		                                                        		<option value="DBB-16银色月痕" ${pd.JDKJZS_RIGHT=='DBB-16银色月痕'?'selected':'' }>DBB-16银色月痕</option>
		                                                        	</select>
																</td>
															</tr>
															<tr>
																<td rowspan="4" style="width: 10%;">后  壁</td>
															</tr>
															<tr>
																<td><p style="font-weight: bold;">
																		<input name="JDKJZS_RADIOBACK" type="radio" onclick="editJDKJ('JDKJZS_RADIOBACK');" 
																			value="玻璃" ${pd.JDKJZS_RADIOBACK=='玻璃'?'checked':''}/>玻璃:
																	</p>
																	<select name="JDKJZS_BACK1" id="JDKJZS_BACK1" style="width: 40%;" class="form-control" disabled="disabled" onchange="editJDKJ('BACK')">
		                                                        		<option value="" ${pd.JDKJZS_BACK==''?'selected':'' }>请选择</option>
		                                                        		<option value="DBM-73蒙砂玻璃" ${pd.JDKJZS_BACK=='DBM-73蒙砂玻璃'?'selected':'' }>DBM-73蒙砂玻璃</option>
		                                                        		<option value="DBM-74白色丝印" ${pd.JDKJZS_BACK=='DBM-74白色丝印'?'selected':'' }>DBM-74白色丝印</option>
		                                                        		<option value="DBM-01透明玻璃" ${pd.JDKJZS_BACK=='DBM-01透明玻璃'?'selected':'' }>DBM-01透明玻璃</option>
		                                                        		<option value="DBM-122凤尾" ${pd.JDKJZS_BACK=='DBM-122凤尾'?'selected':'' }>DBM-122凤尾</option>
		                                                        	</select>
																</td>
															</tr>
															<tr>
																<td><p style="font-weight: bold;">
																		<input name="JDKJZS_RADIOBACK" type="radio" onclick="editJDKJ('JDKJZS_RADIOBACK');" 
																			value="框架玻璃用户自理" ${pd.JDKJZS_RADIOBACK=='框架玻璃用户自理'?'checked':''}/>框架玻璃用户自理:
																	</p>
																	<input type="text" name="JDKJZS_YHZL_BACK" id="JDKJZS_YHZL_BACK" onkeyup="editJDKJ('BACK')"
	                                                          			disabled="disabled" style="width: 40%;" value="${pd.JDKJZS_BACK}"	class="form-control">
                                                         		</td>
															</tr>
															<tr>
																<td><p style="font-weight: bold;">
																		<input name="JDKJZS_RADIOBACK" type="radio" onclick="editJDKJ('JDKJZS_RADIOBACK');" 
																			value="密度板" ${pd.JDKJZS_RADIOBACK=='密度板'?'checked':''}/>密度板:
																	</p>
																	<select name="JDKJZS_BACK3" id="JDKJZS_BACK3" style="width: 40%;" class="form-control" disabled="disabled" onchange="editJDKJ('BACK')">
		                                                        		<option value="" ${pd.JDKJZS_BACK==''?'selected':'' }>请选择</option>
		                                                        		<option value="DBB-01印象阳光" ${pd.JDKJZS_BACK=='DBB-01印象阳光'?'selected':'' }>DBB-01印象阳光</option>
		                                                        		<option value="DBB-03雪后草原" ${pd.JDKJZS_BACK=='DBB-03雪后草原'?'selected':'' }>DBB-03雪后草原</option>
		                                                        		<option value="DBB-06世纪通道" ${pd.JDKJZS_BACK=='DBB-06世纪通道'?'selected':'' }>DBB-06世纪通道</option>
		                                                        		<option value="DBB-12竹叶弄影" ${pd.JDKJZS_BACK=='DBB-12竹叶弄影'?'selected':'' }>DBB-12竹叶弄影</option>
		                                                        		<option value="DBB-16银色月痕" ${pd.JDKJZS_BACK=='DBB-16银色月痕'?'selected':'' }>DBB-16银色月痕</option>
		                                                        	</select>
																</td>
															</tr>
															<tr>
																<td rowspan="4" style="width: 10%;">前  壁</td>
															</tr>
															<tr>
																<td><p style="font-weight: bold;">
																		<input name="JDKJZS_RADIOAHEAD" type="radio" onclick="editJDKJ('JDKJZS_RADIOAHEAD');" 
																			value="玻璃" ${pd.JDKJZS_RADIOAHEAD=='玻璃'?'checked':''}/>玻璃:
																	</p>
																	<select name="JDKJZS_AHEAD1" id="JDKJZS_AHEAD1" style="width: 40%;" class="form-control" disabled="disabled" onchange="editJDKJ('AHEAD')">
		                                                        		<option value="" ${pd.JDKJZS_AHEAD1==''?'selected':'' }>请选择</option>
		                                                        		<option value="DBM-73蒙砂玻璃" ${pd.JDKJZS_AHEAD=='DBM-73蒙砂玻璃'?'selected':'' }>DBM-73蒙砂玻璃</option>
		                                                        		<option value="DBM-74白色丝印" ${pd.JDKJZS_AHEAD=='DBM-74白色丝印'?'selected':'' }>DBM-74白色丝印</option>
		                                                        		<option value="DBM-01透明玻璃" ${pd.JDKJZS_AHEAD=='DBM-01透明玻璃'?'selected':'' }>DBM-01透明玻璃</option>
		                                                        		<option value="DBM-122凤尾" ${pd.JDKJZS_AHEAD=='DBM-122凤尾'?'selected':'' }>DBM-122凤尾</option>
		                                                        	</select>
																</td>
															</tr>
															<tr>
																<td><p style="font-weight: bold;">
																		<input name="JDKJZS_RADIOAHEAD" type="radio" onclick="editJDKJ('JDKJZS_RADIOAHEAD');" 
																			value="框架玻璃用户自理" ${pd.JDKJZS_RADIOAHEAD=='框架玻璃用户自理'?'checked':''}/>框架玻璃用户自理:
																	</p>
																	<input type="text" name="JDKJZS_YHZL_AHEAD" id="JDKJZS_YHZL_AHEAD" onkeyup="editJDKJ('AHEAD')"
	                                                          			disabled="disabled" style="width: 40%;" value="${pd.JDKJZS_AHEAD}"	class="form-control">
                                                         		</td>
															</tr>
															<tr>
																<td><p style="font-weight: bold;">
																		<input name="JDKJZS_RADIOAHEAD" type="radio" onclick="editJDKJ('JDKJZS_RADIOAHEAD');" 
																			value="密度板" ${pd.JDKJZS_RADIOAHEAD=='密度板'?'checked':''}/>密度板:
																	</p>
																	<select name="JDKJZS_AHEAD3" id="JDKJZS_AHEAD3" style="width: 40%;" class="form-control" disabled="disabled" onchange="editJDKJ('AHEAD')">
		                                                        		<option value="" ${pd.JDKJZS_AHEAD==''?'selected':'' }>请选择</option>
		                                                        		<option value="DBB-01印象阳光" ${pd.JDKJZS_AHEAD=='DBB-01印象阳光'?'selected':'' }>DBB-01印象阳光</option>
		                                                        		<option value="DBB-03雪后草原" ${pd.JDKJZS_AHEAD=='DBB-03雪后草原'?'selected':'' }>DBB-03雪后草原</option>
		                                                        		<option value="DBB-06世纪通道" ${pd.JDKJZS_AHEAD=='DBB-06世纪通道'?'selected':'' }>DBB-06世纪通道</option>
		                                                        		<option value="DBB-12竹叶弄影" ${pd.JDKJZS_AHEAD=='DBB-12竹叶弄影'?'selected':'' }>DBB-12竹叶弄影</option>
		                                                        		<option value="DBB-16银色月痕" ${pd.JDKJZS_AHEAD=='DBB-16银色月痕'?'selected':'' }>DBB-16银色月痕</option>
		                                                        	</select>
																</td>
															</tr>
                                                        	<!-- ------井道框架装饰结束 -->
                                                	</table>
                                                </div>
                                                <div id="tab-5" class="tab-pane">
                                                    <!-- 轿厢装潢 -->
                                                    <c:if test="${modelsPd.ele_type=='DT12'}">
                                                        <table class="table table-striped table-bordered table-hover" border="1" cellspacing="0">
                                                          <tr>
                                                            <td colspan="2"><label>轿厢装潢模块</label></td>
                                                            <td colspan="2"><label>选项</label></td>
                                                            <td style="width: 180px;"><label>加价</label></td>
                                                          </tr>
                                                           <tr>
                                                            <td colspan="2">轿厢地板</td>
                                                            <!-- 不加价 -->
                                                            <td colspan="2">
                                                                <input name="JXZH_JXDB" type="radio" value="PVC 塑胶地砖(标准)" 
                                                                	onclick="editJxzh('JXZH_JXDB');" ${pd.JXZH_JXDB=='PVC 塑胶地砖(标准)'?'checked':''}/>PVC 塑胶地砖(标准)
                                                            		&nbsp;
                                                                <input name="JXZH_JXDB" type="radio" value="MBL 20mm大理石(选项规格)" 
                                                                	onclick="editJxzh('JXZH_JXDB');" ${pd.JXZH_JXDB=='MBL 20mm大理石(选项规格)'?'checked':''}/>MBL 20mm大理石(选项规格)
                                                            		&nbsp;
                                                                <input name="JXZH_JXDB" type="radio" value="" 
                                                                	onclick="editJxzh('JXZH_JXDB');" ${pd.JXZH_JXDB==''?'checked':''}/>特殊
                                                               	<input name="JXZH_JXDB" type="radio" value="客户自理" 
                                                                	onclick="editJxzh('JXZH_JXDB');" ${pd.JXZH_JXDBTEXT!=''&&JXZH_JXDBTEXT!=null?'checked':''}/>客户自理
                                                               	<input id = "JXZH_JXDBTEXT" name="JXZH_JXDBTEXT" type="text" value="${pd.JXZH_JXDB}" disabled="disabled"/>
                                                               	<!-- 如果选择客户自理则保存'客户自理'+TEXT输入内容 -->
                                                            </td>
                                                            <td></td>
                                                          </tr>
                                                          <tr>
                                                          	<td colspan="2">地板样式编码</td>
                                                          	<td colspan="2">
                                                          		标准PVC规格:
                                                          		<select name='JXZH_DBYSBM1' id="JXZH_DBYSBM1" style="width: 18%;" onchange="editJxzh('JXZH_DBYSBM1');" class="form-control">
                                                                    <option value="">请选择</option> 
                                                                    <option value="DBF-01" ${pd.JXZH_DBYSBM=='DBF-01'?'selected':''}>DBF-01</option>
                                                                    <option value="DBF-02" ${pd.JXZH_DBYSBM=='DBF-02'?'selected':''}>DBF-02</option>
                                                                    <option value="DBF-05" ${pd.JXZH_DBYSBM=='DBF-05'?'selected':''}>DBF-05</option>
                                                                    <option value="DBF-06" ${pd.JXZH_DBYSBM=='DBF-06'?'selected':''}>DBF-06</option>
                                                                </select>
                                                       			&nbsp;单色大理石选项规格:
                                                       			<select name='JXZH_DBYSBM2' id="JXZH_DBYSBM2" style="width: 18%;" onchange="editJxzh('JXZH_DBYSBM2');" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="DBF-11" ${pd.JXZH_DBYSBM=='DBF-11'?'selected':''}>DBF-11</option>
                                                                    <option value="DBF-12" ${pd.JXZH_DBYSBM=='DBF-12'?'selected':''}>DBF-12</option>
                                                                    <option value="DBF-13" ${pd.JXZH_DBYSBM=='DBF-13'?'selected':''}>DBF-13</option>
                                                                    <option value="DBF-16" ${pd.JXZH_DBYSBM=='DBF-16'?'selected':''}>DBF-16</option>
                                                                    <option value="DBF-10" ${pd.JXZH_DBYSBM=='DBF-10'?'selected':''}>DBF-10</option>
                                                                    <option value="DBF-18" ${pd.JXZH_DBYSBM=='DBF-18'?'selected':''}>DBF-18</option>
                                                                    <option value="DBF-22" ${pd.JXZH_DBYSBM=='DBF-22'?'selected':''}>DBF-22</option>
                                                                    <option value="DBF-112" ${pd.JXZH_DBYSBM=='DBF-112'?'selected':''}>DBF-112</option>
                                                                    <option value="DBF-113" ${pd.JXZH_DBYSBM=='DBF-113'?'selected':''}>DBF-113</option>
                                                                    <option value="DBF-114" ${pd.JXZH_DBYSBM=='DBF-114'?'selected':''}>DBF-114</option>
                                                                    <option value="DBF-115" ${pd.JXZH_DBYSBM=='DBF-115'?'selected':''}>DBF-115</option>
                                                                    <option value="DBF-132" ${pd.JXZH_DBYSBM=='DBF-132'?'selected':''}>DBF-132</option>
                                                                </select>
                                                                &nbsp;拼花大理石选项规格:
                                                       			<select name='JXZH_DBYSBM3' id="JXZH_DBYSBM3" style="width: 18%;" onchange="editJxzh('JXZH_DBYSBM3');" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="DBF-106" ${pd.JXZH_DBYSBM=='DBF-106'?'selected':''}>DBF-106</option>
                                                                    <option value="DBF-107" ${pd.JXZH_DBYSBM=='DBF-107'?'selected':''}>DBF-107</option>
                                                                    <option value="DBF-108" ${pd.JXZH_DBYSBM=='DBF-108'?'selected':''}>DBF-108</option>
                                                                    <option value="DBF-109" ${pd.JXZH_DBYSBM=='DBF-109'?'selected':''}>DBF-109</option>
                                                                </select>
                                                          	</td>
                                                          	<td>
                                                          		<input type="hidden" id="JXZH_DBYSBM" name="JXZH_DBYSBM">
                                                          		<input type="text" name="JXZH_DBYSBM_TEMP" id="JXZH_DBYSBM_TEMP" 
                                                          			class="form-control" readonly="readonly">
                                                          	</td>
                                                          </tr>
                                                          <tr>
                                                          	<td colspan="2" row>吊顶型号</td>
                                                          	<!-- 钛金镜面加价1500 -->
                                                          	<td colspan="2">
                                                          		标配规格(不锈钢镜面):
                                                          		<select name='JXZH_DDXH1' id="JXZH_DDXH1" style="width: 18%;" onchange="editJxzh('JXZH_DDXH1');" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="DBD-01" ${pd.JXZH_DDXH=='DBF-01'?'selected':''}>DBF-01</option>
                                                                    <option value="DBD-05" ${pd.JXZH_DDXH=='DBF-02'?'selected':''}>DBF-02</option>
                                                                    <option value="DBD-82" ${pd.JXZH_DDXH=='DBF-05'?'selected':''}>DBF-05</option>
                                                                </select>
                                                       			&nbsp;&nbsp;选项规格(钛金镜面):
                                                       			<select name='JXZH_DDXH2' id="JXZH_DDXH2" style="width: 18%;" onchange="editJxzh('JXZH_DDXH2');" class="form-control">
                                                                    <option value="">请选择</option>
                                                                    <option value="DBD-09" ${pd.JXZH_DDXH=='DBD-09'?'selected':''}>DBD-09</option>
                                                                    <option value="DBD-16" ${pd.JXZH_DDXH=='DBD-16'?'selected':''}>DBD-16</option>
                                                                    <option value="DBD-83" ${pd.JXZH_DDXH=='DBD-83'?'selected':''}>DBD-83</option>
                                                                </select>
                                                          	</td>
                                                          	<td>
                                                          		<input type="hidden" id="JXZH_DDXH" name="JXZH_DDXH">
                                                          		<input type="text" name="JXZH_DDXH_TEMP" id="JXZH_DDXH_TEMP" 
                                                          			class="form-control" readonly="readonly">
                                                          	</td>
                                                          </tr>
                                                          <tr>
                                                          	<td colspan="2">轿门规格</td>
                                                          	<td colspan="2">
                                                          		<select name='JXZH_JMGG' id="JXZH_JMGG" onchange="editJxzh('JXZH_JMGG');" class="form-control" style="width: 18%;">
                                                          		<!-- SUS：不计价,SPP不加价，其他选项价格以下方选项型号加价为准 -->
                                                                    <option value="">请选择</option>
                                                                    <option value="发纹(标准)" ${pd.JXZH_JMGG=='发纹(标准)'?'selected':''}>发纹(标准)</option>
                                                                    <option value="喷漆" ${pd.JXZH_JMGG=='喷漆'?'selected':''}>喷漆</option>
                                                                    <option value="其他选项规格" ${pd.JXZH_JMGG=='其他选项规格'?'selected':''}>其他选项规格</option>
                                                                </select>
                                                          	</td>
                                                          	<td></td>
                                                          </tr>
                                                          <tr>
                                                          	<td colspan="2">喷漆颜色(轿门)</td>
                                                          	<td colspan="2">
                                                          		<select name='JXZH_PQYS_JM' id="JXZH_PQYS_JM" class="form-control" style="width: 18%;">
                                                          		<!-- 不计价 -->
                                                                    <option value="">请选择</option>
                                                                    <option value="RAL7032" ${pd.JXZH_PQYS_JM=='RAL7032'?'selected':''}>RAL7032</option>
                                                                    <option value="RAL7035" ${pd.JXZH_PQYS_JM=='RAL7035'?'selected':''}>RAL7035</option>                                
                                                                </select>
                                                          	</td>
                                                          	<td></td>
                                                          </tr>
                                                          <tr>
                                                          	<td colspan="2">选项型号(轿门)</td>
                                                          	<!-- 所有选项型号价格均为2650 -->
                                                          	 <td colspan="2">
                                                          		<select name='JXZH_XXXH_JM' id="JXZH_XXXH_JM" onchange="editJxzh('JXZH_XXXH_JM');" class="form-control" style="width: 18%;">
                                                                    <option value="">请选择</option>
                                                                    <option value="DBM-108" ${pd.JXZH_XXXH_JM=='DBM-108'?'selected':''}>DBM-108</option>
                                                                    <option value="DBM-110" ${pd.JXZH_XXXH_JM=='DBM-110'?'selected':''}>DBM-110</option>
                                                                    <option value="DBM-111" ${pd.JXZH_XXXH_JM=='DBM-111'?'selected':''}>DBM-111</option>
                                                                    <option value="DBM-112" ${pd.JXZH_XXXH_JM=='DBM-112'?'selected':''}>DBM-112</option>
                                                                    <option value="DBM-114" ${pd.JXZH_XXXH_JM=='DBM-114'?'selected':''}>DBM-114</option>
                                                                    <option value="DBM-115" ${pd.JXZH_XXXH_JM=='DBM-115'?'selected':''}>DBM-115</option>
                                                                    <option value="DBM-126" ${pd.JXZH_XXXH_JM=='DBM-126'?'selected':''}>DBM-126</option>
                                                                    <option value="DBM-128" ${pd.JXZH_XXXH_JM=='DBM-128'?'selected':''}>DBM-128</option>
                                                                </select>
                                                          	</td>
                                                          	<td>
                                                          		<input type="text" name="JXZH_XXXH_JM_TEMP" id="JXZH_XXXH_JM_TEMP" 
                                                          			class="form-control" readonly="readonly">
                                                          	</td>
                                                          </tr>
                                                          <tr>
                                                          	<td colspan="2">轿厢规格</td>
                                                          	<td colspan="2">
                                                          		<select name='JXZH_JMGG' id="JXZH_JXGG" onchange="editJxzh('JXZH_JXGG');" class="form-control" style="width: 18%;">
                                                          		<!-- SUS：不计价,SPP不加价，其他选项价格以下方选项型号加价为准 -->
                                                                    <option value="">请选择</option>
                                                                    <option value="发纹(标准)" ${pd.JXZH_JXGG=='发纹(标准)'?'selected':''}>发纹(标准)</option>
                                                                    <option value="喷漆" ${pd.JXZH_JXGG=='喷漆'?'selected':''}>喷漆</option>
                                                                    <option value="其他选项规格" ${pd.JXZH_JXGG=='其他选项规格'?'selected':''}>其他选项规格</option>
                                                                </select>
                                                          	</td>
                                                          	<td></td>
                                                          </tr>
                                                          
                                                          <tr>
                                                          	<td colspan="2">喷漆颜色(轿厢)</td>
                                                          	<td colspan="2">
                                                          		<select name='JXZH_PQYS_JX' id="JXZH_PQYS_JX" class="form-control" style="width: 18%;">
                                                          		<!-- 不计价 -->
                                                                    <option value="">请选择</option>
                                                                    <option value="RAL7032" ${pd.JXZH_PQYS_JX=='RAL7032'?'selected':''}>RAL7032</option>
                                                                    <option value="RAL7035" ${pd.JXZH_PQYS_JX=='RAL7035'?'selected':''}>RAL7035</option>                                
                                                                </select>
                                                          	</td>
                                                          	<td></td>
                                                          </tr>
                                                          <tr>
                                                          	<td colspan="2">选项型号(轿厢)</td>
                                                          	<!-- 加价 DLC-43:56700 DLC-97:19000 DLC-99:15000 DLC-100:22000 DLC-102:17000
																 DLC-103:17000 DLC-104:19600 DLC-115:11500 DLC-120:43500 DLC-122:41500
                                                          	 -->
                                                          	 <td colspan="2">
                                                          		<select name='JXZH_XXXH_JX' id="JXZH_XXXH_JX" onchange="editJxzh('JXZH_XXXH_JX');" class="form-control" style="width: 18%;">
                                                                    <option value="">请选择</option>
                                                                    <option value="DLC-43" ${pd.JXZH_XXXH_JX=='DLC-43'?'selected':''}>DLC-43</option>
                                                                    <option value="DLC-97" ${pd.JXZH_XXXH_JX=='DLC-97'?'selected':''}>DLC-97</option>
                                                                    <option value="DLC-99" ${pd.JXZH_XXXH_JX=='DLC-99'?'selected':''}>DLC-99</option>
                                                                    <option value="DLC-100" ${pd.JXZH_XXXH_JX=='DLC-100'?'selected':''}>DLC-100</option>
                                                                    <option value="DLC-102" ${pd.JXZH_XXXH_JX=='DLC-102'?'selected':''}>DLC-102</option>
                                                                    <option value="DLC-103" ${pd.JXZH_XXXH_JX=='DLC-103'?'selected':''}>DLC-103</option>
                                                                    <option value="DLC-104" ${pd.JXZH_XXXH_JX=='DLC-104'?'selected':''}>DLC-104</option>
                                                                    <option value="DLC-115" ${pd.JXZH_XXXH_JX=='DLC-115'?'selected':''}>DLC-115</option>
                                                                    <option value="DLC-120" ${pd.JXZH_XXXH_JX=='DLC-120'?'selected':''}>DLC-120</option>
                                                                    <option value="DLC-122" ${pd.JXZH_XXXH_JX=='DLC-122'?'selected':''}>DLC-122</option>
                                                                </select>
                                                          	</td>
                                                          	<td>
                                                          		<input type="text" name="JXZH_XXXH_JX_TEMP" id="JXZH_XXXH_JX_TEMP" 
                                                          			class="form-control" readonly="readonly">
                                                          	</td>
                                                          </tr>
                                                          <tr>
                                                          	<td colspan="2">前壁规格</td>
                                                          	<!-- SUS,SPP不加价，其他1500（如轿厢规格选项型号已加价，则此处无需加价） -->
                                                          	<td colspan="2">
                                                          		<input name="JXZH_QBGG" type="radio" value="发纹(标准)" 
                                                          			onclick="editJxzh('JXZH_QBGG');"  ${pd.JXZH_QBGG=='发纹(标准)'?'checked':''}/>发纹(标准)&nbsp;
                                                          		<input name="JXZH_QBGG" type="radio" value="喷漆" 
                                                          			onclick="editJxzh('JXZH_QBGG');"  ${pd.JXZH_QBGG=='喷漆'?'checked':''}/>喷漆&nbsp;
                                                          		<input name="JXZH_QBGG" type="radio" value="不锈钢镜面" 
                                                          			onclick="editJxzh('JXZH_QBGG');"  ${pd.JXZH_QBGG=='不锈钢镜面'?'checked':''}/>不锈钢镜面&nbsp;
                                                          		<input name="JXZH_QBGG" type="radio" value="钛金镜面" 
                                                          			onclick="editJxzh('JXZH_QBGG');"  ${pd.JXZH_QBGG=='钛金镜面'?'checked':''}/>钛金镜面&nbsp;
                                                          		<input name="JXZH_QBGG" type="radio" value="化妆钢板" 
                                                          			onclick="editJxzh('JXZH_QBGG');"  ${pd.JXZH_QBGG=='化妆钢板'?'checked':''}/>化妆钢板&nbsp;
                                                          		<input name="JXZH_QBGG" type="radio" value="玫瑰金镜面" 
                                                          			onclick="editJxzh('JXZH_QBGG');"  ${pd.JXZH_QBGG=='玫瑰金镜面'?'checked':''}/>玫瑰金镜面
                                                          	</td>
                                                          	<td>
                                                          		<input type="text" name="JXZH_QBGG_TEMP" id="JXZH_QBGG_TEMP" 
                                                          			class="form-control" readonly="readonly">
                                                          	</td>
                                                          </tr>
                                                          <tr>
                                                          	<td colspan="2">样式规格</td>
                                                          	<!-- 不计价 -->
                                                          	<td colspan="2">
                                                          		<input name="JXZH_YSGG" type="radio" value="RAL7032" ${pd.JXZH_YSGG=='RAL7032'?'checked':''}/>RAL7032&nbsp;
                                                          		<input name="JXZH_YSGG" type="radio" value="RAL7035" ${pd.JXZH_YSGG=='RAL7035'?'checked':''}/>RAL7035&nbsp;
                                                          		<input name="JXZH_YSGG" type="radio" value="B108胡桃木纹" ${pd.JXZH_YSGG=='B108胡桃木纹'?'checked':''}/>B108胡桃木纹&nbsp;
                                                          		<input name="JXZH_YSGG" type="radio" value="C105金葱木纹" ${pd.JXZH_YSGG=='C105金葱木纹'?'checked':''}/>C105金葱木纹&nbsp;
                                                          		<input name="JXZH_YSGG" type="radio" value="C127金丝铂" ${pd.JXZH_YSGG=='C127金丝铂'?'checked':''}/>C127金丝铂&nbsp;
                                                          		<input name="JXZH_YSGG" type="radio" value="103红木纹" ${pd.JXZH_YSGG=='103红木纹'?'checked':''}/>103红木纹
                                                          	</td>
                                                          	<td></td>
                                                          </tr>
                                                          <tr>
                                                          	<td colspan="2">扶手形式</td>
                                                          	<!-- 不计价 -->
                                                          	<td colspan="2">
                                                          		<input name="JXZH_FSXS" type="radio" value="N" ${pd.JXZH_FSXS=='N'?'checked':''}/>N&nbsp;
                                                          		<input name="JXZH_FSXS" type="radio" value="后侧扶手" ${pd.JXZH_FSXS=='后侧扶手'?'checked':''}/>后侧扶手&nbsp;
                                                          	</td>
                                                          	<td></td>
                                                          </tr>
                                                          <tr>
                                                          	<td colspan="2">扶手数量</td>
                                                          	<!-- 1个不加价，每加一个500 -->
                                                          	<td colspan="2">
                                                          		<input name="JXZH_FSSL" id="JXZH_FSSL" type="text" style="width: 18%;" value="${pd.JXZH_FSSL}" onkeyup="editJxzh('JXZH_FSSL');" />
                                                          	</td>
                                                          	<td>
                                                          		<input type="text" name="JXZH_FSSL_TEMP" id="JXZH_FSSL_TEMP" 
                                                          			class="form-control" readonly="readonly">
                                                          	</td>
                                                          </tr>
                                                          <tr>
                                                          	<td colspan="2">扶手型号</td>
                                                          	<!-- 不计价 -->
                                                          	<td colspan="2">
                                                          		<input name="JXZH_FSXH" type="radio" value="JF-FS-01" ${pd.JXZH_FSXH=='JF-FS-01'?'checked':''}/>JF-FS-01&nbsp;
                                                          		<input name="JXZH_FSXH" type="radio" value="JF-FS-02" ${pd.JXZH_FSXH=='JF-FS-02'?'checked':''}/>JF-FS-02&nbsp;
                                                          		<input name="JXZH_FSXH" type="radio" value="JF-FS-03" ${pd.JXZH_FSXH=='JF-FS-03'?'checked':''}/>JF-FS-03&nbsp;
                                                          		<input name="JXZH_FSXH" type="radio" value="JF-FS-04" ${pd.JXZH_FSXH=='JF-FS-04'?'checked':''}/>JF-FS-04&nbsp;
                                                          		<input name="JXZH_FSXH" type="radio" value="JF-FS-05" ${pd.JXZH_FSXH=='JF-FS-05'?'checked':''}/>JF-FS-05
                                                          	</td>
                                                          	<td></td>
                                                          </tr>
                                                          <tr>
                                                          	<td colspan="2">轿厢是否预留装修(重量)</td>
                                                          	<!-- 选择Y时，必填写轿厢预留装修（重量），否则不可填-->
                                                          	<td colspan="2">
                                                          		<select name='JXZH_SFYL' id="JXZH_SFYL" class="form-control" onchange="editJxzh('JXZH_YLZL');" style="width: 18%;">
                                                                    <option value="Y" ${pd.JXZH_SFYL=='Y'?'selected':''}>Y</option>
                                                                    <option value="N" ${pd.JXZH_SFYL=='N'?'selected':''}>N</option>                                
                                                                </select>
                                                          	</td>
                                                          	<td></td>
                                                          </tr>
                                                          <tr>
                                                          	<td colspan="2">轿厢预留装修(重量)</td>
                                                          	<!-- 10元/kg,最大200KG -->
                                                          	<td colspan="2">
                                                          		<label style="color: red;" id = "YLZLLabel">*</label>
                                                          		<input name="JXZH_YLZL" id="JXZH_YLZL" type="text" style="width: 18%;" value="${pd.JXZH_YLZL}" onkeyup="editJxzh('JXZH_YLZL');" />KG
                                                          	</td>
                                                          	<td>
                                                          		<input type="text" name="JXZH_YLZL_TEMP" id="JXZH_YLZL_TEMP" readonly="readonly"
                                                          			class="form-control">
                                                          	</td>
                                                          </tr>
                                                          <tr>
                                                          	<td colspan="2">明镜形式</td>
                                                          	<!-- N不计价，后侧明镜不加价 -->
                                                          	<td colspan="2">
                                                          		<input name="JXZH_MJXS" type="radio" value="N" ${pd.JXZH_MJXS=='N'?'checked':''}/>N&nbsp;
                                                          		<input name="JXZH_MJXS" type="radio" value="后侧明镜" ${pd.JXZH_MJXS=='后侧明镜'?'checked':''}/>后侧明镜
                                                          	</td>
                                                          	<td></td>
                                                          </tr>
                                                          <tr>
                                                          	<td colspan="2">观光梯形式</td>
                                                          	<!-- 全部非标询价 -->
                                                          	<td colspan="2">
                                                          		<input name="JXZH_GGTXS" type="radio" value="半圆观光" ${pd.JXZH_GGTXS=='半圆观光'?'checked':''}/>半圆观光&nbsp;
                                                          		<input name="JXZH_GGTXS" type="radio" value="一面观光" ${pd.JXZH_GGTXS=='一面观光'?'checked':''}/>一面观光&nbsp;
                                                          		<input name="JXZH_GGTXS" type="radio" value="两面观光" ${pd.JXZH_GGTXS=='两面观光'?'checked':''}/>两面观光&nbsp;
                                                          		<input name="JXZH_GGTXS" type="radio" value="三面观光" ${pd.JXZH_GGTXS=='三面观光'?'checked':''}/>三面观光
                                                          	</td>
                                                          	<td><font color="red">请非标询价</font></td>
                                                          </tr>
                                                          <tr>
                                                          	<td colspan="2">观光轿厢型号</td>
                                                          	<!-- 全部非标询价 -->
                                                          	<td colspan="2">
                                                          		<input name="JXZH_GGTJXXH" type="radio" onclick="SelChange('JXZH_GGTJXXH')" value="N" ${pd.JXZH_GGTJXXH=='N'?'checked':''}/>N&nbsp;
                                                          		<input name="JXZH_GGTJXXH" type="radio" onclick="SelChange('JXZH_GGTJXXH')" value="T特殊" ${pd.JXZH_GGTJXXH=='T特殊'?'checked':''}/>T特殊
                                                          	</td>
                                                          	<td><font color="red">请非标询价</font></td>
                                                          </tr>
                                                          <tr>
                                                          	<td colspan="2">观光梯外围部件颜色</td>
                                                          	<!-- 全部非标询价 -->
                                                          	<td colspan="2">
                                                          		<input name="JXZH_GGTYS" type="radio" onclick="SelChange('JXZH_GGTYS')" value="RAL7039灰色" ${pd.JXZH_GGTYS=='RAL7039灰色'?'checked':''}/>RAL7039灰色&nbsp;
                                                          		<input name="JXZH_GGTYS" type="radio" onclick="SelChange('JXZH_GGTYS')" value="RAL9010象牙白" ${pd.JXZH_GGTYS=='RAL9010象牙白'?'checked':''}/>RAL9010象牙白
                                                          	</td>
                                                          	<td><font color="red">请非标询价</font></td>
                                                          </tr>
                                                          <tr>
                                                          	<td colspan="2" rowspan="2">轿厢操纵箱</td>
                                                          	<td colspan="2" >
                                                          		<!-- A:不加价，B:1000/台，C：1000，D：1000，E：1000 -->
                                                          		单独盒式:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                          		<input name="JXZH_JXCZX" type="radio" onclick="editJxzh('JXZH_JXCZX');" value="COP500(标准)" ${pd.JXZH_JXCZX=='COP500(标准)'?'checked':''}/>COP500(标准)&nbsp;
                                                          		<input name="JXZH_JXCZX" type="radio" onclick="editJxzh('JXZH_JXCZX');" value="COP505ME(镜面蚀刻)" ${pd.JXZH_JXCZX=='COP505ME(镜面蚀刻)'?'checked':''}/>COP505ME(镜面蚀刻)&nbsp;
                                                          		<input name="JXZH_JXCZX" type="radio" onclick="editJxzh('JXZH_JXCZX');" value="COP505TE(钛金蚀刻)" ${pd.JXZH_JXCZX=='COP505TE(钛金蚀刻)'?'checked':''}/>COP505TE(钛金蚀刻)&nbsp;
                                                          		<input name="JXZH_JXCZX" type="radio" onclick="editJxzh('JXZH_JXCZX');" value="COP501ME(镜面蚀刻)" ${pd.JXZH_JXCZX=='COP501ME(镜面蚀刻)'?'checked':''}/>COP501ME(镜面蚀刻)&nbsp;
                                                          		<input name="JXZH_JXCZX" type="radio" onclick="editJxzh('JXZH_JXCZX');" value="COP502TE(钛金蚀刻)" ${pd.JXZH_JXCZX=='COP502TE(钛金蚀刻)'?'checked':''}/>COP502TE(钛金蚀刻)
                                                          	</td>
                                                          	<td rowspan="2">
                                                          		<input type="text" name="JXZH_JXCZX_TEMP" id="JXZH_JXCZX_TEMP" 
                                                          			class="form-control" readonly="readonly">
                                                          	</td>
                                                          </tr>
                                                          <tr>
                                                          	<td colspan="2">
                                                          		<!-- F：加价1000/台，G加价1500/台 -->
                                                          		前壁一体式:&nbsp;
                                                          		<input name="JXZH_JXCZX" type="radio" onclick="editJxzh('JXZH_JXCZX');" value="COP520(喷漆，同前壁)" ${pd.JXZH_JXCZX=='COP520(喷漆，同前壁)'?'checked':''}/>COP520(喷漆，同前壁)&nbsp;
                                                          		<input name="JXZH_JXCZX" type="radio" onclick="editJxzh('JXZH_JXCZX');" value="COP520S(发纹)" ${pd.JXZH_JXCZX=='COP520S(发纹)'?'checked':''}/>COP520S(发纹)
                                                          	</td>
                                                          	
                                                          </tr>
                                                          <tr>
                                                          	<td colspan="2">轿厢显示</td>
                                                          	<!-- B加价600/台 -->
                                                          	<td colspan="2">
                                                          		<input name="JXZH_JXXS" type="radio" onclick="editJxzh('JXZH_JXXS');" value="点阵显示(标准)" ${pd.JXZH_JXXS=='点阵显示(标准)'?'checked':''}/>点阵显示(标准)&nbsp;&nbsp;
                                                          		<input name="JXZH_JXXS" type="radio" onclick="editJxzh('JXZH_JXXS');" value="蓝白液晶显示(选配)" ${pd.JXZH_JXXS=='蓝白液晶显示(选配)'?'checked':''}/>蓝白液晶显示(选配)
                                                          	</td>
                                                          	<td>
                                                          		<input type="text" name="JXZH_JXXS_TEMP" id="JXZH_JXXS_TEMP" 
                                                          			class="form-control" readonly="readonly">
                                                          	</td>
                                                          </tr>
                                                        </table>
                                                    </c:if>
                                                    <c:if test="${modelsPd.ele_type=='DT11'}">
                                                    <!-- A2轿厢装潢 -->
                                                    	<table class="table table-striped table-bordered table-hover" border="1" cellspacing="0">
                                                        	<tr>
                                                        		<td colspan="2"><label>轿厢装潢模块</label></td>
                                                        		<td colspan="2"><label>选项</label></td>
                                                        		<td style="width: 180px;"><label>加价</label></td>
                                                        	</tr>
	                                                        <tr>
	                                                          	<td colspan="2" rowspan="2">轿内操纵箱类型</td>
	                                                          	<td colspan="2" >
	                                                          		<!-- A:不加价，B:1000/台，C：1000，D：1000，E：1000 -->
	                                                          		面板型操纵箱:&nbsp;&nbsp;
	                                                          		<input name="JXZH_JXCZX_LX" type="radio" onclick="editJxzh('JXZH_JXCZX');" value="DBK-04" ${pd.JXZH_JXCZX_LX=='DBK-04'?'checked':''}/>DBK-04&nbsp;
	                                                          		<input name="JXZH_JXCZX_LX" type="radio" onclick="editJxzh('JXZH_JXCZX');" value="DBK-05" ${pd.JXZH_JXCZX_LX=='DBK-05'?'checked':''}/>DBK-05&nbsp;
	                                                          		<input name="JXZH_JXCZX_LX" type="radio" onclick="editJxzh('JXZH_JXCZX');" value="DBK-06" ${pd.JXZH_JXCZX_LX=='DBK-06'?'checked':''}/>DBK-06&nbsp;
	                                                          		<input name="JXZH_JXCZX_LX" type="radio" onclick="editJxzh('JXZH_JXCZX');" value="DBK-07" ${pd.JXZH_JXCZX_LX=='DBK-07'?'checked':''}/>DBK-07&nbsp;
	                                                          		<input name="JXZH_JXCZX_LX" type="radio" onclick="editJxzh('JXZH_JXCZX');" value="DBK-17" ${pd.JXZH_JXCZX_LX=='DBK-17'?'checked':''}/>DBK-17
	                                                          	</td>
	                                                          	<td rowspan="2">
	                                                          		<input type="text" name="JXZH_JXCZX_TEMP" id="JXZH_JXCZX_TEMP" 
	                                                          			class="form-control" readonly="readonly">
	                                                          	</td>
	                                                        </tr>
	                                                    	<tr>
	                                                    		<td colspan="2">
	                                                          		<!-- F：加价1000/台，G加价1500/台 -->
	                                                    			扶手型操纵箱:&nbsp;&nbsp;
	                                                    			<input name="JXZH_JXCZX_LX" type="radio" onclick="editJxzh('JXZH_JXCZX');" value="DBK-01" ${pd.JXZH_JXCZX_LX=='DBK-01'?'checked':''}/>DBK-01&nbsp;
				                                                    <input name="JXZH_JXCZX_LX" type="radio" onclick="editJxzh('JXZH_JXCZX');" value="DBK-02" ${pd.JXZH_JXCZX_LX=='DBK-02'?'checked':''}/>DBK-02&nbsp;
				                                                    <input name="JXZH_JXCZX_LX" type="radio" onclick="editJxzh('JXZH_JXCZX');" value="DBK-03" ${pd.JXZH_JXCZX_LX=='DBK-03'?'checked':''}/>DBK-03&nbsp;
				                                                    <input name="JXZH_JXCZX_LX" type="radio" onclick="editJxzh('JXZH_JXCZX');" value="DBK-08" ${pd.JXZH_JXCZX_LX=='DBK-08'?'checked':''}/>DBK-08&nbsp;
				                                                    <input name="JXZH_JXCZX_LX" type="radio" onclick="editJxzh('JXZH_JXCZX');" value="DBK-09" ${pd.JXZH_JXCZX_LX=='DBK-09'?'checked':''}/>DBK-09&nbsp;
				                                                    <input name="JXZH_JXCZX_LX" type="radio" onclick="editJxzh('JXZH_JXCZX');" value="DBK-11" ${pd.JXZH_JXCZX_LX=='DBK-11'?'checked':''}/>DBK-11
	                                                    		</td>
	                                                    	</tr>
	                                                    	<tr>
		                                                        <td colspan="2">轿内操纵箱布置</td>
		                                                        <td colspan="2">
		                                                        	<input name="JXZH_JXCZX_BZ" type="radio" value="左侧壁" ${pd.JXZH_JXCZX_BZ=='左侧壁'?'checked':''}/>左侧壁&nbsp;&nbsp;
		                                                        	<input name="JXZH_JXCZX_BZ" type="radio" value="右侧壁" ${pd.JXZH_JXCZX_BZ=='右侧壁'?'checked':''}/>右侧壁&nbsp;&nbsp;
		                                                        	<input name="JXZH_JXCZX_BZ" type="radio" value="后壁" ${pd.JXZH_JXCZX_BZ=='后壁'?'checked':''}/>后壁
		                                                        </td>
		                                                        <td>
		                                                        </td>
	                                                      	</tr>
	                                                      	<tr>
		                                                        <td colspan="2">厅外召唤</td>
		                                                        <td colspan="2">
		                                                        	<input name="JXZH_TWZH" type="radio" value="门框嵌入式召唤(标准)" ${pd.JXZH_TWZH=='门框嵌入式召唤(标准)'?'checked':''}/>门框嵌入式召唤(标准)&nbsp;&nbsp;
		                                                        	<input name="JXZH_TWZH" type="radio" value="独立面板式召唤(非标)" ${pd.JXZH_TWZH=='独立面板式召唤(非标)'?'checked':''}/>独立面板式召唤(非标)
		                                                        </td>
		                                                        <td>
		                                                        </td>
	                                                      	</tr>
	                                                      	<tr>
		                                                        <td colspan="2">厅门</td>
		                                                        <td colspan="2">
		                                                        	<input name="JXZH_TMWZ" type="radio" value="左轴" ${pd.JXZH_TWZH=='门框嵌入式召唤(标准)'?'checked':''}/>门框嵌入式召唤(标准)&nbsp;&nbsp;
		                                                        	<input name="JXZH_TMWZ" type="radio" value="右轴" ${pd.JXZH_TWZH=='独立面板式召唤(非标)'?'checked':''}/>独立面板式召唤(非标)&nbsp;&nbsp;
		                                                        	在层站<input type="text" name = "JXZH_TMWZ_TEXT" id="JXZH_TMWZ_TEXT" value="${pd.JXZH_TMWZ_TEXT}">
		                                                        </td>
		                                                        <td>
		                                                        </td>
	                                                      	</tr>
	                                                      	<tr>
		                                                        <td colspan="2">门框标准型材</td>
		                                                        <td colspan="2">
		                                                        	<select name="JXZH_MKBZXC" id="JXZH_MKBZXC" class="form-control">
		                                                        		<option value="DBC-01米白色" ${pd.JXZH_MKBZXC=='DBC-01米白色'?'selected':'' }>DBC-01米白色</option>
		                                                        		<option value="DBC-02红棕色胡桃木纹" ${pd.JXZH_MKBZXC=='DBC-02红棕色胡桃木纹'?'selected':'' }>DBC-02红棕色胡桃木纹</option>
		                                                        		<option value="DBC-09银白氧化" ${pd.JXZH_MKBZXC=='DBC-09银白氧化'?'selected':'' }>DBC-09银白氧化</option>
		                                                        		<option value="DBC-11褐色樱桃木纹" ${pd.JXZH_MKBZXC=='DBC-11褐色樱桃木纹'?'selected':'' }>DBC-11褐色樱桃木纹</option>
		                                                        		<option value="DBC-12玫瑰金色" ${pd.JXZH_MKBZXC=='DBC-12玫瑰金色'?'selected':'' }>DBC-12玫瑰金色</option>
		                                                        		<option value="DBC-16黑色亚光" ${pd.JXZH_MKBZXC=='DBC-16黑色亚光'?'selected':'' }>DBC-16黑色亚光</option>
		                                                        		<option value="DBC-10黑色亮光" ${pd.JXZH_MKBZXC=='DBC-10黑色亮光'?'selected':'' }>DBC-10黑色亮光</option>
		                                                        		<option value="DBC-04电泳金黄" ${pd.JXZH_MKBZXC=='DBC-04电泳金黄'?'selected':'' }>DBC-04电泳金黄</option>
		                                                        	</select>
		                                                        </td>
		                                                        <td>
		                                                        	<!-- <input type="text" readonly="readonly" id="JXZH_MKBZXC_TEMP" name = "JXZH_MKBZXC_TEMP"> -->
		                                                        </td>
	                                                      	</tr>
	                                                      	<!-- ---- -->
	                                                      	<tr>
                                                        		<td rowspan="2" colspan="2">门玻璃样式</td>
                                                        		<!-- B，200/层  C：不加价，D：500/层，E：500/层，F：500/层，G：500/层 -->
                                                        		<td colspan="2">
                                                        			<p>样式选择:</p>&nbsp;
                                                        			<select name="JXZH_MBLYS1" id="JXZH_MBLYS1" onchange="editJxzh('JXZH_MBLYS');" class="form-control">
                                                        				<option value="" ${pd.JXZH_MBLYS==''?'checked':''}>请选择</option>
                                                        				<option value="DBM-01透明玻璃" ${pd.JXZH_MBLYS=='DBM-01透明玻璃'?'checked':''}>DBM-01透明玻璃</option>
                                                        				<option value="DBM-16暗香盈神" ${pd.JXZH_MBLYS=='DBM-16暗香盈神'?'checked':''}>DBM-16暗香盈神</option>
                                                        				<option value="DBM-29金秋情致" ${pd.JXZH_MBLYS=='DBM-29金秋情致'?'checked':''}>DBM-29金秋情致</option>
                                                        				<option value="DBM-32燕山夜雨" ${pd.JXZH_MBLYS=='DBM-32燕山夜雨'?'checked':''}>DBM-32燕山夜雨</option>
                                                        				<option value="DBM-73蒙砂玻璃" ${pd.JXZH_MBLYS=='DBM-73蒙砂玻璃'?'checked':''}>DBM-73蒙砂玻璃</option>
                                                        				<option value="DBM-74白色丝印" ${pd.JXZH_MBLYS=='DBM-74白色丝印'?'checked':''}>DBM-74白色丝印</option>
                                                        				<option value="DBM-09镶嵌玻璃" ${pd.JXZH_MBLYS=='DBM-09镶嵌玻璃'?'checked':''}>DBM-09镶嵌玻璃</option>
                                                        				<option value="DBM-31 皓月清风" ${pd.JXZH_MBLYS=='DBM-31 皓月清风'?'checked':''}>DBM-31 皓月清风</option>
                                                        				<option value="DBM-10镶嵌玻璃" ${pd.JXZH_MBLYS=='DBM-10镶嵌玻璃'?'checked':''}>DBM-10镶嵌玻璃</option>
                                                        				<option value="DBM-47镶嵌玻璃" ${pd.JXZH_MBLYS=='DBM-47镶嵌玻璃'?'checked':''}>DBM-47镶嵌玻璃</option>
                                                        				<option value="DBM-49镶嵌玻璃" ${pd.JXZH_MBLYS=='DBM-49镶嵌玻璃'?'checked':''}>DBM-49镶嵌玻璃</option>
                                                        				<option value="DBM-50镶嵌玻璃" ${pd.JXZH_MBLYS=='DBM-50镶嵌玻璃'?'checked':''}>DBM-50镶嵌玻璃</option>
                                                        				<option value="DBM-122凤尾" ${pd.JXZH_MBLYS=='DBM-122凤尾'?'checked':''}>DBM-122凤尾</option>
                                                        				<option value="DBM-14溪亭日暮" ${pd.JXZH_MBLYS=='DBM-14溪亭日暮'?'checked':''}>DBM-14溪亭日暮</option>
                                                        				<option value="DBB-37木色" ${pd.JXZH_MBLYS=='DBB-37木色'?'checked':''}>DBB-37木色</option>
                                                        				<option value="DBB-37白色" ${pd.JXZH_MBLYS=='DBB-37白色'?'checked':''}>DBB-37白色</option>
                                                        				<option value="DBM-08镶嵌玻璃" ${pd.JXZH_MBLYS=='DBM-08镶嵌玻璃'?'checked':''}>DBM-08镶嵌玻璃</option>
                                                        				<option value="DBM-06镶嵌玻璃" ${pd.JXZH_MBLYS=='DBM-06镶嵌玻璃'?'checked':''}>DBM-06镶嵌玻璃</option>
                                                        				<option value="DBM-12镶嵌玻璃" ${pd.JXZH_MBLYS=='DBM-12镶嵌玻璃'?'checked':''}>DBM-12镶嵌玻璃</option>
                                                        				<option value="DBM-43镶嵌玻璃" ${pd.JXZH_MBLYS=='DBM-43镶嵌玻璃'?'checked':''}>DBM-43镶嵌玻璃</option>
                                                        				<option value="DBM-130镶嵌玻璃" ${pd.JXZH_MBLYS=='DBM-130镶嵌玻璃'?'checked':''}>DBM-130镶嵌玻璃</option>
                                                        				<option value="DBM-96烟熏灰" ${pd.JXZH_MBLYS=='DBM-96烟熏灰'?'checked':''}>DBM-96烟熏灰</option>
                                                        				<option value="DBM-97海洋蓝" ${pd.JXZH_MBLYS=='DBM-97海洋蓝'?'checked':''}>DBM-97海洋蓝</option>
                                                        				<option value="DBM-98苹果绿" ${pd.JXZH_MBLYS=='DBM-98苹果绿'?'checked':''}>DBM-98苹果绿</option>
		                                                        	</select>
                                                        			数量:<input type="text" name="JXZH_MBLYS_SL" id="JXZH_MBLYS_SL" class="form-control">
                                                        			在层站:<input type="text" name="JXZH_MBLYS_CZ" id="JXZH_MBLYS_CZ" class="form-control">
                                                        		</td>
                                                        		<td rowspan="2">
                                                        			<input type="text" name="CZGG_MBLYS_TEMP" id="CZGG_MBLYS_TEMP" 
	                                                          			class="form-control" readonly="readonly">
                                                        		</td>
                                                        	</tr>
                                                        	<tr>
                                                        		<td colspan="2">
                                                        			<p>客户自理:</p>&nbsp;
                                                        			<select name="JXZH_MBLYS2" id="JXZH_MBLYS2" onchange="editJxzh('JXZH_MBLYS');" class="form-control">
                                                        				<option value="" ${pd.JXZH_MBLYS==''?'checked':''}>请选择</option>
                                                        				<option value="客户自理预留厚度9mm" ${pd.JXZH_MBLYS=='客户自理预留厚度9mm'?'checked':''}>9mm</option>
                                                        				<option value="客户自理预留厚度18mm" ${pd.JXZH_MBLYS=='客户自理预留厚度18mm'?'checked':''}>18mm</option>
                                                        			</select>
                                                        		</td>
                                                        	</tr>
	                                                      	<!-- ---- -->
	                                                      	<tr>
		                                                        <td colspan="2">门拉手</td>
		                                                        <td colspan="2">
		                                                        	<select name="JXZH_MLS" id="JXZH_MLS" class="form-control">
		                                                        		<option value="DBL-01黑胡桃" ${pd.JXZH_MLS=='DBL-01黑胡桃'?'selected':'' }>DBL-01黑胡桃</option>
		                                                        		<option value="DBL-02西施红" ${pd.JXZH_MLS=='DBL-02西施红'?'selected':'' }>DBL-02西施红</option>
		                                                        		<option value="DBL-03A不锈钢" ${pd.JXZH_MLS=='DBL-03A不锈钢'?'selected':'' }>DBL-03A不锈钢</option>
		                                                        		<option value="DBL-03B砂金色" ${pd.JXZH_MLS=='DBL-03B砂金色'?'selected':'' }>DBL-03B砂金色</option>
		                                                        		<option value="DBL-04榉木" ${pd.JXZH_MLS=='DBL-04榉木'?'selected':'' }>DBL-04榉木</option>
		                                                        		<option value="DBL-05晚霞红" ${pd.JXZH_MLS=='DBL-05晚霞红'?'selected':'' }>DBL-05晚霞红</option>
		                                                        		<option value="DBL-06有机玻璃" ${pd.JXZH_MLS=='DBL-06有机玻璃'?'selected':'' }>DBL-06有机玻璃</option>
		                                                        		<option value="DBL-12松香玉" ${pd.JXZH_MLS=='DBL-12松香玉'?'selected':'' }>DBL-12松香玉</option>
		                                                        		<option value="DBL-13砂金色不锈钢" ${pd.JXZH_MLS=='DBL-13砂金色不锈钢'?'selected':'' }>DBL-13砂金色不锈钢</option>
		                                                        		<option value="DBL-11大花绿" ${pd.JXZH_MLS=='DBL-11大花绿'?'selected':'' }>DBL-11大花绿</option>
		                                                        		<option value="DBL-24青铜色" ${pd.JXZH_MLS=='DBL-24青铜色'?'selected':'' }>DBL-24青铜色</option>
		                                                        		<option value="DBL-25钛金+沙比利木色" ${pd.JXZH_MLS=='DBL-25钛金+沙比利木色'?'selected':'' }>DBL-25钛金+沙比利木色</option>
		                                                        	</select>
		                                                        </td>
		                                                        <td>
		                                                        </td>
	                                                      	</tr>
	                                                      	<tr>
		                                                        <td colspan="2">轿厢型材</td>
		                                                        <td colspan="2">
		                                                        	<select name="JXZH_JXXC" id="JXZH_JXXC" class="form-control">
		                                                        		<option value="DBC-01米白色" ${pd.JXZH_JXXC=='DBC-01米白色'?'selected':'' }>DBC-01米白色</option>
		                                                        		<option value="DBC-02红棕色胡桃木纹" ${pd.JXZH_JXXC=='DBC-02红棕色胡桃木纹'?'selected':'' }>DBC-02红棕色胡桃木纹</option>
		                                                        		<option value="DBC-09银白氧化" ${pd.JXZH_JXXC=='DBC-09银白氧化'?'selected':'' }>DBC-09银白氧化</option>
		                                                        		<option value="DBC-11褐色樱桃木纹" ${pd.JXZH_JXXC=='DBC-11褐色樱桃木纹'?'selected':'' }>DBC-11褐色樱桃木纹</option>
		                                                        		<option value="DBC-12玫瑰金色" ${pd.JXZH_JXXC=='DBC-12玫瑰金色'?'selected':'' }>DBC-12玫瑰金色</option>
		                                                        		<option value="DBC-16黑色亚光" ${pd.JXZH_JXXC=='DBC-16黑色亚光'?'selected':'' }>DBC-16黑色亚光</option>
		                                                        		<option value="DBC-10黑色亮光" ${pd.JXZH_JXXC=='DBC-10黑色亮光'?'selected':'' }>DBC-10黑色亮光</option>
		                                                        		<option value="DBC-04电泳金黄" ${pd.JXZH_JXXC=='DBC-04电泳金黄'?'selected':'' }>DBC-04电泳金黄</option>
		                                                        	</select>
		                                                        </td>
		                                                        <td>
		                                                        </td>
	                                                      	</tr>
	                                                      	<tr>
		                                                        <td colspan="2">吊顶</td>
		                                                        <td colspan="2">
		                                                        	<select name="JXZH_DD" id="JXZH_DD" onchange="editJxzh('JXZH_DD');" class="form-control">
		                                                        		<option value="DBD-01太阳星辰" ${pd.JXZH_DD=='DBD-01太阳星辰'?'selected':'' }>DBD-01太阳星辰</option>
		                                                        		<option value="DBD-05漩涡" ${pd.JXZH_DD=='DBD-05漩涡'?'selected':'' }>DBD-05漩涡</option>
		                                                        		<option value="DBD-09太阳星辰" ${pd.JXZH_DD=='DBD-09太阳星辰'?'selected':'' }>DBD-09太阳星辰</option>
		                                                        		<option value="DBD-13伞花" ${pd.JXZH_DD=='DBD-13伞花'?'selected':'' }>DBD-13伞花</option>
		                                                        		<option value="DBD-14伞花" ${pd.JXZH_DD=='DBD-14伞花'?'selected':'' }>DBD-14伞花</option>
		                                                        		<option value="DBD-16漩涡" ${pd.JXZH_DD=='DBD-16漩涡'?'selected':'' }>DBD-16漩涡</option>
		                                                        		<option value="DBD-82飞絮" ${pd.JXZH_DD=='DBD-82飞絮'?'selected':'' }>DBD-82飞絮</option>
		                                                        		<option value="DBD-83飞絮" ${pd.JXZH_DD=='DBD-83飞絮'?'selected':'' }>DBD-83飞絮</option>
		                                                        		<option value="DBD-111金色" ${pd.JXZH_DD=='DBD-111金色'?'selected':'' }>DBD-111金色</option>
		                                                        		<option value="DBD-111银色" ${pd.JXZH_DD=='DBD-111银色'?'selected':'' }>DBD-111银色</option>
		                                                        		<option value="DBD-112金色" ${pd.JXZH_DD=='DBD-112金色'?'selected':'' }>DBD-112金色</option>
		                                                        		<option value="DBD-112银色" ${pd.JXZH_DD=='DBD-112银色'?'selected':'' }>DBD-112银色</option>
		                                                        	</select>
		                                                        </td>
		                                                        <td>
		                                                        	<input type="text" name="JXZH_DD_TEMP" id="JXZH_DD_TEMP" 
	                                                          			class="form-control" readonly="readonly">
		                                                        </td>
	                                                      	</tr>
	                                                      	<tr>
		                                                        <td colspan="2">轿底</td>
		                                                        <td colspan="2">
		                                                        	PVC地板:&nbsp;
		                                                        	<select name="JXZH_JD1" id="JXZH_JD1" onchange="editJxzh('JXZH_JD1');" class="form-control">
		                                                        		<option value="" ${pd.JXZH_JD==''?'selected':'' }>请选择</option>
		                                                        		<option value="DBF-01行云流水" ${pd.JXZH_JD=='DBF-01行云流水'?'selected':'' }>DBF-01行云流水</option>
		                                                        		<option value="DBF-02多情探戈" ${pd.JXZH_JD=='DBF-02多情探戈'?'selected':'' }>DBF-02多情探戈</option>
		                                                        		<option value="DBF-05温莎俑瓷" ${pd.JXZH_JD=='DBF-05温莎俑瓷'?'selected':'' }>DBF-05温莎俑瓷</option>
		                                                        		<option value="DBF-06浅驼草原" ${pd.JXZH_JD=='DBF-06浅驼草原'?'selected':'' }>DBF-06浅驼草原</option>
		                                                        		<option value="DBF-24陨石星空" ${pd.JXZH_JD=='DBF-24陨石星空'?'selected':'' }>DBF-24陨石星空</option>
		                                                        		<option value="DBF-26红棕色木纹" ${pd.JXZH_JD=='DBF-26红棕色木纹'?'selected':'' }>DBF-26红棕色木纹</option>
		                                                        		<option value="轿底用户自理，预留18mm(用户自理)" ${pd.JXZH_JD=='轿底用户自理，预留18mm(用户自理)'?'selected':'' }>轿底用户自理，预留18mm(用户自理)</option>
		                                                        	</select>&nbsp;&nbsp;&nbsp;
		                                                        	单色大理石:&nbsp;
		                                                        	<select name="JXZH_JD2" id="JXZH_JD2" onchange="editJxzh('JXZH_JD2');" class="form-control">
		                                                        		<option value="" ${pd.JXZH_JD==''?'selected':'' }>请选择</option>
		                                                        		<option value="DBF-10(雪花白)" ${pd.JXZH_JD=='DBF-10(雪花白)'?'selected':'' }>DBF-10(雪花白)</option>
		                                                        		<option value="DBF-11(米黄)" ${pd.JXZH_JD=='DBF-11(米黄)'?'selected':'' }>DBF-11(米黄)</option>
		                                                        		<option value="DBF-12(赛纳米黄)" ${pd.JXZH_JD=='DBF-12(赛纳米黄)'?'selected':'' }>DBF-12(赛纳米黄)</option>
		                                                        		<option value="DBF-13(咖啡色)" ${pd.JXZH_JD=='DBF-13(咖啡色)'?'selected':'' }>DBF-13(咖啡色)</option>
		                                                        		<option value="DBF-16(浅啡网纹)" ${pd.JXZH_JD=='DBF-16(浅啡网纹)'?'selected':'' }>DBF-16(浅啡网纹)</option>
		                                                        		<option value="DBF-18(法国米黄)" ${pd.JXZH_JD=='DBF-18(法国米黄)'?'selected':'' }>DBF-18(法国米黄)</option>
		                                                        		<option value="DBF-22(西班牙米黄)" ${pd.JXZH_JD=='DBF-22(西班牙米黄)'?'selected':'' }>DBF-22(西班牙米黄)</option>
		                                                        		<option value="G DBF-112 新莎安娜米黄" ${pd.JXZH_JD=='G DBF-112 新莎安娜米黄'?'selected':'' }>G DBF-112 新莎安娜米黄</option>
		                                                        		<option value="G DBF-113 埃及米黄" ${pd.JXZH_JD=='G DBF-113 埃及米黄'?'selected':'' }>G DBF-113 埃及米黄</option>
		                                                        		<option value="G DBF-114黑白花" ${pd.JXZH_JD=='G DBF-114黑白花'?'selected':'' }>G DBF-114黑白花</option>
		                                                        		<option value="G DBF-115黑金沙" ${pd.JXZH_JD=='G DBF-115黑金沙'?'selected':'' }>G DBF-115黑金沙</option>
		                                                        		<option value="G DBF-132雅士白" ${pd.JXZH_JD=='G DBF-132雅士白'?'selected':'' }>G DBF-132雅士白</option>
		                                                        	</select>&nbsp;&nbsp;&nbsp;
		                                                        	拼花大理石:&nbsp;
		                                                        	<select name="JXZH_DD3" id="JXZH_DD3" onchange="editJxzh('JXZH_JD3');" class="form-control">
		                                                        		<option value="" ${pd.JXZH_JD==''?'selected':'' }>请选择</option>
		                                                        		<option value="G DBF-106大花白+深啡网纹" ${pd.JXZH_JD=='G DBF-106大花白+深啡网纹'?'selected':'' }>G DBF-106大花白+深啡网纹</option>
		                                                        		<option value="G DBF-107浅啡网纹+米黄" ${pd.JXZH_JD=='G DBF-107浅啡网纹+米黄'?'selected':'' }>G DBF-107浅啡网纹+米黄</option>
		                                                        		<option value="G DBF-108深啡网纹+米黄" ${pd.JXZH_JD=='G DBF-108深啡网纹+米黄'?'selected':'' }>G DBF-108深啡网纹+米黄</option>
		                                                        		<option value="G DBF-109深啡网纹+西班牙米黄" ${pd.JXZH_JD=='G DBF-109深啡网纹+西班牙米黄'?'selected':'' }>G DBF-109深啡网纹+西班牙米黄</option>
		                                                        	</select>
		                                                        </td>
		                                                        <td>
		                                                        	<input type="text" name="JXZH_JD" id="JXZH_JD" 
		                                                        		class="form-control" readonly="readonly">
		                                                        	<input type="text" name="JXZH_JD_TEMP" id="JXZH_JD_TEMP" 
	                                                          			class="form-control" readonly="readonly">
		                                                        </td>
	                                                      	</tr>
	                                                      	<tr>
                                                          	<td colspan="2">轿厢是否预留装修(重量)</td>
                                                          	<!-- 选择Y时，必填写轿厢预留装修（重量），否则不可填-->
                                                          	<td colspan="2">
                                                          		<select name='JXZH_SFYL' id="JXZH_SFYL" class="form-control" onchange="editJxzh('JXZH_YLZL');" style="width: 18%;">
                                                                    <option value="Y" ${pd.JXZH_SFYL=='Y'?'selected':''}>Y</option>
                                                                    <option value="N" ${pd.JXZH_SFYL=='N'?'selected':''}>N</option>                                
                                                                </select>
                                                          	</td>
                                                          	<td></td>
                                                          </tr>
                                                          <tr>
                                                          	<td colspan="2">轿厢预留装修(重量)</td>
                                                          	<!-- 10元/kg,最大200KG -->
                                                          	<td colspan="2">
                                                          		<label style="color: red;" id = "YLZLLabel">*</label>
                                                          		<input name="JXZH_YLZL" id="JXZH_YLZL" type="text" style="width: 18%;" value="${pd.JXZH_YLZL}" onkeyup="editJxzh('JXZH_YLZL');" />KG
                                                          	</td>
                                                          	<td>
                                                          		<input type="text" name="JXZH_YLZL_TEMP" id="JXZH_YLZL_TEMP" readonly="readonly"
                                                          			class="form-control">
                                                          	</td>
                                                          </tr>
	                                                      	<!-- ----轿壁开始 -->
                                                        	<tr>
																<td rowspan="15">轿壁</td>
																<td rowspan="5">左侧壁</td>
															</tr>
															<tr>
																<td><p style="font-weight: bold;">
																	<input name="JXZH_JB_RADIOLEFT" type="radio" onclick="editJxzh('JXZH_JB_RADIOLEFT');" 
																		value="玻璃" ${pd.JXZH_JB_RADIOLEFT=='玻璃'?'checked':''}/>玻璃:
																	</p>
																	<select name="JXZH_JB_LEFT1" id="JXZH_JB_LEFT1" onchange="editJxzh('JXZH_JB_LEFT')" class="form-control" disabled="disabled">
		                                                        		<option value="" ${pd.JXZH_JB_LEFT==''?'selected':'' }>请选择</option>
		                                                        		<option value="DBM-14" ${pd.JXZH_JB_LEFT=='DBM-14'?'selected':'' }>DBM-14</option>
		                                                        		<option value="DBM-16" ${pd.JXZH_JB_LEFT=='DBM-16'?'selected':'' }>DBM-16</option>
		                                                        		<option value="DBM-19" ${pd.JXZH_JB_LEFT=='DBM-19'?'selected':'' }>DBM-19</option>
		                                                        		<option value="DBM-32" ${pd.JXZH_JB_LEFT=='DBM-32'?'selected':'' }>DBM-32</option>
		                                                        		<option value="DBM-73" ${pd.JXZH_JB_LEFT=='DBM-73'?'selected':'' }>DBM-73</option>
		                                                        		<option value="DBM-74" ${pd.JXZH_JB_LEFT=='DBM-74'?'selected':'' }>DBM-74</option>
		                                                        		<option value="DBM-122" ${pd.JXZH_JB_LEFT=='DBM-122'?'selected':'' }>DBM-122</option>
		                                                        		<option value="DBM-01" ${pd.JXZH_JB_LEFT=='DBM-01'?'selected':'' }>DBM-01</option>
		                                                        	</select>&nbsp;&nbsp;&nbsp;
																</td>
																<td rowspan="15" colspan="2"><input type="text" name="JXZH_JB_TEMP" id="JXZH_JB_TEMP" 
	                                                          			class="form-control" readonly="readonly">
	                                                          			<input hidden="hiddden" id = "JXZH_JB_LEFTTEMP" name = "JXZH_JB_LEFTTEMP">
	                                                          			<input hidden="hiddden" id = "JXZH_JB_RIGHTTEMP" name = "JXZH_JB_RIGHTTEMP">
	                                                          			<input hidden="hiddden" id = "JXZH_JB_BACKTEMP" name = "JXZH_JB_BACKTEMP">
	                                                          			<input hidden="hiddden" id = "JXZH_JB_LEFT" name = "JXZH_JB_LEFT">
	                                                          			<input hidden="hiddden" id = "JXZH_JB_RIGHT" name = "JXZH_JB_RIGHT">
	                                                          			<input hidden="hiddden" id = "JXZH_JB_BACK" name = "JXZH_JB_BACK">
                                                         		</td>
															</tr>
															<tr>
																<td><p style="font-weight: bold;">
																	<input name="JXZH_JB_RADIOLEFT" type="radio" onclick="editJxzh('JXZH_JB_RADIOLEFT');" 
																		value="木轿壁" ${pd.JXZH_JB_RADIOLEFT=='木轿壁'?'checked':''}/>木轿壁:
																</p>
																	<select name="JXZH_JB_LEFT2" id="JXZH_JB_LEFT2" class="form-control" disabled="disabled">
		                                                        		<option value="" ${pd.JXZH_JB_LEFT==''?'selected':'' }>请选择</option>
		                                                        		<option value="DBB-37白色" ${pd.JXZH_JB_LEFT=='DBB-37白色'?'selected':'' }>DBB-37白色</option>
		                                                        		<option value="DBB-37木色" ${pd.JXZH_JB_LEFT=='DBB-37木色'?'selected':'' }>DBB-37木色</option>
		                                                        		<option value="DBB-40白色" ${pd.JXZH_JB_LEFT=='DBB-40白色'?'selected':'' }>DBB-40白色</option>
		                                                        		<option value="DBB-40木色" ${pd.JXZH_JB_LEFT=='DBB-40木色'?'selected':'' }>DBB-40木色</option>
		                                                        	</select>&nbsp;&nbsp;&nbsp;
																</td>
															</tr>
															<tr>
																<td><p style="font-weight: bold;">
																	<input name="JXZH_JB_RADIOLEFT" type="radio" onclick="editJxzh('JXZH_JB_RADIOLEFT');" 
																		value="三段式" ${pd.JXZH_JB_RADIOLEFT=='三段式'?'checked':''}/>三段式:
																</p>
																	上段：<input type="text" name="JXZH_JB_LEFTSDS_TEXT1" id="JXZH_JB_LEFTSDS_TEXT1" 
	                                                          			    disabled="disabled" value="${pd.JXZH_JB_LEFTSD_TEXT1}"	class="form-control">
	                                                          		中段：
	                                                          		<!-- 装饰板选项 -->
	                                                          		<select name="JXZH_JB_LEFTSDS" id="JXZH_JB_LEFTSDS" class="form-control" onchange="editJxzh('JXZH_JB_SDS')" disabled="disabled">
		                                                        		<option value="" ${pd.JXZH_JB_LEFTSDS==''?'selected':'' }>请选择(中段材质)</option>
		                                                        		<option value="装饰板" ${pd.JXZH_JB_LEFTSDS=='装饰板'?'selected':'' }>装饰板</option>
		                                                        		<option value="发纹(单面)" ${pd.JXZH_JB_LEFTSDS=='发纹(单面)'?'selected':'' }>发纹(单面)</option>
		                                                        		<option value="发纹(双面)" ${pd.JXZH_JB_LEFTSDS=='发纹(双面))'?'selected':'' }>发纹(双面)</option>
		                                                        		<option value="镜面(单面)" ${pd.JXZH_JB_LEFTSDS=='镜面(单面)'?'selected':'' }>镜面(单面)</option>
		                                                        		<option value="镜面(双面)" ${pd.JXZH_JB_LEFTSDS=='镜面(双面)'?'selected':'' }>镜面(双面)</option>
		                                                        		<option value="钛金(单面)" ${pd.JXZH_JB_LEFTSDS=='钛金(单面)'?'selected':'' }>钛金(单面)</option>
		                                                        		<option value="钛金(双面)" ${pd.JXZH_JB_LEFTSDS=='钛金(双面)'?'selected':'' }>钛金(双面)</option>
		                                                        	</select>&nbsp;&nbsp;
	                                                          		<select name="JXZH_JB_LEFTSDSZSB" id="JXZH_JB_LEFTSDSZSB" class="form-control" style="display: none;">
		                                                        		<option value="" ${pd.JXZH_JB_LEFTSDSZSB==''?'selected':'' }>请选择(装饰板选项)</option>
		                                                        		<option value="DBB-01" ${pd.JXZH_JB_LEFTSDSZSB=='DBB-01'?'selected':'' }>DBB-01</option>
		                                                        		<option value="DBB-02" ${pd.JXZH_JB_LEFTSDSZSB=='DBB-02'?'selected':'' }>DBB-02</option>
		                                                        		<option value="DBB-03" ${pd.JXZH_JB_LEFTSDSZSB=='DBB-03'?'selected':'' }>DBB-03</option>
		                                                        		<option value="DBB-06" ${pd.JXZH_JB_LEFTSDSZSB=='DBB-06'?'selected':'' }>DBB-06</option>
		                                                        		<option value="DBB-12" ${pd.JXZH_JB_LEFTSDSZSB=='DBB-12'?'selected':'' }>DBB-12</option>
		                                                        		<option value="DBB-13" ${pd.JXZH_JB_LEFTSDSZSB=='DBB-13'?'selected':'' }>DBB-13</option>
		                                                        		<option value="DBB-16" ${pd.JXZH_JB_LEFTSDSZSB=='DBB-16'?'selected':'' }>DBB-16</option>
		                                                        		<option value="DBB-17" ${pd.JXZH_JB_LEFTSDSZSB=='DBB-17'?'selected':'' }>DBB-17</option>
		                                                        		<option value="DBB-20" ${pd.JXZH_JB_LEFTSDSZSB=='DBB-20'?'selected':'' }>DBB-20</option>
		                                                        		<option value="DBB-23" ${pd.JXZH_JB_LEFTSDSZSB=='DBB-23'?'selected':'' }>DBB-23</option>
		                                                        		<option value="DBB-25" ${pd.JXZH_JB_LEFTSDSZSB=='DBB-25'?'selected':'' }>DBB-25</option>
		                                                        		<option value="DBB-29" ${pd.JXZH_JB_LEFTSDSZSB=='DBB-29'?'selected':'' }>DBB-29</option>
		                                                        		<option value="DBB-30" ${pd.JXZH_JB_LEFTSDSZSB=='DBB-30'?'selected':'' }>DBB-30</option>
		                                                        	</select>&nbsp;&nbsp;
		                                                        	下段：<input type="text" name="JXZH_JB_LEFTSDS_TEXT2" id="JXZH_JB_LEFTSDS_TEXT2" 
	                                                          			value="${pd.JXZH_JB_LEFTSDS_TEXT2}"	class="form-control" disabled="disabled">
																</td>
															</tr>
															<tr>
																<td><p style="font-weight: bold;">
																	<input name="JXZH_JB_RADIOLEFT" type="radio" onclick="editJxzh('JXZH_JB_RADIOLEFT');" 
																		value="密度板" ${pd.JXZH_JB_RADIOLEFT=='密度板'?'checked':''}/>密度板:
																	</p>
																	<select name="JXZH_JB_LEFT3" id="JXZH_JB_LEFT3" onchange="editJxzh('JXZH_JB_LEFT')" class="form-control" disabled="disabled">
		                                                        		<option value="" ${pd.JXZH_JB_LEFT==''?'selected':'' }>请选择</option>
		                                                        		<option value="DBB-01" ${pd.JXZH_JB_LEFT=='DBB-01'?'selected':'' }>DBB-01</option>
		                                                        		<option value="DBB-02" ${pd.JXZH_JB_LEFT=='DBB-02'?'selected':'' }>DBB-02</option>
		                                                        		<option value="DBB-03" ${pd.JXZH_JB_LEFT=='DBB-03'?'selected':'' }>DBB-03</option>
		                                                        		<option value="DBB-06" ${pd.JXZH_JB_LEFT=='DBB-06'?'selected':'' }>DBB-06</option>
		                                                        		<option value="DBB-12" ${pd.JXZH_JB_LEFT=='DBB-12'?'selected':'' }>DBB-12</option>
		                                                        		<option value="DBB-13" ${pd.JXZH_JB_LEFT=='DBB-13'?'selected':'' }>DBB-13</option>
		                                                        		<option value="DBB-16" ${pd.JXZH_JB_LEFT=='DBB-16'?'selected':'' }>DBB-16</option>
		                                                        		<option value="DBB-17" ${pd.JXZH_JB_LEFT=='DBB-17'?'selected':'' }>DBB-17</option>
		                                                        		<option value="DBB-20" ${pd.JXZH_JB_LEFT=='DBB-20'?'selected':'' }>DBB-20</option>
		                                                        		<option value="DBB-23" ${pd.JXZH_JB_LEFT=='DBB-23'?'selected':'' }>DBB-23</option>
		                                                        		<option value="DBB-25" ${pd.JXZH_JB_LEFT=='DBB-25'?'selected':'' }>DBB-25</option>
		                                                        		<option value="DBB-29" ${pd.JXZH_JB_LEFT=='DBB-29'?'selected':'' }>DBB-29</option>
		                                                        		<option value="DBB-30" ${pd.JXZH_JB_LEFT=='DBB-30'?'selected':'' }>DBB-30</option>
		                                                        	</select>&nbsp;&nbsp;&nbsp;
																</td>
															</tr>
															<tr>
																<td rowspan="5">右侧壁</td>
															</tr>
															<tr>
																<td><p style="font-weight: bold;">
																		<input name="JXZH_JB_RADIORIGHT" type="radio" onclick="editJxzh('JXZH_JB_RADIORIGHT');" 
																			value="玻璃" ${pd.JXZH_JB_RADIORIGHT=='玻璃'?'checked':''}/>玻璃:
																	</p>
																	<select name="JXZH_JB_RIGHT1" id="JXZH_JB_RIGHT1" onchange="editJxzh('JXZH_JB_RIGHT')" class="form-control" disabled="disabled">
		                                                        		<option value="" ${pd.JXZH_JB_RIGHT==''?'selected':'' }>请选择</option>
		                                                        		<option value="DBM-14" ${pd.JXZH_JB_RIGHT=='DBM-14'?'selected':'' }>DBM-14</option>
		                                                        		<option value="DBM-16" ${pd.JXZH_JB_RIGHT=='DBM-16'?'selected':'' }>DBM-16</option>
		                                                        		<option value="DBM-19" ${pd.JXZH_JB_RIGHT=='DBM-19'?'selected':'' }>DBM-19</option>
		                                                        		<option value="DBM-32" ${pd.JXZH_JB_RIGHT=='DBM-32'?'selected':'' }>DBM-32</option>
		                                                        		<option value="DBM-73" ${pd.JXZH_JB_RIGHT=='DBM-73'?'selected':'' }>DBM-73</option>
		                                                        		<option value="DBM-74" ${pd.JXZH_JB_RIGHT=='DBM-74'?'selected':'' }>DBM-74</option>
		                                                        		<option value="DBM-122" ${pd.JXZH_JB_RIGHT=='DBM-122'?'selected':'' }>DBM-122</option>
		                                                        		<option value="DBM-01" ${pd.JXZH_JB_RIGHT=='DBM-01'?'selected':'' }>DBM-01</option>
		                                                        	</select>&nbsp;&nbsp;&nbsp;
																</td>
															</tr>
															<tr>
															</tr>
															<tr>
															</tr>
															<tr>
																<td><p style="font-weight: bold;">
																		<input name="JXZH_JB_RADIORIGHT" type="radio" onclick="editJxzh('JXZH_JB_RADIORIGHT');" 
																			value="密度板" ${pd.JXZH_JB_RADIORIGHT=='密度板'?'checked':''}/>密度板:
																	</p>
																	<select name="JXZH_JB_RIGHT3" id="JXZH_JB_RIGHT3" onchange="editJxzh('JXZH_JB_RIGHT')" class="form-control" disabled="disabled">
		                                                        		<option value="" ${pd.JXZH_JB_RIGHT==''?'selected':'' }>请选择</option>
		                                                        		<option value="DBB-01" ${pd.JXZH_JB_RIGHT=='DBB-01'?'selected':'' }>DBB-01</option>
		                                                        		<option value="DBB-02" ${pd.JXZH_JB_RIGHT=='DBB-02'?'selected':'' }>DBB-02</option>
		                                                        		<option value="DBB-03" ${pd.JXZH_JB_RIGHT=='DBB-03'?'selected':'' }>DBB-03</option>
		                                                        		<option value="DBB-06" ${pd.JXZH_JB_RIGHT=='DBB-06'?'selected':'' }>DBB-06</option>
		                                                        		<option value="DBB-12" ${pd.JXZH_JB_RIGHT=='DBB-12'?'selected':'' }>DBB-12</option>
		                                                        		<option value="DBB-13" ${pd.JXZH_JB_RIGHT=='DBB-13'?'selected':'' }>DBB-13</option>
		                                                        		<option value="DBB-16" ${pd.JXZH_JB_RIGHT=='DBB-16'?'selected':'' }>DBB-16</option>
		                                                        		<option value="DBB-17" ${pd.JXZH_JB_RIGHT=='DBB-17'?'selected':'' }>DBB-17</option>
		                                                        		<option value="DBB-20" ${pd.JXZH_JB_RIGHT=='DBB-20'?'selected':'' }>DBB-20</option>
		                                                        		<option value="DBB-23" ${pd.JXZH_JB_RIGHT=='DBB-23'?'selected':'' }>DBB-23</option>
		                                                        		<option value="DBB-25" ${pd.JXZH_JB_RIGHT=='DBB-25'?'selected':'' }>DBB-25</option>
		                                                        		<option value="DBB-29" ${pd.JXZH_JB_RIGHT=='DBB-29'?'selected':'' }>DBB-29</option>
		                                                        		<option value="DBB-30" ${pd.JXZH_JB_RIGHT=='DBB-30'?'selected':'' }>DBB-30</option>
		                                                        	</select>&nbsp;&nbsp;&nbsp;
																</td>
															</tr>
															<tr>
																<td rowspan="5">后  壁</td>
															</tr>
															<tr>
																<td><p style="font-weight: bold;">
																		<input name="JXZH_JB_RADIOBACK" type="radio" onclick="editJxzh('JXZH_JB_RADIOBACK');" 
																			value="玻璃" ${pd.JXZH_JB_RADIOBACK=='玻璃'?'checked':''}/>玻璃:
																	</p>
																	<select name="JXZH_JB_BACK1" id="JXZH_JB_BACK1" onchange="editJxzh('JXZH_JB_BACK')" class="form-control" disabled="disabled">
		                                                        		<option value="" ${pd.JXZH_JB_BACK==''?'selected':'' }>请选择</option>
		                                                        		<option value="DBM-14" ${pd.JXZH_JB_BACK=='DBM-14'?'selected':'' }>DBM-14</option>
		                                                        		<option value="DBM-16" ${pd.JXZH_JB_BACK=='DBM-16'?'selected':'' }>DBM-16</option>
		                                                        		<option value="DBM-19" ${pd.JXZH_JB_BACK=='DBM-19'?'selected':'' }>DBM-19</option>
		                                                        		<option value="DBM-32" ${pd.JXZH_JB_BACK=='DBM-32'?'selected':'' }>DBM-32</option>
		                                                        		<option value="DBM-73" ${pd.JXZH_JB_BACK=='DBM-73'?'selected':'' }>DBM-73</option>
		                                                        		<option value="DBM-74" ${pd.JXZH_JB_BACK=='DBM-74'?'selected':'' }>DBM-74</option>
		                                                        		<option value="DBM-122" ${pd.JXZH_JB_BACK=='DBM-122'?'selected':'' }>DBM-122</option>
		                                                        		<option value="DBM-01" ${pd.JXZH_JB_BACK=='DBM-01'?'selected':'' }>DBM-01</option>
		                                                        	</select>&nbsp;&nbsp;&nbsp;
																</td>
															</tr>
															<tr>
															</tr>
															<tr>
															</tr>
															<tr>
																<td><p style="font-weight: bold;">
																		<input name="JXZH_JB_RADIOBACK" type="radio" onclick="editJxzh('JXZH_JB_RADIOBACK');" 
																			value="密度板" ${pd.JXZH_JB_RADIOBACK=='密度板'?'checked':''}/>密度板:
																	</p>
																	<select name="JXZH_JB_BACK3" id="JXZH_JB_BACK3" onchange="editJxzh('JXZH_JB_BACK')" class="form-control" disabled="disabled">
		                                                        		<option value="" ${pd.JXZH_JB_BACK==''?'selected':'' }>请选择</option>
		                                                        		<option value="DBB-01" ${pd.JXZH_JB_BACK=='DBB-01'?'selected':'' }>DBB-01</option>
		                                                        		<option value="DBB-02" ${pd.JXZH_JB_BACK=='DBB-02'?'selected':'' }>DBB-02</option>
		                                                        		<option value="DBB-03" ${pd.JXZH_JB_BACK=='DBB-03'?'selected':'' }>DBB-03</option>
		                                                        		<option value="DBB-06" ${pd.JXZH_JB_BACK=='DBB-06'?'selected':'' }>DBB-06</option>
		                                                        		<option value="DBB-12" ${pd.JXZH_JB_BACK=='DBB-12'?'selected':'' }>DBB-12</option>
		                                                        		<option value="DBB-13" ${pd.JXZH_JB_BACK=='DBB-13'?'selected':'' }>DBB-13</option>
		                                                        		<option value="DBB-16" ${pd.JXZH_JB_BACK=='DBB-16'?'selected':'' }>DBB-16</option>
		                                                        		<option value="DBB-17" ${pd.JXZH_JB_BACK=='DBB-17'?'selected':'' }>DBB-17</option>
		                                                        		<option value="DBB-20" ${pd.JXZH_JB_BACK=='DBB-20'?'selected':'' }>DBB-20</option>
		                                                        		<option value="DBB-23" ${pd.JXZH_JB_BACK=='DBB-23'?'selected':'' }>DBB-23</option>
		                                                        		<option value="DBB-25" ${pd.JXZH_JB_BACK=='DBB-25'?'selected':'' }>DBB-25</option>
		                                                        		<option value="DBB-29" ${pd.JXZH_JB_BACK=='DBB-29'?'selected':'' }>DBB-29</option>
		                                                        		<option value="DBB-30" ${pd.JXZH_JB_BACK=='DBB-30'?'selected':'' }>DBB-30</option>
		                                                        	</select>&nbsp;&nbsp;&nbsp;
																</td>
															</tr>
                                                        	<!-- ------轿壁结束 -->
                                                        </table>
                                                    </c:if>
                                                    <!-- 轿厢装潢End -->
                                                </div>
                                                <div id="tab-6" class="tab-pane">
                                                    <!-- 层站规格 -->
                                                        <table class="table table-striped table-bordered table-hover" border="1" cellspacing="0">
                                                        	<tr>
                                                        		<td colspan="2"><label>层站规格模块</label></td>
                                                        		<td colspan="2"><label>选项</label></td>
                                                        		<td style="width: 180px;"><label>加价</label></td>
                                                        	</tr>
                                                        	<tr>
                                                        		<td colspan="2">外呼显示</td>
                                                        		<!-- B，200/层 -->
                                                        		<td colspan="2">
                                                        			<input name="CZGG_WHXS" type="radio" onclick="editCZGG('CZGG_WHXS');" value="点阵显示(标准)" ${pd.CZGG_WHXS=='点阵显示(标准)'?'checked':''}/>点阵显示(标准)&nbsp;
                                                          			<input name="CZGG_WHXS" type="radio" onclick="editCZGG('CZGG_WHXS');" value="蓝白液晶显示" ${pd.CZGG_WHXS=='蓝白液晶显示'?'checked':''}/>蓝白液晶显示
                                                        		</td>
                                                        		<td>
	                                                          		<input type="text" name="CZGG_WHXS_TEMP" id="CZGG_WHXS_TEMP" 
	                                                          			class="form-control" readonly="readonly">
                                                          		</td>
                                                        	</tr>
                                                        	<!-- ---- -->
                                                        	<tr>
                                                        		<td rowspan="2" colspan="2">外呼盒型号</td>
                                                        		<!-- B，200/层  C：不加价，D：500/层，E：500/层，F：500/层，G：500/层 -->
                                                        		<td colspan="2">
                                                        			<p>无底盒形式:</p>&nbsp;
                                                        			<input name="CZGG_WHHXH" type="radio" onclick="editCZGG('CZGG_WHHXH');" value="发纹不锈钢HOP520S(标准)" ${pd.CZGG_WHHXH=='发纹不锈钢HOP520S(标准)'?'checked':''}/>发纹不锈钢HOP520S(标准)&nbsp;
                                                          			<input name="CZGG_WHHXH" type="radio" onclick="editCZGG('CZGG_WHHXH');" value="镜面不锈钢HOP520M" ${pd.CZGG_WHHXH=='镜面不锈钢HOP520M'?'checked':''}/>镜面不锈钢HOP520M
                                                        		</td>
                                                        		<td rowspan="2">
                                                        			<input type="text" name="CZGG_WHHXH_TEMP" id="CZGG_WHHXH_TEMP" 
	                                                          			class="form-control" readonly="readonly">
                                                        		</td>
                                                        	</tr>
                                                        	<tr>
                                                        		<td colspan="2">
                                                        			<p>有底盒形式:</p>&nbsp;
                                                        			<input name="CZGG_WHHXH" type="radio" onclick="editCZGG('CZGG_WHHXH');" value="HOP500(发纹)" ${pd.CZGG_WHHXH=='HOP500(发纹)'?'checked':''}/>HOP500(发纹)&nbsp;
                                                          			<input name="CZGG_WHHXH" type="radio" onclick="editCZGG('CZGG_WHHXH');" value="HOP505ME(镜面蚀刻)" ${pd.CZGG_WHHXH=='HOP505ME(镜面蚀刻)'?'checked':''}/>HOP505ME(镜面蚀刻)&nbsp;
                                                          			<input name="CZGG_WHHXH" type="radio" onclick="editCZGG('CZGG_WHHXH');" value="HOP505TE(钛金蚀刻)" ${pd.CZGG_WHHXH=='HOP505TE(钛金蚀刻)'?'checked':''}/>HOP505TE(钛金蚀刻)&nbsp;
                                                          			<input name="CZGG_WHHXH" type="radio" onclick="editCZGG('CZGG_WHHXH');" value="HOP501ME(镜面蚀刻" ${pd.CZGG_WHHXH=='HOP501ME(镜面蚀刻'?'checked':''}/>HOP501ME(镜面蚀刻&nbsp;
                                                          			<input name="CZGG_WHHXH" type="radio" onclick="editCZGG('CZGG_WHHXH');" value="HOP502TE(钛金蚀刻)" ${pd.CZGG_WHHXH=='HOP502TE(钛金蚀刻)'?'checked':''}/>HOP502TE(钛金蚀刻)
                                                        		</td>
                                                        	</tr>
                                                        	<!-- ------ -->
                                                        	<tr>
                                                        		<td colspan="2">喷漆颜色</td>
                                                        		<!-- 不加价 -->
                                                        		<td colspan="2">
                                                        			<input name="CZGG_PQYS" type="radio" onclick="editCZGG('CZGG_PQYS');" value="RAL7032:卵石灰" ${pd.CZGG_PQYS=='RAL7032:卵石灰'?'checked':''}/>RAL7032:卵石灰&nbsp;
                                                          			<input name="CZGG_PQYS" type="radio" onclick="editCZGG('CZGG_PQYS');" value="RAL7035:浅灰色" ${pd.CZGG_PQYS=='RAL7035:浅灰色'?'checked':''}/>RAL7035:浅灰色&nbsp;
                                                          			<input name="CZGG_PQYS" type="radio" onclick="editCZGG('CZGG_PQYS');" value="N:不要" ${pd.CZGG_PQYS=='N:不要'?'checked':''}/>N:不要
                                                        		</td>
                                                        		<td></td>
                                                        	</tr>
                                                        	<tr>
                                                        		<td colspan="2">小门套材质规格</td>
                                                        		<!-- SUS，SPP,不加价，其他加价350/层 -->
                                                        		<td colspan="2">
                                                        			<input name="CZGG_XMTCZGG" type="radio" onclick="editCZGG('CZGG_XMTCZGG');" value="SUS:发纹(标准)" ${pd.CZGG_XMTCZGG=='SUS:发纹(标准)'?'checked':''}/>SUS:发纹(标准)&nbsp;
                                                          			<input name="CZGG_XMTCZGG" type="radio" onclick="editCZGG('CZGG_XMTCZGG');" value="MIR:不锈钢镜面" ${pd.CZGG_XMTCZGG=='MIR:不锈钢镜面'?'checked':''}/>MIR:不锈钢镜面&nbsp;
                                                          			<input name="CZGG_XMTCZGG" type="radio" onclick="editCZGG('CZGG_XMTCZGG');" value="TM:钛金镜面" ${pd.CZGG_XMTCZGG=='TM:钛金镜面'?'checked':''}/>TM:钛金镜面&nbsp;
                                                          			<input name="CZGG_XMTCZGG" type="radio" onclick="editCZGG('CZGG_XMTCZGG');" value="RM:玫瑰金镜面" ${pd.CZGG_XMTCZGG=='RM:玫瑰金镜面'?'checked':''}/>RM:玫瑰金镜面&nbsp;
                                                          			<input name="CZGG_XMTCZGG" type="radio" onclick="editCZGG('CZGG_XMTCZGG');" value="CLST:化妆钢板" ${pd.CZGG_XMTCZGG=='CLST:化妆钢板'?'checked':''}/>CLST:化妆钢板&nbsp;
                                                          			<input name="CZGG_XMTCZGG" type="radio" onclick="editCZGG('CZGG_XMTCZGG');" value="SPP:喷漆" ${pd.CZGG_XMTCZGG=='SPP:喷漆'?'checked':''}/>SPP:喷漆
                                                        		</td>
                                                        		<td>
                                                        			<input type="text" name="CZGG_XMTCZGG_TEMP" id="CZGG_XMTCZGG_TEMP" 
	                                                          			class="form-control" readonly="readonly">
                                                        		</td>
                                                        	</tr>
                                                        	<tr>
                                                        		<td colspan="2">层站</td>
                                                        		<!-- 不计价 -->
                                                        		<td colspan="2">
                                                        			<input name="CZGG_CZTEXT" type="text" value="" ${pd.CZGG_CZTEXT}/>
                                                        		<td></td>
                                                        	</tr>
                                                        	<tr>
                                                        		<td colspan="2">楼高参数(mm)</td>
                                                        		<!-- 不计价 -->
                                                        		<td colspan="2">
                                                        			<input name="CZGG_LGTEXT" type="text" value="" ${pd.CZGG_LGTEXT}/>
                                                        		<td></td>
                                                        	</tr>
                                                        	<tr>
                                                        		<td colspan="2">停站名(显示名)</td>
                                                        		<!-- 不计价 -->
                                                        		<td colspan="2">
                                                        			<input name="CZGG_TZMEXT" type="text" value="" ${pd.CZGG_TZMEXT}/>
                                                        		<td></td>
                                                        	</tr>
                                                        	<!-- ---- -->
                                                        	<tr>
                                                        		<td rowspan="2" colspan="2">小门套</td>
                                                        		<!-- 勾选（如材质选择SUS发纹，则默认/）SUS，SPP,不加价，其他加价350/层 -->
                                                        		<td colspan="2">
                                                        			<p>材质:</p>&nbsp;
                                                        			<input name="CZGG_XMTCZ" type="radio" onclick="editCZGG('CZGG_XMTCZ');" value="SUS:发纹(标准)" ${pd.CZGG_XMTCZ=='SUS:发纹(标准)'?'checked':''}/>SUS:发纹(标准)&nbsp;
                                                          			<input name="CZGG_XMTCZ" type="radio" onclick="editCZGG('CZGG_XMTCZ');" value="MIR:不锈钢镜面" ${pd.CZGG_XMTCZ=='MIR:不锈钢镜面'?'checked':''}/>MIR:不锈钢镜面&nbsp;
                                                          			<input name="CZGG_XMTCZ" type="radio" onclick="editCZGG('CZGG_XMTCZ');" value="TM:钛金镜面" ${pd.CZGG_XMTCZ=='TM:钛金镜面'?'checked':''}/>TM:钛金镜面&nbsp;
                                                          			<input name="CZGG_XMTCZ" type="radio" onclick="editCZGG('CZGG_XMTCZ');" value="RM:玫瑰金镜面" ${pd.CZGG_XMTCZ=='RM:玫瑰金镜面'?'checked':''}/>RM:玫瑰金镜面&nbsp;
                                                          			<input name="CZGG_XMTCZ" type="radio" onclick="editCZGG('CZGG_XMTCZ');" value="CLST:化妆钢板" ${pd.CZGG_XMTCZ=='CLST:化妆钢板'?'checked':''}/>CLST:化妆钢板&nbsp;
                                                          			<input name="CZGG_XMTCZ" type="radio" onclick="editCZGG('CZGG_XMTCZ');" value="SPP:喷漆" ${pd.CZGG_XMTCZ=='SPP:喷漆'?'checked':''}/>SPP:喷漆
                                                        		</td>
                                                        		<td rowspan="2">
                                                        			<input type="text" name="CZGG_XMTCZ_TEMP" id="CZGG_XMTCZ_TEMP" 
	                                                          			class="form-control" readonly="readonly">
                                                        		</td>
                                                        	</tr>
                                                        	<tr>
                                                        		<td colspan="2">
                                                        			<p>式样编码:</p>&nbsp;
                                                        			<input name="CZGG_XMTYSBM" type="radio" value="/" ${pd.CZGG_XMTYSBM=='/'?'checked':''}/>/&nbsp;&nbsp;
                                                        			<input name="CZGG_XMTYSBM" type="radio" value="RAL7032:卵石灰" ${pd.CZGG_XMTYSBM=='RAL7032:卵石灰'?'checked':''}/>RAL7032:卵石灰&nbsp;
                                                          			<input name="CZGG_XMTYSBM" type="radio" value="RAL7035:浅灰色" ${pd.CZGG_XMTYSBM=='RAL7035:浅灰色'?'checked':''}/>RAL7035:浅灰色&nbsp;
                                                          			<input name="CZGG_XMTYSBM" type="radio" value="B108:胡桃木纹" ${pd.CZGG_XMTYSBM=='B108:胡桃木纹'?'checked':''}/>B108:胡桃木纹&nbsp;
                                                          			<input name="CZGG_XMTYSBM" type="radio" value="C105:金葱木纹" ${pd.CZGG_XMTYSBM=='C105:金葱木纹'?'checked':''}/>C105:金葱木纹
                                                        		</td>
                                                        	</tr>
                                                        	<!-- ------ -->
                                                        	<!-- ---- -->
                                                        	<tr>
                                                        		<td rowspan="2" colspan="2">厅门</td>
                                                        		<!-- 勾选（如材质选择SUS发纹，则默认/）SUS，SPP,不加价，其他加价2650/层 -->
                                                        		<td colspan="2">
                                                        			<p>材质:</p>&nbsp;
                                                        			<input name="CZGG_TMCZ" type="radio" onclick="editCZGG('CZGG_TMCZ');" value="SUS:发纹(标准)" ${pd.CZGG_TMCZ=='SUS:发纹(标准)'?'checked':''}/>SUS:发纹(标准)&nbsp;
                                                          			<input name="CZGG_TMCZ" type="radio" onclick="editCZGG('CZGG_TMCZ');" value="MIR:不锈钢镜面" ${pd.CZGG_TMCZ=='MIR:不锈钢镜面'?'checked':''}/>MIR:不锈钢镜面&nbsp;
                                                          			<input name="CZGG_TMCZ" type="radio" onclick="editCZGG('CZGG_TMCZ');" value="TM:钛金镜面" ${pd.CZGG_TMCZ=='TM:钛金镜面'?'checked':''}/>TM:钛金镜面&nbsp;
                                                          			<input name="CZGG_TMCZ" type="radio" onclick="editCZGG('CZGG_TMCZ');" value="RM:玫瑰金镜面" ${pd.CZGG_TMCZ=='RM:玫瑰金镜面'?'checked':''}/>RM:玫瑰金镜面&nbsp;
                                                          			<input name="CZGG_TMCZ" type="radio" onclick="editCZGG('CZGG_TMCZ');" value="CLST:化妆钢板" ${pd.CZGG_TMCZ=='CLST:化妆钢板'?'checked':''}/>CLST:化妆钢板&nbsp;
                                                          			<input name="CZGG_TMCZ" type="radio" onclick="editCZGG('CZGG_TMCZ');" value="SPP:喷漆" ${pd.CZGG_TMCZ=='SPP:喷漆'?'checked':''}/>SPP:喷漆
                                                        		</td>
                                                        		<td rowspan="2">
                                                        			<input type="text" name="CZGG_TMCZ_TEMP" id="CZGG_TMCZ_TEMP" 
	                                                          			class="form-control" readonly="readonly">
                                                        		</td>
                                                        	</tr>
                                                        	<tr>
                                                        		<td colspan="2">
                                                        			<p>式样编码:</p>&nbsp;
                                                        			<input name="CZGG_TMYSBM" type="radio" value="/" ${pd.CZGG_TMYSBM=='/'?'checked':''}/>/&nbsp;&nbsp;
                                                        			<input name="CZGG_TMYSBM" type="radio" value="DBM-108" ${pd.CZGG_TMYSBM=='DBM-108'?'checked':''}/>DBM-108&nbsp;
                                                          			<input name="CZGG_TMYSBM" type="radio" value="DBM-110" ${pd.CZGG_TMYSBM=='DBM-110'?'checked':''}/>DBM-110&nbsp;
                                                          			<input name="CZGG_TMYSBM" type="radio" value="DBM-111" ${pd.CZGG_TMYSBM=='DBM-111'?'checked':''}/>DBM-111&nbsp;
                                                          			<input name="CZGG_TMYSBM" type="radio" value="DBM-112" ${pd.CZGG_TMYSBM=='DBM-112'?'checked':''}/>DBM-112&nbsp;
                                                          			<input name="CZGG_TMYSBM" type="radio" value="DBM-114" ${pd.CZGG_TMYSBM=='DBM-114'?'checked':''}/>DBM-114&nbsp;
                                                          			<input name="CZGG_TMYSBM" type="radio" value="DBM-115" ${pd.CZGG_TMYSBM=='DBM-115'?'checked':''}/>DBM-115&nbsp;
                                                          			<input name="CZGG_TMYSBM" type="radio" value="DBM-126" ${pd.CZGG_TMYSBM=='DBM-126'?'checked':''}/>DBM-126&nbsp;
                                                          			<input name="CZGG_TMYSBM" type="radio" value="DBM-128" ${pd.CZGG_TMYSBM=='DBM-128'?'checked':''}/>DBM-128&nbsp;
                                                        		</td>
                                                        	</tr>
                                                        	<!-- ------ -->
                                                        	
                                                        </table>
                                                    <!-- 厅门门套 -->
                                                </div>
                                                <div id="tab-9" class="tab-pane">
                                                	<input type="hidden" id="OPT_FB_TEMP" class="form-control">
                                                    <!-- 非标 -->
                                                    <%@include file="nonstanard_detail.jsp" %>
                                                    <!-- 非标 -->
                                                </div>
                                                
                                                <div id="tab-10" class="tab-pane">
                                                    <!-- 常规非标 -->
                                                    <%@include file="conventional_nonstandard.jsp" %>
                                                    <!-- 常规非标 -->
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
	                                            <input type="text" name="HOUSEHOLD_AZF_TEMP" id="HOUSEHOLD_AZF_TEMP" class="form-control" readonly="readonly" value="${pd.DELCO_AZF }">
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
        
        initBindSelect("${pd.BASE_JXGG}");
        
        //加载标准价格,初始化关联选项
        if("${pd.view}"=="save"){
            editZz();
        }
        editSd();
        //setSbj();
        $("#BZ_C").val("${regelevStandardPd.C}");
        $("#BZ_Z").val("${regelevStandardPd.Z}");
        $("#BZ_M").val("${regelevStandardPd.M}");
        
        if("${pd.view}"=="edit")
		{
	        $("#BZ_C").val("${pd.BZ_C}");
	        $("#BZ_Z").val("${pd.BZ_Z}");
	        $("#BZ_M").val("${pd.BZ_M}");
	        
		}

        bindSelect2AndInitDate($('#BZ_C'), "${pd.BZ_C}");
        bindSelect2AndInitDate($('#BZ_Z'), "${pd.BZ_Z}");
        bindSelect2AndInitDate($('#BZ_M'), "${pd.BZ_M}");
        bindSelect2AndInitDate($('#BZ_ZZ'), "${pd.BZ_ZZ}");
        bindSelect2AndInitDate($('#BZ_SD'), "${pd.BZ_SD}");
        bindSelect2AndInitDate($('#BZ_KMKD'), "${pd.BZ_KMKD}");
        
        
        //调用初始化贯通门
        Jsgtms();
        
        var FLAG = $("#FLAG").val();
        if(FLAG=="CBJ"||FLAG=="ZHJ"){
            cbjPrice();
        }
        if("${pd.view}"=="edit"){
            cbjPrice();
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

        setSbj();
        /* setTimeout(function(){
            cbjPrice();
            setSbj();
        },500); */
        countInstallPrice();
        
        //加载运输模块显示 
        if("${pd.trans_type}"!=null && "${pd.trans_type}"!=""){
        	$("#trans_type").val("${pd.trans_type}");
            hideDiv();
        }else{
        	$("#trans_type").val(1);
        }
    });
    
    //根据门数和站数计算贯通门数
    function Jsgtms()
    {
    	var bz_m=parseInt_DN($("#BZ_M").val());
    	var bz_z=parseInt_DN($("#BZ_Z").val());
    	if(bz_z>bz_m)
    	{
    		$("#OPT_GTMS").val(0);
    	}else{
    		var gtms=bz_m-bz_z;
    		$("#OPT_GTMS").val(gtms);
    	}
    }
    
    //关闭当前页面
    function CloseSUWin(id) {
      window.parent.$("#" + id).data("kendoWindow").close();
    }

    //修改层时修改站和门
    function editC(){
        var c_ = $("#BZ_C").val();
        $("#BZ_Z").val(c_);
        $("#BZ_M").val(c_);
        setSbj();
        
      	//超高和加价
        setJdzg();
      	
        editCZGG("CZGG_WHXS");
        editCZGG('CZGG_TMCZ');
    }

    //添加行,录入运输
    function addRow(){
        var tr = $("#transTable tr").eq(0).clone();
        $(tr).find("td").eq(0).find("select").eq(0).val("");
        $(tr).find("td").eq(1).find("input").eq(0).val("");
        $(tr).find("td:last").html("").append("<td><input type='button' value='删除' onclick='delRow(this)'></td>");
        $("#transTable").append(tr);
    }
    //删除行
    function delRow(obj){
        $(obj).parent().parent().parent().remove();
    }

    //调用时计算价格
    function cbjPrice(){
        //井道总高
        setJdzg();
        //可选项
        
         if ($("#OPT_YCFW_TEXT").is(":checked")) {
            $("#OPT_YCFW").val("1");
        } else {
            $("#OPT_YCFW").val("0");
        }
        if ($("#OPT_TDTC_TEXT").is(":checked")) {
            $("#OPT_TDTC").val("1");
        } else {
            $("#OPT_TDTC").val("0");
        }
        
        editOpt('OPT_YCFW','1');
        editOpt('OPT_TDTC','1');
       
        editZJGG("BASE_JXKS","1");
        editZJGG("BASE_JXGD","1");
        editZJGG("BASE_CRKG","1");
        editZJGG("BASE_MKPZXS","1");
        editZJGG("BASE_KMFS","1");
        editZJGG("BASE_KZGWZ","1");

        editCZGG("CZGG_WHXS","1");
        editCZGG("CZGG_WHHXH","1");
        editCZGG("CZGG_XMTCZGG","1");
        editCZGG("CZGG_XMTCZ","1");
        editCZGG("CZGG_TMCZ","1");

        editJN("JN_LLSZ","1");
        editJN("JN_DJXT","1");
        editJN("JN_CZFS","1");

        editJxzh("JXZH_JXDB","1");
        editJxzh("JXZH_DBYSBM1","1");
        editJxzh("JXZH_DBYSBM2","1");
        editJxzh("JXZH_DBYSBM3","1");
        editJxzh("JXZH_XXXH_JM","1");
        editJxzh("JXZH_XXXH_JX","1");
        editJxzh("JXZH_QBGG","1");
        editJxzh("JXZH_YLZL","1");
        editJxzh("JXZH_JXCZX","1");
        editJxzh("JXZH_JXXS","1");
        editJxzh("JXZH_FSSL","1");
        
        //加载页面初始化常规非标加价
        editMTBH('CGFB_MTBH443','1');
        editMTBH('CGFB_MTBHSUS304','1');
        editMTBH('CGFB_MTBH15SUS304','1');
        editMTBH('CGFB_MTBH1215','1');
        editMTBH('CGFB_JXHL','1');
        editMTBH('CGFB_DLSB','1');
        editMTBH('CGFB_DZCZ','1');
        editMTBH('CGFB_KMGD','1');
        editMTBH('CGFB_DKIP65','1');
        editMTBH('CGFB_PKM','1');
        editMTBH('CGFB_ZFSZ2000','1');
        editMTBH('CGFB_ZFSZ3000','1');
        editMTBH('CGFB_ZFSZAQB','1');
        editMTBH('CGFB_JXCC','1');
        editMTBH('CGFB_TDYJ','1');
        editMTBH('CGFB_JJFAJMK','1');
        editMTBH('CGFB_JJFACXK','1');
        
        if("${pd.CGFB_JXCLBH}"=='由减振复合不锈钢变更为443发纹不锈钢'){
        	CGFBJXCLBH('1');
        }else if("${pd.CGFB_JXCLBH}"=='由减震复合不锈钢变更为1.5mmSUS304发纹不锈钢'){
        	CGFBJXCLBH('2');
        }else if("${pd.CGFB_JXCLBH}"=='减震复合不锈钢厚度由1.2mm增加到1.5mm'){
        	CGFBJXCLBH('3');
        }else if("${pd.CGFB_JXCLBH}"=='由减振复合不锈钢变更为SUS304发纹不锈钢'){
        	CGFBJXCLBH('4')
        }else if("${pd.CGFB_JXCLBH}"=='轿厢后壁中间一块采用镜面不锈钢，宽度约600mm'){
        	CGFBJXCLBH('5');
        }
        
        if("${pd.CGFB_GTJX}"=='JFCOPO9H-C1'){
        	CGFBGTJX('1');
        }else if("${pd.CGFB_GTJX}"=='JFCOPO5P-E'){
        	CGFBGTJX('2');
        }


    }



    //调用参考报价
    function selCbj(){
        var modelsId = $("#MODELS_ID").val();
        //获取当前数量
        var sl_ = $("#HOUSEHOLD_SL").val();
        var item_id = $("#ITEM_ID").val();
        var offer_version = $("#offer_version").val();
        $("#cbjView").kendoWindow({
            width: "1000px",
            height: "600px",
            title: "调用参考报价",
            actions: ["Close"],
            content: "<%=basePath%>e_offer/selCbj.do?models=modelsId&HOUSEHOLD_SL="+sl_+
            		"&item_id="+item_id+"&offer_version="+offer_version,
            modal : true,
            visible : false,
            resizable : true
        }).data("kendoWindow").maximize().open();
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


    //设置disable--
    //设置地板装修厚度
    function setDbzxhd(){
        var dbxh_ = $("#JXZH_DBXH").val();
        if(dbxh_=="JD-08"){
            $("#JXZH_DBZXHD").val("3");
        }else{
            $("#JXZH_DBZXHD").val("");
        }
    }
    //井道承重墙厚度
    function setJdczqhdDisable(flag){
        if(flag=='1'){
            $("#BASE_JDCZQHD_TEXT").val("");
            $("#BASE_JDCZQHD_TEXT").attr("disabled","disabled");
        }else if(flag=='0'){
            $('#BASE_JDCZQHD_TEXT').removeAttr("disabled"); 
        }
    }



    //轿厢装潢-轿顶装潢
    function setJdzhDisable(flag){
        if(flag=="1"){
            $("#ZSDD_2").val("");
            $("#ZSDD_2").attr("disabled","disabled");
            $('#ZSDD_1').removeAttr("disabled"); 
        }else if(flag=="2"){
            $("#ZSDD_1").val("");
            $("#ZSDD_1").attr("disabled","disabled");
            $('#ZSDD_2').removeAttr("disabled"); 
        }else{
            $("#ZSDD_2").val("");
            $("#ZSDD_2").attr("disabled","disabled");
            $("#ZSDD_1").val("");
            $("#ZSDD_1").attr("disabled","disabled");
        }
    }
    //轿厢装潢-地板型号
    function setDbxhDisable(flag){
        if(flag=='1'){
            $("#JXZH_DBXH_SELECT").val("");
            $("#JXZH_DBXH_SELECT").attr("disabled","disabled");
            $("#JXZH_DBZXHD").val("3");
        }else if(flag=='0'){
            $('#JXZH_DBXH_SELECT').removeAttr("disabled"); 
        }
    }
    //轿厢装潢-扶手型号
    function setFsxhDisable(flag){
        if(flag=='1'){
            $("#JXZH_FSXH_SELECT").val("无");
            $("#JXZH_FSXH_SELECT").attr("disabled","disabled");
            $("#JXZH_FSXH_TEMP").val("");
            $("#JXZH_FSAZWZ_TEMP").val("");
        }else if(flag=='0'){
            $('#JXZH_FSXH_SELECT').removeAttr("disabled"); 
            $("#JXZH_FSXH_TEMP").val("");
            $("#JXZH_FSAZWZ_TEMP").val("");
        }
    }
  
  
    //厅门信号装置-厅外召唤型号
    function setTwzhxhDisable(flag){
        if(flag=="1"){
            $("#TMXHZZ_XS_1").val("");
            $("#TMXHZZ_XS_1").attr("disabled","disabled");
            $("#TMXHZZ_AN_1").val("");
            $("#TMXHZZ_AN_1").attr("disabled","disabled");
            $("#TMXHZZ_CZ_1").val("");
            $("#TMXHZZ_CZ_1").attr("disabled","disabled");
            $("#TMXHZZ_ZDJC_1").val("");
            $("#TMXHZZ_ZDJC_1").attr("disabled","disabled");
            $("#TMXHZZ_MCGS_1").val("");
            $("#TMXHZZ_MCGS_1").attr("disabled","disabled");
            $("#TMXHZZ_FJSM_1").val("");
            $("#TMXHZZ_FJSM_1").attr("disabled","disabled");
            $('#TMXHZZ_XS_2').removeAttr("disabled"); 
            $('#TMXHZZ_AN_2').removeAttr("disabled"); 
            $('#TMXHZZ_CZ_2').removeAttr("disabled"); 
            $('#TMXHZZ_ZDJC_2').removeAttr("disabled"); 
            $('#TMXHZZ_MCGS_2').removeAttr("disabled"); 
            $('#TMXHZZ_FJSM_2').removeAttr("disabled"); 
        }else if(flag=="2"){
            $("#TMXHZZ_XS_2").val("");
            $("#TMXHZZ_XS_2").attr("disabled","disabled");
            $("#TMXHZZ_AN_2").val("");
            $("#TMXHZZ_AN_2").attr("disabled","disabled");
            $("#TMXHZZ_CZ_2").val("");
            $("#TMXHZZ_CZ_2").attr("disabled","disabled");
            $("#TMXHZZ_ZDJC_2").val("");
            $("#TMXHZZ_ZDJC_2").attr("disabled","disabled");
            $("#TMXHZZ_MCGS_2").val("");
            $("#TMXHZZ_MCGS_2").attr("disabled","disabled");
            $("#TMXHZZ_FJSM_2").val("");
            $("#TMXHZZ_FJSM_2").attr("disabled","disabled");
            $('#TMXHZZ_XS_1').removeAttr("disabled"); 
            $('#TMXHZZ_AN_1').removeAttr("disabled"); 
            $('#TMXHZZ_CZ_1').removeAttr("disabled"); 
            $('#TMXHZZ_ZDJC_1').removeAttr("disabled"); 
            $('#TMXHZZ_MCGS_1').removeAttr("disabled"); 
            $('#TMXHZZ_FJSM_1').removeAttr("disabled"); 
        }
    }

    //计算基础价
    function setSbj(){
    	//调用初始化贯通门
    	
        Jsgtms();
    	
        var sd_ = $("#BZ_SD").val();  //速度
        if(sd_=="1.0"){var sd=1;}
        else if(sd_=="2.0"){var sd=2;}
        else{var sd=sd_;}
        var c_ = $("#BZ_C").val();     //层站
        var zz_ = $("#BZ_ZZ").val();  //载重
        var models_name = $("#tz_").val();  //型号名称
        var price = 0;
        $.post("<%=basePath%>e_offer/setBascPrice",
                {
                    "SD": sd,
                    "ZZ": zz_,
                    "C": c_,
                    "NAME": models_name
                },function(result)
                {
                    if(result.msg=="success")
                    {
                        if(result.pd!=null){
                            $("#SBJ_TEMP").val(result.pd.PRICE*sl_);
                            $("#DANJIA").val(result.pd.PRICE);
                        }else{
                            $("#SBJ_TEMP").val(0);
                            $("#DANJIA").val(0);
                        }

                        setMPrice();
                        
                        countZhj();
                    }
                    
                });
        //调用计算折扣
        JS_SJBJ();
    }


    //修改载重时
    function editZz(obj){
    	var Zz = $("#BZ_ZZ").val();
    	if (ele_type=="DT12") {
    		if (Zz=='450') {
        		$("#BZ_SD option[value='0.4']").remove();//删除0.4速度选项
        		$("#BZ_KMXS option[value='旁开(选配)']").remove();//删除开门形式旁开选项
    		}else{
    			$("#BZ_SD").empty();
    			$("#BZ_SD").append("<option value=''>请选择</option>"); 
    			$("#BZ_SD").append("<option value='0.4' ${regelevStandardPd.SD=='0.4'?'selected':''}>0.4</option>"); 
    			$("#BZ_SD").append("<option value='0.5' ${regelevStandardPd.SD=='0.5'?'selected':''}>0.5</option>"); 
    			$("#BZ_SD").append("<option value='1.0' ${regelevStandardPd.SD=='1.0'?'selected':''}>1.0</option>"); 
    			
    			$("#BZ_KMXS").empty();
    			$("#BZ_KMXS").append("<option value='中分(标配)' ${pd.BZ_KMXS=='中分(标配)'?'selected':''}>中分(标配)</option>"); 
    			$("#BZ_KMXS").append("<option value='旁开(选配)' ${pd.BZ_KMXS=='旁开(选配)'?'selected':''}>旁开(选配)</option>"); 
    		}
		}
    	        
        setSbj();
        if($("#BASE_JDZG").val()!=null && $("#BASE_JDZG").val()!="")
        {
        	setJdzg();
        }


    }
    //修改开门形式
//     function SetKMXS(){
//     	var kmxs_ = $("#BZ_KMXS").val();
//     	if (ele_type=="DT11") {
//     		if (kmxs_=="手拉式层门") {
//     			$("#BZ_KMXS_TEMP").val(10000);
// 			}else if(kmxs_=="自动式层门"){
// 				$("#BZ_KMXS_TEMP").val(15000);
// 			}else{
// 				$("#BZ_KMXS_TEMP").val(0);
// 			}
//     	}
//     }

    //修改速度时
    function editSd(){
        var sd_ = $("#BZ_SD").val();
        if (ele_type=="DT12") {
        	if (sd_=='0.4') {
        		//0.4速度,最高6楼
        		$("#BZ_C option[value='7']").remove();
        		$("#BZ_C option[value='8']").remove();
    		}else if(typeof($("#BZ_C option[value='7']").val())=="undefined"){
    			$("#BZ_C").append("<option value='7'>7</option>"); 
    			$("#BZ_C").append("<option value='8'>8</option>"); 
    		}
		}else if (ele_type=="DT11") {
			if (sd_=='0.4') {
				
			}
			
		}
    	
        
        setSbj();
        if($("#BASE_JDZG").val()!=null && $("#BASE_JDZG").val()!="")
        {
        	setJdzg();
        }
    }

    //修改门数量时修改标准价格
    function setMPrice(){
    	//调用初始化贯通门
        Jsgtms();
        
        var sbj_jj = parseInt($("#DANJIA").val());
        var m_ = parseInt($("#BZ_M").val());
        var c_ = parseInt($("#BZ_C").val());
        var z_ = parseInt($("#BZ_Z").val());//站
        var price = 0;
        var kmkd_ = parseInt($("#BZ_KMKD").val());
        if(!isNaN(m_)&&!isNaN(c_)&&!isNaN(z_)){
			//sbj_jj = sbj_jj * sl_;
        	
        	var _jj = 0;
        	if(kmkd_=="800"){
        		_jj = -1680;
            }else if(kmkd_=="900"){
            	_jj = -1920;
            }else if(kmkd_=="1100"){
            	_jj = -2200;
            }
        	
        	price = subDoor(sbj_jj, c_ , z_, m_, _jj);
        	
        	$("#SBJ_TEMP").val(price * sl_);
        	$("#BZ_M_TEMP").val(0);
        	
            /* var jm = c_-m_;
            if(jm>0){
                if(kmkd_=="800"){
                    price = -1680*jm*sl_;
                }else if(kmkd_=="900"){
                    price = -1920*jm*sl_;
                }else if(kmkd_=="1100"){
                    price = -2200*jm*sl_;
                }
            }
            $("#BZ_M_TEMP").val(price); */
            countZhj();
        }
        //修改门数后 再次加载价格
        cbjPrice();
    }

    
    function countZhj(){
        var zhj_count = 0;
        var sbj_count = 0;
        
        
        var base_jxks_temp = parseInt_DN($("#BASE_JXKS_TEMP").val());
        var base_jxgd_temp = parseInt_DN($("#BASE_JXGD_TEMP").val());//等于3000不可打折
       	var base_jxgd_fbtemp = 0;
        if ((base_jxgd_temp/sl_)==3000) {
        	base_jxgd_temp = 0;
        	base_jxgd_fbtemp = 3000;
		}
        
        
        var base_crkg_temp = parseInt_DN($("#BASE_CRKG_TEMP").val());
        var base_mkpzxs_temp = parseInt_DN($("#BASE_MKPZXS_TEMP").val());
        var base_kmfs_temp = parseInt_DN($("#BASE_KMFS_TEMP").val());
        var base_kzgwz_temp=parseInt_DN($("#BASE_KZGWZ_TEMP").val());
        var base_kzgwz_fbtemp = 0;
        if (base_kzgwz_temp/sl_==1000) {
        	base_kzgwz_temp = 0;
        	base_kzgwz_fbtemp = 1000;
		}
        var bz_m_temp = $("#BZ_M_TEMP").val()==""?0:parseInt_DN($("#BZ_M_TEMP").val());
        var base_jdzg_temp = parseInt_DN($("#BASE_JDZG_TEMP").val());
        var opt_ycfw_temp = parseInt_DN($("#OPT_YCFW_TEMP").val());
        var opt_tdtc_temp = parseInt_DN($("#OPT_TDTC_TEMP").val());
        var jn_djxt_temp = parseInt_DN($("#JN_DJXT_TEMP").val());
        var jn_czfs_temp = parseInt_DN($("#JN_CZFS_TEMP").val());
        
        //A2
        var base_jxbzxs_temp =parseInt_DN($("#BASE_JXBZXS_TEMP").val());
        var jxzh_jxczx_temp =parseInt_DN($("#JXZH_JXCZX_TEMP").val());
        var czgg_mblys_fbtemp =parseInt_DN($("#CZGG_MBLYS_TEMP").val());//加价3000不打折
        var base_yglx_fbtemp =parseInt_DN($("#BASE_YGLX_TEMP").val());
        
        
        //设备加价(整机规格+可选功能+机能)
        sbj_count = base_jxks_temp+base_jxgd_temp+base_crkg_temp+base_mkpzxs_temp+base_kmfs_temp+
       				base_kzgwz_temp+bz_m_temp+base_jdzg_temp+opt_ycfw_temp+opt_tdtc_temp+jn_djxt_temp+
       				jn_czfs_temp+base_jxbzxs_temp;
        
        var czgg_whxs_temp =parseInt_DN($("#CZGG_WHXS_TEMP").val());
        var czgg_whhxh_temp =parseInt_DN($("#CZGG_WHHXH_TEMP").val());
        var czgg_xmtczgg_temp =parseInt_DN($("#CZGG_XMTCZGG_TEMP").val());
        var czgg_xmtcz_temp =parseInt_DN($("#CZGG_XMTCZ_TEMP").val());
        var czgg_tmcz_temp =parseInt_DN($("#CZGG_TMCZ_TEMP").val());
        
        
        var jxzh_dbysbm_temp = parseInt_DN($("#JXZH_DBYSBM_TEMP").val());
        var jxzh_ddxh_temp = parseInt_DN($("#JXZH_DDXH_TEMP").val());
        var jxzh_xxxh_jm_temp = parseInt_DN($("#JXZH_XXXH_JM_TEMP").val());
        var jxzh_xxxh_jx_temp = parseInt_DN($("#JXZH_XXXH_JX_TEMP").val());
        var jxzh_qbgg_temp = parseInt_DN($("#JXZH_QBGG_TEMP").val());
        var jxzh_fssl_temp = parseInt_DN($("#JXZH_FSSL_TEMP").val());
        var jxzh_ylzl_temp = parseInt_DN($("#JXZH_YLZL_TEMP").val());
        var jxzh_jxczx_temp = parseInt_DN($("#JXZH_JXCZX_TEMP").val());
        var jxzh_jxxs_temp = parseInt_DN($("#JXZH_JXXS_TEMP").val());
        
        //装潢加价(轿厢规格+层站规格)
        zhj_count=czgg_whxs_temp+czgg_whhxh_temp+czgg_xmtczgg_temp+czgg_xmtcz_temp+czgg_tmcz_temp+jxzh_dbysbm_temp+
        			jxzh_ddxh_temp+jxzh_xxxh_jm_temp+jxzh_xxxh_jx_temp+jxzh_qbgg_temp+jxzh_fssl_temp+jxzh_ylzl_temp+
        			jxzh_jxczx_temp+jxzh_jxxs_temp+jxzh_jxczx_temp;
        
        var base_kzfs_temp = $("#BASE_KZFS_TEMP").val()==""?0:parseInt_DN($("#BASE_KZFS_TEMP").val());
        var base_dgzj_temp = $("#BASE_DGZJ_TEMP").val()==""?0:parseInt_DN($("#BASE_DGZJ_TEMP").val());
        /* var opt_ltbl_temp = $("#OPT_LTBL_TEMP").val()==""?0:parseInt_DN($("#OPT_LTBL_TEMP").val()); */
        /* var opt_tdjjjy_temp = $("#OPT_TDJJJY_TEMP").val()==""?0:parseInt_DN($("#OPT_TDJJJY_TEMP").val()); */
        var opt_jxdzz_temp = $("#OPT_JXDZZ_TEMP").val()==""?0:parseInt_DN($("#OPT_JXDZZ_TEMP").val());
        var opt_sjcz_temp = $("#OPT_SJCZ_TEMP").val()==""?0:parseInt_DN($("#OPT_SJCZ_TEMP").val());
        var opt_cctvdl_temp = $("#OPT_CCTVDL_TEMP").val()==""?0:parseInt_DN($("#OPT_CCTVDL_TEMP").val());
        var opt_djgrbh_temp = $("#OPT_DJGRBH_TEMP").val()==""?0:parseInt_DN($("#OPT_DJGRBH_TEMP").val());
        var opt_bajk_temp = $("#OPT_BAJK_TEMP").val()==""?0:parseInt_DN($("#OPT_BAJK_TEMP").val());
        var opt_mbcan_temp = $("#OPT_MBCAN_TEMP").val()==""?0:parseInt_DN($("#OPT_MBCAN_TEMP").val());
        var opt_kmzpc_temp = $("#OPT_KMZPC_TEMP").val()==""?0:parseInt_DN($("#OPT_KMZPC_TEMP").val());
        var opt_qpgm_temp = $("#OPT_QPGM_TEMP").val()==""?0:parseInt_DN($("#OPT_QPGM_TEMP").val());
        /* var opt_ycjk_temp = $("#OPT_YCJK_TEMP").val()==""?0:parseInt_DN($("#OPT_YCJK_TEMP").val()); */
        var opt_jfgt_temp = $("#OPT_JFGT_TEMP").val()==""?0:parseInt_DN($("#OPT_JFGT_TEMP").val());
        var opt_ick_temp = $("#OPT_ICK_TEMP").val()==""?0:parseInt_DN($("#OPT_ICK_TEMP").val());
        var opt_ickzksb_temp = $("#OPT_ICKZKSB_TEMP").val()==""?0:parseInt_DN($("#OPT_ICKZKSB_TEMP").val());
        var opt_ickkp_temp = $("#OPT_ICKKP_TEMP").val()==""?0:parseInt_DN($("#OPT_ICKKP_TEMP").val());
        var opt_gtmjxjmbf_temp = $("#OPT_GTMJXJMBF_TEMP").val()==""?0:parseInt_DN($("#OPT_GTMJXJMBF_TEMP").val());
        var opt_gtmtmbf_temp = $("#OPT_GTMTMBF_TEMP").val()==""?0:parseInt_DN($("#OPT_GTMTMBF_TEMP").val());
        var dzjksdjxt_djts_temp = $("#DZJKSDJXT_DJTS_TEMP").val()==""?0:parseInt_DN($("#DZJKSDJXT_DJTS_TEMP").val());
        var jxzh_jm_temp = $("#JXZH_JM_TEMP").val()==""?0:parseInt_DN($("#JXZH_JM_TEMP").val());
        /* var jxzh_jmzh_temp = $("#JXZH_JMZH_TEMP").val()==""?0:parseInt_DN($("#JXZH_JMZH_TEMP").val()); */
        var jxzh_jxzh_temp = $("#JXZH_JXZH_TEMP").val()==""?0:parseInt_DN($("#JXZH_JXZH_TEMP").val());
        var jxzh_qwb_temp = $("#JXZH_QWB_TEMP").val()==""?0:parseInt_DN($("#JXZH_QWB_TEMP").val());
       /*  var jxzh_cwb_temp = $("#JXZH_CWB_TEMP").val()==""?0:parseInt_DN($("#JXZH_CWB_TEMP").val());
        var jxzh_hwb_temp = $("#JXZH_HWB_TEMP").val()==""?0:parseInt_DN($("#JXZH_HWB_TEMP").val()); */
        var jxzh_zsdd_temp = $("#JXZH_ZSDD_TEMP").val()==""?0:parseInt_DN($("#JXZH_JM_TEMP").val());
        var jxzh_aqc_temp = $("#JXZH_AQC_TEMP").val()==""?0:parseInt_DN($("#JXZH_AQC_TEMP").val());
        var jxzh_bgj_temp = $("#JXZH_BGJ_TEMP").val()==""?0:parseInt_DN($("#JXZH_BGJ_TEMP").val());
        var jxzh_ylzhzl_temp = $("#JXZH_YLZHZL_TEMP").val()==""?0:parseInt_DN($("#JXZH_YLZHZL_TEMP").val());
        var jxzh_fsxh_temp = $("#JXZH_FSXH_TEMP").val()==""?0:parseInt_DN($("#JXZH_FSXH_TEMP").val());
        var jxzh_fsazwz_temp = $("#JXZH_FSAZWZ_TEMP").val()==""?0:parseInt_DN($("#JXZH_FSAZWZ_TEMP").val());
        var tmmt_scmkcz_temp = $("#TMMT_SCMKCZ_TEMP").val()==""?0:parseInt_DN($("#TMMT_SCMKCZ_TEMP").val());
        var tmmt_qycmkcz_temp = $("#TMMT_QYCMKCZ_TEMP").val()==""?0:parseInt_DN($("#TMMT_QYCMKCZ_TEMP").val());
        var tmmt_sctmcz_temp = $("#TMMT_SCTMCZ_TEMP").val()==""?0:parseInt_DN($("#TMMT_SCTMCZ_TEMP").val());
        var tmmt_qyctmcz_temp = $("#TMMT_QYCTMCZ_TEMP").val()==""?0:parseInt_DN($("#TMMT_QYCTMCZ_TEMP").val());
        /* var czp_czpxh_temp = $("#CZP_CZPXH_TEMP").val()==""?0:parseInt_DN($("#CZP_CZPXH_TEMP").val()); */
        /* var tmxhzz_cz_temp = $("#TMXHZZ_CZ_TEMP").val()==""?0:parseInt_DN($("#TMXHZZ_CZ_TEMP").val()); */
        var tmxhzz_gbscjrczx_temp = $("#TMXHZZ_GBSCJRCZX_TEMP").val()==""?0:parseInt_DN($("#TMXHZZ_GBSCJRCZX_TEMP").val());
        var base_ccjg = $("#BASE_CCJG").val()==""?0:parseInt_DN($("#BASE_CCJG").val());
        
//         zhj_count = base_ccjg+jxzh_jm_temp+jxzh_jxzh_temp+jxzh_qwb_temp+jxzh_zsdd_temp+jxzh_aqc_temp+jxzh_bgj_temp+jxzh_ylzhzl_temp+jxzh_fsazwz_temp;
        /* $("#FEIYUE_ZHJ").val(zhj_count); */
        
        //非标选项加价
        var opt_fb_temp = parseInt_DN($("#OPT_FB_TEMP").val())+base_jxgd_fbtemp+base_kzgwz_fbtemp;
//         sbj_count = bz_m_temp+base_kzfs_temp+base_jdzg_temp+base_dgzj_temp+opt_jxdzz_temp+opt_sjcz_temp+opt_cctvdl_temp+opt_djgrbh_temp+opt_bajk_temp+opt_mbcan_temp+opt_kmzpc_temp+opt_qpgm_temp+opt_jfgt_temp+opt_ick_temp+opt_ickzksb_temp+opt_ickkp_temp+opt_gtmjxjmbf_temp+opt_gtmtmbf_temp+dzjksdjxt_djts_temp+tmmt_scmkcz_temp+tmmt_qycmkcz_temp+tmmt_sctmcz_temp+tmmt_qyctmcz_temp+tmxhzz_gbscjrczx_temp+opt_fb_temp;
        //设备标准价格 (选项加价)
        var sbj_temp = parseInt_DN($("#SBJ_TEMP").val());
        $("#XS_XXJJ").val(sbj_count+zhj_count);
        //折前价 =基价+选项加价 
        $("#XS_ZQJ").val(sbj_count+zhj_count+sbj_temp);

        //运输费
        var delco_ysf = $("#DELCO_YSF").val()==""?0:parseInt_DN($("#DELCO_YSF").val());
        $("#DELCO_YSF").val(delco_ysf);
        //安装费
        var delco_azf = $("#DELCO_AZF_TEMP").val()==""?0:parseInt($("#DELCO_AZF_TEMP").val());
        $("#DELCO_AZF").val(delco_azf);
        
        //非标加价
        setFBPrice();

        var household_zk = parseFloat($("#HOUSEHOLD_ZK").val())/100;
        if(!isNaN(household_zk)){
            var household_sbj = parseInt($("#SBJ_TEMP").val());
            var household_sjbj = (household_sbj+zhj_count+sbj_count+household_azf+household_ysf)*household_zk;
            var household_zhsbj = household_sbj*household_zk;
            $("#HOUSEHOLD_SJBJ").val(household_sbj);
            $("#HOUSEHOLD_ZHSBJ").val(household_zhsbj);
            $("#zk_").text($("#HOUSEHOLD_ZK").val()+"%");
        }
        countInstallPrice();
        
        JS_SJBJ();
    }

    //计算井道总高-加价
    function setJdzg(){
    	var dtsl_ = parseInt($("#DT_SL").val());
        var tsgd_ = parseInt($("#BASE_TSGD").val());    //提升高度
        var dksd_ = parseInt($("#BASE_DKSD").val());     //底坑深度
        var dcgd_ = parseInt($("#BASE_DCGD").val());    //顶层高度
        //加价
        var price = 0;
        var dksd_ = parseInt_DN($("#BASE_DKSD").val());
        var dcgd_ = parseInt_DN($("#BASE_DCGD").val());
        //顶层高度或底坑深度小于300或者大于500提示非标
    	if (dksd_<300||dksd_>500||dcgd_<300||dcgd_>500) {
    		$("#BASE_CCJG").val("请非标询价");
		}else{
		
	        if(!isNaN(tsgd_)&&!isNaN(dksd_)&&!isNaN(dcgd_)){
	            var jdzg_ = tsgd_+dksd_+dcgd_;  //井道总高
	            $("#BASE_JDZG").val(jdzg_);
	            
	            //根据基本参数 获取提升高度 以及加价 
	            var sd_ = $("#BZ_SD").val();  //速度
	            if(sd_=="1.0"){var sd=1;}
	            else if(sd_=="2.0"){var sd=2;}
	            else{var sd=sd_;}
	            var c_ = $("#BZ_C").val();     //层站
	            var zz_ = $("#BZ_ZZ").val();  //载重
	            var models_name = $("#tz_").val();  //型号名称
	            $.post("<%=basePath%>e_offer/setBascPrice",
	                    {
	                        "SD": sd,
	                        "ZZ": zz_,
	                        "C": c_,
	                        "NAME": models_name
	                    },function(result)
	                    {
	                        if(result.msg=="success")
	                        {
	                        	var BZJDG = 0;
	                        	var JJ = 0;
	                        	if(result.pd != null){
	                        		BZJDG = result.pd.BZJDG;
	                        		JJ = result.pd.JJ;
	                        	}
	                       		var jdzg=$("#BASE_JDZG").val();
	                           	var ccgd=jdzg-parseInt(BZJDG*1000);//超出高度
	                           	var ccjg=(ccgd/1000)*JJ*dtsl_	; //超出高度加价
	                           	$("#BASE_CCGD").val(ccgd);
	                           	if(parseInt(ccjg)>0){
	                           		$("#BASE_CCJG").val(parseInt(ccjg));
	                           	}else{
	                           		$("#BASE_CCJG").val(0);
	                           	}
	                           	
	                           	$("#BASE_JDZG_TEMP").val("0");
	                            //放入价格
	                            countZhj();
	                            
	                        } 
	                    });
	            setDgzj();
	        }else{
	        	$("#BASE_CCGD").val("");
	        	$("#BASE_CCJG").val("");
	        	$("#BASE_JDZG_TEMP").val("");
	        	$("#BASE_JDZG").val("");
	        }
		}
    	//A2油缸类型联动加价
        if (ele_type=="DT11") {
        	editZJGG('BASE_YGLX');
		}
        
    }

    //计算导轨支架-加价
    function setDgzj(){
    	var sl_ = $("#FEIYUE_SL").val()==""?0:parseInt($("#FEIYUE_SL").val());
    	var sd_ = $("#BZ_SD").val();  //速度
        var c_ = $("#BZ_C").val();     //层站
        var zz_ = $("#BZ_ZZ").val();  //载重
        var models_name = $("#tz_").val();  //型号名称
        if(sd_=="1.0"){var sd=1;}
        else if(sd_=="2.0"){var sd=2;}
        else{var sd=sd_;}
        $.post("<%=basePath%>e_offer/setBascPrice",
                {
                    "SD": sd,
                    "ZZ": zz_,
                    "C": c_,
                    "NAME": models_name
                },function(result)
                {
                    if(result.msg=="success")
                    {
                    	//井道总高(标准)
                        //var jdzg_std=result.pd.BZJDG*1000;
                        var jdzg_std=$("#BASE_JDZG").val();
                        //计算标准导轨支架数量
                        var dgzj_std;
                        if(zz_=="630" || zz_=="800")
                        {
                        	dgzj_std = Math.ceil((jdzg_std/2500)+1);
                        }else if(zz_=="1000" || zz_=="1150")
                        {
                        	dgzj_std = Math.ceil((jdzg_std/2000)+1);
                        }
                        var price;
                        var jdzg_sj=$("#BASE_JDZG").val();  //实际井道总高
                        var qgljj_sj=$("#BASE_QGLJJ").val();//实际圈钢梁间距
                        //计算出实际导轨支架
                        if(jdzg_sj=="" || isNaN(jdzg_sj)){
                        	$("#BASE_DGZJ").val(0);
                          	$("#BASE_DGZJ_TEMP").val(0);
                        }else{
                            //计算出实际导轨支架
                            var dgzj_sj=Math.ceil((jdzg_sj/qgljj_sj)+1); 
                            price=(dgzj_sj-dgzj_std)*310;
                        	if(dgzj_sj>dgzj_std)
                            {
                            	$("#BASE_DGZJ").val(dgzj_sj);
                            	if(price>0){
                            		$("#BASE_DGZJ_TEMP").val(price*sl_);
                            	}else{
                            		$("#BASE_DGZJ_TEMP").val(0);
                            	}
                            }else{
                            	$("#BASE_DGZJ").val(dgzj_std);
                            	if(price>0){
                            		$("#BASE_DGZJ_TEMP").val(price*sl_);
                            	}else{
                            		$("#BASE_DGZJ_TEMP").val(0);
                            	}
                            }
                        }
                        //放入价格
                        countZhj();
                        
                    }
                    
                });

    }

    //可选功能部分加价
    function editOpt(option, isRefresh){
        //价格
        var price = 0;
        if (ele_type=="DT12") {
        	if (option=="OPT_YCFW") {
            	//加价5000
            	if($("#OPT_YCFW_TEXT").is(":checked")){
                    price = 5000*sl_;
                }else{
                    price = 0;
                }
            	$("#OPT_YCFW_TEMP").val(price);
    		}else if(option=="OPT_TDTC"){
    			//加价5500
            	if($("#OPT_TDTC_TEXT").is(":checked")){
                    price = 5500*sl_;
                }else{
                    price = 0;
                }
            	$("#OPT_TDTC_TEMP").val(price);
    		}
		}else if(ele_type=="DT11"){
			var price = 0;
			if (option=="OPT_YYTS"){
				if($("#OPT_YYTS_TEXT").is(":checked")){
	                price = 2800*sl_;
	            }else{
	                price = 0;
	            }
				$("#OPT_YYTS_TEMP").val(price);
			}else if(option=="OPT_SFDJ"){
				if($("#OPT_SFDJ_TEXT").is(":checked")){
	                price = 600*sl_;
	            }else{
	                price = 0;
	            }
				$("#OPT_SFDJ_TEMP").val(price);
			}else if(option=="OPT_BCMDR"){
				if($("#OPT_BCMDR_TEXT").is(":checked")){
	                price = 1000*sl_;
	            }else{
	                price = 0;
	            }
				$("#OPT_BCMDR_TEMP").val(price);
			}else if(option=="OPT_GGCTW"){
				if($("#OPT_GGCTW_TEXT").is(":checked")){
	                price = 1000*sl_;
	            }else{
	                price = 0;
	            }
				$("#OPT_GGCTW_TEMP").val(price);
			}else if(option=="OPT_YWLQ"){
				if($("#OPT_YWLQ_TEXT").is(":checked")){
	                price = 16800*sl_;
	            }else{
	                price = 0;
	            }
				$("#OPT_YWLQ_TEMP").val(price);
			}else if(option=="OPT_YWJR"){
				if($("#OPT_YWJR_TEXT").is(":checked")){
	                price = 2400*sl_;
	            }else{
	                price = 0;
	            }
				$("#OPT_YWJR_TEMP").val(price);
			}else if(option=="OPT_TWSK"){
				price = parseInt_DN($("#OPT_TWSK_SKGS").val())*2500;
				$("#OPT_TWSK_TEMP").val(price);
			}else if(option=="OPT_TWZW"){
				price = parseInt_DN($("#OPT_TWZW_KZGS").val())*4000;
				$("#OPT_TWZW_TEMP").val(price);
			}else if(option=="OPT_ZWSB"){
				price = parseInt_DN($("#OPT_ZWSB").val())*4000;
				$("#OPT_ZWSB_TEMP").val(price);
			}else if(option=="OPT_YCFW"){
				if($("#OPT_YCFW_TEXT").is(":checked")){
	                price = 5000*sl_;
	            }else{
	                price = 0;
	            }
				$("#OPT_YCFW_TEMP").val(price);
			}else if(option=="OPT_GZLS"){
				if($("#OPT_GZLS_TEXT").is(":checked")){
	                price = 1000*sl_;
	            }else{
	                price = 0;
	            }
				$("#OPT_GZLS_TEMP").val(price);
			}else if(option=="OPT_GZLS"){
				if($("#OPT_GZLS_TEXT").is(":checked")){
	                price = 1000*sl_;
	            }else{
	                price = 0;
	            }
				$("#OPT_GZLS_TEMP").val(price);
			}
		}
        if(isRefresh != '1'){
            //放入价格
            countZhj();
        }
    }
    
    function editJDKJ(option,isRefresh){
    	var price = 0;
		if(option=="KJXC"){
			//井道总高
			var jdzg_ = $("#BASE_JDZG").val();
			//没选玻璃加价
			if ($("#JDKJZS_KJXC").val()!="") {
				if ($("#JDKJZS_LEFT1").val()==""&&$("#JDKJZS_RIGHT1").val()==""
					&&$("#JDKJZS_BACK1").val()==""&&$("#JDKJZS_AHEAD1").val()=="") 
				{
					if ($("#JDKJZS_KJXC").val()=="DBC-01米白色"||$("#JDKJZS_KJXC").val()=="DBC-09银白氧化"
							||$("#JDKJZS_KJXC").val()=="DBC-10黑色亮光") {
						price = 4000*jdzg_*sl_;
					}else{
						price = 5500*jdzg_*sl_;
					}
				}else{
					//选了玻璃加价
					if ($("#JDKJZS_KJXC").val()=="DBC-01米白色"||$("#JDKJZS_KJXC").val()=="DBC-09银白氧化"
							||$("#JDKJZS_KJXC").val()=="DBC-10黑色亮光") {
						price = 4500*jdzg_*sl_;
					}else{
						price = 6000*jdzg_*sl_;
					}
				}
			}
			$("#JDKJZS_KJXC_TEMP").val(price);
		}else if(option=="JDKJZS_RADIOLEFT"){
			var radio_ = $("input[name='JDKJZS_RADIOLEFT']:checked").val();
			switch (radio_) {
			case "玻璃":
				//屏蔽其他选项
				$("#JDKJZS_LEFT1").removeAttr("disabled");
				$("#JDKJZS_LEFT3").val("");
				$("#JDKJZS_LEFT3").attr("disabled","disabled");
				$("#JDKJZS_YHZL_LEFT").val("");
				$("#JDKJZS_YHZL_LEFT").attr("disabled","disabled");
				break;
			case "框架玻璃用户自理":
				//屏蔽其他选项
				$("#JDKJZS_YHZL_LEFT").removeAttr("disabled");
				$("#JDKJZS_LEFT1").val("");
				$("#JDKJZS_LEFT1").attr("disabled","disabled");
				$("#JDKJZS_LEFT3").val("");
				$("#JDKJZS_LEFT3").attr("disabled","disabled");
				break;
			case "密度板":
				//屏蔽其他选项
				$("#JDKJZS_LEFT3").removeAttr("disabled");
				$("#JDKJZS_LEFT1").val("");
				$("#JDKJZS_LEFT1").attr("disabled","disabled");
				$("#JDKJZS_YHZL_LEFT").val("");
				$("#JDKJZS_YHZL_LEFT").attr("disabled","disabled");
				break;
			default:
				break;
			}
			//联动
			editJDKJ('LEFT');
		}else if(option=="JDKJZS_RADIORIGHT"){
			var radio_ = $("input[name='JDKJZS_RADIORIGHT']:checked").val();
			switch (radio_) {
			case "玻璃":
				//屏蔽其他选项
				$("#JDKJZS_RIGHT1").removeAttr("disabled");
				$("#JDKJZS_RIGHT3").val("");
				$("#JDKJZS_RIGHT3").attr("disabled","disabled");
				$("#JDKJZS_YHZL_RIGHT").val("");
				$("#JDKJZS_YHZL_RIGHT").attr("disabled","disabled");
				break;
			case "框架玻璃用户自理":
				//屏蔽其他选项
				$("#JDKJZS_YHZL_RIGHT").removeAttr("disabled");
				$("#JDKJZS_RIGHT1").val("");
				$("#JDKJZS_RIGHT1").attr("disabled","disabled");
				$("#JDKJZS_RIGHT3").val("");
				$("#JDKJZS_RIGHT3").attr("disabled","disabled");
				break;
			case "密度板":
				//屏蔽其他选项
				$("#JDKJZS_RIGHT3").removeAttr("disabled");
				$("#JDKJZS_RIGHT1").val("");
				$("#JDKJZS_RIGHT1").attr("disabled","disabled");
				$("#JDKJZS_YHZL_RIGHT").val("");
				$("#JDKJZS_YHZL_RIGHT").attr("disabled","disabled");
				break;
			default:
				break;
			}
			//联动
			editJDKJ('RIGHT');
		}else if(option=="JDKJZS_RADIOBACK"){
			var radio_ = $("input[name='JDKJZS_RADIOBACK']:checked").val();
			switch (radio_) {
			case "玻璃":
				//屏蔽其他选项
				$("#JDKJZS_BACK1").removeAttr("disabled");
				$("#JDKJZS_BACK3").val("");
				$("#JDKJZS_BACK3").attr("disabled","disabled");
				$("#JDKJZS_YHZL_BACK").val("");
				$("#JDKJZS_YHZL_BACK").attr("disabled","disabled");
				break;
			case "框架玻璃用户自理":
				//屏蔽其他选项
				$("#JDKJZS_YHZL_BACK").removeAttr("disabled");
				$("#JDKJZS_BACK1").val("");
				$("#JDKJZS_BACK1").attr("disabled","disabled");
				$("#JDKJZS_BACK3").val("");
				$("#JDKJZS_BACK3").attr("disabled","disabled");
				break;
			case "密度板":
				//屏蔽其他选项
				$("#JDKJZS_BACK3").removeAttr("disabled");
				$("#JDKJZS_BACK1").val("");
				$("#JDKJZS_BACK1").attr("disabled","disabled");
				$("#JDKJZS_YHZL_BACK").val("");
				$("#JDKJZS_YHZL_BACK").attr("disabled","disabled");
				break;
			default:
				break;
			}
			//联动
			editJDKJ('BACK');
		}else if(option=="JDKJZS_RADIOAHEAD"){
			var radio_ = $("input[name='JDKJZS_RADIOAHEAD']:checked").val();
			switch (radio_) {
			case "玻璃":
				//屏蔽其他选项
				$("#JDKJZS_AHEAD1").removeAttr("disabled");
				$("#JDKJZS_AHEAD3").val("");
				$("#JDKJZS_AHEAD3").attr("disabled","disabled");
				$("#JDKJZS_YHZL_AHEAD").val("");
				$("#JDKJZS_YHZL_AHEAD").attr("disabled","disabled");
				break;
			case "框架玻璃用户自理":
				//屏蔽其他选项
				$("#JDKJZS_YHZL_AHEAD").removeAttr("disabled");
				$("#JDKJZS_AHEAD1").val("");
				$("#JDKJZS_AHEAD1").attr("disabled","disabled");
				$("#JDKJZS_AHEAD3").val("");
				$("#JDKJZS_AHEAD3").attr("disabled","disabled");
				break;
			case "密度板":
				//屏蔽其他选项
				$("#JDKJZS_AHEAD3").removeAttr("disabled");
				$("#JDKJZS_AHEAD1").val("");
				$("#JDKJZS_AHEAD1").attr("disabled","disabled");
				$("#JDKJZS_YHZL_AHEAD").val("");
				$("#JDKJZS_YHZL_AHEAD").attr("disabled","disabled");
				break;
			default:
				break;
			}
			//联动
			editJDKJ('AHEAD');
		}else if(option=="LEFT"){
			if ($("#JDKJZS_LEFT1").val()!="") {
				$("#JDKJZS_LEFT").val($("#JDKJZS_LEFT1").val());
				if ($("#JDKJZS_LEFT1").val()!="DBM-01透明玻璃"&&$("#JDKJZS_LEFT1").val()!="DBM-73蒙砂玻璃") {
					price = "请非标询价";
				}
			}else if ($("#JDKJZS_YHZL_LEFT").val()!="") {
				$("#JDKJZS_LEFT").val($("#JDKJZS_YHZL_LEFT").val());
			}else if ($("#JDKJZS_LEFT3").val()!="") {
				$("#JDKJZS_LEFT").val($("#JDKJZS_LEFT3").val());
			}
			$("#JDKJZS_TEMP").val(price);
			//联动框架型材加价
			editJDKJ('KJXC');
		}else if(option=="RIGHT"){
			if ($("#JDKJZS_RIGHT1").val()!="") {
				$("#JDKJZS_RIGHT").val($("#JDKJZS_RIGHT1").val());
			}else if ($("#JDKJZS_YHZL_RIGHT").val()!="") {
				$("#JDKJZS_RIGHT").val($("#JDKJZS_YHZL_RIGHT").val());
			}else if ($("#JDKJZS_RIGHT3").val()!="") {
				$("#JDKJZS_RIGHT").val($("#JDKJZS_RIGHT3").val());
			}
			$("#JDKJZS_TEMP").val(price);
			//联动框架型材加价
			editJDKJ('KJXC');
		}else if(option=="BACK"){
			if ($("#JDKJZS_BACK1").val()!="") {
				$("#JDKJZS_BACK").val($("#JDKJZS_BACK1").val());
			}else if ($("#JDKJZS_YHZL_BACK").val()!="") {
				$("#JDKJZS_BACK").val($("#JDKJZS_YHZL_BACK").val());
			}else if ($("#JDKJZS_BACK3").val()!="") {
				$("#JDKJZS_BACK").val($("#JDKJZS_BACK3").val());
			}
			$("#JDKJZS_TEMP").val(price);
			//联动框架型材加价
			editJDKJ('KJXC');
		}else if(option=="AHEAD"){
			if ($("#JDKJZS_AHEAD1").val()!="") {
				$("#JDKJZS_AHEAD").val($("#JDKJZS_AHEAD1").val());
			}else if ($("#JDKJZS_YHZL_AHEAD").val()!="") {
				$("#JDKJZS_AHEAD").val($("#JDKJZS_YHZL_AHEAD").val());
			}else if ($("#JDKJZS_AHEAD3").val()!="") {
				$("#JDKJZS_AHEAD").val($("#JDKJZS_AHEAD3").val());
			}
			$("#JDKJZS_TEMP").val(price);
			//联动框架型材加价
			editJDKJ('KJXC');
		}
		
		if(isRefresh != '1'){
            //放入价格
            countZhj();
        }
    } 
    
    //单组监控室对讲系统-切换选中
    function Djtxfs_XZ(){
        $("#DZJKSDJXT_DJTS_TEMP").val('');
        $("#DZJKSDJXT_DJTS").val('');
        
    }

    //单组监控室对讲系统-加价
    function editDzjksdjxt(){
    	var djts=parseInt($("#DZJKSDJXT_DJTS").val());
    	var price = 0;
    	if(!isNaN(djts))
    	{
            if(djts>=10)
            {
            	price = 0;
            }
            else
            {
            	if($("input[name='DZJKSDJXT_DJTXFS']:checked").val()=="无线制"){
            		price = 3570+(2330*djts);
                }else if($("input[name='DZJKSDJXT_DJTXFS']:checked").val()=="总线制"){
                	price = 4080+(720*djts);
                }
            }
            $("#DZJKSDJXT_DJTS_TEMP").val(price);
            //放入价格
            countZhj();
    	}
    	$("#DZJKSDJXT_DJTS_TEMP").val(price);
    }

    //整机规格加价
    function editZJGG(option,isRefresh){
        var c_ = parseInt_DN($("#BZ_C").val());
        var z_ = parseInt_DN($("#BZ_Z").val());
        var m_ = parseInt_DN($("#BZ_M").val());
        
        //价格
        var price = 0;
        var fbprice =0;
        if (option=="BASE_JXKS") {
//         	标准：(320kg,)950*1200,950*1000(400),950*1200,1000*1250,1100*1400(450kg)
//             1100*1200 其他情况统一加价2000
			var jxk_ = $("#BASE_JXK").val();
			var jxs_ = $("#BASE_JXS").val();
			if (jxk_!=""&&jxs_!="") {
				if (ele_type=="DT12") {
					if (jxk_=="950(320kg\\400kg)"&&jxs_=="1200(320\\400kg\\450kg)"||
							jxk_=="950(320kg\\400kg)"&&jxs_=="1000(320kg)"||
							jxk_=="1000(400kg)"&&jxs_=="1250(400kg)"||
							jxk_=="1100(400kg\\450kg)"&&jxs_=="1400(400kg)"||
							jxk_=="1100(400kg\\450kg)"&&jxs_=="1200(320\\400kg\\450kg)"){
						price = 0;
						//不加价
					}else{
						price = 2000*sl_;
					}
				}else if(ele_type=="DT11"){
					var ygwz_ = $("#BASE_YGWZ").val();
					var zz_ = $("#BZ_ZZ").val();
						//侧置逻辑载重260
						if (zz_=="260") {
							if ((jxk_=="800"&&jxs_=="800")||(jxk_=="800"&&jxs_=="1000")
								||(jxk_=="1000"&&jxs_=="1000")||(jxk_=="1000"&&jxs_=="800")
							){
								price = 0;
							}else{
								price = 2000*sl_;
							}
						}else{
							//载重320和400
							if (ygwz_!="油缸后置") {
								if ((jxk_=="1000"&&jxs_=="1000")||(jxk_=="800"&&jxs_=="1250")
										||(jxk_=="1000"&&jxs_=="1250")
									){
										price = 0;
								}else{
									price = 2000*sl_;
								}
							}else{
								//油缸后置
								if ((jxk_=="1000"&&jxs_=="1000")||(jxk_=="1250"&&jxs_=="800")
										||(jxk_=="1250"&&jxs_=="1000")
									){
										price = 0;
								}else{
									price = 2000*sl_;
								}
							}
						}
					
				}
			}
			$("#BASE_JXKS_TEMP").val(price);
		}else if(option=="BASE_JXGD"){
// 			曳引轿高2300，加价2000元可打折；轿高2400，非标加价3000元不可打折；
			var jxgd_ = $("input[name='BASE_JXGD']:checked").val();
			if (jxgd_=="2300") {
				price = 2000*sl_;
			}else if(jxgd_=="2400"){
				price = 3000*sl_;//不可打折
			}else{
				price = 0;
			}
			$("#BASE_JXGD_TEMP").val(price);
		}else if(option=="BASE_CRKG"){
// 			标准2000，选项2100需选项加价400元/层
			var crkg_ = $("input[name='BASE_CRKG']:checked").val();
			if (crkg_=="2100") {
				price = 2100*sl_*c_;
			}else{
				price = 0;
			}
			$("#BASE_CRKG_TEMP").val(price);
		}else if(option=="BASE_MKPZXS"){
// 			D双出入口,TH贯通门,加价10000
			var mkpzxs_ = $("input[name='BASE_MKPZXS']:checked").val();
			if (mkpzxs_=="双出入口"||mkpzxs_=="贯通门") {
				price = 10000;
			}else{
				price = 0;
			}
			$("#BASE_MKPZXS_TEMP").val(price);
		}else if(option=="BASE_KMFS"){
// 			2S两扇旁开(选项)，加1000/台+950*层数，当门口配置型式选择D或TH时，加价2000/台+950*层数
			var kmfs_ = $("input[name='BASE_KMFS']:checked").val();
			var mkpzxs_ = $("input[name='BASE_MKPZXS']:checked").val();
			if (kmfs_=="两扇旁开(选项)") {
				price = 1000*sl_+950*c_;
				if (mkpzxs_=="双出入口"||mkpzxs_=="贯通门") {
					price = 1000*sl_+950*c_;
				}
			}
			$("#BASE_KMFS_TEMP").val(price);
		}else if(option=="BASE_KZGWZ"){
			var kzgwz_ = $("input[name='BASE_KZGWZ']:checked").val();
			if (kzgwz_=="特殊") {
				//非标加价1000不可打折
				price = 1000*sl_;
			}else{
				price = 0;
			}
			$("#BASE_KZGWZ_TEMP").val(price);
		}else if(option=="BASE_JDJG"){
			var jdjg_ = $("#BASE_JDJG").val();
			if (jdjg_=="铝合金框架(东南提供，室外梯防水客户自理)") {
				$("#BASE_JDJG_LABEL").show();
			}else{
				$("#BASE_JDJG_LABEL").hide();
			}
		}else if(option=="BASE_YGLX"){
			//油缸类型 提升高度mm换算米1:1000
			var tsgd_ = parseFloat($("#BASE_TSGD").val()).toFixed(1);
        	var yglx_ = $("#BASE_YGLX").val();
        	var price = 0;
        	if (yglx_=="单节缸") {
        		if (tsgd_ >11500 && tsgd_ <=12500) {
    				price=8000*sl_;
    			}
			}else if(yglx_=="对接缸"){
				if (tsgd_< 11500) {
					price = 3500*sl_;
				}else if(tsgd_>11500 && tsgd_<=12500) {
    				price=10500*sl_;
    			}else if(tsgd_>12500 && tsgd_<=13300){
    				price=11000*sl_;
    			}else if(tsgd_>13300 && tsgd_<=14500){
    				price=15500*sl_;
    			}else if(tsgd_>14500 && tsgd_<=15300){
    				price=16000*sl_;
    			}
				
			}
        	$("#BASE_YGLX_TEMP").val(price);
		}
        if(isRefresh != '1'){
            //放入价格
            countZhj();
        }
        
    }
    
    function editCZGG(option,isRefresh){
        //价格
        var price = 0;
        
        var c_ = parseInt_DN($("#BZ_C").val());
        var z_ = parseInt_DN($("#BZ_Z").val());
        var m_ = parseInt_DN($("#BZ_M").val());
    	if (option=="CZGG_WHXS") {
    		//200一层,层站改变时要跟联动
			if ($("input[name='CZGG_WHXS']:checked").val()=="蓝白液晶显示") {
				price = 200*c_*sl_
			}
    		
			$("#CZGG_WHXS_TEMP").val(price);
		}else if(option == "CZGG_WHHXH"){
			<!-- B，200/层  C：不加价，D：500/层，E：500/层，F：500/层，G：500/层 -->
			
			var czgg_whhxh_ = $("input[name='CZGG_WHHXH']:checked").val();
			if (typeof(czgg_whhxh_)!="undefined") {
				if (czgg_whhxh_!="发纹不锈钢HOP520S(标准)"&&czgg_whhxh_!="镜面不锈钢HOP520M"&&czgg_whhxh_!="HOP500(发纹)") {
					price = 500*c_*sl_;
				}else if(czgg_whhxh_=="镜面不锈钢HOP520M"){
					price = 200*c_*sl_;
				}
			}
			$("#CZGG_WHHXH_TEMP").val(price);
		}else if(option=="CZGG_XMTCZGG"){
			var czgg_xmtczgg_ = $("input[name='CZGG_XMTCZGG']:checked").val();
			if (czgg_xmtczgg_!="SUS:发纹(标准)"&&czgg_xmtczgg_!="SPP:喷漆"&&typeof(czgg_xmtczgg_)!="undefined") {
				price = 350*c_*sl_;
				
			}
			$("#CZGG_XMTCZGG_TEMP").val(price);
		}else if(option=="CZGG_XMTCZ"){
			<!-- B，200/层  C：不加价，D：500/层，E：500/层，F：500/层，G：500/层 -->
			var czgg_xmtcz_ = $("input[name='CZGG_XMTCZ']:checked").val();
			if (czgg_xmtcz_!="SUS:发纹(标准)"&&czgg_xmtcz_!="SPP:喷漆"&&typeof(czgg_xmtcz_)!="undefined") {
				price = 350*c_*sl_;
			}
			$("#CZGG_XMTCZ_TEMP").val(price);
		}else if(option=="CZGG_TMCZ"){
			<!-- B，200/层  C：不加价，D：500/层，E：500/层，F：500/层，G：500/层 -->
			var czgg_tmcz_ = $("input[name='CZGG_TMCZ']:checked").val();
			if (czgg_tmcz_!="SUS:发纹(标准)"&&czgg_tmcz_!="SPP:喷漆"&&typeof(czgg_tmcz_)!="undefined"){
				price = 2650*c_*sl_;
			}
			$("#CZGG_TMCZ_TEMP").val(price);
		}
    	 if(isRefresh != '1'){
             //放入价格
             countZhj();
         }
        
    }
    //编辑机能模块
    function editJN(option,isRefresh){
        //价格
        var price = 0;
        if (option=="JN_LLSZ") {
//         	单台不加价，其他非标
			if ($("input[name='JN_LLSZ']:checked").val()=="单台") {
				$("#JN_LLSZ_Label").hide();
			}else{
				$("#JN_LLSZ_Label").show();
			}
		}else if(option=="JN_DJXT"){
			if ($("input[name='JN_DJXT']:checked").val()=="五方通话"){
				price = 1000*sl_
			}
			$("#JN_DJXT_TEMP").val(price);
			
		}else if(option=="JN_CZFS"){
// 			B,C加价2500/个，DE，加4000/个
			if ($("input[name='JN_CZFS']:checked").val()=="轿内刷卡"||$("input[name='JN_CZFS']:checked").val()=="厅外刷卡") {
				$("input[name='JN_CZFSTEXT1']").val("");
				$("input[name='JN_CZFSTEXT1']").attr("disabled","disabled");
				price = 2500 * parseInt_DN($("input[name='JN_CZFSTEXT2']").val())*sl_;
			}else if($("input[name='JN_CZFS']:checked").val()=="厅外指纹识别"){
				$("input[name='JN_CZFSTEXT1']").removeAttr("disabled");
				price = 4000 * parseInt_DN($("input[name='JN_CZFSTEXT2']").val())*sl_;
			}else{
				$("input[name='JN_CZFSTEXT1']").val("");
				$("input[name='JN_CZFSTEXT1']").attr("disabled","disabled");
				price = 0;
			}
			$("#JN_CZFS_TEMP").val(price);
		}
        
        if(isRefresh != '1'){
            //放入价格
            countZhj();
        }
    }
    function editGTZFB(){
    	//底坑间距大于500加价2500
    	var dkjj_ = parseFloat($("#GTZFB_JJ1").val());
    	if (dkjj_ > 500) {
			price = 2500*sl_;
		}else{
			price = 0;
		}
    	$("#GTZFB_TEMP").val(price);
    }

    //轿厢装潢部分-加价
    function editJxzh(option, isRefresh){
        //数量
        
        //价格
        var price = 0;
        if(option=="JXZH_JXDB"){
        	if ($("input[name='JXZH_JXDB']:checked").val()=="客户自理") {
        		$('#JXZH_JXDBTEXT').removeAttr("disabled");
        		$('#JXZH_JXDBTEXT').val("");
			}else{
				$('#JXZH_JXDBTEXT').attr("disabled","disabled");
			}
        }else if(option=="BASE_JXBZXS"){
        	if ($("#BASE_JXBZXS").val()!="单开门(标准)") {
				price = 6000*sl_;
			}else{
				price = 0;
			}
        	$("#BASE_JXBZXS_TEMP").val(price);
        }
        else if(option=="JXZH_DBYSBM1"){
        	if ($("#JXZH_DBYSBM1").val()!="") {
        		$("#JXZH_DBYSBM2").val("");
            	$("#JXZH_DBYSBM3").val("");
            	$("#JXZH_DBYSBM").val($("#JXZH_DBYSBM1").val());
            	
            	price = 0;
            	$("#JXZH_DBYSBM_TEMP").val(price);
			}
        }else if(option=="JXZH_DBYSBM2"){
        	if ($("#JXZH_DBYSBM2").val()!="") {
        		$("#JXZH_DBYSBM").val($("#JXZH_DBYSBM2").val());
            	$("#JXZH_DBYSBM1").val("");
            	$("#JXZH_DBYSBM3").val("");
           		price = 4000*sl_;
    			price = 0;
            	$("#JXZH_DBYSBM_TEMP").val(price);
        	}
        }else if(option=="JXZH_DBYSBM3"){
        	if ($("#JXZH_DBYSBM2").val()!="") {
        		$("#JXZH_DBYSBM").val($("#JXZH_DBYSBM3").val());
            	$("#JXZH_DBYSBM1").val("");
            	$("#JXZH_DBYSBM2").val("");
            	if ($("#JXZH_DBYSBM3").val()!="") {
            		price = 6000*sl_;
    			}else{
    				price = 0;
    			}
            	$("#JXZH_DBYSBM_TEMP").val(price);
        	}
        }else if(option=="JXZH_DDXH1"){
        	$("#JXZH_DDXH").val($("#JXZH_DDXH1").val());
        	$("#JXZH_DDXH2").val("");
        	price = 0;
        	$("#JXZH_DDXH_TEMP").val(price);
        }else if(option=="JXZH_DDXH2"){
        	$("#JXZH_DDXH").val($("#JXZH_DDXH2").val());
        	$("#JXZH_DDXH1").val("");
        	if ($("#JXZH_DDXH2").val()!="") {
        		price = 1500*sl_;
			}else{
				price = 0;
			}
        	$("#JXZH_DDXH_TEMP").val(price);
        }else if(option=="JXZH_XXXH_JM"){
        	if ($("#JXZH_XXXH_JM").val()!="") {
            	price = 2650*sl_;
			}else{
				price = 0;
			}
        	$("#JXZH_XXXH_JM_TEMP").val(price);
        }else if(option=="JXZH_XXXH_JX"){
//         	加价DLC-43:56700,DLC-97:19000,DLC-99:15000,DLC-100:22000,DLC-102:17000,DLC-103:17000
//         	DLC-104:19600,DLC-115:11500,DLC-120:43500,DLC-122:41500
        	var jxzh_xxxh_jx = $("#JXZH_XXXH_JX").val();
        	switch (jxzh_xxxh_jx) {
			case "DLC-43":
				price = 56700*sl_;
				break;
			case "DLC-97":
				price = 19000*sl_;
				break;
			case "DLC-99":
				price = 15000*sl_;
				break;
			case "DLC-100":
				price = 22000*sl_;
				break;
			case "DLC-102":
				price = 17000*sl_;
				break;
			case "DLC-103":
				price = 17000*sl_;
				break;
			case "DLC-104":
				price = 19600*sl_;
				break;
			case "DLC-115":
				price = 11500*sl_;
				break;
			case "DLC-120":
				price = 43500*sl_;
				break;
			case "DLC-122":
				price = 41500*sl_;
				break;
			default:
				price = 0;
				break;
			}
        	$("#JXZH_XXXH_JX_TEMP").val(price);
        }else if(option=="JXZH_QBGG"){
//         	SUS,SPP不加价，其他1500（如轿厢规格选项型号已加价，则此处无需加价）
			var jxzh_qbgg_ = $("input[name='JXZH_QBGG']:checked").val();

			if (jxzh_qbgg_!="发纹(标准)" && jxzh_qbgg_!="喷漆" && typeof(jxzh_qbgg_)!="undefined"
					&&$("#JXZH_XXXH_JX_TEMP").val()=="0") {
				price = 1500*sl_;
			}else{
				price = 0;
			}
			$("#JXZH_QBGG_TEMP").val(price);
        }else if(option=="JXZH_YLZL"){
//         	10元/kg,最大200KG
			if (ele_type=="DT12") {
				if ($("#JXZH_SFYL").val()=="Y") {
					$("#JXZH_YLZL").removeAttr("disabled");
					$("#JXZH_YLZL").attr("required","required");
					$("#YLZLLabel").show();
					if ($("#JXZH_YLZL").val()>200) {
						$("#JXZH_YLZL").val("最大200KG");
					}
					price = 10*sl_*parseInt_DN($("#JXZH_YLZL").val());
				}else{
					price = 0;
					$("#YLZLLabel").hide();
					$("#JXZH_YLZL").attr("disabled","disabled");
					$("#JXZH_YLZL").removeAttr("required");
				}
			}else if(ele_type=="DT11"){
				//家用梯A2方法
				if ($("#JXZH_SFYL").val()=="Y") {
					$("#JXZH_YLZL").removeAttr("disabled");
					$("#JXZH_YLZL").attr("required","required");
					$("#YLZLLabel").show();
					price = 10*sl_*parseInt_DN($("#JXZH_YLZL").val());
					if ($("#JXZH_YLZL").val()>80) {
						price="请非标询价";
					}
				}else{
					price = 0;
					$("#YLZLLabel").hide();
					$("#JXZH_YLZL").attr("disabled","disabled");
					$("#JXZH_YLZL").removeAttr("required");
				}
			}
			
			
			$("#JXZH_YLZL_TEMP").val(price);
        }else if(option=="JXZH_JXCZX"){
//         	A:不加价，B:1000/台，C：1000，D：1000，E：1000 F：加价1000/台，G加价1500/台
			var jxzh_jxczx_ =$("input[name='JXZH_JXCZX']:checked").val();
			if (jxzh_jxczx_!="COP500(标准)"&&typeof(jxzh_jxczx_)!="undefined") {
				price = 1000;
				if ($("input[name='JXZH_JXCZX']:checked").val()=="COP520S(发纹)") {
					price = 1500;
				}
			}
			$("#JXZH_JXCZX_TEMP").val(price);
        }else if(option=="JXZH_JXXS"){
        	if ($("input[name='JXZH_JXXS']:checked").val()=="蓝白液晶显示(选配)") {
				price = 600*sl_;
			}
        	$("#JXZH_JXXS_TEMP").val(price);
        }else if(option=="JXZH_FSSL"){
//         	1个不加价，每加一个500
        	if (parseInt_DN($("#JXZH_FSSL").val())>1) {
				price = 500*sl_;
			}
        	$("#JXZH_FSSL_TEMP").val(price);
        }
        else if(option=="JXZH_JMZH"){
            //轿门装潢
        	var jmzh_ = $("#JXZH_JMZH").val();
            if(jmzh_!="喷涂")
            {
            	$("#JXZH_JMSBH").val("");
                $("#JXZH_JMSBH").attr("disabled","disabled");
            }
            else
            {
            	$('#JXZH_JMSBH').removeAttr("disabled"); 
            }
            
            var kmkd_ = $("#BZ_KMKD").val();  //开门宽度
            
            if(jmzh_=="JF-K-C01" || jmzh_=="发纹不锈钢"){
                price = 0;
            }else if(jmzh_=="JF-K-C02"||jmzh_=="JF-K-C03"){
                price = 2950*sl_;
            }else if(jmzh_=="JF-K-C04"||jmzh_=="JF-K-C05"||jmzh_=="JF-K-C06"||jmzh_=="JF-K-C07"){
                price = 3420*sl_;
            }else if(jmzh_=="喷涂")
            {
            	if(kmkd_=="800"){
                    price = -580*sl_;
                }else if(kmkd_=="900"){
                    price = -680*sl_;
                }else if(kmkd_=="1000"){
                    price = -780*sl_;
                }
            }else if(jmzh_=="镜面不锈钢")
            {
            	if(kmkd_=="800"){
                    price = 1340*sl_;
                }else if(kmkd_=="900"){
                    price = 1380*sl_;
                }else if(kmkd_=="1000"){
                    price = 1420*sl_;
                }
            }
            $("#JXZH_JM_TEMP").val(price);
        }else if(option=="JXZH_JXZH"){
            //轿厢装潢
            var jxzh_ = $("#JXZH_JXZH").val();
            if(jxzh_=="JF-K-JX-01"){
                price = 0;
            }else if(jxzh_=="JF-K-JX-02"){
                price = 19100*sl_;
            }else if(jxzh_=="JF-K-JX-03"){
                price = 27500*sl_;
            }else if(jxzh_=="JF-K-JX-04"){
                price = 33200*sl_;
            }else if(jxzh_=="JF-K-JX-05"){
                price = 16000*sl_;
            }else if(jxzh_=="JF-K-JX-06"){
                price = 25100*sl_;
            }else if(jxzh_=="JF-K-JX-07"){
                price = 22700*sl_;
            }else if(jxzh_=="JF-K-JX-08"){
                price = 32700*sl_;
            }else if(jxzh_=="JF-K-JX-09"){
                price = 13200*sl_;
            }else if(jxzh_=="JF-K-JX-10"){
                price = 19600*sl_;
            }else if(jxzh_=="JF-K-JX-11"){
                price = 19600*sl_;
            }
            $("#JXZH_JXZH_TEMP").val(price);
        }else if(option=="JXZH_QWB"){
            //前围壁
            var qwb_ = $("input[name='JXZH_QWB']:checked").val();
            var zz_ = $("#BZ_ZZ").val();//载重
            if(qwb_=="喷涂"){
            	var cwb_pt = $("input[id='JXZH_CWB_PT']:checked").val();
            	var hwb_pt = $("input[id='JXZH_HWB_PT']:checked").val();
            	if(cwb_pt=="喷涂" && hwb_pt=="喷涂")
            	{
            		if(zz_=="630"){
                        price = -2450*sl_;
                    }else if(zz_=="800"){
                        price = -2700*sl_;
                    }else if(zz_=="1000"){
                        price = -2800*sl_;
                    }else if(zz_=="1150"){
                        price = -2900*sl_;
                    }
            	}else{price=0;}
                
            }else if(qwb_=="发纹不锈钢"){
            	var cwb_fw = $("input[id='JXZH_CWB_FW']:checked").val();
            	var hwb_fw = $("input[id='JXZH_HWB_FW']:checked").val();
            	if(cwb_fw=="发纹不锈钢" && hwb_fw=="发纹不锈钢")
            	{price=0;}else{price=0;}
            }else if(qwb_=="镜面不锈钢"){
            	var cwb_jm = $("input[id='JXZH_CWB_JM']:checked").val();
            	var hwb_jm = $("input[id='JXZH_HWB_JM']:checked").val();
            	if(cwb_jm=="镜面不锈钢" && hwb_jm=="镜面不锈钢")
            	{
            		if(zz_=="630"){
                        price = 6840*sl_;
                    }else if(zz_=="800"){
                        price = 6840*sl_;
                    }else if(zz_=="1000"){
                        price = 6840*sl_;
                    }else if(zz_=="1150"){
                        price = 7080*sl_;
                    }
            	}else{price=0;}
            }
            $("#JXZH_QWB_TEMP").val(price);
        }else if(option=="JXZH_CWB"){
            //侧围壁
            var cwb_ = $("input[name='JXZH_CWB']:checked").val();
            var zz_ = $("#BZ_ZZ").val();//载重
            if(cwb_=="喷涂"){
            	var qwb_pt = $("input[id='JXZH_QWB_PT']:checked").val();
            	var hwb_pt = $("input[id='JXZH_HWB_PT']:checked").val();
            	if(qwb_pt=="喷涂" && hwb_pt=="喷涂")
            	{
            		if(zz_=="630"){
                        price = -2450*sl_;
                    }else if(zz_=="800"){
                        price = -2700*sl_;
                    }else if(zz_=="1000"){
                        price = -2800*sl_;
                    }else if(zz_=="1150"){
                        price = -2900*sl_;
                    }
            	}else{price=0;}
            }else if(cwb_=="发纹不锈钢"){
            	var qwb_fw = $("input[id='JXZH_QWB_FW']:checked").val();
            	var hwb_fw = $("input[id='JXZH_HWB_FW']:checked").val();
            	if(qwb_fw=="发纹不锈钢" && hwb_fw=="发纹不锈钢")
            	{price=0;}else{price=0;}
            }else if(cwb_=="镜面不锈钢"){
            	var qwb_jm = $("input[id='JXZH_QWB_JM']:checked").val();
            	var hwb_jm = $("input[id='JXZH_HWB_JM']:checked").val();
            	if(qwb_jm=="镜面不锈钢" && hwb_jm=="镜面不锈钢")
            	{
            		if(zz_=="630"){
                        price = 6840*sl_;
                    }else if(zz_=="800"){
                        price = 6840*sl_;
                    }else if(zz_=="1000"){
                        price = 6840*sl_;
                    }else if(zz_=="1150"){
                        price = 7080*sl_;
                    }
            	}else{price=0;}
            }
            $("#JXZH_QWB_TEMP").val(price);
        }else if(option=="JXZH_HWB"){
            //后围壁
            var hwb_ = $("input[name='JXZH_HWB']:checked").val();
            var zz_ = $("#BZ_ZZ").val();//载重
            if(hwb_=="喷涂"){
            	var qwb_pt = $("input[id='JXZH_QWB_PT']:checked").val();
            	var cwb_pt = $("input[id='JXZH_CWB_PT']:checked").val();
            	if(qwb_pt=="喷涂" && cwb_pt=="喷涂")
            	{
            		if(zz_=="630"){
                        price = -2450*sl_;
                    }else if(zz_=="800"){
                        price = -2700*sl_;
                    }else if(zz_=="1000"){
                        price = -2800*sl_;
                    }else if(zz_=="1150"){
                        price = -2900*sl_;
                    }
            	}else{price=0;}
                
            }else if(hwb_=="发纹不锈钢"){
            	var qwb_fw = $("input[id='JXZH_QWB_FW']:checked").val();
            	var cwb_fw = $("input[id='JXZH_CWB_FW']:checked").val();
            	if(qwb_fw=="发纹不锈钢" && cwb_fw=="发纹不锈钢")
            	{price=0;}else{price=0;}
            }else if(hwb_=="镜面不锈钢"){
            	var qwb_jm = $("input[id='JXZH_QWB_JM']:checked").val();
            	var cwb_jm = $("input[id='JXZH_CWB_JM']:checked").val();
            	if(qwb_jm=="镜面不锈钢" && cwb_jm=="镜面不锈钢")
            	{
            		if(zz_=="630"){
                        price = 6840*sl_;
                    }else if(zz_=="800"){
                        price = 6840*sl_;
                    }else if(zz_=="1000"){
                        price = 6840*sl_;
                    }else if(zz_=="1150"){
                        price = 7080*sl_;
                    }
            	}else{price=0;}
            }
            $("#JXZH_QWB_TEMP").val(price);
        }else if(option=="JXZH_ZSDD"){
            //轿顶装潢-装饰吊顶
            var zsdd_ = $("select[name='JXZH_ZSDD']").val();
            var zz_ = $("#BZ_ZZ").val();//载重
            if(zsdd_=="JF-CL-01"){
                if(zz_=="450"){
                    price = -380*sl_;
                }else if(zz_=="630"){
                    price = -540*sl_;
                }else if(zz_=="800"){
                    price = -620*sl_;
                }else if(zz_=="1000"){
                    price = -710*sl_;
                }
            }else if(zsdd_=="JF-CL-02"){
                if(zz_=="450"){
                    price = -380*sl_;
                }else if(zz_=="630"){
                    price = -540*sl_;
                }else if(zz_=="800"){
                    price = -620*sl_;
                }else if(zz_=="1000"){
                    price = -710*sl_;
                }
            }else if(zsdd_=="JF-CL-03"){
                if(zz_=="450"){
                    price = -380*sl_;
                }else if(zz_=="630"){
                    price = -540*sl_;
                }else if(zz_=="800"){
                    price = -620*sl_;
                }else if(zz_=="1000"){
                    price = -710*sl_;
                }
            }else if(zsdd_=="JF-CL-04"){
                if(zz_=="450"){
                    price = 330*sl_;
                }else if(zz_=="630"){
                    price = -540*sl_;
                }else if(zz_=="800"){
                    price = -620*sl_;
                }else if(zz_=="1000"){
                    price = -710*sl_;
                }
            }else if(zsdd_=="JF-CL-21"){
                if(zz_=="450"){
                    price = 240*sl_;
                }else if(zz_=="630"){
                    price = 240*sl_;
                }else if(zz_=="800"){
                    price = 240*sl_;
                }else if(zz_=="1000"){
                    price = 240*sl_;
                }else if(zz_=="1350"){
                    price = 280*sl_;
                }else if(zz_=="1600"){
                    price = 390*sl_;
                }else if(zz_=="2000"){
                    price = 510*sl_;
                }
            }
            $("#JXZH_ZSDD_TEMP").val(price);
        }else if(option=="JXZH_AQC"){
            //安全窗
            var aqc_ = $("input[name='JXZH_AQC']:checked").val();
            if(aqc_=="有"){
                price = 1300*sl_;
            }else if(aqc_=="无"){
                price = 0;
            }
            $("#JXZH_AQC_TEMP").val(price);
        }else if(option=="JXZH_BGJ"){
            //半高镜
            var bgj_ = $("input[name='JXZH_BGJ']:checked").val();
            if(bgj_=="有"){
                var zz_ = $("#BZ_ZZ").val();  //载重
                if(zz_=="630"){
                    price = 980*sl_;
                }else if(zz_=="800"){
                    price = 980*sl_;
                }else if(zz_=="1000"){
                    price = 1300*sl_;
                }else if(zz_=="1150"){
                    price = 1500*sl_;
                }
            }else if(bgj_=="无"){
                price = 0;
            }
            $("#JXZH_BGJ_TEMP").val(price);
        }else if (option =="JXZH_JXCZX") {
        	var jxczx_ = $("input[name='JXZH_JXCZX_LX']:checked").val();
        	if (jxczx_=="DBK-17") {
				price = 1500*sl_
			}else{
				price = 0;
			}
        	$("#JJXZH_JXCZX_TEMP").val(price);
		}else if (option =="JXZH_MBLYS") {
        	if ($("#JXZH_MBLYS1").val()=="DBB-37白色"||$("#JXZH_MBLYS1").val()=="DBB-37木色") {
				price = 3000;
			}else{
				price = 0;
			}
        	$("#JXZH_MBLYS_TEMP").val(price);
		}else if(option=="JXZH_DD"){
			//A2吊顶
			if ($("#JXZH_DD").val()=="DBD-09太阳星辰"||$("#JXZH_DD").val()=="DBD-14伞花"
					||$("#JXZH_DD").val()=="DBD-16漩涡"||$("#JXZH_DD").val()=="DBD-83飞絮")
			{
				price = 1000*sl_;
			}else if ($("#JXZH_DD").val()=="DBD-111金色"||$("#JXZH_DD").val()=="DBD-111银色"
					||$("#JXZH_DD").val()=="DBD-112金色"||$("#JXZH_DD").val()=="DBD-112银色")
			{
				price = 4000*sl_;
			}else{
				price = 0;
			}
			$("#JXZH_DD_TEMP").val(price);
		}else if(option=="JXZH_JD1"){
			if ($("#JXZH_JD1").val()!="") {
        		$("#JXZH_JD2").val("");
            	$("#JXZH_JD3").val("");
            	$("#JXZH_JD").val($("#JXZH_JD1").val());
            	price = 0;
            	$("#JXZH_JD_TEMP").val(price);
			}
		}else if(option=="JXZH_JD2"){
			if ($("#JXZH_JD2").val()!="") {
        		$("#JXZH_JD1").val("");
            	$("#JXZH_JD3").val("");
            	$("#JXZH_JD").val($("#JXZH_JD2").val());
            	price = 0;
            	$("#JXZH_JD_TEMP").val(price);
			}
		}else if(option=="JXZH_JD3"){
			if ($("#JXZH_JD3").val()!="") {
        		$("#JXZH_JD1").val("");
            	$("#JXZH_JD2").val("");
            	$("#JXZH_JD").val($("#JXZH_JD3").val());
            	price = 6000*sl_;
            	$("#JXZH_JD_TEMP").val(price);
			}
		}else if(option=="JXZH_JB_RADIOLEFT"){
			var radioleft_ = $("input[name='JXZH_JB_RADIOLEFT']:checked").val();
			switch (radioleft_) {
			case "玻璃":
				//屏蔽其他选项
				$("#JXZH_JB_LEFT1").removeAttr("disabled");
				$("#JXZH_JB_LEFT2").val("");
				$("#JXZH_JB_LEFT2").attr("disabled","disabled");
				$("#JXZH_JB_LEFTSDS_TEXT1").val("");
				$("#JXZH_JB_LEFTSDS_TEXT1").attr("disabled","disabled");
				$("#JXZH_JB_LEFTSDS").val("");
				$("#JXZH_JB_LEFTSDS").attr("disabled","disabled");
				$("#JXZH_JB_LEFTSDSZSB").val("");
				$("#JXZH_JB_LEFTSDSZSB").attr("disabled","disabled");
				$("#JXZH_JB_LEFTSDS_TEXT2").val("");
				$("#JXZH_JB_LEFTSDS_TEXT2").attr("disabled","disabled");
				$("#JXZH_JB_LEFT3").val("");
				$("#JXZH_JB_LEFT3").attr("disabled","disabled");
				
				break;
			case "木轿壁":
				$("#JXZH_JB_LEFT2").removeAttr("disabled");
				$("#JXZH_JB_LEFT1").val("");
				$("#JXZH_JB_LEFT1").attr("disabled","disabled");
				$("#JXZH_JB_LEFTSDS_TEXT1").val("");
				$("#JXZH_JB_LEFTSDS_TEXT1").attr("disabled","disabled");
				$("#JXZH_JB_LEFTSDS").val("");
				$("#JXZH_JB_LEFTSDS").attr("disabled","disabled");
				$("#JXZH_JB_LEFTSDSZSB").val("");
				$("#JXZH_JB_LEFTSDSZSB").attr("disabled","disabled");
				$("#JXZH_JB_LEFTSDS_TEXT2").val("");
				$("#JXZH_JB_LEFTSDS_TEXT2").attr("disabled","disabled");
				$("#JXZH_JB_LEFT3").val("");
				$("#JXZH_JB_LEFT3").attr("disabled","disabled");
				
				break;
			case "三段式":
				$("#JXZH_JB_LEFTSDS_TEXT1").removeAttr("disabled");
				$("#JXZH_JB_LEFTSDS").removeAttr("disabled");
				$("#JXZH_JB_LEFTSDSZSB").removeAttr("disabled");
				$("#JXZH_JB_LEFTSDS_TEXT2").removeAttr("disabled");
				$("#JXZH_JB_LEFT1").val("");
				$("#JXZH_JB_LEFT1").attr("disabled","disabled");
				$("#JXZH_JB_LEFT2").val("");
				$("#JXZH_JB_LEFT2").attr("disabled","disabled");
				$("#JXZH_JB_LEFT3").val("");
				$("#JXZH_JB_LEFT3").attr("disabled","disabled");
					
				break;
			case "密度板":
				//屏蔽其他选项
				$("#JXZH_JB_LEFT3").removeAttr("disabled");
				$("#JXZH_JB_LEFT1").val("");
				$("#JXZH_JB_LEFT1").attr("disabled","disabled");
				$("#JXZH_JB_LEFT2").val("");
				$("#JXZH_JB_LEFT2").attr("disabled","disabled");
				$("#JXZH_JB_LEFTSDS_TEXT1").val("");
				$("#JXZH_JB_LEFTSDS_TEXT1").attr("disabled","disabled");
				$("#JXZH_JB_LEFTSDS").val("");
				$("#JXZH_JB_LEFTSDS").attr("disabled","disabled");
				$("#JXZH_JB_LEFTSDSZSB").val("");
				$("#JXZH_JB_LEFTSDSZSB").attr("disabled","disabled");
				$("#JXZH_JB_LEFTSDS_TEXT2").val("");
				$("#JXZH_JB_LEFTSDS_TEXT2").attr("disabled","disabled");
				
				break;
			default:
				break;
			}
		}else if(option=="JXZH_JB_RADIORIGHT"){
			var radioright_ = $("input[name='JXZH_JB_RADIORIGHT']:checked").val();
			switch (radioright_) {
			case "玻璃":
				$("#JXZH_JB_RIGHT1").removeAttr("disabled");
				$("#JXZH_JB_RIGHT3").val("");
				$("#JXZH_JB_RIGHT3").attr("disabled","disabled");
				break;
			case "密度板":
				$("#JXZH_JB_RIGHT3").removeAttr("disabled");
				$("#JXZH_JB_RIGHT1").val("");
				$("#JXZH_JB_RIGHT1").attr("disabled","disabled");
				break;
			default:
				break;
			}
		}else if(option=="JXZH_JB_RADIOBACK"){
			var radioback_ = $("input[name='JXZH_JB_RADIOBACK']:checked").val();
			switch (radioback_) {
			case "玻璃":
				$("#JXZH_JB_BACK1").removeAttr("disabled");
				$("#JXZH_JB_BACK3").val("");
				$("#JXZH_JB_BACK3").attr("disabled","disabled");
				break;
			case "密度板":
				$("#JXZH_JB_BACK3").removeAttr("disabled");
				$("#JXZH_JB_BACK1").val("");
				$("#JXZH_JB_BACK1").attr("disabled","disabled");
				break;
			default:
				break;
			}
		}else if(option=="JXZH_JB_LEFT"){
			if ($("#JXZH_JB_LEFT1").val()!="") {
				//轿厢装潢轿壁左玻璃
				$("#JXZH_JB_LEFT").val($("#JXZH_JB_LEFT1").val());
				if ($("#JXZH_JB_LEFT1").val()=="DBM-74"||$("#JXZH_JB_LEFT1").val()=="DBM-122") {
					price = 1500*sl_;
				}else{
					price = 2500*sl_;
				}
			}else if($("#JXZH_JB_LEFT2").val()!=""){
				//轿厢装潢轿壁左木轿壁
				$("#JXZH_JB_LEFT").val($("#JXZH_JB_LEFT2").val());
				price = 3000*sl_;
			}else if($("#JXZH_JB_LEFT3").val()!=""){
				//轿厢装潢轿壁左密度板
				$("#JXZH_JB_LEFT").val($("#JXZH_JB_LEFT3").val());
				price = 0;
			}
			//左轿壁价格赋值与汇总
			$("#JXZH_JB_LEFTTEMP").val(price);
			var countTemp = parseInt_DN($("#JXZH_JB_LEFTTEMP").val())+parseInt_DN($("#JXZH_JB_RIGHTTEMP").val())
				+parseInt_DN($("#JXZH_JB_BACKTEMP").val());
			$("#JXZH_JB_TEMP").val(countTemp);
		}else if(option=="JXZH_JB_RIGHT"){
			////轿厢装潢轿壁右玻璃
			if ($("#JXZH_JB_RIGHT1").val()!="") {
				$("#JXZH_JB_RIGHT").val($("#JXZH_JB_RIGHT1").val());
				if ($("#JXZH_JB_RIGHT1").val()=="DBM-74"||$("#JXZH_JB_RIGHT1").val()=="DBM-122") {
					price = 1500*sl_;
				}else if($("#JXZH_JB_RIGHT1").val()=="DBM-14"||$("#JXZH_JB_RIGHT1").val()=="DBM-16"
							||$("#JXZH_JB_RIGHT1").val()=="DBM-32")
				{
					price = 2500*sl_;
				}
			}else if($("#JXZH_JB_RIGHT3").val()!=""){
			//右密度板
				$("#JXZH_JB_RIGHT").val($("#JXZH_JB_RIGHT3").val());
				price = 0;
			}
			//右轿壁价格赋值与汇总
			$("#JXZH_JB_RIGHTTEMP").val(price);
			var countTemp = parseInt_DN($("#JXZH_JB_LEFTTEMP").val())+parseInt_DN($("#JXZH_JB_RIGHTTEMP").val())
				+parseInt_DN($("#JXZH_JB_BACKTEMP").val());
			$("#JXZH_JB_TEMP").val(countTemp);
		}else if(option=="JXZH_JB_BACK"){
			//后玻璃
			if ($("#JXZH_JB_BACK1").val()!="") {
				$("#JXZH_JB_BACK").val($("#JXZH_JB_BACK1").val());
				if ($("#JXZH_JB_BACK1").val()=="DBM-74"||$("#JXZH_JB_BACK1").val()=="DBM-122") {
					price = 1500*sl_;
				}else if($("#JXZH_JB_BACK1").val()=="DBM-14"||$("#JXZH_JB_BACK1").val()=="DBM-16"
							||$("#JXZH_JB_BACK1").val()=="DBM-32")
				{
					price = 2500*sl_;
				}
			}else if($("#JXZH_JB_BACK3").val()!=""){
			//后密度板
				$("#JXZH_JB_BACK").val($("#JXZH_JB_BACK3").val());
			}
			$("#JXZH_JB_BACKTEMP").val(price);
			var countTemp = parseInt_DN($("#JXZH_JB_LEFTTEMP").val())+parseInt_DN($("#JXZH_JB_RIGHTTEMP").val())
				+parseInt_DN($("#JXZH_JB_BACKTEMP").val());
			$("#JXZH_JB_TEMP").val(countTemp);
		}else if(option=="JXZH_JB_SDS"){
			var sds_ = $("#JXZH_JB_LEFTSDS").val();
			switch (sds_) {
			case "装饰板":
				price = 500*sl_;
				$("#JXZH_JB_LEFTSDSZSB").show();
				break;
			case "发纹(单面)":
				price = (500+200)*sl_;
				//清空装饰板型号选项
				$("#JXZH_JB_LEFTSDSZSB").val("");
				$("#JXZH_JB_LEFTSDSZSB").hide();
				break;
			case "发纹(双面)":
				price = (500+200)*2*sl_;
				$("#JXZH_JB_LEFTSDSZSB").val("");
				$("#JXZH_JB_LEFTSDSZSB").hide();
				break;
			case "镜面(单面)":
				price = (500+300)*sl_;
				$("#JXZH_JB_LEFTSDSZSB").val("");
				$("#JXZH_JB_LEFTSDSZSB").hide();
				break;
			case "镜面(双面)":
				price = (500+300)*2*sl_;
				$("#JXZH_JB_LEFTSDSZSB").val("");
				$("#JXZH_JB_LEFTSDSZSB").hide();
				break;
			case "钛金(单面)":
				price = (500+400)*sl_;
				$("#JXZH_JB_LEFTSDSZSB").val("");
				$("#JXZH_JB_LEFTSDSZSB").hide();
				break;
			case "钛金(双面)":
				price = (500+400)*2*sl_;
				//清空装饰板型号选项
				$("#JXZH_JB_LEFTSDSZSB").val("");
				$("#JXZH_JB_LEFTSDSZSB").hide();
				break;

			default:
				break;
			}
			//左轿壁价格赋值与汇总
			$("#JXZH_JB_LEFTTEMP").val(price);
			var countTemp = parseInt_DN($("#JXZH_JB_LEFTTEMP").val())+parseInt_DN($("#JXZH_JB_RIGHTTEMP").val())
				+parseInt_DN($("#JXZH_JB_BACKTEMP").val());
			$("#JXZH_JB_TEMP").val(countTemp);
		}
        if(isRefresh != '1'){
            //放入价格
            countZhj();
        }
    }

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
            $("#HOUSEHOLD_YSF").val(0);
            $("#XS_YSJ").val(0);
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
                        $("#HOUSEHOLD_YSF").val(transPrice);
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
                        $("#HOUSEHOLD_YSF").val(transPrice);
                        $("#XS_YSJ").val(transPrice);
                        countZhj();
                        //计算总报价
                    	jsTatol();
                    }
                );
        }
        else
        {
            countZhj();
            //计算总报价
        	jsTatol();
        }
       
    }
    
    //提交前验证
    function validateIsInput() {
        //非空验证
        if ($("#XS_QTFY").val() == "" && $("#XS_QTFY").val() == "") {
            $("#XS_QTFY").focus();
            $("#XS_QTFY").tips({
                side: 3,
                msg: "请填写其他费用!",
                bg: '#AE81FF',
                time: 3
            });
            return false;
        }
        if ($("#XS_YJZE").val() == "" && $("#XS_YJZE").val() == "") {
            $("#XS_YJZE").focus();
            $("#XS_YJZE").tips({
                side: 3,
                msg: "请填写佣金费用!",
                bg: '#AE81FF',
                time: 3
            });
            return false;
        }
        if ($("#XS_CQSJDJ").val() == "" && $("#XS_CQSJDJ").val() == "") {
            $("#XS_CQSJDJ").focus();
            $("#XS_CQSJDJ").tips({
                side: 3,
                msg: "请填写草签实际单价!",
                bg: '#AE81FF',
                time: 3
            });
            return false;
        }
        if ($("#XS_YSJ").val() == "" && $("#XS_YSJ").val() == "") {
            $("#XS_YSJ").focus();
            $("#XS_YSJ").tips({
                side: 3,
                msg: "请录入运输价!",
                bg: '#AE81FF',
                time: 3
            });
            return false;
        }

        if (!validateRequired()) {
            return false;
        }

        //new 全文NaN判断
        var ss = true;
        $("input[type='text']").each(function () {
            if ($(this).val() == "NaN") {
                $(this).focus();
                $(this).tips({
                    side: 3,
                    msg: "此项为NaN!",
                    bg: '#AE81FF',
                    time: 3
                });
                ss = false;
                return false;
            }
        })
        if (!ss) {
            return false;
        }

        //非标json
        $("#UNSTD").val(getJsonStrfb());

        $("#trans_more_car").val(formatTransJson());
        //设置checkbox选项值
        //可选功能部分

        
        if ($("#OPT_YCFW_TEXT").is(":checked")) {
            $("#OPT_YCFW").val("1");
        } else {
            $("#OPT_YCFW").val("0");
        }
        if ($("#OPT_TDTC_TEXT").is(":checked")) {
            $("#OPT_TDTC").val("1");
        } else {
            $("#OPT_TDTC").val("0");
        }
        
        //扶手型号
        if ($("input[name='JXZH_FSXH']:checked").val() == "") {
            $("input[name='JXZH_FSXH']:checked").val($("#JXZH_FSXH_SELECT").val())
        }

        return true;

    }

	//保存
    function save() {

        if (validateIsInput()) {
        	var index = layer.load(1);
        	var saveFlag = "1";
			$.ajax({
			    type: 'POST',
			    url: '<%=basePath%>e_offerdt/saveHousehold.do',
			    data: $("#HouseholdForm").dn2_serialize(getSelectDis())+"&saveFlag="+saveFlag,
			    dataType: "JSON",
			    success: function(data) {
			    	layer.close(index);
			    	if(data.code == 1){
			    		buildofferButton(data);
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
 
  
    //计算设备实际报价
    function JS_SJBJ()
    {
    	checkForm();
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
                    	var cqsjdj=$("#XS_CQSJDJ").val();
                    	//数量
                    	var sl=$("#HOUSEHOLD_SL").val();
                    	//赋值给设备实际报价
                    	$("#XS_SBSJBJ").val(cqsjdj*sl);
                    	
                    	//计算折扣并赋值
                    	var zkl;
                    	var qtfy=$("#XS_QTFY").val()*ShuiLv;//其他费用
                    	var yjze=$("#XS_YJZE").val()*ShuiLv;//佣金总额
                    	var sjbj=$("#XS_SBSJBJ").val();//设备实际报价
                    	var fbj=$("#XS_FBJ").val();//非标价
                    	var jj=parseInt($("#SBJ_TEMP").val());//基价
                    	var xxjj=parseInt($("#XS_XXJJ").val());//选项加价
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
//                     	$("#YJSYZKL").attr("value",yjsyzkl);
//                     	alert(yjsyzkl);
                    	
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
    	var sbsjzj_=parseInt_DN($("#XS_SBSJBJ").val());//设备实际总价
    	var qtfy_=parseInt_DN($("#XS_QTFY").val());//其他费用
    	var azf_=parseInt_DN($("#XS_AZJ").val());//安装费
    	var ysf_=parseInt_DN($("#XS_YSJ").val());//运输费
    	var a;
    	var b;
    	var c;
    	var d;
    	if(isNaN(sbsjzj_)){
    		a=0;
    	}else{a=sbsjzj_;}
    	
    	if(isNaN(qtfy_)){
    		b=0;
    	}else{b=qtfy_;}
    	
    	if(isNaN(azf_)){
    		c=0;
    	}else{c=azf_;}
    	
    	if(isNaN(ysf_)){
    		d=0;
    	}else{d=ysf_;}
    	
    	$("#XS_TATOL").val(a+b+c+d);
    }
  //验证表单输入数字
  	function checkForm(){
    	var checkCq=parseInt($("#XS_CQSJDJ").val());//草签实际单价
    	var checkQtfy=parseInt($("#XS_QTFY").val());//其他费用
    	var checkYjze=parseInt($("#XS_YJZE").val());//佣金总额

    	if(isNaN(checkCq))
    	{
    		document.getElementById('XS_CQSJDJ').value='';
    	}
    	if(isNaN(checkQtfy))
    	{
    		document.getElementById('XS_QTFY').value='';
    	}
    	if(isNaN(checkYjze))
    	{
    		document.getElementById('XS_YJZE').value='';
    	} 
    }
    
</script>
</body>

</html>
