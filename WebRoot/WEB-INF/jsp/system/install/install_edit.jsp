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


    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title>${pd.SYSNAME}</title>
	<!-- jsp文件头和头部 -->
	<%@ include file="../../system/admin/top.jsp"%> 
	<!-- 日期控件-->
    <script src="static/js/layer/laydate/laydate.js"></script>
	<script type="text/javascript">
	

	$(document).ready(function () {
		//loading end
		parent.layer.closeAll('loading');
     	
		showDiv();
     });

	//保存
	function save(){
		$("#installForm").submit();
	}

	function CloseSUWin(id) {
		window.parent.$("#" + id).data("kendoWindow").close();
		/* 	window.parent.location.reload(); */
	}

	//显示授权
	function showDiv(){
		var type = $("#buyout").val();
		if(type=="1"){//买断项目,上传授权申请
			$("#authorizeDiv").show();
			$("#contractorDiv").hide();
		}else if(type=="0"){
			$("#contractorDiv").show();
			$("#authorizeDiv").hide();
		}else{
			$("#authorizeDiv").hide();
			$("#contractorDiv").hide();
		}
	}
	


	//上传下载部分
	function upload(e,v){
        var filePath = $(e).val(); 
        var arr = filePath.split("\\"); 
        var fileName = arr[arr.length-1];
        var suffix = filePath.substring(filePath.lastIndexOf(".")).toLowerCase();
        /*var fileType = ".xls|.xlsx|.doc|.docx|.txt|.pdf|"; */
        if(filePath == null || filePath == ""){
            $(v).val("");
            return false;
        }
        /*if(fileType.indexOf(suffix+"|")==-1){
            var ErrMsg = "该文件类型不允许上传。请上传 "+fileType+" 类型的文件，当前文件类型为"+suffix; 
            $(e).val("");
            alert(ErrMsg);
            return false;
        }*/
        
        var data = new FormData();
        
        data.append("file", $(e)[0].files[0]);
        
        $.ajax({
            url:"install/upload.do",
            type:"POST",
            data:data,
            cache: false,
            processData:false,
            contentType:false,
            success:function(result){
                if(result.success){
                    $(v).val(result.filePath);
                }else{
                    alert(result.errorMsg);
                }
            }
        });
    }
    // 下载文件   e代表当前路径值 
    function downFile(e){
        var downFile = $(e).val();
        window.location.href="install/down?downFile="+downFile;
    }
	</script>
</head>

<body class="gray-bg">
<form action="install/${msg}.do" name="installForm" id="installForm" method="post">
<input type="hidden" name="id" id="id" value="${pd.id}"/>
<input type="hidden" name="operateType" id="operateType" value="${operateType}"/>
    <div class="wrapper wrapper-content">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="row">
            			<div class="col-sm-12">
                			<div class="panel panel-primary">
                                <div class="panel-heading">
                                    项目信息
                                </div>
                    			<div class="panel-body">
                        			<div class="form-group form-inline">
                        				<label><font color="red">*</font>选择项目:</label>
                        				<select name="item_id" id="item_id" class="form-control m-b">
                        					<option value="">请选择项目</option>
                        					<c:forEach items="${itemList}" var="var">
                        						<option value="${var.item_id}" ${var.item_id==pd.item_id?"selected":""}>${var.item_name}</option>
                        					</c:forEach>
                        				</select>
                        			</div>
                        		</div>
                        	</div>
                        </div>
                     </div>
                     <div class="row">
						<div class="col-sm-12">
							<div class="panel panel-primary">
					            <div class="panel-heading">
					                土建勘测
					            </div>
								<div class="panel-body">
					    			<div class="form-group form-inline">
					    				<label>土建勘测报告(曳引):</label>
					    				<input class="form-control" type="file"  title="土建勘测报告(曳引)" onchange="upload(this,$('#tow'))" />
			                            <input class="form-control" type="hidden" name="tow" id="tow"  value="${pd.tow}" title="土建勘测报告(曳引)"  />
			                            <c:if test="${pd ne null and pd.tow ne null and pd.tow ne '' }">
		        							<a class="btn btn-mini btn-success" onclick="downFile($('#tow'))">下载附件</a>
		    							</c:if>
					    				<label>土建勘测报告(液压):</label>
										<input class="form-control" type="file"  title="土建勘测报告(液压)" onchange="upload(this,$('#hyd'))" />
			                            <input class="form-control" type="hidden" name="hyd" id="hyd"  value="${pd.hyd}" title="土建勘测报告(液压)"  />
			                            <c:if test="${pd ne null and pd.hyd ne null and pd.hyd ne '' }">
		        							<a class="btn btn-mini btn-success" onclick="downFile($('#hyd'))">下载附件</a>
		    							</c:if>
					    			</div>
					    		</div>
					    	</div>
					    </div>
					</div>
					<div class="row">
						<div class="col-sm-12">
							<div class="panel panel-primary">
					            <div class="panel-heading">
					                安装信息
					            </div>
								<div class="panel-body">
					    			<div class="form-group form-inline">
					    				<label><font color="red">*</font>项目类型:</label>
					    				<select id="buyout" name="buyout" class="form-control m-b" onchange="showDiv();">
					    					<option value="">是否为买断项目</option>
					    					<option value="1" ${pd.buyout=="1"?"selected":""}>是</option>
					    					<option value="0" ${pd.buyout=="0"?"selected":""}>否</option>
					    				</select>
					    			</div>
					    			<div class="form-group form-inline" id="authorizeDiv" style="display:none">
					    				<label>授权申请表:</label>
					    				<input class="form-control" type="file"  title="授权申请表" onchange="upload(this,$('#authorize'))" />
			                            <input class="form-control" type="hidden" name="authorize" id="authorize"  value="${pd.authorize}" title="授权申请表"  />
			                            <c:if test="${pd ne null and pd.authorize ne null and pd.authorize ne '' }">
		        							<a class="btn btn-mini btn-success" onclick="downFile($('#authorize'))">下载附件</a>
		    							</c:if>
					    			</div>
					    			<div class="form-group form-inline" id="contractorDiv" style="display:none">
					    				<label>分包商:</label>
					    				<select id="contractor_id" name="contractor_id" class="form-control m-b">
					    					<option value="">请选择分包商</option>
					    					<c:forEach items="${agentList}" var="var">
					    						<option value="${var.agent_id}" ${var.agent_id==pd.contractor_id?"selected":""}>${var.agent_name}</option>
					    					</c:forEach>
					    				</select>
					    			</div>
					    		</div>
					    	</div>
					    </div>
					</div>
                    <tr>
					<td><a class="btn btn-primary" style="width: 150px; height:34px;float:left;"  onclick="save();">保存</a></td>
					<td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('EditInstall');">关闭</a></td>
					</tr>
				</div>
            </div>
            
        </div>
 </div>
 </form>
</body>

</html>
