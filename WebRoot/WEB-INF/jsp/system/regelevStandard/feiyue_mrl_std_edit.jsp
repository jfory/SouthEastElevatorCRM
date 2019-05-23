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
                                                <option value="1.5">1.5</option>
                                                <option value="1.75">1.75</option>
											</select>
											&nbsp;&nbsp;&nbsp;
											<span style="color: red">*</span>
											<label style="width: 10%">电梯载重(KG):</label>
											<select style="width: 18%" class="form-control" id="ZZ" name="ZZ" onchange="setSbj()">
												<option value="">请选择</option>
                                                <option value="630">630</option>
                                                <option value="800">800</option>
                                                <option value="1000">1000</option>
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
                    price = 117910;
                }else if(c_=="4"){
                    price = 122300;
                }else if(c_=="5"){
                    price = 126700;
                }else if(c_=="6"){
                    price = 131090;
                }else if(c_=="7"){
                    price = 135480;
                }else if(c_=="8"){
                    price = 139870;
                }else if(c_=="9"){
                    price = 144260;
                }else if(c_=="10"){
                    price = 148650;
                }else if(c_=="11"){
                    price = 153040;
                }else if(c_=="12"){
                    price = 157440;
                }else if(c_=="13"){
                    price = 161830;
                }else if(c_=="14"){
                    price = 166220;
                }else if(c_=="15"){
                    price = 170610;
                }
            }else if(zz_=="800"){
                if(c_=="3"){
                    price = 118750;
                }else if(c_=="4"){
                    price = 123220;
                }else if(c_=="5"){
                    price = 127690;
                }else if(c_=="6"){
                    price = 132160;
                }else if(c_=="7"){
                    price = 136630;
                }else if(c_=="8"){
                    price = 141100;
                }else if(c_=="9"){
                    price = 145570;
                }else if(c_=="10"){
                    price = 150040;
                }else if(c_=="11"){
                    price = 156550;
                }else if(c_=="12"){
                    price = 161160;
                }else if(c_=="13"){
                    price = 165770;
                }else if(c_=="14"){
                    price = 170380;
                }else if(c_=="15"){
                    price = 174990;
                }
            }else if(zz_=="1000"){
                if(c_=="3"){
                    price = 122820;
                }else if(c_=="4"){
                    price = 127510;
                }else if(c_=="5"){
                    price = 132190;
                }else if(c_=="6"){
                    price = 136880;
                }else if(c_=="7"){
                    price = 141560;
                }else if(c_=="8"){
                    price = 146240;
                }else if(c_=="9"){
                    price = 150930;
                }else if(c_=="10"){
                    price = 155610;
                }else if(c_=="11"){
                    price = 160290;
                }else if(c_=="12"){
                    price = 164980;
                }else if(c_=="13"){
                    price = 169660;
                }else if(c_=="14"){
                    price = 174350;
                }else if(c_=="15"){
                    price = 179030;
                }
            }
        }else if(sd_=="1.5"){  //速度=1.75m/s
            if(zz_=="630"){
                if(c_=="4"){
                    price = 122470;
                }else if(c_=="5"){
                    price = 126870;
                }else if(c_=="6"){
                    price = 131260;
                }else if(c_=="7"){
                    price = 135650;
                }else if(c_=="8"){
                    price = 140040;
                }else if(c_=="9"){
                    price = 144430;
                }else if(c_=="10"){
                    price = 148820;
                }else if(c_=="11"){
                    price = 153210;
                }else if(c_=="12"){
                    price = 157610;
                }else if(c_=="13"){
                    price = 162000;
                }else if(c_=="14"){
                    price = 166390;
                }else if(c_=="15"){
                    price = 170780;
                }else if(c_=="16"){
                    price = 175170;
                }else if(c_=="17"){
                    price = 179560;
                }else if(c_=="18"){
                    price = 183950;
                }else if(c_=="19"){
                    price = 188350;
                }else if(c_=="20"){
                    price = 192740;
                }else if(c_=="21"){
                    price = 197130;
                }else if(c_=="22"){
                    price = 201520;
                }else if(c_=="23"){
                    price = 205910;
                }else if(c_=="24"){
                    price = 210300;
                }else if(c_=="25"){
                    price = 214690;
                }
            }else if(zz_=="800"){
                if(c_=="4"){
                    price = 126120;
                }else if(c_=="5"){
                    price = 130590;
                }else if(c_=="6"){
                    price = 135060;
                }else if(c_=="7"){
                    price = 139530;
                }else if(c_=="8"){
                    price = 144000;
                }else if(c_=="9"){
                    price = 148480;
                }else if(c_=="10"){
                    price = 152950;
                }else if(c_=="11"){
                    price = 159460;
                }else if(c_=="12"){
                    price = 164070;
                }else if(c_=="13"){
                    price = 168690;
                }else if(c_=="14"){
                    price = 173300;
                }else if(c_=="15"){
                    price = 177910;
                }else if(c_=="16"){
                    price = 182530;
                }else if(c_=="17"){
                    price = 187140;
                }else if(c_=="18"){
                    price = 191750;
                }else if(c_=="19"){
                    price = 196370;
                }else if(c_=="20"){
                    price = 200980;
                }else if(c_=="21"){
                    price = 205590;
                }else if(c_=="22"){
                    price = 210210;
                }else if(c_=="23"){
                    price = 214820;
                }else if(c_=="24"){
                    price = 219440;
                }else if(c_=="25"){
                    price = 224050;
                }
            }else if(zz_=="1000"){
                if(c_=="4"){
                    price = 130230;
                }else if(c_=="5"){
                    price = 134910;
                }else if(c_=="6"){
                    price = 139600;
                }else if(c_=="7"){
                    price = 144280;
                }else if(c_=="8"){
                    price = 148960;
                }else if(c_=="9"){
                    price = 153650;
                }else if(c_=="10"){
                    price = 158330;
                }else if(c_=="11"){
                    price = 163010;
                }else if(c_=="12"){
                    price = 167700;
                }else if(c_=="13"){
                    price = 172380;
                }else if(c_=="14"){
                    price = 177070;
                }else if(c_=="15"){
                    price = 181750;
                }else if(c_=="16"){
                    price = 186430;
                }else if(c_=="17"){
                    price = 191120;
                }else if(c_=="18"){
                    price = 195800;
                }else if(c_=="19"){
                    price = 200480;
                }else if(c_=="20"){
                    price = 205170;
                }else if(c_=="21"){
                    price = 209850;
                }else if(c_=="22"){
                    price = 214540;
                }else if(c_=="23"){
                    price = 219220;
                }else if(c_=="24"){
                    price = 223900;
                }else if(c_=="25"){
                    price = 228590;
                }
            }
        }else if(sd_=="1.75"){
            if(zz_=="630"){
                if(c_=="4"){
                    price =  124520;
                }else if(c_=="5"){
                    price =  128910;
                }else if(c_=="6"){
                    price =  133300;
                }else if(c_=="7"){
                    price =  137700;
                }else if(c_=="8"){
                    price =  142090;
                }else if(c_=="9"){
                    price =  146480;
                }else if(c_=="10"){
                    price =  150870;
                }else if(c_=="11"){
                    price =  155260;
                }else if(c_=="12"){
                    price =  159650;
                }else if(c_=="13"){
                    price =  164040;
                }else if(c_=="14"){
                    price =  168440;
                }else if(c_=="15"){
                    price =  172830;
                }else if(c_=="16"){
                    price =  177220;
                }else if(c_=="17"){
                    price =  181610;
                }else if(c_=="18"){
                    price =  186000;
                }else if(c_=="19"){
                    price =  190390;
                }else if(c_=="20"){
                    price =  194780;
                }else if(c_=="21"){
                    price =  199180;
                }else if(c_=="22"){
                    price =  203570;
                }else if(c_=="23"){
                    price =  207960;
                }else if(c_=="24"){
                    price =  212350;
                }else if(c_=="25"){
                    price =  216740;
                }else if(c_=="26"){
                    price =  221130;
                }else if(c_=="27"){
                    price =  225530;
                }else if(c_=="28"){
                    price =  229920;
                }else if(c_=="29"){
                    price =  234310;
                }else if(c_=="30"){
                    price =  238700;
                }else if(c_=="31"){
                    price =  243090;
                }
            }else if(zz_=="800"){
                if(c_=="4"){
                    price =   127660;
                }else if(c_=="5"){
                    price =   132130;
                }else if(c_=="6"){
                    price =   136600;
                }else if(c_=="7"){
                    price =   141080;
                }else if(c_=="8"){
                    price =   145550;
                }else if(c_=="9"){
                    price =   150020;
                }else if(c_=="10"){
                    price =   154490;
                }else if(c_=="11"){
                    price =   161010;
                }else if(c_=="12"){
                    price =   165620;
                }else if(c_=="13"){
                    price =   170230;
                }else if(c_=="14"){
                    price =   174850;
                }else if(c_=="15"){
                    price =   179460;
                }else if(c_=="16"){
                    price =   184070;
                }else if(c_=="17"){
                    price =   188680;
                }else if(c_=="18"){
                    price =   193300;
                }else if(c_=="19"){
                    price =   197910;
                }else if(c_=="20"){
                    price =   202520;
                }else if(c_=="21"){
                    price =   207140;
                }else if(c_=="22"){
                    price =   211750;
                }else if(c_=="23"){
                    price =   216360;
                }else if(c_=="24"){
                    price =   220980;
                }else if(c_=="25"){
                    price =   225590;
                }else if(c_=="26"){
                    price =   230200;
                }else if(c_=="27"){
                    price =   234820;
                }else if(c_=="28"){
                    price =   239430;
                }else if(c_=="29"){
                    price =   244050;
                }else if(c_=="30"){
                    price =   248660;
                }else if(c_=="31"){
                    price =   253270;
                }
            }else if(zz_=="1000"){
                if(c_=="4"){
                    price =   131610;
                }else if(c_=="5"){
                    price =   136300;
                }else if(c_=="6"){
                    price =   140980;
                }else if(c_=="7"){
                    price =   145660;
                }else if(c_=="8"){
                    price =   150350;
                }else if(c_=="9"){
                    price =   155030;
                }else if(c_=="10"){
                    price =   159720;
                }else if(c_=="11"){
                    price =   164400;
                }else if(c_=="12"){
                    price =   169080;
                }else if(c_=="13"){
                    price =   173770;
                }else if(c_=="14"){
                    price =   178450;
                }else if(c_=="15"){
                    price =   183130;
                }else if(c_=="16"){
                    price =   187820;
                }else if(c_=="17"){
                    price =   192500;
                }else if(c_=="18"){
                    price =   197190;
                }else if(c_=="19"){
                    price =   201870;
                }else if(c_=="20"){
                    price =   206550;
                }else if(c_=="21"){
                    price =   211240;
                }else if(c_=="22"){
                    price =   215920;
                }else if(c_=="23"){
                    price =   220600;
                }else if(c_=="24"){
                    price =   225290;
                }else if(c_=="25"){
                    price =   229970;
                }else if(c_=="26"){
                    price =   234660;
                }else if(c_=="27"){
                    price =   239340;
                }else if(c_=="28"){
                    price =   244020;
                }else if(c_=="29"){
                    price =   248710;
                }else if(c_=="30"){
                    price =   253390;
                }else if(c_=="31"){
                    price =   258070;
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
                }else if(kmkd_=="1500"){
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
