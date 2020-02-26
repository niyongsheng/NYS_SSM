<%--
  Created by IntelliJ IDEA.
  User: nigang
  Date: 2020/2/24
  Time: 4:56 下午
  To change this template use File | Settings | File Templates.

  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.4.1/dist/jquery.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>群组信息管理</title>

    <!-- Theme Css -->
    <link href="<%=path%>/plugins/bootstrap-4/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%=path%>/css/style.css" rel="stylesheet">
    <!-- Responsive and DataTables -->
    <link href="<%=path%>/plugins/datatables/dataTables.bootstrap4.min.css" rel="stylesheet" type="text/css">
<%--    <link href="<%=path%>/plugins/datatables/buttons.bootstrap4.min.css" rel="stylesheet" type="text/css">--%>
<%--    <link href="<%=path%>/plugins/datatables/responsive.bootstrap4.min.css" rel="stylesheet" type="text/css">--%>
    <link href="<%=path%>/plugins/responsive-table/css/rwd-table.min.css" rel="stylesheet" type="text/css" media="screen">

    <style type="text/css">
        td, th {
            text-align: center;
        }

        .table-responsive {
            margin-top: 15px;
        }

        img {
            -webkit-transition: ease .2s;
            transition: ease .2s;
            -webkit-transform-origin: 50% 50%; /* transform-origin默认值就是居中，可以不加 */
            transform-origin: 50% 50%; /* transform-origin默认值就是居中，可以不加 */
        }

        .hover {
            -webkit-transform: scale(2.2); /*放大倍数*/
            transform: scale(2.2); /*放大倍数*/
        }
    </style>
</head>

<body>
<div class="table-responsive" data-pattern="priority-columns">
    <div data-responsive-table-toolbar="table-1" class="float-right" style="margin-top: 10px; margin-bottom: 10px; padding-right: 7px"></div>
    <table id="table-1" class="table table-bordered dataTable table-small-font table-striped display-all"
           role="grid" aria-describedby="datatable_info">
        <thead>
        <tr role="row">
            <th id="table-1-col-0" class="sorting_asc" tabindex="0" aria-controls="datatable"
                rowspan="1" colspan="1" aria-sort="ascending"
                aria-label="Name: activate to sort column descending"
                style="display: table-cell;">编号
            </th>
            <th id="table-1-col-1" data-priority="1" class="sorting_asc" tabindex="0"
                aria-controls="datatable"
                rowspan="1" colspan="1" aria-sort="ascending"
                aria-label=""
                style="display: table-cell;">群头像
            </th>
            <th id="table-1-col-2" data-priority="1" class="sorting_asc" tabindex="0" aria-controls="datatable"
                rowspan="1" colspan="1" aria-sort="ascending"
                aria-label=""
                style="display: table-cell;">群名称
            </th>
            <th id="table-1-col-3" data-priority="1" class="sorting" tabindex="0" aria-controls="datatable"
                rowspan="1" colspan="1"
                aria-label=""
                style="display: table-cell;">群ID
            </th>
            <th id="table-1-col-4" data-priority="1" class="sorting" tabindex="0" aria-controls="datatable"
                rowspan="1" colspan="1"
                aria-label=""
                style="display: none;">群简介
            </th>
            <th id="table-1-col-5" data-priority="1" class="sorting" tabindex="0" aria-controls="datatable"
                rowspan="1" colspan="1"
                aria-label=""
                style="display: table-cell;">创建者
            </th>
            <th id="table-1-col-6" data-priority="1" class="sorting" tabindex="0" aria-controls="datatable"
                rowspan="1" colspan="1"
                aria-label=""
                style="display: none;">群类型
            </th>
            <th id="table-1-col-7" data-priority="1" class="sorting" tabindex="0" aria-controls="datatable"
                rowspan="1" colspan="1"
                aria-label=""
                style="display: none;">群状态
            </th>
            <th id="table-1-col-8" data-priority="1" class="sorting" tabindex="0" aria-controls="datatable"
                rowspan="1" colspan="1"
                aria-label=""
                style="display: table-cell;">过期时间
            </th>
            <th id="table-1-col-9" data-priority="1" class="sorting" tabindex="0" aria-controls="datatable"
                rowspan="1" colspan="1"
                aria-label=""
                style="display: table-cell;">创建时间
            </th>
            <th id="table-1-col-10" style="display: table-cell;">编辑</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${pagingList}" var="group" varStatus="s">
            <c:if test="${s.count}%2 == 1">
                <tr role="row" class="odd">
            </c:if>
            <c:if test="${s.count}%2 == 0">
                <tr role="row" class="even">
            </c:if>
            <td data-priority="" colspan="1" data-columns="table-1-col-0" style="display: table-cell;">${s.count}</td>
            <td data-priority="1" colspan="1" data-columns="table-1-col-1" style="display: table-cell;">
                <img src="${group.groupIcon}" class="rounded-circle" width="30px" height="30px">
            </td>
            <td data-priority="1" colspan="1" data-columns="table-1-col-2" class="sorting_1" style="display: table-cell;">${group.groupName}</td>
            <td data-priority="1" colspan="1" data-columns="table-1-col-3" style="display: table-cell;">${group.groupId}</td>
            <td data-priority="1" colspan="1" data-columns="table-1-col-4" style="display: none;"><small>${group.introduction}</small></td>
            <td data-priority="1" colspan="1" data-columns="table-1-col-5" style="display: table-cell;">${group.creator}</td>
            <td data-priority="1" colspan="1" data-columns="table-1-col-6" style="display: none;">${group.groupType}</td>
            <td data-priority="1" colspan="1" data-columns="table-1-col-7" style="display: none;">${group.status}</td>
            <td data-priority="1" colspan="1" data-columns="table-1-col-8" style="display: table-cell;">${group.expireTime}</td>
            <td data-priority="1" colspan="1" data-columns="table-1-col-9" style="display: table-cell;">${group.gmtCreate}</td>
            <td data-priority="" colspan="1" data-columns="table-1-col-10" style="display: table-cell;">
                <a class="btn btn-outline-success" role="button"
                   href="${pageContext.request.contextPath}/findUserServlet?id=${user.id}">查看</a>
                <a class="btn btn-outline-warning" role="button"
                   href="${pageContext.request.contextPath}/findUserServlet?id=${user.id}">修改</a>
                <a class="btn btn-outline-danger" role="button" href="javascript:deleteUser(${user.id});">删除</a>
            </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<!-- Theme Js -->
<script src="<%=path%>/plugins/jquery/jquery.min.js"></script>
<script src="<%=path%>/plugins/popper/popper.min.js"></script>
<script src="<%=path%>/plugins/bootstrap-4/js/bootstrap.min.js"></script>
<!-- Responsive and datatable js -->
<script src="<%=path%>/plugins/datatables/jquery.dataTables.min.js"></script>
<script src="<%=path%>/plugins/datatables/dataTables.bootstrap4.min.js"></script>
<%--<script src="<%=path%>/plugins/datatables/dataTables.responsive.min.js"></script>--%>
<%--<script src="<%=path%>/plugins/datatables/responsive.bootstrap4.min.js"></script>--%>
<script src="<%=path%>/plugins/responsive-table/js/rwd-table.min.js"></script>

<script type="text/javascript">
    $(function () {
        $('.table-responsive').responsiveTable({
            pattern: 'priority-columns',
            stickyTableHeader: true,
            fixedNavbar: '.navbar-fixed-top',
            focusBtnIcon: 'glyphicon glyphicon-screenshot',
            addDisplayAllBtn: 'btn btn-outline-secondary',
            i18n: {
                focus: '聚焦',
                display: '展示项目',
                displayAll: '显示所有'
            }
        });
    });

    // $('.table-responsive').responsiveTable('update');

    $(document).ready(function () {
        $('#table-1').DataTable()
    });

    $(document).ready(function () {
        <%-- 划过图片<img>放大效果 --%>
        $('img').hover(function () {
            $(this).addClass('hover')
        }, function () {
            $(this).removeClass('hover')
        });
    });
</script>

</body>

</html>

