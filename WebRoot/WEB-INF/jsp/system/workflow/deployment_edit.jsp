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
	<%@ include file="../../system/admin/top.jsp"%> 
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pd.SYSNAME}</title>
</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content">
        <div class="row">
        <div class="panel blank-panel">
                    <div class="panel-heading">
                        <div class="panel-options">
                        	<ul class="nav nav-tabs">
                                <li class="active" >
                                <a data-toggle="tab" href="#tab-1" onclick="tabChange('1')">
	                                <i class="fa fa-cog"></i>
	                                通过上传zip文件部署
                                </a>
                                </li>
                                <li>
                                <a data-toggle="tab" href="#tab-2" onclick="tabChange('2')">
	                                <i class="fa fa-cog"></i>
	                                通过填写文件路径部署
                                </a>
                                </li>
                        	 </ul>    
                        </div>
                    </div>
					<div class="panel-body">
                    	<div class="tab-content">
                    	<!-- 通过上传zip文件部署 -->
                            <div id="tab-1" class="tab-pane active">
                           	 <form action="workflow/deployWorkFlowWithZip.do" name="workflowForm1" id="workflowForm1" method="post" enctype="multipart/form-data">
					                <div class="ibox float-e-margins">
						                <div class="ibox float-e-margins">
						                    <div class="ibox-content">
						                        <div class="row">
						                            <div class="col-lg-12">
						                                    <div class="form-group">
						                                      	<label>流程名称:</label>
						                                        <input  type="text" name="delployName" id="delployName"   maxlength="100" placeholder="这里输入流程名称" title="流程名称" class="form-control">
						                                    </div>
						                                    <div class="form-group">
						                                    	<label>流程文件(只能上传zip格式文件):</label>
						                                        <input class="form-control" type="file" name="delployFile" id="delployFile"   placeholder="请选择流程文件 title="流程文件" />
						                                    </div>
						                            </div>
						                        </div>
						                    </div>
												<div style="height: 20px;"></div>
												<tr>
												<td><button type="button" class="btn btn-primary"style="width: 150px; height:34px;float:left;"  onclick="save_zip();">部署</button></td>
												<td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('deployWorkFlow');">取消</a></td>
												</tr>
										</div>
					                </div>
				                </form>
				            </div>
				            <!-- 通过填写文件路径部署 -->
				            <div id="tab-2" class="tab-pane">
				            <form action="workflow/deployWorkFlowWithPath.do" name="workflowForm2" id="workflowForm2" method="post" >
				                <div class="ibox float-e-margins">
					                <div class="ibox float-e-margins">
					                    <div class="ibox-content">
					                        <div class="row">
					                            <div class="col-lg-12">
					                                    <div class="form-group">
					                                      	<label>流程名称:</label>
					                                        <input  type="text" name="name" id="name"   maxlength="100" placeholder="这里输入流程名称" title="流程名称" class="form-control">
					                                    </div>
					                                    <div class="form-group">
					                                    	<label>bpmn文件路径(classpath下，如activiti/diagrams/helloworld.bpmn):</label>
					                                        <input  type="text" name="bpmnPath" id="bpmnPath"   maxlength="100" placeholder="这里输入bpmn文件路径" title="bpmn文件路径" class="form-control">
					                                    </div>
					                                    <div class="form-group">
					                                    	<label>png文件路径(classpath下，如activiti/diagrams/helloworld.png):</label>
					                                        <input  type="text" name="pngPath" id="pngPath"   maxlength="100" placeholder="这里输入png文件路径" title="png文件路径" class="form-control">
					                                    </div>
					                            </div>
					                        </div>
					                    </div>
											<div style="height: 20px;"></div>
											<tr>
											<td><button type="button" class="btn btn-primary"style="width: 150px; height:34px;float:left;"  onclick="save_path();">部署</button></td>
											<td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('deployWorkFlow');">取消</a></td>
											</tr>
									</div>
				                </div>
				                </form>
				            </div>
			           </div>
					</div>
				 </div>
        </div>
 </div>
 
 <script type="text/javascript">
	//保存 with zip
	function save_zip(){
		if($("#delployName").val()=="" && $("#delployName").val()==""){
			$("#delployName").tips({
				side:3,
	            msg:"请输入流程名称",
	            bg:'#AE81FF',
	            time:2
	        });
			$("#delployName").focus();
			return false;
		}
	
		if($("#delployFile").val()=="" && $("#delployFile").val()==""){
			$("#delployFile").tips({
				side:3,
	            msg:"请选择zip格式的流程文件",
	            bg:'#AE81FF',
	            time:2
	        });
			$("#delployFile").focus();
			return false;
		}
		$("#workflowForm1").submit();
		
	};
	//保存 with path
	function save_path(){
		if($("#name").val()=="" && $("#name").val()==""){
			$("#name").tips({
				side:3,
	            msg:"请输入流程名称",
	            bg:'#AE81FF',
	            time:2
	        });
			$("#name").focus();
			return false;
		}
	
		if($("#bpmnPath").val()=="" && $("#bpmnPath").val()==""){
			$("#bpmnPath").tips({
				side:3,
	            msg:"请输入bpmn文件路径",
	            bg:'#AE81FF',
	            time:2
	        });
			$("#bpmnPath").focus();
			return false;
		}
		if($("#pngPath").val()=="" && $("#pngPath").val()==""){
			$("#pngPath").tips({
				side:3,
	            msg:"请输入png文件路径",
	            bg:'#AE81FF',
	            time:2
	        });
			$("#pngPath").focus();
			return false;
		}
		$("#workflowForm2").submit();
	};
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
