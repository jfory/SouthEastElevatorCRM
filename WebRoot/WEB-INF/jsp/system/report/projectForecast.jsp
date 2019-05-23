<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fns" uri="/WEB-INF/tlds/fns.tld"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
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
 <!-- 日期控件-->
 <script src="static/js/layer/laydate/laydate.js"></script>
 <!-- echarts -->
 <link href="static/css/echarts/style.css" rel="stylesheet">
 <link href="static/css/select2/select2.min.css" rel="stylesheet">
 <script src="static/js/select2/select2.min.js"></script>
<title>${pd.SYSNAME}</title>
<style type="text/css">
   	.echarts{
   		height: 500px;
   	}
   </style>
</head>

<body class="gray-bg">
	<div class="col-sm-12">
         <div class="ibox float-e-margins" id="menuContent" class="menuContent"
              style="display:none; position: absolute;z-index: 99;border: solid 1px #18a689;max-height:300px;overflow-y:scroll;overflow-x:auto">
             <div class="ibox-content">
                 <div>
                     <input class="form-control" style="height: 30px" type="text" placeholder="搜索" id="keyWord"
                            onkeyup="searchTreeNodesByKeyWord()">
                     <ul id="myzTree" class="ztree" style="margin-top:0; width:160px;"></ul>
                 </div>
             </div>
         </div>
     </div>
	<div class="col-sm-12">
		<div class="ibox float-e-margins">
			<div class="ibox-content" style="margin-bottom: 15px;">
				<div id="top" ,name="top"></div>
				<form role="form" class="form-inline" action=""
					method="post" name="postForm" id="shopForm" >

					<div class="form-group ">
						<%-- <input class="form-control" type="text" id="nav-search-input"
							type="text" name="houses_name" value="${pd.houses_name }"
							placeholder="运营模块"> --%>
							<select class="form-control" style="width: 300px;" name="yymk" multiple="multiple"><c:forEach items="${fns:getDictList('bb_qu_yymk')}" var="yymk" varStatus="vsyymk">
                                       	<option value="${yymk.value }">${yymk.name }</option></c:forEach>
                          		</select>
					</div>
					<div class="form-group ">
						<input class="form-control" id="nav-search-input1" type="text"
	 					  name="input_date" onclick="laydate()"
	   					  placeholder="预测日期" >
					</div>
					 <%-- <div class="form-group form-inline" style="">
                        <select class="form-control" name="genjinstatus">
                            <option value="">请选择跟进状态</option><c:forEach items="${fns:getDictList('xm_gjjl_xmzt')}" var="fbtype" varStatus="vsfbtype">
                                  <option value="${fbtype.value }">${fbtype.name }</option></c:forEach>
                        </select>
                    </div>
                    <div class="form-group form-inline" style="">
                        <input id="model_id" name="model_id" type="hidden" value="">
                        <input id="model_name" name="model_name" type="hidden" value="">
                        <input id="modelSelect" name="modelSelect" type="text" value="" readonly
                               class="form-control" placeholder="请点击选择梯种分类" onclick="showMenu();">
                    </div>
                    <div class="form-group form-inline" style="">
                        <select name="sale_type" class="form-control"
	                            onchange="setOrderOrg();">
	                        <option value="">请选择销售类型</option>
	                        <option value="1">经销</option>
	                        <option value="2">直销</option>
	                        <option value="3">代销</option>
	                    </select>
                    </div>
                    <div class="form-group form-inline" style="">
                        <select name="order_org" id="order_org" class="form-control">
	                        <option value="">请选择订购单位</option>
	                    </select>
                    </div> --%>
					<div class="form-group">
						<button id="btn_sreach" type="button" class="btn  btn-primary "
							style="margin-bottom: 0px;" title="搜索" onclick="sreanch()">
							<i style="font-size: 18px;" class="fa fa-search"></i>
						</button>
						<a class="btn btn-warning" style="margin-top: 7px;margin-left: 5px;" title="导出到Excel" type="button" target="_blank" onclick="toExcel(this);" href="javascript:;">导出</a>
							<button class="btn btn-info" style="margin-top: 7px"  title="导入到Excel" type="button" onclick="inputFile()">导入</button>
							<input style="display: none" class="form-control" type="file"  title="导入" id="importFile" onchange="importExcel(this)"/>
					<button class="btn  btn-success" style="margin-top: 7px"  title="下载数据模板" type="button" onclick="downFile()">下载模板</button>
					${page.pageStr}
					</div>
					<!-- <button class="btn  btn-success"  style="margin-left: 380px;" title="刷新" type="button"
						style="float: right" onclick="refreshCurrentTab();">刷新
					</button> -->
				</form>
			</div>
			<div class="ibox-content">
	            <div class="echarts" id="echarts-bar-chart"></div>
	        </div>
		</div>
	</div>
	<!--返回顶部开始-->
	<div id="back-to-top">
		<a class="btn btn-warning btn-back-to-top"
			href="javascript: setWindowScrollTop (this,document.getElementById('top').offsetTop);">
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
	<!-- ECharts -->
    <script src="static/js/plugins/echarts/echarts3/echarts.js"></script>
	<script type="text/javascript">
    $(document).ready(function () {
		//loading end
		parent.layer.closeAll('loading');
        /* checkbox */
        
        var gjs = $('select[name=yymk]').find("option");
        $.each(gjs, function(i,v) {
			$(v).attr("selected", "selected"); 
		});
		$('select[name=yymk]').select2();
		
		chart = echarts.init(document.getElementById("echarts-bar-chart"));
		
		$('#nav-search-input1').val(getNowFormatDate());
		
		sreanch();
    });
    /* checkbox全选 */
    $("#zcheckbox").on('ifChecked', function (event) {

        $('input').iCheck('check');
    });
    /* checkbox取消全选 */
    $("#zcheckbox").on('ifUnchecked', function (event) {

        $('input').iCheck('uncheck');
    });

    //刷新iframe
    function refreshCurrentTab() {
    	$("#postForm").submit();
    	//window.location.reload();
    }
    //检索
/*     function search() {
        $("#postForm").submit();
    } */
   
    var chart;
    //set by type
    function sreanch(){
    	$('#btn_sreach').attr("disabled", "disabled");
		var yymk = $("select[name='yymk']").val();
	  	var input_date = $("input[name='input_date']").val();
        $.post("<%=basePath%>report/sreachProjectForecastReport.do?input_date="+input_date+"&yymk=" + yymk,
            function(data){
        		$('#btn_sreach').removeAttr("disabled");
                var obj = eval("("+data+")");
                chart.setOption(obj,true);
            }
        );
    }
    
  //导出到Excel
	function toExcel(ele){
		var url = "<%=basePath%>report/toProjectForecastExcel.do?";
		 var yymk = $("select[name='yymk']").val();
         url = url + "&yymk=" + yymk
             + "&input_date=" + $("input[name='input_date']").val();
        $(ele).attr("href", url);
	}
	//选择导入文件
	function inputFile(){
		$("#importFile").click();
	}

	//导入Excel
	function importExcel(e){
    	var filePath = $(e).val();
    	//当前文件
    	var suffix = filePath.substring(filePath.lastIndexOf(".")).toLowerCase();
    	var fileType = ".xls|.xlsx|";
    	if(filePath == null || filePath == ""){
            return false;
        }
        if(fileType.indexOf(suffix+"|")==-1){
            var ErrMsg = "该文件类型不允许上传。请上传 "+fileType+" 类型的文件，当前文件类型为"+suffix; 
            $(e).val("");
            alert(ErrMsg);
            return false;
        }
        var data = new FormData();
    	data.append("file", $(e)[0].files[0]);
    	$.ajax({
            url:"<%=basePath%>report/importExcel.do",
            type:"POST",
            data:data,
            cache: false,
            processData:false,
            contentType:false,
            success:function(result){
            	$(e).val("");
                if(result.msg=="success"){
                	swal({
                		title:"导入成功!",
                		text:"导入数据成功。",
                		type:"success"
                	},
					 function(){
						 refreshCurrentTab();
					 });
                }else if(result.msg=="allErr"){
                    swal({
                    	title:"导入失败!",
                    	text:"导入数据失败!"+result.errorUpload,
                    	type:"error"
                    },
					 function(){
						 refreshCurrentTab();
					 });
                }else if(result.msg=="error"){
                    swal({
                    	title:"部分数据导入失败!",
                    	text:"错误信息："+result.errorUpload,
                    	type:"warning"
                    },
					 function(){
						 refreshCurrentTab();
					 });
                }else if(result.msg=="exception"){
                    swal({
                    	title:"导入失败!",
                    	text:"导入数据失败!"+result.errorUpload,
                    	type:"error"
                    },
					 function(){
						 refreshCurrentTab();
					 });
                }
            }
        });
	}
	
	function setOrderOrg() {
        var sale_type = $("select[name='sale_type']").val();
        if (sale_type != "") {
            $.post("<%=basePath%>item/getOrderOrg.do?sale_type=" + sale_type,
                function (data) {
                    var obj = eval("(" + data.orderOrgs + ")");
                    var optStr = "";
                    for (var i = 0; i < obj.length; i++) {
                        optStr += "<option value='" + obj[i].id + "'";
                        optStr += ">" + obj[i].name + "</option>";
                        $("#order_org").empty();
                        $("#order_org").append(optStr);
                    }
                }
            );
        }
    }
	
	function showMenu() {
        var orgObj = $("#modelSelect");
        var orgOffset = $("#modelSelect").offset();
        $("#menuContent").css({
            left: (orgOffset.left + 6) + "px",
            top: orgOffset.top + orgObj.outerHeight() + "px"
        }).slideDown("fast");

        $("body").bind("mousedown", onBodyDown);
    }
    
	// 下载文件   e代表当前路径值 
	function downFile() {
		var url="uploadFiles/file/Report/项目预测表.xls";
		var name = window.encodeURI(window.encodeURI(url));
		window.open("customer/DataModel?url=" + name,"_blank");
	}
		/* back to top */
		function setWindowScrollTop(win, topHeight) {
			if (win.document.documentElement) {
				win.document.documentElement.scrollTop = topHeight;
			}
			if (win.document.body) {
				win.document.body.scrollTop = topHeight;
			}
		}
		
		//获取当前时间，格式YYYY-MM-DD
	    function getNowFormatDate() {
	        var date = new Date();
	        var seperator1 = "-";
	        var year = date.getFullYear();
	        var month = date.getMonth() + 1;
	        var strDate = date.getDate();
	        if (month >= 1 && month <= 9) {
	            month = "0" + month;
	        }
	        if (strDate >= 0 && strDate <= 9) {
	            strDate = "0" + strDate;
	        }
	        var currentdate = year + seperator1 + month + seperator1 + strDate;
	        return currentdate;
	    }
		
	</script>
</body>
</html>