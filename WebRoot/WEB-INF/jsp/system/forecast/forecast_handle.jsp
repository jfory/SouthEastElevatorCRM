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
    <div class="wrapper wrapper-content">
        <div class="row">
	            <div class="col-sm-12">
	                <div class="ibox float-e-margins">
	                    <div class="ibox-content">
	                    <div id="top",name="top"></div>
	                       <form role="form" class="form-inline" action="" method="post" name="forecastHistoryForm" id="forecastHistoryForm">
	                            <div class="form-group form-inline" style="display:none">
	                                 <button type="submit" class="btn  btn-primary " style="margin-bottom:0px"><i style="font-size:18px;" class="fa fa-search"></i></button>
	                            </div>
	                        	<button class="btn  btn-success" title="刷新" type="button" style="margin-top: 5px;margin-left: 752px" onclick="refreshCurrentTab();">刷新</button>
	                        </form>
	                        <div class="table-responsive">
	                            <table class="table table-striped table-bordered table-hover">
	                                <thead>
	                                    <tr>
	                                        <th style="width:5%;"><input type="checkbox" name="zcheckbox" id="zcheckbox" class="i-checks" ></th>
	                                        <th style="width:5%;">编号</th>
	                                        <th style="width:10%;">提交人</th>
	                                        <th style="width:10%;">上报状态</th>
	                                        <th style="width:10%;">是否跨区</th>
	                                        <th style="width:10%;">当月总台量</th>
	                                        <th style="width:10%;">月份编号</th>
	                                    </tr>
	                                </thead>
	                                <tbody>
	                                <!-- 开始循环 -->	
									<c:choose>
												<c:when test="${not empty forecastHistory}">
													<c:if test="${QX.cha == 1 }">
														<c:forEach items="${forecastHistory}" var="var" >
															<tr>
																<td><input type="checkbox" class="i-checks" name='ids' id='${var.id}' value='${var.id}' ></td>
																<td>${var.id}</td>
																<td>${var.user_name}</td>
																<td>
																	<c:if test="${var.status==0}">
																		未提交
																	</c:if>
																	<c:if test="${var.status==1}">
																		销售人员提交
																	</c:if>
																	<c:if test="${var.status==2}">
																		分公司经理汇总
																	</c:if>
																	<c:if test="${var.status==3}">
																		分公司经理提交
																	</c:if>
																	<c:if test="${var.status==4}">
																		区域经理汇总
																	</c:if>
																	<c:if test="${var.status==5}">
																		区域经理提交
																	</c:if>
																	<c:if test="${var.status==6}">
																		股份公司审阅
																	</c:if>
																</td>
																<td>${var.more_region==0?'否':'是'}</td>
																<td>${var.now_count}台</td>
																<td>${var.month_no}</td>
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
										${page.pageStr}
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
     function refreshCurrentTab() {
     	$("#OrdinaryTypeForm").submit();
     }
	//检索
	function search(){
		$("#OrdinaryTypeForm").submit();
	}
	function CloseSUWin(id) {
		window.parent.$("#" + id).data("kendoWindow").close();
		/* 	window.parent.location.reload(); */
	}
	</script>
</body>

</html>
