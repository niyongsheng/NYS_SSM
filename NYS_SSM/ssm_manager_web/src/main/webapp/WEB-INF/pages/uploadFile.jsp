<%--
  Created by IntelliJ IDEA.
  User: nigang
  Date: 2019/9/25
  Time: 12:39 下午
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <title>uploadFile</title>
</head>
<body>
<form method="POST" enctype="multipart/form-data" action="${pageContext.request.contextPath}/upload/serviceUpload">
    <table>
        <tr><td>File to upload:</td><td><input type="file" name="file" /></td></tr>
        <tr><td></td><td><input type="submit" value="Upload" /></td></tr>
    </table>
</form>
</body>
</html>
