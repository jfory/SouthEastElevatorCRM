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
	<title>${pd.SYSNAME}</title>
</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div id="EditItemExamin" class="animated fadeIn"></div>
	        <div class="row">
	            <div class="col-sm-12">
	                <div class="ibox float-e-margins">
	                    <div class="ibox-content">
	                    <div id="top",name="top"></div>
	                        <form role="form" class="form-inline" action="item/listItemExamin.do" method="post" name="ItemExaminForm" id="ItemExaminForm">
	                            <div>
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
	                                        <th style="width:5%;"><input type="checkbox" name="zcheckbox" id="zcheckbox" class="i-checks" ></th>
	                                        <th style="width:5%;">编号</th>
	                                        <th style="width:10%;">电梯种类</th>
	                                        <th style="width:10%;">销售角色</th>
	                                        <th style="width:10%;">考核角色</th>	 
	                                        <th style="width:15%;">启用状态</th>
	                                        <th style="width:15%;">操作</th>
	                                    </tr>
	                                </thead>
	                                <tbody>
	                                <!-- 开始循环 -->	
									<c:choose>
										<c:when test="${not empty itemExaminList}">
											<c:if test="${QX.cha == 1 }">
												<c:forEach items="${itemExaminList}" var="var" >
													<tr>
														<td><input type="checkbox" class="i-checks" name='ids' id='${var.id}' value='${var.id}' ></td>
														<td>${var.id}</td>
														<td>${var.elevator_name}</td>
														<td>${var.sale_role_text}</td>
														<td>${var.examin_role_text}</td>
														<td>${var.status=='0'?'禁用':'启用'}</td>
														<td>
															<c:if test="${QX.edit != 1 && QX.del != 1 }">
																<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="icon-lock" title="无权限">无权限</i></span>
															</c:if>
															<div>
																<c:if test="${QX.edit == 1 }">
																	<button class="btn btn-sm btn-info btn-sm" title="查看" type="button" onclick="edit('${var.id}','sel');">查看</button>
																</c:if>
																<c:if test="${QX.edit == 1 }">
																	<button class="btn btn-sm btn-primary btn-sm" title="设置" type="button" onclick="edit('${var.id}','edit');">设置</button>
																</c:if>
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

		//修改/查看
		function edit(id,operateType){
			$("#EditItemExamin").kendoWindow({
		        width: "1000px",
		        height: "800px",
		        title: "销售考核",
		        actions: ["Close"],
		        content: '<%=basePath%>item/goEditItemExamin.do?id='+id+'&operateType='+operateType,
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").maximize().open();
		}
      	//刷新iframe
        function refreshCurrentTab() {
        	$("#ItemExaminForm").submit();
        }
		//检索
		function search(){
			$("#ItemExaminForm").submit();
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


