<%--
  Created by IntelliJ IDEA.
  User: nigang
  Date: 2020/1/21
  Time: 12:45 下午
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
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

    <title>稻草堆APP</title>
    <%-- 收藏用logo图标 --%>
    <link rel="bookmark" type="image/x-icon" href="${pageContext.request.contextPath}/img/appDownload/logo_icon_120x120.png"/>
    <%-- 网站显示页logo图标 --%>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/img/appDownload/logo_icon_120x120.png">

    <%-- toastr --%>
    <link href="${pageContext.request.contextPath}/plugins/toastr/toastr.min.css" rel='stylesheet' type='text/css'>
    <%-- Bootstrap --%>
    <link href="${pageContext.request.contextPath}/plugins/appDownload/bootstrap.css" rel='stylesheet' type='text/css'>
    <!-- Custom Theme files -->
    <link href="${pageContext.request.contextPath}/plugins/appDownload/style.css" rel='stylesheet' type='text/css'>
    <!-- Custom Theme files -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- jQuery -->
    <script src="${pageContext.request.contextPath}/plugins/appDownload/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/plugins/appDownload/move-top.js"></script>
    <script src="${pageContext.request.contextPath}/plugins/appDownload/easing.js"></script>
    <script src="${pageContext.request.contextPath}/plugins/toastr/toastr.min.js"></script>
    <%-- 初始化弹框提醒 --%>
    <script type="text/javascript">
        function popup() {
            alert("安卓版本开发中...");
            toastr.options.positionClass = 'toast-bottom-right';
            toastr.warning('安卓版预计年中上线');
        }
    </script>

    <script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
    <script type="text/javascript">
        jQuery(document).ready(function($) {
            $(".scroll").click(function(event){
                event.preventDefault();
                $('html,body').animate({scrollTop:$(this.hash).offset().top},1000);
            });
        });
    </script>
</head>
<body>
<!---- container ---->
<div class="container">
    <!---- header ---->
    <div class="header">
        <div class="col-md-5 header-left">
            <!----sreen-gallery-cursual---->
            <div class="sreen-gallery-cursual">
                <!-- requried-jsfiles-for owl -->
                <link href="${pageContext.request.contextPath}/plugins/appDownload/owl.carousel.css" rel="stylesheet">
                <script src="${pageContext.request.contextPath}/plugins/appDownload/owl.carousel.js"></script>
                <script>
                    $(document).ready(function() {
                        $("#owl-demo").owlCarousel({
                            items : 1,
                            lazyLoad : true,
                            autoPlay : true,
                            navigation : false,
                            navigationText :  false,
                            pagination : true,
                        });
                    });
                </script>
                <!-- //requried-jsfiles-for owl -->
                <div id="owl-demo" class="owl-carousel">
                    <div class="item">
                        <img src="${pageContext.request.contextPath}/img/appDownload/divice_1.png" title="name" />
                    </div>
                    <div class="item">
                        <img src="${pageContext.request.contextPath}/img/appDownload/divice_2.png" title="name" />
                    </div>
                    <div class="item">
                        <img src="${pageContext.request.contextPath}/img/appDownload/divice_3.png" title="name" />
                    </div>
                </div>
                <!--//sreen-gallery-cursual---->
            </div>
        </div>
        <div class="col-md-7 header-right">
            <a href="#"><img src="${pageContext.request.contextPath}/img/appDownload/logo_icon_120x120.png" class="img-responsive img-thumbnail" title="daocaodui" /></a>
            <p>塑造生命 成就使命!</p>
            <ul class="big-btns">
                <li><a class="btn-g" href="https://itunes.apple.com/cn/app/id1495581916">下载APP</a></li>
                <li><a class="btn-gr" href="${pageContext.request.contextPath}/home/login">关于</a></li>
            </ul>
            <ul class="usefull-for">
                <li><a class="u-apple" href="https://itunes.apple.com/cn/app/id1495581916"><span> </span></a></li>
                <li><a class="u-and" href="javascript:void(0)" onclick="popup()"><span> </span></a></li>
<%--                <li><a class="u-windows" href="javascript:void(0)" onclick="popup()"><span> </span></a></li>--%>
            </ul>
        </div>
        <div class="clearfix"> </div>
    </div>
</div>
<!---- header ---->
<!----- top-grids ----->
<div class="top-grids">
    <div class="container">
        <div class="top-grids-head text-center">
            <h3>稻草堆是一款我们提供支持的本地化团契生活服务类产品</h3>
            <p>旨在更好的帮助弟兄姊妹分享、读经、代祷建立规律的属灵生活和亲密的团契关系。</p>
        </div>
        <div class="top-grids-box">
            <div class="col-md-4  top-grid text-center">
                <span class="t-icon1"> </span>
                <h4>LOVE</h4>
                <p>“A new command I give you: Love one another. As I have loved you, so you must love one another.By this everyone will know that you are my disciples, if you love one another.” (John 13:34-35 NIV) </p>
            </div>
            <div class="col-md-4  top-grid text-center">
                <span class="t-icon1"> </span>
                <h4>CONFIDENCE</h4>
                <p>Now faith is confidence in what we hope for and assurance about what we do not see. This is what the ancients were commended for.  (Hebrews 11:1-2 NIV) </p>
            </div>
            <div class="col-md-4  top-grid text-center">
                <span class="t-icon1"> </span>
                <h4>HOPE</h4>
                <p>For in this hope we were saved. But hope that is seen is no hope at all. Who hopes for what they already have? But if we hope for what we do not yet have, we wait for it patiently.  (Romans 8:24-25 NIV) </p>
            </div>
            <div class="clearfix"> </div>
        </div>
    </div>
</div>
<!----- top-grids ----->
<!----- featrues-grids----->
<div class="fea-grids">
    <div class="container">
        <div class="col-md-6 fea-grids-left">
            <script>
                $(document).ready(function() {
                    $("#owl-demo1").owlCarousel({
                        items : 1,
                        lazyLoad : true,
                        autoPlay : true,
                        navigation : false,
                        navigationText :  false,
                        pagination : true,
                    });
                });
            </script>
            <!-- //requried-jsfiles-for owl -->
            <!-- start content_slider -->
            <div id="owl-demo1" class="owl-carousel">
                <div class="item">
                    <img src="${pageContext.request.contextPath}/img/appDownload/IMG_0312.PNG" title="name" />
                </div>
                <div class="item">
                    <img src="${pageContext.request.contextPath}/img/appDownload/IMG_0313.PNG" title="name" />
                </div>
                <div class="item">
                    <img src="${pageContext.request.contextPath}/img/appDownload/IMG_0314.PNG" title="name" />
                </div>
                <div class="item">
                    <img src="${pageContext.request.contextPath}/img/appDownload/IMG_0315.PNG" title="name" />
                </div>
                <div class="item">
                    <img src="${pageContext.request.contextPath}/img/appDownload/IMG_0316.PNG" title="name" />
                </div>
                <div class="item">
                    <img src="${pageContext.request.contextPath}/img/appDownload/IMG_0317.PNG" title="name" />
                </div>
                <div class="item">
                    <img src="${pageContext.request.contextPath}/img/appDownload/IMG_0318.PNG" title="name" />
                </div>
                <div class="item">
                    <img src="${pageContext.request.contextPath}/img/appDownload/IMG_0319.PNG" title="name" />
                </div>
            </div>
            <!--//sreen-gallery-cursual---->
        </div>
        <div class="tlinks">Collect from <a href="http://www.cssmoban.com/"  title="网站模板">网站模板</a></div>
        <div class="col-md-6 fea-grids-left">
            <h3>稻草堆APP功能性介绍： </h3>
            <div class="fea-grids-left-grids">
                <div class="fea-grids-left-grid">
                    <div class="fea-grids-left-grid-left">
                        <span class="fea-icon4"> </span>
                    </div>
                    <div class="fea-grids-left-grid-right">
                        <h4>联系</h4>
                        <p>私聊、群聊、音视频通话 </p>
                    </div>
                    <div class="clearfix"> </div>
                </div>
                <div class="fea-grids-left-grid">
                    <div class="fea-grids-left-grid-left">
                        <span class="fea-icon1"> </span>
                    </div>
                    <div class="fea-grids-left-grid-right">
                        <h4>分享</h4>
                        <p>分享心得感受、转载文章 </p>
                    </div>
                    <div class="clearfix"> </div>
                </div>
                <div class="fea-grids-left-grid">
                    <div class="fea-grids-left-grid-left">
                        <span class="fea-icon2"> </span>
                    </div>
                    <div class="fea-grids-left-grid-right">
                        <h4>读经</h4>
                        <p>在线阅读、读经打卡 </p>
                    </div>
                    <div class="clearfix"> </div>
                </div>
                <div class="fea-grids-left-grid">
                    <div class="fea-grids-left-grid-left">
                        <span class="fea-icon3"> </span>
                    </div>
                    <div class="fea-grids-left-grid-right">
                        <h4>代祷</h4>
                        <p>发布查看代祷事项</p>
                    </div>
                    <div class="clearfix"> </div>
                </div>
                <div class="fea-grids-left-grid">
                    <div class="fea-grids-left-grid-left">
                        <span class="fea-icon2"> </span>
                    </div>
                    <div class="fea-grids-left-grid-right">
                        <h4>活动</h4>
                        <p>发起或加入群组活动 </p>
                    </div>
                    <div class="clearfix"> </div>
                </div>
                <div class="fea-grids-left-grid">
                    <div class="fea-grids-left-grid-left">
                        <span class="fea-icon4"> </span>
                    </div>
                    <div class="fea-grids-left-grid-right">
                        <h4>音频</h4>
                        <p>上传收听诗歌、主日分享 </p>
                    </div>
                    <div class="clearfix"> </div>
                </div>
                <div class="fea-grids-left-grid">
                    <div class="fea-grids-left-grid-left">
                        <span class="fea-icon1"> </span>
                    </div>
                    <div class="fea-grids-left-grid-right">
                        <h4>书单</h4>
                        <p>发现、推荐属灵书籍 </p>
                    </div>
                    <div class="clearfix"> </div>
                </div>
                <div class="fea-grids-left-grid">
                    <div class="fea-grids-left-grid-left">
                        <span class="fea-icon3"> </span>
                    </div>
                    <div class="fea-grids-left-grid-right">
                        <h4>搜索</h4>
                        <p>在线圣经全文检索</p>
                    </div>
                    <div class="clearfix"> </div>
                </div>
            </div>
        </div>
        <div class="clearfix"> </div>
    </div>
</div>
<!----- featrues-grids----->
<!----- testmonials ---->
<div class="testmonials">
    <div class="container">
        <script>
            $(document).ready(function() {
                $("#owl-demo2").owlCarousel({
                    items : 1,
                    lazyLoad : true,
                    autoPlay : true,
                    navigation : false,
                    navigationText :  false,
                    pagination : true,
                });
            });
        </script>
        <!-- //requried-jsfiles-for owl -->
        <!-- start content_slider -->
        <div id="owl-demo2" class="owl-carousel">
            <div class="item">
                <div class="testmonial-grids">
                    <div class="testmonial-head text-center">
                        <img src="${pageContext.request.contextPath}/img/appDownload/quit.png" title="name" />
                        <p>"稻草堆项目是个人工作之余的开源项目，还有很多需要改进和优化的地方，如果你在使用过程中有任何想法、建议或者希望参与其中，欢迎联系我。"</p>
                    </div>
                    <div class="testmonial-row">
                        <div class="col-md-4 testmonial-grid">
                            <div class="t-people-left">
                                <img src="${pageContext.request.contextPath}/img/appDownload/user_icon_1.png" class="img-responsive img-thumbnail_1" title="name" />
                            </div>
                            <div class="t-people-right">
                                <h4>John Ni</h4>
                                <span>设计</span>
                            </div>
                            <div class="clearfix"> </div>
                        </div>
                        <div class="col-md-4 testmonial-grid">
                            <div class="t-people-left">
                                <img src="${pageContext.request.contextPath}/img/appDownload/user_icon_1.png" class="img-responsive img-thumbnail_1" title="name" />
                            </div>
                            <div class="t-people-right">
                                <h4>John Ni</h4>
                                <span>开发</span>
                            </div>
                            <div class="clearfix"> </div>
                        </div>
                        <div class="col-md-4 testmonial-grid">
                            <div class="t-people-left">
                                <img src="${pageContext.request.contextPath}/img/appDownload/user_icon_1.png" class="img-responsive img-thumbnail_1" title="name" />
                            </div>
                            <div class="t-people-right">
                                <h4>John Ni</h4>
                                <span>维护</span>
                            </div>
                            <div class="clearfix"> </div>
                        </div>
                        <div class="clearfix"> </div>
                    </div>
                </div>
            </div>
            <div class="item">
                <div class="testmonial-grids">
                    <div class="testmonial-head text-center">
                        <img src="${pageContext.request.contextPath}/img/appDownload/quit.png" title="name" />
                        <p>"The Daocaodui is an open source project of personal work, that needs to be improved and optimized. If you have any ideas, suggestions or wish to participate in the process, Wellcome to contact me."</p>
                    </div>
                    <div class="testmonial-row">
                        <div class="col-md-4 testmonial-grid">
                            <div class="t-people-left">
                                <img src="${pageContext.request.contextPath}/img/appDownload/user_icon_1.png" class="img-responsive img-thumbnail_1" title="name" />
                            </div>
                            <div class="t-people-right">
                                <h4>John Ni</h4>
                                <span>Designer</span>
                            </div>
                            <div class="clearfix"> </div>
                        </div>
                        <div class="col-md-4 testmonial-grid">
                            <div class="t-people-left">
                                <img src="${pageContext.request.contextPath}/img/appDownload/user_icon_1.png" class="img-responsive img-thumbnail_1" title="name" />
                            </div>
                            <div class="t-people-right">
                                <h4>John Ni</h4>
                                <span>Developer</span>
                            </div>
                            <div class="clearfix"> </div>
                        </div>
                        <div class="col-md-4 testmonial-grid">
                            <div class="t-people-left">
                                <img src="${pageContext.request.contextPath}/img/appDownload/user_icon_1.png" class="img-responsive img-thumbnail_1" title="name" />
                            </div>
                            <div class="t-people-right">
                                <h4>John Ni</h4>
                                <span>Maintenance</span>
                            </div>
                            <div class="clearfix"> </div>
                        </div>
                        <div class="clearfix"> </div>
                    </div>
                </div>
            </div>
        </div>
        <!--//sreen-gallery-cursual---->
    </div>
</div>
<!----- testmonials ---->
<!----- notify ---->
<div class="notify">
    <div class="container">
        <div class="notify-grid">
            <img src="${pageContext.request.contextPath}/img/appDownload/msg-icon.png" title="mail" />
            <h3>Get Notified of any updates!</h3>
            <p>Subscribe to our newsletter to be notified about new version release</p>
            <form>
                <input type="text" class="text" value="niyongsheng@outlook.com" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = 'niyongsheng@outlook.com';}">
                <input type="submit" value="Submit" />
            </form>
        </div>
    </div>
</div>
<!----- notify ---->
<!----- social-icons ---->
<div class="social-icons">
    <div class="container">
        <ul>
            <li><a class="twitter" href="#"><span> </span></a></li>
            <li><a class="facebook" href="#"><span> </span></a></li>
            <li><a class="vemeo" href="#"><span> </span></a></li>
            <li><a class="pin" href="#"><span> </span></a></li>
            <div class="clearfix"> </div>
        </ul>
    </div>
    <!---- footer-links ---->
    <div class="footer-links">
        <ul>
            <li>
                <p>Copyright &copy; 2020.Company Daocaodui All rights reserved.<a href="https://github.com/niyongsheng" target="_blank" title="硕鼠工作室">硕鼠工作室</a></p>
            </li>
        </ul>
        <script type="text/javascript">
            $(document).ready(function() {
                /*
                var defaults = {
                    containerID: 'toTop', // fading element id
                    containerHoverID: 'toTopHover', // fading element hover id
                    scrollSpeed: 1200,
                    easingType: 'linear'
                 };
                */
                toastr.info('稻草堆欢迎你');
                $().UItoTop({ easingType: 'easeOutQuart' });

            });
        </script>
        <a href="#" id="toTop" style="display: block;"> <span id="toTopHover" style="opacity: 1;"> </span></a>
    </div>
    <!---- footer-links ---->
</div>
<!----- social-icons ---->
</div>
<!---- container ---->

</body>
</html>
