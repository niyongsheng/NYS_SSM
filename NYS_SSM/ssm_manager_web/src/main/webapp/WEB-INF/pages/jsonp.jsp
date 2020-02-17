<%--
  Created by IntelliJ IDEA.
  User: nigang
  Date: 2020/2/18
  Time: 12:01 上午
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>跨域传送</title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <!-- jQuery -->
    <script src="${pageContext.request.contextPath}/plugins/jquery/jquery.min.js"></script>
    <!-- Bootstrap 4 -->
    <script src="${pageContext.request.contextPath}/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            $.ajax({
                type: "get",
                async: false,
                url: "${pageContext.request.contextPath}/jsonp/jsonpTest?callback=getUser&userId=3",
                dataType: "jsonp",
                jsonp: "callback", // 一般默认为:callback
                jsonpCallback: "getUser", // 自定义的jsonp回调函数名称，默认为jQuery自动生成的随机函数名，也可以写"?"，jQuery会自动为你处理数据
                success: function (json) {
                    /**
                     * 获得服务器返回的信息。
                     * 可以做具体的业务处理。
                     */
                    alert('用户信息：ID： ' + json.userId + ' ，姓名： ' + json.username + '。');
                },
                error: function () {
                    alert('fail');
                }
            });
        });
    </script>
</head>

<body oncontextmenu="return false">
<div class="jumbotron">
    <h1 class="display-4">Hello, Jsonp!</h1>
    <p class="lead">This is a simple hero unit, a simple jumbotron-style component for calling extra attention to
        featured content or information.</p>
    <hr class="my-4">
    <p>It uses utility classes for typography and spacing to space content out within the larger container.</p>
    <a class="btn btn-primary btn-lg" href="#" role="button">Learn more</a>
</div>
</body>
</html>