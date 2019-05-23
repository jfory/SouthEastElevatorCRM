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
                <div class="mail-box-header" style="width: 100%;height: 25%">
                    <form method="get" action="" class="pull-right mail-search" name="searchForm" id="searchForm">
                        <div class="input-group">
							<input type="hidden" name="status" id="status" value="${status}">
                            <input type="text" class="form-control input-sm" name="search" placeholder="搜索邮件标题，正文等">
                            <div class="input-group-btn">
                                <input type="button" class="btn btn-sm btn-primary" value="搜索" onclick="searchMail();">
                            </div>
                        </div>
                    </form>
                    <h2>
                    ${titlePd.title} (未读${count})
                </h2>
                    <div class="mail-tools tooltip-demo m-t-md">
                        <button class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="left" title="刷新列表" onclick="window.parent.mailMain('${titlePd.titleFlag}')"><i class="fa fa-refresh"></i> 刷新</button>
                        <button class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="top" title="标为已读" onclick="setState('read');"><i class="fa fa-eye"></i>
                        </button>
                        <button class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="top" title="标为重要" onclick="setState('impt');"><i class="fa fa-exclamation"></i>
                        </button>
                        <button class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="top" title="移动到回收站" onclick="setState('del');"><i class="fa fa-trash-o"></i>
                        </button>

                    </div>
                </div>
                <div class="mail-box" style="width: 100%;height: 70%;">
                	<div style="margin-left: 20px">
                        <input type="checkbox" name="zcheckbox" id="zcheckbox" class="i-checks">
                	</div>
                    <table class="table table-hover table-mail">
                        <tbody>
                        	<c:choose>
								<c:when test="${not empty mesList}">
									<c:forEach items="${mesList}" var="var" >
										<c:if test="${var.is_read==0}">
                            				<tr class="unread">
										</c:if>
										<c:if test="${var.is_read==1}">
                            				<tr class="read">
										</c:if>
			                                <td class="check-mail">
			                                    <input type="checkbox" class="i-checks" name="ids" id="${var.id}" value="${var.id}">
			                                </td>
                                			<td class="mail-ontact" style="width:13%;" onclick="window.parent.mailDetail('${var.id}');">${var.id}</td>
                                			<td class="mail-ontact" onclick="window.parent.mailDetail('${var.id}');">${var.send_name}</td>
                                			<td class="mail-subject" onclick="window.parent.mailDetail('${var.id}');">${var.title}</td>
			                                <td class="text-right mail-date" onclick="window.parent.mailDetail('${var.id}');">${var.send_date}</td>
									</c:forEach>
                            		</tr>
								</c:when>
								<c:otherwise>
									<tr class="main_info">
										<td colspan="100" class="center" >没有相关数据</td>
									</tr>
								</c:otherwise>
							</c:choose>
                        </tbody>
                    </table>
					${page.pageStr}
                </div>

	<!-- iCheck -->
    <!-- <script src="js/plugins/iCheck/icheck.min.js"></script> -->
    <script src="static/js/iCheck/icheck.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('.i-checks').iCheck({
                checkboxClass: 'icheckbox_square-green',
                radioClass: 'iradio_square-green',
            });

            //默认加载收件箱
        	$('#mail').attr('src', "<%=basePath%>message/mailMain.do");

			 //loading end
			 parent.layer.closeAll('loading');
        });

        /* checkbox全选 */
		$("#zcheckbox").on('ifChecked', function(event){
		 	$('input').iCheck('check');
		});
		/* checkbox取消全选 */
		$("#zcheckbox").on('ifUnchecked', function(event){
		 	$('input').iCheck('uncheck');
		});

		function setState(flag){
			var str = '';
			for(var i=0;i < document.getElementsByName('ids').length;i++){
			  if(document.getElementsByName('ids')[i].checked){
			  	if(str=='') str += document.getElementsByName('ids')[i].value;
			  	else str += ',' + document.getElementsByName('ids')[i].value;
			  }
			}
			if(str==''){
				swal({
	                title: "您未选择任何数据",
	                text: "请选择你需要操作的数据！",
	                type: "error",
	                showCancelButton: false,
	                confirmButtonColor: "#DD6B55",
	                confirmButtonText: "OK",
	                closeOnConfirm: true,
	                timer:1500
	            });
			}else{
				if(flag=="read"){
					window.parent.setRead(str,"mail_main");
				}else if(flag=="impt"){
					window.parent.setImpt(str,"mail_main");
				}else if(flag=="del"){
					window.parent.setDel(str,"mail_main");
				}
			}
		}

		function searchMail(){
			var search = $("#search").val();
			var status = $("#status").val();
			$('#searchForm').attr('action', "<%=basePath%>message/mailMain.do?search="+search+"&status="+status);
			$('#searchForm').submit();
		}
	</script>
</body>

</html>