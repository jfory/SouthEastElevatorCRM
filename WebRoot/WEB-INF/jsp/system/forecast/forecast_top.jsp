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

<body class="gray-bg">
<form action="forecast/${msg}.do" name="ForecastForm" id="ForecastForm" method="post">
	<input type="hidden" name="id"  id="id" value="${pd.id }"/>
	<input type="hidden" name="item_id" id="item_id" value="${pd.item_id}"/>
    <div class="wrapper wrapper-content" style="z-index: -1">
        <div class="row">
            <div class="col-sm-12" >
                <div class="ibox float-e-margins">
                    <div class="ibox-content">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="panel panel-primary">
                                    <div class="panel-heading">
                                        项目信息
                                    </div>
                        			<div class="panel-body">
				                    	<div class="form-group form-inline">
		                                	<table class="table table-striped table-bordered table-hover">
				                                <thead>
				                                    <tr>
				                                        <th style="width:5%;"><input type="checkbox" id="zcheckbox" onclick="selectAllBox();"></th>
				                                        <th style="width:5%;">项目编号</th>
				                                        <th style="width:10%;">项目名称</th>
				                                        <th style="width:10%;">是否top10项目</th>
				                                        <th style="width:10%;">是否重点项目</th>
				                                    </tr>
				                                </thead>
			                                	<tbody>
				                                <!-- 开始循环 -->	
												<c:choose>
													<c:when test="${not empty itemList}">
														<c:if test="${QX.cha == 1 }">
															<c:forEach items="${itemList}" var="var" >
																<tr>
																	<td><input type="checkbox" name='ids' id='${var.item_id }' value='${var.item_id }' onclick="getNowMonthCount();"
																	<c:forEach items="${items}" var="item">
																		<c:if test="${var.item_id==item}">
																			checked="checked"
																		</c:if>
																	</c:forEach>
																	></td>
																	<td>${var.item_no}</td>
																	<td>${var.item_name}</td>
																	<td><input type="checkbox" name="isTop" id="${var.item_id}" value="${var.item_id}" onclick="setTop(this);" ${var.is_top=='1'?'checked':''}></td>
																	<td><input type="checkbox" name="isAtn" id="${var.item_id}" value="${var.item_id}" onclick="setAtn(this)" ${var.is_attention=='1'?'checked':''}></td>
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
						<div style="height: 20px;"></div>
						<tr>
						<c:if test="${operateType!='sel'}">
							<td>
								<a class="btn btn-primary" style="width: 150px; height:34px;float:left;"  onclick="javascript:CloseSUWin('setTopForecast');">保存</a>
							</td>					
						</c:if>	
						<td>
							<a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('setTopForecast');">关闭</a>
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
	
	function selectAllBox(){
		var status = document.getElementById('zcheckbox').checked;
		for(var i=0;i < document.getElementsByName('ids').length;i++){
			document.getElementsByName('ids')[i].checked=status;
		}
		getNowMonthCount();
	}

	//计算选中项目电梯总数量
	function getNowMonthCount(){
		var str = '';
		for(var i=0;i < document.getElementsByName('ids').length;i++){
		  if(document.getElementsByName('ids')[i].checked){
		  	if(str=='') str += document.getElementsByName('ids')[i].value;
		  	else str += ',' + document.getElementsByName('ids')[i].value;
		  }
		}
		$("#item_id").val(str);
		$.post("<%=basePath%>forecast/getNowMonthCount.do?ids="+str,
				function(data){
					$("#now_count").val(data);
				}
		);
	}

	//保存
	function save(){
		$("#ForecastForm").submit();
	}

	//标注top10
	function setTop(obj){
		$.post("<%=basePath%>forecast/checkMonthTop",
				function(data){
					if(data.msg=="success"){
						var item_id = $(obj).val();
						var isTop = $(obj).is(':checked')==true?'1':'0';
						$.post("<%=basePath%>item/updateTopStatus?item_id="+item_id+"&is_top="+isTop,
								function(data){
									if(data.msg=="error"){
										/*alert("操作失败!");*/
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
					}else if(data.msg=="exception"){
						/*alert("该月top10项目已满");*/
						swal({
			                title: "操作失败",
			                text: "该月top10项目已满！",
			                type: "error",
			                showCancelButton: false,
			                confirmButtonColor: "#DD6B55",
			                confirmButtonText: "OK",
			                closeOnConfirm: true,
			                timer:1500
			            });
					}else if(data.msg=="error"){
						/*alert("操作失败!");*/
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

	//标注重点
	function setAtn(obj){
		var item_id = $(obj).val();
		var isAtn = $(obj).is(':checked')==true?'1':'0';
		$.post("<%=basePath%>item/updateAtnStatus?item_id="+item_id+"&is_attention="+isAtn,
				function(data){
					if(data.msg=="error"){
						/*alert("操作失败!");*/
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

	
	function CloseSUWin(id) {
		window.parent.$("#" + id).data("kendoWindow").close();
		/* 	window.parent.location.reload(); */
	}
	</script>
</body>

</html>
