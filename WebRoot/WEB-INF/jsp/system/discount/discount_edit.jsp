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
    <!-- Sweet Alert -->
    <link href="static/js/sweetalert/sweetalert.css" rel="stylesheet">
	<script src="static/js/sweetalert/sweetalert.min.js"></script>
	<script type="text/javascript">
	
	//保存
	function save(){
		var elevatorIds = "";
		 $(":checkbox[name='ids']").each(function () {
			elevatorIds += $(this).val()+",";
		});
		elevatorIds = elevatorIds.substring(0,elevatorIds.length-1);
		$("#elevatorIds").val(elevatorIds);
		if($("#item_status").val()=="2"){
			var task = /^[0-9]+.?[0-9]*$/;
			if(!task.test($("#discount").val())||$("#discount").val()<0||$("#discount").val()>100){
				$("#discount").focus();
				$("#discount").tips({
					side:3,
		            msg:"请输入0-100之间的数字",
		            bg:'#AE81FF',
		            time:2
		        });
				return false;
			}
			$("#item_id").removeAttr("disabled");
			setJsonStr();
			$("#discountForm").submit();
		}else{
			/*alert("此项目不是报价状态无法申请折扣。");*/
			swal({
                title: "操作失败",
                text: "此项目不是报价状态无法申请折扣！",
                type: "error",
                showCancelButton: false,
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "OK",
                closeOnConfirm: true,
                timer:1500
            });
		}
	}
		
	function CloseSUWin(id) {
		window.parent.$("#" + id).data("kendoWindow").close();
		/* 	window.parent.location.reload(); */
	}

	function setDiscountInfo(){
		var item_id = $("#item_id").val();
		var discount = $("#discount").val();
		if(item_id!=""){
			$.post("<%=basePath%>discount/setDiscountInfo.do",
					{
						"item_id": item_id
					},
					function(data){
						var str = "";
						var jsonObj = data.discountList;
						var status = data.status;
						for(var i = 0;i<jsonObj.length;i++){
							str += "<tr";
							if(status!="2"){
								str += " style='background-color:rgb(238,238,238);' ";
							}
							str += "><td><input type='checkbox' class='i-checks' name='ids' id='"+jsonObj[i].id+"' value='"+jsonObj[i].id+"' onclick='return false'></td><td>"+jsonObj[i].id+"</td><td>"+jsonObj[i].elevator_name+"</td><td>"+jsonObj[i].num+"</td><td>"+jsonObj[i].total+"</td><td><input type='text' class='form-control' style='width:80px'></td></tr>";
						}
	        			$("#tab tr:not(:first)").remove();
						$("#tab").append(str);
						if(status=="2"){
							$("[name = zcheckbox]:checkbox").attr("checked", true);
							$("[name = ids]:checkbox").attr("checked", true);
						}
						$("#item_status").val(status);
					}
				);
		}
	}
	$(document).ready(function(){
		var iim = $("#item_id_menu").val();
		if(iim!=""){
			$("#item_id").val(iim);
			$("#item_id").attr("disabled","disabled");
			setDiscountInfo();
		}
	});

	function setJsonStr(){
		var jsonStr = "[";
		var infoId = "";
		var discount = "";
		$("#tab tr:not(:first)").each(function(){
			infoId = $(this).find("td").eq("1").html();
			discount = $(this).find("td").eq("5").find("input").eq("0").val();
			jsonStr += "{\'infoId\':\'"+infoId+"\',\'discount\':\'"+discount+"\'},";
		});
		jsonStr = jsonStr.substring(0,jsonStr.length-1)+"]";
		$("#discountJson").val(jsonStr);
	}
	

	</script>
</head>

<body class="gray-bg">
<form action="discount/${msg}.do" name="discountForm" id="discountForm" method="post">
<input type="hidden" name="id" id="id" value="${pd.id}"/>
<input type="hidden" name="item_id_menu" id="item_id_menu" value="${item_id_menu}">
<input type="hidden" name="elevatorIds" id="elevatorIds"/>
<input type="hidden" name="item_status" id="item_status"/>
<input type="hidden" name="discountJson" id="discountJson"/>
<input type="hidden" name="operateType" id="operateType" value="${operateType}"/>
    <div class="wrapper wrapper-content">
        <div class="row">
            <div class="col-sm-12">
                <!-- <div class="ibox float-e-margins"> -->
                    <div class="row">
	        			<div class="col-sm-12">
	            			<div class="panel panel-primary">
	                            <div class="panel-heading">
	                                项目信息
	                            </div>
	                			<div class="panel-body">        
	                                <div class="form-group form-inline">   
	                          			<label style="margin-left: 20px"><span><font color="red">*</font></span>选择项目:</label>
				                        <select name="item_id" id="item_id" onchange="setDiscountInfo();" class="form-control m-b" style="margin-top:16px">
				                          	<option value=''>请选择项目</option>
				                          	<c:forEach items="${itemList}" var="var">
				                          		<option value="${var.item_id}">${var.item_name}</option>
				                          	</c:forEach>
				                        </select>
	                          			<label style="margin-left: 20px"><span><font color="red">*</font></span>输入折扣(百分比):</label>
	                          			<input type="text" class="form-control" name="discount" id="discount"><label>%</label>
	                				</div>
                    			</div>
		                    </div>
		                </div>
		            </div>
            	<!-- </div> -->
            	<div class="row">
        			<div class="col-sm-12">
            			<div class="panel panel-primary">
                            <div class="panel-heading">
                                梯种列表
                            </div>
                			<div class="panel-body">    
			                    <div class="table-responsive">
				                    <table class="table table-striped table-bordered table-hover" id="tab">
				                    	<tr>
				                            <th style="width:5%;"><input type="checkbox" name="zcheckbox" id="zcheckbox" class="i-checks" onclick="return false;"></th>
				                            <th style="width:5%;">编号</th>
				                            <th style="width:10%;">种类</th>
				                            <th style="width:10%;">数量</th>
				                            <th style="width:10%;">总额</th>
				                            <th style="width:10%;">折扣(百分比)</th>
				                        </tr>
			                    	</table>
			                    </div>
	                    	</div>
	                	</div>
	            	</div>
            	</div>
            	<div class="row">
            		<div class="col-sm-12">
						<div class="panel panel-primary">
                            <div class="panel-heading">
                                描述信息
                            </div>
                			<div class="panel-body">        
                                <div class="form-group">   
			                        <label style="margin-left: 20px">描述:</label>
			                    	<textarea rows="3" cols="20" class="form-control" name="descript" id="descript"></textarea>
                				</div>
	                    	</div>
	                	</div>
	            	</div>
            	</div>
                <tr>
				<td><a class="btn btn-primary" style="width: 150px; height:34px;float:left;"  onclick="save();">保存</a></td>
				<td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('EditDiscount');">关闭</a></td>
				</tr>
				</div>
            </div>
            
        </div>
 </div>
 </form>
</body>

</html>
