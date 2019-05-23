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


    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title>${pd.SYSNAME}</title>
	<!-- jsp文件头和头部 -->
	<%@ include file="../../system/admin/top.jsp"%> 
	<!-- 日期控件-->
    <script src="static/js/layer/laydate/laydate.js"></script>
	<script type="text/javascript">
	
	$(document).ready(function(){
		parent.layer.closeAll('loading');

		setItemOption();
	});

	//获取项目信息下拉列表
	function setItemOption(){
		$.post("<%=basePath%>collect/findItemOption.do",
			function(data){
				var itemStr;
				var itemObj = data.itemList;
				for(var i=0;i<itemObj.length;i++){
					itemStr += "<option value='"+itemObj[i].item_id+"'>"+itemObj[i].item_name+"</option>";
				}
				$("#item_id").append(itemStr);
			}
		);
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
		/* 	window.parent.location.reload(); */
	}

	</script>
</head>

<body class="gray-bg">
<form action="collect/saveCollectMoney.do" name="collectMoneyForm" id="collectMoneyForm" method="post">
	<input type="hidden" name="c_id" id="c_id" value="${c_id}"/>
    <div class="wrapper wrapper-content" style="z-index: -1">
        <div class="row">
            <div class="col-sm-12" >
                <div class="ibox float-e-margins">
                    <div class="ibox-content">

                    		<div class="row">
                    			<div class="col-sm-12">
                        			<div class="panel panel-primary">
	                                    <div class="panel-heading">
	                                        收款历史
	                                    </div>
                            			<div class="panel-body">
		                                    <table class="table table-striped table-bordered table-hover">
				                                <thead>
				                                    <tr>
				                                        <th style="width:5%;">来款人</th>
				                                        <th style="width:10%;">收款人</th>
				                                        <th style="width:10%;">收款金额</th>
				                                        <th style="width:10%;">收款日期</th>
				                                    </tr>
				                                </thead>
				                                <tbody>
				                                	<c:forEach items="${collectMoneyList}" var="var">
				                                		<tr>
				                                			<td>${var.payee}</td>
				                                			<td>${var.user}</td>
				                                			<td>${var.total}</td>
				                                			<td>${var.input_date}</td>
				                                		</tr>
														<tr></tr>
				                                	</c:forEach>
				                                </tbody>
				                            </table>
				                            <div class="form-group form-inline">
			                            		<label>总需收款:</label>
				                            	<input type="text" class="form-control" value="${total}"/>
				                            </div>

				                            <div class="form-group form-inline">
				                            	<label>当前收款:</label>
				                            	<input type="text" class="form-control" value="${payTotal}"/>
				                            </div>
		                    			</div>
		                    		</div>
		                    	</div>
		                    </div>

                    		<div class="row">
                    			<div class="col-sm-12">
                        			<div class="panel panel-primary">
	                                    <div class="panel-heading">
	                                        收款信息
	                                    </div>
                            			<div class="panel-body">
		                                    <div class="form-group form-inline">
		                                        <label style="width:10%;">付款人:</label>
		                                        <input type="text" name="payee" id="payee" class="form-control" placeholder="这里输入付款人">
		                                    </div>

		                                    <div class="form-group form-inline">
		                                        <label style="width:10%;">金额:</label>
		                                        <input type="text" name="total" id="total" class="form-control" placeholder="这里输入金额">
		                                    </div>

		                                    <div class="form-group form-inline">
		                                        <label style="width:10%;">收款人:</label>
		                                        <input type="text" name="user" id="user" class="form-control" placeholder="这里输入收款人">
		                                    </div>

		                                    <div class="form-group form-inline">
		                                        <label style="width:10%;">描述:</label>
				                                <textarea rows="3" cols="13" name="descript" id="descript" class="form-control" placeholder="这里输入描述"></textarea>
		                                    </div>

		                                    <c:if test="${itemType==1}">
			                                    <div class="form-group form-inline">
			                                    	<label>付款方式:</label>
			                                    	<select name="payment" id="payment" class="form-control m-b">
			                                    		<option value=''>请选择付款方式</option>
			                                    		<option value='1'>额度支付</option>
			                                    		<option value='2'>现金支付</option>
			                                    	</select>
			                                    </div>
		                                    </c:if>
		                    			</div>
		                    		</div>
		                    	</div>
		                    </div>

						<div style="height: 20px;"></div>
						<tr>
						<c:if test="${operateType!='sel'}">
							<td>
								<a class="btn btn-primary"style="width: 150px; height:34px;float:left;"  onclick="save();">保存</a>
							</td>					
						</c:if>	
						<td>
							<a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('collectMoneyForm');">关闭</a>
						</td>
						</tr>
					</div>
				</div>
			</div>
		</div>   
 </div>
 </form>
<!-- Sweet alert -->
<script src="static/js/sweetalert/sweetalert.min.js"></script>
<script type="text/javascript">


	//保存
	function save(){
		$("#collectMoneyForm").submit();
	}
</script>
</body>

</html>
