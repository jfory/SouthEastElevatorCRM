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
        <div id="EditElevatorBase" class="animated fadeIn"></div>
        <div id="AddElevatorBase" class="animated fadeIn"></div>
		<div id="EditElevatorOptional" class="animated fadeIn"></div>
        <div id="AddElevatorOptional" class="animated fadeIn"></div>
        <div id="ElevatorOptional" class="animated fadeIn"></div>
        <div id="EditElevatorNonstandard" class="animated fadeIn"></div>
        <div id="AddElevatorNonstandard" class="animated fadeIn"></div>
	        <div class="row">
				<div class="panel blank-panel">
					<div class="panel-heading">
						<div class="panel-options">
							<ul class="nav nav-tabs">
								<li id="nav-tab-1" >
									<a data-toggle="tab" href="#tab-1" onclick="tabChange(1)">
										<i class="fa fa-hourglass-o"></i>
										电梯基础项配置
									</a>
								</li>
								<li id="nav-tab-2">
									<a class="count-info-sm" data-toggle="tab" href="#tab-2" onclick="tabChange(2)">
										<i class="fa fa-hourglass-2"></i>
										电梯可选项配置
										
									</a>
								</li>
								<li id="nav-tab-3">
									<a data-toggle="tab" href="#tab-3" onclick="tabChange(3)">
										<i class="fa fa-hourglass"></i>
										电梯非标项配置
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
										<form role="form" class="form-inline" action="elevatorConfig/elevatorBaseList.do" method="post" name="elevatorConfigForm1" id="elevatorConfigForm1">
											<div class="form-group ">
	                                			<input type="text" name="elevator_base_name" value="${elevator_base_name}" placeholder="这里输入电梯基础项配置" class="form-control">
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
													<th style="width:15%;">基础项名称</th>
													
													<th style="width:25%;">描述</th>
													<th >操作</th>
												</tr>
												</thead>
												<tbody>
												<!-- 开始循环 -->
												<c:choose>
													<c:when test="${not empty elevatorBaseList}">
														<c:if test="${QX.cha == 1 }">
															<c:forEach items="${elevatorBaseList}" var="elevatorBase" varStatus="vs1">
																<tr>
																	
																	<td><input type="checkbox"  class="i-checks" name='ids' id='ids' value="${elevatorBase.elevator_base_id}"></td>
														
														
																	<td class='center' style="width: 30px;">${vs1.index+1}</td>
																	<td>${elevatorBase.elevator_base_name }</td>
																	<td>${elevatorBase.elevator_base_description }</td>
																	<td>
																		
																			<button class="btn  btn-primary btn-sm" title="编辑" type="button" onclick="editElevatorBase('${elevatorBase.elevator_base_id }');">编辑</button>
																			<button class="btn  btn-danger btn-sm" title="删除" type="button" onclick="delElevatorBase('${elevatorBase.elevator_base_id}');">删除</button>
																		
																		
																		
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
												<button class="btn  btn-primary" title="新增" type="button" onclick="addElevatorBase();">新增</button>
											</c:if>
											<a class="btn btn-warning" title="导出到Excel" type="button" target="_blank" href="<%=basePath%>elevatorConfig/toExcel.do?type=1">导出</a>
											<button class="btn btn-info" title="导入到Excel" type="button" onclick="inputFile(1)">导入</button>
											<input style="display: none" class="form-control" type="file"  title="导入" id="importFile1" onchange="importExcel(this,1)"/>
											<%--<c:if test="${QX.del == 1 }">--%>
												<%--<button class="btn  btn-danger" title="批量删除" type="button" onclick="makeAll();">批量删除</button>--%>
											<%--</c:if>--%>
											${page.pageStrForActiviti}
										</div>
									</div>
								</div>
							</div>
							<!-- 电梯可选配置 -->
							<div id="tab-2" class="tab-pane">
								<div class="ibox float-e-margins">
									<div class="ibox-content">
										<div id="top2"name="top2"></div>
										<form role="form" class="form-inline" action="elevatorConfig/elevatorOptionalList.do" method="post" name="elevatorConfigForm2" id="elevatorConfigForm2">
											<div class="form-group ">
	                                			<input type="text" name="elevator_optional_name" value="${elevator_optional_name}" placeholder="这里搜索一级菜单" class="form-control">
	                                			<select class="form-control" name="elevator_id" id="elevator_id" title="电梯类型">
			                               			<option value="">请选择类别</option>
			                                        <option value="1" ${elevator_id eq 1 ? 'selected':'' }>常规梯</option>
			                                        <option value="2" ${elevator_id eq 2 ? 'selected':'' }>家用梯</option>
			                                        <option value="3" ${elevator_id eq 3 ? 'selected':'' }>特种梯</option>
			                                        <option value="4" ${elevator_id eq 4 ? 'selected':'' }>扶梯</option>
													
												</select>
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
													<th style="width:10%;">一级菜单</th>
													<th style="width:10%;">二级菜单</th>
													<th style="width:10%;">三级菜单</th>
													<th style="width:10%;">四级菜单</th>
													<th style="width:10%;">价格</th>
													<th style="width:5%;">单位</th>
													<th style="width:5%;">交货期</th>
													<th style="width:15%;">描述</th>
													<th >操作</th>
												</tr>
												</thead>
												<tbody>
												<!-- 开始循环 -->
												<c:choose>
													<c:when test="${not empty elevatorOptionalList}">
														<c:if test="${QX.cha == 1 }">
															<c:forEach items="${elevatorOptionalList}" var="elevatorOptional" varStatus="vs2">
																<tr>
																	<td><input type="checkbox"  class="i-checks" name='ids' id='ids' value="${elevatorOptional.elevator_optional_id}"></td>
																	<td class='center' style="width: 30px;">${vs2.index+1}</td>
																	<td>${elevatorOptional.oneMenuName }</td>
																	<td>${elevatorOptional.twoMenuName }</td>
																	<td>${elevatorOptional.threeMenuName }</td>
																	<td>${elevatorOptional.fourMenuName }</td>
																	<%-- <td>
																		<c:forEach items="${elevatorCascadeList }" var="elevatorCascade">
																			${elevatorCascade.id eq elevatorOptional.id ? elevatorCascade.name : '' }
																		</c:forEach>
																		
																	</td> --%>
																	<td>${elevatorOptional.elevator_optional_price }</td>
																	<td>
																		<c:forEach items="${elevatorUnitList }" var="elevatorUnit">
																			${elevatorUnit.elevator_unit_id eq elevatorOptional.elevator_unit_id ? elevatorUnit.elevator_unit_name : '' }
																		</c:forEach>
																	</td>
																	
																	<td>${elevatorOptional.elevator_optional_delivery }</td>
																	<td>${elevatorOptional.elevator_optional_description }</td>
																	<td>
																		<%-- <button class="btn  btn-warning btn-sm" title="配置" type="button" onclick="elevatorOptional('${elevatorOptional.elevator_optional_id}');">配置</button> --%>
																		<button class="btn  btn-primary btn-sm" title="编辑" type="button" onclick="editElevatorOptional('${elevatorOptional.elevator_optional_id }');">编辑</button>
																		<button class="btn  btn-danger btn-sm" title="删除" type="button" onclick="delElevatorOptional('${elevatorOptional.elevator_optional_id }');">删除</button>
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
												<button class="btn  btn-primary" title="新增" type="button" onclick="addElevatorOptional();">新增</button>
											</c:if>
											<a class="btn btn-warning" title="导出到Excel" type="button" target="_blank" href="<%=basePath%>elevatorConfig/toExcel.do?type=2">导出</a>
											<button class="btn btn-info" title="导入到Excel" type="button" onclick="inputFile(2)">导入</button>
											<input style="display: none" class="form-control" type="file"  title="导入" id="importFile2" onchange="importExcel(this,2)"/>
											${page.pageStrForActiviti}
										</div>
									</div>
								</div>
							</div>
							<%--电梯非标配置--%>
							<div id="tab-3" class="tab-pane">
								<div class="ibox float-e-margins">
									<div class="ibox-content">
										<div id="top3" name="top3"></div>
										<form role="form" class="form-inline" action="elevatorConfig/elevatorNonstandardList.do" method="post" name="elevatorConfigForm3" id="elevatorConfigForm3">
											<div class="form-group ">
	                                			<input type="text" name="elevator_nonstandard_name" value="${elevator_nonstandard_name}" placeholder="这里一级菜单" class="form-control">
	                                			<select class="form-control" name="elevator_nonstandard_state" id="elevator_nonstandard_state" title="功能状态">
			                               			<option value="">请选择类别</option>
			                                        <option value="1" ${elevator_nonstandard_state eq 1 ? 'selected':'' }>启用</option>
			                                        <option value="2" ${elevator_nonstandard_state eq 2 ? 'selected':'' }>禁用</option>
			                                        <option value="3" ${elevator_nonstandard_state eq 3 ? 'selected':'' }>历史记录</option>
													
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
													<th style="width:10%;">一级菜单</th>
													<th style="width:10%;">二级菜单</th>
													<th style="width:10%;">三级菜单</th>
													<th style="width:10%;">四级菜单</th>
													<th style="width:5%;">状态</th>
													<th style="width:10%;">价格</th>
													<th style="width:5%;">单位</th>
													<th style="width:5%;">交货期</th>
													<th style="width:15%;">描述</th>
													<th >操作</th>
												</tr>
												</thead>
												<tbody>
												<!-- 开始循环 -->
												<c:choose>
													<c:when test="${not empty elevatorNonstandardList}">
														<c:if test="${QX.cha == 1 }">
															<c:forEach items="${elevatorNonstandardList}" var="elevatorNonstandard" varStatus="vs3">
																<tr>
																	<td><input type="checkbox"  class="i-checks" name='ids' id='ids' value="${elevatorNonstandard.elevator_nonstandard_id}"></td>
																	<td class='center' style="width: 30px;">${vs3.index+1}</td>
																	<td>${elevatorNonstandard.oneMenuName }</td>
																	<td>${elevatorNonstandard.twoMenuName }</td>
																	<td>${elevatorNonstandard.threeMenuName }</td>
																	<td>${elevatorNonstandard.fourMenuName }</td>
																	<%-- <td>
																		<c:forEach items="${elevatorCascadeList }" var="elevatorCascade">
																			${elevatorCascade.id eq elevatorNonstandard.id ? elevatorCascade.name : '' }
																		</c:forEach>
																	</td> --%>
																	<td>
																		<c:if test="${elevatorNonstandard.elevator_nonstandard_state eq 1}">启用</c:if>
																		<c:if test="${elevatorNonstandard.elevator_nonstandard_state eq 2}">禁用</c:if>
																		<c:if test="${elevatorNonstandard.elevator_nonstandard_state eq 3}">历史记录</c:if>
																	</td>
																	<td>${elevatorNonstandard.elevator_nonstandard_price }</td>
																	<td>
																		<c:forEach items="${elevatorUnitList }" var="elevatorUnit">
																			${elevatorUnit.elevator_unit_id eq elevatorNonstandard.elevator_unit_id ? elevatorUnit.elevator_unit_name : '' }
																		</c:forEach>
																	</td>
																	<td>${elevatorNonstandard.elevator_nonstandard_delivery }</td>
																	<td>${elevatorNonstandard.elevator_nonstandard_description }</td>
																	<td>
																		<button class="btn  btn-primary btn-sm" title="编辑" type="button" onclick="editElevatorNonstandard('${elevatorNonstandard.elevator_nonstandard_id }');">编辑</button>
																		<button class="btn  btn-danger btn-sm" title="删除" type="button" onclick="delElevatorNonstandard('${elevatorNonstandard.elevator_nonstandard_id }');">删除</button>
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
												<button class="btn  btn-primary" title="新增" type="button" onclick="addElevatorNonstandard();">新增</button>
											</c:if>                                                                          
											<a class="btn btn-warning" title="导出到Excel" type="button" target="_blank" href="<%=basePath%>elevator/toExcelElevatorNonstandard.do">导出</a>
											<button class="btn btn-info" title="导入到Excel" type="button" onclick="inputFile(3)">导入</button>
											<input style="display: none" class="form-control" type="file"  title="导入" id="importFile3" onchange="importExcel3(this)"/>
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
	 if(isActive1=="1"){
		 $("#nav-tab-1").addClass("active");
		 $("#tab-1").addClass("active");
	 }else if(isActive2=="1"){
		 $("#nav-tab-2").addClass("active");
		 $("#tab-2").addClass("active");
	 }else if(isActive3=="1"){
		 $("#nav-tab-3").addClass("active");
		 $("#tab-3").addClass("active");
	 }
	 //tab切换
	 function tabChange(id){
		 //loading
		 layer.load(1);
		$("#elevatorConfigForm"+id).submit();

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
        	$("#elevatorConfigForm"+id).submit();
        }
		//检索
		function search(id){
			//loading
			layer.load(1);
			$("#elevatorConfigForm"+id).submit();
		}
		
		//新增电梯基础项配置
		function addElevatorBase(){
			$("#AddElevatorBase").kendoWindow({
		        width: "600px",
		        height: "600px",
		        title: "新增电梯基础项配置",
		        actions: ["Close"],
		        content: '<%=basePath%>elevatorConfig/goAddElevatorBase.do',
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").center().open();
		}
		 //编辑电梯基础项配置
		 function editElevatorBase(id){
			 $("#EditElevatorBase").kendoWindow({
				 width: "600px",
				 height: "600px",
				 title: "编辑",
				 actions: ["Close"],
				 content: '<%=basePath%>elevatorConfig/goEditElevatorBase.do?elevator_base_id='+id+"&tm="+new Date().getTime(),
				 modal : true,
				 visible : false,
				 resizable : true
			 }).data("kendoWindow").center().open();
		 }
		
		//删除电梯基础项配置
		function delElevatorBase(id){
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
					var url = "<%=basePath%>elevatorConfig/delElevatorBase.do?elevator_base_id="+id+"&tm="+new Date().getTime();
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
		
		
		
		//新增电梯可选配置
		function addElevatorOptional(){
			$("#AddElevatorOptional").kendoWindow({
		        width: "600px",
		        height: "600px",
		        title: "新增电梯可选配置",
		        actions: ["Close"],
		        content: '<%=basePath%>elevatorConfig/goAddElevatorOptional.do',
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").maximize().open();
		}
		 //编辑电梯可选配置
		 function editElevatorOptional(id){
			 $("#EditElevatorOptional").kendoWindow({
				 width: "600px",
				 height: "600px",
				 title: "编辑电梯可选配置",
				 actions: ["Close"],
				 content: '<%=basePath%>elevatorConfig/goEditElevatorOptional.do?elevator_optional_id='+id+"&tm="+new Date().getTime(),
				 modal : true,
				 visible : false,
				 resizable : true
			 }).data("kendoWindow").maximize().open();
		 }
		
		//删除电梯可选配置
		function delElevatorOptional(id){
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
					var url = "<%=basePath%>elevatorConfig/delElevatorOptional.do?elevator_optional_id="+id+"&tm="+new Date().getTime();
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
		
		
		//新增电梯非标配置
		function addElevatorNonstandard(){
			$("#AddElevatorNonstandard").kendoWindow({
		        width: "600px",
		        height: "600px",
		        title: "新增电梯非标配置",
		        actions: ["Close"],
		        content: '<%=basePath%>elevatorConfig/goAddElevatorNonstandard.do',
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").maximize().open();
		}
		 //编辑电梯非标配置
		 function editElevatorNonstandard(id){
			 $("#EditElevatorNonstandard").kendoWindow({
				 width: "600px",
				 height: "600px",
				 title: "编辑电梯非标配置",
				 actions: ["Close"],
				 content: '<%=basePath%>elevatorConfig/goEditElevatorNonstandard.do?elevator_nonstandard_id='+id+"&tm="+new Date().getTime(),
				 modal : true,
				 visible : false,
				 resizable : true
			 }).data("kendoWindow").maximize().open();
		 }
		
		//删除电梯非标配置
		function delElevatorNonstandard(id){
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
					var url = "<%=basePath%>elevatorConfig/delElevatorNonstandard.do?elevator_nonstandard_id="+id+"&tm="+new Date().getTime();
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
			$.post("<%=basePath%>sysAgent/toExcel.do");
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
	            url:"<%=basePath%>elevatorConfig/importExcel.do?type="+type,
	            type:"POST",
	            data:data,
	            cache: false,
	            processData:false,
	            contentType:false,
	            success:function(result){
	            	if(result.msg=="success"){
	                	swal({
	                		title:"导入成功!",
	                		text:"导入数据成功。",
	                		type:"success"
	                	},
						 function(){
							 refreshCurrentTab();
						 });
	                }else{
	                	 swal({
		                    	title:"导入失败!",
		                    	text:"导入数据失败,"+result.errorMsg,
		                    	type:"error"
		                    },
							 function(){
								 refreshCurrentTab();
							 });
	                }
	            }
	        });
		}
		//导入Excel
		function importExcel3(e){
			alert("3");
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
	            url:"<%=basePath%>elevator/importExcelElevatorNonstandard.do",
	            type:"POST",
	            data:data,
	            cache: false,
	            processData:false,
	            contentType:false,
	            success:function(result){
	            	if(result.msg=="success"){
	                	swal({
	                		title:"导入成功!",
	                		text:"导入数据成功。",
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
	                	 swal({
		                    	title:"导入失败!",
		                    	text:"导入数据失败,"+result.errorMsg,
		                    	type:"error"
		                    },
							 function(){
								 refreshCurrentTab();
							 });
	                }
	            }
	        });
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


