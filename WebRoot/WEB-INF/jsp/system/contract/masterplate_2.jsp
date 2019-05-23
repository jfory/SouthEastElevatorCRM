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
								   <center style="font-family:arial;color:black;font-size:25px;font-weight:bold;">电（扶）梯设备安装合同</center>
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
									      <td  >单位名称:<input type="text" style="width:75%;" value="${kehu.name}"/></td>
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
									      <td>联系人:<input type="text" style="width:80%;"/></td>
									    </tr>
									     <tr height="40">
									      <td>联系方式:&nbsp<input type="text" style="width:75%;" value="${kehu.contact_phone}"/></td>
									      <td>联系方式:&nbsp<input type="text" style="width:75%;"/></td>
									    </tr>
									    <tr height="40" >
									      <td> </td>
									      <td> </td>
									    </tr>
									     <tr height="40" >
									      <td>甲方法定代表或授权代理人签字:</td>
									      <td>乙方法定代表或授权代理人签字:</td>
									    </tr>
									    <tr height="40" >
									      <td>___________________________</td>
									      <td>___________________________</td>
									    </tr>
									     <tr height="40">
									      <td>签订日期_____年_____月_____日</td>
									      <td>签订日期_____年_____月_____日</td>
									    </tr>
									    <tr height="40">
									      <td>签约地点:<input type="text" style="width:75%;"/></td>
									      <td>签约地点:<input type="text" style="width:75%;"/></td>
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
									      <td colspan="2">安装地点：  </td>
									      
									    </tr>
									</table>
								</div>
								<div style="margin-top:10px;">
								    <span style="line-height:30px">&emsp;&emsp;双方按照政府部门相关法律法规及国务院《特种设备安全法》的规定，遵循公平，诚实和信用的原则，共同确定以下由乙方向甲方提供的产品安装服务内容条款。</br></span>
                                    <span id="biaoti">一、合同生效及终止</span></br>
                                    <span style="line-height:30px">&emsp;&emsp;本合同经双方代表签字并盖章后生效，并将自动终止于本合同约定电（扶）梯验收合格及甲方支付完毕相应的安装费用。</span>
                                    </br><span id="biaoti">二、工程概况</span></br>
                                    <span style="line-height:30px">1、甲方将如下电（扶）梯安装工程委托乙方安装：</span>
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
													<tr  height="30px";>
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
                                 <tr height="45px";>
                                        <td colspan="7">本合同安装调试\厂检总台数：___________台</td>
                                      </tr>
                                      <tr height="45px";>
                                        <td colspan="7">本合同安装调试\厂检费总金额（人民币）：___________&emsp;&emsp;&emsp;&emsp;大写（人民币）：___________</td>
                                      </tr>
	                            </table>  
								</div>
								<div style="margin-top:10px;">
								  <span>&emsp;&emsp;具体规格参数详见《电（扶）梯设备定作合同》中附件“产品技术规格表”。</span></br>
                                    <span style="line-height:30px">
                                      2、 工程地址：______________________________________________________________</br>                                                                                     
                                      &emsp;&emsp;甲方联系人：_______________联系电话：_______________传真：_______________</br>                   
                                      &emsp;&emsp;乙方联系人：_______________联系电话：_______________传真：_______________</br>                    
                                      3、以上费用不包含甲方或总包方的配合费。
                                    </span></br>
                                    </br>
                                     <span id="biaoti">三、安装费支付方式</span></br>
                                     <span style="line-height:30px">
                                         1、	甲方在双方约定的安装开工日期前 10 天，向乙方支付安装费总额的 50 %，计人民币(大写)__________元整。在收到款项且确认工地具备安装条件后，乙方安排发运，并于货到工地及甲方通知后10天内进场安装。
                                         </br>2、	电（扶）梯安装调试完成，在通过政府部门验收合格后10日内， 甲方按照合同要求向乙方支付剩余的  50 ％安装费，计人民币(大写)__________元整，此款支付最迟不超过货到工地后4个月。乙方收到合同规定的款额后3日内与甲方办理电（扶）梯移交手续。
                                         </br>3、	如因甲方原因导致乙方不能及时安装，或电（扶）梯安装完毕后因甲方原因不及时申报验收，则设备发货之日起三个月满日即视为电（扶）梯设备已验收合格，甲方即应支付合同约定的相应款项。
                                         </br>4、         如甲方未按时支付前述安装验收款，即使免费保修期已经开始，乙方仍有权暂停免费维修保养责任。乙方对暂停期间电梯发生的故障或事故免责。
                                         </br> <span id="biaoti">付款时注意事项：</span>
                                            </br>&emsp;&emsp;支付安装款时，须注明付款单位名称；
                                            </br>&emsp;&emsp;付款后及时将支付凭证复印件传真给乙方授权代表人，以便及时确认并安排电（扶）梯安装。
                                         </br> <span id="biaoti">发票开具事项：</span>
                                            </br>&emsp;&emsp;验收项目：验收后一次性提供发票；
                                     </span></br>
                                     </br>
                                      <span id="biaoti">四、土建要求</span></br>
                                      <span style="line-height:30px">
                                         &emsp;&emsp;甲方的建筑土建必须符合建筑工程质量要求、《电（扶）梯设备定作合同》确定的土建总体布置图样和双方确认的设计土建技术要求。对于不符合项目，甲方应在约定期限内整改完毕，由于整改和拖延整改而产生的费用或损失，由甲方负责。
                                      </span></br>
                                      </br>
                                      <span id="biaoti">五、安装资格保证</span>
                                      <span style="line-height:30px">
                                         </br>&emsp;&emsp;按照国务院《特种设备安全法》规定，本合同所涉及的产品由乙方、或乙方下属_____子/分公司，或受乙方委托的具有安装资质并持有乙方开具项目委托书的单位实施安装。
                                      </span></br>
                                      </br>
                                      <span id="biaoti">六、安装施工方式、双方责任和配合事宜</span>
                                      <span style="line-height:30px">
                                        </br>&emsp;&emsp;甲乙双方约定以附件所确认的施工内容实施安装。为保证施工安全、质量和进度，甲乙双方配合事宜和责任义务如下：
                                      </span></br>
                                      <span id="biaoti">1、甲方权利和义务：</span>
                                      <span style="line-height:30px">
                                        </br>&emsp;1.1	就该项目授权本方人员与乙方人员进行工程交底，落实专门联系人，负责乙方与其他施工单位交叉作业时的协调工作。
                                        </br>&emsp;1.2	甲方有权监督乙方的施工进度、施工质量、施工安全及人员持证上岗作业情况，发现问题及时通知乙方。
                                        </br>&emsp;1.3	按照产品的《电（扶）梯土建布置图》和双方会签的《电（扶）梯现场交底备忘录》，对井道进行施工，提供完整清洁的施工现场、施工必须的水源、各楼层动力和照明电源、井道门洞防护设施和消费器材、通道照明、装饰面标高、电梯厅的轴线基准，井道和底坑须防止水源进入，机房门窗应完整、结实、防盗。在正式电源到位以前，提供机房的临时独立调试电源。正式电源应接至乙方指定的电源接入点。
                                        </br>&emsp;1.4	负责由于甲方土建不符引起的井道整改，以及配合乙方进行土建封堵和修补工作。
                                        </br>&emsp;1.5	及时通知乙方人员进行井道施工完工后的勘测，并由双方会同签定《电（扶）梯土建勘测表》以确认施工“符合《电（扶）梯土建布置图》《电（扶）梯现场交底备记录》要求”。
                                        </br>&emsp;1.6	如甲方未能在设备发货日期  15  天之前完成符合要求的土建工作，则乙方可将开工日期调整。
                                        </br>&emsp;1.7	甲方负责提供作业区附近具有消防、防盗措施和足够面积的卸货场地、运输通道和库房（可驻人看管），并负责施工现场的安全保卫以及工作时间之外对安装现场的监护、成品保护及施工材料、设备和工具的看护，以防遗失。如由于甲方原因，电（扶）梯发货后暂不开工，甲方需负责产品开箱前的货物保管；安装工程暂时停止的，甲方必须与乙方代表协商确认在此期间的设备保管责任。甲方应承担因甲方原因造成的乙方的误工损失，并顺延工期（见违约责任）。电（扶）梯产品未经厂检、验收合格并正式移交甲方之前，甲方不可擅自使用，否则由此产生的后果由甲方承担，且视为产品已由甲方验收合格，并开始计算质保期。
                                        </br>&emsp;1.8	为保证施工安全和施工质量，甲方须给予乙方正常的施工周期。
                                        </br>&emsp;1.9	为乙方提供施工便利条件，协助提供施工人员的就近食宿的生活方便。
                                        </br>&emsp;1.10	免费提供安装施工期间所需的水、电源
                                        </br>&emsp;1.11	在有关政府部门出具的开工文件所载日期之前且双方书面移交和接收电梯井道之 前，甲方应负责提供符合国家标准的厅门安全护栏。
                                        </br>&emsp;1.12	在申请政府验收前，由甲方负责提供电梯机房到监控室等区域的通信电缆，并完成敷设工作。配合电梯制造单位做好电梯校验和调试工作，并保证电梯必须经过制造厂家的厂检。
                                        </br>&emsp;1.13	按本合同的约定支付安装工程款项。
                                      </span></br>
                                      </br>
                                      <span id="biaoti">2、乙方权利和义务：</span>
                                      <span style="line-height:30px">
                                        </br>&emsp;2.1	在合同预约的开工期前，及时派此项目的工程项目经理会同甲方按标准对施工现场进行土建勘测，确认施工条件，提供咨询服务和提出整改要求，现场会签《电（扶）梯现场交底备忘录》和《电（扶）梯土建勘测报告》，参加现场施工协调会议，配合甲方建筑施工。
                                        </br>&emsp;2.2	在开工进场前，会同甲方向当地政府部门提出开工许可申请。
                                        </br>&emsp;2.3	设备到货后会同甲方代表根据发运资料共同对设备包装完整性和装箱数量进行清点
                                        </br>&emsp;2.4	在正常安装期间，负责保管库房内尚未安装的设备及部件。如由于甲方原因在施工中途不得不暂停施工，则必须与甲方协商确认在此期间的设备保管责任。
                                        </br>&emsp;2.5	严格按照相关国家、行业或企业技术标准和质量规范，并遵守施工现场的各类规则制度，组织合格的安装人员实施安装、调试和验收作业，并达到合同约定的技术质量标准。
                                        </br>&emsp;2.6	施工中产生的各类废弃物，由乙方按照当地环境管理法律法规及有关规定予以处理。
                                        </br>&emsp;2.7	负责安装质量的调试、厂检验收，配合政府部门完成验收工作。
                                        </br>&emsp;2.8	负责由于安装质量问题造成的二次检验的整改。
                                        </br>&emsp;2.9	遵守施工现场的有关规章制度。 
                                        </br>&emsp;2.10	参加现场施工协调会议，配合甲方建筑施工。
                                      </span></br>
                                      </br>
                                      <span id="biaoti">七、安装预约和实施前的准备</span>
                                      <span style="line-height:30px">
                                        </br>&emsp;1、	双方预约于_____年_____月开工安装，预计施工周期为_____周。
                                        </br>&emsp;2、	在本合同签订后_____个工作日内，乙方即派人员到现场向甲方授权的施工人员进行交底，指导甲方进行电梯井道和机房等的施工以满足《电（扶）梯土建布置图》要求，交底完毕双方当场签订《电（扶）梯现场交底备忘录》。
                                        </br>&emsp;3、	甲方按照双方会签的《电（扶）梯现场交底备忘录》进行施工完毕后，及时通知乙方到现场进行土建勘测。如果土建勘测结果符合电（扶）梯的《电（扶）梯土建布置图》要求，则甲乙双方授权的人员当场会签《电（扶）梯土建勘测报告》；否则需要在勘测结果一栏注明需要整改的事项要求甲方再予整改，直到符合为止。（注：此《电（扶）梯土建勘测报告》最后会签符合要求的日期决定产品实际安装日期，请甲乙双方务必引以重视）。
                                        </br>&emsp;4、	乙方进场开工的条件应是产品到达现场、土建具备安装条件及甲方支付了本合同约定的款项及合同对应的《电（扶）梯设备定作合同》约定的款项。当满足以上条件后，双方再确定开工进场日期和竣工日期。
                                        </br>&emsp;5、	如因非乙方原因，造成乙方无法按照双方约定的安装工期计划进行施工安装、调试（如停电、土建延迟、井道准备工作延迟等），乙方对所造成的延期和误工不承担责任；若由此产生停工状态，甲方应承担乙方由于停工而造成的直接损失和费用。
                                        </br>&emsp;6、	甲方如要求变更安装日期，必须提前一个月书面通知到乙方，双方重新确定开工日期。若甲方要求终止安装的，应书面通知乙方。若已造成乙方损失，乙方有权不返还已收安装款或采取法律措施要求赔偿。
                                      </span>
                                      </br>
                                       <span id="biaoti">八、甲方或乙方的责任及承担费用（确认以“√”表示）</span>
                                      <table>
                                        <tr height="35px" style="text-align:center;">
                                          <td width="80%" style="font-size:20px;">责  任  内  容</td>
                                          <td width="10%">甲方负责</td>
                                          <td width="10%">乙方负责</td>
                                        </tr>
                                        <tr height="35px">
                                          <td>1．按照乙方要求完成电梯设备现场卸车及起吊。</td>
                                          <td style="text-align:center;">_____</td>
                                          <td style="text-align:center;">_____</td>
                                        </tr>
                                        <tr height="35px">
                                          <td>2．提供符合国家标准及安全标准要求的安装平台</td>
                                          <td style="text-align:center;">_____</td>
                                          <td style="text-align:center;">_____</td>
                                        </tr>
                                        <tr height="35px">
                                          <td>3．提供并安装井道永久照明，照明装置应符合国家标准的有关要求。</td>
                                          <td style="text-align:center;">_____</td>
                                          <td style="text-align:center;">_____</td>
                                        </tr>
                                        <tr height="35px">
                                          <td>4．提供安装期间所需的水电费</td>
                                          <td style="text-align:center;">_____</td>
                                          <td style="text-align:center;">_____</td>
                                        </tr>
                                        <tr height="35px">
                                          <td>5．提供合格的机房高台爬梯及永久性护栏。</td>
                                          <td style="text-align:center;">_____</td>
                                          <td style="text-align:center;">_____</td>
                                        </tr>
                                        <tr height="35px">
                                          <td>6. 五方通话调试工作</td>
                                          <td style="text-align:center;">_____</td>
                                          <td style="text-align:center;">_____</td>
                                        </tr>
                                        <tr height="35px">
                                          <td>7．政府部门检验、验收费用</td>
                                          <td style="text-align:center;">_____</td>
                                          <td style="text-align:center;">_____</td>
                                        </tr>
                                      </table>
                                      </br>
                                       <span id="biaoti">九、安装验收和支付</span>
                                      <span style="line-height:30px">
                                        </br>&emsp;1、	电（扶）梯安装工程结束，由乙方单位质量部门根据相应标准验收合格后，书面通知甲方会同乙方共同验收。甲方在接到乙方递交的《电（扶）梯工程竣工移交通知单》后 7日内予以验收，在乙方的《安装验收报告》上签署是否合格意见；如甲方既未在前述7 日内提出工程确实存在不合格项目的有效证明，又拒绝在《电（扶）梯工程竣工移交通知单》上签署盖章，则乙方可视为甲方默认验收合格并已于前述7日期满之日在“电（扶）梯工程移交单”上签署盖章。
                                        </br>&emsp;2、	设备需当地政府相关部门验收的，甲方应在乙方验收结束后三天内申报使用许可验收并承担相应费用。验收中存在的不合格项目，甲、乙双方根据合同中各自所承担的责任和义务分别予以整改合格。
                                        </br>&emsp;3、	安装产品未经验收通过或未经乙方办理竣工移交手续之前，甲方不得自行使用该产品。否则甲方将承担因此引起的一切包括但不限于安全责任在内的法律后果
                                        </br>&emsp;4、	乙方收到甲方付清了应付款项的有效凭证后办理移交手续，将产品、随机图册资料及相关证书报告交付给甲方。
                                      </span></br>
                                      </br>
                                       <span id="biaoti">十、执行标准</span>
                                      <span style="line-height:30px">
                                        </br>&emsp;1、	本合同项下的电梯产品按GB7588-2003《电梯制造与安装安全规范》标准安装。
                                        </br>&emsp;2、	本合同项下的家用电梯按照GB/T21739-2008《家用电梯制造与安装规范》，以及Q/320500DNDT002-2012 《家用电梯》标准安装。
                                        </br>&emsp;3、	本合同项下的自动扶梯、自动人行道按GB16899-1997《自动扶梯和自动人行道的制造与安装安全规范》标准安装。
                                        </br>&emsp;4、	本合同项下的液压梯按GB 21240-2007《液压梯制造与安装安全规范》标准安装。
                                        </br>&emsp;5、	本合同项下的杂物电梯按GB 25194-2010《杂物电梯制造与安装安全规范》标准安装。
                                        </br>&emsp;6、	本合同项下的电梯按GB/T 10060-2011《电梯安装验收规范》安装验收。
                                        </br>&emsp;7、	本合同项下的电梯、自动扶梯、自动人行道，应按照TSG T7001-2009《电梯监督检验和定期检验规则》等，通过特种设备检验检测机构的监督检验后方能投入正式使用。
                                        </br>&emsp;8、	产品使用之前，甲方应仔细阅读随机提供的《用户使用指南》以及国务院《特种设备安全法》，并遵照执行。
                                      </span></br>
                                      </br>
                                       <span id="biaoti">十一、质保期的服务</span>
                                      <span style="line-height:30px">
                                        </br>&emsp;1、	免费保修保养期：在甲方遵守货物的保管、使用、安装、保养、维修条件下，本合同设备的免费保修保养期为自设备安装完毕、政府验收合格之日起12个月或自乙方发运之日起18个月（以先到日期为准）。
                                        </br>&emsp;2、	在质量保证期内，如因乙方产品本身质量问题导致设备无法正常使用，乙方免费负责部件更换；因非乙方原因造成的设备损坏，由甲方承担责任和费用，乙方有偿提供所需更换部件及服务。
                                        </br>&emsp;3、	如甲方自行安排其他单位进行电（扶）梯安装、调试，乙方将不承担任何质量和安全责任，以及免费维修的责任及费用。
                                        </br>&emsp;4、	鉴于电（扶）梯设备所涉及的技术条件比较复杂，为确保运行质量，建议设备由乙方提供专业的维修保养服务。双方应及时签订《电梯设备保养合同》。签订后，乙方将提供完善的保养服务，并在保养期内提供优惠价格的配件。
                                      </span></br>
                                      </br>
                                       <span id="biaoti">十二、保密条款</span>
                                      <span style="line-height:30px">
                                        </br>&emsp;甲方应对乙方提供给甲方的保密资料，负有保密义务，承担保密责任。甲方未经乙方书面同意不得向第三方公布，泄露或揭露任何保密资料或以其他方式使用保密资料。上述“保密资料”包括乙方的业务、雇员、客户、技术及科技方面的书面或其他形式的资料和信息（无论是否明确标明或注明是“保密资料”）。本保密条款下的义务及责任在本安装合同满期或终止后仍然有效。
                                      </span></br>
                                      </br>
                                       <span id="biaoti">十三、价格调整</span>
                                      <span style="line-height:30px">
                                        </br>&emsp;如果因为甲方原因造成实际安装日期距电梯到货日期超过12个月，或由于非乙方的原因造成安装停工期超过6个月则安装价格将作相应调整，并另行签署补充协议。
                                      </span></br>
                                      </br>
                                       <span id="biaoti">十四、违约责任</span>
                                      <span style="line-height:30px">
                                        </br>&emsp;1、	甲方未按约定支付安装工程款项，乙方有权顺延工期和/或调整合同金额，并且甲方应向乙方支付逾期付款的违约金，每日按逾期款项总金额的万分之三计算。
                                        </br>&emsp;2、	甲方未按约定提供施工条件的，乙方有权顺延工期和/或调整合同金额：并且甲方每延迟一天应按合同总金额的万分之三（安装合同价格／工期）向乙方支付违约金，并承担乙方误工费（按每人每天100元计算）。若连续延误达七天，乙方有权撤回施工人员，甲方承担乙方的二次进场费以及来回的差旅费，期间的已安装/待安装的零部件由甲方保管。
                                        </br>&emsp;3、	如任何一方未履行本合同项下的义务达三个月或以上的，另一方有权决定是否解除合同；如决定解除的，应书面通知对方，在这种情况下，合同应于通知发出之日解除，违约方应根据上文承担违约责任。
                                        </br>&emsp;4、	如发生不可抗力事件按《中华人民共和国合同法》的有关规定处理。
                                      </span></br>
                                       </br>
                                       <span id="biaoti">十五、其他</span>
                                      <span style="line-height:30px">
                                        </br>&emsp;1、	本合同签订时，需要对合同条款增加和更改的，双方应在“另行约定事项”中约定，经双方授权签署人签字并加盖公章后生效。
                                        </br>&emsp;2、	本合同生效后，需要对原条款进行变更的，双方应另行签订“合同变更协议书”，经双方单位签字盖章后生效。
                                        </br>&emsp;3、	以下文件及其他与本合同有关的协议均为本合同之附件，为本合同不可分割的组成部分，与本合同具有同等的法律效力。
                                        </br>&emsp;&emsp;&emsp;a) ________________________                           
                                        </br>&emsp;&emsp;&emsp;b) ________________________                            
                                        </br>&emsp;4、	在安装过程中发生安全事故，由政府主管部门介入并作出事故鉴定结论，或在政府主管部门不介入时由双方共同委托有能力的第三方权威机构进行鉴定。双方的安全责任及法律责任根据鉴定结论而定。
                                        </br>&emsp;5、	双方发生争议时，应先协商解决，协商不成，任何一方可依法向原告所在地的人民法院起诉。
                                        </br>&emsp;6、	本合同正本一式肆份，双方各执贰份。
                                      </span></br>
                                      </br>
                                       <span id="biaoti">十六、另行约定事项</span>
                                      
                                      
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
		 $.post("<%=basePath%>contract/transformPDF2.do?con_id="+con_id+"&item_id="+item_id,
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
