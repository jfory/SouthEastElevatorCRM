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
	<!-- Sweet Alert -->
	<link href="static/js/sweetalert2/sweetalert2.css" rel="stylesheet"> 
	<!-- 日期控件-->
<script src="static/js/layer/laydate/laydate.js"></script>
	<!-- Sweet alert -->
	<script src="static/js/sweetalert2/sweetalert2.js"></script>
	
</head>

<body class="gray-bg">
<form action="basicPrice/${msg}.do" name="regelevStandardForm" id="regelevStandardForm" method="post">
    <input type="hidden" name="PRICE_TEMP" id="PRICE_TEMP">
	<input type="hidden" name="ID" id="ID" value="${pd.ID}" />
	<input type="hidden" name="MODELS" id="MODELS" value="${pd.MODELS}" />
	<%--用户ID--%>
	<input type="hidden" name="requester_id" id="requester_id" value="${userpds.USER_ID}"/>
	
    <div class="wrapper wrapper-content">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-content">
                        <div class="row">
                            <div class="col-sm-12">
                               <div class="ibox float-e-margins" id="menuContent" class="menuContent" style="display:none; position: absolute;z-index: 99;border: solid 1px #18a689;max-height:300px;overflow-y:scroll;overflow-x:auto">
									
							  </div>
                                <div class="panel panel-primary">
                                    <div class="panel-heading">
                                        	电梯标准价格详情
                                    </div>
                                    <div class="panel-body" >
                                        <div class="form-group form-inline">
											<span style="color: red">*</span>
											<label style="width: 10%">电梯速度(m/s):</label>
											<input style="width:18%"  type="text"  placeholder="电梯速度"  id="SD" name="SD" value="${pd.SD }"  class="form-control">
											
											<span style="color: red;margin-left: 1%">*</span>
											<label style="width: 10%">电梯载重(KG):</label>
											<input style="width:18%"  type="text"  placeholder="载重"  id="ZZ" name="ZZ" value="${pd.ZZ }" class="form-control">
											
											<span style="color: red;margin-left: 1%">*</span>
											<label style="width: 10%">层站门:</label>
                                            <input style="width:7%"  type="text"  placeholder="层"  id="C" name="C" value="${pd.C }"  class="form-control">
                                            <input style="width:7%"  type="text"  placeholder="站"  id="Z" name="Z" value="${pd.Z }"  class="form-control">
                                            <input style="width:7%"  type="text"  placeholder="门"  id="M" name="M" value="${pd.M }"  class="form-control">
											
                                    	</div>
                                        
                                        <div class="form-group form-inline">
                                        	<span style="color: red">*</span>
											<label style="width:10%" >标准提升高度:</label>
                                    		<input style="width:18%"  type="text"  placeholder="提升高度"  id="TSGD" name="TSGD" value="${pd.TSGD }"  class="form-control">
                                    		
                                    		<span style="color: red;margin-left: 1%">*</span>
											<label style="width:10%" >超出高度:</label>
                                    		<input style="width:18%"  type="text"  placeholder="超出高度"  id="EWAI" name="EWAI" value="${pd.EWAI }"  class="form-control">
                                    		
                                            <span style="color: red;margin-left: 1%">*</span>
											<label style="width:10%" >加价:</label>
                                    		<input style="width:18%"  type="text"  placeholder="加价"  id="JJ" name="JJ" value="${pd.JJ }"  class="form-control">
                                        </div>
                                        
                                        <div class="form-group form-inline">
                                        	<span style="color: red">*</span>
                                   			<label style="width:10%">标准底坑深(m):</label>
                                       		<input style="width:18%" type="text" name="BZDKS" id="BZDKS" value="${pd.BZDKS}"  
			                                 placeholder="请输入标准底坑深(m)" title="标准底坑深(m)" class="form-control">
                                       		
                                       		<span style="color: red;margin-left: 1%">*</span>
											<label style="width:10%" >标准顶层高(m):</label>
                                    		<input style="width:18%"  type="text"  placeholder="标准顶层高(m)"  id="BZDCG" name="BZDCG" 
                                    		value="${pd.BZDCG}"  class="form-control">
                                    		
                                    		<span style="color: red;margin-left: 1%">*</span>
											<label style="width:10%" >标准井道高(m):</label>
                                    		<input style="width:18%"  type="text"  placeholder="标准井道高(m)"  id="BZJDG" name="BZJDG" 
                                    		value="${pd.BZJDG}"  class="form-control">
                                       		
                                        </div>
                                        
                                        <div class="form-group form-inline">
                                       		<span style="color: red;">*</span>
                                   			<label style="width:10%">生效日期:</label>
                                       		<input style="width:18%" type="text" name="KS_TIME" id="KS_TIME" value="${pd.KS_TIME}"  
			                                 placeholder="请输入生效日期" title="生效日期" class="form-control" onclick="laydate()" autocomplete="off">
                                       		
                                       		<span style="color: red;margin-left: 1%">*</span>
                                   			<label style="width:10%">失效日期:</label>
                                       		<input style="width:18%" type="text" name="END_TIME" id="END_TIME" value="${pd.END_TIME}"  
			                                 placeholder="请输入失效日期" title="失效日期" class="form-control" onclick="laydate()" autocomplete="off">
                                        </div>
                                        
                                        <div class="form-group form-inline">
                                        	<span style="color: red">*</span>
                                   			<label style="width:10%">电梯标准金额:</label>
                                       		<input style="width:18%" type="text" name="PRICE" id="PRICE" value="${pd.PRICE}"  
			                                 placeholder="请输入电梯标准金额" title="电梯标准金额" class="form-control">
                                       		
                                       		<span style="color: red;margin-left: 1%">*</span>
											<label style="width:10%" >名称:</label>
                                    		<input style="width:18%"  type="text"  placeholder="名称"  id="NAME" name="NAME" value="${pd.NAME }"  class="form-control">
                                       		
                                        </div>
                                        
                                   </div>
                                </div>
                            </div>
                        </div>
                    </div>
						<div style="height: 20px;"></div>
						<tr>
						<td><a class="btn btn-primary"style="width: 150px; height:34px;float:left;"  onclick="save();">保存</a></td>
                        <td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('AddRegelevStandard');">关闭</a></td>
						</tr>
					</div>
            </div>
            
        </div>
 </div>
 </form> 
 
</body>
	<script type="text/javascript">
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

    
	//保存
	function save(){
		if($("#SD").val()==""){
			$("#SD").focus();
			$("#SD").tips({
				side:3,
	            msg:'请输入电梯速度',
	            bg:'#AE81FF',
	            time:2
	        });
			return false;
		}
		if($("#ZZ").val()==""){
			$("#ZZ").focus();
			$("#ZZ").tips({
				side:3,
	            msg:'请输入电梯重量',
	            bg:'#AE81FF',
	            time:2
	        });
			return false;
		}
		
		if($("#C").val()==""){
			$("#C").focus();
			$("#C").tips({
				side:3,
	            msg:'请输入电梯层',
	            bg:'#AE81FF',
	            time:2
	        });
			return false;
		}
		if($("#Z").val()==""){
			$("#Z").focus();
			$("#Z").tips({
				side:3,
	            msg:'请输入电梯站',
	            bg:'#AE81FF',
	            time:2
	        });
			return false;
		}
		if($("#M").val()==""){
			$("#M").focus();
			$("#M").tips({
				side:3,
	            msg:'请输入电梯门',
	            bg:'#AE81FF',
	            time:2
	        });
			return false;
		}
		
		if($("#TSGD").val()==""){
			$("#TSGD").focus();
			$("#TSGD").tips({
				side:3,
	            msg:'请输入标准提升高度',
	            bg:'#AE81FF',
	            time:2
	        });
			return false;
		}
		
		if($("#EWAI").val()==""){
			$("#EWAI").focus();
			$("#EWAI").tips({
				side:3,
	            msg:'请输入超出高度',
	            bg:'#AE81FF',
	            time:2
	        });
			return false;
		}
		
		if($("#JJ").val()==""){
			$("#JJ").focus();
			$("#JJ").tips({
				side:3,
	            msg:'请输入加价',
	            bg:'#AE81FF',
	            time:2
	        });
			return false;
		}
		
		if($("#BZDKS").val()==""){
			$("#BZDKS").focus();
			$("#BZDKS").tips({
				side:3,
	            msg:'请输入标准地坑深（m）',
	            bg:'#AE81FF',
	            time:2
	        });
			return false;
		}
		
		if($("#BZDCG").val()==""){
			$("#BZDCG").focus();
			$("#BZDCG").tips({
				side:3,
	            msg:'请输入标准顶层高（m）',
	            bg:'#AE81FF',
	            time:2
	        });
			return false;
		}
		
		if($("#BZJDG").val()==""){
			$("#BZJDG").focus();
			$("#BZJDG").tips({
				side:3,
	            msg:'请输入标准井道高（m）',
	            bg:'#AE81FF',
	            time:2
	        });
			return false;
		}
		
		if($("#KS_TIME").val()==""){
			$("#KS_TIME").focus();
			$("#KS_TIME").tips({
				side:3,
	            msg:'请选择生效日期',
	            bg:'#AE81FF',
	            time:2
	        });
			return false;
		}
		
		if($("#END_TIME").val()==""){
			$("#END_TIME").focus();
			$("#END_TIME").tips({
				side:3,
	            msg:'请选择失效日期',
	            bg:'#AE81FF',
	            time:2
	        });
			return false;
		}
		
		if($("#PRICE").val()==""){
			$("#PRICE").focus();
			$("#PRICE").tips({
				side:3,
	            msg:'请输入标准金额',
	            bg:'#AE81FF',
	            time:2
	        });
			return false;
		}
		
		if($("#NAME").val()==""){
			$("#NAME").focus();
			$("#NAME").tips({
				side:3,
	            msg:'请填写名称',
	            bg:'#AE81FF',
	            time:2
	        });
			return false;
		}
		
		var sd = $("#SD").val();
		var zz_ = $("#ZZ").val();
		var c_ = $("#C").val();
		var models_name = $("#NAME").val();
		if(sd != "${pd.SD}"
				|| zz_ != "${pd.ZZ}"
				|| c_ != "${pd.C}"
				|| models_name != "${pd.NAME}"){
			
			var index = layer.load(1);
			$.post("<%=basePath%>basicPrice/isExistBascPrice",{
	            "SD": sd,
	            "ZZ": zz_,
	            "C": c_,
	            "NAME": models_name
	        }, function (result) {
	        	layer.close(index);
	       	 if (result.code == 1) {
	                if(result.exist == 0){
	                	$("#regelevStandardForm").submit();
	                } else {
		               	swal({
			                title: "数据已存在！",
			                text: '名称为：'+models_name+'，速度为：'+sd+'，载重为：'+zz_+'，层为：'+c_+' 的数据已存在！',
			                type: "info",
			                showCancelButton: false,
			                confirmButtonColor: "#DD6B55",
			                confirmButtonText: "OK",
			                closeOnConfirm: true,
			            });
	                }
	            } else {
				    layer.msg('操作失败', {icon: 2});
	            }
	        });
			
		}else {
			$("#regelevStandardForm").submit();
		}
		
	}
	
	
	function CloseSUWin(id) {
		window.parent.$("#" + id).data("kendoWindow").close();
	}
	</script>
</html>
