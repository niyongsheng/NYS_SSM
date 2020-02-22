<%--
  Created by IntelliJ IDEA.
  User: nigang
  Date: 2019/9/23
  Time: 11:39 上午
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>

<!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <meta http-equiv="x-ua-compatible" content="ie=edge">

    <title>Markdown</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/Editor/css/editormd.min.css">
    <script src="${pageContext.request.contextPath}/plugins/jquery/jquery.min.js"></script>

    <script type="text/javascript">
        $(function() {
            var editor = editormd("editor", {
                width: "100%",
                height: "900px",
                // markdown: "xxxx",     // dynamic set Markdown text
                emoji: true,
                path : "${pageContext.request.contextPath}/plugins/Editor/lib/",  // Autoload modules mode, codemirror, marked... dependents libs path

                imageUpload          : true,          // Enable/disable upload
                imageFormats         : ["jpg", "jpeg", "gif", "png", "bmp", "webp"],
                imageUploadURL       : "${pageContext.request.contextPath}/upload/qiniuUpload",             // Upload url
                crossDomainUpload    : false,          // Enable/disable Cross-domain upload
                uploadCallbackURL    : ""             // Cross-domain upload callback url
            });
        });
    </script>
</head>
<body>

<div id="editor">
    <!-- Tips: Editor.md can auto append a `<textarea>` tag -->
    <textarea style="display:none;">### 稻草堆</textarea>
</div>
<%-- js引用一定要放在body最下部 --%>
<script src="${pageContext.request.contextPath}/plugins/Editor/editormd.js"></script>
</body>
</html>
