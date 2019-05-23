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
	<!-- jsp文件头和头部 -->
	<%@ include file="../../system/admin/top.jsp"%> 

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title>${pd.SYSNAME}</title>
   
</head>

<body class="gray-bg">
<form ction="happuser/${msg }.do" name="userForm" id="userForm" method="post">
<input type="hidden" name="USER_ID" id="user_id" value="${pd.USER_ID }"/>
    <div class="wrapper wrapper-content">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-content">
                        <div class="row">
                            <div class="col-sm-12">
									<c:if test="${pd.ROLE_ID != '1'}">	
									<div class="form-group form-inline">
                                         <select class="form-control" name="ROLE_ID" id="role_id" data-placeholder="请选择等级" title="级别" style="width:300px">
                                        <option value="">请选择等级</option>
                                        <c:forEach items="${roleList}" var="role">
											<option value="${role.ROLE_ID }" <c:if test="${role.ROLE_ID == pd.ROLE_ID }">selected</c:if>>${role.ROLE_NAME }</option>
										</c:forEach>
										</select>
										 <div class="form-group ">
										<input  style="width:300px;max-width:500px;" class="form-control layer-date" placeholder="请选择开通日期"  title="开通日期" name="START_TIME" id="START_TIME" value="${pd.START_TIME}">
		                            	</div>
                                    </div>
									</c:if>
									<c:if test="${pd.ROLE_ID == '1'}">
									<input name="ROLE_ID" id="role_id" value="1" type="hidden" />
									</c:if>
									<div class="form-group form-inline">
                                         <input style="width:300px"   class="form-control" type="text" name="USERNAME" id="loginname" value="${pd.USERNAME }" placeholder="这里输入用户名" title="用户名">
										 <div class="form-group ">
										<input  style="width:300px;max-width:500px;" class="form-control layer-date" name="END_TIME" id="END_TIME" value="${pd.END_TIME}" type="text" placeholder="请选择到期日期" title="到期日期">
		                            	</div>
									</div>
									<div class="form-group form-inline">
                                         <input style="width:300px"  class="form-control" type="text" name="NUMBER" id="NUMBER" value="${pd.NUMBER }" maxlength="32" placeholder="这里输入编号" title="编号" onblur="hasN('${pd.USERNAME }')">
										<input  style="width:300px" class="form-control" type="text" name="EMAIL" id="EMAIL"  value="${pd.EMAIL }" maxlength="32" placeholder="这里输入邮箱" title="邮箱" onblur="hasE('${pd.USERNAME }')">
									</div>
                                    <div class="form-group form-inline">
                                         <input style="width:300px"  class="form-control" type="password" name="PASSWORD" id="password"  placeholder="输入密码"  title="密码">
										<input  style="width:300px" class="form-control" type="tel" name="PHONE" id="PHONE" value="${pd.PHONE }" placeholder="这里输入手机号" title="手机号">
									</div>
									<div class="form-group form-inline">
                                         <input style="width:300px"  class="form-control" type="password" name="chkpwd" id="chkpwd"  placeholder="确认密码"  title="确认密码">
										<input  style="width:300px" class="form-control" type="text" name="SFID" id="SFID" value="${pd.SFID }" placeholder="这里输入身份证号" title="身份证号">
									</div>
									<div class="form-group form-inline">
                                         <input style="width:300px"  class="form-control" type="text" name="NAME" id="name"  value="${pd.NAME }" placeholder="这里输入姓名" title="姓名">
										<input  style="width:300px;max-width:500px;" class="form-control layer-date" type="text"  name="regist_time" id="regist_time"  value="${pd.regist_time }" placeholder="请选择注册时间" title="注册时间">
									</div>
									<div class="form-group form-inline">
                                        <select style="width:300px"  class="form-control" id="sex" name="SEX"  title="性别" >
											<option value='1' <c:if test="${'男'== pd.SEX }">selected</c:if>>男</option>
											<option value='2' <c:if test="${'女'== pd.SEX }">selected</c:if>>女</option>
										</select>
										<select  style="width:300px" class="form-control" id="cityid" name="CITYID" title="城市" >
									       <c:forEach items ="${citys}" var="item">
										  	   <option value='${item.cityid}' <c:if test="${item.cityname== pd.cityname }">selected</c:if>>${item.cityname}</option>
								           </c:forEach>
								        </select>
                                    </div>
									<div class="form-group form-inline">
                                         <input style="width:300px"  class="form-control" type="text" name="card_num" id="card_num"  value="${pd.card_num }" placeholder="这里输入卡号" title="卡号">
										<input  style="width:300px" class="form-control" type="number" name="points" id="points"  value="${pd.points }" placeholder="这里输入积分" title="积分">
									</div>
									<div class="form-group form-inline">
                                         <input style="width:300px"  class="form-control" type="text" name="shop_id" id="shop_id"  value="${pd.shop_id }" placeholder="这里输入开卡门店" title="开卡门店">
										<select style="width:300px"  class="form-control" name="card_from" id="card_from" class="input_txt" data-placeholder="这里输入来源渠道"  title="来源渠道" >
												<option value="">请选择来源渠道</option>
												<option value="网上开卡" <c:if test="${'online'== pd.card_from }">selected</c:if>>网上开卡</option>
												<option value="门店开卡" <c:if test="${'shop'== pd.card_from }">selected</c:if>>门店开卡</option>
											</select>
									</div>
									<div class="form-group form-inline">
                                         <input style="width:300px"  class="form-control" type="number" name="buy_times" id="buy_times"  value="${pd.buy_times }" placeholder="这里输入消费次数" title="消费次数">
										<input  style="width:300px" class="form-control" type="text" name="buy_amount" id="buy_amount"  value="${pd.buy_amount }" placeholder="这里输入消费金额" title="消费金额">
									</div>
									<div class="form-group form-inline">
                                         <input style="width:300px"  class="form-control" type="text" readonly="readonly"  name="wx_openid" id="wx_openid"  value="${pd.wx_openid }" placeholder="这里输入微信ID" title="微信ID">
										<input  style="width:300px" class="form-control" type="text" readonly="readonly"  name="wx_nick" id="wx_nick" value="${pd.wx_nick }" placeholder="这里输入微信号" title="微信号">
									</div>
									<div class="form-group form-inline">
                                         <input style="width:300px"  class="form-control" type="number" name="YEARS" id="YEARS"  value="${pd.YEARS }" placeholder="这里输入开通年限(这里输入数字)" title="开通年限">
										<input  style="width:300px" class="form-control" type="text" name="BZ" id="BZ"value="${pd.BZ }" placeholder="这里输入备注" title="备注">
									</div>
                            		<div class="form-group form-inline">
                                         <input style="width:300px"  class="form-control" type="text" name="RIGHTS" id="RIGHTS"value="${pd.RIGHTS }" placeholder="权限" title="权限">
										<select style="width:300px"  class="form-control" name="STATUS" title="状态">
										<option value="1" <c:if test="${pd.STATUS == '1' }">selected</c:if> >正常</option>
										<option value="0" <c:if test="${pd.STATUS == '0' }">selected</c:if> >冻结</option>
										</select>
									</div>
                            </div>
                            
                        </div>
                        
                    </div>
						<div style="height: 20px;"></div>
						<tr>
						<td><a class="btn btn-primary"style="width: 150px; height:34px;float:left;"  onclick="save();">保存</a></td>
						<td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('EditUsers');">关闭</a></td>
						</tr>
					</div>
            </div>
            
        </div>
 </div>
 </form>
 <!-- 日期控件-->
    <script src="static/js/layer/laydate/laydate.js"></script>
    
	<script type="text/javascript">
	$(document).ready(function(){
		if($("#user_id").val()!=""){
			$("#loginname").attr("readonly","readonly");
			$("#loginname").css("color","gray");
		}
	});
	//日期范围限制
    var start = {
        elem: '#START_TIME',
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
        elem: '#END_TIME',
        format: 'YYYY/MM/DD hh:mm:ss',
        max: '2099-06-16 23:59:59',
        istime: true,
        istoday: false,
        choose: function (datas) {
            start.max = datas; //结束日选好后，重置开始日的最大日期
        }
    };
    var reg = {
            elem: '#regist_time',
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
    laydate(reg);
	function ismail(mail){
	return(new RegExp(/^(?:[a-zA-Z0-9]+[_\-\+\.]?)*[a-zA-Z0-9]+@(?:([a-zA-Z0-9]+[_\-]?)*[a-zA-Z0-9]+\.)+([a-zA-Z]{2,})+$/).test(mail));
	}
	
	//保存
	function save(){
		
		if($("#role_id").val()==""){
			$("#role_id").focus();
			$("#role_id").tips({
				side:3,
	            msg:'选择角色',
	            bg:'#AE81FF',
	            time:2
	        });

			return false;
		}
		if($("#loginname").val()=="" || $("#loginname").val()=="此用户名已存在!"){
			
			$("#loginname").tips({
				side:3,
	            msg:'输入用户名',
	            bg:'#AE81FF',
	            time:2
	        });
			
			$("#loginname").focus();
			$("#loginname").val('');
			$("#loginname").css("background-color","white");
			return false;
		}else{
			$("#loginname").val(jQuery.trim($('#loginname').val()));
		}
		
		if($("#NUMBER").val()==""){
			
			$("#NUMBER").tips({
				side:3,
	            msg:'输入编号',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#NUMBER").focus();
			return false;
		}	
		
		if($("#EMAIL").val()==""){
			
			$("#EMAIL").tips({
				side:3,
	            msg:'输入邮箱',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#EMAIL").focus();
			return false;
		}else if(!ismail($("#EMAIL").val())){
			$("#EMAIL").tips({
				side:3,
	            msg:'邮箱格式不正确',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#EMAIL").focus();
			return false;
		}
		if($("#user_id").val()=="" && $("#password").val()==""){
			
			$("#password").tips({
				side:3,
	            msg:'输入密码',
	            bg:'#AE81FF',
	            time:2
	        });
			
			$("#password").focus();
			return false;
		}
		if($("#password").val()!=$("#chkpwd").val()){
			$("#chkpwd").tips({
				side:3,
	            msg:'两次密码不相同',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#chkpwd").focus();
			return false;
		}
		if($("#name").val()==""){
			$("#name").tips({
				side:3,
	            msg:'输入姓名',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#name").focus();
			return false;
		}
		if($("#card_num").val()==""){
			$("#card_num").tips({
				side:3,
	            msg:'输入会员卡号',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#card_num").focus();
			return false;
		}
		if($("#card_num").val()==""){
			$("#card_num").tips({
				side:3,
	            msg:'输入会员卡号',
	            bg:'#AE81FF',
	            time:3
	        });
			$("#card_num").focus();
			return false;
		}
		if($("#START_TIME").val()!= "" && $("#END_TIME").val() != ""){
			var t1 = $("#START_TIME").val();
			var t2 = $("#END_TIME").val();
			t1 = Number(t1.replace('-', '').replace('-', ''));
			t2 = Number(t2.replace('-', '').replace('-', ''));
			if(t1-t2>0){
				
				$("#END_TIME").tips({
					side:3,
		            msg:'到期日期必须大于开通日期',
		            bg:'#AE81FF',
		            time:3
		        });
				
				return false;
			}
		}
		if($("#YEARS").val()==""){
			$("#YEARS").val(0);
		}else if(isNaN(Number($("#YEARS").val()))){
			
			$("#YEARS").tips({
				side:3,
	            msg:'输入数字',
	            bg:'#AE81FF',
	            time:3
	        });
			
			$("#YEARS").focus();
			$("#YEARS").val(0);
			return false;
		}
			
		if($("#user_id").val()==""){
			hasU();
		}else{
			$("#userForm").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
	}
	
	//判断用户名是否存在
	function hasU(){
		var USERNAME = $("#loginname").val();
		var url = "<%=basePath%>happuser/hasU.do?USERNAME="+USERNAME+"&tm="+new Date().getTime();
		$.get(url,function(data){
			if(data=="error"){
				$("#loginname").css("background-color","#D16E6C");
				
				setTimeout("$('#loginname').val('此用户名已存在!')",500);
				
			}else{
				$("#userForm").submit();
				$("#zhongxin").hide();
				$("#zhongxin2").show();
			}
		});
	}
	
	//判断邮箱是否存在
	function hasE(USERNAME){
		var EMAIL = $("#EMAIL").val();
		var url = "<%=basePath%>happuser/hasE.do?EMAIL="+EMAIL+"&USERNAME="+USERNAME+"&tm="+new Date().getTime();
		$.get(url,function(data){
			if(data=="error"){
				
				$("#EMAIL").tips({
					side:3,
		            msg:'邮箱已存在',
		            bg:'#AE81FF',
		            time:3
		        });
				
				setTimeout("$('#EMAIL').val('')",2000);
				
			}
		});
	}
	
	//判断编码是否存在
	function hasN(USERNAME){
		var NUMBER = $("#NUMBER").val();
		var url = "<%=basePath%>happuser/hasN.do?NUMBER="+NUMBER+"&USERNAME="+USERNAME+"&tm="+new Date().getTime();
		$.get(url,function(data){
			if(data=="error"){
				
				$("#NUMBER").tips({
					side:3,
		            msg:'编号已存在',
		            bg:'#AE81FF',
		            time:3
		        });
				
				setTimeout("$('#NUMBER').val('')",2000);
				
			}
		});
	}
		
		function CloseSUWin(id) {
			window.parent.$("#" + id).data("kendoWindow").close();
		/* 	window.parent.location.reload(); */
		}
	</script>
</body>

</html>
