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


<title>${pd.SYSNAME}</title>
<!-- jsp文件头和头部 -->
<%@ include file="../../system/admin/top.jsp"%>
<!-- Fancy box -->
<script src="static/js/fancybox/jquery.fancybox.js"></script>
 <link href="static/js/sweetalert2/sweetalert2.css" rel="stylesheet">
<link href="static/js/fancybox/jquery.fancybox.css" rel="stylesheet">
<link type="text/css" rel="stylesheet"
	href="plugins/zTree/3.5.24/css/zTreeStyle/zTreeStyle.css" />
<script type="text/javascript"
	src="plugins/zTree/3.5.24/js/jquery.ztree.core.js"></script>
<script type="text/javascript"
	src="plugins/zTree/3.5.24/js/jquery.ztree.excheck.js"></script>
<script type="text/javascript"
	src="plugins/zTree/3.5.24/js/jquery.ztree.exedit.js"></script>


<!-- 日期控件-->
<script src="static/js/layer/laydate/laydate.js"></script>
<script type="text/javascript">
     $(document).ready(function () {
            /* 图片 */
            $('.fancybox').fancybox({
                openEffect: 'none',
                closeEffect: 'none'
            });
        });
    /*  function hasShop()
     {
    	 alert("a");
    	 var item_no = $("#item_no").val(); //获取项目的编号
 		$("#Special").val(null);    //设置文本框值为null
 		$("#General").val(null);    //设置文本框值为null
 		$.ajax({
 			url : "contract/checkedoffer.do", //请求地址
 			type : "POST", //请求方式
 			data : {
 				'item_no' : item_no   //请求参数
 			}, //请求参数
 			success : function(result) {
 				var json=result.offer.elevator_info;
 				var obj = eval("("+json+")");
 				for(var i=0;i<obj.length;i++)
 				{
 					if(obj[i].elevatorType==3)
 					{
 						$("#Special").val("no");  //如果梯种包含3（特种梯）走特种梯流程
 					}
 					else if(obj[i].elevatorType==1)
 					{
 						$("#General").val("yes");  //如果梯种包含1（常规梯）走常规梯流程
 					}
 					else if(obj[i].elevatorType==2)
 					{
 						$("#General").val("yes");  //如果梯种包含2（常规梯）走常规梯流程
 					}
 					else if(obj[i].elevatorType==4)
 					{
 						$("#General").val("yes");  //如果梯种包含4（常规梯）走常规梯流程
 					}
 				}
 			}
 		});
     } */
     
     
     
        //保存
        function save(){
            if ($("#con_name").val()=="" && $("#con_name").val()=="") 
            {
                $("#con_name").focus();
            	$("#con_name").tips({
                    side: 3,
                    msg: "请输入合同名称",
                    bg: '#AE81FF',
                    time: 3
                });
              
                return false;
            }

            if ($("#con_is_contained").val()=="" && $("#con_is_contained").val()=="") 
            {
                $("#con_is_contained").focus();
            	$("#con_is_contained").tips({
                    side: 3,
                    msg: "请选择是否包含装梯",
                    bg: '#AE81FF',
                    time: 3
                });
              
                return false;
            }
            if ($("#con_EndTime").val()=="" && $("#con_EndTime").val()=="") 
            {
                $("#con_EndTime").focus();
            	$("#con_EndTime").tips({
                    side: 3,
                    msg: "请选择合同结束时间",
                    bg: '#AE81FF',
                    time: 3
                });
              
                return false;
            }

            if ($("#ow_SignedTime").val()=="" && $("#ow_SignedTime").val()=="") 
            {
                $("#ow_SignedTime").focus();
            	$("#ow_SignedTime").tips({
                    side: 3,
                    msg: "请选择签订日期",
                    bg: '#AE81FF',
                    time: 3
                });
              
                return false;
            } 
      	$("#cellForm").submit();      
        }
        
	
	//文件异步上传   e代表当前File对象,v代表对应路径值
	function upload(e,v) {
		var filePath = $(e).val();
		var arr = filePath.split("\\");
		var fileName = arr[arr.length - 1];
		var suffix = filePath.substring(filePath.lastIndexOf("."))
				.toLowerCase();
		var fileType = ".xls|.xlsx|.doc|.docx|.txt|.pdf|";
		if (filePath == null || filePath == "") {
			$(v).val("");
			return false;
		}

		//var data = new FormData($("#agentForm")[0]);
		var data = new FormData();
		data.append("file", $(e)[0].files[0]);
		$.ajax({
			url : "contract/upload.do",
			type : "POST",
			data : data,
			cache : false,
			processData : false,
			contentType : false,
			success : function(result) {
				if (result.success) {
					$(v).val(result.filePath);
				} else {
					alert(result.errorMsg);
				}
			}
		});
	}
	// 下载文件   e代表当前路径值 
	function downFile(e) {
		var downFile = $(e).val();
		window.location.href = "contract/down?downFile=" + downFile;
	}
	
	
   
	  //日期范围限制
	    var start = {
	        elem: '#start_time',
	        format: 'YYYY/MM/DD hh:mm:ss',
	        max: '2099-06-16 23:59:59', //最大日期
	        istime:true,
	        istoday: false,
	        choose: function (datas) {
	            end.min = datas; //开始日选好后，重置结束日的最小日期
	            end.start = datas //将结束日的初始值设定为开始日
	        }
	    };
	    var end = {
	        elem: '#end_time',
	        format: 'YYYY/MM/DD hh:mm:ss',
	        max: '2099-06-16 23:59:59',
	        istime: true,
	        istoday: false,
	        choose: function (datas) {
	            start.max = datas; //结束日选好后，重置开始日的最大日期
	        }
	    };
	    laydate(start);
	    laydate(end);
	    
	    function CloseSUWin(id) {
			window.parent.$("#" + id).data("kendoWindow").close();
			/* 	window.parent.location.reload(); */
		}
</script>
</head>
<body class="gray-bg">
	<form action="contract/${msg}.do" name="cellForm" id="cellForm"
		method="post">
		<input type="hidden" name="con_id"id="con_id" value="${pd.con_id}" />
		<input type="hidden" name="item_no"id="item_no" value="${pd.item_no}" />
		 <!-- 项目是否包含特种梯 -->
		<input type="hidden" name="Special"id="Special"/>  
		 <!-- 项目是否包含常规梯 -->
		<input type="hidden" name="General"id="General"/>  
		<input type="hidden" name="con_process_key"id="con_process_key" value="${pd.con_process_key}" />
		<input type="hidden" name="con_special_key"id="con_special_key" value="${pd.con_special_key}" />
		<div class="wrapper wrapper-content">
			<div class="row">
				<div class="col-sm-12">
					<div class="ibox float-e-margins">
						<div class="ibox-content1">
								<div class="panel panel-primary">
									<div class="panel-heading">合同信息</div>
									<div class="panel-body">
									<div class="row" style="margin-left: 10px">
										<div class="form-group form-inline">
										<span style="color: red;">*</span>
												<label style="width: 15%">合同名称:</label>
													<input style="width: 30%" type="text" name="con_name"
														id="con_name" value="${pd.con_name}" onblur="hasShop()"
														placeholder="这里输入合同名称" title="合同名称"  class="form-control" />
												<span type="hidden">&nbsp&nbsp&nbsp</span>
												<span style="color: red;">*</span>
												<label style="width: 15%">项目名称:</label> 
												 <input style="width: 30%" type="text" name="item_name" readonly="readonly"
														id="item_name" value="${pd.item_name}"
														placeholder="这里输入项目名称" title="项目名称" class="form-control" />
												 </div>
											<div class="form-group form-inline">
											<span style="color: red;">*</span>
											<label style="width: 15%">是否包含安装:</label>
												<select
													style="width: 30%" class="form-control"
													name="con_is_contained" readonly id="con_is_contained">
													<option value="">请选择</option>
													<option value="1" <c:if test="${pd.con_is_contained =='1'}"> selected</c:if>>是</option>
													<option value="2" <c:if test="${pd.con_is_contained =='2'}"> selected</c:if>>否</option>
												</select> 
											<label style="width: 15%;margin-left:24px;">安装价格:</label>
												 <input style="width: 30%" type="text" name="install_price"
														id="install_price" value="${pd.install_price}"
														placeholder="这里输入安装价格" title="安装价格" class="form-control" />
										    </div>
										    <div class="form-group form-inline">
												 <label style="width:15%;margin-left:10px;">安装条款:</label>
												 <textarea rows="3" cols="64" name="install_clause" id="install_clause" 
												 placeholder="这里输入安装条款" class="form-control">${pd.install_clause }</textarea>
											</div>
											<div class="form-group form-inline">
												 <label style="width:15%;margin-left:10px;">合同条款:</label>
												 <textarea rows="3" cols="64" name="item_content" id="item_content" placeholder="这里输入合同条款" class="form-control">${pd.item_content }</textarea>
											</div>
											<div class="form-group form-inline">
												 <label style="width: 15%;margin-left:10px;">合同金额:</label>
												 <input style="width: 30%" type="text" name="item_total" readonly="readonly"
														id="item_total" value="${pd.item_total}"
														placeholder="这里输入合同金额" title="合同金额" class="form-control" />
												<label style="width: 15%;margin-left:24px;">付款方式:</label> <input
													style="width: 30%" type="text" type="text"
													name="con_Payment" id="con_Payment"
													value="${pd.con_Payment}" placeholder="这里输入付款方式"
													title="付款方式" class="form-control">
													</div>
												<div class="form-group form-inline">
												<label style="width: 15%;margin-left:10px;">工期:</label> <input
													style="width: 30%" type="text" type="text"
													name="con_Duration" id="con_Duration"
													value="${pd.con_Duration}" placeholder="这里输入工期"
													title="工期" class="form-control">
													<span type="hidden">&nbsp&nbsp&nbsp</span>
													<span style="color: red;">*</span>
												<label style="width: 15%">合同结束时间:</label> <input
													style="width: 30%" type="text" type="text"
													name="con_EndTime" id="con_EndTime" readonly
													value="${pd.con_EndTime}" placeholder="这里输入合同结束时间"
													title="合同结束时间" onclick="laydate()" class="form-control">
											    </div>
												<div class="form-group form-inline">
												 	<label style="width: 15%;margin-left:10px;">合同类型:</label> <input
													style="width: 30%" type="text" type="text"
													name="con_type" id="con_type"
													value="${pd.con_type}" placeholder="这里输入合同类型"
													title="合同类型" class="form-control">
													<label style="width: 15%;margin-left:24px;">备注:</label> <input
													style="width: 30%" type="text" type="text"
													name="con_remarks" id="con_remarks"
													value="${pd.con_remarks}" placeholder="这里输入备注"
													title="备注" class="form-control">
												</div>
									<!-- 上传文件 -->
											<div class="form-group form-inline">
												<label style="width: 15%;margin-left:10px;">上传技术规格表:</label>
												 <input class="form-control" style="width: 30%" type="hidden" name="con_technology" id="con_technology"  
												 placeholder="这里输入附件" value="${pd.con_technology}" title="附件" /> 
												 <input style="width: 30%" class="form-control" type="file" name="technology" id="technology" 
												readonly placeholder="这里输入附件" title="附件" onchange="upload(this,$('#con_technology'))" />
												<c:if
													test="${pd ne null and pd.con_technology ne null and pd.con_technology ne '' }">
													<a class="btn btn-mini btn-success"
														onclick="downFile($('#con_technology'))">下载附件</a>
												</c:if>
												<label style="width: 15%;margin-left:24px;">上传土建图:</label>
												 <input class="form-control" style="width: 30%" type="hidden" name="con_build" id="con_build"  
												 placeholder="这里输入附件" value="${pd.con_build}" title="附件" /> 
												 <input style="width: 30%" class="form-control" type="file" name="build" id="build" 
												readonly placeholder="这里输入附件" title="附件" onchange="upload(this,$('#con_build'))" />
												<c:if
													test="${pd ne null and pd.con_build ne null and pd.con_build ne '' }">
													<a class="btn btn-mini btn-success"
														onclick="downFile($('#con_build'))">下载附件</a>
												</c:if>
											</div>
											<div class="form-group form-inline">
									<!-- 上传文件 -->
												<label style="width: 15%;margin-left:10px;">上传商务条款:</label>
												 <input class="form-control" style="width: 30%" type="hidden" name="con_standard" id="con_standard"  
												 placeholder="这里输入附件" value="${pd.con_standard}" title="附件" /> 
												 <input style="width: 30%" class="form-control" type="file" name="standard" id="standard" 
												readonly placeholder="这里输入附件" title="附件" onchange="upload(this,$('#con_standard'))" />
												<c:if
													test="${pd ne null and pd.con_standard ne null and pd.con_standard ne '' }">
													<a class="btn btn-mini btn-success"
														onclick="downFile($('#con_standard'))">下载附件</a>
												</c:if>
												
												<label style="width: 15%;margin-left:24px;">上传价格审批表:</label>
												 <input class="form-control" style="width: 30%" type="hidden" name="con_tariff" id="con_tariff"  
												 placeholder="这里输入附件" value="${pd.con_tariff}" title="附件" /> 
												 <input style="width: 30%" class="form-control" type="file" name="tariff" id="tariff" 
												readonly placeholder="这里输入附件" title="附件" onchange="upload(this,$('#con_tariff'))" />
												<c:if
													test="${pd ne null and pd.con_tariff ne null and pd.con_tariff ne '' }">
													<a class="btn btn-mini btn-success"
														onclick="downFile($('#con_tariff'))">下载附件</a>
												</c:if>
											</div>
											<div class="form-group form-inline">
									<!-- 上传文件 -->
												<label style="width: 15%;margin-left:10px;">招投标文件:</label>
												 <input class="form-control" style="width: 30%" type="hidden" name="con_bidding" id="con_bidding"  
												 placeholder="这里输入附件" value="${pd.con_bidding}" title="附件" /> 
												 <input style="width: 30%" class="form-control" type="file" name="bidding" id="bidding" 
												readonly placeholder="这里输入附件" title="附件" onchange="upload(this,$('#con_bidding'))" />
												<c:if
													test="${pd ne null and pd.con_bidding ne null and pd.con_bidding ne '' }">
													<a class="btn btn-mini btn-success"
														onclick="downFile($('#con_bidding'))">下载附件</a>
												</c:if>
												
												<label style="width: 15%;margin-left:24px;">附件:</label>
												 <input class="form-control" style="width: 30%" type="hidden" name="con_adjunct" id="con_adjunct"  
												 placeholder="这里输入附件" value="${pd.con_adjunct}" title="附件" /> 
												 <input style="width: 30%" class="form-control" type="file" name="houseimg" id="houseimg" 
												readonly placeholder="这里输入附件" title="附件" onchange="upload(this,$('#con_adjunct'))" />
												<c:if
													test="${pd ne null and pd.con_adjunct ne null and pd.con_adjunct ne '' }">
													<a class="btn btn-mini btn-success"
														onclick="downFile($('#con_adjunct'))">下载附件</a>
												</c:if>
											</div>
											<div class="form-group form-inline">
											<!-- 上传文件 -->
												<label style="width: 15%;margin-left:10px;">设备合同文本:</label>
												 <input class="form-control" style="width: 30%" type="hidden" name="facility_contract" id="facility_contract"  
												 placeholder="这里输入附件" value="${pd.facility_contract}" title="附件" /> 
												 <input style="width: 30%" class="form-control" type="file" name="facility" id="facility" 
												readonly placeholder="这里输入附件" title="附件" onchange="upload(this,$('#facility_contract'))" />
												<c:if
													test="${pd ne null and pd.facility_contract ne null and pd.facility_contract ne '' }">
													<a class="btn btn-mini btn-success"
														onclick="downFile($('#facility_contract'))">下载附件</a>
												</c:if>
												<label style="width: 15%;margin-left:24px;">安装合同文本:</label>
												 <input class="form-control" style="width: 30%" type="hidden" name="install_contract" id="install_contract"  
												 placeholder="这里输入附件" value="${pd.install_contract}" title="附件" /> 
												 <input style="width: 30%" class="form-control" type="file" name="install" id="install" 
												readonly placeholder="这里输入附件" title="附件" onchange="upload(this,$('#install_contract'))" />
												<c:if
													test="${pd ne null and pd.install_contract ne null and pd.install_contract ne '' }">
													<a class="btn btn-mini btn-success"
														onclick="downFile($('#install_contract'))">下载附件</a>
												</c:if>
											</div>
											<div class="form-group form-inline">
												 <label style="width: 15%;margin-left:10px;">甲方:</label>
												 <input style="width: 30%" type="text" name="owner"
														id="owner" value="${pd.owner}"
														placeholder="这里输入甲方" title="甲方" class="form-control"/>
												<label style="width: 15%;margin-left:24px;">乙方:</label> <input
													style="width: 30%" type="text" type="text"
													name="second" id="second"
													value="${pd.second}" placeholder="这里输入乙方"
													title="乙方" class="form-control">
										   </div>
										   <div class="form-group form-inline">
												 <label style="width: 15%;margin-left:10px;">地址:</label>
												 <input style="width: 30%" type="text" name="ow_address"
														id="ow_address" value="${pd.ow_address}"
														placeholder="这里输入地址" title="地址" class="form-control" />
												<label style="width: 15%;margin-left:24px;">地址:</label> <input
													style="width: 30%" type="text" type="text"
													name="se_address" id="se_address"
													value="${pd.se_address}" placeholder="这里输入地址"
													title="地址" class="form-control">
										   </div>
											<div class="form-group form-inline">
												 <label style="width: 15%;margin-left:10px;">法定代表人:</label>
												 <input style="width: 30%" type="text" name="ow_representative"
														id="ow_representative" value="${pd.ow_representative}"
														placeholder="这里输入法定代表人" title="法定代表人" class="form-control" />
												<label style="width: 15%;margin-left:24px;">法定代表人:</label> <input
													style="width: 30%" type="text" type="text"
													name="se_representative" id="se_representative"
													value="${pd.se_representative}" placeholder="这里输入法定代表人"
													title="法定代表人" class="form-control">
										   </div>
											<div class="form-group form-inline">
												 <label style="width: 15%;margin-left:10px;">委托代理人:</label>
												 <input style="width: 30%" type="text" name="ow_entrusted"
														id="ow_entrusted" value="${pd.ow_entrusted}"
														placeholder="这里输入委托代理人" title="委托代理人"  class="form-control" />
												<label style="width: 15%;margin-left:24px;">委托代理人:</label> <input
													style="width: 30%" type="text" type="text"
													name="se_entrusted" id="se_entrusted"
													value="${pd.se_entrusted}" placeholder="这里输入委托代理人"
													title="委托代理人" class="form-control">
										   </div>
										   <div class="form-group form-inline">
												 <label style="width: 15%;margin-left:10px;">电话:</label>
												 <input style="width: 30%" type="text" name="ow_phone"
														id="ow_phone" value="${pd.ow_phone}"
														placeholder="这里输入电话" title="电话"  class="form-control" />
												<label style="width: 15%;margin-left:24px;">电话:</label> <input
													style="width: 30%" type="text" type="text"
													name="se_phone" id="se_phone"
													value="${pd.se_phone}" placeholder="这里输入电话"
													title="电话" class="form-control">
										   </div>
										   <div class="form-group form-inline">
												 <label style="width: 15%;margin-left:10px;">传真:</label>
												 <input style="width: 30%" type="text" name="ow_faxes"
														id="ow_faxes" value="${pd.ow_faxes}"
														placeholder="这里输入传真" title="传真"  class="form-control" />
												<label style="width: 15%;margin-left:24px;">传真:</label> <input
													style="width: 30%" type="text" type="text"
													name="se_faxes" id="se_faxes"
													value="${pd.se_faxes}" placeholder="这里输入传真"
													title="传真" class="form-control">
										   </div>
										   <div class="form-group form-inline">
												 <label style="width: 15%;margin-left:10px;">开户银行:</label>
												 <input style="width: 30%" type="text" name="ow_bank"
														id="ow_bank" value="${pd.ow_bank}"
														placeholder="这里输入开户银行" title="开户银行"  class="form-control" />
												<label style="width: 15%;margin-left:24px;">开户银行:</label> <input
													style="width: 30%" type="text" type="text"
													name="se_bank" id="se_bank"
													value="${pd.se_bank}" placeholder="这里输入开户银行"
													title="开户银行" class="form-control">
										   </div>
										   <div class="form-group form-inline">
												 <label style="width: 15%;margin-left:10px;">帐号:</label>
												 <input style="width: 30%" type="text" name="ow_accounts"
														id="ow_accounts" value="${pd.ow_accounts}"
														placeholder="这里输入帐号" title="帐号"  class="form-control" />
												<label style="width: 15%;margin-left:24px;">帐号:</label> <input
													style="width: 30%" type="text" type="text"
													name="se_accounts" id="se_accounts"
													value="${pd.se_accounts}" placeholder="这里输入帐号"
													title="帐号" class="form-control">
										   </div>
										   <div class="form-group form-inline">
										   <span style="color: red;">*</span>
												 <label style="width: 15%">签订日期:</label>
												 <input style="width: 30%" type="text" name="ow_SignedTime"
														id="ow_SignedTime" value="${pd.ow_SignedTime}" readonly
														placeholder="这里输入签订日期" title="签订日期" onclick="laydate()" class="form-control" />
										   </div>
										</div>
									</div>
								</div>
							<tr>
								<td><a class="btn btn-primary"
									style="width: 150px; height: 34px; float: left;"
									onclick="save();">保存</a></td>
								<td>
							<a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('EditItem');">关闭</a>
						        </td>
							</tr>
						</div>
				</div>
			</div>
	</form>
<script type="text/javascript">
$(document).ready(function hasShop(){
   	 var item_no = $("#item_no").val(); //获取项目的编号
		$("#Special").val(null);    //设置文本框值为null
		$("#General").val(null);    //设置文本框值为null
		$.ajax({
			url : "contract/checkedoffer.do", //请求地址
			type : "POST", //请求方式
			data : {
				'item_no' : item_no   //请求参数
			}, //请求参数
			success : function(result) {
				var json=result.offer.elevator_info;
				var obj = eval("("+json+")");
				for(var i=0;i<obj.length;i++)
				{
					if(obj[i].elevatorType==3)
					{
						$("#Special").val("no");  //如果梯种包含3（特种梯）走特种梯流程
					}
					else if(obj[i].elevatorType==1)
					{
						$("#General").val("yes");  //如果梯种包含1（常规梯）走常规梯流程
					}
					else if(obj[i].elevatorType==2)
					{
						$("#General").val("yes");  //如果梯种包含2（常规梯）走常规梯流程
					}
					else if(obj[i].elevatorType==4)
					{
						$("#General").val("yes");  //如果梯种包含4（常规梯）走常规梯流程
					}
				}
			}
		});
    })
    
	</script>
</body>
</html>
