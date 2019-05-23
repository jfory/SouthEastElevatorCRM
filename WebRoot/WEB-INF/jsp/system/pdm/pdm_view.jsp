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
										GCXM
									</a>
								</li>
								<li id="nav-tab-2">
									<a data-toggle="tab" href="#tab-2" onclick="tabChange(2)">
										<i class="fa fa-hourglass"></i>
										XMPZ
									</a>
								</li>
								<li id="nav-tab-3">
									<a data-toggle="tab" href="#tab-3" onclick="tabChange(3)">
										<i class="fa fa-hourglass"></i>
										XMPZCS
									</a>
								</li>
								<li id="nav-tab-4">
									<a data-toggle="tab" href="#tab-4" onclick="tabChange(4)">
										<i class="fa fa-hourglass"></i>
										DZGX
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
										<form role="form" class="form-inline" action="pdm/toGCXM.do" method="post" name="PDMForm1" id="PDMForm1">
				                            <div class="form-group form-inline" style="width:100%">
				                                 <input type="button" class="btn btn-primary" style="margin-bottom:0px;margin-left:86%;margin-top:5px;" value="上传数据" onclick="uploadGCXM();">
				                                 <button class="btn  btn-success" title="刷新" type="button" style="margin-top: 5px;float:right"; onclick="refreshCurrentTab(1);">刷新
				                                 </button>
				                            </div>
				                        	
			                        	</form>
										<div class="table-responsive">
			                            <table class="table table-striped table-bordered table-hover">
			                                <thead>
			                                    <tr>
			                                        <th style="width:5%;"><input type="checkbox" name="zcheckbox" id="zcheckbox" class="i-checks" ></th>
			                                        <th style="width:10%;">主键</th>
			                                        <th style="width:15%;">编号</th>
			                                        <th style="width:15%;">创建时间</th>
			                                        <th style="width:10%;">创建人</th>
			                                        <th style="width:10%;">状态</th>
			                                        <th style="width:15%;">操作</th>
			                                    </tr>
			                                </thead>
			                                <tbody>
			                                <!-- 开始循环 -->	
											<c:choose>
												<c:when test="${not empty GCXM}">
													<c:if test="${QX.cha == 1 }">
														<c:forEach items="${GCXM}" var="var" >
															<tr>
																<td><input type="checkbox" class="i-checks" name='ids' id='${var.item_id }' value='${var.item_id }' ></td>
																<td>${var.id}</td>
																<td>${var.no}</td>
																<td>${var.input_date}</td>
																<td>${var.input_user}</td>
																<td>${var.status}</td>
																<td>
																	<c:if test="${QX.edit != 1 && QX.del != 1 }">
																		<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="icon-lock" title="无权限">无权限</i></span>
																	</c:if>
																	<div>
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
										${page.pageStr}
										</div>

									</div>
								</div>
							</div>


							<div id="tab-2" class="tab-pane">
								<div class="ibox float-e-margins">
									
									<div class="ibox-content">
										<form role="form" class="form-inline" action="pdm/toXMPZ.do" method="post" name="PDMForm2" id="PDMForm2">
				                            <div class="form-group form-inline" style="width:100%">
				                                <input type="button" class="btn btn-primary" style="margin-bottom:0px;margin-left:86%;margin-top:5px" value="上传数据" onclick="uploadXMPZ();">
				                        		<button class="btn  btn-success" title="刷新" type="button" style="margin-top: 5px;float:right" onclick="refreshCurrentTab(2);">刷新</button>
				                            </div>
			                        	</form>
										<div class="table-responsive">
			                            <table class="table table-striped table-bordered table-hover">
			                                <thead>
			                                    <tr>
			                                        <th style="width:5%;"><input type="checkbox" name="zcheckbox" id="zcheckbox" class="i-checks" ></th>
			                                        <th style="width:10%;">主键</th>
			                                        <th style="width:15%;">编号</th>
			                                        <th style="width:15%;">创建时间</th>
			                                        <th style="width:10%;">创建人</th>
			                                        <th style="width:10%;">状态</th>
			                                        <th style="width:15%;">操作</th>
			                                    </tr>
			                                </thead>
			                                <tbody>
			                                <!-- 开始循环 -->	
											<c:choose>
												<c:when test="${not empty XMPZ}">
													<c:if test="${QX.cha == 1 }">
														<c:forEach items="${XMPZ}" var="var" >
															<tr>
																<td><input type="checkbox" class="i-checks" name='ids' id='${var.item_id }' value='${var.item_id }' ></td>
																<td>${var.id}</td>
																<td>${var.no}</td>
																<td>${var.input_date}</td>
																<td>${var.input_user}</td>
																<td>${var.status}</td>
																<td>
																	<c:if test="${QX.edit != 1 && QX.del != 1 }">
																		<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="icon-lock" title="无权限">无权限</i></span>
																	</c:if>
																	<div>
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
										${page.pageStr}
										</div>

									</div>
								</div>
							</div>

							<div id="tab-3" class="tab-pane">
								<div class="ibox float-e-margins">
									
									<div class="ibox-content">
										<form role="form" class="form-inline" action="pdm/toXMPZCS.do" method="post" name="PDMForm3" id="PDMForm3">
				                            <div class="form-group form-inline" style="width:100%">
				                                <input type="button" class="btn btn-primary" style="margin-bottom:0px;margin-top:5px;margin-left:86%" value="上传数据" onclick="uploadXMPZCS();">
				                        		<button class="btn  btn-success" title="刷新" type="button" style="margin-top: 5px;float:right" onclick="refreshCurrentTab(3);">刷新</button>
				                            </div>
			                        	</form>
										<div class="table-responsive">
			                            <table class="table table-striped table-bordered table-hover">
			                                <thead>
			                                    <tr>
			                                        <th style="width:5%;"><input type="checkbox" name="zcheckbox" id="zcheckbox" class="i-checks" ></th>
			                                        <th style="width:10%;">主键</th>
			                                        <th style="width:15%;">编号</th>
			                                        <th style="width:15%;">创建时间</th>
			                                        <th style="width:10%;">创建人</th>
			                                        <th style="width:10%;">状态</th>
			                                        <th style="width:15%;">操作</th>
			                                    </tr>
			                                </thead>
			                                <tbody>
			                                <!-- 开始循环 -->	
											<c:choose>
												<c:when test="${not empty XMPZCS}">
													<c:if test="${QX.cha == 1 }">
														<c:forEach items="${XMPZCS}" var="var" >
															<tr>
																<td><input type="checkbox" class="i-checks" name='ids' id='${var.item_id }' value='${var.item_id }' ></td>
																<td>${var.id}</td>
																<td>${var.no}</td>
																<td>${var.input_date}</td>
																<td>${var.input_user}</td>
																<td>${var.status}</td>
																<td>
																	<c:if test="${QX.edit != 1 && QX.del != 1 }">
																		<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="icon-lock" title="无权限">无权限</i></span>
																	</c:if>
																	<div>
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
										${page.pageStr}
										</div>

									</div>
								</div>
							</div>

							<div id="tab-4" class="tab-pane">
								<div class="ibox float-e-margins">
									
									<div class="ibox-content">
										<form role="form" class="form-inline" action="pdm/toDZGX.do" method="post" name="PDMForm4" id="PDMForm4">
				                            <div class="form-group form-inline" style="width:100%">
				                                <input type="button" class="btn btn-primary" style="margin-bottom:0px;margin-top:5px;margin-left:86%" value="上传数据" onclick="uploadDZGX();">
				                        		<button class="btn  btn-success" title="刷新" type="button" style="margin-top: 5px;float:right" onclick="refreshCurrentTab(4);">刷新</button>
				                            </div>
			                        	</form>
										<div class="table-responsive">
			                            <table class="table table-striped table-bordered table-hover">
			                                <thead>
			                                    <tr>
			                                        <th style="width:5%;"><input type="checkbox" name="zcheckbox" id="zcheckbox" class="i-checks" ></th>
			                                        <th style="width:10%;">主键</th>
			                                        <th style="width:15%;">编号</th>
			                                        <th style="width:15%;">创建时间</th>
			                                        <th style="width:10%;">创建人</th>
			                                        <th style="width:10%;">状态</th>
			                                        <th style="width:15%;">操作</th>
			                                    </tr>
			                                </thead>
			                                <tbody>
			                                <!-- 开始循环 -->	
											<c:choose>
												<c:when test="${not empty DZGX}">
													<c:if test="${QX.cha == 1 }">
														<c:forEach items="${DZGX}" var="var" >
															<tr>
																<td><input type="checkbox" class="i-checks" name='ids' id='${var.item_id }' value='${var.item_id }' ></td>
																<td>${var.id}</td>
																<td>${var.no}</td>
																<td>${var.input_date}</td>
																<td>${var.input_user}</td>
																<td>${var.status}</td>
																<td>
																	<c:if test="${QX.edit != 1 && QX.del != 1 }">
																		<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="icon-lock" title="无权限">无权限</i></span>
																	</c:if>
																	<div>
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
         }else if(active=="3"){
			 $("#nav-tab-3").addClass("active");
			 $("#tab-3").addClass("active");
         }else if(active=="4"){
			 $("#nav-tab-4").addClass("active");
			 $("#tab-4").addClass("active");
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


    //上传GCXM
    function uploadGCXM(){
    	$.post("<%=basePath%>pdm/uploadGCXM.do",
    		function(data){
    			if(data.msg=="success"){
    				refreshCurrentTab(1);
    			}
    		});
    }

    //上传XMPZ
    function uploadXMPZ(){
    	$.post("<%=basePath%>pdm/uploadXMPZ.do",
    		function(data){
    			if(data.msg=="success"){
    				refreshCurrentTab(2);
    			}
    		});
    }


    //上传XMPZCS
    function uploadXMPZCS(){
    	$.post("<%=basePath%>pdm/uploadXMPZCS.do",
    		function(data){
    			if(data.msg=="success"){
    				refreshCurrentTab(3);
    			}
    		});
    }


    //上传DZGX
    function uploadDZGX(){
    	$.post("<%=basePath%>pdm/uploadDZGX.do",
    		function(data){
    			if(data.msg=="success"){
    				refreshCurrentTab(4);
    			}
    		});
    }
     
   	//刷新iframe
     function refreshCurrentTab(id) {
     	$("#PDMForm"+id).submit();
     }
	//检索
	function search(id){
		$("#PDMForm"+id).submit();
	}

	//修改tab
	function tabChange(id){
		$("#PDMForm"+id).submit();
	}

	function CloseSUWin(id) {
		window.parent.$("#" + id).data("kendoWindow").close();
		/* 	window.parent.location.reload(); */
	}
	</script>
</body>

</html>
