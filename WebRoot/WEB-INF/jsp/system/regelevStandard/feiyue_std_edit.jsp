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
												<option value="1.0">1.0</option>
                                                <option value="1.75">1.75</option>
                                                <option value="2.0">2.0</option>
											</select>
											&nbsp;&nbsp;&nbsp;
											<span style="color: red">*</span>
											<label style="width: 10%">电梯载重(KG):</label>
											<select style="width: 18%" class="form-control" id="ZZ" name="ZZ" onchange="setSbj()">
												<option value="">请选择</option>
                                                <option value="630">630</option>
                                                <option value="800">800</option>
                                                <option value="1000">1000</option>
												<option value="1150">1150</option>
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
                                                <option value="中分">中分</option>
                                            </select>
                                            <label style="width:11%;margin-top: 25px;margin-bottom: 10px"><font color="red">*</font>开门宽度:</label>
                                            <select style="width: 20%;margin-top: 10px" class="form-control m-b" id="KMKD" name="KMKD" onchange="setMPrice();">
                                                <option value="800">800</option>
                                                <option value="900">900</option>
                                                <option value="1000">1000</option>
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
        if(sd_=="1.0"){
            if(zz_=="630"){
                if(c_=="3"){
                    price = 111000;
                }else if(c_=="4"){
                    price = 111000;
                }else if(c_=="5"){
                    price = 118800;
                }else if(c_=="6"){
                    price = 122700;
                }else if(c_=="7"){
                    price = 126600;
                }else if(c_=="8"){
                    price = 130500;
                }else if(c_=="9"){
                    price = 134300;
                }else if(c_=="10"){
                    price = 138200;
                }else if(c_=="11"){
                    price = 143800;
                }else if(c_=="12"){
                    price = 147800;
                }else if(c_=="13"){
                    price = 151700;
                }else if(c_=="14"){
                    price = 155800;
                }else if(c_=="15"){
                    price = 159700;
                }
            }else if(zz_=="800"){
                if(c_=="3"){
                    price = 113500;
                }else if(c_=="4"){
                    price = 117300;
                }else if(c_=="5"){
                    price = 121100;
                }else if(c_=="6"){
                    price = 124900;
                }else if(c_=="7"){
                    price = 128700;
                }else if(c_=="8"){
                    price = 132600;
                }else if(c_=="9"){
                    price = 136300;
                }else if(c_=="10"){
                    price = 140200;
                }else if(c_=="11"){
                    price = 145700;
                }else if(c_=="12"){
                    price = 149600;
                }else if(c_=="13"){
                    price = 153500;
                }else if(c_=="14"){
                    price = 157400;
                }else if(c_=="15"){
                    price = 161300;
                }
            }else if(zz_=="1000"){
                if(c_=="3"){
                    price = 116100;
                }else if(c_=="4"){
                    price = 120200;
                }else if(c_=="5"){
                    price = 124200;
                }else if(c_=="6"){
                    price = 128300;
                }else if(c_=="7"){
                    price = 132400;
                }else if(c_=="8"){
                    price = 136400;
                }else if(c_=="9"){
                    price = 140600;
                }else if(c_=="10"){
                    price = 144600;
                }else if(c_=="11"){
                    price = 152100;
                }else if(c_=="12"){
                    price = 156400;
                }else if(c_=="13"){
                    price = 160600;
                }else if(c_=="14"){
                    price = 164900;
                }else if(c_=="15"){
                    price = 169200;
                }
            }else if(zz_=="1150"){
                if(c_=="3"){
                    price = 127700;
                }else if(c_=="4"){
                    price = 132000;
                }else if(c_=="5"){
                    price = 137000;
                }else if(c_=="6"){
                    price = 142000;
                }else if(c_=="7"){
                    price = 147100;
                }else if(c_=="8"){
                    price = 151900;
                }else if(c_=="9"){
                    price = 157100;
                }else if(c_=="10"){
                    price = 162000;
                }else if(c_=="11"){
                    price = 167100;
                }else if(c_=="12"){
                    price = 172100;
                }else if(c_=="13"){
                    price = 177100;
                }else if(c_=="14"){
                    price = 182200;
                }else if(c_=="15"){
                    price = 187300;
                }
            }
        }else if(sd_=="1.75"){  //速度=1.75m/s
            if(zz_=="800"){
                if(c_=="4"){
                    price = 118300;
                }else if(c_=="5"){
                    price = 122400;
                }else if(c_=="6"){
                    price = 126400;
                }else if(c_=="7"){
                    price = 130500;
                }else if(c_=="8"){
                    price = 134500;
                }else if(c_=="9"){
                    price = 138600;
                }else if(c_=="10"){
                    price = 142700;
                }else if(c_=="11"){
                    price = 148400;
                }else if(c_=="12"){
                    price = 152500;
                }else if(c_=="13"){
                    price = 156700;
                }else if(c_=="14"){
                    price = 160900;
                }else if(c_=="15"){
                    price = 165000;
                }else if(c_=="16"){
                    price = 169200;
                }else if(c_=="17"){
                    price = 173300;
                }else if(c_=="18"){
                    price = 177500;
                }else if(c_=="19"){
                    price = 181600;
                }else if(c_=="20"){
                    price = 185700;
                }else if(c_=="21"){
                    price = 189900;
                }else if(c_=="22"){
                    price = 194000;
                }else if(c_=="23"){
                    price = 198300;
                }else if(c_=="24"){
                    price = 202400;
                }else if(c_=="25"){
                    price = 206500;
                }
            }else if(zz_=="1000"){
                if(c_=="4"){
                    price = 121900;
                }else if(c_=="5"){
                    price = 126000;
                }else if(c_=="6"){
                    price = 130300;
                }else if(c_=="7"){
                    price = 134400;
                }else if(c_=="8"){
                    price = 138600;
                }else if(c_=="9"){
                    price = 142800;
                }else if(c_=="10"){
                    price = 147000;
                }else if(c_=="11"){
                    price = 154600;
                }else if(c_=="12"){
                    price = 159000;
                }else if(c_=="13"){
                    price = 163300;
                }else if(c_=="14"){
                    price = 167600;
                }else if(c_=="15"){
                    price = 172000;
                }else if(c_=="16"){
                    price = 176400;
                }else if(c_=="17"){
                    price = 180800;
                }else if(c_=="18"){
                    price = 185100;
                }else if(c_=="19"){
                    price = 189500;
                }else if(c_=="20"){
                    price = 193800;
                }else if(c_=="21"){
                    price = 198300;
                }else if(c_=="22"){
                    price = 202600;
                }else if(c_=="23"){
                    price = 207000;
                }else if(c_=="24"){
                    price = 211300;
                }else if(c_=="25"){
                    price = 215600;
                }
            }else if(zz_=="1150"){
                if(c_=="4"){
                    price = 133900;
                }else if(c_=="5"){
                    price = 139000;
                }else if(c_=="6"){
                    price = 144200;
                }else if(c_=="7"){
                    price = 149300;
                }else if(c_=="8"){
                    price = 154400;
                }else if(c_=="9"){
                    price = 159600;
                }else if(c_=="10"){
                    price = 164700;
                }else if(c_=="11"){
                    price = 169800;
                }else if(c_=="12"){
                    price = 175000;
                }else if(c_=="13"){
                    price = 180100;
                }else if(c_=="14"){
                    price = 185200;
                }else if(c_=="15"){
                    price = 190400;
                }else if(c_=="16"){
                    price = 195500;
                }else if(c_=="17"){
                    price = 200600;
                }else if(c_=="18"){
                    price = 205800;
                }else if(c_=="19"){
                    price = 210900;
                }else if(c_=="20"){
                    price = 216000;
                }else if(c_=="21"){
                    price = 221200;
                }else if(c_=="22"){
                    price = 226300;
                }else if(c_=="23"){
                    price = 231400;
                }else if(c_=="24"){
                    price = 236600;
                }else if(c_=="25"){
                    price = 241700;
                }
            }
        }else if(sd_=="2.0"){
            if(zz_=="800"){
                if(c_=="4"){
                    price =  138400;
                }else if(c_=="5"){
                    price =  142500;
                }else if(c_=="6"){
                    price =  146600;
                }else if(c_=="7"){
                    price =  150600;
                }else if(c_=="8"){
                    price =  154700;
                }else if(c_=="9"){
                    price =  158700;
                }else if(c_=="10"){
                    price =  162700;
                }else if(c_=="11"){
                    price =  168500;
                }else if(c_=="12"){
                    price =  172700;
                }else if(c_=="13"){
                    price =  176800;
                }else if(c_=="14"){
                    price =  181000;
                }else if(c_=="15"){
                    price =  185100;
                }else if(c_=="16"){
                    price =  189200;
                }else if(c_=="17"){
                    price =  193400;
                }else if(c_=="18"){
                    price =  197500;
                }else if(c_=="19"){
                    price =  201800;
                }else if(c_=="20"){
                    price =  205900;
                }else if(c_=="21"){
                    price =  210000;
                }else if(c_=="22"){
                    price =  214200;
                }else if(c_=="23"){
                    price =  218300;
                }else if(c_=="24"){
                    price =  222500;
                }else if(c_=="25"){
                    price =  226600;
                }else if(c_=="26"){
                    price =  230700;
                }else if(c_=="27"){
                    price =  234900;
                }else if(c_=="28"){
                    price =  239100;
                }else if(c_=="29"){
                    price =  243200;
                }else if(c_=="30"){
                    price =  247400;
                }else if(c_=="31"){
                    price =  251500;
                }else if(c_=="32"){
                    price =  255700;
                }else if(c_=="33"){
                    price =  259800;
                }else if(c_=="34"){
                    price =  263900;
                }else if(c_=="35"){
                    price =  268100;
                }else if(c_=="36"){
                    price =  272200;
                }
            }else if(zz_=="1000"){
                if(c_=="4"){
                    price =   143800;
                }else if(c_=="5"){
                    price =   148000;
                }else if(c_=="6"){
                    price =   152200;
                }else if(c_=="7"){
                    price =   156400;
                }else if(c_=="8"){
                    price =   160500;
                }else if(c_=="9"){
                    price =   164800;
                }else if(c_=="10"){
                    price =   168900;
                }else if(c_=="11"){
                    price =   176500;
                }else if(c_=="12"){
                    price =   180900;
                }else if(c_=="13"){
                    price =   185200;
                }else if(c_=="14"){
                    price =   189600;
                }else if(c_=="15"){
                    price =   193900;
                }else if(c_=="16"){
                    price =   198400;
                }else if(c_=="17"){
                    price =   202700;
                }else if(c_=="18"){
                    price =   207100;
                }else if(c_=="19"){
                    price =   211400;
                }else if(c_=="20"){
                    price =   215800;
                }else if(c_=="21"){
                    price =   220200;
                }else if(c_=="22"){
                    price =   224500;
                }else if(c_=="23"){
                    price =   228900;
                }else if(c_=="24"){
                    price =   233200;
                }else if(c_=="25"){
                    price =   237600;
                }else if(c_=="26"){
                    price =   242000;
                }else if(c_=="27"){
                    price =   246400;
                }else if(c_=="28"){
                    price =   250700;
                }else if(c_=="29"){
                    price =   255100;
                }else if(c_=="30"){
                    price =   259400;
                }else if(c_=="31"){
                    price =   263900;
                }else if(c_=="32"){
                    price =   268200;
                }else if(c_=="33"){
                    price =   272500;
                }else if(c_=="34"){
                    price =   276900;
                }else if(c_=="35"){
                    price =   281200;
                }else if(c_=="36"){
                    price =   285700;
                }
            }else if(zz_=="1150"){
                if(c_=="4"){
                    price =   156800;
                }else if(c_=="5"){
                    price =   162000;
                }else if(c_=="6"){
                    price =   167100;
                }else if(c_=="7"){
                    price =   172300;
                }else if(c_=="8"){
                    price =   177300;
                }else if(c_=="9"){
                    price =   182600;
                }else if(c_=="10"){
                    price =   187600;
                }else if(c_=="11"){
                    price =   192700;
                }else if(c_=="12"){
                    price =   197900;
                }else if(c_=="13"){
                    price =   203000;
                }else if(c_=="14"){
                    price =   208200;
                }else if(c_=="15"){
                    price =   213300;
                }else if(c_=="16"){
                    price =   218500;
                }else if(c_=="17"){
                    price =   223500;
                }else if(c_=="18"){
                    price =   228800;
                }else if(c_=="19"){
                    price =   233800;
                }else if(c_=="20"){
                    price =   239000;
                }else if(c_=="21"){
                    price =   244100;
                }else if(c_=="22"){
                    price =   249200;
                }else if(c_=="23"){
                    price =   254300;
                }else if(c_=="24"){
                    price =   259500;
                }else if(c_=="25"){
                    price =   264700;
                }else if(c_=="26"){
                    price =   269900;
                }else if(c_=="27"){
                    price =   275100;
                }else if(c_=="28"){
                    price =   280300;
                }else if(c_=="29"){
                    price =   285500;
                }else if(c_=="30"){
                    price =   290700;
                }else if(c_=="31"){
                    price =   295900;
                }else if(c_=="32"){
                    price =   301100;
                }else if(c_=="33"){
                    price =   306300;
                }else if(c_=="34"){
                    price =   311500;
                }else if(c_=="35"){
                    price =   316700;
                }else if(c_=="36"){
                    price =   321900;
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
                if(kmkd_=="800"){
                    price = price-1680*jm;
                }else if(kmkd_=="900"){
                    price = price-1920*jm;
                }else if(kmkd_=="1100"){
                    price = price-2200*jm;
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
