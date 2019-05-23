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
	<!-- 合同录入界面 -->
	<div id="InformationHTML" class="animated fadeIn"></div>

	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-content">
					
						<form role="form" class="form-inline" action="contractNew/goAddContract.do"
							method="post" name="QuoteSelect" id="QuoteSelect">

							<div class="form-group ">
								<input class="form-control" type="text" id="item_name"
									type="text" name="item_name" value="${pd.item_name}"
									placeholder="项目名称">
							</div>
							<div class="form-group">
								<button type="submit" class="btn  btn-primary "
									style="margin-bottom: 0px;" title="查询">查询
								</button>
							</div>
						</form>
						
						<div class="row">
							</br>
						</div>
						<div class="table-responsive">
							<table class="table table-striped table-bordered table-hover">
								<thead>
									<tr>
										<th>报价编号</th>
										<th>项目名称</th>
										<th>客户名称</th>
										<th>电梯台数</th>
										<th>业务员</th>
										<th>总价格</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody>
									<!-- 开始循环 -->
									<c:choose>
										<c:when test="${not empty e_offerList}">
											<c:if test="${QX.cha == 1 }">
												<c:forEach items="${e_offerList}" var="con" varStatus="vs">
													<tr>
														<td>${con.offer_no}</td>
														<td>${con.item_name}</td>
														<td>${con.customer_name}</td>
														<td>${con.num}</td>
														<td>${con.USERNAME}</td>
														<td>${con.total}</td>
														<td>
															<button class="btn btn-sm btn-info" title="查看"
																type="button" onclick="CNQSselect('${con.offer_no}','${con.item_id}');">查看
															</button>
															<button class="btn btn-sm btn-info" title="选择"
																type="button" onclick="CNQSpick('${con.offer_no}','${con.item_id}');">选择
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
	
	<!--返回顶部结束-->
	<!-- Fancy box -->
	<script src="static/js/fancybox/jquery.fancybox.js"></script>
	<!-- iCheck -->
	<script src="static/js/iCheck/icheck.min.js"></script>
	<!-- Sweet alert -->
	<script src="static/js/sweetalert/sweetalert.min.js"></script>
	
	<script type="text/javascript">
		 //查看报价信息
	    function CNQSselect(offer_no,item_id)
	    {
	    	$("#InformationHTML").kendoWindow({
	            width: "800px",
	            height: "700px",
	            title: "报价信息",
	            actions: ["Close"],
	            content: '<%=basePath%>e_offer/SeeEoffer.do?offer_no='+offer_no+'&item_id='+item_id,
	            modal: true,
	            visible: false,
	            resizable: true
	        }).data("kendoWindow").maximize().open();
	    }
		//查看 跳转到  报价管理 -报价项目
		/* function CNQSselect(BJBH){
			
		} */
		
	  	//选择（进入合同录入界面）
	    function CNQSpick(offer_no,item_id) {
			window.parent.$("#InformationHTML").kendoWindow({
	            width: "550px",
	            height: "300px",
	            title: "合同录入信息",
	            actions: ["Close"],
	            content: '<%=basePath%>contractNew/goPickContract.do?offer_no='+offer_no+'&item_id='+item_id,
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
	</script>
</body>
</html>


