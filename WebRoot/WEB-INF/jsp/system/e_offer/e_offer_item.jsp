<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
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
	<div class="wrapper wrapper-content animated fadeInRight">
		<div id="addOffer" class="animated fadeIn"></div>
		<div id="EditItem" class="animated fadeIn"></div>
		
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-content">
						<div id="top" ,name="top"></div>
						<form role="form" class="form-inline" action="e_offer/itemList.do" method="post" name="shopForm" id="shopForm">
							<div class="form-group ">
								<input class="form-control" type="text" id="nav-search-input"
									type="text" name="item_name" value="${pd.item_name}"
									placeholder="项目名称">
							</div>
							<div class="form-group">
								<button type="submit" class="btn  btn-primary" title="查询" 
								style="margin-left: 10px; height:32px;margin-top:3px;">查询</button>
							</div>
						</form>
						</br>
						<div class="table-responsive">
							<table class="table table-striped table-bordered table-hover">
								<thead>
									<tr>
										<th><input type="checkbox" name="zcheckbox"
											id="zcheckbox" class="i-checks"></th>
										<th style="text-align:center;">项目编号</th>
										<th style="text-align:center;text-overflow: ellipsis;white-space: nowrap;width: 25%">项目名称</th>
										<th style="text-align:center;text-overflow: ellipsis;white-space: nowrap;width: 20%">客户名称</th>
										<th style="text-align:center;">电梯台数</th>
										<th style="text-align:center;">业务员</th>
										<th style="text-align:center;">联系人</th>
										<th style="text-align:center;">项目状态</th>
										<th style="text-align:center;">操作</th>
									</tr>
								</thead>
								<tbody>
									<!-- 开始循环 -->
									<c:choose>
										<c:when test="${not empty itemList}">
											<c:if test="${QX.cha == 1 }">
												<c:forEach items="${itemList}" var="i" varStatus="vs">

													<tr>
														<td class='center' style="width: 30px;">
														<label>
														<input
																class="i-checks" type='checkbox' name='ids'
																value="${i.item_no}" id="${i.item_no}"
																alt="${i.item_no}" />
																<span class="lbl"></span>
																</label>
																</td>
														
														<td style="text-align:center;">${i.item_no}</td>
														<td style="text-align:center;">${i.item_name}</td>
														<td style="text-align:center;">${i.customer_name}</td>
														<td style="text-align:center;">${i.ednum}</td>
														<td style="text-align:center;">${i.USERNAME}</td>
														<td style="text-align:center;">${i.item_contact}</td>
														<td style="text-align:center;">信息</td>
														<td style="text-align:center;">
														   <button class="btn btn-sm btn-info btn-sm " title="查看"
															 type="button" onclick="See('${i.item_id}','sel')">查看
														   </button>
														   <%--  <button class="btn  btn-primary btn-sm" title="编辑"
															 type="button" onclick="See('${i.item_id}','edit')">编辑
														   </button> --%>
														    <button class="btn btn-warning btn-sm" title="报价"
															 type="button" onclick="addEoffer('${i.item_no}')">报价
														   </button>
															
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
    $(document).ready(function () {
		//loading end
		parent.layer.closeAll('loading');
        /* checkbox */
        $('.i-checks').iCheck({
            checkboxClass: 'icheckbox_square-green',
            radioClass: 'iradio_square-green',
        });
    });
    /* checkbox全选 */
    $("#zcheckbox").on('ifChecked', function (event) {
        $('input').iCheck('check');
    });
    /* checkbox取消全选 */
    $("#zcheckbox").on('ifUnchecked', function (event) {
        $('input').iCheck('uncheck');
    });
    //刷新
    function search() {
        $("#shopForm").submit();
    }
    
    //报价
    function addEoffer(item_no)
    {
    	window.parent.$("#addOffer").kendoWindow({
             width: "900px",
             height: "700px",
             title: "项目报价",
             actions: ["Close"],
             content: '<%=basePath%>e_offer/addEoffer.do?item_no='+item_no,
             modal: true,
             visible: false,
             resizable: true
         }).data("kendoWindow").maximize().open();
    	 CloseSUWin();
    }
    
    //关闭页面
    function CloseSUWin() {
		window.parent.$("#xinjian").data("kendoWindow").close();
	};
    
    //查看 和 修改
    function See(id,operateType) {
        $("#EditItem").kendoWindow({
            width: "800px",
            height: "700px",
            title: "查看项目信息",
            actions: ["Close"],
            content: '<%=basePath%>item/goEditItem.do?item_id='+id+'&operateType='+operateType,
            modal: true,
            visible: false,
            resizable: true
        }).data("kendoWindow").maximize().open();
    }
   

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


