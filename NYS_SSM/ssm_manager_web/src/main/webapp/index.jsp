<%--
  Created by IntelliJ IDEA.
  User: nigang
  Date: 2019/9/4
  Time: 3:17 下午
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>index</title>
</head>
<body>
    <h3>测试</h3>
    <a href="account/findAll">查询所有账户信息</a>
    <hr>
    <form action="account/save" method="post">
        姓名:<input type="text" name="name"><br>
        金额:<input type="text" name="money"><br>
        <input type="submit" value="保存">
    </form>
</body>
</html>
