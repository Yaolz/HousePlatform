<%--
  Created by IntelliJ IDEA.
  User: yao
  Date: 2017/9/16
  Time: 10:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
    <title>历史价格</title>
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <link href="<%=path%>/public/css/bootstrap.min.css" rel="stylesheet">
    <script src="<%=path%>/public/angular/angular.min.js"></script>
</head>
<body ng-app="myApp" ng-controller="myCtrl">
<%@include file="../../main/toubu.jsp" %>
<div class="container">
    <div class="row">
        <div class="col-xs-1">
        </div>
        <div class="col-xs-10">
            <div>
                <img src="<%=path %>/public/admin/buildings1.jpg" style="width:975px; height: 280px;margin-top: 20px;">
                <div class="carousel-caption" style="margin-bottom: 200px;">
                    <a href="#">广告1</a>
                </div>
            </div>
            <ul class="nav nav-tabs" style="margin-top:20px;">
                <li role="presentation">
                    <a href="<%=path %>/buildings/indexBuildingsDetailPage?buildingsId=${buildings.id}">楼盘首页</a>
                </li>
                <li role="presentation">
                    <a href="<%=path %>/buildings/navBuildingsPage?buildingsId=${buildings.id}">楼盘详情</a>
                </li>
                <li role="presentation">
                    <a href="<%=path %>/activity/navActivityPage?buildingsId=${buildings.id}">楼盘活动</a>
                </li>
                <li role="presentation" class="active">
                    <a href="<%=path %>/buildings/avgPricePage?buildingsId=${buildings.id}">历史价格</a>
                </li>
                <li role="presentation">
                    <a href="<%=path %>/house/navHousePage?buildingsId=${buildings.id}">户型图</a>
                </li>
                <li role="presentation">
                    <a href="<%=path %>/comment/buildingsCommentPage?buildingsId=${buildings.id}">楼盘点评</a>
                </li>
                <li role="presentation">
                    <a href="<%=path %>/employee/navEmployeePage?buildingsId=${buildings.id}">销售员</a>
                </li>
                <li role="presentation">
                    <a href="<%=path %>/room/navRoomPage?buildingsId=${buildings.id}">在线看房</a>
                </li>
                <li role="presentation">
                    <a id="message" href="/message/navMessagePage?buildingsId=${buildings.id}">留言</a>
                </li>
            </ul>
        </div>
        <div class="col-xs-1">
        </div>
    </div>

    <div class="row" style="margin-top: 20px;">
        <div class="col-xs-1">
        </div>
        <div class="col-xs-10" style="border: 1px solid #d7d4f0;">
            <div id="line"></div>
        </div>
    </div>
</div>
<%@include file="../../main/banquan.jsp" %>

<script src="<%=path %>/public/js/jquery.min.js"></script>
<script src="<%=path%>/public/angular/angular.min.js"></script>
<script src="<%=path %>/layer-v3.1.0/layer/layer.js"></script>
<script src="https://img.hcharts.cn/highcharts/highcharts.js"></script>
<script src="https://img.hcharts.cn/highcharts/modules/exporting.js"></script>
<script src="https://img.hcharts.cn/highcharts-plugins/highcharts-zh_CN.js"></script>
<script src="<%=path%>/index/js/index.js"></script>
<script src="<%=path%>/index/js/index-login1.js"></script>
<script>

    $(function () {
        //格式化时间
        function date1(dates) {
            var str = dates;
            var strA = str.split(/[a-zA-Z]/);
            var d = {}

            d.year = strA[0].split('-')[0];
            d.month = strA[0].split('-')[1];
            d.day = strA[0].split('-')[2];
            d.hour = strA[1].split(':')[0];
            d.minute = strA[1].split(':')[1];
            d.second = strA[1].split(':')[2];
            d.weekday = str.match(/[a-zA-Z]/)[0];
            return d.year + "-" + d.month + "-" + d.day + " " + d.hour + ":" + d.minute;
        }

        var datas = [];
        var time = [];
        $.post("<%=path %>/buildings/avgPrice?buildingsId=${buildings.id }",
            function (data) {
                for (var i = 0, len = data.avgprices.length; i < len; i++) {
                    time.push(date1(data.avgprices[i].recording_time));
                    datas.push(data.avgprices[i].avg_price);
                }
                empStatics("line", datas, time);
            }, "json"
        );
    });

    function empStatics(id, datas, time) {
        new Highcharts.Chart(id, {
            // 图表的标题
            title: {
                text: '楼盘历史价格',
                x: -20
            },
            // 子标题
            subtitle: {
                text: '数据来源: 售楼网',
                x: -20
            },
            xAxis: {
                categories: time
            },
            yAxis: {
                title: {
                    text: '万元'
                },
                plotLines: [{
                    value: 0,
                    width: 1,
                    color: '#808080'
                }]
            },
            // 图例
            legend: {
                layout: 'vertical',
                align: 'right',
                verticalAlign: 'middle',
                borderWidth: 0
            },
            // 数据
            series: [{
                name: "历史价格",
                data: datas
            }]
        });
    }

</script>
</body>
</html>
