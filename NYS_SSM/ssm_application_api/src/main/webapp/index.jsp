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
    <link rel="icon" href="${pageContext.request.contextPath}/file/logo.png" type="image/x-icon"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.7.2/animate.min.css">
    <script src="https://use.fontawesome.com/e148434007.js"></script>
    <script>
        function animationOut() {
            const element =  document.querySelector('.myLogo')
            element.classList.add('animated', 'bounceOutRight', 'fast')
        }
        function animationIn() {
            const element =  document.querySelector('.myLogo')
            element.classList.add('animated', 'bounceInRight', 'fast')
        }
    </script>
</head>
<body>
<h1 class="animated lightSpeedIn fast">NYS_SSM
<i class="fa fa-cog fa-spin fa-1x fa-fw "></i>
</h1>

<img class="myLogo" src="${pageContext.request.contextPath}/file/logo.png"/>
<button class="animated rotateInDownLeft delay-2s" onclick="animationOut()">点火!</button>
<%--<button class="animated rotateInDownRight delay-3s" onclick="animationIn()">回收!</button>--%>
<hr class="animated fadeInLeft delay-1s" style="width: 300px;" align="left"/>

<i class="fa fa-paper-plane fa-2x animated zoomIn delay-2s" aria-hidden="true"></i>
<a class="animated zoomIn delay-2s" href="${pageContext.request.contextPath}/swagger-ui.html" style="font-size: 22px">Swagger</a>
<br/>
<i class="fa fa-github-alt fa-2x animated zoomIn delay-2s" aria-hidden="true"></i>
<a class="animated zoomIn delay-2s" href="https://github.com/niyongsheng/NYS_SSM/" style="font-size: 22px">OpenSources</a>
</body>
</html>
