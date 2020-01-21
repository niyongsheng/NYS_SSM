<%--
  Created by IntelliJ IDEA.
  User: nigang
  Date: 2020/1/21
  Time: 10:36 上午
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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

    <title>User Privacy Protocol</title>

    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/fontawesome-free/css/all.min.css">
    <%-- ionic icon --%>
    <link rel="stylesheet" href="https://cdn.staticfile.org/ionicons/2.0.1/css/ionicons.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/adminlte.min.css">
    <!-- Google Font: Source Sans Pro -->
    <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">

    <style type="text/css">
        td, th {
            text-align: center;
        }

        .contentWrapper {
            margin: 0px;
            padding: 15px;
            width: 100%;
        }
    </style>
</head>
<body class="hold-transition skin-blue sidebar-mini">
<!-- Content Wrapper. Contains page content -->
<div class="contentWrapper">
    <!-- Main content -->
    <section class="content">
        <div class="content">
            <h3 class="headline text-dark">《用户隐私保护协议》</h3>
            <br>
            <div class="col-lg-5">
                <form class="search-form">
                    <div class="input-group">
                        <input type="text" name="search" class="form-control" placeholder="Search">

                        <div class="input-group-append">
                            <button type="submit" name="submit" class="btn btn-dark"><i class="fas fa-search"></i>
                            </button>
                        </div>
                    </div>
                    <!-- /.input-group -->
                </form>
            </div>
            <br>
        </div>

        <article>
            <!-- Main content -->
            <div class="content container-fluid">
                <div class="row">
                    <div class="col-lg-auto">
                        <section class="content-max-width">
                            <section id="date">
                                <div class="callout callout col-lg-8">
                                    <h5><i class="fas fa-exclamation-triangle text-yellow"></i> Date </h5>
                                    <p>更新日期：2020年01月01日<br>生效日期：2020年01月01日</p>
                                </div>
                                <hr>
                                <h5>
                                    <div>稻草堆APP是一款由我们提供服务的本地化团契生活服务类产品，为说明稻草堆会如何收集、使用和存储你的个人信息及你享有何种权利，我们将通过本协议向你阐述相关事宜，其中要点如下：</div>
                                </h5>
                                <ul>
                                    <li>i. 我们将逐一说明我们收集的你的个人信息类型及其对应的用途，以便你了解我们针对某一特定功能所收集的具体个人信息的类别、使用理由及收集方式。</li>
                                    <li>ii.
                                        当你使用一些功能时，我们会在获得你的同意后，收集你的一些敏感信息，例如你在使用稻草堆运动功能时我们会收集你的步数信息。除非按照相关法律法规要求必须收集，拒绝提供这些信息仅会使你无法使用相关特定功能，但不影响你正常使用稻草堆的其他功能。
                                    </li>
                                    <li>iii. 目前，稻草堆不会主动共享或转让你的个人信息至第三方，如存在其他共享或转让你的个人信息情形时，我们会征得你的明示同意。</li>
                                    <li>iv. 此外，我们也将会严格遵守相关法律法规的规定，并要求第三方保障其提供的信息的合法性。</li>
                                    <li>v. 你可以通过本协议所列途径访问、更正、删除你的个人信息，也可以撤回同意、投诉举报以及设置隐私功能。</li>
                                </ul>

                                <h5>1.我们收集的信息</h5>
                                <p>在你使用稻草堆服务的过程中，稻草堆会按照如下方式收集你在使用服务时主动提供或因为使用服务而产生的信息，用以向你提供服务、优化我们的服务以及保障你的帐号安全：</p>
                                <ul>
                                    <li>1.1
                                        当你注册稻草堆服务时，我们会收集你的昵称、头像、手机号码，收集这些信息是为了帮助你完成稻草堆注册，保护你稻草堆帐号的安全。手机号码属于敏感信息，收集此类信息是为了满足相关法律法规的网络实名制要求。若你不提供这类信息，你可能无法正常使用我们的服务。
                                    </li>
                                    <li>
                                        1.2当你使用稻草堆运动功能时，我们需要收集你的步数信息，与你的好友进行比较。该信息属于敏感信息，拒绝提供这些信息仅会使你无法使用稻草堆运动功能，但不影响你正常使用稻草堆的其他功能。
                                    </li>
                                </ul>
                                <h5>2.信息的存储</h5>
                                <ul>
                                    <li>2.1 信息存储的地点
                                        <p>我们会按照法律法规规定，将境内收集的用户个人信息存储于中国境内。</p>
                                    </li>
                                    <li>2.2 信息存储的期限
                                        <p>一般而言，我们仅为实现目的所必需的时间保留你的个人信息，例如：
                                            手机号码：若你需要使用稻草堆服务，我们需要一直保存你的手机号码，以保证你正常使用该服务，当你注销稻草堆帐户后，我们将删除相应的信息；
                                            运动信息：当你使用了运动排行榜服务，我们需要保存你的运动步数信息，以保证你正常使用运动排行榜功能，当你删除APP时，我们将删除相应的信息。
                                            当我们的产品或服务发生停止运营的情形时，我们将以推送通知、公告等形式通知您，并在合理的期限内删除您的个人信息或进行匿名化处理。</p>
                                    </li>
                                </ul>

                                <h5>3.信息安全</h5>
                                <p>我们努力为用户的信息安全提供保障，以防止信息的丢失、不当使用、未经授权访问或披露。
                                    我们将在合理的安全水平内使用各种安全保护措施以保障信息的安全。例如，我们会使用加密技术（例如，MD5）、匿名化处理等手段来保护你的个人信息。</p>
                                <h5>4.对外提供</h5>
                                <p>目前，我们不会主动共享或转让你的个人信息至第三方，如存在其他共享或转让你的个人信息情形时，我们会征得你的明示同意。
                                    我们不会对外公开披露其收集的个人信息，如必须公开披露时，我们会向你告知此次公开披露的目的、披露信息的类型及可能涉及的敏感信息，并征得你的明示同意。</p>
                                <h5>5.你的权利</h5>
                                <p>在你使用稻草堆期间，为了你可以更加便捷地访问、更正、删除你的个人信息。此外，我们还设置了投诉举报渠道，你的意见将会得到及时的处理。</p>
                                <h5>6.变更</h5>
                                <p>
                                    我们可能会适时对本协议进行修订。当协议的条款发生变更时，我们会在你登录及版本更新时以推送通知、弹窗的形式向你展示变更后的协议。请你注意，只有在你点击弹窗中的同意按钮后，我们才会按照更新后的协议收集、使用、存储你的个人信息。</p>
                                <h5>7.未成年人保护</h5>
                                <p>
                                    我们非常重视对未成年人个人信息的保护。根据相关法律法规的规定，若你是18周岁以下的未成年人，在使用稻草堆服务前，应事先取得你的家长或法定监护人的书面同意。若你是未成年人的监护人，当你对你所监护的未成年人的个人信息有相关疑问时，请通过第8节中的联系方式与我们联系。</p>
                                <h5>8.与我们联系</h5>
                                <p>当你有其他的投诉、建议、未成年人个人信息相关问题时，请通过<a href="http://www.daocaodui.top">http://www.daocaodui.top</a>
                                    与我们联系。你也可以将你的问题发送至<a href="mailto:niyongsheng@outlook.com">niyongsheng@outlook.com</a>或寄到如下地址：</p>
                                <ul>
                                    <li>中国山东省临沂市兰山区兰山街道书香门第 倪刚（收）</li>
                                    <li>邮编：276000</li>
                                    <li>我们将尽快审核所涉问题，并在验证你的用户身份后的十五天内予以回复。</li>
                                </ul>

                            </section>
                        </section>
                    </div>
                </div>
            </div>
            <!-- /.content -->
        </article>

    </section>
    <!-- /.content -->
</div>


<!-- jQuery -->
<script src="${pageContext.request.contextPath}/plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="${pageContext.request.contextPath}/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="${pageContext.request.contextPath}/js/adminlte.min.js"></script>
</body>
</html>
