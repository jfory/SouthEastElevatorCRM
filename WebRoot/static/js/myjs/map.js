var locat = (window.location+'').split('/'); 
$(function(){if('tool'== locat[3]){locat =  locat[0]+'//'+locat[2];}else{locat =  locat[0]+'//'+locat[2]+'/'+locat[3];};});

$(top.hangge());

$(top.hangge());

function openMap(){
   var result = showModalDialog(locat+"/tool/mapXY.do","","dialogWidth=650px;dialogHeight=500px;");
   if(result==null || ""==result){
	      		return;
   }else{
    var result=result.split("-");
		document.getElementById("ZUOBIAO_X").value=result[0];		
		document.getElementById("ZUOBIAO_Y").value=result[1];
	   }
}
function openMap2(){
	   var result = showModalDialog(locat+"/tool/mapXY.do","","dialogWidth=650px;dialogHeight=500px;");
	   if(result==null || ""==result){
 	      		return;
	   }else{
	    var result=result.split("-");
 		document.getElementById("ZUOBIAO_X2").value=result[0];		
  		document.getElementById("ZUOBIAO_Y2").value=result[1];
  	   }
	}
//去后计算
function getDistance(){
	if($("#ZUOBIAO_Y").val()==""){
		$("#ZUOBIAO_Y").tips({
			side:3,
            msg:'不能为空',
            bg:'#AE81FF',
            time:2
        });
		$("#ZUOBIAO_Y").focus();
		return false;
	}
	if($("#ZUOBIAO_X").val()==""){
		$("#ZUOBIAO_X").tips({
			side:3,
            msg:'不能为空',
            bg:'#AE81FF',
            time:2
        });
		$("#ZUOBIAO_X").focus();
		return false;
	}
	if($("#ZUOBIAO_Y2").val()==""){
		$("#ZUOBIAO_Y2").tips({
			side:3,
            msg:'不能为空',
            bg:'#AE81FF',
            time:2
        });
		$("#ZUOBIAO_Y2").focus();
		return false;
	}
	if($("#ZUOBIAO_X2").val()==""){
		$("#ZUOBIAO_X2").tips({
			side:3,
            msg:'不能为空',
            bg:'#AE81FF',
            time:2
        });
		$("#ZUOBIAO_X2").focus();
		return false;
	}
	$.ajax({
		type: "POST",
		url: locat+'/tool/getDistance.do',
    	data: {ZUOBIAO_X:$("#ZUOBIAO_X").val(),ZUOBIAO_Y:$("#ZUOBIAO_Y").val(),ZUOBIAO_X2:$("#ZUOBIAO_X2").val(),ZUOBIAO_Y2:$("#ZUOBIAO_Y2").val(),tm:new Date().getTime()},
		dataType:'json',
		cache: false,
		success: function(data){
			 if("success" == data.result){
				 if('null' == data.distance || null == data.distance){
					 $("#distance").text("计算失败,参数有误");
				 }else{
					 $("#distance").tips({
							side:1,
				            msg:'计算结果',
				            bg:'#75C117',
				            time:3
				     });
					 $("#distance").val(data.distance);
				 }
			 }else{
				 $("#distance").tips({
						side:3,
			            msg:'计算失败,参数有误',
			            bg:'#FF5080',
			            time:10
			     });
				 return;
			 }
		}
	});
}