<%--
  Created by IntelliJ IDEA.
  User: nigang
  Date: 2019/9/11
  Time: 10:43 上午
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>

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

    <title>稻草堆后台管理系统V1.0</title>

    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/fontawesome-free/css/all.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/adminlte.min.css">
    <!-- Google Font: Source Sans Pro -->
    <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">
    <script>
        function changeFrameHeight() {
            var ifm = document.getElementById("mainIframe");
            // var navBar = document.getElementById("navBar");
            // var footer = document.getElementById("footer");
            // var navBarHeight = window.getComputedStyle(navBar).height;
            // var footerHeight = window.getComputedStyle(footer).height;
            // var navBarHeight = $("#navBar").height();
            // var footerHeight = $("#footer").height();
            ifm.height = document.documentElement.clientHeight - 88;
            // ifm.height = document.documentElement.clientHeight - navBarHeight - footerHeight;
            out.println("导航栏高度：" + navBarHeight + "Footer高度：" + footerHeight);
        }

        // window.onpageshow = function () {
        //     changeFrameHeight();
        // };
        // window.onloadstart = function () {
        //     changeFrameHeight();
        // };
        // document.ready = function () {
        //     changeFrameHeight1();
        // };
        // document.onload = function () {
        //     changeFrameHeight();
        // };
        window.onresize = function () {
            changeFrameHeight();
        }
    </script>
</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">

    <!-- Navbar -->
    <nav id="navBar" class="main-header navbar navbar-expand navbar-white navbar-light">
        <!-- Left navbar links -->
        <ul class="navbar-nav">
            <li class="nav-item">
                <a class="nav-link" data-widget="pushmenu" href="#"><i class="fas fa-bars"></i></a>
            </li>
            <li class="nav-item d-none d-sm-inline-block">
                <a href="index.jsp" class="nav-link">首页</a>
            </li>
            <li class="nav-item d-none d-sm-inline-block">
                <a href="#" class="nav-link">联系</a>
            </li>
        </ul>

        <!-- Single button -->
        <div class="btn-group" role="group">
            <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true"
                    aria-expanded="false">
                稻草堆
                <span class="caret"></span>
            </button>
            <ul class="dropdown-menu">
                <li class="dropdown-item"><a class="dropdown-item-text" href="#">Dropdown link</a></li>
                <li class="dropdown-item"><a class="dropdown-item-text" href="#">Dropdown link</a></li>
            </ul>
        </div>

        <!-- SEARCH FORM -->
        <form class="form-inline ml-3">
            <div class="input-group input-group-sm">
                <input class="form-control form-control-navbar" type="search" placeholder="搜索" aria-label="Search">
                <div class="input-group-append">
                    <button class="btn btn-navbar" type="submit">
                        <i class="fas fa-search"></i>
                    </button>
                </div>
            </div>
        </form>

        <!-- Right navbar links -->
        <ul class="navbar-nav ml-auto">
            <!-- User Account: style can be found in dropdown.less -->
            <li class="dropdown user user-menu align-self-center">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                    <img src="${sessionScope.user.icon}" class="user-image" alt="User Image">
                    <span class="hidden-xs align-content-center">${sessionScope.user.nickname}</span>
                </a>
                <ul class="dropdown-menu dropdown-menu-lg dropdown-menu-right">
                    <!-- User image -->
                    <li class="user-header">
                        <img src="${sessionScope.user.icon}" class="img-circle" alt="User Image">
                        <p>
                            ${sessionScope.user.nickname}<br>
                            <small><shiro:hasRole name="admin"> 管理员 </shiro:hasRole></small>
                            <small><shiro:hasRole name="superadmin"> 超级管理员 </shiro:hasRole></small>
                            <small><shiro:hasRole name="pastor"> 牧者 </shiro:hasRole></small>
                            <small><shiro:hasRole name="service"> 服侍 </shiro:hasRole></small>
                            <small><shiro:hasRole name="user"> 普通用户 </shiro:hasRole></small>
                            <small>${sessionScope.user.introduction}</small>
                        </small>
                    </li>
                    <!-- Menu Footer-->
                    <li class="user-footer">
                        <div class="fa-pull-left">
                            <a href="#" class="btn btn-default btn-flat">设置</a>
                        </div>
                        <div class="fa-pull-right">
                            <a href="${pageContext.request.contextPath}/user/logout"
                               class="btn btn-default btn-flat">退出</a>
                        </div>
                    </li>
                </ul>
            </li>
            <%-- 右边栏 --%>
            <%--            <li class="nav-item">
                            <a class="nav-link" data-widget="control-sidebar" data-slide="true" href="#"><i
                                    class="fas fa-th-large"></i></a>
                        </li>--%>
        </ul>
    </nav>
    <!-- /.navbar -->

    <!-- Main Sidebar Container -->
    <aside class="main-sidebar sidebar-dark-primary elevation-4">
        <!-- Brand Logo -->
        <a href="#" class="brand-link">
            <img src="img/AdminLTELogo.png" alt="AdminLTE Logo" class="brand-image img-circle elevation-3"
                 style="opacity: .8">
            <span class="brand-text font-weight-light">稻草堆后台 V1.0</span>
        </a>

        <!-- Sidebar -->
        <div class="sidebar">

            <!-- Sidebar Menu -->
            <nav class="mt-2">
                <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu"
                    data-accordion="false">
                    <!-- Add icons to the links using the .nav-icon class
                         with font-awesome or any other icon font library -->
                    <li class="nav-item has-treeview menu-open">
                        <a href="#" class="nav-link">
                            <i class="nav-icon fas fa-tachometer-alt"></i>
                            <p>
                                业务数据
                                <i class="right fas fa-angle-left"></i>
                            </p>
                        </a>
                        <ul class="nav nav-treeview">
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/home/infoBox" target="iframe"
                                   class="nav-link">
                                    <i class="fa fa-chart-bar nav-icon"></i>
                                    <p>数据纵览</p>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/home/activity" target="iframe"
                                   class="nav-link">
                                    <i class="fa fa-bullhorn nav-icon"></i>
                                    <p>轮播公告</p>
                                </a>
                            </li>
                        </ul>
                    </li>
                    <li class="nav-item has-treeview menu-open">
                        <a href="#" class="nav-link">
                            <i class="nav-icon fas fa-user"></i>
                            <p>
                                用户管理
                                <i class="right fas fa-angle-left"></i>
                            </p>
                        </a>
                        <ul class="nav nav-treeview">
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/user/findAll" target="iframe"
                                   class="nav-link">
                                    <i class="fa fa-list-ol nav-icon"></i>
                                    <p>用户列表</p>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/home/test" target="iframe" class="nav-link">
                                    <i class="fa fa-users nav-icon"></i>
                                    <p>群组列表</p>
                                </a>
                            </li>
                        </ul>
                    </li>
                    <li class="nav-item has-treeview menu-open">
                        <a href="#" class="nav-link">
                            <i class="nav-icon fa fa-briefcase"></i>
                            <p>
                                业务管理
                                <i class="right fas fa-angle-left"></i>
                            </p>
                        </a>
                        <ul class="nav nav-treeview">
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/home/markdown" target="iframe"
                                   class="nav-link">
                                    <i class="fa fa-pen-nib nav-icon"></i>
                                    <p>Markdown</p>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/upload/uploadPage" target="iframe"
                                   class="nav-link">
                                    <i class="fa fa-list-alt nav-icon"></i>
                                    <p>分享列表</p>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/upload/uploadPage" target="iframe"
                                   class="nav-link">
                                    <i class="fa fa-praying-hands nav-icon"></i>
                                    <p>代祷列表</p>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/upload/uploadPage" target="iframe"
                                   class="nav-link">
                                    <i class="fa fa-trophy nav-icon"></i>
                                    <p>活动列表</p>
                                </a>
                            </li>
                        </ul>
                    </li>
                    <li class="nav-item has-treeview menu-open">
                        <a href="#" class="nav-link">
                            <i class="nav-icon fas fa-play-circle"></i>
                            <p>
                                影音管理
                                <i class="right fas fa-angle-left"></i>
                            </p>
                        </a>
                        <ul class="nav nav-treeview">
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/user/findAll" target="iframe"
                                   class="nav-link">
                                    <i class="fa fa-music nav-icon"></i>
                                    <p>音频列表</p>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/home/test" target="iframe" class="nav-link">
                                    <i class="fa fa-video nav-icon"></i>
                                    <p>视频列表</p>
                                </a>
                            </li>
                        </ul>
                    </li>
                    <li class="nav-item has-treeview">
                        <a href="#" class="nav-link">
                            <i class="nav-icon fa fa-plane"></i>
                            <p>
                                开发服务
                                <i class="right fas fa-angle-left"></i>
                            </p>
                        </a>
                        <ul class="nav nav-treeview">
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/user/userProtocol" target="iframe"
                                   class="nav-link">
                                    <i class="fa fa-clipboard nav-icon"></i>
                                    <p>用户协议</p>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/../api/swagger-ui.html" target="iframe"
                                   class="nav-link">
                                    <i class="fa fa-code nav-icon"></i>
                                    <p>app接口</p>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/swagger-ui.html" target="iframe"
                                   class="nav-link">
                                    <i class="fa fa-code nav-icon"></i>
                                    <p>web接口</p>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/user/appDownload" target="iframe"
                                   class="nav-link">
                                    <i class="fa fa-download nav-icon"></i>
                                    <p>下载地址</p>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="https://github.com/niyongsheng/NYS_SSM" class="nav-link">
                                    <i class="fa fa-star nav-icon"></i>
                                    <p>开源地址</p>
                                </a>
                            </li>
                        </ul>
                    </li>
                    <li class="nav-item">
                        <a href="https://github.com/niyongsheng/niyongsheng.github.io/blob/master/Beg/README.md"
                           target="iframe" class="nav-link active">
                            <i class="nav-icon fas fa-th"></i>
                            <p>
                                关于我们
                                <span class="right badge badge-danger">爱</span>
                            </p>
                        </a>
                    </li>
                </ul>
            </nav>
            <!-- /.sidebar-menu -->
        </div>
        <!-- /.sidebar -->
    </aside>

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <%-- iframe框架 --%>
        <iframe name="iframe" id="mainIframe" src="${pageContext.request.contextPath}/home/infoBox" frameborder="0"
                align="middle" width="100%" scrolling="auto" onload="changeFrameHeight()"></iframe>
    </div>
    <!-- /.content-wrapper -->

    <!-- Main Footer -->
    <footer id="footer" class="main-footer">
        <!-- To the right -->
        <div class="float-right d-none d-sm-inline">
            塑造生命 成就使命
        </div>
        <!-- Default to the left -->
        <strong>Copyright &copy; 2019-2020 <a href="http://www.daocaodui.top/web">daocaodui.top</a> @</strong>硕鼠工作室 All
        rights
        reserved.
    </footer>
</div>
<!-- ./wrapper -->

<!-- REQUIRED SCRIPTS -->

<!-- jQuery -->
<script src="${pageContext.request.contextPath}/plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="${pageContext.request.contextPath}/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="${pageContext.request.contextPath}/js/adminlte.min.js"></script>
</body>
</html>

