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
	<input type="hidden" name="operateType" id="operateType">
    <div class="wrapper wrapper-content">
        <div class="row">
            <div class="col-sm-12 animated fadeInRight">
                <div class="mail-box-header">
	                <h2>
	                    站内信息
	                </h2>
                    <div class="mail-tools tooltip-demo m-t-md">
	                    <form method="get" action="message/listMessage.do" class="pull-right mail-search" id="MessageForm" name="MessageForm">
	                        <div class="input-group">
	                            <div class="input-group-btn pull-right" style="margin-right: 90%">
	                        	<button type="button" onclick="add();" class="btn btn-sm btn-primary">
	                        		新建
	                        	</button>
	                        	</div>
	                        </div>
	                    </form>
                        <button class="btn btn-white btn-sm" onclick="refreshCurrentTab();" data-toggle="tooltip" data-placement="left" title="刷新列表"><i class="fa fa-refresh"></i> 刷新</button>
                        <button class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="top" title="标为已读" onclick="makeAll('status','标记已读')"><i class="fa fa-eye"></i>
                        </button>
                        <!-- <button class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="top" title="标为重要"><i class="fa fa-exclamation"></i>
                        </button> -->
                        <button class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="top" title="删除信息" onclick="makeAll('del','删除')"><i class="fa fa-trash-o"></i>
                        </button>

                    </div>
                </div>
                <div class="mail-box">

                    <table class="table table-hover table-mail">
                        <tbody>
                        	<tr class="unread">
								<td class="check-mail">
			                        <input type="checkbox" name="zcheckbox" class="i-checks">
			                    </td>
			                    <td class="mail-ontact">
			                    	编号
			                    </td>
			                    <td class="mail-ontact">
			                    	发件人
			                    </td>
			                    <td class="mail-ontact">
			                    	标题
			                    </td>
			                    <td class="mail-ontact">
			                    	日期
			                    </td>
                        	</tr>
                        	<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty mesList}">
									<c:forEach items="${mesList}" var="var" >
										<c:if test="${var.status==0}">
                            				<tr class="unread" onclick="edit(this);">
										</c:if>
										<c:if test="${var.status==1}">
                            				<tr class="read" onclick="edit(this);">
										</c:if>
			                                <td class="check-mail">
			                                    <input type="checkbox" class="i-checks" name="ids" id="${var.id}" value="${var.id}">
			                                </td>
                                			<td class="mail-ontact">
                                				<a href="#">${var.id}</a>
                                			</td>
                                			<td class="mail-ontact">
                                				<a href="#">${var.send_name}</a>
                                			</td>
                                			<td class="mail-ontact">
                                				<a href="#">${var.title}</a>
                                			</td>
			                                <td class="mail-ontact">${var.send_date}</td>
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
	//新增
	function add(){
		$("#EditMessage").kendoWindow({
	        width: "1000px",
	        height: "600px",
	        title: "编辑消息",
	        actions: ["Close"],
	        content: '<%=basePath%>message/goAddMessage.do?operateType=add',
	        modal : true,
			visible : false,
			resizable : true
	    }).data("kendoWindow").maximize().open();
	}

	//查看,回复
	function edit(obj){
		var id = $(obj).find("td").eq("1").text();
		//查看时修改已读状态
		$.post("<%=basePath%>message/editStatus?id="+id);
		$("#EditMessage").kendoWindow({
	        width: "1000px",
	        height: "600px",
	        title: "编辑消息",
	        actions: ["Close"],
	        content: '<%=basePath%>message/goEditMessage.do?operateType=edit&id='+id,
	        modal : true,
			visible : false,
			resizable : true
	    }).data("kendoWindow").maximize().open();
	}
	//批量操作
		function makeAll(operateType,title){
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
				swal({
	                title: "您确定要"+title+"选中的数据吗？",
	                type: "warning",
	                showCancelButton: true,
	                confirmButtonColor: "#DD6B55",
	                confirmButtonText: "确定",
	                cancelButtonText: "取消",
	                closeOnConfirm: false,
	                closeOnCancel: false
	            },
	            function (isConfirm) {
	                if (isConfirm) {
	                	$.ajax({
							type: "POST",
							url: '<%=basePath%>message/editStatus.do',
					    	data: {message_ids:str,operateType:operateType},
							dataType:'json',
							cache: false,
							success: function(data){
								if(data.msg=='success'){
									swal({   
	        				        	title: "操作成功！",
	        				        	type: "success",  
	        				        	 }, 
	        				        	function(){   
	        				        		 refreshCurrentTab(); 
	        				        	 });
		    					}else{
		    						swal("操作失败", "您的"+title+"操作失败了！", "error");
		    					}
								
							}
						});
	                } else {
	                    swal("已取消", "您取消了操作！", "error");
	                }
	            });
			}
		}
	function CloseSUWin(id) {
		window.parent.$("#" + id).data("kendoWindow").close();
		/* 	window.parent.location.reload(); */
	}
	</script>
</body>

</html>
