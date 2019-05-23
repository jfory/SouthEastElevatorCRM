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
	<!-- blueimp-gallery -->
	<link href="static/js/blueimp/css/blueimp-gallery.min.css" rel="stylesheet">
	<title>${pd.SYSNAME}</title>
</head>

<body class="gray-bg">
	<!-- blueimp-gallery -->
	<div id="blueimp-gallery" class="blueimp-gallery">
		<div class="slides"></div>
		<h3 class="title"></h3>
		<a class="prev">‹</a>
		<a class="next">›</a>
		<a class="close">×</a>
		<a class="play-pause"></a>
		<ol class="indicator"></ol>
	</div>
    <div class="wrapper wrapper-content animated fadeInRight">
        <div id="viewDiagram" class="animated fadeIn"></div>
        <div id="setWorkFlow" class="animated fadeIn"></div>
	        <div class="row">
	            <div class="col-sm-12">
	                <div class="ibox float-e-margins">
	                    <div class="ibox-content">
	                    <div id="top",name="top"></div>
	                        <form role="form" class="form-inline" action="workflow/listWorkFlows.do" method="post" name="workflowForm" id="workflowForm">
	                            <div class="form-group ">
	                                <input autocomplete="off" id="nav-search-input" type="text" name="name" value="${pd.name }" placeholder="这里输入流程定义名称"  class="form-control">
	                            </div>
	                            <div class="form-group ">
	                                <input autocomplete="off" id="nav-search-input" type="text" name="key" value="${pd.key }" placeholder="这里输入流程定义key"  class="form-control">
	                            </div>
	                            <div class="form-group">
	                                 <button type="submit" class="btn  btn-primary " style="margin-bottom:0px;" title ="搜索"><i style="font-size:18px;" class="fa fa-search"></i></button>
	                            </div>
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
	                                        <th style="width:10%;">名称</th>
	                                        <th style="width:5%;">版本</th>
	                                        <th style="width:10%;">部署ID</th>
	                                        <th style="width:10%;">流程定义的KEY</th>
	                                        <th style="width:10%;">流程图</th>
											<th style="width:10%;">操作</th>
	                                    </tr>
	                                </thead>
	                                <tbody>
	                               <!-- 开始循环 -->	
									<c:choose>
										<c:when test="${not empty processDefinitions}">
											<c:if test="${QX.cha == 1 }">
											<c:forEach items="${processDefinitions}" var="processDefinition" varStatus="vs">
														
												<tr>
													<td class='center' style="width: 30px;">${vs.index+1}</td>
													<td>${processDefinition.id }</td>
													<td>${processDefinition.name }</td>
													<td>${processDefinition.version }</td>
													<td>${processDefinition.deploymentId }</td>
													<td>${processDefinition.key }</td>
													<td ><a  data-gallery="" href="<%=basePath%>workflow/getProcessResourceWithDefID?pdid=${processDefinition.id}&type=image" title="流程图">
														<img style="width:150px;height:100px" src="<%=basePath%>workflow/getProcessResourceWithDefID?pdid=${processDefinition.id}&type=image" alt="流程图">
													</a>
													</td>
													<td>
														<c:if test="${QX.edit != 1 && QX.del != 1 }">
															<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="icon-lock" title="无权限">无权限</i></span>
														</c:if>
														<div>
															<c:if test="${QX.edit == 1 ||QX.add ==1}">
																<button class="btn  btn-warning btn-sm" title="设置" type="button" onclick="setWorkFlow('${processDefinition.id}');">设置</button>
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
	<!-- blueimp gallery -->
	<script src="static/js/blueimp/jquery.blueimp-gallery.min.js"></script>
    
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
		function viewDiagram(processDefinitionId){
			$("#viewDiagram").kendoWindow({
		        width: "1400px",
		        height: "600px",
		        title: "查看流程图",
		        actions: ["Close"],
		        content: '<%=basePath%>workflow/goViewDiagram?pdid='+processDefinitionId+'&type=image',
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").center().open();
		}
		 //设置流程
		 function setWorkFlow(processDefinitionId){
			 $("#setWorkFlow").kendoWindow({
				 width: "1000px",
				 height: "600px",
				 title: "设置流程",
				 actions: ["Close"],
				 content: '<%=basePath%>workflow/goWorkFlowSetUp?pdid='+processDefinitionId+'&type=image',
				 modal : true,
				 visible : false,
				 resizable : true
			 }).data("kendoWindow").center().open();
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


