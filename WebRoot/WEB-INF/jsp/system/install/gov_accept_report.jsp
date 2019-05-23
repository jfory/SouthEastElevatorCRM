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
    <form action="install/${msg}.do" name="govAcceptReportForm" id="govAcceptReportForm" method="post">
    <input type="hidden" name="details_id" id="details_id" value="${details_id}">
    <input type="hidden" name="currect_id" id="currect_id" value="${currect_id}">
    <div class="wrapper wrapper-content">
        <div class="row">
            <div class="col-sm-12">
                <div class="row">
                    <div class="col-sm-12">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                验收报告信息
                            </div>
                            <div class="panel-body">
                                <div class="form-group form-inline">
                                    <label>报检时间:</label>
                                    <input type="text" class="form-control" name="apply_date" id="apply_date">
                                    <label>检验时间:</label>
                                    <input type="text" class="form-control" name="check_date" id="check_date">
                                    <label>发证时间:</label>
                                    <input type="text" class="form-control" name="license_date" id="license_date">
                                    <label>验收报告:</label>
                                    <input type="text" class="form-control" name="gov_report" id="gov_report">
                                    <label>整改单:</label>
                                    <input type="text" class="form-control" name="correct_report" id="correct_report">
                                    <label>合格证:</label>
                                    <input type="text" class="form-control" name="coq" id="coq">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>



                <tr>
                <td><a class="btn btn-primary" style="width: 150px; height:34px;float:left;"  onclick="save();">保存</a></td>
                <td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('correctReport');">关闭</a></td>
                </tr>
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
		/* checkbox */
        $('.i-checks').iCheck({
            checkboxClass: 'icheckbox_square-green',
            radioClass: 'iradio_square-green',
        });
     });

    //保存
    function save(){
    	$("#govAcceptReportForm").submit();
    }


	//刷新iframe
    function refreshCurrentTab() {
     	$("#govAcceptReportForm").submit();
    }

	function CloseSUWin(id) {
		window.parent.$("#"+id).data("kendoWindow").close();
		/* 	window.parent.location.reload(); */
	}
	</script>
</body>

</html>
