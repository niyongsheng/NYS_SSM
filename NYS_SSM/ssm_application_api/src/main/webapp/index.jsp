<!DOCTYPE html>
<html lang="zh">
<head>
  <meta charset="UTF-8">
  <title>AMIS Demo</title>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <meta name="viewport"
        content="width=device-width, initial-scale=1, maximum-scale=1">
  <meta http-equiv="X-UA-Compatible" content="IE=Edge">
  <link rel="stylesheet"
        href="css/sdk_AMis.css">
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
<script src="js/sdk_AMis.js"></script>
<script type="text/javascript">
  (function() {
    var amis = amisRequire('amis/embed');
    amis.embed('#root', {
      type: 'page',
      title: 'AMIS Demo',
      body: 'hello world'
    });
  })();
</script>
</body>
</html>