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
	<input type="hidden" id="active" value="${active}">
	<div id="correctReport" class="animated fadeIn"></div>
	<div id="govAcceptReport" class="animated fadeIn"></div>
    <div class="wrapper wrapper-content">
    	<div class="row">
        	<div class="panel blank-panel">
				<div class="panel-heading">
					<div class="panel-options">
						<ul class="nav nav-tabs">
							<li id="nav-tab-1">
								<a class="count-info-sm" data-toggle="tab" href="#tab-1" onclick="tabChange(1)">
									<i class="fa fa-hourglass-2"></i>
									待整改
								</a>
							</li>
							<li id="nav-tab-2">
								<a data-toggle="tab" href="#tab-2" onclick="tabChange(2)">
									<i class="fa fa-hourglass"></i>
									已整改
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
									<form role="form" class="form-inline" action="install/listCorrect.do" method="post" name="CorrectForm1" id="CorrectForm1">
										<div class="form-group" style="width:100%">
			                        		<button class="btn  btn-success" title="刷新" type="button" style="margin-top: 5px;float:right" onclick="refreshCurrentTab(1);">刷新</button>
			                        	</div>
		                        	</form>
		                        	<div class="table-responsive">
			                           	<table class="table table-striped table-bordered table-hover">
			                                <thead>
			                                    <tr>
			                                        <th style="width:5%;"><input type="checkbox" name="zcheckbox" id="zcheckbox" class="i-checks" ></th>
			                                        <th style="width:10%;">编号</th>
			                                        <th style="width:10%;">电梯编号</th>
			                                        <th style="width:10%;">梯种</th>
			                                        <th style="width:10%;">所属项目</th>
			                                        <th style="width:15%;">操作</th>
			                                    </tr>
			                                </thead>
			                                <tbody>
			                                <!-- 开始循环 -->	
											<c:choose>
												<c:when test="${not empty correctList}">
													<c:if test="${QX.cha == 1 }">
														<c:forEach items="${correctList}" var="var" >
															<tr>
																<td><input type="checkbox" class="i-checks" name='ids' id='${var.id }' value='${var.id }' ></td>
																<td>${var.id}</td>
																<td>${var.no}</td>
																<td>${var.elevator_name }</td>
																<td>${var.item_name }</td>
																<td>
																	<c:if test="${QX.edit != 1 && QX.del != 1 }">
																		<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="icon-lock" title="无权限">无权限</i></span>
																	</c:if>
																	<div>
																		<c:if test="${var.init == 0 }">
																			<button class="btn btn-sm btn-primary btn-sm" title="整改报告" type="button" onclick="correctReport('${var.id}','${var.details_id}');">整改报告</button>
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


						<div id="tab-2" class="tab-pane">
							<div class="ibox float-e-margins">
								
								<div class="ibox-content">
									<form role="form" class="form-inline" action="install/listCorrectDone.do" method="post" name="CorrectForm2" id="CorrectForm2">
										<div class="form-group" style="width:100%">
			                        		<button class="btn  btn-success" title="刷新" type="button" style="margin-top: 5px;float:right" onclick="refreshCurrentTab(2);">刷新</button>
			                        	</div>
		                        	</form>
		                        	<div class="table-responsive">
		                        		<table class="table table-striped table-bordered table-hover">
			                                <thead>
			                                    <tr>
			                                        <th style="width:5%;"><input type="checkbox" name="zcheckbox" id="zcheckbox" class="i-checks" ></th>
			                                        <th style="width:10%;">编号</th>
			                                        <th style="width:10%;">电梯编号</th>
			                                        <th style="width:10%;">梯种</th>
			                                        <th style="width:10%;">所属项目</th>
			                                        <th style="width:15%;">操作</th>
			                                    </tr>
			                                </thead>
			                                <tbody>
			                                <!-- 开始循环 -->	
											<c:choose>
												<c:when test="${not empty correctDoneList}">
													<c:if test="${QX.cha == 1 }">
														<c:forEach items="${correctDoneList}" var="var" >
															<tr>
																<td><input type="checkbox" class="i-checks" name='ids' id='${var.id }' value='${var.id }' ></td>
																<td>${var.id}</td>
																<td>${var.no}</td>
																<td>${var.elevator_name }</td>
																<td>${var.item_name }</td>
																<td>
																	<c:if test="${QX.edit != 1 && QX.del != 1 }">
																		<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="icon-lock" title="无权限">无权限</i></span>
																	</c:if>
																	<div>
																		<c:if test="${var.status == 0 && var.init ==  0}">
																			<button class="btn btn-sm btn-primary btn-sm" title="验收结果" type="button" onclick="govAccept('${var.id}','${var.details_id}');">验收结果</button>
																		</c:if>
																		<c:if test="${var.init == 1 }">
																			<button class="btn btn-sm btn-primary btn-sm" title="验收结果" type="button" onclick="govAccept('${var.id}','${var.details_id}');">验收结果</button>
																		</c:if>
																		<c:if test="${var.init == 2 }">
																			<button class="btn btn-sm btn-default btn-sm" title="已验收" type="button">已验收</button>
																			<button class="btn btn-sm btn-success btn-sm" title="验收报告" type="button" onclick="goAddGovReport('${var.id}','${var.details_id}')">验收报告</button>
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
     

	//整改报告
	function correctReport(id,details_id){
		$("#correctReport").kendoWindow({
	        width: "550px",
	        height: "300px",
	        title: "编辑整改报告",
	        actions: ["Close"],
	        content: '<%=basePath%>install/toAddCorrectReport.do?id='+id+"&details_id="+details_id,
	        modal : true,
			visible : false,
			resizable : true
	    }).data("kendoWindow").maximize().open();
	}

	//政府验收结果
	function govAccept(id,details_id){
		swal({
            title: "该电梯是否已经通过政府验收?",
            text: "请核实电梯信息后操作,点击未通过会重新进入整改环节",
            type: "warning",
            showCancelButton: true,
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "已通过",
            cancelButtonText: "未通过"
        },
        function (isConfirm) {
            if (isConfirm) {
            	var url = "<%=basePath%>install/govAccept.do?details_id="+details_id+"&id="+id+"&init=2&tm="+new Date().getTime();;
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
            	var url = "<%=basePath%>install/govAccept.do?details_id="+details_id+"&id="+id+"&init=0&tm="+new Date().getTime();;
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

	//验收报告
	function goAddGovReport(id,details_id){
		$("#govAcceptReport").kendoWindow({
	        width: "550px",
	        height: "300px",
	        title: "编辑政府验收报告",
	        actions: ["Close"],
	        content: '<%=basePath%>install/goAddGovAcceptReport.do?id='+id+'&details_id='+details_id,
	        modal : true,
			visible : false,
			resizable : true
	    }).data("kendoWindow").maximize().open();
	}

	//修改tab
	function tabChange(id){
		$("#CorrectForm"+id).submit();
	}

	//刷新iframe
    function refreshCurrentTab(id) {
     	$("#CorrectForm"+id).submit();
    }

	function CloseSUWin(id) {
		window.parent.$("#" + id).data("kendoWindow").close();
		/* 	window.parent.location.reload(); */
	}
	</script>
</body>

</html>
