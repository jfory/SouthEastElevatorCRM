<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>

<head>

<base href="<%=basePath%>">


<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- Check Box -->
<link href="static/js/iCheck/custom.css" rel="stylesheet">


<title>信息查看</title>
<!-- jsp文件头和头部 -->
<%@ include file="../../system/admin/top.jsp"%>

<!-- iCheck -->
<script src="static/js/iCheck/icheck.min.js"></script>
<!-- 日期控件-->
<script src="static/js/layer/laydate/laydate.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		//loading end
		parent.layer.closeAll('loading');
		/* checkbox */
        $('.i-checks').iCheck({
            checkboxClass: 'icheckbox_square-green',
            radioClass: 'iradio_square-green',
        });
		if ('${msg}'=='view'){
		    $("input").attr("disabled","disabled");
		    $("select").attr("disabled","disabled");
        }
        $("#customer").autocomplete({
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
                //$("#company_property_ordinary").val(ui.item.companyKind);
                //$("#legal_represent_ordinary").val(ui.item.operName);
                //$("#company_phone_ordinary").val(ui.item.telephone);
                $("#duty_para").val(ui.item.businessLienceNum);
                $("#inv_address").val(ui.item.companyAddress);
            }
        });
	});


	//添加
	function add(){
		var yskUUID = "";
		var kxtext="";
		//获取应收款列表选中的行
		$("#yskTable tr:not(:first)").each(function(){
			if($(this).find("td").eq(0).find("input").eq(0).is(":checked")){
				yskUUID = $(this).find("td").eq(0).find("input").eq(0).val();
				//已选应收金额
				var selectedYsk = $(this).find("td").eq(3).text();
				$("#selectedYsk").val(selectedYsk);
				kxtext=$(this).find("td").eq(2).find("input").val();
			}
		});


		//获取电梯信息列表选中的行
		var map = {};
		$("#dtInfoTable tr:not(:first)").each(function(){
			if($(this).find("td").eq(0).find("input").eq(0).is(":checked")){
				//选获取选中行型号
				var model = $(this).find("td").eq(2).text();
				if(map.hasOwnProperty(model)){
					map[model] = parseInt(map[model])+1;
				}else{
					map[model] = 1;
				}
			}
		});

		var invHtml = ""
		var tidx=$("#invTable").find("tr").length;
		for(var key in map){
			invHtml += "<tr>";
			invHtml += "<td><input type='hidden' value=''><input type='hidden' value='"+yskUUID+"'>"+tidx+++"</td>";
			invHtml += "<td>"+key+"</td>";
			invHtml += "<td>"+map[key]+"</td>";
			invHtml += "<td><select class='form-control'><option value=''>请选择</option><option value='1'>增值税专用发票</option><option value='2'>增值税普通发票</option></select></td>";
			invHtml += "<td><input type='text' class='form-control' name='tax_rate'></td>";
			invHtml += "<td><input type='text' class='form-control' onkeyup='setKpPrice(this);'></td>";
			invHtml += "<td></td>";
			invHtml += "<td></td>";
			invHtml += "<td><select class='form-control' id='test'><option value=''>请选择</option><option value='1'>订金</option><option value='2'>排产款</option><option value='3'>发货款</option><option value='4'>货到现场</option><option value='5'>安装发货款</option><option value='6'>安装开工款</option><option value='7'>验收款</option><option value='8'>质保金</option></select></td>";
			invHtml += "<td><button class='btn  btn-danger' title='删除' type='button' style='margin-top: 5px;margin-bottom:0px;float: right' onclick='deleteInv(this);'>删除</button></td>";
			
			invHtml += "</tr>";
		}
		var invdom=$(invHtml);
        $(invdom).find("td").eq(8).find("select").val(kxtext);
		$("#invTable").append(invdom);
	}

	//删除
	function deleteInv(obj){
		 var TOTAL =Number($("#ykPrice").val());
	      var YNum=new Number($(obj).parent().parent().find("td").eq(5).find("input").eq(0).val());//开票金额
	      
	      var a =TOTAL-YNum;
	      $("#ykPrice").val(a);
	      
	      wkPrice = parseInt($("#selectedYsk").val())-parseInt(a);
	      $("#wkPrice").val(wkPrice);
		var tr=obj.parentNode.parentNode;
	      var tbody=tr.parentNode;
	      tbody.removeChild(tr);

	      $("#invTable tr:not(:first)").each(function(idx){
	          $(this).find("td").eq(0).text(idx+1);
		  })
	     
		/* $("#invTable tr:not(:first)").remove(); */
		/*$("#invTable tr:not(:first)").empty().append("<tr class='main_info'><td colspan='100' class='center' >没有相关数据</td></tr>");*/
	}

	//设置开票金额
	function setKpPrice(obj){
		var ts = parseInt($(obj).parent().parent().find("td").eq(2).text());
		var kpPrice = isNaN(parseInt($(obj).val()))?0:parseInt($(obj).val());
		var unitPrice = kpPrice/ts;
		//单价赋值
		$(obj).parent().parent().find("td").eq(6).text(unitPrice);
		//已开金额赋值
		var ykPrice = 0;
		$("#invTable tr:not(:first)").each(function(){
			var kp_ = parseInt($(this).find("td").eq(5).find("input").eq(0).val());
			ykPrice += isNaN(kp_)?0:kp_;
		});
		//未开票金额赋值
		var wkPrice = 0;
		wkPrice = parseInt($("#selectedYsk").val())-parseInt(ykPrice);
		$("#ykPrice").val(ykPrice);
		$("#wkPrice").val(wkPrice);
	}

	//保存
	function save() {

		//处理发票信息
		var invInfoJson = "[";
		$("#invTable tr:not(:first)").each(function(){
			var id_ = $(this).find("td").eq(0).find("input").eq(0).val();
			var yskUUID_ = $(this).find("td").eq(0).find("input").eq(1).val();
			var xh_ = $(this).find("td").eq(1).text();
			var ts_ = $(this).find("td").eq(2).text();
			var lx_ = $(this).find("td").eq(3).find("select").eq(0).val();
			//var sl_ = $(this).find("td").eq(4).text();
			var kpje_ = $(this).find("td").eq(5).find("input").eq(0).val();
			var dj_ = $(this).find("td").eq(6).text();
			var bl_ = $(this).find("td").eq(7).text();
			var kx_ = $(this).find("td").eq(8).find("select").eq(0).val();
			var sl_ = $(this).find("[name='tax_rate']").eq(0).val();

			invInfoJson += "{'id':'"+id_+"','yskUUID_':'"+yskUUID_+"','xh_':'"+xh_+"','ts_':'"+ts_+"','lx_':'"+lx_+"','sl_':'"+sl_+"','kpje_':'"+kpje_+"','dj_':'"+dj_+"','bl_':'"+bl_+"','kx_':'"+kx_+"'},"
		});
        invInfoJson = (invInfoJson.length>1?invInfoJson.substring(0,invInfoJson.length-1): invInfoJson)+"]";
		$("#invInfoJson").val(invInfoJson);
		$("#infoForm").submit();
	}

	function CloseSUWin(id) {
		window.parent.$("#" + id).data("kendoWindow").close();
	}
</script>
</head>

<body class="gray-bg" onload="checkOperateType();">
    
	<form  action="newInvoice/${msg}.do" name="infoForm" id="infoForm"
		method="post">
		<input type="hidden" name="operateType" id="operateType" value="${operateType}"/>
       <!-- <button class="btn  btn-success" title="新建" type="button" style="margin-top: 5px;margin-bottom:0px;margin-right:10px;float: right">关闭</button> -->
       <c:if test="${msg!='view'}">
		<input type="button" class="btn  btn-success" title="新建" style="margin-top: 5px;margin-bottom:0px;margin-right:5px;float: right" onclick="save();" value="提交">
        <input type="button" class="btn  btn-success" title="新建" style="margin-top: 5px;margin-bottom:0px;margin-right:5px;float: right" onclick="save();" value="保存">
	   </c:if>
	   
       <input class="btn  btn-success" title="刷新" type="button" style="margin-top: 5px;margin-bottom:0px;margin-right:5px;float: right" value="附件">
	   
        <input type="hidden" id="invInfoJson" name="invInfoJson">
        <input type="hidden" id="id" name="id" value="${pd.id}">
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
									<div class="panel-body">
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
												
										</div>
										
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
													<th style="width:10%;">操作</th>
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
													<td><button class='btn  btn-danger' title='删除' type='button' style='margin-top: 5px;margin-bottom:0px;float: right' onclick='deleteInv(this);'>删除</button></td>
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
			                                    <option value="1" ${pd.inv_main=='1'?'selected':''}>东南电梯股份有限公司</option>
			                                    <option value="2" ${pd.inv_main=='2'?'selected':''}>苏州多美适电梯有限公司</option>
			                                    <option value="3" ${pd.inv_main=='3'?'selected':''}>苏州杰富电梯有限公司</option>
			                                    <option value="4" ${pd.inv_main=='4'?'selected':''}>苏州东南电梯安装有限公司</option>
			                                    <option value="5" ${pd.inv_main=='5'?'selected':''}>多美适网络科技</option>
                                         	</select>
											<label
											style="width: 10%; margin-left: 10px;">购货单位名称:</label> <input
											style="width: 20%" type="text" name="customer"
											 id="customer"
											value="${pd.customer}" title="购货单位名称"
											class="form-control" />
											<label
											style="width: 10%; margin-left: 10px;">纳税人识别号:</label> <input
											style="width: 20%" type="text" name="duty_para"
											 id="duty_para"
											value="${pd.duty_para}" title="纳税人识别号"
											class="form-control" />		
										</div>
										
										
										<div class="form-group form-inline">
											<label style="width: 10%; margin-left: 10px;">开票地址:</label> <input
												style="width: 80%" type="text" name="inv_address"
												 id="inv_address"
												value="${pd.inv_address}" title="开票地址"
												class="form-control" />
												
										</div>
										
										<div class="form-group form-inline">
											<label style="width: 10%; margin-left: 10px;">开户行:</label> <input
												style="width: 20%" type="text" name="bank"
												 id="bank"
												value="${pd.bank}" title="开户行"
												class="form-control" /> <label
												style="width: 10%; margin-left: 10px;">银行账号:</label> <input
												style="width: 20%" type="text" name="bank_account"
												 id="bank_account"
												value="${pd.bank_account}" title="银行账号"
												class="form-control" />
												<label
												style="width: 10%; margin-left: 10px;">邮编:</label> <input
												style="width: 20%" type="text" name="postcode"
												 id="postcode"
												value="${pd.postcode}" title="邮编"
												class="form-control" />
												
										</div>
										
										<div class="form-group form-inline">
											<label style="width: 10%; margin-left: 10px;">邮寄地址:</label> <input
												style="width: 20%" type="text" name="post_address"
												 id="post_address"
												value="${pd.post_address}" title="邮寄地址"
												class="form-control" /> <label
												style="width: 10%; margin-left: 10px;">收件人:</label> <input
												style="width: 20%" type="text" name="addressee"
												 id="addressee"
												value="${pd.addressee}" title="收件人"
												class="form-control" />
												<label
												style="width: 10%; margin-left: 10px;">电话:</label> <input
												style="width: 20%" type="text" name="phone"
												 id="phone"
												value="${pd.phone}" title="电话"
												class="form-control" />
												
										</div>
										
										<div class="form-group form-inline">			
												<label
												style="width: 10%; margin-left: 10px;">备注:</label> <input
												style="width: 80%" type="text" name="remark"
												 id="remark"
												value="${pd.remark}" title="备注"
												class="form-control" />
												
										</div>
										<c:if test="${operateType=='CK'}">
										<div class="form-group form-inline">
											<label style="width: 10%; margin-left: 10px;">发票号:</label> <input
												style="width: 20%" type="text" name="FPH"
												 id="FPH"
												value="${pd.FPH}" title="发票号"
												class="form-control" /> <label
												style="width: 10%; margin-left: 10px;">快递单号:</label> <input
												style="width: 20%" type="text" name="KDDH"
												 id="KDDH"
												value="${pd.KDDH}" title="快递单号"
												class="form-control" />
												<label
												style="width: 10%; margin-left: 10px;">客户接收单上传:</label>
											    <input  type="hidden" name="KHJSDSC" id="KHJSDSC" value="${pd.KHJSDSC}"/>
												<input style="width:20%" class="form-control" type="file" name="KHJSDSC_TEXT" id="KHJSDSC_TEXT"
														readonly placeholder="这里输入附件" title="附件" onchange="upload(this)" />
												
										</div>   
										</c:if> 
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
	<script type="text/javascript">
	
    /* checkbox全选 */
    $("#zcheckbox1").on('ifChecked', function (event) {
        $('dianti').iCheck('check');
    });
    /* checkbox取消全选 */
    $("#zcheckbox1").on('ifUnchecked', function (event) {
        $('dianti').iCheck('uncheck');
    });
    
    
    function checkOperateType() {
		if($("#operateType").val()=="CK"){
			var inputs = document.getElementsByTagName("input");
			for(var i = 0;i<inputs.length;i++){
				inputs[i].setAttribute("disabled","true");
			}
			var textareas = document.getElementsByTagName("textarea");
			for(var i = 0;i<textareas.length;i++){
				textareas[i].setAttribute("disabled","true");
			}
			var selects = document.getElementsByTagName("select");
			for(var i = 0;i<selects.length;i++){
				selects[i].setAttribute("disabled","true");
			}
		}
		layer.close(index);

	}
    
	</script>
	
</body>

</html>
