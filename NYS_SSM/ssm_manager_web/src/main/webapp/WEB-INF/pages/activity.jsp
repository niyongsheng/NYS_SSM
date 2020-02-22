<%--
  Created by IntelliJ IDEA.
  User: nigang
  Date: 2019/9/24
  Time: 11:03 上午
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>Activity</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <%--  <link rel="stylesheet" href="https://houtai.baidu.com/v2/csssdk">--%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/amis/sdk_AMis.css">
    <style>
        html, body, .app-wrapper {
            position: relative;
            width: 100%;
            height: 100%;
            margin: 0;
            padding: 0;
        }
    </style>
</head>
<body>
<div id="root" class="app-wrapper"></div>
<%--<script src="https://houtai.baidu.com/v2/jssdk"></script>--%>
<script src="${pageContext.request.contextPath}/plugins/amis/sdk_AMis.js"></script>
<script type="text/javascript">
    (function() {
        var amis = amisRequire('amis/embed');
        amis.embed('#root', {
            "$schema": "https://houtai.baidu.com/v2/schemas/page.json",
            "type": "page",
            "title": "轮播图",
            "data": {
                "carousel0": [
                    "https://hiphotos.baidu.com/fex/%70%69%63/item/bd3eb13533fa828b13b24500f31f4134960a5a44.jpg",
                    "https://video-react.js.org/assets/poster.png",
                    "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=3893101144,2877209892&fm=23&gp=0.jpg"
                ],
                "carousel1": [
                    {
                        "html": "<div style=\"width: 100%; height: 300px; background: #e3e3e3; text-align: center; line-height: 300px;\">carousel data in form</div>"
                    },
                    {
                        "image": "https://hiphotos.baidu.com/fex/%70%69%63/item/bd3eb13533fa828b13b24500f31f4134960a5a44.jpg"
                    },
                    {
                        "image": "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=3893101144,2877209892&fm=23&gp=0.jpg"
                    }
                ]
            },
            "body": [
                {
                    "type": "grid",
                    "columns": [
                        {
                            "type": "panel",
                            "title": "直接页面配置",
                            "body": {
                                "type": "carousel",
                                "controlsTheme": "light",
                                "height": "300",
                                "options": [
                                    {
                                        "image": "https://video-react.js.org/assets/poster.png"
                                    },
                                    {
                                        "html": "<div style=\"width: 100%; height: 300px; background: #e3e3e3; text-align: center; line-height: 300px;\">carousel data</div>"
                                    },
                                    {
                                        "image": "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=3893101144,2877209892&fm=23&gp=0.jpg"
                                    }
                                ]
                            }
                        }
                    ]
                },
                {
                    "type": "grid",
                    "columns": [
                        {
                            "type": "form",
                            "title": "表单内展示",
                            "sm": 6,
                            "controls": [
                                {
                                    "type": "carousel",
                                    "controlsTheme": "dark",
                                    "name": "carousel1",
                                    "label": "carousel",
                                    "animation": "slide",
                                    "height": "300"
                                }
                            ]
                        }
                    ]
                }
            ]
        });
    })();
</script>
</body>
</html>