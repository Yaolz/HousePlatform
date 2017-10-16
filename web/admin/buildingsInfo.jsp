<%--
  Created by IntelliJ IDEA.
  User: yao
  Date: 2017/8/28
  Time: 16:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%><!DOCTYPE html>
<html>
<head>
    <title>Title</title>
</head>
<link href="<%=path%>/public/css/bootstrap.min.css" rel="stylesheet">
<link href="<%=path %>/public/admin/css/bootstrap-table.css"/>
<link href="<%=path%>/public/css/style.min.css" rel="stylesheet">
<link href="<%=path%>/public/admin/css/admincheck.css" rel="stylesheet">
<body>
<div class="panel-body" style="padding-top:30px;">
    <div class="row">
        <div class="col-xs-4">
            <button class="btn btn-primary" style="margin-left: 5px;">
                楼盘详情
            </button>
        </div>
        <div class="col-xs-6"></div>
        <div class="col-xs-2">
            <button class="btn btn-primary" onclick="window.location.reload(true);" style="margin-left: 50%">刷新</button>
        </div>
    </div>
    <table id="tb_buildings" class="table">
        <thead>
        <tr>
            <th data-checkbox="true"></th>
            <th data-field="name">楼盘名称</th>
            <th data-field="agencyPrice.name">所属经销商</th>
            <th data-field="area">区域</th>
            <th data-field="tel">售楼电话</th>
            <th data-field="building_area">建筑面积</th>
            <th data-field="avg_price">楼盘均价</th>
            <th data-field="reception_address">接待地址</th>
            <th data-field="open_date" data-formatter="operateTMSRPFormatter" data-sortable="true">开盘时间</th>
            <th data-field="total_rooms">总套数</th>
        </tr>
        </thead>
    </table>
</div>
<form id="editForm" target="_blank">
    <input type="hidden" name="buildings.id" id="checkId"/>
    <iniput type="hidden" name="agency.id" id="agency"/>
</form>
</body>
<script src="<%=path%>/public/js/jquery.min.js"></script>
<script src="<%=path%>/public/js/bootstrap.min.js"></script>
<script src="<%=path %>/public/admin/js/bootstrap-table.js"></script>
<script src="<%=path %>/public/admin/js/bootstrap-table-zh-CN.js"></script>
<script src="<%=path %>/layer-v3.1.0/layer/layer.js"></script>
<script>
    (function (document, window, $) {
        (function () {
            $('#tb_buildings').bootstrapTable({
                url: "/buildings/admBuildingsAll",//匹配后台
                dataType: "json",//后台返回的数据
                method: 'post',//post提交
                dataField: 'rows',
                contentType: "application/x-www-form-urlencoded",
                sidePagination: "server", //服务端请求
                striped: true,//	设置为 true 会有隔行变色效果
                pagination: true,//是否显示 数据条数选择框
                pageNumber: 1,//初始页码
                pageSize: 5,
                pageList: [5, 10, 15, 20], //可供选择的每页的行数（*）
                queryParamsType: "undefined",
                undefined: "id",
                toolbar: '#toolbar',  // 显示工具
                clickToSelect: true, // 启用选中行
            });
        })();
    })(document, window, jQuery);

    function operateTMSRPFormatter(value, rows, index) {//格式化时间
        var html = ('<span>' + rows.open_date.substr(0, 10) + '</span>');
        return html;
    }


    $("#btn_build").click(function () {
        var select = $("#tb_buildings").bootstrapTable('getSelections');
        if (select.length == 1) {
            var id = select[0].id;
            $('#checkId').val(id);
            $("#editForm").prop("action", "<%=path %>/buildings/admBuildingsDet").submit();
        } else {
            layer.msg("请选择一行");
            $("#tb_buildings").bootstrapTable("refresh");
        }
    });

    $("#btn_agency").click(function () {
        var select = $("#tb_buildings").bootstrapTable('getSelections');
        if (select.length == 1) {
            var id = select.agency.id;
            $('#agency').val(id);
            $("#editForm").prop("action", "<%=path %>/agency/agencyDetail").submit();
        } else {
            layer.msg("请选择一行");
            $("#tb_buildings").bootstrapTable("refresh");
        }
    });

</script>
</html>
