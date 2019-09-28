<%--
  Created by IntelliJ IDEA.
  User: nigang
  Date: 2019/9/28
  Time: 9:01 上午
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <title>APIs</title>
    <link rel="icon" href="https://github.com/niyongsheng/NYS_SSM/blob/master/logo.png?raw=true" type="image/x-icon"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.7.2/animate.min.css">
    <script>
        function animation() {
            const element =  document.querySelector('.mylogo')
            element.classList.add('animated', 'bounceOutRight', 'fast')
        }
    </script>
</head>
<body>
<h1 class="animated lightSpeedIn fast">NYS_SSM</h1>
<img class="myLogo" src="https://github.com/niyongsheng/NYS_SSM/blob/master/logo.png?raw=true"/>
<button class="animated rotateInDownLeft delay-2s" onclick="animation()">点火!</button>
<hr class="animated fadeInLeft delay-1s" style="width: 400px;" align="left"/>
<a class="animated zoomIn delay-3s" href="${pageContext.request.contextPath}/swagger-ui.html" style="font-size: 22px">📎 Swagger</a>
<br/>
<a class="animated zoomIn delay-3s" href="https://github.com/niyongsheng/NYS_SSM/" style="font-size: 22px">📎 OpenSources</a>
</body>
</html>
