<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<script src="static/js/installioncount.js?v=1.1"></script>
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
	<form action="e_offer/${msg}.do" name="feishangForm" id="feishangForm"
		method="post">
		<input type="hidden" name="ele_type" id="ele_type" value="DT10">
		<input type="hidden" name="view" id="view" value="${pd.view}">
		<input type="hidden" name="BJC_ID" id="BJC_ID" value="${pd.BJC_ID}">
		<input type="hidden" name="offer_version" id="offer_version" value="${pd.offer_version}">
		<input type="hidden" name="IS_FEIBIAO" id="IS_FEIBIAO" value="false">
		<input type="hidden" name="FEISHANG_MRL_ID" id="FEISHANG_MRL_ID"
			value="${pd.FEISHANG_MRL_ID}"> <input type="hidden"
			name="FLAG" id="FLAG" value="${FLAG}"> <input type="hidden"
			name="rowIndex" id="rowIndex" value="${pd.rowIndex}"> <input
			type="hidden" name="UNSTD" id="UNSTD" value="${pd.UNSTD}"> <input
			type="hidden" name="MODELS_ID" id="MODELS_ID" value="${pd.MODELS_ID}">
		<input type="hidden" name="ITEM_ID" id="ITEM_ID" value="${pd.ITEM_ID}">
		<input type="hidden" name="ELEV_IDS" id="ELEV_IDS"
			value="${pd.ELEV_IDS}"> <input type="hidden"
			name="BASE_BZJDZG" id="BASE_BZJDZG"> <input type="hidden"
			name="M_KMKD" id="M_KMKD">
<%-- 	<input type="hidden" name="YJSYZKL" id="YJSYZKL" value="${pd.YJSYZKL}"> --%>
    <input type="hidden" name="ZGYJ" id="ZGYJ" value="${pd.ZGYJ}">
		<div class="" style="z-index: -1;margin-top: -20px;">
			<div class="row">
				<div class="col-sm-12">
					<div class="">
						<div class="">
							<div class="row">
								<div class="col-sm-12">
									<div class="panel panel-primary">
										<div class="panel-heading">
											报价信息
											<%-- <c:if test="${forwardMsg!='view'}">
												<input type="button" value="装潢价格" onclick="selZhj();"
													class="btn-sm btn-success">
												<input type="button" value="调用参考报价" onclick="selCbj();"
													class="btn-sm btn-success">
											</c:if> --%>
										</div>
										<div class="panel-body">
											<div class="form-group form-inline">
												<label style="width: 11%; margin-bottom: 10px"><font
													color="red">*</font>梯种</label> <input style="width: 20%;"
													class="form-control" id="tz_" type="text" name="tz_"
													value="${modelsPd.models_name }" placeholder="这里输入型号名称"
													required="required">
												<!-- <select style="width: 20%;margin-top: 10px" class="form-control" id="tz_" name="tz_">
                                                <option value="飞尚">飞尚</option>
                                            </select> -->
							
												<c:if test="${pd.view== 'save' }">
													<label style="width: 11%; margin-bottom: 10px"><font
														color="red">*</font>载重(kg):</label>
													<select style="width: 20%;" class="form-control" id="BZ_ZZ"
														name="BZ_ZZ" onchange="editZz()" required="required">
														<option value="1000"
															${regelevStandardPd.ZZ=='1000'?'selected':''}>1000</option>
														<option value="">请选择</option>
														<option value="2000"
															${regelevStandardPd.ZZ=='2000'?'selected':''}>2000</option>
														<option value="3000"
															${regelevStandardPd.ZZ=='3000'?'selected':''}>3000</option>
														<option value="4000"
															${regelevStandardPd.ZZ=='4000'?'selected':''}>4000</option>
														<option value="5000"
															${regelevStandardPd.ZZ=='5000'?'selected':''}>5000</option>
													</select>

													<label style="width: 11%; margin-bottom: 10px"><font color="red">*</font>速度(m/s):</label>
													<select style="width: 20%;" class="form-control" id="BZ_SD"
														name="BZ_SD" onchange="editSd();" required="required">
														<option value="">请选择</option>
														<option value="0.5"
															${regelevStandardPd.SD=='0.5'?'selected':''}>0.5</option>
														<option value="1.0"
															${regelevStandardPd.SD=='1.0'?'selected':''}>1.0</option>
													</select>
											</div>

											<div class="form-group form-inline">
												<label style="width: 11%; margin-bottom: 10px"><font
													color="red">*</font>开门形式</label> <select style="width: 20%;"
													class="form-control" id="BZ_KMXS" name="BZ_KMXS"
													required="required">
													<option value="中分双折"
														${regelevStandardPd.KMXS=='中分双折'?'selected':''}>中分双折</option>
													<option value="左旁开"
														${regelevStandardPd.KMXS=='左旁开'?'selected':''}>左旁开</option>
													<option value="右旁开"
														${regelevStandardPd.KMXS=='右旁开'?'selected':''}>右旁开</option>
													<option value="中分"
														${regelevStandardPd.KMXS=='中分'?'selected':''}>中分</option>
													<option value="中分三折"
														${regelevStandardPd.KMXS=='中分三折'?'selected':''}>中分三折</option>
													<option value="其他"
														${regelevStandardPd.KMXS=='其他'?'selected':''}>其他</option>
												</select> <label style="width: 11%; margin-bottom: 10px"><font
													color="red">*</font>开门宽度:</label> <select style="width: 20%;"
													class="form-control" id="BZ_KMKD" name="BZ_KMKD"
													onchange="setMPrice();" required="required">
													<option value="">请选择</option>
													<option value="其他">其他</option>
													<option value="900">900</option>
													<option value="1500">1500</option>
													<option value="1700">1700</option>
													<option value="2000">2000</option>
													<option value="2200">2200</option>
												</select> <label style="width: 11%; margin-bottom: 10px">层站门:</label>
												<select class="form-control" style="width: 7%" name="BZ_C"
													id="BZ_C"
													onchange="editC();$('#ELE_C').html(this.value);$('#BZ_Z').change();$('#BZ_M').change()">
													<option value="">请选择</option>
												</select> <select class="form-control" style="width: 7%" name="BZ_Z"
													id="BZ_Z" onchange="setSbj();$('#ELE_Z').html(this.value)">
													<option value="">请选择</option>
												</select> <select class="form-control" style="width: 7%" name="BZ_M"
													id="BZ_M"
													onchange="setMPrice();$('#ELE_M').html(this.value)">
													<option value="">请选择</option>
												</select>
												</c:if>

												<c:if test="${pd.view== 'edit' }">
													<label style="width: 11%; margin-bottom: 10px"><font
														color="red">*</font>载重(kg):</label>
													<select style="width: 20%;" class="form-control" id="BZ_ZZ"
														name="BZ_ZZ" onchange="editZz()" required="required">
														<option value="">请选择</option>
														<option value="1000" ${pd.BZ_ZZ=='1000'?'selected':''}>1000</option>
														<option value="2000" ${pd.BZ_ZZ=='2000'?'selected':''}>2000</option>
														<option value="3000" ${pd.BZ_ZZ=='3000'?'selected':''}>3000</option>
														<option value="4000" ${pd.BZ_ZZ=='4000'?'selected':''}>4000</option>
														<option value="5000" ${pd.BZ_ZZ=='5000'?'selected':''}>5000</option>
													</select>

													<label style="width: 11%; margin-bottom: 10px"><font color="red">*</font>速度(m/s):</label>
													<select style="width: 20%;" class="form-control" id="BZ_SD"
														name="BZ_SD" onchange="editSd();" required="required">
														<option value="">请选择</option>
														<option value="0.5" ${pd.BZ_SD=='0.5'?'selected':''}>0.5</option>
														<option value="1.0" ${pd.BZ_SD=='1.0'?'selected':''}>1.0</option>
													</select>
											</div>

											<div class="form-group form-inline">
												<label style="width: 11%; margin-bottom: 10px"><font
													color="red">*</font>开门形式</label> <select style="width: 20%;"
													class="form-control" id="BZ_KMXS" name="BZ_KMXS">
													<option value="中分双折" ${pd.BZ_KMXS=='中分双折'?'selected':''}>中分双折</option>
													<option value="左旁开" ${pd.BZ_KMXS=='左旁开'?'selected':''}>左旁开</option>
													<option value="右旁开" ${pd.BZ_KMXS=='右旁开'?'selected':''}>右旁开</option>
													<option value="中分" ${pd.BZ_KMXS=='中分'?'selected':''}>中分</option>
													<option value="中分三折" ${pd.BZ_KMXS=='中分三折'?'selected':''}>中分三折</option>
													<option value="其他" ${pd.BZ_KMXS=='其他'?'selected':''}>其他</option>
												</select> <label style="width: 11%; margin-bottom: 10px"><font
													color="red">*</font>开门宽度:</label> <select style="width: 20%;"
													class="form-control" id="BZ_KMKD" name="BZ_KMKD"
													onchange="setMPrice();">
													<option value="">请选择</option>
													<option value="其他" ${pd.BZ_KMKD=='其他'?'selected':''}>其他</option>
													<option value="900" ${pd.BZ_KMKD=='900'?'selected':''}>900</option>
													<option value="1500" ${pd.BZ_KMKD=='1500'?'selected':''}>1500</option>
													<option value="1700" ${pd.BZ_KMKD=='1700'?'selected':''}>1700</option>
													<option value="2000" ${pd.BZ_KMKD=='2000'?'selected':''}>2000</option>
													<option value="2200" ${pd.BZ_KMKD=='2200'?'selected':''}>2200</option>
												</select> <label style="width: 11%; margin-bottom: 10px">层站门:</label>
												<select class="form-control" style="width: 7%" name="BZ_C"
													id="BZ_C"
													onchange="editC();$('#ELE_C').html(this.value);$('#BZ_Z').change();$('#BZ_M').change()">
													<option value="">请选择</option>
												</select> <select class="form-control" style="width: 7%" name="BZ_Z"
													id="BZ_Z" onchange="setSbj();$('#ELE_Z').html(this.value)">
													<option value="">请选择</option>
												</select> <select class="form-control" style="width: 7%" name="BZ_M"
													id="BZ_M"
													onchange="setMPrice();$('#ELE_M').html(this.value)">
													<option value="">请选择</option>
												</select>
												</c:if>

											</div>
											<div class="form-group form-inline">
												<label style="width: 11%; margin-bottom: 10px">数量:</label> <input
													type="text" style="width: 20%;" class="form-control"
													id="FEISHANG_MRL_SL" name="FEISHANG_MRL_SL"
													value="${pd.FEISHANG_MRL_SL}" readonly="readonly">
<input type="hidden" class="form-control" id="DT_SL" name="DT_SL" value="${pd.FEISHANG_MRL_SL}" readonly="readonly" style="width:20%;">
												<label style="width: 11%; margin-bottom: 10px">单价:</label> <input
													type="text" style="width: 20%;" class="form-control"
													id="DANJIA" name="DANJIA"
													value="${regelevStandardPd.PRICE}" readonly="readonly">

												<label><input type="hidden"
													class="form-control" id="FEISHANG_MRL_ZK"
													name="FEISHANG_MRL_ZK" value="${pd.FEISHANG_MRL_ZK}"
													onkeyup="countZhj();"></label>
												
												<label style="width:11%;margin-bottom: 10px"><font color="red">*</font>土建图图号:</label>
												<input type="text" class="form-control" id="TJTTH" name="TJTTH" required="required" value="${pd.TJTTH}" style="width:20%;">
												

											</div>
											<div class="form-group form-inline">
												<label style="width:11%;margin-bottom: 10px">佣金使用折扣率:</label>
												<input style="width: 20%;" type="text" class="form-control" name="YJSYZKL" id="YJSYZKL" readonly="readonly" value="${pd.YJSYZKL}">
												<label class="intro" style="color: red;display: none;" id="DANJIA_Label">开门宽度非标,减门价格请非标询价</label>
											</div>
											<div class="form-group form-inline dn-fixed-to-top">
												<table
													class="table table-striped table-bordered table-hover"
													id="tab" name="tab">
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
															<%-- <input type="text" style='width:50px;border-left:0px;border-top:0px;border-right:0px;border-bottom:1px ' name="FEISHANG_MRL_SBJ" id="FEISHANG_MRL_SBJ" value="${regelevStandardPd.PRICE}"> --%>
															<input type="text"
															style="width: 100%; border-left: 0px; border-top: 0px; border-right: 0px; border-bottom: 1px"
															name="SBJ_TEMP" id="SBJ_TEMP" readonly="readonly"
															value="${regelevStandardPd.PRICE*pd.FEISHANG_MRL_SL}">
														</td>
														<!-- 选项加价 -->
														<td><input type="text"
															style="width: 100%; border-left: 0px; border-top: 0px; border-right: 0px; border-bottom: 1px"
															name="FEISHANG_MRL_XXJJ" id="FEISHANG_MRL_XXJJ"
															readonly="readonly" value="${pd.FEISHANG_MRL_XXJJ}"></td>
														<!-- 折前价 -->
														<td><input type="text"
															style="width: 100%; border-left: 0px; border-top: 0px; border-right: 0px; border-bottom: 1px"
															name="FEISHANG_MRL_ZQJ" id="FEISHANG_MRL_ZQJ"
															readonly="readonly" value="${pd.FEISHANG_MRL_ZQJ}"></td>
														<!-- 非标价 -->
														<td><input type="text"
															style="width: 100%; border-left: 0px; border-top: 0px; border-right: 0px; border-bottom: 1px"
															name="FEISHANG_MRL_FBJ" id="FEISHANG_MRL_FBJ"
															readonly="readonly" value="${pd.FEISHANG_MRL_FBJ}">
														</td>
														<!-- 其他费用 -->
														<td><input type="text"
															style="width: 100%; border-left: 0px; border-top: 0px; border-right: 0px; border-bottom: 1px; background-color: yellow;"
															name="FEISHANG_MRL_QTFY" id="FEISHANG_MRL_QTFY"
															onkeyup="JS_SJBJ();" value="${pd.FEISHANG_MRL_QTFY}">
														</td>
														<!-- 佣金总额 -->
														<td><input type="text"
															style="width: 100%; border-left: 0px; border-top: 0px; border-right: 0px; border-bottom: 1px; background-color: yellow;"
															name="FEISHANG_MRL_YJZE" id="FEISHANG_MRL_YJZE"
															onkeyup="JS_SJBJ();" value="${pd.FEISHANG_MRL_YJZE}">
														</td>
														<!-- 是否超标 -->
														<input type="hidden"
															style="width: 45px; border-left: 0px; border-top: 0px; border-right: 0px; border-bottom: 1px"
															name="FEISHANG_MRL_SFCB" id="FEISHANG_MRL_SFCB"
															value="${pd.FEISHANG_MRL_SFCB}" readonly="readonly">
														<%-- <td><input type="text"
															style="width: 45px; border-left: 0px; border-top: 0px; border-right: 0px; border-bottom: 1px"
															name="FEISHANG_MRL_SFCB" id="FEISHANG_MRL_SFCB"
															value="${pd.FEISHANG_MRL_SFCB}" readonly="readonly">
														</td> --%>
														<!-- 折扣率 -->
														<td><input type="text"
															style="width: 100%; border-left: 0px; border-top: 0px; border-right: 0px; border-bottom: 1px"
															name="FEISHANG_MRL_ZKL" id="FEISHANG_MRL_ZKL"
															value="${pd.FEISHANG_MRL_ZKL}" readonly="readonly">
														</td>
														<!-- 草签实际单价 -->
														<td><input type="text"
															style="width: 100%; border-left: 0px; border-top: 0px; border-right: 0px; border-bottom: 1px; background-color: yellow;"
															name="FEISHANG_MRL_CQSJDJ" id="FEISHANG_MRL_CQSJDJ"
															onkeyup="JS_SJBJ();" value="${pd.FEISHANG_MRL_CQSJDJ}"></td>
														<!-- 设备实际报价 -->
														<td><input type="text"
															style="width: 100%; border-left: 0px; border-top: 0px; border-right: 0px; border-bottom: 1px"
															name="FEISHANG_MRL_SBSJBJ" id="FEISHANG_MRL_SBSJBJ"
															readonly="readonly" value="${pd.FEISHANG_MRL_SBSJBJ}"></td>
														<!-- 比例 -->
														<input type="hidden"
															style="width: 45px; border-left: 0px; border-top: 0px; border-right: 0px; border-bottom: 1px"
															name="FEISHANG_MRL_YJBL" id="FEISHANG_MRL_YJBL"
															value="${pd.FEISHANG_MRL_YJBL}" readonly="readonly">
														<%-- <td><input type="text"
															style="width: 45px; border-left: 0px; border-top: 0px; border-right: 0px; border-bottom: 1px"
															name="FEISHANG_MRL_YJBL" id="FEISHANG_MRL_YJBL"
															value="${pd.FEISHANG_MRL_YJBL}" readonly="readonly">
														</td> --%>
														<!-- 安装费 -->
														<td><input type="text"
															style="width: 100%; border-left: 0px; border-top: 0px; border-right: 0px; border-bottom: 1px"
															name="FEISHANG_MRL_AZJ" id="FEISHANG_MRL_AZJ"
															value="${pd.FEISHANG_MRL_AZJ}" readonly="readonly">
														</td>
														<!-- 运输费 -->
														<td><input type="text"
															style="width: 100%; border-left: 0px; border-top: 0px; border-right: 0px; border-bottom: 1px"
															name="FEISHANG_MRL_YSJ" id="FEISHANG_MRL_YSJ"
															value="${pd.FEISHANG_MRL_YSJ}" readonly="readonly">
														</td>
														<!-- 总报价 -->
														<td><input type="text"
															style="width: 100%; border-left: 0px; border-top: 0px; border-right: 0px; border-bottom: 1px"
															name="FEISHANG_MRL_TATOL" id="FEISHANG_MRL_TATOL"
															value="${pd.FEISHANG_MRL_TATOL}" readonly="readonly">
														</td>
													</tr>
												</table>

												<input type="hidden" name="FEISHANG_MRL_ZHJ"
													id="FEISHANG_MRL_ZHJ" value="${pd.FEISHANG_MRL_ZHJ}">
												<input type="hidden" name="FEISHANG_MRL_SBJ"
													id="FEISHANG_MRL_SBJ" value="${regelevStandardPd.PRICE}">
												<%-- <input type="hidden" name="SBJ_TEMP" id="SBJ_TEMP" value="${regelevStandardPd.PRICE}"> --%>
												<span id="zk_">${pd.FEISHANG_MRL_ZK}</span> <input
													type="hidden" name="FEISHANG_MRL_ZHSBJ"
													id="FEISHANG_MRL_ZHSBJ" value="${pd.FEISHANG_MRL_ZHSBJ}">
												<input type="hidden" name="FEISHANG_MRL_AZF"
													id="FEISHANG_MRL_AZF" value="${pd.FEISHANG_MRL_AZF}" /> <input
													type="hidden" name="FEISHANG_MRL_YSF" id="FEISHANG_MRL_YSF"
													value="${pd.FEISHANG_MRL_YSF}"> <input
													type="hidden" name="FEISHANG_MRL_SJBJ"
													id="FEISHANG_MRL_SJBJ" value="${pd.FEISHANG_MRL_SJBJ}">

											</div>

											<div class="form-group form-inline">
												<ul class="nav nav-tabs">
													<li class="active"><a data-toggle="tab" href="#tab-1"
														class="active">基本参数</a></li>
													<li><a data-toggle="tab" href="#tab-2">标准功能</a></li>
													<li><a data-toggle="tab" href="#tab-3">可选功能</a></li>
													<li><a data-toggle="tab" href="#tab-4">单组监控室对讲系统</a></li>
													<li><a data-toggle="tab" href="#tab-5">轿厢装潢</a></li>
													<li><a data-toggle="tab" href="#tab-6">厅门门套</a></li>
													<li><a data-toggle="tab" href="#tab-7">操纵盘</a></li>
													<li><a data-toggle="tab" href="#tab-8">厅门信号装置</a></li>
													<li><a data-toggle="tab" href="#tab-9">非标</a></li>
													<li class=""><a data-toggle="tab" href="#tab-10">常规非标</a></li>
												</ul>
												<div class="tab-content">
													<div id="tab-1" class="tab-pane">
														<!-- 基本参数 -->
														<table
															class="table table-striped table-bordered table-hover"
															border="1" cellspacing="0">
															<tr>
																<td colspan="6">基本价格</td>
																<td width="50">加价</td>
															</tr>
															<tr>
																<td width="110">控制系统</td>
																<td colspan="5"><input type="hidden"
																	name="BASE_KZXT" id="BASE_KZXT" value="VVVF系统">
																	VVVF系统</td>
																<td>&nbsp;</td>
															</tr>
															<tr>
																<td>控制方式</td>
																<td colspan="5"><input type="radio"
																	name="BASE_KZFS" value="单台(G1C)"
																	onclick="KZFS_TEMP('1');"
																	${pd.BASE_KZFS=='单台(G1C)'?'checked':''} /> 单台(G1C) <input
																	type="radio" name="BASE_KZFS" value="两台并联(G2C)"
																	onclick="KZFS_TEMP('2');"
																	${pd.BASE_KZFS=='两台并联(G2C)'?'checked':''} /> 两台并联(G2C)
																	<input type="radio" name="BASE_KZFS" value="三台群控(G3C)"
																	onclick="KZFS_TEMP('3');"
																	${pd.BASE_KZFS=='三台群控(G3C)'?'checked':''} /> 三台群控(G3C)
																	<input type="radio" name="BASE_KZFS" value="四台群控(G4C)"
																	onclick="KZFS_TEMP('4');"
																	${pd.BASE_KZFS=='四台群控(G4C)'?'checked':''} /> 四台群控(G4C)
																</td>
																<td><input type="text"
																	name="BASE_KZFS_TEMP" id="BASE_KZFS_TEMP"
																	class="form-control" readonly="readonly"></td>
															</tr>

															<tr>
																<td>曳引主机</td>
																<td colspan="5"><select name="BASE_YYZJ"
																	id="BASE_YYZJ" class="form-control">
																		<option value="">请选择</option>
																		<option value="永磁同步无齿轮曳引机"
																			${pd.BASE_YYZJ=='永磁同步无齿轮曳引机'||pd.view== 'save'?'selected':''}>永磁同步无齿轮曳引机</option>
																</select></td>
																<td>&nbsp;</td>
															</tr>
															<tr>
																<td>井道结构</td>
																<td colspan="5"><input name="BASE_JDJG"
																	type="radio" value="全混凝土"
																	${pd.BASE_JDJG=='全混凝土'?'checked':''} />全混凝土
																	<input name="BASE_JDJG" type="radio"
																	value="框架结构(圈梁)"
																	${pd.BASE_JDJG=='框架结构(圈梁)'?'checked':''} />框架结构(圈梁)
																	<input name="BASE_JDJG" type="radio"
																	value="钢结构" ${pd.BASE_JDJG=='钢结构'?'checked':''} />钢结构
																</td>
																<td>&nbsp;</td>
															</tr>
															<tr>
																<td>圈/钢梁间距</td>
																<td colspan="5"><input name="BASE_QGLJJ" id="BASE_QGLJJ"
																	type="text" value="${pd.BASE_QGLJJ}"
																	style="width: 120px" class="form-control" />mm</td>
																<td>&nbsp;</td>
															</tr>
															<tr>
																<td><font color="red">*</font>轿厢规格CW*CD(mm)</td>
																<td colspan="5"><select name="BASE_JXGG"
																	id="BASE_JXGG" class="form-control" required="required">
																		<option value="">请选择</option>
																		<option value="1400mm×1600mm"
																			${pd.BASE_JXGG=='1400mm×1600mm'?'selected':''}>1400mm×1600mm</option>
																		<option value="1700mm×2400mm"
																			${pd.BASE_JXGG=='1700mm×2400mm'?'selected':''}>1700mm×2400mm</option>
																		<option value="2000mm×2800mm"
																			${pd.BASE_JXGG=='2000mm×2800mm'?'selected':''}>2000mm×2800mm</option>
																		<option value="2000mm×3600mm"
																			${pd.BASE_JXGG=='2000mm×3600mm'?'selected':''}>2000mm×3600mm</option>
																		<option value="2400mm×3600mm"
																			${pd.BASE_JXGG=='2400mm×3600mm'?'selected':''}>2400mm×3600mm</option>
																		<option value="2400mm×3000mm"
																			${pd.BASE_JXGG=='2400mm×3000mm'?'selected':''}>2400mm×3000mm</option>
																</select>
																<div style="margin-top: 5px;">
																<font color="red" id="BASE_JXGG_FBTEXT" style="display:none;">国标允许的轿厢面积对应的载重下轿厢尺寸的变化时非标加价，超出国标时请非标询价</font>
																</div></td>
																<td>
																	<input type="hidden" name=CGFB_JXCC id="CGFB_JXCC" value="${pd.CGFB_JXCC }">
																	<input type="text" name="CGFB_JXCC_TEMP" id="CGFB_JXCC_TEMP" class="form-control" readonly="readonly"></td>
															</tr>
															<tr>
																<td>轿厢高度(非净高)</td>
																<td colspan="2">
																	<p>
																		1000kg:<input name="BASE_JXGD"
																			${pd.BASE_JXGD=='1000kg-2300mm'?'checked':''} type="radio"
																			value="1000kg-2300mm" />2300mm
																	</p>
																	<p>
																		2000~3000kg:<input name="BASE_JXGD"
																			${pd.BASE_JXGD=='2000~3000kg-2200mm'?'checked':''} type="radio"
																			value="2000~3000kg-2200mm" />2200mm
																	</p>
																	<p>
																		4000~5000kg:<input name="BASE_JXGD"
																			${pd.BASE_JXGD=='4000~5000kg-2400mm'?'checked':''} type="radio"
																			value="4000~5000kg-2400mm" />2400mm
																	</p>
																</td>
																<td colspan="3">可选:
																	<p>
																		2000~3000kg:<input name="BASE_JXGD"
																			${pd.BASE_JXGD=='2000~3000kg-2300mm'?'checked':''} type="radio"
																			value="2000~3000kg-2300mm" />2300mm 
																			<input name="BASE_JXGD"
																			${pd.BASE_JXGD=='2000~3000kg-2400mm'?'checked':''} type="radio"
																			value="2000~3000kg-2400mm" />2400mm
																	</p>
																	<p>
																		4000~5000kg:<input name="BASE_JXGD"
																			${pd.BASE_JXGD=='4000~5000kg-2500mm'?'checked':''} type="radio"
																			value="4000~5000kg-2500mm" />2500mm 
																			<input name="BASE_JXGD"
																			${pd.BASE_JXGD=='4000~5000kg-2600mm'?'checked':''} type="radio"
																			value="4000~5000kg-2600mm" />2600mm
																	</p>
																</td>
																<td>&nbsp;</td>
															</tr>
															<tr>
																<td>开门尺寸OP*OPH</td>
																<td colspan="5"><select name="BASE_KMCC"
																	id="BASE_KMCC" class="form-control">
																		<option value="">请选择</option>
																		<option value="900mm*2100mm(1000kg)"
																			${pd.BASE_KMCC=='900mm*2100mm(1000kg)'?'selected':''}>900mm*2100mm(1000kg)</option>
																		<option value="1500mm*2100mm(2000kg)"
																			${pd.BASE_KMCC=='1500mm*2100mm(2000kg)'?'selected':''}>1500mm*2100mm(2000kg)</option>
																		<option value="2000mm*2100mm(3000kg)"
																			${pd.BASE_KMCC=='1700mm*2100mm(3000kg)'?'selected':''}>1700mm*2100mm(3000kg)</option>
																		<option value="2000mm*2300mm(4000kg)"
																			${pd.BASE_KMCC=='2000mm*2300mm(4000kg)'?'selected':''}>2000mm*2300mm(4000kg)</option>
																		<option value="2200mm*2300mm(4000kg)"
																			${pd.BASE_KMCC=='2200mm*2300mm(4000kg)'?'selected':''}>2200mm*2300mm(4000kg)</option>
																		<option value="2200mm*2300mm(5000kg)"
																			${pd.BASE_KMCC=='2200mm*2300mm(5000kg)'?'selected':''}>2200mm*2300mm(5000kg)</option>
																</select></td>
																<td>&nbsp;</td>
															</tr>
															<tr>
																<td><font color="red">*</font>轿厢出入口数量</td>
																<td colspan="5"><select name="BASE_JXRKSL"
																	id="BASE_JXRKSL" class="form-control" onchange="editGbcs('BASE_JXRKSL');" required="required">
																		<option value="">请选择</option>
																		<option value="1" ${pd.BASE_JXRKSL=='1'?'selected':''}>1</option>
																		<option value="2" ${pd.BASE_JXRKSL=='2'?'selected':''}>2</option>
																</select></td>
																<td>&nbsp;</td>
															</tr>
															<tr>
																<td>门机驱动</td>
																<td colspan="5"><select id="BASE_MLX"
																	name="BASE_MLX" class="form-control">
																			<option value="VVVF控制+PM门机" ${pd.BASE_MLX=='VVVF控制+PM门机'?'selected':''}>VVVF控制+PM门机</option>
																</select></td>
																<td>&nbsp;</td>
															</tr>
															<tr>
																<td>门保护</td>
																<td colspan="5"><select id="BASE_MBH"
																	name="BASE_MBH" class="form-control">
																		<%-- <option value="PM/2D光幕"
																			${pd.BASE_MLXMBH=='2D光幕'?'selected':''}>2D光幕</option>
																		<option value="VVVF门机/2D光幕"
																			${pd.BASE_MLXMBH=='VVVF控制+PM电机'?'selected':''}>VVVF控制+PM电机</option> --%>
																			<option value="2D光幕" ${pd.BASE_MBH=='2D光幕'?'selected':''}>2D光幕</option>
																</select></td>
																<td>&nbsp;</td>
															</tr>
															<tr>
																<td>井道承重墙厚度</td>
																<!-- <td colspan="2" width="300"><input
																	name="BASE_JDCZQHD" type="radio" value="250"
																	${pd.BASE_JDCZQHD=='250'?'checked':''}
																	onclick="setJdczqhdDisable('1');" />WT=250mm</td> -->
																<td colspan="3"><input name="BASE_JDCZQHD"
																	type="radio" value="250" onclick="setJdczqhdDisable('0');"
																	${pd.BASE_JDCZQHD=='250'?'':'checked'} /> WT=<input
																	name="BASE_JDCZQHD_TEXT" id="BASE_JDCZQHD_TEXT"
																	type="text" class="form-control" style="width: 100px"
																	value="250" />mm
																</td>
																<td>&nbsp;</td>
															</tr>
															<tr>
																<td>提升高度RISE</td>
																<td colspan="2"><font color="red">*</font><input
																	name="BASE_TSGD" onkeyup="setJdzg();" id="BASE_TSGD"
																	type="text" class="form-control"
																	value="${pd.BASE_TSGD}" placeholder="必填"
																	required="required" />mm</td>
																<td colspan="3">
																	超出: <input name="BASE_CCGD"
																	id="BASE_CCGD" type="text" style="width: 30%"
																	class="form-control" value="${pd.BASE_CCGD}"
																	readonly="readonly" />mm
																	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
																	加价: <input name="BASE_CCJG"
																	id="BASE_CCJG" type="text" style="width: 30%"
																	class="form-control" value="${pd.BASE_CCJG}"
																	readonly="readonly" />元
																</td>
																<td><label class="intro" style="color: red;display: none;" id="CGJJ_Label">请非标询价</label></td>
															</tr>
															<tr>
																<td>井道尺寸HW*HD</td>
																<td colspan="5"><input name="BASE_JDK"
																	id="BASE_JDK" type="text" class="form-control"
																	style="width: 15%" value="${pd.BASE_JDK}" />mm宽× <input
																	name="BASE_JDS" id="BASE_JDS" type="text"
																	class="form-control" style="width: 15%"
																	value="${pd.BASE_JDS}" />mm深</td>
																<td>&nbsp;</td>
															</tr>
															<tr>
																<td>底坑顶层</td>
																<td colspan="5">
																	<p>
																		<font color="red">*</font>底坑深度:<input name="BASE_DKSD"
																			id="BASE_DKSD" type="text" class="form-control"
																			onkeyup="setJdzg();"
																			value="${pd.BASE_DKSD}" placeholder="必填"
																			required="required" />mm
																	</p>
																	<p>
																		<font color="red">*</font> 顶层高度:<input
																			name="BASE_DCGD" id="BASE_DCGD" type="text"
																			class="form-control" 
																			onkeyup="setJdzg();" value="${pd.BASE_DCGD}"
																			placeholder="必填" required="required" />mm
																	</p>
																</td>
																<td>&nbsp;</td>
															</tr>
															<tr>
																<td>井道总高</td>
																<td colspan="5"><input name="BASE_JDZG"
																	id="BASE_JDZG" type="text" class="form-control"
																	value="${pd.BASE_JDZG}" readonly="readonly" />mm</td>
																<td><input type="hidden"
																	name="BASE_JDZG_TEMP" id="BASE_JDZG_TEMP"
																	style="width: 60%" class="form-control"
																	readonly="readonly"></td>
															</tr>
															<tr>
																<td>基站驻停</td>
																<td colspan="5">在<input type="text" name="BASE_JZZT"
																	id="BASE_JZZT" class="form-control"
																	value="${pd.BASE_JZZT}">层</td>
																<td>&nbsp;</td>
															</tr>
															<tr>
																<td>紧急消防</td>
																<td colspan="5">在<input type="text" name="BASE_JJXF"
																	id="BASE_JJXF" class="form-control"
																	value="${pd.BASE_JJXF}">层</td>
																<td>&nbsp;</td>
															</tr>
															<tr>
																<td>楼层标记</td>
																<td colspan="5"><input class="form-control"
																	name="BASE_LCBJ" id="BASE_LCBJ" type="text"
																	value="${pd.BASE_LCBJ}" /></td>
																<td>&nbsp;</td>
															</tr>
															<tr>
																<td>导轨支架</td>
																<td colspan="5"><input class="form-control"
																	name="BASE_DGZJ" id="BASE_DGZJ" type="text"
																	onkeyup="setDgzj();" value="${pd.BASE_DGZJ}" /></td>
																<td><input class="form-control"
																	type="text" name="BASE_DGZJ_TEMP" id="BASE_DGZJ_TEMP"
																	readonly="readonly">
																	<label class="intro" style="color: red;display: none;width: 50%;" id="DGZJ_Label">请非标询价</label>
																</td>
																	
															</tr>
															<tr>
																<td>备注</td>
																<td colspan="6">
																	楼层标记中作为盲层的楼层在标记外加圆圈注明，如1、2、③、4其中3层为盲层；标准配置下基站、驻停、紧急消防操作都设在同一层；轿厢高度指轿厢结构高度（含吊顶高度，非净高）；圈/钢梁结构间距指导轨架安装间距，需与土建（图纸）一致。
																</td>
															</tr>
														</table>
														<!-- 基本参数 -->
													</div>
													<div id="tab-2" class="tab-pane">
														<!-- 标准功能 -->
														<table
															class="table table-striped table-bordered table-hover"
															border="1" cellspacing="0">
															<tr>
																<td>&nbsp;</td>
																<td>&nbsp;</td>
																<td>&nbsp;</td>
																<td>&nbsp;</td>
																<td>&nbsp;</td>
																<td>&nbsp;</td>
																<td>&nbsp;</td>
																<td>&nbsp;</td>
																<td>&nbsp;</td>
															</tr>
															<tr>
																<td>序号</td>
																<td>功能</td>
																<td>简称</td>
																<td>序号</td>
																<td>功能</td>
																<td>简称</td>
																<td>序号</td>
																<td>功能</td>
																<td>简称</td>
															</tr>
															<tr>
																<td>1</td>
																<td>无呼自返基站</td>
																<td>LOBBY</td>
																<td>2</td>
																<td>再平层</td>
																<td>RLEV</td>
																<td>3</td>
																<td>五方对讲(不含控制柜到监控室连线)</td>
																<td>ICU-5</td>
															</tr>
															<tr>
																<td>4</td>
																<td>关门时间保护</td>
																<td>DTP</td>
																<td>5</td>
																<td>端站换速及楼层号矫正</td>
																<td>&nbsp;</td>
																<td>6</td>
																<td>接触器反馈检测功能</td>
																<td>&nbsp;</td>
															</tr>
															<tr>
																<td>7</td>
																<td>全集选控制</td>
																<td>FCL</td>
																<td>8</td>
																<td>轿厢防意外移动</td>
																<td>UCMP</td>
																<td>9</td>
																<td>电网电压波动检测功能</td>
																<td>&nbsp;</td>
															</tr>
															<tr>
																<td>10</td>
																<td>厅外和轿厢数字式位置指示器</td>
																<td>HPI CPI</td>
																<td>11</td>
																<td>继电器检查保护</td>
																<td>&nbsp;</td>
																<td>12</td>
																<td>故障自动检测</td>
																<td>&nbsp;</td>
															</tr>
															<tr>
																<td>13</td>
																<td>厅外和轿厢呼梯/等级</td>
																<td>DTTL</td>
																<td>14</td>
																<td>速度反馈检测功能</td>
																<td>&nbsp;</td>
																<td>15</td>
																<td>超载不启动(警示灯及蜂鸣器)</td>
																<td>OLD</td>
															</tr>
															<tr>
																<td>16</td>
																<td>厅外及轿厢运行方向显示</td>
																<td>HDI&amp;CDI</td>
																<td>17</td>
																<td>逆向运行保护</td>
																<td>&nbsp;</td>
																<td>18</td>
																<td>自动开关门</td>
																<td>&nbsp;</td>
															</tr>
															<tr>
																<td>19</td>
																<td>运行次数显示</td>
																<td>TRIC</td>
																<td>20</td>
																<td>防打滑保护</td>
																<td>&nbsp;</td>
																<td>21</td>
																<td>直接停靠</td>
																<td>&nbsp;</td>
															</tr>
															<tr>
																<td>22</td>
																<td>楼层显示字符的任意设定</td>
																<td>&nbsp;</td>
																<td>23</td>
																<td>防溜车保护</td>
																<td>&nbsp;</td>
																<td>24</td>
																<td>门区外不能开门</td>
																<td>&nbsp;</td>
															</tr>
															<tr>
																<td>25</td>
																<td>轿内通风手动及照明自动控制</td>
																<td>FLP</td>
																<td>26</td>
																<td>限位保护</td>
																<td>&nbsp;</td>
																<td>27</td>
																<td>预转矩输出</td>
																<td>&nbsp;</td>
															</tr>
															<tr>
																<td>28</td>
																<td>本层外召开门</td>
																<td>&nbsp;</td>
																<td>29</td>
																<td>上下极限保护装置</td>
																<td>&nbsp;</td>
																<td>30</td>
																<td>门连锁保护</td>
																<td>&nbsp;</td>
															</tr>
															<tr>
																<td>31</td>
																<td>重复关门</td>
																<td>&nbsp;</td>
																<td>32</td>
																<td>机房选层</td>
																<td>&nbsp;</td>
																<td>33</td>
																<td>运行接触器保护</td>
																<td>&nbsp;</td>
															</tr>
															<tr>
																<td>34</td>
																<td>井道自学习</td>
																<td>&nbsp;</td>
																<td>35</td>
																<td>开、关门按钮</td>
																<td><span lang="EN-US"
																		xml:lang="EN-US">DOB DCB</span></td>
																<td>36</td>
																<td>抱闸检测保护</td>
																<td>&nbsp;</td>
															</tr>
															<tr>
																<td>37</td>
																<td>待梯层设定</td>
																<td>&nbsp;</td>
																<td>38</td>
																<td>紧急消防操作（消防功能）</td>
																<td>EFO</td>
																<td>39</td>
																<td>光幕门保护装置</td>
																<td>LRD</td>
															</tr>
															<tr>
																<td>40</td>
																<td>不停层设置</td>
																<td>&nbsp;</td>
																<td>41</td>
																<td>轿内应急照明</td>
																<td>ECU</td>
																<td>42</td>
																<td>撞底缓冲装置</td>
																<td>&nbsp;</td>
															</tr>
															<tr>
																<td>43</td>
																<td>外召按钮嵌入自诊断</td>
																<td>&nbsp;</td>
																<td>44</td>
																<td>故障低速自救功能</td>
																<td>&nbsp;</td>
																<td>45</td>
																<td>错误指令删除</td>
																<td>DCC</td>
															</tr>
															<tr>
																<td>46</td>
																<td>反向指令自动消除</td>
																<td>&nbsp;</td>
																<td>47</td>
																<td>检修运行（轿顶与机房）</td>
																<td><span lang="EN-US"
																		xml:lang="EN-US">TCI ERO</span></td>
																<td>48</td>
																<td>安全回路保护</td>
																<td>&nbsp;</td>
															</tr>
															<tr>
																<td>49</td>
																<td>门保持按钮</td>
																<td>DHB</td>
																<td>50</td>
																<td>紧急电动运行</td>
																<td>&nbsp;</td>
																<td>51</td>
																<td>独立运行</td>
																<td>ISC</td>
															</tr>
															<tr>
																<td>52</td>
																<td>驻停</td>
																<td>PKS</td>
																<td>53</td>
																<td>警铃</td>
																<td>ALM</td>
																<td>54</td>
																<td>设置厅、轿门时间</td>
																<td>CHT</td>
															</tr>
															<tr>
																<td>55</td>
																<td>手动紧急救援</td>
																<td>&nbsp;</td>
																<td>56</td>
																<td>层轿门旁路装置</td>
																<td>&nbsp;</td>
																<td>57</td>
																<td>门回路自监测</td>
																<td>&nbsp;</td>
															</tr>
														</table>
														<!-- 标准功能 -->
													</div>
													<div id="tab-3" class="tab-pane">
														<!-- 可选功能 -->
														<table
															class="table table-striped table-bordered table-hover"
															border="1" cellspacing="0">
															<tr>
																<td colspan="5">可选功能</td>
															</tr>
															<tr>
																<td>序号</td>
																<td>功能</td>
																<td>简称</td>
																<td>有</td>
																<td>加价</td>
															</tr>
															<tr>
																<td>1</td>
																<td>消防联动（火警自动返回基站）</td>
																<td>FL</td>
																<td><input type="checkbox" name="OPT_XFLD_TEXT"
																	id="OPT_XFLD_TEXT" onclick="editOpt('OPT_XFLD')"
																	${pd.OPT_XFLD=='1'?'checked':''} /> <input
																	type="hidden" name="OPT_XFLD" id="OPT_XFLD"></td>
																<td><input type="text" name="OPT_XFLD_TEMP"
																	id="OPT_XFLD_TEMP" class="form-control"
																	readonly="readonly"></td>
															</tr>
															<tr>
																<td>2</td>
																<td>司机操作</td>
																<td>ATT</td>
																<td><input type="checkbox" name="OPT_SJCZ_TEXT"
																	id="OPT_SJCZ_TEXT" onclick="editOpt('OPT_SJCZ')"
																	${pd.OPT_SJCZ=='1'?'checked':''} /> <input
																	type="hidden" name="OPT_SJCZ" id="OPT_SJCZ"></td>
																<td>&nbsp;</td>
															</tr>
															<tr>
																<td>3</td>
																<td>消防员运行（轿厢内）</td>
																<td>EFS</td>
																<td><input type="checkbox" name="OPT_XFYYX_TEXT"
																	id="OPT_XFYYX_TEXT" onclick="editOpt('OPT_XFYYX')"
																	${pd.OPT_XFYYX=='1'?'checked':''} /> <input
																	type="hidden" name="OPT_XFYYX" id="OPT_XFYYX">
																</td>
																<td>&nbsp;</td>
															</tr>
															<tr>
																<td>4</td>
																<td>提前开门</td>
																<td>&nbsp;</td>
																<td><input type="checkbox" name="OPT_SZTJMSJ_TEXT"
																	id="OPT_SZTJMSJ_TEXT" onclick="editOpt('OPT_SZTJMSJ')"
																	${pd.OPT_SZTJMSJ=='1'?'checked':''} /> <input
																	type="hidden" name="OPT_SZTJMSJ" id="OPT_SZTJMSJ">
																</td>
																<td>&nbsp;</td>
															</tr>
															<tr>
																<td>5</td>
																<td>轿厢到站钟</td>
																<td>GNC</td>
																<td><input type="checkbox" name="OPT_JXDZZ_TEXT"
																	id="OPT_JXDZZ_TEXT" onclick="editOpt('OPT_JXDZZ')"
																	${pd.OPT_JXDZZ=='1'?'checked':''} /> <input
																	type="hidden" name="OPT_JXDZZ" id="OPT_JXDZZ">
																</td>
																<td><input type="text" name="OPT_JXDZZ_TEMP"
																	id="OPT_JXDZZ_TEMP" class="form-control"
																	readonly="readonly"></td>
															</tr>
															<tr>
																<td>6</td>
																<td>BA接口</td>
																<td>BA</td>
																<td><input type="checkbox" name="OPT_BAJK_TEXT"
																	id="OPT_BAJK_TEXT" onclick="editOpt('OPT_BAJK')"
																	${pd.OPT_BAJK=='1'?'checked':''} /> <input
																	type="hidden" name="OPT_BAJK" id="OPT_BAJK"></td>
																<td><input type="text" name="OPT_BAJK_TEMP"
																	id="OPT_BAJK_TEMP" class="form-control"
																	readonly="readonly"></td>
															</tr>
															<tr>
																<td>7</td>
																<td>CCTV电缆（轿厢到机房）</td>
																<td>CCTVC</td>
																<td><input type="checkbox" name="OPT_CCTVDL_TEXT"
																	id="OPT_CCTVDL_TEXT" onclick="editOpt('OPT_CCTVDL')"
																	${pd.OPT_CCTVDL=='1'?'checked':''} /> <input
																	type="hidden" name="OPT_CCTVDL" id="OPT_CCTVDL">
																</td>
																<td><input type="text" name="OPT_CCTVDL_TEMP"
																	id="OPT_CCTVDL_TEMP" class="form-control"
																	readonly="readonly"></td>
															</tr>
															<tr>
																<td>8</td>
																<td>语音报站</td>
																<td>SR</td>
																<td><input type="checkbox" name="OPT_YYBZ_TEXT"
																	id="OPT_YYBZ_TEXT" onclick="editOpt('OPT_YYBZ')"
																	${pd.OPT_YYBZ=='1'?'checked':''} /> <input
																	type="hidden" name="OPT_YYBZ" id="OPT_YYBZ"></td>
																<td><input type="text" name="OPT_YYBZ_TEMP"
																	id="OPT_YYBZ_TEMP" class="form-control"
																	readonly="readonly"></td>
															</tr>
															<%-- <tr>
                                                            <td>9</td>
                                                            <td>停电应急救援</td>
                                                            <td>ARD</td>
                                                            <td>
                                                                <input type="checkbox" name="OPT_TDYJJY_TEXT" id="OPT_TDYJJY_TEXT" onclick="editOpt('OPT_TDYJJY')" ${pd.OPT_TDYJJY=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_TDYJJY" id="OPT_TDYJJY">
                                                            </td>
                                                            <td><input type="text" name="OPT_TDYJJY_TEMP" id="OPT_TDYJJY_TEMP" class="form-control"></td>
                                                          </tr> --%>
															<tr>
																<td>10</td>
																<td>防捣乱操作</td>
																<td>ANS</td>
																<td><input type="checkbox" name="OPT_FDLCZ_TEXT"
																	id="OPT_FDLCZ_TEXT" onclick="editOpt('OPT_FDLCZ')"
																	${pd.OPT_FDLCZ=='1'?'checked':''} /> <input
																	type="hidden" name="OPT_FDLCZ" id="OPT_FDLCZ">
																</td>
																<td><input type="text" name="OPT_FDLCZ_TEMP"
																	id="OPT_FDLCZ_TEMP" class="form-control"
																	readonly="readonly"></td>
															</tr>
															<tr>
																<td>11</td>
																<td>电机过热保护</td>
																<td>THB</td>
																<td><input type="checkbox" name="OPT_DJGRBH_TEXT"
																	id="OPT_DJGRBH_TEXT" onclick="editOpt('OPT_DJGRBH')"
																	${pd.OPT_DJGRBH=='1'?'checked':''} /> <input
																	type="hidden" name="OPT_DJGRBH" id="OPT_DJGRBH">
																</td>
																<td><input type="text" name="OPT_DJGRBH_TEMP"
																	id="OPT_DJGRBH_TEMP" class="form-control"
																	readonly="readonly"></td>
															</tr>
															<tr>
																<td>12</td>
																<td>下集选</td>
																<td>DCL</td>
																<td><input type="checkbox" name="OPT_XJX_TEXT"
																	id="OPT_XJX_TEXT" onclick="editOpt('OPT_XJX')"
																	${pd.OPT_XJX=='1'?'checked':''} /> <input type="hidden"
																	name="OPT_XJX" id="OPT_XJX"></td>
																<td>&nbsp;</td>
															</tr>
															<%-- <tr>
                                                            <td>13</td>
                                                            <td>物联网（远程监控）</td>
                                                            <td>DTNS</td>
                                                            <td>
                                                                <input type="checkbox" name="OPT_WLW_TEXT" id="OPT_WLW_TEXT" onclick="editOpt('OPT_WLW')" ${pd.OPT_WLW=='1'?'checked':''}/>
                                                                <input type="hidden" name="OPT_WLW" id="OPT_WLW">
                                                            </td>
                                                            <td><input type="text" name="OPT_WLW_TEMP" id="OPT_WLW_TEMP" class="form-control"></td>
                                                          </tr> --%>
															<tr>
																<td>14</td>
																<td>紧急备用电源操作装置</td>
																<td>EPO</td>
																<td><input type="checkbox"
																	name="OPT_JJBYDYCZZZ_TEXT" id="OPT_JJBYDYCZZZ_TEXT"
																	onclick="editOpt('OPT_JJBYDYCZZZ')"
																	${pd.OPT_JJBYDYCZZZ=='1'?'checked':''} /> <input
																	type="hidden" name="OPT_JJBYDYCZZZ" id="OPT_JJBYDYCZZZ">
																</td>
																<td><input type="text" name="OPT_JJBYDYCZZZ_TEMP"
																	id="OPT_JJBYDYCZZZ_TEMP" class="form-control"
																	readonly="readonly"></td>
															</tr>
															<tr>
																<td>15</td>
																<td>厅外消防员服务</td>
																<td>EPO</td>
																<td><input type="checkbox" name="OPT_TWXFYFW_TEXT"
																	id="OPT_TWXFYFW_TEXT" onclick="editOpt('OPT_TWXFYFW')"
																	${pd.OPT_TWXFYFW=='1'?'checked':''} /> <input
																	type="hidden" name="OPT_TWXFYFW" id="OPT_TWXFYFW">
																</td>
																<td><input type="text" name="OPT_TWXFYFW_TEMP"
																	id="OPT_TWXFYFW_TEMP" class="form-control"
																	readonly="readonly"></td>
															</tr>
															<tr>
																<td>16</td>
																<td>LOP按钮</td>
																<td>EPO</td>
																<td><select name="OPT_LOPAN" id="OPT_LOPAN"
																	onchange="editOpt('OPT_LOPAN')" class="form-control">
																		<option value="">请选择</option>
																		<option value="单梯" ${pd.OPT_LOPAN=='单梯'?'selected':''}>单梯</option>
																		<option value="并联" ${pd.OPT_LOPAN=='并联'?'selected':''}>并联</option>
																</select></td>
																<td>&nbsp;</td>
															</tr>
															<tr>
																<td>17</td>
																<td>LOP按钮个数</td>
																<td>EPO</td>
																<td><input type="text" name="OPT_LOPANGS"
																	id="OPT_LOPANGS" onkeyup="editOpt('OPT_LOPANGS')"
																	class="form-control" value="${pd.OPT_LOPANGS}" /></td>
																<td><input type="text" name="OPT_LOPANGS_TEMP"
																	id="OPT_LOPANGS_TEMP" class="form-control"
																	readonly="readonly"></td>
															</tr>
															<tr>
	                                                            <td>18</td>
	                                                            <td>IC卡(轿内控制)</td>
																<td></td>
	                                                            <td>
	                                                                <select name="OPT_ICK" id="OPT_ICK"
	                                                                        onchange="editOpt('OPT_ICK');"
	                                                                        class="form-control">
	                                                                    <option value="">请选择</option>
	                                                                    <option value="刷卡后手动选择到达楼层" ${pd.OPT_ICK=='刷卡后手动选择到达楼层'?'selected':''}>
	                                                                        刷卡后手动选择到达楼层
	                                                                    </option>
	                                                                    <option value="刷卡后自动选择到达楼层" ${pd.OPT_ICK=='刷卡后自动选择到达楼层'?'selected':''}>
	                                                                        刷卡后自动选择到达楼层
	                                                                    </option>
	                                                                    <option value="非标" ${pd.OPT_ICK=='非标'?'selected':''}>
	                                                                        非标
	                                                                    </option>
	                                                                </select>
	                                                            </td>
	                                                            <td><input type="text" name="OPT_ICK_TEMP" id="OPT_ICK_TEMP"
	                                                                       class="form-control" readonly="readonly"></td>
	                                                        </tr>
	                                                        <tr>
	                                                            <td>19</td>
	                                                            <td>IC卡制卡设备</td>
																<td></td>
	                                                            <td>
	                                                                <input name="OPT_ICKZKSB_TEXT" id="OPT_ICKZKSB_TEXT"
	                                                                       type="checkbox"
	                                                                       onclick="editOpt('OPT_ICKZKSB');" ${pd.OPT_ICKZKSB=='1'?'checked':''} />
	                                                                <input type="hidden" name="OPT_ICKZKSB"
	                                                                       id="OPT_ICKZKSB">
	                                                            </td>
	                                                            <td><input type="text" name="OPT_ICKZKSB_TEMP"
	                                                                       id="OPT_ICKZKSB_TEMP" class="form-control"
	                                                                       readonly="readonly"></td>
	                                                        </tr>
	                                                        <tr>
	                                                            <td>20</td>
	                                                            <td>IC卡卡片(张)</td>
																<td></td>
	                                                            <td>
	                                                                <input name="OPT_ICKKP" id="OPT_ICKKP" type="text"
	                                                                       onkeyup="editOpt('OPT_ICKKP');"
	                                                                       class="form-control" value="${pd.OPT_ICKKP}"/>
	                                                            </td>
	                                                            <td><input type="text" name="OPT_ICKKP_TEMP"
	                                                                       id="OPT_ICKKP_TEMP" class="form-control"
	                                                                       readonly="readonly"></td>
	                                                        </tr>
															<tr>
																<td>21</td>
																<td>贯通轿厢</td>
																<td>EPO</td>
																<td><input type="checkbox" name="OPT_GTJX_TEXT"
																	id="OPT_GTJX_TEXT" onclick="editOpt('OPT_GTJX');editGbcs('BASE_JXRKSL_SELECT');"
																	${pd.OPT_GTJX=='1'?'checked':''} /> <input
																	type="hidden" name="OPT_GTJX" id="OPT_GTJX"></td>
																<td><input type="text" name="OPT_GTJX_TEMP"
																	id="OPT_GTJX_TEMP" class="form-control"
																	readonly="readonly">
																	<label class="intro" style="color: red;display: none;" id="GTMJX_Label">请非标询价</label>
																</td>
															</tr>
															<tr>
																<td>22</td>
																<td>贯通层数</td>
																<td>EPO</td>
																<td><input type="text" name="OPT_GTCS"
																	id="OPT_GTCS" onkeyup="editOpt('OPT_GTCS')"
																	class="form-control" value="${pd.OPT_GTCS}"
																	readonly="readonly" /></td>
																<td><input type="text" name="OPT_GTCS_TEMP"
																	id="OPT_GTCS_TEMP" class="form-control"
																	readonly="readonly">
																	<label class="intro" style="color: red;display: none;" id="GTMCS_Label">请非标询价</label>
																</td>
															</tr>
														</table>
														<!-- 可选功能 -->
													</div>
													<div id="tab-4" class="tab-pane">
														<!-- 单组监控室对讲系统 -->
														<table
															class="table table-striped table-bordered table-hover"
															border="1" cellspacing="0">
															<tr>
																<td colspan="4">单组监控室对讲系统</td>
																<td>加价</td>
															</tr>
															<tr>
																<td>对讲通讯方式</td>
																<td><input name="DZJKSDJXT_DJTXFS" type="radio"
																	value="分线制" ${pd.DZJKSDJXT_DJTXFS=='分线制'?'checked':''} />分线制
																	<input name="DZJKSDJXT_DJTXFS" type="radio" value="总线制"
																	${pd.DZJKSDJXT_DJTXFS=='总线制'?'checked':''} />总线制</td>
																<td>对讲的电梯台数</td>
																<td><input name="DZJKSDJXT_DJDDTTS"
																	id="DZJKSDJXT_DJDDTTS" type="text" style="width: 50px"
																	value="${pd.DZJKSDJXT_DJDDTTS}" />台</td>
																<td>&nbsp;</td>
															</tr>
															<!-- <tr>
                                                            <td>关联电梯合同号</td>
                                                            <td colspan="4"><input name="text2" type="text" class="form-control" /></td>
                                                          </tr> -->
															<tr>
																<td>备注</td>
																<td colspan="4">
																		标配五方对讲：轿厢、轿顶、底坑，控制柜，监控室；选择一对多时，10台以下项目标配为分线制多局对讲,<font color="red">10台以下项目选择总线制需要非标询价；</font>10台以上项目标配为总线制多局对讲，多局对讲系统单个监控室主机的最大控制台数为64台
																</td>
															</tr>
														</table>
														<!-- 单组监控室对讲系统 -->
													</div>
													<div id="tab-5" class="tab-pane">
														<!-- 轿厢装潢 -->
														<table
															class="table table-striped table-bordered table-hover"
															border="1" cellspacing="0">
															<tr>
																<td colspan="2">轿厢装潢</td>
																<td>标准</td>
																<td>可选&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;取消选择
                                                            		<input name="JXZH_JM" type="radio" value="" onclick="editJxzh('JXZH_JM_quxiao');"/>
                                                           		</td>
																<td>加价</td>
															</tr>
															<tr>
																<td rowspan="4">轿厢</td>
																<td>轿门</td>
																<td><input name="JXZH_JM" type="radio" value="喷涂"
																	onclick="editJxzh('JXZH_JM')"
																	${pd.JXZH_JM=='喷涂'?'checked':''} />喷涂 色标号: <select
																	name="JXZH_JMSBH" id="JXZH_JMSBH" class="form-control">
																		<option value="">请选择</option>
																		<option value="P-01"
																			${pd.JXZH_JMSBH=='P-01'?'selected':''}>P-01</option>
																		<option value="P-02"
																			${pd.JXZH_JMSBH=='P-02'?'selected':''}>P-02</option>
																		<option value="P-03"
																			${pd.JXZH_JMSBH=='P-03'?'selected':''}>P-03</option>
																		<option value="P-04"
																			${pd.JXZH_JMSBH=='P-04'?'selected':''}>P-04</option>
																		<option value="P-05"
																			${pd.JXZH_JMSBH=='P-05'?'selected':''}>P-05</option>
																		<option value="P-06"
																			${pd.JXZH_JMSBH=='P-06'?'selected':''}>P-06</option>
																		<option value="P-07"
																			${pd.JXZH_JMSBH=='P-07'?'selected':''}>P-07</option>
																</select></td>
																<td><input name="JXZH_JM" type="radio"
																	value="SUS 443发纹不锈钢" onclick="editJxzh('JXZH_JM')"
																	${pd.JXZH_JM=='SUS 443发纹不锈钢'?'checked':''} />SUS
																	443发纹不锈钢</td>
																<td><input type="text" name="JXZH_JM_TEMP"
																	id="JXZH_JM_TEMP" class="form-control"
																	readonly="readonly">
																</td>
															</tr>
															<tr>
																<td>前围壁</td>
																<td><input name="JXZH_QWB" type="radio" value="喷涂"
																	onclick="editJxzh('JXZH_QWB')"
																	${pd.JXZH_QWB=='喷涂'?'checked':''} />喷涂 色标号: <select
																	name="JXZH_QWBSBH" id="JXZH_QWBSBH"
																	class="form-control">
																		<option value="">请选择</option>
																		<option value="P-01"
																			${pd.JXZH_QWBSBH=='P-01'?'selected':''}>P-01</option>
																		<option value="P-02"
																			${pd.JXZH_QWBSBH=='P-02'?'selected':''}>P-02</option>
																		<option value="P-03"
																			${pd.JXZH_QWBSBH=='P-03'?'selected':''}>P-03</option>
																		<option value="P-04"
																			${pd.JXZH_QWBSBH=='P-04'?'selected':''}>P-04</option>
																		<option value="P-05"
																			${pd.JXZH_QWBSBH=='P-05'?'selected':''}>P-05</option>
																		<option value="P-06"
																			${pd.JXZH_QWBSBH=='P-06'?'selected':''}>P-06</option>
																		<option value="P-07"
																			${pd.JXZH_QWBSBH=='P-07'?'selected':''}>P-07</option>
																</select></td>
																<td><input name="JXZH_QWB" type="radio"
																	value="SUS 443发纹不锈钢" onclick="editJxzh('JXZH_QWB')"
																	${pd.JXZH_QWB=='SUS 443发纹不锈钢'?'checked':''} />SUS
																	443发纹不锈钢</td>
																<td rowspan="3"><input type="text"
																	name="JXZH_QWB_TEMP" id="JXZH_QWB_TEMP"
																	class="form-control" readonly="readonly">
																	<br>
                                                              		<font color="red">如果三侧配置不一致，请非标询价!</font></td></td>
															</tr>
															<tr>
																<td>侧围壁</td>
																<td><input name="JXZH_CWB" type="radio" value="喷涂"
																	onclick="editJxzh('JXZH_CWB')"
																	${pd.JXZH_CWB=='喷涂'?'checked':''} />喷涂 色标号: <select
																	name="JXZH_CWBSBH" id="JXZH_CWBSBH"
																	class="form-control">
																		<option value="">请选择</option>
																		<option value="P-01"
																			${pd.JXZH_CWBSBH=='P-01'?'selected':''}>P-01</option>
																		<option value="P-02"
																			${pd.JXZH_CWBSBH=='P-02'?'selected':''}>P-02</option>
																		<option value="P-03"
																			${pd.JXZH_CWBSBH=='P-03'?'selected':''}>P-03</option>
																		<option value="P-04"
																			${pd.JXZH_CWBSBH=='P-04'?'selected':''}>P-04</option>
																		<option value="P-05"
																			${pd.JXZH_CWBSBH=='P-05'?'selected':''}>P-05</option>
																		<option value="P-06"
																			${pd.JXZH_CWBSBH=='P-06'?'selected':''}>P-06</option>
																		<option value="P-07"
																			${pd.JXZH_CWBSBH=='P-07'?'selected':''}>P-07</option>
																</select></td>
																<td><input name="JXZH_CWB" type="radio"
																	value="SUS 443发纹不锈钢" onclick="editJxzh('JXZH_CWB')"
																	${pd.JXZH_CWB=='SUS 443发纹不锈钢'?'checked':''} />SUS
																	443发纹不锈钢</td>
																<td>&nbsp;<!-- <input type="text" name="JXZH_CWB_TEMP" id="JXZH_CWB_TEMP" class="form-control"> --></td>
															</tr>
															<tr>
																<td>后围壁</td>
																<td><input name="JXZH_HWB" type="radio" value="喷涂"
																	onclick="editJxzh('JXZH_HWB')"
																	${pd.JXZH_HWB=='喷涂'?'checked':''} />喷涂 色标号: <select
																	name="JXZH_HWBSBH" id="JXZH_HWBSBH"
																	class="form-control">
																		<option value="">请选择</option>
																		<option value="P-01"
																			${pd.JXZH_HWBSBH=='P-01'?'selected':''}>P-01</option>
																		<option value="P-02"
																			${pd.JXZH_HWBSBH=='P-02'?'selected':''}>P-02</option>
																		<option value="P-03"
																			${pd.JXZH_HWBSBH=='P-03'?'selected':''}>P-03</option>
																		<option value="P-04"
																			${pd.JXZH_HWBSBH=='P-04'?'selected':''}>P-04</option>
																		<option value="P-05"
																			${pd.JXZH_HWBSBH=='P-05'?'selected':''}>P-05</option>
																		<option value="P-06"
																			${pd.JXZH_HWBSBH=='P-06'?'selected':''}>P-06</option>
																		<option value="P-07"
																			${pd.JXZH_HWBSBH=='P-07'?'selected':''}>P-07</option>
																</select></td>
																<td><input name="JXZH_HWB" type="radio"
																	value="SUS 443发纹不锈钢" onclick="editJxzh('JXZH_HWB')"
																	${pd.JXZH_HWB=='SUS 443发纹不锈钢'?'checked':''} />SUS
																	443发纹不锈钢</td>
																<td>&nbsp;<!-- <input type="text" name="JXZH_HWB_TEMP" id="JXZH_HWB_TEMP" class="form-control"> --></td>
															</tr>
															<tr>
																<td height="63" colspan="2">轿顶装潢</td>
																<td colspan="2">
																
																
																	<select name="JXZH_JDZH" id="JXZH_JDZH" class="form-control">
                                                            			<option value="">请选择</option>
                                                                		<option value="悬吊式:(1000kg标准)"${pd.JXZH_JDZH=='悬吊式:(1000kg标准)'?'selected':''} >悬吊式:(1000kg标准) JF-CL22</option>
                                                                		<option value="单顶式" ${pd.JXZH_JDZH=='单顶式'?'selected':''}>单顶式: 均分块式碳钢板喷漆结构顶</option>
                                                            		</select>
																
<!-- 																	<p> -->
<!-- 																		<input name="JXZH_JDZH" type="radio" -->
<!-- 																			value="悬吊式:(1000kg标准)" -->
<%-- 																			${pd.JXZH_JDZH=='悬吊式:(1000kg标准)'?'checked':''} />悬吊式:(1000kg标准) --%>
<!-- 																	</p> -->
<!-- 																	<p>JF-CL22</p> -->
<!-- 																	<p> -->
<!-- 																		<input name="JXZH_JDZH" type="radio" -->
<!-- 																			value="单顶式:(2000~3000kg标准)" -->
<%-- 																			${pd.JXZH_JDZH=='单顶式:(2000~3000kg标准)'?'checked':''} />单顶式:(2000~3000kg标准) --%>
<!-- 																	</p> -->
<!-- 																	<p>均分块式碳钢板喷漆结构顶</p> -->
																</td>
																<td>&nbsp;</td>
															</tr>
															<tr>
																<td height="63" colspan="2">不锈钢吊顶</td>
																<td colspan="2"><input type="checkbox"
																	name="JXZH_BXGDD_TEXT" id="JXZH_BXGDD_TEXT"
																	onclick="editJxzh('JXZH_BXGDD')"
																	${pd.JXZH_BXGDD=='1'?'checked':''}> <input
																	type="hidden" name="JXZH_BXGDD" id="JXZH_BXGDD">
																</td>
																<td><input type="text" name="JXZH_BXGDD_TEMP"
																	id="JXZH_BXGDD_TEMP" class="form-control"
																	readonly="readonly">
																	<label class="intro" style="color: red;display: none;" id="JXZH_BXGDD_Label">请非标询价</label>
																</td>
															</tr>
															<tr>
																<td height="63" colspan="2">不锈钢地板</td>
																<td colspan="2"><input type="checkbox"
																	name="JXZH_BXGDB_TEXT" id="JXZH_BXGDB_TEXT"
																	onclick="editJxzh('JXZH_BXGDB')"
																	${pd.JXZH_BXGDB=='1'?'checked':''}> <input
																	type="hidden" name="JXZH_BXGDB" id="JXZH_BXGDB">
																</td>
																<td><input type="text" name="JXZH_BXGDB_TEMP"
																	id="JXZH_BXGDB_TEMP" class="form-control"
																	readonly="readonly">
																	<label class="intro" style="color: red;display: none;" id="JXZH_BXGDB_Label">请非标询价</label>
																	</td>
															</tr>
															<tr>
																<td height="63" colspan="2">半高镜</td>
																<td colspan="2"><input type="checkbox"
																	name="JXZH_BGJ_TEXT" id="JXZH_BGJ_TEXT"
																	onclick="editJxzh('JXZH_BGJ')"
																	${pd.JXZH_BGJ=='1'?'checked':''}> <input
																	type="hidden" name="JXZH_BGJ" id="JXZH_BGJ"></td>
																<td><input type="text" name="JXZH_BGJ_TEMP"
																	id="JXZH_BGJ_TEMP" class="form-control"
																	readonly="readonly">
																	<label class="intro" style="color: red;display: none;" id="JXZH_BGJ_Label">请非标询价</label>
																</td>
															</tr>
															<tr>
																<td colspan="2">地板型号</td>
																<td>
																	<p>
																		1000kg:<input name="JXZH_DBXH" type="radio"
																			value="PVC地板革" onclick="setDbxhDisable('1');"
																			${pd.JXZH_DBXH=='PVC地板革'?'checked':''} />PVC地板革
																	</p>
																	<p>
																		其他载重:<input name="JXZH_DBXH" type="radio"
																			value="碳钢花纹钢板" ${pd.JXZH_DBXH=='碳钢花纹钢板'?'checked':''}
																			onclick="setDbxhDisable('1');" />碳钢花纹钢板
																	</p>
																</td>
																<td>
																<input name="JXZH_DBXH" type="radio" value=""
																	onclick="setDbxhDisable('0');"
																	${pd.JXZH_DBXH.substring(0, 2)=='P-'?'checked':''} /> <select
																	name="JXZH_DBXH_SELECT" id="JXZH_DBXH_SELECT"
																	class="form-control">
																		<option value="">请选择</option>
																		<option value="P-01"
																			${pd.JXZH_DBXH=='P-01'?'selected':''}>P-01</option>
																		<option value="P-02"
																			${pd.JXZH_DBXH=='P-02'?'selected':''}>P-02</option>
																		<option value="P-03"
																			${pd.JXZH_DBXH=='P-03'?'selected':''}>P-03</option>
																		<option value="P-04"
																			${pd.JXZH_DBXH=='P-04'?'selected':''}>P-04</option>
																		<option value="P-05"
																			${pd.JXZH_DBXH=='P-05'?'selected':''}>P-05</option>
																		<option value="P-06"
																			${pd.JXZH_DBXH=='P-06'?'selected':''}>P-06</option>
																		<option value="P-07"
																			${pd.JXZH_DBXH=='P-07'?'selected':''}>P-07</option>
																</select></td>
																<td>&nbsp;</td>
															</tr>
															<tr>
																<td colspan="2">地板装修厚度(mm)</td>
																<td colspan="2"><input type="text"
																	value="${pd.JXZH_DBZXHD}" name="JXZH_DBZXHD"
																	id="JXZH_DBZXHD" class="form-control"></td>
																<td>&nbsp;</td>
															</tr>
															<tr>
																<td colspan="2">防撞条型号</td>
																<td><input name="JXZH_FZTXH" type="radio" value="无"
																	onchange="editJxzh('JXZH_FZTXH')"
																	${pd.JXZH_FZTXH=='无'?'checked':''} />无</td>
																<td><input name="JXZH_FZTXH" type="radio" value=""
																	onchange="editJxzh('JXZH_FZTXH')"
																	${pd.JXZH_FZTXH=='无'?'':'checked'} /> <select
																	name="JXZH_FZTXH_SELECT" id="JXZH_FZTXH_SELECT"
																	onchange="editJxzh('JXZH_FZTXH')" class="form-control">
																		<option value="">请选择</option>
																		<option value="木条"
																			${pd.JXZH_FZTXH=='木条'?'selected':''}>木条</option>
																		<option value="橡胶条"
																			${pd.JXZH_FZTXH=='橡胶条'?'selected':''}>橡胶条</option>
																</select></td>
																<td><input type="text" name="JXZH_FZTXH_TEMP"
																	id="JXZH_FZTXH_TEMP" class="form-control"
																	readonly="readonly">
																	<label class="intro" style="color: red;display: none;" id="JXZH_FZTXH_Label">请非标询价</label>
																</td>
															</tr>
															<tr>
																<td colspan="2">防撞条安装位置</td>
																<td colspan="2"><input name="JXZH_FZTAZWZ1"
																	type="checkbox" value="后围壁" onclick="editJxzh('JXZH_FZTXH')"
																	${pd.JXZH_FZTAZWZ1=='后围壁'?'checked':''} />后围壁 <input
																	name="JXZH_FZTAZWZ2" type="checkbox" value="左围壁" onclick="editJxzh('JXZH_FZTXH')"
																	${pd.JXZH_FZTAZWZ2=='左围壁'?'checked':''} />左围壁 <input
																	name="JXZH_FZTAZWZ3" type="checkbox" value="右围壁" onclick="editJxzh('JXZH_FZTXH')"
																	${pd.JXZH_FZTAZWZ3=='右围壁'?'checked':''} />右围壁</td>
																<td>&nbsp;</td>
															</tr>
														</table>
														<!-- 轿厢装潢 -->
													</div>
													<div id="tab-6" class="tab-pane">
														<!-- 厅门门套 -->
														<table
															class="table table-striped table-bordered table-hover"
															border="1" cellspacing="0">
															<tr>
																<td colspan="7">厅门门套</td>
																<td>加价</td>
															</tr>
															<input type="hidden" name="TMMT_FWBXGTM_TEXT"
																id="TMMT_FWBXGTM_TEXT"
																onclick="editTmmt('TMMT_FWBXGTM');"
																${pd.TMMT_FWBXGTM=='1'?'checked':''}>
															<input type="hidden" name="TMMT_FWBXGTM"
																id="TMMT_FWBXGTM">
															<!-- <input type="hidden" name="TMMT_FWBXGTM_TEMP" id="TMMT_FWBXGTM_TEMP" class="form-control"> -->
															<%--发纹不锈钢小门套--%>
															<input type="hidden" name="TMMT_FWBXGXMT_TEXT"
																id="TMMT_FWBXGXMT_TEXT"
																onclick="editTmmt('TMMT_FWBXGXMT');"
																${pd.TMMT_FWBXGXMT=='1'?'checked':''}>
															<input type="hidden" name="TMMT_FWBXGXMT"
																id="TMMT_FWBXGXMT">
															<!-- <input type="hidden" name="TMMT_FWBXGXMT_TEMP" id="TMMT_FWBXGXMT_TEMP" class="form-control"> -->

															<tr>
																<td width="150">首层 大门套</td>
																<td width="573" colspan="5"><select id="TMMT_PTDMT"
																	name="TMMT_PTDMT" onchange="editTmmt('TMMT_PTDMT');"
																	class="form-control">
																		<option value="">请选择</option>
																		<option value="喷涂"
																			${pd.TMMT_PTDMT=='喷涂'?'selected':''}>喷涂</option>
																		<option value="发纹不锈钢"
																			${pd.TMMT_PTDMT=='发纹不锈钢'?'selected':''}>发纹不锈钢</option>
																</select></td>
																<td width="198"><input name="DMT_SL" id="DMT_SL"
																	type="text" style="width: 80px" 
																	onkeyup="setSctmmt('2');" class="form-control" value="${pd.DMT_SL}"  /> 套</td>
																<td><input type="text" name="TMMT_DMT_TEMP"
																	id="TMMT_DMT_TEMP" class="form-control"
																	readonly="readonly"> <input type="hidden"
																	name="TMMT_DMT_TEMP2" id="TMMT_DMT_TEMP2"
																	class="form-control"></td>
															</tr>
															<tr>
																<td width="150" rowspan="2">首层厅门门套</td>
																<td width="200">厅门材质
	                                                            <span style="margin-left: 5px;cursor: pointer;color: blue;" onclick="editJxzh('TMMT_SCTMMT_quxiao');">取消选择</span>
	                                                            </td>
																<!-- <td width="45">合同号</td> -->
																<td width="45" colspan="2">数量</td>
																<td width="200">厅门材质</td>
																<!-- <td width="45">合同号</td> -->
																<td width="45" colspan="2">数量</td>
																<td width="68">加价</td>
															</tr>
															<tr>
																<td height="62">
																	<p>
																		标准: <input name="TMMT_SCTMMT" type="radio" value="喷涂"
																			onclick="setScsbhDisable('0');"
																			${pd.TMMT_SCTMMT=='喷涂' || pd.view== 'save'?'checked':''} />喷涂
																	</p>
																	<p>
																		色标号: <select name="TMMT_SCSBH" id="TMMT_SCSBH"
																			class="form-control">
																			<option value="">----</option>
																			<option value="P-01"
																				${pd.TMMT_SCSBH=='P-01'?'selected':''}>P-01</option>
																			<option value="P-02"
																				${pd.TMMT_SCSBH=='P-02'?'selected':''}>P-02</option>
																			<option value="P-03"
																				${pd.TMMT_SCSBH=='P-03'?'selected':''}>P-03</option>
																			<option value="P-04"
																				${pd.TMMT_SCSBH=='P-04'?'selected':''}>P-04</option>
																			<option value="P-05"
																				${pd.TMMT_SCSBH=='P-05'?'selected':''}>P-05</option>
																			<option value="P-06"
																				${pd.TMMT_SCSBH=='P-06'?'selected':''}>P-06</option>
																			<option value="P-07"
																				${pd.TMMT_SCSBH=='P-07'?'selected':''}>P-07</option>
																		</select>
																	</p>
																</td>
																<!-- 合同号 -->
																<input type="hidden" name="text3" type="text"
																	style="width: 20px" />

																<td colspan="2"><input name="TMMT_SCSL"
																	id="TMMT_SCSL_1" type="text" style="width: 80px"
																	value="${pd.TMMT_SCSL}" class="form-control" />套</td>
																<td>
																	<p>可选:</p>
																	<p>
																		<input name="TMMT_SCTMMT" id="TMMT_SCTMMT1"
																			type="radio" value="SUS443 发纹不锈钢"
																			onclick="setScsbhDisable('1');$('#TMMT_SCSL_2').val('1')"
																			${pd.TMMT_SCTMMT=='SUS443 发纹不锈钢'?'checked':''} />SUS443
																		发纹不锈钢
																	</p>
																</td>
																<!-- 合同号 -->
																<input name="text3" type="hidden" style="width: 20px" />
																<td colspan="2"><input name="TMMT_SCSL"
																	id="TMMT_SCSL_2" type="text" style="width: 80px"
																	onkeyup="setSctmmt('1');" value="${pd.TMMT_SCSL}"
																	class="form-control" />套</td>
																<td><input type="text" name="TMMT_FWBXGTM_TEMP"
																	id="TMMT_FWBXGTM_TEMP" class="form-control"
																	readonly="readonly"> <input type="hidden"
																	name="TMMT_FWBXGTM_TEMP2" id="TMMT_FWBXGTM_TEMP2"
																	class="form-control"></td>
															</tr>
															<tr>
																<td height="150">非首层厅门门套</td>
																<td>
																	<p>
																		标准: <input name="TMMT_FSCTMMT"
																			type="radio" value="喷涂"
																			onclick="setFscsbhDisable('0');"
																			${pd.TMMT_FSCTMMT=='喷涂'|| pd.view== 'save'?'checked':''} />喷涂
																	</p>
																	<p>
																		色标号: <select name="TMMT_FSCSBH" id="TMMT_FSCSBH"
																			class="form-control">
																			<option value="">请选择</option>
																			<option value="P-01"
																				${pd.TMMT_FSCSBH=='P-01'?'selected':''}>P-01</option>
																			<option value="P-02"
																				${pd.TMMT_FSCSBH=='P-02'?'selected':''}>P-02</option>
																			<option value="P-03"
																				${pd.TMMT_FSCSBH=='P-03'?'selected':''}>P-03</option>
																			<option value="P-04"
																				${pd.TMMT_FSCSBH=='P-04'?'selected':''}>P-04</option>
																			<option value="P-05"
																				${pd.TMMT_FSCSBH=='P-05'?'selected':''}>P-05</option>
																			<option value="P-06"
																				${pd.TMMT_FSCSBH=='P-06'?'selected':''}>P-06</option>
																			<option value="P-07"
																				${pd.TMMT_FSCSBH=='P-07'?'selected':''}>P-07</option>
																		</select>
																	</p>
																</td>
																<!-- <td>
                                                                <input name="text5" type="text" style="width:20px" />
                                                            </td> -->
																<td colspan="2"><input name="TMMT_FSCSL"
																	id="TMMT_FSCSL_1" type="text" style="width: 80px"
																	value="${pd.TMMT_FSCSL}" class="form-control" />套</td>
																<td>
																	<p>可选:</p>
																	<p>
																		<input name="TMMT_FSCTMMT" id="TMMT_FSCTMMT2"
																			type="radio" value="SUS443 发纹不锈钢"
																			onclick="setFscsbhDisable('1');$('#TMMT_FSCSL_2').val('1')"
																			${pd.TMMT_FSCTMMT=='SUS443 发纹不锈钢'?'checked':''} />SUS443
																		发纹不锈钢
																	</p>
																</td>
																<!-- <td>
                                                                <input name="text32" type="text" style="width:20px" />
                                                            </td> -->
																<td colspan="2"><input name="TMMT_FSCSL"
																	id="TMMT_FSCSL_2" type="text" style="width: 80px"
																	onkeyup="setFsctmmt('1');" value="${pd.TMMT_FSCSL}"
																	class="form-control" />套</td>
																<td><input type="text" name="TMMT_FWBXGXMT_TEMP"
																	id="TMMT_FWBXGXMT_TEMP" class="form-control"
																	readonly="readonly"> <input type="hidden"
																	name="TMMT_FWBXGXMT_TEMP2" id="TMMT_FWBXGXMT_TEMP2"
																	class="form-control"></td>

															</tr>

															<tr>
																<td width="150">非首层 大门套</td>
																<td width="573" colspan="5"><select id="FSC_DMT"
																	name="FSC_DMT" onchange="editTmmt('FSC_DMT');"
																	class="form-control">
																		<option value="">请选择</option>
																		<option value="喷涂" ${pd.FSC_DMT=='喷涂'?'selected':''}>喷涂</option>
																		<option value="发纹不锈钢"
																			${pd.FSC_DMT=='发纹不锈钢'?'selected':''}>发纹不锈钢</option>
																</select></td>
																<td width="198"><input name="FSC_DMT_SL" id="FSC_DMT_SL"
																	type="text" style="width: 80px"  value="${pd.FSC_DMT_SL}"
																	onkeyup="setFsctmmt('2');" class="form-control" /> 套</td>
																<td><input type="text" name="FSC_DMT_TEMP"
																	id="FSC_DMT_TEMP" class="form-control"
																	readonly="readonly"> <input type="hidden"
																	name="FSC_DMT_TEMP2" id="FSC_DMT_TEMP2"
																	class="form-control"></td>
															</tr>


															<tr>
																<td>备注</td>
																<td colspan="7">
																	厅门和门套的数量，不管单台还是并联或多台群控，必须按单台计算，并注明合同号，多台可连写。</td>
															</tr>
															<tr>
                                                        		<td colspan="4" class="intro" style="color: red;display: none;" id="TMMT_Label"><label style="font-size: 16px;">由于开门宽度非标,厅门门套模块请非标询价</label></td>
                                                          	</tr>
														</table>
														<!-- 厅门门套 -->
													</div>
													<div id="tab-7" class="tab-pane">
														<!-- 操纵盘 -->
														<table
															class="table table-striped table-bordered table-hover"
															border="1" cellspacing="0">
															<tr>
																<td colspan="4">操纵盘</td>
															</tr>
															<tr>
																<td>操纵盘型号</td>
																<td>可选：嵌入式</td>
																<td>标准：嵌入式<input type="hidden" name="CZP_CZPLX"
																	id="CZP_CZPLX" value="嵌入式"></td>
																<td>加价</td>
															</tr>
															<tr>
																<td height="138">操纵盘型号</td>
																<td>
																	<p>
																		<input name="CZP_CZPXH" type="radio"
																			value="JFCOP19H-C" onclick="setCzpxhDisable('1');"
																			${pd.CZP_CZPXH=='JFCOP19H-C'?'checked':''} />JFCOP19H-C（标配只勾选本行，下列不必选）
																	</p>
																	<p>
																		显示 <select name="CZP_XS" id="CZP_XS_1"
																			class="form-control">
																			<option value="">请选择</option>
																			<option value="LED(标配)"
																				${pd.CZP_XS=='LED(标配)'?'selected':''}>LED(标配)</option>
																			<option value="LCD"
																				${pd.CZP_XS=='LCD'?'selected':''}>LCD</option>
																		</select>
																	</p>
																	<p>
																		按钮 <select name="CZP_AN" id="CZP_AN_1"
																			class="form-control">
																			<option value="">请选择</option>
																			<option value="圆形(标配)"
																				${pd.CZP_AN=='圆形(标配)'?'selected':''}>圆形(标配)</option>
																		</select>
																	</p>
																	<p>
																		材质 <select name="CZP_CZ" id="CZP_CZ_1"
																			class="form-control">
																			<option value="">请选择</option>
																			<option value="发纹不锈钢(标准)"
																				${pd.CZP_CZ=='发纹不锈钢(标准)'?'selected':''}>发纹不锈钢(标准)</option>
																		</select>
																	</p>
																</td>
																<td>
																	<p>
																		<input name="CZP_CZPXH" type="radio"
																			value="JFCOP19H-E" onclick="setCzpxhDisable('2');"
																			${pd.CZP_CZPXH=='JFCOP19H-E'?'selected':''} />JFCOP19H-E（标配只勾选本行，下列不必选）
																	</p>
																	<p>
																		显示 <select name="CZP_XS" id="CZP_XS_2"
																			class="form-control">
																			<option value="">请选择</option>
																			<option value="LCD(标配)"
																				${pd.CZP_XS=='LED(标配)'?'selected':''}>LCD(标配)</option>
																		</select>
																	</p>
																	<p>
																		按钮 <select name="CZP_AN" id="CZP_AN_2"
																			class="form-control">
																			<option value="">请选择</option>
																			<option value="圆形(标配)"
																				${pd.CZP_AN=='圆形(标配)'?'selected':''}>圆形(标配)</option>
																		</select>
																	</p>
																	<p>
																		材质 <select name="CZP_CZ" id="CZP_CZ_2"
																			class="form-control">
																			<option value="">请选择</option>
																			<option value="发纹不锈钢(标准)"
																				${pd.CZP_CZ=='发纹不锈钢(标准)'?'selected':''}>发纹不锈钢(标准)</option>
																		</select>
																	</p>
																</td>
																<td>&nbsp;</td>
															</tr>
															<tr>
																<td>操纵盘位置</td>
																<td><select name="CZP_CZPWZ" id="CZP_CZPWZ"
																	onchange="editCzp('CZP_CZPWZ');" class="form-control">
																		<option value="右前(站在层站面向轿厢)"
																			${pd.CZP_CZPWZ=='右前(站在层站面向轿厢)'?'selected':''}>右前(站在层站面向轿厢)</option>
																		<option value="左前(站在层站面向轿厢)"
																			${pd.CZP_CZPWZ=='左前(站在层站面向轿厢)'?'selected':''}>左前(站在层站面向轿厢)</option>
																		<option value="右侧围壁(站在层站面向轿厢)"
																			${pd.CZP_CZPWZ=='右侧围壁(站在层站面向轿厢)'?'selected':''}>右侧围壁(站在层站面向轿厢)</option>
																		<option value="左侧围壁(站在层站面向轿厢)"
																			${pd.CZP_CZPWZ=='左侧围壁(站在层站面向轿厢)'?'selected':''}>左侧围壁(站在层站面向轿厢)</option>
																</select></td>
																<td></td>
																<td>加价</td>
															</tr>
															<%-- <tr>
                                                            <td>
                                                                <!-- <img src="操纵盘_image003.jpg" alt="cop_fr"/> -->1000kg:左前
                                                                <input type="radio" name="CZP_CZPWZ" value="1000kg:左前" ${pd.CZP_CZPWZ=='1000kg:左前'?'checked':''}>
                                                                <input type="hidden" name="CZP_CZPWZ" value="">
                                                            </td>
                                                            <td>
                                                                <!-- <img src="操纵盘_image004.jpg" alt="cop_r"/> -->左侧(窄/深轿厢可选)
                                                                <input type="radio" name="CZP_CZPWZ" value="左侧(窄/深轿厢可选)" ${pd.CZP_CZPWZ=='左侧(窄/深轿厢可选)'?'checked':''}>
                                                            </td>
                                                            <td>&nbsp;</td>
                                                          </tr> --%>
															<%-- <tr>
                                                            <td>
                                                                <!-- <img src="操纵盘_image004_0000.jpg" alt="cop_r"/> -->其他载重:左侧
                                                                <input type="radio" name="CZP_CZPWZ" value="其他载重:左侧" ${pd.CZP_CZPWZ=='其他载重:左侧'?'checked':''}>
                                                            </td>
                                                            <td>
                                                                <!-- <img src="操纵盘_image005.jpg" alt="cop_fr"/> -->其他载重:左前
                                                                <input type="radio" name="CZP_CZPWZ" value="其他载重:左前"${pd.CZP_CZPWZ=='其他载重:左前'?'checked':''}>
                                                            </td>
                                                            <td>&nbsp;</td>
                                                          </tr> --%>
														</table>
														<!-- 操纵盘 -->
													</div>
													<div id="tab-8" class="tab-pane">
														<!-- 厅门信号装置 -->
														<table
															class="table table-striped table-bordered table-hover"
															border="1" cellspacing="0">
															<tr>
																<td colspan="4">厅门信号装置</td>
															</tr>
															<tr>
																<td width="86">厅外召唤类型</td>
																<td width="180">标准：无底盒<input type="hidden"
																	name="TMXHZZ_TWZHLX" id="TMXHZZ_TWZHLX" value="无底盒"></td>
																<td width="244">可选：无底盒</td>
																<td width="56">加价</td>
															</tr>
															<tr>
																<td>厅外召唤型号</td>
																<td>
																	<p>
																		<input name="TMXHZZ_TWZHXH" type="radio"
																			onclick="setTwzhxhDisable('1');" value="JFCOP19H-C1"
																			${pd.TMXHZZ_TWZHXH=='JFCOP19H-C1'?'checked':''} />JFCOP19H-C1（标配只勾选本行，下列不必选）
																	</p>
																	<p>
																		显示 <select name="TMXHZZ_XS" id="TMXHZZ_XS_1"
																			class="form-control">
																			<option value="">请选择</option>
																			<option value="LED(标配)"
																				${pd.TMXHZZ_XS=='LED(标配)'?'selected':''}>LED(标配)</option>
																			<option value="LCD"
																				${pd.TMXHZZ_XS=='LCD'?'selected':''}>LCD</option>
																		</select>
																	</p>
																	<p>
																		按钮 <select name="TMXHZZ_AN" id="TMXHZZ_AN_1"
																			class="form-control">
																			<option value="">请选择</option>
																			<option value="按钮(圆形)"
																				${pd.TMXHZZ_AN=='按钮(圆形)'?'selected':''}>按钮(圆形)</option>
																		</select>
																	</p>
																	<p>
																		材质 <select name="TMXHZZ_CZ" id="TMXHZZ_CZ_1"
																			class="form-control">
																			<option value="">请选择</option>
																			<option value="发纹不锈钢(标准)"
																				${pd.TMXHZZ_CZ=='发纹不锈钢(标准)'?'selected':''}>发纹不锈钢(标准)</option>
																		</select>
																	</p>
																</td>
																<td>
																	<p>
																		<input name="TMXHZZ_TWZHXH" type="radio"
																			value="JFCOP19H-E1" onclick="setTwzhxhDisable('2');"
																			${pd.TMXHZZ_TWZHXH=='JFCOP19H-E1'?'checked':''} />JFCOP19H-E1（标配只勾选本行，下列不必选）
																	</p>
																	<p>
																		显示 <select name="TMXHZZ_XS" id="TMXHZZ_XS_2"
																			class="form-control">
																			<option value="">请选择</option>
																			<option value="LCD(标配)"
																				${pd.TMXHZZ_XS=='LCD(标配)'?'selected':''}>LCD(标配)</option>
																		</select>
																	</p>
																	<p>
																		按钮 <select name="TMXHZZ_AN" id="TMXHZZ_AN_2"
																			class="form-control">
																			<option value="">请选择</option>
																			<option value="圆形(标准)"
																				${pd.TMXHZZ_AN=='圆形(标准)'?'selected':''}>圆形(标准)</option>
																		</select>
																	</p>
																	<p>
																		材质 <select name="TMXHZZ_CZ" id="TMXHZZ_CZ_2"
																			class="form-control">
																			<option value="">请选择</option>
																			<option value="发纹不锈钢(标准)"
																				${pd.TMXHZZ_CZ=='发纹不锈钢(标准)'?'selected':''}>发纹不锈钢(标准)</option>
																		</select>
																	</p>
																</td>
																<td>&nbsp;</td>
															</tr>
															<tr>
																<td rowspan="2">厅外召唤形式</td>
																<td><input name="TMXHZZ_TWZHXS" type="radio"
																			onclick="setTwzhxxDisable('1');" value="1"
																			${pd.TMXHZZ_TWZHXS=='1'?'checked':''} />标准:</td>
																<td><input name="TMXHZZ_TWZHXS" type="radio"
																			onclick="setTwzhxxDisable('2');" value="2"
																			${pd.TMXHZZ_TWZHXS=='2'?'checked':''} />可选:</td>
																<td>加价</td>
															</tr>
															<%-- <tr>
                                                            <td>
                                                                <!-- <img src="../../../../../AppData/Roaming/Macromedia/Dreamweaver 8/OfficeImageTemp/image006.png"/> -->
                                                                <input type="radio" name="TMXHZZ_TWZHXS" value="标准" ${pd.TMXHZZ_TWZHXS=='标准'?'checked':''}>
                                                            </td>
                                                            <td>
                                                                <!-- <img src="../../../../../AppData/Roaming/Macromedia/Dreamweaver 8/OfficeImageTemp/image007.png"/> -->
                                                                <input type="radio" name="TMXHZZ_TWZHXS" value="双控" ${pd.TMXHZZ_TWZHXS=='双控'?'checked':''}>
                                                            </td>
                                                            <td>&nbsp;</td>
                                                          </tr> --%>
															<tr>
																<td>
																	<p>
																		在 <input name="TMXHZZ_ZDJC" id="TMXHZZ_ZDJC_1"
																			type="text" style="width: 80px" class="form-control"
																			value="${pd.TMXHZZ_ZDJC}" /> 层、 每层 <input
																			name="TMXHZZ_MCGS" id="TMXHZZ_MCGS_1" type="text"
																			style="width: 80px" class="form-control"
																			value="${pd.TMXHZZ_MCGS}" /> 个
																	</p>
																	<p>
																		附加说明： <input name="TMXHZZ_FJSM" id="TMXHZZ_FJSM_1"
																			type="text" class="form-control"
																			value="${pd.TMXHZZ_FJSM}" />
																	</p>
																</td>
																<td>
																	<p>
																		在 <input name="TMXHZZ_ZDJC" id="TMXHZZ_ZDJC_2"
																			type="text" style="width: 80px" class="form-control" value="${pd.TMXHZZ_ZDJC}" />
																		层、 每层 <input name="TMXHZZ_MCGS" id="TMXHZZ_MCGS_2"
																			type="text" style="width: 80px" class="form-control" value="${pd.TMXHZZ_MCGS}" />
																		个
																	</p>
																	<p>
																		附加说明： <input name="TMXHZZ_FJSM" id="TMXHZZ_FJSM_2"
																			type="text" class="form-control" value="${pd.TMXHZZ_FJSM}" />
																	</p>
																</td>
																<td>&nbsp;</td>
															</tr>
															<tr>
																<td>备注</td>
																<td colspan="3">
																		1、填写厅外召唤所在层时，请用实际楼层标记填写。2、厅外召唤形式图例仅作示意，当楼层标记为一位数时，数字显示为一位数字，在顶层只有一个向下按钮，在底层只有一个向上按钮。3、驻停楼层的厅外召唤带钥匙开关。4、厅外召唤样式(HBtype)有单个(Single)和两台合用一个(Duplex)两种。
																</td>
															</tr>
														</table>
														<!-- 厅门信号装置 -->
													</div>
													<div id="tab-9" class="tab-pane">
                                                	<input type="hidden" id="OPT_FB_TEMP" class="form-control">
														<!-- 非标 -->
														<%@include file="nonstanard_detail.jsp"%>
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
										<div class="panel-heading">安装价格</div>
										<div class="panel-body">
											<table class="table table-striped table-bordered table-hover"
												border="1" cellspacing="0">
												<!-- 基准价 -->
												<tr>
													<td>安装费（基准价）（元/台）</td>
													<td><input type="text" name="JZJ_DTJZJ" id="JZJ_DTJZJ"
														class="form-control" readonly="readonly"
														value="${pd.JZJ_DTJZJ }"> <input type="hidden"
														id="initFloor" value="${regelevStandardPd.C}"></td>
													<td>是否设备安装一体合同</td>
													<td><input type="checkbox" id="JZJ_IS_YTHT"
														name="JZJ_IS_YTHT" onclick="changeSSCount()"
														${pd.JZJ_IS_YTHT=='1'?'checked':'' }> <input
														type="hidden" name="JZJ_IS_YTHT_VAL" id="JZJ_IS_YTHT_VAL"
														value="${pd.JZJ_IS_YTHT}"></td>
													<td>单台专用税收补偿（元/台）</td>
													<td><input type="text" name="JZJ_SSBC" id="JZJ_SSBC"
														class="form-control" readonly="readonly"
														value="${pd.JZJ_SSBC }"></td>
												</tr>
												<tr>
													<td>单台安装费（最终基准价）（元/台）</td>
													<td><input type="text" name="JZJ_DTZJ" id="JZJ_DTZJ"
														class="form-control" readonly="readonly"
														value="${pd.JZJ_DTZJ }"></td>
													<td>总价（元）</td>
													<td><input type="text" name="JZJ_AZF" id="JZJ_AZF"
														class="form-control" readonly="readonly"
														value="${pd.JZJ_AZF }"></td>
													<td colspan="2"></td>
												</tr>
												<tr>
													<td colspan="6"></td>
												</tr>
												<!-- 手填价格 -->
												<tr>
													<td>安装费（元/台）</td>
													<td><input type="text" name="ELE_DTAZF" id="ELE_DTAZF"
														value="${pd.ELE_DTAZF }"
														onkeyup="value=value.replace(/[^\-?\d.]/g,'')"
														oninput="countSDPrice();" class="form-control"></td>
													<td>政府验收费（元/台）</td>
													<td><input type="text" id="ELE_ZFYSF" NAME="ELE_ZFYSF"
														value="${pd.ELE_ZFYSF }"
														onkeyup="value=value.replace(/[^\-?\d.]/g,'')"
														oninput="countSDPrice();" class="form-control"></td>
													<td>免保期超出1年计费（元/台）</td>
													<td><input type="text" name="ELE_MBJF" id="ELE_MBJF"
														value="${pd.ELE_MBJF }"
														onkeyup="value=value.replace(/[^\-?\d.]/g,'')"
														oninput="countSDPrice();" class="form-control"></td>
												</tr>
												<tr>
													<td>合同约定其他费用（元/台）</td>
													<td><input type="text" name="ELE_QTSF" id="ELE_QTSF"
														value="${pd.ELE_QTSF }"
														onkeyup="value=value.replace(/[^\-?\d.]/g,'')"
														oninput="countSDPrice();" class="form-control"></td>
													<td>安装总价（元/台）</td>
													<td><input type="text" name="ELE_DTZJ" id="ELE_DTZJ"
														class="form-control" readonly="readonly"
														value="${pd.ELE_DTZJ }"></td>
													<td>安装总价（元）</td>
													<td><input type="text" name="ELE_AZF" id="ELE_AZF"
														class="form-control" readonly="readonly"
														value="${pd.ELE_AZF }"></td>
												</tr>
												<tr>
													<td>备注</td>
													<td colspan="3"><input type="text" name="ELE_REMARK"
														id="ELE_REMARK" value="${pd.ELE_REMARK }"
														class="form-control"></td>
													<td colspan="2"></td>
												</tr>
												<tr>
													<td colspan="6"></td>
												</tr>
												<!-- 其它价格 -->
												<tr>
													<td>工程类型</td>
													<td><select id="OTHP_GCLX" name="OTHP_GCLX"
														onchange="changeCJPrice();" class="form-control">
															<option value="买断" ${pd.OTHP_GCLX=='买断'?'selected':'' }>买断</option>
															<option value="厂检" ${pd.OTHP_GCLX=='厂检'?'selected':'' }>厂检</option>
															<option value="验收" ${pd.OTHP_GCLX=='验收'?'selected':'' }>验收</option>
													</select></td>
													<td>厂检费（元）</td>
													<td><input type="text" name="OTHP_CJF" id="OTHP_CJF"
														class="form-control" readonly="readonly"
														value="${pd.OTHP_CJF }"></td>
													<td rowspan="2">调试/厂检总价（元）</td>
													<td rowspan="2"><input type="text" name="OTHP_ZJ"
														id="OTHP_ZJ" class="form-control" readonly="readonly"
														value="${pd.OTHP_ZJ }"></td>
												</tr>
												<tr>
													<td>调试费</td>
													<td><input type="checkbox" id="OTHP_ISTSF"
														name="OTHP_ISTSF" onclick="changeCJPrice();"
														${pd.OTHP_ISTSF=='1'?'checked':'' }> <input
														type="hidden" id="OTHP_ISTSF_VAL" name="OTHP_ISTSF_VAL"
														value="${pd.OTHP_ISTSF }"></td>
													<td>调试费（元）</td>
													<td><input type="text" name="OTHP_TSF" id="OTHP_TSF"
														class="form-control" readonly="readonly"
														value="${pd.OTHP_TSF }"></td>
												</tr>
												<tr>
													<td colspan="6"></td>
												</tr>
												<tr>
													<td>总价（元）</td>
													<td><input type="text" name="FEISHANG_MRL_AZF_TEMP"
														id="FEISHANG_MRL_AZF_TEMP" class="form-control"
														readonly="readonly" value="${pd.FEIYUE_AZF}"></td>
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
                                            <input type="text" id="trans_price" name="trans_price" class="form-control" oninput="countTransPrice()" value="${pd.FEISHANG_MRL_YSJ}">
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

	<%-- <tr>
		<td><c:if test="${forwardMsg!='view'}">
				<a class="btn btn-primary"
					style="width: 150px; height: 34px; float: left; margin: 0px 10px 30px 10px;"
					onclick="save();">保存</a>
			</c:if></td>
		<td><a class="btn btn-danger"
			style="width: 150px; height: 34px; float: right; margin: 0px 10px 30px 10px;"
			onclick="javascript:CloseSUWin('ElevatorParam');">关闭</a></td>
	</tr> --%>
	
	<div class="foot-btn">
        <c:if test="${forwardMsg!='view'}">
			<input type="button" value="装潢价格" onclick="selZhj();" style="width: 120px; margin-left: 5px; height:30px"
				class="btn btn-sm btn-info btn-sm">
			<input type="button" value="调用参考报价" onclick="selCbj();"
				style="width: 120px; margin-left: 5px; height:30px" class="btn btn-sm btn-info btn-sm">
		</c:if>
		<c:if test="${forwardMsg!='view'}">
			<a class="btn btn-primary"
				style="width: 120px; margin-left: 5px; height:30px"
				onclick="save();">保存</a>
		</c:if>
        <a class="btn btn-danger"
			style="width: 120px; margin-left: 5px; height:30px"
			onclick="javascript:CloseSUWin('ElevatorParam');">关闭</a>
	</div>

	<script src="static/js/sweetalert/sweetalert.min.js"></script>
	<script src="static/js/iCheck/icheck.min.js"></script>
	<script type="text/javascript">

    $(document).ready(function(){
        $("#tab-1").addClass("active");
        
        //加载标准价格,初始化关联选项
        editZz("1");
        editSd();

        if("${pd.view}"=="edit")
		{
			$("#BZ_C").val("${pd.BZ_C}");
	        $("#BZ_Z").val("${pd.BZ_Z}");
	        $("#BZ_M").val("${pd.BZ_M}");
		} else {
	        $("#BZ_C").val("${regelevStandardPd.C}");
	        $("#BZ_Z").val("${regelevStandardPd.Z}");
	        $("#BZ_M").val("${regelevStandardPd.M}");
		}
        
        if("${cbjFlag}"=="1")
		{
        	
	        $("#BZ_ZZ").val("${pd.BZ_ZZ}");
	        
	        $("#BZ_SD").val("${pd.BZ_SD}");
	        $("#BZ_SD").change();
			$("#BZ_C").val("${pd.BZ_C}");
	        $("#BZ_Z").val("${pd.BZ_Z}");
	        $("#BZ_M").val("${pd.BZ_M}");
	        $("#BZ_KMKD").val("${pd.BZ_KMKD}");
		}

        bindSelect2AndInitDate($('#BZ_C'), "${pd.BZ_C}");
        bindSelect2AndInitDate($('#BZ_Z'), "${pd.BZ_Z}");
        bindSelect2AndInitDate($('#BZ_M'), "${pd.BZ_M}");
        bindSelect2AndInitDate($('#BZ_ZZ'), "${pd.BZ_ZZ}");
        bindSelect2AndInitDate($('#BZ_SD'), "${pd.BZ_SD}");
        bindSelect2AndInitDate($('#BZ_KMKD'), "${pd.BZ_KMKD}");
        initBindSelect("${pd.BASE_JXGG}","1");
        
      	//---改
        setSbj();
        
        //调用初始化贯通门
        Jsgtms();
        $("#JXZH_DBZXHD").val(5);
        
        var FLAG = $("#FLAG").val();

        if(FLAG=="CBJ"||FLAG=="ZHJ"){
            cbjPrice();
        }
        if("${pd.view}"=="edit"){
            cbjPrice();
        }

        if($("[name='TMMT_SCTMMT']:checked").val()=='喷涂'){
            setScsbhDisable('0');
        }else if($("[name='TMMT_SCTMMT']:checked").val()=='SUS443 发纹不锈钢'){
            setScsbhDisable('1');
            setSctmmt('1');
        } else {
        	//首层厅门门套
        	$("#TMMT_SCSBH").val("");
            $("#TMMT_SCSBH").attr("disabled","disabled");
            $("#TMMT_SCSL_1").val("");
            $("#TMMT_SCSL_1").attr("disabled","disabled");
            $("#TMMT_SCSL_2").val("");
            $("#TMMT_SCSL_2").attr("disabled","disabled");
        }

        if($("[name='TMMT_FSCTMMT']:checked").val()=='喷涂'){
            setFscsbhDisable('0');
        }else if($("[name='TMMT_FSCTMMT']:checked").val()=='SUS443 发纹不锈钢'){
            setFscsbhDisable('1');
            setFsctmmt('1');
        } else {
        	//非首层厅门门套
            $("#TMMT_FSCSBH").val("");
            $("#TMMT_FSCSBH").attr("disabled","disabled");
            $("#TMMT_FSCSL_1").val("");
            $("#TMMT_FSCSL_1").attr("disabled","disabled");
            $("#TMMT_FSCSL_2").val("");
            $("#TMMT_FSCSL_2").attr("disabled","disabled");
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
        
        /* //赋默认值
        $("#DMT_SL").val(1);
        $("#FSC_DMT_SL").val(1); */
        
        editTmmt('TMMT_PTDMT');
        editTmmt('FSC_DMT');
        //加载运输模块显示 
        if("${pd.trans_type}"!=null && "${pd.trans_type}"!=""){
        	$("#trans_type").val("${pd.trans_type}");
            hideDiv();
        }else{
        	$("#trans_type").val(1);
        }

        updateFbX();
        
        if("${pd.TMXHZZ_TWZHXH}"=='JFCOP19H-C1'){
        	setTwzhxhDisable('1');
        } else if("${pd.TMXHZZ_TWZHXH}"=='JFCOP19H-E1'){
        	setTwzhxhDisable('2');
        }
        
        if("${pd.TMXHZZ_TWZHXS}"=='1'){
        	setTwzhxxDisable('1');
        } else if("${pd.TMXHZZ_TWZHXS}"=='2'){
        	setTwzhxxDisable('2');
        } else if("${pd.view}"=="save"){
        	$("input:radio[name=TMXHZZ_TWZHXS][value='1']").prop('checked','checked');
        	setTwzhxxDisable('1');
        }
        
    });

  //根据门数和站数计算贯通门数
    function Jsgtms()
    {
    	var bz_m=parseInt_DN($("#BZ_M").val());
    	var bz_z=parseInt_DN($("#BZ_Z").val());
    	var gtms=bz_m-bz_z;
    	if(gtms>0){
    	$("#OPT_GTCS").val(gtms);
    	}else{
    	$("#OPT_GTCS").val(0);
    	}

    	var bz_zz=parseInt_DN($("#BZ_ZZ").val());
    	var sl_ = parseInt_DN($("#FEISHANG_MRL_SL").val());
    	if(gtms>0){
    	if(bz_zz=='1000')
    	{
    		var price=gtms*2400*sl_;
    		$("#OPT_GTCS_TEMP").val(price);
    	}else if(bz_zz=='2000')
    	{
    		var price=gtms*4300*sl_;
    		$("#OPT_GTCS_TEMP").val(price);
    	}else if(bz_zz=='3000')
    	{
    		var price=gtms*5100*sl_;
    		$("#OPT_GTCS_TEMP").val(price);
    	}else if(bz_zz=='4000')
    	{
    		var price=gtms*5800*sl_;
    		$("#OPT_GTCS_TEMP").val(price);
    	}else if(bz_zz=='5000')
    	{
    		var price=gtms*5800*sl_;
    		$("#OPT_GTCS_TEMP").val(price);
    	}
    	}else{
    		var price=0;
    		$("#OPT_GTCS_TEMP").val(price);
    	}
    	//放入价格
        countZhj();
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


    //调用参考报价
    function selCbj(){
        var modelsId = $("#MODELS_ID").val();
        //获取当前数量
        var sl_ = $("#FEISHANG_MRL_SL").val();
        var item_id = $("#ITEM_ID").val();
        var offer_version = $("#offer_version").val();
        var elevIds_ = $("#ELEV_IDS").val();
        var itemId_ = $("#ITEM_ID").val();
        var bjcId = $("#BJC_ID").val();
        var feishangId = $("#FEISHANG_MRL_ID").val();
        var rowIndex = $("#rowIndex").val();
        $("#cbjView").kendoWindow({
            width: "1000px",
            height: "600px",
            title: "调用参考报价",
            actions: ["Close"],
            content: "<%=basePath%>e_offer/selCbj.do?models=feishangmrl&FEISHANGMRL_SL="+sl_+"&FEISHANGMRL_ID="+feishangId+"&ELEV_IDS="+elevIds_+"&ITEM_ID="+itemId_+"&BJC_ID="+bjcId+"&rowIndex="+rowIndex
            +"&item_id="+itemId_+"&offer_version="+offer_version,
            modal : true,
            visible : false,
            resizable : true
        }).data("kendoWindow").maximize().open();
    }

    //调用装潢价格
    function selZhj(){
        var modelsId = $("#MODELS_ID").val();
        //获取当前基础设备价格
        var zz_ = $("#BZ_ZZ").val();
        var sd_ = $("#BZ_SD").val();
        var kmxs_ = $("#BZ_KMXS").val();
        var kmkd_ = $("#BZ_KMKD").val();
        var c_ = $("#BZ_C").val();
        var z_ = $("#BZ_Z").val();
        var m_ = $("#BZ_M").val();
        var sl_ = $("#FEISHANG_MRL_SL").val();
        var zk_ = $("#FEISHANG_MRL_ZK").val();
        var sbj_ = $("#FEISHANG_MRL_SBJ").val();

        var elevIds_ = $("#ELEV_IDS").val();
        var itemId_ = $("#ITEM_ID").val();
        var bjcId = $("#BJC_ID").val();
        var feishangId = $("#FEISHANG_MRL_ID").val();
        var rowIndex = $("#rowIndex").val();
        $("#zhjView").kendoWindow({
            width: "1000px",
            height: "600px",
            title: "调用参考报价",
            actions: ["Close"],
            content: "<%=basePath%>e_offer/selZhj.do?models=feishang&BZ_ZZ="+zz_+"&BZ_SD="+sd_+"&BZ_KMXS="+kmxs_+"&BZ_KMKD="+kmkd_+"&BZ_C="+c_+"&BZ_Z="+z_+"&BZ_M="+m_+"&FEISHANG_SL="+sl_+"&FEISHANG_ZK="+zk_+"&FEISHANG_SBJ="+sbj_+"&FEISHANG_ID="+feishangId+"&ELEV_IDS="+elevIds_+"&ITEM_ID="+itemId_+"&BJC_ID="+bjcId+"&rowIndex="+rowIndex,
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
    //井道承重墙厚度
    function setJdczqhdDisable(flag){
        if(flag=='1'){
            $("#BASE_JDCZQHD_TEXT").val("");
            $("#BASE_JDCZQHD_TEXT").attr("disabled","disabled");
        }else if(flag=='0'){
            $('#BASE_JDCZQHD_TEXT').removeAttr("disabled"); 
        }
    }
    //轿门色标号
    function setJmsbhDisable(flag){
        if(flag=='1'){
            $("#JXZH_JMSBH").val("");
            $("#JXZH_JMSBH").attr("disabled","disabled");
        }else if(flag=='0'){
            $('#JXZH_JMSBH').removeAttr("disabled"); 
        }
    }
    //前围壁色标号
    function setQwbsbhDisable(flag){
        if(flag=='1'){
            $("#JXZH_QWBSBH").val("");
            $("#JXZH_QWBSBH").attr("disabled","disabled");
        }else if(flag=='0'){
            $('#JXZH_QWBSBH').removeAttr("disabled"); 
        }
    }
    //侧围壁色标号
    function setCwbsbhDisable(flag){
        if(flag=='1'){
            $("#JXZH_CWBSBH").val("");
            $("#JXZH_CWBSBH").attr("disabled","disabled");
        }else if(flag=='0'){
            $('#JXZH_CWBSBH').removeAttr("disabled"); 
        }
    }
    //后围壁色标号
    function setHwbsbhDisable(flag){
        if(flag=='1'){
            $("#JXZH_HWBSBH").val("");
            $("#JXZH_HWBSBH").attr("disabled","disabled");
        }else if(flag=='0'){
            $('#JXZH_HWBSBH').removeAttr("disabled"); 
        }
    }
    //地板型号
    function setDbxhDisable(flag){
        if(flag=='1'){
            $("#JXZH_DBXH_SELECT").val("");
            $("#JXZH_DBXH_SELECT").attr("disabled","disabled");
        }else if(flag=='0'){
            $('#JXZH_DBXH_SELECT').removeAttr("disabled"); 
        }
    }
    //防撞条型号
    function setFztxhDisable(flag){
        if(flag=='1'){
            $("#JXZH_FZTXH_SELECT").val("");
            $("#JXZH_FZTXH_SELECT").attr("disabled","disabled");
        }else if(flag=='0'){
            $('#JXZH_FZTXH_SELECT').removeAttr("disabled"); 
        }
    }
    //首层色标号和首层发纹不锈钢，参数传1为发纹不锈钢，0为喷涂
    function setScsbhDisable(flag){
        if(flag=='1'){
            $("#TMMT_SCSBH").val("");
            $("#TMMT_SCSBH").attr("disabled","disabled");
            $("#TMMT_SCSL_1").val("");
            $("#TMMT_SCSL_1").attr("disabled","disabled");
            $('#TMMT_SCSL_2').removeAttr("disabled"); 
            $("#TMMT_FWBXGTM_TEMP").val("");
            /*$("#TMMT_SCSL").val("");
            $("#TMMT_SCSL").attr("disabled","disabled");*/
            var price=0;
       	    var kmkd_ = $("#BZ_KMKD").val();  //开门宽度
            var c_ = parseInt_DN($("#BZ_C").val()-1);    //层数
            var sl_ = $("#FEISHANG_MRL_SL").val()==""?0:parseInt_DN($("#FEISHANG_MRL_SL").val());
           
            var ptdmt_ = $("#TMMT_PTDMT").val();
            //如果选择了大门套,直接算厅门价格
            if(ptdmt_=="喷涂" || ptdmt_=="发纹不锈钢"){
            	if(kmkd_=="900")
                {
                    price = 980*sl_;
                }else if(kmkd_=="1500"){
                    price = 1700*sl_;
                }else if(kmkd_=="1700"){
                    price = 2000*sl_;
                }else if(kmkd_=="2000"){
                    price = 2200*sl_;
                }else if(kmkd_=="2200"){
                    price = 2300*sl_;
                }
            }
            //如果没有选大门套，则计算厅门+小门套发纹不锈钢的价格
            else{
            	//厅门门套需要算厅门价格和门套价格
                if(kmkd_=="900")
                {
                    price = 980*sl_+310*sl_;
                }else if(kmkd_=="1500"){
                    price = 1700*sl_+540*sl_;
                }else if(kmkd_=="1700"){
                    price = 2000*sl_+620*sl_;
                }else if(kmkd_=="2000"){
                    price = 2200*sl_+690*sl_;
                }else if(kmkd_=="2200"){
                    price = 2300*sl_+770*sl_;
                }
            }  
            
            
            $("#TMMT_FWBXGTM_TEMP").val(price);
            $("#TMMT_FWBXGTM_TEMP2").val(price);
            countZhj();
        }else if(flag=='0'){
            $("#TMMT_SCSL_2").val("");
            $("#TMMT_SCSL_2").attr("disabled","disabled");
            $('#TMMT_SCSBH').removeAttr("disabled"); 
            $('#TMMT_SCSL_1').removeAttr("disabled");
            $("#TMMT_FWBXGTM_TEMP").val("");
            /*$('#TMMT_SCSL').removeAttr("disabled"); */

        }
    }
    //首层厅门门套加价
    function setSctmmt(flag)
    {
    	if(flag=='1')
    	{
    		if($("#TMMT_SCTMMT1").is(":checked"))
        	{
                var a=$("#TMMT_SCSL_2").val();
                var b=$("#TMMT_FWBXGTM_TEMP2").val();
                //$("#TMMT_FWBXGTM_TEMP").val(a*b);
                //--改
        		var ptdmt_ = $("#TMMT_PTDMT").val();
                if(ptdmt_=="喷涂" || ptdmt_=="发纹不锈钢"){
                	var sl_ = $("#FEISHANG_MRL_SL").val()==""?0:parseInt_DN($("#FEISHANG_MRL_SL").val());
        			var kmkd_ = $("#BZ_KMKD").val();  //开门宽度
                    //如果选择了大门套,直接算厅门价格
                	var price = 0;
                	//厅门门套需要算厅门价格和门套价格
                    if(kmkd_=="900")
                    {
                        price = 980*sl_*a;
                    }else if(kmkd_=="1500"){
                        price = 1700*sl_*a;
                    }else if(kmkd_=="1700"){
                        price = 2000*sl_*a;
                    }else if(kmkd_=="2000"){
                        price = 2200*sl_*a;
                    }else if(kmkd_=="2200"){
                        price = 2300*sl_*a;
                    }
                    $("#TMMT_FWBXGTM_TEMP").val(price);
                }
                //如果没有选大门套，则计算厅门+小门套发纹不锈钢的价格
                else{
        			var sl_ = $("#FEISHANG_MRL_SL").val()==""?0:parseInt_DN($("#FEISHANG_MRL_SL").val());
        			var kmkd_ = $("#BZ_KMKD").val();  //开门宽度
                    //如果选择了大门套,直接算厅门价格
                	var price = 0;
                	//厅门门套需要算厅门价格和门套价格
                    if(kmkd_=="900")
                    {
                        price = 980*sl_*a+310*sl_*a;
                    }else if(kmkd_=="1500"){
                        price = 1700*sl_*a+540*sl_*a;
                    }else if(kmkd_=="1700"){
                        price = 2000*sl_*a+620*sl_*a;
                    }else if(kmkd_=="2000"){
                        price = 2200*sl_*a+690*sl_*a;
                    }else if(kmkd_=="2200"){
                        price = 2300*sl_*a+770*sl_*a;
                    }
                    $("#TMMT_FWBXGTM_TEMP").val(price);
                }
               
        	}
    	}
    	else if(flag=='2')
    	{
    		var dmt_sl=parseInt_DN($("#DMT_SL").val());
    		if(isNaN(dmt_sl))
    		{
    			$("#TMMT_DMT_TEMP").val($("#TMMT_DMT_TEMP2").val());
    		}
    		else
    		{
    			var a4=parseInt_DN($("#TMMT_DMT_TEMP2").val());
        		$("#TMMT_DMT_TEMP").val(dmt_sl*a4);
    		}
    	}
    	
    	 //放入价格
        countZhj();
    }

    //非首层色标号和首层发纹不锈钢，参数传1为发纹不锈钢，0为喷涂
    function setFscsbhDisable(flag){
        if(flag=='1'){
            $("#TMMT_FSCSBH").val("");
            $("#TMMT_FSCSBH").attr("disabled","disabled");
            $("#TMMT_FSCSL_1").val("");
            $("#TMMT_FSCSL_1").attr("disabled","disabled");
            $('#TMMT_FSCSL_2').removeAttr("disabled"); 
            $("#TMMT_FWBXGXMT_TEMP").val("");
            /*$("#TMMT_FSCSL").val("");
            $("#TMMT_FSCSL").attr("disabled","disabled");*/
            var kmkd_ = $("#BZ_KMKD").val();  //开门宽度
            var c_ = parseInt_DN($("#BZ_C").val()-1);    //层数
            c_=1;
            var sl_ = $("#FEISHANG_MRL_SL").val()==""?0:parseInt_DN($("#FEISHANG_MRL_SL").val());
            var price=0;
          	
            //var ptdmt_ = $("#TMMT_PTDMT").val();
            var ptdmt_ = $("#FSC_DMT").val();
          	//如果选择了大门套,直接算厅门价格
            if(ptdmt_=="喷涂" || ptdmt_=="发纹不锈钢"){
            	if(kmkd_=="900"){
	                price = 980*sl_*c_;
	            }else if(kmkd_=="1500"){
	                price = 1700*sl_*c_;
	            }else if(kmkd_=="1700"){
	                price = 2000*sl_*c_;
	            }else if(kmkd_=="2000"){
	                price = 2200*sl_*c_;
	            }else if(kmkd_=="2200"){
	                price = 2300*sl_*c_;
	            }
            }else{
	          	//否则厅门门套需要算厅门价格和门套价格
	            if(kmkd_=="900"){
	                price = 980*sl_*c_+310*sl_*c_;
	            }else if(kmkd_=="1500"){
	                price = 1700*sl_*c_+540*sl_*c_;
	            }else if(kmkd_=="1700"){
	                price = 2000*sl_*c_+620*sl_*c_;
	            }else if(kmkd_=="2000"){
	                price = 2200*sl_*+690*sl_*c_;
	            }else if(kmkd_=="2200"){
	                price = 2300*sl_*c_+770*sl_*c_;
	            }
          	}
            
            $("#TMMT_FWBXGXMT_TEMP").val(price);
            $("#TMMT_FWBXGXMT_TEMP2").val(price);
            //放入价格
            countZhj();
        }else if(flag=='0'){
            $("#TMMT_FSCSL_2").val("");
            $("#TMMT_FSCSL_2").attr("disabled","disabled");
            $('#TMMT_FSCSBH').removeAttr("disabled"); 
            $('#TMMT_FSCSBH').removeAttr("disabled"); 
            $('#TMMT_FSCSL_1').removeAttr("disabled");
            $("#TMMT_FWBXGXMT_TEMP").val("");
            /*$('#TMMT_FSCSL').removeAttr("disabled"); */
        }
    }
  //非 首层  厅门门套加价
    function setFsctmmt(flag)
    {
		  if(flag=='1')
		  {
			  if($("#TMMT_FSCTMMT2").is(":checked"))
		    	{
		            var a=$("#TMMT_FSCSL_2").val();
		            var b=$("#TMMT_FWBXGXMT_TEMP2").val();
		            //$("#TMMT_FWBXGXMT_TEMP").val(a*b);
		           
		            //-----改
		            var sl_ = $("#FEISHANG_MRL_SL").val()==""?0:parseInt_DN($("#FEISHANG_MRL_SL").val());
	    			var kmkd_ = $("#BZ_KMKD").val();  //开门宽度
	                //如果选择了大门套,直接算厅门价格
	                var price = 0;
		            
	    			var ptdmt_ = $("#FSC_DMT").val();
	              	//如果选择了大门套,直接算厅门价格
	                if(ptdmt_=="喷涂" || ptdmt_=="发纹不锈钢"){
	                	if(kmkd_=="900"){
	    	                price = 980*sl_*a;
	    	            }else if(kmkd_=="1500"){
	    	                price = 1700*sl_*a;
	    	            }else if(kmkd_=="1700"){
	    	                price = 2000*sl_*a;
	    	            }else if(kmkd_=="2000"){
	    	                price = 2200*sl_*a;
	    	            }else if(kmkd_=="2200"){
	    	                price = 2300*sl_*a;
	    	            }
	                	$("#TMMT_FWBXGXMT_TEMP").val(price);
	                }else{
	    	          	//否则厅门门套需要算厅门价格和门套价格
	    	            if(kmkd_=="900"){
	    	                price = 980*sl_*a+310*sl_*a;
	    	            }else if(kmkd_=="1500"){
	    	                price = 1700*sl_*a+540*sl_*a;
	    	            }else if(kmkd_=="1700"){
	    	                price = 2000*sl_*a+620*sl_*a;
	    	            }else if(kmkd_=="2000"){
	    	                price = 2200*sl_*a+690*sl_*a;
	    	            }else if(kmkd_=="2200"){
	    	                price = 2300*sl_*a+770*sl_*a;
	    	            }
	                	$("#TMMT_FWBXGXMT_TEMP").val(price);
	              	}
	                
		    	}
		  }
		  else if(flag=='2')
		  {
			  var dmt_sl=parseInt_DN($("#FSC_DMT_SL").val());
	    		if(isNaN(dmt_sl))
	    		{
	    			$("#FSC_DMT_TEMP").val($("#FSC_DMT_TEMP2").val());
	    		}
	    		else
	    		{
	    			var a4=parseInt_DN($("#FSC_DMT_TEMP2").val());
	        		$("#FSC_DMT_TEMP").val(dmt_sl*a4);
	    		}
		  }
	    	
		  //放入价格
	      countZhj();
    }

    //操纵盘型号
    function setCzpxhDisable(flag){
        if(flag=='1'){
            $("#CZP_XS_2").val("");
            $("#CZP_XS_2").attr("disabled","disabled");
            $("#CZP_AN_2").val("");
            $("#CZP_AN_2").attr("disabled","disabled");
            $("#CZP_CZ_2").val("");
            $("#CZP_CZ_2").attr("disabled","disabled");
            $('#CZP_XS_1').removeAttr("disabled"); 
            $('#CZP_AN_1').removeAttr("disabled"); 
            $('#CZP_CZ_1').removeAttr("disabled"); 
        }else if(flag=='2'){
            $("#CZP_XS_1").val("");
            $("#CZP_XS_1").attr("disabled","disabled");
            $("#CZP_AN_1").val("");
            $("#CZP_AN_1").attr("disabled","disabled");
            $("#CZP_CZ_1").val("");
            $("#CZP_CZ_1").attr("disabled","disabled");
            $('#CZP_XS_2').removeAttr("disabled"); 
            $('#CZP_AN_2').removeAttr("disabled"); 
            $('#CZP_CZ_2').removeAttr("disabled"); 
        }
    }

    //厅外召唤型号
    function setTwzhxhDisable(flag){
        if(flag=='1'){
            $("#TMXHZZ_XS_2").val("");
            $("#TMXHZZ_XS_2").attr("disabled","disabled");
            $("#TMXHZZ_AN_2").val("");
            $("#TMXHZZ_AN_2").attr("disabled","disabled");
            $("#TMXHZZ_CZ_2").val("");
            $("#TMXHZZ_CZ_2").attr("disabled","disabled");
            //$("#TMXHZZ_ZDJC_2").val("");
            //$("#TMXHZZ_ZDJC_2").attr("disabled","disabled");
            //$("#TMXHZZ_MCGS_2").val("");
            //$("#TMXHZZ_MCGS_2").attr("disabled","disabled");
            //$("#TMXHZZ_FJSM_2").val("");
            //$("#TMXHZZ_FJSM_2").attr("disabled","disabled");
            $('#TMXHZZ_XS_1').removeAttr("disabled"); 
            $('#TMXHZZ_AN_1').removeAttr("disabled"); 
            $('#TMXHZZ_CZ_1').removeAttr("disabled"); 
            //$('#TMXHZZ_ZDJC_1').removeAttr("disabled"); 
            //$('#TMXHZZ_MCGS_1').removeAttr("disabled"); 
            //$('#TMXHZZ_FJSM_1').removeAttr("disabled"); 
        }else if(flag=='2'){
            $("#TMXHZZ_XS_1").val("");
            $("#TMXHZZ_XS_1").attr("disabled","disabled");
            $("#TMXHZZ_AN_1").val("");
            $("#TMXHZZ_AN_1").attr("disabled","disabled");
            $("#TMXHZZ_CZ_1").val("");
            $("#TMXHZZ_CZ_1").attr("disabled","disabled");
            //$("#TMXHZZ_ZDJC_1").val("");
            //$("#TMXHZZ_ZDJC_1").attr("disabled","disabled");
            //$("#TMXHZZ_MCGS_1").val("");
            //$("#TMXHZZ_MCGS_1").attr("disabled","disabled");
            //$("#TMXHZZ_FJSM_1").val("");
            //$("#TMXHZZ_FJSM_1").attr("disabled","disabled");
            $('#TMXHZZ_XS_2').removeAttr("disabled"); 
            $('#TMXHZZ_AN_2').removeAttr("disabled"); 
            $('#TMXHZZ_CZ_2').removeAttr("disabled"); 
            //$('#TMXHZZ_ZDJC_2').removeAttr("disabled"); 
            //$('#TMXHZZ_MCGS_2').removeAttr("disabled"); 
            //$('#TMXHZZ_FJSM_2').removeAttr("disabled"); 
        }
    }

  //厅外召唤型号
    function setTwzhxxDisable(flag){
        if(flag=='1'){
            $("#TMXHZZ_ZDJC_2").val("");
            $("#TMXHZZ_ZDJC_2").attr("disabled","disabled");
            $("#TMXHZZ_MCGS_2").val("");
            $("#TMXHZZ_MCGS_2").attr("disabled","disabled");
            $("#TMXHZZ_FJSM_2").val("");
            $("#TMXHZZ_FJSM_2").attr("disabled","disabled");
            $('#TMXHZZ_ZDJC_1').removeAttr("disabled"); 
            $('#TMXHZZ_MCGS_1').removeAttr("disabled"); 
            $('#TMXHZZ_FJSM_1').removeAttr("disabled"); 
        }else if(flag=='2'){
            $("#TMXHZZ_ZDJC_1").val("");
            $("#TMXHZZ_ZDJC_1").attr("disabled","disabled");
            $("#TMXHZZ_MCGS_1").val("");
            $("#TMXHZZ_MCGS_1").attr("disabled","disabled");
            $("#TMXHZZ_FJSM_1").val("");
            $("#TMXHZZ_FJSM_1").attr("disabled","disabled");
            $('#TMXHZZ_ZDJC_2').removeAttr("disabled"); 
            $('#TMXHZZ_MCGS_2').removeAttr("disabled"); 
            $('#TMXHZZ_FJSM_2').removeAttr("disabled"); 
        }
    }

    //计算基础价
    function setSbj(){
    	//调用初始化贯通门
        Jsgtms();
    	var sl_ = $("#FEISHANG_MRL_SL").val()==""?0:parseInt_DN($("#FEISHANG_MRL_SL").val());
        var sd_ = $("#BZ_SD").val();  //速度
        if(sd_=="1.0"){var sd=1;}
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
                	if(basisDate.fbdj == null){
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
                            
                            //countZhj();
                        }
                	} else {
        				$("#SBJ_TEMP").val(basisDate.fbdj*sl_);
        	            $("#DANJIA").val(basisDate.fbdj);
                		setMPrice();
                	}
                    
                });
        
    }

    //修改载重时
    function editZz(isnonUpdateQLJJ){
        var zz_ = $("#BZ_ZZ").val();
        if(zz_=="1000"){    //载重1000时
            //修改轿厢规格
            /* $("#BASE_JXGG").val("1000D-1400*1600"); */
            //修改轿厢高度
            /* $("input[name='BASE_JXGD'][value='2200mm']").attr("checked",true); */
            
            $("#IS_FEIBIAO").val("false");
            $("#JXZH_QWB_TEMP").show();
        	$("#BASE_DGZJ_TEMP").show();
        	$("#JXZH_BXGDD_TEMP").show();
        	$("#JXZH_BXGDB_TEMP").show();
        	$("#OPT_GTJX_TEMP").show();
        	$("#OPT_GTCS_TEMP").show();
        	$("#JXZH_BGJ_TEMP").show();
        	$("#JXZH_FZTXH_TEMP").show();
        	$(".intro").hide();	
            //修改开门尺寸
            $("#BASE_KMCC").val("900mm*2100mm(1000kg)");
            //修改轿顶装潢
            $("#JXZH_JDZH").val("悬吊式:(1000kg标准)");
          

        }else if(zz_=="2000"){  //载重2000时
            //修改轿厢规格
            /* $("#BASE_JXGG").val("2000D-1700*2400"); */
            //修改轿厢高度
            /* $("input[name='BASE_JXGD'][value='2300mm']").attr("checked",true); */
            
            $("#IS_FEIBIAO").val("false");
            $("#JXZH_QWB_TEMP").show();
        	$("#BASE_DGZJ_TEMP").show();
        	$("#JXZH_BXGDD_TEMP").show();
        	$("#JXZH_BXGDB_TEMP").show();
        	$("#OPT_GTJX_TEMP").show();
        	$("#OPT_GTCS_TEMP").show();
        	$("#JXZH_BGJ_TEMP").show();
        	$("#JXZH_FZTXH_TEMP").show();
        	$(".intro").hide();	
            //修改开门尺寸
            $("#BASE_KMCC").val("1500mm*2100mm(2000kg)");
          	//修改轿顶装潢
            $("#JXZH_JDZH").val("单顶式");
          

        }else if(zz_=="3000"){  //载重3000时
            //修改轿厢规格
            /* $("#BASE_JXGG").val("3000D-2000*2800"); */
            //修改轿厢高度
            /* $("input[name='BASE_JXGD'][value='2400mm']").attr("checked",true); */
            
            $("#IS_FEIBIAO").val("false");
            $("#JXZH_QWB_TEMP").show();
        	$("#BASE_DGZJ_TEMP").show();
        	$("#JXZH_BXGDD_TEMP").show();
        	$("#JXZH_BXGDB_TEMP").show();
        	$("#OPT_GTJX_TEMP").show();
        	$("#OPT_GTCS_TEMP").show();
        	$("#JXZH_BGJ_TEMP").show();
        	$("#JXZH_FZTXH_TEMP").show();
        	$(".intro").hide();	
            //修改开门尺寸
            $("#BASE_KMCC").val("2000mm*2100mm(3000kg)");
          	//修改轿顶装潢
            $("#JXZH_JDZH").val("单顶式");
          
           
        }else if(zz_=="4000"){  //载重3000时
            //修改轿厢规格
            /* $("#BASE_JXGG").val("3000D-2000*2800"); */
            //修改轿厢高度
            /* $("input[name='BASE_JXGD'][value='2400mm']").attr("checked",true); */
            
            $("#IS_FEIBIAO").val("false");
            $("#JXZH_QWB_TEMP").show();
        	$("#BASE_DGZJ_TEMP").show();
        	$("#JXZH_BXGDD_TEMP").show();
        	$("#JXZH_BXGDB_TEMP").show();
        	$("#OPT_GTJX_TEMP").show();
        	$("#OPT_GTCS_TEMP").show();
        	$("#JXZH_BGJ_TEMP").show();
        	$("#JXZH_FZTXH_TEMP").show();
        	$(".intro").hide();	
            //修改开门尺寸
            $("#BASE_KMCC").val("2000mm*2100mm(3000kg)");
          	//修改轿顶装潢
            $("#JXZH_JDZH").val("单顶式");
          
           
        }else if(zz_=="5000"){  //载重3000时
            //修改轿厢规格
            /* $("#BASE_JXGG").val("3000D-2000*2800"); */
            //修改轿厢高度
            /* $("input[name='BASE_JXGD'][value='2400mm']").attr("checked",true); */
            
            $("#IS_FEIBIAO").val("false");
            $("#JXZH_QWB_TEMP").show();
        	$("#BASE_DGZJ_TEMP").show();
        	$("#JXZH_BXGDD_TEMP").show();
        	$("#JXZH_BXGDB_TEMP").show();
        	$("#OPT_GTJX_TEMP").show();
        	$("#OPT_GTCS_TEMP").show();
        	$("#JXZH_BGJ_TEMP").show();
        	$("#JXZH_FZTXH_TEMP").show();
        	$(".intro").hide();	
            //修改开门尺寸
            $("#BASE_KMCC").val("2000mm*2100mm(3000kg)");
          	//修改轿顶装潢
            $("#JXZH_JDZH").val("单顶式");
          
           
        }else if(zz_==""){
        	$("#IS_FEIBIAO").val("true");
        	$("#JXZH_QWB_TEMP").hide();
        	$("#JXZH_QWB_TEMP").val(0);
        	$("#BASE_DGZJ_TEMP").hide();
        	$("#BASE_DGZJ_TEMP").val(0);
        	$("#JXZH_BXGDD_TEMP").hide();
        	$("#JXZH_BXGDB_TEMP").hide();
        	$("#OPT_GTJX_TEMP").hide();
        	$("#OPT_GTCS_TEMP").hide();
        	$("#JXZH_BGJ_TEMP").hide();
        	$("#JXZH_FZTXH_TEMP").val(0);
        	$("#JXZH_FZTXH_TEMP").hide();
        	$(".intro").show();	
        }
        else{
        	$("#IS_FEIBIAO").val("true");
        	$("#JXZH_QWB_TEMP").hide();
        	$("#JXZH_QWB_TEMP").val(0);
        	$("#BASE_DGZJ_TEMP").hide();
        	$("#BASE_DGZJ_TEMP").val(0);
        	$("#JXZH_BXGDD_TEMP").hide();
        	$("#JXZH_BXGDB_TEMP").hide();
        	$("#OPT_GTJX_TEMP").hide();
        	$("#OPT_GTCS_TEMP").hide();
        	$("#JXZH_BGJ_TEMP").hide();
        	$("#JXZH_FZTXH_TEMP").val(0);
        	$("#JXZH_FZTXH_TEMP").hide();
        	$(".intro").show();	
        }
        if(isnonUpdateQLJJ != '1'){
            //修改圈/钢梁间距
            $("#BASE_QGLJJ").val("2000");
        }
        editOpt('OPT_GTJX');
        editJxzh('JXZH_BXGDD');
        editJxzh('JXZH_BXGDB');
        editJxzh('JXZH_BGJ');
        editJxzh('JXZH_FZTXH');
        setSbj();
        
        //超高和加价
        setJdzg();
    }

    //修改速度时
    function editSd(){
        var sd_ = $("#BZ_SD").val();
        if(sd_=="0.5"){
            var appendStr = "<option value=''>请选择</option><option value='2'>2</option><option value='3'>3</option><option value='4'>4</option><option value='5'>5</option><option value='6'>6</option><option value='7'>7</option><option value='8'>8</option>";
            $("#BZ_C").empty();
            $("#BZ_Z").empty();
            $("#BZ_M").empty();
            $("#BZ_C").append(appendStr);
            $("#BZ_Z").append(appendStr);
            $("#BZ_M").append(appendStr);
        }else if(sd_=="1.0"){
            var appendStr = "<option value=''>请选择</option><option value='2' ${regelevStandardPd.C=='2'?'selected':''}>2</option><option value='3'>3</option><option value='4'>4</option><option value='5'>5</option><option value='6'>6</option><option value='7'>7</option><option value='8'>8</option><option value='9'>9</option><option value='10'>10</option><option value='11'>11</option><option value='12'>12</option><option value='13'>13</option><option value='14'>14</option><option value='15'>15</option>";
            $("#BZ_C").empty();
            $("#BZ_Z").empty();
            $("#BZ_M").empty();
            $("#BZ_C").append(appendStr);
            $("#BZ_Z").append(appendStr);
            $("#BZ_M").append(appendStr);
        } else {
			var appendStr = "<option value=''>请选择</option>";
			$("#BZ_C").empty();
			$("#BZ_Z").empty();
			$("#BZ_M").empty();
			$("#BZ_C").append(appendStr);
			$("#BZ_Z").append(appendStr);
			$("#BZ_M").append(appendStr);
		}
        setSbj();
        
    }
    
  //控制方式加价 
    function KZFS_TEMP(flag)
    {
    	//数量
        var sl_ = $("#FEISHANG_MRL_SL").val()==""?0:parseInt_DN($("#FEISHANG_MRL_SL").val());
    	var price=0;
    	if(flag=='1')
    	{
    		price=0;
    	}else if(flag=='2')
    	{
    		price=240*sl_;
    	}
    	else if(flag=='3')
    	{
    		price=2400*sl_;
    	}
    	else if(flag=='4')
    	{
    		price=2000*sl_;
    	}
    	$("#BASE_KZFS_TEMP").val(price);
    	//计算价格
    	countZhj();
    }

    //修改门数量时修改标准价格
    function setMPrice(){
    	//调用初始化贯通门
        Jsgtms();
        var m_ = parseInt_DN($("#BZ_M").val());
        var c_ = parseInt_DN($("#BZ_C").val());
        var z_ = parseInt_DN($("#BZ_Z").val());//站
        var price = parseInt_DN($("#FEISHANG_MRL_SBJ").val());
        var kmkd_ = parseInt_DN($("#BZ_KMKD").val());
        var sl_ = $("#FEISHANG_MRL_SL").val()==""?0:parseInt_DN($("#FEISHANG_MRL_SL").val());
        var DANJIA = $("#DANJIA").val()==""?0:parseInt_DN($("#DANJIA").val());
        var price1=$("#DANJIA").val()==""?0:parseInt_DN($("#DANJIA").val());
        var ptdmt_ = $("#TMMT_PTDMT").val();
        var fscdmt_ = $("#FSC_DMT").val();
        //--改
        if(kmkd_=="900")
        {
        	//首层门套价格
        	var a=$("#TMMT_SCSL_2").val();
        	//如果选择了大门套,直接算厅门价格
        	if(ptdmt_=="喷涂" || ptdmt_=="发纹不锈钢"){
            	$("#TMMT_FWBXGTM_TEMP").val(980*a*sl_);
                $("#TMMT_FWBXGTM_TEMP2").val(980*1*sl_);
        	}
        	//如果没有选大门套，则计算厅门+小门套发纹不锈钢的价格
        	else{
            	$("#TMMT_FWBXGTM_TEMP").val(980*a*sl_+310*a*sl_);
        	}
            
            //非首层门套价格
            var b=$("#TMMT_FSCSL_2").val();
          	//如果选择了大门套,直接算厅门价格
            if(fscdmt_=="喷涂" || fscdmt_=="发纹不锈钢"){
                $("#TMMT_FWBXGXMT_TEMP").val(980*b*sl_);
                $("#TMMT_FWBXGXMT_TEMP2").val(980*sl_);
            } else {
            	//否则厅门门套需要算厅门价格和门套价格
                $("#TMMT_FWBXGXMT_TEMP").val(980*b*sl_+310*sl_*b);
            }
        }
        else if(kmkd_=="1500")
        {
        	//首层门套价格
        	var a=$("#TMMT_SCSL_2").val();
        	//如果选择了大门套,直接算厅门价格
        	if(ptdmt_=="喷涂" || ptdmt_=="发纹不锈钢"){
            	$("#TMMT_FWBXGTM_TEMP").val(1700*a*sl_);
                $("#TMMT_FWBXGTM_TEMP2").val(1700*1*sl_);
        	}
        	//如果没有选大门套，则计算厅门+小门套发纹不锈钢的价格
        	else{
            	$("#TMMT_FWBXGTM_TEMP").val(1700*a*sl_+540*a*sl_);
        	}
        	
            //非首层门套价格
            var b=$("#TMMT_FSCSL_2").val();
          	//如果选择了大门套,直接算厅门价格
            if(fscdmt_=="喷涂" || fscdmt_=="发纹不锈钢"){
                $("#TMMT_FWBXGXMT_TEMP").val(1700*sl_*b);
                $("#TMMT_FWBXGXMT_TEMP2").val(1700*sl_);
            }else{
            	//否则厅门门套需要算厅门价格和门套价格
                $("#TMMT_FWBXGXMT_TEMP").val(1700*b*sl_+540*b*sl_);
            }
        }
        else if(kmkd_=="1700")
        {
        	//首层门套价格
        	var a=$("#TMMT_SCSL_2").val();
        	//如果选择了大门套,直接算厅门价格
        	if(ptdmt_=="喷涂" || ptdmt_=="发纹不锈钢"){
            	$("#TMMT_FWBXGTM_TEMP").val(2000*a*sl_);
                $("#TMMT_FWBXGTM_TEMP2").val(2000*1*sl_);
        	}
        	//如果没有选大门套，则计算厅门+小门套发纹不锈钢的价格
        	else{
            	$("#TMMT_FWBXGTM_TEMP").val(2000*a*sl_+620*a*sl_);
        	}
        	
            //非首层门套价格
            var b=$("#TMMT_FSCSL_2").val();
          	//如果选择了大门套,直接算厅门价格
            if(fscdmt_=="喷涂" || fscdmt_=="发纹不锈钢"){
                $("#TMMT_FWBXGXMT_TEMP").val(2000*b*sl_);	
                $("#TMMT_FWBXGXMT_TEMP2").val(2000*sl_);
            } else {
            	$("#TMMT_FWBXGXMT_TEMP").val(2000*b*sl_+620*b*sl_);
            }
        }
        else if(kmkd_=="2000")
        {
        	//首层门套价格
        	var a=$("#TMMT_SCSL_2").val();
        	//如果选择了大门套,直接算厅门价格
        	if(ptdmt_=="喷涂" || ptdmt_=="发纹不锈钢"){
            	$("#TMMT_FWBXGTM_TEMP").val(2200*a*sl_);
                $("#TMMT_FWBXGTM_TEMP2").val(2200*1*sl_);
        	} else {
        		$("#TMMT_FWBXGTM_TEMP").val(2200*a*sl_+690*a*sl_);
        	}
            
            //非首层门套价格
            var b=$("#TMMT_FSCSL_2").val();
          	//如果选择了大门套,直接算厅门价格
            if(fscdmt_=="喷涂" || fscdmt_=="发纹不锈钢"){
                $("#TMMT_FWBXGXMT_TEMP").val(2200*b*sl_);
                $("#TMMT_FWBXGXMT_TEMP2").val(2200*sl_);
            } else {
                $("#TMMT_FWBXGXMT_TEMP2").val(2200*b*sl_+690*b*sl_);
            }
        }
        else if(kmkd_=="2200")
        {
        	//首层门套价格
        	var a=$("#TMMT_SCSL_2").val();
        	//如果选择了大门套,直接算厅门价格
        	if(ptdmt_=="喷涂" || ptdmt_=="发纹不锈钢"){
            	$("#TMMT_FWBXGTM_TEMP").val(2300*a*sl_);
                $("#TMMT_FWBXGTM_TEMP2").val(2300*1*sl_);
        	} else {
        		$("#TMMT_FWBXGTM_TEMP").val(2300*a*sl_+770*a*sl_);
        	}
            
            //非首层门套价格
            var b=$("#TMMT_FSCSL_2").val();
          	//如果选择了大门套,直接算厅门价格
            if(fscdmt_=="喷涂" || fscdmt_=="发纹不锈钢"){
                $("#TMMT_FWBXGXMT_TEMP").val(2300*b*sl_);
                $("#TMMT_FWBXGXMT_TEMP2").val(2300*sl_);
            } else {
            	$("#TMMT_FWBXGXMT_TEMP").val(2300*b*sl_+770*b*sl_);
            }
        }else {
        	$("#TMMT_FWBXGTM_TEMP").val(0);
            $("#TMMT_FWBXGXMT_TEMP").val(0);
        }
        
        //countZhj();
        editJxzh('JXZH_JM');
        
        if(!isNaN(m_)&&!isNaN(c_)&&!isNaN(z_)){
        	
        	if (kmkd_=="900"||kmkd_=="1500"||kmkd_=="1700"||kmkd_=="2000"||kmkd_=="2200") {
	        	var _jj = 0;
	        	if(kmkd_=="900"){
	        		_jj = -2400;
	            }else if(kmkd_=="1500"){
	            	_jj = -4300;
	            }else if(kmkd_=="1700"){
	            	_jj = -5500;
	            }else if(kmkd_=="2000"){
	            	_jj = -5800;
	            }else if(kmkd_=="2200"){
	            	_jj = -6600;
	            }
	        	price = subDoor(DANJIA, c_ , z_, m_, _jj);
				
	        	$("#SBJ_TEMP").val(price * sl_);
	        	$("#DANJIA").val(price);
	        	$("#M_KMKD").val(0);
	        	
             	$("#TMMT_Label").hide();
             	$("#DANJIA_Label").hide();
        	}else{
        		//开门宽度非标
				$("#DANJIA_Label").show();
				$("#TMMT_Label").show();
        	}
        	
            /* var jm = c_-m_;
            if(jm>=0){
                if(kmkd_=="900"){
                    price1 = DANJIA-2400*jm*sl_;
                }else if(kmkd_=="1500"){
                    price1 = DANJIA-4300*jm*sl_;
                }else if(kmkd_=="2000"){
                    price1 = DANJIA-5800*jm*sl_;
                }else if(kmkd_=="1700"){
                    price1 = DANJIA-5500*jm*sl_;
                }else if(kmkd_=="2200"){
                    price1 = DANJIA-6600*jm*sl_;
                }
            }else{
            	//alert("选择的门大于层，请非标询价");
            }
            $("#M_KMKD").val(price1-DANJIA);

            $("#SBJ_TEMP").val(price); */
			//countZhj();
        }
        countZhj();
        
        //setSbj();
    }

    function countZhj(){
        var zhj_count = 0;
        var sbj_count = 0;
        var base_jdzg_temp = $("#BASE_JDZG_TEMP").val()==""?0:parseInt_DN($("#BASE_JDZG_TEMP").val());
        var base_dgzj_temp = $("#BASE_DGZJ_TEMP").val()==""?0:parseInt_DN($("#BASE_DGZJ_TEMP").val());
        var opt_xfld_temp = $("#OPT_XFLD_TEMP").val()==""?0:parseInt_DN($("#OPT_XFLD_TEMP").val());
        var opt_twxftfw_temp = $("#OPT_TWXFYFW_TEMP").val()==""?0:parseInt_DN($("#OPT_TWXFYFW_TEMP").val());
        var opt_jxdzz_temp = $("#OPT_JXDZZ_TEMP").val()==""?0:parseInt_DN($("#OPT_JXDZZ_TEMP").val());
        var opt_cctvdl_temp = $("#OPT_CCTVDL_TEMP").val()==""?0:parseInt_DN($("#OPT_CCTVDL_TEMP").val());
        /* var opt_tdyjjy_temp = $("#OPT_TDYJJY_TEMP").val()==""?0:parseInt_DN($("#OPT_TDYJJY_TEMP").val()); */
        var opt_djgrbh_temp = $("#OPT_DJGRBH_TEMP").val()==""?0:parseInt_DN($("#OPT_DJGRBH_TEMP").val());
        /* var opt_wlw_temp = $("#OPT_WLW_TEMP").val()==""?0:parseInt_DN($("#OPT_WLW_TEMP").val()); */
        var opt_bajk_temp = $("#OPT_BAJK_TEMP").val()==""?0:parseInt_DN($("#OPT_BAJK_TEMP").val());
        var opt_yybz_temp = $("#OPT_YYBZ_TEMP").val()==""?0:parseInt_DN($("#OPT_YYBZ_TEMP").val());
        var opt_fdlcz_temp = $("#OPT_FDLCZ_TEMP").val()==""?0:parseInt_DN($("#OPT_FDLCZ_TEMP").val());
        var opt_jjbydyczzz_temp = $("#OPT_JJBYDYCZZZ_TEMP").val()==""?0:parseInt_DN($("#OPT_JJBYDYCZZZ_TEMP").val());
        var opt_lopangs_temp = $("#OPT_LOPANGS_TEMP").val()==""?0:parseInt_DN($("#OPT_LOPANGS_TEMP").val());
        var opt_gtjx_temp = $("#OPT_GTJX_TEMP").val()==""?0:parseInt_DN($("#OPT_GTJX_TEMP").val());
        var opt_gtcs_temp = $("#OPT_GTCS_TEMP").val()==""?0:parseInt_DN($("#OPT_GTCS_TEMP").val());
        var jxzh_fztxh_temp = $("#JXZH_FZTXH_TEMP").val()==""?0:parseInt_DN($("#JXZH_FZTXH_TEMP").val());
        var jxzh_bgj_temp = $("#JXZH_BGJ_TEMP").val()==""?0:parseInt_DN($("#JXZH_BGJ_TEMP").val());
        var jxzh_bxgdb_temp = $("#JXZH_BXGDB_TEMP").val()==""?0:parseInt_DN($("#JXZH_BXGDB_TEMP").val());
        var jxzh_bxgdd_temp = $("#JXZH_BXGDD_TEMP").val()==""?0:parseInt_DN($("#JXZH_BXGDD_TEMP").val());
        var jxzh_qwb_temp = $("#JXZH_QWB_TEMP").val()==""?0:parseInt_DN($("#JXZH_QWB_TEMP").val());
        var jxzh_jm_temp = $("#JXZH_JM_TEMP").val()==""?0:parseInt_DN($("#JXZH_JM_TEMP").val());
        var tmmt_dmt_temp = $("#TMMT_DMT_TEMP").val()==""?0:parseInt_DN($("#TMMT_DMT_TEMP").val());
        var tmmt_fwbxgxmt_temp = $("#TMMT_FWBXGXMT_TEMP").val()==""?0:parseInt_DN($("#TMMT_FWBXGXMT_TEMP").val());
        var tmmt_fwbxgtm_temp = $("#TMMT_FWBXGTM_TEMP").val()==""?0:parseInt_DN($("#TMMT_FWBXGTM_TEMP").val());
        var base_ccjg = $("#BASE_CCJG").val()==""?0:parseInt_DN($("#BASE_CCJG").val());
        var fsc_dmt_temp = $("#FSC_DMT_TEMP").val()==""?0:parseInt_DN($("#FSC_DMT_TEMP").val());
        var base_kzfs_temp = $("#BASE_KZFS_TEMP").val()==""?0:parseInt_DN($("#BASE_KZFS_TEMP").val());
        var M_KMKD=$("#M_KMKD").val()==""?0:parseInt_DN($("#M_KMKD").val());
		
        //IC卡制卡设备相关选项
        var opt_ick_temp = parseInt_DN($("#OPT_ICK_TEMP").val());
        var opt_ickzksb_temp =  parseInt_DN($("#OPT_ICKZKSB_TEMP").val());
        var opt_ickkp_temp = parseInt_DN($("#OPT_ICKKP_TEMP").val());
        
      	//非标选项加价
        var opt_fb_temp = $("#OPT_FB_TEMP").val()==""?0:parseInt_DN($("#OPT_FB_TEMP").val());
        
        zhj_count = fsc_dmt_temp+base_ccjg+jxzh_fztxh_temp+jxzh_bgj_temp+jxzh_bxgdb_temp+jxzh_bxgdd_temp+jxzh_qwb_temp+jxzh_jm_temp;
        /* $("#FEISHANG_MRL_ZHJ").val(zhj_count); */
        //sbj_count = base_kzfs_temp+base_jdzg_temp+base_dgzj_temp+opt_xfld_temp+opt_twxftfw_temp+opt_jxdzz_temp+opt_cctvdl_temp+opt_djgrbh_temp+opt_bajk_temp+opt_yybz_temp+opt_fdlcz_temp+opt_jjbydyczzz_temp+opt_lopangs_temp+opt_gtjx_temp+opt_gtcs_temp+tmmt_dmt_temp+tmmt_fwbxgxmt_temp+tmmt_fwbxgtm_temp;
        //去掉井道总高的加价
        sbj_count = base_kzfs_temp+base_dgzj_temp+opt_xfld_temp+opt_twxftfw_temp+opt_jxdzz_temp+opt_cctvdl_temp+opt_djgrbh_temp+opt_bajk_temp+opt_yybz_temp+opt_fdlcz_temp+opt_jjbydyczzz_temp+opt_lopangs_temp+opt_gtjx_temp+opt_gtcs_temp+tmmt_dmt_temp+tmmt_fwbxgxmt_temp+tmmt_fwbxgtm_temp+opt_fb_temp+opt_ick_temp+opt_ickzksb_temp+opt_ickkp_temp;

        //设备标准价格 (选项加价)
        var sbj_temp = parseInt_DN($("#SBJ_TEMP").val());
        $("#FEISHANG_MRL_XXJJ").val(/* sbj_temp+ */sbj_count+zhj_count+M_KMKD);
        //折前价 =基价+选项加价 
        $("#FEISHANG_MRL_ZQJ").val(sbj_count+zhj_count+sbj_temp);
        
        //运输费
        var feishang_ysf = $("#FEISHANG_MRL_YSF").val()==""?0:parseInt_DN($("#FEISHANG_MRL_YSF").val());
        $("#FEISHANG_MRL_YSF").val(feishang_ysf);
        //安装费
        var feishang_azf = $("#FEISHANG_MRL_AZF_TEMP").val()==""?0:parseInt_DN($("#FEISHANG_MRL_AZF_TEMP").val());
        $("#FEISHANG_MRL_AZF").val(feishang_azf);

        
      //非标加价
        setFBPrice();
        
        
        var feishang_zk = parseFloat($("#FEISHANG_MRL_ZK").val())/100;
        if(!isNaN(feishang_zk)){
            var feishang_sbj = parseInt_DN($("#SBJ_TEMP").val());
            var feishang_sjbj = (feishang_sbj+zhj_count+sbj_count+feishang_ysf+feishang_azf)*feishang_zk;
            var feishang_zhsbj = feishang_sbj*feishang_zk;
            $("#FEISHANG_MRL_SJBJ").val(feishang_sjbj);
            $("#FEISHANG_MRL_ZHSBJ").val(feishang_zhsbj);
            $("#zk_").text($("#FEISHANG_MRL_ZK").val());
        }

        countInstallPrice();
        
        JS_SJBJ();
    }

    //调用参考报价之后计算价格
    function cbjPrice(){
        //井道总高
        setJdzg();
        //导轨支架
        setDgzj();
        
        //KZFS_TEMP("${pd.BASE_KZFS}");
        
        if("${pd.BASE_KZFS}"=="单台(G1C)")
		{
        	KZFS_TEMP("1");
		}else if("${pd.BASE_KZFS}"=="两台并联(G2C)"){
			KZFS_TEMP("2");
		}else if("${pd.BASE_KZFS}"=="三台群控(G3C)"){
			KZFS_TEMP("3");
		}else if("${pd.BASE_KZFS}"=="四台群控(G4C)"){
			KZFS_TEMP("4");
		}
        //可选功能
        editOpt('OPT_XFLD','1');
        editOpt('OPT_TWXFYFW','1');
        editOpt('OPT_JXDZZ','1');
        editOpt('OPT_CCTVDL','1');
        editOpt('OPT_TDYJJY','1');
        editOpt('OPT_DJGRBH','1');
        editOpt('OPT_WLW','1');
        editOpt('OPT_BAJK','1');
        editOpt('OPT_YYBZ','1');
        editOpt('OPT_FDLCZ','1');
        editOpt('OPT_JJBYDYCZZZ','1');
        editOpt('OPT_LOPANGS','1');
        editOpt('OPT_GTJX','1');
        editOpt('OPT_GTCS','1');
        editOpt('OPT_ICK', '1');
        editOpt('OPT_ICKZKSB', '1');
        editOpt('OPT_ICKKP', '1');
        //轿厢装潢
        editJxzh('JXZH_JM','1');
        editJxzh('JXZH_QWB','1');
        editJxzh('JXZH_CWB','1');
        editJxzh('JXZH_HWB','1');
        editJxzh('JXZH_BXGDD','1');
        editJxzh('JXZH_BXGDB','1');
        editJxzh('JXZH_BGJ','1');
        editJxzh('JXZH_FZTXH','1');
        //厅门门套
        editTmmt('TMMT_FWBXGTM','1');
        editTmmt('TMMT_FWBXGXMT','1');
        editTmmt('TMMT_DMT','1');
        editTmmt('FSC_DMT','1');
        
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

    //计算井道总高-加价
    function setJdzg(){
    	var dtsl_ = parseInt_DN($("#DT_SL").val());
        var tsgd_= parseInt_DN($("#BASE_TSGD").val());    //提升高度
        var dksd_ = parseInt_DN($("#BASE_DKSD").val());     //底坑深度
        var dcgd_ = parseInt_DN($("#BASE_DCGD").val());    //顶层高度
        var gqljj = parseInt_DN($("#BASE_QGLJJ").val());  //钢圈梁间距
        if(!isNaN(tsgd_)&&!isNaN(dksd_)&&!isNaN(dcgd_))
        {
            var jdzg_ = tsgd_+dksd_+dcgd_;  //井道总高
            $("#BASE_JDZG").val(jdzg_);
            //加价
            var price = 0;
            var zz_ = $("#BZ_ZZ").val();  //载重
            var c_ = parseInt_DN($("#BZ_C").val())   //层数
            
            //计算导轨支架实际档数
            dgzj_std = Math.ceil((jdzg_/gqljj)+1);
            //alert(jdzg_+'+'+gqljj+'='+dgzj_std); 
            $("#BASE_DGZJ").val(dgzj_std);
            
            /* if(zz_=="1000"){
                var K = 3850;
                var S = 1250;
                var jdzg_std = 3000*(c_-1)+K+S; //井道总高(标准)
                price = 720*((jdzg_-jdzg_std)/100);
                var dgzj_std = Math.ceil((jdzg_std/2500)+1);//导轨支架标准档数
                $("#BASE_DGZJ").val(dgzj_std);
            }else if(zz_=="2000"){
                var K = 4300;
                var S = 1500;
                var jdzg_std = 3000*(c_-1)+K+S; //井道总高(标准)
                price = 770*((jdzg_-jdzg_std)/100);
                var dgzj_std = Math.ceil((jdzg_std/2500)+1);//导轨支架标准档数
                $("#BASE_DGZJ").val(dgzj_std);
            }else if(zz_=="3000"){
                var K = 4300;
                var S = 1500;
                var jdzg_std = 3000*(c_-1)+K+S; //井道总高(标准)
                price = 890*((jdzg_-jdzg_std)/100);
                var dgzj_std = Math.ceil((jdzg_std/2500)+1);//导轨支架标准档数
                $("#BASE_DGZJ").val(dgzj_std);
            } */
        }

      //根据基本参数 获取提升高度 以及加价
        var sd_ = $("#BZ_SD").val();  //速度
        if(sd_=="1.0")
        {
        	var sd=1;
        } else {
        	var sd=sd_;
        }
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
                    	if(isNaN(tsgd_) && isNaN(dksd_) && isNaN(dcgd_))
                    	{
                    		$("#BASE_CCGD").val("");
                        	$("#BASE_CCJG").val("");
                        	$("#BASE_JDZG_TEMP").val("");
                        	$("#BASE_JDZG").val("");
                    	}
                    	else
                    	{
                    		var BZJDG = 0;
                        	var JJ = 0;
                        	if(result.pd != null){
                        		BZJDG = result.pd.BZJDG;
                        		JJ = result.pd.JJ;
                        	}
                    		var jdzg=$("#BASE_JDZG").val();
                        	var ccgd=jdzg-parseInt_DN(BZJDG*1000);//超出高度
                        	var ccjg=(ccgd/1000)*JJ*dtsl_;//超出高度加价
                        	$("#BASE_CCGD").val(ccgd);
                        	if(parseInt_DN(ccjg)>0){
                           		$("#BASE_CCJG").val(parseInt_DN(ccjg));
                           	}else{
                           		$("#BASE_CCJG").val(0);
                           	}
                        	
                        	$("#BASE_BZJDZG").val(BZJDG);

                            $("#BASE_JDZG_TEMP").val(price);
                            //放入价格
                            countZhj();
                    	}
                    	
                    }
                    else
                    {
                    	$("#BASE_CCGD").val("");
                    	$("#BASE_CCJG").val("");
                    	$("#BASE_JDZG_TEMP").val("");
                    	$("#BASE_JDZG").val("");
                    }

                });
        setDgzj();

        
    }

    //计算导轨支架-加价
    function setDgzj(){
        var dgzj_ = parseInt_DN($("#BASE_DGZJ").val());  //导轨支架
        
        BASE_JDZG
        var sl_ = $("#FEISHANG_MRL_SL").val()==""?0:parseInt_DN($("#FEISHANG_MRL_SL").val()); //台数
        if(!isNaN(dgzj_)){
            var zz_ = $("#BZ_ZZ").val();  //载重
            var c_ = parseInt_DN($("#BZ_C").val())   //层数
            var jdzg_std = 0;   //井道总高(标准)
            var dgzj_std = 0;   //导轨支架档数(标准)
            
            //井道总高(标准) 改为从数据库中取
            //jdzg_std = $("#BASE_BZJDZG").val();
            jdzg_std = $("#BASE_JDZG").val();
            
            var zz = parseInt_DN($("#BZ_ZZ").val());  //载重
           
        	var gqljj = parseInt_DN($("#BASE_QGLJJ").val());  //钢圈梁间距
            dgzj_std = Math.ceil((jdzg_std/gqljj)+1);
            
            var price = (dgzj_-dgzj_std)*450*sl_;
            if(dgzj_>dgzj_std)
            {
              	$("#BASE_DGZJ").val(dgzj_);
              	if(price>0){
            		$("#BASE_DGZJ_TEMP").val(price);
            	}else{
            		$("#BASE_DGZJ_TEMP").val(0);
            	}
            }
            else
            {
            	$("#BASE_DGZJ").val(dgzj_std); 
            	$("#BASE_DGZJ_TEMP").val("0");
            }
           
            //放入价格
            countZhj();
        }
    }

  	//基本参数部分-加价
	function editGbcs(option){
		//数量
        var sl_ = $("#FEISHANG_SL").val()==""?0:parseInt_DN($("#FEISHANG_SL").val());
      	//价格
        var price = 0;
        if(option=="BASE_JXRKSL"){
        	if($('#BASE_JXRKSL').val() == 2){
      			$('#OPT_GTJX_TEXT').prop("checked","checked");
      		} else {
      			$("#OPT_GTJX_TEXT").removeAttr("checked");
      		}
        	editOpt('OPT_GTJX');
        } else if(option=="BASE_JXRKSL_SELECT"){
        	if($("#OPT_GTJX_TEXT").is(":checked")){
        		$('#BASE_JXRKSL').val("2");
      		} else {
      			$('#BASE_JXRKSL').val("1");
      		}
        }
  	}
  	
    //可选功能部分加价
    function editOpt(option, isRefresh){
        //数量
        var sl_ = $("#FEISHANG_MRL_SL").val()==""?0:parseInt_DN($("#FEISHANG_MRL_SL").val());
        //价格
        var price = 0;
        if(option=="OPT_XFLD"){
            //消防联动
            if($("#OPT_XFLD_TEXT").is(":checked")){
                price = 150*sl_;
            }else{
                price = 0;
            }
            $("#OPT_XFLD_TEMP").val(price);
        }else if(option=="OPT_TWXFYFW"){
            //厅外消防员服务
            if($("#OPT_TWXFYFW_TEXT").is(":checked")){
                price = 230*sl_;
            }else{
                price = 0;
            }
            $("#OPT_TWXFYFW_TEMP").val(price);
        }else if(option=="OPT_JXDZZ"){
            //轿厢到站钟
            if($("#OPT_JXDZZ_TEXT").is(":checked")){
                price = 180*sl_;
            }else{
                price = 0;
            }
            $("#OPT_JXDZZ_TEMP").val(price);
        }else if(option=="OPT_CCTVDL"){
            //CCTV电缆
            if($("#OPT_CCTVDL_TEXT").is(":checked"))
            {
                var test = $("#BASE_TSGD").val();
                if(!test>0)
                {
                	alert("请填写基础参数的提升高度!");
                }
                else
                {
                	if(!isNaN(parseInt_DN($("#BASE_TSGD").val()))){
                        var tsgd_ = parseInt_DN($("#BASE_TSGD").val());  //提升高度
                        price = 16*(tsgd_/1000+15)*sl_;
                    }
                }
            }else{
                price = 0;
            }
            $("#OPT_CCTVDL_TEMP").val(price);
        }else if(option=="OPT_TDYJJY"){
            //停电应急救援
            if($("#OPT_TDYJJY_TEXT").is(":checked")){
                var zz_ = $("#BZ_ZZ").val();  //载重
                var sd_ = $("#BZ_SD").val();  //速度
                if(zz_=="3000"&&sd_=="1.0"){
                    price = 9000*sl_;
                }else{
                    price = 7300*sl_;
                }
            }else{
                price = 0;
            }
            $("#OPT_TDYJJY_TEMP").val(price);
        }else if(option=="OPT_DJGRBH"){
            //电机过热保护
            if($("#OPT_DJGRBH_TEXT").is(":checked")){
                price = 620*sl_;
            }else{
                price = 0;
            }
            $("#OPT_DJGRBH_TEMP").val(price);
        }else if(option=="OPT_WLW"){
            //物联网
            if($("#OPT_WLW_TEXT").is(":checked")){
                price = 3700*sl_;
            }else{
                price = 0;
            }
            $("#OPT_WLW_TEMP").val(price);
        }else if(option=="OPT_BAJK"){
            //BA接口
            if($("#OPT_BAJK_TEXT").is(":checked")){
                price = 620*sl_;
            }else{
                price = 0;
            }
            $("#OPT_BAJK_TEMP").val(price);
        }else if(option=="OPT_YYBZ"){
            //语音报站
            if($("#OPT_YYBZ_TEXT").is(":checked")){
                price = 1200*sl_;
            }else{
                price = 0;
            }
            $("#OPT_YYBZ_TEMP").val(price);
        }else if(option=="OPT_FDLCZ"){
            //防捣乱操作
            if($("#OPT_FDLCZ_TEXT").is(":checked")){
                price = 120*sl_;
            }else{
                price = 0;
            }
            $("#OPT_FDLCZ_TEMP").val(price);
        }else if(option=="OPT_JJBYDYCZZZ"){
            //紧急备用电源操作装置
            if($("#OPT_JJBYDYCZZZ_TEXT").is(":checked")){
                price = 3100*sl_;
            }else{
                price = 0;
            }
            $("#OPT_JJBYDYCZZZ_TEMP").val(price);
        }else if(option=="OPT_LOPANGS"){
            //LOP按钮个数
            console.log($("#OPT_LOPANGS").val());
            if(!isNaN(parseInt_DN($("#OPT_LOPANGS").val()))){
                var lopangs_ = parseInt_DN($("#OPT_LOPANGS").val());
                price = 30*lopangs_*sl_;
            }
            $("#OPT_LOPANGS_TEMP").val(price);
        }else if(option=="OPT_GTJX"){
            //贯通轿厢
            if($("#OPT_GTJX_TEXT").is(":checked")){
                var zz_ = $("#BZ_ZZ").val();  //载重
                var sd_=$("#BZ_SD").val();//速度
                if(zz_=="1000"){
                    price = 10000*sl_;
                }else if(zz_=="2000"){
                    price = 12000*sl_;
                }else if(zz_=="3000"){
                    price = 13100*sl_;
                }else if(zz_=="4000" || zz_=="5000")
               	{
                	price=15000*sl_;
               	}
            }else{
                price = 0;
            }
            $("#OPT_GTJX_TEMP").val(price);
        }else if(option=="OPT_GTCS"){
            //贯通层数
            if(!isNaN(parseInt_DN($("#OPT_GTCS").val()))){
                var gtcs_ = parseInt_DN($("#OPT_GTCS").val());
                var zz_ = $("#BZ_ZZ").val();  //载重
                if(zz_=="1000"){
                    price = 2400*gtcs_*sl_;
                }else if(zz_=="2000"){
                    price = 4300*gtcs_*sl_;
                }else if(zz_=="3000"){
                    price = 5100*gtcs_*sl_;
                }else if(zz_=="4000" || zz_=="5000"){
                    price = 5800*gtcs_*sl_;
                }
            }else{
                price = 0;
            }
            $("#OPT_GTCS_TEMP").val(price);
        } else if (option == "OPT_ICK") {
            //IC卡(轿内控制)
            if ($("#OPT_ICK").val() == "刷卡后手动选择到达楼层") {
                price = 1920 * sl_;
            } else if ($("#OPT_ICK").val() == "刷卡后自动选择到达楼层") {
                price = 4040 * sl_;
            } else {
                price = 0;
            }
            $("#OPT_ICK_TEMP").val(price);
        } else if (option == "OPT_ICKZKSB") {
            //IC卡制卡设备
            if ($("#OPT_ICKZKSB_TEXT").is(":checked")) {
                $("#OPT_ICKZKSB_TEMP").val(1400);
            } else {
                $("#OPT_ICKZKSB_TEMP").val(0);
            }
        } else if (option == "OPT_ICKKP") {
            //IC卡卡片
            if (!isNaN(parseInt_DN($("#OPT_ICKKP").val()))) {
                price = parseInt_DN($("#OPT_ICKKP").val()) * 12;
            } else {
                price = 0;
            }
            $("#OPT_ICKKP_TEMP").val(price);
        }
        
        if(isRefresh != '1'){
            //放入价格
            countZhj();
        }
    }

    //轿厢装潢部分-加价
    function editJxzh(option, isRefresh){
        //数量
        var sl_ = $("#FEISHANG_MRL_SL").val()==""?0:parseInt_DN($("#FEISHANG_MRL_SL").val());
        //价格
        var price = 0;
        if(option=="JXZH_JM"){
            //轿门
            var jm_ = $("input[name='JXZH_JM']:checked").val();
            if(jm_=="SUS 443发纹不锈钢"){
                setJmsbhDisable("1");
                var kmkd_ = $("#BZ_KMKD").val();  //开门宽度
                if(kmkd_=="900"){
                    price = 1000*sl_;
                }else if(kmkd_=="1500"){
                    price = 1700*sl_;
                }else if(kmkd_=="1700"){
                    price = 2000*sl_;
                }else if(kmkd_=="2000"){
                    price = 2200*sl_;
                }else if(kmkd_=="2200"){
                    price = 2300*sl_;
                }
                //如果贯通层数大于0，表示有贯通时，轿门的价格需要乘以2
                //贯通层数
                if(!isNaN(parseInt_DN($("#OPT_GTCS").val()))){
                	if(parseInt_DN($("#OPT_GTCS").val())>0){
                		price=price*2;
                	}
                }
            }else{
                setJmsbhDisable("0");
                price = 0;
            }
            $("#JXZH_JM_TEMP").val(price);
        }else if(option=="JXZH_JM_quxiao"){
        	$("input[name='JXZH_JM']:checked").removeAttr("checked");
        	$("input[name='JXZH_QWB']:checked").removeAttr("checked");
        	$("input[name='JXZH_CWB']:checked").removeAttr("checked");
        	$("input[name='JXZH_HWB']:checked").removeAttr("checked");
        	$("#JXZH_JM_TEMP").val(0);
        	$("#JXZH_QWB_TEMP").val(0);
        }else if(option=="TMMT_SCTMMT_quxiao"){
        	$("input[name='TMMT_SCTMMT']:checked").removeAttr("checked");
        	$("input[name='TMMT_FSCTMMT']:checked").removeAttr("checked");
        	$("#TMMT_FWBXGTM_TEMP").val(0);
        	$("#TMMT_FWBXGTM_TEMP2").val(0);
        	$("#TMMT_FWBXGXMT_TEMP").val(0);
        	$("#TMMT_FWBXGXMT_TEMP2").val(0);
        	
        	//首层厅门门套
        	$("#TMMT_SCSBH").val("");
            $("#TMMT_SCSBH").attr("disabled","disabled");
            $("#TMMT_SCSL_1").val("");
            $("#TMMT_SCSL_1").attr("disabled","disabled");
            $("#TMMT_SCSL_2").val("");
            $("#TMMT_SCSL_2").attr("disabled","disabled");
            
          	//非首层厅门门套
            $("#TMMT_FSCSBH").val("");
            $("#TMMT_FSCSBH").attr("disabled","disabled");
            $("#TMMT_FSCSL_1").val("");
            $("#TMMT_FSCSL_1").attr("disabled","disabled");
            $("#TMMT_FSCSL_2").val("");
            $("#TMMT_FSCSL_2").attr("disabled","disabled");
            
        }else if(option=="JXZH_QWB"){
            //前围壁
            var qwb_ = $("input[name='JXZH_QWB']:checked").val();
            var cwb_ = $("input[name='JXZH_CWB']:checked").val();
            var hwb_ = $("input[name='JXZH_HWB']:checked").val();
            if(qwb_=="SUS 443发纹不锈钢"){
                setQwbsbhDisable("1");
                if(cwb_=="SUS 443发纹不锈钢" &&hwb_=="SUS 443发纹不锈钢"){
                	var kmkd_ = $("#BZ_KMKD").val();  //开门宽度
                    var zz_ = $("#BZ_ZZ").val();  //载重
                    if(zz_=="1000"){
                        price = 4000*sl_;
                    }else if(zz_=="2000"){
                        price = 8000*sl_;
                    }else if(zz_=="3000"){
                        price = 10000*sl_;
                    }else if(zz_=="3000"){
                        price = 10000*sl_;
                    }else if(zz_=="4000"){
                        price = 12000*sl_;
                    }else if(zz_=="5000"){
                        price = 15000*sl_;
                    }
                }
            }else{
                setQwbsbhDisable("0");
                price = 0;
            }
            $("#JXZH_QWB_TEMP").val(price);
        }else if(option=="JXZH_CWB"){
            //侧围壁
        	 var qwb_ = $("input[name='JXZH_QWB']:checked").val();
             var cwb_ = $("input[name='JXZH_CWB']:checked").val();
             var hwb_ = $("input[name='JXZH_HWB']:checked").val();
             if(cwb_=="SUS 443发纹不锈钢"){
                 setCwbsbhDisable("1");
                 if(qwb_=="SUS 443发纹不锈钢" && hwb_=="SUS 443发纹不锈钢"){
                	 var kmkd_ = $("#BZ_KMKD").val();  //开门宽度
                     var zz_ = $("#BZ_ZZ").val();  //载重
                     if(zz_=="1000"){
                         price = 4000*sl_;
                     }else if(zz_=="2000"){
                         price = 8000*sl_;
                     }else if(zz_=="3000"){
                         price = 10000*sl_;
                     }else if(zz_=="3000"){
                         price = 10000*sl_;
                     }else if(zz_=="4000"){
                         price = 12000*sl_;
                     }else if(zz_=="5000"){
                         price = 15000*sl_;
                     }
                 }
             }else{
            	 setCwbsbhDisable("0");
                 price = 0;
             }
             $("#JXZH_QWB_TEMP").val(price);
        }else if(option=="JXZH_HWB"){
            //后围壁
        	 var qwb_ = $("input[name='JXZH_QWB']:checked").val();
             var cwb_ = $("input[name='JXZH_CWB']:checked").val();
             var hwb_ = $("input[name='JXZH_HWB']:checked").val();
             if(hwb_=="SUS 443发纹不锈钢"){
                 setHwbsbhDisable("1");
                 if(qwb_=="SUS 443发纹不锈钢"&& cwb_=="SUS 443发纹不锈钢"){
                     var kmkd_ = $("#BZ_KMKD").val();  //开门宽度
                     var zz_ = $("#BZ_ZZ").val();  //载重
                     if(zz_=="1000"){
                         price = 4000*sl_;
                     }else if(zz_=="2000"){
                         price = 8000*sl_;
                     }else if(zz_=="3000"){
                         price = 10000*sl_;
                     }else if(zz_=="3000"){
                         price = 10000*sl_;
                     }else if(zz_=="4000"){
                         price = 12000*sl_;
                     }else if(zz_=="5000"){
                         price = 15000*sl_;
                     }
                 }
             }else{
            	 setHwbsbhDisable("0");
                 price = 0;
             }
             $("#JXZH_QWB_TEMP").val(price);
        }else if(option=="JXZH_BXGDD"){
            //不锈钢吊顶
            if($("#JXZH_BXGDD_TEXT").is(":checked")){
                var zz_ = $("#BZ_ZZ").val();  //载重
                if(zz_=="1000"){
                    price = 1200*sl_;
                }else if(zz_=="2000"){
                    price = 2300*sl_;
                }else if(zz_=="3000"){
                    price = 3500*sl_;
                }else if(zz_=="4000"){
                    price = 4600*sl_;
                }else if(zz_=="5000"){
                    price = 5800*sl_;
                }
            }else{
                price = 0;
            }
            $("#JXZH_BXGDD_TEMP").val(price);
        }else if(option=="JXZH_BXGDB"){
            //不锈钢地板
            if($("#JXZH_BXGDB_TEXT").is(":checked")){
                var zz_ = $("#BZ_ZZ").val();  //载重
                if(zz_=="1000"){
                    price = 3100*sl_;
                }else if(zz_=="2000"){
                    price = 5400*sl_;
                }else if(zz_=="3000"){
                    price = 7700*sl_;
                }else if(zz_=="4000"){
                    price = 10000*sl_;
                }else if(zz_=="5000"){
                    price = 12000*sl_;
                }
            }else{
                price = 0;
            }
            $("#JXZH_BXGDB_TEMP").val(price);
        }else if(option=="JXZH_BGJ"){
            //半高镜
            if($("#JXZH_BGJ_TEXT").is(":checked")){
                var zz_ = $("#BZ_ZZ").val();  //载重
                if(zz_=="1000"){
                    price = 880*sl_;
                }else if(zz_=="2000"){
                    price = 1500*sl_;
                }else if(zz_=="3000"){
                    price = 1800*sl_;
                }else if(zz_=="4000"){
                    price = 2200*sl_;
                }else if(zz_=="5000"){
                    price = 2500*sl_;
                }
            }else{
                price = 0;
            }
            $("#JXZH_BGJ_TEMP").val(price);
        }else if(option=="JXZH_FZTXH"){
            //防撞条型号
            //防撞条数量
            var FZTSL1 = $("input:checkbox[name='JXZH_FZTAZWZ1']:checked").length;
            var FZTSL2 = $("input:checkbox[name='JXZH_FZTAZWZ2']:checked").length;
            var FZTSL3 = $("input:checkbox[name='JXZH_FZTAZWZ3']:checked").length;
            var countFZTSL = FZTSL1+FZTSL2+FZTSL3;
         	// 2018-10-13 改 不需乘以防撞条数量 start
            if(countFZTSL > 0){
            	countFZTSL = 1;
            }
            // end
            if($("input[name='JXZH_FZTXH']:checked").val()!="无"){
                setFztxhDisable('0');
                var fztxh_ = $("#JXZH_FZTXH_SELECT").val();
                var zz_=$("#BZ_ZZ").val();//载重
                if(fztxh_=="木条"){
                	if(zz_=="1000" || zz_=="2000" || zz_=="3000"){
                		price = 1500*sl_*countFZTSL;
                	}else{
                		price = 1800*sl_*countFZTSL;
                	}
                }else if(fztxh_=="橡胶条"){
                	if(zz_=="1000" || zz_=="2000" || zz_=="3000"){
                		price = 2200*sl_*countFZTSL;
                	}else{
                		price = 2600*sl_*countFZTSL;
                	}
                }
            }else{
                setFztxhDisable('1');
                price = 0;
            }
            $("#JXZH_FZTXH_TEMP").val(price);
        }
        if(isRefresh != '1'){
            //放入价格
            countZhj();
        }
    }

    //厅门门套部分-加价
    function editTmmt(option, isRefresh)
    {
        //数量
        var sl_ = $("#FEISHANG_MRL_SL").val()==""?0:parseInt_DN($("#FEISHANG_MRL_SL").val());
        //价格
        var price = 0;
        if(option=="TMMT_FWBXGTM"){
            //发纹不锈钢厅门
            if($("#TMMT_FWBXGTM_TEXT").is(":checked")){
                var kmkd_ = $("#BZ_KMKD").val();  //开门宽度
                var c_ = parseInt_DN($("#BZ_C").val());    //层数
                if(kmkd_=="900"){
                    price = 980*c_*sl_;
                }else if(kmkd_=="1500"){
                    price = 1700*c_*sl_;
                }else if(kmkd_=="2000"){
                    price = 2200*c_*sl_;
                }
            }else{
                price = 0;
            }
            $("#TMMT_FWBXGTM_TEMP").val(price);
        }else if(option=="FSC_DMT"){
        	//非首层  大门套
            var ptdmt_ = $("#FSC_DMT").val();
            var kmkd_ = $("#BZ_KMKD").val();  //开门宽度
            var ts = $("#FSC_DMT_SL").val()==""?0:parseInt_DN($("#FSC_DMT_SL").val());    //套数
            if(ptdmt_=="喷涂"){
            	if(kmkd_=="900"){
                    price = 1500*ts*sl_;
                }else if(kmkd_=="1500"){
                    price = 2300*ts*sl_;
                }else if(kmkd_=="1700"){
                    price = 2600*ts*sl_;
                }else if(kmkd_=="2000"){
                    price = 3100*ts*sl_;
                }else if(kmkd_=="2200"){
                    price = 3400*ts*sl_;
                }
            }else if(ptdmt_=="发纹不锈钢"){
            	if(kmkd_=="900"){
                    price = 2100*ts*sl_;
                }else if(kmkd_=="1500"){
                    price = 3400*ts*sl_;
                }else if(kmkd_=="1700"){
                    price = 3800*ts*sl_;
                }else if(kmkd_=="2000"){
                    price = 4500*ts*sl_;
                }else if(kmkd_=="2200"){
                    price = 4800*ts*sl_;
                }
            }
            $("#FSC_DMT_TEMP").val(price);
            $("#FSC_DMT_TEMP2").val(price);
        }else if(option=="TMMT_PTDMT"){
            //首层  大门套
            var ptdmt_ = $("#TMMT_PTDMT").val();
            var kmkd_ = $("#BZ_KMKD").val();  //开门宽度
            var ts = $("#DMT_SL").val()==""?0:parseInt_DN($("#DMT_SL").val());    //套数
            if(ptdmt_=="喷涂"){
                if(kmkd_=="900"){
                    price = 1500*ts*sl_;
                }else if(kmkd_=="1500"){
                    price = 2300*ts*sl_;
                }else if(kmkd_=="1700"){
                    price = 2600*ts*sl_;
                }else if(kmkd_=="2000"){
                    price = 3100*ts*sl_;
                }else if(kmkd_=="2200"){
                    price = 3400*ts*sl_;
                }
            }else if(ptdmt_=="发纹不锈钢"){
                if(kmkd_=="900"){
                    price = 2100*ts*sl_;
                }else if(kmkd_=="1500"){
                    price = 3400*ts*sl_;
                }else if(kmkd_=="1700"){
                    price = 3800*ts*sl_;
                }else if(kmkd_=="2000"){
                    price = 4500*ts*sl_;
                }else if(kmkd_=="2200"){
                    price = 4800*ts*sl_;
                }
            }
            $("#TMMT_DMT_TEMP").val(price);
            $("#TMMT_DMT_TEMP2").val(price);
        }
        
        if(isRefresh != '1'){
            //放入价格
            countZhj();
        }
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
        	$("#FEISHANG_MRL_YSJ").val(0);
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
                        $("#FEISHANG_MRL_YSJ").val(transPrice);
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
                        $("#FEISHANG_MRL_YSJ").val(transPrice);
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

    function save(){

        if(validateIsInput()){
//         	removeAttrDisabled();
        	
        	var index = layer.load(1);
        	var saveFlag = "1";
			$.ajax({
			    type: 'POST',
			    url: '<%=basePath%>e_offerdt/saveFeishangMrl.do',
			    data: $("#feishangForm").dn2_serialize(getSelectDis())+"&saveFlag="+saveFlag,
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
    
    function getFBLXJSON() {
    	return ${fns:getDictListJson('fbtype')};
    }

    function validateIsInput() {
    	//非空验证
        if ($("#FEISHANG_MRL_QTFY").val() == "" && $("#FEISHANG_MRL_QTFY").val() == "") {
			$("#FEISHANG_MRL_QTFY").focus();
			$("#FEISHANG_MRL_QTFY").tips({
				side : 3,
				msg : "请填写其他费用!",
				bg : '#AE81FF',
				time : 3
			});
			return false;
		}
        
        if ($("#FEISHANG_MRL_YJZE").val() == "" && $("#FEISHANG_MRL_YJZE").val() == "") {
			$("#FEISHANG_MRL_YJZE").focus();
			$("#FEISHANG_MRL_YJZE").tips({
				side : 3,
				msg : "请填写佣金费用!",
				bg : '#AE81FF',
				time : 3
			});
			return false;
		}
        
        if ($("#FEISHANG_MRL_CQSJDJ").val() == "" && $("#FEISHANG_MRL_CQSJDJ").val() == "") {
			$("#FEISHANG_MRL_CQSJDJ").focus();
			$("#FEISHANG_MRL_CQSJDJ").tips({
				side : 3,
				msg : "请填写草签实际单价!",
				bg : '#AE81FF',
				time : 3
			});
			return false;
		}
        
        if ($("#FEISHANG_MRL_YSJ").val() == "" && $("#FEISHANG_MRL_YSJ").val() == "") {
			$("#FEISHANG_MRL_YSJ").focus();
			$("#FEISHANG_MRL_YSJ").tips({
				side : 3,
				msg : "请录入运输价!",
				bg : '#AE81FF',
				time : 3
			});
			return false;
		}

        if(!validateRequired()){
        	return false;
        }
        
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

        //非标json
        $("#UNSTD").val(getJsonStrfb());
        $("#trans_more_car").val(formatTransJson());

        //井道承重墙厚度
        if($("input[name='BASE_JDCZQHD']:checked").val()!="250"){
            $("input[name='BASE_JDCZQHD']:checked").val($("#BASE_JDCZQHD_TEXT").val());
        }
        //轿厢装潢地板型号
        if($("input[name='JXZH_DBXH']:checked").val()!="PVC地板革"&&$("input[name='JXZH_DBXH']:checked").val()!="碳钢花纹钢板"){
            $("input[name='JXZH_DBXH']:checked").val($("#JXZH_DBXH_SELECT").val());
        }
        //防撞条型号
        if($("input[name='JXZH_FZTXH']:checked").val()!="无"){
            $("input[name='JXZH_FZTXH']:checked").val($("#JXZH_FZTXH_SELECT").val());
        }
        //轿厢装潢
        if($("#JXZH_BXGDD_TEXT").is(":checked")){
            $("#JXZH_BXGDD").val("1");
        }else{
            $("#JXZH_BXGDD").val("0");
        }
        if($("#JXZH_BXGDB_TEXT").is(":checked")){
            $("#JXZH_BXGDB").val("1");
        }else{
            $("#JXZH_BXGDB").val("0");
        }
        if($("#JXZH_BGJ_TEXT").is(":checked")){
            $("#JXZH_BGJ").val("1");
        }else{
            $("#JXZH_BGJ").val("0");
        }
        //厅门门套
        if($("#TMMT_FWBXGTM_TEXT").is(":checked")){
            $("#TMMT_FWBXGTM").val("1");
        }else{
            $("#TMMT_FWBXGTM").val("0");
        }
        if($("#TMMT_FWBXGXMT_TEXT").is(":checked")){
            $("#TMMT_FWBXGXMT").val("1");
        }else{
            $("#TMMT_FWBXGXMT").val("0");
        }
        //可选功能
        if($("#OPT_XFLD_TEXT").is(":checked")){
            $("#OPT_XFLD").val("1");
        }else{
            $("#OPT_XFLD").val("0");
        }
        if($("#OPT_SJCZ_TEXT").is(":checked")){
            $("#OPT_SJCZ").val("1");
        }else{
            $("#OPT_SJCZ").val("0");
        }
        if($("#OPT_XFYYX_TEXT").is(":checked")){
            $("#OPT_XFYYX").val("1");
        }else{
            $("#OPT_XFYYX").val("0");
        }
        if($("#OPT_SZTJMSJ_TEXT").is(":checked")){
            $("#OPT_SZTJMSJ").val("1");
        }else{
            $("#OPT_SZTJMSJ").val("0");
        }
        if($("#OPT_JXDZZ_TEXT").is(":checked")){
            $("#OPT_JXDZZ").val("1");
        }else{
            $("#OPT_JXDZZ").val("0");
        }
        if($("#OPT_BAJK_TEXT").is(":checked")){
            $("#OPT_BAJK").val("1");
        }else{
            $("#OPT_BAJK").val("0");
        }
        if($("#OPT_CCTVDL_TEXT").is(":checked")){
            $("#OPT_CCTVDL").val("1");
        }else{
            $("#OPT_CCTVDL").val("0");
        }
        if($("#OPT_YYBZ_TEXT").is(":checked")){
            $("#OPT_YYBZ").val("1");
        }else{
            $("#OPT_YYBZ").val("0");
        }
        if($("#OPT_TDYJJY_TEXT").is(":checked")){
            $("#OPT_TDYJJY").val("1");
        }else{
            $("#OPT_TDYJJY").val("0");
        }
        if($("#OPT_FDLCZ_TEXT").is(":checked")){
            $("#OPT_FDLCZ").val("1");
        }else{
            $("#OPT_FDLCZ").val("0");
        }
        if($("#OPT_DJGRBH_TEXT").is(":checked")){
            $("#OPT_DJGRBH").val("1");
        }else{
            $("#OPT_DJGRBH").val("0");
        }
        if($("#OPT_XJX_TEXT").is(":checked")){
            $("#OPT_XJX").val("1");
        }else{
            $("#OPT_XJX").val("0");
        }
        if($("#OPT_WLW_TEXT").is(":checked")){
            $("#OPT_WLW").val("1");
        }else{
            $("#OPT_WLW").val("0");
        }
        if($("#OPT_JJBYDYCZZZ_TEXT").is(":checked")){
            $("#OPT_JJBYDYCZZZ").val("1");
        }else{
            $("#OPT_JJBYDYCZZZ").val("0");
        }
        if($("#OPT_TWXFYFW_TEXT").is(":checked")){
            $("#OPT_TWXFYFW").val("1");
        }else{
            $("#OPT_TWXFYFW").val("0");
        }
        if($("#OPT_GTJX_TEXT").is(":checked")){
            $("#OPT_GTJX").val("1");
        }else{
            $("#OPT_GTJX").val("0");
        }
        
        
        if($("#CGFB_JXHL_TEXT").is(":checked")){
            $("#CGFB_JXHL").val("1");
        }else{
            $("#CGFB_JXHL").val("0");
        }
        if($("#CGFB_DZCZ_TEXT").is(":checked")){
            $("#CGFB_DZCZ").val("1");
        }else{
            $("#CGFB_DZCZ_TEXT").val("0");
        }
        if($("#CGFB_KMGD_TEXT").is(":checked")){
            $("#CGFB_KMGD").val("1");
        }else{
            $("#CGFB_KMGD").val("0");
        }
        
        if($("#CGFB_DKIP65_TEXT").is(":checked")){
            $("#CGFB_DKIP65").val("1");
        }else{
            $("#CGFB_DKIP65").val("0");
        }
        if($("#CGFB_PKM_TEXT").is(":checked")){
            $("#CGFB_PKM").val("1");
        }else{
            $("#CGFB_PKM").val("0");
        }
        if($("#CGFB_ZFSZAQB_TEXT").is(":checked")){
            $("#CGFB_ZFSZAQB").val("1");
        }else{
            $("#CGFB_ZFSZAQB").val("0");
        }
        
        /* if($("#CGFB_JXCC_TEXT").is(":checked")){
            $("#CGFB_JXCC").val("1");
        }else{
            $("#CGFB_JXCC").val("0");
        } */
        if($("#CGFB_JJFAJMK_TEXT").is(":checked")){
            $("#CGFB_JJFAJMK").val("1");
        }else{
            $("#CGFB_JJFAJMK").val("0");
        }
        
        if ($("#OPT_ICKZKSB_TEXT").is(":checked")) {
            $("#OPT_ICKZKSB").val("1");
        } else {
            $("#OPT_ICKZKSB").val("0");
        }
        
        return true;
	}
    
    function saveOfAjax() {
    	if(validateIsInput()){
           var index = layer.load(1);
			$.ajax({
			    type: 'POST',
			    url: '<%=basePath%>e_offerdt/${msg}.do',
			    data: $("#feishangForm").dn2_serialize(getSelectDis()),
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
			$('#FEISHANG_MRL_ID').val(data.dtCodId);
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
    	//setTimeout(function(){
			basisDate.fbdj = dj;
			$("#SBJ_TEMP").val(dj*getEleNum());
	        $("#DANJIA").val(dj);
	        setMPrice();
	        //countZhj();
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
                    	var cqsjdj=$("#FEISHANG_MRL_CQSJDJ").val();
                    	//数量
                    	var sl=$("#FEISHANG_MRL_SL").val();
                    	//赋值给设备实际报价
                    	$("#FEISHANG_MRL_SBSJBJ").val(cqsjdj*sl);
                    	
                    	//计算折扣并赋值
                    	var zkl;
                    	var qtfy=$("#FEISHANG_MRL_QTFY").val()*ShuiLv;//其他费用
                    	var yjze=$("#FEISHANG_MRL_YJZE").val()*ShuiLv;//佣金总额
                    	var sjbj=$("#FEISHANG_MRL_SBSJBJ").val();//设备实际报价
                    	var fbj=$("#FEISHANG_MRL_FBJ").val();//非标价
                    	var jj=parseInt_DN($("#SBJ_TEMP").val());//基价
                    	var xxjj=parseInt_DN($("#FEISHANG_MRL_XXJJ").val());//选项加价
                    	var qtfya=getValueToFloat("#XS_QTFY");
                    	var a=sjbj-fbj-qtfy-yjze;
                    	var b=jj+xxjj;
                    	zkl=(a/b).toFixed(3);
                    	$("#FEISHANG_MRL_ZKL").val((zkl*100).toFixed(1));
                    	
                    	//计算佣金比例并赋值
                    	var yjbl;
                    	/* var c=sjbj-fbj-qtfy;
                    	yjbl=(c/b).toFixed(3);
                    	$("#FEISHANG_MRL_YJBL").val((yjbl*100).toFixed(1)); */
                    	yjbl=$("#FEISHANG_MRL_YJZE").val()/(sjbj/ShuiLv);
                    	$("#FEISHANG_MRL_YJBL").val((yjbl*100).toFixed(1));
                    	
                    	
                    	//计算佣金使用折扣率和最高佣金
                    	var yjsyzkl;
                    	var ZGYJ;
                    	var ZGYJA;
                    	// (实际报价-非标费-其他费用*1.16)/(基价+选项)
                    	var c=sjbj-fbj-(qtfya*ShuiLv);
                    	//alert(sjbj+'-'+fbj+'-('+qtfya+'*'+ShuiLv+')'+'/'+b);
                    	yjsyzkl=c/b;
                    	$("#YJSYZKL").val((yjsyzkl*100).toFixed(1));
                    	
                    	var yjsyzkla = $("#YJSYZKL").val()==""?0:parseInt_DN($("#YJSYZKL").val());
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
                    			$("#FEISHANG_MRL_SFCB").val("Y");
                    		}else{$("#FEISHANG_MRL_SFCB").val("N");}
                    	}
                    	else if(66<=zkl*100<=70)
                    	{
                    		var q=(sjbj*0.5)/ShuiLv;
                    		if(yjze>q)
                    		{
                    			$("#FEISHANG_MRL_SFCB").val("Y");
                    		}else{$("#FEISHANG_MRL_SFCB").val("N");}
                    	}
                    	else if(71<=zkl*100<=75)
                    	{
                    		var q=(sjbj*0.6)/ShuiLv;
                    		if(yjze>q)
                    		{
                    			$("#FEISHANG_MRL_SFCB").val("Y");
                    		}else{$("#FEISHANG_MRL_SFCB").val("N");}
                    	}
                    	else if(zkl*100>75)
                    	{
                    		var q=(sjbj*0.6)/ShuiLv;
                    		var w=(jj+xxjj)*0.85;
                    		var e=sjbj-fbj-qtfy;
                    		var r=(q+(e-w)*0.5)/ShuiLv;
                    		if(yjze>r)
                    		{
                    			$("#FEISHANG_MRL_SFCB").val("Y");
                    		}else{$("#FEISHANG_MRL_SFCB").val("N");}
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
    	var sbsjzj_=parseInt_DN($("#FEISHANG_MRL_SBSJBJ").val());//设备实际总价
    	var qtfy_=parseInt_DN($("#FEISHANG_MRL_QTFY").val());//其他费用
    	var azf_=parseInt_DN($("#FEISHANG_MRL_AZJ").val());//安装费
    	var ysf_=parseInt_DN($("#FEISHANG_MRL_YSJ").val());//运输费
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
    	$("#FEISHANG_MRL_TATOL").val(sbsjzj_+qtfy_+azf_+ysf_);
    }
  
  	//验证表单输入数字
  	function checkForm(){
    	var checkCq=parseInt_DN($("#FEISHANG_MRL_CQSJDJ").val());//草签实际单价
    	var checkQtfy=parseInt_DN($("#FEISHANG_MRL_QTFY").val());//其他费用
    	var checkYjze=parseInt_DN($("#FEISHANG_MRL_YJZE").val());//佣金总额

    	if(isNaN(checkCq))
    	{
    		document.getElementById('FEISHANG_MRL_CQSJDJ').value='';
    	}
    	if(isNaN(checkQtfy))
    	{
    		document.getElementById('FEISHANG_MRL_QTFY').value='';
    	}
    	if(isNaN(checkYjze))
    	{
    		document.getElementById('FEISHANG_MRL_YJZE').value='';
    	} 
  	}

</script>
</body>

</html>
