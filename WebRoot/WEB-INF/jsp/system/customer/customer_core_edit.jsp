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
        // laydate(start);
        //  laydate(end);


        //检测查看/编辑操作
        function checkOperateType(){
            if($("#operateType").val()=='sel'){
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
        }

        //保存
        function save(){
            $("#customer_name").focus();
            if($("#customer_name").val()==""){
                $("#customer_name").tips({
                    side:3,
                    msg:"输入客户名称",
                    bg:'#AE81FF',
                    time:2
                });
                return false;
            }
            $("#collector_phone").focus();
            if($("#collector_phone").val()==""){
                $("#collector_phone").tips({
                    side:3,
                    msg:"输入集采负责人电话",
                    bg:'#AE81FF',
                    time:2
                });
                return false;
            }
            $("#collector_phone").focus();
            if(!(/^1[3|4|5|7|8]\d{9}$/.test($("#collector_phone").val()))){
                $("#collector_phone").tips({
                    side:3,
                    msg:"电话格式输入有误",
                    bg:'#AE81FF',
                    time:2
                });
                return false;
            }
            $("#collector_time").focus();
            if($("#collector_time").val()==""){
                $("#collector_time").tips({
                    side:3,
                    msg:"输入集采时间",
                    bg:'#AE81FF',
                    time:2
                });
                return false;
            }
            $("#has_cooperate_pro").focus();
            if($("#has_cooperate_pro").val()==""){
                $("#has_cooperate_pro").tips({
                    side:3,
                    msg:"是否曾经有过项目合作",
                    bg:'#AE81FF',
                    time:2
                });
                return false;
            }
            $("#now_cooperate_pro").focus();
            if($("#now_cooperate_pro").val()==""){
                $("#now_cooperate_pro").tips({
                    side:3,
                    msg:"当前是否有项目合作",
                    bg:'#AE81FF',
                    time:2
                });
                return false;
            }
            $("#is_core_cooperate").focus();
            if($("#is_core_cooperate").val()==""){
                $("#is_core_cooperate").tips({
                    side:3,
                    msg:"是否战略合作",
                    bg:'#AE81FF',
                    time:2
                });
                return false;
            }
            $("#customerCoreForm").submit();
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
        function checkCustomerName(){
            var operateType = $("#operateType").val();
            var old_customer_name;
            var customer_name;
            customer_name = $("#customer_name").val();
            old_customer_name = $("#old_customer_name").val();
            var url = "<%=basePath%>customerCore/checkName.do?customer_name="+customer_name+"&customer_type=Core"+"&old_customer_name="+old_customer_name+"&operateType="+operateType;
            $.post(
                url,
                function(data){
                    if(data.msg=='success'){
                    }else if(data.msg=='error'){
                        $("#customer_name").focus();
                        $("#customer_name").tips({
                            side:3,
                            msg:"该客户名称已存在",
                            bg:'#AE81FF',
                            time:2
                        });
                    }
                }
            );
        }
        $(function () {
            $("#customer_name").autocomplete({
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
                minLength: 2
            });
        });
	</script>
</head>

<body class="gray-bg" onload="checkOperateType();" onclick="hideMenu();">
<form action="customerCore/${msg}.do" name="customerCoreForm" id="customerCoreForm" method="post">
	<input style="width:170px" type="hidden" name="operateType"  id="operateType" value="${operateType}"/>
	<input style="width:170px" type="hidden" name="input_user"  id="input_user" value="${input_user}"/>
	<input style="width:170px" type="hidden" name="operateType" id="operateType" value="${operateType }"/>
	<input style="width:170px" type="hidden" name="customer_id"  id="customer_id" value="${pd.customer_id }"/>

	<div class="wrapper wrapper-content" style="z-index: -1">
		<div class="row">
			<div class="col-sm-12" >
				<div class="ibox float-e-margins">
					<div class="ibox-content">
						<!-- 战略客户信息  开始 -->
						<div class="row" style="padding-left: 15px">
							<div class="row">
								<div class="col-sm-12">
									<div class="panel panel-primary">
										<div class="panel-heading">
											客户基本信息
										</div>
										<div class="panel-body">
											<div class="form-group form-inline">
												<label style="width:10%;margin-top: 25px;margin-bottom: 10px"><span><font color="red">*</font></span>客户名称:</label>
												<div style="display: inline" class=" ui-widget">
													<input style="width:22%" type="text" name="customer_name" id="customer_name"  value="${pd.customer_name}" ${operateType=='edit'&&editType==pd.customer_type?"readonly='readonly'":""} placeholder="这里输入客户名称"  title="客户名称"  class="form-control" onblur="checkCustomerName();">
												</div>
												<label style="width:10%;margin-top: 25px;margin-bottom: 10px"><span><font color="red">*</font></span>客户级别:</label>
												<select style="width:22%" name="customer_level" id="customer_level" class="form-control m-b">
													<option value="">请选择客户级别</option>
													<option value="A" ${pd.customer_level=="A"?"selected":""}>100强</option>
													<option value="B" ${pd.customer_level=="B"?"selected":""}>500强</option>
													<option value="C" ${pd.customer_level=="C"?"selected":""}>地方性</option>
												</select>
												<input type="hidden" id="old_customer_name" value="${pd.customer_name }"/>
												<c:if test="${operateType != 'add' }">
													<label style="width:10%;margin-top: 25px;margin-bottom: 10px"><span><font color="red">*</font></span>客户编号:</label>
													<input style="width:24%" readonly="readonly" name="customer_no" id="customer_no" value="${pd.customer_no}" class="form-control" style="width:170px" placeholder="这里输入客户编号" type="text">
												</c:if>
												<label style="width:130px;margin-left: 20px;display:none">客户类型:</label>
												<input style="width:170px" type="hidden" disabled="disabled" value="战略客户"  title="客户类型"   class="form-control"/>
												<input style="width:170px" type="hidden" name="customer_type" id="customer_type"  value="Core"    title="客户类型"   class="form-control">
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-sm-12">
									<div class="panel panel-primary">
										<div class="panel-heading">
											集采人信息
										</div>
										<div class="panel-body">
											<div class="form-group form-inline">
												<label style="width:10%;margin-top: 25px;margin-bottom: 10px">集采负责人:</label>
												<select style="width:22%" id="collector" name="collector" class="selectpicker" data-live-search="true" title="请选择负责人">
													<c:forEach items="${collectors}" var="var" >
														<option value="${var.USER_ID  }"${var.USER_ID==pd.collector?'selected':'' } >${var.NAME }</option>
													</c:forEach>
												</select>
												<label style="width:10%;margin-top: 25px;margin-bottom: 10px"><span><font color="red">*</font></span>集采时间:</label>
												<input style="width:22%" type="text" name="collector_time" id="collector_time"  value="${pd.collector_time}" placeholder="这里输入集采时间"   title="集采时间"   class="form-control layer-date" onclick="laydate()">
												<label style="width:10%;margin-top: 25px;margin-bottom: 10px"><span><font color="red">*</font></span>集采负责人电话:</label>
												<input style="width:24%" type="text" name="collector_phone" id="collector_phone"  value="${pd.collector_phone}" placeholder="这里输入集采负责人电话"   title="集采负责人电话"   class="form-control">
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-sm-12">
									<div class="panel panel-primary">
										<div class="panel-heading">
											其他关键人信息
										</div>
										<div class="panel-body">
											<div class="form-group form-inline">
												<label style="width:10%;margin-top: 25px;margin-bottom: 10px">其他关键人姓名1:</label>
												<input style="width:22%" type="text" name="keyperson_name1" id="keyperson_name1"  value="${pd.keyperson_name1}"  placeholder="这里输入其他关键人姓名"  title="其他关键人姓名"  class="form-control">
												<label style="width:10%;margin-top: 25px;margin-bottom: 10px">其他关键人职位1:</label>
												<input style="width:22%" type="text" name="keyperson_duty1" id="keyperson_duty1"  value="${pd.keyperson_duty1}"   placeholder="这里输入其他关键人职位" title="其他关键人职位"   class="form-control">
												<label style="width:10%;margin-top: 25px;margin-bottom: 10px">其他关键人电话1:</label>
												<input style="width:24%" type="text" name="keyperson_phone1" id="keyperson_phone1"  value="${pd.keyperson_phone1}"    placeholder="这里输入其他关键人电话" title="其他关键人电话"   class="form-control">
											</div>
											<div class="form-group form-inline">
												<label style="width:10%;margin-top: 25px;margin-bottom: 10px">其他关键人姓名2:</label>
												<input style="width:22%" type="text" name="keyperson_name2" id="keyperson_name2"  value="${pd.keyperson_name2}"  placeholder="这里输入其他关键人姓名"  title="其他关键人姓名"  class="form-control">
												<label style="width:10%;margin-top: 25px;margin-bottom: 10px">其他关键人职位2:</label>
												<input style="width:22%" type="text" name="keyperson_duty2" id="keyperson_duty2"  value="${pd.keyperson_duty2}"   placeholder="这里输入其他关键人职位" title="其他关键人职位"   class="form-control">
												<label style="width:10%;margin-top: 25px;margin-bottom: 10px">其他关键人电话2:</label>
												<input style="width:24%" type="text" name="keyperson_phone2" id="keyperson_phone2"  value="${pd.keyperson_phone2}"  placeholder="这里输入其他关键人电话"  title="其他关键人电话"   class="form-control">
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-sm-12">
									<div class="panel panel-primary">
										<div class="panel-heading">
											合作信息
										</div>
										<div class="panel-body">
											<div class="form-group form-inline" >
												<label style="width:10%;margin-top: 25px;margin-bottom: 10px"><span><font color="red">*</font></span>是否曾经有过项目合作:</label>
												<select style="width:22%" name="has_cooperate_pro" id="has_cooperate_pro" class="form-control m-b">
													<option value="1" ${pd.has_cooperate_pro==1?'selected':'' }>是</option>
													<option value="0" ${pd.has_cooperate_pro==0?'selected':'' }>否</option>
												</select>
												<label style="width:10%;margin-top: 25px;margin-bottom: 10px"><span><font color="red">*</font></span>当前是否有项目合作:</label>
												<select style="width:22%" name="now_cooperate_pro" id="now_cooperate_pro" class="form-control m-b">
													<option value="1" ${pd.now_cooperate_pro==1?'selected':'' }>是</option>
													<option value="0" ${pd.now_cooperate_pro==0?'selected':'' }>否</option>
												</select>
												<!-- 合作项目设置为隐藏 -->
												<label style="width:130px;display:none">合作项目:</label>
												<input style="width:170px" type="hidden" name="cooperate_pro_id" id="cooperate_pro_id"  value="${pd.cooperate_pro_id}"  placeholder="这里输入合作项目"  title="合作项目"   class="form-control">
												<!-- 合作项目设置为隐藏 -->
												<label style="width:10%;margin-top: 25px;margin-bottom: 10px"><span><font color="red">*</font></span>是否战略合作:</label>
												<select style="width:24%" name="is_core_cooperate" id="is_core_cooperate" class="form-control m-b">
													<option value="1" ${pd.is_core_cooperate==1?'selected':'' }>是</option>
													<option value="0" ${pd.is_core_cooperate==0?'selected':'' }>否</option>
												</select>
											</div>
											<div class="form-group form-inline" >
												<label style="width:10%;margin-top: 25px;margin-bottom: 10px">战略合作期限:</label>
												<input style="width:22%" type="text" name="core_cooperate_date" id="core_cooperate_date"  value="${pd.core_cooperate_date}"  placeholder="这里输入战略合作期限"  title="战略合作期限"   class="form-control layer-date" onclick="laydate()">
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-sm-12">
									<div class="panel panel-primary">
										<div class="panel-heading">
											合同信息
										</div>
										<div class="panel-body">
											<div class="form-group form-inline">
												<!-- 项目进展状态设置为隐藏 -->
												<label style="width:130px;display:none">项目进展状态:</label>
												<input style="width:170px" type="hidden" name="pro_status" id="pro_status"  value="${pd.pro_status}"  placeholder="这里输入项目进展状态"  title="项目进展状态"  class="form-control">
												<!-- 项目进展状态设置为隐藏 -->
												<label style="width:10%;margin-top: 25px;margin-bottom: 10px">协议台量:</label>
												<input style="width:22%" type="text" name="core_cooperate_num" id="core_cooperate_num"  value="${pd.core_cooperate_num}"  placeholder="这里输入协议台量"  title="协议台量"  class="form-control">
												<label style="width:10%;margin-top: 25px;margin-bottom: 10px">合同金额:</label>
												<input style="width:22%" type="text" name="core_cooperate_money" id="core_cooperate_money"  value="${pd.core_cooperate_money}"  placeholder="这里输入合同金额"  title="合同金额"   class="form-control">
											</div>
											<div class="form-group form-inline">
												<label style="width:10%;margin-top: 25px;margin-bottom: 10px">战略合作协议:</label>
												<input style="width:22%" class="form-control" type="file"  title="战略合作协议" onchange="upload(this,$('#core_cooperate_agre'))" />
												<input class="form-control" type="hidden" name="core_cooperate_agre" id="core_cooperate_agre"  value="${pd.core_cooperate_agre}" title="战略合作协议"  />
												<c:if test="${pd ne null and pd.core_cooperate_agre ne null and pd.core_cooperate_agre ne '' }">
													<a class="btn btn-mini btn-success" onclick="downFile($('#core_cooperate_agre'))">下载附件</a>
												</c:if>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- 战略客户信息  结束 -->
					</div>
					<div style="height: 20px;"></div>
					<tr>
						<c:if test="${operateType!='sel'}">
							<td><a class="btn btn-primary"style="width: 150px; height:34px;float:left;"  onclick="save();">保存</a>
							</td>
						</c:if>
						<td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('EditCustomerCore');">关闭</a></td>
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
    var company_setting = {
        data: {
            simpleData: {
                enable: true
            }
        },
        callback: {
            beforeClick: beforeClickCompany
        }
    };

    var AreazNodes =${areas};
    var CompanyzNodes =${companys==null?'[]':companys};
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
                    return true;
                }
            }
        );
    }

    function onClickArea(e, treeId, treeNode) {
    }

    function beforeClickCompany(treeId, treeNode, clickFlag) {
        $("#customer_company_ordinary").val(treeNode.id);
        $("#customer_company_text_ordinary").val(treeNode.name);
        $("#customer_company_merchant").val(treeNode.id);
        $("#customer_company_text_merchant").val(treeNode.name);
        $("#customer_company_core").val(treeNode.id);
        $("#customer_company_text_core").val(treeNode.name);
        $("#companyContent").hide();
    }



    $(document).ready(function() {
        $.fn.zTree.init($("#area_zTree"), area_setting, AreazNodes);
        var AreazTree = $.fn.zTree.getZTreeObj("area_zTree");
        AreazTree.expandAll(true);
        $.fn.zTree.init($("#company_zTree"), company_setting, CompanyzNodes);
        var CompanyzTree = $.fn.zTree.getZTreeObj("company_zTree");
        CompanyzTree.expandAll(true);


    });


    function showAreaMenuOrdinary() {
        var areaObj = $("#customer_area_text_ordinary");
        var areaOffset = $("#customer_area_text_ordinary").offset();
        $("#areaContent").css({left:(areaOffset.left+6) + "px", top:areaOffset.top + areaObj.outerHeight() + "px"}).slideDown("fast");
        $("body").bind("mousedown", onBodyDown);
    }

	/*function showMenuMerchant() {
	 var areaObj = $("#area_id_text_merchant");
	 var areaOffset = $("#area_id_text_merchant").offset();
	 $("#areaContent").css({left:(areaOffset.left+6) + "px", top:areaOffset.top + areaObj.outerHeight() + "px"}).slideDown("fast");
	 $("body").bind("mousedown", onBodyDown);
	 }*/


    function showCompanyMenuOrdinary() {
        var companyObj = $("#customer_company_text_ordinary");
        var companyOffset = $("#customer_company_text_ordinary").offset();
        $("#companyContent").css({left:(companyOffset.left+6) + "px", top:companyOffset.top + companyObj.outerHeight() + "px"}).slideDown("fast");
        $("body").bind("mousedown", onBodyDown);
    }

	/*function showCompanyMenuMerchant() {
	 var companyObj = $("#customer_company_text_merchant");
	 var companyOffset = $("#customer_company_text_merchant").offset();
	 $("#companyContent").css({left:(companyOffset.left+6) + "px", top:companyOffset.top + companyObj.outerHeight() + "px"}).slideDown("fast");
	 $("body").bind("mousedown", onBodyDown);
	 }*/

    function showCompanyMenuCore() {
        var companyObj = $("#customer_company_text");
        var companyOffset = $("#customer_company_text").offset();
        $("#companyContent").css({left:(companyOffset.left+6) + "px", top:companyOffset.top + companyObj.outerHeight() + "px"}).slideDown("fast");
        $("body").bind("mousedown", onBodyDown);
    }
    function hideMenu(event){
        event  =  event  ||  window.event; // 事件
        var  target    =  event.target  ||  ev.srcElement; // 获得事件源
        var  obj  =  target.getAttribute('id');
        if(obj!='customer_area_text_ordinary'){
            $("#areaContent").hide();
        }
        if(obj!='customer_company_text_ordinary'&&obj!='customer_company_text_merchant'&&obj!='customer_company_text'){
            $("#companyContent").hide();
        }
    }
</script>
</body>

</html>
