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
    <!-- ztree样式 -->
    
<link type="text/css" rel="stylesheet"
	href="plugins/zTree/3.5.24/css/zTreeStyle/zTreeStyle.css" />
    <style type="text/css">
		.ztree li span.button.add {
			margin-left: 2px;
			margin-right: -1px;
			background-position: -144px 0;
			vertical-align: top;
			*vertical-align: middle
		}
	</style>
	<!-- jsp文件头和头部 -->
	<%@ include file="../../system/admin/top.jsp"%> 
	<!-- 日期控件-->
    <script src="static/js/layer/laydate/laydate.js"></script>
	<script type="text/javascript">
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
 //   laydate(start);
//    laydate(end);
	
	function showAddType(){
		if($("#operateType").val()=='add'){
			$("#operateDec").show();
			$("#ordinary").show();
			$("#merchant").hide();
			$("#core").hide();
			$("#dec2").hide();
			$("#dec3").hide();
		}else if($("#operateType").val()=='sel'){
			var inputs = document.getElementsByTagName("input");
			if($("#decisionFlag2").val()!=1){
				$("#dec2").hide();
			}
			if($("#decisionFlag3").val()!=1){
				$("#dec3").hide();
			}
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
		}else if($("#operateType").val()=='edit'){
			$("#operateDec").show();
			if($("#decisionFlag2").val()==1){
				document.getElementById("dec2").style.display="block";
				$("#dec2").show();
			}
			if($("#decisionFlag3").val()==1){
				document.getElementById("dec3").style.display="block";
				$("#dec3").show();
			}
		}
	}
	
	//添加决策层
	function addDec(){
		for(var i=1;i < document.getElementsByName('dec').length;i++){
			  if(document.getElementsByName('dec')[i].style.display=='none'){
			  	  document.getElementsByName('dec')[i].style.display='block';
			  	  return;
			  }
		}
	}
	
	//删除决策层
	function delDec(){
		for(var i=document.getElementsByName('dec').length-1;i>=0;i--){
			   if(document.getElementsByName('dec')[i].style.display=='block'){
			  	  document.getElementsByName('dec')[i].style.display='none';
			  	  var inputs = document.getElementsByName('dec')[i].getElementsByTagName("input");
			  	  var textareas = document.getElementsByName('dec')[i].getElementsByTagName("textarea");
			  	  for(var j=0;j<inputs.length;j++){
			  		  inputs[j].value="";
			  	  }
			  	 for(var j=0;j<inputs.length;j++){
			  		  textareas[j].value="";
			  	  }
			  	  return;
			  }
		}
	}
	
	//新增
	function showAddCustomerType(){
		if($("#CustomerType").val()==1){
			$("#customer_add_type").val("Ordinary");
			$("#ordinary").show();
			$("#merchant").hide();
			$("#person").hide();
		}else if($("#CustomerType").val()==2){
			$("#customer_add_type").val("Merchant");
			$("#ordinary").hide();
			$("#merchant").show();
			$("#person").hide();
		}else if($("#CustomerType").val()==3){
			$("#customer_add_type").val("Person");
			$("#ordinary").hide();
			$("#merchant").hide();
			$("#person").show();
		}
	}
	//保存
	function save(){
		var ordinary;
		var merchant;
		if($("#customer_update_type").val()=='Ordinary'||$("#operateType").val()=='add'){
			ordinary = document.getElementById("ordinary").style.display;
		}
		if($("#customer_update_type").val()=='Merchant'||$("#operateType").val()=='add'){
			merchant = document.getElementById("merchant").style.display;
		}
		if(ordinary=='block'||ordinary==''){
			$("#customer_name_ordinary").focus();
			if($("#customer_name_ordinary").val()==""){
				$("#customer_name_ordinary").tips({
					side:3,
		            msg:"输入客户名称",
		            bg:'#AE81FF',
		            time:2
		        });
				return false;
			}
			$("#customer_trade_ordinary").focus();
			if($("#customer_trade_ordinary").val()==""){
				$("#customer_trade_ordinary").tips({
					side:3,
		            msg:"选择客户行业",
		            bg:'#AE81FF',
		            time:2
		        });
				return false;
			}
			$("#company_phone_ordinary").focus();
			if($("#company_phone_ordinary").val()==""){
				$("#company_phone_ordinary").tips({
					side:3,
		            msg:"输入公司电话",
		            bg:'#AE81FF',
		            time:2
		        });
				return false;
			}
			$("#is_core_ordinary").focus();
			if($("#is_core_ordinary").val()==""){
				$("#is_core_ordinary").tips({
					side:3,
		            msg:"选择是否战略用户",
		            bg:'#AE81FF',
		            time:2
		        });
				return false;
			}
			$("#customer_contact_ordinary").focus();
			if($("#customer_contact_ordinary").val()==""){
				$("#customer_contact_ordinary").tips({
					side:3,
		            msg:"输入联系人",
		            bg:'#AE81FF',
		            time:2
		        });
				return false;
			}
			$("#contact_phone_ordinary").focus();
			if($("#contact_phone_ordinary").val()==""){
				$("#contact_phone_ordinary").tips({
					side:3,
		            msg:"输入联系人电话",
		            bg:'#AE81FF',
		            time:2
		        });
				return false;
			}
		}else if(merchant=='block'||merchant==''){
			$("#customer_name_merchant").focus();
			if($("#customer_name_merchant").val()==""){
				$("#customer_name_merchant").tips({
					side:3,
		            msg:"输入姓名",
		            bg:'#AE81FF',
		            time:2
		        });
				return false;
			}
			/* $("#is_core_merchant").focus();
			if($("#is_core_merchant").val()==""){
				$("#is_core_merchant").tips({
					side:3,
		            msg:"选择是否战略用户",
		            bg:'#AE81FF',
		            time:2
		        });
				return false;
			} */
			$("#customer_contact_merchant").focus();
			if($("#customer_contact_merchant").val()==""){
				$("#customer_contact_merchant").tips({
					side:3,
		            msg:"输入联系人",
		            bg:'#AE81FF',
		            time:2
		        });
				return false;
			}
			$("#contact_phone_merchant").focus();
			if($("#contact_phone_merchant").val()==""){
				$("#contact_phone_merchant").tips({
					side:3,
		            msg:"输入联系人电话",
		            bg:'#AE81FF',
		            time:2
		        });
				return false;
			}
			//检查楼盘信息
			var pName = $("table").find("tr").eq(1).find("td").eq(0).find("input").eq(0);
			var pDescript = $("table").find("tr").eq(1).find("td").eq(1).find("input").eq(0);
			pName.focus();
			if(pName.val()==""){
				pName.tips({
					side:3,
		            msg:"至少输入一个项目/楼盘信息",
		            bg:'#AE81FF',
		            time:2
		        });
				return false;
			}
			pDescript.focus();
			if(pDescript.val()==""){
				pDescript.tips({
					side:3,
		            msg:"输入项目描述",
		            bg:'#AE81FF',
		            time:2
		        });
				return false;
			}

		}
		//处理小业主楼盘信息
		$("#house_no_merchant").val($("#house_no_text_merchant").val());
		//处理小业主项目信息
		var project_name = "";
		var project_descript = "";
		var jsonStr = "[";
		$("#itemTable tr:not(:first)").each(function(){
			project_name = $(this).find("td").eq(0).find("input").eq(0).val();
			project_descript = $(this).find("td").eq(1).find("input").eq(0).val();
			jsonStr += "{\'project_name\':\'"+project_name+"\',\'project_descript\':\'"+project_descript+"\'},";
		});
		jsonStr = jsonStr.substring(0,jsonStr.length-1)+"]";
		$("#customer_project_merchant").val(jsonStr);
		$("#customerForm").submit();
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
        
        //var data = new FormData($("#agentForm")[0]);
        var data = new FormData();
        
        data.append("file", $(e)[0].files[0]);
        
        $.ajax({
            url:"customer/upload.do",
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
        window.location.href="customer/down?downFile="+downFile;
    }
		
	function CloseSUWin(id) {
		window.parent.$("#" + id).data("kendoWindow").close();
		/* 	window.parent.location.reload(); */
	}

	//检测客户名称
	function checkCustomerName(type){
		var operateType = $("#operateType").val();
		var old_customer_name;
		var customer_name;
		if(type=='Ordinary'){
			customer_name = $("#customer_name_ordinary").val();
			old_customer_name = $("#old_customer_name_ordinary").val();
		}else if(type=='Merchant'){
			customer_name = $("#customer_name_merchant").val();
			old_customer_name = $("#old_customer_name_merchant").val();
		}else if(type=='Core'){
			customer_name = $("#customer_name_core").val();
			old_customer_name = $("#old_customer_name_core").val();
		}
		var url = "<%=basePath%>customer/checkName.do?customer_name="+customer_name+"&customer_type="+type+"&old_customer_name="+old_customer_name+"&operateType="+operateType;
		$.post(
			url,
			function(data){
				if(data.msg=='success'){
				}else if(data.msg=='error'){
					if(type=='Ordinary'){
						$("#customer_name_ordinary").focus();
						$("#customer_name_ordinary").tips({
							side:3,
				            msg:"该客户名称已存在",
				            bg:'#AE81FF',
				            time:2
				        });
				    }else if(type=='Merchant'){
						$("#customer_name_merchant").focus();
						$("#customer_name_merchant").tips({
							side:3,
				            msg:"该客户名称已存在",
				            bg:'#AE81FF',
				            time:2
				        });
					}else if(type=='Core'){
						$("#customer_name_core").focus();
						$("#customer_name_core").tips({
							side:3,
				            msg:"该客户名称已存在",
				            bg:'#AE81FF',
				            time:2
				        });
					}
				}
			}
		);
	}

	//添加行,录入业主开发的项目信息
	function addRow(){
		var tr = $("table tr").eq(1).clone();
		$(tr).find("td").eq(0).find("input").eq(0).val("");
		$(tr).find("td").eq(1).find("input").eq(0).val("");
		$(tr).find("td:last").html("").append("<td><input type='button' value='删除' onclick='delRow(this)'></td>");
		$("#itemTable").append(tr);
	}

	//删除行
	function delRow(obj){
		$(obj).parent().parent().parent().remove();
	}

    function getMaterialInfos(e) {
        var $customer_name_ordinary = $("#customer_name_ordinary");

        $("#customer_name_ordinary").autocomplete({
            source:[{label:"ActionScript",value:"ds",dd:"ss"}
            ],
            select: function( event, ui ) {
                console.log(ui)
			}
        });
        /*
        $.ajax({
            url: "",
            type: "Get",
            data: { "likeId": $customer_name_ordinary.val() },
            success: function (data) {
                if (data != null) {
                    $customer_name_ordinary.autocomplete({
                        source: data
                    });
                }
            }
        });*/
    }
    $(function () {
        $("#customer_name_ordinary").autocomplete({
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
                $("#company_property_ordinary").val(ui.item.companyKind);
                $("#legal_represent_ordinary").val(ui.item.operName);
                $("#company_phone_ordinary").val(ui.item.telephone);
                $("#company_tax_ordinary").val(ui.item.businessLienceNum);
                $("#company_address_ordinary").val(ui.item.companyAddress);
            }
        });
    });
	</script>
</head>

<body class="gray-bg" onload="showAddType();" onclick="hideMenu();">
<form action="customer/${msg}.do" name="customerForm" id="customerForm" method="post">
<input type="hidden" name="customer_add_type"  id="customer_add_type" value="Ordinary"/>
<input type="hidden" name="input_user"  id="input_user" value="${input_user}"/>
<input type="hidden" name="operateType" id="operateType" value="${operateType }"/>
<input type="hidden" name="decisionFlag2" id="decisionFlag2" value="${decisionFlag2 }"/>
<input type="hidden" name="decisionFlag3" id="decisionFlag3" value="${decisionFlag3 }"/>
<input type="hidden" name="customer_update_type" id="customer_update_type" value="${customer_update_type}"/>
<input type="hidden" name="customer_id_ordinary"  id="customer_id_ordinary" value="${pd.customer_id }"/>
<input type="hidden" name="customer_id_merchant"  id="customer_id_merchant" value="${pd.customer_id }"/>
<input type="hidden" name="customer_id_core"  id="customer_id_core" value="${pd.customer_id }"/>
<input type="hidden" name="customer_project_merchant" id="customer_project_merchant" value="${pd.customer_project}"/>

    <div class="wrapper wrapper-content" style="z-index: -1">
        <div class="row">
            <div class="col-sm-12" >
                <div class="ibox float-e-margins">
                    <div class="ibox-content">
                    <!-- 如果是新增，显示选择客户类别下拉框 -->
                    	<c:if test="${operateType == 'add' }">

	                        <div class="form-inline">
                    		<label style="width:100px">选择客户类型:</label>
                    		<select id="CustomerType" class="form-control m-b" onchange="showAddCustomerType();">
                    			<option value="1">普通客户</option>
                    			<option value="2">小业主</option>
                    			<!-- <option value="3">个人客户</option> -->
                    			<!-- <option value="3">战略客户</option> -->
                    		</select>
                    		</div>
                    	</c:if>
                    	<!-- 开发商客户信息  开始 -->
                    	<c:if test="${((operateType == 'edit' or operateType=='sel') and editType == 'Ordinary') or operateType == 'add'}">
                        <div class="row" id="ordinary">
                            <div class="col-sm-12">
                            		<!-- 客户基本信息 -->
                                    <div class="row">
                            			<div class="col-sm-12">
                                			<div class="panel panel-primary">
                                				<c:if test="${operateType =='sel'}">
	                                			<div class="form-group form-inline">
													<label style="width: 8%; margin-top: 25px; margin-left: 20px">录入人:</label>
													<label style="width: 15%">${pd.user_name}</label>
												    <label style="width: 8%; margin-top: 25px; margin-left: 20px">录入时间:</label>
													<label style="width: 15%">${pd.input_date}</label>
												</div>
												</c:if>
			                                    <div class="panel-heading">
			                                        客户基本信息
			                                    </div>
                                    			<div class="panel-body">        
		                                        <div class="form-group form-inline">
                                    				<label style="width:10%;margin-top: 25px;margin-bottom: 10px"><span><font color="red">*</font></span>客户名称:</label>
													<div style="display: inline" class=" ui-widget">
														<input style="width:22%" placeholder="这里输入客户名称" type="text" name="customer_name_ordinary" id="customer_name_ordinary" value="${pd.customer_name }"  title="客户名称" class="form-control" onblur="checkCustomerName('Ordinary');">
														<input type="hidden" id="old_customer_name_ordinary" value="${pd.customer_name }"/>
													</div>
			                                        <input style="width:170px" type="hidden" name="customer_type_ordinary" id="customer_type_ordinary"  value="Ordinary"    title="客户类别"   class="form-control">
			                                        <!-- <label style="width:80px;margin-left: 30px;margin-left:30px;margin-top:25px"><span><font color="red">*</font></span>客户类型:</label>
			                                        <select name="customer_ordinary_type_ordinary" id="customer_ordinary_type_ordinary" class="form-control" style="width:170px">
			                                        	<option value="">请选择客户类型</option>
			                                        	<c:forEach items="${ordinarys}" var="var">
			                                        		<option value=${var.id} ${var.id==pd.customer_ordinary_type?'selected':''}>${var.type}</option>
			                                        	</c:forEach>
			                                        </select> -->
			                                        <label style="width:10%;margin-top: 25px;margin-bottom: 10px"><span><font color="red">*</font></span>客户行业:</label>
			                                        <select name="customer_trade_ordinary" id="customer_trade_ordinary" class="form-control" style="width:22%">
			                                        	<option value="">请选择客户行业</option>
			                                        	<c:forEach items="${trades}" var="var">
			                                        		<option value=${var.id} ${var.id==pd.customer_trade?'selected':''}>${var.name}</option>
			                                        	</c:forEach>
			                                        </select>
					                            	<c:if test="${operateType != 'add' }">
					                                	<label style="width:10%;margin-top: 25px;margin-bottom: 10px"><span><font color="red">*</font></span>客户编号:</label>
					                                    <input style="width:24%" readonly="readonly" name="customer_no" id="customer_no" value="${pd.customer_no}" class="form-control" style="width:170px"  type="text">
													</c:if>
                                        		</div>
		                                        <div class="form-group form-inline">
			                                    	<label style="width:10%;margin-top: 25px;margin-bottom: 10px"><span></span>客户集团:</label>
			                                    	<select id="customer_company_ordinary" name="customer_company_ordinary" class="selectpicker" data-live-search="true">
			                                    		<option value=''>无</option>
														<c:forEach items="${cores}" var="var" >
															<option value="${var.customer_id  }"${var.customer_id==pd.customer_company?'selected':'' } >${var.customer_name }</option>
													  	</c:forEach>
													</select><!-- 
			                                        <input type="text" readonly="readonly" style="width:170px" name="customer_company_text_ordinary" id="customer_company_text_ordinary" value="${pd.customer_company_text }"  placeholder="请选择集团" title="客户集团" class="form-control" onclick="showCompanyMenuOrdinary();"/>
			                                        <input style="width:170px"  type="hidden" name="customer_company_ordinary" id="customer_company_ordinary"  value="${pd.customer_company}"   title="客户集团"   class="form-control" > -->
			                                        <label style="width:10%;margin-top: 25px;margin-bottom: 10px"><span><font color="red">*</font></span>公司电话:</label>
			                                        <input style="width:22%" type="text" name="company_phone_ordinary" id="company_phone_ordinary"  value="${pd.company_phone}" placeholder="这里输入公司电话"  title="公司电话"   class="form-control">
			                                        <%-- <label style="width:10%;margin-top: 25px;margin-bottom: 10px"><span><font color="red">*</font></span>是否战略用户:</label>
			                                        <select style="width:22%" class="form-control m-b" id="is_core_ordinary" name='is_core_ordinary'>
			                                        	<option value=''>请选择</option>
			                                        	<option value='true' ${pd.is_core=='true'?'selected':''}>是</option>
			                                        	<option value='false'${pd.is_core=='false'?'selected':''}>否</option>
			                                        </select> --%>
		                                    	</div>
		                                    </div>
		                                </div>
		                            </div>
                                    </div>
                                    <div class="row">
                            			<div class="col-sm-12">
                                			<div class="panel panel-primary">
			                                    <div class="panel-heading">
			                                        联系人信息
			                                    </div>
                                    			<div class="panel-body">
				                                    <div class="form-group form-inline">
				                                        <label style="width:10%;margin-top: 25px;margin-bottom: 10px"><span><font color="red">*</font></span>联系人:</label>
				                                        <input style="width:22%" type="text" name="customer_contact_ordinary" id="customer_contact_ordinary"  value="${pd.customer_contact}" placeholder="这里输入联系人" title="联系人"  class="form-control">
				                                        <label style="width:10%;margin-top: 25px;margin-bottom: 10px"><span><font color="red">*</font></span>联系人电话:</label>
				                                        <input style="width:22%" style="width:170px" style="width:170px" style="width:170px" type="text" name="contact_phone_ordinary" id="contact_phone_ordinary"  value="${pd.contact_phone}" placeholder="这里输入联系人电话" title="联系人电话"   class="form-control">
				                                        <label style="width:10%;margin-top: 25px;margin-bottom: 10px">联系人职务:</label>
				                                        <input style="width:24%" style="width:170px" type="text" name="contact_duty_ordinary" id="contact_duty_ordinary"  value="${pd.contact_duty}" placeholder="这里输入联系人职务" title="联系人职务"   class="form-control">
				                                    </div>
				                                    <div class="form-group form-inline">
				                                        <label style="width:10%;margin-top: 25px;margin-bottom: 10px">联系人邮件:</label>
				                                        <input style="width:22%" type="text" name="contact_email_ordinary" id="contact_email_ordinary"  value="${pd.contact_email}"  placeholder="这里输入联系人邮件" title="联系人邮件"  class="form-control">
				                                        <label style="width:10%;margin-top: 25px;margin-bottom: 10px">归属区域:</label>
				                                        <input type="text" readonly="readonly" style="width:22%" name="customer_area_text_ordinary" id="customer_area_text_ordinary" value="${pd.customer_area_text }"  placeholder="请选择区域" title="归属区域" class="form-control" onclick="showAreaMenuOrdinary();"/>
				                                        <input style="width:22%"  type="hidden" name="customer_area_ordinary" id="customer_area_ordinary"  value="${pd.customer_area}"   title="归属区域"   class="form-control" >
				                                        <label style="width:10%;margin-top: 25px;margin-bottom: 10px">归属分公司:</label>
				                                        <input type="text" readonly="readonly" style="width:24%" name="customer_branch_text_ordinary" id="customer_branch_text_ordinary" value="${pd.customer_branch_text }"  placeholder="请选择分公司" title="归属分公司" class="form-control" onclick="showBranchMenuOrdinary();"/>
				                                        <input style="width:24%"  type="hidden" name="customer_branch_ordinary" id="customer_branch_ordinary"  value="${pd.customer_branch}"   title="归属分公司"   class="form-control" >
				                                        <label style="width:80px;margin-left:20px;display:none">跟进业务员:</label>
				                                        <input type="hidden" id="respond_salesman_ordinary" name="respond_salesman_ordinary" value="${respond_salesman}">
				                                        <!-- <label style="width:80px;margin-left:20px">跟进业务员:</label>
				                                        <select id="respond_salesman_ordinary" name="respond_salesman_ordinary" class="selectpicker" data-live-search="true" title="请选择业务员">
													        <c:forEach items="${responds}" var="var" >
															<option value="${var.USER_ID  }"${var.USER_ID==pd.respond_salesman?'selected':'' } >${var.NAME }</option>
													  	</c:forEach>
												      	</select> -->
				                                    </div>
				                                </div>
				                            </div>
				                        </div>
				                    </div>
				                    <div class="row">
                            			<div class="col-sm-12">
                                			<div class="panel panel-primary">
			                                    <div class="panel-heading">
			                                        企业信息
			                                    </div>
                                    			<div class="panel-body">
				                                    <div class="form-group form-inline">
				                                        <label style="width:10%;margin-top: 25px;margin-bottom: 10px">企业性质:</label>
				                                        <input style="width:22%" style="width:170px" type="text" name="company_property_ordinary" id="company_property_ordinary"  value="${pd.enterprice_property}" placeholder="这里输入企业性质" title="企业性质"  class="form-control">
				                                        <label style="width:10%;margin-top: 25px;margin-bottom: 10px">员工人数:</label>
				                                        <select style="width:22%" id="employee_num_ordinary" name="employee_num_ordinary" class="form-control m-b">
				                                        	<option value=''>请选择</option>
				                                        	<option value='0~50人' ${pd.employee_num=='0~50人'?'selected':''}>0~50人</option>
				                                        	<option value='50~100人' ${pd.employee_num=='50~100人'?'selected':''}>50~100人</option>
				                                        	<option value='100~300人' ${pd.employee_num=='100~300人'?'selected':''}>100~300人</option>
				                                        	<option value='300~500人' ${pd.employee_num=='300~500人'?'selected':''}>300~500人</option>
				                                        	<option value='500人以上' ${pd.employee_num=='500人以上'?'selected':''}>500人以上</option>
				                                        </select>
				                                        <label style="width:10%;margin-top: 25px;margin-bottom: 10px">法人代表:</label>
				                                        <input style="width:24%" style="width:170px" type="text" name="legal_represent_ordinary" id="legal_represent_ordinary"  value="${pd.legal_represent}" placeholder="这里输入法人代表" title="法人代表"  class="form-control">
				                                    </div>
				                                    <div class="form-group form-inline">
				                                    </div>
				                                    <div class="form-group form-inline">
				                                        <label style="width:10%;margin-top: 25px;margin-bottom: 10px">传真:</label>
				                                        <input style="width:22%" style="width:170px" type="text" name="company_fax_ordinary" id="company_fax_ordinary"  value="${pd.company_fax}" placeholder="这里输入传真" title="传真"  class="form-control">
				                                        <label style="width:10%;margin-top: 25px;margin-bottom: 10px">开户银行:</label>
				                                        <input style="width:22%" style="width:170px" type="text" name="company_bank_ordinary" id="company_bank_ordinary"  value="${pd.company_bank}"  title="开户银行"  placeholder="这里输入开户银行" class="form-control">
				                                        <label style="width:10%;margin-top: 25px;margin-bottom: 10px">银行账号:</label>
				                                        <input style="width:24%" style="width:170px" type="text" name="bank_no_ordinary" id="bank_no_ordinary"  value="${pd.bank_no}" placeholder="这里输入账号"  title="账号"   class="form-control">
				                                        <label style="width:80px;margin-left: 30px;margin-bottom:30px;display:none">信用等级:</label>
				                                        <input style="width:170px;display:none" type="text" name="credit_ratings_ordinary" id="credit_ratings_ordinary"  value="${pd.credit_ratings}"  placeholder="这里输入信用等级" title="信用等级"   class="form-control">
				                                        <!-- <label style="width:80px;margin-left: 30px">资金来源:</label>
				                                        <input style="width:170px" style="width:170px" type="text" name="found_source_ordinary" id="found_source_ordinary"  value="${pd.found_source}" placeholder="这里输入资金来源" title="资金来源"   class="form-control"> -->
				                                    </div>
				                                    <div class="form-group form-inline">
				                                        <label style="width:10%;margin-top: 25px;margin-bottom: 10px">税号:</label>
				                                        <input style="width:22%" style="width:170px" type="text" name="company_tax_ordinary" id="company_tax_ordinary"  value="${pd.company_tax}" placeholder="这里输入税号" title="税号"  class="form-control">
				                                        <label style="width:10%;margin-top: 25px;margin-bottom: 10px">公司地址:</label>
				                                        <input style="width:22%" style="width:170px;margin-bottom:30px;" type="text" name="company_address_ordinary" id="company_address_ordinary"  value="${pd.company_address}" placeholder="这里输入地址" title="地址"   class="form-control">
				                                        <label style="width:10%;margin-top: 25px;margin-bottom: 10px">公司邮箱:</label>
				                                        <input style="width:24%" style="width:170px" type="text" name="company_email_ordinary" id="company_email_ordinary"  value="${pd.company_email}" placeholder="这里输入公司邮箱"  title="公司邮箱"   class="form-control">
				                                        <label style="width:80px;display:none">客户等级:</label>
				                                        <input style="width:170px;display:none" type="text" name="customer_ratings_ordinary" id="customer_ratings_ordinary"  value="${pd.customer_ratings}"  placeholder="这里输入等级" title="客户等级"  class="form-control">
				                                    </div>
				                                </div>
				                            </div>
				                        </div>
				                    </div>
				                    <div class="row">
                            			<div class="col-sm-12">
                                			<div class="panel panel-primary">
			                                    <div class="panel-heading">
			                                        经营状况
			                                    </div>
                                    			<div class="panel-body">
				                                    <div class="form-group">
				                                    	<label style="width:10%;margin-top: 25px;margin-bottom: 10px">经营内容及业绩:</label>
				                                        <textarea rows="3" cols="20" name="business_and_scope_ordinary" id="business_and_scope_ordinary" placeholder="这里输入经营内容及业绩" class="form-control">${pd.business_and_scope }</textarea>
				                                    </div>
				                                    <div class="form-group">
				                                        <label style="width:10%;margin-top: 25px;margin-bottom: 10px">经营状况:</label>
				                                        <textarea rows="3" cols="20" name="business_status_ordinary" id="business_status_ordinary" placeholder="这里输入经营状况" class="form-control">${pd.business_status }</textarea>
														<label style="width:80px;margin-left: 20px;display:none">启用标志:</label>
				                                        <select style="display:none" name="start_flag_ordinary" id="start_flag_ordinary" class="form-control m-b" >
				                                        	<option value="1"}>启用</option>
				                                        	<option value="0" selected="selected" }>禁用</option>
				                                        </select>
				                                    </div>
				                                </div>
				                            </div>
				                        </div>
				                    </div>
                            		<!-- 决策1信息 -->
                            		<div name="dec" id="dec1">
                            		<div class="row">
                            			<div class="col-sm-12">
                                			<div class="panel panel-primary">
			                                    <div class="panel-heading">
			                                        决策层一
			                                    </div>
                                    			<div class="panel-body">
				                                    <!-- <label>决策层1:</label> -->
				                            		<div class="form-group form-inline">
				                                        <label style="width:10%;margin-top: 25px;margin-bottom: 10px">姓名:</label>
				                                        <input style="width:22%" type="text" name="dm_name1_ordinary" id="dm_name1_ordinary"  value="${pd.dm_name1}" placeholder="这里输入姓名" title="姓名"   class="form-control">
				                                        <label style="width:10%;margin-top: 25px;margin-bottom: 10px">职位:</label>
				                                        <input style="width:22%" type="text" name="dm_duty1_ordinary" id="dm_duty1_ordinary"  value="${pd.dm_duty1}" placeholder="这里输入职位"  title="职位"   class="form-control">
				                                    </div>
				                                    <div class="form-group form-inline" >
				                                        <label style="width:10%;margin-top: 25px;margin-bottom: 10px">年龄:</label>
				                                        <input style="width:22%" type="text" name="dm_age1_ordinary" id="dm_age1_ordinary"  value="${pd.dm_age1}" placeholder="这里输入年龄" title="年龄"   class="form-control">
				                                        <label style="width:10%;margin-top: 25px;margin-bottom: 10px">学历:</label>
				                                        <input style="width:22%" type="text" name="dm_edubg1_ordinary" id="dm_edubg1_ordinary"  value="${pd.dm_edubg1}" placeholder="这里输入学历" title="学历"   class="form-control">
				                                    </div>
				                                    <div class="form-group form-inline">
				                                        <label style="width:10%;margin-top: 25px;margin-bottom: 10px">生日:</label>
				                                        <input style="width:22%" type="text" name="dm_birthday1_ordinary" id="dm_birthday1_ordinary"  value="${pd.dm_birthday1}"  placeholder="这里输入生日" title="生日"  class="form-control layer-date" onclick="laydate()">
				                                        <label style="width:10%;margin-top: 25px;margin-bottom: 10px">联系电话:</label>
				                                        <input style="width:22%" type="text" name="dm_phone1_ordinary" id="dm_phone1_ordinary"  value="${pd.dm_phone1}" placeholder="这里输入联系电话" title="联系电话"   class="form-control">
				                                        <label style="width:10%;margin-top: 25px;margin-bottom: 10px">性别:</label>
				                                        <select name="dm_sex1_ordinary" id="dm_sex1_ordinary" class="form-control m-b">
				                                        	<option value="">请选择</option>
				                                        	<option value="男"  ${pd.dm_sex1=='男'?'selected':''}>男</option>
				                                        	<option value="女"  ${pd.dm_sex1=='女'?'selected':''}>女</option>
				                                        </select>
				                                    </div>
				                                    <div class="form-group">
				                                        <label style="width:10%;margin-top: 25px;margin-bottom: 10px">嗜好:</label>
				                                        <textarea rows="3" cols="13" name="dm_hobby1_ordinary" id="dm_hobby1_ordinary" placeholder="这里输入嗜好" class="form-control">${pd.dm_hobby1 }</textarea>
				                                    </div>
				                                </div>
				                            </div>
				                        </div>
				                    </div>
				                    </div>
                            		<!-- 决策2信息 -->
                            		<div name="dec" id="dec2" style="display: none;">
                            		<div class="row">
                            			<div class="col-sm-12">
                                			<div class="panel panel-primary">
			                                    <div class="panel-heading">
			                                        决策层二
			                                    </div>
                                    			<div class="panel-body">
				                                    <!-- <label>决策层2:</label> -->
				                            		<div class="form-group form-inline">
				                                        <!-- <input style="width:170px" type="text" name="decision_make2_ordinary" id="decision_make2_ordinary"  value="${pd.decision_make2}"  title="决策层2"  class="form-control"> -->
				                                        <label style="width:10%;margin-top: 25px;margin-bottom: 10px">姓名:</label>
				                                        <input style="width:22%" type="text" name="dm_name2_ordinary" id="dm_name2_ordinary"  value="${pd.dm_name2}" placeholder="这里输入姓名" title="姓名"   class="form-control">
				                                        <label style="width:10%;margin-top: 25px;margin-bottom: 10px">职位:</label>
				                                        <input style="width:22%" type="text" name="dm_duty2_ordinary" id="dm_duty2_ordinary"  value="${pd.dm_duty2}" placeholder="这里输入职位"  title="职位"   class="form-control">
				                                    </div>
				                                    <div class="form-group form-inline">
				                                        <label style="width:10%;margin-top: 25px;margin-bottom: 10px">年龄:</label>
				                                        <input style="width:22%" type="text" name="dm_age2_ordinary" id="dm_age2_ordinary"  value="${pd.dm_age2}" placeholder="这里输入年龄" title="年龄"   class="form-control">
				                                        <label style="width:10%;margin-top: 25px;margin-bottom: 10px">学历:</label>
				                                        <input style="width:22%" type="text" name="dm_edubg2_ordinary" id="dm_edubg2_ordinary"  value="${pd.dm_edubg2}" placeholder="这里输入学历" title="学历"   class="form-control">
				                                    </div>
				                                    <div class="form-group form-inline">
				                                        <label style="width:10%;margin-top: 25px;margin-bottom: 10px">生日:</label>
				                                        <input style="width:22%" type="text" name="dm_birthday2_ordinary" id="dm_birthday2_ordinary"  value="${pd.dm_birthday2}"  placeholder="这里输入生日" title="生日"  class="form-control layer-date" onclick="laydate()">
				                                        <label style="width:10%;margin-top: 25px;margin-bottom: 10px">联系电话:</label>
				                                        <input style="width:22%" type="text" name="dm_phone2_ordinary" id="dm_phone2_ordinary"  value="${pd.dm_phone2}" placeholder="这里输入联系电话" title="联系电话"   class="form-control">
				                                        <label style="width:10%;margin-top: 25px;margin-bottom: 10px">性别:</label>
				                                        <%-- <input style="width:170px" type="text" name="dm_sex2_ordinary" id="dm_sex2_ordinary"  value="${pd.dm_sex2}"  title="性别"  class="form-control"> --%>
				                                        <select name="dm_sex2_ordinary" id="dm_sex2_ordinary" class="form-control m-b">
				                                        	<option value="">请选择</option>
				                                        	<option value="男"  ${pd.dm_sex2=='男'?'selected':''}>男</option>
				                                        	<option value="女"  ${pd.dm_sex2=='女'?'selected':''}>女</option>
				                                        </select>
				                                    </div>
				                                    <div class="form-group">
				                                        <label style="width:10%;margin-top: 25px;margin-bottom: 10px">嗜好:</label>
				                                        <textarea rows="3" cols="13" name="dm_hobby2_ordinary" id="dm_hobby2_ordinary" placeholder="这里输入嗜好" class="form-control">${pd.dm_hobby2 }</textarea>
				                                    </div>
				                                    </div>
				                                </div>
				                            </div>
			                            </div>
			                            </div>
                            		<!-- 决策3信息 -->
                            		<div name="dec" id="dec3" style="display: none">
                            		<div class="row">
                            			<div class="col-sm-12">
                                			<div class="panel panel-primary">
			                                    <div class="panel-heading">
			                                        决策层三
			                                    </div>
                                    			<div class="panel-body">
				                                    <!-- <label>决策层3:</label> -->
				                            		<div class="form-group form-inline">
				                                        <!-- <input style="width:170px" type="text" name="decision_make3_ordinary" id="decision_make3_ordinary"  value="${pd.decision_make3}"  title="决策层3"  class="form-control"> -->
				                                        <label style="width:10%;margin-top: 25px;margin-bottom: 10px">姓名:</label>
				                                        <input style="width:22%" type="text" name="dm_name3_ordinary" id="dm_name3_ordinary"  value="${pd.dm_name3}" placeholder="这里输入姓名" title="姓名"   class="form-control">
				                                        <label style="width:10%;margin-top: 25px;margin-bottom: 10px">职位:</label>
				                                        <input style="width:22%" type="text" name="dm_duty3_ordinary" id="dm_duty3_ordinary"  value="${pd.dm_duty3}" placeholder="这里输入职位"  title="职位"   class="form-control">
				                                    </div>
				                                    <div class="form-group form-inline">
				                                        <label style="width:10%;margin-top: 25px;margin-bottom: 10px">年龄:</label>
				                                        <input style="width:22%" type="text" name="dm_age3_ordinary" id="dm_age3_ordinary"  value="${pd.dm_age3}" placeholder="这里输入年龄" title="年龄"   class="form-control">
				                                        <label style="width:10%;margin-top: 25px;margin-bottom: 10px">学历:</label>
				                                        <input style="width:22%" type="text" name="dm_edubg3_ordinary" id="dm_edubg3_ordinary"  value="${pd.dm_edubg3}" placeholder="这里输入学历" title="学历"   class="form-control">
				                                    </div>
				                                    <div class="form-group form-inline">
				                                        <label style="width:10%;margin-top: 25px;margin-bottom: 10px">生日:</label>
				                                        <input style="width:22%" type="text" name="dm_birthday3_ordinary" id="dm_birthday3_ordinary"  value="${pd.dm_birthday3}"  placeholder="这里输入生日" title="生日"  class="form-control layer-date" onclick="laydate()">
				                                        <label style="width:10%;margin-top: 25px;margin-bottom: 10px">联系电话:</label>
				                                        <input style="width:22%" type="text" name="dm_phone3_ordinary" id="dm_phone3_ordinary"  value="${pd.dm_phone3}" placeholder="这里输入联系电话" title="联系电话"   class="form-control">
				                                        <label style="width:10%;margin-top: 25px;margin-bottom: 10px">性别:</label>
				                                        <%-- <input style="width:170px" type="text" name="dm_sex3_ordinary" id="dm_sex3_ordinary"  value="${pd.dm_sex3}"  title="性别"  class="form-control"> --%>
				                                        <select name="dm_sex3_ordinary" id="dm_sex3_ordinary" class="form-control m-b">
				                                        	<option value="">请选择</option>
				                                        	<option value="男"  ${pd.dm_sex3=='男'?'selected':''}>男</option>
				                                        	<option value="女"  ${pd.dm_sex3=='女'?'selected':''}>女</option>
				                                        </select>
				                                    </div>
				                                    <div class="form-group">
				                                        <label style="width:10%;margin-top: 25px;margin-bottom: 10px">嗜好:</label>
				                                        <textarea rows="3" cols="13" name="dm_hobby3_ordinary" id="dm_hobby3_ordinary" placeholder="这里输入嗜好" class="form-control">${pd.dm_hobby3 }</textarea>
				                                    </div>
				                            	</div>
				                        	</div>
	                                    </div>
	                                </div>
	                                </div>
                                    <div class="form-group form-inline" id="operateDec" style="display: none;">
	                                    <input type="button" onclick="addDec()" value="添加决策层"/>
	                                    <input type="button" onclick="delDec()" value="删除决策层"/>
                                	</div>
                                    <!-- 客户关系信息 -->
                            		<div class="row">
                            			<div class="col-sm-12">
                                			<div class="panel panel-primary">
			                                    <div class="panel-heading">
			                                        客户关系信息
			                                    </div>
                                    			<div class="panel-body">
				                                    <div class="form-group">
				                                        <label style="width:10%;margin-top: 25px;margin-bottom: 10px">目前关系描述:</label>
				                                        <textarea rows="3" cols="13" name="relation_descript_ordinary" id="relation_descript_ordinary" placeholder="这里输入目前关系描述" class="form-control">${pd.relation_descript }</textarea>
				                                    </div>
				                                    <div class="form-group">
				                                        <label style="width:10%;margin-top: 25px;margin-bottom: 10px">备注:</label>
				                                        <textarea rows="3" cols="13" name="remark_ordinary" id="remark_ordinary" class="form-control" placeholder="这里输入备注">${pd.remark }</textarea>
				                                    </div>
				                                </div>
				                            </div>
				                        </div>
				                    </div>
                            </div>
                        </div>
                        </div>
                        </c:if>
                        <!-- 开发商客户信息  结束 -->
                        
                        <!-- 业主客户信息  开始 -->
                    	<c:if test="${((operateType == 'edit' or operateType=='sel') and editType == 'Merchant') or operateType == 'add'}">
                        <div class="row" id="merchant" style="padding-left: 15px">
                        	<div class="row">
                            <div class="col-sm-12">
                                <div class="panel panel-primary">
                                    <div class="panel-heading">
                                        客户基本信息
                                    </div>
                                    <div class="panel-body">
		                        		<div class="form-group form-inline">
				                            <label style="width:10%;margin-top: 25px;margin-bottom: 10px"><span><font color="red">*</font></span>姓名:</label>
				                            <input style="width:22%" type="text" name="customer_name_merchant" id="customer_name_merchant"  value="${pd.customer_name}"  placeholder="这里输入姓名" title="姓名"  class="form-control" onblur="checkCustomerName('Merchant');">
				                            <input type="hidden" id="old_customer_name_merchant" value="${pd.customer_name }"/>
				                            <input type="hidden" name="customer_type_merchant" id="customer_type_merchant"  value="Merchant" >
				                        	<label style="width:10%;margin-top: 25px;margin-bottom: 10px"><span><font color="red">*</font></span>联系电话:</label>
				                            <input style="width:22%" type="text" name="contact_phone_merchant" id="contact_phone_merchant"  value="${pd.contact_phone}"  placeholder="这里输入联系电话"  title="联系电话"  class="form-control">
			                                <!-- <label style="width:110px;margin-left: 30px;margin-left:30px;margin-top:25px"><span><font color="red">*</font></span>是否战略用户:</label>
			                                <select style="width:170px" class="form-control m-b" name="is_core_merchant" id='is_core_merchant'>
			                                	<option value=''>请选择</option>
	                                        	<option value='true' ${pd.is_core=='true'?'selected':''}>是</option>
	                                        	<option value='false'${pd.is_core=='false'?'selected':''}>否</option>
			                                </select> -->
			                                <label style="width:10%;margin-top: 25px;margin-bottom: 10px">楼盘信息:</label>
			                                <select style="width:24%" class="selectpicker" multiple data-live-search="true" data-live-search-placeholder="查找" data-actions-box="true" name="house_no_text_merchant" id="house_no_text_merchant">
									            <optgroup label="楼盘列表">
									            	<c:forEach items="${houseList}" var="var" >
															<option value="${var.houses_no }"  
																<c:forEach items="${houses}" var="house">
																${var.houses_no==house?'selected':''}
																</c:forEach>
															>${var.houses_name }</option>
													</c:forEach>
									            </optgroup>
									          </select>
				          					<input type="hidden" id="house_no_merchant" name="house_no_merchant"/>
		                        		</div>
		                        		<div class="form-group form-inline">
			                                <label style="width:10%;margin-top: 25px;margin-bottom: 10px">客户级别:</label>
			                                <select style="width:22%;margin-top: 18px;" name="customer_ratings_merchant" id="customer_ratings_merchant" class="form-control m-b">
			                                	<option value="">请选择客户级别</option>
			                                	<option value="普通客户" ${pd.customer_ratings=="普通客户"?"selected":""}>普通客户</option>
			                                	<option value="样板客户" ${pd.customer_ratings=="样板客户"?"selected":""}>样板客户</option>
			                                	<option value="VIP" ${pd.customer_ratings=="VIP"?"selected":""}>VIP</option>
			                                	<option value="MVP" ${pd.customer_ratings=="MVP"?"selected":""}>MVP</option>
			                                </select>
		                            		<!-- <input style="width:170px" type="text" name="customer_ratings_merchant" id="customer_ratings_merchant"  value="${pd.customer_ratings}" placeholder="这里输入客户级别"   title="客户级别"  class="form-control"> -->
				                            <label style="width:10%;margin-top: 25px;margin-bottom: 10px">客户爱好:</label>
				                            <input style="width:22%" type="text" name="customer_hobby_merchant" id="customer_hobby_merchant"  value="${pd.customer_hobby}" placeholder="这里输入客户爱好"   title="客户爱好"  class="form-control">
				                            <label style="width:10%;margin-top: 25px;margin-bottom: 10px">客户生日:</label>
				                            <input style="width:22%" type="text" name="customer_birthday_merchant" id="customer_birthday_merchant"  value="${pd.customer_birthday}"  placeholder="这里输入客户生日"  title="客户生日"   class="form-control layer-date" onclick="laydate()">
				                        </div>
				                        <div class="form-group form-inline">
				                            <label style="width:10%;margin-top: 25px;margin-bottom: 10px">客户单位:</label>
			                                <input style="width:22%" type="text" name="customer_org_merchant" id="customer_org_merchant"  value="${pd.customer_org}"  placeholder="这里输入客户单位"  title="客户单位"   class="form-control">
				                        	<label style="width:10%;margin-top: 25px;margin-bottom: 10px">客户邮箱:</label>
				                            <input style="width:22%" type="text" name="customer_email_merchant" id="customer_email_merchant"  value="${pd.customer_email}"  placeholder="这里输入客户邮箱"  title="客户邮箱"  class="form-control">
				                            <!-- <label style="width:110px;margin-left: 30px;margin-left:30px;margin-top:25px">联系方式:</label>
				                            <input style="width:170px" type="text" name="contact_way_merchant" id="contact_way_merchant"  value="${pd.contact_way}"  placeholder="这里输入联系方式"  title="联系方式"   class="form-control"> -->
				                            <label style="width:10%;margin-top: 25px;margin-bottom: 10px">联系地址:</label>
				                            <input style="width:22%" type="text" name="contact_address_merchant" id="contact_address_merchant"  value="${pd.contact_address}"  placeholder="这里输入联系地址"  title="联系地址"  class="form-control">
				                        </div>
				                        <div class="form-group form-inline">
				                            <label style="width:10%;margin-top: 25px;margin-bottom: 10px">客户集团:</label>
				                            <select style="width:22%" id="customer_company_merchant" name="customer_company_merchant" class="selectpicker" data-live-search="true">
	                                    		<option value=''>无</option>
												<c:forEach items="${cores}" var="var" >
													<option value="${var.customer_id  }"${var.customer_id==pd.customer_company?'selected':'' } >${var.customer_name }</option>
											  	</c:forEach>
											</select>
				                        
			                        	<c:if test="${operateType != 'add' }">
			                                    <label style="width:10%;margin-top: 25px;margin-bottom: 10px"><span><font color="red">*</font></span>客户编号:</label>
			                            		<input style="width:22%" name="customer_no" readonly="readonly" id="customer_no" class="form-control" value="${pd.customer_no}" style="width:170px" placeholder="这里输入客户编号" type="text">
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
                                        联系人信息
                                    </div>
                                    <div class="panel-body">
                                   		<!-- <div class="form-group form-inline">
				                            <label style="width:110px;margin-left: 30px;margin-left:30px;margin-top:25px"><span><font color="red">*</font></span>联系人:</label>
				                            <input style="width:170px" type="text" name="customer_contact_merchant" id="customer_contact_merchant"  value="${pd.customer_contact}"   placeholder="这里输入联系人" title="联系人"   class="form-control">
				                            <label style="width:110px;margin-left: 30px;margin-left:30px;margin-top:25px"><span><font color="red">*</font></span>联系电话:</label>
				                            <input style="width:170px" type="text" name="contact_phone_merchant" id="contact_phone_merchant"  value="${pd.contact_phone}"  placeholder="这里输入联系电话"  title="联系电话"  class="form-control">
				                        </div> -->
				                        <div class="form-group form-inline">
				                            <label style="width:10%;margin-top: 25px;margin-bottom: 10px">紧急联系人1:</label>
				                            <input style="width:22%" type="text" name="contact_emergency_one_merchant" id="contact_emergency_one_merchant"  value="${pd.contact_emergency_one}"   placeholder="这里输入紧急联系人" title="紧急联系人"   class="form-control">
				                            <label style="width:10%;margin-top: 25px;margin-bottom: 10px">联系电话:</label>
				                            <input style="width:22%" type="text" name="em_one_phone_merchant" id="em_one_phone_merchant"  value="${pd.em_one_phone}"  placeholder="这里输入联系电话"  title="联系电话"  class="form-control">
				                        </div>
	                        			<div class="form-group form-inline">
				                            <label style="width:10%;margin-top: 25px;margin-bottom: 10px">紧急联系人2:</label>
				                            <input style="width:22%" type="text" name="contact_emergency_two_merchant" id="contact_emergency_two_merchant"  value="${pd.contact_emergency_two}"  placeholder="这里输入紧急联系人"  title="紧急联系人"   class="form-control">
				                            <label style="width:10%;margin-top: 25px;margin-bottom: 10px">联系电话:</label>
				                            <input style="width:22%" type="text" name="em_two_phone_merchant" id="em_two_phone_merchant"  value="${pd.em_two_phone}"  placeholder="这里输入联系电话"  title="联系电话"  class="form-control">
	                            	    </div>
	                            	</div>
	                          	</div>
	                        </div>
	                        </div>
	                        <div class="row">
                            <div class="col-sm-12">
                                <div class="panel panel-primary">
                                    <div class="panel-heading">
                                        客户其他信息
                                    </div>
                                    <div class="panel-body">
                                    <div class="table-responsive">
			                            <table class="table table-striped table-bordered table-hover" id="itemTable">
			                                <thead>
			                                    <tr>
			                                        <th style="width:5%;">项目/楼盘名称</th>
			                                        <th style="width:10%;">项目描述</th>
			                                        <th style="width:10%;">操作</th>
			                                    </tr>
			                                </thead>
			                                <tbody>
			                                	<tr>
			                                		<td><input type="text" style="border-style:none"><font color="red">*</font></td>
			                                		<td><input type="text" style="border-style:none"><font color="red">*</font></td>
			                                		<td><input type="button" value="添加" onclick="addRow();"></td>
			                                	</tr>
			                                </tbody>
			                            </table>
			                        </div>

				                        <!-- <div class="form-group form-inline">
				                            <label style="width:110px;margin-left: 20px;display:none">业务员:</label>
				                            <input style="width:170px" type="hidden" name="respond_salesman_merchant" id="respond_salesman_merchant"  value="${pd.respond_salesman}"  placeholder="这里输入传真号码"  title="传真号码"   class="form-control">
				                            <label style="width:110px;margin-left: 30px;margin-left:30px;margin-top:25px">服务人员:</label>
				                            <input style="width:170px" type="text" name="service_man_merchant" id="service_man_merchant"  value="${pd.service_man}"  placeholder="这里输入服务人员"  title="服务人员"  class="form-control">
				                            <label style="width:110px;margin-left: 30px;margin-left:30px;margin-top:25px">开发的项目:</label>
				                            <input style="width:170px" type="text" name="customer_project_merchant" id="customer_project_merchant"  value="${pd.customer_project}"  placeholder="这里输入开发的项目"  title="开发的项目"   class="form-control">
				                        </div>
				                        <div class="form-group form-inline">
				                            <label style="width:110px;margin-left: 30px;margin-left:30px;margin-top:25px">型号规格:</label>
				                            <input style="width:170px" type="text" name="type_specifiaction_merchant" id="type_specifiaction_merchant"  value="${pd.type_specifiaction}"  placeholder="这里输入型号规格"  title="型号规格"  class="form-control">
				                            <label style="width:110px;margin-left: 30px;margin-left:30px;margin-top:25px">配置:</label>
				                            <input style="width:170px" type="text" name="config_merchant" id="config_merchant"  value="${pd.config}"  placeholder="这里输入配置"  title="配置"  class="form-control">
				                            <label style="width:110px;margin-left: 30px;margin-left:30px;margin-top:25px">项目来源:</label>
				                            <input style="width:170px" type="text" name="project_source_merchant" id="project_source_merchant"  value="${pd.project_source}"  placeholder="这里输入项目来源"  title="项目来源"   class="form-control">
				                            <label style="width:110px;margin-left: 20px">营业执照:</label>
				                            <input style="width:250px" class="form-control" type="file"  title="营业执照" onchange="upload(this,$('#business_lincese_merchant'))" />
				                            <input class="form-control" type="hidden" name="business_lincese_merchant" id="business_lincese_merchant"  value="${pd.business_lincese}" title="营业执照"  />
				                            <c:if test="${pd ne null and pd.business_lincese ne null and pd.business_lincese ne '' }">
			        							<a class="btn btn-mini btn-success" onclick="downFile($('#business_lincese_merchant'))">下载附件</a>
			    							</c:if>
				                        </div>
				                        <div class="form-group form-inline">
				                            <label style="width:110px;margin-left: 30px;margin-left:30px;margin-top:25px">效果图:</label>
				                            <input style="width:170px" type="text" name="design_sketch_merchant" id="design_sketch_merchant"  value="${pd.design_sketch}" placeholder="这里输入效果图"   title="效果图"  class="form-control">
				                            <label style="width:110px;margin-left: 30px;margin-left:30px;margin-top:25px">价格:</label>
				                            <input style="width:170px" type="text" name="price_merchant" id="price_merchant"  value="${pd.price}"   placeholder="这里输入价格" title="价格"   class="form-control">
				                        </div> -->
				                    </div>
				                </div>
				            </div>
				            </div>
				            <div class="row" style="display:none">
                            <div class="col-sm-12">
                                <div class="panel panel-primary">
                                    <div class="panel-heading">
                                        代理商信息
                                    </div>
                                    <div class="panel-body">
				                        <div class="form-group form-inline">
				                            <label style="width:110px;margin-left: 30px;margin-left:30px;margin-top:25px">代理商公司:</label>
				                            <input style="width:170px" type="text" name="agent_company_merchant" id="agent_company_merchant"  value="${pd.agent_company}"  placeholder="这里输入代理商公司"  title="代理商公司"  class="form-control">
				                            <label style="width:110px;margin-left: 30px;margin-left:30px;margin-top:25px">代理商公司名称:</label>
				                            <input style="width:170px" type="text" name="agent_name_merchant" id="agent_name_merchant"  value="${pd.agent_name}"  placeholder="这里输入代理商公司名称"  title="代理商公司名称"   class="form-control">
				                            <label style="width:110px;margin-left: 30px;margin-left:30px;margin-top:25px">代理商操作品牌:</label>
				                            <input style="width:170px" type="text" name="agent_brand_merchant" id="agent_brand_merchant"  value="${pd.agent_brand}" placeholder="这里输入代理商操作品牌"   title="代理商操作品牌"  class="form-control">
				                        </div>
				                        <div class="form-group form-inline">
				                            <label style="width:110px;margin-left: 30px;margin-left:30px;margin-top:25px">代理商级别:</label>
				                            <input style="width:170px" type="text" name="agent_ratings_merchant" id="agent_ratings_merchant"  value="${pd.agent_ratings}"  placeholder="这里输入代理商级别"  title="代理商级别"   class="form-control">
				                            <label style="width:110px;margin-left: 30px;margin-left:30px;margin-top:25px">代理商性质:</label>
				                            <input style="width:170px" type="text" name="agent_property_merchant" id="agent_property_merchant"  value="${pd.agent_property}"  placeholder="这里输入代理商性质"  title="代理商性质"  class="form-control">
				                        </div>
				                    </div>
				                </div>
				            </div>
				            </div>
				            <div class="row">
                            <div class="col-sm-12">
                                <div class="panel panel-primary">
                                    <div class="panel-heading">
                                        其他信息
                                    </div>
                                    <div class="panel-body">
				                        <div class="form-group">
				                            <label style="width:10%;margin-top: 25px;margin-bottom: 10px">备注:</label>
				                             <textarea rows="3" cols="13" name="remark_merchant" id="remark_merchant" class="form-control" placeholder="这里输入备注">${pd.remark }</textarea>
				                            <label style="width:110px;display:none">客户状态:</label>
				                            <select name="customer_status_merchant" id="customer_status_merchant" class="form-control m-b" style="display:none">
			                                    <option value="1"}>启用</option>
			                                	<option value="0" selected="selected">禁用</option>
			                                </select>
			                            </div>
			                    	</div>
			                   	</div>
			                </div>
			                </div>
                        </div>
                        </c:if>
                        <!-- 业主客户信息  结束 -->
                        
                        <!-- 个人客户信息  开始 -->
                    	<%-- <c:if test="${((operateType == 'edit' or operateType=='sel') and editType == 'Core') or operateType == 'add'}">
                        <div class="row" id="person" style="padding-left: 15px">
	                    	<div class="row">
	                        <div class="col-sm-12">
	                            <div class="panel panel-primary">
	                                <div class="panel-heading">
	                                    客户基本信息
	                                </div>
	                                <div class="panel-body">		
				                        <div class="form-group form-inline">
				                            <label style="width:80px;margin-left: 30px;margin-left:30px;margin-top:25px"><span><font color="red">*</font></span>客户名称:</label>
				                            <input type="text" class="form-control" placeholder="这里输入客户名称" name="customer_name_person" id="customer_name_person">
				                        	<label style="width:110px;margin-left: 30px;margin-left:30px;margin-top:25px">联系电话:</label>
			                                <input type="text" class="form-control" placeholder="这里输入联系电话" name="phone_person" id="phone_person">
			                                <label style="width:110px;margin-left: 30px;margin-left:30px;margin-top:25px">客户地址:</label>
			                                </div>
			                                <div class="form-group form-inline">
			                                <input type="text" class="form-control" placeholder="这里输入客户地址" name="address_person" id="address_person">
			                                <label style="width:110px;margin-left: 30px;margin-left:30px;margin-top:25px">客户邮箱:</label>
			                                <input type="text" class="form-control" placeholder="这里输入客户邮箱" name="email_person" id="email_person">
			                                <label style="width:110px;margin-left: 30px;margin-left:30px;margin-top:25px">描述信息:</label>
			                                <input type="text" class="form-control" placeholder="这里输入描述信息" name="descript_person" id="descript_person">
			                                <label style="width:110px;margin-left: 30px;margin-left:30px;margin-top:25px">备注:</label>
			                                <input type="text" class="form-control" placeholder="这里输入备注" name="remark_person" id="remark_person">
				                        </div>
			                    	</div>
			                    </div>
			                </div>
			            	</div>
                        </div>
                        </c:if> --%>
                        <!-- 个人客户信息  结束 -->
                    	</div>
						<div style="height: 20px;"></div>
						<tr>
						<c:if test="${operateType!='sel'}">
						<td><a class="btn btn-primary"style="width: 150px; height:34px;float:left;"  onclick="save();">保存</a>
						</td>
						</c:if>
						<td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('EditCustomer');">关闭</a></td>
						</tr>
					</div>
            </div>
            
        </div>
 </div>
 </form>
 <!-- ztree区域显示模块 -->
 <div class="ibox float-e-margins" id="areaContent" class="menuContent" style="display:none; position: absolute;z-index: 99;border: solid 1px #18a689;max-height:300px;overflow-y:scroll;overflow-x:auto">
	<div class="ibox-content">
		<div>
			<ul id="area_zTree" class="ztree" style="margin-top:0; width:170px;"></ul>
		</div>
	</div>
 </div>

 <!-- ztree公司显示模块 -->
 <div class="ibox float-e-margins" id="companyContent" class="menuContent" style="display:none; position: absolute;z-index: 99;border: solid 1px #18a689;max-height:300px;overflow-y:scroll;overflow-x:auto">
	<div class="ibox-content">
		<div>
			<ul id="company_zTree" class="ztree" style="margin-top:0; width:170px;"></ul>
		</div>
	</div>
 </div>


 <!-- ztree子公司显示模块 -->
<div class="ibox float-e-margins" id="branchContent" class="menuContent" style="display:none; position: absolute;z-index: 99;border: solid 1px #18a689;max-height:300px;overflow-y:scroll;overflow-x:auto">
<div class="ibox-content">
	<div>
		<ul id="branch_zTree" class="ztree" style="margin-top:0; width:170px;"></ul>
	</div>
</div>
</div>
 
<%-- <div id="leftdiv" name="leftdiv" class="col-sm-6" style="height:700px;overflow-y:scroll;overflow-x:auto;
			<c:choose>
				 <c:when test='${not empty regions}'>display:block;</c:when>
				 <c:otherwise>display:none;</c:otherwise>
			</c:choose>
			 ">
	<div class="ibox float-e-margins">
		<div class="ibox-content">
		<div id="myzTree" class="ztree"></div>
		</div>
	</div>
</div> --%>
 <%--zTree--%>
<script type="text/javascript"
	src="plugins/zTree/3.5.24/js/jquery.ztree.core.js"></script>
<script type="text/javascript"
	src="plugins/zTree/3.5.24/js/jquery.ztree.excheck.js"></script>
<script type="text/javascript"
	src="plugins/zTree/3.5.24/js/jquery.ztree.exedit.js"></script>
<!-- Sweet alert -->
<script src="static/js/sweetalert/sweetalert.min.js"></script>
<script type="text/javascript">
	//归属区域显示
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
					$("#customer_area_ordinary").val(treeNode.id);
					$("#customer_area_text_ordinary").val(treeNode.name);
					/*$("#area_id_merchant").val(treeNode.id);
					$("#area_id_text_merchant").val(treeNode.name);*/
					$("#areaContent").hide();
					settingBranch(treeNode.id);

					return true;
				}
			}
		);
	}

	function onClickArea(e, treeId, treeNode) {
		
	}
	
	function showAreaMenuOrdinary() {
		var areaObj = $("#customer_area_text_ordinary");
		var areaOffset = $("#customer_area_text_ordinary").offset();
		$("#areaContent").css({left:(areaOffset.left+6) + "px", top:areaOffset.top + areaObj.outerHeight() + "px"}).slideDown("fast");
		$("body").bind("mousedown", onBodyDown);
	}

	function settingBranch(areaId){
		//归属分公司显示
		var branch_setting = {
				view: {
					dblClickExpand: false
				},
				data: {
					simpleData: {
						enable: true
					}
				},
				callback: {
					beforeClick: beforeClickBranch,
					onClick: onClickBranch
				}
			};
		$.post("<%=basePath%>customer/getBranchCompany?parentId="+areaId,
				function(data){
					var BranchzNodes =eval('('+data.branchs+')');
					var log, className = "dark";

					$.fn.zTree.init($("#branch_zTree"), branch_setting, BranchzNodes);
					var BranchzTree = $.fn.zTree.getZTreeObj("branch_zTree");
					BranchzTree.expandAll(true);
				}
			);
	}

	$(document).ready(function() {
		$.fn.zTree.init($("#area_zTree"), area_setting, AreazNodes);
		var AreazTree = $.fn.zTree.getZTreeObj("area_zTree");
		AreazTree.expandAll(true);

		//编辑普通客户信息时加载区域
		var areaId = $("#customer_area_ordinary").val();
		if(areaId!=""){
			settingBranch(areaId);
		}
		//编辑业主信息时加载项目信息
		var customerProject = $("#customer_project_merchant").val();
		if(customerProject!=""){
			setCustomerProject(customerProject);
		}
	});

	function setCustomerProject(str){
		var obj = eval("("+str+")");
		for(var j = 0;j<obj.length-1;j++){
			addRow();
		}
		for(var i = 0;i<obj.length;i++){
			$("table tr:not(:first)").eq(i).each(function(){
				$(this).find("td").eq(0).find("input").eq(0).val(obj[i].project_name);
				$(this).find("td").eq(1).find("input").eq(0).val(obj[i].project_descript);
			});
		}
	}

	function beforeClickBranch(treeId, treeNode) {
		var url = "<%=basePath%>customer/checkSubCompanyNode.do?id="+treeNode.id;
		$.post(
			url,
			function(data){
				if(data.msg=='success'){
					$("#customer_branch_ordinary").val(treeNode.id);
					$("#customer_branch_text_ordinary").val(treeNode.name);
					$("#branchContent").hide();
					return true;
				}
			}
		);
	}

	function onClickBranch(e, treeId, treeNode) {}

	function showBranchMenuOrdinary() {
		var branchObj = $("#customer_branch_text_ordinary");
		var branchOffset = $("#customer_branch_text_ordinary").offset();
		$("#branchContent").css({left:(branchOffset.left+6) + "px", top:branchOffset.top + branchObj.outerHeight() + "px"}).slideDown("fast");
		$("body").bind("mousedown", onBodyDown);
	}


	function hideMenu(event){
		event  =  event  ||  window.event; // 事件 
        var  target    =  event.target  ||  ev.srcElement; // 获得事件源 
        var  obj  =  target.getAttribute('id');
        if(obj!='customer_area_text_ordinary'){
			$("#areaContent").hide();
        }
	}
</script>
</body>

</html>
