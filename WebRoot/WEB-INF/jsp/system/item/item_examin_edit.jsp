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
	//设置电梯信息div的id后缀初始值为_1
	var elevatorId=1;
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
	
	
	//保存
	function save(){
		$("#sale_role").val($("#sale_role_text").val());
		$("#examin_role").val($("#examin_role_text").val());
		$("#itemExaminForm").submit();
	}

	
	function CloseSUWin(id) {
		window.parent.$("#" + id).data("kendoWindow").close();
		/* 	window.parent.location.reload(); */
	}
	</script>
</head>

<body class="gray-bg">
<form action="item/${msg}.do" name="itemExaminForm" id="itemExaminForm" method="post">
<input style="width:170px" type="hidden" name="id"  id="id" value="${pd.id }"/>

    <div class="wrapper wrapper-content" style="z-index: -1">
        <div class="row">
            <div class="col-sm-12" >
                <div class="ibox float-e-margins">
                    <div class="ibox-content">
                        <div class="row">
                            <div class="col-sm-12">
                                    <div class="row">
                            			<div class="col-sm-12">
                                			<div class="panel panel-primary">
			                                    <div class="panel-heading">
			                                        考核设置
			                                    </div>
			                                        <div class="form-group form-inline">
	                                    				<label style="width:10%;"><span><font color="red">*</font></span>销售权限角色:</label>
	                                    				<select style="width:22%" class="selectpicker" multiple data-live-search="true" data-live-search-placeholder="查找" data-actions-box="true" name="sale_role_text" id="sale_role_text">
												            <optgroup label="角色列表">
												            	<c:forEach items="${subRoleList}" var="var" >
																		<option value="${var.ROLE_ID }"  
																			<c:forEach items="${saleRoleList}" var="sale">
																			${var.ROLE_ID==sale?'selected':''}
																			</c:forEach>
																		>${var.ROLE_NAME }</option>
																</c:forEach>
												            </optgroup>
												        </select>
												        <input type="hidden" name="sale_role" id="sale_role">
	                                        		</div>
			                                        <div class="form-group form-inline">
	                                    				<label style="width:10%;"><span><font color="red">*</font></span>销售考核角色:</label>
	                                    				<select style="width:22%" class="selectpicker" multiple data-live-search="true" data-live-search-placeholder="查找" data-actions-box="true" name="examin_role_text" id="examin_role_text">
												            <optgroup label="角色列表">
												            	<c:forEach items="${subRoleList}" var="var" >
																		<option value="${var.ROLE_ID }"  
																			<c:forEach items="${examinRoleList}" var="examin">
																			${var.ROLE_ID==examin?'selected':''}
																			</c:forEach>
																		>${var.ROLE_NAME }</option>
																</c:forEach>
												            </optgroup>
												        </select>
												        <input type="hidden" name="examin_role" id="examin_role">
	                                        		</div>
	                                        		<div class="form-group form-inline">
	                                    				<label style="width:10%;"><span><font color="red">*</font></span>启用状态:</label>
	                                    				<select style="width:22%" class="form-control m-b" id="status" name="status">
	                                    					<option value="">请选择启用状态</option>
	                                    					<option value="0" ${pd.status=='0'?'selected':''}>禁用</option>
	                                    					<option value="1" ${pd.status=='1'?'selected':''}>启用</optin>
	                                    				</select>
	                                        		</div>
		                                    	</div>
		                                	</div>
		                            	</div>
                                    </div>
                            </div>
                        </div>
						<div style="height: 20px;"></div>
						<tr>
						<c:if test="${operateType!='sel'}">
							<td>
								<a class="btn btn-primary"style="width: 150px; height:34px;float:left;"  onclick="save();">保存</a>
							</td>					
						</c:if>	
						<td>
							<a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('EditItemExamin');">关闭</a>
						</td>
						</tr>
					</div>
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
 <%--zTree--%>
<script type="text/javascript"
	src="plugins/zTree/3.5.24/js/jquery.ztree.core.js"></script>
<script type="text/javascript"
	src="plugins/zTree/3.5.24/js/jquery.ztree.excheck.js"></script>
<script type="text/javascript"
	src="plugins/zTree/3.5.24/js/jquery.ztree.exedit.js"></script>
<!-- Sweet alert -->
<script src="static/js/sweetalert/sweetalert.min.js"></script>
</body>

</html>
