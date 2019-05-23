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
		
		
		
		
		var jsonStr="[";
		var details_id;
		var total;

		$("#collectStage tr:not(:first)").each(function(){
			details_id = $(this).find("td").eq(0).text();
			total = $(this).find("td").eq(2).find("input").eq(0).val();
			jsonStr += "{'details_id':'"+details_id+"','total':'"+total+"'},";
		});
		jsonStr = jsonStr.substring(0,jsonStr.length-1)+"]";
		$("#data").val(jsonStr);
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
	<form action="comefund/${msg}.do" name="cellForm" id="cellForm" method="post">
		<input type="hidden" name="come_fund_id" id="come_fund_id" value="${pd.com_no}" /> 
		<input type="hidden" name="data" id="data"/> 
		<div class="wrapper wrapper-content">
			<div class="row">
				<div class="col-sm-12">
					<div class="ibox float-e-margins">
						<div class="ibox-content1">
						
							<div class="panel panel-primary">
								<div class="panel-heading">认领来款</div>
								  <div class="panel-body">
										<div class="row" style="margin-left: 10px">
											<div class="form-group form-inline">
												<span style="color: red;">*</span> 
												<label style="width: 15%">选择项目:</label>
												<select style="width: 30%" class="form-control" name="item_id" readonly id="item_id">
													<option value="">请选择</option>
													<c:forEach items="${collectSet}" var="co">
														<option value="${co.item_id}"
															<c:if test="${co.item_id eq pd.item_id}">selected</c:if>>${co.item_name}</option>
													</c:forEach>
												</select> 
												<span type="hidden">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</span>
												<label style="width: 15%">项目总金额:</label>
													<input style="width: 30%" type="text" name="item_total" id="item_total" readonly
													 value="${pd.item_total}"placeholder="这里输入来款账户" title="来款账户" class="form-control" /> 
											</div>
											<div class="form-group form-inline"> 
											<span type="hidden">&nbsp&nbsp</span>
												<label style="width: 15%">来款金额:</label>
												<input style="width: 30%" type="text" name="com_money" id="com_money" value="${pd.com_money}"
													readonly placeholder="这里输入来款金额" title="来款金额" class="form-control" /> 
												<span type="hidden">&nbsp&nbsp&nbsp&nbsp</span>
												<span style="color: red;">*</span>
												<label style="width: 15%">资金使用类型:</label>
												<select style="width: 30%" class="form-control" name="status" id="status" readonly>
														<option value="">请选择</option>
														<option value="0">项目使用</option>
														<option value="1">核销额度</option>
												</select> 
											</div>
										</div>
									</div>
							</div>
							<div class="panel panel-primary">
                                <div class="panel-heading">应收款信息</div>
								 <div class="panel-body">
									<div class="row" >
									    <table style="margin-top: -15px" id="collectSet" class="table table-striped table-bordered table-hover">
								          <thead>
									          <tr>
									           	  <th>项目名称</th>
										          <th>总金额</th>
										          <th>订金</th>
										          <th>排产款</th>
										          <th>发货款</th>
										          <th>安装开工款</th>
										          <th>货到工地款</th>
										          <th>调试款</th>
										          <th>安装验收款</th>
										          <th>设备验收款</th>
										          <th>质保金</th>
									          </tr>
								        </thead>
								        <tbody>
									          <tr>
										          <td>null</td>
										          <td>null</td>
										          <td>null</td>
										          <td>null</td>
										          <td>null</td>
										          <td>null</td>
										          <td>null</td>
										          <td>null</td>
										          <td>null</td>
										          <td>null</td>
										          <td>null</td>
									          </tr>
								       </tbody>
							        </table>
                                  </div>
                                 </div>
                                </div>
                                <div class="panel panel-primary">
								<div class="panel-heading">分款</div>
								 <div class="panel-body">
										<div class="row" style="margin-left: 10px">
											<div class="form-group form-inline">
											<span style="color: red;">*</span> 
												<label style="width: 15%">选择分款阶段:</label>
												<select style="width: 28%" class="form-control" name="stage" id="stage" readonly>
														<option value="0">请选择</option>
														<option value="contract">订金</option>
														<option value="product">排产款</option>
														<option value="shipment">发货款</option>
														<option value="install">安装开工款</option>
														<option value="arrival">货到工地款</option>
														<option value="adjust">调试款</option>
														<option value="accept">安装验收款</option>
														<option value="remit">设备验收款</option>
														<option value="quality">质保金</option>
												</select> 
												<span type="hidden">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</span> 
												<label style="width: 15%">请输入分款金额:</label>
												<input style="width: 28%" type="text" name="money" id="money" value="${pd.money}"
													placeholder="这里输入金额" title="金额" class="form-control" /> 
												<button class="btn  btn-primary btn-sm" title="计算"type="button" onclick="jisuan();">计算</button>
										</div>
								</div>
							</div>
							</div>
							<div class="panel panel-primary">
                                <div class="panel-heading">电梯应收款信息</div>
								 <div class="panel-body">
									<div class="row" >
									    <table style="margin-top: -15px" id="collectStage" class="table table-striped table-bordered table-hover">
								          <thead>
									          <tr>
									           	  <th>电梯编号</th>
										          <th>应收款</th>
										          <th>分款</th>
									          </tr>
								        </thead>
								        <tbody>
								  <%--       <!-- 开始循环 -->
									<c:choose>
										<c:when test="${not empty collectStage}">
											<c:if test="${QX.cha == 1 }">
												<c:forEach items="${collectStage}" var="cs" varStatus="vs">
													<tr>
														<td>${cs.details_id}</td>
														<td>${cs.total}</td>
														<td></td>
													</tr>
												</c:forEach>
											</c:if>
										</c:when>
									</c:choose> --%>
								       </tbody>
							        </table>
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
	//选中项目后，加载项目信息和该项目的应收款信息
	$("#item_id").change(function() {
		var item_id = $(this).find("option:checked").attr("value"); //获取选中值的编号
		$.ajax({
			url : "comefund/checkeditem.do", //请求地址
			type : "POST", //请求方式
			data : {
				'item_id' : item_id
			}, //请求参数
			success : function(result) {
				$("#item_total").val(result.collectSet.total);
				$("#collectSet tr:not(:first)").each(function(){
					$(this).find("td").eq(0).text(result.collectSet.item_name);
					$(this).find("td").eq(1).text(result.collectSet.total);
					$(this).find("td").eq(2).text(result.collectSet.contract);
					$(this).find("td").eq(3).text(result.collectSet.product);
					$(this).find("td").eq(4).text(result.collectSet.shipment);
					$(this).find("td").eq(5).text(result.collectSet.install);
					$(this).find("td").eq(6).text(result.collectSet.arrival);
					$(this).find("td").eq(7).text(result.collectSet.adjust);
					$(this).find("td").eq(8).text(result.collectSet.accept);
					$(this).find("td").eq(9).text(result.collectSet.remit);
					$(this).find("td").eq(10).text(result.collectSet.quality);
				});
			}
		});
	});
	
	//选中分款阶段后，加载该阶段的电梯应收款信息
	$("#stage").change(function() {
		var item_id=$("#item_id").val();
		var stage_no = $(this).find("option:checked").attr("value"); //获取选中值的编号
		if(stage_no=="product"||stage_no=="shipment"||stage_no=="install"||stage_no=="adjust"||stage_no=="accept"||stage_no=="remit"||stage_no=="quality")
		{
			$.ajax({
				url : "comefund/checkedele.do", //请求地址
				type : "POST", //请求方式
				data : {
					'stage_no' : stage_no,
					'item_id':item_id
				}, //请求参数
				success : function(result) {
					//$("#item_total").val(result.collectSet.total);
					/* $("#collectStage tr:not(:first)").each(function(){
						$(this).find("td").eq(0).text(result.collectStage.details_id);  //电梯编号
						$(this).find("td").eq(1).text(result.collectStage.total);       //应收款
					}); */
					var a="";
					for(var i=0;i<result.collectStage.length;i++)
					{
						a+="<tr><td>"+result.collectStage[i].details_id+"</td><td>"+result.collectStage[i].total+"</td><td><input type='text' placeholder='请输入分款金额' class='form-control'/></td></tr>"
					}
					$("#collectStage tr:not(:first)").html("");
					$("#collectStage").append(a);
				}
			});
		}
	});
	function jisuan()
	{
		var price=0;
		$("#collectStage tr:not(:first)").each(function(){
			var a=$(this).find("td").eq(2).find("input").eq(0).val()
			var b=parseInt(a)
			//console.log(b);
			//console.log("b"+isNaN(b));
			//console.log("price"+isNaN(price));
			price+=b;
			//console.log(price);
		});
		$("#money").val(price);
	}
</script>
</html>
