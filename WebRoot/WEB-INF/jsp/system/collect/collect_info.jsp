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
	});

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
<form action="collect/saveInfo.do" name="infoForm" id="infoForm" method="post">
	<input type="hidden" name="stage" id="stage" value="${pd.stage}">
	<input type="hidden" name="item_id" id="item_id" value="${pd.item_id}">
	<input type="hidden" name="flag" id="flag" value="${pd.flag}">
    <div class="wrapper wrapper-content" style="z-index: -1">
        <div class="row">
            <div class="col-sm-12" >
                <div class="ibox float-e-margins">
                    <div class="ibox-content">
                		<div class="row">
                			<div class="col-sm-12">
                    			<div class="panel panel-primary">
                                    <div class="panel-heading">
                                        登记历史
                                    </div>
                        			<div class="panel-body">
	                                    <div class="form-group form-inline">
	                                        <table id="tab" class="table table-striped table-bordered table-hover">
				                                <thead>
				                                    <tr>
				                                        <th style="width:3%;">付款人</th>
				                                        <th style="width:5%;">付款金额</th>
				                                        <th style="width:5%;">付款方式</th>
				                                        <th style="width:5%;">收款人</th>
				                                        <th style="width:5%;">付款时间</th>
				                                    </tr>
				                                </thead>
				                                <tbody>
				                                <!-- 开始循环 -->
												<c:choose>
													<c:when test="${not empty infoList}">
														<c:forEach items="${infoList}" var="var">
															<tr>
																<td>${var.payman}</td>
																<td>${var.total}</td>
																<td>${var.payment}</td>
																<td>${var.payee}</td>
																<td>${var.input_date}</td>
															</tr>
														</c:forEach>
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
                                    <div class="panel-heading">
                                        收款信息
                                    </div>
                        			<div class="panel-body">
	                                    <div class="form-group form-inline">
	                                        <label style="width:10%;">付款人:</label>
	                                        <input type="text" name="payman" id="payman" class="form-control"/>
	                                        <label style="width:10%;">付款金额:</label>
	                                        <input type="text" name="total" id="total" class="form-control"/>
	                                    </div>
	                                    <div class="form-group form-inline">
	                                        <label style="width:10%;">付款方式:</label>
	                                        <input type="text" name="payment" id="payment" class="form-control"/>
	                                        <label style="width:10%;">收款人:</label>
	                                        <input type="text" name="payee" id="payee" class="form-control"/>
	                                    </div>
	                                    <div class="form-group form-inline">
	                                        <label style="width:10%;">描述:</label>
	                                        <input type="text" name="descript" id="descript" class="form-control"/>
	                                    </div>
	                    			</div>
	                    		</div>
	                    	</div>
	                    </div>
	                    <div class="ibox-content">
						<div style="height: 20px;"></div>
						<tr>
						<c:if test="${operateType!='sel'}">
							<td>
								<a class="btn btn-primary" style="width: 150px; height:34px;float:left;"  onclick="save();">保存</a>
							</td>					
						</c:if>	
						<td>
							<a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('SetInfo');">关闭</a>
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
		$("#infoForm").submit();
	}

	//关闭
	function CloseSUWin(id) {
		window.parent.$("#" + id).data("kendoWindow").close();
		/* 	window.parent.location.reload(); */
	}
</script>
</body>

</html>
