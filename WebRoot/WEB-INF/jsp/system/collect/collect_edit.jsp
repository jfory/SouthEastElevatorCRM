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
	<script type="text/javascript">
	
	$(document).ready(function(){
		parent.layer.closeAll('loading');

		//setItemOption();

		$("div[name='divs']").each(function(){
			$(this).hide();
		});
		var contractType = $("#contract_type").val();
		if(contractType == 1){//安装合同
			$("#installDiv").show();
			$("#acceptDiv").show();
		}else if(contractType == 2){//销售合同
			$("#contractDiv").show();
			$("#productDiv").show();
			$("#shipmentDiv").show();
			$("#qualityDiv").show();
		}else if(contractType == 3){//安装销售合同
			$("div[name='divs']").each(function(){
				$(this).show();
			});
		}
	});

	//获取项目信息下拉列表
	/*function setItemOption(){
		$.post("<%=basePath%>collect/findItemOption.do",
			function(data){
				var item_id = $("#itemId").val();
				var itemStr;
				var itemObj = data.itemList;
				for(var i=0;i<itemObj.length;i++){
					itemStr += "<option value='"+itemObj[i].item_id+"'>"+itemObj[i].item_name+"</option>";
				}
				$("#item_id").append(itemStr);
				$("#item_id").val(item_id);
			}
		);
	}*/

	//选择电梯并录入对应款项
	function setElevator(stage){
		var item_id = $("#item_id").val();
		var operateType = $("#operateType").val();
		$("#Elevator").kendoWindow({
		        width: "1000px",
		        height: "600px",
		        title: "电梯",
		        actions: ["Close"],
		        content: '<%=basePath%>collect/setElevator.do?stage='+stage+'&item_id='+item_id+"&operateType="+operateType,
		        modal : true,
				visible : false,
				resizable : true
		}).data("kendoWindow").maximize().open();
	}

	//登记款项
	function setInfo(stage,flag){
		var item_id = $("#item_id").val();
		$("#SetInfo").kendoWindow({
		        width: "1000px",
		        height: "600px",
		        title: "登记",
		        actions: ["Close"],
		        content: '<%=basePath%>collect/setInfo.do?stage='+stage+'&item_id='+item_id+"&flag="+flag,
		        modal : true,
				visible : false,
				resizable : true
		}).data("kendoWindow").maximize().open();
	}

	//计算总额
	function setTotal(){
		var contract = parseInt($("#contract").val()==""?0:$("#contract").val());
		var product = parseInt($("#product").val()==""?0:$("#product").val());
		var shipment = parseInt($("#shipment").val()==""?0:$("#shipment").val());
		var install = parseInt($("#install").val()==""?0:$("#install").val());
		var arrival = parseInt($("#arrival").val()==""?0:$("#arrival").val());
		var adjust = parseInt($("#adjust").val()==""?0:$("#adjust").val());
		var accept = parseInt($("#accept").val()==""?0:$("#accept").val());
		var remit = parseInt($("#remit").val()==""?0:$("#remit").val());
		var quality = parseInt($("#quality").val()==""?0:$("#quality").val());
		var total = contract+product+shipment+install+arrival+adjust+accept+remit+quality;
		$("#total").val(total);
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
<div id="Elevator" class="animated fadeIn"></div>
<div id="SetInfo" class="animated fadeIn"></div>
<form action="collect/${msg}.do" name="collectForm" id="collectForm" method="post">
	<input type="hidden" name="contract_type" id="contract_type" value=${contract_type}>
	<input type="hidden" name="id" id="id" value=${pd.id}"">
	<input type="hidden" name="itemId" id="itemId" value="${pd.item_id}">
	<input type="hidden" name="operateType" id="operateType" value="${operateType}">
    <div class="wrapper wrapper-content" style="z-index: -1">
        <div class="row">
            <div class="col-sm-12" >
                <div class="ibox float-e-margins">
                    <div class="ibox-content">
                		<div class="row">
                			<div class="col-sm-12">
                    			<div class="panel panel-primary">
                                    <div class="panel-heading">
                                        项目信息
                                    </div>
                        			<div class="panel-body">
	                                    <div class="form-group form-inline">
	                                        <label style="width:10%;">选择项目:</label>
	                                        <select name="item_id" id="item_id" class="form-control m-b">
	                                        	<option value=''>请选择项目</option>
	                                        	<c:forEach items="${itemList}" var="var">
	                                        		<option value="${var.item}"></option>
	                                        	</c:forEach>
	                                        </select>
	                                    </div>
	                    			</div>
	                    		</div>
	                    	</div>
	                    </div>
	                    <div class="row" name="divs" id="contractDiv">
                			<div class="col-sm-12">
                    			<div class="panel panel-primary">
                                    <div class="panel-heading">
                                        应收款
                                    </div>
                        			<div class="panel-body">
	                                    <div class="form-group form-inline">
	                                        <label style="width:10%;">合同定金:</label>
	                                        <input type="text" name="contract" id="contract" value="${pd.contract}" class="form-control"/>
	                                        <!-- <input type="button" value="登记" onclick="setInfo('contract','1');"> -->
	                                    </div>
	                    			</div>
	                    		</div>
	                    	</div>
	                    </div>
	                    <div class="row" name="divs" id="productDiv">
                			<div class="col-sm-12">
                    			<div class="panel panel-primary">
                                    <div class="panel-heading">
                                        排产款
                                    </div>
                        			<div class="panel-body">
                        				<div class="form-group form-inline">
	                                        <label style="width:10%;">排产款:</label>
	                                        <input type="text" name="product" id="product" value="${pd.product}" class="form-control"/>
	                                        <input type="hidden" name="product_data" id="product_data" value="${pds.product_data}">
	                                        <button class="btn btn-sm btn-info btn-sm" title="选择电梯" type="button" onclick="setElevator('product')">选择电梯</button>
	                                    </div>
	                    			</div>
	                    		</div>
	                    	</div>
	                    </div>
	                    <div class="row" name="divs" id="shipmentDiv">
							<div class="col-sm-12">
								<div class="panel panel-primary">
						            <div class="panel-heading">
						                发货款
						            </div>
                        			<div class="panel-body">
	                                    <div class="form-group form-inline">
	                                        <label style="width:10%;">发货款:</label>
	                                        <input type="text" name="shipment" id="shipment" value="${pd.shipment}" class="form-control" readonly="readonly"/>
	                                        <input type="hidden" name="shipment_data" id="shipment_data" value="${pds.shipment_data}">
	                                        <button class="btn btn-sm btn-info btn-sm" title="选择电梯" type="button" onclick="setElevator('shipment')">选择电梯</button>
	                                    </div>
	                    			</div>
						    	</div>
							</div>
						</div>
						 <div class="row" name="divs" id="installDiv">
							<div class="col-sm-12">
								<div class="panel panel-primary">
						            <div class="panel-heading">
						                安装开工款
						            </div>
                        			<div class="panel-body">
	                                    <div class="form-group form-inline">
	                                        <label style="width:10%;">安装开工款:</label>
	                                        <input type="text" name="install" id="install" value="${pd.install}" class="form-control" readonly="readonly"/>
	                                        <input type="hidden" name="install_data" id="install_data" value="${pds.install_data}">
	                                        <button class="btn btn-sm btn-info btn-sm" title="选择电梯" type="button" onclick="setElevator('install')">选择电梯</button>
	                                    </div>
	                    			</div>
						    	</div>
							</div>
						</div>
						 <div class="row" name="divs" id="arrivalDiv">
							<div class="col-sm-12">
								<div class="panel panel-primary">
						            <div class="panel-heading">
						                货到工地款
						            </div>
                        			<div class="panel-body">
	                                    <div class="form-group form-inline">
	                                        <label style="width:10%;">货到工地款:</label>
	                                        <input type="text" name="arrival" id="arrival" value="${pd.arrival}" class="form-control"/>
	                                    </div>
	                    			</div>
						    	</div>
							</div>
						</div>
						 <div class="row" name="divs" id="adjustDiv">
							<div class="col-sm-12">
								<div class="panel panel-primary">
						            <div class="panel-heading">
						                调试款
						            </div>
                        			<div class="panel-body">
	                                    <div class="form-group form-inline">
	                                        <label style="width:10%;">调试款:</label>
	                                        <input type="text" name="adjust" id="adjust" value="${pd.adjust}" class="form-control" readonly="readonly"/>
	                                        <input type="hidden" name="adjust_data" id="adjust_data" value="${pds.adjust_data}">
	                                        <button class="btn btn-sm btn-info btn-sm" title="选择电梯" type="button" onclick="setElevator('adjust')">选择电梯</button>
	                                    </div>
	                    			</div>
						    	</div>
							</div>
						</div>
						 <div class="row" name="divs" id="acceptDiv">
							<div class="col-sm-12">
								<div class="panel panel-primary">
						            <div class="panel-heading">
						                安装验后款
						            </div>
                        			<div class="panel-body">
	                                    <div class="form-group form-inline">
	                                        <label style="width:10%;">安装验后款:</label>
	                                        <input type="text" name="accept" id="accept" value="${pd.accept}" class="form-control" readonly="readonly"/>
	                                        <input type="hidden" name="accept_data" id="accept_data" value="${pds.accept_data}">
	                                        <button class="btn btn-sm btn-info btn-sm" title="选择电梯" type="button" onclick="setElevator('accept')">选择电梯</button>
	                                    </div>
	                    			</div>
						    	</div>
							</div>
						</div>
						 <div class="row" name="divs" id="remitDiv">
							<div class="col-sm-12">
								<div class="panel panel-primary">
						            <div class="panel-heading">
						                设备验后款
						            </div>
                        			<div class="panel-body">
	                                    <div class="form-group form-inline">
	                                        <label style="width:10%;">设备验后款:</label>
	                                        <input type="text" name="remit" id="remit" value="${pd.remit}" class="form-control" readonly="readonly"/>
	                                        <input type="hidden" name="remit_data" id="remit_data" value="${pds.remit_data}">
	                                        <button class="btn btn-sm btn-info btn-sm" title="选择电梯" type="button" onclick="setElevator('remit')">选择电梯</button>
	                                    </div>
	                    			</div>
						    	</div>
							</div>
						</div>
						 <div class="row" name="divs" id="qualityDiv">
							<div class="col-sm-12">
								<div class="panel panel-primary">
						            <div class="panel-heading">
						                质保金
						            </div>
                        			<div class="panel-body">
	                                    <div class="form-group form-inline">
	                                        <label style="width:10%;">质保金:</label>
	                                        <input type="text" name="quality" id="quality" value="${pd.quality}" class="form-control" readonly="readonly"/>
	                                        <input type="hidden" name="quality_data" id="quality_data" value="${pds.quality_data}">
	                                        <button class="btn btn-sm btn-info btn-sm" title="选择电梯" type="button" onclick="setElevator('quality')">选择电梯</button>
	                                    </div>
	                    			</div>
						    	</div>
							</div>
						</div>
                		<div class="row">
                			<div class="col-sm-12">
                    			<div class="panel panel-primary">
                                    <div class="panel-heading">
                                        总计
                                    </div>
                        			<div class="panel-body">
	                                    <div class="form-group form-inline">
	                                        <label style="width:10%;">总额:</label>
	                                        <input type="text" name="total" id="total" value="${pd.total}" class="form-control"/>
	                                        <button class="btn btn-sm btn-success btn-sm" title="计算总额" type="button" onclick="setTotal()">计算总额</button>
	                                    </div>
	                    			</div>
	                    		</div>
	                    	</div>
	                    </div>
	                    <div class="ibox-content">
						<div style="height: 20px;"></div>
						<tr>
						<td>
							<a class="btn btn-primary" style="width: 150px; height:34px;float:left;"  onclick="save();">保存</a>
						</td>
						<td>
							<a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('EditCollect');">关闭</a>
						</td>
						</tr>
					</div>
				</div>
			</div>
		</div>   
 </div>
 </form>
<!-- Sweet alert -->
<script src="static/js/sweetalert/sweetalert.min.js"></script>
<script type="text/javascript">




	//保存
	function save(){
		$("#collectForm").submit();
	}

	//关闭
	function CloseSUWin(id) {
		window.parent.$("#" + id).data("kendoWindow").close();
		/* 	window.parent.location.reload(); */
	}
</script>
</body>

</html>
