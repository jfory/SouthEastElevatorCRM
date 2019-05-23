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
	<div id="offsetQuota" class="animated fadeIn"></div>
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
									待认领
								</a>
							</li>
							<li id="nav-tab-2">
								<a data-toggle="tab" href="#tab-2" onclick="tabChange(2)">
									<i class="fa fa-hourglass"></i>
									已认领
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
									<form role="form" class="form-inline" action="collect/listInfoForQuota.do" method="post" name="DetailsForm1" id="DetailsForm1">
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
			                                        <th style="width:10%;">项目id</th>
			                                        <th style="width:10%;">阶段</th>
			                                        <th style="width:10%;">金额</th>
			                                        <th style="width:15%;">操作</th>
			                                    </tr>
			                                </thead>
			                                <tbody>
			                                <!-- 开始循环 -->	
											<c:choose>
												<c:when test="${not empty infoList}">
													<c:if test="${QX.cha == 1 }">
														<c:forEach items="${infoList}" var="var" >
															<tr>
																<td><input type="checkbox" class="i-checks" name='ids' id='${var.id }' value='${var.id }' ></td>
																<td>${var.uuid}</td>
																<td>${var.item_id}</td>
																<td>${var.stage}</td>
																<td>${var.money}</td>
																<td>
																	<c:if test="${QX.edit != 1 && QX.del != 1 }">
																		<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="icon-lock" title="无权限">无权限</i></span>
																	</c:if>
																	<div>
																		<c:if test="${var.status == 1}">
																			<button class="btn btn-sm btn-primary btn-sm" title="认领" type="button" onclick="claim('${var.uuid}')">认领</button>
																		</c:if>
																		<c:if test="${var.status == 2}">
																			<button class="btn btn-sm btn-default btn-sm" title="已认领" type="button">已认领</button>
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
									<form role="form" class="form-inline" action="collect/listQuota.do" method="post" name="DetailsForm2" id="DetailsForm2">
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
			                                        <th style="width:10%;">编号</th>
			                                        <th style="width:10%;">分款编号</th>
			                                        <th style="width:10%;">操作</th>
			                                    </tr>
			                                </thead>
			                                <tbody>
			                                <!-- 开始循环 -->	
											<c:choose>
												<c:when test="${not empty quotaList}">
													<c:if test="${QX.cha == 1 }">
														<c:forEach items="${quotaList}" var="var" >
															<tr>
																<td><input type="checkbox" class="i-checks" name='ids' id='${var.id }' value='${var.id }' ></td>
																<td>${var.id}</td>
																<td>${var.info_id}</td>
																<td>
																	<c:if test="${QX.edit != 1 && QX.del != 1 }">
																		<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="icon-lock" title="无权限">无权限</i></span>
																	</c:if>
																	<div>
																		<button class="btn btn-sm btn-primary btn-sm" title="核销" type="button" onclick="offset('${var.info_id}')">核销</button>
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


	//认领
	function claim(uuid){
		$.post("<%=basePath%>collect/claimInfo.do?uuid="+uuid,
			function(data){
				refreshCurrentTab(1);
			}
		);
	}

	//核销
	function offset(info_id){
        	$("#offsetQuota").kendoWindow({
		        width: "1000px",
		        height: "600px",
		        title: "核销",
		        actions: ["Close"],
		        content: '<%=basePath%>collect/offsetQuota.do?info_id='+info_id,
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").maximize().open();
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
