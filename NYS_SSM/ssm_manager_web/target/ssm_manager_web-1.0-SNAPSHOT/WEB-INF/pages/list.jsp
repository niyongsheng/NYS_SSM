<%--
  Created by IntelliJ IDEA.
  User: nigang
  Date: 2019/9/6
  Time: 10:31 上午
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <h3>查询了所有的账户信息</h3>
    <c:forEach items="${list}" var="account">
        id：${account.id} 姓名：${account.name} 金额：${account.money}
        <br>
    </c:forEach>
</body>
</html>
