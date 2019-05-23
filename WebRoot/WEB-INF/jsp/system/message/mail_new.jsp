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
    	<link href="static/js/iCheck/custom.css" rel="stylesheet">
		<title>${pd.SYSNAME}</title>
	</head>
<body class="gray-bg">
<form name="mailForm" id="mailForm" action="" style="width: 100%">
<input type="hidden" value="${newPd.id}" name="answ_id" id="answ_id">
                <div class="mail-box-header" style="width: 100%">
                    <div class="pull-right tooltip-demo">
                        <a href="javascript:saveDraft();" class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="top" title="存为草稿"><i class="fa fa-pencil"></i> 存为草稿</a>
                        <a href="mailbox.html" class="btn btn-danger btn-sm" data-toggle="tooltip" data-placement="top" title="放弃"><i class="fa fa-times"></i> 放弃</a>
                    </div>
                    <h2>
                    写信
                </h2>
                </div>
                <div class="mail-box">
                    <div class="mail-body" style="height: 120px;">
                        <form class="form-horizontal" method="get">
                            <div class="form-group form-inline">
                                <label class="col-sm-2 control-label" style="text-align: left">发送到：</label>
                                <div class="col-sm-9">
									<select style="width:22%" id="recv_id" name="recv_id" class="selectpicker" data-live-search="true" data-style="btn-none" data-width="100%" multiple data-actions-box="true" title="请选择用户">
                                		<c:forEach items="${userList}" var="var" >
											<option value="${var.user_id  }"
												<c:forEach items="${recvList}" var="recvId">
                                                    ${var.user_id==recvId?'selected':''}
                                                </c:forEach>
											>${var.name }</option>
									  	</c:forEach>
									</select>
									<input type="hidden" name="recv_id_selected" id="recv_id_selected">
                                    <!-- <input type="text" class="form-control" style="width: 100%" value="${newPd.recv_id}" name="recv_id" id="recv_id"> -->
                                </div>
                            </div>
                            <div class="form-group form-inline">
                                <label class="col-sm-2 control-label" style="text-align: left">主题：</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" style="width: 100%" name="title" id="title">
                                </div>
                            </div>
                        </form>

                    </div>

                    <div class="mail-text h-200">

                        <div class="summernote">
                            <textarea cols="90" rows="9" name="mes_text" id="mes_text" style="margin-left:30px"></textarea>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                    <div class="mail-body text-right tooltip-demo">
                        <a href="javascript:sendMail();" class="btn btn-sm btn-primary" data-toggle="tooltip" data-placement="top" title="Send"><i class="fa fa-reply"></i> 发送</a>
                        <a href="mailbox.html" class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="top" title="Discard email"><i class="fa fa-times"></i> 放弃</a>
                        <a href="javascript:saveDraft();" class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="top" title="Move to draft folder"><i class="fa fa-pencil"></i> 存为草稿</a>
                    </div>
                    <div class="clearfix"></div>
                </div>
</form>

    <!-- 自定义js -->
    <script src="static/js/content.js"></script>
    <!-- iCheck -->
    <script src="static/js/iCheck/icheck.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('.i-checks').iCheck({
                checkboxClass: 'icheckbox_square-green',
                radioClass: 'iradio_square-green',
            });

			//loading end
			parent.layer.closeAll('loading');
        });

        function sendMail(){
        	$("#recv_id_selected").val($("#recv_id").val());
    		$("#mailForm").attr("action", "<%=basePath%>message/sendMail.do");
    		$("#mailForm").submit();
    	}

    	function saveDraft(){
        	$("#recv_id_selected").val($("#recv_id").val());
    		$("#mailForm").attr("action", "<%=basePath%>message/saveDraft.do");
    		$("#mailForm").submit();
    	}
    </script>
</body>

</html>