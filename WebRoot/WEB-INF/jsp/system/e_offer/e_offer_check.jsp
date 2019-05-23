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
$("input").attr("readonly","readonly");
$("select").attr("disabled","disabled");

initCJFTSF();

});
</script>
</head>
<body class="gray-bg">
    <div id="ElevatorParam" class="animated fadeIn"></div>
    <div id="EditShops" class="animated fadeIn"></div>
	<form action="e_offer/${msg}.do" name="e_offerForm" id="e_offerForm" method="post">
	    <input type="hidden" name="item_id" id="item_id" value="${pd.item_id}" /> 
	    <input type="hidden" name="offer_no" id="offer_no" value="${pd.offer_no}" /> 
	    <input type="hidden" name="jsonStr" id="jsonStr">
		<div class="wrapper wrapper-content">
			<div class="row">
				<div class="col-sm-12">
					<div class="ibox float-e-margins">
						<div class="ibox-content1">
							<div class="panel panel-primary">
								<!-- 页面内容开始 -->
								<div class="form-group form-inline">
									<label style="margin-top: 15px; margin-left: 20px; width: 8%">项目名称:</label> 
									<label style="width: 22%">
										<a herf="javascript:;"onclick="SeeProject('${pd.item_id}','sel');" 
															style="color:blue;">${pd.item_name}</a>
									</label> 
									
									<label style="margin-top: 15px; margin-left: 20px; width: 8%">报价编号:</label>
									<label style="width: 22%">${pd.offer_no}</label> 
									<label style="width: 8%; margin-left: 15px">版本:  ${pd.offer_version}</label>

									<!-- <button class="btn btn-primary btn-sm" style="width: 9%; margin-left: 20px; height:31px"
									 title="保存" type="button" onclick="save();">保存</button>
									<button class="btn btn-primary btn-sm" style="width: 9%; margin-left: 8px; height:31px"
									 title="提交" type="button">提交</button> -->
									<button class="btn btn-danger" style="width: 9%; margin-left:15%; height:31px" 
									 title="总结" type="button" onclick="ZongJie('${pd.item_id}');">总结</button>
								</div>
								<div class="form-group form-inline">

									<label style="width: 8%; margin-left: 20px">销售类型:</label> 
									<c:if test="${pd.sale_type == 1}">
									  <label style="width: 22%">经销</label>
									</c:if>
									<c:if test="${pd.sale_type == 2}">
									  <label style="width: 22%">直销</label>
									</c:if>
									<c:if test="${pd.sale_type == 3}">
									  <label style="width: 22%">代销</label>
									</c:if>
									
									<label style="width: 8%; margin-left: 20px">最终用户:</label> 
									<label style="width: 21.5%">${pd.customer_name}</label>
									
									<label style="width: 8%; margin-left: 20px">客户名称:</label> 
									<label style="width: 22%">${pd.selorder_org}</label>
								</div>
		
								<div class="form-group form-inline">
									<label style="width: 8%; margin-left: 20px">申请人:</label>
									<label style="width: 22%">${pd.apply_name}</label>
								    <label style="width: 8%; margin-left: 20px">申请时间:</label>
									<label style="width: 22%">${pd.offer_date}</label>
									
								</div>
								
								
								<div class="panel-heading">报价信息</div>
								
								<div class="panel-body">
									<div class="form-group form-inline">
										<div class="table-responsive">
										  
											<!-- ↓↓↓-报价池相关-↓↓↓↓ -->
											<label style="margin-left:10px;">报价池:</label>
											<table class="table table-striped table-bordered table-hover" id="tab1" name="tab1">
												<thead>
													<tr>
														<th><input type="checkbox" name="zcheckbox"
															id="zcheckbox" class="i-checks"></th>
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
																		<td class='center' style="width: 30px;"><label>
																				<input class="i-checks" type='checkbox' name='ids'
																				 /> <span class="lbl"></span>
																		</label></td>
																		<!-- <td style="text-align: center;">${bjc.MODELS_}</td>
																		<td style="text-align: center;">${bjc.SL_}</td>
																		<td style="text-align: center;">${bjc.CZM_}</td>
																		<td style="text-align: center;">${bjc.SBJ_}</td>
																		<td style="text-align: center;">${bjc.ZK_}</td>
																		<td style="text-align: center;">${bjc.ZHSBJ_}</td>
																		<td style="text-align: center;">${bjc.AZF_}</td>
																		<td style="text-align: center;">${bjc.YSF_}</td>
																		<td style="text-align: center;">${bjc.SJBJ_}</td> -->
																		<td style="text-align: center;">
																		<input type="hidden" value="${bjc.BJC_ID}">
																		${bjc.MODELS_NAME}</td>
																		<td style="text-align: center;">${bjc.BJC_SL}</td>
																		<td style="text-align: center;">${bjc.BJC_C}/${bjc.BJC_Z}/${bjc.BJC_M}</td>
																		<td style="text-align: center;">${bjc.BJC_SBJ}</td>
																		<td style="text-align: center;">${bjc.BJC_ZK}</td>
																		<td style="text-align: center;">${bjc.YJZE}</td>
																		<td style="text-align: center;">${bjc.YJBL}</td>
																		<td style="text-align: center;">${bjc.BJC_AZF}</td>
																		<td style="text-align: center;">${bjc.OTHP_TSF}</td>
																		<td style="text-align: center;">${bjc.OTHP_CJF}</td>
																		<td style="text-align: center;">${bjc.BJC_YSF}</td>
																		<td style="text-align: center;">${bjc.BJC_SJBJ}</td>
																		<td style="text-align: center;">
																			<button class="btn  btn-primary btn-sm" title="查看"  type="button" onclick="sel(this,'${bjc.BJC_COD_ID}','${bjc.BJC_MODELS}','${bjc.BJC_ID}');">查看</button>
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
												    <td class='center' style="width: 30px;">
												      <label><input class="i-checks" type='checkbox' name='ids'/>
													  <span class="lbl"></span></label>
													</td>
												    <td style="text-align: center;">总计</td>
												    <td style="text-align: center;">${pd.COUNT_SL}</td>
												    <td style="text-align: center;"></td>
												    <td style="text-align: center;">${pd.COUNT_SJZJ}</td>
												    <td style="text-align: center;">${pd.COUNT_ZK}</td>
												    <td style="text-align: center;">${pd.COUNT_YJ}</td>
												    <td style="text-align: center;">${pd.COUNT_BL}</td>
												    <td style="text-align: center;">${pd.COUNT_AZF}</td>
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
										<input style="width:21%" type="text" id="SWXX_MBQX" name="SWXX_MBQX" value="${(pd.SWXX_MBQX==null||pd.SWXX_MBQX=='')?'1':pd.SWXX_MBQX}" class="form-control" placeholder="请输入免保期限">
									
									</div>

									<%-- <div class="form-group form-inline">
										<label style="width:9%;margin-left:10px">是否发货前付清:</label>
										<select style="width: 21%" class="form-control" id="SWXX_SFFHQFQ" name="SWXX_SFFHQFQ">
											<option value=""  ${pd.SWXX_SFFHQFQ==""?"selected":""}>请选择</option>
											<option value="1" ${pd.SWXX_SFFHQFQ=="1"?"selected":""}>是</option>
											<option value="2" ${pd.SWXX_SFFHQFQ=="2"?"selected":""}>否</option>
										</select>
										<label style="width:9%;margin-left:28px">免保期限（年）:</label>
										<input style="width:21%" type="text" id="SWXX_MBQX" name="SWXX_MBQX" value="${pd.SWXX_MBQX}" class="form-control" placeholder="请输入免保期限">
									    
									   
									</div> --%>
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
													<td><input type="text" id="SWXX_DJ_DAY" name="SWXX_DJ_DAY" value="${pd.SWXX_DJ_DAY}" class="form-control" placeholder="请输入付款天数"></td>
													<td>
														<input type="text" id="SWXX_DJ" name="SWXX_DJ" value="${pd.SWXX_DJ}"
															   class="form-control" placeholder="请输入定金比例">
													</td>
												</tr>
												<tr>
													<td>排产款</td>
													<td><input type="text" id="SWXX_PCK_DAY" name="SWXX_PCK_DAY" value="${pd.SWXX_PCK_DAY}" class="form-control" placeholder="请输入付款天数"></td>
													<td><input type="text" id="SWXX_PCK" name="SWXX_PCK" value="${pd.SWXX_PCK}" class="form-control" placeholder="请输入排产款比例"></td>
												</tr>
												<tr>
													<td>发货款</td>
													<td><input type="text" id="SWXX_FHK_DAY" name="SWXX_FHK_DAY" value="${pd.SWXX_FHK_DAY}" class="form-control" placeholder="请输入付款天数"></td>
													<td><input type="text" id="SWXX_FHK" name="SWXX_FHK" value="${pd.SWXX_FHK}" class="form-control" placeholder="请输入发货款比例"></td>
												</tr>
												<tr>
													<td>货到工地款</td>
													<td><input type="text" id="SWXX_HDGDK_DAY" name="SWXX_HDGDK_DAY" value="${pd.SWXX_HDGDK_DAY}" class="form-control" placeholder="请输入付款天数"></td>
													<td><input type="text" id="SWXX_HDGDK" name="SWXX_HDGDK" value="${pd.SWXX_HDGDK}" class="form-control" placeholder="请输入货到工地款比例"></td>
												</tr>
												<tr>
													<td>验收款</td>
													<td><input type="text" id="SWXX_YSK_DAY" name="SWXX_YSK_DAY" value="${pd.SWXX_YSK_DAY}" class="form-control" placeholder="请输入付款天数"></td>
													<td><input type="text" id="SWXX_YSK" name="SWXX_YSK" value="${pd.SWXX_YSK}" class="form-control" placeholder="请输入验收款比例"></td>
												</tr>
												<tr>
													<td>质保金</td>
													<td><input type="text" id="SWXX_ZBJBL_DAY" name="SWXX_ZBJBL_DAY" value="${pd.SWXX_ZBJBL_DAY}" class="form-control" placeholder="请输入付款天数"></td>
													<td><input type="text" id="SWXX_ZBJBL" name="SWXX_ZBJBL" value="${pd.SWXX_ZBJBL}" class="form-control" placeholder="请输入质保金比例"></td>
												</tr>
												
												<!-- 增加 -->
												<tr>
													<td>信用证</td>
													<td><input type="text" id="SWXX_XYZ_DAY" name="SWXX_XYZ_DAY" value="${pd.SWXX_XYZ_DAY}" class="form-control" placeholder="请输入付款天数"></td>
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
													<td><input type="text" id="SWXX_FKBL_DJ_DAY" name="SWXX_FKBL_DJ_DAY" value="${pd.SWXX_FKBL_DJ_DAY}" class="form-control" placeholder="请输入付款天数"></td>
													<td>
														<input type="text" id="SWXX_FKBL_DJ" name="SWXX_FKBL_DJ" value="${pd.SWXX_FKBL_DJ}"
															   class="form-control" placeholder="请输入定金比例">
													</td>
												</tr>
												<tr>
													<td>发货前</td>
													<td><input type="text" id="SWXX_FKBL_FHQ_DAY" name="SWXX_FKBL_FHQ_DAY" value="${pd.SWXX_FKBL_FHQ_DAY}" class="form-control" placeholder="请输入付款天数"></td>
													<td><input type="text" id="SWXX_FKBL_FHQ" name="SWXX_FKBL_FHQ" value="${pd.SWXX_FKBL_FHQ}" class="form-control" placeholder="请输入发货前比例"></td>
												</tr>
												<tr>
													<td>货到工地</td>
													<td><input type="text" id="SWXX_FKBL_HDGD_DAY" name="SWXX_FKBL_HDGD_DAY" value="${pd.SWXX_FKBL_HDGD_DAY}" class="form-control" placeholder="请输入付款天数"></td>
													<td><input type="text" id="SWXX_FKBL_HDGD" name="SWXX_FKBL_HDGD" value="${pd.SWXX_FKBL_HDGD}" class="form-control" placeholder="请输入货到工地比例"></td>
												</tr>
												<tr>
													<td>验收合格</td>
													<td><input type="text" id="SWXX_FKBL_YSHG_DAY" name="SWXX_FKBL_YSHG_DAY" value="${pd.SWXX_FKBL_YSHG_DAY}" class="form-control" placeholder="请输入付款天数"></td>
													<td><input type="text" id="SWXX_FKBL_YSHG" name="SWXX_FKBL_YSHG" value="${pd.SWXX_FKBL_YSHG}" class="form-control" placeholder="请输入验收合格比例"></td>
												</tr>
												<tr>
													<td>质保金</td>
													<td><input type="text" id="SWXX_FKBL_ZBJBL_DAY" name="SWXX_FKBL_ZBJBL_DAY" value="${pd.SWXX_FKBL_ZBJBL_DAY}" class="form-control" placeholder="请输入付款天数"></td>
													<td><input type="text" id="SWXX_FKBL_ZBJBL" name="SWXX_FKBL_ZBJBL" value="${pd.SWXX_FKBL_ZBJBL}" class="form-control" placeholder="请输入质保金比例"></td>
												</tr>
												</tbody>
											</table>
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
</body>
<script type="text/javascript">
    //关闭当前页面
    function CloseSUWin(id) {
	  window.parent.$("#" + id).data("kendoWindow").close();
    }
  //加入报价池
  function addoffer(obj,modelsId,flag,elevator_id,modelsName,item_id)
  {
	  var YNum=new Number($(obj).parent().parent().find("td").eq("3").text());//已报台数
	  var WNum=new Number($(obj).parent().parent().find("td").eq("4").text());//未报台数 
	  var offer_num=new Number($(obj).parent().parent().find("td").eq("5").find("div").eq("0").text());//报价台数
	  var models_name=modelsName;//型号名称
	  //该型号全部电梯id
	  var elevIds=$(obj).prev().val();
	  var AllElevID=elevIds.split(","); 
	  var elev_ids="";
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
		     var a=WNum-offer_num;
		     $(obj).parent().parent().find("td").eq("4").text(a);
		     $(obj).parent().parent().find("td").eq("3").text(YNum+offer_num);
			 $("#123").append('<tr>'+
						'<td class="center" style="width: 30px;"><label>'+
						'<input class="i-checks" type="checkbox" name="ids"'+
						'value="${i.item_no}" id="${i.item_no}"'+
						'alt="${i.item_no}" /> <span class="lbl"></span>'+
				'</label></td>'+
				'<td style="text-align: center;">'+models_name+'</td>'+
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
				'<td style="text-align: center;">'+
					'<button class="btn  btn-primary btn-sm" title="编辑"'+
					'onclick="edit(this,\''+elevator_id+'\',\''+modelsId+'\',\''+flag+'\',\''+offer_num+'\',\''+elev_ids+'\')" type="button">编辑</button>'+
					'<button class="btn btn-danger btn-sm" title="查看"'+
					'	style="margin-left:5px;" type="button">删除</button>'+
				'</td>'+
			'</tr>');
			 
			 $('#no_data').hide();
		    }
		 }
  }


  //跳转查看
  function sel(obj,cod_id,models_id,bjc_id){
  	var rowIndex = $(obj).parent().parent().index();
  	var url = "<%=basePath%>e_offer/offerView.do?COD_ID="+cod_id+"&rowIndex="+rowIndex+"&MODELS_ID="+models_id+"&BJC_ID="+bjc_id+"&forwardMsg=view";
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

  
    //录入总结 
    function ZongJie(item_id)
    {
    	$("#EditShops").kendoWindow({
            width: "800px",
            height: "430px",
            title: "总结",
            actions: ["Close"],
            content: '<%=basePath%>e_offer/ZongJie.do?item_id='+item_id,
            modal: true,
            visible: false,
            resizable: true
        }).data("kendoWindow").center().open();
    }

  //编辑
  function edit(obj,elevator_id,modelsId,flag,offer_num,elev_ids)
  {
  	var rowIndex = $(obj).parent().parent().index();
  	var url;
	if(elevator_id=='1')
	{
		  
	}
	else if(elevator_id=='2')
	{
		 
	}
	else if(elevator_id=='3')
	{
		 
	}
	else if(elevator_id=='4')
	{
		 url = "<%=basePath%>e_offer/escalatorParam.do?elevator_id="+elevator_id+"&modelsId="+modelsId+"&flag="+flag+"&offer_num="+offer_num+"&rowIndex="+rowIndex+"&elev_ids="+elev_ids;
	}
	else
	{
	  alert("电梯梯种错误！");
	}
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
  
  //查看项目报备信息
  function SeeProject(id,operateType){
		$("#EditShops").kendoWindow({
	        width: "1000px",
	        height: "800px",
	        title: "编辑项目信息",
	        actions: ["Close"],
	        content: '<%=basePath%>item/goEditItem.do?item_id='+id+'&operateType='+operateType,
	        modal : true,
			visible : false,
			resizable : true
	    }).data("kendoWindow").maximize().open();
	}
	
  /**
  * 计算总的厂检费和调试费
  */
	function initCJFTSF() {
		if($('#123 tr').length > 0){
			var zcjf = 0;
			var ztsf = 0;
			$('#123 tr').each(function(i,v) {
				var tsf = parseInt($(this).children("td").eq(9).text());
				if(isNaN(tsf)){
					tsf = 0;
				}
				var cjf = parseInt($(this).children("td").eq(10).text());
				if(isNaN(cjf)){
					cjf = 0;
				}
				ztsf += tsf;
				zcjf += cjf;
			});
			
			$('#hztr').children("td").eq(9).html(ztsf);
			$('#hztr').children("td").eq(10).html(zcjf);
		} else {
			$('#hztr').children("td").eq(9).html(0);
			$('#hztr').children("td").eq(10).html(0);
		}
	}

</script>
</html>
