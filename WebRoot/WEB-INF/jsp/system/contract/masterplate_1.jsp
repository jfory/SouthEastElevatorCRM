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
 <link href="static/js/sweetalert2/sweetalert2.css" rel="stylesheet">
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
        function save()
        {
            if ($("#masterplate").val()=="0" && $("#masterplate").val()=="0") 
            {
                $("#masterplate").focus();
            	$("#masterplate").tips({
                    side: 3,
                    msg: "请选择合同模版",
                    bg: '#AE81FF',
                    time: 3
                });
              
                return false;
            }
      	    $("#cellForm").submit();      
        }
        
	
	
	    
	    function CloseSUWin(id) {
			window.parent.$("#" + id).data("kendoWindow").close();
			/* 	window.parent.location.reload(); */
		}
</script>
 <style type="text/css">
  input
  {
  border-color: black; 
  border-style: solid; 
  border-top-width: 0px;
  border-right-width: 0px; 
  border-bottom-width: 1px;
  border-left-width: 0px;
  }
  span
  {
    font-family:微软雅黑;
    font-size:15px;
    color:black;
    font-style:inherit;
    font-family:arial;
  }
  table
  {
     width:100%;
     font-family:微软雅黑;
     font-size:15px;
     color:black;
     font-style:inherit;
     font-family:arial;
  }
  #biaoti
  {
    text-align:center;
    font-weight:bold;
  }
 </style>
</head>
<body class="gray-bg">
	<form action="contract/${msg}.do" name="cellForm" id="cellForm"
		method="post">
		<div class="wrapper wrapper-content">
		<input type="hidden" id="con_id" name="con_id" value="${pd.con_id}">
		<input type="hidden" id="item_id" name="item_id" value="${pd.item_id}">
			<div class="row">
				<div class="col-sm-12">
					<div class="ibox float-e-margins">
						<div class="ibox-content1">
								
						         <div style="font-family:微软雅黑;">
								   <center style="font-family:arial;color:black;font-size:25px;font-weight:bold;">电（扶）梯设备定作合同</center>
									<table id="tou">
									    <tr height="50">
									        <td> </td>
									        <td> </td>
									    </tr>
									    <tr height="50">
									        <td>合同编号:&nbsp<input type="text" style="width:75%;" value="${pd.con_id}"/></td>
									        <td>项目名称:&nbsp<input type="text" style="width:75%;" value="${pd.item_name}"/></td>
									    </tr>
									     <tr height="50" style="text-align:center;font-weight:bold;">
									      <td>定作方（甲方）</td>
									      <td>承揽方（乙方）</td>
									    </tr>
									     <tr height="40">
									      <td  >定作方:&nbsp<input type="text" style="width:80%;" value="${kehu.name}"/></td>
									      <td  >单位名称:<u>东南电梯股份有限公司</u></td>
									    </tr>
									     <tr height="40">
									      <td>公司地址:&nbsp<input type="text" style="width:75%;" value="${kehu.address}"/></td>
									      <td>公司地址:江苏省吴江经济开发区交通北路6588号</td>
									    </tr>
									     <tr height="40">
									      <td>电话:&nbsp<input type="text" style="width:84%;" value="${kehu.phone}"/></td>
									      <td>总机:0512-63038888 </td>
									    </tr>
									     <tr height="40">
									      <td>传真:<input type="text" style="width:84%;" value="${kehu.fax}"/></td>
									      <td>传真:0512-63031582 </td>
									    </tr>
									     <tr height="40">
									      <td>邮编:<input type="text" style="width:84%;" value="${kehu.postcode}"/></td>
									      <td>邮编:215200</td>
									    </tr>
									     <tr height="40">
									      <td>开户银行:<input type="text" style="width:75%;" value="${kehu.bank}"/></td>
									      <td>开户银行:中国建设银行吴江市支行   </td>
									    </tr>
									     <tr height="40">
									      <td>银行帐号:<input type="text" style="width:75%;" value="${kehu.bank_no}"/></td>
									      <td>银行帐号:32201997636059000518</td>
									    </tr>
									     <tr height="40">
									      <td>税务登记号:<input type="text" style="width:70%;" value="${kehu.tax}"/></td>
									      <td>税务登记号:320584703659565</td>
									    </tr>
									     <tr height="40">
									      <td>联系人:<input type="text" style="width:80%;" value="${kehu.contact}"/></td>
									      <td>行号:<input type="text" style="width:84%;"/></td>
									    </tr>
									     <tr height="40">
									      <td>联系方式:&nbsp<input type="text" style="width:75%;" value="${kehu.contact_phone}"/></td>
									      <td>联系人:&nbsp<input type="text" style="width:80%;"/></td>
									    </tr>
									     <tr height="40">
									      <td> </td>
									      <td>联系方式:&nbsp<input type="text" style="width:75%;"/></td>
									    </tr>
									    <tr height="40" >
									      <td> </td>
									      <td> </td>
									    </tr>
									     <tr height="40" >
									      <td>甲方盖章:</td>
									      <td>乙方盖章:</td>
									    </tr>
									     <tr height="40">
									      <td>&nbsp&nbsp签字:<input type="text" style="width:75%;"/></td>
									      <td>&nbsp&nbsp签字:<input type="text" style="width:75%;"/></td>
									    </tr>
									     <tr height="40">
									      <td>_____年_____月_____日</td>
									      <td>_____年_____月_____日</td>
									    </tr>
									     <tr height="40">
									      <td> </td>
									      <td> </td>
									    </tr>
									    <tr height="40" style="text-align:center;font-weight:bold;">
									      <td colspan="2">合同设备最终用户及安装地点：</td>
									    </tr>
									    <tr height="40">
									      <td colspan="2" style="color:red;">最终用户/使用单位名称：____________________________________________________________</td>
									      
									    </tr>
									    <tr height="40">
									      <td>联系人：</td>
									      <td>联系电话：</td>
									    </tr>
									    <tr height="40">
									      <td colspan="2">安装地点：_________省_________市_________区/县                                            </td>
									      
									    </tr>
									</table>
								</div>
								<div style="margin-top:10px;">
								    <span>&emsp;&emsp;根据《中华人民共和国合同法》，经甲乙双方友好协商，一致同意签订本合同，并共同遵守。</br></span>
                                    <span>&emsp;&emsp;合同条款如下：</br></span>
                                    <span id="biaoti">第一条：合同货物描述、数量及价格（RMB，元）：</span>
                                    <table border="2" style="text-align:center;">
	                                <thead>
	                                    <tr height="25px"; style="background-color:#D9D9D9">
	                                        <td>序号</td>
	                                        <td>产品名称</td>
	                                        <td>型号</td>
	                                        <td>梯种</td>
	                                        <td>数量</td>
	                                        <td>单价</td>
	                                        <td>小计</td>
	                                    </tr>
	                                </thead>
	                                <tbody>
	                                <!-- 开始循环 -->	
									<c:choose>
										<c:when test="${not empty listelev}">
											<c:if test="${QX.cha == 1 }">
												<c:forEach items="${listelev}" var="ele" varStatus="vs">
													<tr  height="25px";>
														<td class='center' style="width: 30px;">${vs.index+1}</td>
														<td>${ele.product_name}</td>
														<td>${ele.models_name}</td>
														<td>${ele.elevator_name}</td>
														<td>${ele.num}</td>
														<td>${ele.total}</td>
														<td>${ele.xj}</td>
													</tr>
												</c:forEach>
											</c:if>
										</c:when>		
									</c:choose>
                                </tbody>
                                <tr height="25px";>
                                    <td colspan="7">合同设备总价（大写人民币）：&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; （￥：&emsp;&emsp;&emsp;&emsp; 元） </td>
                                </tr>
	                            </table>
								</div>
								<div style="margin-top:10px;">
								  <span>注：（1） 具体规格描述，详见相应的《电梯合同技术规格表》、《自动扶梯合同技术规格表》、《自</br>
                                                                                                         动人行道合同技术规格表》和《土建布置图》及双方确认的其他技术协议或文件（如有）。</br>
                                          &emsp;&emsp;（2）上述合同设备总价含17%增值税，含运保费（代办）。
                                    </span></br>
                                    <span> </span></br>
                                    <span id="biaoti">第二条：付款方式：</span></br>
                                    <span style="line-height:30px">
                                      &emsp;&emsp;2.1甲方根据交提货周期长短，按下述约定付款：</br>
                                      &emsp;&emsp;&emsp;1）第一期款：在本合同签订之日起7天内，甲方应向乙方支付本合同设备总价款的 30 %，计人民币（大写）：____________________元整（其中合同设备总价的20%作为合同定金）。若合同履行，则定金抵作本合同的货款。甲方逾期给付的，则合同的交货期予以顺延。</br>
                                      &emsp;&emsp;&emsp;2）第二期款：甲方须在提货前     天之前，向乙方支付合同设备总价的    %，计人民币（大写）：____________________元整作为投产款。甲方逾期给付的，则合同的预定交货期予以顺延。</br>
                                      &emsp;&emsp;&emsp;3）第三期款：在满足工厂生产周期的前提下，甲方须在约定的交货日期前15天之前，向乙方支付设备提货款，合同设备总价的    %，计人民币（大写）：____________________元整。乙方收到此款项后，根据本合同约定的交货周期安排发运。甲方逾期给付的，则合同的交货周期予以顺延。</br>
                                      &emsp;&emsp;2.2付款时注意事项：</br>
                                      &emsp;&emsp;&emsp;&emsp;支付定金和货款时，须注明付款单位名称；</br>
                                      &emsp;&emsp;&emsp;&emsp;付款后，及时将支付凭证复印件传真给乙方授权代表人，以便及时确认；</br>
                                      &emsp;&emsp;2.3发票开具事项：</br>
                                      &emsp;&emsp;&emsp;&emsp;买断&出口项目：按出货后7天内开具；</br>
                                      &emsp;&emsp;&emsp;&emsp;其他项目：电梯安装完工验收合格后，一次性提供发票。</br>
                                    </span></br>
                                   
                                     <span id="biaoti">第三条：货物的交付：</span></br>
                                     <span style="line-height:30px">
                                          &emsp;&emsp;3.1本合同设备预定交货期应为本合同签订、乙方收到甲方投产款以及技术确认、《土建布置图》及合同技术规格表等技术资料由客户签字盖章确认起____天。如未能满足前述条件，交货期顺延或另议。
                                           </br>&emsp;&emsp;交货期如有变动，一方应提前书面通知，并经另一书面认可。甲方要求推迟交货时间/暂停供货的，应经乙方书面认可，由此产生的仓储费自约定交货时间起算。期间如有法定节假日，交货期顺延。
                                       </br>&emsp;&emsp;3.2设备的具体发货日期详见《发货确认函》确认。
                                       </br>&emsp;&emsp;3.3交货地点： 乙方工厂。
                                       </br>&emsp;&emsp;3.4交货方式：
                                       </br>&emsp;&emsp;1）甲方自提：
                                       </br>&emsp;&emsp;甲方应按本合同约定，在付清全部应付设备款项后，提货人携带甲方自提委托书和本人身份证等有效证明，在本合同约定的交货期内前往乙方工厂提取合同设备。
                                       </br>&emsp;&emsp;2）乙方代办运输：
                                       </br>&emsp;&emsp;甲方应明确以下收货信息，如收货信息错误导致乙方错发，乙方不承担相关责任。
                                       </br> 收货单位：________________________________________
                                        </br>到(站)港：________________________________________                                                                                 
                                        </br>接货地址：________________________________________                                                                               
                                        </br> 邮编：________联系人：_______电话：________传真：________    
                                      </br> &emsp;&emsp;3.5乙方应按照本合同约定的运输方式、收货单位发运合同设备。如甲方收货地址变更为不同省/市区域，因涉及服务便利性及区域差异，需由乙方对合同信息进行重新确认，产生的相关费用由甲方承担（如有）。如前述信息变更，甲方应在发运前7天及时书面通知乙方，否则乙方将按照本合同约定发运。
                                      </br> &emsp;&emsp;3.6如果甲方与乙方安装公司或乙方子公司就本项目签订的安装合同内约定安装款项须在合同设备发运前支付的，则合同设备将在乙方安装公司或乙方子公司收到该款项后才能发运。
                                       
                                     </span></br>
                                     </br>
                                      <span id="biaoti">第四条：货物的交付查验和保管：</span></br>
                                      <span style="line-height:30px">
                                        &emsp;&emsp;4.1乙方可根据特殊情况，在征得甲方同意的条件下，将合同设备分批发运，以配合合同设备的安装和保证交付使用的时间。如因甲方原因分批发运的，对所发生的额外运输费及包装费，甲方应在合同设备发运前向乙方一次性结清。
                                        </br>&emsp;&emsp;4.2收货查验：
                                               </br> &emsp;&emsp;甲方收到货物当日，应对货物箱数进行清点，并会同承运人对包装箱的完好或损坏状态进行确认，若发现包装箱缺少或损坏，应即时记录缺损情况，包括现场照片等资料，并要求运输部门出具有效证明，并在电梯设备到货之日起5日内以书面联系乙方，并协助乙方办理保险索赔事宜。否则乙方视为与甲方清点无误。
                                        </br>&emsp;&emsp;4.3保管：
                                               </br>&emsp;&emsp;甲方应提供具备防淋、防潮、防盗、防强光等存放货物所需的封闭空间，并对货物进行妥善保管，防止任何损蚀、损失和损害。
                                        </br>&emsp;&emsp;4.4 安装前查验：
                                               </br>&emsp;&emsp;在包装箱完好无损的情况下，箱内货物有缺损由乙方负责补足、修理或更换；如未经乙方许可，甲方擅自开箱的，或者开箱前包装箱已经损坏，箱内货物有缺损的，包装箱数量与根据合同4.2条款约定清点的数量不一致的，乙方不承担责任。
                                      </span></br>
                                      </br>
                                      <span id="biaoti">第五条：执行标准：</span>
                                      <span style="line-height:30px">
                                                                                                              本公司产品执行标准：
                                            </br> &emsp;&emsp;5.1	GB 7588-2003    《电梯制造与安装安全规范》
                                            </br> &emsp;&emsp;5.2	GB 21240-2007   《液压电梯制造与安装安全规范》
                                            </br> &emsp;&emsp;5.3	GB 16899-2011   《自动扶梯和自动人行道的制造与安装安全规范》
                                      </span></br>
                                      </br>
                                      <span id="biaoti">第六条：承诺和保证：</span>
                                      <span style="line-height:30px">
                                        </br>&emsp;&emsp;6.1乙方保证其出售的货物完全符合本合同的约定，并保证其所提供的货物是全新的，且有权出售。
                                        </br>&emsp;&emsp;6.2根据国务院（2003）第373号令《特种设备安全监察条例》的有关规定，电梯、扶梯、人行道等设备的安装必须由电梯制造单位或者其通过合同委托、同意的且依照本条例取得许可的单位进行。在签订本合同的同时，甲乙双方应签订本合同电（扶）梯设备的安装合同。若甲方不与乙方签订安装合同，或虽签约但后又违约自行安排乙方以外的其他方进行合同电（扶）梯设备的安装、调试、维护工作的，乙方只承担与本合同电（扶）梯设备原设计、制造相关的直接质量责任，除此以外其它任何质量和安全责任均由甲方承担，乙方将不承担免费保修保养责任。
                                        </br>&emsp;&emsp;6.3由乙方或乙方委托方负责安装的，在甲方遵守货物的保管、使用、安装、保养、维修条件下，本合同电（扶）梯设备的免费保修保养期为自设备安装完毕、政府验收合格之日起12个月或自乙方发运之日起18个月（以先到日期为准）。在此期间，如产品设备本身存在因乙方原因造成的质量缺陷，乙方应负责修理或免费更换相应零部件。若合同设备分批验收，质保期则分批计算。
                                        </br>&emsp;&emsp;如非由乙方或乙方委托方负责安装的产品，则乙方不承担免费保养责任，亦不承担因非乙方安装调试而引起的质量事故及责任，乙方只承担与产品原设计、制造相关的直接质量责任，除此以外其它任何质量和安全责任均由甲方承担。
                                      </span></br>
                                      </br>
                                      <span id="biaoti">第七条：违约责任：</span>
                                      <span style="line-height:30px">
                                        </br>&emsp;&emsp;7.1本合同生效后，如因乙方原因全部或部分解除合同，须向甲方双倍返还定金，同时须赔偿甲方直接经济损失；如因甲方原因全部或部分解除合同，乙方不退还定金，甲方同时须赔偿乙方直接经济损失。
                                        </br>&emsp;&emsp;7.2如甲方未按期支付定金或货款，乙方可以顺延交付日期和/或调整合同总价，同时甲方每天应按延迟交付合同设备总金额的万分之三向乙方支付违约金（但违约金累积最高不超过合同总价的3%）；如甲方未按期支付定金或任何一期货款达三个月或以上的，乙方有权决定是否解除合同；如决定解除的，乙方应向甲方发出书面通知，本合同应视为因甲方原因于通知发出之日被解除，甲方应同时按上款规定承担违约责任。
                                        </br>&emsp;&emsp;7.3乙方在合同交货期到期后一周内免费提供仓储；如甲方迟延付款超过一周，造成乙方无法交付货物的，甲方须向乙方支付仓储费（按电梯每台每天100元计算），并且在甲方付清到期货款和仓储费前将暂不交付货物。甲方其他原因（如甲方要求推迟交货时间并经乙方同意）造成乙方无法如期交付货物的，甲方亦应支付延期交货所产生的仓储费。如甲方推迟交货时间不确定的，应及时予以确定，如经乙方催告后仍不确定的，则乙方可按甲方原因解除合同处理，也可以要求甲方继续履行合同。
                                        </br>&emsp;&emsp;7.4如乙方因自身单方面原因延期交货，应按延期天数向甲方支付每天合同总价万分之三的违约金（但违约金累积最高不超过合同总价的3%）；如乙方无理由延期交货达三个月的，除继续支付上述违约金外，甲方还有权决定是否解除合同；如决定解除的，甲方应向乙方发出书面通知，本合同应视为因乙方原因于通知发出之日被解除，乙方应同时按7.1条规定承担违约责任。
                                        </br>&emsp;&emsp;7.5不可抗力事件应根据《中华人民共和国合同法》的要求进行处理。
                                        </br>&emsp;&emsp;7.6在甲方付清本合同款项之前，本合同电（扶）梯设备的所有权属乙方所有。
                                      </span></br>
                                      </br>
                                      <span id="biaoti">第八条：争议的解决：</span>
                                      <span style="line-height:30px">
                                          </br>&emsp;&emsp;因执行本合同而引起的一切争议，由双方通过友好协商解决；协商不成时合同任一方均可向原告所在地法院提起诉讼。
                                      </span></br>
                                      </br>
                                      <span id="biaoti">第九条：其他：</span>
                                      <span style="line-height:30px">
                                        </br>&emsp;&emsp;9.1 本合同自双方签署且甲方支付合同约定的定金后生效。
                                        </br>&emsp;&emsp;9.2本合同所有条款均为打印文字。本合同文本不得随意涂改；若需修改，须经甲、乙双方协商达成一致意见，并经双方签字盖章确认后视为有效。
                                        </br>&emsp;&emsp;9.3本合同附件（《土建布置图》、《电梯合同技术规格表》，或《自动扶梯合同技术规格表》及《自动人行道合同技术规格表》等），为本合同不可分割的组成部分，与本合同具有同等的法律效力，双方签字盖章后视为有效。<span style="text-align:center;font-weight:bold;color: red;">如果因甲方设计、土建结构变更，则《土建布置图》（井道及机房布置图）须经双方盖章确认后有效，时间以双方确认的最后一份为准。在甲乙双方确认《土建布置图》（井道及机房布置图）及《合同设备技术规格表》、合同生效后，甲方设计、土建结构发生变更，则甲方需承担因变更而产生的相关费用。</span>
                                        </br>&emsp;&emsp;9.4在本合同签定后，合同中如有未尽事宜或合同履行过程中有相关内容需加以补充或变更，双方需签署书面补充合同或变更合同。
                                        </br>&emsp;&emsp;9.5本合同设备涉及的乙方知识产权，未经乙方许可，甲方不得为生产经营目的制造、使用、许诺销售、销售、进口其知识产权产品，或者使用其知识产权方法。
                                        </br>&emsp;&emsp;9.6合同未涉及的违约事宜等条款，应按照《中华人民共和国合同法》相关规定处理。
                                        </br>&emsp;&emsp;9.7本合同壹式肆份，甲乙双方各执贰份，具有同等法律效力。
                                      </span>
                                      </br>
                                      </br>
								</div>
								
							<tr>
								<td><a class="btn btn-primary"
									style="width: 150px; height: 34px; float: left;"
									onclick="save1();">下载</a></td>
								<td>
							<a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('EditMoban');">关闭</a>
						        </td>
							</tr>
						</div>
				</div>
			</div>
	</form>
	<script type="text/javascript">
	 function save1(){
		 var con_id=$("#con_id").val();
		 var item_id=$("#item_id").val();
		 $.post("<%=basePath%>contract/transformPDF.do?con_id="+con_id+"&item_id="+item_id,
				 function(data)
				 {
			         if(data.msg=="success")
			         {
			        	 alert("下载成功");
			        	 var id="EditMoban";
			        	 CloseSUWin(id);
			         }
				 });
	 } 
	</script>
</body>
</html>
