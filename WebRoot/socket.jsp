<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <base href="<%=basePath%>">
    <title></title>
</head>
<body>
<div>
    <input type="submit" value="Start" onclick="startMsg();"/>
</div>
<div id="messages"></div>


<script type="text/javascript">
    var webSocket = new WebSocket('ws://127.0.0.1:8080/NUMYSQL/appwebsocket');

    webSocket.onerror = function (event) {
        onError(event)
    };

    webSocket.onopen = function (event) {
        onOpen(event)
    };

    webSocket.onmessage = function (event) {
        onMessage(event)
    };

    function onMessage(event) {
        document.getElementById('messages').innerHTML += '<br />' + event.data;
    }

    function onOpen(event) {
        //webSocket.send('已链接到');
        document.getElementById('messages').innerHTML = '已链接到服务器';
    }

    function onError(event) {
        document.getElementById('messages').innerHTML = '服务器连接中断';
    }

    function startMsg() {
        webSocket.send('客户端发来的消息');
        return false;
    }

    /* onOpen 我们创建一个连接到服务器的连接时将会调用此方法。

     onError 当客户端-服务器通信发生错误时将会调用此方法。

     onMessage 当从服务器接收到一个消息时将会调用此方法。在我们的例子中，我们只是将从服务器获得的消息添加到DOM。

     我们连接到websocket 服务器端，使用构造函数 new WebSocket() 而且传之以端点URL：

     ws://localhost:8080/byteslounge/websocket  */


</script>
</body>
</html>
