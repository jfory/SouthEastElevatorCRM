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
    <form role="form" class="form-inline" action="install/saveWorkAdjust.do" method="post" name="adjustWorkForm" id="adjustWorkForm">
    <input type="hidden" name="apply_id" id="apply_id" value="${apply_id}">
    <input type="hidden" name="type" id="type" value="${type}">
    <div class="wrapper wrapper-content">
        <div class="row">
            <div class="col-sm-12">
                <div class="row">
                    <div class="col-sm-12">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                派工信息
                            </div>
                            <div class="panel-body">
                                <div class="form-group form-inline">
                                    <label>派工人员</label>
                                    <select class="form-control m-b" name="work_user" id="work_user">
                                        <option value="">请选择派工人员</option>
                                        <c:forEach items="${userList}" var="var">
                                            <option value="${var.user_id}">${var.name}</option>
                                        </c:forEach>
                                    </select>
                                    <label>派工日期</label>
                                    <input type="text" class="form-control" name="work_date" id="work_date">
                                    <label>派工地址</label>
                                    <input type="text" class="form-control" name="work_address" id="work_address">
                                    <label>备注</label>
                                    <input type="text" class="form-control" name="remark" id="remark">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <tr>
                <td><a class="btn btn-primary" style="width: 150px; height:34px;float:left;"  onclick="save();">保存</a></td>
                <td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('toWork');">关闭</a></td>
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
    	$("#adjustWorkForm").submit();
    }


	//检索
	function search(){
		$("#adjustWorkForm").submit();
	}
	//刷新iframe
    function refreshCurrentTab() {
     	$("#adjustWorkForm").submit();
    }

	function CloseSUWin() {
		window.parent.$("#SelfcheckReport").data("kendoWindow").close();
		/* 	window.parent.location.reload(); */
	}
	</script>
</body>

</html>
