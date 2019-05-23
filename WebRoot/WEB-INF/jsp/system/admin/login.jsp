
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title>${pd.SYSNAME}</title>

    <link rel="shortcut icon" href="favicon.ico"> <link href="static/css/bootstrap.min.css" rel="stylesheet">
    <link href="static/css/font-awesome.css" rel="stylesheet">

    <link href="static/css/animate.css" rel="stylesheet">
    <link href="static/css/style.css" rel="stylesheet">
    <link href="static/css/iCheck/custom.css" rel="stylesheet">
    <link href="static/js/layer/skin/layer.css" rel="stylesheet">

    <!-- <script>if(window.top !== window.self){ window.top.location = window.location;}</script> -->
</head>

<body  class="gray-bg">
<div id="formbackground" style="position:absolute; width:100%; height:100%; z-index:-1">  
<img src="static/img/bg_mi2.jpg" height="100%" width="100%"/>  
</div>
    <div  class="middle-box text-center loginscreen  animated fadeInDown">
        <div class="ibox">
        <div class="ibox-content2">
            <div >

                <h3 class="logo-name-sm">东南电梯</h3>

            </div>
            <h2>客户关系管理系统</h2>

            <form class="m-t" role="form"  action="" method="post" name="loginForm" id="loginForm" onkeydown="enter();" >
                <div class="form-group">
                    <input type="text"  class="form-control" placeholder="用户名" required="" name="loginname" id="loginname" value="">
                </div>
                <div class="form-group">
                    <input type="password" class="form-control" placeholder="密码" required="" name="password" id="password" value="">
                </div>

                <%--<div class="form-group text-left">--%>
                        <%--<input type="text"  placeholder="验证码" required="" name="code" id="code" style="width:60%;height:34px; border: 1px solid #e5e6e7; padding: 6px 12px; font-size: 14px;">--%>
                        <%--<i><img style= "width:38%;height:34px;" id="codeImg" alt="点击更换" title="点击更换" src="" /></i>--%>

                <%--</div>--%>
                <%--<div class="form-group text-left">--%>
                    <%--<div class="checkbox i-checks">--%>
                        <%--<label class="no-padding">--%>
                            <%--<input type="checkbox" id="saveid" onclick="savePaw();"><i></i> 记住密码--%>
                       <%--</label>--%>
                    <%--</div>--%>
                <%--</div>--%>
                 <div class="form-group text-left">
                       <a class="btn btn-primary" onclick="severCheck();"style="width:80%;height:34px; border: 1px solid #e5e6e7; padding: 6px 12px; font-size: 14px;">登 录</a>
                      <a class="btn btn-danger" style="width:18%;height:34px;" onclick="quxiao();">清除</a>

                </div>

                </p>

            </form>
            </div>
        </div>
    </div>

    <!-- 全局js -->
    <!-- <script src="static/js/jquery.min.js"></script> -->
    <script src="static/js/jquery-1.12.4.min.js"></script>
    <script src="static/js/bootstrap.min.js"></script>
    <!-- 自定义js -->
    <script src="static/js/content.js"></script>
    <!-- iCheck -->
    <script src="static/js/iCheck/icheck.min.js"></script>
    <!-- cookie -->
    <script type="text/javascript" src="static/js/jquery.cookie.js"></script>
    <script type="text/javascript" src="static/js/layer/layer.min.js"></script>

    <script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script type="text/javascript">
	        $(document).ready(function () {
	            $('.i-checks').iCheck({
	                checkboxClass: 'icheckbox_square-green',
	                radioClass: 'iradio_square-green',
	            });
	            
	            
	                var userAgent = navigator.userAgent; //取得浏览器的userAgent字符串  
	                console.log(userAgent);
	                var isIE = userAgent.indexOf("compatible") > -1 && userAgent.indexOf("MSIE") > -1; //判断是否IE<11浏览器  
	                var isChrome = userAgent.indexOf("Chrome") > -1; 
	                var isEdge = userAgent.indexOf("Edge") > -1 && !isIE; //判断是否IE的Edge浏览器  
	                var isIE11 = userAgent.indexOf('Trident') > -1 && userAgent.indexOf("rv:11.0") > -1;
	                if (!isChrome&&!isIE) {
	                	alert("请使用Chrome浏览器或者内核为IE9以上浏览器以便正常使用系统");
					}
	                if(isIE) {
	                    var reIE = new RegExp("MSIE (\\d+\\.\\d+);");
	                    reIE.test(userAgent);
	                    var fIEVersion = parseFloat(RegExp["$1"]);
	                    if(fIEVersion == 7) {
	                    	alert("请使用Chrome浏览器或者内核为IE9以上浏览器以便正常使用系统");
	                        return 7;
	                    } else if(fIEVersion == 8) {
	                    	alert("请使用Chrome浏览器或者内核为IE9以上浏览器以便正常使用系统");
	                        return 8;
	                    } else if(fIEVersion == 9) {
	                    	
	                        return 9;
	                    } else if(fIEVersion == 10) {
	                    	
	                        return 10;
	                    } else {
	                    	alert("请使用Chrome浏览器或者内核为IE9以上浏览器以便正常使用系统");
	                        return 6;//IE版本<=7
	                    }   
	                } else if(isEdge) {
	                	
	                    return 'edge';//edge
	                } else if(isIE11) {
	                	
	                    return 11; //IE11  
	                }else{
	                	
	                    return -1;//不是ie浏览器
	                }
	            

	            
	            
	            
	            
	            
	            
	        });
			//服务器校验
			function severCheck(){
				if(check()){

					var loginname = $("#loginname").val();
					var password = $("#password").val();
					var code = "qq313596790DNCRM"+loginname+",DNCRM,"+password+"QQ978336446DNCRM"+",DNCRM,"+$("#code").val();
                    //loading start
                    var loading = layer.load(1);
                    $.ajax({
                        type: "POST",
                        url: 'login_login',
                        data: {KEYDATA:code,tm:new Date().getTime()},
                        dataType:'json',
                        cache: false,
                        success: function(data){
                            //loading end
                            layer.closeAll('loading');
                            if("success" == data.result){
                                saveCookie();
                                window.location.href="main/index";
                            }else if("usererror" == data.result){
                                $("#loginname").tips({
                                    side : 1,
                                    msg : "用户名或密码有误",
                                    bg : '#FF5080',
                                    time : 2
                                });

                                $("#loginname").focus();

                            }else if("codeerror" == data.result){
                                $("#code").tips({
                                    side : 1,
                                    msg : "验证码输入有误",
                                    bg : '#FF5080',
                                    time : 2
                                });
                                $("#code").focus();
                            }else if("statuserror" == data.result){
                                $("#loginname").tips({
                                    side : 1,
                                    msg : "该账户未启用",
                                    bg : '#FF5080',
                                    time : 2
                                });

                                $("#loginname").focus();
                            }else{
                                $("#loginname").tips({
                                    side : 1,
                                    msg : "缺少参数",
                                    bg : '#FF5080',
                                    time : 2
                                });
                                $("#loginname").focus();
                            }
                        }
                    });
				}
			}

			$(document).ready(function() {
//				changeCode();
//				$("#codeImg").bind("click", changeCode);
			});

			$(document).keyup(function(event) {
				if (event.keyCode == 13) {
					$("#to-recover").trigger("click");
				}
			});

			function genTimestamp() {
				var time = new Date();
				return time.getTime();
			}

			function changeCode() {
				$("#codeImg").attr("src", "code.do?t=" + genTimestamp());
			}

			//客户端校验
			function check() {
				if ($("#loginname").val() == "") {

					$("#loginname").tips({
						side : 2,
						msg : '用户名不得为空',
						bg : '#AE81FF',
						time : 2
					});

					$("#loginname").focus();
					return false;
				} else {
					$("#loginname").val(jQuery.trim($('#loginname').val()));
				}

				if ($("#password").val() == "") {

					$("#password").tips({
						side : 2,
						msg : '密码不得为空',
						bg : '#AE81FF',
						time : 2
					});

					$("#password").focus();
					return false;
				}
				if ($("#code").val() == "") {

					$("#code").tips({
						side : 1,
						msg : '验证码不得为空',
						bg : '#AE81FF',
						time : 2
					});

					$("#code").focus();
					return false;
				}

				return true;
			}

			function savePaw() {
				if (!$("#saveid").attr("checked")) {
					$.cookie('loginname', '', {
						expires : -1
					});
					$.cookie('password', '', {
						expires : -1
					});
					$("#loginname").val('');
					$("#password").val('');
				}
			}

			function saveCookie() {
				if ($("#saveid").attr("checked")) {
					$.cookie('loginname', $("#loginname").val(), {
						expires : 7
					});
					$.cookie('password', $("#password").val(), {
						expires : 7
					});
				}
			}
			function quxiao() {
				$("#loginname").val('');
				$("#password").val('');
			}

			jQuery(function() {
				var loginname = $.cookie('loginname');
				var password = $.cookie('password');
				if (typeof(loginname) != "undefined"
						&& typeof(password) != "undefined") {
					$("#loginname").val(loginname);
					$("#password").val(password);
					$("#saveid").attr("checked", true);
					$("#code").focus();
				}
			});
            //回车事件
            function enter () {
                var e=window.event||arguments.callee.caller.arguments[0];
                if(e.keyCode==13){
                    severCheck();
                }
            }
		</script>
		<script>
			//TOCMAT重启之后 点击左侧列表跳转登录首页 
			if (window != top) {
				top.location.href = location.href;
			}
		</script>
</body>

</html>
