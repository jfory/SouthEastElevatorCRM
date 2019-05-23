<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <base href="<%=basePath%>">
    <!-- jsp文件头和头部 -->
    <%@ include file="../../system/admin/top.jsp"%>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- 图片插件 -->
        <link href="static/js/fancybox/jquery.fancybox.css" rel="stylesheet">
        <!-- Check Box -->
        <link href="static/js/iCheck/custom.css" rel="stylesheet">
        <!-- Sweet Alert -->
        <link href="static/js/sweetalert/sweetalert.css" rel="stylesheet">
        <link href="static/js/sweetalert2/sweetalert2.css" rel="stylesheet">
        <title>${pd.SYSNAME}</title>
    </head>

<body class="gray-bg">
<div class="wrapper wrapper-content animated fadeInRight">
    <div id="zhjView" class="animated fadeIn"></div>
    <div id="handleLeave" class="animated fadeIn"></div>
    <div id="handleLeave1" class="animated fadeIn"></div>
    <div id="handleLeave2" class="animated fadeIn"></div>
    <div id="SeeTask" class="animated fadeIn" style="width: 800px;height: 600"></div>
    <div class="row">
        <div id="top" name="top">
<!--             <div class="col-sm-6"> -->

           
             <div class="col-sm-12">
             <form role="form" class="form-inline" action="head/goDefaultc.do" method="post" name="headForm" id="headForm">
                        <table class="table table-striped table-bordered table-hover" style="width:25%" >
                            <tr>
                                <th>滞留项目数：
                                <a onclick="ziliuyujing(1);">
                                <font color="#FF0000">${itemCount}
                                </font></a>
                                                                                         
                                </th>
                            </tr>
                            <tr>
                                <th>到期应收款数：
                                <a onclick="yingshouyujing(2);">
                                <font color="#FF0000">${yskCount}
                                </font></a>&nbsp;&nbsp;&nbsp;&nbsp;
                                <input style="width:60px" type="text" name="DQTS" id="DQTS" VALUE="${DQTS}"
                                 placeholder="到期天数" >
                                </th>
                            </tr>
                        </table>
                        </form>
            </div>
            

  <input type="hidden" id="MENU_NAME" name="MENU_NAME" value="${caidan}" class="form-control">


  

 			<div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>待办任务</h5>
                       <%--  ${rolist}  --%>
                    </div>
                    <div class="ibox-content1">

						<div class="form-group form-inline">
							<label style="width:8%;margin-bottom: 10px">名称:</label>
                            <input style="width:20%;" class="form-control" id="project_name" type="text"
                                                   name="project_name" value="" >
							<label style="margin-left:5px;width:8%;margin-bottom: 10px">任务类别:</label>
							<select style="width: 20%;" class="form-control" id="s_task_type" name="s_task_type">
								<option value=""></option>
								<option value="1">报价折扣审核</option>
								<option value="3">代理商审核</option>
								<option value="4">设备合同审核</option>
								<option value="5">安装合同审核</option>
								<option value="6">变更协议审核</option>
								<option value="7">非标申请审核</option>
								<option value="8">项目报备跨区审核</option>
								<option value="9">开票审核</option>
							</select>
							<button id="btn_sreachtask" style="margin-left:5px;margin-top:5px;" class="btn  btn-primary btn-sm" 
													  title="搜索" type="button"onclick="sreachTask();">搜索</button>
						  	<button id="btn_refresh" class="btn  btn-success" title="刷新" type="button"
                                style="float: right" onclick="sreachTask('1');">刷新
                        </button>
						</div>
						
                        <table class="table table-striped table-bordered table-hover">
                            <thead>
                            <tr>
                                <th>序号</th>
                                <th>项目名称</th>
                                <th>发布时间</th>
                                <th>发布人</th>
                                <th>当前节点</th>
                                <th>任务类别</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody id="taskbody">
                               <!-- 开始循环 -->
								<c:choose>
								  <c:when test="${not empty Tasks}">
									  <c:forEach items="${Tasks}" var="e" varStatus="vs">
										<tr>		
											<td class='center' style="width: 30px;">${vs.index+1}</td>
											<td>${e.item_name}</td>
											<td>${e.TASK_TIME}</td>
											<td>${e.user_name}</td>
											<td>${e.task_name}</td>
											<td style="color:red;">
											    ${e.TASK_TYPE=="1"?"报价折扣审核":""}
											    ${e.TASK_TYPE=="2"?"分包商审核":""}
											    ${e.TASK_TYPE=="3"?"代理商审核":""}
											    ${e.TASK_TYPE=="4"?"设备合同审核":""}
											    ${e.TASK_TYPE=="5"?"安装合同审核":""}
											    ${e.TASK_TYPE=="6"?"变更协议审核":""}
											    ${e.TASK_TYPE=="7"?"非标申请审核":""}
											    ${e.TASK_TYPE=="8"?"项目报备跨区审核":""}
											    ${e.TASK_TYPE=="9"?"开票审核":""}
											</td>
											<td style="text-align:center;">
												<!--<button class="btn  btn-info btn-sm" title="办理" type="button" onclick="offerAudit('${e.TASK_TYPE}');">办理</button>-->
												<button class="btn  btn-success btn-sm" title="查看" type="button" onclick="See('${eo.offer_no}','${eo.item_id}')">查看</button>
												<c:if test="${e.type == '0'}">
													<button class="btn  btn-primary btn-sm" title="签收" type="button" onclick="claimstra(this,'${eo.task_id}','${eo.offer_id}','${eo.offer_no}');">签收</button>
												</c:if>
												<c:if test="${e.type == '1'}">
													<c:if test="${e.instance_status == 2 || eo.instance_status == 3}">
													<button class="btn  btn-warning btn-sm" title="办理" type="button" onclick="goHandlestra('${eo.task_id}','${eo.offer_id}','${eo.offer_no}');">办理</button>
													</c:if>
													<c:if test="${e.instance_status == 5}">
													<button class="btn  btn-warning btn-sm" title="重新提交" type="button" onclick="restartAgent('${eo.task_id }','${eo.offer_id}');">重新提交</button>
													</c:if>
												</c:if>
										  	</td>
									  </tr>
									</c:forEach>
							    </c:when>
							<c:otherwise>
								<tr class="main_info">
									<td colspan="100" class="center">没有相关数据</td>
								</tr>
							</c:otherwise>
						</c:choose>
                        </tbody>

                        </table>
                            <tr>
                                <!-- <a style="float:right">更多>></a> -->
                            </tr>

                    </div>
                </div>
<!--                 <div class="ibox float-e-margins"> -->
<!--                     <div class="ibox-title"> -->
<!--                         <h5>图表1</h5> -->

<!--                     </div> -->
<!--                     <div class="ibox-content1"> -->
<!--                         <div id="morris-bar-chart"></div> -->
<!--                     </div> -->
<!--                 </div> -->
            </div>

            
<!--         <div class="col-sm-6"> -->
<!--             <div class="ibox float-e-margins"> -->
<!--                 <div class="ibox-title"> -->
<!--                     <h5>图表2</h5> -->
<!--                 </div> -->
<!--                 <div class="ibox-content1"> -->
<!--                     <div id="morris-one-line-chart"></div> -->
<!--                 </div> -->
<!--             </div> -->

<!--             <div class="ibox float-e-margins"> -->
<!--                 <div class="ibox-title"> -->
<!--                     <h5>图表3</h5> -->
<!--                 </div> -->
<!--                 <div class="ibox-content1"> -->
<!--                     <div id="morris-donut-chart"></div> -->
<!--                 </div> -->
<!--             </div> -->
<!--         </div> -->
        </div>
    </div>
</div>
<!-- Fancy box -->
<script src="static/js/fancybox/jquery.fancybox.js"></script>
<!-- iCheck -->
<script src="static/js/iCheck/icheck.min.js"></script>
<!-- Sweet alert -->
<script src="static/js/sweetalert/sweetalert.min.js"></script>
<%--morris
<script src="static/js/morris/morris.js"></script>
<script src="static/js/morris/raphael-2.1.0.min.js"></script>
<script src="static/js/demo/morris-demo.js"></script>--%>
<script src="static/js/sweetalert2/es6-promise.auto.min.js"></script>
	<script src="static/js/sweetalert2/sweetalert2.js"></script>
	    <!-- 日期控件-->
    <script src="static/js/layer/laydate/laydate.js"></script>
<script type="text/javascript">

    $(document).ready(function(){
        loadAuditData();
    });
function offerAudit(non_standrad_id,type,offer_id,HT_NO,item_id,flag)
{

	var sumStr=$("#MENU_NAME").val();
	var str;
	if(type==1){str="项目报价审核";}
	else if(type==2){str="分包商审核";}
	else if(type==3){str="代理商审核";}
	else if(type==4){str="设备合同审核";}
	else if(type==5){str="安装合同审核";}
	else if(type==6){str="合同变更审核";}
	else if(type==7){str="非标申请审核";}
	else if(type==8){str="项目跨区审核";}
	else if(type==9){str="开票审核";}

	
	if(sumStr.indexOf(str)>-1){
	    // 包含  
    var url;
	     if(type==1){url="<%=basePath%>e_offer/e_offerAudit.do?offer_id="+offer_id+"&flag="+flag;}
	else if(type==2){url="<%=basePath%>sysAgent/listPendingAgent.do";}
	else if(type==3){url="<%=basePath%>sysAgent/listPendingAgent.do";}
	else if(type==4){url="<%=basePath%>contractNew/ContractAudit.do?HT_NO="+HT_NO+"&flag="+flag;}
	else if(type==5){url="<%=basePath%>contractNewInstallation/ContractAudit.do?HT_NO="+HT_NO+"&flag="+flag;}
	else if(type==6){url="<%=basePath%>contractModify/ContractAudit.do?HT_NO="+HT_NO+"&flag="+flag;}
	else if(type==7){url="<%=basePath%>nonStandrad/listAuditNonstandrad.do?non_standrad_id="+non_standrad_id+"&flag="+flag;}
	else if(type==8){url="<%=basePath%>item/ItemAudit.do?item_id="+item_id+"&flag="+flag;}
	else if(type==9){url="<%=basePath%>newInvoice/ContractAudit.do?HT_NO="+HT_NO+"&flag="+flag;}
	 $("#handleLeave").kendoWindow({
		 width: "600px",
		 height: "400px",
		 title: "办理任务",
		 actions: ["Close"],
		 content: url,
		 modal : true,
		 visible : false,
		 resizable : true
	 }).data("kendoWindow").maximize().open(); 
	}else{
		swal({
            title:"没有审批权限。",
            html:true
        }) 
	}
	
	
	
	 
	 
}

function ziliuyujing(type)
{
	var url="<%=basePath%>item/listItem.do?ZL_TYPE=滞留";
	 $("#handleLeave1").kendoWindow({
		 width: "600px",
		 height: "400px",
		 title: "滞留项目预警",
		 actions: ["Close"],
		 content: url,
		 modal : true,
		 visible : false,
		 resizable : true
	 }).data("kendoWindow").maximize().open();
}


function yingshouyujing(type)
{
	var DQTS=$("#DQTS").val();
	var url="<%=basePath%>newcollect/collectList.do?DQTS="+DQTS;
	 $("#handleLeave2").kendoWindow({
		 width: "600px",
		 height: "400px",
		 title: "应收款预警",
		 actions: ["Close"],
		 content: url,
		 modal : true,
		 visible : false,
		 resizable : true
	 }).data("kendoWindow").maximize().open();
}


$("#DQTS").change(function(){
	$("#headForm").submit();
});

function loadAuditData() {
	var project_name = $('#project_name').val();
	var task_type = $('#s_task_type').val();
	$('#btn_sreachtask').attr("disabled", "disabled");
	$('#btn_refresh').attr("disabled", "disabled");
	stopShow = false;
	
    $.ajax({
        type: "POST",
        url:"<%=basePath%>head/getTaskData.do",
        data: {
        	"project_name":project_name,
        	"task_type":task_type
        },
        dataType: 'json',
        cache: false,
        success: function (data) {
            addTaskTable(data);
        	$('#btn_sreachtask').removeAttr("disabled");
        	$('#btn_refresh').removeAttr("disabled");
        },
        error:function (data) {
        	$('#btn_sreachtask').removeAttr("disabled");
        	$('#btn_refresh').removeAttr("disabled");
        }
    });
}
function addTaskTable(result) {
	
    if(result){
        $("#taskbody").html("");
        for (var i=0;i<result.length;i++){
        	if (result[i].type==1) {
				//待处理
        		$("#taskbody").append(
		                '<tr id="tasktr'+i+'" style="display: none;">' +
		                '<td class="center" style="width: 30px;">'+(i+1)+'</td>' +
		                '<td><a href="javascript:;" onclick="SeeDetail(\''+result[i].task_id+'\',\''+(result[i].invoice_id?result[i].invoice_id:result[i].id)+'\',\''+(result[i].modify_id?result[i].modify_id:result[i].id)+'\',\''+result[i].AZ_UUID+'\',\''+result[i].HT_UUID+'\',\''+result[i].agent_id+'\',\''+result[i].non_standrad_id+'\',\''+result[i].item_id+'\',\''+result[i].offer_no+'\',\''+result[i].TASK_TYPE+'\');">'+result[i].item_name+'</a></td>' +
		                '<td>'+result[i].TASK_TIME+'</td>' +
		                '<td>'+result[i].user_name+'</td>' +
		                '<td>'+result[i].task_name+'</td>' +
		                '<td style="color:red;">'+getTaskType(result[i].TASK_TYPE)+'</td>' +
		                '<td style="text-align:center;">' +
		                '<button class="btn  btn-warning btn-sm" title="办理" type="button" onclick="goHandlestra(\''+result[i].task_id+'\',\''+(result[i].invoice_id?result[i].invoice_id:result[i].id)+'\',\''+(result[i].modify_id?result[i].modify_id:result[i].id)+'\',\''+result[i].AZ_UUID+'\',\''+result[i].HT_UUID+'\',\''+result[i].agent_id+'\',\''+result[i].non_standrad_id+'\',\''+result[i].item_id+'\',\''+result[i].offer_no+'\',\''+result[i].TASK_TYPE+'\');">办理</button>' +
		                '</td>' +
		                ' </tr>'
		            );
			}else{
				//待签收
				$("#taskbody").append(
		                '<tr id="tasktr'+i+'" style="display: none;">' +
		                '<td class="center" style="width: 30px;">'+(i+1)+'</td>' +
		                '<td><a href="javascript:;" onclick="SeeDetail(\''+result[i].task_id+'\',\''+(result[i].invoice_id?result[i].invoice_id:result[i].id)+'\',\''+(result[i].modify_id?result[i].modify_id:result[i].id)+'\',\''+result[i].AZ_UUID+'\',\''+result[i].HT_UUID+'\',\''+result[i].agent_id+'\',\''+result[i].non_standrad_id+'\',\''+result[i].item_id+'\',\''+result[i].offer_no+'\',\''+result[i].TASK_TYPE+'\');">'+result[i].item_name+'</a></td>' +
		                '<td>'+result[i].TASK_TIME+'</td>' +
		                '<td>'+result[i].user_name+'</td>' +
		                '<td>'+result[i].task_name+'</td>' +
		                '<td style="color:red;">'+getTaskType(result[i].TASK_TYPE)+'</td>' +
		                '<td style="text-align:center;">' +
		                '<button class="btn  btn-info btn-sm" title="签收" type="button" onclick="claimstra(this,\''+result[i].task_id+'\',\''+(result[i].invoice_id?result[i].invoice_id:result[i].id)+'\',\''+(result[i].modify_id?result[i].modify_id:result[i].id)+'\',\''+result[i].AZ_UUID+'\',\''+result[i].HT_UUID+'\',\''+result[i].agent_id+'\',\''+result[i].non_standrad_id+'\',\''+result[i].item_id+'\',\''+result[i].offer_no+'\',\''+result[i].TASK_TYPE+'\');">签收</button>' +
		                '</td>' +
		                ' </tr>'
		            );
			}
            
        }
        showTaskTr(0,result.length);
    }


}

	//签收任务
	function claimstra(ele,task_id,invoice_id,modify_id,AZ_UUID,HT_UUID,agent_id,non_standrad_id,item_id,offer_no,task_flag){
		console.log(task_flag);
		var url = "";
		switch (task_flag) {
	        case "1":
	        	//报价审核
	        	url="<%=basePath%>e_offer/claim.do?task_id="+task_id+"&tm="+new Date().getTime();
	        	break;
	        case "2":
	        	//分包商审核
	        	url = "<%=basePath%>sysAgent/claim.do?task_id="+task_id+"&tm="+new Date().getTime();
	        	break;
	        case "3":
	        	//代理商审核
	        	url = "<%=basePath%>sysAgent/claim.do?task_id="+task_id+"&tm="+new Date().getTime();
	        	break;
	        case "4":
	        	//设备合同审核
	        	url = "<%=basePath%>contractNew/claim.do?task_id="+task_id+"&tm="+new Date().getTime();
	        	break;
	        case "5":
	        	url = "<%=basePath%>contractNewInstallation/claim.do?task_id="+task_id+"&tm="+new Date().getTime();
	            break;
	        case "6":
	        	//合同变更审核
	        	url = "<%=basePath%>contractModify/claim.do?task_id="+task_id+"&tm="+new Date().getTime();
	            break;
	        case "7":
	        	//非标审核
	        	var url = "<%=basePath%>nonStandrad/claim.do?task_id="+task_id+"&tm="+new Date().getTime();
	            break;
	        case "8":
	        	//项目跨区审核
	        	url = "<%=basePath%>contractNew/claim.do?task_id="+task_id+"&tm="+new Date().getTime();
	        	break;
	        case "9":
	        	//开票审核
	        	url = "<%=basePath%>newInvoice/claim.do?task_id="+task_id+"&tm="+new Date().getTime();
	            break;
    	}
		
		 swal({
			 title: "您确定要签收这条任务吗？",
			 text: "签收后将请对该任务进行处理！",
			 type: "warning",
			 showCancelButton: true,
			 confirmButtonColor: "#DD6B55",
			 confirmButtonText: "签收",
			 cancelButtonText: "取消",
			 showLoaderOnConfirm: true,
	        allowOutsideClick: false,
	        preConfirm: function() {
	            return new Promise(function(resolve, reject) {
					 $.get(url, function (data) {
						 if (data.msg == "success") {
							 swal({
								 title: "签收成功！",
								 text: "您已经成功签收了这个任务,请对该任务进行处理。",
								 type: "success",
							 }).then(function(){
								 //refreshCurrentTab(2);
								 $(ele).parent().append('<button class="btn  btn-warning btn-sm" title="办理" type="button" onclick="goHandlestra(\''+task_id+'\',\''+invoice_id+'\',\''+modify_id+'\',\''+AZ_UUID+'\',\''+HT_UUID+'\',\''+agent_id+'\',\''+non_standrad_id+'\',\''+item_id+'\',\''+offer_no+'\',\''+task_flag+'\');">办理</button>');
								 $(ele).remove();
							 });
						 } else {
							 swal({
								 title: "签收失败！",
								 text:  data.err,
								 type: "error",
								 showConfirmButton: false,
								 timer: 1000
							 });
						 }
					 });
	                
	            })
	        }
		 }).then(function (isConfirm) {
			 if (isConfirm === true) {
				 
			 } else if (isConfirm === false) {
				 swal({
					 title: "取消签收！",
					 text: "您已经取消签收操作了！",
					 type: "error",
					 showConfirmButton: false,
					 timer: 1000
				 });
			 }
		 });
	}
	
	//办理任务
	function goHandlestra(task_id,invoice_id,modify_id,AZ_UUID,HT_UUID,agent_id,non_standrad_id,item_id,offer_no,task_flag){
		var url = "";
		var offer_id="";
		var _handleid = "handleLeave";
		switch (task_flag) {
        case "1":
        	//报价办理
        	url='<%=basePath%>e_offer/goHandStra.do?task_id='+task_id+'&offer_no='+offer_no;
        	break;
        case "2":
        	//分包商办理
        	url='<%=basePath%>sysAgent/goHandleContractor?task_id='+task_id+'&agent_id='+agent_id;
            break;
        case "3":
        	//代理商办理
            url='<%=basePath%>sysAgent/goHandleAgent?task_id='+task_id+'&agent_id='+agent_id;
            break;
        case "4":
        	//设备合同办理
            url='<%=basePath%>contractNew/goHandStra.do?task_id='+task_id+'&HT_UUID='+HT_UUID;
            break;
        case "5":
        	//安装合同办理
        	url ='<%=basePath%>contractNewInstallation/goHandStra.do?task_id='+task_id+'&AZ_UUID='+AZ_UUID;
            break;
        case "6":
        	//合同变更审核
        	url='<%=basePath%>contractModify/goHandStra.do?task_id='+task_id+'&id='+modify_id;
            break;
        case "7":
        	//非标办理
        	url='<%=basePath%>nonStandrad/preAuditNonStandrad.do?task_id='+task_id+'&non_standrad_id='+non_standrad_id;
        	_handleid = 'zhjView';
            break;
        case "8":
        	//项目跨区办理
        	url='<%=basePath%>item/goHandStra.do?task_id='+task_id+'&item_id='+item_id;
            break;
        case "9":
        	//开票审核
        	url='<%=basePath%>newInvoice/goHandStra.do?task_id='+task_id+'&id='+invoice_id;
            break;
	}
		$("#"+_handleid).kendoWindow({
			 width: "600px",
			 height: "400px",
			 title: "办理任务",
			 actions: ["Close"],
			 content: url,
			 modal : true,
			 visible : false,
			 resizable : true
		}).data("kendoWindow").maximize().open();
	}
	
function getTaskType(ttype) {
    switch (ttype) {
        case "1":
            return "报价折扣审核"; break;
        case "2":
            return "分包商审核"; break;
        case "3":
            return "代理商审核"; break;
        case "4":
            return "设备合同审核"; break;
        case "5":
            return "安装合同审核"; break;
        case "6":
            return "变更协议审核"; break;
        case "7":
            return "非标申请审核"; break;
        case "8":
            return "项目报备跨区审核"; break;
        case "9":
            return "开票审核"; break;
    }
}
var stopShow = false;
function showTaskTr(idx,len){
    if(idx<len && !stopShow){
        setTimeout(function () {
            $("#tasktr"+idx).show(500);
            showTaskTr(idx+1,len);
        },200) ;
    }

}
	//查看任务
	function SeeDetail(task_id,invoice_id,modify_id,AZ_UUID,HT_UUID,agent_id,non_standrad_id,item_id,offer_no,task_flag){
		var url = "";
		var operateType ="sel";
		var newinvoinceType ="CK";
		var _seeid = "handleLeave";
		switch (task_flag) {
		    case "1":
		    	//报价查看
		    	url='<%=basePath%>e_offer/SeeEoffer.do?offer_no=' + offer_no + '&item_id=' + item_id;
		    	break;
		    case "2":
		    	//分包商查看
		    	url='<%=basePath%>sysAgent/toView.do?agent_id='+agent_id;
		        break;
		    case "3":
		    	//代理商查看
		        url='<%=basePath%>sysAgent/toView.do?agent_id='+agent_id;
		        break;
		    case "4":
		    	//设备合同查看
		        url='<%=basePath%>contractNew/goView.do?HT_UUID=' + HT_UUID;
		        break;
		    case "5":
		    	//安装合同查看
		    	url ='<%=basePath%>contractNewInstallation/goView.do?AZ_UUID=' + AZ_UUID;
		        break;
		    case "6":
		    	//合同变更查看
		    	url='<%=basePath%>contractModify/goEdit.do?id=' + modify_id+'&forwardMsg=view';
		        break;
		    case "7":
		    	//非标查看
		    	url='<%=basePath%>nonStandrad/preEditNonStandrad.do?non_standrad_id='+non_standrad_id+'&operateType='+operateType;
		    	_seeid = 'zhjView';
		        break;
		    case "8":
		    	//项目跨区查看
		    	url='<%=basePath%>item/goEditItem.do?item_id='+item_id+'&operateType='+operateType;
		        break;
		    case "9":
		    	//开票查看
		    	url='<%=basePath%>newInvoice/goEdit.do?id='+invoice_id+'&type='+newinvoinceType;
		        break;
		}
		$("#"+_seeid).kendoWindow({
			 width: "600px",
			 height: "400px",
			 title: "查看任务",
			 actions: ["Close"],
			 content: url,
			 modal : true,
			 visible : false,
			 resizable : true
		}).data("kendoWindow").maximize().open();
	}
	

function sreachTask(isRefresh) {
	if (isRefresh=="1") {
		$('#project_name').val("");
		$('#s_task_type').val("");
	}
	stopShow = true;
    $("#taskbody").html("");
	
    loadAuditData();
	
}

</script>
</body>
</html>


