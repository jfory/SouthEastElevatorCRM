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

<div>
		<input type="hidden" name="item_id" id="item_id" value="${pd.item_id}">
		<input type="hidden" name="contract_id" id="contract_id" value="${pd.ht_uuid}">
		<input type="hidden" name="dtInfoJson" id="dtInfoJson" value="${pd.dtInfoJson}">
		<input type="hidden" name="fkfsJson" id="fkfsJson" value="${pd.fkfsJson}">
		<input type="hidden" name="id" id="id" value="${pd.id}">
		<input type="hidden" name="NonUpload_json" id="NonUpload_json" value="${pd.NonUpload}">
		<div class="wrapper wrapper-content">
			<div class="row">
				<div class="col-sm-12">
					<div class="ibox float-e-margins">
					<div class="ibox-content1">
					<div id="cmForm" >
							<!-- 头部  Start-->
							<div style="padding-bottom:40px;">
								<div class="form-inline" style="width:350px;font-size:16px;float:left;margin-top:8px;">
									变更协议号:${pd.modify_number}
								</div>
								<div class="form-group form-inline" style="float:right;margin-right:20px;">
									<a class="btn btn-sm btn-danger" style="width: 50; height: 30px;float:right;" onclick="javascript:CloseSUWin('handleLeave');">关闭</a>
									
									<!-- <button class="btn btn-sm" title="预览" 
										style="background:#999999;color:white;"
										type="button" onclick="CNpreview();">预览
									</button> -->
			             		</div>
		             		</div>
							<!-- 头部  End-->
							
							<!-- 主信息 Start -->
							<div class="panel panel-primary">
								<div class="panel-heading">变更协议信息</div>
								<div class="panel-body">
								<div class="row" style="margin-left: 10px">
								
								<!-- 10 22 - 10 22 -10 22 -->
								<!-- 第一层 -->
								<div class="form-group form-inline">                                
                              		<label style="width:10%;">
                              			<span><font color="red">*</font></span>项目名称:</label>
                                     	<input style="width:35%" type="text" value="${headInfo.item_name}" readonly="readonly"
                                     	title="项目名称" class="form-control">
                                 	<label style="width:10%;">
                                 		<span><font color="red">*</font></span>客户名称:</label>
                                 		<input style="width:35%" type="text" readonly="readonly"
										value="${headInfo.customer_name}"
										title="客户名称" class="form-control" />
			                    </div>
			                    <!-- 第二层 -->
			                    <div class="form-group form-inline">                                
                              		<label style="width:10%;">
                              			<span><font color="red">*</font></span>安装地址:</label>
                                     	<input style="width:35%" type="text" readonly="readonly" value="${headInfo.province_name}${headInfo.city_name}${headInfo.county_name}${headInfo.address_info}"
                                     	placeholder="请输入安装地址" title="安装地址" class="form-control">
                                 	<label style="width:10%;">
                                 		<span><font color="red">*</font></span>最终用户:</label>
                                 		<input style="width:35%" type="text" readonly="readonly"
										 value="${headInfo.end_user}"
										 title="最终用户" class="form-control" />
			                    </div>
			                    <!-- 第三层 -->
			                    <div class="form-group form-inline">                                
                              		<label style="width:10%;">
                              			<span><font color="red">*</font></span>合同签订日期:</label>
                                     	<input style="width:35%" type="text" 
                                     	value="${headInfo.ht_qdrq}"  
                                     	title="合同签订日期" class="form-control" onclick="laydate()">
                                 	<label style="width:10%;">
                                 		<span><font color="red">*</font></span>变更次第:</label>
                                 		<input style="width:35%" type="text" name="squence" 
										id="squence" value="${pd.squence}"
										placeholder="请输入变更次第" title="变更次第" class="form-control" readonly="readonly" />
			                    </div>
			                    <!-- 第四层 -->
			                    <div class="form-group form-inline">                                
                              		<label style="width:10%;">
                              			<span><font color="red">*</font></span>变更原因:</label>
										<textarea name="reason" id="reason"
												   style="width:35%" rows="3" cols="20"
												  title="变更原因" class="form-control">${pd.reason}</textarea>
									<label style="width:10%;">
										<span><font color="red">*</font></span>变更内容:</label>
									<textarea name="content" id="content"
											  style="width:35%" rows="3" cols="20"
											  title="变更内容" class="form-control">${pd.content}</textarea>
			                    </div>
			                    <!-- 第五层 -->
			                   	<div class="form-group form-inline">                                
                              		<label style="width:10%;">
                              			<span><font color="red">*</font></span>特殊性概述:</label>
									<textarea name="special_desc" id="special_desc"
											  style="width:35%" rows="3" cols="20"
											  title="特殊性概述" class="form-control">${pd.special_desc}</textarea>
									<label style="width:10%;">
										<span><font color="red">*</font></span>其他约定:</label>
									<textarea name="other" id="other"
											  style="width:35%" rows="3" cols="20"
											  title="其他约定" class="form-control">${pd.other}</textarea>
			                    </div>
								<!-- 第七层 -->
			                    <div class="form-group form-inline"> 
			                    	<label style="width:10%;">
                              			<span><font color="red"></font></span>交货期(天):</label>
                                     	<input style="width:35%" type="text" name="date_deli" 
                                     	id="date_deli" value="${pd.date_deli}"  
                                     	placeholder="请输入交货期" title="交货期" class="form-control">

								</div>					
	                            
	                            <!-- 新增和编辑时候显示 -->
                                <c:if test="${forwardMsg!='view'}">
                                 <div id="fjmk">
									<div class="form-group form-inline">
									  <label style="width: 9%;margin-left: 10px;">附件上传:</label> 
									   <input class="form-control" type="hidden" name="NonUpload" value="" title="附件上传" />
										<input style="width: 21%" class="form-control" type="file"
											name="non_upload" id="non_upload" title="附件上传" onchange="upload(this)" />
										<select style="width:10%" name="HT_WJLX" id="HT_WJLX" class="form-control">
											<option value="">文件类型</option>
											<option value="1" ${pd.HT_WJLX=='1'?'selected':''}>技术变更单</option>
											<option value="2" ${pd.HT_WJLX=='2'?'selected':''}>商务变更单</option>
											<option value="3" ${pd.HT_WJLX=='3'?'selected':''}>图纸</option>
											<option value="4" ${pd.HT_WJLX=='4'?'selected':''}>技术规格表</option>
										</select>
										<c:if test="${msg=='saveContractModify'}">
										  <button style="margin-left:3px;margin-top:3px;" class="btn  btn-primary btn-sm" 
										  title="添加" type="button"onclick="addHousesImg();">加</button>
										</c:if>
										<c:if test="${msg=='editContractModify'}">
										  <button style="margin-left:3px;margin-top:3px;" class="btn  btn-primary btn-sm" 
										  title="添加" type="button"onclick="addHousesImg1();">加</button>
										   <c:if test="${pd ne null and pd.NonUpload ne null and pd.NonUpload ne '' }">
										     <a class="btn btn-mini btn-success" onclick="downFile(this)">下载附件</a>
										  </c:if> 
										</c:if>
									</div>
								</div>
							  </c:if>
							
							  <!-- 查看时候显示 -->
                              <c:if test="${forwardMsg=='view'}">
                               <div id="fjmk">
									<div class="form-group form-inline">
									  <label style="width: 9%;margin-left: 10px;">附件上传:</label> 
									    <input class="form-control" type="hidden" name="NonUpload" value="" title="附件上传" />
										<input style="width: 21%" class="form-control" type="file" disabled="disabled"
											name="non_upload" id="non_upload" title="附件上传" onchange="upload(this)" />
										<select style="width:10%" name="HT_WJLX" id="HT_WJLX" class="form-control" disabled="disabled">
											<option value="">文件类型</option>
											<option value="1" ${pd.HT_WJLX=='1'?'selected':''}>技术变更单</option>
											<option value="2" ${pd.HT_WJLX=='2'?'selected':''}>商务变更单</option>
											<option value="3" ${pd.HT_WJLX=='3'?'selected':''}>图纸</option>
											<option value="4" ${pd.HT_WJLX=='4'?'selected':''}>技术规格表</option>
										</select>
										<button style="margin-left:3px;margin-top:3px;" class="btn  btn-primary btn-sm" 
										  title="添加" type="button"onclick="addHousesImg1();" disabled="disabled">加</button>
										<c:if test="${pd ne null and pd.NonUpload ne null and pd.NonUpload ne '' }">
										     <a class="btn btn-mini btn-success" onclick="downFile(this)">下载附件</a>
										</c:if> 
									</div>
								</div>
							  </c:if>
	                            
	
							<!-- row -->		   
							</div>
						<!-- panel-body -->
						</div>
					<!-- panel panel-primary -->
					</div>
					<!-- 主信息 End -->
						
					<!-- 电梯信息 Start -->	
					<div class="panel panel-primary">
						<!-- 头  -->
						<div class="panel-heading" style="padding-right:30px;">电梯信息</div>
						<div class="panel-body">
						<div class="row" style="margin-left: 10px">	
							<table class="table table-striped table-bordered table-hover" id="elevTable">
								<thead>
									<tr>
										<th>序号</th>
										<th>梯号</th>
										<th>梯型</th>
										<th>层/站/门(提升高度)</th>
										<th>设备单价(元/台)</th>
										<th>变更金额</th>
										<th>安装单价(元/台)</th>
										<th>变更金额</th>
										<th>小计(元/台)</th>
										<th>变更后小计</th>
										<th style="display: none">操作</th>
									</tr>
								</thead>
								<tbody>
									<!-- 开始循环 -->
									<c:choose>
										<c:when test="${not empty dtInfoList}">
											<c:if test="${QX.cha == 1 }">
												<c:forEach items="${dtInfoList}" var="dt" varStatus="vs">
													<tr>
														<td>${vs.index+1}</td>
														<td><input type="hidden" value="${dt.DT_UUID}" name="DT_UUID"><input type="hidden" value="${dt.id}">${dt.DT_TH}</td>
														<td>${dt.DT_TX}</td>
														<td>${dt.DT_CZM}</td>
														<td>${dt.DT_SBDJ}</td>
														<td><input type="text" name="modify_sbdj" class="form-control" style="width: 100px" onkeyup="value=value.replace(/[^\-\d.]/g,'');setChangeElevTotal();" value="${dt.modify_sbdj}"></td>
														<td>${dt.DT_AZDJ}</td>
														<td><input type="text" name="modify_azdj" class="form-control" style="width: 100px" onkeyup="value=value.replace(/[^\-\d.]/g,'');setChangeElevTotal();" value="${dt.modify_azdj}"></td>
														<td>${dt.DT_XJ}</td>
														<td><input type="text" name="modify_total" class="form-control" style="width: 100px" readonly="readonly">
															<input type="hidden"  name="DT_YSJ" value="${dt.DT_YSJ}">
														</td>
														<td style="display: none">
															<input class="btn btn-sm btn-primary" style="width: 50px" value="增加"
																type="text" onclick="CNDTXX_add();">
															<input class="btn btn-sm btn-danger" value="删除" style="width: 50px" 
																	type="text" onclick="CNDTXX_del();">
														</td>
													</tr>
												</c:forEach>
											</c:if>
											<!-- 权限设置 -->
											<c:if test="${QX.cha == 0 }">
												<tr>
													<td colspan="100" class="center">您无权查看</td>
												</tr>
											</c:if>
										</c:when>
										<c:otherwise>
											<tr class="main_info">
												<td colspan="100" class="center">没有相关数据</td>
											</tr>
										</c:otherwise>
									</c:choose>
								</tbody>
							</table>
							<div class="form-inline" style="font-size:16px;float:left;padding-left:10px;">
								<input type="hidden" name="total" id="total" value="${pd.total}">
								原总金额:<span id="elevTotal"></span>&nbsp&nbsp&nbsp<font color="red">变更金额:<span id="changeElevTotal"></span></font>&nbsp&nbsp&nbsp变更后总额:<span id="afterElevTotal"></span>
							</div>
						<!-- 结尾 -->
						</div>
						</div>
						</div>
						<!-- 电梯信息 End -->
						
						<!-- 付款方式 Start -->	
						<div class="panel panel-primary">
						<!-- 头  -->
						<div class="panel-heading" style="padding-right:30px;">付款方式 </div>
						<div class="panel-body">
						<div class="row" style="margin-left: 10px">	
							<table class="table table-striped table-bordered table-hover" id="contractNewFKFSTab">
								<thead>
									<tr>
										<th>期次</th>
										<th>阶段</th>
										<th>判断日期</th>
										<th>付款天数</th>
										<th>付款比例(%)</th>
										<th>金额(元)</th>
										<th>已开票金额</th>
										<th>已收款金额</th>
										<th>备注</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody>
									<!-- 开始循环 -->
									<c:choose>
										<c:when test="${not empty fkfsList}">
											<c:if test="${QX.cha == 1 }">
												<c:forEach items="${fkfsList}" var="f" varStatus="vs">
													<tr>
														<td>${vs.index+1}</td>
														<td>
															<input type="hidden" value="${f.FKFS_UUID}" name="so_fkfs">
															<input type="hidden" value="${f.ID}" name="cm_id">
															<select class="form-control" name='stage' id="stage">
										                        <option value="1" ${f.FKFS_KX=='1'?'selected':''}>订金</option>
										                        <option value="2" ${f.FKFS_KX=='2'?'selected':''}>排产款</option>
										                        <option value="3" ${f.FKFS_KX=='3'?'selected':''}>发货款</option>
										                        <option value="4" ${f.FKFS_KX=='4'?'selected':''}>货到现场款</option>
										                        <option value="5" ${f.FKFS_KX=='5'?'selected':''}>安装发货款</option>
										                        <option value="6" ${f.FKFS_KX=='6'?'selected':''}>安装开工款</option>
										                        <option value="7" ${f.FKFS_KX=='7'?'selected':''}>验收款</option>
																<option value="8" ${f.FKFS_KX=='8'?'selected':''}>质保金</option>
										                    </select>
														</td>
														<td>
															<select class="form-control" id="" name='so_pdrq'>
																<option value="1" ${f.FKFS_PDRQ=='1'?'selected':''}>合同签订日期</option>
																<option value="2" ${f.FKFS_PDRQ=='2'?'selected':''}>预计发货日期</option>
																<option value="3" ${f.FKFS_PDRQ=='3'?'selected':''}>预计货到现场日期</option>
																<option value="4" ${f.FKFS_PDRQ=='4'?'selected':''}>预计进场日期</option>
																<option value="5" ${f.FKFS_PDRQ=='5'?'selected':''}>预计验收日期</option>
																<option value="6" ${f.FKFS_PDRQ=='6'?'selected':''}>免保期限</option>
															</select></td>
														<td><input type="text" name="so_fkts" value="${f.FKFS_FKTS}" class="form-control"></td>
														<td><input type="text" name="pay_percent" value="${f.FKFS_FKBL}" class="form-control" onkeyup="value=value.replace(/[^\-\d.]/g,'');setFkfsJe(this)"></td>
														<td>
														<input style="width:90%" name="price" type="text" class="form-control" value="${f.FKFS_JE}" onkeyup="value=value.replace(/[^\-\d.]/g,'');setFkfsBL(this)"/>
														</td>
														<td>${f.inv_price==null?"--":f.inv_price}</td>
														<td>--</td>
														<td><input type="text" name="remark" class="form-control" value="${f.REMARK}"></td>
														<td>
															<input class="btn btn-sm btn-danger" value="删除"
																	type="text" onclick="CNFKFSdel(this);" style="width: 50px" >
														</td>
													</tr>
												</c:forEach>
											</c:if>
											<!-- 权限设置 -->
											<c:if test="${QX.cha == 0 }">
												<tr>
													<td colspan="100" class="center">您无权查看</td>
												</tr>
											</c:if>
										</c:when>
										<c:otherwise>
											<!-- <tr class="main_info">

												<td colspan="100" class="center">没有相关数据</td>

											</tr> -->
										</c:otherwise>
									</c:choose>
								</tbody>
							</table>
						<!-- 结尾 -->
						</div>
						</div>
						</div>
						<!-- 付款方式  End -->
					</div>
						
						<!-- 办理任务 Start -->	
						<div class="panel panel-primary">
						<!-- 头  -->
						<div class="panel-heading" style="padding-right:30px;">办理任务 </div>
						<div class="panel-body">
							<form action="contractModify/handleAgent.do" name="handleLeaveForm" id="handelLeaveForm" method="post">
								<input type="hidden" id="task_id" name="task_id" value="${pd.task_id}">
								<input type="hidden" id="id" name="id" value="${pd.id}">
								<input type="hidden" id="action" name="action" value="${pd.action}">
								<div class="wrapper wrapper-content">
									<div class="row">
										<div class="col-sm-12">
											<div class="ibox float-e-margins">
												<div class="ibox-content">
													<div class="row">
														<div class="col-lg-12">
															<div class="form-group">
																<label> 批注:</label>
																<textarea class="form-control" rows="5"  cols="20" value="" name="comment" id="comment"  placeholder="这里输入批注" maxlength="250" title="批注" ></textarea>
															</div>
														</div>
													</div>
												</div>
												<div style="height: 10px;"></div>
							                        <div style="height: 40px;"></div>
												<tr>
													<td><button type="submit" class="btn btn-primary"style="width: 150px; height:34px;float:left;"  onclick="return handle('approve');">批准</button></td>
													<td><button type="submit" class="btn btn-danger"style="width: 150px; height:34px;float:right;"  onclick="return handle('reject');">驳回</button></td>
												</tr>
											</div>
										</div>
							
									</div>
								</div>
							</form>
						</div>
						</div>
						<!-- 办理任务  End -->
						
                         <div class="row">
                             <div class="col-sm-12">
                                 <div class="panel panel-primary">
                                     <div class="panel-heading">
                                         审核记录
                                     </div>
                                     <div class="panel-body">
                                         <table class="table table-striped table-bordered table-hover">

                                             <thead>
                                             <tr>
                                                 <th style="width:8%;">序号</th>
                                                 <th>任务名称</th>
                                                 <th>签收时间</th>
                                                 <th>办理时间</th>
                                                 <th>办理人</th>
                                                 <th>处理</th>
                                                 <th>批注</th>
                                             </tr>
                                             </thead>
                                             <tbody>
                                             <c:choose>
                                                 <c:when test="${not empty historys}">
                                                     <c:forEach items="${historys}" var="history" varStatus="vs">
                                                         <tr>
                                                             <td class='center' style="width: 30px;">${vs.index+1}</td>
                                                             <td>${history.task_name }</td>
                                                             <td>${history.claim_time }</td>
                                                             <td>${history.complete_time}</td>
                                                             <td>${history.user_name}</td>
                                                             <td>${history.action}</td>
                                                             <td>${history.comment}</td>
                                                         </tr>
                                                     </c:forEach>
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
                                 </div>
                             </div>
                         </div>
						
					</div>
				</div>
			</div>
			</div>
		</div>
	</div>

<script type="text/javascript">
	$(document).ready(function () {
	    //打开页面时计算电梯原总金额
	    setElevTotal();
	    setChangeElevTotal();
	
	    var forwardMsg = "${forwardMsg}";
	    if(forwardMsg=='view'){
	        //查看页面设置disable
	        var inputs = document.getElementById('cmForm').getElementsByTagName("input");
	        for(var i = 0;i<inputs.length;i++){
	            inputs[i].setAttribute("disabled","true");
	        }
	        var textareas = document.getElementById('cmForm').getElementsByTagName("textarea");
	        for(var i = 0;i<textareas.length;i++){
	            textareas[i].setAttribute("disabled","true");
	        }
	        var selects = document.getElementById('cmForm').getElementsByTagName("select");
	        for(var i = 0;i<selects.length;i++){
	            selects[i].setAttribute("disabled","true");
	        }
	    }
	    
	    if(forwardMsg=='view'){
	    	//查看时加载附件上传信息
			var housesJSON = $("#NonUpload_json").val();
			if(housesJSON!=""){
				setCheckJSON(housesJSON);
			}
	    }else{
	    	//编辑时加载附件上传信息
			var housesJSON = $("#NonUpload_json").val();
			if(housesJSON!=""){
				setHousesJSON(housesJSON);
			}
	    }
	
		 $("#contractNewFKFSTab tr:not(:first)").each(function(){
		     var kpje=$(this).find("td").eq(6).text();
		     if(kpje!=""&&!isNaN(kpje)){
		         $(this).find("input").attr("disabled","disabled");
		         $(this).find("select").attr("disabled","disabled");
		     }
		 });
	 
	 
	});
	
	//查看时加载附件上传 
 	function setCheckJSON(supp){
 		var obj = eval("("+supp+")");
 		for(var j = 0;j<obj.length-1;j++){
 			addCheckImg();
 		}
 		 for(var i = 0;i<obj.length;i++){
 			$("#fjmk").find("div").eq(i).each(function(){
 				$(this).find("input").eq(0).val(obj[i].NonUpload);
 				$(this).find("#HT_WJLX").val(obj[i].HT_WJLX);
 			});
 		} 
 	}
	
 	//实现 查看多个附件上传
 	var x=0;
 	function addCheckImg(){
 		 x = x + 1;
 	     $("#fjmk").append('<div id="fjmk'+x+'" class="form-group form-inline">'+
 		                       '<label style="width:9%;margin-left:13px;">附件上传:</label>'+ 
 		                       '<input class="form-control" type="hidden" name="NonUpload"'+
 				               'value="" title="附件上传" />'+
 			                   '<input style="width: 21%" class="form-control" type="file"'+
 				               'disabled="disabled" name="non_upload" id="non_upload"'+
 				               'title="附件上传" onchange="upload(this)" />'+
								 '<select style="width:10%" name="HT_WJLX" id="HT_WJLX" class="form-control" disabled="disabled">' +
								 '<option value="">文件类型</option>' +
								 '<option value="1" >技术变更单</option>' +
								 '<option value="2" >商务变更单</option>' +
								 '<option value="3" >图纸</option>' +
								 '<option value="4" >技术规格表</option>' +
								 '</select>'+
 			                   '<button style="margin-left:6px;margin-top:4px;" class="btn  btn-danger btn-sm"'+
 			                   'title="删除" disabled="disabled" type="button"onclick="delHouses('+j+');">减</button>'+ 
 			                   '<c:if test="${pd ne null and pd.NonUpload ne null and pd.NonUpload ne '' }">'+
 				               '  <a class="btn btn-mini btn-success" onclick="downFile(this)">下载附件</a>'+
 			                   '</c:if>'+
 		                       '</div>'
 	     );   
 	}
	
	//计算电梯总金额
    function setElevTotal(){
    	var elev_total = 0;
    	$("#elevTable tr:not(:first)").each(function(){
			elev_total += isNaN(parseInt($(this).find("td").eq(8).text()))?0:parseInt($(this).find("td").eq(8).text());
		});
    	$("#elevTotal").text(elev_total);
    }
	
    //计算变更金额
    function setChangeElevTotal(){
    	var change_elev_total = 0;//变更金额

    	var after_elev_total = 0;//变更后总金额

    	$("#elevTable tr:not(:first)").each(function(){

    		var sbdj_ = $(this).find("td").eq(4).text();
    		var sbdj_change = $(this).find("td").eq(5).find("input").eq(0).val();

    		var azdj_ = $(this).find("td").eq(6).text();
    		var azdj_change = $(this).find("td").eq(7).find("input").eq(0).val();

    		var  dt_ysj=$(this).find("[name='DT_YSJ']").eq(0).val();

    		sbdj_change = isNaN(sbdj_change)?0:sbdj_change;
    		azdj_change = isNaN(azdj_change)?0:azdj_change;

    		if((sbdj_change!=""&&!isNaN(sbdj_change))&&(azdj_change!=""&&!isNaN(azdj_change))){
	    		//变更后小计

	    		var afterTotal = parseInt(sbdj_change)+parseInt(azdj_change)+parseFloat(dt_ysj);
	    		$(this).find("td").eq(9).find("input").eq(0).val(afterTotal);
	    		//累加每行的变更金额差价

	    		var changeTotal = (parseInt(sbdj_change)-parseInt(sbdj_))+(parseInt(azdj_change)-parseInt(azdj_));

	    		change_elev_total += changeTotal;
	    		after_elev_total += afterTotal;
    		}
		});
    	$("#changeElevTotal").text(change_elev_total);
    	$("#afterElevTotal").text(after_elev_total);
    	$("#total").val(after_elev_total);
    	setFkbl();
    }

  //计算已付款比例
    function setFkbl(){
    	var afterElevTotal = $("#afterElevTotal").text();
    	if(afterElevTotal!=""&&!isNaN(afterElevTotal)){
    		//循环获取当前已付款金额

    		$("#contractNewFKFSTab tr:not(:first)").each(function(){
    		    var kpje=$(this).find("td").eq(6).text();
    		    if(kpje!=""&&!isNaN(kpje)){
                    var je_ = $(this).find("[name='price']").eq(0).val();
                    var pp_ = parseFloat(((parseInt(je_)/parseInt(afterElevTotal))*100).toFixed(2));
                    $(this).find("[name='pay_percent']").eq(0).val(pp_);
				}else{
                    var pp_=converValueToFloat($(this).find("[name='pay_percent']").eq(0).val());
                    var je_=parseFloat((converValueToFloat(afterElevTotal)*(pp_/100)).toFixed(2));
                    $(this).find("[name='price']").eq(0).val(je_);
				}


    		});
    	}
    }
    
    function converValueToFloat(val){
    	if(val==''||isNaN(val)){
    	    return 0;
		}else {
    	    return parseFloat(val);
		}
	}
    
 // 下载文件   e代表当前路径值 
 	function downFile(e) {
 		var downFile = $(e).prev().prev().prev().val();
 		window.location.href = "cell/down?downFile=" + downFile;
 	}
 
 	function CloseSUWin(id) {
		window.parent.$("#" + id).data("kendoWindow").close();
		/* 	window.parent.location.reload(); */
	}
  
	//保存
	function handle(action) {
		if ($("#comment").val()=="") {
			$("#comment").focus();
			$("#comment").tips({
				side: 3,
				msg: "请输入批注",
				bg: '#AE81FF',
				time: 2
			});
			return false;
		}else{
			$("#action").val(action);
		}
	}
</script>
</body>

</html>
