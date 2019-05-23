<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<table class="table table-striped table-bordered table-hover" id="cgfbTable">
   <thead>
   <!-- 轿厢壁材料变化（标配1.2m符合减震不锈钢） -->
   <tr>
          <td style="width: 20%;">轿厢壁材料变化（标配1.2m符合减震不锈钢）</td>
          <td colspan="2">
          	<select style="" class="form-control" id="CGFB_JXCLBH" name="CGFB_JXCLBH" onchange="CGFBJXCLBH()">
                 <option value="">请选择</option>
                 <option value="由减振复合不锈钢变更为443发纹不锈钢" ${pd.CGFB_JXCLBH=='由减振复合不锈钢变更为443发纹不锈钢'?'selected="selected"':''}>由减振复合不锈钢变更为443发纹不锈钢</option>
                 <option value="由减振复合不锈钢变更为SUS304发纹不锈钢" ${pd.CGFB_JXCLBH=='由减振复合不锈钢变更为SUS304发纹不锈钢'?'selected="selected"':''}>由减振复合不锈钢变更为SUS304发纹不锈钢</option>
                 <option value="由减震复合不锈钢变更为1.5mmSUS304发纹不锈钢" ${pd.CGFB_JXCLBH=='由减震复合不锈钢变更为1.5mmSUS304发纹不锈钢'?'selected="selected"':''}>由减震复合不锈钢变更为1.5mmSUS304发纹不锈钢</option>
                 <option value="减震复合不锈钢厚度由1.2mm增加到1.5mm" ${pd.CGFB_JXCLBH=='减震复合不锈钢厚度由1.2mm增加到1.5mm'?'selected="selected"':''}>减震复合不锈钢厚度由1.2mm增加到1.5mm</option>
                 <option value="轿厢后壁中间一块采用镜面不锈钢，宽度约600mm" ${pd.CGFB_JXCLBH=='轿厢后壁中间一块采用镜面不锈钢，宽度约600mm'?'selected="selected"':''}>轿厢后壁中间一块采用镜面不锈钢，宽度约600mm</option>
             </select>
           </td>
           <td><input type="text" name="CGFB_JXCLBH_TEMP" id="CGFB_JXCLBH_TEMP" class="form-control" readonly="readonly"></td>
         
    </tr>
    
    <!-- 轿门、厅门、门套的材料变化（标配首层为1.2m复合减震不锈钢） -->
    <tr>
           <td rowspan="4">轿门、厅门、门套的材料变化（标配首层为1.2m复合减震不锈钢）</td>
           <td>
                                由减震复合不锈钢变更为443发纹不锈钢
           </td>
           <td>
           <input type="text" name="CGFB_MTBH443" id="CGFB_MTBH443"  onkeyup="editMTBH('CGFB_MTBH443');" class="form-control" value="${pd.CGFB_MTBH443}">门
           </td>
           <td>
           <input type="text" name="CGFB_MTBH443_TEMP" id="CGFB_MTBH443_TEMP" class="form-control" readonly="readonly">
           </td>
    </tr>
    <tr>
           <td>
                                由减震复合不锈钢变更为SUS304发纹不锈钢
           </td>
           <td>
           <input type="text" name="CGFB_MTBHSUS304" id="CGFB_MTBHSUS304" class="form-control" onkeyup="editMTBH('CGFB_MTBHSUS304');" value="${pd.CGFB_MTBHSUS304}">门
           </td>
           <td>
           <input type="text" name="CGFB_MTBHSUS304_TEMP" id="CGFB_MTBHSUS304_TEMP" class="form-control" readonly="readonly">
           </td>
      </tr>  
      <tr>
           <td>
                                由减震复合不锈钢变更为1.5mmSUS304发纹不锈钢
           </td>
           <td>
           <input type="text" name="CGFB_MTBH15SUS304" id="CGFB_MTBH15SUS304" class="form-control" onkeyup="editMTBH('CGFB_MTBH15SUS304');"  value="${pd.CGFB_MTBH15SUS304}">门
           </td>
           <td>
           <input type="text" name="CGFB_MTBH15SUS304_TEMP" id="CGFB_MTBH15SUS304_TEMP" class="form-control" readonly="readonly">
           </td>
      </tr>
      <tr>  
           <td>
                                减震复合不锈钢厚度由1.2mm增加到1.5mm
           </td>
           <td>
           <input type="text" name="CGFB_MTBH1215" id="CGFB_MTBH1215" class="form-control" onkeyup="editMTBH('CGFB_MTBH1215');"  value="${pd.CGFB_MTBH1215}">门
           </td>
           <td>
           <input type="text" name="CGFB_MTBH1215_KZFS_TEMP" id="CGFB_MTBH1215_TEMP" class="form-control" readonly="readonly">
           </td>
      </tr>
  
     <!-- 轿厢护栏加高到1100mm -->
     <tr>
          <td>轿厢护栏加高到1100mm</td>
          <td colspan="1">
              
              <input name="CGFB_JXHL_TEXT" id="CGFB_JXHL_TEXT" type="checkbox" onclick="editMTBH('CGFB_JXHL');"  ${pd.CGFB_JXHL=='1'?'checked':''}/>
                                      高度700mm-1100mm</br> 
              <input type="hidden" name="CGFB_JXHL" id="CGFB_JXHL">                                                                                                                 
           </td>
           <td></td>
           <td><input type="text" name="CGFB_JXHL_TEMP" id="CGFB_JXHL_TEMP" class="form-control" readonly="readonly"></td>
    </tr>  
    
    <!-- 大理石地板价格 -->
    <tr>
            <td>大理石地板价格</td>
            <td colspan="2">
                <select style="width: 50%;" class="form-control" id="CGFB_DLSB" name="CGFB_DLSB" onclick="editMTBH('CGFB_DLSB');">
					    <option  value="" ${pd.CGFB_DLSB==''?'selected':''}>请选择</option>
					    <option  value="非拼花大理石" ${pd.CGFB_DLSB=='非拼花大理石'?'selected':''}>非拼花大理石</option>
					    <option  value="拼花大理石" ${pd.CGFB_DLSB=='拼花大理石'?'selected':''}>拼花大理石</option>
				</select>
            </td>
            
            <td><input type="text" name="CGFB_DLSB_TEMP" id="CGFB_DLSB_TEMP" class="form-control" readonly="readonly"></td>
     </tr>
    
     <!-- 对重侧置 -->
     <tr>
          <td>对重侧置或担架梯</td>
          <td colspan="2">
              <input type="checkbox" name="CGFB_DZCZ_TEXT" id="CGFB_DZCZ_TEXT" value="对重在井道侧面，有机房电梯" onclick="editMTBH('CGFB_DZCZ');" ${pd.CGFB_DZCZ=='1'?'checked':''}/>
                                       对重在井道侧面，有机房电梯</br>         
              <input type="hidden" name="CGFB_DZCZ" id="CGFB_DZCZ">                                                                                                                 
           </td>
           <td><input type="text" name="CGFB_DZCZ_TEMP" id="CGFB_DZCZ_TEMP" class="form-control" readonly="readonly"></td>
     </tr>    
    
     <!-- 开门高度2000 -->
     <tr>
          <td>开门高度2000</td>
          <td colspan="2">
              <input type="checkbox" name="CGFB_KMGD_TEXT" id="CGFB_KMGD_TEXT" value="高度增加2000" onclick="editMTBH('CGFB_KMGD');" ${pd.CGFB_KMGD=='1'?'checked':''}/>
                                       高度增加2000</br> 
              <input type="hidden" name=CGFB_KMGD id="CGFB_KMGD">                                                                                                                             
           </td>
           <td><input type="text" name="CGFB_KMGD_TEMP" id="CGFB_KMGD_TEMP" class="form-control" readonly="readonly"></td>
     </tr>    
     
     <!-- 地坑IP65 -->
     <tr>
          <td>地坑IP65</td>
          <td colspan="2">
              <input type="checkbox" name="CGFB_DKIP65_TEXT" id="CGFB_DKIP65_TEXT" value="IP65防水" onclick="editMTBH('CGFB_DKIP65');" ${pd.CGFB_DKIP65=='1'?'checked':''}/>
              IP65防水</br>
              <input type="hidden" name=CGFB_DKIP65 id="CGFB_DKIP65">                                                                                                                    
           </td>
           <td><input type="text" name="CGFB_DKIP65_TEMP" id="CGFB_DKIP65_TEMP" class="form-control" readonly="readonly"></td>
     </tr> 
     
     <!-- 旁开门 -->
     <tr>
          <td>旁开门</td>
          <td colspan="2">
              <input type="checkbox" name="CGFB_PKM_TEXT" id="CGFB_PKM_TEXT" value="开门由中分门变为旁开门" onclick="editMTBH('CGFB_PKM');" ${pd.CGFB_PKM=='1'?'checked':''}/>
                                      开门由中分门变为旁开门</br>
              <input type="hidden" name=CGFB_PKM id="CGFB_PKM">                                                                                                                       
           </td>
           <td><input type="text" name="CGFB_PKM_TEMP" id="CGFB_PKM_TEMP" class="form-control" readonly="readonly"></td>
     </tr>      

     <!-- 贯通轿厢增加一个COP -->
     <tr>
          <td>贯通轿厢增加一个COP</td>
          <td colspan="2">
          	<select style="" class="form-control" id="CGFB_GTJX" name="CGFB_GTJX" onchange="CGFBGTJX();">
                 <option value="">请选择</option>
                 <option value="JFCOPO9H-C1" ${pd.CGFB_GTJX=='JFCOPO9H-C1'?'selected="selected"':''}>JFCOPO9H-C1</option>
                 <option value="JFCOPO5P-E" ${pd.CGFB_GTJX=='JFCOPO5P-E'?'selected="selected"':''}>JFCOPO5P-E</option>
             </select>
           </td>
           <td><input type="text" name="CGFB_GTJX_TEMP" id="CGFB_GTJX_TEMP" class="form-control" readonly="readonly"></td>
     </tr> 
     
    <!-- 中分双折开门尺寸非标 -->
    <tr>
           <td rowspan="2">中分双折开门尺寸非标</td>
          
           <td colspan="2">
            <select style="width: 50%;" class="form-control" id="CGFB_ZFSZ2000" name="CGFB_ZFSZ2000" onclick="editMTBH('CGFB_ZFSZ2000');">
					    <option  value="" ${pd.CGFB_ZFSZ2000==''?'selected':''}>载重2000kg请选择</option>
					    <option  value="开门变小" ${pd.CGFB_ZFSZ2000=='开门变小'?'selected':''}>开门变小</option>
					    <option  value="1600*（2100-2200）" ${pd.CGFB_ZFSZ2000=='1600*（2100-2200）'?'selected':''}>1600*（2100-2200）</option>
					    <option  value="1700*（2100-2200）" ${pd.CGFB_ZFSZ2000=='1700*（2100-2200）'?'selected':''}>1700*（2100-2200）</option>
					    <option  value="1800*（2100-2200）" ${pd.CGFB_ZFSZ2000=='1800*（2100-2200）'?'selected':''}>1800*（2100-2200）</option>
			</select>
           </td>
           <td>
           <input type="text" name="CGFB_ZFSZ2000_TEMP" id="CGFB_ZFSZ2000_TEMP" class="form-control" readonly="readonly">
           </td>
    </tr>
    <tr>
           
           <td colspan="2"> 
            <select style="width: 50%;" class="form-control" id="CGFB_ZFSZ3000" name="CGFB_ZFSZ3000" onclick="editMTBH('CGFB_ZFSZ3000');">
					    <option  value="" ${pd.CGFB_ZFSZ3000==''?'selected':''}>载重3000kg请选择</option>
					    <option  value="开门变小" ${pd.CGFB_ZFSZ3000=='开门变小'?'selected':''}>开门变小</option>
					    <option  value="1800*（2100-2200）" ${pd.CGFB_ZFSZ3000=='1800*（2100-2200）'?'selected':''}>1800*（2100-2200）</option>
					    <option  value="1900*（2100-2200）" ${pd.CGFB_ZFSZ3000=='1900*（2100-2200）'?'selected':''}>1900*（2100-2200）</option>
					    <option  value="2000*（2100-2200）" ${pd.CGFB_ZFSZ3000=='2000*（2100-2200）'?'selected':''}>2000*（2100-2200）</option>
			</select>
           </td>
           <td>
           <input type="text" name="CGFB_ZFSZ3000_TEMP" id="CGFB_ZFSZ3000_TEMP" class="form-control" readonly="readonly">
           </td>
      </tr>  

     <!-- 中分双折门加安全触板 -->
     <tr>
          <td>中分双折门加安全触板</td>
          <td colspan="2">
              <input type="checkbox" name="CGFB_ZFSZAQB_TEXT" id="CGFB_ZFSZAQB_TEXT" value="增加安全触板功能" onclick="editMTBH('CGFB_ZFSZAQB');" ${pd.CGFB_ZFSZAQB=='1'?'checked':''}/>
                                      增加安全触板功能</br>
              <input type="hidden" name=CGFB_ZFSZAQB id="CGFB_ZFSZAQB">                                                                                                                   
           </td>
           <td><input type="text" name="CGFB_ZFSZAQB_TEMP" id="CGFB_ZFSZAQB_TEMP" class="form-control" readonly="readonly"></td>
     </tr>      
            
     <!-- 轿厢尺寸非标 -->
     <%-- <tr>
          <td>轿厢尺寸非标</td>
          <td colspan="2">
              <input type="checkbox" name="CGFB_JXCC_TEXT" id="CGFB_JXCC_TEXT" value="国标允许的轿厢面积对应的载重下轿厢尺寸的变化" onclick="editMTBH('CGFB_JXCC');" ${pd.CGFB_JXCC=='1'?'checked':''}/>
                                      国标允许的轿厢面积对应的载重下轿厢尺寸的变化</br> 
              <input type="hidden" name=CGFB_JXCC id="CGFB_JXCC">                                                                                                            
           </td>
           <td><input type="text" name="CGFB_JXCC_TEMP" id="CGFB_JXCC_TEMP" class="form-control" readonly="readonly"></td>
     </tr>  --%>
     
    <!-- 停电应急加价 -->
    <tr>
            <td>停电应急加价</td>
            <td colspan="2">
                <select style="width: 50%;" class="form-control" id="CGFB_TDYJ" name="CGFB_TDYJ" onclick="editMTBH('CGFB_TDYJ');">
					    <option  value="" ${pd.CGFB_TDYJ==''?'selected':''}>请选择</option>
					    <option  value="EMK-ARD-B11 5.5KW" ${pd.CGFB_TDYJ=='EMK-ARD-B11 5.5KW'?'selected':''}>EMK-ARD-B11 5.5KW</option>
					    <option  value="EMK-ARD-B11 7.5KW" ${pd.CGFB_TDYJ=='EMK-ARD-B11 7.5KW'?'selected':''}>EMK-ARD-B11 7.5KW</option>
					    <option  value="EMK-ARD-B11 11KW" ${pd.CGFB_TDYJ=='EMK-ARD-B11 11KW'?'selected':''}>EMK-ARD-B11 11KW</option>
					    <option  value="EMK-ARD-B18 15KW" ${pd.CGFB_TDYJ=='EMK-ARD-B18 15KW'?'selected':''}>EMK-ARD-B18 15KW</option>
					    <option  value="EMK-ARD-B18 18.5KW" ${pd.CGFB_TDYJ=='EMK-ARD-B18 18.5KW'?'selected':''}>EMK-ARD-B18 18.5KW</option>
					    <option  value="EMK-ARD-B37 22KW" ${pd.CGFB_TDYJ=='EMK-ARD-B37 22KW'?'selected':''}>EMK-ARD-B37 22KW</option>
					    <option  value="EMK-ARD-B37 30KW" ${pd.CGFB_TDYJ=='EMK-ARD-B37 30KW'?'selected':''}>EMK-ARD-B37 30KW</option>
				        <option  value="EMK-ARD-B37 37KW" ${pd.CGFB_TDYJ=='EMK-ARD-B37 37KW'?'selected':''}>EMK-ARD-B37 37KW</option>
				</select>
            </td>
            
            <td><input type="text" name="CGFB_TDYJ_TEMP" id="CGFB_TDYJ_TEMP" class="form-control" readonly="readonly"></td>
     </tr>   
     
    <!-- 经济型方案物联网 -->
    <tr>
           <td rowspan="2">经济型方案物联网</td>
          
           <td colspan="2">
           <input type="checkbox" name="CGFB_JJFAJMK_TEXT" id="CGFB_JJFAJMK_TEXT" value="GPRS无线中继模块 IOT-WL210D" onclick="editMTBH('CGFB_JJFAJMK');" ${pd.CGFB_JJFAJMK=='1'?'checked':''}/>
            GPRS无线中继模块 IOT-WL210D
             <input type="hidden" name=CGFB_JJFAJMK id="CGFB_JJFAJMK">    
           </td>
           <td>
           		<input type="text" name="CGFB_JJFAJMK_TEMP" id="CGFB_JJFAJMK_TEMP" class="form-control" readonly="readonly">
           </td>
    </tr>
    <tr>
           
           <td>
           1.5米默纳克串口线 IOT-DB9-A-CAB
           </td>
           <td>
           <input type="text" name="CGFB_JJFACXK" id="CGFB_JJFACXK" onkeyup="editMTBH('CGFB_JJFACXK');" class="form-control" value="${pd.CGFB_JJFACXK}">根
           </td>
           <td>
           <input type="text" name="CGFB_JJFACXK_TEMP" id="CGFB_JJFACXK_TEMP" class="form-control" readonly="readonly">
           </td>
      </tr>         
    
    </thead>
    <tbody id="cgfbbody">
    </tbody>
</table>

<script type="text/javascript">

//对重侧置  无机房mrl 或 货梯 则不适用（灰掉）
function initDZCZ() {
	var eleType = $('#ele_type').val();
	if(eleType == 'DT10'
			|| eleType == 'DT5'
			|| eleType == 'DT8'
			|| eleType == 'DT9'){
		$('#CGFB_DZCZ_TEXT').attr("disabled", "disabled");
	}
}
initDZCZ();

//控制方式加价
function CGFBJXCLBH(flag)
{
	var jxclbh = $('#CGFB_JXCLBH').val();
	if(jxclbh == "由减振复合不锈钢变更为443发纹不锈钢"){
		flag='1'
	} else if(jxclbh == "由减震复合不锈钢变更为1.5mmSUS304发纹不锈钢"){
		flag='2'
	} else if(jxclbh == "减震复合不锈钢厚度由1.2mm增加到1.5mm"){
		flag='3'
	} else if(jxclbh == "由减振复合不锈钢变更为SUS304发纹不锈钢"){
		flag='4'
	} else if(jxclbh == "轿厢后壁中间一块采用镜面不锈钢，宽度约600mm"){
		flag='5'
	}
	
	//数量
	var sl_ = $("#DT_SL").val()==""?0:parseInt($("#DT_SL").val());
	//载重
	var zz_ = $("#BZ_ZZ").val()==""?0:parseInt($("#BZ_ZZ").val());
	var price=0;
	if(zz_<=1000){
		if(flag=='1')
		{
			price=0;
		}else if(flag=='2')
		{
			price=1000*sl_;
		}
		else if(flag=='3')
		{
			price=850*sl_;
		}
		else if(flag=='4')
		{
			price=750*sl_;
		}else if(flag=='5')
		{
			price=300*sl_;
		}
	}else{
		price=0;
	}
	$("#CGFB_JXCLBH_TEMP").val(price);
	//计算价格
	countZhj();
}

function CGFBGTJX(flag)
{
	var gtjx = $("#CGFB_GTJX").val();
	if(gtjx == "JFCOPO9H-C1"){
		flag = '1';
	} else if(gtjx == "JFCOPO5P-E"){
		flag = '2';
	}
	
	//数量
	var sl_ = $("#DT_SL").val()==""?0:parseInt($("#DT_SL").val());
	//门
	var m_ = parseInt($("#BZ_M").val());//门
	var price=0;
		if(flag=='1')
		{
			price=(2030+30*(m_-2))*sl_;
		}else if(flag=='2')
		{
			price=(1000+30*(m_-2))*sl_;
		}
	$("#CGFB_GTJX_TEMP").val(price);
	//计算价格
	countZhj();
}


//加价
function editMTBH(option, isRefresh){
    //数量
    var sl_ = $("#DT_SL").val()==""?0:parseInt($("#DT_SL").val());
    //开门宽度
    var kmkd_ = $("#BZ_KMKD").val()==""?0:parseInt($("#BZ_KMKD").val());
    //载重
    var zz_ = $("#BZ_ZZ").val()==""?0:parseInt($("#BZ_ZZ").val());
    //层数、门数
     var c_ = parseInt($("#BZ_C").val());//层
     var m_ = parseInt($("#BZ_M").val());//门
    //价格
    var price = 0;
    if(kmkd_<=1100){
	    if(option=="CGFB_MTBH443"){
	    	price = 0;
	        $("#CGFB_MTBH443_TEMP").val(price);
	    }else if(option=="CGFB_MTBHSUS304"){
	    	var CGFB_MTBHSUS304_ = parseInt($("#CGFB_MTBHSUS304").val()==""?0:parseInt($("#CGFB_MTBHSUS304").val()));
	    	price = 200*CGFB_MTBHSUS304_*sl_;
	        $("#CGFB_MTBHSUS304_TEMP").val(price);
	    }else if(option=="CGFB_MTBH15SUS304"){
	    	var CGFB_MTBH15SUS304_ = parseInt($("#CGFB_MTBH15SUS304").val()==""?0:parseInt($("#CGFB_MTBH15SUS304").val()));
	    	price = 300*CGFB_MTBH15SUS304_*sl_;
	        $("#CGFB_MTBH15SUS304_TEMP").val(price);
	    }else if(option=="CGFB_MTBH1215"){
	    	var CGFB_MTBH1215_ = parseInt($("#CGFB_MTBH1215").val()==""?0:parseInt($("#CGFB_MTBH1215").val()));
	    	price = 250*CGFB_MTBH1215_*sl_;
	        $("#CGFB_MTBH1215_TEMP").val(price);
	    }
    }else{
    	$("#CGFB_MTBH443_TEMP").val(price);
    	$("#CGFB_MTBHSUS304_TEMP").val(price);
    	$("#CGFB_MTBH15SUS304_TEMP").val(price);
    	$("#CGFB_MTBH1215_TEMP").val(price);
    }
    
    
     if(option=="CGFB_JXHL"){
    	if($("#CGFB_JXHL_TEXT").is(":checked")){
            price = 500*sl_;
        }else{
            price = 0;
        }
        $("#CGFB_JXHL_TEMP").val(price);
    }else if(option=="CGFB_DLSB"){
    	var CGFB_DLSB_ = $("#CGFB_DLSB").val();
    	if(CGFB_DLSB_=="非拼花大理石"){
    		if(zz_<=1000){
    			price=3500*sl_;
    		}else if (zz_>1000 && zz_<=1600){
    			price=4500*sl_;
    		}
    	}else if(CGFB_DLSB_=="拼花大理石") {
    		if(zz_<=1000){
    			price=4500*sl_;
    		}else if (zz_>1000 && zz_<=1600){
    			price=5500*sl_;
    		}
    	}
        $("#CGFB_DLSB_TEMP").val(price);
    }else if(option=="CGFB_DZCZ"){
    	if($("#CGFB_DZCZ_TEXT").is(":checked")){
            //price = 150*sl_*c_;
            price = 1000*sl_;
        }else{
            price = 0;
        }
        $("#CGFB_DZCZ_TEMP").val(price);
    }else if(option=="CGFB_KMGD"){
    	if($("#CGFB_KMGD_TEXT").is(":checked")){
            price = 0;
        }else{
            price = 0;
        }
        $("#CGFB_KMGD_TEMP").val(price);
    }else if(option=="CGFB_DKIP65"){
    	if($("#CGFB_DKIP65_TEXT").is(":checked")){
            price = 2000*sl_;
        }else{
            price = 0;
        }
        $("#CGFB_DKIP65_TEMP").val(price);
    }else if(option=="CGFB_PKM"){
    	if($("#CGFB_PKM_TEXT").is(":checked") && kmkd_<=1200){
            price = (1000+(700*m_))*sl_;
        }else{
            price = 0;
        }
        $("#CGFB_PKM_TEMP").val(price);
    }else if(option=="CGFB_ZFSZ2000"){
    	var CGFB_ZFSZ2000_ = $("#CGFB_ZFSZ2000").val();
    	if(zz_==2000){
	    	if(CGFB_ZFSZ2000_=="开门变小" ){
	    	    price=0;
	    	}else if(CGFB_ZFSZ2000_=="1600*（2100-2200）") {
	    		price=1500*sl_;
	    	}else if(CGFB_ZFSZ2000_=="1700*（2100-2200）") {
	    		price=1600*sl_;
	    	}else if(CGFB_ZFSZ2000_=="1800*（2100-2200）") {
	    		price=1700*sl_;
	    	}
    	}
        $("#CGFB_ZFSZ2000_TEMP").val(price);
    }else if(option=="CGFB_ZFSZ3000"){
    	var CGFB_ZFSZ2000_ = $("#CGFB_ZFSZ3000").val();
    	if(zz_==2000){
	    	if(CGFB_ZFSZ2000_=="开门变小" ){
	    	    price=0;
	    	}else if(CGFB_ZFSZ2000_=="1800*（2100-2200）") {
	    		price=1600*sl_;
	    	}else if(CGFB_ZFSZ2000_=="1900*（2100-2200）") {
	    		price=1800*sl_;
	    	}else if(CGFB_ZFSZ2000_=="2000*（2100-2200）") {
	    		price=2000*sl_;
	    	}
    	 }
        $("#CGFB_ZFSZ3000_TEMP").val(price);
       
    }else if(option=="CGFB_ZFSZAQB"){
    	if($("#CGFB_ZFSZAQB_TEXT").is(":checked")){
            price = 1500*sl_;
        }else{
            price = 0;
        }
        $("#CGFB_ZFSZAQB_TEMP").val(price);
    }else if(option=="CGFB_JXCC"){
    	//if($("#CGFB_JXCC_TEXT").is(":checked"))
    	if($("#CGFB_JXCC").val() == "1"){
    		var _jj = 1000;
    		if(getFeuyueJxJJ() && getFeuyueJxJJ() != 0){
    			_jj = getFeuyueJxJJ();
    		}
            price = _jj*sl_;
        }else{
            price = 0;
        }
        $("#CGFB_JXCC_TEMP").val(price);
    }else if(option=="CGFB_TDYJ"){
     	var CGFB_TDYJ_ = $("#CGFB_TDYJ").val();
     	if(CGFB_TDYJ_=="EMK-ARD-B11 5.5KW"){
     		price=2130*sl_;
     	}else if(CGFB_TDYJ_=="EMK-ARD-B11 7.5KW") {
     		price=2130*sl_;
     	}
     	else if(CGFB_TDYJ_=="EMK-ARD-B11 11KW") {
     		price=2440*sl_;
     	}
     	else if(CGFB_TDYJ_=="EMK-ARD-B18 15KW") {
     		price=2750*sl_;
     	}
     	else if(CGFB_TDYJ_=="EMK-ARD-B18 18.5KW") {
     		price=3130*sl_;
     	}
		else if(CGFB_TDYJ_=="EMK-ARD-B37 22KW") {
			price=3750*sl_;
     	}
        else if(CGFB_TDYJ_=="EMK-ARD-B37 30KW") {
        	price=4750*sl_;
     	}
		else if(CGFB_TDYJ_=="EMK-ARD-B37 37KW") {
			price=4750*sl_;
     	}
        $("#CGFB_TDYJ_TEMP").val(price);
    }else if(option=="CGFB_JJFAJMK"){
    	if($("#CGFB_JJFAJMK_TEXT").is(":checked")){
            price = 830*sl_;
        }else{
            price = 0;
        }
        $("#CGFB_JJFAJMK_TEMP").val(price);
    }else if(option=="CGFB_JJFACXK"){
    	var CGFB_JJFACXK_ = parseInt($("#CGFB_JJFACXK").val()==""?0:parseInt($("#CGFB_JJFACXK").val()));
    	price = 30*CGFB_JJFACXK_*sl_;
        $("#CGFB_JJFACXK_TEMP").val(price);
    }
    
	//物联网网线根数自动赋值
    var sel_CGFB_JJFACXK = $("#CGFB_JJFACXK").val();
   	if ($("#CGFB_JJFAJMK_TEXT").is(":checked")&&sel_CGFB_JJFACXK=="")
   	{
   		$("#CGFB_JJFACXK").val("1");
   		$("#CGFB_JJFACXK_TEMP").val("30");
	}
    
    if(isRefresh != '1'){
        //放入价格
        countZhj();
    }
}


</script>

