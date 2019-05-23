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
		if ($("#inv_com_no").val() == "" && $("#inv_com_no").val() == "") {
			$("#inv_com_no").focus();
			$("#inv_com_no").tips({
				side : 3,
				msg : "请选择来款",
				bg : '#AE81FF',
				time : 3
			});
			return false;
		}

		if ($("#inv_money").val() == "" && $("#inv_money").val() == "") {
			$("#inv_money").focus();
			$("#inv_money").tips({
				side : 3,
				msg : "请输入来款金额",
				bg : '#AE81FF',
				time : 3
			});
			return false;
		}

		if ($("#inv_item_no").val() == "" && $("#inv_item_no").val() == "") {
			$("#inv_item_no").focus();
			$("#inv_item_no").tips({
				side : 3,
				msg : "请输入项目名称",
				bg : '#AE81FF',
				time : 3
			});
			return false;
		}

		if ($("#inv_company").val() == "" && $("#inv_company").val() == "") {
			$("#inv_company").focus();
			$("#inv_company").tips({
				side : 3,
				msg : "请输入公司名称",
				bg : '#AE81FF',
				time : 3
			});
			return false;
		}

		if ($("#inv_comp_address").val() == "" && $("#inv_comp_address").val() == "") {
			$("#inv_comp_address").focus();
			$("#inv_comp_address").tips({
				side : 3,
				msg : "请输入公司地址",
				bg : '#AE81FF',
				time : 3
			});

			return false;
		}

		if ($("#inv_time").val() == "" && $("#inv_time").val() == "") {
			$("#inv_time").focus();
			$("#inv_time").tips({
				side : 3,
				msg : "请输入开票时间",
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
	<form action="invoice/${msg}.do" name="cellForm" id="cellForm" method="post">
		<input type="hidden" name="cellname" id="cellname"value="${pd.cell_name}" />
		<input type="hidden" name="houses_name" id="houses_name" value="${pd.houses_no}" />
		<div class="wrapper wrapper-content">
			<div class="row">
				<div class="col-sm-12">
					<div class="ibox float-e-margins">
						<div class="ibox-content1">
							<div class="panel panel-primary">
								<div class="panel-heading">发票基本信息</div>
								<div class="panel-body">
									<c:if test="${msg== 'saveS' }">
										<div class="row" style="margin-left: 10px">
											<div class="form-group form-inline">
												<span style="color: red;">*</span> 
												<label style="width: 15%">请选择来款:</label>
												<select style="width: 30%" class="form-control" name="inv_com_no" readonly id="inv_com_no">
													<option value="">请选择</option>
													<c:forEach items="${comefundList}" var="com">
														<option value="${com.com_no}"
															<c:if test="${com.com_no eq pd.com_no}">selected</c:if>>${com.com_no}</option>
													</c:forEach>
												</select>
												<span style="color: red;">*</span>
													<label style="width: 15%">发票金额:</label>
													<input style="width: 30%" type="text" type="text" name="inv_money" readonly
													id="inv_money" value="${pd.inv_money}" placeholder="这里输入发票金额"
													title="发票金额" class="form-control">	
											</div>
											<div class="form-group form-inline">
												<span style="color: red;">*</span> 
												<label style="width: 15%">项目名称:</label>
												<input style="width: 30%" type="text" type="text" name="inv_item_no" 
													id="inv_item_no" value="${pd.inv_item_no}" placeholder="这里输入项目名称"
													title="项目名称" class="form-control">
													<span style="color: red;">*</span>
												<label style="width: 15%">所属公司:</label> 
												<input style="width: 30%" type="text" type="text" name="inv_company" 
													id="inv_company" value="${pd.inv_company}" placeholder="这里输入所属公司"
													title="所属公司" class="form-control">
											</div>
											<div class="form-group form-inline">
												<span style="color: red;">*</span> 
												<label style="width: 15%">公司地址:</label> 
												<input style="width: 30%" type="text" type="text" name="inv_comp_address" 
													id="inv_comp_address" value="${pd.inv_comp_address}" placeholder="这里输入公司地址"
													title="公司地址" class="form-control">
													<span style="color: red;">*</span>
												<label style="width: 15%">开票时间:</label> 
												<input style="width: 30%" type="text" type="text" name="inv_time" 
													id="inv_time" value="${pd.inv_time}" placeholder="这里输入开票时间"
													onclick="laydate()" readonly="readonly" title="开票时间" class="form-control">
											</div>
											<div class="form-group form-inline">
												 <label style="width: 15%">备注:</label> <input style="width: 30%" type="text" type="text" name="inv_remarks" 
													id="inv_remarks" value="${pd.inv_remarks}" placeholder="这里输入备注"
													title="备注" class="form-control">
											</div>
										</div>
									</c:if>
									<c:if test="${msg== 'editS' }">
										<div class="row" style="margin-left: 10px">
											<div class="form-group form-inline">
											<span style="color: red;">*</span> 
												<label style="width: 15%">发票编号:</label>
												<input style="width: 30%" type="text" type="text" name="inv_no" readonly
													id="inv_no" value="${pd.inv_no}" placeholder="这里输入发票金额"
													title="发票编号" class="form-control">	
												<span style="color: red;">*</span> 
												<label style="width: 15%">请选择来款:</label>
												<select style="width: 30%" class="form-control" name="inv_com_no" readonly id="inv_com_no">
													<option value="">请选择</option>
													<c:forEach items="${comefundList}" var="com">
														<option value="${com.com_no}"
															<c:if test="${com.com_no eq pd.inv_com_no}">selected</c:if>>${com.com_no}</option>
													</c:forEach>
												</select>
											</div>
											<div class="form-group form-inline">
												<span style="color: red;">*</span>
													<label style="width: 15%">发票金额:</label>
													<input style="width: 30%" type="text" type="text" name="inv_money" readonly
													id="inv_money" value="${pd.inv_money}" placeholder="这里输入发票金额"
													title="发票金额" class="form-control">	
												<span style="color: red;">*</span> 
												<label style="width: 15%">请选择项目:</label>
												<input style="width: 30%" type="text" type="text" name="inv_item_no" 
													id="inv_item_no" value="${pd.inv_item_no}" placeholder="这里输入项目名称"
													title="项目名称" class="form-control">
											</div>
											<div class="form-group form-inline">	
												<span style="color: red;">*</span>
												<label style="width: 15%">所属公司:</label> 
												<input style="width: 30%" type="text" type="text" name="inv_company" 
													id="inv_company" value="${pd.inv_company}" placeholder="这里输入所属公司"
													title="所属公司" class="form-control">
												<span style="color: red;">*</span>
												<label style="width: 15%">公司地址:</label> 
												<input style="width: 30%" type="text" type="text" name="inv_comp_address" 
													id="inv_comp_address" value="${pd.inv_comp_address}" placeholder="这里输入公司地址"
													title="公司地址" class="form-control">
											</div>
											<div class="form-group form-inline">	
													<span style="color: red;">*</span>
												<label style="width: 15%">开票时间:</label> 
												<input style="width: 30%" type="text" type="text" name="inv_time" 
													id="inv_time" value="${pd.inv_time}" placeholder="这里输入开票时间"
													onclick="laydate()" readonly="readonly" title="开票时间" class="form-control">
												 <label style="width: 15%">备注:</label> 
												 <input style="width: 30%" type="text" type="text" name="inv_remarks" 
													id="inv_remarks" value="${pd.inv_remarks}" placeholder="这里输入备注"
													title="备注" class="form-control">
											</div>
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
<script type="text/javascript">
	//选中竞争对手公司后 加载选中的公司信息
	$("#inv_com_no").change(function() {
		var com_no = $(this).find("option:checked").attr("value"); //获取选中值的编号
		$.ajax({
			url : "invoice/checkedcom.do", //请求地址
			type : "POST", //请求方式
			data : {
				'com_no' : com_no
			}, //请求参数
			success : function(result) {
				$("#inv_money").val(result.comefund.com_money);
			}
		});
	});
</script>
</html>
