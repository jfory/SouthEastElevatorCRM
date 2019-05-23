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
        <div id="viewDiagram" class="animated fadeIn"></div>
        <div id="viewHistory" class="animated fadeIn"></div>
	        <div class="row">
	            <div class="col-sm-12">
	                <div class="ibox float-e-margins">
	                    <div class="ibox-content">
	                    <div id="top" name="top"></div>
	                        <form role="form" class="form-inline" action="workflow/listProcessInstance.do" method="post" name="workflowForm" id="workflowForm">
	                           <%--  <div class="form-group ">
	                                <input autocomplete="off" id="nav-search-input" type="text" name="name" value="${pd.name }" placeholder="这里输入流程定义名称"  class="form-control">
	                            </div>
	                            <div class="form-group ">
	                                <input autocomplete="off" id="nav-search-input" type="text" name="key" value="${pd.key }" placeholder="这里输入流程定义key"  class="form-control">
	                            </div>
	                            <div class="form-group">
	                                 <button type="submit" class="btn  btn-primary " style="margin-bottom:0px;" title ="搜索"><i style="font-size:18px;" class="fa fa-search"></i></button>
	                            </div> --%>
	                            <button class="btn  btn-success" title="刷新" type="button" style="float:right" onclick="refreshCurrentTab();">刷新</button>
	                        	
	                        </form>
	                            <div class="row">
	                            </br>
	                             </div>
	                        <div class="table-responsive" style="1500px">
	                            <table class="table table-striped table-bordered table-hover">
	                                <thead>
	                                    <tr>
	                                        <th style="width:5%;">序号</th>
	                                        <th style="width:10%;">ID</th>
	                                        <th style="width:10%;">流程实例定义的KEY</th>
	                                        <th style="width:10%;">流程实例Business KEY</th>
	                                        <th style="width:10%;">流程实例部署ID</th>
	                                        <th style="width:10%;">流程实例ID</th>
	                                        <th style="width:10%;">当前活动ID</th>
	                                        <th style="width:10%;">操作</th>
	                                    </tr>
	                                </thead>
	                                <tbody>
	                               <!-- 开始循环 -->	
									<c:choose>
										<c:when test="${not empty processInstances}">
											<c:if test="${QX.cha == 1 }">
											<c:forEach items="${processInstances}" var="processInstance" varStatus="vs">
														
												<tr>
													<td class='center' style="width: 30px;">${vs.index+1}</td>
													<td>${processInstance.id }</td>
													<td>${processInstance.processDefinitionKey }</td>
													<td>${processInstance.businessKey }</td>
													<td>${processInstance.deploymentId }</td>
													<td>${processInstance.processInstanceId }</td>
													<td>${processInstance.activityId }</td>
													<td>
														<c:if test="${QX.edit != 1 && QX.del != 1 }">
															<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="icon-lock" title="无权限">无权限</i></span>
														</c:if>
														<div>
															<c:if test="${QX.cha == 1 }">
																<button class="btn  btn-primary btn-sm" title="查看" type="button" onclick="viewDiagram('${processInstance.id}');">查看</button>
																<button class="btn  btn-info btn-sm" title="查看记录" type="button" onclick="viewHistory('${processInstance.id}');">历史记录</button>
															</c:if>
														</div>
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
	                        </br>
	                        <div class="col-lg-12" style="padding-left:0px;padding-right:0px;margin:10px -10px 10px -10px">
										${page.pageStrForActiviti}
								</div>
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
	    <!--返回顶部开始-->
        <div id="back-to-top">
            <a class="btn btn-warning btn-back-to-top" href="javascript: setWindowScrollTop (this,document.getElementById('top').offsetTop);">
            <a class="btn btn-warning btn-back-to-top" href="javascript: javascript:setScrollTop (0);">
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
    	<!-- Fancy box -->
    <script src="static/js/fancybox/jquery.fancybox.js"></script>
    
	<script type="text/javascript">
	 $(document).ready(function () {
		 //loading end
		 parent.layer.closeAll('loading');
     	/* 图片 */
         $('.fancybox').fancybox({
             openEffect: 'none',
             closeEffect: 'none'
         });
         $("#loading").hide();
     });
    
    	//刷新iframe
        function refreshCurrentTab() {
        	$("#workflowForm").submit();
        }
		//检索
		function search(){
			$("#workflowForm").submit();
		}

         //查看流程定义图片
         function viewDiagram(processInstanceId){
             $("#viewDiagram").kendoWindow({
                 width: "1000px",
                 height: "600px",
                 title: "查看流程图",
                 actions: ["Close"],
                 content: '<%=basePath%>workflow/goViewDiagramWithPid?pid='+processInstanceId+'&type=image',
                 modal : true,
                 visible : false,
                 resizable : true
             }).data("kendoWindow").center().open();
         }
         //查看历史
         function viewHistory(processInstanceId){
             $("#viewHistory").kendoWindow({
                 width: "900px",
                 height: "600px",
                 title: "查看历史记录",
                 actions: ["Close"],
                 content: '<%=basePath%>workflow/goViewHistory?pid='+processInstanceId,
                 modal : true,
                 visible : false,
                 resizable : true
             }).data("kendoWindow").center().open();
         }
		/* back to top */
		function setWindowScrollTop(win, topHeight){
			console.log("win->"+win);
			console.log("topHeight-->"+topHeight);
			if(win.document.documentElement){
				console.log("win->1111");
				win.parent.document.documentElement.scrollTop = topHeight;
			}
			if(win.document.body){
				console.log("win->222");
				win.parent.document.body.scrollTop = topHeight;
		    }
		}

	 top.window.onscroll =  function()

	 {

		 var windowHeight = getWindowHeight(self)-150;



		 var lvTop=parseInt(getWindowHeight(top))+parseInt(getWindowScrollTop(top))-250;

		 lvTop = lvTop<=0?1:lvTop;

		 lvTop = lvTop>windowHeight?windowHeight:lvTop;



		 document.getElementById("top").style.top=lvTop+"px";

		 document.getElementById("top").style.left="245px";

	 }
	 function getWindowScrollTop(win){

		 var scrollTop=0;

		 if(win.document.documentElement&&win.document.documentElement.scrollTop){

			 scrollTop=win.document.documentElement.scrollTop;

		 }else if(win.document.body){

			 scrollTop=win.document.body.scrollTop;

		 }

		 return scrollTop;

	 }
	 function getWindowHeight(win){

		 var clientHeight=0;

		 if(win.document.body.clientHeight&&win.document.documentElement.clientHeight){

			 clientHeight = (win.document.body.clientHeight<win.document.documentElement.clientHeight)?win.document.body.clientHeight:win.document.documentElement.clientHeight;

		 }else{

			 clientHeight = (win.document.body.clientHeight>win.document.documentElement.clientHeight)?win.document.body.clientHeight:win.document.documentElement.clientHeight;

		 }

		 return clientHeight;

	 }



	</script>
</body>
</html>


