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
    <link href="static/js/sweetalert/sweetalert.css" rel="stylesheet">
	<title>${pd.SYSNAME}</title>
</head>

<body class="gray-bg" >
	<div id="EditSupplement" class="animated fadeIn"></div>
	<div id="HandleTask" class="animated fadeIn"></div>
	<input type="hidden" id="active" value="${active}">
    <div class="wrapper wrapper-content">
        <div class="row">
        	<div class="panel blank-panel">
					<div class="panel-heading">
						<div class="panel-options">
							<ul class="nav nav-tabs">
								<li id="nav-tab-1">
									<a class="count-info-sm" data-toggle="tab" href="#tab-1" onclick="tabChange(1)">
										<i class="fa fa-hourglass-2"></i>
										我的申请
									</a>
								</li>
								<li id="nav-tab-2">
									<a data-toggle="tab" href="#tab-2" onclick="tabChange(2)">
										<i class="fa fa-hourglass"></i>
										待我办理
										<c:if test="${pd.count>0}">
											<span class="label label-warning">${pd.count}</span>
										</c:if>
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
										<form role="form" class="form-inline" action="install/supplement.do" method="post" name="SupplementForm1" id="SupplementForm1">
				                            <div class="form-group form-inline" style="display:none">
				                                 <button type="submit" class="btn  btn-primary " style="margin-bottom:0px"><i style="font-size:18px;" class="fa fa-search"></i></button>
				                            </div>
				                        	<button class="btn  btn-success" title="刷新" type="button" style="margin-top: 5px;margin-left: 752px" onclick="refreshCurrentTab(1);">刷新</button>
			                        	</form>
										<div class="table-responsive">
			                            <table class="table table-striped table-bordered table-hover">
			                                <thead>
			                                    <tr>
			                                        <th style="width:5%;"><input type="checkbox" name="zcheckbox" id="zcheckbox" class="i-checks" ></th>
			                                        <th style="width:10%;">编号</th>
			                                        <th style="width:15%;">开箱报告编号</th>
			                                        <th style="width:15%;">申请人</th>
			                                        <th style="width:10%;">申请时间</th>
			                                        <th style="width:10%;">申请状态</th>
			                                        <th style="width:15%;">操作</th>
			                                    </tr>
			                                </thead>
			                                <tbody>
			                                <!-- 开始循环 -->	
											<c:choose>
												<c:when test="${not empty supplementList}">
													<c:if test="${QX.cha == 1 }">
														<c:forEach items="${supplementList}" var="var" >
															<tr>
																<td><input type="checkbox" class="i-checks" name='ids' id='${var.item_id }' value='${var.item_id }' ></td>
																<td>${var.id}</td>
																<td>${var.unbox_id}</td>
																<td>${var.name}</td>
																<td>${var.input_date}</td>
																<td>
																	${var.status=="1"?"新增":""}
																	${var.status=="2"?"已完成":""}
																</td>
																<td>
																	<c:if test="${QX.edit != 1 && QX.del != 1 }">
																		<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="icon-lock" title="无权限">无权限</i></span>
																	</c:if>
																	<div>
																		<!-- <c:if test="${QX.edit == 1 }">
																			<button class="btn btn-sm btn-primary btn-sm" title="编辑" type="button" onclick="edit('${var.id}');">编辑</button>
																		</c:if>
																		<c:if test="${QX.del == 1 }">
																			<button class="btn btn-sm btn-danger btn-sm" title="删除" type="button" onclick="del('${var.id}')">删除</button>
																		</c:if> -->
																		<c:if test="${var.status == 0 }">
																			<button class="btn btn-sm btn-warning btn-sm" title="提交" type="button" onclick="start('${var.id}','${var.unbox_id}')">提交</button>
																		</c:if>
																		<c:if test="${var.status == 3 }">
																			<button class="btn btn-sm btn-warning btn-sm" title="提交" type="button" onclick="restart('${var.id}','${var.unbox_id}')">重新提交</button>
																		</c:if>
																	</div>
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
										<div class="col-lg-12" style="padding-left:0px;padding-right:0px">
											<c:if test="${QX.add == 1 }">
												<button class="btn  btn-primary" title="新增" type="button" onclick="add();">新增</button>
											</c:if>
											<!-- <c:if test="${QX.del == 1 }">
												<button class="btn  btn-danger" title="批量删除" type="button" onclick="makeAll();">批量删除</button>						
											</c:if> -->
												${page.pageStr}
										</div>
										</div>

									</div>
								</div>
							</div>


							<div id="tab-2" class="tab-pane">
								<div class="ibox float-e-margins">
									
									<div class="ibox-content">
										<form role="form" class="form-inline" action="install/listSupplementPend.do" method="post" name="SupplementForm2" id="SupplementForm2">
				                            <div class="form-group form-inline" style="display:none">
				                                 <button type="submit" class="btn  btn-primary " style="margin-bottom:0px"><i style="font-size:18px;" class="fa fa-search"></i></button>
				                            </div>
				                        	<button class="btn  btn-success" title="刷新" type="button" style="margin-top: 5px;margin-left: 752px" onclick="refreshCurrentTab(2);">刷新</button>
			                        	</form>
										<div class="table-responsive">
			                            <table class="table table-striped table-bordered table-hover">
			                                <thead>
			                                    <tr>
			                                        <th style="width:5%;"><input type="checkbox" name="zcheckbox" id="zcheckbox" class="i-checks" ></th>
			                                        <th style="width:10%;">编号</th>
			                                        <th style="width:15%;">开箱报告编号</th>
			                                        <th style="width:15%;">申请人</th>
			                                        <th style="width:10%;">申请时间</th>
			                                        <th style="width:10%;">申请状态</th>
			                                        <th style="width:15%;">操作</th>
			                                    </tr>
			                                </thead>
			                                <tbody>
			                                <!-- 开始循环 -->	
											<c:choose>
												<c:when test="${not empty supplements}">
													<c:if test="${QX.cha == 1 }">
														<c:forEach items="${supplements}" var="var" >
															<tr>
																<td><input type="checkbox" class="i-checks" name='ids' id='${var.item_id }' value='${var.item_id }' ></td>
																<td>${var.id}</td>
																<td>${var.unbox_id}</td>
																<td>${var.name}</td>
																<td>${var.input_date}</td>
																<td>
																	${var.status=="1"?"新增":""}
																	${var.status=="2"?"已完成":""}
																</td>
																<td>
																	<c:if test="${QX.edit != 1 && QX.del != 1 }">
																		<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="icon-lock" title="无权限">无权限</i></span>
																	</c:if>
																	<div>
																		<c:if test="${var.type == 1 }">
																			<button class="btn btn-sm btn-success btn-sm" title="办理" type="button" onclick="handle('${var.task_id}','${var.id}')">办理</button>
																		</c:if>
																		<c:if test="${var.type == 0 }">
																			<button class="btn btn-sm btn-warning btn-sm" title="签收" type="button" onclick="claim('${var.task_id}')">签收</button>
																		</c:if>
																	</div>
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
										<div class="col-lg-12" style="padding-left:0px;padding-right:0px">
											<c:if test="${QX.add == 1 }">
												<button class="btn  btn-primary" title="新增" type="button" onclick="add();">新增</button>
											</c:if>
											<!-- <c:if test="${QX.del == 1 }">
												<button class="btn  btn-danger" title="批量删除" type="button" onclick="makeAll();">批量删除</button>						
											</c:if> -->
												${page.pageStr}
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
    <script src="static/js/sweetalert/sweetalert.min.js"></script>
	<script type="text/javascript">
	 $(document).ready(function () {
		 //loading end
		 parent.layer.closeAll('loading');
     	/* checkbox */
         $('.i-checks').iCheck({
             checkboxClass: 'icheckbox_square-green',
             radioClass: 'iradio_square-green',
         });
     	/* 图片 */
         $('.fancybox').fancybox({
             openEffect: 'none',
             closeEffect: 'none'
         });
         /* tab */
         var active = $("#active").val();
         if(active==""||active=="1"){
			 $("#nav-tab-1").addClass("active");
			 $("#tab-1").addClass("active");
         }else if(active=="2"){
			 $("#nav-tab-2").addClass("active");
			 $("#tab-2").addClass("active");
         }

     });
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
     	$("#SupplementForm"+id).submit();
     }
	//检索
	function search(id){
		$("#SupplementForm"+id).submit();
	}
	//新增
	function add(){
		$("#EditSupplement").kendoWindow({
	        width: "550px",
	        height: "300px",
	        title: "新增补件申请",
	        actions: ["Close"],
	        content: '<%=basePath%>install/goAddSupplement.do',
	        modal : true,
			visible : false,
			resizable : true
	    }).data("kendoWindow").maximize().open();
	}

	//提交流程
	function start(id,unbox_id){
		swal({
                title: "您确定要提交这条任务吗？",
                text: "提交后将会上报进行审核！",
                type: "warning",
                showCancelButton: true,
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "提交",
                cancelButtonText: "取消"
            },
            function (isConfirm) {
                if (isConfirm) {
                	var url = "<%=basePath%>install/startApply.do?id="+id+"&unbox_id="+unbox_id+"&tm="+new Date().getTime();;
    				$.get(url,function(data){
    					if(data.msg=='success'){
    						swal({   
    				        	title: "提交成功！",
    				        	text: "您已经成功提交了这个任务,请等待该任务办理。",
    				        	type: "success",  
    				        	 }, 
    				        	function(){   
    				        		 refreshCurrentTab(1); 
    				        	 });
    					}else{
    						swal("提交失败", "您的提交操作失败了！", "error");
    					}
    				});
                } else {
                    swal("已取消", "您取消了提交操作！", "error");
                }
            });
	}

	//重新提交
	function restart(id,unbox_id){
		swal({
                title: "您确定要重新提交这条任务吗？",
                text: "重新提交后将会上报进行审核！",
                type: "warning",
                showCancelButton: true,
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "提交",
                cancelButtonText: "取消"
            },
            function (isConfirm) {
                if (isConfirm) {
                	var url = "<%=basePath%>install/restartApply.do?id="+id+"&unbox_id="+unbox_id+"&tm="+new Date().getTime();;
    				$.get(url,function(data){
    					if(data.msg=='success'){
    						swal({   
    				        	title: "提交成功！",
    				        	text: "您已经成功提交了这个任务,请等待该任务办理。",
    				        	type: "success",  
    				        	 }, 
    				        	function(){   
    				        		 refreshCurrentTab(2); 
    				        	 });
    					}else{
    						swal("提交失败", "您的重新提交操作失败了！", "error");
    					}
    				});
                } else {
                    swal("已取消", "您取消了重新提交操作！", "error");
                }
            });
	}

	//签收任务
	function claim(task_id){
		swal({
                    title: "您确定要签收这条任务吗？",
                    text: "签收后请对该任务进行处理！",
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "签收",
                    cancelButtonText: "取消"
                },
                function (isConfirm) {
                    if (isConfirm) {
                    	var url = "<%=basePath%>install/claim.do?task_id="+task_id+"&tm="+new Date().getTime();;
        				$.get(url,function(data){
        					if(data.msg=='success'){
        						swal({   
        				        	title: "签收成功！",
        				        	text: "您已经成功签收了这个任务,请对该任务进行处理。",
        				        	type: "success",  
        				        	 }, 
        				        	function(){   
        				        		 refreshCurrentTab(2); 
        				        	 });
        					}else{
        						swal("签收失败", "您的签收操作失败了！", "error");
        					}
        				});
                    } else {
                        swal("已取消", "您取消了签收操作！", "error");
                    }
                });

	}

	//办理任务
	function handle(task_id,id){
		$("#HandleTask").kendoWindow({
	        width: "550px",
	        height: "300px",
	        title: "办理意见",
	        actions: ["Close"],
	        content: '<%=basePath%>install/goHandleTask.do?task_id='+task_id+'&id='+id,
	        modal : true,
			visible : false,
			resizable : true
	    }).data("kendoWindow").maximize().open();
	}

	//修改tab
	function tabChange(id){
		$("#SupplementForm"+id).submit();
	}

	function CloseSUWin(id) {
		window.parent.$("#" + id).data("kendoWindow").close();
		/* 	window.parent.location.reload(); */
	}
	</script>
</body>

</html>
