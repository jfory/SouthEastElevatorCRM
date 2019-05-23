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
                                                <option value="800">800</option>
                                                <option value="1000">1000</option>
												<option value="1150">1150</option>
												<option value="1350">1350</option>
                                                <option value="1600">1600</option>
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
                                                <option value="800">800</option>
                                                <option value="900">900</option>
                                                <option value="1100">1100</option>
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
            if(zz_=="800"){
                if(c_=="3"){
                    price = 154460;
                }else if(c_=="4"){
                    price = 160390;
                }else if(c_=="5"){
                    price = 166330;
                }else if(c_=="6"){
                    price = 172260;
                }else if(c_=="7"){
                    price = 178200;
                }else if(c_=="8"){
                    price = 184130;
                }else if(c_=="9"){
                    price = 190070;
                }else if(c_=="10"){
                    price = 196000;
                }else if(c_=="11"){
                    price = 201940;
                }else if(c_=="12"){
                    price = 207870;
                }else if(c_=="13"){
                    price = 214810;
                }else if(c_=="14"){
                    price = 220740;
                }else if(c_=="15"){
                    price = 226680;
                }else if(c_=="16"){
                    price = 232610;
                }else if(c_=="17"){
                    price = 238550;
                }else if(c_=="18"){
                    price = 244490;
                }else if(c_=="19"){
                    price = 250420;
                }else if(c_=="20"){
                    price = 256360;
                }
            }else if(zz_=="1000"){
                if(c_=="3"){
                    price = 162160;
                }else if(c_=="4"){
                    price = 168090;
                }else if(c_=="5"){
                    price = 174030;
                }else if(c_=="6"){
                    price = 179960;
                }else if(c_=="7"){
                    price = 185900;
                }else if(c_=="8"){
                    price = 191830;
                }else if(c_=="9"){
                    price = 197770;
                }else if(c_=="10"){
                    price = 203700;
                }else if(c_=="11"){
                    price = 209640;
                }else if(c_=="12"){
                    price = 215570;
                }else if(c_=="13"){
                    price = 221510;
                }else if(c_=="14"){
                    price = 227440;
                }else if(c_=="15"){
                    price = 233380;
                }else if(c_=="16"){
                    price = 240310;
                }else if(c_=="17"){
                    price = 246250;
                }else if(c_=="18"){
                    price = 252190;
                }else if(c_=="19"){
                    price = 258120;
                }else if(c_=="20"){
                    price = 264060;
                }
            }else if(zz_=="1150"){
                if(c_=="3"){
                    price = 186890;
                }else if(c_=="4"){
                    price = 192780;
                }else if(c_=="5"){
                    price = 198670;
                }else if(c_=="6"){
                    price = 204560;
                }else if(c_=="7"){
                    price = 210450;
                }else if(c_=="8"){
                    price = 216340;
                }else if(c_=="9"){
                    price = 222230;
                }else if(c_=="10"){
                    price = 228120;
                }else if(c_=="11"){
                    price = 234010;
                }else if(c_=="12"){
                    price = 239900;
                }else if(c_=="13"){
                    price = 245790;
                }else if(c_=="14"){
                    price = 251680;
                }else if(c_=="15"){
                    price = 257570;
                }else if(c_=="16"){
                    price = 263460;
                }else if(c_=="17"){
                    price = 269350;
                }else if(c_=="18"){
                    price = 275240;
                }else if(c_=="19"){
                    price = 281130;
                }else if(c_=="20"){
                    price = 287020;
                }
            }else if(zz_=="1350"){
                if(c_=="3"){
                    price = 208350;
                }else if(c_=="4"){
                    price = 214230;
                }else if(c_=="5"){
                    price = 220120;
                }else if(c_=="6"){
                    price = 226000;
                }else if(c_=="7"){
                    price = 231880;
                }else if(c_=="8"){
                    price = 237760;
                }else if(c_=="9"){
                    price = 243640;
                }else if(c_=="10"){
                    price = 249520;
                }else if(c_=="11"){
                    price = 255400;
                }else if(c_=="12"){
                    price = 261280;
                }else if(c_=="13"){
                    price = 267160;
                }else if(c_=="14"){
                    price = 273040;
                }else if(c_=="15"){
                    price = 278920;
                }else if(c_=="16"){
                    price = 284800;
                }else if(c_=="17"){
                    price = 290690;
                }else if(c_=="18"){
                    price = 296570;
                }else if(c_=="19"){
                    price = 302450;
                }else if(c_=="20"){
                    price = 308330;
                }
            }else if(zz_=="1600"){
                if(c_=="3"){
                    price = 211430;
                }else if(c_=="4"){
                    price = 217420;
                }else if(c_=="5"){
                    price = 223410;
                }else if(c_=="6"){
                    price = 229400;
                }else if(c_=="7"){
                    price = 235390;
                }else if(c_=="8"){
                    price = 241370;
                }else if(c_=="9"){
                    price = 247360;
                }else if(c_=="10"){
                    price = 253350;
                }else if(c_=="11"){
                    price = 259340;
                }else if(c_=="12"){
                    price = 265330;
                }else if(c_=="13"){
                    price = 271320;
                }else if(c_=="14"){
                    price = 277300;
                }else if(c_=="15"){
                    price = 283290;
                }else if(c_=="16"){
                    price = 289280;
                }else if(c_=="17"){
                    price = 295270;
                }else if(c_=="18"){
                    price = 301260;
                }else if(c_=="19"){
                    price = 307250;
                }else if(c_=="20"){
                    price = 313230;
                }
            }
        }else if(sd_=="1.5"){   //速度=1.5m/s
            if(zz_=="800"){
                if(c_=="3"){
                    price = 159520;
                }else if(c_=="4"){
                    price = 165450;
                }else if(c_=="5"){
                    price = 171390;
                }else if(c_=="6"){
                    price = 177320;
                }else if(c_=="7"){
                    price = 183260;
                }else if(c_=="8"){
                    price = 189190;
                }else if(c_=="9"){
                    price = 195120;
                }else if(c_=="10"){
                    price = 201060;
                }else if(c_=="11"){
                    price = 206990;
                }else if(c_=="12"){
                    price = 212930;
                }else if(c_=="13"){
                    price = 219860;
                }else if(c_=="14"){
                    price = 225790;
                }else if(c_=="15"){
                    price = 231730;
                }else if(c_=="16"){
                    price = 237670;
                }else if(c_=="17"){
                    price = 243600;
                }else if(c_=="18"){
                    price = 249530;
                }else if(c_=="19"){
                    price = 255470;
                }else if(c_=="20"){
                    price = 261400;
                }else if(c_=="21"){
                    price = 267340;
                }else if(c_=="22"){
                    price = 273270;
                }else if(c_=="23"){
                    price = 279200;
                }else if(c_=="24"){
                    price = 285140;
                }
            }else if(zz_=="1000"){
                if(c_=="3"){
                    price = 167220;
                }else if(c_=="4"){
                    price = 173150;
                }else if(c_=="5"){
                    price = 179090;
                }else if(c_=="6"){
                    price = 185020;
                }else if(c_=="7"){
                    price = 190960;
                }else if(c_=="8"){
                    price = 196890;
                }else if(c_=="9"){
                    price = 202820;
                }else if(c_=="10"){
                    price = 208760;
                }else if(c_=="11"){
                    price = 214690;
                }else if(c_=="12"){
                    price = 220630;
                }else if(c_=="13"){
                    price = 226560;
                }else if(c_=="14"){
                    price = 232490;
                }else if(c_=="15"){
                    price = 238430;
                }else if(c_=="16"){
                    price = 245370;
                }else if(c_=="17"){
                    price = 251300;
                }else if(c_=="18"){
                    price = 257230;
                }else if(c_=="19"){
                    price = 263170;
                }else if(c_=="20"){
                    price = 269100;
                }else if(c_=="21"){
                    price = 275040;
                }else if(c_=="22"){
                    price = 280970;
                }else if(c_=="23"){
                    price = 286900;
                }else if(c_=="24"){
                    price = 292840;
                }
            }else if(zz_=="1150"){
                if(c_=="3"){
                    price = 188210;
                }else if(c_=="4"){
                    price = 194080;
                }else if(c_=="5"){
                    price = 199950;
                }else if(c_=="6"){
                    price = 205820;
                }else if(c_=="7"){
                    price = 211700;
                }else if(c_=="8"){
                    price = 217570;
                }else if(c_=="9"){
                    price = 223440;
                }else if(c_=="10"){
                    price = 229310;
                }else if(c_=="11"){
                    price = 235180;
                }else if(c_=="12"){
                    price = 241060;
                }else if(c_=="13"){
                    price = 246930;
                }else if(c_=="14"){
                    price = 252800;
                }else if(c_=="15"){
                    price = 258670;
                }else if(c_=="16"){
                    price = 264550;
                }else if(c_=="17"){
                    price = 270420;
                }else if(c_=="18"){
                    price = 276290;
                }else if(c_=="19"){
                    price = 282160;
                }else if(c_=="20"){
                    price = 288030;
                }else if(c_=="21"){
                    price = 293910;
                }else if(c_=="22"){
                    price = 299780;
                }else if(c_=="23"){
                    price = 305650;
                }else if(c_=="24"){
                    price = 311520;
                }
            }else if(zz_=="1350"){
                if(c_=="3"){
                    price = 212070;
                }else if(c_=="4"){
                    price = 217890;
                }else if(c_=="5"){
                    price = 223720;
                }else if(c_=="6"){
                    price = 229540;
                }else if(c_=="7"){
                    price = 235360;
                }else if(c_=="8"){
                    price = 241190;
                }else if(c_=="9"){
                    price = 247010;
                }else if(c_=="10"){
                    price = 252830;
                }else if(c_=="11"){
                    price = 258660;
                }else if(c_=="12"){
                    price = 264480;
                }else if(c_=="13"){
                    price = 270310;
                }else if(c_=="14"){
                    price = 276130;
                }else if(c_=="15"){
                    price = 281950;
                }else if(c_=="16"){
                    price = 287780;
                }else if(c_=="17"){
                    price = 293600;
                }else if(c_=="18"){
                    price = 299430;
                }else if(c_=="19"){
                    price = 305250;
                }else if(c_=="20"){
                    price = 311070;
                }else if(c_=="21"){
                    price = 316900;
                }else if(c_=="22"){
                    price = 322720;
                }else if(c_=="23"){
                    price = 328550;
                }else if(c_=="24"){
                    price = 334370;
                }
            }else if(zz_=="1600"){
                if(c_=="3"){
                    price = 219780;
                }else if(c_=="4"){
                    price = 225650;
                }else if(c_=="5"){
                    price = 231530;
                }else if(c_=="6"){
                    price = 237400;
                }else if(c_=="7"){
                    price = 243270;
                }else if(c_=="8"){
                    price = 249150;
                }else if(c_=="9"){
                    price = 255020;
                }else if(c_=="10"){
                    price = 260890;
                }else if(c_=="11"){
                    price = 266770;
                }else if(c_=="12"){
                    price = 272640;
                }else if(c_=="13"){
                    price = 278510;
                }else if(c_=="14"){
                    price = 284380;
                }else if(c_=="15"){
                    price = 290260;
                }else if(c_=="16"){
                    price = 296130;
                }else if(c_=="17"){
                    price = 302000;
                }else if(c_=="18"){
                    price = 307880;
                }else if(c_=="19"){
                    price = 313750;
                }else if(c_=="20"){
                    price = 319620;
                }else if(c_=="21"){
                    price = 325490;
                }else if(c_=="22"){
                    price = 331370;
                }else if(c_=="23"){
                    price = 337240;
                }else if(c_=="24"){
                    price = 343110;
                }
            }
        }else if(sd_=="1.75"){  //速度=1.75m/s
            if(zz_=="800"){
                if(c_=="4"){
                    price = 169490;
                }else if(c_=="5"){
                    price = 175430;
                }else if(c_=="6"){
                    price = 181360;
                }else if(c_=="7"){
                    price = 187300;
                }else if(c_=="8"){
                    price = 193240;
                }else if(c_=="9"){
                    price = 199180;
                }else if(c_=="10"){
                    price = 205120;
                }else if(c_=="11"){
                    price = 211060;
                }else if(c_=="12"){
                    price = 217000;
                }else if(c_=="13"){
                    price = 223940;
                }else if(c_=="14"){
                    price = 229880;
                }else if(c_=="15"){
                    price = 235820;
                }else if(c_=="16"){
                    price = 241750;
                }else if(c_=="17"){
                    price = 247690;
                }else if(c_=="18"){
                    price = 253630;
                }else if(c_=="19"){
                    price = 259570;
                }else if(c_=="20"){
                    price = 265510;
                }else if(c_=="21"){
                    price = 271450;
                }else if(c_=="22"){
                    price = 277390;
                }else if(c_=="23"){
                    price = 283330;
                }else if(c_=="24"){
                    price = 289270;
                }else if(c_=="25"){
                    price = 295200;
                }else if(c_=="26"){
                    price = 301140;
                }else if(c_=="27"){
                    price = 307080;
                }else if(c_=="28"){
                    price = 313020;
                }else if(c_=="29"){
                    price = 318960;
                }else if(c_=="30"){
                    price = 324900;
                }
            }else if(zz_=="1000"){
                if(c_=="4"){
                    price = 177190;
                }else if(c_=="5"){
                    price = 183130;
                }else if(c_=="6"){
                    price = 189060;
                }else if(c_=="7"){
                    price = 195000;
                }else if(c_=="8"){
                    price = 200940;
                }else if(c_=="9"){
                    price = 206880;
                }else if(c_=="10"){
                    price = 212820;
                }else if(c_=="11"){
                    price = 218760;
                }else if(c_=="12"){
                    price = 224700;
                }else if(c_=="13"){
                    price = 230640;
                }else if(c_=="14"){
                    price = 236580;
                }else if(c_=="15"){
                    price = 242520;
                }else if(c_=="16"){
                    price = 249450;
                }else if(c_=="17"){
                    price = 255390;
                }else if(c_=="18"){
                    price = 261330;
                }else if(c_=="19"){
                    price = 267270;
                }else if(c_=="20"){
                    price = 273210;
                }else if(c_=="21"){
                    price = 279150;
                }else if(c_=="22"){
                    price = 285090;
                }else if(c_=="23"){
                    price = 291030;
                }else if(c_=="24"){
                    price = 296970;
                }else if(c_=="25"){
                    price = 302900;
                }else if(c_=="26"){
                    price = 308840;
                }else if(c_=="27"){
                    price = 314780;
                }else if(c_=="28"){
                    price = 320720;
                }else if(c_=="29"){
                    price = 326660;
                }else if(c_=="30"){
                    price = 332600;
                }
            }else if(zz_=="1150"){
                if(c_=="4"){
                    price = 194890;
                }else if(c_=="5"){
                    price = 200860;
                }else if(c_=="6"){
                    price = 206820;
                }else if(c_=="7"){
                    price = 212790;
                }else if(c_=="8"){
                    price = 218760;
                }else if(c_=="9"){
                    price = 224730;
                }else if(c_=="10"){
                    price = 230700;
                }else if(c_=="11"){
                    price = 236670;
                }else if(c_=="12"){
                    price = 242640;
                }else if(c_=="13"){
                    price = 248610;
                }else if(c_=="14"){
                    price = 254580;
                }else if(c_=="15"){
                    price = 260550;
                }else if(c_=="16"){
                    price = 266510;
                }else if(c_=="17"){
                    price = 272480;
                }else if(c_=="18"){
                    price = 278450;
                }else if(c_=="19"){
                    price = 284420;
                }else if(c_=="20"){
                    price = 290390;
                }else if(c_=="21"){
                    price = 296360;
                }else if(c_=="22"){
                    price = 302330;
                }else if(c_=="23"){
                    price = 308300;
                }else if(c_=="24"){
                    price = 314270;
                }else if(c_=="25"){
                    price = 320230;
                }else if(c_=="26"){
                    price = 326200;
                }else if(c_=="27"){
                    price = 332170;
                }else if(c_=="28"){
                    price = 338140;
                }else if(c_=="29"){
                    price = 344110;
                }else if(c_=="30"){
                    price = 350080;
                }
            }else if(zz_=="1350"){
                if(c_=="4"){
                    price = 224230;
                }else if(c_=="5"){
                    price = 230020;
                }else if(c_=="6"){
                    price = 235810;
                }else if(c_=="7"){
                    price = 241610;
                }else if(c_=="8"){
                    price = 247400;
                }else if(c_=="9"){
                    price = 253190;
                }else if(c_=="10"){
                    price = 258980;
                }else if(c_=="11"){
                    price = 264780;
                }else if(c_=="12"){
                    price = 270570;
                }else if(c_=="13"){
                    price = 276360;
                }else if(c_=="14"){
                    price = 282160;
                }else if(c_=="15"){
                    price = 287950;
                }else if(c_=="16"){
                    price = 293740;
                }else if(c_=="17"){
                    price = 299530;
                }else if(c_=="18"){
                    price = 305330;
                }else if(c_=="19"){
                    price = 311120;
                }else if(c_=="20"){
                    price = 316910;
                }else if(c_=="21"){
                    price = 322700;
                }else if(c_=="22"){
                    price = 328500;
                }else if(c_=="23"){
                    price = 334290;
                }else if(c_=="24"){
                    price = 340080;
                }else if(c_=="25"){
                    price = 345880;
                }else if(c_=="26"){
                    price = 351670;
                }else if(c_=="27"){
                    price = 357460;
                }else if(c_=="28"){
                    price = 363250;
                }else if(c_=="29"){
                    price = 369050;
                }else if(c_=="30"){
                    price = 374840;
                }
            }else if(zz_=="1600"){
                if(c_=="4"){
                    price = 229750;
                }else if(c_=="5"){
                    price = 235650;
                }else if(c_=="6"){
                    price = 241560;
                }else if(c_=="7"){
                    price = 247460;
                }else if(c_=="8"){
                    price = 253370;
                }else if(c_=="9"){
                    price = 259270;
                }else if(c_=="10"){
                    price = 265180;
                }else if(c_=="11"){
                    price = 271080;
                }else if(c_=="12"){
                    price = 276990;
                }else if(c_=="13"){
                    price = 282890;
                }else if(c_=="14"){
                    price = 288800;
                }else if(c_=="15"){
                    price = 294700;
                }else if(c_=="16"){
                    price = 300610;
                }else if(c_=="17"){
                    price = 306510;
                }else if(c_=="18"){
                    price = 312420;
                }else if(c_=="19"){
                    price = 318320;
                }else if(c_=="20"){
                    price = 324230;
                }else if(c_=="21"){
                    price = 330130;
                }else if(c_=="22"){
                    price = 336040;
                }else if(c_=="23"){
                    price = 341940;
                }else if(c_=="24"){
                    price = 347850;
                }else if(c_=="25"){
                    price = 353750;
                }else if(c_=="26"){
                    price = 359660;
                }else if(c_=="27"){
                    price = 365560;
                }else if(c_=="28"){
                    price = 371470;
                }else if(c_=="29"){
                    price = 377370;
                }else if(c_=="30"){
                    price = 383280;
                }
            }
        }else if(sd_=="2.0"){
            if(zz_=="800"){
                if(c_=="4"){
                    price =   190040;
                }else if(c_=="5"){
                    price =   196610;
                }else if(c_=="6"){
                    price =   203180;
                }else if(c_=="7"){
                    price =   209750;
                }else if(c_=="8"){
                    price =   216320;
                }else if(c_=="9"){
                    price =   222890;
                }else if(c_=="10"){
                    price =   229460;
                }else if(c_=="11"){
                    price =   236030;
                }else if(c_=="12"){
                    price =   242600;
                }else if(c_=="13"){
                    price =   249180;
                }else if(c_=="14"){
                    price =   255740;
                }else if(c_=="15"){
                    price =   262310;
                }else if(c_=="16"){
                    price =   268890;
                }else if(c_=="17"){
                    price =   275460;
                }else if(c_=="18"){
                    price =   282020;
                }else if(c_=="19"){
                    price =   288600;
                }else if(c_=="20"){
                    price =   295170;
                }else if(c_=="21"){
                    price =   301740;
                }else if(c_=="22"){
                    price =   308300;
                }else if(c_=="23"){
                    price =   314880;
                }else if(c_=="24"){
                    price =   321450;
                }else if(c_=="25"){
                    price =   328020;
                }else if(c_=="26"){
                    price =   334600;
                }else if(c_=="27"){
                    price =   341160;
                }else if(c_=="28"){
                    price =   347730;
                }else if(c_=="29"){
                    price =   354310;
                }else if(c_=="30"){
                    price =   360880;
                }else if(c_=="31"){
                    price =   367440;
                }else if(c_=="32"){
                    price =   374020;
                }else if(c_=="33"){
                    price =   380590;
                }else if(c_=="34"){
                    price =   387160;
                }else if(c_=="35"){
                    price =   393720;
                }else if(c_=="36"){
                    price =   400300;
                }
            }else if(zz_=="1000"){
                if(c_=="4"){
                    price =    195740;
                }else if(c_=="5"){
                    price =    202280;
                }else if(c_=="6"){
                    price =    208810;
                }else if(c_=="7"){
                    price =    215350;
                }else if(c_=="8"){
                    price =    221890;
                }else if(c_=="9"){
                    price =    228430;
                }else if(c_=="10"){
                    price =    234960;
                }else if(c_=="11"){
                    price =    241500;
                }else if(c_=="12"){
                    price =    248040;
                }else if(c_=="13"){
                    price =    254590;
                }else if(c_=="14"){
                    price =    261110;
                }else if(c_=="15"){
                    price =    267650;
                }else if(c_=="16"){
                    price =    274200;
                }else if(c_=="17"){
                    price =    280740;
                }else if(c_=="18"){
                    price =    287270;
                }else if(c_=="19"){
                    price =    293810;
                }else if(c_=="20"){
                    price =    300350;
                }else if(c_=="21"){
                    price =    306890;
                }else if(c_=="22"){
                    price =    313420;
                }else if(c_=="23"){
                    price =    319960;
                }else if(c_=="24"){
                    price =    326500;
                }else if(c_=="25"){
                    price =    333040;
                }else if(c_=="26"){
                    price =    339590;
                }else if(c_=="27"){
                    price =    346110;
                }else if(c_=="28"){
                    price =    352650;
                }else if(c_=="29"){
                    price =    359200;
                }else if(c_=="30"){
                    price =    365740;
                }else if(c_=="31"){
                    price =    372260;
                }else if(c_=="32"){
                    price =    378810;
                }else if(c_=="33"){
                    price =    385350;
                }else if(c_=="34"){
                    price =    391890;
                }else if(c_=="35"){
                    price =    398410;
                }else if(c_=="36"){
                    price =    404960;
                }
            }else if(zz_=="1150"){
                if(c_=="4"){
                    price =   228950;
                }else if(c_=="5"){
                    price =   235370;
                }else if(c_=="6"){
                    price =   241800;
                }else if(c_=="7"){
                    price =   248220;
                }else if(c_=="8"){
                    price =   254640;
                }else if(c_=="9"){
                    price =   261060;
                }else if(c_=="10"){
                    price =   267490;
                }else if(c_=="11"){
                    price =   273910;
                }else if(c_=="12"){
                    price =   280330;
                }else if(c_=="13"){
                    price =   286760;
                }else if(c_=="14"){
                    price =   293180;
                }else if(c_=="15"){
                    price =   299600;
                }else if(c_=="16"){
                    price =   306030;
                }else if(c_=="17"){
                    price =   312450;
                }else if(c_=="18"){
                    price =   318870;
                }else if(c_=="19"){
                    price =   325300;
                }else if(c_=="20"){
                    price =   331720;
                }else if(c_=="21"){
                    price =   338140;
                }else if(c_=="22"){
                    price =   344560;
                }else if(c_=="23"){
                    price =   350990;
                }else if(c_=="24"){
                    price =   357410;
                }else if(c_=="25"){
                    price =   363830;
                }else if(c_=="26"){
                    price =   370260;
                }else if(c_=="27"){
                    price =   376680;
                }else if(c_=="28"){
                    price =   383100;
                }else if(c_=="29"){
                    price =   389530;
                }else if(c_=="30"){
                    price =   395950;
                }else if(c_=="31"){
                    price =   402370;
                }else if(c_=="32"){
                    price =   408800;
                }else if(c_=="33"){
                    price =   415220;
                }else if(c_=="34"){
                    price =   421640;
                }else if(c_=="35"){
                    price =   428060;
                }else if(c_=="36"){
                    price =   434490;
                }
            }else if(zz_=="1350"){
                if(c_=="4"){
                    price =   251280;
                }else if(c_=="5"){
                    price =   257870;
                }else if(c_=="6"){
                    price =   264470;
                }else if(c_=="7"){
                    price =   271060;
                }else if(c_=="8"){
                    price =   277650;
                }else if(c_=="9"){
                    price =   284240;
                }else if(c_=="10"){
                    price =   290830;
                }else if(c_=="11"){
                    price =   297420;
                }else if(c_=="12"){
                    price =   304010;
                }else if(c_=="13"){
                    price =   310610;
                }else if(c_=="14"){
                    price =   317200;
                }else if(c_=="15"){
                    price =   323790;
                }else if(c_=="16"){
                    price =   330380;
                }else if(c_=="17"){
                    price =   336970;
                }else if(c_=="18"){
                    price =   343560;
                }else if(c_=="19"){
                    price =   350160;
                }else if(c_=="20"){
                    price =   356750;
                }else if(c_=="21"){
                    price =   363340;
                }else if(c_=="22"){
                    price =   369930;
                }else if(c_=="23"){
                    price =   376520;
                }else if(c_=="24"){
                    price =   383110;
                }else if(c_=="25"){
                    price =   389700;
                }else if(c_=="26"){
                    price =   396300;
                }else if(c_=="27"){
                    price =   402890;
                }else if(c_=="28"){
                    price =   409480;
                }else if(c_=="29"){
                    price =   416070;
                }else if(c_=="30"){
                    price =   422660;
                }else if(c_=="31"){
                    price =   429250;
                }else if(c_=="32"){
                    price =   435840;
                }else if(c_=="33"){
                    price =   442440;
                }else if(c_=="34"){
                    price =   449030;
                }else if(c_=="35"){
                    price =   455620;
                }else if(c_=="36"){
                    price =   462210;
                }
            }else if(zz_=="1600"){
                if(c_=="4"){
                    price =   253510;
                }else if(c_=="5"){
                    price =   260170;
                }else if(c_=="6"){
                    price =   266840;
                }else if(c_=="7"){
                    price =   273510;
                }else if(c_=="8"){
                    price =   280170;
                }else if(c_=="9"){
                    price =   286840;
                }else if(c_=="10"){
                    price =   293500;
                }else if(c_=="11"){
                    price =   300170;
                }else if(c_=="12"){
                    price =   306830;
                }else if(c_=="13"){
                    price =   313500;
                }else if(c_=="14"){
                    price =   320160;
                }else if(c_=="15"){
                    price =   326830;
                }else if(c_=="16"){
                    price =   333490;
                }else if(c_=="17"){
                    price =   340160;
                }else if(c_=="18"){
                    price =   346820;
                }else if(c_=="19"){
                    price =   353490;
                }else if(c_=="20"){
                    price =   360150;
                }else if(c_=="21"){
                    price =   366820;
                }else if(c_=="22"){
                    price =   373490;
                }else if(c_=="23"){
                    price =   380150;
                }else if(c_=="24"){
                    price =   386820;
                }else if(c_=="25"){
                    price =   393480;
                }else if(c_=="26"){
                    price =   400150;
                }else if(c_=="27"){
                    price =   406810;
                }else if(c_=="28"){
                    price =   413480;
                }else if(c_=="29"){
                    price =   420140;
                }else if(c_=="30"){
                    price =   426810;
                }else if(c_=="31"){
                    price =   433470;
                }else if(c_=="32"){
                    price =   440140;
                }else if(c_=="33"){
                    price =   446800;
                }else if(c_=="34"){
                    price =   453470;
                }else if(c_=="35"){
                    price =   460130;
                }else if(c_=="36"){
                    price =   466800;
                }
            }
        }else if(sd_=="2.5"){
            if(zz_=="800"){
                if(c_=="5"){
                    price =    202280;
                }else if(c_=="6"){
                    price =    208860;
                }else if(c_=="7"){
                    price =    215440;
                }else if(c_=="8"){
                    price =    222020;
                }else if(c_=="9"){
                    price =    228600;
                }else if(c_=="10"){
                    price =    235170;
                }else if(c_=="11"){
                    price =    241740;
                }else if(c_=="12"){
                    price =    248330;
                }else if(c_=="13"){
                    price =    254900;
                }else if(c_=="14"){
                    price =    261470;
                }else if(c_=="15"){
                    price =    268060;
                }else if(c_=="16"){
                    price =    274630;
                }else if(c_=="17"){
                    price =    281210;
                }else if(c_=="18"){
                    price =    287790;
                }else if(c_=="19"){
                    price =    294360;
                }else if(c_=="20"){
                    price =    300940;
                }else if(c_=="21"){
                    price =    307520;
                }else if(c_=="22"){
                    price =    314100;
                }else if(c_=="23"){
                    price =    320660;
                }else if(c_=="24"){
                    price =    327250;
                }else if(c_=="25"){
                    price =    333820;
                }else if(c_=="26"){
                    price =    340400;
                }else if(c_=="27"){
                    price =    346980;
                }else if(c_=="28"){
                    price =    353550;
                }else if(c_=="29"){
                    price =    360130;
                }else if(c_=="30"){
                    price =    366710;
                }else if(c_=="31"){
                    price =    373290;
                }else if(c_=="32"){
                    price =    379860;
                }else if(c_=="33"){
                    price =    386440;
                }else if(c_=="34"){
                    price =    393020;
                }else if(c_=="35"){
                    price =    399590;
                }else if(c_=="36"){
                    price =    406170;
                }else if(c_=="37"){
                    price =    412750;
                }else if(c_=="38"){
                    price =    419320;
                }else if(c_=="39"){
                    price =    425910;
                }else if(c_=="40"){
                    price =    432480;
                }
            }else if(zz_=="1000"){
                if(c_=="5"){
                    price =     208700;
                }else if(c_=="6"){
                    price =     215340;
                }else if(c_=="7"){
                    price =     221990;
                }else if(c_=="8"){
                    price =     228630;
                }else if(c_=="9"){
                    price =     235270;
                }else if(c_=="10"){
                    price =     241900;
                }else if(c_=="11"){
                    price =     248540;
                }else if(c_=="12"){
                    price =     255190;
                }else if(c_=="13"){
                    price =     261820;
                }else if(c_=="14"){
                    price =     268460;
                }else if(c_=="15"){
                    price =     275100;
                }else if(c_=="16"){
                    price =     281740;
                }else if(c_=="17"){
                    price =     288390;
                }else if(c_=="18"){
                    price =     295020;
                }else if(c_=="19"){
                    price =     301660;
                }else if(c_=="20"){
                    price =     308300;
                }else if(c_=="21"){
                    price =     314940;
                }else if(c_=="22"){
                    price =     321580;
                }else if(c_=="23"){
                    price =     328210;
                }else if(c_=="24"){
                    price =     334860;
                }else if(c_=="25"){
                    price =     341490;
                }else if(c_=="26"){
                    price =     348140;
                }else if(c_=="27"){
                    price =     354770;
                }else if(c_=="28"){
                    price =     361410;
                }else if(c_=="29"){
                    price =     368060;
                }else if(c_=="30"){
                    price =     374690;
                }else if(c_=="31"){
                    price =     381340;
                }else if(c_=="32"){
                    price =     387970;
                }else if(c_=="33"){
                    price =     394610;
                }else if(c_=="34"){
                    price =     401260;
                }else if(c_=="35"){
                    price =     407890;
                }else if(c_=="36"){
                    price =     414530;
                }else if(c_=="37"){
                    price =     421170;
                }else if(c_=="38"){
                    price =     427810;
                }else if(c_=="39"){
                    price =     434460;
                }else if(c_=="40"){
                    price =     441090;
                }
            }else if(zz_=="1150"){
                if(c_=="5"){
                    price =     238170;
                }else if(c_=="6"){
                    price =     244650;
                }else if(c_=="7"){
                    price =     251140;
                }else if(c_=="8"){
                    price =     257630;
                }else if(c_=="9"){
                    price =     264110;
                }else if(c_=="10"){
                    price =     270600;
                }else if(c_=="11"){
                    price =     277080;
                }else if(c_=="12"){
                    price =     283570;
                }else if(c_=="13"){
                    price =     290050;
                }else if(c_=="14"){
                    price =     296540;
                }else if(c_=="15"){
                    price =     303030;
                }else if(c_=="16"){
                    price =     309510;
                }else if(c_=="17"){
                    price =     316000;
                }else if(c_=="18"){
                    price =     322480;
                }else if(c_=="19"){
                    price =     328970;
                }else if(c_=="20"){
                    price =     335460;
                }else if(c_=="21"){
                    price =     341940;
                }else if(c_=="22"){
                    price =     348430;
                }else if(c_=="23"){
                    price =     354910;
                }else if(c_=="24"){
                    price =     361400;
                }else if(c_=="25"){
                    price =     367880;
                }else if(c_=="26"){
                    price =     374370;
                }else if(c_=="27"){
                    price =     380860;
                }else if(c_=="28"){
                    price =     387340;
                }else if(c_=="29"){
                    price =     393830;
                }else if(c_=="30"){
                    price =     400310;
                }else if(c_=="31"){
                    price =     406800;
                }else if(c_=="32"){
                    price =     413290;
                }else if(c_=="33"){
                    price =     419770;
                }else if(c_=="34"){
                    price =     426260;
                }else if(c_=="35"){
                    price =     432740;
                }else if(c_=="36"){
                    price =     439230;
                }else if(c_=="37"){
                    price =     445720;
                }else if(c_=="38"){
                    price =     452200;
                }else if(c_=="39"){
                    price =     458690;
                }else if(c_=="40"){
                    price =     465170;
                }
            }else if(zz_=="1350"){
                if(c_=="5"){
                    price =     263530;
                }else if(c_=="6"){
                    price =     270120;
                }else if(c_=="7"){
                    price =     276720;
                }else if(c_=="8"){
                    price =     283310;
                }else if(c_=="9"){
                    price =     289900;
                }else if(c_=="10"){
                    price =     296490;
                }else if(c_=="11"){
                    price =     303080;
                }else if(c_=="12"){
                    price =     309670;
                }else if(c_=="13"){
                    price =     316270;
                }else if(c_=="14"){
                    price =     322860;
                }else if(c_=="15"){
                    price =     329450;
                }else if(c_=="16"){
                    price =     336040;
                }else if(c_=="17"){
                    price =     342630;
                }else if(c_=="18"){
                    price =     349220;
                }else if(c_=="19"){
                    price =     355810;
                }else if(c_=="20"){
                    price =     362410;
                }else if(c_=="21"){
                    price =     369000;
                }else if(c_=="22"){
                    price =     375590;
                }else if(c_=="23"){
                    price =     382180;
                }else if(c_=="24"){
                    price =     388770;
                }else if(c_=="25"){
                    price =     395360;
                }else if(c_=="26"){
                    price =     401950;
                }else if(c_=="27"){
                    price =     408550;
                }else if(c_=="28"){
                    price =     415140;
                }else if(c_=="29"){
                    price =     421730;
                }else if(c_=="30"){
                    price =     428320;
                }else if(c_=="31"){
                    price =     434910;
                }else if(c_=="32"){
                    price =     441500;
                }else if(c_=="33"){
                    price =     448090;
                }else if(c_=="34"){
                    price =     454690;
                }else if(c_=="35"){
                    price =     461280;
                }else if(c_=="36"){
                    price =     467870;
                }else if(c_=="37"){
                    price =     474460;
                }else if(c_=="38"){
                    price =     481050;
                }else if(c_=="39"){
                    price =     487640;
                }else if(c_=="40"){
                    price =     494240;
                }
            }else if(zz_=="1600"){
                if(c_=="5"){
                    price =     267260;
                }else if(c_=="6"){
                    price =     273850;
                }else if(c_=="7"){
                    price =     280450;
                }else if(c_=="8"){
                    price =     287040;
                }else if(c_=="9"){
                    price =     293630;
                }else if(c_=="10"){
                    price =     300220;
                }else if(c_=="11"){
                    price =     306810;
                }else if(c_=="12"){
                    price =     313400;
                }else if(c_=="13"){
                    price =     320000;
                }else if(c_=="14"){
                    price =     326590;
                }else if(c_=="15"){
                    price =     333180;
                }else if(c_=="16"){
                    price =     339770;
                }else if(c_=="17"){
                    price =     346360;
                }else if(c_=="18"){
                    price =     352950;
                }else if(c_=="19"){
                    price =     359540;
                }else if(c_=="20"){
                    price =     366140;
                }else if(c_=="21"){
                    price =     372730;
                }else if(c_=="22"){
                    price =     379320;
                }else if(c_=="23"){
                    price =     385910;
                }else if(c_=="24"){
                    price =     392500;
                }else if(c_=="25"){
                    price =     399090;
                }else if(c_=="26"){
                    price =     405680;
                }else if(c_=="27"){
                    price =     412280;
                }else if(c_=="28"){
                    price =     418870;
                }else if(c_=="29"){
                    price =     425460;
                }else if(c_=="30"){
                    price =     432050;
                }else if(c_=="31"){
                    price =     438640;
                }else if(c_=="32"){
                    price =     445230;
                }else if(c_=="33"){
                    price =     451830;
                }else if(c_=="34"){
                    price =     458420;
                }else if(c_=="35"){
                    price =     465010;
                }else if(c_=="36"){
                    price =     471600;
                }else if(c_=="37"){
                    price =     478190;
                }else if(c_=="38"){
                    price =     484780;
                }else if(c_=="39"){
                    price =     491370;
                }else if(c_=="40"){
                    price =     497970;
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
            var appendStr = "<option value=''>请选择</option><option value='5'>5</option><option value='6'>6</option><option value='7'>7</option><option value='8'>8</option><option value='9'>9</option><option value='10'>10</option><option value='11'>11</option><option value='12'>12</option><option value='13'>13</option><option value='14'>14</option><option value='15'>15</option><option value='16'>16</option><option value='17'>17</option><option value='18'>18</option><option value='19'>19</option><option value='20'>20</option><option value='21'>21</option><option value='22'>22</option><option value='23'>23</option><option value='24'>24</option><option value='25'>25</option><option value='26'>26</option><option value='27'>27</option><option value='28'>28</option><option value='29'>29</option><option value='30'>30</option><option value='31'>31</option><option value='32'>32</option><option value='33'>33</option><option value='34'>34</option><option value='35'>35</option><option value='36'>36</option><option value='37'>37</option><option value='38'>38</option><option value='39'>39</option><option value='40'>40</option>";
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
        $("#regelevStandardForm").submit();
    }
    
    
    function CloseSUWin(id) {
        window.parent.$("#" + id).data("kendoWindow").close();
    }
    
	</script>
</html>
