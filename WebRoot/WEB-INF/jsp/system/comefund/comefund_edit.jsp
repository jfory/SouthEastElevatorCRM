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
<html>

<head>

<base href="<%=basePath%>">


<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">


<title>${pd.SYSNAME}</title>
<!-- jsp文件头和头部 -->
<%@ include file="../../system/admin/top.jsp"%>
<!-- Fancy box -->
<script src="static/js/fancybox/jquery.fancybox.js"></script>

<link href="static/js/fancybox/jquery.fancybox.css" rel="stylesheet">
<link type="text/css" rel="stylesheet"
	href="plugins/zTree/3.5.24/css/zTreeStyle/zTreeStyle.css" />
<script type="text/javascript"
	src="plugins/zTree/3.5.24/js/jquery.ztree.core.js"></script>
<script type="text/javascript"
	src="plugins/zTree/3.5.24/js/jquery.ztree.excheck.js"></script>
<script type="text/javascript"
	src="plugins/zTree/3.5.24/js/jquery.ztree.exedit.js"></script>


<!-- 日期控件-->
<script src="static/js/layer/laydate/laydate.js"></script>
<script type="text/javascript">
     $(document).ready(function () {
            /* 图片 */
            $('.fancybox').fancybox({
                openEffect: 'none',
                closeEffect: 'none'
            });
        });
	//保存
	function save() {
		if ($("#com_money").val() == "" && $("#com_money").val() == "") {
			$("#com_money").focus();
			$("#com_money").tips({
				side : 3,
				msg : "请输入来款金额",
				bg : '#AE81FF',
				time : 3
			});
			return false;
		}

		if ($("#com_account").val() == "" && $("#com_account").val() == "") {
			$("#com_account").focus();
			$("#com_account").tips({
				side : 3,
				msg : "请输入来款账户",
				bg : '#AE81FF',
				time : 3
			});
			return false;
		}

		if ($("#com_company").val() == "" && $("#com_company").val() == "") {
			$("#com_company").focus();
			$("#com_company").tips({
				side : 3,
				msg : "请输入来款公司",
				bg : '#AE81FF',
				time : 3
			});
			return false;
		}
		$("#cellForm").submit();
	}

	
	 //日期范围限制
    var start = {
        elem: '#start_time',
        format: 'YYYY/MM/DD hh:mm:ss',
        max: '2099-06-16 23:59:59', //最大日期
        istime:true,
        istoday: false,
        choose: function (datas) {
            end.min = datas; //开始日选好后，重置结束日的最小日期
            end.start = datas //将结束日的初始值设定为开始日
        }
    };
    var end = {
        elem: '#end_time',
        format: 'YYYY/MM/DD hh:mm:ss',
        max: '2099-06-16 23:59:59',
        istime: true,
        istoday: false,
        choose: function (datas) {
            start.max = datas; //结束日选好后，重置开始日的最大日期
        }
    };
    laydate(start);
    laydate(end);
	
	function CloseSUWin(id) {
		window.parent.$("#" + id).data("kendoWindow").close();
	}


</script>


</head>

<body class="gray-bg">
	<form action="comefund/${msg}.do" name="cellForm" id="cellForm"
		method="post">
		<input type="hidden" name="com_states" id="com_states" value="${pd.com_states}" /> 
		<div class="wrapper wrapper-content">
			<div class="row">
				<div class="col-sm-12">
					<div class="ibox float-e-margins">
						<div class="ibox-content1">
							<div class="panel panel-primary">
								<div class="panel-heading">来款基本信息</div>
								<div class="panel-body">
									<c:if test="${msg== 'saveS' }">
										<div class="row" style="margin-left: 10px">
											<div class="form-group form-inline">
												<span style="color: red;">*</span> 
												<label style="width: 15%">来款金额:</label>
												<input style="width: 30%" type="text" name="com_money" id="com_money" value="${pd.com_money}"
													placeholder="这里输入来款金额" title="来款金额" class="form-control" /> 
												<span type="hidden">&nbsp&nbsp&nbsp&nbsp&nbsp</span>
												<span style="color: red;">*</span>
												<label style="width: 15%">来款账户:</label>
													<input style="width: 30%" type="text" name="com_account" id="com_account"
													 value="${pd.com_account}"placeholder="这里输入来款账户" title="来款账户" class="form-control" /> 
											</div>
											<div class="form-group form-inline">
												<span style="color: red;">*</span> 
												<label style="width: 15%">来款公司:</label>
												<input style="width: 30%" type="text" name="com_company" id="com_company" value="${pd.com_company}"
													placeholder="这里输入来款公司" title="来款公司" class="form-control" /> 
												<span type="hidden">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</span>
												<label style="width: 15%">来款时间:</label> 
												<input style="width: 30%" type="text" name="com_time" id="com_time" value="${pd.com_time}"
												 readonly="readonly"	placeholder="这里输入来款时间" title="来款时间" onclick="laydate()" class="form-control" /> 
											</div>
											<div class="form-group form-inline">
												<span type="hidden">&nbsp&nbsp</span> 
												<label style="width: 15%">备注:</label> 
												 <input style="width: 30%" type="text" name="com_remarks" id="com_remarks" value="${pd.com_remarks}"
													placeholder="这里输入备注" title="备注" class="form-control" /> 
											</div>
										</div>
									</c:if>
									<c:if test="${msg== 'editS' }">
										<div class="form-group form-inline">
												<span style="color: red;">*</span> 
												<label style="width: 15%">来款编号:</label>
												<input style="width: 30%" type="text" name="com_no" id="com_no" value="${pd.com_no}"
													placeholder="这里输入来款编号" title="来款编号" class="form-control" /> 
												<span type="hidden">&nbsp&nbsp&nbsp&nbsp&nbsp</span>
												<span style="color: red;">*</span>
												<label style="width: 15%">来款金额:</label>
													<input style="width: 30%" type="text" name="com_money" id="com_money"
													 value="${pd.com_money}"placeholder="这里输入来款金额" title="来款金额" class="form-control" /> 
											</div>
											<div class="form-group form-inline">
												<span style="color: red;">*</span> 
												<label style="width: 15%">来款账户:</label>
												<input style="width: 30%" type="text" name="com_account" id="com_account" value="${pd.com_account}"
													placeholder="这里输入来款账户" title="来款账户" class="form-control" /> 
												<span type="hidden">&nbsp&nbsp&nbsp&nbsp&nbsp</span>
												<span style="color: red;">*</span>
												<label style="width: 15%">来款公司:</label> 
												<input style="width: 30%" type="text" name="com_company" id="com_company" value="${pd.com_company}"
													placeholder="这里输入来款公司" title="来款公司" class="form-control" /> 
											</div>
											<div class="form-group form-inline">
												<span type="hidden">&nbsp&nbsp</span> 
												<label style="width: 15%">来款时间:</label> 
												 <input style="width: 30%" type="text" name="com_time" id="com_time" value="${pd.com_time}"
													readonly="readonly" placeholder="这里输入来款时间" title="来款时间" onclick="laydate()" class="form-control" /> 
												<span type="hidden">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</span>
												<label style="width: 15%">备注:</label> 
												 <input style="width: 30%" type="text" name="com_remarks" id="com_remarks" value="${pd.com_remarks}"
													placeholder="这里输入备注" title="备注" class="form-control" /> 
											</div>
									</c:if>
								</div>
							</div>
						<tr>
							<td><a class="btn btn-primary"
								style="width: 150px; height: 34px; float: left;"
								onclick="save();">保存</a></td>
							<td><a class="btn btn-danger"
								style="width: 150px; height: 34px; float: right;"
								onclick="javascript:CloseSUWin('EditShops');">关闭</a></td>
						</tr>
					</div>

				</div>
			</div>
	</form>
</body>
</html>
