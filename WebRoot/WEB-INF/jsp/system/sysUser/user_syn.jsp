<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>

<head>

    <base href="<%=basePath%>">


    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link type="text/css" rel="stylesheet" href="plugins/zTree/3.5.24/css/zTreeStyle/zTreeStyle.css"/>
    <!-- Sweet Alert -->
    <link href="static/js/sweetalert2/sweetalert2.css" rel="stylesheet">

    <title>${pd.SYSNAME}</title>
    <!-- jsp文件头和头部 -->
    <%@ include file="../../system/admin/top.jsp" %>

    <!-- Sweet alert -->
    <script src="static/js/sweetalert2/sweetalert2.js"></script>
	    
    <script type="text/javascript">
	    $(document).ready(function(){
			//loading end
			parent.layer.closeAll('loading');
		    refreshConn();
	    });

	    function refreshConn(){
	    	var index = layer.load(1);
	    	$.post("<%=basePath%>synUser/synInfo.do",
	    			function(data){
			    		if(data.msg=="success"){
			    			var str = data.msgPd.userAddIds;
			    			if(str.length>100){
			    				str = str.substr(1,10)+"....";
			    			}
		    				$("#add_count").html(data.msgPd.add_count);
		    				$("#edit_count").html(data.msgPd.edit_count);
		    				$("#del_count").html(data.msgPd.del_count);
		    				$("#userAddIds").html(data.msgPd.userAddIds);
		    				$("#userAddIds_str").html(str);
		    				$("#userEditIds").html(data.msgPd.userEditIds);
		    				$("#userDelIds").html(data.msgPd.userDelIds);
		    				$("#userDelCodes").html(data.msgPd.userDelCodes);
			    			layer.close(index);
						}else if(data.msg=="error"){
							layer.close(index);
							if(confirm("连接失败,是否重连?")){
								refreshConn();
							}
						}
	    			}
	    	);
	    }
	    
	    function checkButtonStatus(){
	    	$.post("<%=basePath%>synUser/checkButtonStatus.do",
	    			function(data){
	    				if(data.buttonStatus){
	    					document.getElementById("openSyn").style.display='none';
	    					document.getElementById("closeSyn").style.display='block';
	    				}else if(!data.buttonStatus){
	    					document.getElementById("openSyn").style.display='block';
	    					document.getElementById("closeSyn").style.display='none';
	    				}
	    			}
	    	);
	    }

	    function synAuto(str){
	    	$.post("<%=basePath%>synUser/synAuto.do?flag="+str,
	    			function(data){
	    				if(data.msg=="success_open"){
							swal({
								title: "开启成功！",
								text: "HR数据将会自动同步到本地数据库",
								type: "success",
								showConfirmButton: true,
								timer: 3000
							});
	    					document.getElementById("closeSyn").style.display='block';
	    					document.getElementById("openSyn").style.display='none';
	    				}else if(data.msg=="success_close"){
							swal({
								title: "关闭成功！",
								text: "HR数据将不会自动同步到本地数据库,需要手动进行同步操作",
								type: "warning",
								showConfirmButton: true,
								timer: 3000
							});
	    					document.getElementById("openSyn").style.display='block';
	    					document.getElementById("closeSyn").style.display='none';
	    				}
	    			}
	    	);
	    }

	    function synToLocal(){
	    	var index = layer.load(1);
	    	$.post("<%=basePath%>synUser/synToLocal.do",
	    			function(data){
	    				if(data.msg=="success"){
							layer.close(index);
							swal({
								title: "同步完成！",
								text: "HR数据已经成功同步到系统用户表",
								type: "success",
								showConfirmButton: true,
								timer: 3000
							}).then(function () {
								window.location.reload();
							});
	    				}
	    			}
	    	);
	    }
	    
	    function synUser(str){
	    	var index = layer.load(1);
	    	var userAddIdStr;
	    	var userEditIdStr;
	    	var userDelIdStr;
	    	var userDelCodeStr;
	    	var isToLocal;
	    	if(str=='all'){
	    		userAddIdStr = $("#userAddIds").html();
	    		userEditIdStr = $("#userEditIds").html();
	    		userDelIdStr = $("#userDelIds").html();
	    		userDelCodeStr = $("#userDelCodes").html();
	    	}else if(str=='add'){
	    		userAddIdStr = $("#userAddIds").html();
	    		userEditIdStr = "";
	    		userDelIdStr = "";
	    		userDelCodeStr = "";
	    	}else if(str=='edit'){
	    		userAddIdStr = "";
	    		userEditIdStr = $("#userEditIds").html();
	    		userDelIdStr = "";
	    		userDelCodeStr = "";
	    	}else if(str=='del'){
	    		userAddIdStr = "";
	    		userEditIdStr = "";
	    		userDelIdStr = $("#userDelIds").html();
	    		userDelCodeStr = $("#userDelCodes").html();
	    	}
	    	$.post("<%=basePath%>synUser/synUserData.do",
	    			{
	    				userAddIds:userAddIdStr,
	    				userEditIds:userEditIdStr,
	    				userDelIds:userDelIdStr,
	    				userDelCodes:userDelCodeStr
	    			},
	    			function(data){
	    				if(data.msg=='success'){
			    			layer.close(index);
							swal({
								title: "同步完成！",
								text: "HR数据已经保存到本地,可点击\"同步至本地\"按钮同步到系统用户表",
								type: "success",
								showConfirmButton: true,
								timer: 3000
							}).then(function () {
								window.location.reload();
							});
	    				}
	    			}
	    		);
	    }
	    function refreshCurrentTab(){
	    	window.location.reload();
	    }
    </script>
</head>
<body class="gray-bg" onload="checkButtonStatus();">
			<div class="col-sm-12">
				
			</div>
			
	<div class="row">
	            <div class="col-sm-12">
	                <div class="ibox float-e-margins">

						<form role="form" class="form-inline" action="synUser/listSynLog.do" method="post" name="synUserForm" id="synUserForm">
	                    <div class="ibox-content">
	                    <div id="top" name="top">
	                    <input type="button" value="点击开启" onclick="synAuto('open');" id="openSyn" name="openSyn" class="btn btn-sm btn-primary btn-sm"/>
						<input type="button" value="点击关闭" onclick="synAuto('close');" id="closeSyn" name="closeSyn" class="btn btn-sm btn-danger btn-sm"/>
						<input type="button" value="一键同步" onclick="synUser('all');" class="btn btn-success"/>
						<input type="button" value="同步至本地" onclick="synToLocal();" class="btn btn-success"/>
						 <button class="btn  btn-success" title="刷新" type="button" style="float:right" onclick="refreshCurrentTab();">刷新</button><br>
	                    </div>
	                        <div class="table-responsive">
		                        <table class="table table-striped table-bordered table-hover">
		                        	<tr>
	                                    <th style="width:8%;">数据总数</th>
	                                    <th style="width:8%;">序号/编号</th>
	                                    <th style="width:8%;">同步类型</th>
	                                    <th style="width:25%;">操作</th>
		                        	</tr>
		                        	<tr>
		                        		<td><span id="add_count"></span></td>
		                        		<td><span id="userAddIds" style="display:none"></span><span id="userAddIds_str"></span></td>
		                        		<td>新增数据</td>
		                        		<td>
		                        			<input type="button" value="同步新增数据" onclick="synUser('add');" class="btn btn-sm btn-primary"/>
		                        		</td>
		                        	</tr>
		                        	<tr>
		                        		<td><span id="edit_count"></span></td>
		                        		<td><span id="userEditIds"></span></td>
		                        		<td>修改数据</td>
		                        		<td>
		                        			<input type="button" value="同步修改数据" onclick="synUser('edit');" class="btn btn-sm btn-warning btn-sm"/>
		                        		</td>
		                        	</tr>
		                        	<tr>
		                        		<td><span id="del_count"></span></td>
		                        		<td><span style="display: none;"  id="userDelCodes"></span><span id="userDelIds"></span></td>
		                        		<td>删除数据</td>
		                        		<td>
		                        			<input type="button" value="同步删除数据" onclick="synUser('del');" class="btn btn-sm btn-danger btn-sm"/>
		                        		</td>
		                        	</tr>
		                        </table>
	                            <table class="table table-striped table-bordered table-hover">
	                                <thead>
	                                    <tr>
	                                        <th style="width:8%;">日志编号</th>
	                                        <th style="width:8%;">员工编号</th>
	                                        <th style="width:8%;">员工姓名</th>
	                                        <th style="width:8%;">同步类型</th>
	                                        <th style="width:8%;">同步状态</th>
	                                        <th style="width:12%;">生成日期</th>
	                                        <th style="width:25%;">同步信息</th>
	                                    </tr>
	                                </thead>
	                                <tbody>
	                                <!-- 开始循环 -->	
									<c:choose>
										<c:when test="${not empty synlogPdList}">
											<c:if test="${QX.cha == 1 }">
												<c:forEach items="${synlogPdList}" var="var" >
													<tr>
														<td>${var.ID}</td>
														<td>${var.SynCode }</td>
														<td>${var.Name }</td>
														<td>
																${var.SynType=='add'?'新增':'' }
																${var.SynType=='edit'?'修改':'' }
																${var.SynType=='del'?'删除':'' }
														</td>
														<td>
																${var.SynStatus=='toSyn'?'待同步':'' }
																${var.SynStatus=='toLocal'?'已同步':'' }
														</td>
														<td>${var.SynDate}</td>
														<td>${var.SynMsg }</td>
													</tr>
												</c:forEach>
											</c:if>
											<c:if test="${QX.cha == 0 }">
												<tr>
													<td colspan="100" class="center">您无权查看</td>
												</tr>
											</c:if>
										</c:when>
										<c:otherwise>
											<tr class="main_info">
												<td colspan="100" class="center" >没有相关数据</td>
											</tr>
										</c:otherwise>
									</c:choose>
                                </tbody>
	                            </table>
								<div class="col-lg-12" style="padding-left:0px;padding-right:0px">
										${page.pageStr}
								</div>
								</div>
						</div>
						</form>
		</div>
	</div>
 </div>
</body>

</html>
