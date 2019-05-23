<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
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
	<!-- 选择报价页面 -->
	<div id="QuoteSelectHTML" class="animated fadeIn"></div>
	<!-- 合同录入界面 -->
	<div id="InformationHTML" class="animated fadeIn"></div>
	<!-- 合同变更 -->
	<div id="ChangeIncontractHTML" class="animated fadeIn"></div>
	
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-content">
						<div id="top" ,name="top"></div>
						
						<form role="form" class="form-inline" action="contractNewInstallation/goSoContract.do"
							method="post" name="ContractNewForm" id="ContractNewForm">

							<div class="form-group ">
								<input class="form-control" id="item_name" type="text" 
								name="item_name" value="${pd.item_name}" placeholder="项目名称">
							</div>
							<div class="form-group ">
								<input class="form-control" type="text" id="HT_NO" name="HT_NO" 
								value="${pd.HT_NO}" placeholder="合同编号">
							</div>
							<%-- <div class="form-group ">
								<select class="form-control" id="ACT_STATUS" name='ACT_STATUS'>
			                    	<option value=''>状态</option>
			                        <option value='1' ${pd.ACT_STATUS=='1'?'selected':''}>新建</option>
			                        <option value='2' ${pd.ACT_STATUS=='2'?'selected':''}>待审批</option>
			                        <option value='3' ${pd.ACT_STATUS=='3'?'selected':''}>审批中</option>
			                        <option value='4' ${pd.ACT_STATUS=='4'?'selected':''}>通过</option>
			                        <option value='5' ${pd.ACT_STATUS=='5'?'selected':''}>不通过</option>
			                        
			                    </select>
							</div> --%>
							<div class="form-group">
								<button type="submit" class="btn  btn-primary"
									style="margin-bottom: 0px;" title="查询">查询
								</button>
							</div> 
							<!-- <div class="form-group">
								<button type="button" class="btn  btn-primary"
									style="margin-bottom: 0px;" title="新建" 
									onclick="CNadd();">新建
								</button>
							</div> -->
							
							<button class="btn  btn-success" title="刷新" type="button"
								style="float: right" onclick="refreshCurrentTab();">刷新
							</button>
						</form>
						
						<div class="row">
							</br>
						</div>
						<div class="table-responsive">
							<table class="table table-striped table-bordered table-hover">
								<thead>
									<tr>
										<th>合同编号</th>
										<th>项目名称</th>
										<th>客户名称</th>
										<th>电梯台数</th>
										<th>业务员</th>
										<th>总价格</th>
										<th>状态</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody>
									<!-- 开始循环 -->
									<c:choose>
										<c:when test="${not empty contractNewList}">
											<c:if test="${QX.cha == 1 }">
												<c:forEach items="${contractNewList}" var="con" varStatus="vs">
													<tr>
														<td style="width:40px">${con.HT_NO}</td>
														<td>${con.item_name}</td>
														<td>${con.customer_name}</td>
														<td>${con.DT_NUM}</td>
														<td>${con.USER_NAME}</td>
														<td>${con.PRICE}</td>
														<c:if test="${con.ACT_STATUS == '5'}">
														  <td style="color: red;">${con.ACT_STATUS}</td>
														</c:if>
														<c:if test="${con.ACT_STATUS != '5'}">
														  <td>${con.ACT_STATUS}</td>
														</c:if>
														
														<td>
															<!-- 公共 -->
															<button class="btn btn-sm btn-info" title="查看"
																type="button" onclick="CNselect('${con.HT_UUID}');">查看
															</button>
															<button class="btn btn-sm btn-info" title="选择"
																type="button" onclick="CNQSpick('${con.HT_UUID}','${con.HT_ITEM_ID}');">选择
															</button>
														</td>
													</tr>
												</c:forEach>
											</c:if>
											<!-- 权限设置 -->
											<c:if test="${QX.cha == 0 }">
												<tr>
													<td colspan="100" class="center">您无权查看</td>
												</tr>
											</c:if>
										</c:when>
										<c:otherwise>
											<tr class="main_info">
												<td colspan="100" class="center">没有相关数据</td>
											</tr>
										</c:otherwise>
									</c:choose>
								</tbody>
							</table>
							<div class="col-lg-12" style="padding-left: 0px; padding-right: 0px">
								${page.pageStr}
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--返回顶部开始-->
	<div id="back-to-top">
		<a class="btn btn-warning btn-back-to-top"
			href="javascript: setWindowScrollTop (this,document.getElementById('top').offsetTop);">
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
	//---------------------------xcx-------------------------Start
	//刷新iframe
    function refreshCurrentTab() {
        $("#ContractNewForm").submit();
    }

	//查看
	function CNselect(HT_UUID){
		$("#InformationHTML").kendoWindow({
	        width: "550px",
	        height: "300px",
	        title: "合同信息",
	        actions: ["Close"],
	        content: '<%=basePath%>contractNew/goView.do?HT_UUID='+HT_UUID,
	        modal : true,
			visible : false,
			resizable : true
	    }).data("kendoWindow").maximize().open();
	};
	
	//选择（进入安装 合同新增 界面）
    function CNQSpick(HT_UUID,HT_ITEM_ID) {
    	window.parent.$("#InformationHTML").kendoWindow({
            width: "550px",
            height: "300px",
            title: "合同录入信息",
            actions: ["Close"],
            content: '<%=basePath%>contractNewInstallation/goSave.do?HT_UUID='+HT_UUID+'&HT_ITEM_ID='+HT_ITEM_ID,
            modal: true,
            visible: false,
            resizable: true
        }).data("kendoWindow").maximize().open();
    	CloseSUWin();
    }
	
    //关闭页面
    function CloseSUWin() {
		window.parent.$("#QuoteSelectHTML").data("kendoWindow").close();
	};
	
    $(document).ready(function () {
		//loading end
		parent.layer.closeAll('loading');
    });
    
  	
	//---------------------------xcx-------------------------End
	
		/* back to top */
		function setWindowScrollTop(win, topHeight) {
			if (win.document.documentElement) {
				win.document.documentElement.scrollTop = topHeight;
			}
			if (win.document.body) {
				win.document.body.scrollTop = topHeight;
			}
		}
	</script>
</body>
</html>


