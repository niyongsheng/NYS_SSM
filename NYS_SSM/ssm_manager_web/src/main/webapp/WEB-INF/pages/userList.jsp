<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<!-- 网页使用的语言 -->
<html lang="zh-CN">
<head>
    <!-- 指定字符集 -->
    <meta charset="utf-8">
    <!-- 使用Edge最新的浏览器的渲染方式 -->
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- viewport视口：网页可以根据设置的宽度自动进行适配，在浏览器的内部虚拟一个容器，容器的宽度与设备的宽度相同。
    width: 默认宽度与设备的宽度相同
    initial-scale: 初始的缩放比，为1:1 -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>用户信息管理</title>

    <!-- 1. 导入CSS的全局样式 -->
    <link href="${pageContext.request.contextPath}/plugins/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- 2. 导入bootstrap的js文件 -->
    <script src="${pageContext.request.contextPath}/plugins/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <!-- 3. jQuery导入，建议使用1.9以上的版本 -->
    <script src="${pageContext.request.contextPath}/plugins/jquery/jquery.min.js"></script>

    <style type="text/css">
        td, th {
            text-align: center;
        }
        .contentWrapper {
            margin: 0;
            padding: 15px;
            width: 100%;
            height: 100%;
        }
    </style>

    <script>
        function deleteUser(id) {
            // 给出安全操作提示
            if (confirm("您确定要删除吗？")) {
                location.href = "${pageContext.request.contextPath}/user/deleteUserById?id="+id+"&pageNum=${pagingList.pageNum}&pageSize=${pagingList.pageSize}";
            }
        }

        window.onload = function () {
            // 给删除选中按钮添加点击事件
            document.getElementById("delSelected").onclick = function () {
                // 给出安全操作提示
                if (confirm("您确定要批量删除吗？")) {
                    // 判断是否有选中条目
                    var checkBoxes = document.getElementsByName("uid");
                    for (var i = 0; i < checkBoxes.length; i++) {
                        if (checkBoxes[i].checked) {
                            // 批量删除表单提交
                            document.getElementById("selectedForm").submit();
                            break;
                        }
                    }
                }
            }

            // 1.获取全选CheckBox
            document.getElementById("allSelected").onclick = function () {
                // 2.获取下列checkBox集合
                var checkBoxes = document.getElementsByName("uid");
                // 3.遍历更新状态
                for (var i = 0; i < checkBoxes.length; i++) {
                    checkBoxes[i].checked = this.checked;
                }
            }
        }

        $("#ips2").bind("input propertychange",function(event){
            console.log($("#ips2").val())
        });
    </script>
</head>

<body>
<!-- Content Wrapper. Contains page content -->
<div class="contentWrapper">
<%--    <h3 style="text-align: center">用户信息列表</h3>--%>

    <div style="float: left; margin: 10px;">
        <form class="form-inline" action="${pageContext.request.contextPath}/user/findByFuzzySearch" method="post">
            <div class="form-group">
                <label for="exampleInputName2">昵称</label>
                <input type="text" name="nickname" value="${condition.nickname[0]}" class="form-control" style="width: 100px" id="exampleInputName2">
            </div>
            <div class="form-group">
                <label for="exampleInputName3">账号</label>
                <input type="text" name="account" value="${condition.account[0]}" class="form-control" id="exampleInputName3">
            </div>
            <div class="form-group">
                <label for="exampleInputPhone2">手机号</label>
                <input type="text" name="phone" value="${condition.phone[0]}" class="form-control" id="exampleInputPhone2">
            </div>
            <%-- 记录分页大小 --%>
            <input type="number" name="pageSize" class="hidden" id="ips1">
            <button type="submit" class="btn btn-default">查询</button>
        </form>
    </div>

    <div style="float: right; margin: 10px;">
        <a class="btn btn-info" href="${pageContext.request.contextPath}/add.jsp">添加新用户</a>
        <a class="btn btn-danger" href="javascript:void()" id="delSelected">删除选中</a>
    </div>

    <form id="selectedForm" action="${pageContext.request.contextPath}/user/deleteSelected?&pageNum=${pagingList.pageNum}&pageSize=${pagingList.pageSize}" method="post">
        <table border="1" class="table table-bordered table-hover">
            <tr class="active">
                <th><input type="checkbox" id="allSelected"></th>
                <th>编号</th>
                <th>头像</th>
                <th>昵称</th>
                <th>账号</th>
                <th>性别</th>
                <th>简介</th>
                <th>团契</th>
                <th>手机号</th>
                <th>身份</th>
                <th>等级</th>
                <th>积分</th>
                <th>状态</th>
                <th>修改时间</th>
                <th>创建时间</th>
                <th>编辑</th>
            </tr>

            <c:forEach items="${pagingList.list}" var="user" varStatus="s">
                <tr>
                    <td><input type="checkbox" name="uid" value="${user.id}"></td>
                    <td>${s.count}</td>
                    <td><img src="${user.icon}" class="img-circle" width="30px" height="30px"></td>
                    <td>${user.nickname}</td>
                    <td>${user.account}</td>
                    <td>${user.gender}</td>
                    <td>${user.introduction}</td>
                    <td>${user.fellowship}</td>
                    <td>${user.phone}</td>
                    <td>${user.profession}</td>
                    <td>${user.grade}</td>
                    <td>${user.score}</td>
                    <td>${user.status}</td>
                    <td>${user.gmtModify}</td>
                    <td>${user.gmtCreate}</td>
                    <td><a class="btn btn-default btn-sm"
                           href="${pageContext.request.contextPath}/findUserServlet?id=${user.id}">修改</a>
                        <a class="btn btn-default btn-sm" href="javascript:deleteUser(${user.id});">删除</a></td>
                </tr>
            </c:forEach>
        </table>
    </form>

    <div style="float: bottom">
        <nav aria-label="Page navigation">
            <ul class="pagination">
                <c:if test="${pagingList.isFirstPage}"> <li class="disabled"> </c:if>
                    <c:if test="${!pagingList.isFirstPage}">
                <li>
                    </c:if>
                    <a href="${pageContext.request.contextPath}/user/findByFuzzySearch?pageNum=${pagingList.pageNum - 1}&pageSize=10&nickname=${condition.nickname[0]}&account=${condition.account[0]}&phone=${condition.phone[0]}"
                        aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                        </a>
                        </li>
                        <c:forEach begin="1" end="${pagingList.pages}" var="i">

                            <c:if test="${pagingList.pageNum == i}">
                                <li class="active">
                                    <a href="${pageContext.request.contextPath}/user/findByFuzzySearch?pageNum=${i}&pageSize=10&nickname=${condition.nickname[0]}&account=${condition.account[0]}&phone=${condition.phone[0]}">${i}</a>
                        </li>
                    </c:if>

                    <c:if test="${pagingList.pageNum != i}">
                        <li>
                            <a href="${pageContext.request.contextPath}/user/findByFuzzySearch?pageNum=${i}&pageSize=10&nickname=${condition.nickname[0]}&account=${condition.account[0]}&phone=${condition.phone[0]}">${i}</a>
                        </li>
                    </c:if>

                </c:forEach>
                <c:if test="${pagingList.pageNum == pagingList.pageSize}">
                <li class="disabled">
                    </c:if>
                    <c:if test="${pagingList.pageNum != pagingList.pageSize}">
                <li>
                    </c:if>
                    <a href="${pageContext.request.contextPath}/user/findByFuzzySearch?pageNum=${pagingList.pageNum + 1}&pageSize=10&nickname=${condition.nickname[0]}&account=${condition.account[0]}&phone=${condition.phone[0]}"
                       aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                    </a>
                </li>
                <div class="input-group input-group-sm" style="float: left;margin-left: 7px">
                    <a class="input-group-addon" id="sizing-addon3" style="width: 40px;font-size: 12px;">分页</a>
                    <input type="number" class="form-control" id="ips2" oninput="" value="${pagingList.pageSize}" style="width: 50px"
                           aria-describedby="sizing-addon3">
                </div>
                <span style="font-size: 20px;margin-left: 5px">
                    总计${pagingList.total}条记录\共${pagingList.pages}页
                </span>
            </ul>
        </nav>
    </div>

</div>

</body>
</html>
