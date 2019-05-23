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
		var str = '';
		$('input:checkbox[name=ids]:checked').each(function(){
			str += $(this).val()+",";
		});
		str = str.substring(0,str.length-1);
		$("#unbox_id").val(str);
		$("#supplementForm").submit();
	}
		
	function CloseSUWin(id) {
		window.parent.$("#" + id).data("kendoWindow").close();
		/* 	window.parent.location.reload(); */
	}
	

	</script>
</head>

<body class="gray-bg">
<form action="install/${msg}.do" name="supplementForm" id="supplementForm" method="post">
<input type="hidden" name="id" id="id" value="${pd.id}"/>
<input type="hidden" name="operateType" id="operateType" value="${operateType}"/>
<input type="hidden" name="unbox_id" id="unbox_id" value="${pd.unbox_id}"/>
    <div class="wrapper wrapper-content">
        <div class="row">
            <div class="col-sm-12">
            	<div class="row">
        			<div class="col-sm-12">
            			<div class="panel panel-primary">
                            <div class="panel-heading">
                                开箱报告
                            </div>
                			<div class="panel-body">    
			                    <div class="table-responsive">
				                    <table class="table table-striped table-bordered table-hover" id="tab">
				                    	<tr>
				                            <th style="width:5%;"><input type="checkbox" name="zcheckbox" id="zcheckbox" class="i-checks"></th>
				                            <th style="width:5%;">编号</th>
				                            <th style="width:10%;">箱号</th>
				                            <th style="width:10%;">操作</th>
				                        </tr>
				                        <c:forEach items="${unboxList}" var="var">
				                        	<tr>
				                        		<td><input type="checkbox" class="i-checks" name='ids' id='${var.id }' value='${var.id }' ></td>
				                        		<td>${var.id}</td>
				                        		<td>${var.encasement_id}</td>
				                        		<td>
				                        			<button class="btn btn-sm btn-info btn-sm" title="查看" type="button" onclick="sel('${var.id}');">查看</button>
				                        		</td>
				                        	</tr>
				                        </c:forEach>
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
                                备注信息
                            </div>
                			<div class="panel-body">        
                                <div class="form-group">   
			                        <label style="margin-left: 20px">备注:</label>
			                    	<textarea rows="3" cols="20" class="form-control" name="remark" id="remark"></textarea>
                				</div>
	                    	</div>
	                	</div>
	            	</div>
            	</div>
                <tr>
				<td><a class="btn btn-primary" style="width: 150px; height:34px;float:left;"  onclick="save();">保存</a></td>
				<td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('EditSupplement');">关闭</a></td>
				</tr>
				</div>
            </div>
            
        </div>
 </div>
 </form>
</body>

</html>
