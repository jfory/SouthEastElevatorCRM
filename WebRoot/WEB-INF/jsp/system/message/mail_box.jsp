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
<form name="mailForm" id="mailForm" action="" style="height: 100%">
    <div class="wrapper wrapper-content" style="height: 100%">
        <div class="row" style="height: 100%">
            <div class="col-sm-3">
                <div class="ibox float-e-margins">
                    <div class="ibox-content mailbox-content">
                        <div class="file-manager">
                            <a class="btn btn-block btn-primary compose-mail" href="javascript:newMail();" target="mail">新建</a>
                            <button class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="left" title="刷新" onclick="refreshMailView();"><i class="fa fa-refresh"></i></button>
                            <div class="space-25"></div>
                            <h5>文件夹</h5>
                            <ul class="folder-list m-b-md" style="padding: 0">
                                <li>
                                    <a href="javascript:mailMain(0);" target="mail"> <i class="fa fa-inbox "></i> 收件箱 
                                    	<c:if test="${statusPd.sjx != 0}">
                                    		<span class="label label-warning pull-right">${statusPd.sjx}</span>
                                    	</c:if>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:mailSend();" target="mail"> <i class="fa fa-envelope-o"></i> 发信</a>
                                </li>
                                <li>
                                    <a href="javascript:mailMain(1);" target="mail"> <i class="fa fa-certificate"></i> 重要 
                                    	<c:if test="${statusPd.zy != 0}">
                                    		<span class="label label-success pull-right">${statusPd.zy}</span>
                                    	</c:if>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:mailDraft();" target="mail"> <i class="fa fa-file-text-o"></i> 草稿 
                                    	<c:if test="${statusPd.cg != 0}">
                                    		<span class="label label-danger pull-right">${statusPd.cg}</span>
                                    	</c:if>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:mailMain(3);" target="mail"> <i class="fa fa-trash-o"></i> 回收站 
                                    	<c:if test="${statusPd.hsz != 0}">
                                    		<span class="label label-default pull-right">${statusPd.hsz}</span>
                                    	</c:if>
                                    </a>
                                </li>
                            </ul>

                            <div class="clearfix"></div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-sm-9 animated fadeInRight" style="height: 100%">
            	<iframe name="mail" id="mail" style="width: 100%;height: 100%;" frameborder="0"></iframe>
            </div>
        </div>
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

        function newMail(){
        	$('#mail').attr('src', "<%=basePath%>message/mailNew.do");
        }

        function mailMain(status){
        	$('#mail').attr('src', "<%=basePath%>message/mailMain.do?status="+status);
        }

		function mailDetail(id){
    		//修改为已读
    		$.post("<%=basePath%>message/editRead?id="+id,
    			function(data){
    				if(data.msg=="success"){
    					//跳转到detail
    					$('#mail').attr('src', "<%=basePath%>message/mailDetail.do?id="+id);
    				}
    			}
    		);
    	}

    	function sendDetail(id){
    		$('#mail').attr('src', "<%=basePath%>message/mailDetail.do?id="+id+"&recv=false");
    	}

    	function mailRecv(id,recvId){
    		$('#mail').attr('src', "<%=basePath%>message/mailRecv.do?id="+id+"&recv_id="+recvId);
    	}

    	function mailSend(){
    		$('#mail').attr('src', "<%=basePath%>message/mailSend.do");
    	}

    	function mailDraft(){
    		$('#mail').attr('src', "<%=basePath%>message/mailDraft.do");
    	}

    	function mailEdit(id){
    		$('#mail').attr('src', "<%=basePath%>message/mailEdit.do?id="+id);
    	}

    	function setRead(str,url){
    		$('#mail').attr('src', "<%=basePath%>message/setRead.do?ids="+str+"&url="+url);
    	}

    	function setImpt(str,url){
    		$('#mail').attr('src', "<%=basePath%>message/setImpt.do?ids="+str+"&url="+url);
    	}

    	function setDel(str,url){
    		$('#mail').attr('src', "<%=basePath%>message/setDel.do?ids="+str+"&url="+url);
    	}

    	function refreshMailView(){
    		$.post("<%=basePath%>message/mailView.do");
    	}
    </script>

</body>

</html>