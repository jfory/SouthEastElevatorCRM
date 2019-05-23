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
        	 if($("#well_name").val()!= $("#WellName").val())
      	    {
         	  var compname = $("#well_name").val();
               var url = "<%=basePath%>well/WellName.do?well_name="+ compname + "&tm="
             		  + new Date().getTime();
 			$.get(url, function(data) {
 				if (data.msg == "error") {
 					$("#well_name").tips({
 						side : 3,
 						msg : '井道类型名称已存在',
 						bg : '#AE81FF',
 						time : 3
 					});
 					setTimeout("$('#well_name').val('')", 2000);
 				}
 				else{save();}
 			});
 		  }
         else{save();}
        }
        //保存
        function save() {
            if ($("#well_id").val() == "" && $("#well_id").val() == "") {
                $("#well_id").tips({
                    side: 3,
                    msg: "请输入井道类型编号",
                    bg: '#AE81FF',
                    time: 2
                });
                $("#well_id").focus();
                return false;
            }

            if ($("#well_name").val() == "" && $("#well_name").val() == "") {
                $("#well_name").tips({
                    side: 3,
                    msg: "请输入井道类型名称",
                    bg: '#AE81FF',
                    time: 2
                });
                $("#well_name").focus();
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
	<form action="well/${msg}.do" name="shopForm" id="shopForm"
		method="post">
		<input type="hidden" name="WellName" id="WellName"value="${pd.well_name}" />
		<div class="wrapper wrapper-content">
			<div class="row">
				<div class="col-sm-12">
					<div class="ibox float-e-margins">
						<div class="ibox-content1">
                                <div class="panel panel-primary">
                                    <div class="panel-heading"> 井道类型基本信息</div>
                                    <div class="panel-body">
							<div class="row" style="margin-left:10px">
								<div class="form-group form-inline">
								<span style="color: red;">*</span>
									<label style="width: 15%">井道类型编号:</label>
										<input style="width: 30%" type="text" name="well_id" id="well_id" value="${pd.well_id}" 
										    readonly="readonly"	placeholder="这里输入井道类型编号" title="井道类型编号" class="form-control" />
									<span type="hidden">&nbsp&nbsp&nbsp&nbsp&nbsp</span>
									<span style="color: red;">*</span>
									<label style="width: 15%">井道类型名称:</label>
									<c:if test="${msg== 'saveS' }">
										<input style="width: 30%" type="text" name="well_name"
											id="well_name" value="${pd.well_name}" onblur="CompName()"
											placeholder="这里输入井道类型名称" title="井道类型名称" class="form-control">
									</c:if>
									<c:if test="${msg== 'editS' }">
										<input style="width: 30%" type="text" name="well_name"
											id="well_name" value="${pd.well_name}"
											placeholder="这里输入井道类型名称" title="井道类型名称" onblur="UpName()"
											class="form-control">
									</c:if>
								</div>
								
								<div class="form-group form-inline">
								  <span type="hidden">&nbsp&nbsp</span>
									<label style="width: 15%">井道类型描述:</label>
										<input style="width: 80%" type="text" name="well_describe"
											id="well_describe" value="${pd.well_describe}"
											placeholder="这里输入井道类型描述" title="井道类型描述" class="form-control" />
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
							
							
					</div>

				</div>
			</div>
	</form>
</body>

</html>
