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
	<style type="text/css">
		.overHide{
			text-align:center;
			overflow:hidden;
			white-space:nowrap;
			text-overflow:ellipsis;
		}
	</style>
	
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
	                        <form role="form" class="form-inline" action="newcollect/collectList.do" method="post" name="CollectForm" id="CollectForm">
	                            <div class="form-group  form-inline ">
	                                <input style="width:170px" type="text" name="item_name" id="item_name" placeholder="项目名称"  class="form-control">
	                            </div>
	                            <div class="form-group  form-inline ">
	                                <input style="width:170px" type="text" name="YSK_AZ_NO" id="YSK_AZ_NO" placeholder="合同号"  class="form-control">
	                            </div>
	                            <div class="form-group  form-inline ">
	                                <input style="width:170px" type="text" name="DQTS" id="DQTS" placeholder="到期天数" value="${DQTS}"  class="form-control">
	                            </div>
	                             <div class="form-group">
                                   <select class="form-control" name='YSK_KX' id="YSK_KX">
                                     <option value="">款项类型</option>
			                         <option value="1">订金</option>
			                         <option value="2">排产款</option>
			                         <option value="3">发货款</option>
			                         <option value="4">货到现场款</option>
			                         <option value="5">安装发货款</option>
			                         <option value="6">安装开工款</option>
			                         <option value="7">验收款</option>
			                      </select>
                               </div>
	                            <div class="form-group  form-inline ">
	                                <!-- <input style="width:170px" type="text" name="YSK_PCTS" id="YSK_PCTS" placeholder="偏差天数"  class="form-control"> -->
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
	                            <table class="table table-striped table-bordered table-hover" style="table-layout:fixed">
	                                <thead>
	                                    <tr>
	                                        <th style="width:10%;" class="overHide" title="合同编号">合同编号</th>
	                                        <th style="width:10%;" class="overHide" title="项目名称">项目名称</th>
	                                        <th style="width:5%;" class="overHide" title="期数">期数</th>
	                                        <th style="width:10%;" class="overHide" title="款项">款项</th>
	                                        <th style="width:10%;" class="overHide" title="应收金额">应收金额</th>
	                                        <th style="width:10%;" class="overHide" title="应收日期">应收日期</th>
	                                        <!-- <th style="width:10%;">偏差天数</th> -->
	                                        <th style="width:10%;" class="overHide" title="到期天数">到期天数</th>	
	                                        <th style="width:10%;" class="overHide" title="已开票金额">已开票金额</th>	
	                                        <th style="width:10%;" class="overHide" title="来款金额">来款金额</th>		  
	                                        <th style="width:8%;" class="overHide" title="合同录入人">合同录入人</th>		                                           
	                                        <th style="width:8%;" class="overHide" title="操作">操作</th>
	                                    </tr>
	                                </thead>
	                                <tbody>
	                                
	                                <!-- 开始循环-->
									<c:choose>
										<c:when test="${not empty SoYskList}">
											<c:if test="${QX.cha == 1 }">
												<c:forEach items="${SoYskList}" var="var" varStatus="vs">
													<tr>
														<td><a href="javascript:;" onclick="CNselect('${var.YSK_UUID}');">${var.YSK_AZ_NO}</a></td>
														<td class="overHide" title="${var.item_name}">${var.item_name}</td>
														<td>第${var.YSK_QS}期</td>
														<td>
														  ${var.YSK_KX=="1"?"订金":""}
														  ${var.YSK_KX=="2"?"排产款":""}
														  ${var.YSK_KX=="3"?"发货款":""}
														  ${var.YSK_KX=="4"?"货到现场款":""}
														  ${var.YSK_KX=="5"?"安装发货款":""}
														  ${var.YSK_KX=="6"?"安装开工款":""}
														  ${var.YSK_KX=="7"?"验收款":""}
														  ${var.YSK_KX=="8"?"质保金":""}
														</td>
														<td>${var.YSK_YSJE}</td>
														
														<%-- <c:if test="${var.HT_TYPE == 1 }">
															<td>
															  ${var.YSK_KX=="1"?var.AZ_QDRQ:""}
															  ${var.YSK_KX=="6"?var.AZ_YJKGRQ:""}
															  ${var.YSK_KX=="7"?var.AZ_YJYSRQ:""}
															  ${var.YSK_KX=="8"?var.AZ_ZBRQ:""}
															</td>
														</c:if>
														<c:if test="${var.HT_TYPE == 2 }">
															<td>
															  ${var.YSK_KX=="1"?var.HT_QDRQ:""}
															  ${var.YSK_KX=="2"?var.HT_YJFHRQ:""}
															  ${var.YSK_KX=="3"?var.HT_JHRQ:""}
															  ${var.YSK_KX=="4"?var.HT_JHRQ:""}
															  ${var.YSK_KX=="7"?var.HT_YJYSRQ:""}
															  ${var.YSK_KX=="8"?var.HT_ZBRQ:""}
															</td>
														</c:if> --%>
														
														<td>${var.KX_YSRQ}</td>
														
														<%-- <td>${var.YSK_PCTS}</td> --%>
														<td>${var.DQTS}</td>
														<td>${var.inv_price}</td>
														<td>${var.LK_LKJE}</td>
														<td>${var.input_users}</td>
														<td>
															<%-- <button class="btn btn-sm btn-info" title="查看"
															  type="button" onclick="CNselect('${var.YSK_UUID}');">查看
														    </button> --%>
														    
															<c:if test="${QX.edit == 1 }">
															<button class="btn btn-sm btn-info" title="编辑"
															  type="button" onclick="CNCollectEdit('${var.YSK_UUID}');">编辑
														    </button>
															</c:if>
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
	                            <div class="col-lg-12" style="padding-left: 0px; padding-right: 0px">
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

        //编辑
        function CNselect(YSK_UUID){
        	$("#EditCollect").kendoWindow({
		        width: "1000px",
		        height: "600px",
		        title: "信息查看",
		        actions: ["Close"],
		        content: '<%=basePath%>newcollect/getCollect.do?YSK_UUID='+YSK_UUID,
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").maximize().open();
        }
        
        //编辑
        function CNCollectEdit(YSK_UUID){
        	$("#EditCollect").kendoWindow({
		        width: "1000px",
		        height: "600px",
		        title: "信息查看",
		        actions: ["Close"],
		        content: '<%=basePath%>newcollect/getEdit.do?YSK_UUID='+YSK_UUID,
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").maximize().open();
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


