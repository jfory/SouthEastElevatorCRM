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

<body class="gray-bg" >
	<div id="EditTradeType" class="animated fadeIn"></div>
    <div class="wrapper wrapper-content">
    	<input type="hidden" name="rowIndex" id="rowIndex" value="${pd.rowIndex}">
    	<input type="hidden" name="ITEM_ID" id="ITEM_ID" value="${pd.ITEM_ID}">
    	<input type="hidden" name="ELEV_IDS" id="ELEV_IDS" value="${pd.ELEV_IDS}">
    	<input type="hidden" name="BJC_ID" id="BJC_ID" value="${pd.BJC_ID}">

    	<input type="hidden" name="MODELS" id="MODELS" value="${pd.models}">
    	<input type="hidden" name="BZ_ZZ" id="BZ_ZZ" value="${pd.BZ_ZZ}">
    	<input type="hidden" name="BZ_SD" id="BZ_SD" value="${pd.BZ_SD}">
    	<input type="hidden" name="BZ_KMXS" id="BZ_KMXS" value="${pd.BZ_KMXS}">
    	<input type="hidden" name="BZ_KMKD" id="BZ_KMKD" value="${pd.BZ_KMKD}">
    	<input type="hidden" name="BZ_C" id="BZ_C" value="${pd.BZ_C}">
    	<input type="hidden" name="BZ_Z" id="BZ_Z" value="${pd.BZ_Z}">
    	<input type="hidden" name="BZ_M" id="BZ_M" value="${pd.BZ_M}">
    	<input type="hidden" name="FEISHANG_SL" id="FEISHANG_SL" value="${pd.FEISHANG_SL}">
    	<input type="hidden" name="FEISHANG_ZK" id="FEISHANG_ZK" value="${pd.FEISHANG_ZK}">
    	<input type="hidden" name="FEISHANG_SBJ" id="FEISHANG_SBJ" value="${pd.FEISHANG_SBJ}">
    	<input type="hidden" name="FEISHANG_ID" id="FEISHANG_ID" value="${pd.FEISHANG_ID}">

    	<input type="hidden" name="FEIYANG_SL" id="FEIYANG_SL" value="${pd.FEIYANG_SL}">
    	<input type="hidden" name="FEIYANG_ZK" id="FEIYANG_ZK" value="${pd.FEIYANG_ZK}">
    	<input type="hidden" name="FEIYANG_SBJ" id="FEIYANG_SBJ" value="${pd.FEIYANG_SBJ}">
    	<input type="hidden" name="FEIYANG_ID" id="FEIYANG_ID" value="${pd.FEIYANG_ID}">

    	<input type="hidden" name="FEIYANGMRL_SL" id="FEIYANGMRL_SL" value="${pd.FEIYANGMRL_SL}">
    	<input type="hidden" name="FEIYANGMRL_ZK" id="FEIYANGMRL_ZK" value="${pd.FEIYANGMRL_ZK}">
    	<input type="hidden" name="FEIYANGMRL_SBJ" id="FEIYANGMRL_SBJ" value="${pd.FEIYANGMRL_SBJ}">
    	<input type="hidden" name="FEIYANGMRL_ID" id="FEIYANGMRL_ID" value="${pd.FEIYANGMRL_ID}">

    	<input type="hidden" name="FEIYANGXF_SL" id="FEIYANGXF_SL" value="${pd.FEIYANGXF_SL}">
    	<input type="hidden" name="FEIYANGXF_ZK" id="FEIYANGXF_ZK" value="${pd.FEIYANGXF_ZK}">
    	<input type="hidden" name="FEIYANGXF_SBJ" id="FEIYANGXF_SBJ" value="${pd.FEIYANGXF_SBJ}">
    	<input type="hidden" name="FEIYANGXF_ID" id="FEIYANGXF_ID" value="${pd.FEIYANGXF_ID}">

    	<input type="hidden" name="FEIYUE_SL" id="FEIYUE_SL" value="${pd.FEIYUE_SL}">
    	<input type="hidden" name="FEIYUE_ZK" id="FEIYUE_ZK" value="${pd.FEIYUE_ZK}">
    	<input type="hidden" name="FEIYUE_SBJ" id="FEIYUE_SBJ" value="${pd.FEIYUE_SBJ}">
    	<input type="hidden" name="FEIYUE_ID" id="FEIYUE_ID" value="${pd.FEIYUE_ID}">

    	<input type="hidden" name="FEIYUEMRL_SL" id="FEIYUEMRL_SL" value="${pd.FEIYUEMRL_SL}">
    	<input type="hidden" name="FEIYUEMRL_ZK" id="FEIYUEMRL_ZK" value="${pd.FEIYUEMRL_ZK}">
    	<input type="hidden" name="FEIYUEMRL_SBJ" id="FEIYUEMRL_SBJ" value="${pd.FEIYUEMRL_SBJ}">
    	<input type="hidden" name="FEIYUEMRL_ID" id="FEIYUEMRL_ID" value="${pd.FEIYUEMRL_ID}">

    	<input type="hidden" name="SHINY_SL" id="SHINY_SL" value="${pd.SHINY_SL}">
    	<input type="hidden" name="SHINY_ZK" id="SHINY_ZK" value="${pd.SHINY_ZK}">
    	<input type="hidden" name="SHINY_SBJ" id="SHINY_SBJ" value="${pd.SHINY_SBJ}">
    	<input type="hidden" name="SHINY_ID" id="SHINY_ID" value="${pd.SHINY_ID}">
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
	                            <table class="table table-striped table-bordered table-hover">
	                                <thead>
	                                    <tr>
	                                        <th style="width:8%;">序号</th>
	                                        <th style="width:8%;">轿厢尺寸</th>
	                                        <th style="width:5%;">轿厢高度</th>
	                                        <th style="width:6%;">单价</th>
	                                        <th style="width:8%;">数量</th>
	                                        <th style="width:8%;">总价</th>
	                                        <th style="width:8%;">操作</th>
	                                    </tr>
	                                </thead>
	                                <tbody>
	                                <!-- 开始循环 -->	
									<c:choose>
										<c:when test="${not empty zhjList}">
											<c:if test="${QX.cha == 1 }">
												<c:forEach items="${zhjList}" var="var" >
													<tr>
														<td>1</td>
														<td>${var.JXGG}</td>
														<td>${var.JXGD}</td>
														<td>--</td>
														<td>${var.SL}</td>
														<td>${var.SJBJ}</td>
														<td>
															<div>
																<c:if test="${QX.edit == 1 }">
																	<button class="btn btn-sm btn-primary btn-sm" title="调用" type="button" onclick="setZhj('${var.ID}');">调用</button>
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


	//修改
	function setZhj(id){
		var models_ = $("#MODELS").val();
		if(models_=="feishang"){
			var zz_ = $("#BZ_ZZ").val();
	        var sd_ = $("#BZ_SD").val();
	        var kmxs_ = $("#BZ_KMXS").val();
	        var kmkd_ = $("#BZ_KMKD").val();
	        var c_ = $("#BZ_C").val();
	        var z_ = $("#BZ_Z").val();
	        var m_ = $("#BZ_M").val();
	        var sl_ = $("#FEISHANG_SL").val();
	        var zk_ = $("#FEISHANG_ZK").val();
	        var sbj_ = $("#FEISHANG_SBJ").val();

	        var elevIds_ = $("#ELEV_IDS").val();
	        var itemId_ = $("#ITEM_ID").val();
	        var bjcId = $("#BJC_ID").val();
        	var feishangId = $("#FEISHANG_ID").val();
        	var rowIndex = $("#rowIndex").val();

			window.parent.$("#zhjView").data("kendoWindow").close();
			window.parent.$("#feishangForm").attr("action", "e_offer/setZhj.do?MODELS=FEISHANG&ID="+id+"&BZ_ZZ="+zz_+"&BZ_SD="+sd_+"&BZ_KMXS="+kmxs_+"&BZ_KMKD="+kmkd_+"&BZ_C="+c_+"&BZ_Z="+z_+"&BZ_M="+m_+"&FEISHANG_SL="+sl_+"&FEISHANG_ZK="+zk_+"&FEISHANG_SBJ="+sbj_+"&ELEV_IDS="+elevIds_+"&ITEM_ID="+itemId_+"&BJC_ID="+bjcId+"&FEISHANG_ID="+feishangId+"&rowIndex="+rowIndex);
			window.parent.$("#feishangForm").submit();
		}else if(models_=="feiyang"){
			var zz_ = $("#BZ_ZZ").val();
	        var sd_ = $("#BZ_SD").val();
	        var kmxs_ = $("#BZ_KMXS").val();
	        var kmkd_ = $("#BZ_KMKD").val();
	        var c_ = $("#BZ_C").val();
	        var z_ = $("#BZ_Z").val();
	        var m_ = $("#BZ_M").val();
	        var sl_ = $("#FEIYANG_SL").val();
	        var zk_ = $("#FEIYANG_ZK").val();
	        var sbj_ = $("#FEIYANG_SBJ").val();

	        var elevIds_ = $("#ELEV_IDS").val();
	        var itemId_ = $("#ITEM_ID").val();
	        var bjcId = $("#BJC_ID").val();
        	var feiyangId = $("#FEIYANG_ID").val();
        	var rowIndex = $("#rowIndex").val();
			window.parent.$("#zhjView").data("kendoWindow").close();
			window.parent.$("#feiyang3000Form").attr("action", "e_offer/setZhj.do?MODELS=FEIYANG&ID="+id+"&BZ_ZZ="+zz_+"&BZ_SD="+sd_+"&BZ_KMXS="+kmxs_+"&BZ_KMKD="+kmkd_+"&BZ_C="+c_+"&BZ_Z="+z_+"&BZ_M="+m_+"&FEIYANG_SL="+sl_+"&FEIYANG_ZK="+zk_+"&FEIYANG_SBJ="+sbj_+"&ELEV_IDS="+elevIds_+"&ITEM_ID="+itemId_+"&BJC_ID="+bjcId+"&FEIYANG_ID="+feiyangId+"&rowIndex="+rowIndex);
			window.parent.$("#feiyang3000Form").submit();
		}else if(models_=="feiyangmrl"){
			var zz_ = $("#BZ_ZZ").val();
	        var sd_ = $("#BZ_SD").val();
	        var kmxs_ = $("#BZ_KMXS").val();
	        var kmkd_ = $("#BZ_KMKD").val();
	        var c_ = $("#BZ_C").val();
	        var z_ = $("#BZ_Z").val();
	        var m_ = $("#BZ_M").val();
	        var sl_ = $("#FEIYANGMRL_SL").val();
	        var zk_ = $("#FEIYANGMRL_ZK").val();
	        var sbj_ = $("#FEIYANGMRL_SBJ").val();

	        var elevIds_ = $("#ELEV_IDS").val();
	        var itemId_ = $("#ITEM_ID").val();
	        var bjcId = $("#BJC_ID").val();
        	var feiyangmrlId = $("#FEIYANGMRL_ID").val();
        	var rowIndex = $("#rowIndex").val();
			window.parent.$("#zhjView").data("kendoWindow").close();
			window.parent.$("#feiyang3000mrlForm").attr("action", "e_offer/setZhj.do?MODELS=FEIYANGMRL&ID="+id+"&BZ_ZZ="+zz_+"&BZ_SD="+sd_+"&BZ_KMXS="+kmxs_+"&BZ_KMKD="+kmkd_+"&BZ_C="+c_+"&BZ_Z="+z_+"&BZ_M="+m_+"&FEIYANGMRL_SL="+sl_+"&FEIYANGMRL_ZK="+zk_+"&FEIYANGMRL_SBJ="+sbj_+"&ELEV_IDS="+elevIds_+"&ITEM_ID="+itemId_+"&BJC_ID="+bjcId+"&FEIYANGMRL_ID="+feiyangmrlId+"&rowIndex="+rowIndex);
			window.parent.$("#feiyang3000mrlForm").submit();
		}else if(models_=="feiyangxf"){
			var zz_ = $("#BZ_ZZ").val();
	        var sd_ = $("#BZ_SD").val();
	        var kmxs_ = $("#BZ_KMXS").val();
	        var kmkd_ = $("#BZ_KMKD").val();
	        var c_ = $("#BZ_C").val();
	        var z_ = $("#BZ_Z").val();
	        var m_ = $("#BZ_M").val();
	        var sl_ = $("#FEIYANGXF_SL").val();
	        var zk_ = $("#FEIYANGXF_ZK").val();
	        var sbj_ = $("#FEIYANGXF_SBJ").val();

	        var elevIds_ = $("#ELEV_IDS").val();
	        var itemId_ = $("#ITEM_ID").val();
	        var bjcId = $("#BJC_ID").val();
        	var feiyangxfId = $("#FEIYANGXF_ID").val();
        	var rowIndex = $("#rowIndex").val();
			window.parent.$("#zhjView").data("kendoWindow").close();
			window.parent.$("#feiyangxfForm").attr("action", "e_offer/setZhj.do?MODELS=FEIYANGXF&ID="+id+"&BZ_ZZ="+zz_+"&BZ_SD="+sd_+"&BZ_KMXS="+kmxs_+"&BZ_KMKD="+kmkd_+"&BZ_C="+c_+"&BZ_Z="+z_+"&BZ_M="+m_+"&FEIYANGXF_SL="+sl_+"&FEIYANGXF_ZK="+zk_+"&FEIYANGXF_SBJ="+sbj_+"&ELEV_IDS="+elevIds_+"&ITEM_ID="+itemId_+"&BJC_ID="+bjcId+"&FEIYANGXF_ID="+feiyangxfId+"&rowIndex="+rowIndex);
			window.parent.$("#feiyangxfForm").submit();
		}else if(models_=="feiyue"){
			var zz_ = $("#BZ_ZZ").val();
	        var sd_ = $("#BZ_SD").val();
	        var kmxs_ = $("#BZ_KMXS").val();
	        var kmkd_ = $("#BZ_KMKD").val();
	        var c_ = $("#BZ_C").val();
	        var z_ = $("#BZ_Z").val();
	        var m_ = $("#BZ_M").val();
	        var sl_ = $("#FEIYUE_SL").val();
	        var zk_ = $("#FEIYUE_ZK").val();
	        var sbj_ = $("#FEIYUE_SBJ").val();

	        var elevIds_ = $("#ELEV_IDS").val();
	        var itemId_ = $("#ITEM_ID").val();
	        var bjcId = $("#BJC_ID").val();
        	var feiyueId = $("#FEIYUE_ID").val();
        	var rowIndex = $("#rowIndex").val();
			window.parent.$("#zhjView").data("kendoWindow").close();
			window.parent.$("#feiyueForm").attr("action", "e_offer/setZhj.do?MODELS=FEIYUE&ID="+id+"&BZ_ZZ="+zz_+"&BZ_SD="+sd_+"&BZ_KMXS="+kmxs_+"&BZ_KMKD="+kmkd_+"&BZ_C="+c_+"&BZ_Z="+z_+"&BZ_M="+m_+"&FEIYUE_SL="+sl_+"&FEIYUE_ZK="+zk_+"&FEIYUE_SBJ="+sbj_+"&ELEV_IDS="+elevIds_+"&ITEM_ID="+itemId_+"&BJC_ID="+bjcId+"&FEIYUE_ID="+feiyueId+"&rowIndex="+rowIndex);
			window.parent.$("#feiyueForm").submit();
		}else if(models_=="feiyuemrl"){
			var zz_ = $("#BZ_ZZ").val();
	        var sd_ = $("#BZ_SD").val();
	        var kmxs_ = $("#BZ_KMXS").val();
	        var kmkd_ = $("#BZ_KMKD").val();
	        var c_ = $("#BZ_C").val();
	        var z_ = $("#BZ_Z").val();
	        var m_ = $("#BZ_M").val();
	        var sl_ = $("#FEIYUEMRL_SL").val();
	        var zk_ = $("#FEIYUEMRL_ZK").val();
	        var sbj_ = $("#FEIYUEMRL_SBJ").val();

	        var elevIds_ = $("#ELEV_IDS").val();
	        var itemId_ = $("#ITEM_ID").val();
	        var bjcId = $("#BJC_ID").val();
        	var feiyuemrlId = $("#FEIYUEMRL_ID").val();
        	var rowIndex = $("#rowIndex").val();
			window.parent.$("#zhjView").data("kendoWindow").close();
			window.parent.$("#feiyuemrlForm").attr("action", "e_offer/setZhj.do?MODELS=FEIYUEMRL&ID="+id+"&BZ_ZZ="+zz_+"&BZ_SD="+sd_+"&BZ_KMXS="+kmxs_+"&BZ_KMKD="+kmkd_+"&BZ_C="+c_+"&BZ_Z="+z_+"&BZ_M="+m_+"&FEIYUEMRL_SL="+sl_+"&FEIYUEMRL_ZK="+zk_+"&FEIYUEMRL_SBJ="+sbj_+"&ELEV_IDS="+elevIds_+"&ITEM_ID="+itemId_+"&BJC_ID="+bjcId+"&FEIYUEMRL_ID="+feiyuemrlId+"&rowIndex="+rowIndex);
			window.parent.$("#feiyuemrlForm").submit();
		}else if(models_=="shiny"){
			var zz_ = $("#BZ_ZZ").val();
	        var sd_ = $("#BZ_SD").val();
	        var kmxs_ = $("#BZ_KMXS").val();
	        var kmkd_ = $("#BZ_KMKD").val();
	        var c_ = $("#BZ_C").val();
	        var z_ = $("#BZ_Z").val();
	        var m_ = $("#BZ_M").val();
	        var sl_ = $("#SHINY_SL").val();
	        var zk_ = $("#SHINY_ZK").val();
	        var sbj_ = $("#SHINY_SBJ").val();

	        var elevIds_ = $("#ELEV_IDS").val();
	        var itemId_ = $("#ITEM_ID").val();
	        var bjcId = $("#BJC_ID").val();
        	var shinyId = $("#SHINY_ID").val();
        	var rowIndex = $("#rowIndex").val();
			window.parent.$("#zhjView").data("kendoWindow").close();
			window.parent.$("#shinyForm").attr("action", "e_offer/setZhj.do?MODELS=SHINY&ID="+id+"&BZ_ZZ="+zz_+"&BZ_SD="+sd_+"&BZ_KMXS="+kmxs_+"&BZ_KMKD="+kmkd_+"&BZ_C="+c_+"&BZ_Z="+z_+"&BZ_M="+m_+"&SHINY_SL="+sl_+"&SHINY_ZK="+zk_+"&SHINY_SBJ="+sbj_+"&ELEV_IDS="+elevIds_+"&ITEM_ID="+itemId_+"&BJC_ID="+bjcId+"&SHINY_ID="+shinyId+"&rowIndex="+rowIndex);
			window.parent.$("#shinyForm").submit();
		}
	}
	

	function CloseSUWin(id) {
		window.parent.$("#" + id).data("kendoWindow").close();
		/* 	window.parent.location.reload(); */
	}
	</script>
</body>

</html>
