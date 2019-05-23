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
<!-- Sweet Alert -->
<script src="static/js/sweetalert/sweetalert.min.js"></script>
<link href="static/js/sweetalert/sweetalert.css" rel="stylesheet">

<!-- 日期控件-->
<script src="static/js/layer/laydate/laydate.js"></script>
</head>
<body class="gray-bg">
	<!-- 合同变更 -->
	<div id="ChangeIncontractHTML" class="animated fadeIn"></div>
	
	<form action="contractNew/" name="cellForm" id="cellForm" method="post">
	
		<div class="wrapper wrapper-content">
			<div class="row">
			
				<div class="col-sm-12">
					<div class="ibox float-e-margins">
					<div class="ibox-content1">
							<!-- 头部  Start-->
							<div style="padding-bottom:40px;">
								<div class="form-inline" style="width:350px;font-size:16px;float:left;margin-top:8px;">
									变更协议号:${bgxy.BGXYH}
								</div>
								<div class="form-group form-inline" style="float:right;margin-right:20px;">
			                         <button class="btn btn-sm btn-primary" title="保存"
										type="submit">保存
									 </button>
									 <button class="btn btn-sm btn-success" title="提交"
										type="button" onclick="CNsubmit();">提交
									</button>
									<button class="btn btn-sm btn-danger" title="关闭"
										type="button" onclick="CNdel();">关闭
									</button>
									<button class="btn btn-sm" title="预览" 
										style="background:#999999;color:white;"
										type="button" onclick="CNpreview();">预览
									</button>
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
                                     	<input style="width:35%" type="text" name="item_name" 
                                     	id="" value="${bgxy.XMMC}"  
                                     	placeholder="请输入项目名称" title="项目名称" class="form-control">
                                 	<label style="width:10%;">
                                 		<span><font color="red">*</font></span>客户名称:</label>
                                 		<input style="width:35%" type="text" name="item_name" readonly="readonly"
										id="" value="${bgxy.KHMC}"
										placeholder="请输入最终用户" title="最终用户" class="form-control" />
			                    </div>
			                    <!-- 第二层 -->
			                    <div class="form-group form-inline">                                
                              		<label style="width:10%;">
                              			<span><font color="red">*</font></span>安装地址:</label>
                                     	<input style="width:35%" type="text" name="item_name" 
                                     	id="" value="${bgxy.AZDZ}"  
                                     	placeholder="请输入安装地址" title="安装地址" class="form-control">
                                 	<label style="width:10%;">
                                 		<span><font color="red">*</font></span>最终用户:</label>
                                 		<input style="width:35%" type="text" name="item_name" readonly="readonly"
										id="" value="${bgxy.ZZYH}"
										placeholder="请输入最终用户" title="最终用户" class="form-control" />
			                    </div>
			                    <!-- 第三层 -->
			                    <div class="form-group form-inline">                                
                              		<label style="width:10%;">
                              			<span><font color="red">*</font></span>合同签订日期:</label>
                                     	<input style="width:35%" type="text" name="item_name" 
                                     	id="" value="${bgxy.HTQDRQ}"  
                                     	placeholder="请输入合同签订日期" title="合同签订日期" class="form-control" onclick="laydate()">
                                 	<label style="width:10%;">
                                 		<span><font color="red">*</font></span>变更次第:</label>
                                 		<input style="width:35%" type="text" name="item_name" 
										id="" value="${bgxy.BGCD}"
										placeholder="请输入变更次第" title="变更次第" class="form-control" />
			                    </div>
			                    <!-- 第四层 -->
			                    <div class="form-group form-inline">                                
                              		<label style="width:10%;">
                              			<span><font color="red">*</font></span>变更原因:</label>
                                     	<input style="width:80%" type="text" name="item_name" 
                                     	id="" value="${bgxy.BGYY}"  
                                     	placeholder="请输入变更原因" title="变更原因" class="form-control">
			                    </div>
			                    <!-- 第五层 -->
			                    <div class="form-group form-inline">                                
                              		<label style="width:10%;">
                              			<span><font color="red">*</font></span>变更内容:</label>
                                     	<input style="width:80%" type="text" name="item_name" 
                                     	id="" value="${bgxy.BGNR}"  
                                     	placeholder="请输入变更内容" title="变更内容" class="form-control">
			                    </div>
			                   	<!-- 第六层 -->
			                   	<div class="form-group form-inline">                                
                              		<label style="width:10%;">
                              			<span><font color="red">*</font></span>特殊性概述:</label>
                                     	<input style="width:22%" type="text" name="item_name" 
                                     	id="" value="${bgxy.TSXGS}"  
                                     	placeholder="请输入特殊性概述" title="特殊性概述" class="form-control">
			                    </div>
								<!-- 第七层 -->
			                    <div class="form-group form-inline"> 
			                    	<label style="width:10%;">
                              			<span><font color="red">*</font></span>交货期(天):</label>
                                     	<input style="width:35%" type="text" name="item_name" 
                                     	id="" value="${bgxy.JHQ}"  
                                     	placeholder="请输入交货期" title="交货期" class="form-control">
                                 	<label style="width:10%;">
                                 		<span><font color="red">*</font></span>其他约定:</label>
                                 		<input style="width:35%" type="text" name="item_name"
										id="" value="${bgxy.QTYD}"
										placeholder="请输入其他约定" title="其他约定" class="form-control" />
								</div>					
	
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
							<table class="table table-striped table-bordered table-hover" id="contractNewDTXXTab">
								<thead>
									<tr>
										<th>序号</th>
										<th>梯号</th>
										<th>产品名称</th>
										<th>层/站/门(提升高度)</th>
										<th>设备单价(元/台)</th>
										<th>变更金额</th>
										<th>安装单价(元/台)</th>
										<th>变更金额</th>
										<th>小计(元/台)</th>
										<th>变更后小计</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody>
									<!-- 开始循环 -->
									<c:choose>
										<c:when test="${not empty contractNewListDTXX}">
											<c:if test="${QX.cha == 1 }">
												<c:forEach items="${contractNewListDTXX}" var="con" varStatus="vs">
													<tr>
														<td>${vs.index+1}</td>
														<td>${con.TH}</td>
														<td>${con.CPMC}</td>
														<td>${con.CZM}</td>
														<td>${con.SBDJ}</td>
														<td>${con.BGJE_SB}</td>
														<td>${con.AZDJ}</td>
														<td>${con.BGJE_AZ}</td>
														<td>${con.XJ}</td>
														<td>${con.BGHXJ}</td>
														<td>
															<button class="btn btn-sm btn-primary" title="增加"
																type="button" onclick="CNDTXX_add();">增加
															</button>
															<button class="btn btn-sm btn-danger" title="删除"
																	type="button" onclick="CNDTXX_del();">删除
															</button>
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
								原总金额:${dtxx.YZJE}&nbsp&nbsp&nbsp<font color="red">变更金额:${dtxx.BGJE}</font>&nbsp&nbsp&nbsp变更后总额:${dtxx.BGHZJE}
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
						<div class="form-group form-inline" style="float:right;margin-right:20px;margin-bottom:0px;">
	                         <button class="btn btn-sm btn-primary" title="添加"
								type="button" onclick="CNFKFSadd();">添加
							 </button>
	             		</div>
						<div class="row" style="margin-left: 10px">	
							<table class="table table-striped table-bordered table-hover" id="contractNewFKFSTab">
								<thead>
									<tr>
										<th>期次</th>
										<th>阶段</th>
										<th>偏差日期</th>
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
										<c:when test="${not empty contractNewList_FKFS}">
											<c:if test="${QX.cha == 1 }">
												<c:forEach items="${contractNewList_FKFS}" var="con" varStatus="vs">
													<tr>
														<td>${vs.index+1}</td>
														<td>${con.JD}</td>
														<td>${con.PCRQ}</td>
														<td>${con.FKBL}</td>
														<td>
														<input style="width:100%" type="text" name="FKFSJE" id="" 
																	value="${con.JE}" class="form-control" />
														</td>
														<td>${con.YKPJE}</td>
														<td>${con.YSKJE}</td>
														<td>${con.BZ}</td>
														<td>
															<button class="btn btn-sm btn-danger" title="删除"
																	type="button" onclick="CNFKFSdel(this);">删除
															</button>
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
						
						<!-- 审批信息 Start -->	
						<div class="panel panel-primary">
						<!-- 头  -->
						<div class="panel-heading" style="padding-right:30px;">审批信息 </div>
						<div class="panel-body">
						<div class="row" style="margin-left: 10px">	
							<table class="table table-striped table-bordered table-hover" id="">
								<thead>
									<tr>
										<th style="width:20%;">审批环节</th>
										<th style="width:20%;">审批人</th>
										<th style="width:20%;">审批结果</th>
										<th style="width:20%;">审批意见</th>
										<th style="width:20%;">审批时间</th>
									</tr>
								</thead>
								<tbody>
								<!-- 开始循环 -->
								<c:choose>
									<c:when test="${not empty contractNewListSP}">
										<c:if test="${QX.cha == 1 }">
											<c:forEach items="${contractNewListSP}" var="con" varStatus="vs">
												<tr>
													<td>${con.SPHJ}</td>
													<td>${con.SPR}</td>
													<td>
													<select class="form-control" id="" name='FKFSKXPDRQ'>
									                        <option value='同意' ${con.SPJG=='同意'?'selected':''}>同意</option>
									                        <option value='拒绝' ${con.SPJG=='拒绝'?'selected':''}>拒绝</option>
									                </select>
													</td>
													<td>
													<input style="width:100%" type="text" name="SPSPYJ" id="" 
														value="${con.SPYJ}" class="form-control" />
													</td>
													<td>${con.SPSJ}</td>
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
							<div class="form-group form-inline" style="float:right;margin-right:20px;margin-bottom:0px;">
		                         <button class="btn btn-sm btn-success" title="提交"
									type="button" onclick="">提交
								 </button>
		             		</div>
						<!-- 结尾 -->
						</div>
						</div>
						</div>
						<!-- 审批信息  End -->
					</div>
				</div>
			</div>
	</form>

<script type="text/javascript">
     $(document).ready(function () {
            /* 图片 */
            $('.fancybox').fancybox({
                openEffect: 'none',
                closeEffect: 'none'
            });
        });

	  //---------------------------xcx-------------------------Start
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
	    
	    //保存
	    function CNsubmit(){
	    	
	    }
	    
	    //关闭
	    function CNdel(){
	    	
	    }
	    
	    //预览
	    function CNpreview(){
	    	
	    }
	    
	    //电梯信息  增加
	    function CNDTXX_add(){
	    	
	    }
	    
	    //电梯信息  删除
	    function CNDTXX_del(){
	    	swal({
	             title: "您确定要删除此条付款方式的信息吗？",
	             text: "删除后将无法恢复，请谨慎操作！",
	             type: "warning",
	             showCancelButton: true,
	             confirmButtonColor: "#DD6B55",
	             confirmButtonText: "删除",
	             cancelButtonText: "取消",
	             closeOnConfirm: false,
	             closeOnCancel: false
	         },
	         function (isConfirm) {
	             if (isConfirm) {
	             	var url = "";
	 				$.get(url,function(data){
	 					if(data.msg=='success'){
	 						swal({   
	 				        	title: "删除成功！",
	 				        	text: "您已经成功删除了这条信息。",
	 				        	type: "success",  
	 				        	 }, 
	 				        	function(){   
	 				        		delTab(obj); 
	 				        	 });
	 					}else{
	 						swal("删除失败", "您的删除操作失败了！", "error");
	 					}
	 				});
	             } else {
	                 swal("已取消", "您取消了删除操作！", "error");
	             }
	         });
	    	
	    	function delTab(obj){
				$(obj).parent().parent().remove();
				//重新标记序号
				var trNum = $("#contractNewDTXXTab tr").length;
				for(var i=1;i<=trNum;i++){
					$("#contractNewDTXXTab").find("tr").eq(i).find("td").eq(0).html(i);  
				}; 
			}
	    }
	    
	    //付款方式  增加
	    function CNFKFSadd(){
	    	var trNum = $("#contractNewFKFSTab tr").length;
			//克隆第一行
			var tr='<tr>'+
			'<td>'+trNum+'</td>'+
			'<td></td>'+
			'<td></td>'+
			'<td></td>'+
			'<td>'+
			'<input style="width:100%" type="text" name="FKFSJE" id="" '+
			'			value="" class="form-control" />'+
			'</td>'+
			'<td></td>'+
			'<td></td>'+
			'<td></td>'+
			'<td>'+
			'	<button class="btn btn-sm btn-danger" title="删除" '+
			'			type="button" onclick="CNFKFSdel(this);">删除 '+
			'	</button>'+
			'</td>'+
			'</tr>'; 
			$("#contractNewFKFSTab").append(tr);
	    }
	    
	  	//付款方式  删除
	    function CNFKFSdel(obj){
	    	swal({
	             title: "您确定要删除此条付款方式的信息吗？",
	             text: "删除后将无法恢复，请谨慎操作！",
	             type: "warning",
	             showCancelButton: true,
	             confirmButtonColor: "#DD6B55",
	             confirmButtonText: "删除",
	             cancelButtonText: "取消",
	             closeOnConfirm: false,
	             closeOnCancel: false
	         },
	         function (isConfirm) {
	             if (isConfirm) {
	             	var url = "";
	 				$.get(url,function(data){
	 					if(data.msg=='success'){
	 						swal({   
	 				        	title: "删除成功！",
	 				        	text: "您已经成功删除了这条信息。",
	 				        	type: "success",  
	 				        	 }, 
	 				        	function(){   
	 				        		delTab(obj); 
	 				        	 });
	 					}else{
	 						swal("删除失败", "您的删除操作失败了！", "error");
	 					}
	 				});
	             } else {
	                 swal("已取消", "您取消了删除操作！", "error");
	             }
	         });
	    	
	    	function delTab(obj){
				$(obj).parent().parent().remove();
				//重新标记序号
				var trNum = $("#contractNewFKFSTab tr").length;
				for(var i=1;i<=trNum;i++){
					$("#contractNewFKFSTab").find("tr").eq(i).find("td").eq(0).html(i);  
				}; 
			}
	  	}
	    
	    //---------------------------xcx-------------------------End
	    
	    
</script>	
</body>
</html>
