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
        	 if($("#house_name").val()!= $("#CompName").val())
      	    {
         	  var compname = $("#house_name").val();
               var url = "<%=basePath%>doormodel/doormodelName.do?house_name="+ compname + "&tm="
             		  + new Date().getTime();
 			$.get(url, function(data) {
 				if (data.msg == "error") {
 					$("#house_name").tips({
 						side : 3,
 						msg : '户型类型已存在',
 						bg : '#AE81FF',
 						time : 3
 					});
 					setTimeout("$('#house_name').val('')", 2000);
 				}else{save();}
 			});
 		  }else{save();}
        }
        //保存
        function save() {
            if ($("#house_id").val() == "" && $("#house_id").val() == "") {
                $("#house_id").tips({
                    side: 3,
                    msg: "请输入户型类型编号",
                    bg: '#AE81FF',
                    time: 2
                });
                $("#house_id").focus();
                return false;
            }

            if ($("#house_name").val() == "" && $("#house_name").val() == "") {
                $("#house_name").tips({
                    side: 3,
                    msg: "请输入户型类型名称",
                    bg: '#AE81FF',
                    time: 2
                });
                $("#house_name").focus();
                return false;
            }
            
            if(isNaN($("#house_id").val()))
        	{
        		  $("#house_id").focus();
              	$("#house_id").tips({
                      side: 3,
                      msg: "编号必须为数字形式",
                      bg: '#AE81FF',
                      time: 3
                  });
              	 return false;
        	}
            
            $("#shopForm").submit();
        }
        //新增数据时 判断编码是否存在
        function hasShop() {
            var NUMBER = $("#house_id").val();
            var url = "<%=basePath%>doormodel/hasShop.do?house_id=" + NUMBER + "&tm="
            		+ new Date().getTime();
            $.get(url, function (data) {
                if (data.msg == "error") {
                    $("#house_id").tips({
                        side: 3,
                        msg: '户型类型编号已存在',
                        bg: '#AE81FF',
                        time: 3
                    });

                    setTimeout("$('#house_id').val('')", 2000);

                }
            });
        }
        
        
        //新增数据时  判断竞名称是否存在
        function CompName() {
            var compname = $("#house_name").val();
            var url = "<%=basePath%>doormodel/doormodelName.do?house_name="+ compname + "&tm="
            		+ new Date().getTime();
            $.get(url, function (data) {
                if (data.msg == "error") {
                    $("#house_name").tips({
                        side: 3,
                        msg: '户型类型已存在',
                        bg: '#AE81FF',
                        time: 3
                    });
                    setTimeout("$('#house_name').val('')", 2000);
                }
            });
        }
        
	function CloseSUWin(id) {
		window.parent.$("#" + id).data("kendoWindow").close();
	}
</script>
</head>

<body class="gray-bg">
	<form action="doormodel/${msg}.do" name="shopForm" id="shopForm"
		method="post">
		<input type="hidden" name="CompName" id="CompName"value="${pd.house_name}" />
		<div class="wrapper wrapper-content">
			<div class="row">
				<div class="col-sm-12">
					<div class="ibox float-e-margins">
						<div class="ibox-content1">
                                <div class="panel panel-primary">
                                    <div class="panel-heading">
                                                                                                户型类型基本信息
                                    </div>
                                    <div class="panel-body">
							<div class="row" style="margin-left:10px">
								<div class="form-group form-inline">
								<span style="color: red;">*</span>
									<label style="width: 15%">户型类型编号:</label>
									<c:if test="${msg== 'saveS' }">
										<input style="width: 30%" type="text" name="house_id"
											id="house_id" value="${pd.house_id}" onblur="hasShop()"
											placeholder="这里输入户型类型编号" title="户型类型编号" class="form-control" />
									</c:if>
									<c:if test="${msg== 'editS' }">
										<input style="width: 30%" type="text" name="house_id"
										   readonly="readonly"	id="house_id" value="${pd.house_id}" placeholder="这里输入户型类型编号"
											title="户型类型编号" class="form-control" />
									</c:if>
									<span type="hidden">&nbsp&nbsp&nbsp&nbsp&nbsp</span>
									<span style="color: red;">*</span>
									<label style="width: 15%">户型类型名称:</label>
									<c:if test="${msg== 'saveS' }">
										<input style="width: 30%" type="text" name=house_name
											id="house_name" value="${pd.house_name}" onblur="CompName()"
											placeholder="这里输入户型类型名称" title="户型类型名称" class="form-control">
									</c:if>
									<c:if test="${msg== 'editS' }">
										<input style="width: 30%" type="text" name="house_name"
											id="house_name" value="${pd.house_name}"
											placeholder="这里输入户型类型名称" title="户型类型名称" onblur="UpName()"
											class="form-control">
									</c:if>
								</div>
								<div class="form-group form-inline">
								<span type="hidden">&nbsp&nbsp</span>
									<label style="width: 15%">户型类型描述:</label>
										<input style="width: 80%" type="text" name="house_describe"
											id="house_describe" value="${pd.house_describe}" 
											placeholder="这里输入户型类型描述" title="户型类型描述" class="form-control" />
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
