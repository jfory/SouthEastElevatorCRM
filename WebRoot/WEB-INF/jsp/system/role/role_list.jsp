<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
	<base href="<%=basePath%>">
	<!-- jsp文件头和头部 -->
	<%@ include file="../../system/admin/top.jsp"%> 
 <!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link href="static/css/switchery/switchery.css" rel="stylesheet">
    <!-- Sweet Alert -->
    <link href="static/js/sweetalert/sweetalert.css" rel="stylesheet">
	<title>${pd.SYSNAME}</title>
</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div id="AddRole" class="animated fadeIn"></div>
        <div id="EditRole" class="animated fadeIn"></div>
        <div id="EditRights" class="animated fadeIn"></div>
        <div id="EditRoleButton" class="animated fadeIn"></div>
        <div id="EditRoleUser" class="animated fadeIn"></div>
	        <div class="row">
	        	<form role="form" class="form-inline" action="" method="post" name="RoleForm" id="RoleForm">
	        	<input type="hidden" id="ROLE_ID" name="ROLE_ID" value="${pd.ROLE_ID}">
	        	<c:if test="${QX.add == 1 }">
	        	<div class="from-inline" style="padding:0px 15px 0px 15px">
	        	<tr>
				<td ><a href="javascript:addRole();" class="btn  btn-success">新增组</a></td>
				</tr>
	        	</div>
				</c:if>
	        	 <div class="panel blank-panel">
                    <div class="panel-heading">
                        <div class="panel-options">
                        	<ul class="nav nav-tabs">
							<c:choose>
								<c:when test="${not empty roleList}">
								<c:forEach items="${roleList}" var="role" varStatus="vs">
		                                <li 
		                                <c:choose>
										<c:when test="${pd.ROLE_ID == role.ROLE_ID}">
											class="active"
										</c:when>
										<c:otherwise>
											class=""
										</c:otherwise>
										</c:choose>
		                                >
		                                <a data-toggle="tab" href="role.do?ROLE_ID=${role.ROLE_ID}#tab-${role.ROLE_ID}" onclick="tabChange('${role.ROLE_ID}')">
			                                <i class="fa fa-user"></i>
			                                ${role.ROLE_NAME }
		                                </a>
		                                </li>
								</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
									<td colspan="100">没有相关数据</td>
									</tr>
								</c:otherwise>
							</c:choose>
                        	 </ul>    
                        </div>
                    </div>
					
					<div class="panel-body">
                    	<div class="tab-content">
                    	<c:choose>
						<c:when test="${not empty roleList}">
							<c:forEach items="${roleList}" var="role" varStatus="vs">
		                         
			                            <div id="tab-${role.ROLE_ID}" 
										<c:choose>
										<c:when test="${pd.ROLE_ID == role.ROLE_ID}">
											class="tab-pane active"
										</c:when>
										<c:otherwise>
											class="tab-pane"
										</c:otherwise>
										</c:choose>
										>
							                <div class="ibox float-e-margins">
							                    <div class="ibox-content">
							                    <div id="top",name="top"></div>
							                        
							                        <c:if test="${QX.edit == 1 }">
							                            <div class="form-group ">
							                                <button type="button" onclick="editRole('${pd.ROLE_ID }');" class="btn  btn-info ">修改组名称</button>
							                            </div>
						                            </c:if>
						                            <c:choose>
														<c:when test="${pd.ROLE_ID == '99'}">
														</c:when>
														<c:otherwise>
														<c:if test="${QX.edit == 1 }">
														<div class="form-group">
							                                 <button type="button" class="btn  btn-warning " onclick="editRights('${pd.ROLE_ID }');" >设置组菜单权限</button>
							                            </div>
														</c:if>
														</c:otherwise>
													</c:choose>
													<c:choose> 
														<c:when test="${pd.ROLE_ID == '6' or pd.ROLE_ID == '4' or pd.ROLE_ID == '1' or pd.ROLE_ID == '7'}">
														</c:when>
														<c:otherwise>
														 <c:if test="${QX.del == 1 }">
														 <div class="form-group">
							                                 <button type="button" class="btn  btn-danger " onclick="delRole('${role.ROLE_ID }','z','${pd.ROLE_NAME }');" >删除组</button>
							                            </div>
														 </c:if>
														</c:otherwise>
													</c:choose>
							                            <button class="btn  btn-success" title="刷新" type="button" style="float:right" onclick="refreshCurrentTab();">刷新</button>
							                            <div class="row">
							                            </br>
							                             </div>
							                        <div class="table-responsive">
							                            <table class="table table-striped table-bordered table-hover">
							                                <thead>
							                                    <tr>
							                                        <th style="width:4%;">序号</th>
							                                        <th style="width:10%;">角色</th>
							                                        <c:if test="${QX.edit == 1 }">
							                                        <%--<th style="width:8%;">备用</th>--%>
							                                        <%--<th style="width:8%;">备用</th>--%>
							                                        <%--<th style="width:8%;">邮件</th>--%>
							                                        <%--<th style="width:8%;">短信</th>--%>
							                                        <%--<th style="width:8%;">站内信</th>--%>
							                                        <th style="width:7%;">增</th>
							                                        <th style="width:7%;">删</th>
							                                        <th style="width:7%;">改</th>
							                                        <th style="width:7%;">查</th>
							                                        </c:if>
							                                        <th style="width:20%;">操作</th>
							                                    </tr>
							                                </thead>
							                                <tbody>
							                                <!-- 开始循环 -->	
							                                		<c:choose>
																	<c:when test="${not empty roleList_z}">
																		<c:if test="${QX.cha == 1 }">
																		<c:forEach items="${roleList_z}" var="var" varStatus="vs">
																		
																	
																		<c:forEach items="${kefuqxlist}" var="varK" varStatus="vsK">
																			<c:if test="${var.QX_ID == varK.GL_ID }">
																				<c:set value="${varK.FX_QX }" var="fx_qx"></c:set>
																				<c:set value="${varK.FW_QX }" var="fw_qx"></c:set>
																				<c:set value="${varK.QX1 }" var="qx1"></c:set>
																				<c:set value="${varK.QX2 }" var="qx2"></c:set>
																			</c:if>
																		</c:forEach>
																		<c:forEach items="${gysqxlist}" var="varG" varStatus="vsG">
																			<c:if test="${var.QX_ID == varG.U_ID }">
																				<c:set value="${varG.C1 }" var="c1"></c:set>
																				<c:set value="${varG.C2 }" var="c2"></c:set>
																				<c:set value="${varG.Q1 }" var="q1"></c:set>
																				<c:set value="${varG.Q2 }" var="q2"></c:set>
																			</c:if>
																		</c:forEach>
																		
																		<tr>
																		<td class='center' style="width:30px;">${vs.index+1}</td>
																		<td id="ROLE_NAMETd${var.ROLE_ID }">${var.ROLE_NAME }</td>
																		<c:if test="${QX.edit == 1 }">
																		<%--<td><input type="checkbox" class="js-switch1 js-switch-change1" id="qx1${vs.index+1}_${var.QX_ID}_kfqx1" <c:if test="${qx1 == 1 }">checked="checked"</c:if> /></td>--%>
																		<%--<td><input type="checkbox" class="js-switch2 js-switch-change2" id="qx2${vs.index+1}_${var.QX_ID}_kfqx2" <c:if test="${qx2 == 1 }">checked="checked"</c:if> /></td>--%>
																		<%--<td><input type="checkbox" class="js-switch3 js-switch-change3" id="qx3${vs.index+1}_${var.QX_ID}_fxqx" <c:if test="${fx_qx == 1 }">checked="checked"</c:if> /></td>--%>
																		<%--<td><input type="checkbox" class="js-switch4 js-switch-change4" id="qx4${vs.index+1}_${var.QX_ID}_fwqx" <c:if test="${fw_qx == 1 }">checked="checked"</c:if> /></label></td>--%>
																		<%--<td><input title="每天可发条数" name="xinjian" id="xj${vs.index+1}" value="${c1 }" style="width:60px;height:100%;text-align:center; padding-top: 0px;padding-bottom: 0px;" onchange="c1(this.id,'c1',this.value,'${var.QX_ID}')" type="number"/></td>--%>

																		<td><a onclick="roleButton('${var.ROLE_ID }','add_qx');" class="btn btn-primary" title="分配新增权限"><i class="fa fa-plus"></i></a></td>
																		<td><a onclick="roleButton('${var.ROLE_ID }','del_qx');" class="btn btn-danger" title="分配删除权限"><i class="fa fa-trash"></i></a></td>
																		<td><a onclick="roleButton('${var.ROLE_ID }','edit_qx');" class="btn btn-warning" title="分配修改权限"><i class="fa fa-save"></i></a></td>
																		<td><a onclick="roleButton('${var.ROLE_ID }','cha_qx');" class="btn btn-success" title="分配查看权限"><i class="fa fa-search"></i></a></td>
																		</c:if>
																		<td style="width:155px;">
																		
																		<c:if test="${QX.edit != 1 && QX.del != 1 }">
																		<div style="width:100%;">
																		<span class="label"><i title="无权限">无权限</i></span>
																		</div>
																		</c:if>
																		
																		<c:if test="${QX.edit == 1 }">
																		<button class="btn  btn-success btn-sm" title="菜单权限" type="button" onclick="editRights('${var.ROLE_ID }');">菜单</button>
																		<button class="btn  btn-primary btn-sm" title="编辑" type="button" onclick="editRole('${var.ROLE_ID }');">编辑</button>
																		<button class="btn  btn-primary btn-sm" title="编辑" type="button" onclick="editRoleUser('${var.ROLE_ID }');">编辑角色成员</button>
																		</c:if>
																		<c:choose> 
																			<c:when test="${var.ROLE_ID == '2' or var.ROLE_ID == '1'}">
																			</c:when>
																			<c:otherwise>
																			 <c:if test="${QX.del == 1 }">
																			 <button class="btn  btn-danger btn-sm" title="删除" type="button" onclick="delRole('${var.ROLE_ID }','c','${var.ROLE_NAME }');">删除</button>
																			 </c:if>
																			</c:otherwise>
																		</c:choose>
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
																		<tr>
																		<td colspan="100" class="center" >没有相关数据</td>
																		</tr>
																	</c:otherwise>
																</c:choose>
															</tbody>
							                            </table>
														<div class="col-lg-12" style="padding-left:0px;padding-right:0px">
															<c:if test="${QX.add == 1 }">
																<button class="btn  btn-primary" title="新增" type="button" onclick="addRole2('${pd.ROLE_ID }');">新增角色</button>
															</c:if>
																${page.pageStr}
														</div>
							                        </div>
							                    </div>
							                </div>
							        
			                            </div>
			                        
							</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
								<td colspan="100">没有相关数据</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</div>
				 </div>
                    

                </div>
	           </div>
	    </form>
	    </div>
	    <!--返回顶部开始-->
        <div id="back-to-top">
            <a class="btn btn-warning btn-back-to-top" href="javascript: setWindowScrollTop (this,document.getElementById('top').offsetTop);">
                <i class="fa fa-chevron-up"></i>
            </a>
        </div>
        <!--返回顶部结束-->
	<!-- Switchery -->
    <script src="static/js/switchery/switchery.js"></script>
    <!-- Sweet alert -->
    <script src="static/js/sweetalert/sweetalert.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
			//loading end
			parent.layer.closeAll('loading');
        	/* 仿iOS7风格switch button*/
        	var elems1 = document.querySelectorAll('.js-switch1');
			for (var i = 0; i < elems1.length; i++) {
			  var switchery1 = new Switchery(elems1[i],{color: '#1AB394'});
			  
			}
			var checkboxs1 = document.querySelectorAll('.js-switch-change1');
			for (var i = 0; i < checkboxs1.length; i++) {
			  var checkbox1 = checkboxs1[i];
			  checkbox1.addEventListener('change', function() {
				  var checkboxid=this.id;
				  var arr = new Array();
				  arr= checkboxid.split("_");
				  if(arr.length>0){
					  var id= arr[0];
					  var qxid= arr[1];
					  var msg = arr[2];
					  var state = this.checked;
					  kf_qx1(id,qxid,msg,state);
				  }
				});
			  
			}
			var elems2 = document.querySelectorAll('.js-switch2');
			for (var i = 0; i < elems2.length; i++) {
			  var switchery2 = new Switchery(elems2[i],{color: '#ED5565'});
			  
			}
			var checkboxs2 = document.querySelectorAll('.js-switch-change2');
			for (var i = 0; i < checkboxs2.length; i++) {
			  var checkbox2 = checkboxs2[i];
			  checkbox2.addEventListener('change', function() {
				  var checkboxid=this.id;
				  var arr = new Array();
				  arr= checkboxid.split("_");
				  if(arr.length>0){
					  var id= arr[0];
					  var qxid= arr[1];
					  var msg = arr[2];
					  var state = this.checked;
					  kf_qx2(id,qxid,msg,state);
				  }
				});
			  
			}
			var elems3 = document.querySelectorAll('.js-switch3');
			for (var i = 0; i < elems3.length; i++) {
			  var switchery3 = new Switchery(elems3[i],{color: '#f8ac59'});
			  
			}
			var checkboxs3 = document.querySelectorAll('.js-switch-change3');
			for (var i = 0; i < checkboxs3.length; i++) {
			  var checkbox3 = checkboxs3[i];
			  checkbox3.addEventListener('change', function() {
				  var checkboxid=this.id;
				  var arr = new Array();
				  arr= checkboxid.split("_");
				  if(arr.length>0){
					  var id= arr[0];
					  var qxid= arr[1];
					  var msg = arr[2];
					  var state = this.checked;
					  kf_qx3(id,qxid,msg,state);
				  }
				});
			  
			}
			var elems4 = document.querySelectorAll('.js-switch4');
			for (var i = 0; i < elems4.length; i++) {
			  var switchery4 = new Switchery(elems4[i],{color: '#1c84c6'});
			  
			}
			var checkboxs4 = document.querySelectorAll('.js-switch-change4');
			for (var i = 0; i < checkboxs4.length; i++) {
			  var checkbox4 = checkboxs4[i];
			  checkbox4.addEventListener('change', function() {
				  var checkboxid=this.id;
				  var arr = new Array();
				  arr= checkboxid.split("_");
				  if(arr.length>0){
					  var id= arr[0];
					  var qxid= arr[1];
					  var msg = arr[2];
					  var state = this.checked;
					  kf_qx4(id,qxid,msg,state);
				  }
				});
			  
			}
        });
        
      	//刷新iframe
        function refreshCurrentTab() {
        	$("#RoleForm").submit();
        	/* window.location.reload(); */
        }
		//tab切换
		function tabChange(id){
			$("#ROLE_ID").val(id);
			$("#RoleForm").submit();
		}
		/* back to top */
		function setWindowScrollTop(win, topHeight){
		    if(win.document.documentElement){
		        win.document.documentElement.scrollTop = topHeight;
		    }
		    if(win.document.body){
		        win.document.body.scrollTop = topHeight;
		    }
		}
		//新增组
		function addRole(){
			$("#AddRole").kendoWindow({
		        width: "400px",
		        height: "250px",
		        title: "新增",
		        actions: ["Close"],
		        content: '<%=basePath%>role/toAdd.do?parent_id=0',
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").center().open();
		}
		
		//新增角色
		function addRole2(pid){
			$("#AddRole").kendoWindow({
		        width: "500px",
		        height: "500px",
		        title: "新增",
		        actions: ["Close"],
		        content: '<%=basePath%>role/toAdd.do?parent_id='+pid,
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").center().open();
		}
		
		//修改
		function editRole(ROLE_ID){
			$("#EditRole").kendoWindow({
		        width: "500px",
		        height: "500px",
		        title: "编辑",
		        actions: ["Close"],
		        content: '<%=basePath%>role/toEdit.do?ROLE_ID='+ROLE_ID,
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").center().open();
		}

		//修改角色成员
		function editRoleUser(ROLE_ID){
			$("#EditRoleUser").kendoWindow({
		        width: "500px",
		        height: "600px",
		        title: "编辑",
		        actions: ["Close"],
		        content: '<%=basePath%>role/toEditRoleUser.do?ROLE_ID='+ROLE_ID,
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").center().open();
		}

		//删除
		function delRole(ROLE_ID,msg,ROLE_NAME){
			swal({
                title: "您确定要删除["+ROLE_NAME+"]吗？",
                text: "删除后将无法恢复，请谨慎操作！",
                type: "warning",
                showCancelButton: true,
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "删除",
                cancelButtonText: "取消",
                closeOnConfirm: false,
                closeOnCancel: false
            },
            function (isConfirm) {
                if (isConfirm) {
                	var url = "<%=basePath%>role/delete.do?ROLE_ID="+ROLE_ID+"&guid="+new Date().getTime();
    				$.get(url,function(data){
    					if(data.result=='success'){
    						swal({   
    				        	title: "删除成功！",
    				        	text: "您已经成功删除了这条信息。",
    				        	type: "success",  
    				        	 }, 
    				        	function(){   
    							if(msg == 'c'){
    								$("#RoleForm").submit();
    							}else{
    								window.location.href="role.do";
    							}
    				        	 });
    					}else if("false1" == data.result){
    						swal({
    			                title: "删除失败!",
    			                text: "删除失败，请先删除此角色组的所有下级!",
    			                type: "error",
    			                showCancelButton: false,
    			                confirmButtonColor: "#DD6B55",
    			                confirmButtonText: "OK",
    			                closeOnConfirm: true,
    			                timer:3000
    			            });
    					}else if("false2" == data.result){
    						swal({
    			                title: "删除失败!",
    			                text: "删除失败，请先删除此角色下的所有的用户!",
    			                type: "error",
    			                showCancelButton: false,
    			                confirmButtonColor: "#DD6B55",
    			                confirmButtonText: "OK",
    			                closeOnConfirm: true,
    			                timer:3000
    			            });
    					}else{
    						swal("删除失败", "您的删除操作失败了！", "error");
    					}
    				});
                } else {
                    swal("已取消", "您取消了删除操作！", "error");
                }
            });
		}
		
		</script>
		
		<script type="text/javascript">

	
		//扩展权限 备用，邮件，短信的权限
		function kf_qx1(id,kefu_id,msg,state){
			var value = 1;
			var wqx = state;
			if(wqx){
				value=1;
			}else{
				value=0;
			}
				var url = "<%=basePath%>role/kfqx.do?kefu_id="+kefu_id+"&msg="+msg+"&value="+value+"&guid="+new Date().getTime();
				$.get(url,function(data){
					if(data=="success"){
						//document.location.reload();
					}
				});
		}
		function kf_qx2(id,kefu_id,msg,state){
			var value = 1;
			var wqx = state;
			if(wqx){
				value=1;
			}else{
				value=0;
			}
				var url = "<%=basePath%>role/kfqx.do?kefu_id="+kefu_id+"&msg="+msg+"&value="+value+"&guid="+new Date().getTime();
				$.get(url,function(data){
					if(data=="success"){
						//document.location.reload();
					}
				});
		}
		function kf_qx3(id,kefu_id,msg,state){
			var value = 1;
			var wqx = state;
			if(wqx){
				value=1;
			}else{
				value=0;
			}
				var url = "<%=basePath%>role/kfqx.do?kefu_id="+kefu_id+"&msg="+msg+"&value="+value+"&guid="+new Date().getTime();
				$.get(url,function(data){
					if(data=="success"){
						//document.location.reload();
					}
				});
		}
		function kf_qx4(id,kefu_id,msg,state){
			var value = 1;
			var wqx = state;
			if(wqx){
				value=1;
			}else{
				value=0;
			}
				var url = "<%=basePath%>role/kfqx.do?kefu_id="+kefu_id+"&msg="+msg+"&value="+value+"&guid="+new Date().getTime();
				$.get(url,function(data){
					if(data=="success"){
						//document.location.reload();
					}
				});
		}
		
		//保存信件数
		function c1(id,msg,value,kefu_id){
				if(value==''||value==null){
					swal({
		                title: "格式错误!",
		                text: "请输入数字!",
		                type: "error",
		                showCancelButton: false,
		                confirmButtonColor: "#DD6B55",
		                confirmButtonText: "OK",
		                closeOnConfirm: true,
		                timer:2000
		            });
					$("#"+id).val(0);
					return;
				}else if(isNaN(Number(value))){
					swal({
		                title: "格式错误!",
		                text: "请输入数字!",
		                type: "error",
		                showCancelButton: false,
		                confirmButtonColor: "#DD6B55",
		                confirmButtonText: "OK",
		                closeOnConfirm: true,
		                timer:2000
		            });
					$("#"+id).val(0);
					return;
				}else{
				var url = "<%=basePath%>role/gysqxc.do?kefu_id="+kefu_id+"&msg="+msg+"&value="+value+"&guid="+new Date().getTime();
				$.get(url,function(data){
					if(data=="success"){
						//document.location.reload();
					}
				});
				}
		}
		
		//菜单权限
		function editRights(ROLE_ID){
			$("#EditRights").kendoWindow({
		        width: "400px",
		        height: "550px",
		        title: "菜单权限",
		        actions: ["Close"],
		        content: '<%=basePath%>role/auth.do?ROLE_ID='+ROLE_ID,
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").center().open();
		}
		
		//按钮权限
		function roleButton(ROLE_ID,msg){
			if(msg == 'add_qx'){
				var Title = "授权新增权限";
			}else if(msg == 'del_qx'){
				Title = "授权删除权限";
			}else if(msg == 'edit_qx'){
				Title = "授权修改权限";
			}else if(msg == 'cha_qx'){
				Title = "授权查看权限";
			}
			$("#EditRoleButton").kendoWindow({
		        width: "400px",
		        height: "550px",
		        title: Title,
		        actions: ["Close"],
		        content: '<%=basePath%>role/button.do?ROLE_ID='+ROLE_ID+'&msg='+msg,
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").center().open();
		}
		</script>
</body>
</html>


