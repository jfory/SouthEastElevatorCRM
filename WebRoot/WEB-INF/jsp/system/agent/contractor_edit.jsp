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
    <link href="static/js/sweetalert2/sweetalert2.css" rel="stylesheet">
	<!-- jsp文件头和头部 -->
	<%@ include file="../../system/admin/top.jsp"%> 
	<style type="text/css">
		.ztree li span.button.defaultSkin_ico_open {
			margin-right: 2px;
			background-position: -110px -16px;
			vertical-align: top;
		}
		.ztree li span.button.defaultSkin_ico_close {
			margin-right: 2px;
			background-position: -110px -16px;
			vertical-align: top;
		}
		.ztree li span.button.defaultSkin_ico_docu {
			margin-right: 2px;
			background-position: -110px -16px;
			vertical-align: top;
		}

	</style>
	<!-- 日期控件-->
    <script src="static/js/layer/laydate/laydate.js"></script>
    <script type="text/javascript">
	  //日期范围限制
	    var operation_ent_time = {
	        elem: '#operation_ent_time',
	        format: 'YYYY/MM/DD hh:mm:ss',
	        max: '2099-06-16 23:59:59', //最大日期
	        istime:true,
	        istoday: false,
	        choose: function (datas) {
	            end.min = datas; //开始日选好后，重置结束日的最小日期
	            end.start = datas //将结束日的初始值设定为开始日
	        }
	    };
	    var insurance_ent_time = {
	        elem: '#insurance_ent_time',
	        format: 'YYYY/MM/DD hh:mm:ss',
	        max: '2099-06-16 23:59:59',
	        istime: true,
	        istoday: false,
	        choose: function (datas) {
	            start.max = datas; //结束日选好后，重置开始日的最大日期
	        }
	    };
	    laydate(operation_ent_time);
	    laydate(insurance_ent_time);
    </script>
</head>

<body class="gray-bg">
<form action="sysAgent/${msg}.do" name="agentForm" id="agentForm" method="post">
	<input type="hidden" name="agent_id" id="agent_id" value="${pd.agent_id}" />
	<%--用户ID--%>
	<input type="hidden" name="requester_id" id="requester_id" value="${userpds.USER_ID}"/>
	<%--用户地址 --%>
	<input type="hidden" id="address_name" name="address_name" value="${pd.address_name }">
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
									<c:choose>
									
										<c:when test="${pd.agent_instance_id ne null and (pd.agent_approval eq 0 or pd.agent_approval eq 4) }">
											<!-- 分包商存在代理资质,未审核状态、可修改信息 -->
													<div class="panel panel-primary">
		                                    <div class="panel-heading">
		                                        	选项
		                                    </div>
		                                    <div class="panel-body">
		                                        
		                                        <div class="form-group form-inline">
			                                    	<label style="width:8%;display: none">启用标志:</label>
			                                        <select style="width:20%;display: none" class="form-control" name="is_acvtivated" id="is_acvtivated" title="启用标志">
				                                        <option value="2"
															<c:if test="${pd.is_acvtivated == '2'}"> selected</c:if>>
															否
														</option>
														<option value="1"
															<c:if test="${pd.is_acvtivated == '1'}"> selected</c:if>>
															是
														</option>
														
													</select>
													
			                                    	<span style="color: red">*</span>
													<label style="width:8%">所属区域:</label>
													<input type="text" readonly="readonly" style="width:20%" 
														name="customer_area_text_ordinary" id="customer_area_text_ordinary" 
														value="${pd.area_name }"  
														placeholder="请选择区域" title="所属区域" 
														class="form-control" onClick="showAreaMenuOrdinary()"/>
													<input style="width:170px"  type="hidden" name="area_id" id="area_id"  value="${pd.area_id}"   title="所属区域"   class="form-control" >	
													
													<!-- ztree区域显示模块 -->
											 		<div class="ibox float-e-margins" id="areaContent" class="menuContent" style="display:none; position: absolute;z-index: 99;border: solid 1px #18a689;max-height:300px;overflow-y:scroll;overflow-x:auto">
														<div class="ibox-content">
															<div>
																<ul id="area_zTree" class="ztree" style="margin-top:0; width:170px;"></ul>
															</div>
														</div>
											 		</div>
		                                    		
													
													<span style="color: red">*</span>
			                                    	<label style="width:8%">所属公司:</label>
			                                    	<input type="text" readonly="readonly" style="width:20%" 
														name="company_id_text" id="company_id_text" 
														value="${pd.company_name }"  
														placeholder="请选择公司" title="所属公司" 
														class="form-control" onClick="showSubCompanyaMenu()"/>
													<input style="width:170px"  type="hidden" name="company_id" id="company_id"  value="${pd.company_id}"   title="所属公司"   class="form-control" >	
													<!-- ztree区域显示模块 -->
											 		<div class="ibox float-e-margins" id="subCompanyContent" class="menuContent" style="display:none; position: absolute;z-index: 99;border: solid 1px #18a689;max-height:300px;overflow-y:scroll;overflow-x:auto">
														<div class="ibox-content">
															<div>
																<ul id="subCompany_zTree" class="ztree" style="margin-top:0; width:170px;"></ul>
															</div>
														</div>
											 		</div>
													
													<span style="color: red">*</span>
													<label style="width: 8%">员工人数:</label>
													<select style="width: 20%" class="form-control" id="employee_num" name="employee_num">
														<option value="">请选择</option>
														<option value="0" <c:if test="${pd.employee_num eq 0}">selected</c:if> >0~50</option>
														<option value="1" <c:if test="${pd.employee_num eq 1}">selected</c:if> >50~100</option>
														<option value="2" <c:if test="${pd.employee_num eq 2}">selected</c:if> >100~300</option>
														<option value="3" <c:if test="${pd.employee_num eq 3}">selected</c:if> >500以上</option>
													</select>
		                                    	</div>
		                                        
		                                        <div class="form-group form-inline">
			                                       	<span style="color: red">*</span>
			                                  			<label style="width:8%" id="isConstructor">代理资质:</label>
			                                      		<select style="width:20%" class="form-control" name="agent_type" id="agent_type" title="代理资质">
			                                       		<option value="">请选择</option>
														<option value="1"
															<c:if test="${pd.agent_type == '1'}"> selected</c:if>>
															是
														</option>
														<option value="2"
															<c:if test="${pd.agent_type == '2'}"> selected</c:if>>
															否
														</option>
													</select>
		                                        		
		                                        		
													<span style="color: red">*</span>
													<label style="width: 8%">类别:</label>
													<select style="width: 20%" class="form-control" id="agent_category" name="agent_category">
														<option value="">请选择</option>
														<option value="0" <c:if test="${pd.agent_category eq 0 }">selected</c:if> >普通</option>
														<option value="1" <c:if test="${pd.agent_category eq 1 }">selected</c:if> >核心</option>
														<option value="2" <c:if test="${pd.agent_category eq 2 }">selected</c:if> >战略联盟</option>
														<option value="3" <c:if test="${pd.agent_category eq 3 }">selected</c:if> >战略联盟二级</option>
														<option value="4" <c:if test="${pd.agent_category eq 4 }">selected</c:if> >东南尚升二级</option>
														
													</select>
													
													<!--  
													<span style="color: red">*</span>
		                                    		<label style="width:8%">信用等级:</label>
		                                    		<select style="width:20%" class="form-control" name="credit_ratings" id="credit_ratings" title="信用等级">
				                                        	<option value="">请选择</option>
												    		<c:forEach var="rating" items="${ratingList}" >
												    		<option value="${rating.id }" <c:if test="${pd.credit_ratings eq rating.id }">selected</c:if>  >${rating.rating }</option>
												    		</c:forEach>
													</select>
											      	-->
		                                   		</div>
		                                   		
		                                   </div>
		                                </div>
										
										
										<div class="panel panel-primary">
		                                    	<div class="panel-heading">
		                                       		 地址
		                                    	</div>
		                                    	<div class="panel-body">
		                                        	
		                                        	<div class="form-group form-inline">
		                                        		<span style="color: red">*</span>
			                                    		<label style="width:8%">地址:</label>
			                                        	<select style="width:20%" class="form-control" name="province_id" id="province_id" title="区域">
				                                        	<option value="">请选择</option>
												    		<c:forEach var="province" items="${provinceList}" >
												    		<option value="${province.id }" <c:if test="${pd.province_id eq province.id }">selected</c:if>  >${province.name }</option>
												    		</c:forEach>
														</select>
													
													
													
													<select style="width: 20%" id="city_id" name="city_id" class="form-control" disabled="disabled" title="城市">
														<option value="">请选择</option>
												    	<c:forEach var="city" items="${cityList}" >
												    		<option value="${city.id }" <c:if test="${pd.city_id eq city.id }">selected</c:if>  >${city.name }</option>
												    	</c:forEach>
													</select>
		                                    		
		                                    		
			                                        <select style="width:20%" class="form-control" name="county_id" id="county_id" title="郡/县" disabled="disabled">
			                                        	<option value="">请选择</option>
												    	<c:forEach var="coundty" items="${coundtyList}" >
												    		<option value="${coundty.id }" <c:if test="${pd.county_id eq coundty.id }">selected</c:if>  >${coundty.name }</option>
												    	</c:forEach>
				                                        
													</select>
													
													
		                                        	<input style="width:20%" class="form-control" type="text" name="agent_address" id="agent_address" placeholder="这里输入地址" value="${pd.agent_address}"  />
													
		                                    </div>
		                                        	
		                                    	</div>
		                                	</div>
		                                	
		                                		<label style="width:80px;display: none" >类型:</label>
			                                       <select style="width:250px;display: none" class="form-control" name="is_constructor" id="is_constructor" title="代理商类型">
			                                        
													<option value="1"
														<c:if test="${pd.isConstructor == '1'}"> selected</c:if>>
														分包商
													</option>
													
												</select>
		                                    
		                                    
		                                    <div class="panel panel-primary">
		                                    	<div class="panel-heading">
		                                        	信息
		                                    	</div>
		                                    	<div class="panel-body">
		                                        	<div class="form-group form-inline" style="width: 100%">
		                                    			<label style="width:6%;display: none" id="agentNo">编号:</label>
		                                    			<input style="width:25%" readonly="readonly"  type="hidden"  placeholder="编号自动生成"  id="agent_no" name="agent_no" value="${pd.agent_no }"  class="form-control">
		                                    			
		                                    			<span style="color: red">*</span>
		                                    			<label style="width:6%" id="agentName">名称:</label>
														<div style="display: inline" class=" ui-widget">
															<input style="width:25%" type="text" placeholder="这里输入名称"  id="agent_name" name="agent_name" value="${pd.agent_name }" onblur="AgentName()" class="form-control">
														</div>

		                                        		<span style="color: red">*</span>                                  
		                                    			
		                                    			<label style="width:6%">联系人:</label>
		                                   				<input style="width:25%" class="form-control"  type="text" name="agent_contact" id="agent_contact" placeholder="这里输入联系人" value="${pd.agent_contact }"  />
		                                    		</div>
		                                    		
		                                    		<div class="form-group form-inline" style="width:100%">
		                                    			<span style="color: red">*</span>
		                                    			<label style="width:6%">电话:</label>
		                                    			<input style="width:25%" class="form-control"  type="text" name="contact_phone" id="contact_phone" placeholder="这里输入联系人电话" value="${pd.contact_phone }" title="联系人电话" />
		                                    			
		                                    			<span style="color: red">*</span>
		                                    			<label style="width:6%">公司电话:</label>
		                                   				<input style="width:25%" class="form-control" type="text" name="agent_tel" id="agent_tel" placeholder="这里输入公司电话" value="${pd.agent_tel}" title="公司电话" />
		                                   				
			                                    		<span style="color: red">*</span>
		                                    			<label style="width:6%">营业执照:</label>
		                                    			<input style="width:25%"  class="form-control" type="text" name="agent_license_no" id="agent_license_no" placeholder="这里输入营业执照号码" value="${pd.agent_license_no}" title="营业执照号码"  />
		                                    			
		                                    		</div>
		                                    		
		                                    		 <div class="form-group form-inline">
		                                    		 	<span>&nbsp;</span>
		                                   				<label style="width:6%">联系邮件:</label>
		                                   	 			<input style="width:25%" class="form-control"  type="text" name="contact_email" id="contact_email" placeholder="这里输入联系邮件" value="${pd.contact_email }" title="联系邮件" />
		                                    			<span>&nbsp;</span>
		                                    			<label style="width:6%">电子邮箱:</label>
		                                    			<input style="width:25%" class="form-control" type="text" name="agent_email" id="agent_email" placeholder="这里输入电子邮箱" value="${pd.agent_email}" title="电子邮箱" />
		                                    			<span>&nbsp;</span>
				                                    	<label style="width:6%">邮编:</label>
				                                    	<input style="width:25%" class="form-control" type="text" name="agent_postcode" id="agent_postcode" placeholder="这里输入邮编" value="${pd.agent_postcode}" title="邮编" />
				                                    	
				                                   		<label style="display: none" id="agentIndustry" >行业:</label>
				                                   	 	<input style="display: none" class="form-control"  type="text" name="agent_industry" id="agent_industry" placeholder="这里输入行业" value="${pd.agent_industry }"  />
		                                    		</div>
		                                    		
		                                    		<div class="form-group form-inline">
		                                    			<span>&nbsp;</span>
				                                    	<label style="width:6%">开户银行:</label>
				                                    	<input style="width:25%" class="form-control" type="text" name="agent_bank_name" id="agent_bank_name" placeholder="这里输入开户银行" value="${pd.agent_bank_name}" title="开户银行" />
				                                    	<span>&nbsp;</span>
				                                     	<label style="width:6%">帐号:</label>
				                                    	<input style="width:25%" class="form-control" type="text" name="agent_bank_account" id="agent_bank_account" placeholder="这里输入帐号" value="${pd.agent_bank_account}" title="帐号" />
				                                    	<span>&nbsp;</span>
				                                    	<label style="width:6%">税号:</label>
				                                    	<input style="width:25%" class="form-control" type="text" name="tax_no" id="tax_no" placeholder="这里输入税号" value="${pd.tax_no}" title="税号" />
		                                    		</div>
		                                    		
		                                    		<div class="form-group form-inline">
		                                    			<span>&nbsp;</span>
				                                    	<label style="width:6%">职务:</label>
					                                    <input style="width:25%" class="form-control"  type="text" name="contact_title" id="contact_title" placeholder="这里输入联系人职务" value="${pd.contact_title }" title="联系人职务" />
					                                   	<span>&nbsp;</span>
				                                    	<label style="width:6%">法人代表:</label>
				                                    	<input style="width:25%" class="form-control" type="text" name="legal_representative" id="legal_representative" placeholder="这里输入法人代表" value="${pd.legal_representative}" title="法人代表" />
				                                    	<span>&nbsp;</span>
				                                    	<label style="width:6%">企业性质:</label>
				                                    	<input style="width:25%" class="form-control" type="text" name="enterprise_property" id="enterprise_property" placeholder="这里输入企业性质" value="${pd.enterprise_property}" title="企业性质" />
		                                    		</div>
		                                    		
		                                    		<div class="form-group form-inline">
		                                    			<span>&nbsp;</span>
				                                    	<label style="width:6%">传真:</label>
				                                    	<input style="width:25%" class="form-control" type="text" name="agent_fax" id="agent_fax" placeholder="这里输入传真" value="${pd.agent_fax}" title="传真" />
				                                    	<span>&nbsp;</span>
		                                    		</div>
		                                    		
		                                    		<div class="form-group form-inline">
		                                    			<span>&nbsp;</span>
		                                    			<label style="width:6%">附件:</label>
					                                 	<input class="form-control" type="hidden" name="accessory" id="accessory" placeholder="这里输入附件" value="${pd.accessory}" title="附件"  />
				                                    	<input style="width:25%" class="form-control" type="file" name="accessory_upload" id="accessory_upload" placeholder="这里输入附件"  title="附件" onchange="upload(this,$('#accessory'))" />
				                                    	<c:if test="${pd ne null and pd.accessory ne null and pd.accessory ne '' }">
				                                    		<a class="btn btn-mini btn-success" onclick="downFile($('#accessory'))">下载附件</a>
				                                    	</c:if>
		                                    		</div>
		                                    	</div>
		                                	</div>
										</c:when>
										
										<c:when test="${pd.agent_instance_id eq null }">
										<!-- 分包商不存在代理资质,可修改信息 -->
													<div class="panel panel-primary">
		                                    <div class="panel-heading">
		                                        	选项
		                                    </div>
		                                    <div class="panel-body">
		                                        
		                                        <div class="form-group form-inline">
			                                    	<label style="width:8%;display: none">启用标志:</label>
			                                        <select style="width:20%;display: none" class="form-control" name="is_acvtivated" id="is_acvtivated" title="启用标志">
				                                        <option value="2"
															<c:if test="${pd.is_acvtivated == '2'}"> selected</c:if>>
															否
														</option>
														<option value="1"
															<c:if test="${pd.is_acvtivated == '1'}"> selected</c:if>>
															是
														</option>
														
													</select>
													
			                                    	<span style="color: red">*</span>
													<label style="width:8%">所属区域:</label>
													<input type="text" readonly="readonly" style="width:20%" 
														name="customer_area_text_ordinary" id="customer_area_text_ordinary" 
														value="${pd.area_name }"  
														placeholder="请选择区域" title="所属区域" 
														class="form-control" onClick="showAreaMenuOrdinary()"/>
													<input style="width:170px"  type="hidden" name="area_id" id="area_id"  value="${pd.area_id}"   title="所属区域"   class="form-control" >	
													
													<!-- ztree区域显示模块 -->
											 		<div class="ibox float-e-margins" id="areaContent" class="menuContent" style="display:none; position: absolute;z-index: 99;border: solid 1px #18a689;max-height:300px;overflow-y:scroll;overflow-x:auto">
														<div class="ibox-content">
															<div>
																<ul id="area_zTree" class="ztree" style="margin-top:0; width:170px;"></ul>
															</div>
														</div>
											 		</div>
		                                    		
													
													<span style="color: red">*</span>
			                                    	<label style="width:8%">所属公司:</label>
			                                    	<input type="text" readonly="readonly" style="width:20%" 
														name="company_id_text" id="company_id_text" 
														value="${pd.company_name }"  
														placeholder="请选择公司" title="所属公司" 
														class="form-control" onClick="showSubCompanyaMenu()"/>
													<input style="width:170px"  type="hidden" name="company_id" id="company_id"  value="${pd.company_id}"   title="所属公司"   class="form-control" >	
													<!-- ztree区域显示模块 -->
											 		<div class="ibox float-e-margins" id="subCompanyContent" class="menuContent" style="display:none; position: absolute;z-index: 99;border: solid 1px #18a689;max-height:300px;overflow-y:scroll;overflow-x:auto">
														<div class="ibox-content">
															<div>
																<ul id="subCompany_zTree" class="ztree" style="margin-top:0; width:170px;"></ul>
															</div>
														</div>
											 		</div>
													
													<span style="color: red">*</span>
													<label style="width: 8%">员工人数:</label>
													<select style="width: 20%" class="form-control" id="employee_num" name="employee_num">
														<option value="">请选择</option>
														<option value="0" <c:if test="${pd.employee_num eq 0}">selected</c:if> >0~50</option>
														<option value="1" <c:if test="${pd.employee_num eq 1}">selected</c:if> >50~100</option>
														<option value="2" <c:if test="${pd.employee_num eq 2}">selected</c:if> >100~300</option>
														<option value="3" <c:if test="${pd.employee_num eq 3}">selected</c:if> >500以上</option>
													</select>
		                                    	</div>
		                                        
		                                        <div class="form-group form-inline">
			                                       	<span style="color: red">*</span>
			                                  			<label style="width:8%" id="isConstructor">代理资质:</label>
			                                      		<select style="width:20%" class="form-control" name="agent_type" id="agent_type" title="代理资质">
			                                       		<option value="">请选择</option>
														<option value="1"
															<c:if test="${pd.agent_type == '1'}"> selected</c:if>>
															是
														</option>
														<option value="2"
															<c:if test="${pd.agent_type == '2'}"> selected</c:if>>
															否
														</option>
													</select>
		                                        		
		                                        		
													<span style="color: red">*</span>
													<label style="width: 8%">类别:</label>
													<select style="width: 20%" class="form-control" id="agent_category" name="agent_category">
														<option value="">请选择</option>
														<option value="0" <c:if test="${pd.agent_category eq 0 }">selected</c:if> >普通</option>
														<option value="1" <c:if test="${pd.agent_category eq 1 }">selected</c:if> >核心</option>
														<option value="2" <c:if test="${pd.agent_category eq 2 }">selected</c:if> >战略联盟</option>
														<option value="3" <c:if test="${pd.agent_category eq 3 }">selected</c:if> >战略联盟二级</option>
														<option value="4" <c:if test="${pd.agent_category eq 4 }">selected</c:if> >东南尚升二级</option>
														
													</select>
													
													<!--  
													<span style="color: red">*</span>
		                                    		<label style="width:8%">信用等级:</label>
		                                    		<select style="width:20%" class="form-control" name="credit_ratings" id="credit_ratings" title="信用等级">
				                                        	<option value="">请选择</option>
												    		<c:forEach var="rating" items="${ratingList}" >
												    		<option value="${rating.id }" <c:if test="${pd.credit_ratings eq rating.id }">selected</c:if>  >${rating.rating }</option>
												    		</c:forEach>
													</select>
											      	-->
		                                   		</div>
		                                   		
		                                   </div>
		                                </div>
										
										
										<div class="panel panel-primary">
		                                    	<div class="panel-heading">
		                                       		 地址
		                                    	</div>
		                                    	<div class="panel-body">
		                                        	
		                                        	<div class="form-group form-inline">
		                                        		<span style="color: red">*</span>
			                                    		<label style="width:8%">地址:</label>
			                                        	<select style="width:20%" class="form-control" name="province_id" id="province_id" title="区域">
				                                        	<option value="">请选择</option>
												    		<c:forEach var="province" items="${provinceList}" >
												    		<option value="${province.id }" <c:if test="${pd.province_id eq province.id }">selected</c:if>  >${province.name }</option>
												    		</c:forEach>
														</select>
													
													
													
													<select style="width: 20%" id="city_id" name="city_id" class="form-control" disabled="disabled" title="城市">
														<option value="">请选择</option>
												    	<c:forEach var="city" items="${cityList}" >
												    		<option value="${city.id }" <c:if test="${pd.city_id eq city.id }">selected</c:if>  >${city.name }</option>
												    	</c:forEach>
													</select>
		                                    		
		                                    		
			                                        <select style="width:20%" class="form-control" name="county_id" id="county_id" title="郡/县" disabled="disabled">
			                                        	<option value="">请选择</option>
												    	<c:forEach var="coundty" items="${coundtyList}" >
												    		<option value="${coundty.id }" <c:if test="${pd.county_id eq coundty.id }">selected</c:if>  >${coundty.name }</option>
												    	</c:forEach>
				                                        
													</select>
													
													
		                                        	<input style="width:20%" class="form-control" type="text" name="agent_address" id="agent_address" placeholder="这里输入地址" value="${pd.agent_address}"  />
													
		                                    </div>
		                                        	
		                                    	</div>
		                                	</div>
		                                	
		                                		<label style="width:80px;display: none" >类型:</label>
			                                       <select style="width:250px;display: none" class="form-control" name="is_constructor" id="is_constructor" title="代理商类型">
			                                        
													<option value="1"
														<c:if test="${pd.isConstructor == '1'}"> selected</c:if>>
														分包商
													</option>
													
												</select>
		                                    
		                                    
		                                    <div class="panel panel-primary">
		                                    	<div class="panel-heading">
		                                        	信息
		                                    	</div>
		                                    	<div class="panel-body">
		                                        	<div class="form-group form-inline" style="width: 100%">
		                                    			<label style="width:6%;display: none" id="agentNo">编号:</label>
		                                    			<input style="width:25%" readonly="readonly"  type="hidden"  placeholder="编号自动生成"  id="agent_no" name="agent_no" value="${pd.agent_no }"  class="form-control">
		                                    			
		                                    			<span style="color: red">*</span>
		                                    			<label style="width:6%" id="agentName">名称:</label>
		                                        		<input style="width:25%" type="text" placeholder="这里输入名称"  id="agent_name" name="agent_name" onblur="AgentName()" value="${pd.agent_name }" class="form-control">     
		                                        		
		                                        		<span style="color: red">*</span>                                  
		                                    			
		                                    			<label style="width:6%">联系人:</label>
		                                   				<input style="width:25%" class="form-control"  type="text" name="agent_contact" id="agent_contact" placeholder="这里输入联系人" value="${pd.agent_contact }"  />
		                                    		</div>
		                                    		
		                                    		<div class="form-group form-inline" style="width:100%">
		                                    			<span style="color: red">*</span>
		                                    			<label style="width:6%">电话:</label>
		                                    			<input style="width:25%" class="form-control"  type="text" name="contact_phone" id="contact_phone" placeholder="这里输入联系人电话" value="${pd.contact_phone }" title="联系人电话" />
		                                    			
		                                    			<span style="color: red">*</span>
		                                    			<label style="width:6%">公司电话:</label>
		                                   				<input style="width:25%" class="form-control" type="text" name="agent_tel" id="agent_tel" placeholder="这里输入公司电话" value="${pd.agent_tel}" title="公司电话" />
		                                   				
			                                    		<span style="color: red">*</span>
		                                    			<label style="width:6%">营业执照:</label>
		                                    			<input style="width:25%"  class="form-control" type="text" name="agent_license_no" id="agent_license_no" placeholder="这里输入营业执照号码" value="${pd.agent_license_no}" title="营业执照号码"  />
		                                    			
		                                    		</div>
		                                    		
		                                    		 <div class="form-group form-inline">
		                                    		 	<span>&nbsp;</span>
		                                   				<label style="width:6%">联系邮件:</label>
		                                   	 			<input style="width:25%" class="form-control"  type="text" name="contact_email" id="contact_email" placeholder="这里输入联系邮件" value="${pd.contact_email }" title="联系邮件" />
		                                    			<span>&nbsp;</span>
		                                    			<label style="width:6%">电子邮箱:</label>
		                                    			<input style="width:25%" class="form-control" type="text" name="agent_email" id="agent_email" placeholder="这里输入电子邮箱" value="${pd.agent_email}" title="电子邮箱" />
		                                    			<span>&nbsp;</span>
				                                    	<label style="width:6%">邮编:</label>
				                                    	<input style="width:25%" class="form-control" type="text" name="agent_postcode" id="agent_postcode" placeholder="这里输入邮编" value="${pd.agent_postcode}" title="邮编" />
				                                    	
				                                   		<label style="display: none" id="agentIndustry" >行业:</label>
				                                   	 	<input style="display: none" class="form-control"  type="text" name="agent_industry" id="agent_industry" placeholder="这里输入行业" value="${pd.agent_industry }"  />
		                                    		</div>
		                                    		
		                                    		<div class="form-group form-inline">
		                                    			<span>&nbsp;</span>
				                                    	<label style="width:6%">开户银行:</label>
				                                    	<input style="width:25%" class="form-control" type="text" name="agent_bank_name" id="agent_bank_name" placeholder="这里输入开户银行" value="${pd.agent_bank_name}" title="开户银行" />
				                                    	<span>&nbsp;</span>
				                                     	<label style="width:6%">帐号:</label>
				                                    	<input style="width:25%" class="form-control" type="text" name="agent_bank_account" id="agent_bank_account" placeholder="这里输入帐号" value="${pd.agent_bank_account}" title="帐号" />
				                                    	<span>&nbsp;</span>
				                                    	<label style="width:6%">税号:</label>
				                                    	<input style="width:25%" class="form-control" type="text" name="tax_no" id="tax_no" placeholder="这里输入税号" value="${pd.tax_no}" title="税号" />
		                                    		</div>
		                                    		
		                                    		<div class="form-group form-inline">
		                                    			<span>&nbsp;</span>
				                                    	<label style="width:6%">职务:</label>
					                                    <input style="width:25%" class="form-control"  type="text" name="contact_title" id="contact_title" placeholder="这里输入联系人职务" value="${pd.contact_title }" title="联系人职务" />
					                                   	<span>&nbsp;</span>
				                                    	<label style="width:6%">法人代表:</label>
				                                    	<input style="width:25%" class="form-control" type="text" name="legal_representative" id="legal_representative" placeholder="这里输入法人代表" value="${pd.legal_representative}" title="法人代表" />
				                                    	<span>&nbsp;</span>
				                                    	<label style="width:6%">企业性质:</label>
				                                    	<input style="width:25%" class="form-control" type="text" name="enterprise_property" id="enterprise_property" placeholder="这里输入企业性质" value="${pd.enterprise_property}" title="企业性质" />
		                                    		</div>
		                                    		
		                                    		<div class="form-group form-inline">
		                                    			<span>&nbsp;</span>
				                                    	<label style="width:6%">传真:</label>
				                                    	<input style="width:25%" class="form-control" type="text" name="agent_fax" id="agent_fax" placeholder="这里输入传真" value="${pd.agent_fax}" title="传真" />
				                                    	<span>&nbsp;</span>
		                                    		</div>
		                                    		
		                                    		<div class="form-group form-inline">
		                                    			<span>&nbsp;</span>
		                                    			<label style="width:6%">附件:</label>
					                                 	<input class="form-control" type="hidden" name="accessory" id="accessory" placeholder="这里输入附件" value="${pd.accessory}" title="附件"  />
				                                    	<input style="width:25%" class="form-control" type="file" name="accessory_upload" id="accessory_upload" placeholder="这里输入附件"  title="附件" onchange="upload(this,$('#accessory'))" />
				                                    	<c:if test="${pd ne null and pd.accessory ne null and pd.accessory ne '' }">
				                                    		<a class="btn btn-mini btn-success" onclick="downFile($('#accessory'))">下载附件</a>
				                                    	</c:if>
		                                    		</div>
		                                    	</div>
		                                	</div>
										</c:when>
										
										<c:otherwise>
											<!-- 代理商审核中,不能修改代理商信息 -->
											
											
												<div class="panel panel-primary">
			                                    <div class="panel-heading">
			                                        	选项
			                                    </div>
			                                    <div class="panel-body">
			                                        
			                                        <div class="form-group form-inline">
				                                    	<label style="width:8%;display: none">启用标志:</label>
				                                        <select style="width:20%;display: none" class="form-control" name="is_acvtivated" id="is_acvtivated" title="启用标志">
					                                        <option value="2"
																<c:if test="${pd.is_acvtivated == '2'}"> selected</c:if>>
																否
															</option>
															<option value="1"
																<c:if test="${pd.is_acvtivated == '1'}"> selected</c:if>>
																是
															</option>
															
														</select>
														
				                                    	<span style="color: red">*</span>
														<label style="width:8%">所属区域:</label>
														<input type="text" readonly="readonly" style="width:20%" disabled="disabled"  
															name="customer_area_text_ordinary" id="customer_area_text_ordinary" 
															value="${pd.area_name }"  
															placeholder="请选择区域" title="所属区域" 
															class="form-control" onClick="showAreaMenuOrdinary()"/>
														<input style="width:170px"  type="hidden" name="area_id" id="area_id"  value="${pd.area_id}"   title="所属区域"   class="form-control" >	
														
														<!-- ztree区域显示模块 -->
												 		<div class="ibox float-e-margins" id="areaContent" class="menuContent" style="display:none; position: absolute;z-index: 99;border: solid 1px #18a689;max-height:300px;overflow-y:scroll;overflow-x:auto">
															<div class="ibox-content">
																<div>
																	<ul id="area_zTree" class="ztree" style="margin-top:0; width:170px;"></ul>
																</div>
															</div>
												 		</div>
			                                    		
														
														<span style="color: red">*</span>
				                                    	<label style="width:8%">所属公司:</label>
				                                    	<input type="text" readonly="readonly" style="width:20%" disabled="disabled"
															name="company_id_text" id="company_id_text" 
															value="${pd.company_name }"  
															placeholder="请选择公司" title="所属公司" 
															class="form-control" onClick="showSubCompanyaMenu()"/>
														<input style="width:170px"  type="hidden" name="company_id" id="company_id"  value="${pd.company_id}"   title="所属公司"   class="form-control" >	
														<!-- ztree区域显示模块 -->
												 		<div class="ibox float-e-margins" id="subCompanyContent" class="menuContent" style="display:none; position: absolute;z-index: 99;border: solid 1px #18a689;max-height:300px;overflow-y:scroll;overflow-x:auto">
															<div class="ibox-content">
																<div>
																	<ul id="subCompany_zTree" class="ztree" style="margin-top:0; width:170px;"></ul>
																</div>
															</div>
												 		</div>
														
														<span style="color: red">*</span>
														<label style="width: 8%">员工人数:</label>
														<select style="width: 20%" class="form-control" id="employee_num" name="employee_num" disabled="disabled">
															<option value="">请选择</option>
															<option value="0" <c:if test="${pd.employee_num eq 0}">selected</c:if> >0~50</option>
															<option value="1" <c:if test="${pd.employee_num eq 1}">selected</c:if> >50~100</option>
															<option value="2" <c:if test="${pd.employee_num eq 2}">selected</c:if> >100~300</option>
															<option value="3" <c:if test="${pd.employee_num eq 3}">selected</c:if> >500以上</option>
														</select>
			                                    	</div>
			                                        
			                                        <div class="form-group form-inline">
				                                       	<span style="color: red">*</span>
				                                  			<label style="width:8%" id="isConstructor">代理资质:</label>
				                                      		<select style="width:20%" class="form-control" disabled="disabled" name="agent_type" id="agent_type" title="代理资质">
				                                       		<option value="">请选择</option>
															<option value="1"
																<c:if test="${pd.agent_type == '1'}"> selected</c:if>>
																是
															</option>
															<option value="2"
																<c:if test="${pd.agent_type == '2'}"> selected</c:if>>
																否
															</option>
														</select>
			                                        		
			                                        		
														<span style="color: red">*</span>
														<label style="width: 8%">类别:</label>
														<select style="width: 20%" class="form-control" disabled="disabled" id="agent_category" name="agent_category">
															<option value="">请选择</option>
															<option value="0" <c:if test="${pd.agent_category eq 0 }">selected</c:if> >普通</option>
															<option value="1" <c:if test="${pd.agent_category eq 1 }">selected</c:if> >核心</option>
															<option value="2" <c:if test="${pd.agent_category eq 2 }">selected</c:if> >战略联盟</option>
															<option value="3" <c:if test="${pd.agent_category eq 3 }">selected</c:if> >战略联盟二级</option>
															<option value="4" <c:if test="${pd.agent_category eq 4 }">selected</c:if> >东南尚升二级</option>
															
														</select>
														
														<!--  
														<span style="color: red">*</span>
			                                    		<label style="width:8%">信用等级:</label>
			                                    		<select style="width:20%" class="form-control" name="credit_ratings" id="credit_ratings" title="信用等级">
					                                        	<option value="">请选择</option>
													    		<c:forEach var="rating" items="${ratingList}" >
													    		<option value="${rating.id }" <c:if test="${pd.credit_ratings eq rating.id }">selected</c:if>  >${rating.rating }</option>
													    		</c:forEach>
														</select>
												      	-->
			                                   		</div>
			                                   		
			                                   </div>
			                                </div>
											
											
											<div class="panel panel-primary">
			                                    	<div class="panel-heading">
			                                       		 地址
			                                    	</div>
			                                    	<div class="panel-body">
			                                        	
			                                        	<div class="form-group form-inline">
			                                        		<span style="color: red">*</span>
				                                    		<label style="width:8%">地址:</label>
				                                        	<select style="width:20%"  class="form-control" name="province_id" id="province_id" title="区域">
					                                        	<option value="">请选择</option>
													    		<c:forEach var="province" items="${provinceList}" >
													    		<option value="${province.id }" <c:if test="${pd.province_id eq province.id }">selected</c:if>  >${province.name }</option>
													    		</c:forEach>
															</select>
														
														
														
														<select style="width: 20%" id="city_id" name="city_id" class="form-control" disabled="disabled" title="城市">
															<option value="">请选择</option>
													    	<c:forEach var="city" items="${cityList}" >
													    		<option value="${city.id }" <c:if test="${pd.city_id eq city.id }">selected</c:if>  >${city.name }</option>
													    	</c:forEach>
														</select>
			                                    		
			                                    		
				                                        <select style="width:20%" class="form-control" name="county_id" id="county_id" title="郡/县" disabled="disabled">
				                                        	<option value="">请选择</option>
													    	<c:forEach var="coundty" items="${coundtyList}" >
													    		<option value="${coundty.id }" <c:if test="${pd.county_id eq coundty.id }">selected</c:if>  >${coundty.name }</option>
													    	</c:forEach>
					                                        
														</select>
														
														
			                                        	<input style="width:20%" class="form-control" readonly="readonly" type="text" name="agent_address" id="agent_address" placeholder="这里输入地址" value="${pd.agent_address}"  />
														
			                                    </div>
			                                        	
			                                    	</div>
			                                	</div>
			                                	
			                                		<label style="width:80px;display: none" >类型:</label>
				                                       <select style="width:250px;display: none" class="form-control" name="is_constructor" id="is_constructor" title="代理商类型">
				                                        
														<option value="1"
															<c:if test="${pd.isConstructor == '1'}"> selected</c:if>>
															分包商
														</option>
														
													</select>
			                                    
			                                    
			                                    <div class="panel panel-primary">
			                                    	<div class="panel-heading">
			                                        	信息
			                                    	</div>
			                                    	<div class="panel-body">
			                                        	<div class="form-group form-inline" style="width: 100%">
			                                    			<label style="width:6%;display: none" id="agentNo">编号:</label>
			                                    			<input style="width:25%" readonly="readonly"  type="hidden"  placeholder="编号自动生成"  id="agent_no" name="agent_no" value="${pd.agent_no }"  class="form-control">
			                                    			
			                                    			<span style="color: red">*</span>
			                                    			<label style="width:6%" id="agentName">名称:</label>
			                                        		<input style="width:25%" type="text" readonly="readonly" placeholder="这里输入名称"  id="agent_name" name="agent_name" onblur="AgentName()" value="${pd.agent_name }" class="form-control">     
			                                        		
			                                        		<span style="color: red">*</span>                                  
			                                    			
			                                    			<label style="width:6%">联系人:</label>
			                                   				<input style="width:25%" class="form-control" readonly="readonly"  type="text" name="agent_contact" id="agent_contact" placeholder="这里输入联系人" value="${pd.agent_contact }"  />
			                                    		</div>
			                                    		
			                                    		<div class="form-group form-inline" style="width:100%">
			                                    			<span style="color: red">*</span>
			                                    			<label style="width:6%">电话:</label>
			                                    			<input style="width:25%" class="form-control" readonly="readonly"  type="text" name="contact_phone" id="contact_phone" placeholder="这里输入联系人电话" value="${pd.contact_phone }" title="联系人电话" />
			                                    			
			                                    			<span style="color: red">*</span>
			                                    			<label style="width:6%">公司电话:</label>
			                                   				<input style="width:25%" class="form-control" readonly="readonly" type="text" name="agent_tel" id="agent_tel" placeholder="这里输入公司电话" value="${pd.agent_tel}" title="公司电话" />
			                                   				
				                                    		<span style="color: red">*</span>
			                                    			<label style="width:6%">营业执照:</label>
			                                    			<input style="width:25%"  class="form-control" readonly="readonly" type="text" name="agent_license_no" id="agent_license_no" placeholder="这里输入营业执照号码" value="${pd.agent_license_no}" title="营业执照号码"  />
			                                    			
			                                    		</div>
			                                    		
			                                    		 <div class="form-group form-inline">
			                                    		 	<span>&nbsp;&nbsp;</span>
			                                   				<label style="width:6%">联系邮件:</label>
			                                   	 			<input style="width:25%" class="form-control" readonly="readonly"  type="text" name="contact_email" id="contact_email" placeholder="这里输入联系邮件" value="${pd.contact_email }" title="联系邮件" />
			                                    			<span>&nbsp;&nbsp;</span>
			                                    			<label style="width:6%">电子邮箱:</label>
			                                    			<input style="width:25%" class="form-control" readonly="readonly" type="text" name="agent_email" id="agent_email" placeholder="这里输入电子邮箱" value="${pd.agent_email}" title="电子邮箱" />
			                                    			<span>&nbsp;&nbsp;</span>
					                                    	<label style="width:6%">邮编:</label>
					                                    	<input style="width:25%" class="form-control" readonly="readonly" type="text" name="agent_postcode" id="agent_postcode" placeholder="这里输入邮编" value="${pd.agent_postcode}" title="邮编" />
					                                    	
					                                   		<label style="display: none" id="agentIndustry" >行业:</label>
					                                   	 	<input style="display: none" class="form-control" readonly="readonly"  type="text" name="agent_industry" id="agent_industry" placeholder="这里输入行业" value="${pd.agent_industry }"  />
			                                    		</div>
			                                    		
			                                    		<div class="form-group form-inline">
			                                    			<span>&nbsp;&nbsp;</span>
					                                    	<label style="width:6%">开户银行:</label>
					                                    	<input style="width:25%" class="form-control" readonly="readonly" type="text" name="agent_bank_name" id="agent_bank_name" placeholder="这里输入开户银行" value="${pd.agent_bank_name}" title="开户银行" />
					                                    	<span>&nbsp;&nbsp;</span>
					                                     	<label style="width:6%">帐号:</label>
					                                    	<input style="width:25%" class="form-control" readonly="readonly" type="text" name="agent_bank_account" id="agent_bank_account" placeholder="这里输入帐号" value="${pd.agent_bank_account}" title="帐号" />
					                                    	<span>&nbsp;&nbsp;</span>
					                                    	<label style="width:6%">税号:</label>
					                                    	<input style="width:25%" class="form-control" readonly="readonly" type="text" name="tax_no" id="tax_no" placeholder="这里输入税号" value="${pd.tax_no}" title="税号" />
			                                    		</div>
			                                    		
			                                    		<div class="form-group form-inline">
			                                    			<span>&nbsp;&nbsp;</span>
					                                    	<label style="width:6%">职务:</label>
						                                    <input style="width:25%" class="form-control" readonly="readonly"  type="text" name="contact_title" id="contact_title" placeholder="这里输入联系人职务" value="${pd.contact_title }" title="联系人职务" />
						                                   	<span>&nbsp;&nbsp;</span>
					                                    	<label style="width:6%">法人代表:</label>
					                                    	<input style="width:25%" class="form-control" readonly="readonly" type="text" name="legal_representative" id="legal_representative" placeholder="这里输入法人代表" value="${pd.legal_representative}" title="法人代表" />
					                                    	<span>&nbsp;&nbsp;</span>
					                                    	<label style="width:6%">企业性质:</label>
					                                    	<input style="width:25%" class="form-control" readonly="readonly" type="text" name="enterprise_property" id="enterprise_property" placeholder="这里输入企业性质" value="${pd.enterprise_property}" title="企业性质" />
			                                    		</div>
			                                    		
			                                    		<div class="form-group form-inline">
			                                    			<span>&nbsp;&nbsp;</span>
					                                    	<label style="width:6%">传真:</label>
					                                    	<input style="width:25%" class="form-control" readonly="readonly" type="text" name="agent_fax" id="agent_fax" placeholder="这里输入传真" value="${pd.agent_fax}" title="传真" />
					                                    	<span>&nbsp;</span>
			                                    		</div>
			                                    		
			                                    		<div class="form-group form-inline">
			                                    			<span>&nbsp;&nbsp;</span>
			                                    			<label style="width:6%">附件:</label>
						                                 	<input class="form-control" type="hidden" name="accessory" id="accessory" placeholder="这里输入附件" value="${pd.accessory}" title="附件"  />
					                                    	<input style="width:25%" class="form-control" type="file" readonly="readonly" name="accessory_upload" id="accessory_upload" placeholder="这里输入附件"  title="附件" onchange="upload(this,$('#accessory'))" />
					                                    	<c:if test="${pd ne null and pd.accessory ne null and pd.accessory ne '' }">
					                                    		<a class="btn btn-mini btn-success" onclick="downFile($('#accessory'))">下载附件</a>
					                                    	</c:if>
			                                    		</div>
			                                    	</div>
			                                	</div>
											
										</c:otherwise>
									</c:choose>
                                    
                                    
                                                                        
                                    <div class="panel panel-primary" style="display: none" id="confirm_constructor">
                                    	<div class="panel-heading">
                                       		 安装资质
                                    	</div>
                                    	<div class="panel-body">
                                        	<div class="form-group form-inline" id="constructorAddHidden1" >
	                                    		<label style="width:8%">安装人数:</label>
                                    			<input style="width:25%" class="form-control" type="text" name="constructor_employee_no" id="constructor_employee_no" placeholder="这里输入安装人数" value="${pd.constructor_employee_no}" title="安装人数" />
                                    			&nbsp;&nbsp;&nbsp;
                                    			<label style="width:8%">安装资格证:</label>
                                    			<input style="width:25%" class="form-control" type="text" name="constructor_certification" id="constructor_certification" placeholder="这里输入安装队资格证" value="${pd.constructor_certification}" title="安装队资格证" />
	                                 		</div>
	                                 		
	                                 		
	                                 		<div class="form-group form-inline" id="constructorAddHidden2" >
			                                 	<label style="width:8%">安装资质:</label>
			                                 	<input class="form-control" type="hidden" name="constructor_qualification" id="constructor_qualification" placeholder="这里输入安装队保险" value="${pd.constructor_qualification}" title="安装资质"  />
		                                    	<input style="width:25%" class="form-control" type="file" name="qualification_upload" id="qualification_upload" placeholder="这里输入安装资质"  title="安装资质" onchange="upload(this,$('#constructor_qualification'))" />
			                                 	<c:if test="${pd ne null and pd.constructor_qualification ne null and pd.constructor_qualification ne '' }">
		                                    		<a class="btn btn-mini btn-success" onclick="downFile($('#constructor_qualification'))">下载安装资质</a>
		                                    	</c:if>	
	                                 		</div>
	                                 
			                                 <div class="form-group form-inline" id="constructorAddHidden3" >
			                                 	<label style="width:8%">安装队保险:</label>
			                                 	<input class="form-control" type="hidden" name="constructor_insurance" id="constructor_insurance" placeholder="这里输入安装队保险" value="${pd.constructor_insurance}" title="安装队保险"  />
		                                    	<input style="width:25%" class="form-control" type="file" name="insurance_upload" id="insurance_upload" placeholder="这里输入安装队保险"  title="安装队保险" onchange="upload(this,$('#constructor_insurance'))" />
		                                    	<c:if test="${pd ne null and pd.constructor_insurance ne null and pd.constructor_insurance ne '' }">
		                                    		<a class="btn btn-mini btn-success" onclick="downFile($('#constructor_insurance'))">下载保险</a>
		                                    	</c:if>
			                                 </div>
                                   
		                                    <div class="form-group" id="constructorAddHidden4" >
		                                        <label>安装业绩描述:</label>
		                                        <textarea class="form-control" rows="10" cols="20" name="constructor_description" id="constructor_description" placeholder="这里输入安装业绩描述" maxlength="250" title="备注" >${pd.constructor_description}</textarea>
		                                    </div>
                                    	</div>
                                    	
                                    	
                                    	<div class="panel-heading">
                                       		操作人信息
                                    	</div>
                                    	<div class="panel-body">
                                        	<div class="form-group form-inline"  >
	                                    		<label style="width:10%">姓名:</label>
                                    			<input style="width:25%" class="form-control" type="text" name="id_card_name" id="id_card_name" placeholder="这里输入姓名" value="${pd.id_card_name}" title="姓名" />
                                    			&nbsp;&nbsp;&nbsp;
                                    			<label style="width:10%">身份证号:</label>
                                    			<input style="width:25%" class="form-control" type="text" name="id_card_no" id="id_card_no" placeholder="这里输入身份证号" value="${pd.id_card_no}" title="身份证号" />
                                    			
	                                 		</div>
	                                 		
	                                 		<div class="form-group form-inline"  >
	                                    		<label style="width:10%">操作证到期时间:</label>
                                    			<input style="width:25%" type="text" name="operation_ent_time" id="operation_ent_time"  value="${pd.operation_ent_time}"  placeholder="这里输入操作证到期时间" title="到期时间"  class="form-control layer-date" onclick="laydate()">
                                    			&nbsp;&nbsp;&nbsp;
                                    			<label style="width:10%">保险到期时间:</label>
                                    			<input style="width:25%" type="text" name="insurance_ent_time" id="insurance_ent_time"  value="${pd.insurance_ent_time}"  placeholder="这里输入保险到期时间" title="到期时间"  class="form-control layer-date" onclick="laydate()">
	                                 		</div>
	                                 		
	                                 		<div class="form-group form-inline"  >
	                                    		<label style="width:10%">保险金额:</label>
                                    			<input style="width:25%" class="form-control" type="text" name="insurance_price" id="insurance_price" placeholder="这里输入保险金额" value="${pd.insurance_price}" title="保险金额" />
	                                 		</div>
	                                 		
	                                 
                                   
		                                    
                                    	</div>
                                	</div>
                                    
                                    <div class="form-group">
                                    	<label style="width:80px">业绩说明:</label>
                                    	<textarea class="form-control" readonly="readonly" rows="10" cols="20" name="content_and_scope" id="content_and_scope" placeholder="这里输入经营内容及业绩" maxlength="250" title="备注" >${pd.content_and_scope}</textarea>
                                    </div>
                                    <div class="form-group">
                                        <label>备注:</label>
                                        <textarea class="form-control" readonly="readonly" rows="10" cols="20" name="agent_remark" id="agent_remark" placeholder="这里输入备注" maxlength="250" title="备注" >${pd.agent_remark}</textarea>
                                    </div>
                            
                            </div>
                            
                        </div>
                        
                    </div>
						<div style="height: 20px;"></div>
						<tr>
						<td><a class="btn btn-primary"style="width: 150px; height:34px;float:left;"  onclick="save();">保存</a></td>
                        <c:if test="${msg eq 'add'}">
                            <td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('AddAgent');">关闭</a></td>
                        </c:if>
                        <c:if test="${msg eq 'editContractor'}">
                            <td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('EditAgent');">关闭</a></td>
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
		<!-- Sweet alert -->
    <script src="static/js/sweetalert2/sweetalert2.js"></script>
	<script type="text/javascript">
	var zNodes =${areas};
	
	//ztree
	var setting = {
		view: {
			dblClickExpand: false
		},
		data: {
			simpleData: {
				enable: true
			}
		},
		callback: {
			onClick: onClick
		}
	};
	
	var provinceName=""; //省份名称
	var cityName="";     //城市名称
	var countyName="";	  //群/县
	var agentAddressName=""; //地址名称
	
	$(document).ready(function(){
		$.fn.zTree.init($("#myzTree"), setting, zNodes);
		var zTree = $.fn.zTree.getZTreeObj("myzTree");
		
		zTree.expandAll(true);
		
		if($("#agent_type").val()==""){
			$("#confirm_constructor").hide();
			
		}else{
			$("#confirm_constructor").show();
			
		}
		
		var province_id = $("#province_id option:selected").val();
		
		if(province_id!=null && province_id!=""){
			$("#city_id").attr("disabled",false);
		}
		
		var county_id = $("#county_id option:selected").val();
		if(county_id !=null && county_id != ""){
			$("#county_id").attr("disabled",false);
		}
		provinceName = $("#province_id option:selected").text();
		cityName = $("#city_id option:selected").text();
		countyName = $("#county_id option:selected").text();
		agentAddressName = $("#agent_address").val();

        $("#agent_name").autocomplete({
            source:function (request, response) {
                $.ajax({
                    url: "customer/getQixinbaoCompany",
                    dataType: "json",
                    data: {
                        searchKey: request.term
                    },
                    success: function( data ) {
                        response( $.map( data, function( item ) {
                            return {
                                label: item.companyName,
                                value: item.companyName,
                                telephone:item.telephone,
                                companyKind:item.companyKind,
                                operName:item.operName,
                                companyAddress:item.companyAddress,
                                businessLienceNum:item.businessLienceNum,
                            }
                        }));
                    }
                });
            },
            minLength: 2,
            select: function( event, ui ) {
                $("#enterprise_property").val(ui.item.companyKind);
                $("#legal_representative").val(ui.item.operName);
                $("#agent_tel").val(ui.item.telephone);
                $("#tax_no").val(ui.item.businessLienceNum);
                $("#agent_license_no").val(ui.item.businessLienceNum);
                $("#agent_address").val(ui.item.companyAddress);
            }
        });
		
	});

	
		//保存
		function save(){
			if($("#area_id").val()==""){
				$("#area_id").focus();
				$("#area_id").tips({
					side:3,
		            msg:'所属区域',
		            bg:'#AE81FF',
		            time:2
		        });
				return false;
			}
			
			if($("#company_id").val()==""){
				$("#company_id").focus();
				$("#company_id").tips({
					side:3,
		            msg:'所属公司',
		            bg:'#AE81FF',
		            time:2
		        });
				
				return false;
			}
			if($("#employee_num").val()==""){
				$("#employee_num").focus();
				$("#employee_num").tips({
					side:3,
		            msg:'员工人数',
		            bg:'#AE81FF',
		            time:2
		        });
				
				
				return false;
			}
			if($("#agent_type").val()==""){
				$("#agent_type").focus();
				$("#agent_type").tips({
					side:3,
		            msg:'代理资质',
		            bg:'#AE81FF',
		            time:2
		        });
				return false;
			}
			/*
			if($("#credit_ratings").val()==""){
				$("#credit_ratings").focus();
				$("#credit_ratings").tips({
					side:3,
		            msg:'信用等级',
		            bg:'#AE81FF',
		            time:2
		        });
				
				
				return false;
			}*/
			if($("#is_acvtivated").val()==""){
				$("#is_acvtivated").focus();
				$("#is_acvtivated").tips({
					side:3,
		            msg:'启用标志',
		            bg:'#AE81FF',
		            time:2
		        });
				
				
				return false;
			}
			
			
			
			if($("#is_constructor").val()==""){
				$("#is_constructor").focus();
				$("#is_constructor").tips({
					side:3,
		            msg:'请选择',
		            bg:'#AE81FF',
		            time:2
		        });
				
				return false;
			}
			if($("#agent_category").val()==""){
				$("#agent_category").focus();
				$("#agent_category").tips({
					side:3,
		            msg:'类别',
		            bg:'#AE81FF',
		            time:2
		        });
				return false;
			}
			
			if($("#province_id").val()==""){
				$("#province_id").focus();
				$("#province_id").tips({
					side:3,
		            msg:'请选择地址',
		            bg:'#AE81FF',
		            time:2
		        });
				return false;
			}
			if($("#city_id").val()==""){
				$("#city_id").focus();
				$("#city_id").tips({
					side:3,
		            msg:'请选择地址',
		            bg:'#AE81FF',
		            time:2
		        });
				return false;
			}
			if($("#agent_address").val()==""){
				$("#agent_address").focus();
				$("#agent_address").tips({
					side:3,
		            msg:'输入地址',
		            bg:'#AE81FF',
		            time:2
		        });
				return false;
			}
			
			
			if($("#agent_name").val()==""){
				$("#agent_name").focus();
				$("#agent_name").tips({
					side:3,
		            msg:'输入名称',
		            bg:'#AE81FF',
		            time:2
		        });
				return false;
			}
			
			if($("#agent_contact").val()==""){
				$("#agent_contact").focus();
				$("#agent_contact").tips({
					side:3,
		            msg:'输入联系人',
		            bg:'#AE81FF',
		            time:2
		        });
				return false;
			}
			if($("#contact_phone").val()==""){
				$("#contact_phone").focus();
				$("#contact_phone").tips({
					side:3,
		            msg:'输入电话',
		            bg:'#AE81FF',
		            time:2
		        });
				return false;
			}
			if($("#agent_tel").val()==""){
				$("#agent_tel").focus();
				$("#agent_tel").tips({
					side:3,
		            msg:'公司电话',
		            bg:'#AE81FF',
		            time:2
		        });
				
				return false;
			}
			if($("#agent_license_no").val()==""){
				$("#agent_license_no").focus();
				$("#agent_license_no").tips({
					side:3,
		            msg:'输入营业执照号码',
		            bg:'#AE81FF',
		            time:2
		        });
				return false;
			}
			
			if($("#employee_num").val()==""){
				$("#employee_num").val(0);
			}else if(isNaN(Number($("#employee_num").val()))){
				$("#employee_num").focus();
				$("#employee_num").tips({
					side:3,
		            msg:'输入数字',
		            bg:'#AE81FF',
		            time:3
		        });
				
				
				$("#employee_num").val(0);
				return false;
			}
			if($("#response_salesman").val()==""){
				$("#response_salesman").focus();
				$("#response_salesman").tips({
					side:3,
		            msg:'请选择业务员',
		            bg:'#AE81FF',
		            time:2
		        });
				return false;
			}
			
			$("#customer_area_text_ordinary").attr("disabled",false);
			$("#company_id").attr("disabled",false);
			$("#employee_num").attr("disabled",false);
			$("#agent_type").attr("disabled",false);
			$("#agent_category").attr("disabled",false);
			$("#province_id").attr("disabled",false);
			$("#city_id").attr("disabled",false);
			$("#county_id").attr("disabled",false);
			
			
			$("#address_name").val(provinceName+cityName+countyName+agentAddressName);
			$("#agentForm").submit();
		}
		
		
		function CloseSUWin(id) {
			window.parent.$("#" + id).data("kendoWindow").close();
		}
		
		//判断是否存在营业执照号码
		$("#agent_license_no").on("blur",function(){
			var agent_license_no = $(this).val();
			var agent_id = $("#agent_id").val();
			$.post("sysAgent/existsLicenseNo.do",{agent_license_no:agent_license_no,agent_id:agent_id},function(result){
				if(result.success){
					
				}else{
					$("#agent_license_no").focus();
					$("#agent_license_no").tips({
						side:3,
			            msg:result.errorMsg,
			            bg:'#AE81FF',
			            time:2
			        });
					$("#agent_license_no").val("");
				}
			});
		});
		
		 
		//判断代理商名称是否已存在
        function AgentName() {
            var name = $("#agent_name").val();
            var url = "<%=basePath%>sysAgent/AgentName.do?agent_name=" + name + "&tm="
				+ new Date().getTime();
		$.get(url, function(data) {
			if (data.msg == "error") {
				$("#agent_name").focus();
				$("#agent_name").tips({
					side : 3,
					msg : '代理商名称已存在',
					bg : '#AE81FF',
					time : 3
				});
				setTimeout("$('#agent_name').val('')", 2000);
			}
		});
	}
		
		
		$("#agent_type").change(function(){
			
			// 类型为分包商时显示追加内容
			if($("#agent_type").val()==""){
				$("#confirm_constructor").hide();
			}else{ 
				$("#confirm_constructor").show();
				
			}
		});
		
		
		
		
		//文件异步上传   e代表当前File对象,v代表对应路径值
		function upload(e,v){
			var filePath = $(e).val(); 
			var arr = filePath.split("\\"); 
			var fileName = arr[arr.length-1];
			var suffix = filePath.substring(filePath.lastIndexOf(".")).toLowerCase();
			var fileType = ".xls|.xlsx|.doc|.docx|.txt|.pdf|"; 
			if(filePath == null || filePath == ""){
				$(v).val("");
				return false;
			}
			if(fileType.indexOf(suffix+"|")==-1){
				var ErrMsg = "该文件类型不允许上传。请上传 "+fileType+" 类型的文件，当前文件类型为"+suffix; 
				$(e).val("");
				alert(ErrMsg);
				return false;
			}
			//var data = new FormData($("#agentForm")[0]);
			var data = new FormData();
			
		    data.append("file", $(e)[0].files[0]);
		    
			$.ajax({
				url:"sysAgent/upload.do",
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
			window.location.href="sysAgent/down?downFile="+downFile;
		}
		
		// 显示城市 
		
		 $("#province_id").change(function(){
   		var province_id = $("#province_id option:selected").val();
   		
   		if(province_id!=null && province_id!=""){
   			provinceName = $("#province_id option:selected").text();
	    		$.post("city/findAllCityByProvinceId.do",{province_id:province_id},function(result){
	    			$("#city_id").empty();
	    			$("#county_id").empty();
	    			if(result.length>0){
	    				$("#city_id").attr("disabled",false);
	    				$("#city_id").append("<option value=''>请选择</option>");
	    				$.each(result,function(key,value){						
	    					$("#city_id").append("<option value='"+value.id+"'  >"+value.name+"</option>");
	    				});
	    				$("#county_id").attr("disabled",true);
	    			}else{
	    				$("#city_id").attr("disabled",true);
	    			}
	    			
	    		});
   		}else{
   			$("#city_id").empty();
   			$("#city_id").attr("disabled",true);
   			$("#county_id").empty();
   			$("#county_id").attr("disabled",true);
   			provinceName="";
   			cityName="";
   			countyName="";
   		}
   	});	
		
		//显示 群/县
		 $("#city_id").change(function(){
	    		var city_id = $("#city_id option:selected").val();
	    		if(city_id !=null && city_id !=""){
	    			cityName = $("#city_id option:selected").text();
		    		$.post("city/findAllCountyByCityId.do",{city_id:city_id},function(result){
		    			$("#county_id").empty();
		    			
		    			if(result.length>0){
		    				$("#county_id").attr("disabled",false);
		    				$("#county_id").append("<option value=''>请选择</option>");
		    				$.each(result,function(key,value){
		    					$("#county_id").append("<option value='"+value.id+"'>"+value.name+"</option>");
		    				});
		    			}else{
		    				$("#county_id").attr("disabled",true);
		    			}
		    		});
	    		}else{
	    			$("#county_id").empty();
	    			$("#county_id").attr("disabled",true);
	    			cityName="";
	    			countyName="";
	    		}
	    	});
		
		//获取群/县
		$("#county_id").change(function(){
			var county_id = $("#county_id option:selected").val();
			if(county_id !=null && county_id != ""){
				countyName = $("#county_id option:selected").text();
			}else{
				countyName="";
			}
		});
		
		//获取输入地址名称
		$("#agent_address").keyup(function(){
			var agent_address = $("#agent_address").val();
			if(agent_address!=null && agent_address!=""){
				agentAddressName=agent_address;
				
			}else{
				agentAddressName="";
			}
			
		});
		
		//读入代理商信息
		$("#agent_name").change(function(){
			var agent_name = $(this).val();
			var agent_id = $("#agent_id").val();
			var agent_type = $("#agent_type").val();
			
			$.post("sysAgent/loadAgent.do",{agent_name:agent_name},function(result){
				if(result.success){
					swal({
                        title: "您确定要读取["+result.agentInfo.agent_name+"]的代理商信息吗？",
                        text: "读取后将无法编辑，请谨慎操作！",
                        type: "warning",
                        showCancelButton: true,
                        confirmButtonColor: "#DD6B55",
                        confirmButtonText: "读取",
                        cancelButtonText: "取消",
                        closeOnConfirm: false,
                        closeOnCancel: false
                    }).then(function (isConfirm) {
                        if (isConfirm) {
                        	$("#agentForm").attr("action","sysAgent/editContractor.do")
                        	$("#agent_id").val(result.agentInfo.agent_id).attr("readOnly",true);
                        	$("#agent_no").val(result.agentInfo.agent_no);
                        	$("#requester_id").val(result.agentInfo.requester_id);
                        	$("#address_name").val(result.agentInfo.address_name).attr("readOnly",true);
                        	$("#customer_area_text_ordinary").val(result.agentInfo.area_name).attr("disabled",true);
                        	$("#company_id_text").val(result.agentInfo.company_name).attr("disabled",true);
                        	$("#area_id").val(result.agentInfo.area_id).attr("readOnly",true);
                        	$("#company_id").val(result.agentInfo.company_id).attr("readOnly",true);
                        	$("#employee_num").val(result.agentInfo.employee_num).attr("disabled",true);
                        	$("#agent_type").val(1).attr("disabled",true);  
                        	$("#agent_category").val(result.agentInfo.agent_category).attr("disabled",true);
                        	$("#province_id").val(result.agentInfo.province_id).attr("disabled",true);
                        	$("#city_id").val(result.agentInfo.city_id).attr("disabled",true);
                        	$("#county_id").val(result.agentInfo.county_id).attr("disabled",true);
                        	$("#agent_address").val(result.agentInfo.agent_address).attr("readOnly",true);
                        	$("#agent_name").val(result.agentInfo.agent_name).attr("readOnly",true);
                        	$("#agent_contact").val(result.agentInfo.agent_contact).attr("readOnly",true);
                        	$("#contact_phone").val(result.agentInfo.contact_phone).attr("readOnly",true);
                        	$("#agent_tel").val(result.agentInfo.agent_tel).attr("readOnly",true);
                        	$("#agent_license_no").val(result.agentInfo.agent_license_no).attr("readOnly",true);
                        	$("#contact_email").val(result.agentInfo.contact_email).attr("readOnly",true);
                        	$("#agent_email").val(result.agentInfo.agent_email).attr("readOnly",true);
                        	$("#agent_postcode").val(result.agentInfo.agent_postcode).attr("readOnly",true);
                        	$("#agent_bank_name").val(result.agentInfo.agent_bank_name).attr("readOnly",true);
                        	$("#agent_bank_account").val(result.agentInfo.agent_bank_account).attr("readOnly",true);
                        	$("#tax_no").val(result.agentInfo.tax_no).attr("readOnly",true);
                        	$("#contact_title").val(result.agentInfo.contact_title).attr("readOnly",true);
                        	$("#legal_representative").val(result.agentInfo.legal_representative).attr("readOnly",true);
                        	$("#enterprise_property").val(result.agentInfo.enterprise_property).attr("readOnly",true);
                        	$("#agent_fax").val(result.agentInfo.agent_fax).attr("readOnly",true);
                        	$("#content_and_scope").val(result.agentInfo.content_and_scope).attr("readOnly",true);
                        	$("#agent_remark").val(result.agentInfo.agent_remark).attr("readOnly",true);
                        	$("#accessory").val(result.agentInfo.accessory).attr("readOnly",true);
                        	$("#accessory_upload").attr("disabled",true);
                        	provinceName = $("#province_id option:selected").text();
                        	cityName = $("#city_id option:selected").text();
                        	countyName = $("#county_id option:selected").text();
                        	agentAddressName = $("#agent_address").val();
	                    	$("#confirm_constructor").show();
                        	} else {
                            swal("已取消", "您取消了读取操作！", "error");
                            $("#agent_name").val('');
                        }
                    });
				}
			});
		});
		
		
		
		
		//区域显示 
		function showAreaMenuOrdinary() {
			var areaObj = $("#customer_area_text_ordinary");
			var areaOffset = $("#customer_area_text_ordinary").offset();
			$("#areaContent").css({left:(areaOffset.left+6) + "px", top:areaOffset.top + areaObj.outerHeight() + "px"}).slideDown("fast");
			$("body").bind("mousedown", onBodyDown);
		}
			
		var area_setting = {
			view: {
				dblClickExpand: false
			},
			data: {
				simpleData: {
					enable: true
				}
			},
			callback: {
				beforeClick: beforeClickArea,
				onClick: onClickArea
			}
		};


		var AreazNodes =${areas};
		var log, className = "dark";
		
		
		function beforeClickArea(treeId, treeNode) {
			var url = "<%=basePath%>customer/checkAreaNode.do?id="+treeNode.id;
			$.post(
				url,
				function(data){
					if(data.msg=='success'){
						$("#area_id").val(treeNode.id);
						$("#customer_area_text_ordinary").val(treeNode.name);
						$("#area_id_merchant").val(treeNode.id);
						$("#area_id_text_merchant").val(treeNode.name);
						$("#areaContent").hide();
						return true;
					}
				}
			);
		}

		function onClickArea(e, treeId, treeNode) {}

		$(document).ready(function() {
			$.fn.zTree.init($("#area_zTree"), area_setting, AreazNodes);
			var AreazTree = $.fn.zTree.getZTreeObj("area_zTree");
			AreazTree.expandAll(true);
		});

		//所属公司显示 
		function showSubCompanyaMenu() {
			var subCompanyObj = $("#company_id_text");
			var subCompanyOffset = $("#company_id_text").offset();
			$("#subCompanyContent").css({left:(subCompanyOffset.left+6) + "px", top:subCompanyOffset.top + subCompanyObj.outerHeight() + "px"}).slideDown("fast");
			$("body").bind("mousedown", onBodyDown);
		}
			
		var subCompany_setting = {
			view: {
				dblClickExpand: false
			},
			data: {
				simpleData: {
					enable: true
				}
			},
			callback: {
				beforeClick: beforeClickSubCompany,
				onClick: onClickSubCompany
			}
		};


		var SubCompanyzNodes =${subCompanys};
		var log, className = "dark";
		
		
		function beforeClickSubCompany(treeId, treeNode) {
			var url = "<%=basePath%>customer/checkSubCompanyNode.do?id="+treeNode.id;
			$.post(
				url,
				function(data){
					if(data.msg=='success'){
						$("#company_id").val(treeNode.id);
						$("#company_id_text").val(treeNode.name);
						$("#subCompanyContent").hide();
						return true;
					}
				}
			);
		}

		function onClickSubCompany(e, treeId, treeNode) {}

		$(document).ready(function() {
			$.fn.zTree.init($("#area_zTree"), area_setting, AreazNodes);
			var AreazTree = $.fn.zTree.getZTreeObj("area_zTree");
			AreazTree.expandAll(true);
			$.fn.zTree.init($("#subCompany_zTree"), subCompany_setting, SubCompanyzNodes);
			var SubCompanyzTree = $.fn.zTree.getZTreeObj("subCompany_zTree");
			SubCompanyzTree.expandAll(true);
		});



		function hideMenu(event){
			event  =  event  ||  window.event; // 事件 
        		var  target    =  event.target  ||  ev.srcElement; // 获得事件源 
        		var  obj  =  target.getAttribute('id');
        		if(obj!='customer_area_text_ordinary'){
				$("#areaContent").hide();
        		}
		}
		
		
		
		function onClick(e, treeId, treeNode) {
			var deptObj = $("#departmentSelect");
			deptObj.attr("value", treeNode.name);
			var deptId = $("#area_id");
			deptId.attr("value", treeNode.id);

		}
		function showMenu() {
			var deptObj = $("#departmentSelect");
			var deptOffset = $("#departmentSelect").offset();
			$("#menuContent").css({left:(deptOffset.left+6) + "px", top:deptOffset.top + deptObj.outerHeight() + "px"}).slideDown("fast");

			$("body").bind("mousedown", onBodyDown);
		}
		function onBodyDown(event) {
			if (!(event.target.id == "menuBtn" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
				hideMenu();
			}
		}
		function hideMenu() {
			$("#menuContent").fadeOut("fast");
			$("body").unbind("mousedown", onBodyDown);
		}//区域显示 
		function showAreaMenuOrdinary() {
			var areaObj = $("#customer_area_text_ordinary");
			var areaOffset = $("#customer_area_text_ordinary").offset();
			$("#areaContent").css({left:(areaOffset.left+6) + "px", top:areaOffset.top + areaObj.outerHeight() + "px"}).slideDown("fast");
			$("body").bind("mousedown", onBodyDown);
		}
			
		var area_setting = {
			view: {
				dblClickExpand: false
			},
			data: {
				simpleData: {
					enable: true
				}
			},
			callback: {
				beforeClick: beforeClickArea,
				onClick: onClickArea
			}
		};


		var AreazNodes =${areas};
		var log, className = "dark";
		
		
		function beforeClickArea(treeId, treeNode) {
			var url = "<%=basePath%>customer/checkAreaNode.do?id="+treeNode.id;
			$.post(
				url,
				function(data){
					if(data.msg=='success'){
						$("#area_id").val(treeNode.id);
						$("#customer_area_text_ordinary").val(treeNode.name);
						$("#area_id_merchant").val(treeNode.id);
						$("#area_id_text_merchant").val(treeNode.name);
						$("#areaContent").hide();
						return true;
					}
				}
			);
		}

		function onClickArea(e, treeId, treeNode) {}

		$(document).ready(function() {
			$.fn.zTree.init($("#area_zTree"), area_setting, AreazNodes);
			var AreazTree = $.fn.zTree.getZTreeObj("area_zTree");
			AreazTree.expandAll(true);
		});

		//所属公司显示 
		function showSubCompanyaMenu() {
			var subCompanyObj = $("#company_id_text");
			var subCompanyOffset = $("#company_id_text").offset();
			$("#subCompanyContent").css({left:(subCompanyOffset.left+6) + "px", top:subCompanyOffset.top + subCompanyObj.outerHeight() + "px"}).slideDown("fast");
			$("body").bind("mousedown", onBodyDown);
		}
			
		var subCompany_setting = {
			view: {
				dblClickExpand: false
			},
			data: {
				simpleData: {
					enable: true
				}
			},
			callback: {
				beforeClick: beforeClickSubCompany,
				onClick: onClickSubCompany
			}
		};


		var SubCompanyzNodes =${subCompanys};
		var log, className = "dark";
		
		
		function beforeClickSubCompany(treeId, treeNode) {
			var url = "<%=basePath%>customer/checkSubCompanyNode.do?id="+treeNode.id;
			$.post(
				url,
				function(data){
					if(data.msg=='success'){
						$("#company_id").val(treeNode.id);
						$("#company_id_text").val(treeNode.name);
						$("#subCompanyContent").hide();
						return true;
					}
				}
			);
		}

		function onClickSubCompany(e, treeId, treeNode) {}

		$(document).ready(function() {
			$.fn.zTree.init($("#area_zTree"), area_setting, AreazNodes);
			var AreazTree = $.fn.zTree.getZTreeObj("area_zTree");
			AreazTree.expandAll(true);
			$.fn.zTree.init($("#subCompany_zTree"), subCompany_setting, SubCompanyzNodes);
			var SubCompanyzTree = $.fn.zTree.getZTreeObj("subCompany_zTree");
			SubCompanyzTree.expandAll(true);
		});



		function hideMenu(event){
			event  =  event  ||  window.event; // 事件 
        		var  target    =  event.target  ||  ev.srcElement; // 获得事件源 
        		var  obj  =  target.getAttribute('id');
        		if(obj!='customer_area_text_ordinary'){
				$("#areaContent").hide();
        		}
		}
		
		
		
		function onClick(e, treeId, treeNode) {
			var deptObj = $("#departmentSelect");
			deptObj.attr("value", treeNode.name);
			var deptId = $("#area_id");
			deptId.attr("value", treeNode.id);

		}
		function showMenu() {
			var deptObj = $("#departmentSelect");
			var deptOffset = $("#departmentSelect").offset();
			$("#menuContent").css({left:(deptOffset.left+6) + "px", top:deptOffset.top + deptObj.outerHeight() + "px"}).slideDown("fast");

			$("body").bind("mousedown", onBodyDown);
		}
		function onBodyDown(event) {
			if (!(event.target.id == "menuBtn" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
				hideMenu();
			}
		}
		function hideMenu() {
			$("#menuContent").fadeOut("fast");
			$("body").unbind("mousedown", onBodyDown);
		}
	</script>
</html>
