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

    <!-- 1. 导入bootstrap的css样式文件 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/plugins/bootstrap-3/css/bootstrap.min.css">
    <!-- 2. 导入bootstrap的js文件 -->
    <script src="${pageContext.request.contextPath}/plugins/bootstrap-3/js/bootstrap.min.js"></script>
    <!-- 3. jQuery导入，建议使用1.9以上的版本 -->
    <script src="${pageContext.request.contextPath}/plugins/jquery/jquery.min.js"></script>

<%--    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">--%>
<%--    <script src="https://cdn.jsdelivr.net/npm/jquery@3.4.1/dist/jquery.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>--%>
<%--    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>--%>
<%--    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>--%>

<%--    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">--%>
<%--    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>--%>

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

    <style type="text/css">
        img {
            -webkit-transition: ease .2s;
            transition: ease .2s;
            -webkit-transform-origin: 50% 50%; /* transform-origin默认值就是居中，可以不加 */
            transform-origin: 50% 50%; /* transform-origin默认值就是居中，可以不加 */
        }

        .hover {
            -webkit-transform: scale(3); /*放大倍数*/
            transform: scale(3); /*放大倍数*/
        }
    </style>

    <script type="text/javascript">
        $(document).ready(function () {
            <%-- 划过图片<img>放大效果 --%>
            $('img').hover(function () {
                $(this).addClass('hover')
            }, function () {
                $(this).removeClass('hover')
            });
        });
    </script>

    <script language="javascript" type="text/javascript">

        // 全选/批量删除
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
                alert("数据无价，谨慎操作！");
                // 2.获取下列checkBox集合
                var checkBoxes = document.getElementsByName("uid");
                // 3.遍历更新状态
                for (var i = 0; i < checkBoxes.length; i++) {
                    checkBoxes[i].checked = this.checked;
                }
            }
        }

        // 删除单个用户
        function deleteUser(id) {
            // 给出安全操作提示
            if (confirm("您确定要删除吗？")) {
                window.location.href = "${pageContext.request.contextPath}/user/deleteUserById?id=" + id + "&pageNum=${pagingList.pageNum}&pageSize=${pagingList.pageSize}";
            }
        }

        // 绑定分页选择事件
        $(document).ready(function () {
            $('#selectedPageSize').change(function () {
                var pageSize = $(this).children('option:selected').val();
                var p2 = $('#param2').val(); // 获取本页面其他标签的值
                window.location.href = "${pageContext.request.contextPath}/user/findByFuzzySearch?pageNum=1&pageSize=" + pageSize + "&nickname=${condition.nickname[0]}&account=${condition.account[0]}&phone=${condition.phone[0]}";
            })
        })
    </script>
</head>

<body>

<div class="contentWrapper">
<%--    <h3 style="text-align: left">用户信息列表</h3>--%>
    <div style="float: left; margin: 0px;">
        <form class="form-inline" action="${pageContext.request.contextPath}/user/findByFuzzySearch" method="post">
            <div class="form-group">
                <label for="exampleInputName2">昵称</label>
                <input type="text" name="nickname" value="${condition.nickname[0]}" class="form-control"
                       style="width: 100px" id="exampleInputName2">
            </div>
            <div class="form-group">
                <label for="exampleInputName3">账号</label>
                <input type="text" name="account" value="${condition.account[0]}" class="form-control"
                       id="exampleInputName3">
            </div>
            <div class="form-group">
                <label for="exampleInputPhone2">手机号</label>
                <input type="text" name="phone" value="${condition.phone[0]}" class="form-control"
                       id="exampleInputPhone2">
            </div>
            <button type="submit" class="btn btn-default">查询</button>
        </form>
    </div>

    <div style="float: right; margin: 10px;">
        <a class="btn btn-info" href="${pageContext.request.contextPath}/add.jsp">添加新用户</a>
        <a class="btn btn-danger" href="javascript:void()" id="delSelected">删除选中</a>
    </div>

    <form id="selectedForm"
          action="${pageContext.request.contextPath}/user/deleteSelected?&pageNum=${pagingList.pageNum}&pageSize=${pagingList.pageSize}"
          method="post">
        <table border="1" class="table table-bordered dataTable" role="grid">
            <tr class="active">
<%--                <th class="sorting_asc" tabindex="0" aria-controls="datatable2" rowspan="1" colspan="1" aria-sort="ascending" aria-label="Name: activate to sort column descending" style="width: 388px;">Name</th>--%>
                <th><input type="checkbox" id="allSelected"></th>
                <th>编号</th>
                <th>头像</th>
                <th>昵称</th>
                <th>账号</th>
                <th>手机号</th>
                <th>性别</th>
                <th>简介</th>
                <th>团契</th>
                <th>身份</th>
                <th>等级</th>
                <th>积分</th>
                <th>状态</th>
                <th>编辑</th>
            </tr>

            <c:forEach items="${pagingList.list}" var="user" varStatus="s">
                <tr>
                    <td><input type="checkbox" name="uid" value="${user.id}"></td>
                    <td>${s.count}</td>
                    <td><img src="${user.icon}" class="img-circle" width="30px" height="30px"></td>
                    <td>${user.nickname}</td>
                    <td>${user.account}</td>
                    <td>${user.phone}</td>
                    <td>${user.gender}</td>
                    <td><small>${user.introduction}</small></td>
                    <td>${user.fellowshipName}</td>
                    <td>${user.roleDescription}</td>
                    <td>${user.grade}</td>
                    <td>${user.score}</td>
                    <td>${user.status}</td>
                    <td>
                        <a class="btn btn-default btn-sm"
                           href="${pageContext.request.contextPath}/findUserServlet?id=${user.id}">查看</a>
                        <a class="btn btn-default btn-sm"
                           href="${pageContext.request.contextPath}/findUserServlet?id=${user.id}">修改</a>
                            <%--                        <a class="btn btn-default btn-sm" href="javascript:deleteUser(${user.id});">删除</a>--%>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </form>

    <div style="float: bottom">
        <nav aria-label="Page navigation">
            <ul class="pagination">
                <c:if test="${pagingList.isFirstPage}">
                <li class="disabled">
                    </c:if>
                    <c:if test="${!pagingList.isFirstPage}">
                <li>
                    </c:if>
                    <a href="${pageContext.request.contextPath}/user/findByFuzzySearch?pageNum=${pagingList.pageNum - 1}&pageSize=${pagingList.pageSize}&nickname=${condition.nickname[0]}&account=${condition.account[0]}&phone=${condition.phone[0]}"
                       aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                    </a>
                </li>
                <c:forEach begin="1" end="${pagingList.pages}" var="i">
                    <c:if test="${pagingList.pageNum == i}">
                        <li class="active">
                            <a href="${pageContext.request.contextPath}/user/findByFuzzySearch?pageNum=${i}&pageSize=${pagingList.pageSize}&nickname=${condition.nickname[0]}&account=${condition.account[0]}&phone=${condition.phone[0]}">${i}</a>
                        </li>
                    </c:if>
                    <c:if test="${pagingList.pageNum != i}">
                        <li>
                            <a href="${pageContext.request.contextPath}/user/findByFuzzySearch?pageNum=${i}&pageSize=${pagingList.pageSize}&nickname=${condition.nickname[0]}&account=${condition.account[0]}&phone=${condition.phone[0]}">${i}</a>
                        </li>
                    </c:if>
                </c:forEach>
                <c:if test="${pagingList.isLastPage}">
                <li class="disabled">
                    </c:if>
                    <c:if test="${!pagingList.isLastPage}">
                <li>
                    </c:if>
                    <a href="${pageContext.request.contextPath}/user/findByFuzzySearch?pageNum=${pagingList.pageNum + 1}&pageSize=${pagingList.pageSize}&nickname=${condition.nickname[0]}&account=${condition.account[0]}&phone=${condition.phone[0]}"
                       aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                    </a>
                </li>
                <%-- 分页 --%>
                <div class="form-inline" style="display: inline-block">
                    <div style="font-size: 15px;margin-left: 10px">分页:
                        <select id="selectedPageSize" class="form-control" href="javascript:selectPageSize();">
                            <c:if test="${pagingList.pageSize == 10}">
                                <option value="10" selected="selected" href="">10</option>
                                <option value="25">25</option>
                                <option value="50">50</option>
                                <option value="100">100</option>
                            </c:if>
                            <c:if test="${pagingList.pageSize == 25}">
                                <option value="10">10</option>
                                <option value="25" selected="selected">25</option>
                                <option value="50">50</option>
                                <option value="100">100</option>
                            </c:if>
                            <c:if test="${pagingList.pageSize == 50}">
                                <option value="10">10</option>
                                <option value="25">25</option>
                                <option value="50" selected="selected">50</option>
                                <option value="100">100</option>
                            </c:if>
                            <c:if test="${pagingList.pageSize == 100}">
                                <option value="10">10</option>
                                <option value="25">25</option>
                                <option value="50">50</option>
                                <option value="100" selected="selected">100</option>
                            </c:if>
                        </select>
                        <span style="font-size: 17px;">总计${pagingList.total}条记录\共${pagingList.pages}页</span>
                    </div>
                </div>
            </ul>
        </nav>
    </div>
</div>

</body>

</html>
