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
    <!-- 图片插件 -->
    <link href="static/js/fancybox/jquery.fancybox.css" rel="stylesheet">
    <!-- Check Box -->
    <link href="static/js/iCheck/custom.css" rel="stylesheet">
    <!-- Sweet Alert -->
    <link href="static/js/sweetalert/sweetalert.css" rel="stylesheet">
	<title>${pd.SYSNAME}</title>
</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div id="EditUsers" class="animated fadeIn"></div>
        <div id="ImportExcel" class="animated fadeIn"></div>
	        <div class="row">
	            <div class="col-sm-12">
	                <div class="ibox float-e-margins">
	                    <div class="ibox-content">
	                    <div id="top",name="top"></div>
	                        <form role="form" class="form-inline" action="happuser/listUsers.do" method="post" name="userForm" id="userForm">
	                            <div class="form-group ">
	                                <input type="text" id="nav-search-input" name="USERNAME" value="${pd.USERNAME }" placeholder="这里输入用户名关键词" class="form-control">
	                            </div>
	                            <div class="form-group ">
	                                <input placeholder="用户最近登录开始日期" title="开始日期" class="form-control layer-date" value="${pd.lastLoginStart}" name="lastLoginStart" id="lastLoginStart">
	                            </div>
	                             <div class="form-group ">
	                                <input placeholder="用户最近登录结束日期" title="结束日期" class="form-control layer-date" value="${pd.lastLoginEnd}" name="lastLoginEnd" id="lastLoginEnd">
	                            </div>   
	                            <div class="form-group">
                                       <select class="form-control" name="ROLE_ID" id="role_id" data-placeholder="请选择等级"  style="vertical-align:top;width:100%"  title="角色">
										<option value="">请选择等级</option>
										<c:forEach items="${roleList}" var="role">
											<option value="${role.ROLE_ID }" <c:if test="${pd.ROLE_ID==role.ROLE_ID}">selected</c:if>>${role.ROLE_NAME }</option>
										</c:forEach>
										</select>
                                </div>
	                            <div class="form-group">
                                       <select class="form-control" name="STATUS" id="STATUS" data-placeholder="状态" style="vertical-align:top;width:100%"  title="角色">
										<option value="">请选择状态</option>
										<option value="1" <c:if test="${pd.STATUS == '1' }">selected</c:if> >正常</option>
										<option value="0" <c:if test="${pd.STATUS == '0' }">selected</c:if> >冻结</option>
										</select>
                                </div>
	                            <div class="form-group">
	                                 <button type="submit" class="btn  btn-primary " style="margin-bottom:0px;" title ="搜索"><i style="font-size:18px;" class="fa fa-search"></i></button>
	                            </div>
	                            <c:if test="${QX.cha == 1 }">
	                            <div class="form-group">
	                                 <button type="button" class="btn  btn-warning " style="margin-bottom:0px;" title ="导出到EXCEL" onclick="toExcel();"><i style="font-size:18px;" class="fa fa-cloud-download"></i></button>
	                            </div>
	                            <c:if test="${QX.edit == 1 }">
	                            <div class="form-group">
	                                 <button type="button" class="btn  btn-info " style="margin-bottom:0px;"  disabled onclick="importExcel();" title="从EXCEL导入"><i style="font-size:18px;" class="fa fa-cloud-upload"></i></button>
	                            </div>
	                            </c:if>
	                            </c:if>
	                            <button class="btn  btn-success" title="刷新" type="button" style="float:right" onclick="refreshCurrentTab();">刷新</button>
	                        	
	                        </form>
	                            <div class="row">
	                            </br>
	                             </div>
	                        <div class="table-responsive" style="1500px">
	                            <table class="table table-striped table-bordered table-hover" style="width:2000px">
	                                <thead>
	                                    <tr>
	                                        <th style="width:1%;"><input type="checkbox" name="zcheckbox" id="zcheckbox" class="i-checks" ></th>
	                                        <th style="width:2%;">序号</th>
	                                        <th style="width:5%;">会员名称</th>
	                                        <th style="width:5%;">姓名</th>
	                                        <th style="width:5%;">角色名称</th>
	                                        <th style="width:3%;">性别</th>
	                                        <th style="width:5%;">电话</th>
	                                        <th style="width:3%;">城市</th>
	                                        <th style="width:3%;">开通年限</th>
	                                        <th style="width:5%;">身份证号码</th>
	                                        <th style="width:5%;">邮箱</th>
	                                        <th style="width:5%;">会员卡号</th>	
	                                        <th style="width:3%;">积分</th>
	                                        <th style="width:5%;">开卡门店</th>
	                                        <th style="width:5%;">来源渠道</th>
	                                        <th style="width:3%;">消费次数</th>
	                                        <th style="width:3%;">消费金额</th>
	                                        <th style="width:5%;">注册时间</th>
	                                        <th style="width:5%;">开始时间</th>
	                                        <th style="width:5%;">结束时间</th>
	                                        <th style="width:5%;">最后登录时间</th>
	                                        <th style="width:3%;">状态</th>
	                                        <th style="width:15%;">操作</th>
	                                    </tr>
	                                </thead>
	                                <tbody>
	                                <!-- 开始循环 -->	
									<!-- 开始循环 -->	
									<c:choose>
										<c:when test="${not empty userList}">
											<c:if test="${QX.cha == 1 }">
											<c:forEach items="${userList}" var="user" varStatus="vs">
														
												<tr>
													<td class='center' style="width: 30px;">
														<label><input  class="i-checks" type='checkbox' name='ids' value="${user.USER_ID }" id="${user.EMAIL }" alt="${user.PHONE }"/><span class="lbl"></span></label>
													</td>
													<td class='center' style="width: 30px;">${vs.index+1}</td>
													<td>${user.USERNAME }</td>
													<td>${user.NAME }</td>
													<td>${user.ROLE_NAME }</td>
													<td>
													<c:choose>
													<c:when test="${user.sex == '2'}">女    </c:when>
													<c:when test="${user.sex == '1'}">男    </c:when>
													</c:choose>
													</td>
													<td>${user.PHONE }</td>
													<td>${user.cityname }</td>
													<td>${user.YEARS }</td>
													<td>${user.NUMBER}</td>
													<td>${user.EMAIL}</td>
													<td>${user.card_num }</td>
													<td>${user.points }</td>
													<td>${user.shop_id }</td>
													<td> 
													   <c:if test="${user.card_from=='online'}">   
															网上开卡
													   </c:if>  
													   <c:if test="${user.card_from=='shop'}">   
															门店开卡
													   </c:if>
													</td>
													<td>${user.buy_times }</td>
													<td>${user.buy_amount }</td>
													<td>${user.regist_time }</td>
													<td>${user.START_TIME}</td>
													<td>${user.END_TIME }</td>
													<td>${user.LAST_LOGIN}</td>
													<td style="width: 60px;" class="center">
														<c:if test="${user.STATUS == '0' }"><span class="label label-important arrowed-in">冻结</span></c:if>
														<c:if test="${user.STATUS == '1' }"><span class="label label-info arrowed">正常</span></c:if>
													</td>
													<td style="width: 30px;" class="center">
													<c:if test="${QX.edit != 1 && QX.del != 1 }">
																<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="icon-lock" title="无权限"></i></span>
															</c:if>
															<div>
															<c:if test="${QX.FX_QX == 1 }">
															<button class="btn  btn-warning btn-sm" title="发送电子邮件" type="button" onclick="sendEmail('${user.EMAIL }');">邮件</button>
															</c:if>
															<c:if test="${QX.FX_QX != 1 }">
															<button class="btn  btn-warning btn-sm" title="你无权发送电子邮件" type="button" disabled>邮件</button>
															</c:if>
																<c:if test="${QX.FW_QX == 1 }">
																	<button class="btn  btn-success btn-sm" title="短信" type="button" onclick="sendSms('${user.PHONE }');">短信</button>
																</c:if>
																<c:if test="${QX.edit == 1 }">
																	<c:if test="${user.USERNAME != 'admin'}">
																	<button class="btn  btn-primary btn-sm" title="编辑" type="button" onclick="editUser('${user.USER_ID }');">编辑</button>
																	</c:if>
																	<c:if test="${user.USERNAME == 'admin'}">
																	<button class="btn  btn-primary btn-sm" title="您不能编辑" type="button" disabled>编辑</button>
																	</c:if>
																</c:if>
																<c:choose>
																<c:when test="${user.USERNAME=='admin'}">
																	<button class="btn  btn-danger btn-sm" title="您不能删除" type="button" diabled>删除</button>
																</c:when>
																<c:otherwise>
																	<c:if test="${QX.del == 1 }">
																	<button class="btn  btn-danger btn-sm" title="删除" type="button" onclick="delUser('${user.USER_ID }','${user.USERNAME }');">删除</button>
																	</c:if>
																</c:otherwise>
															</c:choose>
													</td>
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
								
	                        </div>
	                        
	                        <div class="col-lg-12" style="padding-left:0px;padding-right:0px;margin:10px -10px 10px -10px">
									<c:if test="${QX.add == 1 }">
										<button class="btn  btn-primary" title="新增" type="button" onclick="add();">新增</button>
									</c:if>
									<c:if test="${QX.FX_QX == 1 }">
										<button class="btn  btn-warning" title="批量发送电子邮件" type="button" onclick="makeAll('sendEmail');">批量电邮</button>
									</c:if>
									<c:if test="${QX.FW_QX == 1 }">
											<button class="btn  btn-success" title="批量发送短信" type="button" onclick="makeAll('sendSms');">批量短信</button>
									</c:if>
									<c:if test="${QX.del == 1 }">
										<button class="btn  btn-danger" title="批量删除" type="button" onclick="makeAll('del');">批量删除</button>						
									</c:if>
										${page.pageStr}
								</div>
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
	    <!--返回顶部开始-->
        <div id="back-to-top">
            <a class="btn btn-warning btn-back-to-top" href="javascript: setWindowScrollTop (this,document.getElementById('top').offsetTop);">
                <i class="fa fa-chevron-up"></i>
            </a>
        </div>
        <!--返回顶部结束-->
	<!-- Fancy box -->
    <script src="static/js/fancybox/jquery.fancybox.js"></script>
	<!-- iCheck -->
    <script src="static/js/iCheck/icheck.min.js"></script>
    <!-- Sweet alert -->
    <script src="static/js/sweetalert/sweetalert.min.js"></script>
    <!-- 日期控件-->
    <script src="static/js/layer/laydate/laydate.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
        	/* checkbox */
            $('.i-checks').iCheck({
                checkboxClass: 'icheckbox_square-green',
                radioClass: 'iradio_square-green',
            });
        	/* 图片 */
            $('.fancybox').fancybox({
                openEffect: 'none',
                closeEffect: 'none'
            });
        });
        /* checkbox全选 */
        $("#zcheckbox").on('ifChecked', function(event){
        	
        	$('input').iCheck('check');
      	});
        /* checkbox取消全选 */
        $("#zcheckbox").on('ifUnchecked', function(event){
        	
        	$('input').iCheck('uncheck');
      	});
        
      	//刷新iframe
        function refreshCurrentTab() {
        	$("#userForm").submit();
        }
		//检索
		function search(){
			$("#userForm").submit();
		}
		//去发送电子邮件页面
		function sendEmail(EMAIL){
			$("#EditUsers").kendoWindow({
		        width: "800px",
		        height: "500px",
		        title: "发送邮件",
		        actions: ["Close"],
		        content: '<%=basePath%>head/goSendEmail.do?EMAIL='+EMAIL+'&msg=appuser',
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").center().open();
		}
		
		//去发送短信页面
		function sendSms(phone){
			$("#EditUsers").kendoWindow({
		        width: "800px",
		        height: "500px",
		        title: "发送短信",
		        actions: ["Close"],
		        content: '<%=basePath%>head/goSendSms.do?PHONE='+phone+'&msg=appuser',
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").center().open();
		}
		//新增
		function add(){
			$("#EditUsers").kendoWindow({
		        width: "800px",
		        height: "500px",
		        title: "新增",
		        actions: ["Close"],
		        content: '<%=basePath%>happuser/goAddU.do',
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").center().open();
		}
		//修改
		function editUser(user_id){
			$("#EditUsers").kendoWindow({
		        width: "800px",
		        height: "600px",
		        title: "修改资料",
		        actions: ["Close"],
		        content: '<%=basePath%>happuser/goEditU.do?USER_ID='+user_id,
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").center().open();
		}
		//删除
		function delUser(userId,msg){
            swal({
                    title: "您确定要删除["+msg+"]吗？",
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
                    	$("#loading1").show();
                    	var url = "<%=basePath%>happuser/deleteU.do?USER_ID="+userId+"&tm="+new Date().getTime();
        				$.get(url,function(data){
        					if(data=='success'){
        						$("#loading1").hide();
        						swal({   
        				        	title: "删除成功！",
        				        	text: "您已经成功删除了这条信息。",
        				        	type: "success",  
        				        	 }, 
        				        	function(){   
        				        		 refreshCurrentTab(); 
        				        	 });
        					}else{
        						$("#loading1").hide();
        						swal("删除失败", "您的删除操作失败了！", "error");
        					}
        				});
                    } else {
                        swal("已取消", "您取消了删除操作！", "error");
                    }
                });
		}
		//批量操作
		function makeAll(msg){
			var str = '';
			var emstr = '';
			var phones = '';
			for(var i=0;i < document.getElementsByName('ids').length;i++)
			{
				  if(document.getElementsByName('ids')[i].checked){
				  	if(str=='') str += document.getElementsByName('ids')[i].value;
				  	else str += ',' + document.getElementsByName('ids')[i].value;
				  	
				  	if(emstr=='') emstr += document.getElementsByName('ids')[i].id;
				  	else emstr += ';' + document.getElementsByName('ids')[i].id;
				  	
				  	if(phones=='') phones += document.getElementsByName('ids')[i].alt;
				  	else phones += ';' + document.getElementsByName('ids')[i].alt;
				  }
			}
			if(str==''){
				swal({
	                title: "您未选择任何数据",
	                text: "请选择你需要操作的数据！",
	                type: "error",
	                showCancelButton: false,
	                confirmButtonColor: "#DD6B55",
	                confirmButtonText: "OK",
	                closeOnConfirm: true,
	                timer:1500
	            });
			}else{

				if(msg == 'del'){
					swal({
		                title: "您确定要删除选中的数据吗？",
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
		                	$("#loading1").show();
		                	$.ajax({
								type: "POST",
								url: '<%=basePath%>happuser/deleteAllU.do?tm='+new Date().getTime(),
						    	data: {USER_IDS:str},
								dataType:'json',
								cache: false,
								success: function(data){
									$.each(data.list, function(i, list){
										if(list.msg=='ok'){
											$("#loading1").hide();
											swal({   
			        				        	title: "删除成功！",
			        				        	text: "您已经成功删除了这些数据。",
			        				        	type: "success",  
			        				        	 }, 
			        				        	function(){   
			        				        		 refreshCurrentTab(); 
			        				        	 });
				    					}else{
				    						$("#loading1").hide();
				    						swal("删除失败", "您的删除操作失败了！", "error");
				    					}
								 	});
									
								}
							});
		                } else {
		                    swal("已取消", "您取消了删除操作！", "error");
		                }
		            });
				}else if(msg == 'sendEmail'){
					swal({
		                title: "您确定要给选中的用户发送邮件吗？",
		                text: "请谨慎操作！",
		                type: "warning",
		                showCancelButton: true,
		                confirmButtonColor: "#DD6B55",
		                confirmButtonText: "发送",
		                cancelButtonText: "取消",
		                closeOnConfirm: true,
		                closeOnCancel: false
		            },
		            function (isConfirm) {
		                if (isConfirm) {
		                	sendEmail(emstr);
		                } else {
		                    swal("已取消", "您取消了发送邮件的操作！", "error");
		                }
		            });
					
				}else if(msg == 'sendSms'){
					swal({
		                title: "您确定要给选中的用户发送短信吗？",
		                text: "请谨慎操作！",
		                type: "warning",
		                showCancelButton: true,
		                confirmButtonColor: "#DD6B55",
		                confirmButtonText: "发送",
		                cancelButtonText: "取消",
		                closeOnConfirm: true,
		                closeOnCancel: false
		            },
		            function (isConfirm) {
		                if (isConfirm) {
		                	sendSms(phones);
		                } else {
		                    swal("已取消", "您取消了发送短信的操作！", "error");
		                }
		            });
					
				}
			}
		}
		//导出excel
		function toExcel(){
			var USERNAME = $("#nav-search-input").val();
			var lastLoginStart = $("#lastLoginStart").val();
			var lastLoginEnd = $("#lastLoginEnd").val();
			var ROLE_ID = $("#role_id").val();
			var STATUS = $("#STATUS").val();
			window.location.href='<%=basePath%>happuser/excel.do?USERNAME='+USERNAME+'&lastLoginStart='+lastLoginStart+'&lastLoginEnd='+lastLoginEnd+'&ROLE_ID='+ROLE_ID+'&STATUS='+STATUS;
		}
		//打开上传excel页面
		function importExcel(){
			
			$("#ImportExcel").kendoWindow({
		        width: "600px",
		        height: "400px",
		        title: "从EXCEL导入到数据库",
		        actions: ["Close"],
		        content: '<%=basePath%>appUser/goUploadExcel.do',
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").center().open();
		}
		//日期范围限制
        var start = {
            elem: '#lastLoginStart',
            format: 'YYYY/MM/DD hh:mm:ss',
            max: '2099-06-16 23:59:59', //最大日期
            istime:true,
            istoday: false,
            choose: function (datas) {
                end.min = datas; //开始日选好后，重置结束日的最小日期
                end.start = datas //将结束日的初始值设定为开始日
            }
        };
        var end = {
            elem: '#lastLoginEnd',
            format: 'YYYY/MM/DD hh:mm:ss',
            max: '2099-06-16 23:59:59',
            istime: true,
            istoday: false,
            choose: function (datas) {
                start.max = datas; //结束日选好后，重置开始日的最大日期
            }
        };
        laydate(start);
        laydate(end);
		/* back to top */
		function setWindowScrollTop(win, topHeight){
		    if(win.document.documentElement){
		        win.document.documentElement.scrollTop = topHeight;
		    }
		    if(win.document.body){
		        win.document.body.scrollTop = topHeight;
		    }
		}
		</script>
</body>
</html>


