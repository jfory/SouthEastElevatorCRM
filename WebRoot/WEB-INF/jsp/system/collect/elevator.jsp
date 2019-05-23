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

<body class="gray-bg">
	<form name="elevatorForm" id="elevatorForm" action="collect/saveElevator.do" method="post">
	<input type="hidden" name="data" id="data">
	<input type="hidden" value="${stage}" id="stage" name="stage">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-content"> 
                    	<div class="row">
							<div class="col-sm-12">
								<div class="panel panel-primary">
						            <div class="panel-heading">
						                设置电梯
						            </div>
						            <div class="panel-body">
				                        <div class="table-responsive">
				                            <table id="tab" class="table table-striped table-bordered table-hover">
				                                <thead>
				                                    <tr>
				                                        <th style="width:3%;">电梯编号</th>
				                                        <th style="width:5%;">款项</th>
				                                    </tr>
				                                </thead>
				                                <tbody>
				                                <!-- 开始循环 -->
												<c:choose>
													<c:when test="${not empty elevatorList}">
														<c:if test="${QX.cha == 1 }">
															<c:forEach items="${elevatorList}" var="var">
																<tr>
																	<td><input type="hidden" value="${var.id}"/>${var.no}</td>
																	<td><input type="text" class="form-control" value="${var.total}"/></td>
																</tr>
															</c:forEach>
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
											<tr>
											<c:if test="${operateType!='sel'}">
												<td>
													<a class="btn btn-primary" style="width: 150px; height:34px;float:left;"  onclick="save();">保存</a>
												</td>					
											</c:if>	
											<td>
												<a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('Elevator');">关闭</a>
											</td>
											</tr>
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
    </form>
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
        });


        //保存
        function save(){

			var jsonStr="[";
			var details_id;
			var total;
			$("#tab tr:not(:first)").each(function(){
				details_id = $(this).find("td").eq(0).find("input").eq(0).val();
				total = $(this).find("td").eq(1).find("input").eq(0).val();
				jsonStr += "{'details_id':'"+details_id+"','total':'"+total+"'},";
			});
			jsonStr = jsonStr.substring(0,jsonStr.length-1)+"]";

			$("#data").val(jsonStr);
			$("#elevatorForm").submit();

        }

        function CloseSUWin(id) {
			window.parent.$("#" + id).data("kendoWindow").close();
			/* 	window.parent.location.reload(); */
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


