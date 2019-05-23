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
	<title>${pd.SYSNAME}</title>
</head>

<body class="gray-bg" >
    <div class="wrapper wrapper-content">
    	<input type="hidden" name="rowIndex" id="rowIndex" value="${pd.rowIndex}">
    	<input type="hidden" name="ITEM_ID" id="ITEM_ID" value="${pd.ITEM_ID}">
    	<input type="hidden" name="ELEV_IDS" id="ELEV_IDS" value="${pd.ELEV_IDS}">
    	<input type="hidden" name="BJC_ID" id="BJC_ID" value="${pd.BJC_ID}">
    	<input type="hidden" name="MODELS" id="MODELS" value="${pd.models}">
    	<input type="hidden" name="FEISHANG_ID" id="FEISHANG_ID" value="${pd.FEISHANG_ID}">
    	<input type="hidden" name="FEISHANG_SL" id="FEISHANG_SL" value="${pd.FEISHANG_SL}">
    	<input type="hidden" name="FEISHANGMRL_ID" id="FEISHANGMRL_ID" value="${pd.FEISHANGMRL_ID}">
    	<input type="hidden" name="FEISHANGMRL_SL" id="FEISHANGMRL_SL" value="${pd.FEISHANGMRL_SL}">
    	<input type="hidden" name="FEIYANG_ID" id="FEIYANG_ID" value="${pd.FEIYANG_ID}">
    	<input type="hidden" name="FEIYANG_SL" id="FEIYANG_SL" value="${pd.FEIYANG_SL}">
    	<input type="hidden" name="FEIYANGMRL_ID" id="FEIYANGMRL_ID" value="${pd.FEIYANGMRL_ID}">
    	<input type="hidden" name="FEIYANGMRL_SL" id="FEIYANGMRL_SL" value="${pd.FEIYANGMRL_SL}">
    	<input type="hidden" name="FEIYANGXF_ID" id="FEIYANGXF_ID" value="${pd.FEIYANGXF_ID}">
    	<input type="hidden" name="FEIYANGXF_SL" id="FEIYANGXF_SL" value="${pd.FEIYANGXF_SL}">
    	<input type="hidden" name="FEIYUE_ID" id="FEIYUE_ID" value="${pd.FEIYUE_ID}">
    	<input type="hidden" name="FEIYUE_SL" id="FEIYUE_SL" value="${pd.FEIYUE_SL}">
    	<input type="hidden" name="FEIYUEMRL_ID" id="FEIYUEMRL_ID" value="${pd.FEIYURMRL_ID}">
    	<input type="hidden" name="FEIYUEMRL_SL" id="FEIYUEMRL_SL" value="${pd.FEIYUEMRL_SL}">
    	<input type="hidden" name="SHINY_ID" id="SHINY_ID" value="${pd.SHINY_ID}">
    	<input type="hidden" name="SHINY_SL" id="SHINY_SL" value="${pd.SHINY_SL}">
    	<input type="hidden" name="DNP9300_ID" id="DNP9300_ID" value="${pd.DNP9300_ID}">
    	<input type="hidden" name="DNP9300_SL" id="DNP9300_SL" value="${pd.DNP9300_SL}">
    	<input type="hidden" name="DNR_ID" id="DNR_ID" value="${pd.DNR_ID}">
    	<input type="hidden" name="DNR_SL" id="DNR_SL" value="${pd.DNR_SL}">
    	<input type="hidden" name="offer_version" id="offer_version" value="${pd.offer_version}">
        <div class="row">
	            <div class="col-sm-12">
	                <div class="ibox float-e-margins">
	                    <div class="ibox-content">
	                       <!-- <form role="form" class="form-inline" action="tradeType/listTradeType.do" method="post" name="" id="">
	                            <div class="form-group form-inline" style="display:none">
	                                 <button type="submit" class="btn  btn-primary " style="margin-bottom:0px"><i style="font-size:18px;" class="fa fa-search"></i></button>
	                            </div>
	                        	<button class="btn  btn-success" title="刷新" type="button" style="margin-top: 5px;margin-left: 752px" onclick="refreshCurrentTab();">刷新</button>
	                        </form> -->
	                        <div class="table-responsive">
	                        
	                        <div class="form-group form-inline">
	                       		
		                     	<div class="form-group">
									<input class="form-control" type="text" id="selitem_name"
										type="text" name="selitem_name" value="${pd.selitem_name}" placeholder="项目名称">
										
									<button type="button" class="btn  btn-primary" title="查询" onclick="findcbjListByItem();"
										style="margin-left: 10px; height:32px;margin-top:3px;">查询</button>
								</div>
	                        </div>
	                            <table class="table table-striped table-bordered table-hover">
	                                <thead>
	                                    <tr>
	                                        <th style="width:8%;">项目名称</th>
	                                        <th style="width:8%;">产品名称</th>
	                                        <th style="width:5%;">数量</th>
	                                        <th style="width:6%;">层站门</th>
<!-- 	                                        <th style="width:8%;">装潢费用</th> -->
	                                        <th style="width:8%;">设备价</th>
	                                        <th style="width:5%;">折扣</th>
<!-- 	                                        <th style="width:8%;">折后设备价</th> -->
	                                        <th style="width:8%;">安装费</th>
	                                        <th style="width:8%;">运输费</th>
	                                        <th style="width:8%;">实际报价</th>
	                                        <th style="width:8%;">操作</th>
	                                    </tr>
	                                </thead>
	                                <tbody>
	                                <!-- 开始循环 -->	
									<c:choose>
										<c:when test="${not empty cbjList}">
											<c:if test="${QX.cha == 1 }">
												<c:forEach items="${cbjList}" var="var" >
													<tr>
														<td>${var.ITEM_NAME}</td>
														<td>${var.MODELS_NAME}</td>
														<td>${var.BJC_SL}</td>
														<td>${var.BJC_C}/${var.BJC_Z}/${var.BJC_M}</td>
<%-- 														<td>${var.BJC_ZHJ}</td> --%>
														<td>${var.BJC_SBJ}</td>
														<td>${var.BJC_ZK}</td>
<%-- 														<td>${var.BJC_ZHSBJ}</td> --%>
														<td>${var.BJC_AZF}</td>
														<td>${var.BJC_YSF}</td>
														<td>${var.BJC_SJBJ}</td>
														<td>
															<div>
																<c:if test="${QX.edit == 1 }">
																	<button class="btn btn-sm btn-primary btn-sm" title="调用" type="button" onclick="setCbj('${var.BJC_ID}');">调用</button>
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
 <!--返回顶部开始-->
        <div id="back-to-top">
            <a class="btn btn-warning btn-back-to-top" href="javascript: setWindowScrollTop (this,document.getElementById('top').offsetTop);">
                <i class="fa fa-chevron-up"></i>
            </a>
        </div>
        <!--返回顶部结束-->
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


	//修改
	function setCbj(bjc_id){
		var models_ = $("#MODELS").val();
		console.log(models_);
		if(models_=="feishang"){
	        var sl_ = $("#FEISHANG_SL").val();
	        var elevIds_ = $("#ELEV_IDS").val();
	        var itemId_ = $("#ITEM_ID").val();
	        var bjcId = $("#BJC_ID").val();
        	var feishangId = $("#FEISHANG_ID").val();
        	var rowIndex = $("#rowIndex").val();
			window.parent.$("#cbjView").data("kendoWindow").close();
			window.parent.$("#feishangForm").attr("action", "e_offer/setCbj.do?MODELS=FEISHANG&CBJ_BJC_ID="+bjc_id+"&FEISHANG_SL="+sl_+"&ELEV_IDS="+ELEV_IDS+"&FEISHANG_ID="+feishangId+"&ITEM_ID="+itemId_+"&BJC_ID="+bjcId+"&rowIndex="+rowIndex);
			window.parent.$("#feishangForm").submit();
		}else if(models_=="feishangmrl"){
	        var sl_ = $("#FEISHANGMRL_SL").val();
	        var elevIds_ = $("#ELEV_IDS").val();
	        var itemId_ = $("#ITEM_ID").val();
	        var bjcId = $("#BJC_ID").val();
        	var feishangId = $("#FEISHANGMRL_ID").val();
        	var rowIndex = $("#rowIndex").val();
			window.parent.$("#cbjView").data("kendoWindow").close();
			window.parent.$("#feishangForm").attr("action", "e_offer/setCbj.do?MODELS=FEISHANGMRL&CBJ_BJC_ID="+bjc_id+"&FEISHANGMRL_SL="+sl_+"&ELEV_IDS="+ELEV_IDS+"&FEISHANGMRL_ID="+feishangId+"&ITEM_ID="+itemId_+"&BJC_ID="+bjcId+"&rowIndex="+rowIndex);
			window.parent.$("#feishangForm").submit();
		}else if(models_=="feiyang"){
	        var sl_ = $("#FEIYANG_SL").val();
	        var elevIds_ = $("#ELEV_IDS").val();
	        var itemId_ = $("#ITEM_ID").val();
	        var bjcId = $("#BJC_ID").val();
        	var feiyangId = $("#FEIYANG_ID").val();
        	var rowIndex = $("#rowIndex").val();
			window.parent.$("#cbjView").data("kendoWindow").close();
			window.parent.$("#feiyang3000Form").attr("action", "e_offer/setCbj.do?MODELS=FEIYANG&CBJ_BJC_ID="+bjc_id+"&FEIYANG_SL="+sl_+"&ELEV_IDS="+ELEV_IDS+"&FEIYANG_ID="+feiyangId+"&ITEM_ID="+itemId_+"&BJC_ID="+bjcId+"&rowIndex="+rowIndex);
			window.parent.$("#feiyang3000Form").submit();
		}else if(models_=="feiyangmrl"){
	        var sl_ = $("#FEIYANGMRL_SL").val();
	        var elevIds_ = $("#ELEV_IDS").val();
	        var itemId_ = $("#ITEM_ID").val();
	        var bjcId = $("#BJC_ID").val();
        	var feiyangmrlId = $("#FEIYANGMRL_ID").val();
        	var rowIndex = $("#rowIndex").val();
			window.parent.$("#cbjView").data("kendoWindow").close();
			window.parent.$("#feiyang3000mrlForm").attr("action", "e_offer/setCbj.do?MODELS=FEIYANGMRL&CBJ_BJC_ID="+bjc_id+"&FEIYANGMRL_SL="+sl_+"&ELEV_IDS="+ELEV_IDS+"&FEIYANGMRL_ID="+feiyangmrlId+"&ITEM_ID="+itemId_+"&BJC_ID="+bjcId+"&rowIndex="+rowIndex);
			window.parent.$("#feiyang3000mrlForm").submit();
		}else if(models_=="feiyangxf"){
	        var sl_ = $("#FEIYANGXF_SL").val();
	        var elevIds_ = $("#ELEV_IDS").val();
	        var itemId_ = $("#ITEM_ID").val();
	        var bjcId = $("#BJC_ID").val();
        	var feiyangxfId = $("#FEIYANGXF_ID").val();
        	var rowIndex = $("#rowIndex").val();
			window.parent.$("#cbjView").data("kendoWindow").close();
			window.parent.$("#feiyangxfForm").attr("action", "e_offer/setCbj.do?MODELS=FEIYANGXF&CBJ_BJC_ID="+bjc_id+"&FEIYANGXF_SL="+sl_+"&ELEV_IDS="+ELEV_IDS+"&FEIYANGXF_ID="+feiyangxfId+"&ITEM_ID="+itemId_+"&BJC_ID="+bjcId+"&rowIndex="+rowIndex);
			window.parent.$("#feiyangxfForm").submit();
		}else if(models_=="feiyue"){
	        var sl_ = $("#FEIYUE_SL").val();
	        var elevIds_ = $("#ELEV_IDS").val();
	        var itemId_ = $("#ITEM_ID").val();
	        var bjcId = $("#BJC_ID").val();
        	var feiyueId = $("#FEIYUE_ID").val();
        	var rowIndex = $("#rowIndex").val();
			window.parent.$("#cbjView").data("kendoWindow").close();
			window.parent.$("#feiyueForm").attr("action", "e_offer/setCbj.do?MODELS=FEIYUE&CBJ_BJC_ID="+bjc_id+"&FEIYUE_SL="+sl_+"&ELEV_IDS="+ELEV_IDS+"&FEIYUE_ID="+feiyueId+"&ITEM_ID="+itemId_+"&BJC_ID="+bjcId+"&rowIndex="+rowIndex);
			window.parent.$("#feiyueForm").submit();
		}else if(models_=="feiyuemrl"){
	        var sl_ = $("#FEIYUEMRL_SL").val();
	        var elevIds_ = $("#ELEV_IDS").val();
	        var itemId_ = $("#ITEM_ID").val();
	        var bjcId = $("#BJC_ID").val();
        	var feiyuemrlId = $("#FEIYUEMRL_ID").val();
        	var rowIndex = $("#rowIndex").val();
			window.parent.$("#cbjView").data("kendoWindow").close();
			window.parent.$("#feiyuemrlForm").attr("action", "e_offer/setCbj.do?MODELS=FEIYUEMRL&CBJ_BJC_ID="+bjc_id+"&FEIYUEMRL_SL="+sl_+"&ELEV_IDS="+ELEV_IDS+"&FEIYUEMRL_ID="+feiyuemrlId+"&ITEM_ID="+itemId_+"&BJC_ID="+bjcId+"&rowIndex="+rowIndex);
			window.parent.$("#feiyuemrlForm").submit();
		}else if(models_=="shiny"){
	        var sl_ = $("#SHINY_SL").val();
	        var elevIds_ = $("#ELEV_IDS").val();
	        var itemId_ = $("#ITEM_ID").val();
	        var bjcId = $("#BJC_ID").val();
        	var shinyId = $("#SHINY_ID").val();
        	var rowIndex = $("#rowIndex").val();
			window.parent.$("#cbjView").data("kendoWindow").close();
			window.parent.$("#shinyForm").attr("action", "e_offer/setCbj.do?MODELS=SHINY&CBJ_BJC_ID="+bjc_id+"&SHINY_SL="+sl_+"&ELEV_IDS="+ELEV_IDS+"&SHINY_ID="+shinyId+"&ITEM_ID="+itemId_+"&BJC_ID="+bjcId+"&rowIndex="+rowIndex);
			window.parent.$("#shinyForm").submit();
		}else if(models_=="dnp9300"){
	        var sl_ = $("#DNP9300_SL").val();
	        var elevIds_ = $("#ELEV_IDS").val();
	        var itemId_ = $("#ITEM_ID").val();
	        var bjcId = $("#BJC_ID").val();
        	var dnp9300Id = $("#DNP9300_ID").val();
        	var rowIndex = $("#rowIndex").val();
			window.parent.$("#cbjView").data("kendoWindow").close();
			window.parent.$("#dnp9300Form").attr("action", "e_offer/setCbj.do?MODELS=DNP9300&CBJ_BJC_ID="+bjc_id+"&DNP9300_SL="+sl_+"&ELEV_IDS="+ELEV_IDS+"&DNP9300_ID="+dnp9300Id+"&ITEM_ID="+itemId_+"&BJC_ID="+bjcId+"&rowIndex="+rowIndex);
			window.parent.$("#dnp9300Form").submit();
		}else if(models_=="dnr"){
	        var sl_ = $("#DNR_SL").val();
	        var elevIds_ = $("#ELEV_IDS").val();
	        var itemId_ = $("#ITEM_ID").val();
	        var bjcId = $("#BJC_ID").val();
        	var dnrId = $("#DNR_ID").val();
        	var rowIndex = $("#rowIndex").val();
			window.parent.$("#cbjView").data("kendoWindow").close();
			window.parent.$("#dnrForm").attr("action", "e_offer/setCbj.do?MODELS=DNR&CBJ_BJC_ID="+bjc_id+"&DNR_SL="+sl_+"&ELEV_IDS="+ELEV_IDS+"&DNR_ID="+dnrId+"&ITEM_ID="+itemId_+"&BJC_ID="+bjcId+"&rowIndex="+rowIndex);
			window.parent.$("#dnrForm").submit();
		}
	}
	

	function findcbjListByItem(){
		var models_ = $("#MODELS").val();
		var url = "";
		var selitem_name = $("#selitem_name").val();
        var item_id=$("#ITEM_ID").val();
        
        var offer_version =$("#offer_version").val();
		if(models_=="feishang"){
			var sl_ = $("#FEISHANG_SL").val();
	        window.parent.$("#cbjView").kendoWindow({
	             width: "900px",
	             height: "700px",
	             title: "项目报价",
	             actions: ["Close"],
	             content: "<%=basePath%>e_offer/selCbj.do?models=feishang&FEISHANG_SL="+sl_+
      			"&item_id="+item_id+"&offer_version="+offer_version+"&selitem_name="+selitem_name,
	             modal: true,
	             visible: false,
	             resizable: true
	         }).data("kendoWindow").maximize().open();
	        
		}else if(models_=="feishangmrl"){
			var sl_ = $("#FEISHANGMRL_SL").val();
	        window.parent.$("#cbjView").kendoWindow({
	             width: "900px",
	             height: "700px",
	             title: "项目报价",
	             actions: ["Close"],
	             content: "<%=basePath%>e_offer/selCbj.do?models=feishangmrl&FEISHANGMRL_SL="+sl_+
      			"&item_id="+item_id+"&offer_version="+offer_version+"&selitem_name="+selitem_name,
	             modal: true,
	             visible: false,
	             resizable: true
	         }).data("kendoWindow").maximize().open();
	        
		}
		else if(models_=="feiyang"){
			var sl_ = $("#FEIYANG_SL").val();
	        window.parent.$("#cbjView").kendoWindow({
	             width: "900px",
	             height: "700px",
	             title: "项目报价",
	             actions: ["Close"],
	             content: "<%=basePath%>e_offer/selCbj.do?models=feiyang&FEIYANG_SL="+sl_+
     			"&item_id="+item_id+"&offer_version="+offer_version+"&selitem_name="+selitem_name,
	             modal: true,
	             visible: false,
	             resizable: true
	         }).data("kendoWindow").maximize().open();
		}else if(models_=="feiyangmrl"){
			var sl_ = $("#FEIYANGMRL_SL").val();
	        window.parent.$("#cbjView").kendoWindow({
	             width: "900px",
	             height: "700px",
	             title: "项目报价",
	             actions: ["Close"],
	             content: "<%=basePath%>e_offer/selCbj.do?models=feiyangmrl&FEIYANGMRL_SL="+sl_+
     			"&item_id="+item_id+"&offer_version="+offer_version+"&selitem_name="+selitem_name,
	             modal: true,
	             visible: false,
	             resizable: true
	         }).data("kendoWindow").maximize().open();
		}else if(models_=="feiyangxf"){
			var sl_ = $("#FEIYANGXF_SL").val();
	        window.parent.$("#cbjView").kendoWindow({
	             width: "900px",
	             height: "700px",
	             title: "项目报价",
	             actions: ["Close"],
	             content: "<%=basePath%>e_offer/selCbj.do?models=feiyangxf&FEIYANGXF_SL="+sl_+
    			"&item_id="+item_id+"&offer_version="+offer_version+"&selitem_name="+selitem_name,
	             modal: true,
	             visible: false,
	             resizable: true
	         }).data("kendoWindow").maximize().open();
		}else if(models_=="feiyue"){
			var sl_ = $("#FEIYUE_SL").val();
	        window.parent.$("#cbjView").kendoWindow({
	             width: "900px",
	             height: "700px",
	             title: "项目报价",
	             actions: ["Close"],
	             content: "<%=basePath%>e_offer/selCbj.do?models=feiyue&FEIYUE_SL="+sl_+
         			"&item_id="+item_id+"&offer_version="+offer_version+"&selitem_name="+selitem_name,
	             modal: true,
	             visible: false,
	             resizable: true
	         }).data("kendoWindow").maximize().open();
// 	    	 CloseSUWin("cbjView");
		}else if(models_=="feiyuemrl"){
			var sl_ = $("#FEIYUEMRL_SL").val();
	        window.parent.$("#cbjView").kendoWindow({
	             width: "900px",
	             height: "700px",
	             title: "项目报价",
	             actions: ["Close"],
	             content: "<%=basePath%>e_offer/selCbj.do?models=feiyuemrl&FEIYUEMRL_SL="+sl_+
   			"&item_id="+item_id+"&offer_version="+offer_version+"&selitem_name="+selitem_name,
	             modal: true,
	             visible: false,
	             resizable: true
	         }).data("kendoWindow").maximize().open();
		}else if(models_=="shiny"){
			var sl_ = $("#SHINY_SL").val();
	        window.parent.$("#cbjView").kendoWindow({
	             width: "900px",
	             height: "700px",
	             title: "项目报价",
	             actions: ["Close"],
	             content: "<%=basePath%>e_offer/selCbj.do?models=shiny&SHINY_SL="+sl_+
  			"&item_id="+item_id+"&offer_version="+offer_version+"&selitem_name="+selitem_name,
	             modal: true,
	             visible: false,
	             resizable: true
	         }).data("kendoWindow").maximize().open();
		}else if(models_=="dnp9300"){
			var sl_ = $("#DNP9300_SL").val();
	        window.parent.$("#cbjView").kendoWindow({
	             width: "900px",
	             height: "700px",
	             title: "项目报价",
	             actions: ["Close"],
	             content: "<%=basePath%>e_offer/selCbj.do?models=dnp9300&DNP9300_SL="+sl_+
 			"&item_id="+item_id+"&offer_version="+offer_version+"&selitem_name="+selitem_name,
	             modal: true,
	             visible: false,
	             resizable: true
	         }).data("kendoWindow").maximize().open();
		}else if(models_=="dnr"){
			var sl_ = $("#DNR_SL").val();
	        window.parent.$("#cbjView").kendoWindow({
	             width: "900px",
	             height: "700px",
	             title: "项目报价",
	             actions: ["Close"],
	             content: "<%=basePath%>e_offer/selCbj.do?models=dnr&DNR_SL="+sl_+
			"&item_id="+item_id+"&offer_version="+offer_version+"&selitem_name="+selitem_name,
	             modal: true,
	             visible: false,
	             resizable: true
	         }).data("kendoWindow").maximize().open();
	        
		}
	}
	function CloseSUWin(id) {
		window.parent.$("#" + id).data("kendoWindow").close();
		/* 	window.parent.location.reload(); */
	}
	</script>
</body>

</html>
