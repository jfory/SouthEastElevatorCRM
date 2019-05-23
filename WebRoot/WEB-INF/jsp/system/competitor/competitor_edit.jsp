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
        	 if($("#comp_name").val()!= $("#CompName").val())
      	    {
         	  var compname = $("#comp_name").val();
               var url = "<%=basePath%>competitor/CompName.do?comp_name="+ compname + "&tm="
             		  + new Date().getTime();
 			$.get(url, function(data) {
 				if (data.msg == "error") {
 					$("#comp_name").tips({
 						side : 3,
 						msg : '竞争公司名称已存在',
 						bg : '#AE81FF',
 						time : 3
 					});
 					setTimeout("$('#comp_name').val('')", 2000);
 				}else{save();}
 			});
 		  }else{save();}
        }
        //保存
        function save() {
            if ($("#comp_name").val() == "" && $("#comp_name").val() == "") {
                $("#comp_name").tips({
                    side: 3,
                    msg: "请输入竞争公司名称",
                    bg: '#AE81FF',
                    time: 2
                });
                $("#comp_name").focus();
                return false;
            }
            $("#shopForm").submit();
        }
        
        //新增数据时  判断竞争对手名称是否存在
        function CompName() {
            var compname = $("#comp_name").val();
            var url = "<%=basePath%>competitor/CompName.do?comp_name="+ compname + "&tm="
            		+ new Date().getTime();
            $.get(url, function (data) {
                if (data.msg == "error") {
                    $("#comp_name").tips({
                        side: 3,
                        msg: '竞争公司名称已存在',
                        bg: '#AE81FF',
                        time: 3
                    });
                    setTimeout("$('#comp_name').val('')", 2000);
                }
            });
        }
     
        //修改数据时判断修改的名字数据库有没有 （保证名字唯一）
        function UpName() {
        	 if($("#comp_name").val()!= $("#CompName").val())
     	    {
        	  var compname = $("#comp_name").val();
              var url = "<%=basePath%>competitor/CompName.do?comp_name="
					+ compname + "&tm=" + new Date().getTime();
			$.get(url, function(data) {
				if (data.msg == "error") {
					$("#comp_name").tips({
						side : 3,
						msg : '竞争公司名称已存在',
						bg : '#AE81FF',
						time : 3
					});
					setTimeout("$('#comp_name').val('')", 2000);
				}
			});
		}

	}

	function CloseSUWin(id) {
		window.parent.$("#" + id).data("kendoWindow").close();
	}
</script>
</head>

<body class="gray-bg">
	<form action="competitor/${msg}.do" name="shopForm" id="shopForm"
		method="post">
		<input type="hidden" name="CompName" id="CompName"
			value="${pd.comp_name}" /> <input type="hidden" name="CompAddress"
			id="CompAddress" value="${pd.comp_address}" />
		<div class="wrapper wrapper-content">
			<div class="row">
				<div class="col-sm-12">
					<div class="ibox float-e-margins">
						<div class="ibox-content1">
							<div class="panel panel-primary">
								<div class="panel-heading">竞争对手基本信息</div>
								<div class="panel-body">
									<div class="row" style="margin-left: -2px">
									
								<c:if test="${msg== 'saveS' }">
									<div class="form-group form-inline">
                                    	<span style="color: red;">*</span>
									    <label style="width: 15%">竞争公司名称:</label>
										<input style="width:  30%" type="text" name="comp_name"
											id="comp_name" value="${pd.comp_name}" onblur="CompName()"
											placeholder="这里输入竞争公司名称" title="竞争公司名称" class="form-control">
								        <label style="width: 15%">竞争公司地址:</label>
										<input style="width:  30%" type="text" name="comp_address"
											id="comp_address" value="${pd.comp_address}"
											placeholder="这里输入竞争公司地址" onblur="CompAddress()"
											title="竞争公司地址" class="form-control">
								</div>
								<div class="form-group form-inline">
	                              <span type="hidden">&nbsp&nbsp</span>
									<label style="width: 15%">竞争公司电话:</label> <input
										style="width:  30%" type="text" type="text" name="comp_phone"
										id="comp_phone" value="${pd.comp_phone}"
										placeholder="这里输入竞争公司电话" title="竞争公司电话" class="form-control">
									<label style="width: 15%">竞争公司邮箱:</label> <input
										style="width: 30%" type="text" name="comp_email"
										id="comp_email" value="${pd.comp_email}"
										placeholder="这里输入竞争公司邮箱" title="竞争公司邮箱" class="form-control">
								</div>
                             </div>
						</c:if>
						<c:if test="${msg== 'editS' }">	
						
						<div class="form-group form-inline">
									<label style="width: 15%">竞争公司编号:</label>
										<input style="width:  30%" type="text" name="comp_id"
										  readonly="readonly" id="comp_id" value="${pd.comp_id}" placeholder="这里输入竞争公司编号"
											title="竞争公司编号" class="form-control" />
                                    	 <span type="hidden">&nbsp&nbsp&nbsp&nbsp&nbsp</span>
                                    	<span style="color: red;">*</span>
									<label style="width: 15%">竞争公司名称:</label>
										<input style="width:  30%" type="text" name="comp_name"
											id="comp_name" value="${pd.comp_name}"
											placeholder="这里输入竞争公司名称" title="竞争公司名称" onblur="UpName()"
											class="form-control">
								</div>
								<div class="form-group form-inline">
									<label style="width: 15%">竞争公司地址:</label>
										<input style="width:  30%" type="text" name="comp_address"
											id="comp_address" value="${pd.comp_address}"
											placeholder="这里输入竞争公司地址" onblur="UpAddress()" title="竞争公司地址" class="form-control">
	                              <span type="hidden">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</span>
									<label style="width: 15%">竞争公司电话:</label> <input
										style="width:  30%" type="text" type="text" name="comp_phone"
										id="comp_phone" value="${pd.comp_phone}"
										placeholder="这里输入竞争公司电话" title="竞争公司电话" class="form-control">
								</div>
								<div class="form-group form-inline">
									<label style="width: 15%">竞争公司邮箱:</label> <input
										style="width: 30%" type="text" name="comp_email"
										id="comp_email" value="${pd.comp_email}"
										placeholder="这里输入竞争公司邮箱" title="竞争公司邮箱" class="form-control">
								</div>
                             </div>
						</c:if>
									</div>
								</div>
								<div style="height: 20px;"></div>
								<tr>
									<td><a class="btn btn-primary"
										style="width: 150px; height: 34px; float: left;"
										onclick="save1();">保存</a></td>
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
