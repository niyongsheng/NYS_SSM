<%--
  Created by IntelliJ IDEA.
  User: nigang
  Date: 2019/9/5
  Time: 9:39 上午
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <!-- 1. 导入CSS的全局样式 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- 2. 导入bootstrap的js文件 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"></script>
    <!-- 3. jQuery导入，建议使用1.9以上的版本 -->
    <script src="https://cdn.bootcss.com/jquery/3.4.1/jquery.min.js"></script>

    <title>Error</title>
</head>
<body>
    <h3>Error</h3>
    ${errorMsg}
    ${errorCode}
</body>
</html>
