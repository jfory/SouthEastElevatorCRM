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
	
	//保存
	function save(){
		$("#type").focus();
		if($("#type").val()==""){
			$("#type").tips({
				side:3,
	            msg:"输入类型名称",
	            bg:'#AE81FF',
	            time:2
	        });
			return false;
		}
		$("#ordinaryType").submit();
	}
		
	//检测类型名称重复
	function checkOrdinaryName(){
		var type = $("#type").val();
		var old_type = $("#old_type").val();
		var operateType = $("#operateType").val();
		$.post("<%=basePath%>ordinaryType/checkOrdinaryName.do?type="+type+"&old_type="+old_type+"&operateType="+operateType,
				function(data){
					if(data.msg!='success'){
						$("#type").focus();
						$("#type").tips({
							side:3,
				            msg:"类型名称重复",
				            bg:'#AE81FF',
				            time:2
				        });
						return false;
					}
				}
		);
	}

	function CloseSUWin(id) {
		window.parent.$("#" + id).data("kendoWindow").close();
		/* 	window.parent.location.reload(); */
	}
	

	</script>
</head>

<body class="gray-bg">
<form action="ordinaryType/${msg}.do" name="ordinaryType" id="ordinaryType" method="post">
<input type="hidden" name="id" id="id" value="${pd.id}"/>
<input type="hidden" name="operateType" id="operateType" value="${operateType}">
    <div class="wrapper wrapper-content">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="form-group form-inline">
                          <label style="margin-left: 20px"><span><font color="red">*</font></span>类型名称:</label>
                          <input type="text" value="${pd.type}" name="type" id="type"  title="类型名称" placeholder="请输入类型名称"  class="form-control" onblur="checkOrdinaryName();" />
                          <input type="hidden" value="${pd.type}" name="old_type" id="old_type">
	                </div>
	                <div class="form-group form-inline">
                        <label style="margin-left: 20px">类型描述:</label>
                          <input type="text" value="${pd.descript}" name="descript" id="descript" title="类型描述" placeholder="请输入类型描述"  class="form-control"/>
                    </div>
                    <tr>
					<td><a class="btn btn-primary"style="width: 150px; height:34px;float:left;"  onclick="save();">保存</a></td>
					<td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('EditOrdinaryType');">关闭</a></td>
					</tr>
				</div>
            </div>
            
        </div>
 </div>
 </form>
</body>

</html>
