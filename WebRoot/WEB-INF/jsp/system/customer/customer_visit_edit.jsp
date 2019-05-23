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
	<!-- 日期控件-->
    <script src="static/js/layer/laydate/laydate.js"></script>
	<script type="text/javascript">
		$(function () {
		    setvisitJSON($("#visit_member").val());
        });
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
  //  laydate(start);
   // laydate(end);

	//保存
	function save(){
		$("#visit_member").val($("#visit_member_text").val());
		$("#visit_customer_id").focus();
		if($("#visit_customer_id").val()==""){
			$("#visit_customer_id").tips({
				side:3,
	            msg:"请选择客户",
	            bg:'#AE81FF',
	            time:2
	        });
			return false;
		}
		$("#visit_company").focus();
		if($("#visit_company").val()==""){
			$("#visit_company").tips({
				side:3,
	            msg:"输入拜访单位",
	            bg:'#AE81FF',
	            time:2
	        });
			return false;
		}
		$("#visit_date").focus();
		if($("#visit_date").val()==""){
			$("#visit_date").tips({
				side:3,
	            msg:"输入拜访时间",
	            bg:'#AE81FF',
	            time:2
	        });
			return false;
		}

        var json = "[";
		$("[name='visit_member_text']").each(function (idx) {
            json += "{\'visit_member\':\'"+$(this).val()+"\'},";
        });
        json =  (json.length>1?json.substring(0,json.length-1): json) +"]";
		$("#visit_member").val(json);
		$("#customerVisitForm").submit();
	}

	function changeCustomerList(){
		var visit_customer_type= $("#visit_customer_type").val();
		$.post('<%=basePath%>customer/getCustomerList.do?visit_customer_type='+visit_customer_type,
				function(data){
					//
					$("#visit_customer_id").empty();
					var optionStr = "";
					$.each(data,function(){
						optionStr += "<option value='"+this.customer_id+"'>"+this.customer_name+"</option>";
					});
					$("#visit_customer_id").append(optionStr);

				}
		);
	}
		
	function CloseSUWin(id) {
		window.parent.$("#" + id).data("kendoWindow").close();
		/* 	window.parent.location.reload(); */
	}
    var visitindex=0;
    function addvisitTag(){
        visitindex+=1;
        $("#VisitDiv").append(
            '<div class="form-group form-inline" id=flieTag'+visitindex+'>'+
            '<label style="margin-left:26px;margin-top:20px">参与成员:&nbsp;</label>'+
        '<input type="text" name="visit_member_text" class="form-control">&nbsp;'+
            '<button style="margin-left:3px;margin-top:3px;" class="btn  btn-danger btn-sm" title="删除" type="button"onclick="deletevisitTag('+visitindex+');">减</button>'+
            '</div>'

        );
    }
    function deletevisitTag(findex){
        $("#flieTag"+findex).remove();
    }

        function setvisitJSON(htfjscjson){
            var obj = eval("("+htfjscjson+")");
            for(var j = 0;j<obj.length-1;j++){
                addvisitTag();
            }
            for(var i = 0;i<obj.length;i++){
                $($("#VisitDiv").find("[name='visit_member_text']")[i]).val(obj[i].visit_member);
            }
        }
	</script>
</head>

<body class="gray-bg">
<form action="customer/${msg}.do" name="customerVisitForm" id="customerVisitForm" method="post">
<input type="hidden" name="visit_id" id="visit_id" value="${pd.visit_id}"/>
    <div class="wrapper wrapper-content">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="form-group form-inline">
                          <label style="margin-left:20px;margin-top:20px"><span><font color="red">*</font></span>客户类型:</label>
                          <c:if test="${pd.customer_type=='Ordinary'}">
                          	<input type="text" disabled="disabled" value="普通客户"  title="客户类型"   class="form-control"/>
                          </c:if>
                          <c:if test="${pd.customer_type=='Merchant'}">
                          	<input type="text" disabled="disabled" value="小业主"  title="客户类型"   class="form-control"/>
                          </c:if>
                          <c:if test="${pd.customer_type=='Core'}">
                          	<input type="text" disabled="disabled" value="战略客户"  title="客户类型"   class="form-control"/>
                          </c:if>
                          <c:choose>
                          	<c:when test="${pd.customer_type!='all'}">
                          		<input type="hidden"  name="visit_customer_type" id="visit_customer_type"  value="${pd.customer_type}"  title="客户类型"   class="form-control">
                          	</c:when>
                          	<c:when test="${pd.customer_type=='all'}">
	                          	<select style="width:184px" name="visit_customer_type" id="visit_customer_type" class="form-control m-b" onchange="changeCustomerList();">
	                          		<option value=''>请选择客户类型</option>
	                          		<option value='Ordinary'>普通客户</option>
	                          		<option value='Merchant'>小业主</option>
	                          		<option value='Core'}>战略客户</option>
	                          	</select>
                          	</c:when>
                          </c:choose>
                          <label style="margin-left: 50px"><span><font color="red">*</font></span>客户名称:</label>
						  <c:if test="${operateType=='add' }">
						  	<c:if test="${pd.add_customer_id!='' }">
						  		<input type="text" class="form-control"  value="${pd.add_customer_name }" disabled="disabled">
						  		<input type="hidden" id="visit_customer_id" name="visit_customer_id" value="${pd.add_customer_id }"/>
						  	</c:if>
						  	<c:if test="${pd.add_customer_id=='' }">
							  <select id="visit_customer_id" name="visit_customer_id"  title="请选择客户" ${pd.add_customer_id!=""?"disabled='disabled'":"" } class="form-control m-b">
										<option value=''>请选择客户</option>
										<c:forEach items="${visitCustomerList}" var="var" >
											<option value="${var.customer_id }"${var.customer_id==pd.add_customer_id?'selected':'' } >${var.customer_name }</option>
									  	</c:forEach>
						   	   </select>
						   	   </c:if>
						  </c:if>
				  	  	  <c:if test="${operateType=='edit' }">
						  	<input type="text" value="${editCustomerName }" disabled="disabled"   class="form-control"/>
						  	<input type="hidden" name="visit_customer_id" id="visit_customer_id" value="${pd.visit_customer_id }"/>
				  	  	  </c:if>
	                </div>
	                <div class="form-group form-inline">
                        <nav class="navbar navbar-default" role="navigation">
                        <label style="margin-left:20px;margin-top:20px"><span><font color="red">*</font></span>拜访单位:</label>
                        <input type="text" name="visit_company" id="visit_company"  value="${pd.visit_company}"  title="拜访单位"  class="form-control">
                        <label style="margin-left:50px;"><span><font color="red">*</font></span>拜访时间:</label>
                        <input type="text" name="visit_date" id="visit_date"  value="${pd.visit_date}" title="拜访时间"  class="form-control layer-date" onclick="laydate()">
						</nav>
                        <!-- <select id="visit_member" name="visit_member" class="selectpicker" data-live-search="true" title="请选择业务员">
                        <c:forEach items="${sysUserList}" var="var" >
											<option value="${var.USER_ID }">${var.NAME }</option>
						</c:forEach>
						</select> -->
                    </div>
                    <div class="form-group form-inline">
                        <label style="margin-left:26px;margin-top:20px">拜访方式:</label>
						<select   name="visit_way" id="visit_way" class="form-control">
							<option value="电话" ${pd.visit_way=="电话"?'selected':''}>电话</option>
							<option value="上门" ${pd.visit_way=="上门"?'selected':''}>上门</option>
							<option value="邮件" ${pd.visit_way=="邮件"?'selected':''}>邮件</option>
							<option value="微信" ${pd.visit_way=="微信"?'selected':''}>微信</option>
							<option value="委托拜访" ${pd.visit_way=="委托拜访"?'selected':''}>委托拜访</option>
							<option value="其他" ${pd.visit_way=="其他"?'selected':''}>其他</option>
						</select>

                    </div>
					<div class="form-group" id="VisitDiv">
						<input type="hidden" id="visit_member" name="visit_member" value="${pd.visit_member}"/>
						<div class="form-group form-inline">
							<label style="margin-left:26px;margin-top:20px">参与成员:</label>
							<input type="text" name="visit_member_text" class="form-control">
							<button style="margin-left:3px;margin-top:3px;" class="btn  btn-primary btn-sm"
									title="添加" type="button"onclick="addvisitTag();">加</button>
						</div>
					</div>
                    <div class="form-group">
                        <label style="margin-left: 20px">拜访目的:</label>
                        <textarea rows="4" cols="17" name="visit_aims" id="visit_aims" class="form-control">${pd.visit_aims }</textarea>
                    </div>
                    <div class="form-group">
                        <label>拜访反馈:</label>
                        <textarea rows="4" cols="17" name="visit_feedback" id="visit_feedback" class="form-control">${pd.visit_feedback }</textarea>
                    </div>
                    <div class="form-group">
                        <label>跟进计划:</label>
                        <textarea rows="4" cols="17" name="respond_plan" id="respond_plan" class="form-control">${pd.respond_plan }</textarea>
                    </div>
					<div style="height: 20px;"></div>
					<tr>
					<td><a class="btn btn-primary"style="width: 150px; height:34px;float:left;"  onclick="save();">保存</a></td>
					<td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('EditCustomerVisit');">关闭</a></td>
					</tr>
				</div>
            </div>
            
        </div>
 </div>
 </form>
</body>

</html>
