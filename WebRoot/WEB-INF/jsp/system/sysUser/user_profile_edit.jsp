<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>

<head>

    <base href="<%=basePath%>">


    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title>${pd.SYSNAME}</title>
    <!-- jsp文件头和头部 -->
    <%@ include file="../../system/admin/top.jsp" %>

    <!-- fullavatareditor -->
    <!--   <script type="text/javascript" src="static/js/fullavatareditor/scripts/swfobject.js"></script>
      <script type="text/javascript" src="static/js/fullavatareditor/scripts/fullAvatarEditor.js"></script>
      <script type="text/javascript" src="static/js/fullavatareditor/scripts/jQuery.Cookie.js"></script>
      <script type="text/javascript" src="static/js/fullavatareditor/scripts/test.js"></script> -->

    <script type="text/javascript" src="static/js/fullAvatarEditor/scripts/swfobject.js"></script>
    <script type="text/javascript" src="static/js/fullAvatarEditor/scripts/fullAvatarEditor.js"></script>
    <!-- Sweet Alert -->
    <link href="static/js/sweetalert/sweetalert.css" rel="stylesheet">

</head>

<body class="gray-bg">
<form action="sysUser/${msg }.do" name="userForm" id="userForm" method="post">
    <input type="hidden" name="USER_ID" id="user_id" value="${pd.USER_ID }"/>
    <div class="wrapper wrapper-content">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-content">

                        <div style="width:632px;margin: 0 auto;text-align:center">
                            <div>
                                <p id="swfContainer">
                                    本组件需要安装Flash Player后才可使用，请从<a href="http://www.adobe.com/go/getflashplayer">这里</a>下载安装。
                                </p>
                            </div>
                        </div>
                        <!--
                           <ul class="nav nav-tabs" id="avatar-tab">
                               <li class="active" id="upload"><a href="javascript:;">本地上传</a>
                               </li>
                               <li id="webcam"><a href="javascript:;">视频拍照</a>
                               </li>
                               <li id="albums"><a href="javascript:;">相册选取</a>
                               </li>
                           </ul>
                           <div class="m-t m-b">
                               <div id="flash1">
                                   <p id="swf1">本组件需要安装Flash Player后才可使用，请从<a href="http://www.adobe.com/go/getflashplayer">这里</a>下载安装。</p>
                               </div>
                               <div id="editorPanelButtons" style="display:none">
                                   <p class="m-t">
                                       <label class="checkbox-inline">
                                           <input type="checkbox" id="src_upload">是否上传原图片？</label>
                                   </p>
                                   <p>
                                       <a href="javascript:;" class="btn btn-w-m btn-primary button_upload"><i class="fa fa-upload"></i> 上传</a>
                                       <a href="javascript:;" class="btn btn-w-m btn-white button_cancel">取消</a>
                                   </p>
                               </div>
                               <p id="webcamPanelButton" style="display:none">
                                   <a href="javascript:;" class="btn btn-w-m btn-info button_shutter"><i class="fa fa-camera"></i> 拍照</a>
                               </p>
                               <div id="userAlbums" style="display:none">
                                   <a href="img/a1.jpg" class="fancybox" title="选取该照片">
                                       <img src="img/a1.jpg" alt="示例图片1" />
                                   </a>
                                   <a href="img/a2.jpg" class="fancybox" title="选取该照片">
                                       <img src="img/a2.jpg" alt="示例图片2" />
                                   </a>
                                   <a href="img/a3.jpg" class="fancybox" title="选取该照片">
                                       <img src="img/a3.jpg" alt="示例图片2" />
                                   </a>
                                   <a href="img/a4.jpg" class="fancybox" title="选取该照片">
                                       <img src="img/a4.jpg" alt="示例图片2" />
                                   </a>
                                   <a href="img/a5.jpg" class="fancybox" title="选取该照片">
                                       <img src="img/a5.jpg" alt="示例图片2" />
                                   </a>
                                   <a href="img/a6.jpg" class="fancybox" title="选取该照片">
                                       <img src="img/a6.jpg" alt="示例图片2" />
                                   </a>
                                   <a href="img/a7.jpg" class="fancybox" title="选取该照片">
                                       <img src="img/a7.jpg" alt="示例图片2" />
                                   </a>
                                   <a href="img/a8.jpg" class="fancybox" title="选取该照片">
                                       <img src="img/a8.jpg" alt="示例图片2" />
                                   </a>
                                   <a href="img/a9.jpg" class="fancybox" title="选取该照片">
                                       <img src="img/a9.jpg" alt="示例图片2" />
                                   </a>>
                               </div>
                           </div> -->

                    </div>
                </div>

            </div>
        </div>
</form>
<script type="text/javascript">
    $(document).ready(function () {

        swfobject.addDomLoadEvent(function () {
            var swf = new fullAvatarEditor("static/js/fullAvatarEditor/fullAvatarEditor.swf", "expressInstall.swf", "swfContainer", {
                        id: 'swf',
                        upload_url: '<%=basePath%>static/js/fullAvatarEditor/jsp/upload.jsp?userid=${pd.USER_ID }&username=${pd.USERNAME }',	//上传接口
                        method: 'post',	//传递到上传接口中的查询参数的提交方式。更改该值时，请注意更改上传接口中的查询参数的接收方式
                        src_upload: 2,		//是否上传原图片的选项，有以下值：0-不上传；1-上传；2-显示复选框由用户选择
                        avatar_sizes: '200*200',			//定义单个头像
                        avatar_sizes_desc: '200*200像素'	   //头像尺寸的提示文本。
                    }, function (msg) {
                        switch (msg.code) {
                            case 1 :
                                break;
                            case 2 :
                                document.getElementById("upload").style.display = "inline";
                                break;
                            case 3 :
                                if (msg.type == 0) {
                                    //do nothing
                                } else if (msg.type == 1) {
                                    swal({
                                        title: "摄像头已准备就绪但用户未允许使用！",
                                        text: "请允许使用摄像头！",
                                        type: "error",
                                        showCancelButton: false,
                                        confirmButtonColor: "#DD6B55",
                                        confirmButtonText: "OK",
                                        closeOnConfirm: true,
                                        timer: 3000
                                    });
                                } else {
                                    swal({
                                        title: "摄像头被占用！",
                                        text: "请关闭其他摄像头相关应用并重新再试！",
                                        type: "error",
                                        showCancelButton: false,
                                        confirmButtonColor: "#DD6B55",
                                        confirmButtonText: "OK",
                                        closeOnConfirm: true,
                                        timer: 3000
                                    });
                                }
                                break;
                            case 4 :
                                if (msg.type == 2) {
                                    swal({
                                        title: "您选择的原图片文件大小（" + msg.content + "）超出了指定的值(2MB)！",
                                        text: "请重新选择图片后再试！",
                                        type: "error",
                                        showCancelButton: false,
                                        confirmButtonColor: "#DD6B55",
                                        confirmButtonText: "OK",
                                        closeOnConfirm: true,
                                        timer: 3000
                                    });
                                }
                                break;
                            case 5 :
                                if (msg.type == 0) {
                                    if (msg.content.sourceUrl) {
                                        /* alert("原图已成功保存至服务器，url为：\n" +msg.content.sourceUrl+"\n\n" + "头像已成功保存至服务器，url为：\n" + msg.content.avatarUrls.join("\n\n")+"\n\n传递的userid="+msg.content.userid+"&username="+msg.content.username);
                                         */
                                        //更新头像
                                        var url = "<%=basePath%>sysUser/updateAvatar.do?USER_ID=" + msg.content.userid + "&AVATAR=" + msg.content.avatarUrls;
                                        $.get(url, function (data) {
                                            if (data.msg == 'success') {
                                            	swal({   
        		        				        	title: "头像更新成功！",
        		        				        	text: "您已经成功更新了头像。",
        		        				        	type: "success",  
        		        				        	 }, 
        		        				        	function(){   
        		        				        		 CloseSUWin('EditUserProfile');
        		        				        	 });
                                            } else {
                                                swal("头像更新失败", "您的更新操作失败了！", "error");
                                            }
                                        });
                                    } else {
                                        /* alert("头像已成功保存至服务器，url为：\n" + msg.content.avatarUrls.join("\n\n")+"\n\n传递的userid="+msg.content.userid+"&username="+msg.content.username);
                                         CloseSUWin('EditUserProfile'); */
                                        //更新头像
                                        var url = "<%=basePath%>sysUser/updateAvatar.do?USER_ID=" + msg.content.userid + "&AVATAR=" + msg.content.avatarUrls;
                                        $.get(url, function (data) {
                                            if (data.msg == 'success') {
                                            	swal({   
        		        				        	title: "头像更新成功！",
        		        				        	text: "您已经成功更新了头像。",
        		        				        	type: "success",  
        		        				        	 }, 
        		        				        	function(){   
        		        				        		 CloseSUWin('EditUserProfile');
        		        				        	 });
                                            } else {
                                                swal("头像更新失败", "您的更新操作失败了！", "error");
                                            }
                                        });
                                    }
                                }
                                break;
                        }
                    }
            );
            /* document.getElementById("upload").onclick=function(){
             swf.call("upload");
             }; */
        });
    });
</script>
<!-- Sweet alert -->
<script src="static/js/sweetalert/sweetalert.min.js"></script>
<script type="text/javascript">

    function CloseSUWin(id) {
        window.parent.$("#" + id).data("kendoWindow").close();
        window.parent.location.reload();
    }
</script>
</body>

</html>
