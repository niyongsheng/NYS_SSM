<%--
  Created by IntelliJ IDEA.
  User: nigang
  Date: 2019/8/31
  Time: 1:55 下午
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <h3>请求成功</h3>
    <% System.out.println("success.jsp执行了..."); %>

    ${account.name}
    <br>
    ${account.id}
    <br>
    ${account.money}
    <hr>

</body>
</html>
