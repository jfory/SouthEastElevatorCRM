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
    <!-- Sweet Alert -->
    <link href="static/js/sweetalert2/sweetalert2.css" rel="stylesheet">
	<title>${pd.SYSNAME}</title>
</head>

<body class="gray-bg">
<form action="contract/handleAgent.do" name="handleLeaveForm" id="handelLeaveForm" method="post">
	<input type="hidden" id="task_id" name="task_id" value="${pd.task_id}">
	<input type="hidden" id="con_id" name="con_id" value="${pd.con_id}">
	<input type="hidden" id="action" name="action" value="${pd.action}">
	<div class="wrapper wrapper-content">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-content">
						<div class="row">
							<div class="col-lg-12">
								<div class="form-group">
									<label> 批注:</label>
									<textarea class="form-control" rows="5"  cols="20" value="" name="comment" id="comment"  placeholder="这里输入批注" maxlength="250" title="批注" ></textarea>
								</div>
							</div>
						</div>
					</div>
					<div style="height: 10px;"></div>
					  <c:if test="${pd.binding eq 1}">
					     <button class="btn  btn-warning btn-sm" title="提交合同" 
					     style="width: 150px; height:34px;float:left;" type="button" 
					     onclick="binding('${pd.con_id}')">绑定电梯工号</button>
					  </c:if>
					  <c:if test="${pd.type eq 1}">
					       <label>请选择下个任务节点:</label>
                           <select style="width: 200px" class="form-control" name="node" readonly id="node">
								<option value="2" selected>合同评审分派</option>
								<option value="1" selected>营销管理部</option>
						  </select>  
                       </c:if> 
                        <div style="height: 40px;"></div>
					<tr>
						<td><button type="submit" class="btn btn-primary"style="width: 150px; height:34px;float:left;"  onclick="return handle('approve');">批准</button></td>
						<td><button type="submit" class="btn btn-danger"style="width: 150px; height:34px;float:right;"  onclick="return handle('reject');">驳回</button></td>
					</tr>
				</div>
			</div>

		</div>
	</div>
</form>
 <script src="static/js/fancybox/jquery.fancybox.js"></script>
	<!-- iCheck -->
    <script src="static/js/iCheck/icheck.min.js"></script>
    <!-- Sweet alert -->
    <script src="static/js/sweetalert/sweetalert.min.js"></script>
<script type="text/javascript">
	  //绑定电梯工号
    function binding(con_id){
        swal({
        	    title: "您确定要绑定电梯工号吗？",
			    text: "点击确定将会与设备内部id关联绑定 ，请谨慎操作！",
                type: "warning",
                showCancelButton: true,
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "确认",
                cancelButtonText: "取消",
                closeOnConfirm: false,
                closeOnCancel: false
                },
                function (isConfirm) {
                    if (isConfirm) 
                    {
                        var url = "<%=basePath%>contract/binding.do?con_id=" + con_id + "&tm=" 
                        		+ new Date().getTime();
                        $.get(url, function (data) {
                            if (data.msg == 'success') 
                            {
                            	swal({   
                            		title: "绑定成功！",
        							text: "您已经成功的把工号与设备内部id关联绑定。",
        				        	type: "success",  
        				        	 });
                            } else {
                                swal("绑定失败", "您的操作失败了！", "error");
                            }
                        });
                    } else {
                        swal("已取消", "您取消了绑定操作！", "error");
                    }
                });
    }
	//保存
	function handle(action) {
		if ($("#comment").val()=="") {
			$("#comment").focus();
			$("#comment").tips({
				side: 3,
				msg: "请输入批注",
				bg: '#AE81FF',
				time: 2
			});
			return false;
		}else{
			$("#action").val(action);
		}
	}
</script>
</body>

</html>
