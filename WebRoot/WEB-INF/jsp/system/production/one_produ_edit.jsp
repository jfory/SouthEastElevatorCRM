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

<link href="static/js/fancybox/jquery.fancybox.css" rel="stylesheet">
<link type="text/css" rel="stylesheet"
	href="plugins/zTree/3.5.24/css/zTreeStyle/zTreeStyle.css" />
<script type="text/javascript"
	src="plugins/zTree/3.5.24/js/jquery.ztree.core.js"></script>
<script type="text/javascript"
	src="plugins/zTree/3.5.24/js/jquery.ztree.excheck.js"></script>
<script type="text/javascript"
	src="plugins/zTree/3.5.24/js/jquery.ztree.exedit.js"></script>


<!-- 日期控件-->
<script src="static/js/layer/laydate/laydate.js"></script>
<script type="text/javascript">
     $(document).ready(function () {
            /* 图片 */
            $('.fancybox').fancybox({
                openEffect: 'none',
                closeEffect: 'none'
            });
        });
        //保存
        function save(){
            if ($("#is_subscription").val()=="" && $("#is_subscription").val()=="") 
            {
                $("#is_subscription").focus();
            	$("#is_subscription").tips({
                    side: 3,
                    msg: "请选择订金是否到账",
                    bg: '#AE81FF',
                    time: 3
                });
              
                return false;
            }
            
            if ($("#signedTime").val()=="" && $("#signedTime").val()=="") 
            {
                $("#signedTime").focus();
            	$("#signedTime").tips({
                    side: 3,
                    msg: "请输入日期",
                    bg: '#AE81FF',
                    time: 3
                });
              
                return false;
            }
            
            
            
      	$("#cellForm").submit();      
        }
        
	
	//文件异步上传   e代表当前File对象,v代表对应路径值
	function upload(e,v) {
		var filePath = $(e).val();
		var arr = filePath.split("\\");
		var fileName = arr[arr.length - 1];
		var suffix = filePath.substring(filePath.lastIndexOf("."))
				.toLowerCase();
		var fileType = ".xls|.xlsx|.doc|.docx|.txt|.pdf|";
		if (filePath == null || filePath == "") {
			$(v).val("");
			return false;
		}

		//var data = new FormData($("#agentForm")[0]);
		var data = new FormData();
		data.append("file", $(e)[0].files[0]);
		$.ajax({
			url : "contract/upload.do",
			type : "POST",
			data : data,
			cache : false,
			processData : false,
			contentType : false,
			success : function(result) {
				if (result.success) {
					$(v).val(result.filePath);
				} else {
					alert(result.errorMsg);
				}
			}
		});
	}
	// 下载文件   e代表当前路径值 
	function downFile(e) {
		var downFile = $(e).val();
		window.location.href = "contract/down?downFile=" + downFile;
	}
	
	
   
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
</script>
</head>
<body class="gray-bg">
	<form action="production/${msg}.do" name="cellForm" id="cellForm"
		method="post">
		<input type="hidden" name="item_no"id="item_no" value="${pd.con_item_no}" />
		<input type="hidden" name="item_id"id="item_id" value="${pd.item_id}"/>
		<input type="hidden" name="elevator_no"id="elevator_no" value="${pd.no}"/>
		<input type="hidden" name="production_key"id="production_key" value="${pd.production_key}"/>
		<input type="hidden" name="pro_no"id="pro_no" value="${pd.pro_no}" />
		<input type="hidden" name="elevator_id"id="elevator_id" value="${pd.elevator_id}" />
		<div class="wrapper wrapper-content">
			<div class="row">
				<div class="col-sm-12">
					<div class="ibox float-e-margins">
						<div class="ibox-content1">
								<div class="panel panel-primary">
									<div class="panel-heading">创建一排单</div>
									<div class="panel-body">
									<div class="row" style="margin-left: 10px">
										         <div class="form-group form-inline">
												    <span style="color: red;">*</span>
												    <label style="width: 15%">项目名称:</label> 
												    <input style="width: 30%" type="text" name="item_name" readonly="readonly"
														id="item_name" value="${pd.item_name}"
														placeholder="这里输入项目名称" title="项目名称" class="form-control" />
													<span type="hidden">&nbsp&nbsp&nbsp</span>
										            <span style="color: red;">*</span>
											        <label style="width: 15%">订金是否到账:</label>
											        <select style="width: 30%" class="form-control"
													name="is_subscription" readonly id="is_subscription">
													<option value="">请选择</option>
													<option value="1" <c:if test="${pd.is_subscription =='1'}"> selected</c:if>>是</option>
													<option value="2" <c:if test="${pd.is_subscription =='2'}"> selected</c:if>>否</option>
												</select> 
										        </div>
										
												<div class="form-group form-inline">
									            <!-- 上传文件 -->
												<label style="width: 15%;margin-left:10px;">上传合同文本:</label>
												 <input class="form-control" style="width: 30%" type="hidden" name="contract_text" id="contract_text"  
												 placeholder="这里输入附件" value="${pd.contract_text}" title="附件" /> 
												 <input style="width: 30%" class="form-control" type="file" name="contract" id="contract" 
												readonly placeholder="这里输入附件" title="附件" onchange="upload(this,$('#contract_text'))" />
												<c:if
													test="${pd ne null and pd.contract_text ne null and pd.contract_text ne '' }">
													<a class="btn btn-mini btn-success"
														onclick="downFile($('#contract_text'))">下载附件</a>
												</c:if>
												<label style="width: 15%;margin-left:24px;">上传排产资料:</label>
												 <input class="form-control" style="width: 30%" type="hidden" name="production_datum" id="production_datum"  
												 placeholder="这里输入附件" value="${pd.production_datum}" title="附件" /> 
												 <input style="width: 30%" class="form-control" type="file" name="production" id="production" 
												readonly placeholder="这里输入附件" title="附件" onchange="upload(this,$('#production_datum'))" />
												<c:if
													test="${pd ne null and pd.production_datum ne null and pd.production_datum ne '' }">
													<a class="btn btn-mini btn-success"
														onclick="downFile($('#production_datum'))">下载附件</a>
												</c:if>
											</div>
											<div class="form-group form-inline">
									          <!-- 上传文件 -->
												<label style="width: 15%;margin-left:10px;">上传评审资料:</label>
												 <input class="form-control" style="width: 30%" type="hidden" name="appraisal_datum" id="appraisal_datum"  
												 placeholder="这里输入附件" value="${pd.appraisal_datum}" title="附件" /> 
												 <input style="width: 30%" class="form-control" type="file" name="appraisal" id="appraisal" 
												readonly placeholder="这里输入附件" title="附件" onchange="upload(this,$('#appraisal_datum'))" />
												<c:if
													test="${pd ne null and pd.appraisal_datum ne null and pd.appraisal_datum ne '' }">
													<a class="btn btn-mini btn-success"
														onclick="downFile($('#appraisal_datum'))">下载附件</a>
												</c:if>
											</div>
										   <div class="form-group form-inline">
										         <span style="color: red;">*</span>
												 <label style="width: 15%">日期:</label>
												 <input style="width: 30%" type="text" name="signedTime"
														id="signedTime" value="${pd.signedTime}" readonly
														placeholder="这里输入日期" title="签订日期" onclick="laydate()" class="form-control" />
										   </div>
										</div>
									</div>
								</div>
							<tr>
								<td><a class="btn btn-primary"
									style="width: 150px; height: 34px; float: left;"
									onclick="save();">保存</a></td>
								<td>
							<a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('EditItem');">关闭</a>
						        </td>
							</tr>
						</div>
				</div>
			</div>
	</form>
</body>
</html>
