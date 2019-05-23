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
	<div id="AdjustReport" class="animated fadeIn"></div>
	<div id="SelfcheckReport" class="animated fadeIn"></div>
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
									待安装
								</a>
							</li>
							<li id="nav-tab-2">
								<a data-toggle="tab" href="#tab-2" onclick="tabChange(2)">
									<i class="fa fa-hourglass"></i>
									已安装
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
									<form role="form" class="form-inline" action="install/installElevatorList.do?item_id=${item_id}" method="post" name="DetailsForm1" id="DetailsForm1">
										<div class="form-group" style="width:100%">
			                        		<button class="btn  btn-success" title="刷新" type="button" style="margin-top: 5px;float:right" onclick="refreshCurrentTab(1);">刷新</button>
			                        	</div>
		                        	</form>
		                        	<div class="table-responsive">
			                           	<table class="table table-striped table-bordered table-hover">
			                                <thead>
			                                    <tr>
			                                        <th style="width:5%;"><input type="checkbox" name="zcheckbox" id="zcheckbox" class="i-checks" ></th>
			                                        <th style="width:10%;">梯号</th>
			                                        <th style="width:10%;">工号</th>
			                                        <th style="width:10%;">梯种</th>
			                                        <th style="width:10%;">型号</th>
			                                        <th style="width:15%;">操作</th>
			                                    </tr>
			                                </thead>
			                                <tbody>
			                                <!-- 开始循环 -->	
											<c:choose>
												<c:when test="${not empty installList}">
													<c:if test="${QX.cha == 1 }">
														<c:forEach items="${installList}" var="var" >
															<tr>
																<td><input type="checkbox" class="i-checks" name='ids' id='${var.id }' value='${var.id }' ></td>
																<td>${var.id}</td>
																<td>${var.no}</td>
																<td>${var.elevator_name }</td>
																<td>${var.models_name }</td>
																<td>
																	<c:if test="${QX.edit != 1 && QX.del != 1 }">
																		<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="icon-lock" title="无权限">无权限</i></span>
																	</c:if>
																	<div>
																		<button class="btn btn-sm btn-primary btn-sm" title="自检" type="button" onclick="selfcheck('${var.id}','${var.models_id}','${var.flag}');">自检</button>
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
									</div>
									<div class="col-lg-12" style="padding-left:0px;padding-right:0px">
											${page.pageStr}
									</div>
									</div>

							</div>
						</div>


						<div id="tab-2" class="tab-pane">
							<div class="ibox float-e-margins">
								
								<div class="ibox-content">
									<form role="form" class="form-inline" action="install/installedElevatorList.do?item_id=${item_id}" method="post" name="DetailsForm2" id="DetailsForm2">
	                       				<input type="hidden" name="item_id" value="${item_id}">
										<div class="form-group" style="width:100%">
			                        		<button class="btn  btn-success" title="刷新" type="button" style="margin-top: 5px;float:right" onclick="refreshCurrentTab(2);">刷新</button>
			                        	</div>
		                        	</form>
		                        	<div class="table-responsive">
		                        		<table class="table table-striped table-bordered table-hover">
			                                <thead>
			                                    <tr>
			                                        <th style="width:5%;"><input type="checkbox" name="zcheckbox" id="zcheckbox" class="i-checks" ></th>
			                                        <th style="width:10%;">梯号</th>
			                                        <th style="width:10%;">工号</th>
			                                        <th style="width:10%;">梯种</th>
			                                        <th style="width:10%;">型号</th>
			                                        <th style="width:15%;">操作</th>
			                                    </tr>
			                                </thead>
			                                <tbody>
			                                <!-- 开始循环 -->	
											<c:choose>
												<c:when test="${not empty installedList}">
													<c:if test="${QX.cha == 1 }">
														<c:forEach items="${installedList}" var="var" >
															<tr>
																<td><input type="checkbox" class="i-checks" name='ids' id='${var.id }' value='${var.id }' ></td>
																<td>${var.id}</td>
																<td>${var.no}</td>
																<td>${var.elevator_name }</td>
																<td>${var.models_name }</td>
																<td>
																	<c:if test="${QX.edit != 1 && QX.del != 1 }">
																		<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="icon-lock" title="无权限">无权限</i></span>
																	</c:if>
																	<div>
																		<c:if test="${var.status == 3 }">
																			<button class="btn btn-sm btn-primary btn-sm" title="调试申请" type="button" onclick="adjust('${var.qc_id}','${var.elevator_id}','1','${var.details_id}');">调试申请</button>
																		</c:if>
																		<c:if test="${var.status == 30 }">
																			<button class="btn btn-sm btn-default btn-sm" title="调试申请中" type="button">调试申请中</button>
																		</c:if>
																		<c:if test="${var.status == 4 }">
																			<button class="btn btn-sm btn-info btn-sm" title="调试报告" type="button" onclick="adjustReport('${var.details_id}','1');">调试报告</button>
																		</c:if>
																		<c:if test="${var.status == 5 }">
																			<button class="btn btn-sm btn-info btn-sm" title="调试报告" type="button" onclick="adjust('${var.qc_id}','${var.elevator_id}','2','${var.details_id}');">厂检申请</button>
																		</c:if>
																		<c:if test="${var.status == 50 }">
																			<button class="btn btn-sm btn-default btn-sm" title="调试报告" type="button">厂检申请中</button>
																		</c:if>
																		<c:if test="${var.status == 6 }">
																			<button class="btn btn-sm btn-info btn-sm" title="厂检报告" type="button" onclick="adjustReport('${var.details_id}','2');">厂检报告</button>
																		</c:if>
																		<c:if test="${var.status == 7 }">
																			<button class="btn btn-sm btn-info btn-sm" title="整改" type="button" onclick="correct('${var.details_id}');">整改</button>
																		</c:if>
																		<c:if test="${var.status == 70 }">
																			<button class="btn btn-sm btn-default btn-sm" title="整改中" type="button">整改中</button>
																		</c:if>
																		<c:if test="${var.status == 71 }">
																			<button class="btn btn-sm btn-default btn-sm" title="等待验收" type="button">等待验收</button>
																		</c:if>
																		<c:if test="${var.status == 72 }">
																			<button class="btn btn-sm btn-default btn-sm" title="已验收" type="button">已验收</button>
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
									</div>
									<div class="col-lg-12" style="padding-left:0px;padding-right:0px">
											${page.pageStr}
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
     
	//检索
	function search(){
		$("#DetailsForm").submit();
	}

	//提交调试申请
	function adjust(qc_id,elevator_id,type,details_id){
		swal({
                    title: "您确定要提交调试申请吗？",
                    text: "",
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "确定",
                    cancelButtonText: "取消"
                },
                function (isConfirm) {
                    if (isConfirm) {
                    	var url = "<%=basePath%>install/addAdjust.do?details_id="+details_id+"&type="+type+"&qc_id="+qc_id+"&elevator_id="+elevator_id+"&tm="+new Date().getTime();;
        				$.get(url,function(data){
        					if(data.msg=='success'){
        						swal({   
        				        	title: "提交成功！",
        				        	text: "您已经成功执行了提交操作。",
        				        	type: "success",  
        				        	 }, 
        				        	function(){   
        				        		 refreshCurrentTab(2); 
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

	//跳转到调试报告页面
	function adjustReport(details_id,type){
		$("#AdjustReport").kendoWindow({
	        width: "550px",
	        height: "300px",
	        title: "派工调试报告",
	        actions: ["Close"],
	        content: '<%=basePath%>install/toAdjustReport.do?details_id='+details_id+"&type="+type,
	        modal : true,
			visible : false,
			resizable : true
	    }).data("kendoWindow").maximize().open();
	}

	//查看
	function selfcheck(id,models_id,flag){
		$("#SelfcheckReport").kendoWindow({
	        width: "550px",
	        height: "300px",
	        title: "录入自检信息",
	        actions: ["Close"],
	        content: '<%=basePath%>install/selfcheckReport.do?id='+id+"&models_id="+models_id+"&flag="+flag,
	        modal : true,
			visible : false,
			resizable : true
	    }).data("kendoWindow").maximize().open();
	}

	//整改
	function correct(details_id){
		swal({
            title: "该梯是否需要整改？",
            text: "",
            type: "warning",
            showCancelButton: true,
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "是",
            cancelButtonText: "否"
        },
        function (isConfirm) {
            if (isConfirm) {
            	var url = "<%=basePath%>install/addCorrect.do?details_id="+details_id+"&status=1&tm="+new Date().getTime();;
				$.get(url,function(data){
					if(data.msg=='success'){
						swal({   
				        	title: "操作成功！",
				        	text: "您已经成功执行了操作。",
				        	type: "success",  
				        	 }, 
				        	function(){   
				        		 refreshCurrentTab(2); 
				        	 });
					}else{
						swal("操作失败", "操作失败了！", "error");
					}
				});
            } else {
            	var url = "<%=basePath%>install/addCorrect.do?details_id="+details_id+"&status=0&tm="+new Date().getTime();;
				$.get(url,function(data){
					if(data.msg=='success'){
						swal({   
				        	title: "操作成功！",
				        	text: "您已经成功执行了操作。",
				        	type: "success",  
				        	 }, 
				        	function(){   
				        		 refreshCurrentTab(2); 
				        	 });
					}else{
						swal("操作失败", "操作失败了！", "error");
					}
				});
            }
        });
	}


	//修改tab
	function tabChange(id){
		$("#DetailsForm"+id).submit();
	}

	//刷新iframe
    function refreshCurrentTab(id) {
     	$("#DetailsForm"+id).submit();
    }

	function CloseSUWin(id) {
		window.parent.$("#" + id).data("kendoWindow").close();
		/* 	window.parent.location.reload(); */
	}
	</script>
</body>

</html>
