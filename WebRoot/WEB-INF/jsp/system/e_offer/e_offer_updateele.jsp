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
<div>
	<div id="TempaddOffer" class="animated fadeIn"></div>
	<!-- 页面内容开始 -->
	<div class="form-group form-inline" style="text-align: right;">		
		<button class="btn btn-primary btn-sm" style="width: 15%; margin-left: 20px; height:31px"
		 title="保存" type="button" onclick="Save();">保存</button>
		<button class="btn btn-danger btn-sm" style="width: 15%; margin-left: 8px; height:31px"
		 title="取消" type="button" onclick="Cancel();">取消</button>
	</div>
	<form action="e_offer/updateOfferEleNum.do" name="e_offerUpdaeEleForm" id="e_offerUpdaeEleForm" method="post">
	    <div class="wrapper wrapper-content">
		    <input type="hidden" name="type" id="type" value="" />
		    <input type="hidden" name="modelsId" id="modelsId" value="${pd.modelsId}" />
		    <input type="hidden" name="modelsNum" id="modelsNum" value="${pd.modelsNum}" />
		    <input type="hidden" name="ele_flag" id="ele_flag" value="${pd.flag}" /> 
		    <input type="hidden" name="elevator_id" id="elevator_id" value="${pd.elevator_id}" /> 
		    <input type="hidden" name="modelsName" id="modelsName" value="${pd.modelsName}" /> 
		    <input type="hidden" name="jsonStr" id="jsonStr">
		    <input type="hidden" name="item_id" id="item_id" value="${pd.item_id}" />
			<input type="hidden" name="offer_version" id="offer_version" value="${pd.offer_version}" >
			<input type="hidden" name="BJCmodelsCount" id="BJCmodelsCount" value="${pd.BJCmodelsCount}" >
			<input type="hidden" name="offer_no" id="offer_no" value="${pd.offer_no}" >
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
		                                    	<td>电梯名</td>
												<td>项目台数</td>
												<td>修改为</td>
		                                    </tr>
		                                </thead>
											<tr>
												<td>${pd.modelsName}</td>
												<td>${pd.modelsNum}</td>
												<td><input id="modifyEleNumInput" name="modifyEleNumInput" placeholder="在此输入要修改数量"></td>
											</tr>
		                            </table>
									</div>
		                        </div>
		                    </div>
		                </div>
	 	</div>
	 </div>
	 </form>
 
</div>
	<script type="text/javascript">
	 $(document).ready(function () {
		 //loading end
// 		 parent.layer.closeAll('loading');
		
     });

	//修改
	function Save(){
		
		if ($("#modifyEleNumInput").val() == "" ) {
			$("#modifyEleNumInput").focus();
			$("#modifyEleNumInput").tips({
				side : 3,
				msg : "请填写该梯形电梯数量",
				bg : '#AE81FF',
				time : 3
			});
			return false;
		}
		
		if(isNaN(Number($("#modifyEleNumInput").val()))){  //当输入不是数字的时候，Number后返回的值是NaN;然后用isNaN判断。
            alert("只能输入数字");
			return false;
        }
		
		var modifyNum = $("#modifyEleNumInput").val()==""?0:parseInt($("#modifyEleNumInput").val());
		var bjcmodlscount = $("#BJCmodelsCount").val();
		var modelsNum = $("#modelsNum").val();
		if (modifyNum==modelsNum) {
			alert("修改台数与项目台数一样");
			return false;
		}
		if (modifyNum<bjcmodlscount) {
			alert("该梯形已在报价池报价,修改数量不能小于报价池该梯形报价数量");
			return false;
		}
		parent.layer.load(1);
		$.ajax({
          //几个参数需要注意一下
              type: "POST",//方法类型
              dataType: "HTML",//预期服务器返回的数据类型
              url: "<%=basePath%>e_offer/updateOfferEleNum.do" ,//url
              data: $('#e_offerUpdaeEleForm').serialize(),
              success: function (result) {
                  if ("success" == result) {
                      CloseSUWin("GoupdateOfferEleNum");
                  }else{
                	  alert("修改失败");
                  }
                  ;
              }

          });
		//CloseSUWin("GoupdateOfferEleNum");
	}
	
	function Cancel(){
// 		window.parent.$("#" + id).data("kendoWindow").close();
		window.parent.$("#GoupdateOfferEleNum").data("kendoWindow").close();
	}
	

	function CloseSUWin(id) {
		
		var offer_no = $("#offer_no").val();
		var url = "<%=basePath%>e_offer/editEoffer.do?offer_no="+offer_no+"&b="+1;
		var params = offer_no;
// 		window.parent.location.reload();
// 		window.location.href = url;
// 		window.location.replace(url);  
// 		$.post(url,params,function(data){
// 		    alert("修改成功");
// 		});
		var ff = window.parent.parent.$("#addOffer");
		//window.parent.parent.$("#addOffer").data("kendoWindow").close();
		ff.kendoWindow({
            width: "800px",
            height: "700px",
            title: "编辑报价",
            actions: ["Close"],
            content: '<%=basePath%>e_offer/editEoffer.do?offer_no='+offer_no,
            modal: true,
            visible: false,
            resizable: true
        }).data("kendoWindow").maximize().open();



		
		window.parent.$("#GoupdateOfferEleNum").data("kendoWindow").close();
// 		window.parent.parent.$("#addOffer").data("kendoWindow").close();
	}
	</script>
</body>

</html>
