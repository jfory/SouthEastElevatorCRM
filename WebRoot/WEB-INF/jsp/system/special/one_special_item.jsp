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
        <div id="EditItem" class="animated fadeIn"></div>
	        <div class="row">
	            <div class="col-sm-12">
	                <div class="ibox float-e-margins">
	                    <div class="ibox-content">
	                    <div id="top",name="top"></div>
	                        <form role="form" class="form-inline" action="production/special.do" method="post" name="ItemForm" id="ItemForm">
	                            <div class="form-group  form-inline ">
	                                <!-- <select style="width:170px" name="search_item_name" id="search_item_name"  class="selectpicker" data-live-search="true">
	                                	<option value="">查询所有</option>
	                                	<c:forEach items="${itemList}" var="var">
	                                		<option value="${var.item_name}">${var.item_name}</option>
	                                	</c:forEach>
	                                </select> -->
	                                <input style="width:170px" type="text" name="search_item_name" id="search_item_name" placeholder="输入项目名称查询"  class="form-control">
	                            </div>
	                            <div class="form-group form-inline ">
	                                 <button type="submit" class="btn  btn-primary " style="margin-bottom:0px"><i style="font-size:18px;" class="fa fa-search"></i></button>
	                            </div>
	                            <button class="btn  btn-success" title="刷新" type="button" style="margin-top: 5px;margin-bottom:0px;float: right" onclick="refreshCurrentTab();">刷新</button>
	                        </form>
	                            <div class="row">
	                            </br>
	                             </div>
	                        <div class="table-responsive">
	                            <table class="table table-striped table-bordered table-hover">
	                                <thead>
	                                    <tr>
	                                        <th style="width:3%;">序号</th>
	                                        <th style="width:5%;">项目编号</th>
	                                        <th style="width:10%;">项目名称</th>
	                                        <th style="width:10%;">联系人</th>
	                                        <th style="width:10%;">联系人电话</th>
	                                        <th style="width:10%;">项目状态</th>
	                                        <th style="width:10%;">项目报价</th>                                       
	                                        <th style="width:15%;">操作</th>
	                                    </tr>
	                                </thead>
	                                <tbody>
	                                <!-- 开始循环 -->	
									<c:choose>
										<c:when test="${not empty itemList}">
											<c:if test="${QX.cha == 1 }">
												<c:forEach items="${itemList}" var="var" varStatus="vs">
													<tr>
														<td class='center' style="width: 30px;">${vs.index+1}</td>
														<td>${var.item_no}</td>
														<td>${var.item_name}</td>
														<td>${var.order_org_contact==""?"未填":var.order_org_contact}</td>
														<td>${var.order_org_phone==""?"未填":var.order_org_phone}</td>
														<td>
															${var.item_status==""?"未选择":""}
															${var.item_status=="1"?"信息":""}
															${var.item_status=="2"?"报价":""}
															${var.item_status=="3"?"投标":""}
															${var.item_status=="4"?"洽谈":""}
															${var.item_status=="5"?"合同":""}
															${var.item_status=="6"?"中标":""}
															${var.item_status=="7"?"失标":""}
															${var.item_status=="8"?"取消":""}
															${var.item_status=="9"?"生效":""}
														</td>
														<td>${var.item_total}</td>
														<td>
															<c:if test="${QX.edit != 1 && QX.del != 1 }">
																<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="icon-lock" title="无权限">无权限</i></span>
															</c:if>
															<div>
															  <button class="btn  btn-success btn-sm" title="查看项目" type="button" onclick="edit('${var.item_id}','sel');">查看项目</button>
															  <button class="btn  btn-warning btn-sm" title="特批排产" type="button" onclick="special('${var.item_id}')">特批排产</button>
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
                                </tbody>
	                            </table>
								<div class="col-lg-12" style="padding-left:0px;padding-right:0px">
										${page.pageStr}
								</div>
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
	<!-- Fancy box -->
    <script src="static/js/fancybox/jquery.fancybox.js"></script>
	<!-- iCheck -->
    <script src="static/js/iCheck/icheck.min.js"></script>
    <!-- Sweet alert -->
    <script src="static/js/sweetalert/sweetalert.min.js"></script>
    <script src="static/js/sweetalert2/sweetalert2.js"></script>
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
        });
        /* checkbox全选 */
        $("#zcheckbox").on('ifChecked', function(event){
        	
        	$('input').iCheck('check');
      	});
        /* checkbox取消全选 */
        $("#zcheckbox").on('ifUnchecked', function(event){
        	
        	$('input').iCheck('uncheck');
      	});
		//查看项目信息
		function edit(id,operateType){
			$("#EditItem").kendoWindow({
		        width: "1000px",
		        height: "800px",
		        title: "编辑项目信息",
		        actions: ["Close"],
		        content: '<%=basePath%>item/goEditItem.do?item_id='+id+'&operateType='+operateType,
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").maximize().open();
		}
		//根据项目ID查询属于这个项目的所有电梯信息
		function special(item_id)
		{
			$("#EditItem").kendoWindow({
		        width: "1000px",
		        height: "800px",
		        title: "特批排产",
		        actions: ["Close"],
		        content: '<%=basePath%>production/elevatorDetails.do?item_id='+item_id,
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").maximize().open();
		}
	  
		
      	//刷新iframe
        function refreshCurrentTab() {
        	$("#ItemForm").submit();
        }
		//检索
		function search(){
			$("#ItemForm").submit();
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


