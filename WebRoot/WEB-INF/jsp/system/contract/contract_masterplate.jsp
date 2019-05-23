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
 <link href="static/js/sweetalert2/sweetalert2.css" rel="stylesheet">
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
        function save()
        {
            if ($("#masterplate").val()=="0" && $("#masterplate").val()=="0") 
            {
                $("#masterplate").focus();
            	$("#masterplate").tips({
                    side: 3,
                    msg: "请选择合同模版",
                    bg: '#AE81FF',
                    time: 3
                });
              
                return false;
            }
      	    $("#cellForm").submit();  
      	  window.parent.$("#EditItem").data("kendoWindow").close();
        }
        
	    function CloseSUWin(id) {
			window.parent.$("#" + id).data("kendoWindow").close();
			/* 	window.parent.location.reload(); */
		}
</script>
</head>
<body class="gray-bg">
	<form action="contract/${msg}.do" name="cellForm" id="cellForm"
		method="post">
		 <div id="EditMoban" class="animated fadeIn"></div>
		<div class="wrapper wrapper-content">
			<div class="row">
				<div class="col-sm-12">
					<div class="ibox float-e-margins">
						<div class="ibox-content1">
								<div class="panel panel-primary">
									<div class="panel-heading">合同模版信息</div>
									<div class="panel-body">
									<div class="row" style="margin-left: 10px">
									<div class="form-group form-inline">
											<span style="color: red;">*</span>
											<label style="width: 15%">请选择合同模版:</label>
												<select style="width: 30%" class="form-control"
													name="masterplate" readonly id="masterplate">
													<option value="0">请选择</option>
													<option value="1">定做合同</option>
													<option value="2">安装合同</option>
													<option value="3">销售合同</option>
												</select> 
										    </div>
										</div>
									</div>
								</div>
							<tr>
								<td><a class="btn btn-primary"
									style="width: 150px; height: 34px; float: left;"
									onclick="save1('${pd.con_id}');">确定</a></td>
								<td>
							<a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('EditItem');">关闭</a>
						        </td>
							</tr>
						</div>
				</div>
			</div>
	</form>
	  <script type="text/javascript">
	   //显示选择合同模版页面
      function save1(con_id){
		   var id =$("#masterplate").val();
		 $("#EditMoban").kendoWindow({
			 width: "760px",
			 height: "800px",
			 title: "选择合同模版",
			 actions: ["Close"],
			 content:"<%=basePath%>contract/masterplate.do?id="+id+"&con_id="+con_id,
			 modal : true,
			 visible : false,
			 resizable : true
		 }).data("kendoWindow").center().open();
	 } 
	  </script>
</body>
</html>
