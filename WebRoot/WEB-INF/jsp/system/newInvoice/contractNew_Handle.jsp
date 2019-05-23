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

<body class="gray-bg"  onload="checkOperateType();">

<form action="newInvoice/handleAgent.do" name="handleLeaveForm" id="handelLeaveForm" method="post">
	<input type="hidden" id="task_id" name="task_id" value="${pd.task_id}">
	<input type="hidden" id="id" name="id" value="${pd.id}">
	<input type="hidden" id="action" name="action" value="${pd.action}">
	
	<input type="hidden" name="operateType" id="operateType" value="${operateType}"/>
	<input type="hidden" name="kuaiji" id="kuaiji" value="${kuaiji}"/>
	<input type="hidden" name="EndTask" id="EndTask" value="${EndTask}"/>
       <!-- <button class="btn  btn-success" title="新建" type="button" style="margin-top: 5px;margin-bottom:0px;margin-right:10px;float: right">关闭</button> -->
       <c:if test="${msg!='view'}">
		<input type="button" class="btn  btn-success" title="新建" style="margin-top: 5px;margin-bottom:0px;margin-right:5px;float: right" onclick="save();" value="提交">
        <input type="button" class="btn  btn-success" title="新建" style="margin-top: 5px;margin-bottom:0px;margin-right:5px;float: right" onclick="save();" value="保存">
	   </c:if>
	   
      <!--  <input class="btn  btn-success" title="刷新" type="button" style="margin-top: 5px;margin-bottom:0px;margin-right:5px;float: right" value="附件"> -->
	   
        <input type="hidden" id="invInfoJson" name="invInfoJson">
	    <input type="hidden" id="item_id" name="item_id" value="${headInfo.item_id}">
	    <input type="hidden" id="ht_uuid" name="ht_uuid" value="${headInfo.ht_uuid}">
	        
		<div class="wrapper wrapper-content">
			<div class="row">
				<div class="col-sm-12">
					<div class="ibox float-e-margins">

						<div class="row">
							<div class="col-sm-12">
								<div class="panel panel-primary">
									<div class="panel-heading">项目信息</div>
									<div class="panel-body">
										<div class="form-group form-inline">
											<label style="width: 10%; margin-left: 10px;">合同编号:</label> <input
												style="width: 20%" type="text" name="no"
												readonly="readonly" id="no"
												value="${headInfo.no}" title="项目号"
												class="form-control" /> <label
												style="width: 10%; margin-left: 10px;">客户名称:</label> <input
												style="width: 20%" type="text" name="customer_name"
												readonly="readonly" id="customer_name"
												value="${headInfo.customer_name}" title="客户名称"
												class="form-control" />
												<label
												style="width: 10%; margin-left: 10px;">台数:</label> <input
												style="width: 20%" type="text" name="dt_num"
												readonly="readonly" id="dt_num"
												value="${headInfo.dt_num}" title="台数"
												class="form-control" />
												
										</div>

										<div class="form-group form-inline">
											<label style="width: 10%; margin-left: 10px;">项目名称:</label> <input
												style="width: 20%" type="text" name="item_name"
												readonly="readonly" id="item_name"
												value="${headInfo.item_name}" title="项目名称"
												class="form-control" /> 
												<label style="width: 10%; margin-left: 10px;">安装地址:</label> <input
												style="width: 20%" type="text" name="install_address"
												readonly="readonly" id="install_address"
												value="${headInfo.province_name}${headInfo.city_name}${headInfo.county_name}${address_info}" title="安装地址"
												class="form-control" /> 
										</div>
										
										<div class="form-group form-inline">
											<label style="width: 10%; margin-left: 10px;">合同总额:</label> <input
												style="width: 20%" type="text" name="price"
												readonly="readonly" id="price"
												value="${headInfo.price}" title="合同总额"
												class="form-control" /> <label
												style="width: 10%; margin-left: 10px;">未开票金额:</label> <input
												style="width: 20%" type="text" 
												readonly="readonly" 
												title="未开票金额"
												class="form-control" value="${kpPd.WK_PRICE==null?headInfo.price:kpPd.WK_PRICE}"/>
												<label
												style="width: 10%; margin-left: 10px;">已开票金额:</label> <input
												style="width: 20%" type="text" 
												readonly="readonly" value="${kpPd.YK_PRICE==null?'0':kpPd.YK_PRICE}"
												title="已开票金额"
												class="form-control"/>
										</div>
										
										
										
									</div>
								</div>
							</div>
						</div>


						<div class="row" >
							<div class="col-sm-12">
								<div class="panel panel-primary">
									<div class="panel-heading">应收款信息</div>
									<div class="panel-body">
										<div class="form-group form-inline">
											<table id="yskTable"
												class="table table-striped table-bordered table-hover">
												<tr>
												    <th style="width:5%;"><input type="checkbox" name="zcheckbox" id="zcheckbox" class="i-checks" >
													<th style="width:5%;">期数</th>
													<th style="width:15%;">款项</th>
													<th style="width:15%;">应收金额</th>
													<th style="width:15%;">应收日期</th>
													<th style="width:15%;">偏差天数</th>
													<th style="width:15%;">未开金额</th>
													<th style="width:15%;">已开金额</th>
												</tr>
												<tbody>
										          <!-- 开始循环-->
									<c:choose>
										<c:when test="${not empty yskList}">
										<c:forEach items="${yskList}" var="var">
											<tr>
												<td><input type="checkbox" class="i-checks" name='ids' value='${var.YSK_UUID}'></td>
												<td>${var.YSK_QS}</td>
												<td>
													${var.YSK_KX=='1'?'订金':''}
													${var.YSK_KX=='2'?'排产款':''}
													${var.YSK_KX=='3'?'发货款':''}
													${var.YSK_KX=='4'?'货到现场':''}
													${var.YSK_KX=='5'?'安装发货款':''}
													${var.YSK_KX=='6'?'安装开工款':''}
													${var.YSK_KX=='7'?'验收款':''}
													${var.YSK_KX=='8'?'质保金':''}
													<input type="hidden" value="${var.YSK_KX}">
												</td>
												<td>${var.YSK_YSJE}</td>
												<td>${var.KX_YSRQ}</td>
												<td>${var.YSK_PCTS}</td>
												<td>${var.WK_PRICE==null?var.YSK_YSJE:var.WK_PRICE}</td>
												<td>${var.YK_PRICE==null?'0':var.YK_PRICE}</td>
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
						
						
						<div class="row" >
							<div class="col-sm-12">
								<div class="panel panel-primary">
									<div class="panel-heading">电梯信息</div>
									<div class="panel-body">
										<div class="form-group form-inline">
											<table id="dtInfoTable"
												class="table table-striped table-bordered table-hover">
												<tr>
												   <th style="width:5%;"><input type="checkbox" checked="checked" name="zcheckbox1" id="zcheckbox1" class="i-checks" >
													<th style="width:10%;">梯号</th>
													<th style="width:40%;">梯种</th>
												</tr>
												<tbody>
										          <!-- 开始循环-->
									<c:choose>
										<c:when test="${not empty dtList}">
										<c:forEach items="${dtList}" var="var">
											<tr>
												<td><input type="checkbox" checked="checked" class="i-checks" name='dianti'  value='1' ></td>
												<td>${var.DT_TH}</td>
												<td>${var.DT_TX}</td>
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
                         <!-- <button class="btn  btn-success" title="删除" type="button" style="margin-top: 5px;margin-bottom:0px;float: right" onclick="deleteInv();">删除</button> -->
						<%-- <c:if test="${msg!='view'}">
						<button class="btn  btn-success" title="添加" type="button" style="margin-top: 5px;margin-bottom:0px;margin-right:5px;float: right" onclick="add();">添加</button>
						</c:if> --%>
						<c:if test="${operateType!='CK'}">
						<button class="btn  btn-success" title="添加" type="button" style="margin-top: 5px;margin-bottom:0px;margin-right:5px;float: right" onclick="add();">添加</button>
						</c:if>

						<div class="row">
							<div class="col-sm-12">
								<div class="panel panel-primary">
									<div class="panel-heading">开票信息 </div>
									<%-- <div class="panel-body">
										<div class="form-group form-inline">
											<label style="width: 10%; margin-left: 10px;">已选应收款:</label> <input
												style="width: 20%" type="text" name="selectedYsk"
												readonly="readonly" id="selectedYsk" title="已选应收款"
												class="form-control" /> 
											<label
												style="width: 10%; margin-left: 10px;">本次已开金额:</label> <input
												style="width: 20%" type="text" name="ykPrice"
												readonly="readonly" id="ykPrice"
												value="${info.this_amount}" title="本次已开金额"
												class="form-control" />
											<label
												style="width: 10%; margin-left: 10px;">本次未开金额:</label> <input
												style="width: 20%" type="text" name="wkPrice"
												readonly="readonly" id="wkPrice"
												value="${info.this_no_amount}" title="本次未开金额"
												class="form-control" />
												
										</div> --%>
										
										<div class="form-group form-inline">
											<table id="invTable"
												class="table table-striped table-bordered table-hover">
												<tr>
												    <th style="width:5%;">序号</th>							   
													<th style="width:15%;">型号</th>
													<th style="width:5%;">台数</th>
													<th style="width:15%;">发票类型</th>
													<th style="width:10%;">税率</th>
													<th style="width:10%;">开票金额</th>
													<th style="width:10%;">单价</th>
													<th style="width:10%;">比例</th>
													<th style="width:10%;">款项类型</th>
													<!-- <th style="width:10%;">操作</th> -->
												</tr>
										          <!-- 开始循环-->
									<c:choose>
										<c:when test="${not empty invoiceInfoList}">
											<c:forEach items="${invoiceInfoList}" var="var" varStatus="st">
												<tr>
													<td>
														<input type="hidden" value="${var.id}">
														<input type="hidden" value="${var.ysk_id}">
															${st.index+1}
													</td>
													<td>${var.elev_models}</td>
													<td>${var.elev_num}</td>
													<td>
														<select class='form-control'>
															<option value=''>请选择</option>
															<option value='1' ${var.inv_type=='1'?'selected':''}>增值税专用发票</option>
															<option value='2' ${var.inv_type=='2'?'selected':''}>增值税普通发票</option>
														</select>
													</td>
													<td> <input type="text" name="tax_rate" value="${var.tax_rate}" class="form-control"></td>
													<td><input type="text" class="form-control" value="${var.inv_price}"></td>
													<td>${var.unit_price}</td>
													<td>${var.proportion}</td>
													<td>
														<select class='form-control'>
															<option value=''>请选择</option>
															<option value='1' ${var.price_type=='1'?'selected':''}>订金</option>
															<option value='2' ${var.price_type=='2'?'selected':''}>排产款</option>
															<option value='3' ${var.price_type=='3'?'selected':''}>发货款</option>
															<option value='4' ${var.price_type=='4'?'selected':''}>货到现场</option>
															<option value='5' ${var.price_type=='5'?'selected':''}>安装发货款</option>
															<option value='6' ${var.price_type=='6'?'selected':''}>安装开工款</option>
															<option value='7' ${var.price_type=='7'?'selected':''}>验收款</option>
															<option value="8" ${var.price_type=='8'?'selected':''}>质保金</option>
														</select>
													</td>
												</tr>
											</c:forEach>
										</c:when>
										<c:otherwise>
											<!-- <tr class="main_info">
												<td colspan="100" class="center" >没有相关数据</td>
											</tr> -->
										</c:otherwise>
									</c:choose> 
											</table>
										</div>
										
										<div class="form-group form-inline">
											<label style="width: 10%; margin-left: 10px;">开票主体:</label> 
											 <select class="form-control" name="inv_main" id="inv_main" data-placeholder="开票主体" style="vertical-align:top;width:20%" title="开票主体">
			                                    <option value="1" ${pd1.inv_main=='1'?'selected':''}>东南电梯股份有限公司</option>
			                                    <option value="2" ${pd1.inv_main=='2'?'selected':''}>苏州多美适电梯有限公司</option>
			                                    <option value="3" ${pd1.inv_main=='3'?'selected':''}>苏州杰富电梯有限公司</option>
			                                    <option value="4" ${pd1.inv_main=='4'?'selected':''}>苏州东南电梯安装有限公司</option>
			                                    <option value="5" ${pd1.inv_main=='5'?'selected':''}>多美适网络科技</option>
                                         	</select>
											<label
											style="width: 10%; margin-left: 10px;">购货单位名称:</label> <input
											style="width: 20%" type="text" name="customer"
											 id="customer"
											value="${pd1.customer}" title="购货单位名称"
											class="form-control" />
											<label
											style="width: 10%; margin-left: 10px;">纳税人识别号:</label> <input
											style="width: 20%" type="text" name="duty_para"
											 id="duty_para"
											value="${pd1.duty_para}" title="纳税人识别号"
											class="form-control" />		
										</div>
										
										
										<div class="form-group form-inline">
											<label style="width: 10%; margin-left: 10px;">开票地址:</label> <input
												style="width: 80%" type="text" name="inv_address"
												 id="inv_address"
												value="${pd1.inv_address}" title="开票地址"
												class="form-control" />
												
										</div>
										
										<div class="form-group form-inline">
											<label style="width: 10%; margin-left: 10px;">开户行:</label> <input
												style="width: 20%" type="text" name="bank"
												 id="bank"
												value="${pd1.bank}" title="开户行"
												class="form-control" /> <label
												style="width: 10%; margin-left: 10px;">银行账号:</label> <input
												style="width: 20%" type="text" name="bank_account"
												 id="bank_account"
												value="${pd1.bank_account}" title="银行账号"
												class="form-control" />
												<label
												style="width: 10%; margin-left: 10px;">邮编:</label> <input
												style="width: 20%" type="text" name="postcode"
												 id="postcode"
												value="${pd1.postcode}" title="邮编"
												class="form-control" />
												
										</div>
										
										<div class="form-group form-inline">
											<label style="width: 10%; margin-left: 10px;">邮寄地址:</label> <input
												style="width: 20%" type="text" name="post_address"
												 id="post_address"
												value="${pd1.post_address}" title="邮寄地址"
												class="form-control" /> <label
												style="width: 10%; margin-left: 10px;">收件人:</label> <input
												style="width: 20%" type="text" name="addressee"
												 id="addressee"
												value="${pd1.addressee}" title="收件人"
												class="form-control" />
												<label
												style="width: 10%; margin-left: 10px;">电话:</label> <input
												style="width: 20%" type="text" name="phone"
												 id="phone"
												value="${pd1.phone}" title="电话"
												class="form-control" />
												
										</div>
										
										<div class="form-group form-inline">			
												<label
												style="width: 10%; margin-left: 10px;">备注:</label> <input
												style="width: 80%" type="text" name="remark"
												 id="remark"
												value="${pd1.remark}" title="备注"
												class="form-control" />
												
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	
	

	
	<c:if test="${not empty historys}">
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
                        </c:if>
                        
                    
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
                        
                        <div class="form-group form-inline">
											<label style="width: 10%; margin-left: 10px;">发票号:</label> <input
												style="width: 20%" type="text" name="FPH"
												 id="FPH"
												value="${pd1.FPH}" title="发票号"
												class="form-control" /> <label
												style="width: 10%; margin-left: 10px;">快递单号:</label> <input
												style="width: 20%" type="text" name="KDDH"
												 id="KDDH"
												value="${pd1.KDDH}" title="快递单号"
												class="form-control" />
												<label
												style="width: 10%; margin-left: 10px;">客户接收单上传:</label>
											    <input  type="hidden" name="KHJSDSC" id="KHJSDSC" value="${pd1.KHJSDSC}"/>
												<input style="width:20%" class="form-control" type="file" name="KHJSDSC_TEXT" id="KHJSDSC_TEXT"
														readonly placeholder="这里输入附件" title="附件" onchange="upload(this)" />
												
										</div>    
                        
					<tr>
						<td><button type="submit" class="btn btn-primary"style="width: 150px; height:34px;float:left;"  onclick="return handle('approve');">批准</button></td>
						<td><button type="submit" class="btn btn-danger"style="width: 150px; height:34px;float:right;"  onclick="return handle('reject');">驳回</button></td>
					</tr>
				</div>
			</div>

		</div>
	</div>
	
	
</form>
<script type="text/javascript">
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
	
	
	   function checkOperateType() {
			if($("#operateType").val()=="CK"){
				var inputs = document.getElementsByTagName("input");
				for(var i = 0;i<inputs.length;i++){
					inputs[i].setAttribute("disabled","false");
				}
				
				var selects = document.getElementsByTagName("select");
				for(var i = 0;i<selects.length;i++){
					selects[i].setAttribute("disabled","true");
				}
				if($("#kuaiji").val()=="kuaiji"){
				$("#FPH").removeAttr("disabled")
				$("#KDDH").removeAttr("disabled")
				//$("#KHJSDSC_TEXT").removeAttr("KHJSDSC_TEXT")
				}
				EndTask
				
				if($("#EndTask").val()=="EndTask"){
					$("#KHJSDSC_TEXT").removeAttr("disabled")
					}
				
				$("#task_id").removeAttr("disabled")
				$("#id").removeAttr("disabled")
				$("#action").removeAttr("disabled")
				
				$("#item_id").removeAttr("disabled")
				$("#ht_uuid").removeAttr("disabled")


			}
			layer.close(index);

		}
	   
	   
		//文件异步上传   e代表当前File对象,v代表对应路径值
		function upload(e) {
			var v=$(e).prev().val();
			var filePath = $(e).val();
			var arr = filePath.split("\\");
			var fileName = arr[arr.length - 1];
			var suffix = filePath.substring(filePath.lastIndexOf("."))
					.toLowerCase();
			var fileType = ".xls|.xlsx|.doc|.docx|.txt|.pdf|";
			if (filePath == null || filePath == "") {
				$(e).prev().val("");
				return false;
			}

			//var data = new FormData($("#agentForm")[0]);
			var data = new FormData();

			data.append("file", $(e)[0].files[0]);

			$.ajax({
				url : "houses/upload.do",
				type : "POST",
				data : data,
				cache : false,
				processData : false,
				contentType : false,
				success : function(result) {
					if (result.success) {
						$(e).prev().val(result.filePath);
	                    alert("上传成功！");
	                    $(e).next().next().show();
					} else {
						alert(result.errorMsg);
					}
				}
			});
		}
</script>
</body>

</html>
