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
											<select style="width: 18%" class="form-control" id="SD" name="SD" onchange="editSd();">
												<option value="">请选择</option>
												<option value="1.0">1.0</option>
												<option value="1.5">1.5</option>
                                                <option value="1.75">1.75</option>
                                                <option value="2.0">2.0</option>
                                                <option value="2.5">2.5</option>
											</select>
											&nbsp;&nbsp;&nbsp;
											<span style="color: red">*</span>
											<label style="width: 10%">电梯载重(KG):</label>
											<select style="width: 18%" class="form-control" id="ZZ" name="ZZ" onchange="setSbj()">
												<option value="">请选择</option>
												<option value="450">450</option>
                                                <option value="630">630</option>
                                                <option value="800">800</option>
                                                <option value="1000">1000</option>
												<option value="1150">1150</option>
												<option value="1350">1350</option>
                                                <option value="1600">1600</option>
                                                <option value="2000">2000</option>
											</select>
											&nbsp;&nbsp;&nbsp;
											<span style="color: red">*</span>
											<label style="width: 10%">层站门:</label>
											<!-- <input style="width:6%"  type="text"  placeholder="层"  id="C" name="C" value="${pd.C }"  class="form-control" onchange="setSbj();">
											<input style="width:6%"  type="text"  placeholder="站"  id="Z" name="Z" value="${pd.Z }"  class="form-control">
											<input style="width:6%"  type="text"  placeholder="门"  id="M" name="M" value="${pd.M }"  class="form-control" onkeyup="setMPrice()"> -->
                                            <select class="form-control m-b" style="width:7%" name="C" id="C" onchange="setSbj();">
                                                <option value="">请选择</option>
                                            </select>
                                            <select class="form-control m-b" style="width:7%" name="Z" id="Z" onchange="setSbj();">
                                                <option value="">请选择</option>
                                            </select>
                                            <select class="form-control m-b" style="width:7%" name="M" id="M" onchange="setMPrice();">
                                                <option value="">请选择</option>
                                            </select>
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
                                                <option value="900">800</option>
                                                <option value="1500">900</option>
                                                <option value="2000">1100</option>
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
            if(zz_=="450"){
                if(c_=="3"){
                    price = 125920;
                }else if(c_=="4"){
                    price = 130920;
                }else if(c_=="5"){
                    price = 135920;
                }else if(c_=="6"){
                    price = 140920;
                }else if(c_=="7"){
                    price = 145920;
                }else if(c_=="8"){
                    price = 150920;
                }else if(c_=="9"){
                    price = 156920;
                }else if(c_=="10"){
                    price = 161920;
                }else if(c_=="11"){
                    price = 166920;
                }else if(c_=="12"){
                    price = 171920;
                }else if(c_=="13"){
                    price = 176920;
                }else if(c_=="14"){
                    price = 181920;
                }else if(c_=="15"){
                    price = 186920;
                }else if(c_=="16"){
                    price = 191920;
                }else if(c_=="17"){
                    price = 196920;
                }else if(c_=="18"){
                    price = 201920;
                }else if(c_=="19"){
                    price = 206920;
                }else if(c_=="20"){
                    price = 211920;
                }
            }else if(zz_=="630"){
                if(c_=="3"){
                    price = 127470;
                }else if(c_=="4"){
                    price = 132470;
                }else if(c_=="5"){
                    price = 137470;
                }else if(c_=="6"){
                    price = 142470;
                }else if(c_=="7"){
                    price = 147470;
                }else if(c_=="8"){
                    price = 152470;
                }else if(c_=="9"){
                    price = 158470;
                }else if(c_=="10"){
                    price = 163470;
                }else if(c_=="11"){
                    price = 168470;
                }else if(c_=="12"){
                    price = 173470;
                }else if(c_=="13"){
                    price = 178470;
                }else if(c_=="14"){
                    price = 183470;
                }else if(c_=="15"){
                    price = 188470;
                }else if(c_=="16"){
                    price = 193470;
                }else if(c_=="17"){
                    price = 198470;
                }else if(c_=="18"){
                    price = 203470;
                }else if(c_=="19"){
                    price = 208470;
                }else if(c_=="20"){
                    price = 213470;
                }
            }else if(zz_=="800"){
                if(c_=="3"){
                    price = 129970;
                }else if(c_=="4"){
                    price = 134970;
                }else if(c_=="5"){
                    price = 139970;
                }else if(c_=="6"){
                    price = 144970;
                }else if(c_=="7"){
                    price = 149970;
                }else if(c_=="8"){
                    price = 154970;
                }else if(c_=="9"){
                    price = 159970;
                }else if(c_=="10"){
                    price = 164970;
                }else if(c_=="11"){
                    price = 169970;
                }else if(c_=="12"){
                    price = 174970;
                }else if(c_=="13"){
                    price = 180970;
                }else if(c_=="14"){
                    price = 185970;
                }else if(c_=="15"){
                    price = 190970;
                }else if(c_=="16"){
                    price = 195970;
                }else if(c_=="17"){
                    price = 200970;
                }else if(c_=="18"){
                    price = 205970;
                }else if(c_=="19"){
                    price = 210970;
                }else if(c_=="20"){
                    price = 215970;
                }
            }else if(zz_=="1000"){
                if(c_=="3"){
                    price = 137670;
                }else if(c_=="4"){
                    price = 142670;
                }else if(c_=="5"){
                    price = 147670;
                }else if(c_=="6"){
                    price = 152670;
                }else if(c_=="7"){
                    price = 157670;
                }else if(c_=="8"){
                    price = 162670;
                }else if(c_=="9"){
                    price = 167670;
                }else if(c_=="10"){
                    price = 172670;
                }else if(c_=="11"){
                    price = 177670;
                }else if(c_=="12"){
                    price = 182670;
                }else if(c_=="13"){
                    price = 187670;
                }else if(c_=="14"){
                    price = 192670;
                }else if(c_=="15"){
                    price = 197670;
                }else if(c_=="16"){
                    price = 203670;
                }else if(c_=="17"){
                    price = 208670;
                }else if(c_=="18"){
                    price = 213670;
                }else if(c_=="19"){
                    price = 218670;
                }else if(c_=="20"){
                    price = 223670;
                }
            }else if(zz_=="1150"){
                if(c_=="3"){
                    price = 162400;
                }else if(c_=="4"){
                    price = 167360;
                }else if(c_=="5"){
                    price = 172310;
                }else if(c_=="6"){
                    price = 177270;
                }else if(c_=="7"){
                    price = 182220;
                }else if(c_=="8"){
                    price = 187180;
                }else if(c_=="9"){
                    price = 192130;
                }else if(c_=="10"){
                    price = 197090;
                }else if(c_=="11"){
                    price = 202040;
                }else if(c_=="12"){
                    price = 207000;
                }else if(c_=="13"){
                    price = 211950;
                }else if(c_=="14"){
                    price = 216910;
                }else if(c_=="15"){
                    price = 221860;
                }else if(c_=="16"){
                    price = 226820;
                }else if(c_=="17"){
                    price = 231770;
                }else if(c_=="18"){
                    price = 236720;
                }else if(c_=="19"){
                    price = 241680;
                }else if(c_=="20"){
                    price = 246630;
                }
            }else if(zz_=="1350"){
                if(c_=="3"){
                    price = 182850;
                }else if(c_=="4"){
                    price = 187790;
                }else if(c_=="5"){
                    price = 192740;
                }else if(c_=="6"){
                    price = 197690;
                }else if(c_=="7"){
                    price = 202630;
                }else if(c_=="8"){
                    price = 207580;
                }else if(c_=="9"){
                    price = 212520;
                }else if(c_=="10"){
                    price = 217470;
                }else if(c_=="11"){
                    price = 222410;
                }else if(c_=="12"){
                    price = 227360;
                }else if(c_=="13"){
                    price = 232310;
                }else if(c_=="14"){
                    price = 237250;
                }else if(c_=="15"){
                    price = 242200;
                }else if(c_=="16"){
                    price = 247140;
                }else if(c_=="17"){
                    price = 252090;
                }else if(c_=="18"){
                    price = 257040;
                }else if(c_=="19"){
                    price = 261980;
                }else if(c_=="20"){
                    price = 266930;
                }
            }else if(zz_=="1600"){
                if(c_=="3"){
                    price = 185780;
                }else if(c_=="4"){
                    price = 190830;
                }else if(c_=="5"){
                    price = 195880;
                }else if(c_=="6"){
                    price = 200920;
                }else if(c_=="7"){
                    price = 205970;
                }else if(c_=="8"){
                    price = 211020;
                }else if(c_=="9"){
                    price = 216070;
                }else if(c_=="10"){
                    price = 221120;
                }else if(c_=="11"){
                    price = 226170;
                }else if(c_=="12"){
                    price = 231220;
                }else if(c_=="13"){
                    price = 236260;
                }else if(c_=="14"){
                    price = 241310;
                }else if(c_=="15"){
                    price = 246360;
                }else if(c_=="16"){
                    price = 251410;
                }else if(c_=="17"){
                    price = 256460;
                }else if(c_=="18"){
                    price = 261510;
                }else if(c_=="19"){
                    price = 266550;
                }else if(c_=="20"){
                    price = 271600;
                }
            }else if(zz_=="2000"){
                if(c_=="3"){
                    price = 203980;
                }else if(c_=="4"){
                    price = 209030;
                }else if(c_=="5"){
                    price = 214080;
                }else if(c_=="6"){
                    price = 219120;
                }else if(c_=="7"){
                    price = 224170;
                }else if(c_=="8"){
                    price = 229220;
                }else if(c_=="9"){
                    price = 234270;
                }else if(c_=="10"){
                    price = 239320;
                }else if(c_=="11"){
                    price = 244370;
                }else if(c_=="12"){
                    price = 249420;
                }else if(c_=="13"){
                    price = 254460;
                }else if(c_=="14"){
                    price = 259510;
                }else if(c_=="15"){
                    price = 264560;
                }else if(c_=="16"){
                    price = 269610;
                }else if(c_=="17"){
                    price = 274660;
                }else if(c_=="18"){
                    price = 279710;
                }else if(c_=="19"){
                    price = 284750;
                }else if(c_=="20"){
                    price = 289800;
                }
            }
        }else if(sd_=="1.5"){   //速度=1.5m/s
            if(zz_=="450"){
                if(c_=="3"){
                    price = 130920;
                }else if(c_=="4"){
                    price = 135920;
                }else if(c_=="5"){
                    price = 140920;
                }else if(c_=="6"){
                    price = 145920;
                }else if(c_=="7"){
                    price = 150920;
                }else if(c_=="8"){
                    price = 155920;
                }else if(c_=="9"){
                    price = 161920;
                }else if(c_=="10"){
                    price = 166920;
                }else if(c_=="11"){
                    price = 171920;
                }else if(c_=="12"){
                    price = 176920;
                }else if(c_=="13"){
                    price = 181920;
                }else if(c_=="14"){
                    price = 186920;
                }else if(c_=="15"){
                    price = 191920;
                }else if(c_=="16"){
                    price = 196920;
                }else if(c_=="17"){
                    price = 201920;
                }else if(c_=="18"){
                    price = 206920;
                }else if(c_=="19"){
                    price = 211920;
                }else if(c_=="20"){
                    price = 216920;
                }else if(c_=="21"){
                    price = 222920;
                }else if(c_=="22"){
                    price = 227920;
                }else if(c_=="23"){
                    price = 232920;
                }else if(c_=="24"){
                    price = 237920;
                }
            }else if(zz_=="630"){
                if(c_=="3"){
                    price = 132470;
                }else if(c_=="4"){
                    price = 137470;
                }else if(c_=="5"){
                    price = 142470;
                }else if(c_=="6"){
                    price = 147470;
                }else if(c_=="7"){
                    price = 152470;
                }else if(c_=="8"){
                    price = 157470;
                }else if(c_=="9"){
                    price = 163470;
                }else if(c_=="10"){
                    price = 168470;
                }else if(c_=="11"){
                    price = 173470;
                }else if(c_=="12"){
                    price = 178470;
                }else if(c_=="13"){
                    price = 183470;
                }else if(c_=="14"){
                    price = 188470;
                }else if(c_=="15"){
                    price = 193470;
                }else if(c_=="16"){
                    price = 198470;
                }else if(c_=="17"){
                    price = 203470;
                }else if(c_=="18"){
                    price = 208470;
                }else if(c_=="19"){
                    price = 213470;
                }else if(c_=="20"){
                    price = 218470;
                }else if(c_=="21"){
                    price = 224470;
                }else if(c_=="22"){
                    price = 229470;
                }else if(c_=="23"){
                    price = 234470;
                }else if(c_=="24"){
                    price = 239470;
                }
            }else if(zz_=="800"){
                if(c_=="3"){
                    price = 134970;
                }else if(c_=="4"){
                    price = 139970;
                }else if(c_=="5"){
                    price = 144970;
                }else if(c_=="6"){
                    price = 149970;
                }else if(c_=="7"){
                    price = 154970;
                }else if(c_=="8"){
                    price = 159970;
                }else if(c_=="9"){
                    price = 164970;
                }else if(c_=="10"){
                    price = 169970;
                }else if(c_=="11"){
                    price = 174970;
                }else if(c_=="12"){
                    price = 179970;
                }else if(c_=="13"){
                    price = 185970;
                }else if(c_=="14"){
                    price = 190970;
                }else if(c_=="15"){
                    price = 195970;
                }else if(c_=="16"){
                    price = 200970;
                }else if(c_=="17"){
                    price = 205970;
                }else if(c_=="18"){
                    price = 210970;
                }else if(c_=="19"){
                    price = 215970;
                }else if(c_=="20"){
                    price = 220970;
                }else if(c_=="21"){
                    price = 225970;
                }else if(c_=="22"){
                    price = 230970;
                }else if(c_=="23"){
                    price = 235970;
                }else if(c_=="24"){
                    price = 240970;
                }
            }else if(zz_=="1000"){
                if(c_=="3"){
                    price = 142670;
                }else if(c_=="4"){
                    price = 147670;
                }else if(c_=="5"){
                    price = 152670;
                }else if(c_=="6"){
                    price = 157670;
                }else if(c_=="7"){
                    price = 162670;
                }else if(c_=="8"){
                    price = 167670;
                }else if(c_=="9"){
                    price = 172670;
                }else if(c_=="10"){
                    price = 177670;
                }else if(c_=="11"){
                    price = 182670;
                }else if(c_=="12"){
                    price = 187670;
                }else if(c_=="13"){
                    price = 192670;
                }else if(c_=="14"){
                    price = 197670;
                }else if(c_=="15"){
                    price = 202670;
                }else if(c_=="16"){
                    price = 208670;
                }else if(c_=="17"){
                    price = 213670;
                }else if(c_=="18"){
                    price = 218670;
                }else if(c_=="19"){
                    price = 223670;
                }else if(c_=="20"){
                    price = 228670;
                }else if(c_=="21"){
                    price = 233670;
                }else if(c_=="22"){
                    price = 238670;
                }else if(c_=="23"){
                    price = 243670;
                }else if(c_=="24"){
                    price = 248670;
                }
            }else if(zz_=="1150"){
                if(c_=="3"){
                    price = 163660;
                }else if(c_=="4"){
                    price = 168600;
                }else if(c_=="5"){
                    price = 173530;
                }else if(c_=="6"){
                    price = 178470;
                }else if(c_=="7"){
                    price = 183410;
                }else if(c_=="8"){
                    price = 188350;
                }else if(c_=="9"){
                    price = 193290;
                }else if(c_=="10"){
                    price = 198220;
                }else if(c_=="11"){
                    price = 203160;
                }else if(c_=="12"){
                    price = 208100;
                }else if(c_=="13"){
                    price = 213040;
                }else if(c_=="14"){
                    price = 217980;
                }else if(c_=="15"){
                    price = 222910;
                }else if(c_=="16"){
                    price = 227850;
                }else if(c_=="17"){
                    price = 232790;
                }else if(c_=="18"){
                    price = 237730;
                }else if(c_=="19"){
                    price = 242660;
                }else if(c_=="20"){
                    price = 247600;
                }else if(c_=="21"){
                    price = 252540;
                }else if(c_=="22"){
                    price = 257480;
                }else if(c_=="23"){
                    price = 262420;
                }else if(c_=="24"){
                    price = 267350;
                }
            }else if(zz_=="1350"){
                if(c_=="3"){
                    price = 186380;
                }else if(c_=="4"){
                    price = 191280;
                }else if(c_=="5"){
                    price = 196170;
                }else if(c_=="6"){
                    price = 201060;
                }else if(c_=="7"){
                    price = 205950;
                }else if(c_=="8"){
                    price = 210840;
                }else if(c_=="9"){
                    price = 215730;
                }else if(c_=="10"){
                    price = 220630;
                }else if(c_=="11"){
                    price = 225520;
                }else if(c_=="12"){
                    price = 230410;
                }else if(c_=="13"){
                    price = 235300;
                }else if(c_=="14"){
                    price = 240190;
                }else if(c_=="15"){
                    price = 245090;
                }else if(c_=="16"){
                    price = 249980;
                }else if(c_=="17"){
                    price = 254870;
                }else if(c_=="18"){
                    price = 259760;
                }else if(c_=="19"){
                    price = 264650;
                }else if(c_=="20"){
                    price = 269540;
                }else if(c_=="21"){
                    price = 274440;
                }else if(c_=="22"){
                    price = 279330;
                }else if(c_=="23"){
                    price = 284220;
                }else if(c_=="24"){
                    price = 289110;
                }
            }else if(zz_=="1600"){
                if(c_=="3"){
                    price = 193730;
                }else if(c_=="4"){
                    price = 198670;
                }else if(c_=="5"){
                    price = 203610;
                }else if(c_=="6"){
                    price = 208550;
                }else if(c_=="7"){
                    price = 213480;
                }else if(c_=="8"){
                    price = 218420;
                }else if(c_=="9"){
                    price = 223360;
                }else if(c_=="10"){
                    price = 228300;
                }else if(c_=="11"){
                    price = 233240;
                }else if(c_=="12"){
                    price = 238180;
                }else if(c_=="13"){
                    price = 243120;
                }else if(c_=="14"){
                    price = 248050;
                }else if(c_=="15"){
                    price = 252990;
                }else if(c_=="16"){
                    price = 257930;
                }else if(c_=="17"){
                    price = 262870;
                }else if(c_=="18"){
                    price = 267810;
                }else if(c_=="19"){
                    price = 272750;
                }else if(c_=="20"){
                    price = 277690;
                }else if(c_=="21"){
                    price = 282620;
                }else if(c_=="22"){
                    price = 287560;
                }else if(c_=="23"){
                    price = 292500;
                }else if(c_=="24"){
                    price = 297440;
                }
            }else if(zz_=="2000"){
                if(c_=="3"){
                    price = 211930;
                }else if(c_=="4"){
                    price = 216870;
                }else if(c_=="5"){
                    price = 221810;
                }else if(c_=="6"){
                    price = 226750;
                }else if(c_=="7"){
                    price = 231680;
                }else if(c_=="8"){
                    price = 236620;
                }else if(c_=="9"){
                    price = 241560;
                }else if(c_=="10"){
                    price = 246500;
                }else if(c_=="11"){
                    price = 251440;
                }else if(c_=="12"){
                    price = 256380;
                }else if(c_=="13"){
                    price = 261320;
                }else if(c_=="14"){
                    price = 266250;
                }else if(c_=="15"){
                    price = 271190;
                }else if(c_=="16"){
                    price = 276130;
                }else if(c_=="17"){
                    price = 281070;
                }else if(c_=="18"){
                    price = 286010;
                }else if(c_=="19"){
                    price = 290950;
                }else if(c_=="20"){
                    price = 295890;
                }else if(c_=="21"){
                    price = 300820;
                }else if(c_=="22"){
                    price = 305760;
                }else if(c_=="23"){
                    price = 310700;
                }else if(c_=="24"){
                    price = 315640;
                }
            }
        }else if(sd_=="1.75"){  //速度=1.75m/s
            if(zz_=="450"){
                if(c_=="4"){
                    price = 139920;
                }else if(c_=="5"){
                    price = 144920;
                }else if(c_=="6"){
                    price = 149920;
                }else if(c_=="7"){
                    price = 154920;
                }else if(c_=="8"){
                    price = 159920;
                }else if(c_=="9"){
                    price = 165920;
                }else if(c_=="10"){
                    price = 170920;
                }else if(c_=="11"){
                    price = 175920;
                }else if(c_=="12"){
                    price = 180920;
                }else if(c_=="13"){
                    price = 185920;
                }else if(c_=="14"){
                    price = 190920;
                }else if(c_=="15"){
                    price = 195920;
                }else if(c_=="16"){
                    price = 200920;
                }else if(c_=="17"){
                    price = 205920;
                }else if(c_=="18"){
                    price = 210920;
                }else if(c_=="19"){
                    price = 215920;
                }else if(c_=="20"){
                    price = 220920;
                }else if(c_=="21"){
                    price = 226920;
                }else if(c_=="22"){
                    price = 231920;
                }else if(c_=="23"){
                    price = 236920;
                }else if(c_=="24"){
                    price = 241920;
                }else if(c_=="25"){
                    price = 246920;
                }else if(c_=="26"){
                    price = 251920;
                }else if(c_=="27"){
                    price = 256920;
                }else if(c_=="28"){
                    price = 261920;
                }else if(c_=="29"){
                    price = 266920;
                }else if(c_=="30"){
                    price = 271920;
                }
            }else if(zz_=="630"){
                if(c_=="4"){
                    price = 141470;
                }else if(c_=="5"){
                    price = 146470;
                }else if(c_=="6"){
                    price = 151470;
                }else if(c_=="7"){
                    price = 156470;
                }else if(c_=="8"){
                    price = 161470;
                }else if(c_=="9"){
                    price = 167470;
                }else if(c_=="10"){
                    price = 172470;
                }else if(c_=="11"){
                    price = 177470;
                }else if(c_=="12"){
                    price = 182470;
                }else if(c_=="13"){
                    price = 187470;
                }else if(c_=="14"){
                    price = 192470;
                }else if(c_=="15"){
                    price = 197470;
                }else if(c_=="16"){
                    price = 202470;
                }else if(c_=="17"){
                    price = 207470;
                }else if(c_=="18"){
                    price = 212470;
                }else if(c_=="19"){
                    price = 217470;
                }else if(c_=="20"){
                    price = 222470;
                }else if(c_=="21"){
                    price = 228470;
                }else if(c_=="22"){
                    price = 233470;
                }else if(c_=="23"){
                    price = 238470;
                }else if(c_=="24"){
                    price = 243470;
                }else if(c_=="25"){
                    price = 248470;
                }else if(c_=="26"){
                    price = 253470;
                }else if(c_=="27"){
                    price = 258470;
                }else if(c_=="28"){
                    price = 263470;
                }else if(c_=="29"){
                    price = 268470;
                }else if(c_=="30"){
                    price = 273470;
                }
            }else if(zz_=="800"){
                if(c_=="4"){
                    price = 143970;
                }else if(c_=="5"){
                    price = 148970;
                }else if(c_=="6"){
                    price = 153970;
                }else if(c_=="7"){
                    price = 158970;
                }else if(c_=="8"){
                    price = 163970;
                }else if(c_=="9"){
                    price = 168970;
                }else if(c_=="10"){
                    price = 173970;
                }else if(c_=="11"){
                    price = 178970;
                }else if(c_=="12"){
                    price = 183970;
                }else if(c_=="13"){
                    price = 189970;
                }else if(c_=="14"){
                    price = 194970;
                }else if(c_=="15"){
                    price = 199970;
                }else if(c_=="16"){
                    price = 204970;
                }else if(c_=="17"){
                    price = 209970;
                }else if(c_=="18"){
                    price = 214970;
                }else if(c_=="19"){
                    price = 219970;
                }else if(c_=="20"){
                    price = 224970;
                }else if(c_=="21"){
                    price = 229970;
                }else if(c_=="22"){
                    price = 234970;
                }else if(c_=="23"){
                    price = 239970;
                }else if(c_=="24"){
                    price = 244970;
                }else if(c_=="25"){
                    price = 249970;
                }else if(c_=="26"){
                    price = 254970;
                }else if(c_=="27"){
                    price = 259970;
                }else if(c_=="28"){
                    price = 264970;
                }else if(c_=="29"){
                    price = 269970;
                }else if(c_=="30"){
                    price = 274970;
                }
            }else if(zz_=="1000"){
                if(c_=="4"){
                    price = 151670;
                }else if(c_=="5"){
                    price = 156670;
                }else if(c_=="6"){
                    price = 161670;
                }else if(c_=="7"){
                    price = 166670;
                }else if(c_=="8"){
                    price = 171670;
                }else if(c_=="9"){
                    price = 176670;
                }else if(c_=="10"){
                    price = 181670;
                }else if(c_=="11"){
                    price = 186670;
                }else if(c_=="12"){
                    price = 191670;
                }else if(c_=="13"){
                    price = 196670;
                }else if(c_=="14"){
                    price = 201670;
                }else if(c_=="15"){
                    price = 206670;
                }else if(c_=="16"){
                    price = 212670;
                }else if(c_=="17"){
                    price = 217670;
                }else if(c_=="18"){
                    price = 222670;
                }else if(c_=="19"){
                    price = 227670;
                }else if(c_=="20"){
                    price = 232670;
                }else if(c_=="21"){
                    price = 237670;
                }else if(c_=="22"){
                    price = 242670;
                }else if(c_=="23"){
                    price = 247670;
                }else if(c_=="24"){
                    price = 252670;
                }else if(c_=="25"){
                    price = 257670;
                }else if(c_=="26"){
                    price = 262670;
                }else if(c_=="27"){
                    price = 267670;
                }else if(c_=="28"){
                    price = 272670;
                }else if(c_=="29"){
                    price = 277670;
                }else if(c_=="30"){
                    price = 282670;
                }
            }else if(zz_=="1150"){
                if(c_=="4"){
                    price = 169370;
                }else if(c_=="5"){
                    price = 174400;
                }else if(c_=="6"){
                    price = 179430;
                }else if(c_=="7"){
                    price = 184460;
                }else if(c_=="8"){
                    price = 189490;
                }else if(c_=="9"){
                    price = 194520;
                }else if(c_=="10"){
                    price = 199550;
                }else if(c_=="11"){
                    price = 204580;
                }else if(c_=="12"){
                    price = 209610;
                }else if(c_=="13"){
                    price = 214640;
                }else if(c_=="14"){
                    price = 219670;
                }else if(c_=="15"){
                    price = 224700;
                }else if(c_=="16"){
                    price = 229730;
                }else if(c_=="17"){
                    price = 234760;
                }else if(c_=="18"){
                    price = 239790;
                }else if(c_=="19"){
                    price = 244820;
                }else if(c_=="20"){
                    price = 249850;
                }else if(c_=="21"){
                    price = 254880;
                }else if(c_=="22"){
                    price = 259910;
                }else if(c_=="23"){
                    price = 264940;
                }else if(c_=="24"){
                    price = 269970;
                }else if(c_=="25"){
                    price = 275000;
                }else if(c_=="26"){
                    price = 280030;
                }else if(c_=="27"){
                    price = 285060;
                }else if(c_=="28"){
                    price = 290090;
                }else if(c_=="29"){
                    price = 295120;
                }else if(c_=="30"){
                    price = 300150;
                }
            }else if(zz_=="1350"){
                if(c_=="4"){
                    price = 197310;
                }else if(c_=="5"){
                    price = 202170;
                }else if(c_=="6"){
                    price = 207030;
                }else if(c_=="7"){
                    price = 211900;
                }else if(c_=="8"){
                    price = 216760;
                }else if(c_=="9"){
                    price = 221620;
                }else if(c_=="10"){
                    price = 226480;
                }else if(c_=="11"){
                    price = 231350;
                }else if(c_=="12"){
                    price = 236210;
                }else if(c_=="13"){
                    price = 241070;
                }else if(c_=="14"){
                    price = 245930;
                }else if(c_=="15"){
                    price = 250790;
                }else if(c_=="16"){
                    price = 255660;
                }else if(c_=="17"){
                    price = 260520;
                }else if(c_=="18"){
                    price = 265380;
                }else if(c_=="19"){
                    price = 270240;
                }else if(c_=="20"){
                    price = 275100;
                }else if(c_=="21"){
                    price = 279970;
                }else if(c_=="22"){
                    price = 284830;
                }else if(c_=="23"){
                    price = 289690;
                }else if(c_=="24"){
                    price = 294550;
                }else if(c_=="25"){
                    price = 299420;
                }else if(c_=="26"){
                    price = 304280;
                }else if(c_=="27"){
                    price = 309140;
                }else if(c_=="28"){
                    price = 314000;
                }else if(c_=="29"){
                    price = 318860;
                }else if(c_=="30"){
                    price = 323730;
                }
            }else if(zz_=="1600"){
                if(c_=="4"){
                    price = 202570;
                }else if(c_=="5"){
                    price = 207530;
                }else if(c_=="6"){
                    price = 212500;
                }else if(c_=="7"){
                    price = 217470;
                }else if(c_=="8"){
                    price = 222440;
                }else if(c_=="9"){
                    price = 227410;
                }else if(c_=="10"){
                    price = 232380;
                }else if(c_=="11"){
                    price = 237350;
                }else if(c_=="12"){
                    price = 242320;
                }else if(c_=="13"){
                    price = 247290;
                }else if(c_=="14"){
                    price = 252260;
                }else if(c_=="15"){
                    price = 257230;
                }else if(c_=="16"){
                    price = 262190;
                }else if(c_=="17"){
                    price = 267160;
                }else if(c_=="18"){
                    price = 272130;
                }else if(c_=="19"){
                    price = 277100;
                }else if(c_=="20"){
                    price = 282070;
                }else if(c_=="21"){
                    price = 287040;
                }else if(c_=="22"){
                    price = 292010;
                }else if(c_=="23"){
                    price = 296980;
                }else if(c_=="24"){
                    price = 301950;
                }else if(c_=="25"){
                    price = 306920;
                }else if(c_=="26"){
                    price = 311890;
                }else if(c_=="27"){
                    price = 316850;
                }else if(c_=="28"){
                    price = 321820;
                }else if(c_=="29"){
                    price = 326790;
                }else if(c_=="30"){
                    price = 331760;
                }
            }else if(zz_=="2000"){
                if(c_=="4"){
                    price = 220770;
                }else if(c_=="5"){
                    price = 225730;
                }else if(c_=="6"){
                    price = 230700;
                }else if(c_=="7"){
                    price = 235670;
                }else if(c_=="8"){
                    price = 240640;
                }else if(c_=="9"){
                    price = 245610;
                }else if(c_=="10"){
                    price = 250580;
                }else if(c_=="11"){
                    price = 255550;
                }else if(c_=="12"){
                    price = 260520;
                }else if(c_=="13"){
                    price = 265490;
                }else if(c_=="14"){
                    price = 270460;
                }else if(c_=="15"){
                    price = 275430;
                }else if(c_=="16"){
                    price = 280390;
                }else if(c_=="17"){
                    price = 285360;
                }else if(c_=="18"){
                    price = 290330;
                }else if(c_=="19"){
                    price = 295300;
                }else if(c_=="20"){
                    price = 300270;
                }else if(c_=="21"){
                    price = 305240;
                }else if(c_=="22"){
                    price = 310210;
                }else if(c_=="23"){
                    price = 315180;
                }else if(c_=="24"){
                    price = 320150;
                }else if(c_=="25"){
                    price = 325120;
                }else if(c_=="26"){
                    price = 330090;
                }else if(c_=="27"){
                    price = 335050;
                }else if(c_=="28"){
                    price = 340020;
                }else if(c_=="29"){
                    price = 344990;
                }else if(c_=="30"){
                    price = 349960;
                }
            }
        }else if(sd_=="2.0"){
            if(zz_=="800"){
                if(c_=="4"){
                    price =  162110;
                }else if(c_=="5"){
                    price =  167720;
                }else if(c_=="6"){
                    price =  173330;
                }else if(c_=="7"){
                    price =  178940;
                }else if(c_=="8"){
                    price =  184550;
                }else if(c_=="9"){
                    price =  190160;
                }else if(c_=="10"){
                    price =  195770;
                }else if(c_=="11"){
                    price =  201380;
                }else if(c_=="12"){
                    price =  206990;
                }else if(c_=="13"){
                    price =  212600;
                }else if(c_=="14"){
                    price =  218210;
                }else if(c_=="15"){
                    price =  223820;
                }else if(c_=="16"){
                    price =  229430;
                }else if(c_=="17"){
                    price =  235040;
                }else if(c_=="18"){
                    price =  240650;
                }else if(c_=="19"){
                    price =  246260;
                }else if(c_=="20"){
                    price =  251870;
                }else if(c_=="21"){
                    price =  257480;
                }else if(c_=="22"){
                    price =  263090;
                }else if(c_=="23"){
                    price =  268700;
                }else if(c_=="24"){
                    price =  274310;
                }else if(c_=="25"){
                    price =  279920;
                }else if(c_=="26"){
                    price =  285530;
                }else if(c_=="27"){
                    price =  291140;
                }else if(c_=="28"){
                    price =  296750;
                }else if(c_=="29"){
                    price =  302360;
                }else if(c_=="30"){
                    price =  307970;
                }else if(c_=="31"){
                    price =  313580;
                }else if(c_=="32"){
                    price =  319190;
                }else if(c_=="33"){
                    price =  324800;
                }else if(c_=="34"){
                    price =  330410;
                }else if(c_=="35"){
                    price =  336020;
                }else if(c_=="36"){
                    price =  341630;
                }
            }else if(zz_=="1000"){
                if(c_=="4"){
                    price =   167810;
                }else if(c_=="5"){
                    price =   173390;
                }else if(c_=="6"){
                    price =   178960;
                }else if(c_=="7"){
                    price =   184540;
                }else if(c_=="8"){
                    price =   190120;
                }else if(c_=="9"){
                    price =   195700;
                }else if(c_=="10"){
                    price =   201270;
                }else if(c_=="11"){
                    price =   206850;
                }else if(c_=="12"){
                    price =   212430;
                }else if(c_=="13"){
                    price =   218010;
                }else if(c_=="14"){
                    price =   223580;
                }else if(c_=="15"){
                    price =   229160;
                }else if(c_=="16"){
                    price =   234740;
                }else if(c_=="17"){
                    price =   240320;
                }else if(c_=="18"){
                    price =   245900;
                }else if(c_=="19"){
                    price =   251470;
                }else if(c_=="20"){
                    price =   257050;
                }else if(c_=="21"){
                    price =   262630;
                }else if(c_=="22"){
                    price =   268210;
                }else if(c_=="23"){
                    price =   273780;
                }else if(c_=="24"){
                    price =   279360;
                }else if(c_=="25"){
                    price =   284940;
                }else if(c_=="26"){
                    price =   290520;
                }else if(c_=="27"){
                    price =   296090;
                }else if(c_=="28"){
                    price =   301670;
                }else if(c_=="29"){
                    price =   307250;
                }else if(c_=="30"){
                    price =   312830;
                }else if(c_=="31"){
                    price =   318400;
                }else if(c_=="32"){
                    price =   323980;
                }else if(c_=="33"){
                    price =   329560;
                }else if(c_=="34"){
                    price =   335140;
                }else if(c_=="35"){
                    price =   340710;
                }else if(c_=="36"){
                    price =   346290;
                }
            }else if(zz_=="1150"){
                if(c_=="4"){
                    price =   201020;
                }else if(c_=="5"){
                    price =   206480;
                }else if(c_=="6"){
                    price =   211950;
                }else if(c_=="7"){
                    price =   217410;
                }else if(c_=="8"){
                    price =   222870;
                }else if(c_=="9"){
                    price =   228330;
                }else if(c_=="10"){
                    price =   233800;
                }else if(c_=="11"){
                    price =   239260;
                }else if(c_=="12"){
                    price =   244720;
                }else if(c_=="13"){
                    price =   250180;
                }else if(c_=="14"){
                    price =   255650;
                }else if(c_=="15"){
                    price =   261110;
                }else if(c_=="16"){
                    price =   266570;
                }else if(c_=="17"){
                    price =   272030;
                }else if(c_=="18"){
                    price =   277500;
                }else if(c_=="19"){
                    price =   282960;
                }else if(c_=="20"){
                    price =   288420;
                }else if(c_=="21"){
                    price =   293880;
                }else if(c_=="22"){
                    price =   299350;
                }else if(c_=="23"){
                    price =   304810;
                }else if(c_=="24"){
                    price =   310270;
                }else if(c_=="25"){
                    price =   315730;
                }else if(c_=="26"){
                    price =   321190;
                }else if(c_=="27"){
                    price =   326660;
                }else if(c_=="28"){
                    price =   332120;
                }else if(c_=="29"){
                    price =   337580;
                }else if(c_=="30"){
                    price =   343040;
                }else if(c_=="31"){
                    price =   348510;
                }else if(c_=="32"){
                    price =   353970;
                }else if(c_=="33"){
                    price =   359430;
                }else if(c_=="34"){
                    price =   364890;
                }else if(c_=="35"){
                    price =   370360;
                }else if(c_=="36"){
                    price =   375820;
                }
            }else if(zz_=="1350"){
                if(c_=="4"){
                    price =   222290;
                }else if(c_=="5"){
                    price =   227910;
                }else if(c_=="6"){
                    price =   233540;
                }else if(c_=="7"){
                    price =   239160;
                }else if(c_=="8"){
                    price =   244780;
                }else if(c_=="9"){
                    price =   250410;
                }else if(c_=="10"){
                    price =   256030;
                }else if(c_=="11"){
                    price =   261650;
                }else if(c_=="12"){
                    price =   267270;
                }else if(c_=="13"){
                    price =   272900;
                }else if(c_=="14"){
                    price =   278520;
                }else if(c_=="15"){
                    price =   284140;
                }else if(c_=="16"){
                    price =   289770;
                }else if(c_=="17"){
                    price =   295390;
                }else if(c_=="18"){
                    price =   301010;
                }else if(c_=="19"){
                    price =   306630;
                }else if(c_=="20"){
                    price =   312260;
                }else if(c_=="21"){
                    price =   317880;
                }else if(c_=="22"){
                    price =   323500;
                }else if(c_=="23"){
                    price =   329130;
                }else if(c_=="24"){
                    price =   334750;
                }else if(c_=="25"){
                    price =   340370;
                }else if(c_=="26"){
                    price =   345990;
                }else if(c_=="27"){
                    price =   351620;
                }else if(c_=="28"){
                    price =   357240;
                }else if(c_=="29"){
                    price =   362860;
                }else if(c_=="30"){
                    price =   368490;
                }else if(c_=="31"){
                    price =   374110;
                }else if(c_=="32"){
                    price =   379730;
                }else if(c_=="33"){
                    price =   385350;
                }else if(c_=="34"){
                    price =   390980;
                }else if(c_=="35"){
                    price =   396600;
                }else if(c_=="36"){
                    price =   402220;
                }
            }else if(zz_=="1600"){
                if(c_=="4"){
                    price =   224410;
                }else if(c_=="5"){
                    price =   230100;
                }else if(c_=="6"){
                    price =   235800;
                }else if(c_=="7"){
                    price =   241490;
                }else if(c_=="8"){
                    price =   247180;
                }else if(c_=="9"){
                    price =   252880;
                }else if(c_=="10"){
                    price =   258570;
                }else if(c_=="11"){
                    price =   264260;
                }else if(c_=="12"){
                    price =   269960;
                }else if(c_=="13"){
                    price =   275650;
                }else if(c_=="14"){
                    price =   281340;
                }else if(c_=="15"){
                    price =   287040;
                }else if(c_=="16"){
                    price =   292730;
                }else if(c_=="17"){
                    price =   298420;
                }else if(c_=="18"){
                    price =   304120;
                }else if(c_=="19"){
                    price =   309810;
                }else if(c_=="20"){
                    price =   315500;
                }else if(c_=="21"){
                    price =   321200;
                }else if(c_=="22"){
                    price =   326890;
                }else if(c_=="23"){
                    price =   332580;
                }else if(c_=="24"){
                    price =   338270;
                }else if(c_=="25"){
                    price =   343970;
                }else if(c_=="26"){
                    price =   349660;
                }else if(c_=="27"){
                    price =   355350;
                }else if(c_=="28"){
                    price =   361050;
                }else if(c_=="29"){
                    price =   366740;
                }else if(c_=="30"){
                    price =   372430;
                }else if(c_=="31"){
                    price =   378130;
                }else if(c_=="32"){
                    price =   383820;
                }else if(c_=="33"){
                    price =   389510;
                }else if(c_=="34"){
                    price =   395210;
                }else if(c_=="35"){
                    price =   400900;
                }else if(c_=="36"){
                    price =   406590;
                }
            }else if(zz_=="2000"){
                if(c_=="4"){
                    price =   242610;
                }else if(c_=="5"){
                    price =   248300;
                }else if(c_=="6"){
                    price =   254000;
                }else if(c_=="7"){
                    price =   259690;
                }else if(c_=="8"){
                    price =   265380;
                }else if(c_=="9"){
                    price =   271080;
                }else if(c_=="10"){
                    price =   276770;
                }else if(c_=="11"){
                    price =   282460;
                }else if(c_=="12"){
                    price =   288160;
                }else if(c_=="13"){
                    price =   293850;
                }else if(c_=="14"){
                    price =   299540;
                }else if(c_=="15"){
                    price =   305240;
                }else if(c_=="16"){
                    price =   310930;
                }else if(c_=="17"){
                    price =   316620;
                }else if(c_=="18"){
                    price =   322320;
                }else if(c_=="19"){
                    price =   328010;
                }else if(c_=="20"){
                    price =   333700;
                }else if(c_=="21"){
                    price =   339400;
                }else if(c_=="22"){
                    price =   345090;
                }else if(c_=="23"){
                    price =   350780;
                }else if(c_=="24"){
                    price =   356470;
                }else if(c_=="25"){
                    price =   362170;
                }else if(c_=="26"){
                    price =   367860;
                }else if(c_=="27"){
                    price =   373550;
                }else if(c_=="28"){
                    price =   379250;
                }else if(c_=="29"){
                    price =   384940;
                }else if(c_=="30"){
                    price =   390630;
                }else if(c_=="31"){
                    price =   396330;
                }else if(c_=="32"){
                    price =   402020;
                }else if(c_=="33"){
                    price =   407710;
                }else if(c_=="34"){
                    price =   413410;
                }else if(c_=="35"){
                    price =   419100;
                }else if(c_=="36"){
                    price =   424790;
                }
            }
        }else if(sd_=="2.5"){
            if(zz_=="800"){
                if(c_=="5"){
                    price =   173260;
                }else if(c_=="6"){
                    price =   178880;
                }else if(c_=="7"){
                    price =   184490;
                }else if(c_=="8"){
                    price =   190100;
                }else if(c_=="9"){
                    price =   195720;
                }else if(c_=="10"){
                    price =   201330;
                }else if(c_=="11"){
                    price =   206940;
                }else if(c_=="12"){
                    price =   212560;
                }else if(c_=="13"){
                    price =   218170;
                }else if(c_=="14"){
                    price =   223780;
                }else if(c_=="15"){
                    price =   229400;
                }else if(c_=="16"){
                    price =   235010;
                }else if(c_=="17"){
                    price =   240620;
                }else if(c_=="18"){
                    price =   246240;
                }else if(c_=="19"){
                    price =   251850;
                }else if(c_=="20"){
                    price =   257460;
                }else if(c_=="21"){
                    price =   263080;
                }else if(c_=="22"){
                    price =   268690;
                }else if(c_=="23"){
                    price =   274300;
                }else if(c_=="24"){
                    price =   279920;
                }else if(c_=="25"){
                    price =   285530;
                }else if(c_=="26"){
                    price =   291140;
                }else if(c_=="27"){
                    price =   296760;
                }else if(c_=="28"){
                    price =   302370;
                }else if(c_=="29"){
                    price =   307980;
                }else if(c_=="30"){
                    price =   313600;
                }else if(c_=="31"){
                    price =   319210;
                }else if(c_=="32"){
                    price =   324820;
                }else if(c_=="33"){
                    price =   330440;
                }else if(c_=="34"){
                    price =   336050;
                }else if(c_=="35"){
                    price =   341660;
                }else if(c_=="36"){
                    price =   347280;
                }else if(c_=="37"){
                    price =   352890;
                }else if(c_=="38"){
                    price =   358500;
                }else if(c_=="39"){
                    price =   364120;
                }else if(c_=="40"){
                    price =   369730;
                }
            }else if(zz_=="1000"){
                if(c_=="5"){
                    price =    179680;
                }else if(c_=="6"){
                    price =    185360;
                }else if(c_=="7"){
                    price =    191040;
                }else if(c_=="8"){
                    price =    196710;
                }else if(c_=="9"){
                    price =    202390;
                }else if(c_=="10"){
                    price =    208060;
                }else if(c_=="11"){
                    price =    213740;
                }else if(c_=="12"){
                    price =    219420;
                }else if(c_=="13"){
                    price =    225090;
                }else if(c_=="14"){
                    price =    230770;
                }else if(c_=="15"){
                    price =    236440;
                }else if(c_=="16"){
                    price =    242120;
                }else if(c_=="17"){
                    price =    247800;
                }else if(c_=="18"){
                    price =    253470;
                }else if(c_=="19"){
                    price =    259150;
                }else if(c_=="20"){
                    price =    264820;
                }else if(c_=="21"){
                    price =    270500;
                }else if(c_=="22"){
                    price =    276170;
                }else if(c_=="23"){
                    price =    281850;
                }else if(c_=="24"){
                    price =    287530;
                }else if(c_=="25"){
                    price =    293200;
                }else if(c_=="26"){
                    price =    298880;
                }else if(c_=="27"){
                    price =    304550;
                }else if(c_=="28"){
                    price =    310230;
                }else if(c_=="29"){
                    price =    315910;
                }else if(c_=="30"){
                    price =    321580;
                }else if(c_=="31"){
                    price =    327260;
                }else if(c_=="32"){
                    price =    332930;
                }else if(c_=="33"){
                    price =    338610;
                }else if(c_=="34"){
                    price =    344290;
                }else if(c_=="35"){
                    price =    349960;
                }else if(c_=="36"){
                    price =    355640;
                }else if(c_=="37"){
                    price =    361310;
                }else if(c_=="38"){
                    price =    366990;
                }else if(c_=="39"){
                    price =    372670;
                }else if(c_=="40"){
                    price =    378340;
                }
            }else if(zz_=="1150"){
                if(c_=="5"){
                    price =    209150;
                }else if(c_=="6"){
                    price =    214670;
                }else if(c_=="7"){
                    price =    220190;
                }else if(c_=="8"){
                    price =    225710;
                }else if(c_=="9"){
                    price =    231230;
                }else if(c_=="10"){
                    price =    236760;
                }else if(c_=="11"){
                    price =    242280;
                }else if(c_=="12"){
                    price =    247800;
                }else if(c_=="13"){
                    price =    253320;
                }else if(c_=="14"){
                    price =    258850;
                }else if(c_=="15"){
                    price =    264370;
                }else if(c_=="16"){
                    price =    269890;
                }else if(c_=="17"){
                    price =    275410;
                }else if(c_=="18"){
                    price =    280930;
                }else if(c_=="19"){
                    price =    286460;
                }else if(c_=="20"){
                    price =    291980;
                }else if(c_=="21"){
                    price =    297500;
                }else if(c_=="22"){
                    price =    303020;
                }else if(c_=="23"){
                    price =    308550;
                }else if(c_=="24"){
                    price =    314070;
                }else if(c_=="25"){
                    price =    319590;
                }else if(c_=="26"){
                    price =    325110;
                }else if(c_=="27"){
                    price =    330640;
                }else if(c_=="28"){
                    price =    336160;
                }else if(c_=="29"){
                    price =    341680;
                }else if(c_=="30"){
                    price =    347200;
                }else if(c_=="31"){
                    price =    352720;
                }else if(c_=="32"){
                    price =    358250;
                }else if(c_=="33"){
                    price =    363770;
                }else if(c_=="34"){
                    price =    369290;
                }else if(c_=="35"){
                    price =    374810;
                }else if(c_=="36"){
                    price =    380340;
                }else if(c_=="37"){
                    price =    385860;
                }else if(c_=="38"){
                    price =    391380;
                }else if(c_=="39"){
                    price =    396900;
                }else if(c_=="40"){
                    price =    402420;
                }
            }else if(zz_=="1350"){
                if(c_=="5"){
                    price =    233300;
                }else if(c_=="6"){
                    price =    238930;
                }else if(c_=="7"){
                    price =    244550;
                }else if(c_=="8"){
                    price =    250170;
                }else if(c_=="9"){
                    price =    255790;
                }else if(c_=="10"){
                    price =    261420;
                }else if(c_=="11"){
                    price =    267040;
                }else if(c_=="12"){
                    price =    272660;
                }else if(c_=="13"){
                    price =    278290;
                }else if(c_=="14"){
                    price =    283910;
                }else if(c_=="15"){
                    price =    289530;
                }else if(c_=="16"){
                    price =    295150;
                }else if(c_=="17"){
                    price =    300780;
                }else if(c_=="18"){
                    price =    306400;
                }else if(c_=="19"){
                    price =    312020;
                }else if(c_=="20"){
                    price =    317650;
                }else if(c_=="21"){
                    price =    323270;
                }else if(c_=="22"){
                    price =    328890;
                }else if(c_=="23"){
                    price =    334510;
                }else if(c_=="24"){
                    price =    340140;
                }else if(c_=="25"){
                    price =    345760;
                }else if(c_=="26"){
                    price =    351380;
                }else if(c_=="27"){
                    price =    357010;
                }else if(c_=="28"){
                    price =    362630;
                }else if(c_=="29"){
                    price =    368250;
                }else if(c_=="30"){
                    price =    373870;
                }else if(c_=="31"){
                    price =    379500;
                }else if(c_=="32"){
                    price =    385120;
                }else if(c_=="33"){
                    price =    390740;
                }else if(c_=="34"){
                    price =    396370;
                }else if(c_=="35"){
                    price =    401990;
                }else if(c_=="36"){
                    price =    407610;
                }else if(c_=="37"){
                    price =    413230;
                }else if(c_=="38"){
                    price =    418860;
                }else if(c_=="39"){
                    price =    424480;
                }else if(c_=="40"){
                    price =    430100;
                }
            }else if(zz_=="1600"){
                if(c_=="5"){
                    price =    236860;
                }else if(c_=="6"){
                    price =    242480;
                }else if(c_=="7"){
                    price =    248100;
                }else if(c_=="8"){
                    price =    253720;
                }else if(c_=="9"){
                    price =    259350;
                }else if(c_=="10"){
                    price =    264970;
                }else if(c_=="11"){
                    price =    270590;
                }else if(c_=="12"){
                    price =    276220;
                }else if(c_=="13"){
                    price =    281840;
                }else if(c_=="14"){
                    price =    287460;
                }else if(c_=="15"){
                    price =    293080;
                }else if(c_=="16"){
                    price =    298710;
                }else if(c_=="17"){
                    price =    304330;
                }else if(c_=="18"){
                    price =    309950;
                }else if(c_=="19"){
                    price =    315580;
                }else if(c_=="20"){
                    price =    321200;
                }else if(c_=="21"){
                    price =    326820;
                }else if(c_=="22"){
                    price =    332440;
                }else if(c_=="23"){
                    price =    338070;
                }else if(c_=="24"){
                    price =    343690;
                }else if(c_=="25"){
                    price =    349310;
                }else if(c_=="26"){
                    price =    354940;
                }else if(c_=="27"){
                    price =    360560;
                }else if(c_=="28"){
                    price =    366180;
                }else if(c_=="29"){
                    price =    371800;
                }else if(c_=="30"){
                    price =    377430;
                }else if(c_=="31"){
                    price =    383050;
                }else if(c_=="32"){
                    price =    388670;
                }else if(c_=="33"){
                    price =    394300;
                }else if(c_=="34"){
                    price =    399920;
                }else if(c_=="35"){
                    price =    405540;
                }else if(c_=="36"){
                    price =    411160;
                }else if(c_=="37"){
                    price =    416790;
                }else if(c_=="38"){
                    price =    422410;
                }else if(c_=="39"){
                    price =    428030;
                }else if(c_=="40"){
                    price =    433660;
                }
            }else if(zz_=="2000"){
                if(c_=="5"){
                    price =    255060;
                }else if(c_=="6"){
                    price =    260680;
                }else if(c_=="7"){
                    price =    266300;
                }else if(c_=="8"){
                    price =    271920;
                }else if(c_=="9"){
                    price =    277550;
                }else if(c_=="10"){
                    price =    283170;
                }else if(c_=="11"){
                    price =    288790;
                }else if(c_=="12"){
                    price =    294420;
                }else if(c_=="13"){
                    price =    300040;
                }else if(c_=="14"){
                    price =    305660;
                }else if(c_=="15"){
                    price =    311280;
                }else if(c_=="16"){
                    price =    316910;
                }else if(c_=="17"){
                    price =    322530;
                }else if(c_=="18"){
                    price =    328150;
                }else if(c_=="19"){
                    price =    333780;
                }else if(c_=="20"){
                    price =    339400;
                }else if(c_=="21"){
                    price =    345020;
                }else if(c_=="22"){
                    price =    350640;
                }else if(c_=="23"){
                    price =    356270;
                }else if(c_=="24"){
                    price =    361890;
                }else if(c_=="25"){
                    price =    367510;
                }else if(c_=="26"){
                    price =    373140;
                }else if(c_=="27"){
                    price =    378760;
                }else if(c_=="28"){
                    price =    384380;
                }else if(c_=="29"){
                    price =    390000;
                }else if(c_=="30"){
                    price =    395630;
                }else if(c_=="31"){
                    price =    401250;
                }else if(c_=="32"){
                    price =    406870;
                }else if(c_=="33"){
                    price =    412500;
                }else if(c_=="34"){
                    price =    418120;
                }else if(c_=="35"){
                    price =    423740;
                }else if(c_=="36"){
                    price =    429360;
                }else if(c_=="37"){
                    price =    434990;
                }else if(c_=="38"){
                    price =    440610;
                }else if(c_=="39"){
                    price =    446230;
                }else if(c_=="40"){
                    price =    451860;
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
                    price = price-2100*jm;
                }else if(kmkd_=="900"){
                    price = price-2400*jm;
                }else if(kmkd_=="1100"){
                    price = price-2800*jm;
                }else if(kmkd_=="1200"){
                    price = price-3000*jm;
                }
            }
            $("#PRICE").val(price);
        }
    }

    //修改速度时
    function editSd(){
        var sd_ = $("#SD").val();
        if(sd_=="1.0"){
            var appendStr = "<option value=''>请选择</option><option value='3'>3</option><option value='4'>4</option><option value='5'>5</option><option value='6'>6</option><option value='7'>7</option><option value='8'>8</option><option value='9'>9</option><option value='10'>10</option><option value='11'>11</option><option value='12'>12</option><option value='13'>13</option><option value='14'>14</option><option value='15'>15</option><option value='16'>16</option><option value='17'>17</option><option value='18'>18</option><option value='19'>19</option><option value='20'>20</option>";
            $("#C").empty();
            $("#Z").empty();
            $("#M").empty();
            $("#C").append(appendStr);
            $("#Z").append(appendStr);
            $("#M").append(appendStr);
        }else if(sd_=="1.5"){
            var appendStr = "<option value=''>请选择</option><option value='3'>3</option><option value='4'>4</option><option value='5'>5</option><option value='6'>6</option><option value='7'>7</option><option value='8'>8</option><option value='9'>9</option><option value='10'>10</option><option value='11'>11</option><option value='12'>12</option><option value='13'>13</option><option value='14'>14</option><option value='15'>15</option><option value='16'>16</option><option value='17'>17</option><option value='18'>18</option><option value='19'>19</option><option value='20'>20</option><option value='21'>21</option><option value='22'>22</option><option value='23'>23</option><option value='24'>24</option>";
            $("#C").empty();
            $("#Z").empty();
            $("#M").empty();
            $("#C").append(appendStr);
            $("#Z").append(appendStr);
            $("#M").append(appendStr);
        }else if(sd_=="1.75"){
            var appendStr = "<option value=''>请选择</option><option value='4'>4</option><option value='5'>5</option><option value='6'>6</option><option value='7'>7</option><option value='8'>8</option><option value='9'>9</option><option value='10'>10</option><option value='11'>11</option><option value='12'>12</option><option value='13'>13</option><option value='14'>14</option><option value='15'>15</option><option value='16'>16</option><option value='17'>17</option><option value='18'>18</option><option value='19'>19</option><option value='20'>20</option><option value='21'>21</option><option value='22'>22</option><option value='23'>23</option><option value='24'>24</option><option value='25'>25</option><option value='26'>26</option><option value='27'>27</option><option value='28'>28</option><option value='29'>29</option><option value='30'>30</option>";
            $("#C").empty();
            $("#Z").empty();
            $("#M").empty();
            $("#C").append(appendStr);
            $("#Z").append(appendStr);
            $("#M").append(appendStr);
        }else if(sd_=="2.0"){
            var appendStr = "<option value=''>请选择</option><option value='4'>4</option><option value='5'>5</option><option value='6'>6</option><option value='7'>7</option><option value='8'>8</option><option value='9'>9</option><option value='10'>10</option><option value='11'>11</option><option value='12'>12</option><option value='13'>13</option><option value='14'>14</option><option value='15'>15</option><option value='16'>16</option><option value='17'>17</option><option value='18'>18</option><option value='19'>19</option><option value='20'>20</option><option value='21'>21</option><option value='22'>22</option><option value='23'>23</option><option value='24'>24</option><option value='25'>25</option><option value='26'>26</option><option value='27'>27</option><option value='28'>28</option><option value='29'>29</option><option value='30'>30</option><option value='31'>31</option><option value='32'>32</option><option value='33'>33</option><option value='34'>34</option><option value='35'>35</option><option value='36'>36</option>";
            $("#C").empty();
            $("#Z").empty();
            $("#M").empty();
            $("#C").append(appendStr);
            $("#Z").append(appendStr);
            $("#M").append(appendStr);
        }else if(sd_=="2.5"){
            var appendStr = "<option value=''>请选择</option><option value='4'>4</option><option value='5'>5</option><option value='6'>6</option><option value='7'>7</option><option value='8'>8</option><option value='9'>9</option><option value='10'>10</option><option value='11'>11</option><option value='12'>12</option><option value='13'>13</option><option value='14'>14</option><option value='15'>15</option><option value='16'>16</option><option value='17'>17</option><option value='18'>18</option><option value='19'>19</option><option value='20'>20</option><option value='21'>21</option><option value='22'>22</option><option value='23'>23</option><option value='24'>24</option><option value='25'>25</option><option value='26'>26</option><option value='27'>27</option><option value='28'>28</option><option value='29'>29</option><option value='30'>30</option><option value='31'>31</option><option value='32'>32</option><option value='33'>33</option><option value='34'>34</option><option value='35'>35</option><option value='36'>36</option><option value='37'>37</option><option value='38'>38</option><option value='39'>39</option><option value='40'>40</option>";
            $("#C").empty();
            $("#Z").empty();
            $("#M").empty();
            $("#C").append(appendStr);
            $("#Z").append(appendStr);
            $("#M").append(appendStr);
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
