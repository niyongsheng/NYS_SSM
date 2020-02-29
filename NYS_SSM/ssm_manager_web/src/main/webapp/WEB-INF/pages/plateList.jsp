<%--
  Created by IntelliJ IDEA.
  User: nigang
  Date: 2020/2/29
  Time: 6:08 下午
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
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>车牌信息管理</title>

    <!-- Theme Css -->
    <link href="<%=path%>/plugins/bootstrap-4/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%=path%>/css/style.css" rel="stylesheet">
    <!-- Responsive and DataTables Css -->
    <link href="<%=path%>/plugins/datatables/css/dataTables.bootstrap4.min.css" rel="stylesheet" type="text/css">
    <link href="<%=path%>/plugins/responsive-table/css/rwd-table.min.css" rel="stylesheet" type="text/css"
          media="screen">

    <style type="text/css">
        td, th {
            text-align: center;
        }

        .table-responsive {
            padding: 20px;
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
    <div data-responsive-table-toolbar="table-1" class="float-right"
         style="margin-top: 10px; margin-bottom: 0px; padding-right: 2px"></div>
    <table id="table-1" class="table table-bordered dataTable table-small-font table-striped display-all"
           role="grid" aria-describedby="datatable_info">
        <thead>
        <tr role="row">
            <th id="table-1-col-0" class="" tabindex="0" aria-controls="datatable"
                rowspan="1" colspan="1" aria-sort="ascending"
                aria-label="Name: activate to sort column descending"
                style="display: table-cell;">编号
            </th>
            <th id="table-1-col-1" data-priority="1" tabindex="0"
                aria-controls="datatable"
                rowspan="1" colspan="1" aria-sort="ascending"
                aria-label=""
                style="display: table-cell;">车牌
            </th>
            <th id="table-1-col-2" data-priority="1" class="" tabindex="0" aria-controls="datatable"
                rowspan="1" colspan="1" aria-sort="ascending"
                aria-label=""
                style="display: table-cell;">车牌号
            </th>
            <th id="table-1-col-3" data-priority="1" class="" tabindex="0" aria-controls="datatable"
                rowspan="1" colspan="1"
                aria-label=""
                style="display: table-cell;">用户账号
            </th>
            <th id="table-1-col-4" data-priority="1" class="" tabindex="0" aria-controls="datatable"
                rowspan="1" colspan="1"
                aria-label=""
                style="display: none;">类型
            </th>
            <th id="table-1-col-5" data-priority="1" class="" tabindex="0" aria-controls="datatable"
                rowspan="1" colspan="1"
                aria-label=""
                style="display: table-cell;">状态
            </th>
            <th id="table-1-col-6" data-priority="1" class="" tabindex="0" aria-controls="datatable"
                rowspan="1" colspan="1"
                aria-label=""
                style="display: none;">开始时间
            </th>
            <th id="table-1-col-7" data-priority="1" class="" tabindex="0" aria-controls="datatable"
                rowspan="1" colspan="1"
                aria-label=""
                style="display: none;">过期时间
            </th>
            <th id="table-1-col-8" data-priority="1" class="" tabindex="0" aria-controls="datatable"
                rowspan="1" colspan="1"
                aria-label=""
                style="display: table-cell;">创建时间
            </th>
            <th id="table-1-col-9" style="display: table-cell;">编辑</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${pagingList}" var="plate" varStatus="s">
            <c:if test="${s.count}%2 == 1">
                <tr role="row" class="odd">
            </c:if>
            <c:if test="${s.count}%2 == 0">
                <tr role="row" class="even">
            </c:if>
            <td data-priority="" colspan="1" data-columns="table-1-col-0" style="display: table-cell;">${s.count}</td>
            <td data-priority="1" colspan="1" data-columns="table-1-col-1" style="display: table-cell;">
                <img src="data:image/png;base64,${plate.plateImage}" class="rounded-circle" width="30px" height="30px">
            </td>
            <td data-priority="1" colspan="1" data-columns="table-1-col-2" class="sorting_1"
                style="display: table-cell;">${plate.plate}</td>
            <td data-priority="1" colspan="1" data-columns="table-1-col-3"
                style="display: table-cell;">${plate.creator}</td>
            <td data-priority="1" colspan="1" data-columns="table-1-col-4" style="display: none;">
                <small>${plate.vipType}</small></td>
            <td data-priority="1" colspan="1" data-columns="table-1-col-5"
                style="display: table-cell;">${plate.status}</td>
            <td data-priority="1" colspan="1" data-columns="table-1-col-6"
                style="display: none;">${plate.startTime}</td>
            <td data-priority="1" colspan="1" data-columns="table-1-col-7"
                style="display: none;">${plate.endTime}</td>
            <td data-priority="1" colspan="1" data-columns="table-1-col-5"
                style="display: none;">${plate.gmtCreate}</td>
            <td data-priority="" colspan="1" data-columns="table-1-col-9" style="display: table-cell;">
                <a class="btn btn-outline-warning" role="button"
                   href="${pageContext.request.contextPath}/findUserServlet?id=${user.id}">禁止</a>
                <a class="btn btn-outline-danger" role="button" href="javascript:deleteOne(${plate.id});">删除</a>
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
<script src="<%=path%>/plugins/datatables/js/jquery.dataTables.min.js"></script>
<script src="<%=path%>/plugins/datatables/js/dataTables.bootstrap4.min.js"></script>
<%--<script src="<%=path%>/plugins/datatables/js/dataTables.uikit.min.js"></script>--%>
<script src="<%=path%>/plugins/responsive-table/js/rwd-table.min.js"></script>

<script type="text/javascript">
/*    $(function () {
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
    });*/

    // $('.table-responsive').responsiveTable('update');

    $(document).ready(function () {
        $('#table-1').DataTable({
                // 选项持久化
                stateSave: true,
                "ordering": false,
                "language":
                    {
                        "processing": "处理中...",
                        "loadingRecords": "载入中...",
                        "lengthMenu": "显示 _MENU_ 项结果",
                        "zeroRecords": "没有符合的结果",
                        "info": "显示第 _START_ 至 _END_ 项结果，共 _TOTAL_ 项",
                        "infoEmpty": "显示第 0 至 0 项结果，共 0 项",
                        "infoFiltered": "(从 _MAX_ 项结果中过滤)",
                        "infoPostFix": "",
                        "search": "搜索:",
                        "paginate": {
                            "first": "第一页",
                            "previous": "上一页",
                            "next": "下一页",
                            "last": "最后一页"
                        },
                        "aria": {
                            "sortAscending": ": 升序排列",
                            "sortDescending": ": 降序排列"
                        }
                    }
            }
        );
    });

    $(document).ready(function () {
        <%-- 划过图片<img>放大效果 --%>
        $('img').hover(function () {
            $(this).addClass('hover')
        }, function () {
            $(this).removeClass('hover')
        });
    });

    // 删除单个车牌
    function deleteOne(id) {
        // 给出安全操作提示
        if (confirm("您确定要删除吗？")) {
            window.location.href = "${pageContext.request.contextPath}/lpr/deletePlateById?plateID=" + id;
        }
    }
</script>

</body>

</html>
