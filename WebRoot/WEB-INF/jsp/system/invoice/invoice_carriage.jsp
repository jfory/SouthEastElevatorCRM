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
		if ($("#car_no").val() == "" && $("#car_no").val() == "") {
			$("#car_no").focus();
			$("#car_no").tips({
				side : 3,
				msg : "请输入承运单号",
				bg : '#AE81FF',
				time : 3
			});
			return false;
		}

		if ($("#car_company").val() == "" && $("#car_company").val() == "") {
			$("#car_company").focus();
			$("#car_company").tips({
				side : 3,
				msg : "请输入承运公司",
				bg : '#AE81FF',
				time : 3
			});
			return false;
		}

		if ($("#car_money").val() == "" && $("#car_money").val() == "") {
			$("#car_money").focus();
			$("#car_money").tips({
				side : 3,
				msg : "请输入承运金额",
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

		if ($("#rec_consignee").val() == "" && $("#rec_consignee").val() == "") {
			$("#rec_consignee").focus();
			$("#rec_consignee").tips({
				side : 3,
				msg : "请输入收货人",
				bg : '#AE81FF',
				time : 3
			});

			return false;
		}

		if ($("#rec_phone").val() == "" && $("#rec_phone").val() == "") {
			$("#rec_phone").focus();
			$("#rec_phone").tips({
				side : 3,
				msg : "请输入联系电话",
				bg : '#AE81FF',
				time : 3
			});
			return false;
		}
		if ($("#car_time").val() == "" && $("#car_time").val() == "") {
			$("#car_time").focus();
			$("#car_time").tips({
				side : 3,
				msg : "请输入日期",
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
								<div class="panel-heading">承运单基本信息</div>
								<div class="panel-body">
										<div class="row" style="margin-left: 10px">
											<div class="form-group form-inline">
												<span style="color: red;">*</span> 
												<label style="width: 15%">发票编号:</label>
												<input style="width: 30%" type="text" type="text" name="inv_no" readonly
													id="inv_no" value="${pd.inv_no}" placeholder="这里输入发票金额"
													title="发票金额" class="form-control">
												<span style="color: red;">*</span>
													<label style="width: 15%">承运单号:</label>
													<input style="width: 30%" type="text" type="text" name="car_no"
													id="car_no" value="${pd.car_no}" placeholder="这里输入承运单号"
													title="承运单号" class="form-control">	
											</div>
											<div class="form-group form-inline">
												<span style="color: red;">*</span> 
												<label style="width: 15%">承运公司:</label>
												<input style="width: 30%" type="text" type="text" name="car_company" 
													id="car_company" value="${pd.car_company}" placeholder="这里输入承运公司"
													title="承运公司" class="form-control">
													<span style="color: red;">*</span>
													<label style="width: 15%">承运金额:</label> 
												<input style="width: 30%" type="text" type="text" name="car_money" 
													id="car_money" value="${pd.car_money}" placeholder="这里输入承运金额"
													 title="承运金额" class="form-control">
											</div>
											<div class="form-group form-inline">
												<span style="color: red;">*</span> 
												<label style="width: 15%">收货公司:</label> 
												<input style="width: 30%" type="text" type="text" name="rec_company" 
													id="rec_company" value="${pd.inv_company}" placeholder="这里输入收货公司"
													readonly="readonly" title="收货公司" class="form-control">
													<span style="color: red;">*</span>
												<label style="width: 15%">公司地址:</label> 
												<input style="width: 30%" type="text" type="text" name="rec_address" 
													id="rec_address" value="${pd.inv_comp_address}" placeholder="这里输入公司地址"
													readonly="readonly" title="公司地址" class="form-control">
											</div>
											<div class="form-group form-inline">
												<span style="color: red;">*</span> 
												<label style="width: 15%">收货人:</label> 
												<input style="width: 30%" type="text" type="text" name="rec_consignee" 
													id="rec_consignee" value="${pd.rec_consignee}" placeholder="这里输入收货人"
													title="收货人" class="form-control">
													<span style="color: red;">*</span>
												<label style="width: 15%">联系电话:</label> 
												<input style="width: 30%" type="text" type="text" name="rec_phone" 
													id="rec_phone" value="${pd.rec_phone}" placeholder="这里输入联系电话"
													title="联系电话" class="form-control">
											</div>
											<div class="form-group form-inline">
											    <span style="color: red;">*</span>
												 <label style="width: 15%">日期:</label> 
												 <input style="width: 30%" type="text" type="text" name="car_time" 
													id="car_time" value="${pd.car_time}" placeholder="这里输入日期"
													onclick="laydate()" readonly="readonly" title="日期" class="form-control">
												<label style="width: 15%">备注:</label> 
												 <input style="width: 30%" type="text" type="text" name="remarks" 
													id="remarks" value="${pd.remarks}" placeholder="这里输入备注"
												    title="备注" class="form-control">
											</div>
										</div>
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
