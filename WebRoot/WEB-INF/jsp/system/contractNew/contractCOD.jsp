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
	
	

	function CloseSUWin(id) {
		window.parent.$("#" + id).data("kendoWindow").close();
		/* 	window.parent.location.reload(); */
	}
	

	</script>
</head>

<body class="gray-bg">
<form action="ordinaryType/${msg}.do" name="ordinaryType" id="ordinaryType" method="post">
<input type="hidden" name="id" id="id" value="${pd.id}"/>
<input type="hidden" name="operateType" id="operateType" value="${operateType}">
    <div class="wrapper wrapper-content">
        <div class="row">
        	
        	<div class="table-responsive">
				<table class="table table-striped table-bordered table-hover">
					<thead>
						<tr>
							<th>梯型</th>
							<th>台数</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						<!-- 开始循环 -->
						<c:choose>
							<c:when test="${not empty contractNewListCOD}">
								<c:if test="${QX.cha == 1 }">
								<c:set value="0" var="sum" />
									<c:forEach items="${contractNewListCOD}" var="con" varStatus="vs">
										<div style="display: none;">
												<c:if test="${before.TX != con.TX }">
													<c:set value="0" var="sum" />
												</c:if>
												<c:if test="${vs.index ==0 }">
													${sum}
												</c:if>
												<c:if test="${before.TX == con.TX }">
													<c:if test="${vs.index>0 }">
													<c:set value="${ before.TS + sum}"  var="sum" />
													${sum}
													</c:if>
												</c:if>
												
										</div>
										<tr>
											<td>${con.TX}</td>
											<td>${con.TS}</td>
											<c:set var="before" value="${con}"/>
											<td>
												<a class="btn btn-sm btn-info" title="输出" type="button" target="_blank" href="<%=basePath%>contractNew/toCOD.do?BJC_COD_ID=${con.BJC_COD_ID}&HT_UUID=${con.HT_UUID}&sum=${sum}">输出</a>
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
			</div>
        	
        
            <%-- <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="form-group form-inline">
                          <label style="margin-left: 20px"><span><font color="red">*</font></span>类型名称:</label>
                          <select class="form-control" id="ACT_STATUS" name='ACT_STATUS'>
			                    	<option value=''>状态</option>
			                        <option value='1' ${pd.ACT_STATUS=='1'?'selected':''}>新建</option>
			                        <option value='2' ${pd.ACT_STATUS=='2'?'selected':''}>待审批</option>
			                        <option value='3' ${pd.ACT_STATUS=='3'?'selected':''}>审批中</option>
			                        <option value='4' ${pd.ACT_STATUS=='4'?'selected':''}>通过</option>
			                        <option value='5' ${pd.ACT_STATUS=='5'?'selected':''}>不通过</option>
			                        
			              </select>
	                </div>
	                <div class="form-group form-inline">
                        <label style="margin-left: 20px">台数:</label>
                          <input type="text" value="${pd.descript}" name="descript" id="descript" title="类型描述" placeholder="请输入类型描述"  class="form-control"/>
                    </div>
                    <tr>
					<td><a class="btn btn-primary"style="width:100%; height:34px;float:left;"  onclick="save();">输出</a></td>
					</tr>
				</div>
            </div> --%>
            
        </div>
 </div>
 </form>
</body>

</html>
