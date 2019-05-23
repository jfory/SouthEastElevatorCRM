<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>

<head>

<base href="<%=basePath%>">


<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- 图片插件 -->
<link href="static/js/fancybox/jquery.fancybox.css" rel="stylesheet">
<!-- Check Box -->
<link href="static/js/iCheck/custom.css" rel="stylesheet">
<!-- Sweet Alert -->
<link href="static/js/sweetalert/sweetalert.css" rel="stylesheet">

<title>${pd.SYSNAME}</title>
<!-- jsp文件头和头部 -->
<%@ include file="../../system/admin/top.jsp"%>
<!-- Fancy box -->
<script src="static/js/fancybox/jquery.fancybox.js"></script>

<link href="static/js/fancybox/jquery.fancybox.css" rel="stylesheet">
<link type="text/css" rel="stylesheet"
	href="plugins/zTree/3.5.24/css/zTreeStyle/zTreeStyle.css" />
<script type="text/javascript"
	src="plugins/zTree/3.5.24/js/jquery.ztree.core.js"></script>
<script type="text/javascript"
	src="plugins/zTree/3.5.24/js/jquery.ztree.excheck.js"></script>
<script type="text/javascript"
	src="plugins/zTree/3.5.24/js/jquery.ztree.exedit.js"></script>

<!-- 日期控件-->
<script src="static/js/layer/laydate/laydate.js"></script>
<script type="text/javascript">
$(document).ready(function () {
/* 图片 */
$('.fancybox').fancybox({
   openEffect: 'none',
   closeEffect: 'none'
});
initCJFTSF();
})
</script>
</head>
<body class="gray-bg">
    <div id="ElevatorParam" class="animated fadeIn"></div>
    <div id="SetElevNo" class="animated fadeIn"></div>
    <div id="EditShops" class="animated fadeIn"></div>
    <div id="GoupdateOfferEleNum" class="animated fadeIn"></div>
    
	<form action="e_offer/${msg}.do" name="e_offerForm" id="e_offerForm" method="post">
	    <input type="hidden" name="type" id="type" value="" />
	    <input type="hidden" name="item_id" id="item_id" value="${pd.item_id}" />
	    <input type="hidden" name="offer_no" id="offer_no" value="${pd.offer_no}" /> 
	    <input type="hidden" name="total" id="total" value="${pd.total}" /> 
	    <input type="hidden" name="offer_id" id="offer_id" value="${pd.offer_id}" /> 
	    <input type="hidden" name="jsonStr" id="jsonStr">
	    <input type="hidden" name="instance_status" id="instance_status" value="${pd.instance_status}" />
		<input type="hidden" name="instance_id" id="instance_id" value="${pd.instance_id}" >
		<input type="hidden" name="offer_user" id="offer_user" value="${pd.offer_user}">
		<input type="hidden" name="offer_date" id="offer_date" value="${pd.offer_date}">
		<input type="hidden" name="KEY" id="KEY" value="${pd.OFFER_KEY}">
		<input type="hidden" name="order_org" id="order_org" value="${pd.order_org}">
		<!-- 报价池汇总相关 -->
		<input type="hidden" name="COUNT_SL" id="COUNT_SL" value="${pd.COUNT_SL}">
	    <input type="hidden" name="COUNT_SJZJ" id="COUNT_SJZJ" value="${pd.COUNT_SJZJ}">
	    <input type="hidden" name="COUNT_ZK" id="COUNT_ZK" value="${pd.COUNT_ZK}">
	    <input type="hidden" name="COUNT_YJ" id="COUNT_YJ" value="${pd.COUNT_YJ}">
	    <input type="hidden" name="COUNT_BL" id="COUNT_BL" value="${pd.COUNT_BL}">
	    <input type="hidden" name="COUNT_AZF" id="COUNT_AZF" value="${pd.COUNT_AZF}">
	    <input type="hidden" name="COUNT_YSF" id="COUNT_YSF" value="${pd.COUNT_YSF}">
	    <input type="hidden" name="COUNT_TATOL" id="COUNT_TATOL" value="${pd.COUNT_TATOL}">
		<div class="" style="margin-top: -20px;">
			<div class="row">
				<div class="col-sm-12">
					<div class="">
						<div class="ibox-content1">
							<div class="panel panel-primary">
								<!-- 页面内容开始 -->
								<div class="form-group form-inline">
									<label style="margin-top: 15px; margin-left: 20px; width: 8%">报价编号:</label>
									<label style="width: 22%">${pd.offer_no}</label> 
									<label style="width: 30%; margin-left: 15px">版本:  ${pd.offer_version}</label>
									
									<button class="btn btn-primary btn-sm" style="width: 9%; margin-left: 20px; height:31px"
									 title="保存" type="button" onclick="save('BC');">保存</button>
									<button class="btn btn-sm btn-info btn-sm" style="width: 9%; margin-left: 8px; height:31px"
									 title="提交" type="button" onclick="save('TJ');">提交</button>
									<button class="btn btn-danger" style="width: 9%; margin-left:8px; height:31px"
									 title="总结" type="button" onclick="ZongJie('${pd.item_id}','${pd.offer_no}');">总结</button>
								</div>
								<div class="form-group form-inline">
									<label style="margin-left: 20px; width: 8%">项目名称:</label> 
									<label style="width: 22%">${pd.item_name}</label> 
										
									<label style="width: 8%; margin-left: 15px">销售类型:</label> 
									<c:if test="${pd.sale_type == 1}">
									  <label style="width: 22%">经销</label>
									</c:if>
									<c:if test="${pd.sale_type == 2}">
									  <label style="width: 22%">直销</label>
									</c:if>
									<c:if test="${pd.sale_type == 3}">
									  <label style="width: 22%">代销</label>
									</c:if>
									<c:if test="${msg =='edit'}">
										<label style="width: 8%; margin-left: 20px">最终用户:</label>
										<label style="width: 22%">${pd.customer_name}</label>
									</c:if>
								</div>
								<c:if test="${msg =='edit'}">
									<div class="form-group form-inline">
										<label style="width: 8%; margin-left: 20px">申请人:</label>
										<label style="width: 21.5%">${pd.apply_name}</label>
									    <label style="width: 8%; margin-left: 20px">申请时间:</label>
										<label style="width: 22%">${pd.offer_date}</label>
										<label style="width: 8%; margin-left: 20px">客户名称:</label>
										<label style="width: 22%">${pd.selorder_org}</label>
									</div>
								</c:if>
								<!-- 新建 -->
								<c:if test="${msg !='edit'}">
									<div class="form-group form-inline">
										<label style="width: 8%; margin-left: 20px">最终用户:</label>
										<label style="width: 21.5%">${pd.customer_name}</label>
										<label style="width: 8%; margin-left: 20px">客户名称:</label>
										<label style="width: 22%">${pd.selorder_org}</label>
									</div>
								</c:if>	
								<!-- <div class="panel-heading">內容补充</div>
								<div class="panel-body">

								</div> -->
								<div class="panel-heading">
								报价信息
								</div>
								<div class="panel-body">
									<div class="form-group form-inline">
										<div class="table-responsive">
										  <label style="margin-left:10px;">项目电梯信息:</label>
											<table class="table table-striped table-bordered table-hover" id="tab">
												<thead>
													<tr>
														<!-- <th><input type="checkbox" name="zcheckbox"
															id="zcheckbox" class="i-checks"></th> -->
														<th style="text-align: center;">电梯规格</th>
														<th style="text-align: center;">项目台数</th>
														<th style="text-align: center;">已报台数</th>
														<th style="text-align: center;">未报台数</th>
														<th style="text-align: center;">报价台数</th>
														<th style="text-align: center;width: 20%">操作</th>
													</tr>
												</thead>
												<tbody>
													<!-- 开始循环 -->
													<c:choose>
														<c:when test="${not empty elevatorList}">
															<c:if test="${QX.cha == 1 }">
																<c:forEach items="${elevatorList}" var="ele" varStatus="vs">
																	<tr>
																		<!-- <td class='center' style="width: 30px;"><label>
																				<input class="i-checks" type='checkbox' name='ids'
																				value="${ele.item_no}" id="${ele.item_no}"
																				alt="${ele.item_no}" /> <span class="lbl"></span>
																		</label></td> -->
																		<td style="text-align: center;">${ele.models_name}</td>
																		<td style="text-align: center;">${ele.modelsNum}</td>
																		<td style="text-align: center;">${ele.YNum}</td>
																		<td style="text-align: center;">${ele.WNum}</td>
																		<td style="text-align: center;">
																		  <div contentEditable="true"></div>
																		  <!-- <input type="text" name="houses_faxes" id="houses_faxes"> -->
																		</td>
																		<td style="text-align: center;width: 15%">
																		    <input type="hidden" value="${ele.elevID}"/>
																			<button class="btn  btn-primary btn-sm" title="加入报价池"
																				type="button" onclick="addoffer(this,'${ele.models_id}','${ele.flag}','${ele.elevator_id}','${ele.models_name}','${ele.item_id}')">加入报价池</button>
																				&nbsp;
																			<c:if test="${msg !='saveS'}">
																				<button class="btn btn-warning btn-sm" title="修改台数"
																					type="button" onclick="GoupdateOfferEleNum(this,'${ele.models_id}','${ele.flag}','${ele.elevator_id}','${ele.models_name}','${ele.item_id}','${pd.offer_version}','${ele.modelsNum}')">修改台数</button>
																			</c:if>
																			<c:if test="${msg =='saveS'}">
																				<button class="btn btn-warning btn-sm" title="请保存报价后再修改" disabled="disabled" 
																					type="button" onclick="GoupdateOfferEleNum(this,'${ele.models_id}','${ele.flag}','${ele.elevator_id}','${ele.models_name}','${ele.item_id}','${pd.offer_version}','${ele.modelsNum}')">修改台数</button>
																			</c:if>
																		</td>
																	</tr>

																</c:forEach>
															</c:if>
														</c:when>
														<c:otherwise>
															<tr class="main_info">
																<!-- 加入报价池 -->
																<td colspan="100" class="center">没有相关数据</td>
															</tr>
														</c:otherwise>
													</c:choose>
												</tbody>
											</table>
											<!-- ↓↓↓-报价池相关-↓↓↓↓ -->
											<label style="margin-left:10px;">报价池:</label>
											<table class="table table-striped table-bordered table-hover" id="tab1" name="tab1">
												<thead>
													<tr>
														<!-- <th><input type="checkbox" name="zcheckbox"
															id="zcheckbox" class="i-checks"></th> -->
														<th style="text-align: center;">产品名称</th>
														<th style="text-align: center;">数量</th>
														<th style="text-align: center;">层/站/门</th>
														<th style="text-align: center;">设备实际总价</th>
														<th style="text-align: center;">折扣</th>
														<th style="text-align: center;">佣金总额</th>
														<th style="text-align: center;">佣金比例</th>
														<th style="text-align: center;">安装费</th>
														<th style="text-align: center;">调式费</th>
														<th style="text-align: center;">厂检费</th>
														<th style="text-align: center;">运输费</th>
														<th style="text-align: center;">总报价</th>
														<th style="text-align: center;">操作</th>
													</tr>
												</thead>
												<tbody id="123">
													<!-- 开始循环 -->
													<c:choose>
														<c:when test="${not empty bjcList}">
															<c:if test="${QX.cha == 1 }">
																<c:forEach items="${bjcList}" var="bjc" varStatus="vs">
																	<tr>
																		<td style="text-align: center;"><input type="hidden" value="${bjc.BJC_ID}">
																		${bjc.MODELS_NAME}</td>
																		<td style="text-align: center;">${bjc.BJC_SL}</td>
																		<td style="text-align: center;">${bjc.BJC_C}/${bjc.BJC_Z}/${bjc.BJC_M}</td>
																		<td style="text-align: center;">${bjc.BJC_SBJ}</td>
																		<td style="text-align: center;">${bjc.BJC_ZK}</td>
																		<td style="text-align: center;">${bjc.YJZE}</td>
																		<td style="text-align: center;">${bjc.YJBL}</td>
																		<td style="text-align: center;">${bjc.ELE_AZF}</td>
																		<td style="text-align: center;">${bjc.OTHP_TSF}</td>
																		<td style="text-align: center;">${bjc.OTHP_CJF}</td>
																		<td style="text-align: center;">${bjc.BJC_YSF}</td>
																		<td style="text-align: center;">${bjc.BJC_SJBJ}</td>
																		<td style="text-align: center;">
																			<button class="btn  btn-primary btn-sm" title="编辑"
																				onclick="toEdit(this,'${bjc.BJC_COD_ID}','${bjc.BJC_MODELS}','${bjc.BJC_ID}')" type="button">编辑</button>
																			<button class="btn btn-danger btn-sm" title="删除" style="margin-left:5px;" type="button"
																			onclick="deleteRow(this,'${bjc.BJC_ELEV}')">删除</button>
																			<button class="btn btn-info btn-sm" title="梯号设置" style="margin-left:5px;" type="button"
																					onclick="setENoRow(this,'${bjc.BJC_ELEV}','${bjc.BJC_ID}')">梯号设置</button>
																		</td>
																	</tr>
																</c:forEach>
															</c:if>
														</c:when>
														<c:otherwise>
															<tr id="no_data" class="main_info">
																<td colspan="100" class="center">没有相关数据</td>
															</tr>
														</c:otherwise>
													</c:choose>
												</tbody>
												  <tr id="hztr">
												    <td style="text-align: center;">总计</td>
												    <td style="text-align: center;">${pd.COUNT_SL}</td>
												    <td style="text-align: center;"></td>
												    <td style="text-align: center;">${pd.COUNT_SJZJ}</td>
												    <td style="text-align: center;">${pd.COUNT_ZK}</td>
												    <td style="text-align: center;">${pd.COUNT_YJ}</td>
												    <td style="text-align: center;">${pd.COUNT_BL}</td>
												    <td style="text-align: center;">
												    	<input type="hidden" name="TB_COUNT_AZF" value="${pd.COUNT_AZF}" />
												    	<span class="tb_dt_azf"></span>
												    </td>
												    <td style="text-align: center;"></td>
												    <td style="text-align: center;"></td>
												    <td style="text-align: center;">${pd.COUNT_YSF}</td>
												    <td style="text-align: center;">${pd.COUNT_TATOL}</td>
												    <td style="text-align: center;"></td>
												  </tr>
												
											</table>
											
											<label style="width:9%;margin-left:10px"><font color="red">*</font>是否发货前付清:</label>
										<select style="width: 21%" class="form-control" id="SWXX_SFFHQFQ" name="SWXX_SFFHQFQ" onchange="yongjinshifouchaobiao();">
											<option value=""  ${pd.SWXX_SFFHQFQ==""?"selected":""}>请选择</option>
											<option value="1" ${pd.SWXX_SFFHQFQ=="1"?"selected":""}>是</option>
											<option value="2" ${pd.SWXX_SFFHQFQ=="2"?"selected":""}>否</option>
										</select>
											
											<label style="width:9%;margin-left:28px">佣金是否超标 :
										</label>
										<input style="width:15%" type="text" id="YJSFCB" name="YJSFCB" value="${pd.YJSFCB}"  class="form-control" readonly="readonly">
										</div>
									</div>
								</div>
								
								<div class="panel-heading">商务信息</div>
								<div class="panel-body">
								    <label style="margin-left:10px">保函类别</label></br>
								     <div class="form-group form-inline">
								        <label style="width:9%;margin-left:10px">投标保函:</label> 
								        <input style="width:10%" type="text" id="SWXX_TBBH_BL" name="SWXX_TBBH_BL" value="${pd.SWXX_TBBH_BL}" class="form-control" placeholder="比例">
								        <input style="width:10%;margin-left:8px" type="text" id="SWXX_TBBH_SX" name="SWXX_TBBH_SX" value="${pd.SWXX_TBBH_SX}" class="form-control" placeholder="时效">
								        
								        <label style="width:9%;margin-left:28px">预付款保函:</label> 
								        <input style="width:10%" type="text" id="SWXX_YFKBH_BL" name="SWXX_YFKBH_BL" value="${pd.SWXX_YFKBH_BL}" class="form-control"placeholder="比例">
								        <input style="width:10%;margin-left:8px" type="text" id="SWXX_YFKBH_SX" name="SWXX_YFKBH_SX" value="${pd.SWXX_YFKBH_SX}" class="form-control" placeholder="时效">
								    </div>
								    <div class="form-group form-inline">
								        <label style="width:9%;margin-left:10px">履约保函:</label> 
								        <input style="width:10%" type="text" id="SWXX_LYBH_BL" name="SWXX_LYBH_BL" value="${pd.SWXX_LYBH_BL}" class="form-control"placeholder="比例">
								        <input style="width:10%;margin-left:8px" type="text" id="SWXX_LYBH_SX" name="SWXX_LYBH_SX" value="${pd.SWXX_LYBH_SX}" class="form-control" placeholder="时效">
								        
								        <label style="width:9%;margin-left:28px">质量保函:</label> 
								        <input style="width:10%" type="text" id="SWXX_ZLBH_BL" name="SWXX_ZLBH_BL" value="${pd.SWXX_ZLBH_BL}" class="form-control"placeholder="比例">
								        <input style="width:10%;margin-left:8px" type="text" id="SWXX_ZLBH_SX" name="SWXX_ZLBH_SX" value="${pd.SWXX_ZLBH_SX}" class="form-control" placeholder="时效">
								        
								        <label style="width:9%;margin-left:28px">免保期限（年）:</label>
										<input style="width:21%" type="text" id="SWXX_MBQX" name="SWXX_MBQX" value="${pd.SWXX_MBQX}" class="form-control" placeholder="请输入免保期限">
								    </div>

									<div class="form-group form-inline">
										<%--<label style="width:9%;margin-left:10px">是否发货前付清:</label>
										<select style="width: 21%" class="form-control" id="SWXX_SFFHQFQ" name="SWXX_SFFHQFQ" onchange="yongjinshifouchaobiao();">
											<option value=""  ${pd.SWXX_SFFHQFQ==""?"selected":""}>请选择</option>
											<option value="1" ${pd.SWXX_SFFHQFQ=="1"?"selected":""}>是</option>
											<option value="2" ${pd.SWXX_SFFHQFQ=="2"?"selected":""}>否</option>
										</select>
										 <label style="width:9%;margin-left:28px">免保期限（年）:</label>
										<input style="width:21%" type="text" id="SWXX_MBQX" name="SWXX_MBQX" value="${pd.SWXX_MBQX}" class="form-control" placeholder="请输入免保期限"> --%>
										
										
									</div>
									<div class="row">
										<div class="col-sm-6">
											<table class="table table-striped table-bordered table-hover">
												<thead>
												<tr><th colspan="3" style="text-align: center">设备付款比例</th></tr>
												<tr>
													<th>款项</th>
													<th>付款天数</th>
													<th>比例</th>
												</tr>
												</thead>
												<tbody>
												<tr>
													<td>定金</td>
													<td><input type="text" id="SWXX_DJ_DAY" name="SWXX_DJ_DAY" value="${pd.SWXX_DJ_DAY}" onkeyup="this.value=this.value.replace(/\D/g,'')" class="form-control" placeholder="请输入付款天数"></td>
													<td>
														<input type="text" id="SWXX_DJ" name="SWXX_DJ" value="${pd.SWXX_DJ}"
															   class="form-control" placeholder="请输入定金比例" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')">
													</td>
												</tr>
												<tr>
													<td>排产款</td>
													<td><input type="text" id="SWXX_PCK_DAY" name="SWXX_PCK_DAY" value="${pd.SWXX_PCK_DAY}" onkeyup="this.value=this.value.replace(/\D/g,'')" class="form-control" placeholder="请输入付款天数"></td>
													<td><input type="text" id="SWXX_PCK" name="SWXX_PCK" value="${pd.SWXX_PCK}" class="form-control" placeholder="请输入排产款比例" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"></td>
												</tr>
												<tr>
													<td>发货款</td>
													<td><input type="text" id="SWXX_FHK_DAY" name="SWXX_FHK_DAY" value="${pd.SWXX_FHK_DAY}" onkeyup="this.value=this.value.replace(/\D/g,'')" class="form-control" placeholder="请输入付款天数"></td>
													<td><input type="text" id="SWXX_FHK" name="SWXX_FHK" value="${pd.SWXX_FHK}" class="form-control" placeholder="请输入发货款比例" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"></td>
												</tr>
												<tr>
													<td>货到工地款</td>
													<td><input type="text" id="SWXX_HDGDK_DAY" name="SWXX_HDGDK_DAY" value="${pd.SWXX_HDGDK_DAY}" class="form-control" onkeyup="this.value=this.value.replace(/\D/g,'')" placeholder="请输入付款天数"></td>
													<td><input type="text" id="SWXX_HDGDK" name="SWXX_HDGDK" value="${pd.SWXX_HDGDK}" class="form-control" placeholder="请输入货到工地款比例" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"></td>
												</tr>
												<tr>
													<td>验收款</td>
													<td><input type="text" id="SWXX_YSK_DAY" name="SWXX_YSK_DAY" value="${pd.SWXX_YSK_DAY}" class="form-control" onkeyup="this.value=this.value.replace(/\D/g,'')" placeholder="请输入付款天数"></td>
													<td><input type="text" id="SWXX_YSK" name="SWXX_YSK" value="${pd.SWXX_YSK}" class="form-control" placeholder="请输入验收款比例" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"></td>
												</tr>
												<tr>
													<td>质保金</td>
													<td><input type="text" id="SWXX_ZBJBL_DAY" name="SWXX_ZBJBL_DAY" value="${pd.SWXX_ZBJBL_DAY}" class="form-control" onkeyup="this.value=this.value.replace(/\D/g,'')" placeholder="请输入付款天数"></td>
													<td><input type="text" id="SWXX_ZBJBL" name="SWXX_ZBJBL" value="${pd.SWXX_ZBJBL}" class="form-control" placeholder="请输入质保金比例" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"></td>
												</tr>
												
												<!-- 增加 -->
												<tr>
													<td>信用证</td>
													<td><input type="text" id="SWXX_XYZ_DAY" name="SWXX_XYZ_DAY" value="${pd.SWXX_XYZ_DAY}" class="form-control" onkeyup="this.value=this.value.replace(/\D/g,'')" placeholder="请输入付款天数"></td>
													<td><input type="text" id="SWXX_XYZ" name="SWXX_XYZ" value="${pd.SWXX_XYZ}" class="form-control" placeholder="请输入信用证比例" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"></td>
												</tr>

												</tbody>
											</table>
										</div>

										<div class="col-sm-6">
											<table class="table table-striped table-bordered table-hover">
												<thead>
												<tr><th colspan="3" style="text-align: center">安装付款比例</th></tr>
												<tr>
													<th>款项</th>
													<th>付款天数</th>
													<th>比例</th>
												</tr>
												</thead>
												<tbody>
												<tr>
													<td>定金</td>
													<td><input type="text" id="SWXX_FKBL_DJ_DAY" name="SWXX_FKBL_DJ_DAY" value="${pd.SWXX_FKBL_DJ_DAY}" class="form-control" onkeyup="this.value=this.value.replace(/\D/g,'')" placeholder="请输入付款天数"></td>
													<td>
														<input type="text" id="SWXX_FKBL_DJ" name="SWXX_FKBL_DJ" value="${pd.SWXX_FKBL_DJ}"
															   class="form-control" placeholder="请输入定金比例" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"> 
													</td>
												</tr>
												<tr>
													<td>发货款</td>
													<td><input type="text" id="SWXX_FKBL_FHQ_DAY" name="SWXX_FKBL_FHQ_DAY" value="${pd.SWXX_FKBL_FHQ_DAY}" class="form-control" onkeyup="this.value=this.value.replace(/\D/g,'')" placeholder="请输入付款天数"></td>
													<td><input type="text" id="SWXX_FKBL_FHQ" name="SWXX_FKBL_FHQ" value="${pd.SWXX_FKBL_FHQ}" class="form-control" placeholder="请输入发货前比例" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"></td>
												</tr>
												<tr>
													<td>安装开工款</td>
													<td><input type="text" id="SWXX_FKBL_HDGD_DAY" name="SWXX_FKBL_HDGD_DAY" value="${pd.SWXX_FKBL_HDGD_DAY}" class="form-control" onkeyup="this.value=this.value.replace(/\D/g,'')" placeholder="请输入付款天数"></td>
													<td><input type="text" id="SWXX_FKBL_HDGD" name="SWXX_FKBL_HDGD" value="${pd.SWXX_FKBL_HDGD}" class="form-control" placeholder="请输入货到工地比例" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"></td>
												</tr>
												<tr>
													<td>验收款</td>
													<td><input type="text" id="SWXX_FKBL_YSHG_DAY" name="SWXX_FKBL_YSHG_DAY" value="${pd.SWXX_FKBL_YSHG_DAY}" class="form-control" onkeyup="this.value=this.value.replace(/\D/g,'')" placeholder="请输入付款天数"></td>
													<td><input type="text" id="SWXX_FKBL_YSHG" name="SWXX_FKBL_YSHG" value="${pd.SWXX_FKBL_YSHG}" class="form-control" placeholder="请输入验收合格比例" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"></td>
												</tr>
												<tr>
													<td>质保金</td>
													<td><input type="text" id="SWXX_FKBL_ZBJBL_DAY" name="SWXX_FKBL_ZBJBL_DAY" value="${pd.SWXX_FKBL_ZBJBL_DAY}" class="form-control" onkeyup="this.value=this.value.replace(/\D/g,'')" placeholder="请输入付款天数"></td>
													<td><input type="text" id="SWXX_FKBL_ZBJBL" name="SWXX_FKBL_ZBJBL" value="${pd.SWXX_FKBL_ZBJBL}" class="form-control" placeholder="请输入质保金比例" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"></td>
												</tr>
												</tbody>
											</table>
										</div>
									</div>
												
								</div>
								<div class="panel-heading">
										报价批注
								</div>
								<div class="panel-body">
									<textarea style="width:100%" rows="3" cols="1" name="offer_remark" id="offer_remark" placeholder="在此输入批注">${pd.offer_remark}</textarea>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
</body>
<!-- Fancy box -->
<script src="static/js/fancybox/jquery.fancybox.js"></script>
<!-- iCheck -->
<script src="static/js/iCheck/icheck.min.js"></script>
<!-- Sweet alert -->
<script src="static/js/sweetalert/sweetalert.min.js"></script>
<script type="text/javascript">
var tap =0;
/* var sum = {},isNumber=/\d+(\.\d+)?/;
for (var i = 0, rl = tab1.rows.length - 1; i < rl; i++) {
    for (var j = 0, cl = tab1.rows[i].cells.length; j < cl; j++) {
        if (isNumber.test(tab1.rows[i].cells[j].innerHTML)) {
            sum[j] = (sum[j] || 0) + parseFloat(tab1.rows[i].cells[j].innerHTML);
        }
    }
}
var tr = tab1.rows[tab1.rows.length - 1];//最后一行
var all = 0;
for (var attr in sum) { tr.cells[attr].innerHTML = sum[attr]; all += sum[attr] }
tr.cells[1].innerHTML = all; */


    //关闭当前页面
    function CloseSUWin(id) {
// 	alert("${pd.msg}");
	  window.parent.$("#" + id).data("kendoWindow").close();
    }
  //加入报价池
  function addoffer(obj,modelsId,flag,elevator_id,modelsName,item_id)
  {
	  var YNum=new Number($(obj).parent().parent().find("td").eq("2").text());//已报台数
	  var WNum=new Number($(obj).parent().parent().find("td").eq("3").text());//未报台数 
	  var offer_num=new Number($(obj).parent().parent().find("td").eq("4").find("div").eq("0").text());//报价台数
	  var models_name=modelsName;//型号名称
	  //该型号全部电梯id
	  var elevIds=$(obj).prev().val();
	  var AllElevID=elevIds.split(","); 
	  var elev_ids="";


	  if(isNaN(offer_num))
		 {
			 alert("报价台数只能是数字！");
		 }
		 else
		 {
			if(offer_num<=0 || offer_num>WNum)
		    {
			   alert("请填写正确的报价台数！");
		    }
		    else
		    {
                //截取电梯ID
		        for(var i=0;i<AllElevID.length;i++)
                {
                    if(i<offer_num)
                    {
                        elev_ids+=AllElevID[i]+",";
                        AllElevID[i]="";
                    }

                }
                for(var i=0;i<AllElevID.length;i++)
                {
                    if(AllElevID[i]==""||typeof(AllElevID[i]) == "undefined")
                    {
                        AllElevID.splice(i,1);
                        i=i-1;
                    }

                }
                $(obj).prev().val(AllElevID);

		     var a=WNum-offer_num;
		     $(obj).parent().parent().find("td").eq("3").text(a);
		     $(obj).parent().parent().find("td").eq("2").text(YNum+offer_num);
			 $("#123").append('<tr>'+
						/*'<td class="center" style="width: 30px;"><label>'+
						'<input class="i-checks" type="checkbox" name="ids"'+
						'value="{i.item_no}" id="{i.item_no}"'+
						'alt="{i.item_no}" /> <span class="lbl"></span>'+
				'</label></td>'+*/
				'<td style="text-align: center;"><input type="hidden">'+models_name+'</td>'+
				'<td style="text-align: center;">'+offer_num+'</td>'+
				'<td style="text-align: center;"></td>'+
				'<td style="text-align: center;"></td>'+
				'<td style="text-align: center;"></td>'+
				'<td style="text-align: center;"></td>'+
				'<td style="text-align: center;"></td>'+
				'<td style="text-align: center;"></td>'+
				'<td style="text-align: center;"></td>'+
				'<td style="text-align: center;"></td>'+
				'<td style="text-align: center;"></td>'+
				'<td style="text-align: center;"></td>'+
				'<td style="text-align: center;">'+
					'<button class="btn  btn-primary btn-sm" title="编辑"'+
					'onclick="edit(this,\''+elevator_id+'\',\''+modelsId+'\',\''+flag+'\',\''+offer_num+'\',\''+elev_ids+'\',\''+item_id+'\')" type="button">编辑</button>'+
					'<button class="btn btn-danger btn-sm" title="删除"'+
					'	style="margin-left:5px;" onclick="deleteRow(this,\''+elev_ids+'\')" type="button">删除</button>'+
                 '<button class="btn btn-info btn-sm" title="梯号设置" style="margin-left:5px;" type="button"'+
                'onclick="setENoRow(this,\''+elev_ids+'\')">梯号设置</button>'+
				'</td>'+
			'</tr>');
			 
			 $('#no_data').hide();
		    }
		 }
  }
  
  //录入总结
  function ZongJie(item_id,offer_no)
  {
  	$("#EditShops").kendoWindow({
          width: "800px",
          height: "430px",
          title: "总结",
          actions: ["Close"],
          content: '<%=basePath%>e_offer/ZongJie.do?item_id='+item_id+'&offer_no='+offer_no,
          modal: true,
          visible: false,
          resizable: true
      }).data("kendoWindow").center().open();
  }

  //删除
  function deleteRow(obj,elev_ids)
  {
	  var offer_no = "${pd.offer_no}";
	  var bjc_id = $(obj).parent().parent().find("td").eq(0).find("input").eq(0).val();
	  swal({
          title: "您确定要删除该条数据吗？",
          text: "删除后将无法恢复，请谨慎操作！",
          type: "warning",
          showCancelButton: true,
          confirmButtonColor: "#DD6B55",
          confirmButtonText: "删除",
          cancelButtonText: "取消",
          closeOnConfirm: false,
          closeOnCancel: false
      },function (isConfirm) 
        {
          if (isConfirm) 
          {
              //删除时判断是否删除数据库

              
              if(typeof(bjc_id)!="undefined"&&bjc_id!=""){
              	$.post("<%=basePath%>e_offer/deleteBjc?BJC_ID="+bjc_id+"&offer_no="+offer_no,function(result){
              		if(result.msg=="success"){
              		  //移除tr
        		      var tr=obj.parentNode.parentNode;
        		      var tbody=tr.parentNode;
        		      tbody.removeChild(tr);
              		  //删除之后更新未报台数
        		      var modelsName = $(obj).parent().parent().find("td").eq(0).text();
        		      var modelsSl = $(obj).parent().parent().find("td").eq(1).text();
        		      $("#tab tr:not(:first)").each(function(){
        					var mn = $(this).find("td").eq(0).text();
        					if(mn.trim()==modelsName.trim()){
        						//已报台数
        						var yb_sl = $(this).find("td").eq(2).text();
        						//未报台数
        						var wb_sl = $(this).find("td").eq(3).text();
        						$(this).find("td").eq(2).text(parseInt(yb_sl)-parseInt(modelsSl));
        						$(this).find("td").eq(3).text(parseInt(wb_sl)+parseInt(modelsSl));
        						var elevIds = $(this).find("td").eq(5).find("input").eq(0).val();
        						if(elevIds==""){
        							$(this).find("td").eq(5).find("input").eq(0).val(elev_ids.substring(0,elev_ids.length-1));
        						}else{
        							$(this).find("td").eq(5).find("input").eq(0).val(elevIds+","+elev_ids.substring(0,elev_ids.length-1));
        						}
        					}
        				});
        		      
        		      //重新给汇总行赋值
        		      $('#tab1 tr:last').find('td').eq(1).text(result.CountPd.COUNT_SL);
        			  $('#tab1 tr:last').find('td').eq(3).text(result.CountPd.COUNT_SJZJ);
        			  $('#tab1 tr:last').find('td').eq(4).text(result.CountPd.COUNT_ZK);
        			  $('#tab1 tr:last').find('td').eq(5).text(result.CountPd.COUNT_YJ);
        			  $('#tab1 tr:last').find('td').eq(6).text(result.CountPd.COUNT_BL);
        			  $('#tab1 tr:last').find('td').eq(7).find("input[name=TB_COUNT_AZF]").val(result.CountPd.COUNT_AZF);
        			  $('#tab1 tr:last').find('td').eq(10).text(result.CountPd.COUNT_YSF);
        			  $('#tab1 tr:last').find('td').eq(11).text(result.CountPd.COUNT_TATOL);
        			  
        			  initCJFTSF();
        		  	}else{
        		  swal("删除失败", "您的删除操作失败了！", "error");
        		  	}
              	});
              }else{
          		  //移除tr
        	      var tr=obj.parentNode.parentNode;
        	      var tbody=tr.parentNode;
        	      tbody.removeChild(tr);
        	      //删除之后更新未报台数
        	      var modelsName = $(obj).parent().parent().find("td").eq(0).text();
        	      var modelsSl = $(obj).parent().parent().find("td").eq(1).text();
        	      $("#tab tr:not(:first)").each(function(){
        				var mn = $(this).find("td").eq(0).text();
        				if(mn==modelsName){
        					//已报台数
        					var yb_sl = $(this).find("td").eq(2).text();
        					//未报台数
        					var wb_sl = $(this).find("td").eq(3).text();
        					$(this).find("td").eq(2).text(parseInt(yb_sl)-parseInt(modelsSl));
        					$(this).find("td").eq(3).text(parseInt(wb_sl)+parseInt(modelsSl));
        					var elevIds = $(this).find("td").eq(5).find("input").eq(0).val();
        					if(elevIds==""){
        						$(this).find("td").eq(5).find("input").eq(0).val(elev_ids.substring(0,elev_ids.length-1));
        					}else{
        						$(this).find("td").eq(5).find("input").eq(0).val(elevIds+","+elev_ids.substring(0,elev_ids.length-1));
        					}
        				}
        			});
              }
        	  
              swal({   
		        	title: "删除成功！",
		        	text: "您已经成功删除了这条信息。",
		        	type: "success",  
		        	 },function(){    
		        	 });
              
          } else {
              swal("已取消", "您取消了删除操作！", "error");
          }
      });
	  //只剩行首时删除表格
      /*if(tbody.rows.length==1) {
          tbody.parentNode.removeChild(tbody);
      }*/
    
  }
  
  //跳转编辑
  function toEdit(obj,cod_id,models_id,bjc_id){
	var offer_no = "${pd.offer_no}";
	var offer_version = "${pd.offer_version}";
  	var rowIndex = $(obj).parent().parent().index();
  	var url = "<%=basePath%>e_offer/offerView.do?COD_ID="+cod_id+"&rowIndex="+rowIndex+"&MODELS_ID="
  			+models_id+"&BJC_ID="+bjc_id+"&offer_no="+offer_no+"&offer_version="+offer_version;
  	$("#ElevatorParam").kendoWindow({
        width: "1000px",
        height: "600px",
        title: "报价清单",
        actions: ["Close"],
        content: url,
        modal : true,
		visible : false,
		resizable : true
    }).data("kendoWindow").maximize().open();
  }
  
  //编辑报价池
  function edit(obj,elevator_id,modelsId,flag,offer_num,elev_ids,item_id)
  {
	var offer_no = "${pd.offer_no}";
    var bjc_id = $(obj).parent().parent().find("td").eq(0).find("input").eq(0).val();
    //alert(bjc_id);
  	var rowIndex = $(obj).parent().parent().index();
  	
	var offer_version = "${pd.offer_version}";
  	var url = "<%=basePath%>e_offer/offerView.do?OFFER_NUM="+offer_num+"&MODELS_ID="+modelsId+"&ELEV_IDS="+elev_ids+"&rowIndex="+rowIndex+"&ITEM_ID="+item_id+"&offer_version="+offer_version+"&offer_no="+offer_no;
	/*if(elevator_id=='1')
	{
		url = "<!%=basePath%>e_offer/regelevParam.do?FEISHANG_SL="+offer_num+"&MODELS_ID="+modelsId+"&ELEV_IDS="+elev_ids;
	}
	else if(elevator_id=='2')
	{
		url = "<!%=basePath%>e_offer/homeelevParam.do?elevator_id="+elevator_id+"&modelsId="+modelsId+"&flag="+flag+"&offer_num="+offer_num+"&rowIndex="+rowIndex+"&elev_ids="+elev_ids;
	}
	else if(elevator_id=='3')
	{
		 
	}
	else if(elevator_id=='4')
	{
		url = "<!%=basePath%>e_offer/escalatorParam.do?elevator_id="+elevator_id+"&modelsId="+modelsId+"&flag="+flag+"&offer_num="+offer_num+"&rowIndex="+rowIndex+"&elev_ids="+elev_ids;
	}
	else
	{
	  alert("电梯梯种错误！");
	}*/
	$("#ElevatorParam").kendoWindow({
        width: "1000px",
        height: "600px",
        title: "报价清单",
        actions: ["Close"],
        content: url,
        modal : true,
		visible : false,
		resizable : true
    }).data("kendoWindow").maximize().open();
	  
  }
  
//保存信息
	function save(type)
	{
		//alert("1");
// 		tap ++;
	    if(type=='TJ')
	    {
	    	$("#type").val("TJ");
	    }
	    else
	    {
	    	$("#type").val("BC");
	    }
	    
	    if ($("#SWXX_SFFHQFQ").val() == "" ) {
			$("#SWXX_SFFHQFQ").focus();
			$("#SWXX_SFFHQFQ").tips({
				side : 3,
				msg : "请选择是否发货前付清",
				bg : '#AE81FF',
				time : 3
			});
			return false;
		}

		//获取jsonStr数组
		var jsonStr="[";
		$("#tab1 tr:gt(1)").each(function(){
			jsonStr += $(this).find("td").eq("0").find("input").eq("0").val()+",";
		});
		jsonStr = jsonStr.substring(0,jsonStr.length-1)+"]";
		$("#jsonStr").val(jsonStr);
		
		$("#total").val($('#tab1 tr:last').find('td').eq(11).text());
        
        $("#COUNT_SL").val($('#tab1 tr:last').find('td').eq(1).text());
        $("#COUNT_SJZJ").val($('#tab1 tr:last').find('td').eq(3).text());
        $("#COUNT_ZK").val($('#tab1 tr:last').find('td').eq(4).text());
        $("#COUNT_YJ").val($('#tab1 tr:last').find('td').eq(5).text());
        $("#COUNT_BL").val($('#tab1 tr:last').find('td').eq(6).text());
        $("#COUNT_AZF").val($('#tab1 tr:last').find('td').eq(7).find("input[name=TB_COUNT_AZF]").val());
        $("#COUNT_YSF").val($('#tab1 tr:last').find('td').eq(10).text());
        $("#COUNT_TATOL").val($('#tab1 tr:last').find('td').eq(11).text());
        
        /* if (销售类型为 = "直销" or 销售类型 = "代理") 
        	and
        	(设备定金 >= 5% and 设备发货款+定金+排产款 >=70% and 设备质保金 <= 5%)
        	or
        	(设备定金 < 5% and 设备发货款+定金+排产款 <70% and 设备质保金 > 5%)
        	or
        	(安装开工款 >=50% and 安装验收款 >= 50%)
        	or
        	(安装开工款 < 50% and 安装验收款 < 50%)
        	then 允许提交，else：提示：（左图），不允许提交*/
        	
       	/* if 销售类型为 = "经销"
       		and
       		(设备定金 >= 5% and 排产款 >=20% and 发货款 = 100%)
       		or
       		(设备定金 < 5% and 排产款 < 20% and 发货款 < 100%)
       		then 允许提交，else：提示：（左图），不允许提交 */
//        	console.log(type);
        if(type=='TJ'){
        //设备定金
        var SWXX_DJ = $("#SWXX_DJ").val()==""?0:parseInt($("#SWXX_DJ").val());
        //排产款
        var SWXX_PCK = $("#SWXX_PCK").val()==""?0:parseInt($("#SWXX_PCK").val());
        //设备发货款
        var SWXX_FHK = $("#SWXX_FHK").val()==""?0:parseInt($("#SWXX_FHK").val());
        //设备质保金
        var SWXX_ZBJBL = $("#SWXX_ZBJBL").val()==""?0:parseInt($("#SWXX_ZBJBL").val());
        
        
        //安装定金
        var SWXX_FKBL_DJ = $("#SWXX_FKBL_DJ").val()==""?0:parseInt($("#SWXX_FKBL_DJ").val());
        //安装发货款
        var SWXX_FKBL_FHK = $("#SWXX_FKBL_FHQ").val()==""?0:parseInt($("#SWXX_FKBL_FHQ").val());
        //安装开工款
        var SWXX_FKBL_HDGD = $("#SWXX_FKBL_HDGD").val()==""?0:parseInt($("#SWXX_FKBL_HDGD").val());
        //安装验收款
        var SWXX_FKBL_YSHG = $("#SWXX_FKBL_YSHG").val()==""?0:parseInt($("#SWXX_FKBL_YSHG").val());

       
        //'直销，代销'
//         console.log("pd.sale_type="+"${pd.sale_type}");
//         console.log("pd.sale_type="+"${pd.sale_type}");
        if("${pd.sale_type}"=="2"||"${pd.sale_type}"=="3")
		{
			//alert('直销，代销');
// 			console.log("排产款"+SWXX_PCK);
// 			console.log("发货款"+SWXX_FHK);
// 			console.log("定金:"+SWXX_DJ);
// 			console.log("质保金:"+SWXX_ZBJBL);
// 			console.log("安装开工款"+SWXX_FKBL_HDGD);
// 			console.log("安装验收款"+SWXX_FKBL_YSHG);
			if((SWXX_DJ >= 5 && SWXX_FHK+SWXX_DJ+SWXX_PCK >=70 && SWXX_ZBJBL <= 5)||
					 (SWXX_DJ < 5 && (SWXX_FHK+SWXX_DJ+SWXX_PCK < 70) && SWXX_ZBJBL > 5)||
					 ((SWXX_FKBL_DJ+SWXX_FKBL_FHK+SWXX_FKBL_HDGD) >= 50 && SWXX_FKBL_YSHG >= 50)||
					 ((SWXX_FKBL_DJ+SWXX_FKBL_FHK+SWXX_FKBL_HDGD) < 50 && SWXX_FKBL_YSHG < 50) ||
					 (SWXX_DJ+SWXX_PCK==100)  //定金+排产款=100，亦可提交 2018.8.28 ghj
			    ){
						$("#e_offerForm").submit();
						layer.load(1);
			}else{
				swal({
		            title:"提交失败",
		            text:"<table border=1><tr><th width='17%'>客户类型</th><th width='33%'>付款方式</th><th width='17%'>客户类型</th><th width='33%'>付款方式</th></tr>"+
                        "<tr><td rowspan=4>直销、代理类</td><td>定金≥5%<br>发货前款≥70%<br>质保金≤5%</td><td rowspan=4>经销类</td><td rowspan=2>定金≥5%<br>排产款≥20%<br>定金+排产款+发货款=100%</td></tr>"+
                        "<tr><td>定金＜5%<br>发货前款＜70%<br>质保金＞5%</td></tr>"+
                        "<tr><td>安装款开工前≥50%<br>安装款验收后≥50%</td><td rowspan=2>定金≥5%<br>排产款≥20%<br>定金+排产款+发货款=100%</td></tr>"+
                        "<tr><td>安装款开工前＜50%<br>安装款验收后＜50%</td></tr></table>",
		            html:true
		        }) 

			}
		}else{
			var c=SWXX_DJ+SWXX_PCK+SWXX_FHK;
			if((SWXX_DJ >= 5 && SWXX_PCK >=20 && c == 100)||
		       (SWXX_DJ < 5 && SWXX_PCK < 20 && c < 100)||
		       (SWXX_DJ >= 5 && c == 100)|| //去除20排产款条件，18.8.23ghj
			   (SWXX_PCK >= 20 && c == 100)||
		       (SWXX_DJ < 5 && c < 100)){
				//alert("经销，能提交");
				$("#e_offerForm").submit(); 
				layer.load(1);
			}else{
				//alert("经销，不能提交");
				swal({
		            title:"提交失败",
		            text:"<table border=1><tr><th width='17%'>客户类型</th><th width='33%'>付款方式</th><th width='17%'>客户类型</th><th width='33%'>付款方式</th></tr>"+
                        "<tr><td rowspan=4>直销、代理类</td><td>定金≥5%<br>发货前款≥70%<br>质保金≤5%</td><td rowspan=4>经销类</td><td rowspan=2>定金≥5%<br>排产款≥20%<br>定金+排产款+发货款=100%</td></tr>"+
                        "<tr><td>定金＜5%<br>发货前款＜70%<br>质保金＞5%</td></tr>"+
                        "<tr><td>安装款开工前≥50%<br>安装款验收后≥50%</td><td rowspan=2>定金<5%<br>排产款<20%<br>定金+排产款+发货款<100%</td></tr>"+
                        "<tr><td>安装款开工前＜50%<br>安装款验收后＜50%</td></tr></table>",
		            html:true
		        }) 
			}
			
		}
        } else{
        	
        	 $("#e_offerForm").submit();
        	 layer.load(1);
        }
        
       
	}

	function setENoRow(obj,ele_id,bjc_id){
		
		if (typeof(bjc_id) != "undefined") {
			 $("#SetElevNo").kendoWindow({
		            width: "500px",
		            height: "500px",
		            title: "录入梯号",
		            actions: ["Close"],
		            content: "<%=basePath%>e_offer/preSetEleENo.do?detail_ids="+ele_id+"&bjc_id="+bjc_id,
		            modal : true,
		            visible : false,
		            resizable : true
		        }).data("kendoWindow").center().open();
		}else{
			alert("请先编辑保存该报价池");
		}
       
	}
	
	function yongjinshifouchaobiao(){
		var flag = $("#SWXX_SFFHQFQ").val();
		var item_id = $("#item_id").val();
		var offer_version = "${pd.offer_version}";
		var yongjinshifouchaobiao;//佣金是否超标
		if(flag=="1"||flag=="2"){
			
			$.post("<%=basePath%>e_offer/shiFouChaoBiao",
	                {
				        "id":"1",
	                    "flag":flag,
	                    "item_id":item_id,
	                    "offer_version":offer_version
	                },function(result)
	                {
	                    if(result.msg=="success")
	                    {
	                    	 $("#YJSFCB").val(result.pd.shifouchaobiao);
	                    	
	                    }
	                    else if(result.msg=="notbjcItem")
	                    {

	                    	$("#YJSFCB").val(" ");
	                    	$("#SWXX_SFFHQFQ").val("");
	                    	alert("请先进行报价再进行勾选");
	                    }
	                    else
	                    {
	                    	$("#YJSFCB").val(" ");
	                    	alert("存在异常，请联系管理员！");
	                    }
	                    
	                });

		}else{
			$("#YJSFCB").val(" ");
		}
	}
	
	function GoupdateOfferEleNum(obj,modelsId,flag,elevator_id,modelsName,item_id,offer_version,modelsNum){
        var offer_no = $("#offer_no").val();
		$("#GoupdateOfferEleNum").kendoWindow({
            width: "500px",
            height: "250px",
            title: "修改报价电梯数量",
            actions: ["Close"],
            content: "<%=basePath%>e_offer/GoupdateOfferEleNum.do?modelsId="+modelsId+
            		"&flag="+flag+"&elevator_id="+elevator_id+"&modelsName="+modelsName+
            		"&item_id="+item_id+"&offer_version="+offer_version+"&modelsNum="+modelsNum+
            		"&offer_no="+offer_no,
            modal : true,
            visible : false,
            resizable : true
        }).data("kendoWindow").center().open();
	}
			
	/**
  	* 计算总的厂检费和调试费
  	*/
	function initCJFTSF() {
		var ctif = 0;
		if($('#123 tr').length > 0){
			var zcjf = 0;
			var ztsf = 0;
			$('#123 tr').each(function(i,v) {
				var tsf = parseInt($(this).children("td").eq(8).text());
				if(isNaN(tsf)){
					tsf = 0;
				}
				var cjf = parseInt($(this).children("td").eq(9).text());
				if(isNaN(cjf)){
					cjf = 0;
				}
				ztsf += tsf;
				zcjf += cjf;
			});
			$('#hztr').children("td").eq(8).html(ztsf);
			$('#hztr').children("td").eq(9).html(zcjf);

			ctif = ztsf + zcjf;
		} else {
			$('#hztr').children("td").eq(8).html(0);
			$('#hztr').children("td").eq(9).html(0);
		}
		
		var count_azf = $('#hztr').children("td").eq(7);
		var cazf = parseInt(count_azf.find("input[name=TB_COUNT_AZF]").val());
		if(isNaN(cazf)){
			cazf = 0;
		}
		count_azf.find("span.tb_dt_azf").html(cazf-ctif);
	}
	

</script>
</html>
