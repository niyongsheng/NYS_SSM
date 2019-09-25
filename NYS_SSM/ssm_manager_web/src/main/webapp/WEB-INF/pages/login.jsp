<%--
  Created by IntelliJ IDEA.
  User: nigang
  Date: 2019/9/11
  Time: 12:00 下午
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>稻草堆后台 | Log in</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/fontawesome-free/css/all.min.css">
    <!-- Ionicons -->
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
    <!-- icheck bootstrap -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/icheck-bootstrap/icheck-bootstrap.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/adminlte.min.css">
    <!-- Google Font: Source Sans Pro -->
    <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">
    <script type="text/javascript">
        function refreshCode() {
            // 1.获取验证码图片对象
            var vcode = document.getElementById("vcode");

            // 2.设置src属性，加时间戳
            vcode.src = "${pageContext.request.contextPath}/verification/checkCode?time="+new Date().getTime();
        }

/*        $(function(){
            login.initPage();
        });
        var login = {
            // 初始化页面跳转，为了防止从iframe跳转到login页面直接在iframe中显示login页面
            initPage : function() {
                //alert(location.href);
                if(window.top != window.self){
                    top.location.href = location.href;
                }
            }
        }*/

        if (window != top) {
            top.location.href = location.href;
        }
    </script>
</head>
<body class="hold-transition login-page">
<div class="login-box">
    <div class="login-logo">
        <a href="http://daocaodui.org"><b>稻草堆</b>后台v1.0</a>
    </div>
    <!-- /.login-logo -->
    <div class="card">
        <div class="card-body login-card-body">
            <p class="login-box-msg">Sign in to start your session</p>

            <form action="${pageContext.request.contextPath}/user/login" method="post">
                <div class="input-group mb-3">
                    <input name="account" type="number" class="form-control" placeholder="请输入管理员账号">
                    <div class="input-group-append">
                        <div class="input-group-text">
                            <span class="fas fa-id-card"></span>
                        </div>
                    </div>
                </div>
                <div class="input-group mb-3">
                    <input name="password" type="password" class="form-control" placeholder="请输入管理员密码">
                    <div class="input-group-append">
                        <div class="input-group-text">
                            <span class="fas fa-lock"></span>
                        </div>
                    </div>
                </div>
                <div class="input-group mb-3">
                    <input type="text" name="verifycode" class="form-control" id="verifycode" placeholder="请输入图片验证码"/>
                    <div class="input-group-append">
                        <div class="input-group-text">
                            <span class="fa fa-shield-alt"></span>
                        </div>
                    </div>
                    <a href="javascript:refreshCode()" style="margin-left: 10px"><img src="${pageContext.request.contextPath}/verification/checkCode" title="看不清点击刷新" id="vcode"/></a>
                </div>
                <div class="row">
                    <div class="col-8">
                        <div class="icheck-primary">
                            <input type="checkbox" id="remember">
                            <label for="remember">
                                记住我
                            </label>
                        </div>
                    </div>
                    <!-- /.col -->
                    <div class="col-4">
                        <button type="submit" class="btn btn-primary btn-block btn-flat">登录</button>
                    </div>
                    <!-- /.col -->
                </div>
            </form>

            <div class="social-auth-links text-center mb-3">
                <p>- By -</p>
                <a href="https://github.com/niyongsheng/NYS_SSM" class="btn btn-block btn-dark">
                    <i class="fab fa-github mr-2"></i> Open source with GitHub
                </a>
            </div>
            <!-- /.social-auth-links -->

            <p class="mb-1">
                <a href="#">忘记密码</a>
            </p>
        </div>
        <!-- /.login-card-body -->
    </div>
</div>
<!-- /.login-box -->

<!-- 出错显示的信息框 -->
<c:if test="${login_msg != null}">
    <div class="alert alert-primary alert-dismissible" role="alert" style="margin-left: 10px; width: 300px;">
        <button type="button" class="close" data-dismiss="alert">
            <span>&times;</span></button>
        <h5>提示!</h5>
        <p style="font-size: 14px">${login_msg}</p>
    </div>

<%--    <div class="callout callout-warning" role="callout" style="height: 100px;width: 300px;">
        <button type="button" class="close" data-dismiss="callout">
            <span>&times;</span></button>
        <h6>提示!</h6>
        <p style="font-size: 15px">${login_msg}</p>
    </div>--%>
</c:if>

<!-- jQuery -->
<script src="${pageContext.request.contextPath}/plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="${pageContext.request.contextPath}/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>

</body>
</html>

