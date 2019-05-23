﻿	<meta charset="utf-8" />
	<title>${pd.SYSNAME}</title>
	<meta name="description" content="overview & stats" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	    <!-- 全局js -->
<!--     <script src="static/js/jquery.min.js"></script> -->
    <script src="static/js/jquery-1.12.4.min.js"></script>
    <script src="static/js/bootstrap.min.js"></script>
    <!-- dropdown-list  下拉框搜索插件 -->
    <script src="static/js/bootstrap-select.min.js"></script>
    <script src="static/js/metisMenu/jquery.metisMenu.js"></script>
    <script src="static/js/slimscroll/jquery.slimscroll.min.js"></script>
    <script src="static/js/layer/layer.min.js"></script>
    <!-- 自定义js -->
    <script src="static/js/common.js?v=4.1.1"></script>
    <script type="text/javascript" src="static/js/contabs.js"></script>
    <!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
    <!-- 第三方插件 -->
    <link rel="shortcut icon" href="favicon.ico"> <link href="static/css/bootstrap.min.css" rel="stylesheet">
    <!-- dropdown-list  下拉框搜索插件 -->
    <link href="static/css/bootstrap-select.min.css" rel="stylesheet">
    <link href="static/css/font-awesome.min.css" rel="stylesheet">
    <link href="static/css/animate.css" rel="stylesheet">
    <link href="static/css/style.css" rel="stylesheet">
    <!-- 引入kendoui组件 -->
	<script src="static/js/kendoui/js/kendo.web.min.js"></script>
	<link href="static/js/kendoui/styles/kendo.common.min.css" rel="stylesheet">
	<link href="static/js/kendoui/styles/kendo.metro.min.css" rel="stylesheet">
	<!-- GITTER -->
    <script src="static/js/gritter/jquery.gritter.min.js"></script>
    <!-- Gritter -->
    <link href="static/js/gritter/jquery.gritter.css" rel="stylesheet">
    <%--layer--%>
    <link href="static/js/layer/skin/layer.css" rel="stylesheet">
    <script type="text/javascript" src="static/js/layer/layer.min.js"></script>
    <!-- jquery-ui-->
    <script src="static/js/jquery-ui-1.10.4.min.js"></script>
    <link href="static/css/jquery-1.10.4-ui.css" rel="stylesheet">

    <!-- 固定div在顶部 -->
    <script type="text/javascript">
	    $(document).ready(function() {
	    	if($('.dn-fixed-to-top').length > 0){
	    		var fixedThis = $('.dn-fixed-to-top');
	    		//$('.dn-fixed-s').css({position:"fixed",left:"0",top:"0",width:"100%",z-index:"1010",background-color:fixedThis.css("background-color")});
	    		//var dnFixedS = {position:"fixed",left:"0",top:"0",width:"100%",z-index:"1010",background-color:fixedThis.css("background-color")};
	    		fixedThis.before("<div class='dn-line-top-hide'></div>");
	    		$("body").scroll(function() {
			    	var based = fixedThis.prev('.dn-line-top-hide');
			    	var basedOffset = based.offset();
			    	if(based.length > 0){
			    		if(basedOffset.top < 0){
				    		if(!fixedThis.hasClass("dn-fixed-s")){
				    			based.css("height", fixedThis.css("height"));
				    			fixedThis.addClass("dn-fixed-s");//$('#line-hide').offset().top
				    			//$('.dn-fixed-s').css("top", 0).css("left", based.offset().left).css("width", based.css("width"));
				    			fixedThis.css("top", 0);
				    		}
				    	} else {
				    		if(fixedThis.hasClass("dn-fixed-s")){
				    			fixedThis.removeClass("dn-fixed-s");
				    			based.css("height", "0px");
				    		}
				    	}
			    	}
		    	});
	    	}
	    });
	</script>
	
	<!-- loading start-->
	<style> 
		html{overflow:auto;} 
		body{overflow-y:auto } 
		.loading{  position:absolute;  
		left:50%; top:50%;  
		margin-left:-150PX;  
		margin-top:-150PX; 
		z-index:55555555;
		display:none;
		} 
		.position-relative{
		position: relative;
		}
		.dn-fixed-s{
			position: fixed;
		    left: 0;
		    top: 0;
		    width: 100%;
		    z-index: 1010;
		    background-color: white;
		}
	</style>
	<div id="loading1" class="loading spiner-example">
       <div class="sk-spinner sk-spinner-fading-circle">
           <div class="sk-circle1 sk-circle"></div>
           <div class="sk-circle2 sk-circle"></div>
           <div class="sk-circle3 sk-circle"></div>
           <div class="sk-circle4 sk-circle"></div>
           <div class="sk-circle5 sk-circle"></div>
           <div class="sk-circle6 sk-circle"></div>
           <div class="sk-circle7 sk-circle"></div>
           <div class="sk-circle8 sk-circle"></div>
           <div class="sk-circle9 sk-circle"></div>
           <div class="sk-circle10 sk-circle"></div>
           <div class="sk-circle11 sk-circle"></div>
           <div class="sk-circle12 sk-circle"></div>
       </div>
   </div>
   <div id="loading2" class="loading spiner-example">
      <div class="sk-spinner sk-spinner-fading-circle">
          <div class="sk-circle1 sk-circle"></div>
          <div class="sk-circle2 sk-circle"></div>
          <div class="sk-circle3 sk-circle"></div>
          <div class="sk-circle4 sk-circle"></div>
          <div class="sk-circle5 sk-circle"></div>
          <div class="sk-circle6 sk-circle"></div>
          <div class="sk-circle7 sk-circle"></div>
          <div class="sk-circle8 sk-circle"></div>
          <div class="sk-circle9 sk-circle"></div>
          <div class="sk-circle10 sk-circle"></div>
          <div class="sk-circle11 sk-circle"></div>
          <div class="sk-circle12 sk-circle"></div>
      </div>
  </div>
  <div id="loading3" class="loading spiner-example" style="display:none;">
         <div class=" sk-spinner sk-spinner-three-bounce">
             <div class="sk-bounce1"></div>
             <div class="sk-bounce2"></div>
             <div class="sk-bounce3"></div>
         </div>
     </div>
  <div id="loading4" class="loading spiner-example" style="display:none;">
       <div class="sk-spinner sk-spinner-wave">
           <div class="sk-rect1"></div>
           <div class="sk-rect2"></div>
           <div class="sk-rect3"></div>
           <div class="sk-rect4"></div>
           <div class="sk-rect5"></div>
       </div>
   </div> 
   
   	<!-- loading end-->
	