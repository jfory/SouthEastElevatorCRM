﻿<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
	<base href="<%=basePath%>">
	<%@ include file="top.jsp"%>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="renderer" content="webkit">
    <title>${pd.SYSNAME}</title>
    
    <!-- 图片插件 -->
    <link href="static/js/fancybox/jquery.fancybox.css" rel="stylesheet">
    <!-- Check Box -->
	<link href="static/js/iCheck/custom.css" rel="stylesheet">
	<!-- Sweet Alert -->
	<link href="static/js/sweetalert/sweetalert.css" rel="stylesheet">
</head>
<body class="fixed-sidebar full-height-layout gray-bg" style="overflow:hidden;margin-top: -18px;">
    <div id="wrapper">
		<div id="EditUsers" class="animated fadeIn"></div>
		<div id="EditSys" class="animated fadeIn"></div>
		<div id="EditUserProfile" class="animated fadeIn"></div>
        <!--左侧导航开始-->
        <nav class="navbar-default navbar-static-side" role="navigation">
            <div class="nav-close"><i class="fa fa-times-circle"></i></div>
            <div class="sidebar-collapse">
                <ul class="nav" id="side-menu">
                    <li class="nav-header">
                        <div class="dropdown profile-element">
                            <span>
	                            <c:choose>
									<c:when test="${not empty pd.AVATAR}">
	                                <a  class="fancybox" href="<%=basePath%>${pd.AVATAR}" >
									<img alt="image" class="img-circle" style="width:60px;height:60px;" src="<%=basePath%>${pd.AVATAR}" />
									</a>
									</c:when>
									<c:otherwise>
									<a class="fancybox" href="static/img/profile_small.jpg">
									<img alt="image" class="img-circle" style="width:60px;height:60px;" src="static/img/profile_small.jpg" />
									</a>
									</c:otherwise>
								</c:choose>
                                </span>
                            <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                                <span class="clear">
                               <span class="block m-t-xs"><strong style="color: #FFB94F" class="font-bold">${pd.USERNAME}&nbsp;</strong><strong class="font-bold">${pd.NAME}</strong></span>
                                <span class="text-muted text-xs block">${pd.deptname}<b class="caret"></b></span>
                                </span>
                            </a>
                            <ul class="dropdown-menu animated fadeInRight m-t-xs">
                                <li><a class="J_menuItem" onclick="editUserInfo();">修改资料</a>
                                </li>
                                <li><a class="J_menuItem" onclick="editUserProfile();">修改头像</a>
                                </li>
                                <li class="divider"></li>
                                <li><a href="logout">安全退出</a>
                                </li>
                            </ul>
                        </div>
                        <div class="logo-element">DNCRM
                        </div>
                    </li>
                    <c:forEach items="${menuList}" var="menu">
						<c:if test="${menu.hasMenu}">
						<li id="lm${menu.MENU_ID }">
						<a href="#">
                            <i class="${menu.MENU_ICON == null ? 'fa fa-desktop' : menu.MENU_ICON}"></i>
                            <span class="nav-label">${menu.MENU_NAME }</span>
                            <span class="fa arrow"></span>
                        </a>
                        <ul class="nav nav-second-level">
                        <c:forEach items="${menu.subMenu}" var="sub">
							<c:if test="${sub.hasMenu}">
							<c:choose>
								<c:when test="${not empty sub.MENU_URL}">
								<li id="z${sub.MENU_ID }">
								<a class="J_menuItem" href="${sub.MENU_URL }">${sub.MENU_NAME }</a>
								</li>
								</c:when>
								<c:otherwise>
								<li><a href="javascript:void(0);"><i class="icon-double-angle-right"></i>${sub.MENU_NAME }</a>
								</li>
								</c:otherwise>
							</c:choose>
							</c:if>
						</c:forEach>
						</ul>
						</li>
						</c:if>
					</c:forEach>
					<%-- <!-- webim -->
						<li id="lmwebim">
							<a href="#">
	                            <i class="fa fa-commenting-o"></i>
	                            <span class="nav-label">即时通讯</span>
	                            <span class="fa arrow"></span>
	                        </a>
	                        <ul class="nav nav-second-level">
	                       
									<li id="zwebim">
									<a class="J_menuItem" href="<%=basePath%>static/web-im/index.jsp">环信</a>
									<a class="J_menuItem" href="<%=basePath%>head/goWebIM.do">环信</a>
									</li>
									<li id="zlayim">
									<a class="J_menuItem" href="<%=basePath%>head/goLayIM.do">layim</a> 
									</li>
							</ul>
							</li> --%>
                </ul>
            </div>
        </nav>
        <!--左侧导航结束-->
        <!--右侧部分开始-->
        <div id="page-wrapper" class="gray-bg dashbard-1">
            <div class="row border-bottom">
                <nav class="navbar navbar-static-top" role="navigation" style="margin-bottom: 0">
                    <div class="navbar-header" style="width: 97%"><a class="navbar-minimalize minimalize-styl-2 btn-sm btn-primary " ><i class="fa fa-bars"></i> </a>
                    </div>

                    <!-- 消息提醒 -->
                    <!-- 站内信部分 -->
                    <div class="btn-group roll-nav" style="margin-top:7px">
                        <a class="dropdown-toggle count-info" data-toggle="dropdown" href="#">
                            <i class="fa fa-bell"></i> <span id="mes_count" class="label label-primary"></span>
                        </a>
                        <ul class="dropdown-menu dropdown-alerts pull-right">
                            <li>
                                <a href="message/mailView.do" class="J_menuItem">
                                    <div>
                                        <i class="fa fa-envelope fa-fw"></i> 您有<span id="mes_recv_count"></span>条未读消息
                                    </div>
                                </a>
                            </li>
                            <li class="divider"></li>
                            <li>
                                <div class="text-center link-block">
                                    <a class="J_menuItem" href="<%=basePath%>message/mailView.do">
                                        <strong>查看所有 </strong>
                                        <i class="fa fa-angle-right"></i>
                                    </a>
                                </div>
                            </li>
                        </ul>
                    </div>
                    <!-- 站内信结束 -->
                </nav>
            </div>
            <div class="row content-tabs">
                <button class="roll-nav roll-left J_tabLeft"><i class="fa fa-backward"></i>
                </button>
                <nav class="page-tabs J_menuTabs">
                    <div class="page-tabs-content">
                        <a href="javascript:;" class="active J_menuTab" data-id="head/goDefault.do">首页</a>
                    </div>
                </nav>
                <button class="roll-nav roll-right J_tabRight"><i class="fa fa-forward"></i>
                </button>
                <div class="btn-group roll-nav roll-right">
                    <button class="dropdown J_tabClose" data-toggle="dropdown">关闭操作<span class="caret"></span>
                    </button>
                    <ul role="menu" class="dropdown-menu dropdown-menu-right">
                        <li class="J_tabShowActive"><a>定位当前选项卡</a>
                        </li>
                        <li class="divider"></li>
                        <li class="J_tabCloseAll"><a>关闭全部选项卡</a>
                        </li>
                        <li class="J_tabCloseOther"><a>关闭其他选项卡</a>
                        </li>
                    </ul>
                </div>
                <a href="javascript:Exit();" class="roll-nav roll-right J_tabExit"><i class="fa fa fa-sign-out"></i> 退出</a>
            </div>
            <div class="row J_mainContent" id="content-main">
                <iframe class="J_iframe" id="iframe0" name="iframe0" src="head/goDefault.do" width="100%" height="100%" href="#" frameborder="0" data-id="head/goDefault.do" seamless></iframe>
            </div>
        </div>
        <!--右侧部分结束-->
         <div>
         </div>
    </div>
	<!-- iCheck -->
	<script src="static/js/iCheck/icheck.min.js"></script>
	<!-- Sweet alert -->
	<script src="static/js/sweetalert/sweetalert.min.js"></script>
    
    <!-- Fancy box -->
    <script src="static/js/fancybox/jquery.fancybox.js"></script>
    
	<script type="text/javascript">
	 $(document).ready(function () {
     	/* 图片 */
         $('.fancybox').fancybox({
             openEffect: 'none',
             closeEffect: 'none'
         });
         $("#loading").hide();

         /* 加载页面时刷新一次站内信部分 */
         refreshMail();
     });

     function refreshMail(){
        /*$.post("<%=basePath%>message/recvMesCount.do",
                function(data){
                    $("#mes_count").text(data.Count);
                    $("#mes_recv_count").text(data.Count);
                }
        );*/
        $.post("<%=basePath%>message/refreshMail.do",
                function(data){
                    $("#mes_count").html(data.count);
                    $("#mes_recv_count").html(data.count);
                }
        );
     }

    //定时刷新站内信消息
    //setInterval("refreshMail()",12000);
	var locat = (window.location+'').split('/'); 
	$(function(){
		if('main'== locat[3]){
			locat =  locat[0]+'//'+locat[2];
			}else{
				locat =  locat[0]+'//'+locat[2]+'/'+locat[3];
				};
		});
	var USER_ID;
     var ROLE_ID;

	$(function(){
		$.ajax({
			type: "POST",
			url: locat+'/head/getUname.do?tm='+new Date().getTime(),
	    	data: encodeURI(""),
			dataType:'json',
			cache: false,
			success: function(data){
				 $.each(data.list, function(i, list){
					 
					/*  //登陆者资料
					 $("#user_info").html('<small>Welcome</small> '+list.NAME+'');
					 
					  */
					 USER_ID = list.USER_ID;//用户ID
                     ROLE_ID = list.ROLE_ID;//角色ID
					/*  hf(list.SKIN);//皮肤 */
					 
					/*  if(list.USERNAME != 'admin'){
						 $("#adminmenu").hide();	//隐藏菜单设置
						 $("#adminzidian").hide();	//隐藏数据字典
						 $("#systemset").hide();	//隐藏系统设置
						 $("#productCode").hide();	//隐藏代码生成
					 } */
					 
				 });
			}
		});
	});
	//修改个人资料
	function editUserInfo(){
        //系统管理员
	    if(ROLE_ID=='1'){
            $("#EditUsers").kendoWindow({
                width: "500px",
                height: "600px",
                title: "修改资料",
                actions: ["Close"],
                content: locat+'/sysUser/goEditU.do?USER_ID='+USER_ID+'&fx=head',
                modal : true,
                visible : false,
                resizable : true
            }).data("kendoWindow").center().open();
        }else{
            $("#EditUsers").kendoWindow({
                width: "500px",
                height: "470px",
                title: "修改资料",
                actions: ["Close"],
                content: locat+'/sysUser/goEditMyInfo.do?USER_ID='+USER_ID,
                modal : true,
                visible : false,
                resizable : true
            }).data("kendoWindow").center().open();
        }

	}
	//修改用户头像
	function editUserProfile(){
		$("#EditUserProfile").kendoWindow({
	        width: "800px",
	        height: "500px",
	        title: "修改用户头像",
	        actions: ["Close"],
	        content: locat+'/sysUser/goEditUserProfile.do?USER_ID='+USER_ID+'&fx=head',
	        modal : true,
			visible : false,
			resizable : true
	    }).data("kendoWindow").center().open();
	}

	
	//删除
    function Exit() {
        swal({
            title: "退出",
            text: "您确定要退出系统吗？",
            type: "warning",
            showCancelButton: true,
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "确定",
            cancelButtonText: "取消",
            closeOnConfirm: false,
            closeOnCancel: false
        },
        function (isConfirm) {
            if (isConfirm) 
            {
            	window.location.href="logout"; 
                
            } else {
                swal("已取消", "您取消了退出操作！", "error");
            }
        });
        
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
	</script>
</body>
</html>
