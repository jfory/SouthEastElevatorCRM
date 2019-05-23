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
    <!-- 图片插件 -->
    <link href="static/js/fancybox/jquery.fancybox.css" rel="stylesheet">
    <!-- Check Box -->
    <link href="static/js/iCheck/custom.css" rel="stylesheet">
    <!-- Sweet Alert -->
	<link href="static/js/sweetalert2/sweetalert2.css" rel="stylesheet">
	<title>${pd.SYSNAME}</title>
</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div id="EditElevatorSpeed" class="animated fadeIn"></div>
        <div id="AddElevatorSpeed" class="animated fadeIn"></div>
		<div id="EditElevatorWeight" class="animated fadeIn"></div>
        <div id="AddElevatorWeight" class="animated fadeIn"></div>
        <div id="EditElevatorStorey" class="animated fadeIn"></div>
        <div id="AddElevatorStorey" class="animated fadeIn"></div>
        <div id="EditElevatorHeight" class="animated fadeIn"></div>
        <div id="AddElevatorHeight" class="animated fadeIn"></div>
	        <div class="row">
				<div class="panel blank-panel">
					<div class="panel-heading">
						<div class="panel-options">
							<ul class="nav nav-tabs">
								<li id="nav-tab-1" >
									<a data-toggle="tab" href="#tab-1" onclick="tabChange(1)">
										<i class="fa fa-hourglass-o"></i>
										电梯速度参数管理
									</a>
								</li>
								<li id="nav-tab-2">
									<a class="count-info-sm" data-toggle="tab" href="#tab-2" onclick="tabChange(2)">
										<i class="fa fa-hourglass-2"></i>
										电梯重量参数管理
										
									</a>
								</li>
								<li id="nav-tab-3">
									<a data-toggle="tab" href="#tab-3" onclick="tabChange(3)">
										<i class="fa fa-hourglass"></i>
										电梯楼层参数管理
									</a>
								</li>
								<li id="nav-tab-4">
									<a data-toggle="tab" href="#tab-4" onclick="tabChange(4)">
										<i class="fa fa-hourglass"></i>
										电梯井道高度参数管理
									</a>
								</li>
							</ul>
						</div>
					</div>
					<div class="panel-body">
						<div class="tab-content">
							<div id="tab-1" class="tab-pane">
								<div class="ibox float-e-margins">
									<div class="ibox-content">
										<div id="top1" name="top1"></div>
										<form role="form" class="form-inline" action="elevatorParameter/elevatorSpeedList.do" method="post" name="elevatorParameterForm1" id="elevatorParameterForm1">
											<div class="form-group ">
	                                			<input type="text" name="elevator_speed_name" value="${elevator_speed_name}" placeholder="这里输入电梯速度参数" class="form-control">
	                            			</div>
	                            			<div class="form-group">
	                                 			<button type="submit" class="btn  btn-primary " style="margin-bottom:0px"><i style="font-size:18px;" class="fa fa-search"></i></button>
	                            			</div>
											<button class="btn  btn-success" title="刷新" type="button" style="float:right" onclick="refreshCurrentTab(1);">刷新</button>

										</form>
										<div class="row">
											</br>
										</div>
										<div class="table-responsive">
											<table class="table table-striped table-bordered table-hover">
												<thead>
												<tr>
													<th style="width:2%;"><input type="checkbox" name="zcheckbox" id="zcheckbox" class="i-checks" ></th>
													<th style="width:5%;">序号</th>
													<th style="width:25%;">电梯速度参数(m/s)</th>
													<th >操作</th>
												</tr>
												</thead>
												<tbody>
												<!-- 开始循环 -->
												<c:choose>
													<c:when test="${not empty elevatorSpeedList}">
														<c:if test="${QX.cha == 1 }">
															<c:forEach items="${elevatorSpeedList}" var="elevatorSpeed" varStatus="vs1">
																<tr>
																	<td><input type="checkbox"  class="i-checks" name='ids' id='ids' value="${elevatorSpeed.elevator_speed_id}"></td>
																	<td class='center' style="width: 30px;">${vs1.index+1}</td>
																	<td>${elevatorSpeed.elevator_speed_name }</td>
																	<td>
																		<button class="btn  btn-primary btn-sm" title="编辑" type="button" onclick="editElevatorSpeed('${elevatorSpeed.elevator_speed_id }');">编辑</button>
																		<button class="btn  btn-danger btn-sm" title="删除" type="button" onclick="delElevatorSpeed('${elevatorSpeed.elevator_speed_id}');">删除</button>
																	</td>
																</tr>
															</c:forEach>
														</c:if>
														<c:if test="${QX.cha == 0 }">
															<tr>
																<td colspan="100" class="center">您无权查看</td>
															</tr>
														</c:if>
													</c:when>
													<c:otherwise>
														<tr class="main_info">
															<td colspan="100" class="center" >没有相关数据</td>
														</tr>
													</c:otherwise>
												</c:choose>
												</tbody>
											</table>
										</div>
										</br>
										<div class="col-lg-12" style="padding-left:0px;padding-right:0px;margin:10px -10px 10px -10px">
											<c:if test="${QX.add == 1 }">
												<button class="btn  btn-primary" title="新增" type="button" onclick="addElevatorSpeed();">新增</button>
											</c:if>
											<a class="btn btn-warning" title="导出到Excel" type="button" target="_blank" href="<%=basePath%>elevatorParameter/toExcel.do?type=1">导出</a>
											<button class="btn btn-info" title="导入到Excel" type="button" onclick="inputFile(1)">导入</button>
											<input style="display: none" class="form-control" type="file"  title="导入" id="importFile1" onchange="importExcel(this,1)"/>
											<%--<c:if test="${QX.del == 1 }">--%>
												<%--<button class="btn  btn-danger" title="批量删除" type="button" onclick="makeAll();">批量删除</button>--%>
											<%--</c:if>--%>
											<button class="btn  btn-success" title="下载数据模板" type="button" onclick="downFile1()">下载模板</button>
											${page.pageStrForActiviti}
										</div>
									</div>
								</div>
							</div>
							<!-- 电梯重量参数 -->
							<div id="tab-2" class="tab-pane">
								<div class="ibox float-e-margins">
									<div class="ibox-content">
										<div id="top2"name="top2"></div>
										<form role="form" class="form-inline" action="elevatorParameter/elevatorWeightList.do" method="post" name="elevatorParameterForm2" id="elevatorParameterForm2">
											<div class="form-group ">
	                                			<input type="text" name="elevator_weight_name" value="${elevator_weight_name}" placeholder="这里输入电梯重量参数" class="form-control">
	                            			</div>
	                            			<div class="form-group">
	                                 			<button type="submit" class="btn  btn-primary " style="margin-bottom:0px"><i style="font-size:18px;" class="fa fa-search"></i></button>
	                            			</div>
											<button class="btn  btn-success" title="刷新" type="button" style="float:right" onclick="refreshCurrentTab(2);">刷新</button>

										</form>
										<div class="row">
											</br>
										</div>
										<div class="table-responsive">
											<table class="table table-striped table-bordered table-hover">
												<thead>
												<tr>
													<th style="width:2%;"><input type="checkbox" name="zcheckbox" id="zcheckbox" class="i-checks" ></th>
													<th style="width:5%;">序号</th>
													<th style="width:25%;">电梯重量参数(KG)</th>
													
													
													<th >操作</th>
												</tr>
												</thead>
												<tbody>
												<!-- 开始循环 -->
												<c:choose>
													<c:when test="${not empty elevatorWeightList}">
														<c:if test="${QX.cha == 1 }">
															<c:forEach items="${elevatorWeightList}" var="elevatorWeight" varStatus="vs2">
																<tr>
																	<td><input type="checkbox"  class="i-checks" name='ids' id='ids' value="${elevatorWeight.elevator_weight_id}"></td>
																	<td class='center' style="width: 30px;">${vs2.index+1}</td>
																	<td>${elevatorWeight.elevator_weight_name }</td>
																	<td>
																		<button class="btn  btn-primary btn-sm" title="编辑" type="button" onclick="editElevatorWeight('${elevatorWeight.elevator_weight_id }');">编辑</button>
																		<button class="btn  btn-danger btn-sm" title="删除" type="button" onclick="delElevatorWeight('${elevatorWeight.elevator_weight_id }');">删除</button>
																	</td>
																</tr>
															</c:forEach>
														</c:if>
														<c:if test="${QX.cha == 0 }">
															<tr>
																<td colspan="100" class="center">您无权查看</td>
															</tr>
														</c:if>
													</c:when>
													<c:otherwise>
														<tr class="main_info">
															<td colspan="100" class="center" >没有相关数据</td>
														</tr>
													</c:otherwise>
												</c:choose>
												</tbody>
											</table>
										</div>
										</br>
										<div class="col-lg-12" style="padding-left:0px;padding-right:0px;margin:10px -10px 10px -10px">
											<c:if test="${QX.add == 1 }">
												<button class="btn  btn-primary" title="新增" type="button" onclick="addElevatorWeight();">新增</button>
											</c:if>
											<a class="btn btn-warning" title="导出到Excel" type="button" target="_blank" href="<%=basePath%>elevatorParameter/toExcel.do?type=2">导出</a>
											<button class="btn btn-info" title="导入到Excel" type="button" onclick="inputFile(2)">导入</button>
											<input style="display: none" class="form-control" type="file"  title="导入" id="importFile2" onchange="importExcel(this,2)"/>
											<button class="btn  btn-success" title="下载数据模板" type="button" onclick="downFile2()">下载模板</button>
											${page.pageStrForActiviti}
										</div>
									</div>
								</div>
							</div>
							<%--电梯楼层参数--%>
							<div id="tab-3" class="tab-pane">
								<div class="ibox float-e-margins">
									<div class="ibox-content">
										<div id="top3" name="top3"></div>
										<form role="form" class="form-inline" action="elevatorParameter/elevatorStoreyList.do" method="post" name="elevatorParameterForm3" id="elevatorParameterForm3">
											<div class="form-group ">
	                                			<input type="text" name="elevator_storey_name" value="${elevator_storey_name}" placeholder="这里输入电梯楼层参数" class="form-control">
	                                			<select class="form-control" name="elevator_speed_id" id="elevator_speed_id" title="速度参数">
			                               			<option value="">请选择速度参数</option>
			                                        <c:forEach items="${elevatorSpeedList }" var="elevatorSpeed">
			                                        	<option value="${elevatorSpeed.elevator_speed_id }" ${elevatorSpeed.elevator_speed_id eq elevator_speed_id ? 'selected':'' }>${elevatorSpeed.elevator_speed_name }</option>
			                                        </c:forEach>
													
												</select>
	                            			</div>
	                            			<div class="form-group">
	                                 			<button type="submit" class="btn  btn-primary " style="margin-bottom:0px"><i style="font-size:18px;" class="fa fa-search"></i></button>
	                            			</div>
											<button class="btn  btn-success" title="刷新" type="button" style="float:right" onclick="refreshCurrentTab(3);">刷新</button>

										</form>
										<div class="row">
											</br>
										</div>
										<div class="table-responsive">
											<table class="table table-striped table-bordered table-hover">
												<thead>
												<tr>
													
													<th style="width:2%;"><input type="checkbox" name="zcheckbox" id="zcheckbox" class="i-checks" ></th>
													<th style="width:5%;">序号</th>
													<th style="width:25%;">电梯楼层参数(层)</th>
													<th style="width:25%;">标准提升高度(m)</th>
													<th style="width:25%;">电梯速度父参数(m/s)</th>
													<th >操作</th>
												</tr>
												</thead>
												<tbody>
												<!-- 开始循环 -->
												<c:choose>
													<c:when test="${not empty elevatorStoreyList}">
														<c:if test="${QX.cha == 1 }">
															<c:forEach items="${elevatorStoreyList}" var="elevatorStorey" varStatus="vs3">
																<tr>
																	<td><input type="checkbox"  class="i-checks" name='ids' id='ids' value="${elevatorStorey.elevator_storey_id}"></td>
																	<td class='center' style="width: 30px;">${vs3.index+1}</td>
																	<td>${elevatorStorey.elevator_storey_name }</td>
																	<td>${elevatorStorey.elevator_height_name }</td>
																	<td>
																		<c:forEach items="${elevatorSpeedList }" var="elevatorSpeed">
																			<c:if test="${elevatorSpeed.elevator_speed_id eq elevatorStorey.elevator_speed_id}">${elevatorSpeed.elevator_speed_name }</c:if>
																		</c:forEach>
																	</td>
																	<td>
																		<button class="btn  btn-primary btn-sm" title="编辑" type="button" onclick="editElevatorStorey('${elevatorStorey.elevator_storey_id }');">编辑</button>
																		<button class="btn  btn-danger btn-sm" title="删除" type="button" onclick="delElevatorStorey('${elevatorStorey.elevator_storey_id }');">删除</button>
																	</td>

																</tr>
															</c:forEach>
														</c:if>
														<c:if test="${QX.cha == 0 }">
															<tr>
																<td colspan="100" class="center">您无权查看</td>
															</tr>
														</c:if>
													</c:when>
													<c:otherwise>
														<tr class="main_info">
															<td colspan="100" class="center" >没有相关数据</td>
														</tr>
													</c:otherwise>
												</c:choose>
												</tbody>
											</table>
										</div>
										</br>
										<div class="col-lg-12" style="padding-left:0px;padding-right:0px;margin:10px -10px 10px -10px">
											<c:if test="${QX.add == 1 }">
												<button class="btn  btn-primary" title="新增" type="button" onclick="addElevatorStorey();">新增</button>
											</c:if>
											<a class="btn btn-warning" title="导出到Excel" type="button" target="_blank" href="<%=basePath%>elevatorParameter/toExcel.do?type=3">导出</a>
											<button class="btn btn-info" title="导入到Excel" type="button" onclick="inputFile(3)">导入</button>
											<input style="display: none" class="form-control" type="file"  title="导入" id="importFile3" onchange="importExcel(this,3)"/>
											<button class="btn  btn-success" title="下载数据模板" type="button" onclick="downFile3()">下载模板</button>
											${page.pageStrForActiviti}
										</div>
									</div>
								</div>
							</div>
							
							<%--井道提高金额--%>
							<div id="tab-4" class="tab-pane">
								<div class="ibox float-e-margins">
									<div class="ibox-content">
										<div id="top4" name="top4"></div>
										<form role="form" class="form-inline" action="elevatorParameter/elevatorHeightList.do" method="post" name="elevatorParameterForm4" id="elevatorParameterForm4">
											<div class="form-group ">
	                                			<input type="text" name="elevator_height_money" value="${elevator_height_money}" placeholder="这里输入井道高度金额" class="form-control">
	                                			<select class="form-control" name="elevator_speed_id" id="elevator_speed_id" title="速度参数">
			                               			<option value="">请选择速度参数</option>
			                                        <c:forEach items="${elevatorSpeedList }" var="elevatorSpeed">
			                                        	<option value="${elevatorSpeed.elevator_speed_id }" ${elevatorSpeed.elevator_speed_id eq elevator_speed_id ? 'selected':'' }>${elevatorSpeed.elevator_speed_name }</option>
			                                        </c:forEach>
												</select>
												<select class="form-control" name="elevator_weight_id" id="elevator_weight_id" title="重量参数">
			                               			<option value="">请选择重量参数</option>
			                                        <c:forEach items="${elevatorWeightList }" var="elevatorWeight">
			                                        	<option value="${elevatorWeight.elevator_weight_id }" ${elevatorWeight.elevator_weight_id eq elevator_weight_id ? 'selected':'' }>${elevatorWeight.elevator_weight_name }</option>
			                                        </c:forEach>
												</select>
	                            			</div>
	                            			<div class="form-group">
	                                 			<button type="submit" class="btn  btn-primary " style="margin-bottom:0px"><i style="font-size:18px;" class="fa fa-search"></i></button>
	                            			</div>
											<button class="btn  btn-success" title="刷新" type="button" style="float:right" onclick="refreshCurrentTab(4);">刷新</button>

										</form>
										<div class="row">
											</br>
										</div>
										<div class="table-responsive">
											<table class="table table-striped table-bordered table-hover">
												<thead>
												<tr>
													
													<th style="width:2%;"><input type="checkbox" name="zcheckbox" id="zcheckbox" class="i-checks" ></th>
													<th style="width:5%;">序号</th>
													<th style="width:25%;">井道高度提升金额</th>
													<th style="width:25%;">电梯重量父参数(KG)</th>
													<th style="width:25%;">电梯速度父参数(m/s)</th>
													<th >操作</th>
												</tr>
												</thead>
												<tbody>
												<!-- 开始循环 -->
												<c:choose>
													<c:when test="${not empty elevatorHeightList}">
														<c:if test="${QX.cha == 1 }">
															<c:forEach items="${elevatorHeightList}" var="elevatorHeight" varStatus="vs4">
																<tr>
																	<td><input type="checkbox"  class="i-checks" name='ids' id='ids' value="${elevatorHeight.elevator_height_id}"></td>
																	<td class='center' style="width: 30px;">${vs4.index+1}</td>
																	<td>${elevatorHeight.elevator_height_money }</td>
																	
																	<td>
																		<c:forEach items="${elevatorSpeedList }" var="elevatorSpeed">
																			<c:if test="${elevatorSpeed.elevator_speed_id eq elevatorHeight.elevator_speed_id}">${elevatorSpeed.elevator_speed_name }</c:if>
																		</c:forEach>
																	</td>
																	<td>
																		<c:forEach items="${elevatorWeightList }" var="elevatorWeight">
																			<c:if test="${elevatorWeight.elevator_weight_id eq elevatorHeight.elevator_weight_id}">${elevatorWeight.elevator_weight_name }</c:if>
																		</c:forEach>
																	</td>
																	<td>
																		<button class="btn  btn-primary btn-sm" title="编辑" type="button" onclick="editElevatorHeight('${elevatorHeight.elevator_height_id }');">编辑</button>
																		<button class="btn  btn-danger btn-sm" title="删除" type="button" onclick="delElevatorHeight('${elevatorHeight.elevator_height_id }');">删除</button>
																	</td>

																</tr>
															</c:forEach>
														</c:if>
														<c:if test="${QX.cha == 0 }">
															<tr>
																<td colspan="100" class="center">您无权查看</td>
															</tr>
														</c:if>
													</c:when>
													<c:otherwise>
														<tr class="main_info">
															<td colspan="100" class="center" >没有相关数据</td>
														</tr>
													</c:otherwise>
												</c:choose>
												</tbody>
											</table>
										</div>
										</br>
										<div class="col-lg-12" style="padding-left:0px;padding-right:0px;margin:10px -10px 10px -10px">
											<c:if test="${QX.add == 1 }">
												<button class="btn  btn-primary" title="新增" type="button" onclick="addElevatorHeight();">新增</button>
											</c:if>
											${page.pageStrForActiviti}
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
	            <div class="col-sm-12">
	                <div class="ibox float-e-margins">

	                </div>
	            </div>
	        </div>
	    </div>
	    <!--返回顶部开始-->
        <div id="back-to-top">
            <a class="btn btn-warning btn-back-to-top" href="javascript: setWindowScrollTop (this,document.getElementById('top').offsetTop);">
                <i class="fa fa-chevron-up"></i>
            </a>
        </div>
        <!--返回顶部结束-->
	<!-- Fancy box -->
    <script src="static/js/fancybox/jquery.fancybox.js"></script>
	<!-- iCheck -->
    <script src="static/js/iCheck/icheck.min.js"></script>
    <!-- Sweet alert -->
	<script src="static/js/sweetalert2/sweetalert2.js"></script>
    <!-- 日期控件-->
    <script src="static/js/layer/laydate/laydate.js"></script>
    
	<script type="text/javascript">
	 $(document).ready(function () {
		 //loading end
		 parent.layer.closeAll('loading');
		 //本页面点击
		 layer.closeAll('loading');
     	/* checkbox */
         $('.i-checks').iCheck({
             checkboxClass: 'icheckbox_square-green',
             radioClass: 'iradio_square-green',
         });
     });

	 //设置tab显示
	 var isActive1 = "${pd.isActive1}";
	 var isActive2 = "${pd.isActive2}";
	 var isActive3 = "${pd.isActive3}";
	 var isActive4 = "${pd.isActive4}";
	 if(isActive1=="1"){
		 $("#nav-tab-1").addClass("active");
		 $("#tab-1").addClass("active");
	 }else if(isActive2=="1"){
		 $("#nav-tab-2").addClass("active");
		 $("#tab-2").addClass("active");
	 }else if(isActive3=="1"){
		 $("#nav-tab-3").addClass("active");
		 $("#tab-3").addClass("active");
	 }else if(isActive4=="1"){
		 $("#nav-tab-4").addClass("active");
		 $("#tab-4").addClass("active");
	 }
	 //tab切换
	 function tabChange(id){
		 //loading
		 layer.load(1);
		$("#elevatorParameterForm"+id).submit();

	 }
     /* checkbox全选 */
     $("#zcheckbox").on('ifChecked', function(event){
     	$('input').iCheck('check');
   	});
     /* checkbox取消全选 */
     $("#zcheckbox").on('ifUnchecked', function(event){
     	
     	$('input').iCheck('uncheck');
   	});
    
    	//刷新iframe
        function refreshCurrentTab(id) {
			//loading
			layer.load(1);
        	$("#elevatorParameterForm"+id).submit();
        }
		//检索
		function search(id){
			//loading
			layer.load(1);
			$("#elevatorParameterForm"+id).submit();
		}
		
		//新增电梯速度参数
		function addElevatorSpeed(){
			$("#AddElevatorSpeed").kendoWindow({
		        width: "500px",
		        height: "500px",
		        title: "新增电梯速度参数",
		        actions: ["Close"],
		        content: '<%=basePath%>elevatorParameter/goAddElevatorSpeed.do',
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").center().open();
		}
		 //编辑电梯速度参数
		 function editElevatorSpeed(id){
			 $("#EditElevatorSpeed").kendoWindow({
				 width: "500px",
				 height: "500px",
				 title: "编辑",
				 actions: ["Close"],
				 content: '<%=basePath%>elevatorParameter/goEditElevatorSpeed.do?elevator_speed_id='+id+"&tm="+new Date().getTime(),
				 modal : true,
				 visible : false,
				 resizable : true
			 }).data("kendoWindow").center().open();
		 }
		
		//删除电梯速度参数
		function delElevatorSpeed(id){
            swal({
                    title: "您确定要删除这条记录吗？",
                    text: "删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    cancelButtonText: "取消",
                    closeOnConfirm: false,
                    closeOnCancel: false
                }).then(function (isConfirm) {
				if (isConfirm===true) {
					var url = "<%=basePath%>elevatorParameter/delElevatorSpeed.do?elevator_speed_id="+id+"&tm="+new Date().getTime();
					$.get(url,function(data){
						if(data.msg=='success'){
							swal({
										title: "删除成功！",
										text: "您已经成功删除了这条数据。",
										type: "success",
									}).then(function(){
								refreshCurrentTab(1);
							});
						}else{
							swal("删除失败", data.err, "error");
						}
					});
				}  else if (isConfirm === false) {
					swal("已取消", "您取消了删除操作！", "error");
				}
			});
		}
		
		//新增电梯重量参数
		function addElevatorWeight(){
			$("#AddElevatorWeight").kendoWindow({
		        width: "500px",
		        height: "500px",
		        title: "新增电梯重量参数",
		        actions: ["Close"],
		        content: '<%=basePath%>elevatorParameter/goAddElevatorWeight.do',
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").center().open();
		}
		 //编辑电梯重量参数
		 function editElevatorWeight(id){
			 $("#EditElevatorWeight").kendoWindow({
				 width: "500px",
				 height: "500px",
				 title: "编辑电梯重量参数",
				 actions: ["Close"],
				 content: '<%=basePath%>elevatorParameter/goEditElevatorWeight.do?elevator_weight_id='+id+"&tm="+new Date().getTime(),
				 modal : true,
				 visible : false,
				 resizable : true
			 }).data("kendoWindow").center().open();
		 }
		
		//删除电梯重量参数
		function delElevatorWeight(id){
            swal({
                    title: "您确定要删除这条记录吗？",
                    text: "删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    cancelButtonText: "取消",
                    closeOnConfirm: false,
                    closeOnCancel: false
                }).then(function (isConfirm) {
				if (isConfirm===true) {
					var url = "<%=basePath%>elevatorParameter/delElevatorWeight.do?elevator_weight_id="+id+"&tm="+new Date().getTime();
					$.get(url,function(data){
						if(data.msg=='success'){
							swal({
										title: "删除成功！",
										text: "您已经成功删除了这条数据。",
										type: "success",
									}).then(function(){
								refreshCurrentTab(2);
							});
						}else{
							swal("删除失败", data.err, "error");
						}
					});
				}  else if (isConfirm === false) {
					swal("已取消", "您取消了删除操作！", "error");
				}
			});
		}
		
		
		//新增电梯楼层参数
		function addElevatorStorey(){
			$("#AddElevatorStorey").kendoWindow({
		        width: "500px",
		        height: "500px",
		        title: "新增电梯楼层参数",
		        actions: ["Close"],
		        content: '<%=basePath%>elevatorParameter/goAddElevatorStorey.do',
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").center().open();
		}
		 //编辑电梯楼层参数
		 function editElevatorStorey(id){
			 $("#EditElevatorStorey").kendoWindow({
				 width: "500px",
				 height: "500px",
				 title: "编辑电梯楼层参数",
				 actions: ["Close"],
				 content: '<%=basePath%>elevatorParameter/goEditElevatorStorey.do?elevator_storey_id='+id+"&tm="+new Date().getTime(),
				 modal : true,
				 visible : false,
				 resizable : true
			 }).data("kendoWindow").center().open();
		 }
		
		//删除电梯楼层参数
		function delElevatorStorey(id){
            swal({
                    title: "您确定要删除这条记录吗？",
                    text: "删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    cancelButtonText: "取消",
                    closeOnConfirm: false,
                    closeOnCancel: false
                }).then(function (isConfirm) {
				if (isConfirm===true) {
					var url = "<%=basePath%>elevatorParameter/delElevatorStorey.do?elevator_storey_id="+id+"&tm="+new Date().getTime();
					$.get(url,function(data){
						if(data.msg=='success'){
							swal({
										title: "删除成功！",
										text: "您已经成功删除了这条数据。",
										type: "success",
									}).then(function(){
								refreshCurrentTab(3);
							});
						}else{
							swal("删除失败", data.err, "error");
						}
					});
				}  else if (isConfirm === false) {
					swal("已取消", "您取消了删除操作！", "error");
				}
			});
		}
		
		
		//新增井道高度参数
		function addElevatorHeight(){
			$("#AddElevatorHeight").kendoWindow({
		        width: "500px",
		        height: "500px",
		        title: "新增电梯井道高度参数",
		        actions: ["Close"],
		        content: '<%=basePath%>elevatorParameter/goAddElevatorHeight.do',
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").center().open();
		}
		 //编辑井道高度参数
		 function editElevatorHeight(id){
			 $("#EditElevatorHeight").kendoWindow({
				 width: "500px",
				 height: "500px",
				 title: "编辑电梯井道高度参数",
				 actions: ["Close"],
				 content: '<%=basePath%>elevatorParameter/goEditElevatorHeight.do?elevator_height_id='+id+"&tm="+new Date().getTime(),
				 modal : true,
				 visible : false,
				 resizable : true
			 }).data("kendoWindow").center().open();
		 }
		
		//删除电梯井道高度参数
		function delElevatorHeight(id){
            swal({
                    title: "您确定要删除这条记录吗？",
                    text: "删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    cancelButtonText: "取消",
                    closeOnConfirm: false,
                    closeOnCancel: false
                }).then(function (isConfirm) {
				if (isConfirm===true) {
					var url = "<%=basePath%>elevatorParameter/delElevatorHeight.do?elevator_height_id="+id+"&tm="+new Date().getTime();
					$.get(url,function(data){
						if(data.msg=='success'){
							swal({
										title: "删除成功！",
										text: "您已经成功删除了这条数据。",
										type: "success",
									}).then(function(){
								refreshCurrentTab(4);
							});
						}else{
							swal("删除失败", data.err, "error");
						}
					});
				}  else if (isConfirm === false) {
					swal("已取消", "您取消了删除操作！", "error");
				}
			});
		}
		
		//批量操作
		function makeAll(){
			var str = '';
			var emstr = '';
			var phones = '';
			for(var i=0;i < document.getElementsByName('ids').length;i++)
			{
				  if(document.getElementsByName('ids')[i].checked){
				  	if(str=='') str += document.getElementsByName('ids')[i].value;
				  	else str += ',' + document.getElementsByName('ids')[i].value;
				  }
			}
			if(str==''){
				swal({
	                title: "您未选择任何数据",
	                text: "请选择你需要操作的数据！",
	                type: "error",
	                showCancelButton: false,
	                confirmButtonColor: "#DD6B55",
	                confirmButtonText: "OK",
	                closeOnConfirm: true,
	                timer:1500
	            });
			}else{
				swal({
	                title: "您确定要删除选中的数据吗？",
	                text: "删除后将无法恢复，请谨慎操作！",
	                type: "warning",
	                showCancelButton: true,
	                confirmButtonColor: "#DD6B55",
	                confirmButtonText: "删除",
	                cancelButtonText: "取消",
	                closeOnConfirm: false,
	                closeOnCancel: false
	            },
	            function (isConfirm) {
	                if (isConfirm) {
	                	$.ajax({
							type: "POST",
							url: '<%=basePath%>workflow/leave/delAllLeaves.do',
					    	data: {leave_ids:str},
							dataType:'json',
							cache: false,
							success: function(data){
								if(data.msg=='success'){
									swal({   
	        				        	title: "删除成功！",
	        				        	text: "您已经成功删除了这些数据。",
	        				        	type: "success",  
	        				        	 }, 
	        				        	function(){   
	        				        		 refreshCurrentTab(); 
	        				        	 });
		    					}else{
		    						swal("删除失败", data.err, "error");
		    					}
								
							}
						});
	                } else {
	                    swal("已取消", "您取消了删除操作！", "error");
	                }
	            });
			}
		}
		
		
		//导出到Excel
		function toExcel(){
			$.post("<%=basePath%>elevatorParameter/toExcel.do");
		}

		//选择导入文件
		function inputFile(type){
			if(type == 1){
				$("#importFile1").click();
			}else if(type == 2){
				$("#importFile2").click();
			}else if(type == 3){
				$("#importFile3").click();	
			}
		}

		//导入Excel
		function importExcel(e,type){
	    	var filePath = $(e).val();
	    	console.log(filePath);
	    	var suffix = filePath.substring(filePath.lastIndexOf(".")).toLowerCase();
	    	var fileType = ".xls|.xlsx|";
	    	if(filePath == null || filePath == ""){
	            return false;
	        }
	        if(fileType.indexOf(suffix+"|")==-1){
	            var ErrMsg = "该文件类型不允许上传。请上传 "+fileType+" 类型的文件，当前文件类型为"+suffix; 
	            $(e).val("");
	            alert(ErrMsg);
	            return false;
	        }
	        var data = new FormData();
	    	data.append("file", $(e)[0].files[0]);
	    	console.log($(e)[0].files[0]);
	    	$.ajax({
	            url:"<%=basePath%>elevatorParameter/importExcel.do?type="+type,
	            type:"POST",
	            data:data,
	            cache: false,
	            processData:false,
	            contentType:false,
	            success:function(result){
	                if(result){
	                	 swal({
		                    	title:"导入成功!",
		                    	text:"导入数据成功！",
		                    	type:"success"
		                    },
							 function(){
								 refreshCurrentTab();
							 });
	                }
	                else if(result.msg2=="error")
	                {
	                	 swal({
		                    	title:"导入失败!",
		                    	text:"导入数据失败,"+result.error,
		                    	type:"error"
		                    },
							 function(){
								 refreshCurrentTab();
							 });
	                }
	                else{
	                    alert(result.errorMsg);
	                }
	            }
	        });
		}
	 
		
		/* 下载数据模板
		2017-06-13 Stone
		*/
		function downFile1() {
			var url="uploadFiles/file/DataModel/Elevator/电梯速度参数表.xls";
			var name = window.encodeURI(window.encodeURI(url));
			window.open("customer/DataModel?url=" + name,"_blank");
		}
		/* 下载数据模板
		2017-06-13 Stone
		*/
		function downFile2() {
			var url="uploadFiles/file/DataModel/Elevator/电梯重量参数表.xls";
			var name = window.encodeURI(window.encodeURI(url));
			window.open("customer/DataModel?url=" + name,"_blank");
		}
		/* 下载数据模板
		2017-06-13 Stone
		*/
		function downFile3() {
			var url="uploadFiles/file/DataModel/Elevator/电梯楼层参数表.xls";
			var name = window.encodeURI(window.encodeURI(url));
			window.open("customer/DataModel?url=" + name,"_blank");
		}
		
		/* back to top */
		function setWindowScrollTop(win, topHeight){
		    if(win.document.documentElement){
		        win.document.documentElement.scrollTop = topHeight;
		    }
		    if(win.document.body){
		        win.document.body.scrollTop = topHeight;
		    }
		}
	</script>
</body>
</html>


