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
	
</head>

<body class="gray-bg">
<form action="sysAgent/${msg}.do" name="agentForm" id="agentForm" method="post">
	<input type="hidden" name="autoid" id="autoid" value="${pd.autoid}" />
    <div class="wrapper wrapper-content">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-content">
                        <div class="row">
                            <div class="col-sm-12">
                            
                            
                                    <div class="panel panel-primary">
                                    <div class="panel-heading">
                                        	选项
                                    </div>
                                    <div class="panel-body">
                                        
                                        <div class="form-group form-inline">
	                                    	<label style="width:8%">启用标志:</label>
	                                        <select style="width:20%" class="form-control" disabled="disabled">
		                                        <option value="2"
													<c:if test="${pd.is_acvtivated == '2'}"> selected</c:if>>
													否
												</option>
												<option value="1"
													<c:if test="${pd.is_acvtivated == '1'}"> selected</c:if>>
													是
												</option>
												
											</select>
											
	                                    	
											<label style="width:8%">所属区域:</label>
											<select style="width:20%" class="form-control" disabled="disabled">
		                                        <option value="">${pd.area_name }</option>
											</select>
                                    		
	                                    	<label style="width:8%">所属公司:</label>
	                                        <select style="width:20%" class="form-control" disabled="disabled">
		                                        
												<option value="">${pd.company_name }</option>
												
											</select>
                                    	</div>
                                        
                                        <div class="form-group form-inline">
											
											<c:if test="${pd.agent_type == '1'}"> 
											<label style="width:8%">安装资质:</label>
											
											<select style="width:20%" disabled="disabled" class="form-control" >
	                                        
												<option value="1"
													<c:if test="${pd.is_constructor == '1'}"> selected</c:if>>
													是
												</option>
												<option value="1"
													<c:if test="${pd.is_constructor == '2'}"> selected</c:if>>
													否
												</option>
											</select>
	                                    </c:if>
	                                    
										<c:if test="${pd.is_constructor == '1'}"> 
											<label style="width:8%">代理资质:</label>
											<select style="width:20%" disabled="disabled" class="form-control" >
	                                        
												<option value="1"
													<c:if test="${pd.agent_type == '1'}"> selected</c:if>>
													是
												</option>
												<option value="1"
													<c:if test="${pd.agent_type == '2'}"> selected</c:if>>
													否
												</option>
											</select>
											
	                                    </c:if>
	                                    
                                    		<label style="width:8%">信用等级:</label>
                                    		<select style="width:20%" class="form-control" disabled="disabled">
										    		<c:forEach var="rating" items="${ratingList}" >
										    		<option value="${rating.id }" <c:if test="${pd.credit_ratings eq rating.id }">selected</c:if>  >${rating.rating }</option>
										    		</c:forEach>
											</select>
                                   		</div>
                                   		
                                   		
                                   		<div class="form-group form-inline">
                                   			<label style="width:8%">类型:</label>
                                    		<label style="width:20%">
		                                    	<c:if test="${pd.agent_type eq 1 }">代理商</c:if>
		                                    	<c:if test="${pd.agent_type eq 2 }">分包商</c:if>
                                    		</label>
                                    		<label style="width:8%">类别:</label>
                                    		<label style="width:20%">
	                                  		<!--类别:0,普通、1,核心、2,战略联盟、3,战略联盟二级、4,东南尚升二级 -->
												<c:if test="${pd.agent_category  eq 0}">
													普通
												</c:if>
												<c:if test="${pd.agent_category  eq 1}">
													核心
												</c:if>
												<c:if test="${pd.agent_category  eq 2}">
													战略联盟
												</c:if>
												<c:if test="${pd.agent_category  eq 3}">
													战略联盟二级
												</c:if>
												<c:if test="${pd.agent_category  eq 4}">
													东南尚升二级
												</c:if>
												<c:if test="${pd.agent_category  eq 5}">
													小业主代理商
												</c:if>
                                    		</label>
                                    		<label style="width:8%">地址:</label>
                                    		<label style="width:20%">
		                                    	${pd.address_name }
                                    		</label>
                                   		</div>
                                   		<div class="form-group form-inline">
                                   			<label style="width:8%">录入人:</label>
                                   			<label style="width:20%">
                                   				${pd.apply_user }
                                    		</label>
                                    		
                                    		<label style="width:8%">录入时间:</label>
                                   			<label style="width:20%">
                                   				${pd.create_time }
                                    		</label>
                                   		</div>
                                   </div>
                                </div>
                                
                                
                                   
                                <div class="panel panel-primary">
                                    	<div class="panel-heading">
                                        	信息
                                    	</div>
                                    	<div class="panel-body">
                                        	<div class="form-group form-inline" style="width: 100%">
                                    			<label style="width:6%" >编号:</label>
                                    			<input style="width:25%" type="text"  value="${pd.agent_no }" disabled="disabled"  class="form-control">
                                    			
                                    			<label style="width:6%" >名称:</label>
                                        		<input style="width:25%" type="text" disabled="disabled" value="${pd.agent_name }" class="form-control">     
                                    			
                                    			<label style="width:6%">联系人:</label>
                                   				<input style="width:25%" class="form-control"  type="text" disabled="disabled" value="${pd.agent_contact }"  />
                                    		</div>
                                    		
                                    		<div class="form-group form-inline" style="width:100%">
                                    			<label style="width:6%">电话:</label>
                                    			<input style="width:25%" class="form-control"  type="text" disabled="disabled" value="${pd.contact_phone }"  />
                                    			
                                    			<label style="width:6%">公司电话:</label>
                                   				<input style="width:25%" class="form-control" type="text"  value="${pd.agent_tel}" disabled="disabled" />
                                    			
                                    			<label style="width:6%">营业执照:</label>
                                    			<input style="width:25%"  class="form-control" type="text" disabled="disabled" value="${pd.agent_license_no}"  />
                                    			
                                    		</div>
                                    		
                                    		 <div class="form-group form-inline">
                                   				<label style="width:6%">联系邮件:</label>
                                   	 			<input style="width:25%" class="form-control" disabled="disabled"  type="text" value="${pd.contact_email }"  />
                                   	 			
                                    			<label style="width:6%">电子邮箱:</label>
                                    			<input style="width:25%" class="form-control" type="text" disabled="disabled"  value="${pd.agent_email}" />
                                    			
		                                    	<label style="width:6%">邮编:</label>
		                                    	<input style="width:25%" class="form-control" type="text" disabled="disabled" value="${pd.agent_postcode}"  />
		                                    	
		                                   		<label style="display: none" id="agentIndustry" >行业:</label>
		                                   	 	<input style="display: none" class="form-control"  type="text" name="agent_industry" id="agent_industry" placeholder="这里输入行业" value="${pd.agent_industry }"  />
                                    		</div>
                                    		
                                    		<div class="form-group form-inline">
		                                    	<label style="width:6%">开户银行:</label>
		                                    	<input style="width:25%" class="form-control" type="text" disabled="disabled" value="${pd.agent_bank_name}"  />
		                                    	
		                                     	<label style="width:6%">帐号:</label>
		                                    	<input style="width:25%" class="form-control" type="text" disabled="disabled" value="${pd.agent_bank_account}"  />
		                                    	
		                                    	<label style="width:6%">税号:</label>
		                                    	<input style="width:25%" class="form-control" type="text" disabled="disabled" value="${pd.tax_no}"  />
                                    		</div>
                                    		
                                    		<div class="form-group form-inline">
		                                    	<label style="width:6%">职务:</label>
			                                    <input style="width:25%" class="form-control"  type="text" disabled="disabled" value="${pd.contact_title }" />
			                                    
		                                    	<label style="width:6%">法人代表:</label>
		                                    	<input style="width:25%" class="form-control" type="text" disabled="disabled" value="${pd.legal_representative}"  />
		                                    	
		                                    	<label style="width:6%">企业性质:</label>
		                                    	<input style="width:25%" class="form-control" type="text" disabled="disabled" value="${pd.enterprise_property}"  />
                                    		</div>
                                    		
                                    		<div class="form-group form-inline">
		                                    	<label style="width:6%">传真:</label>
		                                    	<input style="width:25%" class="form-control" type="text" disabled="disabled" value="${pd.agent_fax}"  />
		                                    	
		                                    	<label style="width:6%">员工人数:</label>
		                                    	<input style="width:25%" class="form-control" type="number" disabled="disabled" value="${pd.employee_num}"  />
		                                    	
		                                    	<label style="width:6%">业务员:</label>
		                                    	<input style="width:25%" class="form-control" type="text" disabled="disabled" value="${pd.response_salesman}"  />
                                    		</div>
                                    	</div>
                                	</div>   
                                   
                                    
                                   
                                    <c:choose>
                                    	<c:when test="${pd.agent_type == '1' and pd.is_constructor == '1'}">
                                    		<div class="panel panel-primary" >
                                    			<div class="panel-heading">
                                    				安装资质
                                    			</div>	
		                                    		<div class="form-group form-inline">
					                                    <label style="width:8%">安装人数:</label>
				                                    	<input style="width:25%" class="form-control" type="text" disabled="disabled"  value="${pd.constructor_employee_no}"  />
				                                    	&nbsp;&nbsp;&nbsp;
				                                    	<label style="width:8%">安装资格证:</label>
				                                    	<input style="width:25%" class="form-control" type="text" disabled="disabled"  value="${pd.constructor_certification}"  />
				                                 	</div>
					                                 <div class="form-group form-inline">
					                                 	<label style="width:8%">安装资质:</label>
					                                 	<input class="form-control" type="hidden" name="constructor_qualification" id="constructor_qualification" placeholder="这里输入安装队保险" value="${pd.constructor_qualification}" title="安装资质"  />
					                                 	<c:if test="${pd ne null and pd.constructor_qualification ne null and pd.constructor_qualification ne '' }">
				                                    		<a class="btn btn-mini btn-success" onclick="downFile($('#constructor_qualification'))">下载安装资质</a>
				                                    	</c:if>	
					                                 </div>
		                                 
					                                 <div class="form-group form-inline">
					                                 	<label style="width:8%">安装队保险:</label>
					                                 	<input class="form-control" type="hidden" name="constructor_insurance" id="constructor_insurance" placeholder="这里输入安装队保险" value="${pd.constructor_insurance}" title="安装队保险"  />
				                                    	<c:if test="${pd ne null and pd.constructor_insurance ne null and pd.constructor_insurance ne '' }">
				                                    		<a class="btn btn-mini btn-success" onclick="downFile($('#constructor_insurance'))">下载保险</a>
				                                    	</c:if>
					                                 </div>
					                                 <div class="form-group">
				                                        <label>安装业绩描述:</label>
				                                        <textarea class="form-control" disabled="disabled" rows="10" cols="20"  maxlength="250"  >${pd.constructor_description}</textarea>
				                                    </div>
				                              </div>    
                                    	</c:when>
                                    	<c:when test="${pd.is_constructor == '1' }">
                                    		<div class="panel panel-primary" >
                                    			<div class="panel-heading">
                                    				安装资质
                                    			</div>	
		                                    		<div class="form-group form-inline">
					                                    <label style="width:8%">安装人数:</label>
				                                    	<input style="width:25%" class="form-control" type="text" disabled="disabled"  value="${pd.constructor_employee_no}"  />
				                                    	&nbsp;&nbsp;&nbsp;
				                                    	<label style="width:8%">安装资格证:</label>
				                                    	<input style="width:25%" class="form-control" type="text" disabled="disabled"  value="${pd.constructor_certification}"  />
				                                 	</div>
					                                 <div class="form-group form-inline">
					                                 	<label style="width:8%">安装资质:</label>
					                                 	<input class="form-control" type="hidden" name="constructor_qualification" id="constructor_qualification" placeholder="这里输入安装队保险" value="${pd.constructor_qualification}" title="安装资质"  />
					                                 	<c:if test="${pd ne null and pd.constructor_qualification ne null and pd.constructor_qualification ne '' }">
				                                    		<a class="btn btn-mini btn-success" onclick="downFile($('#constructor_qualification'))">下载安装资质</a>
				                                    	</c:if>	
					                                 </div>
				                                 
					                                 <div class="form-group form-inline">
					                                 	<label style="width:8%">安装队保险:</label>
					                                 	<input class="form-control" type="hidden" name="constructor_insurance" id="constructor_insurance" placeholder="这里输入安装队保险" value="${pd.constructor_insurance}" title="安装队保险"  />
				                                    	<c:if test="${pd ne null and pd.constructor_insurance ne null and pd.constructor_insurance ne '' }">
				                                    		<a class="btn btn-mini btn-success" onclick="downFile($('#constructor_insurance'))">下载保险</a>
				                                    	</c:if>
					                                 </div>
					                                 <div class="form-group">
				                                        <label>安装业绩描述:</label>
				                                        <textarea class="form-control" disabled="disabled" rows="10" cols="20"  maxlength="250"  >${pd.constructor_description}</textarea>
				                                    </div>
				                              </div>      
                                    	</c:when>
	                                   
                                    </c:choose>
                                   
                                    
                                    <div class="form-group">
                                    	<label style="width:80px">业绩说明:</label>
                                    	<textarea class="form-control" disabled="disabled" rows="10" cols="20"  maxlength="250"  >${pd.content_and_scope}</textarea>
                                    	
                                        <label>备注:</label>
                                        <textarea class="form-control" disabled="disabled" rows="10" cols="20"  maxlength="250"  >${pd.agent_remark}</textarea>
                                    </div>
                            
                            </div>
                            
                        </div>
                        
                    </div>
						<div style="height: 20px;"></div>
						<tr>
                       
                            <td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('ViewAgent');">关闭</a></td>
                       
						</tr>
					</div>
            </div>
            
        </div>
 </div>
 </form> 
 
</body>

 
 
	<script type="text/javascript">
	

	
		
		
		
		function CloseSUWin(id) {
			window.parent.$("#" + id).data("kendoWindow").close();
		}
		
		 
		
		
		
		
		
		// 下载文件   e代表当前路径值 
		function downFile(e){
			var downFile = $(e).val();
			window.location.href="sysAgent/down?downFile="+downFile;
		}
	</script>
</html>
