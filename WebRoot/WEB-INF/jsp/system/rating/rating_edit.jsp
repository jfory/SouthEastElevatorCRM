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
    <link type="text/css" rel="stylesheet" href="plugins/zTree/3.5.24/css/zTreeStyle/zTreeStyle.css"/>
	<!-- jsp文件头和头部 -->
	<%@ include file="../../system/admin/top.jsp"%> 
	
</head>

<body class="gray-bg">
<form action="rating/${msg}.do" name="ratingForm" id="ratingForm" method="post">
	<input type="hidden" name="id" id="id" value="${pd.id}" />
    <div class="wrapper wrapper-content">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-content">
                        <div class="row">
                            <div class="col-sm-12">
                            
                               <div class="ibox float-e-margins" id="menuContent" class="menuContent" style="display:none; position: absolute;z-index: 99;border: solid 1px #18a689;max-height:300px;overflow-y:scroll;overflow-x:auto">
									<div class="ibox-content">
										<div>
											<!--  <input class="form-control" style="height: 30px" type="text" placeholder="搜索" id="keyWord" onkeyup="searchTreeNodesByKeyWord()">-->
											<ul id="myzTree" class="ztree" style="margin-top:0; width:160px;"></ul>
										</div>
									</div>
							  </div>
							  
                                    
                                    <div class="panel panel-primary">
                                    	<div class="panel-heading">
                                        	信用等级信息
                                    	</div>
                                    	<div class="panel-body">
                                        	<div class="form-group form-inline" style="width: 100%">
                                    			<label >等级:</label>
                                    			<input  type="text"  placeholder="这里输入信用等级"  id="rating" name="rating" value="${pd.rating }"  class="form-control">
                                    			<span style="color: red">*</span>
                                    			
                                    			
                                    		</div>
                                    		
                                    		 <div class="form-group">
                                        		<label>描述:</label>
                                        		<textarea class="form-control" rows="10" cols="20" name="description" id="description" placeholder="这里输入描述" maxlength="250" title="描述" >${pd.description}</textarea>
                                    		</div>
                                    		
                                    		
                                    	</div>
                                	</div>
                                    
                                    
                                    
	                                    
                                    
                                   
                                   
                            
                            </div>
                            
                        </div>
                        
                    </div>
						<div style="height: 20px;"></div>
						<tr>
						<td><a class="btn btn-primary"style="width: 150px; height:34px;float:left;"  onclick="save();">保存</a></td>
                        <c:if test="${msg eq 'add'}">
                            <td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('AddRating');">关闭</a></td>
                        </c:if>
                        <c:if test="${msg eq 'edit'}">
                            <td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('EditRating');">关闭</a></td>
                        </c:if>
						</tr>
					</div>
            </div>
            
        </div>
 </div>
 </form> 
 
</body>

 
 	<%--zTree--%>
<script type="text/javascript"
		src="plugins/zTree/3.5.24/js/jquery.ztree.all.js"></script>
	<script type="text/javascript">
	
	
	
	$(document).ready(function(){
		
	});
	
	
	
		//保存
		function save(){
			
			if($("#rating").val()==""){
				$("#rating").focus();
				$("#rating").tips({
					side:3,
		            msg:'信用等级不能为空',
		            bg:'#AE81FF',
		            time:2
		        });
				
				
				return false;
			}
			
			$("#ratingForm").submit();
		}
		
		
		function CloseSUWin(id) {
			window.parent.$("#" + id).data("kendoWindow").close();
		}
		
		//判断是否存在信用等级
		$("#rating").on("blur",function(){
			var rating = $(this).val();
			var id = $("#id").val();
			
			$.post("rating/existsRating.do",{rating:rating,id:id},function(result){
				if(result.success){
					
				}else{
					$("#rating").focus();
					$("#rating").tips({
						side:3,
			            msg:result.errorMsg,
			            bg:'#AE81FF',
			            time:2
			        });
					$("#rating").val("");
				}
			});
		});
		
		 
		
		
		
		
		
		
		
		
		
		
	
	</script>
</html>
