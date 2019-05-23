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
<script type="text/javascript">
        $(document).ready(function () {
            /* 图片 */
            $('.fancybox').fancybox({
                openEffect: 'none',
                closeEffect: 'none'
            });
        });
        
        function save1()
        {
        	 if($("#type_name").val()!= $("#CompName").val())
      	    {
         	  var compname = $("#type_name").val();
               var url = "<%=basePath%>housesType/housestypeName.do?type_name="+ compname + "&tm="
             		  + new Date().getTime();
 			$.get(url, function(data) {
 				if (data.msg == "error") {
 					$("#type_name").tips({
 						side : 3,
 						msg : '楼盘类型名称已存在',
 						bg : '#AE81FF',
 						time : 3
 					});
 					setTimeout("$('#type_name').val('')", 2000);
 				}else{save();}
 			});
 		  }else{save();}
        }
        //保存
        function save() {
            if ($("#id").val() == "" && $("#id").val() == "") {
                $("#id").tips({
                    side: 3,
                    msg: "请输入楼盘类型编号",
                    bg: '#AE81FF',
                    time: 2
                });
                $("#id").focus();
                return false;
            }

            if ($("#type_name").val() == "" && $("#type_name").val() == "") {
                $("#type_name").tips({
                    side: 3,
                    msg: "请输入楼盘类型名称",
                    bg: '#AE81FF',
                    time: 2
                });
                $("#type_name").focus();
                return false;
            }
            
            $("#shopForm").submit();
        }
     
	function CloseSUWin(id) {
		window.parent.$("#" + id).data("kendoWindow").close();
	}
</script>
</head>

<body class="gray-bg">
	<form action="housesType/${msg}.do" name="shopForm" id="shopForm"
		method="post">
		<input type="hidden" name="CompName" id="CompName"value="${pd.type_name}" />
		<input type="hidden" name="CompAddress"id="CompAddress" value="${pd.comp_address}" />
		<div class="wrapper wrapper-content">
			<div class="row">
				<div class="col-sm-12">
					<div class="ibox float-e-margins">
						<div class="ibox-content1">
                                <div class="panel panel-primary">
                                    <div class="panel-heading">
                                                                                                楼盘类型基本信息
                                    </div>
                                    <div class="panel-body">
							<div class="row" style="margin-left:10px">
								<div class="form-group form-inline">
								   <span style="color: red;">*</span>
									<label style="width: 15%">楼盘类型编号:</label>
										<input style="width: 30%" type="text" name="id" id="id" value="${pd.id}" 
											readonly="readonly" placeholder="这里输入楼盘类型编号" title="楼盘类型编号" class="form-control" />
									 <span type="hidden">&nbsp&nbsp&nbsp&nbsp&nbsp</span>
									<span style="color: red;">*</span>
									<label style="width: 15%">楼盘类型名称:</label>
									<c:if test="${msg== 'saveS' }">
										<input style="width: 30%" type="text" name="type_name"
											id="type_name" value="${pd.type_name}" onblur="CompName()"
											placeholder="这里输入楼盘类型名称" title="楼盘类型名称" class="form-control">
									</c:if>
									<c:if test="${msg== 'editS' }">
										<input style="width: 30%" type="text" name="type_name"
											id="type_name" value="${pd.type_name}"
											placeholder="这里输入楼盘类型名称" title="楼盘类型名称" onblur="UpName()"
											class="form-control">
									</c:if>
								</div>

                                <div class="form-group form-inline">
                               <span type="hidden">&nbsp&nbsp</span>
									<label style="width: 15%">楼盘类型描述:</label>
										<input style="width: 80%" type="text" name="type_describe"
											id="type_describe" value="${pd.type_describe}" 
											placeholder="这里输入楼盘类型描述" title="楼盘类型描述" class="form-control" />
								</div>
								
							</div>
							
							 </div>
						</div>
					</div>
					
                                    </div>
                                </div>
							
							<div style="height: 20px;"></div>
							<tr>
								<td>
								
							<a class="btn btn-primary"
								style="width: 150px; height: 34px; float: left;"
								onclick="save1();">保存</a>
								
									</td>
								<td><a class="btn btn-danger"
									style="width: 150px; height: 34px; float: right;"
									onclick="javascript:CloseSUWin('EditShops');">关闭</a></td>
							</tr>
							  
                       
				</div>
			
	</form>
</body>

</html>
