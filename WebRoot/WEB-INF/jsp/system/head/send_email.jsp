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
	<%@ include file="../../system/admin/top.jsp"%> 
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pd.SYSNAME}</title>
     <!-- Sweet Alert -->
    <link href="static/js/sweetalert/sweetalert.css" rel="stylesheet">
    <!-- Check Box -->
    <link href="static/js/iCheck/custom.css" rel="stylesheet">
     <!-- Summernote -->
    <link href="static/js/summernote/summernote.css" rel="stylesheet">
 	<link href="static/js/summernote/summernote-bs3.css" rel="stylesheet">
</head>

<body class="gray-bg">
<form>
	<textarea name="CONTENT" id="CONTENT" style="display:none" ></textarea>
		<input type="hidden" name="TYPE" id="TYPE" value="1"/>
		<input type="hidden" name="isAll" id="isAll" value="no"/>
    <div class="wrapper wrapper-content">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-content1">
                        <div class="row">
                        <div class="form-group">
                             <label>收件人:</label>
                            <div class="media-body">
                                <textarea class="form-control" name="EMAIL" id="EMAIL" placeholder="请选输入对方邮箱,多个请用(;)分号隔开" title="请选输入对方邮箱,多个请用(;)分号隔开">${pd.EMAIL}</textarea>
                            </div>
                        </div>
                        <div class="form-group">
                         	<label>标题:</label>
                            <input  type="text" name="TITLE" id="TITLE" value="" placeholder="请选输入邮件标题" class="form-control">
                        </div>
                        </div>
                         <div class="row">
                        <div class="form-group">
                             <label>邮件内容:</label>
                             <!--  富文本编辑器-->
                             <div class="summernote">
                   			 </div>
                        </div>
                        </div>
                        <div class="row form-inline">
                        <input type="radio" name="form-field-radio" id="form-field-radio1" onclick="setType('1');" value="icon-edit" checked="checked" class="i-checks" >纯文本
                        <input type="radio" name="form-field-radio" id="form-field-radio2" onclick="setType('2');" value="icon-edit" class="i-checks" >带标签
                        <input type="checkbox" name="form-field-checkbox" id="allusers" onclick="isAll();" class="i-checks" >全体用户
                        </div>
                    </div>
						<div style="height: 20px;"></div>
						<tr>
						<td><a class="btn btn-primary"style="width: 150px; height:34px;float:left;"  onclick="sendEm();">发送</a></td>
						<td><a class="btn btn-danger" style="width: 150px; height: 34px;float:right;" onclick="javascript:CloseSUWin('EditUsers');">关闭</a></td>
						</tr>
					</div>
            </div>
            
        </div>
 </div>
 </form>
 <!--引入属于此页面的js -->
 <script type="text/javascript" src="static/js/myjs/headEmail.js"></script>
 <!-- Sweet alert -->
 <script src="static/js/sweetalert/sweetalert.min.js"></script>
 <!-- iCheck -->
 <script src="static/js/iCheck/icheck.min.js"></script>
 <!-- SUMMERNOTE -->
 <script src="static/js/summernote/summernote.min.js"></script>
 <script src="static/js/summernote/summernote-zh-CN.js"></script>
 <script type="text/javascript">
 $(document).ready(function () {
 	/* checkbox */
     $('.i-checks').iCheck({
         checkboxClass: 'icheckbox_square-green',
         radioClass: 'iradio_square-green',
     });
   //onImageUpload callback
     $('.summernote').summernote({
    	 lang: 'zh-CN',
    	 height:300,
       	 callbacks: {
         onImageUpload: function(files, editor, welEditable) {
           // upload image to server and create imgNode...
           if(files.length=1){
        	 /*   单张图片 */
        	   sendFile(files[0],editor,welEditable);
           }else if (files.length>1){
        	   /* 多张图片 */
        	   sendFiles(files,editor,welEditable);
        	  /*  for(var item in files){
        		   sendFile(item,editor,welEditable);
        	   } */
        	   
           }
           }
       }
     });
 });

//异步上传图片
function sendFile(file,editor,welEditable) {
 /* 显示loading */
 var loading = layer.load(1);
    data = new FormData();
    data.append("file", file);
    $.ajax({
        data: data,
        type: "POST",
        url: "<%=basePath%>pictures/uploadImg.do",
        cache: false,
        contentType: false,
        processData: false,
        success: function(data) {
			if(data.msg=='success'){
				layer.close(loading);
				var path ="<%=basePath%>uploadFiles/uploadImgs/"+data.path;
				 $('.summernote').summernote('editor.insertImage', path); 
			     
			}else{
				layer.close(loading);
				swal({
	                title: "图片上传失败！",
	                text: "请您重新上传图片！",
	                type: "error",
	                showCancelButton: false,
	                confirmButtonColor: "#DD6B55",
	                confirmButtonText: "OK",
	                closeOnConfirm: true,
	                timer:1500
	            });
			}
			 
		},  
		error:function(){
			 layer.close(loading);
			 swal({
	                title: "图片上传失败！",
	                text: "请您重新上传图片！",
	                type: "error",
	                showCancelButton: false,
	                confirmButtonColor: "#DD6B55",
	                confirmButtonText: "OK",
	                closeOnConfirm: true,
	                timer:1500
	            });
		}  
    });
}

//异步上传图片 ,多张(暂时未做处理)
function sendFiles(file,editor,welEditable) {
 /* 显示loading */
 var loading = layer.load(1);
    data = new FormData();
    data.append("file", file);
    $.ajax({
        data: data,
        type: "POST",
        url: "<%=basePath%>pictures/uploadImg.do",
        cache: false,
        contentType: false,
        processData: false,
        success: function(data) {
			if(data.msg=='success'){
				layer.close(loading);
				var path ="<%=basePath%>uploadFiles/uploadImgs/"+data.path;
				 $('.summernote').summernote('editor.insertImage', path); 
			     
			}else{
				layer.close(loading);
				swal({
	                title: "图片上传失败！",
	                text: "请您重新上传图片！",
	                type: "error",
	                showCancelButton: false,
	                confirmButtonColor: "#DD6B55",
	                confirmButtonText: "OK",
	                closeOnConfirm: true,
	                timer:1500
	            });
			}
			 
		},  
		error:function(){
			 layer.close(loading);
			 swal({
	                title: "图片上传失败！",
	                text: "请您重新上传图片！",
	                type: "error",
	                showCancelButton: false,
	                confirmButtonColor: "#DD6B55",
	                confirmButtonText: "OK",
	                closeOnConfirm: true,
	                timer:1500
	            });
		}  
    });
}

	//关闭页面
	function CloseSUWin(id) {
		window.parent.$("#" + id).data("kendoWindow").close();
		/* window.location.reload();  */
	}
</script>
</body>

</html>
