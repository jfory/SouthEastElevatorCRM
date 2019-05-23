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
<!-- Check Box -->
<link href="static/js/iCheck/custom.css" rel="stylesheet">


<title>信息查看</title>
<!-- jsp文件头和头部 -->
<%@ include file="../../system/admin/top.jsp"%>

<!-- iCheck -->
<script src="static/js/iCheck/icheck.min.js"></script>
<!-- 日期控件-->
<script src="static/js/layer/laydate/laydate.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		//loading end
		parent.layer.closeAll('loading');
		/* checkbox */
        $('.i-checks').iCheck({
            checkboxClass: 'icheckbox_square-green',
            radioClass: 'iradio_square-green',
        });

        setElevator();

	});
	

	//修改合同变更类型
	function setType(){
		setElevator();
	}

	//设置电梯
	function setElevator(){
		var c_id = $("#c_id").val();
		$("#type_1").show();
		$.post("<%=basePath%>contractModify/setElevator.do?c_id="+c_id,
			function(data){
				var jsonStr = "<option value=''>请选择电梯</option>"; 
				for(var i=0;i<data.list.length;i++){
					jsonStr += "<option value='"+data.list[i].id+"'>"+data.list[i].no+"</option>";
				}
				//$("#elevator").append(jsonStr);
				$("select[name='elevator']").append(jsonStr);
			}
		);
	}

	//加载电梯详细信息
	function loadElevatorInfo(obj){
		var elevator_id = $(obj).val();
		$.post("<%=basePath%>contractModify/loadElevatorInfo.do?elevator_id="
				+ elevator_id, function(data) {
			$(obj).parent().parent().find("td").eq(2).text(data.data.total);
		});
	}
	

	//保存
	function save() {
		/*var str;
		$("input[name='type']:checked").each(function(){
			alert($(this).val());
			str+=$(this).val()+",";
		});
		str = str.substring(0,str.length-1);
		$("#type").val(str);*/
		setElevatorJson();
		$("#modifyForm").submit();
	}

	//处理电梯
	function setElevatorJson() {
		var elevatorId;
		var elevatorStatus;
		var elevatorTotal;
		var elevatorDescript;

		var jsonStr = "[";
		$("#tab tr:not(:first)").each(
				function() {
					elevatorId = $(this).find("td").eq(0).find("select").eq(0)
							.val();
					elevatorStatus = $(this).find("td").eq(1).html();
					elevatorTotal = $(this).find("td").eq(2).html();
					elevatorDescript = $(this).find("td").eq(3).find("input")
							.eq(0).val();
					jsonStr += "{\'elevator_id\':\'" + elevatorId
							+ "\',\'elevator_status\':\'" + elevatorStatus
							+ "\',\'elevator_total\':\'" + elevatorTotal
							+ "\',\'elevator_descript\':\'" + elevatorDescript
							+ "\'},";
				});
        jsonStr = (jsonStr.length>1?jsonStr.substring(0,jsonStr.length-1): jsonStr)+"]";

		console.log(jsonStr);

		$("#elevatorJson").val(jsonStr);

	}

	//添加行
	function addRow() {
		var tr = $("#tab").find("tr").eq(1).clone();
		$(tr)
				.find("td:last")
				.html("")
				.append(
						"<td><input type='button' value='删除' onclick='delRow(this)'></td>");
		$("#tab").append(tr);
	}

	//删除行
	function delRow(obj) {
		$(obj).parent().parent().parent().remove();
	}

	//上传下载部分
	function upload(e, v) {
		var filePath = $(e).val();
		var arr = filePath.split("\\");
		var fileName = arr[arr.length - 1];
		var suffix = filePath.substring(filePath.lastIndexOf("."))
				.toLowerCase();
		/*var fileType = ".xls|.xlsx|.doc|.docx|.txt|.pdf|"; */
		if (filePath == null || filePath == "") {
			$(v).val("");
			return false;
			/*if(fileType.indexOf(suffix+"|")==-1){
			}
			    var ErrMsg = "该文件类型不允许上传。请上传 "+fileType+" 类型的文件，当前文件类型为"+suffix; 
			    $(e).val("");
			    alert(ErrMsg);
			    return false;
			}*/

			//var data = new FormData($("#agentForm")[0]);
			var data = new FormData();

			data.append("file", $(e)[0].files[0]);

			$.ajax({
				url : "contractModify/upload.do",
				type : "POST",
				data : data,
				cache : false,
				processData : false,
				contentType : false,
				success : function(result) {
					if (result.success) {
						$(v).val(result.filePath);
					} else {
						alert(result.errorMsg);
					}
				}
			});
		}
	}
	// 下载文件   e代表当前路径值 
	function downFile(e) {
		var downFile = $(e).val();
		window.location.href = "customer/down?downFile=" + downFile;
	}

	function CloseSUWin(id) {
		window.parent.$("#" + id).data("kendoWindow").close();
	}
</script>
</head>

<body class="gray-bg">
	<form action="contractNew/.do" name="infoForm" id="infoForm"
		method="post">
		<%-- 
<input type="hidden" name="id" id="id" value="${pd.id}"/>
<input type="hidden" name="operateType" id="operateType" value="${operateType}"/>
<input type="hidden" name="elevatorJson" id="elevatorJson">
<input type="hidden" name="type" id="type">
--%>
		<div class="wrapper wrapper-content">
			<div class="row">
				<div class="col-sm-12">
					<div class="ibox float-e-margins">

						<div class="row">
							<div class="col-sm-12">
								<div class="panel panel-primary">
									<div class="panel-heading">项目信息</div>
									<div class="panel-body">
										<div class="form-group form-inline">
											<label style="width: 10%; margin-left: 10px;">项目号:</label> <input
												style="width: 20%" type="text" name="project_number"
												readonly="readonly" id="project_number"
												value="${info.project_number}" title="项目号"
												class="form-control" /> <label
												style="width: 10%; margin-left: 10px;">客户名称:</label> <input
												style="width: 20%" type="text" name="customer_name"
												readonly="readonly" id="customer_name"
												value="${info.customer_name}" title="客户名称"
												class="form-control" />
												<label
												style="width: 10%; margin-left: 10px;">项目名称:</label> <input
												style="width: 20%" type="text" name="Elevator_num"
												readonly="readonly" id="Elevator_num"
												value="${info.Elevator_num}" title="台数"
												class="form-control" />
												
										</div>

										<div class="form-group form-inline">
											<label style="width: 10%; margin-left: 10px;">开票主体:</label> <input
												style="width: 20%" type="text" name="project_number"
												readonly="readonly" id="project_number"
												value="${info.project_number}" title="项目号"
												class="form-control" /> <label
												style="width: 10%; margin-left: 10px;">购货单位名称:</label> <input
												style="width: 20%" type="text" name="customer_name"
												readonly="readonly" id="customer_name"
												value="${info.customer_name}" title="客户名称"
												class="form-control" />
												<label
												style="width: 10%; margin-left: 10px;">纳税人识别号:</label> <input
												style="width: 20%" type="text" name="Elevator_num"
												readonly="readonly" id="Elevator_num"
												value="${info.Elevator_num}" title="台数"
												class="form-control" />
												
										</div>
										
										<div class="form-group form-inline">
											<label style="width: 15%; margin-left: 10px;">开票地址:</label> <input
												style="width: 30%" type="text" name="project_name"
												readonly="readonly" id="project_name"
												value="${info.project_name}" title="项目名称"
												class="form-control" /> 
												<label style="width: 15%; margin-left: 10px;">项目地址:</label> <input
												style="width: 30%" type="text" name="nstallation_address"
												readonly="readonly" id="nstallation_address"
												value="${info.nstallation_address}" title="安装地址"
												class="form-control" /> 
										</div>
										
										<div class="form-group form-inline">
											<label style="width: 10%; margin-left: 10px;">开户行:</label> <input
												style="width: 20%" type="text" name="Total_contract"
												readonly="readonly" id="Total_contract"
												value="${info.Total_contract}" title="合同总额"
												class="form-control" /> <label
												style="width: 10%; margin-left: 10px;">银行账号:</label> <input
												style="width: 20%" type="text" name="Out_amount"
												readonly="readonly" id="Out_amount"
												value="${info.Out_amount}" title="未开票金额"
												class="form-control" />
												<label
												style="width: 10%; margin-left: 10px;">邮编:</label> <input
												style="width: 20%" type="text" name="In_amount"
												readonly="readonly" id="In_amount"
												value="${info.In_amount}" title="已开票金额"
												class="form-control" />
										</div>
										
										<div class="form-group form-inline">
											<label style="width: 10%; margin-left: 10px;">邮寄地址:</label> <input
												style="width: 20%" type="text" name="Total_contract"
												readonly="readonly" id="Total_contract"
												value="${info.Total_contract}" title="合同总额"
												class="form-control" /> <label
												style="width: 10%; margin-left: 10px;">收件人:</label> <input
												style="width: 20%" type="text" name="Out_amount"
												readonly="readonly" id="Out_amount"
												value="${info.Out_amount}" title="未开票金额"
												class="form-control" />
												<label
												style="width: 10%; margin-left: 10px;">电话:</label> <input
												style="width: 20%" type="text" name="In_amount"
												readonly="readonly" id="In_amount"
												value="${info.In_amount}" title="已开票金额"
												class="form-control" />
										</div>
										
										
										<div class="form-group form-inline">
											<label style="width: 10%; margin-left: 10px;">合同总额:</label> <input
												style="width: 20%" type="text" name="Total_contract"
												readonly="readonly" id="Total_contract"
												value="${info.Total_contract}" title="合同总额"
												class="form-control" /> <label
												style="width: 10%; margin-left: 10px;">未开票金额:</label> <input
												style="width: 20%" type="text" name="Out_amount"
												readonly="readonly" id="Out_amount"
												value="${info.Out_amount}" title="未开票金额"
												class="form-control" />
												<label
												style="width: 10%; margin-left: 10px;">已开票金额:</label> <input
												style="width: 20%" type="text" name="In_amount"
												readonly="readonly" id="In_amount"
												value="${info.In_amount}" title="已开票金额"
												class="form-control" />
										</div>
										
										
										<div class="form-group form-inline">
											<label style="width: 10%; margin-left: 10px;">录入人:</label> <input
												style="width: 20%" type="text" name="Total_contract"
												readonly="readonly" id="Total_contract"
												value="${info.Total_contract}" title="合同总额"
												class="form-control" /> <label
												style="width: 10%; margin-left: 10px;">录入时间:</label> <input
												style="width: 20%" type="text" name="Out_amount"
												readonly="readonly" id="Out_amount"
												value="${info.Out_amount}" title="未开票金额"
												class="form-control" />
												<label
												style="width: 10%; margin-left: 10px;">台数:</label> <input
												style="width: 20%" type="text" name="In_amount"
												readonly="readonly" id="In_amount"
												value="${info.In_amount}" title="已开票金额"
												class="form-control" />
										</div>
													
									</div>
								</div>
							</div>
						</div>


						<div class="row" >
							<div class="col-sm-12">
								<div class="panel panel-primary">
									<div class="panel-heading">应收款信息</div>
									<div class="panel-body">
										<div class="form-group form-inline">
											<table id="tab"
												class="table table-striped table-bordered table-hover">
												<tr>

													<th style="width:5%;">期数</th>
													<th style="width:15%;">款项</th>
													<th style="width:15%;">应收金额</th>
													<th style="width:15%;">应收日期</th>
													<th style="width:15%;">偏差天数</th>
													<th style="width:15%;">未开金额</th>
													<th style="width:15%;">已开金额</th>
												</tr>
												<tbody>
										          <!-- 开始循环-->
									<c:choose>
										<c:when test="${not empty table}">
										<tr>
												<c:forEach items="${table}" var="var">
														<td>${var}</td>
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
							</div>
						</div>
						
						<%-- 
						<div class="row" >
							<div class="col-sm-12">
								<div class="panel panel-primary">
									<div class="panel-heading">电梯信息</div>
									<div class="panel-body">
										<div class="form-group form-inline">
											<table id="tab"
												class="table table-striped table-bordered table-hover">
												<tr>
												   <th style="width:5%;"><input type="checkbox" name="zcheckbox1" id="zcheckbox1" class="i-checks" >
													<th style="width:10%;">梯号</th>
													<th style="width:40%;">梯种</th>
													<th style="width:15%;">载重</th>
													<th style="width:15%;">速度</th>
													<th style="width:15%;">提升高度</th>
												</tr>
												<tbody>
										          <!-- 开始循环-->
									<c:choose>
										<c:when test="${not empty table}">
										<tr>
												<c:forEach items="${table}" var="var">
														<td>${var}</td>
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
							</div>
						</div> 
                       --%>

						<div class="row">
							<div class="col-sm-12">
								<div class="panel panel-primary">
									<div class="panel-heading">开票信息</div>
									<div class="panel-body">
										<div class="form-group form-inline">
											<label style="width: 10%; margin-left: 10px;">已选应收款:</label> <input
												style="width: 20%" type="text" name="Selected_receivables"
												readonly="readonly" id="Selected_receivables"
												value="${info.Selected_receivables}" title="已选应收款"
												class="form-control" /> <label
												style="width: 10%; margin-left: 10px;">本次已开金额:</label> <input
												style="width: 20%" type="text" name="this_amount"
												readonly="readonly" id="invoice_value"
												value="${info.this_amount}" title="本次已开金额"
												class="form-control" />
												<label
												style="width: 10%; margin-left: 10px;">本次未开金额:</label> <input
												style="width: 20%" type="text" name="this_no_amount"
												readonly="readonly" id="this_no_amount"
												value="${info.this_no_amount}" title="本次未开金额"
												class="form-control" />
												
										</div>
										
										<div class="form-group form-inline">
											<table id="tab"
												class="table table-striped table-bordered table-hover">
												<tr>
												    <th style="width:5%;">序号</th>							   
													<th style="width:15%;">型号</th>
													<th style="width:15%;">台数</th>
													<th style="width:15%;">发票类型</th>
													<th style="width:10%;">税率</th>
													<th style="width:10%;">开票金额</th>
													<th style="width:10%;">单价</th>
													<th style="width:10%;">比例</th>
													<th style="width:10%;">款项类型</th>
												</tr>
												<tbody>
										          <!-- 开始循环-->
									<c:choose>
										<c:when test="${not empty table}">
										<tr>
												<c:forEach items="${table}" var="var">
														<td>${var}</td>
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
							</div>
						</div>
                     
                     <div class="row">
							<div class="col-sm-12">
								<div class="panel panel-primary">
									<div class="panel-heading">审批信息</div>
									<div class="panel-body">
										<div class="form-group form-inline">
											<table id="tab"
												class="table table-striped table-bordered table-hover">
												<tr>																   
													<th style="width:20%;">处理环节</th>
													<th style="width:20%;">处理人</th>
													<th style="width:20%;">处理结果</th>
													<th style="width:20%;">处理意见</th>
													<th style="width:20%;">处理时间</th>	
												</tr>
												<tbody>
										          <!-- 开始循环-->
									<c:choose>
										<c:when test="${not empty table}">
										<tr>
												<c:forEach items="${table}" var="var">
														<td>${var}</td>
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
										
										<div class="form-group form-inline">
											<label style="width: 10%; margin-left: 10px;">发票号:</label> <input
												style="width: 20%" type="text" name="Selected_receivables"
												readonly="readonly" id="Selected_receivables"
												value="${info.Selected_receivables}" title="已选应收款"
												class="form-control" /> <label
												style="width: 10%; margin-left: 10px;">快递号:</label> <input
												style="width: 20%" type="text" name="this_amount"
												readonly="readonly" id="invoice_value"
												value="${info.this_amount}" title="本次已开金额"
												class="form-control" />
												<label
												style="width: 10%; margin-left: 10px;">上传:</label> 
												<input style="width:20%" class="form-control" type="file"  title="附件" onchange="upload(this,$('#file'))" />
										
												
										</div>
										
										
										
										
									</div>
								</div>
							</div>
						</div>




<%-- 
						<tr>
							<td><a class="btn btn-primary"
								style="width: 150px; height: 34px; float: left;"
								onclick="save();">保存</a></td>
							<td><a class="btn btn-danger"
								style="width: 150px; height: 34px; float: right;"
								onclick="javascript:CloseSUWin('EditModify');">关闭</a></td>
						</tr>
--%>						
					</div>
				</div>

			</div>
		</div>
	</form>
</body>

</html>
