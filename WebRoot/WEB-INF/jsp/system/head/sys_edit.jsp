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
    <!-- Check Box -->
    <link href="static/js/iCheck/custom.css" rel="stylesheet">
    <!-- 图片插件 -->
    <link href="static/js/fancybox/jquery.fancybox.css" rel="stylesheet">
    <!-- 上传图片插件 -->
	<link href="plugins/uploadify/uploadify.css" rel="stylesheet" type="text/css">
	
	<title>${pd.SYSNAME}</title>
</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
	        <div class="row">
	        	<input type="hidden" id="ROLE_ID" name="ROLE_ID" value="${pd.ROLE_ID}">
	        	 <div class="panel blank-panel">
                    <div class="panel-heading">
                        <div class="panel-options">
                        	<ul class="nav nav-tabs">
                                <li class="active" >
                                <a data-toggle="tab" href="#tab-1" onclick="tabChange('1')">
	                                <i class="fa fa-home"></i>
	                                配置 NO1
                                </a>
                                </li>
                                <li>
                                <a data-toggle="tab" href="#tab-2" onclick="tabChange('2')">
	                                <i class="fa fa-cog"></i>
	                                配置 NO2
                                </a>
                                </li>
                                <li>
                                <a data-toggle="tab" href="#tab-3" onclick="tabChange('3')">
	                                <i class="fa fa-cog"></i>
	                                配置 NO3
                                </a>
                                </li>
                        	 </ul>    
                        </div>
                    </div>
					<div class="panel-body">
                    	<div class="tab-content">
                            <div id="tab-1" class="tab-pane active">
				                <div class="ibox float-e-margins">
				                    <form action="head/saveSys.do" name="Form" id="Form" method="post">
	                           			<table id="table_report" class="table table-striped table-bordered table-hover">
											<tr>
												<td style="width:80px;text-align: right;padding-top: 13px;">系统名称:</td>
												<td><input type="text" name="YSYNAME" id="YSYNAME" value="${pd.YSYNAME }" placeholder="这里输入系统名称" style="width:90%" title="系统名称"/></td>
											
												<td style="width:80px;text-align: right;padding-top: 13px;">每页条数:</td>
												<td><input type="number" name="COUNTPAGE" id="COUNTPAGE" value="${pd.COUNTPAGE }" placeholder="这里输入每页条数" style="width:90%" title="每页条数"/></td>
											</tr>
										</table>
										<table id="table_report" class="table table-striped table-bordered table-hover">
											<tr>
												<td style="text-align: center;" colspan="100">
													邮件服务器配置
												</td>
											</tr>
											<tr>
												<td style="width:80px;text-align: right;padding-top: 13px;">SMTP:</td>
												<td><input type="text" name="SMTP" id="SMTP" value="${pd.SMTP }" placeholder="例如:smtp.qq.com" style="width:90%" title="SMTP"/></td>
											
												<td style="width:80px;text-align: right;padding-top: 13px;">端口:</td>
												<td><input type="number" name="PORT" id="PORT" value="${pd.PORT }" placeholder="一般为：25" style="width:90%" title="端口"/></td>
											</tr>
											<tr>
												<td style="width:80px;text-align: right;padding-top: 13px;">邮箱:</td>
												<td><input type="email" name="EMAIL" id="EMAIL" value="${pd.EMAIL }" placeholder="请输入邮件服务器邮箱" style="width:90%" title="邮箱"/></td>
											
												<td style="width:80px;text-align: right;padding-top: 13px;">密码:</td>
												<td><input type="password" name="PAW" id="PAW" value="${pd.PAW }" placeholder="请输入邮箱密码" style="width:90%" title="密码"/></td>
											</tr>
										</table>
										
										<table id="table_report" class="table table-striped table-bordered table-hover">
											<tr>
												<td style="text-align: center;" colspan="100">
													短信接口&nbsp;(短信商一&nbsp;<a href="http://www.dxton.com/" target="_blank">官网</a>)
												</td>
											</tr>
											<tr>
												<td style="width:80px;text-align: right;padding-top: 13px;">账号:</td>
												<td><input type="email" name="SMSU1" id="SMSU1" value="${pd.SMSU1 }" placeholder="请输入账号" style="width:90%" title="邮箱"/></td>
											
												<td style="width:80px;text-align: right;padding-top: 13px;">密码:</td>
												<td><input type="password" name="SMSPAW1" id="SMSPAW1" value="${pd.SMSPAW1 }" placeholder="请输入密码" style="width:90%" title="密码"/></td>
											</tr>
											<tr>
												<td style="text-align: center;" colspan="100">
													短信接口&nbsp;(短信商二&nbsp;<a href="http://www.ihuyi.com/" target="_blank">官网</a>)
												</td>
											</tr>
											<tr>
												<td style="width:80px;text-align: right;padding-top: 13px;">账号:</td>
												<td><input type="email" name="SMSU2" id="SMSU2" value="${pd.SMSU2 }" placeholder="请输入账号" style="width:90%" title="邮箱"/></td>
											
												<td style="width:80px;text-align: right;padding-top: 13px;">密码:</td>
												<td><input type="password" name="SMSPAW2" id="SMSPAW2" value="${pd.SMSPAW2 }" placeholder="请输入密码" style="width:90%" title="密码"/></td>
											</tr>
										</table>
								
										<table class="center" style="width:100%" >
											<div style="height: 10px;">
												<tr>
												<td><a class="btn btn-primary"style="width: 150px; height:34px;float:left;"  onclick="save();">保存</a></td>
												<td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('EditSys');">关闭</a></td>
												</tr>
											</div>
										</table>
									</form>
				                </div>
				            </div>
				            <!-- 配置NO2 -->
				            <div id="tab-2" class="tab-pane">
				                <div class="ibox float-e-margins">
				                    <form action="head/saveSys2.do" name="Form2" id="Form2" method="post">
										<table id="table_report" class="table table-striped table-bordered table-hover">
											<tr>
												<td style="text-align: center;" colspan="100">
													文字水印配置
													<label style="float:left;padding-left: 15px;"><input name="fcheckbox" class="i-checks" type="checkbox" id="check1"  /><span class="lbl">开启</span></label>
												</td>
											</tr>
											<tr>
												<td style="width:80px;text-align: right;padding-top: 12px;">内容:</td>
												<td><input type="text" name="fcontent" id="fcontent" value="${pd.fcontent }"  style="width:90%" title="水印文字内容"/></td>
												<td style="width:80px;text-align: right;padding-top: 12px;">字号:</td>
												<td><input type="number" name="fontSize" id="fontSize" value="${pd.fontSize }"  style="width:90%" title="字号"/></td>
											</tr>
											<tr>
												<td style="width:80px;text-align: right;padding-top: 12px;">X坐标:</td>
												<td><input type="number" name="fontX" id="fontX" value="${pd.fontX }"  style="width:90%" title="X坐标"/></td>
												<td style="width:80px;text-align: right;padding-top: 12px;">Y坐标:</td>
												<td><input type="number" name="fontY" id="fontY" value="${pd.fontY }"  style="width:90%" title="Y坐标"/></td>
											</tr>
										</table>
										
										<table id="table_report" class="table table-striped table-bordered table-hover">
											<tr>
												<td style="text-align: center;" colspan="100">
													图片水印配置
													<label style="float:left;padding-left: 15px;"><input name="fcheckbox" class="i-checks" type="checkbox" id="check2" /><span class="lbl">开启</span></label>
												</td>
											</tr>
											<tr>
												<td style="width:80px;text-align: right;padding-top: 12px;">X坐标:</td>
												<td><input type="number" name="imgX" id="imgX" value="${pd.imgX }" style="width:90%" title="X坐标"/></td>
												<td style="width:80px;text-align: right;padding-top: 12px;">Y坐标:</td>
												<td><input type="number" name="imgY" id="imgY" value="${pd.imgY }"  style="width:90%" title="Y坐标"/></td>
											</tr>
											<tr>
												<td style="width:80px;text-align: right;padding-top: 12px;">水印:</td>
												<td colspan="10" >
													<div style="float:left;">
													<a class="fancybox" href="<%=basePath%>uploadFiles/uploadImgs/${pd.imgUrl}">
							                            <img style="width:150px;height:50px" src="<%=basePath%>uploadFiles/uploadImgs/${pd.imgUrl}"/>
							                        </a>
							                        </div>
							                        <div style="float:right;align:center"><input type="file" name="TP_URL" id="uploadify1" keepDefaultStyle = "true"/></div>
												</td>
												<%-- <td colspan="10">
												<div style="float:left;" class="fancybox"><img src="<%=basePath%>uploadFiles/uploadImgs/${pd.imgUrl}" style="width:150px;height:50px" /></div>
												<div style="float:right;"><input type="file" name="TP_URL" id="uploadify1" keepDefaultStyle = "true"/></div>
												</td> --%>
											</tr>
										</table>
										
										<table class="center" style="width:100%" >
											<div style="height: 10px;">
												<tr>
												<td><a class="btn btn-primary"style="width: 150px; height:34px;float:left;"  onclick="save2();">保存</a></td>
												<td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('EditSys');">关闭</a></td>
												</tr>
											</div>
										</table>
										<input type="hidden" name="isCheck1" id="isCheck1" value="${pd.isCheck1 }"/>
										<input type="hidden" name="isCheck2" id="isCheck2" value="${pd.isCheck2 }"/>
										<input type="hidden" name="imgUrl" id="imgUrl" value="${pd.imgUrl }"/>
										<input type="hidden" value="no" id="hasTp1" />
									</form>
				                </div>
				            </div>
				            <!--配置NO3  -->
				            <div id="tab-3" class="tab-pane">
				                <div class="ibox float-e-margins">
				                    <form action="head/saveSys3.do" name="Form3" id="Form3" method="post">
										<table id="table_report" class="table table-striped table-bordered table-hover">
											<tr>
												<td style="text-align: center;" colspan="100">
													微信接口配置
												</td>
											</tr>
											<tr>
												<td style="width:120px;text-align: right;padding-top: 12px;">URL(服务器地址):</td>
												<td><input type="text" name="WXURL" id="WXURL" value="<%=basePath%>weixin/index "   style="width:90%" title="URL(服务器地址)必须是域名，ip地址验证通不过"/></td>
											</tr>
											<tr>
												<td style="width:120px;text-align: right;padding-top: 12px;">Token(令牌):</td>
												<td><input type="text" name="Token" id="Token" value="${pd.Token }"  style="width:90%" title="URL(服务器地址)"/></td>
											</tr>
										</table>
										
										<table class="center" style="width:100%" >
											<div style="height: 10px;">
												<tr>
												<td><a class="btn btn-primary"style="width: 150px; height:34px;float:left;"  onclick="save3();">保存</a></td>
												<td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('EditSys');">关闭</a></td>
												</tr>
											</div>
										</table>
									</form>
				                </div>
				            </div>
			           </div>
					</div>
				 </div>
                    

                </div>
	           </div>
	    </div>
	<!--引入属于此页面的js -->
	<script type="text/javascript" src="static/js/myjs/sys.js"></script>
    <!-- Sweet alert -->
    <script src="static/js/sweetalert/sweetalert.min.js"></script>
    <!-- iCheck -->
    <script src="static/js/iCheck/icheck.min.js"></script>
    <!-- Fancy box -->
    <script src="static/js/fancybox/jquery.fancybox.js"></script>
    <!-- 上传图片插件 -->
	<script type="text/javascript" src="plugins/uploadify/swfobject.js"></script>
	<script type="text/javascript" src="plugins/uploadify/jquery.uploadify.v2.1.4.min.js"></script>
	<!-- 上传图片插件 -->
	<script type="text/javascript">
	var jsessionid = "<%=session.getId()%>";  //勿删，uploadify兼容火狐用到
	</script>
    <script type="text/javascript">
    $(document).ready(function () {
		//loading end
		parent.layer.closeAll('loading');
    	/* checkbox */
        $('.i-checks').iCheck({
            checkboxClass: 'icheckbox_square-green',
            radioClass: 'iradio_square-green',
        });
    	
        if("${pd.isCheck1 }" == "yes"){
        	$('#check1').iCheck('check');
		}else{
			$('#check1').iCheck('uncheck');
		}
		if("${pd.isCheck2 }" == "yes"){
			$('#check2').iCheck('check');
		}else{
			$('#check2').iCheck('uncheck');
		}
    	/* 图片 */
        $('.fancybox').fancybox({
            openEffect: 'none',
            closeEffect: 'none'
        });
    });
    /* checkbox选中 */
    $("#check1").on('ifChecked', function(event){
    	$('#check1').iCheck('check');
    	$("#isCheck1").val('yes');
  	});
    $("#check2").on('ifChecked', function(event){
    	$('#check2').iCheck('check');
    	$("#isCheck2").val('yes');
  	});
    /* checkbox取消选中 */
    $("#check1").on('ifUnchecked', function(event){
    	$('#check1').iCheck('uncheck');
    	$("#isCheck1").val('no');
  	});
    $("#check2").on('ifUnchecked', function(event){
    	$('#check2').iCheck('uncheck');
    	$("#isCheck2").val('no');
  	});
	//tab切换
	function tabChange(id){
		$("#tab-"+id).addClass('active');
	}
	//关闭页面
	function CloseSUWin(id) {
		window.parent.$("#" + id).data("kendoWindow").close();
	
	}
	</script>
</body>
</html>


