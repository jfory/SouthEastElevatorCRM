<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
	<base href="<%=basePath%>">
	<!-- jsp文件头和头部 -->
	<%@ include file="../../system/admin/top.jsp"%> 
 <!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Check Box -->
    <link href="static/js/iCheck/custom.css" rel="stylesheet">
    <!-- Sweet Alert -->
    <link href="static/js/sweetalert/sweetalert.css" rel="stylesheet">
    <title>${pd.SYSNAME}</title>
</head>

<body class="gray-bg" onload="checkOperateType();">
<form action="forecast/${msg}.do" name="ForecastForm" id="ForecastForm" method="post">
	<input type="hidden" name="id"  id="id" value="${pd.id }"/>
	<input type="hidden" name="status" id="status" value="${pd.status}">
	<input type="hidden" name="item_id" id="item_id" value="${pd.item_id}"/>
	<input type="hidden" name="operateType" id="operateType" value="${operateType}"/>
	<input type="hidden" name="more_region" id="more_region" value="${more_region}"/>
    <div class="wrapper wrapper-content" style="z-index: -1">
        <div class="row">
            <div class="col-sm-12" >
                <div class="ibox float-e-margins">
                    <div class="ibox-content">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="panel panel-primary">
                                    <div class="panel-heading">
                                        本月预测
                                    </div>
                        			<div class="panel-body">
				                    	<div class="form-group form-inline">
		                                	<table class="table table-striped table-bordered table-hover">
				                                <thead>
				                                    <tr>
				                                        <th style="width:5%;"><input type="checkbox" id="zcheckbox_now" onclick="selectAllBox('now');"></th>
				                                        <th style="width:5%;">项目编号</th>
				                                        <th style="width:10%;">申请人</th>
				                                        <th style="width:10%;">项目名称</th>
				                                        <th style="width:10%;">项目状态</th>
				                                        <th style="width:10%;">总台量</th>
				                                        <th style="width:10%;">是否跨区</th>
				                                        <th style="width:10%;">所跨区域</th>
				                                        <th style="width:10%;">跨区台量</th>
				                                    </tr>
				                                </thead>
			                                	<tbody>
				                                <!-- 开始循环 -->	
												<c:choose>
													<c:when test="${not empty itemPdList}">
														<c:if test="${QX.cha == 1 }">
															<c:forEach items="${itemPdList}" var="var" >
																<tr>
																	<td><input type="checkbox" name='ids_now' id='${var.item_id }' value='${var.item_id }' onclick="getNowMonthCount('now');"
																	<c:forEach items="${items}" var="item">
																		<c:if test="${var.item_id==item}">
																			checked="checked"
																		</c:if>
																	</c:forEach>
																	></td>
																	<td>${var.item_no}</td>
																	<td>${var.name}</td>
																	<td>${var.item_name}</td>
																	<td>
																		<c:if test="${var.item_status==0}">
																			信息
																		</c:if>
																		<c:if test="${var.item_status==1}">
																			报价
																		</c:if>
																		<c:if test="${var.item_status==2}">
																			投标
																		</c:if>
																		<c:if test="${var.item_status==3}">
																			洽谈
																		</c:if>
																		<c:if test="${var.item_status==4}">
																			合同
																		</c:if>
																		<c:if test="${var.item_status==5}">
																			中标
																		</c:if>
																		<c:if test="${var.item_status==6}">
																			失标
																		</c:if>
																		<c:if test="${var.item_status==7}">
																			取消
																		</c:if>
																		<c:if test="${var.item_status==8}">
																			生效
																		</c:if>
																	</td>
																	<td>${var.count}</td>
																	<td><input type="hidden" name="isCrossRegion" value="${var.is_cross_region}">${var.is_cross_region=='1'?'是':'否'}</td>
																	<td>${var.crossName}</td>
																	<td>${var.cross_region_num}</td>
																</tr>
															</c:forEach>
														</c:if>
													</c:when>
												</c:choose>
		                                		</tbody>
			                            	</table>
	                            		</div>
	                            	</div>
	                            </div>
                            </div>
                        </div>
                        <div class="row">
                			<div class="col-sm-12">
                    			<div class="panel panel-primary">
                                    <div class="panel-heading">
                                        上月预测信息
                                    </div>
                        			<div class="panel-body">
				                        <div class="form-group form-inline">
                        					<table class="table table-striped table-bordered table-hover">
				                                <thead>
				                                    <tr>
				                                        <th style="width:10%;">预测编号</th>
				                                        <th style="width:15%;">上月台量</th>
				                                        <th style="width:10%;display: none;">上月指标</th>
				                                        <th style="width:10%;display: none;">指标(百分比)</th>
				                                    </tr>
				                                </thead>
			                                	<tbody>
			                                		<c:choose>
													<c:when test="${not empty frontForecastList}">
														<c:if test="${QX.cha == 1 }">
															<c:forEach items="${frontForecastList}" var="var" >
																<tr>
																	<td>${var.id}</td>
																	<td>${var.now_count}</td>
																	<td style="display: none;">${var.month_quota}</td>
																	<td style="display: none;">${var.percent}</td>
																</tr>
															</c:forEach>
														</c:if>
													</c:when>
												</c:choose>
			                                	</tbody>
			                            	</table>
				                        </div>
	                                </div>
	                            </div>
	                        </div>
				        </div>
                        <div class="row">
                			<div class="col-sm-12">
                    			<div class="panel panel-primary">
                                    <div class="panel-heading">
                                        本月预测信息
                                    </div>
                        			<div class="panel-body">
				                        <div class="form-group form-inline">
                        					<label style="width:10%;margin-top: 25px;margin-bottom: 10px">本月当前台量:</label>
				                        	<input style="width:28%" type="text" name="now_count" id="now_count"  value="${pd.now_count}"  title="本月当前台量"  placeholder="这里输入本月当前台量" class="form-control">
                        					<!-- <label style="width:10%;margin-top: 25px;margin-bottom: 10px">本月预测台量:</label>
				                        	<input style="width:22%" type="text" name="forecast_now" id="forecast_now"  value="${pd.forecast_now}"  title="本月预测台量"  placeholder="这里输入本月预测台量" class="form-control"> -->
                        					<label style="width:10%;margin-top: 25px;margin-bottom: 10px;display: none;">本月指标:</label>
				                        	<input style="width:22%;display: none;" readonly="readonly"  type="text" name="month_quota" id="month_quota"  value="${pd.month_quota}"  title="本月指标"  placeholder="这里输入本月指标" class="form-control">
                        					<label style="width:10%;margin-top: 25px;margin-bottom: 10px;display: none;">指标(百分比):</label>
				                        	<input style="width:22%;display: none;" readonly="readonly" type="text" name="percent" id="percent"  value="${pd.percent}"  title="指标百分比"  placeholder="这里输入指标百分比" class="form-control">
				                        	<label style="display: none;">%</label>
				                        </div>
				                        <!-- <div class="form-group form-inline">
                        					<label style="width:10%;margin-top: 25px;margin-bottom: 10px">是否top10项目:</label>
                        					<select class="form-control m-b">
                        						<option value="">请选择是否top10</option>
                        						<option value="0">否</option>
                        						<option value="1">是</option>
                        					</select>
                        					<label style="width:10%;margin-top: 25px;margin-bottom: 10px">是否重点项目:</label>
                        					<select class="form-control m-b">
                        						<option value="">请选择是否重点项目</option>
                        						<option value="0">否</option>
                        						<option value="1">是</option>
                        					</select>
				                        </div> -->
	                                </div>
	                            </div>
	                        </div>
				        </div>
				        <div class="row">
                            <div class="col-sm-12">
                                <div class="panel panel-primary">
                                    <div class="panel-heading">
                                        下月预测
                                    </div>
                        			<div class="panel-body">
				                    	<div class="form-group form-inline">
		                                	<table class="table table-striped table-bordered table-hover">
				                                <thead>
				                                    <tr>
				                                        <th style="width:5%;"><input type="checkbox" id="zcheckbox_next" onclick="selectAllBox('next');"></th>
				                                        <th style="width:5%;">项目编号</th>
				                                        <th style="width:10%;">申请人</th>
				                                        <th style="width:10%;">项目名称</th>
				                                        <th style="width:10%;">项目状态</th>
				                                        <th style="width:10%;">总台量</th>
				                                        <th style="width:10%;">是否跨区</th>
				                                        <th style="width:10%;">所跨区域</th>
				                                        <th style="width:10%;">跨区台量</th>
				                                    </tr>
				                                </thead>
			                                	<tbody>
				                                <!-- 开始循环 -->	
												<c:choose>
													<c:when test="${not empty itemPdList}">
														<c:if test="${QX.cha == 1 }">
															<c:forEach items="${itemPdList}" var="var" >
																<tr>
																	<td><input type="checkbox" name='ids_next' id='${var.item_id }' value='${var.item_id }' onclick="getNowMonthCount('next');"></td>
																	<td>${var.item_no}</td>
																	<td>${var.name}</td>
																	<td>${var.item_name}</td>
																	<td>${var.item_status}</td>
																	<td>${var.count}</td>
																	<td>${var.is_cross_region=='1'?'是':'否'}</td>
																	<td>${var.crossName}</td>
																	<td>${var.cross_region_num}</td>
																</tr>
															</c:forEach>
														</c:if>
													</c:when>
												</c:choose>
		                                		</tbody>
			                            	</table>
	                            		</div>
	                            	</div>
	                            </div>
                            </div>
                        </div>
				        <div class="row">
                			<div class="col-sm-12">
                    			<div class="panel panel-primary">
                                    <div class="panel-heading">
                                        下月预测信息
                                    </div>
                        			<div class="panel-body">
				                        <div class="form-group form-inline">
                        					<label style="width:10%;margin-top: 25px;margin-bottom: 10px">下月预测台量:</label>
				                        	<input style="width:22%;" type="text" name="forecast_next" id="forecast_next"  value="${pd.forecast_next}"  title="下月预测台量"  placeholder="这里输入下月预测台量" class="form-control">
				                        	<label style="width:10%;margin-top: 25px;margin-bottom: 10px;display: none;">下月指标:</label>
				                        	<input style="width:22%;display: none;" readonly="readonly"  type="text" name="quota_next" id="quota_next"  value="${pd.quota_next}"  title="本月指标"  placeholder="这里输入本月指标" class="form-control">
                        					<label style="width:10%;margin-top: 25px;margin-bottom: 10px;display: none;">指标(百分比):</label>
				                        	<input style="width:22%;display: none;" readonly="readonly" type="text" name="percent_next" id="percent_next"  value="${pd.percent_next}"  title="指标百分比"  placeholder="这里输入指标百分比" class="form-control">
				                        	<label style="display: none;">%</label>
				                        </div>
	                                </div>
	                            </div>
	                        </div>
				        </div>
						<div style="height: 20px;"></div>
						<tr>
						<c:if test="${operateType!='sel'}">
							<td>
								<a class="btn btn-primary" style="width: 150px; height:34px;float:left;"  onclick="save();">保存</a>
							</td>					
						</c:if>	
						<td>
							<a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('EditForecast');">关闭</a>
						</td>
						</tr>
					</div>
				</div>
			</div>
		</div>   
 	</div>
 </form>
	<!-- 日期控件-->
    <script src="static/js/layer/laydate/laydate.js"></script>
	<!-- iCheck -->
	<script src="static/js/iCheck/icheck.min.js"></script>
	<!-- Sweet alert -->
	<script src="static/js/sweetalert/sweetalert.min.js"></script>
	<script type="text/javascript">
	//日期范围限制
    var start = {
        elem: '#start_time',
        format: 'YYYY/MM/DD hh:mm:ss',
        max: '2099-06-16 23:59:59', //最大日期
        istime:true,
        istoday: false,
        choose: function (datas) {
            end.min = datas; //开始日选好后，重置结束日的最小日期
            end.start = datas //将结束日的初始值设定为开始日
        }
    };
    var end = {
        elem: '#end_time',
        format: 'YYYY/MM/DD hh:mm:ss',
        max: '2099-06-16 23:59:59',
        istime: true,
        istoday: false,
        choose: function (datas) {
            start.max = datas; //结束日选好后，重置开始日的最大日期
        }
    };
    laydate(start);
    laydate(end);
	
	function selectAllBox(flag){
		var boxId = 'zcheckbox_'+flag;
		var id = 'ids_'+flag;
		var status = document.getElementById(boxId).checked;
		for(var i=0;i < document.getElementsByName(id).length;i++){
			document.getElementsByName(id)[i].checked=status;
		}
		getNowMonthCount(flag);
	}

	//计算选中项目电梯总数量
	function getNowMonthCount(flag){
		var quota;
		if(flag=='now'){
			quota = $("#month_quota").val();
		}else if(flag=='next'){
			quota = $("#quota_next").val();
		}
		var boxId = 'zcheckbox_'+flag;
		var id = 'ids_'+flag;
		var str = '';
		for(var i=0;i < document.getElementsByName(id).length;i++){
		  if(document.getElementsByName(id)[i].checked){
		  	if(str=='') str += document.getElementsByName(id)[i].value;
		  	else str += ',' + document.getElementsByName(id)[i].value;
		  }
		}
		if(flag=='now'){
			$("#item_id").val(str);
		}
		$.post("<%=basePath%>forecast/getNowMonthCount.do?ids="+str+"&quota="+quota,
				function(data){
					if(data.msg=="success"){
						if(flag=='now'){
							$("#now_count").val(data.count);
							$("#percent").val(data.percent);
						}else if(flag=='next'){
							$("#forecast_next").val(data.count);
							$("#percent_next").val(data.percent);
						}
					}else if(data.msg=="error"){
						/*alert("操作错误!");*/
						swal({
			                title: "操作失败",
			                text: "操作错误！",
			                type: "error",
			                showCancelButton: false,
			                confirmButtonColor: "#DD6B55",
			                confirmButtonText: "OK",
			                closeOnConfirm: true,
			                timer:1500
			            });
					}
				}
		);
	}


	//保存
	function save(){
		var size = $("input:checkbox[name='ids_now']:checked").length;
		if(size==0){
			$("input:checkbox[name='ids_now']:last").focus();
			$("input:checkbox[name='ids_now']:last").tips({
					side:3,
		            msg:"请选择项目信息",
		            bg:'#AE81FF',
		            time:2
		        });
			return false;
		}
		var nowCount = $("#now_count").val();
		var forecastNow = $("#forecast_now").val();
		if(Number(nowCount)>Number(forecastNow)){
			$("#forecast_now").focus();
			$("#forecast_now").tips({
				side:3,
	            msg:"预测台量需要大于当前台量",
	            bg:'#AE81FF',
	            time:2
	        });
			return false;
		}
		//判断预测信息是否跨区
		$("#more_region").val("0");
		for(var i = 0;i<document.getElementsByName("isCrossRegion").length;i++){
			if(document.getElementsByName("isCrossRegion")[i].value=="1"){
				$("#more_region").val("1");
			}
		}
		$("#ForecastForm").submit();
	}

	//加载页面判断查看/修改
	function checkOperateType(){
		if($("#operateType").val()=="sel"){
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
	}

	
	function CloseSUWin(id) {
		window.parent.$("#" + id).data("kendoWindow").close();
		/* 	window.parent.location.reload(); */
	}
	</script>
</body>

</html>
