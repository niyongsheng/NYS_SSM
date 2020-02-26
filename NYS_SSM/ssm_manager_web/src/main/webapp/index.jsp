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
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<!-- INDEX PAGE -->
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="x-ua-compatible" content="ie=edge">

    <title>稻草堆后台管理系统V1.0</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/img/appdownload/logo_icon_120x120.png">
    <!-- Font Awesome Icons -->
    <link href="<%=path%>/css/icons.css" rel="stylesheet">
    <!-- Overlay Scrollbars -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/adminlte.min.css">
    <!-- Google Font: Source Sans Pro -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700">

    <script>
        function changeFrameHeight() {
            var ifm = document.getElementById("mainIframe");
            var navBarHeight = $("#navBar").height();
            var footerHeight = $("#footer").height();
            ifm.height = $(document.body).height(); // -88
            // ifm.height = $(document.body).height() - navBarHeight - footerHeight;
            console.log("导航栏高度：" + navBarHeight + " Footer高度：" + footerHeight);
        }

        // 监听浏览器窗口尺寸改变
        window.onresize = function () {
            changeFrameHeight();
        }
    </script>
</head>

<body class="hold-transition sidebar-mini layout-fixed layout-navbar-fixed layout-footer-fixed">

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
            <!-- Single button -->
            <li class="nav-item dropdown">
                <a class="nav-link rounded dropdown-toggle" href="#" role="button" data-toggle="dropdown"
                   aria-haspopup="true" aria-expanded="false">
                    稻草堆团契
                </a>
                <ul class="dropdown-menu">
                    <li class="dropdown-item"><a class="dropdown-item-text" href="#">测试团契1</a></li>
                    <li class="dropdown-item"><a class="dropdown-item-text" href="#">测试团契2</a></li>
                    <li class="dropdown-item"><a class="dropdown-item-text" href="#">测试团契3</a></li>
                </ul>
            </li>
        </ul>
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
            <li class="nav-item dropdown">
                <a class="nav-link" data-toggle="dropdown" href="#">
                    <i class="mdi mdi-bell-outline mdi-24px"></i>
                    <%--                    <i class="far fa-comment fa-lg"></i>--%>
                    <span class="badge badge-danger navbar-badge">3</span>
                </a>
                <div class="dropdown-menu dropdown-menu-lg dropdown-menu-right">
                    <a href="#" class="dropdown-item">
                        <!-- Message Start -->
                        <div class="media">
                            <img src="${pageContext.request.contextPath}/file/logo.png" alt="User Avatar"
                                 class="img-size-50 mr-3 img-circle">
                            <div class="media-body">
                                <h3 class="dropdown-item-title">
                                    Brad Diesel
                                    <span class="float-right text-sm text-danger"><i class="fas fa-star"></i></span>
                                </h3>
                                <p class="text-sm">Call me whenever you can...</p>
                                <p class="text-sm text-muted"><i class="far fa-clock mr-1"></i> 4 Hours Ago</p>
                            </div>
                        </div>
                        <!-- Message End -->
                    </a>
                    <div class="dropdown-divider"></div>
                    <a href="#" class="dropdown-item">
                        <!-- Message Start -->
                        <div class="media">
                            <img src="${pageContext.request.contextPath}/file/logo.png" alt="User Avatar"
                                 class="img-size-50 img-circle mr-3">
                            <div class="media-body">
                                <h3 class="dropdown-item-title">
                                    John Pierce
                                    <span class="float-right text-sm text-muted"><i class="fas fa-star"></i></span>
                                </h3>
                                <p class="text-sm">I got your message bro</p>
                                <p class="text-sm text-muted"><i class="far fa-clock mr-1"></i> 4 Hours Ago</p>
                            </div>
                        </div>
                        <!-- Message End -->
                    </a>
                    <div class="dropdown-divider"></div>
                    <a href="#" class="dropdown-item">
                        <!-- Message Start -->
                        <div class="media">
                            <img src="${pageContext.request.contextPath}/file/logo.png" alt="User Avatar"
                                 class="img-size-50 img-circle mr-3">
                            <div class="media-body">
                                <h3 class="dropdown-item-title">
                                    Nora Silvester
                                    <span class="float-right text-sm text-warning"><i class="fas fa-star"></i></span>
                                </h3>
                                <p class="text-sm">The subject goes here</p>
                                <p class="text-sm text-muted"><i class="far fa-clock mr-1"></i> 4 Hours Ago</p>
                            </div>
                        </div>
                        <!-- Message End -->
                    </a>
                    <div class="dropdown-divider"></div>
                    <a href="#" class="dropdown-item dropdown-footer">See All Messages</a>
                </div>
            </li>
            <!-- User Account: style can be found in dropdown.less -->
            <li class="dropdown user user-menu align-self-center">
                <a class="nav-link rounded dropdown-toggle" href="#" role="button" data-toggle="dropdown"
                   aria-haspopup="true" aria-expanded="false">
                    <img src="${sessionScope.user.icon}" class="img-circle user-image" alt="User Image">
                    ${sessionScope.user.nickname}
                    <span class="fa fa-caret-down" title="个人信息菜单"></span>
                </a>
                <ul class="dropdown-menu dropdown-menu-lg dropdown-menu-right">
                    <!-- User image -->
                    <li class="user-header">
                        <img src="${sessionScope.user.icon}" class="img-circle" alt="User Image">
                        <p>
                            <small><shiro:hasRole name="admin"><a
                                    style="color: orange">[管理员]</a></shiro:hasRole></small>
                            <small><shiro:hasRole name="superadmin"><a style="color: orange">[超级管理员]</a></shiro:hasRole></small>
                            <small><shiro:hasRole name="pastor"><a
                                    style="color: orange">[牧者]</a></shiro:hasRole></small>
                            <small><shiro:hasRole name="service"><a
                                    style="color: orange">[服侍]</a></shiro:hasRole></small>
                            <small><shiro:hasRole name="user"><a
                                    style="color: orange">[普通用户]</a></shiro:hasRole></small>
                        </p>
                        <small>${sessionScope.user.introduction}</small>
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
            <%-- 右边栏 control sidebar --%>
            <li class="nav-item">
                <a class="nav-link" data-widget="control-sidebar" data-slide="true" href="#"><i
                        class="fas fa-th-large"></i></a>
            </li>
        </ul>
    </nav>
    <!-- /.navbar -->

    <!-- Main Sidebar Container -->
    <aside class="main-sidebar sidebar-dark-primary elevation-4">
        <!-- Brand Logo -->
        <a href="#" class="brand-link">
            <img src="${pageContext.request.contextPath}/img/adminLogo.png" class="brand-image img-circle elevation-3"
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
                                    <p style="width: 20px"></p>
                                    <i class="fa fa-chart-bar nav-icon"></i>
                                    <p>数据纵览</p>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/home/activity" target="iframe"
                                   class="nav-link">
                                    <p style="width: 20px"></p>
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
                                    <p style="width: 20px"></p>
                                    <i class="fa fa-list-ol nav-icon"></i>
                                    <p>用户列表</p>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/group/findAllGroups?fellowship=${sessionScope.user.fellowship}"
                                   target="iframe" class="nav-link">
                                    <p style="width: 20px"></p>
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
                                    <p style="width: 20px"></p>
                                    <i class="fa fa-pen-nib nav-icon"></i>
                                    <p>Markdown</p>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/upload/uploadPage" target="iframe"
                                   class="nav-link">
                                    <p style="width: 20px"></p>
                                    <i class="fa fa-list-alt nav-icon"></i>
                                    <p>分享列表</p>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/upload/uploadPage" target="iframe"
                                   class="nav-link">
                                    <p style="width: 20px"></p>
                                    <i class="fa fa-praying-hands nav-icon"></i>
                                    <p>代祷列表</p>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/home/test" target="iframe"
                                   class="nav-link">
                                    <p style="width: 20px"></p>
                                    <i class="fa fa-trophy nav-icon"></i>
                                    <p>活动列表</p>
                                </a>
                            </li>
                        </ul>
                    </li>
                    <li class="nav-item has-treeview">
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
                                    <p style="width: 20px"></p>
                                    <i class="fa fa-music nav-icon"></i>
                                    <p>音频列表</p>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/user/test" target="iframe" class="nav-link">
                                    <p style="width: 20px"></p>
                                    <i class="fa fa-video nav-icon"></i>
                                    <p>视频列表</p>
                                </a>
                            </li>
                        </ul>
                    </li>
                    <li class="nav-item has-treeview">
                        <a href="#" class="nav-link">
                            <i class="nav-icon fas fa-lightbulb"></i>
                            <p>
                                测试服务
                                <i class="right fas fa-angle-left"></i>
                            </p>
                        </a>
                        <ul class="nav nav-treeview">
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/user/conversation" target="iframe"
                                   class="nav-link">
                                    <p style="width: 20px"></p>
                                    <i class="fa fa-comment nav-icon"></i>
                                    <p>Websocket</p>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="<%=basePath%>/webservice/cxfWebService?wsdl" target="_blank" class="nav-link">
                                    <p style="width: 20px"></p>
                                    <i class="fa fa-bicycle nav-icon"></i>
                                    <p>WebService</p>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/jsonp/jsonpTest" target="iframe"
                                   class="nav-link">
                                    <p style="width: 20px"></p>
                                    <i class="fa fa-wifi nav-icon"></i>
                                    <p>Jsonp</p>
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
                                    <p style="width: 20px"></p>
                                    <i class="fa fa-clipboard nav-icon"></i>
                                    <p>用户协议</p>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/../api/swagger-ui.html" target="iframe"
                                   class="nav-link">
                                    <p style="width: 20px"></p>
                                    <i class="fa fa-code nav-icon"></i>
                                    <p>app接口</p>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/swagger-ui.html" target="iframe"
                                   class="nav-link">
                                    <p style="width: 20px"></p>
                                    <i class="fa fa-code nav-icon"></i>
                                    <p>web接口</p>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="${pageContext.request.contextPath}/user/appDownload" target="iframe"
                                   class="nav-link">
                                    <p style="width: 20px"></p>
                                    <i class="fa fa-download nav-icon"></i>
                                    <p>下载地址</p>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="https://github.com/niyongsheng/NYS_SSM" target="_blank" class="nav-link">
                                    <p style="width: 20px"></p>
                                    <i class="fa fa-star nav-icon"></i>
                                    <p>开源地址</p>
                                </a>
                            </li>
                        </ul>
                    </li>
                    <li class="nav-header">MISCELLANEOUS</li>
                    <li class="nav-item">
                        <a href="https://github.com/niyongsheng/NYS_SSM/blob/master/LICENSE" target="_blank"
                           class="nav-link">
                            <i class="nav-icon fas fa-file"></i>
                            <p>Documentation</p>
                        </a>
                    </li>
                    <li class="nav-header">LABELS</li>
                    <li class="nav-item">
                        <a href="<%=path%>/user/test" class="nav-link" target="iframe">
                            <i class="nav-icon far fa-circle text-white"></i>
                            <p>TestWeb</p>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="<%=path%>/error/500" class="nav-link" target="iframe">
                            <i class="nav-icon far fa-circle text-danger"></i>
                            <p class="text">Important</p>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="<%=path%>/error/errorUnauth" class="nav-link" target="iframe">
                            <i class="nav-icon far fa-circle text-warning"></i>
                            <p>Warning</p>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="<%=path%>/error/null" class="nav-link" target="iframe">
                            <i class="nav-icon far fa-circle text-info"></i>
                            <p>Informational</p>
                        </a>
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
    <!-- ./main-sidebar -->

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <div class="content container-fluid">
            <%-- iframe框架 --%>
            <iframe name="iframe" id="mainIframe" src="${pageContext.request.contextPath}/home/infoBox" frameborder="0"
                    align="middle" width="100%" scrolling="auto" onload="changeFrameHeight()"></iframe>
        </div>
    </div>
    <!-- /.content-wrapper -->

    <!-- Control Sidebar -->
    <aside class="control-sidebar control-sidebar-dark">
        <!-- Control sidebar content goes here -->
    </aside>
    <!-- /.control-sidebar -->

    <!-- Main Footer -->
    <footer id="footer" class="main-footer">
        <!-- Default to the left -->
        <strong>Copyright &copy; 2019-2020 <a href="http://www.daocaodui.top/web">daocaodui.top</a> @</strong>
        <a>硕鼠工作室 All rights reserved.</a>
        <!-- To the right -->
        <div class="float-right d-none d-sm-inline-block">
            <b>塑造生命 成就使命</b>
        </div>
    </footer>
    <%-- ./main-footer --%>
</div>

<!-- jQuery -->
<script src="${pageContext.request.contextPath}/plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="${pageContext.request.contextPath}/plugins/bootstrap-4/js/bootstrap.bundle.min.js"></script>
<!-- Overlay Scrollbars -->
<script src="${pageContext.request.contextPath}/plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
<!-- AdminLTE App -->
<script src="${pageContext.request.contextPath}/js/adminlte.js"></script>
<%-- Control Sidebar --%>
<script src="${pageContext.request.contextPath}/js/colorful.js"></script>

</body>
</html>

