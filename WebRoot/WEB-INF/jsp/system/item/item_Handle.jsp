<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
	<base href="<%=basePath%>">
	<%@ include file="../../system/admin/top.jsp"%>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>${pd.SYSNAME}</title>
	
    
</head>

<body class="gray-bg">

<form action="item/handleItem.do" name="handleLeaveForm" id="handelLeaveForm" method="post">
	<input type="hidden" id="task_id" name="task_id" value="${pd.task_id}">
	<input type="hidden" id="item_id" name="item_id" value="${pd.item_id}">
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
<script type="text/javascript">
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
