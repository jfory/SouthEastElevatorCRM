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
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Sweet Alert -->
	<link href="static/js/sweetalert2/sweetalert2.css" rel="stylesheet">
	<title>${pd.SYSNAME}</title>
</head>

<body class="gray-bg">
    <div id="setUpView" class="animated fadeIn"></div>
	<div id="top" name="top"></div>
    <div class="wrapper wrapper-content animated fadeInRight">
	        <div class="row">
				<div class="panel blank-panel">
					<div class="panel-body">
					<div class="ibox-content">
						<div class="table-responsive">
								<table class="table table-striped table-bordered table-hover">
									<thead>
									<tr>
										<th style="width:10%;">序号</th>
										<th style="width:40%;">常规梯</th>
										<th>操作</th>
									</tr>
									</thead>
									<tbody>
									<!-- 开始循环 -->
									<c:choose>
										<c:when test="${not empty modelsList}">
											<c:forEach items="${modelsList}" var="models" varStatus="vs1">
												<tr>
													<td class='center' style="width: 30px;">${vs1.index+1}</td>
													<td>${models.models_name }</td>
													<td>
													  <button class="btn  btn-primary btn-sm" title="配置" type="button" onclick="goWorkFlowSetUpEdit('${models.models_id }');">配置</button>
													</td>
												</tr>
											</c:forEach>
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
    
	<script type="text/javascript">
	 $(document).ready(function () {
     });

    	//刷新iframe
        function refreshCurrentTab(id) {
			//loading
			layer.load(1);
        	$("#leaveForm"+id).submit();
        }
		//检索
		function search(id){
			//loading
			layer.load(1);
			$("#leaveForm"+id).submit();
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
		
		function goWorkFlowSetUpEdit(models_id) {
			//用户任务则设置点击操作
            $("#setUpView").kendoWindow({
                width: "400px",
                height: "500px",
                title: "设置",
                actions: ["Close"],
                content: '<%=basePath%>workflow/goContractTechWorkFlowSetUpEdit?models_id='+models_id,
                modal : true,
                visible : false,
                resizable : true
            }).data("kendoWindow").center().open();
		}
		
	</script>
</body>
</html>
