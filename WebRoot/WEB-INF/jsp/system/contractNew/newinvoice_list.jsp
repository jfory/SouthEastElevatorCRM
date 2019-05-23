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
    <!-- <link href="static/js/sweetalert2/sweetalert2.css" rel="stylesheet"> -->
	<!-- <title>${pd.SYSNAME}</title> -->
	<title>新应收款</title>
</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div id="EditCollect" class="animated fadeIn"></div>
        <div id="Collect" class="animated fadeIn"></div>
        <div id="Offset" class="animated fadeIn"></div>
        <div id="CollectSet" class="animated fadeIn"></div>
	        <div class="row">
	            <div class="col-sm-12">
	                <div class="ibox float-e-margins">
	                    <div class="ibox-content">
	                    <div id="top" name="top"></div>
	                        <form role="form" class="form-inline" action="newInvoice/invoiceList.do" method="post" name="invoiceListForm" id="invoiceListForm">
	                            <div class="form-group  form-inline ">
	                                <input style="width:170px" type="text" name="search_item_name" id="search_item_name" placeholder="项目名称"  class="form-control">
	                            </div>
	                            <div class="form-group  form-inline ">
	                                <input style="width:170px" type="text" name="search_contract_number" id="search_contract_number" placeholder="合同号"  class="form-control">
	                            </div>
	                          
	                            <div class="form-group  form-inline ">
	                                <input style="width:170px" type="text" name="search_Invoice_number" id="search_Invoice_number" placeholder="发票号"  class="form-control">
	                            </div>
	                               <div class="form-group">
                            <select class="form-control" name="search_Process_statee" id="search_Process_state" data-placeholder="流程状态" style="vertical-align:top;width:100%" title="流程状态">
                                   <option value="">流程状态</option>
                                    <option value="0">0</option>
                                    <option value="1">1</option>
                                    <option value="2">2</option>
     
                            </select>
                             </div>
	                            <div class="form-group form-inline ">
	                                 <button type="submit" class="btn  btn-primary " style="margin-bottom:0px"><i style="font-size:18px;" class="fa fa-search"></i></button>
	                            </div>
	                           
	                            
	                            <button class="btn  btn-success" title="刷新" type="button" style="margin-top: 5px;margin-bottom:0px;float: right" onclick="refreshCurrentTab();">刷新</button>
	                            <button class="btn  btn-success" title="新建" type="button" style="margin-top: 5px;margin-bottom:0px;margin-right:5px;float: right" onclick="add();">新建</button>
	                        </form>
	                            <div class="row">
	                            </br>
	                             </div>
	                        <div class="table-responsive">
	                            <table class="table table-striped table-bordered table-hover">
	                                <thead>
	                                    <tr>
	                                    	<th style="width:5%;"><input type="checkbox" name="zcheckbox" id="zcheckbox" class="i-checks" >
	                                        <th style="width:10%;">项目号</th>
	                                        <th style="width:12%;">项目名称</th>
	                                        <th style="width:10%;">发票号码</th>
	                                        <th style="width:10%;">发票类型</th>
	                                        <th style="width:10%;">开票金额</th>
	                                        <th style="width:10%;">申请人</th>
	                                        <th style="width:10%;">申请日期</th>
	                                        <th style="width:10%;">流程状态</th>		                              		                                        
	                                        <th style="width:13%;">操作</th>
	                                    </tr>
	                                </thead>
	                                <tbody>
	                                <tr>
														<td><input type="checkbox" class="i-checks" name='ids' id='1' value='1' ></td>
														<td>001</td>
														<td>万科</td>
														<td>001</td>
														<td>增值税</td>
														<td>100000.00</td>
														<td>张三</td>
														<td>2018-01-01</td>
														<td>新建</td>
														<td>
														
															<div>
																	<button class="btn btn-sm btn-info btn-sm" title="处理" type="button" onclick="examine()">处理</button>
															        <button class="btn btn-sm btn-info btn-sm" title="返回" type="button" onclick="">返回</button>
															        <button class="btn btn-sm btn-info btn-sm" title="修改" type="button" onclick="">修改</button>
															        <button class="btn btn-sm btn-info btn-sm" title="删除" type="button" onclick="">删除</button>
															</div>															
														
														</td>
													</tr>
	                                <%--
	                                <!-- 开始循环-->
									<c:choose>
										<c:when test="${not empty collectList}">
											<c:if test="${QX.cha == 1 }">
												<c:forEach items="${collectList}" var="var">
													<tr>
														<td><input type="checkbox" class="i-checks" name='ids' id='${var.id}' value='${var.id}' ></td>
														<td>${var.id}</td>
														<td>${var.item_no}</td>
														<td>${var.collect_total}</td>
														<td>${var.status}</td>
														<td>${var.descript}</td>
														<td>
															<c:if test="${QX.edit != 1 && QX.del != 1 }">
																<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="icon-lock" title="无权限">无权限</i></span>
															</c:if>
															<div>
																	<button class="btn btn-sm btn-info btn-sm" title="编辑" type="button" onclick="sel('${var.item_id}');">编辑</button>
															
																<!-- <c:if test="${QX.edit == 1}">
																	<button class="btn btn-sm btn-primary btn-sm" title="编辑" type="button" onclick="edit('${var.id}','edit');">编辑</button>
																</c:if> -->
																<c:if test="${var.status == 1}">
																	<button class="btn btn-sm btn-success btn-sm" title="收款" type="button" onclick="collect('${var.id}');">收款</button>
																</c:if>
																<c:if test="${QX.del == 1 }">
																	<button class="btn btn-sm btn-danger btn-sm" title="删除" type="button" onclick="del('${var.id}');">删除</button>
																</c:if>
																<!-- <button class="btn btn-sm btn-warning btn-sm" title="核销" type="button" onclick="offset('${var.id}');">核销</button>-->
															</div>
														</td>
													</tr>
												</c:forEach>
											</c:if>
											<c:if test="${QX.cha == 0 }">
												<tr>
													<td colspan="100" class="center">您无权查看</td>
												</tr>
											</c:if>
										</c:when>
										<c:otherwise>
											<tr class="main_info">
												<td colspan="100" class="center" >没有相关数据</td>
											</tr>
										</c:otherwise>
									</c:choose> 	
									 --%> 
                                </tbody>
	                            </table>
	                            <%-- 
	                            <div class="col-lg-12" style="padding-left:0px;padding-right:0px">
									<c:if test="${QX.add == 1 }">
										<button class="btn  btn-primary" title="新增" type="button" id="addBtn" name="addBtn" onclick="addView();">新增</button>
									</c:if>
										${page.pageStr}
								</div>
								--%>
								</div>
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
	    <!--返回顶部开始-->
        <div id="back-to-top">
            <a class="btn btn-warning btn-back-to-top" href="javascript: setWindowScrollTop (this,document.getElementById('top').offsetTop);">
                <i class="fa fa-chevron-up"></i>
            </a>
        </div>
        <!--返回顶部结束-->
         <%-- 
        <div class="ibox float-e-margins" id="addContent" class="menuContent" style="display:none; position: absolute;z-index: 99;border: solid 1px #18a689;max-height:300px;overflow-y:scroll;overflow-x:auto">
			<div class="ibox-content">
				<div>
					<h5><a href="javascript:add(1);">安装合同项目</a></h5><br>
					<h5><a href="javascript:add(2);">销售合同项目</a></h5><br>
					<h5><a href="javascript:add(3);">安装销售合同项目</a></h5><br>
				</div>
			</div>
		</div>
		--%>
	<!-- Fancy box -->
    <script src="static/js/fancybox/jquery.fancybox.js"></script>
	<!-- iCheck -->
    <script src="static/js/iCheck/icheck.min.js"></script>
    <!-- Sweet alert -->
    <script src="static/js/sweetalert/sweetalert.min.js"></script>
    <!-- <script src="static/js/sweetalert2/sweetalert2.js"></script> -->
    <script type="text/javascript">
        $(document).ready(function () {
			//loading end
			parent.layer.closeAll('loading');
        	/* checkbox */
            $('.i-checks').iCheck({
                checkboxClass: 'icheckbox_square-green',
                radioClass: 'iradio_square-green',
            });
        	/* 图片 */
            $('.fancybox').fancybox({
                openEffect: 'none',
                closeEffect: 'none'
            });

            $("body").click(function(event){
				event  =  event  ||  window.event; // 事件 
		        var  target    =  event.target  ||  ev.srcElement; // 获得事件源 
		        var  obj  =  target.getAttribute('id');
		        if(obj!='addBtn'){
					$("#addContent").hide();
		        }
            });

        });
        /* checkbox全选 */
        $("#zcheckbox").on('ifChecked', function(event){
        	
        	$('input').iCheck('check');
      	});
        /* checkbox取消全选 */
        $("#zcheckbox").on('ifUnchecked', function(event){
        	
        	$('input').iCheck('uncheck');
      	});


        //展开新增选项卡
        function addView(){
			var addBtnObj = $("#addBtn");
			var addBtnOffset = $("#addBtn").offset();
			$("#addContent").css({left:(addBtnOffset.left+6) + "px", top:addBtnOffset.top + addBtnObj.outerHeight() + "px"}).slideDown("fast");
			$("body").bind("mousedown", onBodyDown);
        }


        //跳转到新增
        function add(type){
        	$("#EditCollect").kendoWindow({
		        width: "1000px",
		        height: "600px",
		        title: "选择合同",
		        actions: ["Close"],
		        content: '<%=basePath%>newInvoice/invoice_add.do?',
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").maximize().open();
        }
        //跳转审批
        function examine(type){
        	$("#EditCollect").kendoWindow({
		        width: "1000px",
		        height: "600px",
		        title: "申请审批",
		        actions: ["Close"],
		        content: '<%=basePath%>newInvoice/invoice_examine.do?',
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").maximize().open();
        }

        
        
        //编辑
        function edit(id,type){
        	$.post("<%=basePath%>collect/goEditCollect.do?id="+id+"&type="+type,
        		function(data){
        			
        		}
        	);
        }

        //收款
        function collect(id){
        	$("#Collect").kendoWindow({
		        width: "1000px",
		        height: "600px",
		        title: "收款",
		        actions: ["Close"],
		        content: '<%=basePath%>collect/goCollect.do?id='+id,
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").maximize().open();
        }

        //核销
        function offset(id){
			$("#Offset").kendoWindow({
		        width: "1000px",
		        height: "600px",
		        title: "核销",
		        actions: ["Close"],
		        content: '<%=basePath%>collect/goOffset.do?id='+id,
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").maximize().open();
        }

        //编辑
        function sel(item_id){
        	$("#EditCollect").kendoWindow({
		        width: "1000px",
		        height: "600px",
		        title: "选择合同",
		        actions: ["Close"],
		        content: '<%=basePath%>newInvoice/contract_sel.do?',
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").maximize().open();
        }

        //删除
        function del(id){
        	swal({
	                title: "您确定要删除此条记录吗？",
	                text: "删除后信息无法恢复，请谨慎操作！",
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
	                	$.ajax({
							type: "POST",
							url: '<%=basePath%>collect/delCollect.do',
					    	data: {id:id},
							dataType:'json',
							cache: false,
							success: function(data){
								if(data.msg=='success'){
									swal({   
	        				        	title: "删除成功！",
	        				        	text: "您已经成功删除了这些数据。",
	        				        	type: "success",  
	        				        	 }, 
	        				        	function(){   
	        				        		 refreshCurrentTab(); 
	        				        	 });
		    					}else{
		    						swal("删除失败", "您的删除操作失败了！", "error");
		    					}
								
							}
						});
	                } else {
	                    swal("已取消", "您取消了删除操作！", "error");
	                }
	            });
        }


      	//刷新iframe
        function refreshCurrentTab() {
        	$("#CollectForm").submit();
        }
		//检索
		function search(){
			$("#CollectForm").submit();
		}
		/* back to top */
		function setWindowScrollTop(win, topHeight){
		    if(win.document.documentElement){
		        win.document.documentElement.scrollTop = topHeight;
		    }
		    if(win.document.body){
		        win.document.body.scrollTop = topHeight;
		    }
		}

		</script>
</body>
</html>


