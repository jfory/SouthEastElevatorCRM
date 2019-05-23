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
	<div class="wrapper wrapper-content animated fadeInRight">
		<div id="EditShops" class="animated fadeIn"></div>
		<div id="ImportExcel" class="animated fadeIn"></div>
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-content">
						<div id="top" ,name="top"></div>
						<form role="form" class="form-inline" action="caroice/caroice.do"
							method="post" name="shopForm" id="shopForm">
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
										<th>序号</th>
										<th>发票编号</th>
										<th>承运单号</th>
										<th>承运公司</th>
										<th>承运金额</th>
										<th>收货公司</th>
										<th>收货地址</th>
										<th>收货人</th>
										<th>收货人电话</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td class='center' style="width: 30px;">${vs.index+1}</td>
										<td>${pd.inv_no}</td>
										<td>${pd.car_no}</td>
										<td>${pd.car_company}</td>
										<td>${pd.car_money}</td>
										<td>${pd.rec_company}</td>
										<td>${pd.rec_address}</td>
										<td>${pd.rec_consignee}</td>
										<td>${pd.rec_phone}</td>
										<td><c:if test="${QX.edit != 1 && QX.del != 1 }">
												<span
													class="label label-large label-grey arrowed-in-right arrowed-in">
													<i class="icon-lock" title="无权限">无权限</i>
												</span>
											</c:if> <c:choose>
												<c:when test="${user.USERNAME=='admin'}"></c:when>
												<c:otherwise>
													<c:if test="${QX.del == 1 }">
														<button class="btn  btn-danger btn-sm" title="删除"
															type="button" onclick="delShop('${pd.inv_no}');">删除
														</button>
													</c:if>
												</c:otherwise>
											</c:choose></td>
									</tr>
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

    //刷新iframe
    function refreshCurrentTab() {
        $("#shopForm").submit();
    }
    //检索
    function search() {
        $("#shopForm").submit();
    }
    //删除
    function delShop(inv_no) {
        swal({
                    title: "您确定要删除[" + inv_no + "]吗？",
                    text: "删除后将无法恢复，请谨慎操作！",
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "删除",
                    cancelButtonText: "取消",
                    closeOnConfirm: false,
                    closeOnCancel: false
                },
                function (isConfirm) {
                    if (isConfirm) {
                        var url = "<%=basePath%>invoice/delCarriage.do?inv_no="+ inv_no + "&tm=" + new Date().getTime();
					$.get(url, function(data) {
						if (data.msg == 'success') {
							swal({
								title : "删除成功！",
								text : "您已经成功删除了这条信息。",
								type : "success",
							}, function() {
								//$("#EditShops").data("kendoWindow").close();
								window.parent.$("#EditShops").data("kendoWindow").close();
								window.parent.location.reload();
								refreshCurrentTab();
							});
						} else {
							swal("删除失败", "您的删除操作失败了！", "error");
						}
					});
				} else {
					swal("已取消", "您取消了删除操作！", "error");
				}
			});
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


