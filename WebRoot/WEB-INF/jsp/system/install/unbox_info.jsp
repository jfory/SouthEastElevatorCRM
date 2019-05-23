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
    <!-- Sweet Alert -->
    <link href="static/js/sweetalert/sweetalert.css" rel="stylesheet">
	<script src="static/js/sweetalert/sweetalert.min.js"></script>
	<script type="text/javascript">
	
	//保存
	function save(){
		//json
		setBillDefect();
		$("#unboxForm").submit();
	}
		
	function CloseSUWin(id) {
		window.parent.$("#" + id).data("kendoWindow").close();
		/* 	window.parent.location.reload(); */
	}

	function showDiv(){
		var defect = $("#is_defect").val();
		if(defect=="1"){
			$("#defectDiv").show();
		}else{
			$("#defectDiv").hide();
		}
	}

	//添加行,
	function addRow(){
		var tr = $("table tr").eq(1).clone();
		$(tr).find("td").eq(0).find("input").eq(0).val("");
		$(tr).find("td").eq(1).find("input").eq(0).val("");
		$(tr).find("td").eq(2).find("input").eq(0).val("");
		$(tr).find("td").eq(3).find("select").eq(0).val("");
		$(tr).find("td:last").html("").append("<td><input type='button' value='删除' onclick='delRow(this)'></td>");
		$("#tab").append(tr);
	}

	//删除行
	function delRow(obj){
		$(obj).parent().parent().parent().remove();
	}

	//生成json
	function setBillDefect(){

		var name = "";
		var model = "";
		var num = "";
		var type = "";
		var jsonStr = "[";

		$("#tab tr:not(:first)").each(function(){
			name = $(this).find("td").eq(0).find("input").eq(0).val();
			model = $(this).find("td").eq(1).find("input").eq(0).val();
			num = $(this).find("td").eq(2).find("input").eq(0).val();
			type = $(this).find("td").eq(3).find("select").eq(0).val();
			jsonStr += "{\'name\':\'"+name+"\',\'model\':\'"+model+"\',\'num\':\'"+num+"\',\'type\':\'"+type+"\'},";
		});
		jsonStr = jsonStr.substring(0,jsonStr.length-1)+"]";
		$("#bill_defect").val(jsonStr);
	}

	
	</script>
</head>

<body class="gray-bg">
<form action="install/saveUnboxInfo.do" name="unboxForm" id="unboxForm" method="post">
<input type="hidden" name="id" id="id" value="${pd.id}"/>
<input type="hidden" name="encasement_id" id="encasement_id" value="${pd.encasement_id}"/>
<input type="hidden" name="receive_id" id="receive_id" value="${pd.receive_id}"/>
<input type="hidden" name="bill_defect" id="bill_defect" value="${pd.bill_defect}"/>
    <div class="wrapper wrapper-content">
        <div class="row">
            <div class="col-sm-12">
                <!-- <div class="ibox float-e-margins"> -->
                    <div class="row">
	        			<div class="col-sm-12">
	            			<div class="panel panel-primary">
	                            <div class="panel-heading">
	                                货物信息
	                            </div>
	                			<div class="panel-body">        
	                                <div class="form-group form-inline">   
	                          			<label>货物箱编号:</label>
	                          			<input type="text" value="${pd.encasement_no}" class="form-control" disabled="disabled">
	                          			<label>货物箱名称:</label>
	                          			<input type="text" value="${pd.encasement_name}" class="form-control" disabled="disabled">
	                				</div>
                    			</div>
		                    </div>
		                </div>
		            </div>
            	<!-- </div> -->
            	<div class="row">
        			<div class="col-sm-12">
            			<div class="panel panel-primary">
                            <div class="panel-heading">
                                缺损情况
                            </div>
                			<div class="panel-body">    
                				<div class="form-group form-inline">
                					<label>是否缺损:</label>
                					<select name="is_defect" id="is_defect" class="form-control m-b" onchange="showDiv();">
                						<option value="">请选择是否缺损</option>
                						<option value="1">是</option>
                						<option value="0">否</option>
                					</select>
                				</div>
			                    <div class="table-responsive" style="display: none" id="defectDiv">
				                    <table class="table table-striped table-bordered table-hover" id="tab">
				                    	<tr>
				                            <th style="width:5%;">组件名称</th>
				                            <th style="width:10%;">组件型号</th>
				                            <th style="width:10%;">组件数量</th>
				                            <th style="width:10%;">缺损类型</th>
				                            <th style="width:10%;">操作</th>
				                        </tr>
				                        <tr>
				                        	<td>
				                        		<input type="text" class="form-control">
				                        	</td>
				                        	<td>
				                        		<input type="text" class="form-control">
				                        	</td>
				                        	<td>
				                        		<input type="text" class="form-control">
				                        	</td>
				                        	<td>
				                        		<select class="form-control m-b">
				                        			<option value="">请选择缺损类型</option>
				                        			<option value="1">缺件</option>
				                        			<option value="2">损坏</option>
				                        		</select>
				                        	</td>
				                        	<td>
				                        		<input type="button" value="添加" onclick="addRow();">
				                        	</td>
				                        </tr>
			                    	</table>
			                    </div>
	                    	</div>
	                	</div>
	            	</div>
            	</div>
                <tr>
				<td><a class="btn btn-primary" style="width: 150px; height:34px;float:left;"  onclick="save();">保存</a></td>
				<td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('UnboxInfo');">关闭</a></td>
				</tr>
				</div>
            </div>
            
        </div>
 </div>
 </form>
</body>

</html>
