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
	<div id="EditMessage" class="animated fadeIn"></div>
    <div class="wrapper wrapper-content">
        <div class="col-sm-12 animated fadeInRight">
                <div class="mail-box-header">
                <h5>
                    <c:if test="${operateType=='add'}">
                    写信
                    </c:if>
                    <c:if test="${operateType=='edit'}">
                    回复
                    </c:if>
                </h5>
                </div>
                <div class="mail-box">
                    <div class="mail-body">
                        <form class="form-horizontal" action="message/${msg}.do" id="MessageForm" name="MessageForm" method="get">
                            <input type="hidden" name="id" id="id" value="${pd.id}">
                            <input type="hidden" name="send_id" id="send_id" value="${pd.send_id}">
                            <div class="form-group">
                            <c:if test="${operateType=='add'}">
                                <label class="col-sm-2 control-label">发送到：</label>

                                <div class="col-sm-10">
                                    <select style="width:100%" class="selectpicker" multiple data-live-search="true" data-live-search-placeholder="查找" data-actions-box="true" name="recv_id_text" id="recv_id_text">
                                    <optgroup label="人员列表">
                                        <c:forEach items="${sysUserList}" var="var" >
                                                <option value="${var.USER_ID }">${var.NAME }</option>
                                        </c:forEach>
                                    </optgroup>
                                  </select>
                                <input type="hidden" id="recv_id" name="recv_id"/>
                                </div>
                            </c:if>
                            <c:if test="${operateType=='edit'}">
                                <div class="form-group">
                                    <label class="col-sm-12" style="margin-left: 3%">回复给：${pd.send_name}</label>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-12" style="margin-left: 3%">主题：${pd.title}</label>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-12" style="margin-left: 3%">内容：${pd.mes_text}</label>
                                </div>
                            </c:if>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-1 control-label">主题：</label>

                                <div class="col-sm-11">
                                    <input type="text" class="form-control" id="title" name="title">
                                </div>
                            </div>

                    </div>

                    <div class="form-group">
                        <label class="col-sm-1 control-label">内容：</label>
                        <div class="summernote">
                            <div class="col-sm-11">
                                <textarea id="mes_text" name="mes_text" cols="11" rows="9" class="form-control"></textarea>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                    </form>
                    <div class="mail-body text-right tooltip-demo">
                        <a href="javascript:save();" class="btn btn-sm btn-primary" data-toggle="tooltip" data-placement="top" title="Send"><i class="fa fa-reply"></i> 发送</a>
                        <a href="javascript:CloseSUWin('EditMessage');" class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="top" title="Discard email"><i class="fa fa-times"></i> 放弃</a>
                    </div>
                    <div class="clearfix"></div>



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
     	$("#MessageForm").submit();
     }
	//检索
	function search(){
		$("#MessageForm").submit();
	}
    //发送
    function save(){
        $("#recv_id").val($("#recv_id_text").val());
        $("#MessageForm").submit();
    }
	
	function CloseSUWin(id) {
		window.parent.$("#" + id).data("kendoWindow").close();
		/* 	window.parent.location.reload(); */
	}
	</script>
</body>

</html>
