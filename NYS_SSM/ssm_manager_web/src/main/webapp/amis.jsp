<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh">
<head>
  <meta charset="UTF-8">
  <title>AMis Demo</title>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <meta name="viewport"
        content="width=device-width, initial-scale=1, maximum-scale=1">
  <meta http-equiv="X-UA-Compatible" content="IE=Edge">
  <link rel="stylesheet"
        href="plugins/AMis/sdk_AMis.css">
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
<script src="plugins/AMis/sdk_AMis.js"></script>
<script type="text/javascript">
  (function() {
    var amis = amisRequire('amis/embed');
    amis.embed('#root', {
      "$schema": "https://houtai.baidu.com/v2/schemas/page.json",
      "type": "page",
      "title": "标题",
      "remark": "提示 Tip",
      "body": [
        "\n            <p>`initApi` 拉取失败时，页面内容区会显示对应的错误信息。</p>\n\n            <p>其他提示示例</p>\n        ",
        {
          "type": "alert",
          "level": "success",
          "body": "温馨提示：对页面功能的提示说明，绿色为正向类的消息提示"
        },
        {
          "type": "alert",
          "level": "warning",
          "body": "您的私有网络已达到配额，如需更多私有网络，可以通过<a>工单</a>申请"
        }
      ],
      "aside": "边栏",
      "toolbar": "工具栏",
      "initApi": "https://houtai.baidu.com/api/mock2/page/initDataError"
    });
  })();
</script>
</body>
</html>