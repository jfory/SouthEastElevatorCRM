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
	
	
</head>

<body class="gray-bg">
<form action="regelevStandard/${msg}.do" name="regelevStandardForm" id="regelevStandardForm" method="post">
    <input type="hidden" name="PRICE_TEMP" id="PRICE_TEMP">
	<input type="hidden" name="ID" id="ID" value="${pd.ID}" />
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
									<div class="ibox-content">
										
									</div>
							  </div>
							  
								
                                	<div class="panel panel-primary">
                                    <div class="panel-heading">
                                        	电梯标准价格详情
                                    </div>
                                    <div class="panel-body" >
                                        <div class="form-group form-inline">
											<span style="color: red">*</span>
											<label style="width: 10%">电梯速度(m/s):</label>
											<select style="width: 18%" class="form-control" id="SD" name="SD" onchange="setSbj();">
												<option value="">请选择</option>
												<option value="0.25">0.25</option>
                                                <option value="0.5">0.5</option>
                                                <option value="1.0">1.0</option>
											</select>
											&nbsp;&nbsp;&nbsp;
											<span style="color: red">*</span>
											<label style="width: 10%">电梯载重(KG):</label>
											<select style="width: 18%" class="form-control" id="ZZ" name="ZZ" onchange="setSbj()">
												<option value="">请选择</option>
                                                <option value="1000">1000</option>
                                                <option value="2000">2000</option>
                                                <option value="3000">3000</option>
												<option value="4000">4000</option>
                                                <option value="5000">5000</option>
											</select>
											&nbsp;&nbsp;&nbsp;
											<span style="color: red">*</span>
											<label style="width: 10%">层站门:</label>
                                            <select class="form-control m-b" style="width:7%" name="C" id="C" onchange="setSbj();">
                                                <option value="">请选择</option>
                                            </select>
                                            <select class="form-control m-b" style="width:7%" name="Z" id="Z" onchange="setSbj();">
                                                <option value="">请选择</option>
                                            </select>
                                            <select class="form-control m-b" style="width:7%" name="M" id="M" onchange="setMPrice();">
                                                <option value="">请选择</option>
                                            </select>
											<!-- <input style="width:6%"  type="text"  placeholder="层"  id="C" name="C" value="${pd.C }"  class="form-control" onchange="setSbj();">
											<input style="width:6%"  type="text"  placeholder="站"  id="Z" name="Z" value="${pd.Z }"  class="form-control">
											<input style="width:6%"  type="text"  placeholder="门"  id="M" name="M" value="${pd.M }"  class="form-control" onkeyup="setMPrice()"> -->
                                    	</div>
                                        
                                        <div class="form-group form-inline">
                                        	<span style="color: red">*</span>
											<label style="width:10%" >名称:</label>
                                    		<input style="width:18%"  type="text"  placeholder="名称"  id="NAME" name="NAME" value="${pd.NAME }"  class="form-control">
                                    		&nbsp;&nbsp;&nbsp;
                                    		<label style="width:11%;margin-top: 25px;margin-bottom: 10px"><font color="red">*</font>开门形式</label>
                                            <select style="width: 20%;margin-top: 10px" class="form-control m-b" id="KMXS" name="KMXS">
                                                <option value="中分双折">中分双折</option>
                                                <option value="旁开">旁开</option>
                                            </select>
                                            <label style="width:11%;margin-top: 25px;margin-bottom: 10px"><font color="red">*</font>开门宽度:</label>
                                            <select style="width: 20%;margin-top: 10px" class="form-control m-b" id="KMKD" name="KMKD" onchange="setMPrice();">
                                                <option value="1400">1400</option>
                                                <option value="1500">1500</option>
                                                <option value="1700">1700</option>
                                                <option value="2000">2000</option>
                                                <option value="2200">2200</option>
                                            </select>
                                        </div>
                                        <div class="form-group form-inline">
                                        	<span style="color: red">*</span>
                                   			<label style="width:10%">电梯标准金额:</label>
                                       		<input style="width:18%" type="text" placeholder="这里输入电梯标准金额"  id="PRICE" name="PRICE" value="${pd.PRICE }" class="form-control">
                                        </div>
                                   </div>
                                </div>
                            </div>
                        </div>
                    </div>
						<div style="height: 20px;"></div>
						<tr>
						<td><a class="btn btn-primary"style="width: 150px; height:34px;float:left;"  onclick="save();">保存</a></td>
                        <c:if test="${msg eq 'addRegelevStandard'}">
                            <td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('AddRegelevStandard');">关闭</a></td>
                        </c:if>
                        <c:if test="${msg eq 'editRegelevStandard'}">
                            <td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('EditRegelevStandard');">关闭</a></td>
                        </c:if>
						</tr>
					</div>
            </div>
            
        </div>
 </div>
 </form> 
 
</body>
	<script type="text/javascript">

	//计算基础价
    function setSbj(){
        var sd_ = $("#SD").val();  //速度
        var c_ = $("#C").val();     //层站
        var zz_ = $("#ZZ").val();  //载重
        var price = 0;
        if(sd_=="0.5"){
            if(zz_=="1000"){
                if(c_=="2"){
                    price = 120700;
                }else if(c_=="3"){
                    price = 127500;
                }else if(c_=="4"){
                    price = 136000;
                }else if(c_=="5"){
                    price = 143500;
                }else if(c_=="6"){
                    price = 150200;
                }else if(c_=="7"){
                    price = 156700;
                }else if(c_=="8"){
                    price = 165300;
                }
            }else if(zz_=="2000"){
                if(c_=="2"){
                    price = 134200;
                }else if(c_=="3"){
                    price = 141800;
                }else if(c_=="4"){
                    price = 150400;
                }else if(c_=="5"){
                    price = 158900;
                }else if(c_=="6"){
                    price = 166400;
                }else if(c_=="7"){
                    price = 175800;
                }else if(c_=="8"){
                    price = 185300;
                }
            }else if(zz_=="3000"){
                if(c_=="2"){
                    price = 179600;
                }else if(c_=="3"){
                    price = 190000;
                }else if(c_=="4"){
                    price = 201500;
                }else if(c_=="5"){
                    price = 211800;
                }else if(c_=="6"){
                    price = 222200;
                }else if(c_=="7"){
                    price = 233500;
                }else if(c_=="8"){
                    price = 244900;
                }
            }else if(zz_=="4000"){
                if(c_=="2"){
                    price = 252400;
                }else if(c_=="3"){
                    price = 266500;
                }else if(c_=="4"){
                    price = 279800;
                }else if(c_=="5"){
                    price = 294900;
                }else if(c_=="6"){
                    price = 310200;
                }else if(c_=="7"){
                    price = 324400;
                }else if(c_=="8"){
                    price = 339500;
                }
            }else if(zz_=="5000"){
                if(c_=="2"){
                    price = 269500;
                }else if(c_=="3"){
                    price = 283600;
                }else if(c_=="4"){
                    price = 298700;
                }else if(c_=="5"){
                    price = 313800;
                }else if(c_=="6"){
                    price = 328000;
                }else if(c_=="7"){
                    price = 342200;
                }else if(c_=="8"){
                    price = 356400;
                }
            }
        }else if(sd_=="0.25"){  //速度=1.75m/s
            if(zz_=="4000"){
                if(c_=="2"){
                    price = 242900;
                }else if(c_=="3"){
                    price = 257100;
                }else if(c_=="4"){
                    price = 271300;
                }
            }else if(zz_=="5000"){
                if(c_=="2"){
                    price = 260900;
                }else if(c_=="3"){
                    price = 275100;
                }else if(c_=="4"){
                    price = 289300;
                }
            }
        }else if(sd_=="1.0"){
            if(zz_=="1000"){
                if(c_=="2"){
                    price =  123700;
                }else if(c_=="3"){
                    price =  131400;
                }else if(c_=="4"){
                    price =  137900;
                }else if(c_=="5"){
                    price =  145500;
                }else if(c_=="6"){
                    price =  153000;
                }else if(c_=="7"){
                    price =  160600;
                }else if(c_=="8"){
                    price =  167200;
                }else if(c_=="9"){
                    price =  174800;
                }else if(c_=="10"){
                    price =  181400;
                }else if(c_=="11"){
                    price =  189000;
                }else if(c_=="12"){
                    price =  196600;
                }else if(c_=="13"){
                    price =  203200;
                }else if(c_=="14"){
                    price =  210800;
                }else if(c_=="15"){
                    price =  218300;
                }
            }else if(zz_=="2000"){
                if(c_=="2"){
                    price =  170200;
                }else if(c_=="3"){
                    price =  178700;
                }else if(c_=="4"){
                    price =  186200;
                }else if(c_=="5"){
                    price =  193800;
                }else if(c_=="6"){
                    price =  202400;
                }else if(c_=="7"){
                    price =  210900;
                }else if(c_=="8"){
                    price =  218400;
                }else if(c_=="9"){
                    price =  226900;
                }else if(c_=="10"){
                    price =  235500;
                }else if(c_=="11"){
                    price =  244000;
                }else if(c_=="12"){
                    price =  251500;
                }else if(c_=="13"){
                    price =  260000;
                }else if(c_=="14"){
                    price =  267600;
                }else if(c_=="15"){
                    price =  276000;
                }
            }else if(zz_=="3000"){
                if(c_=="2"){
                    price =  224000;
                }else if(c_=="3"){
                    price =  235500;
                }else if(c_=="4"){
                    price =  246700;
                }else if(c_=="5"){
                    price =  257100;
                }else if(c_=="6"){
                    price =  267600;
                }else if(c_=="7"){
                    price =  278000;
                }else if(c_=="8"){
                    price =  289300;
                }else if(c_=="9"){
                    price =  300700;
                }else if(c_=="10"){
                    price =  311100;
                }else if(c_=="11"){
                    price =  322400;
                }else if(c_=="12"){
                    price =  333800;
                }else if(c_=="13"){
                    price =  344200;
                }else if(c_=="14"){
                    price =  354500;
                }else if(c_=="15"){
                    price =  365800;
                }
            }
        }
        $("#PRICE_TEMP").val(price);
        $("#PRICE").val(price);
    }


    //修改门数量时修改标准价格
    function setMPrice(){
        var m_ = parseInt($("#M").val());
        var c_ = parseInt($("#C").val());
        var price = parseInt($("#PRICE_TEMP").val());
        var kmkd_ = parseInt($("#KMKD").val());
        if(!isNaN(m_)&&!isNaN(c_)&&!isNaN(price)){
            var jm = c_-m_;
            if(jm>0){
                if(kmkd_=="1400"||kmkd_=="1500"){
                    price = price-4300*jm;
                }else if(kmkd_=="1700"){
                    price = price-5100*jm;
                }else if(kmkd_=="2000"){
                    price = price-5800*jm;
                }else if(kmkd_=="2200"){
                    price = price-6600*jm;
                }
            }
            $("#PRICE").val(price);
        }
    }



        //保存
        function save(){
            if($("#SD").val()==""){
                $("#SD").focus();
                $("#SD").tips({
                    side:3,
                    msg:'请选择电梯速度',
                    bg:'#AE81FF',
                    time:2
                });
                return false;
            }
            if($("#ZZ").val()==""){
                $("#ZZ").focus();
                $("#ZZ").tips({
                    side:3,
                    msg:'请选择电梯重量',
                    bg:'#AE81FF',
                    time:2
                });
                return false;
            }
            
            if($("#C").val()==""){
                $("#C").focus();
                $("#C").tips({
                    side:3,
                    msg:'请填写电梯层',
                    bg:'#AE81FF',
                    time:2
                });
                return false;
            }
            if($("#Z").val()==""){
                $("#Z").focus();
                $("#Z").tips({
                    side:3,
                    msg:'请填写电梯站',
                    bg:'#AE81FF',
                    time:2
                });
                return false;
            }
            if($("#M").val()==""){
                $("#M").focus();
                $("#M").tips({
                    side:3,
                    msg:'请填写电梯门',
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
            $("#regelevStandardForm").submit();
        }
        
        
        function CloseSUWin(id) {
            window.parent.$("#" + id).data("kendoWindow").close();
        }
    
	</script>
</html>
