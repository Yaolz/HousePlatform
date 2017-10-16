<%--
  Created by IntelliJ IDEA.
  User: yao
  Date: 2017/9/16
  Time: 8:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<%
    String path = request.getContextPath();
%>
<head>
    <title>户型图</title>
</head>
<link href="<%=path%>/public/css/bootstrap.min.css" rel="stylesheet">
<script src="<%=path%>/public/angular/angular.min.js"></script>
<link rel="stylesheet" href="<%=path%>/public/xiangcecss/css/baguetteBox.min.css">
<body ng-app="myApp" ng-controller="myCtrl">
<%@include file="../../main/toubu.jsp" %>
<div class="container">
    <div class="row">
        <div class="col-xs-1">
        </div>
        <div class="col-xs-10">
            <div id="ads">
                <a target="_blank" href="{{ads[0].ad_url}}">
                    <img src="<%=path %>/{{ads[0].logo}}" title="{{ads[0].title}}" width="100%" height="280px;">
                </a>
            </div>
            <div class="hidden" id="noads">
                <a target="_blank"
                   href="http://mail.qq.com/cgi-bin/qm_share?t=qm_mailme&email=shoulouwang@qq.com">
                    <img src="<%=path %>/images/timg1.jpg" title="点击投放广告" class="img-responsive" width="100%" height="280px;">
                </a>
            </div>
        </div>
        <div class="col-xs-1">
        </div>
    </div>

    <div class="row">
        <div class="col-xs-1">
        </div>
        <div class="col-xs-10">
            <ul class="nav nav-tabs" style="margin-top:20px;">
                <li role="presentation">
                    <a id="indexPage" href="#">楼盘首页</a>
                </li>
                <li role="presentation">
                    <a id="builDetail" href="">楼盘详情</a>
                </li>
                <li role="presentation">
                    <a id="builActivity" href="">楼盘活动</a>
                </li>
                <li role="presentation">
                    <a id="hisPrice" href="">历史价格</a>
                </li>
                <li role="presentation" class="active">
                    <a id="building" href="">户型图</a>
                </li>
                <li role="presentation">
                    <a id="comment" href="">楼盘点评</a>
                </li>
                <li role="presentation">
                    <a id="employee" href="">销售员</a>
                </li>
                <li role="presentation">
                    <a id="room" href="">在线看房</a>
                </li>
                <li role="presentation">
                    <a id="message" href="">留言</a>
                </li>
            </ul>
        </div>
        <div class="col-xs-1">
        </div>
    </div>

    <div class="row" style="margin-top: 30px;">
        <div class="col-xs-1">
        </div>
        <div class="col-xs-10 tz-gallery">
            <div class="col-xs-4" ng-repeat="h in house  | limitTo: 6" style="margin-top: 30px;">
                <a href="<%=path%>/{{h.logo}}" alt="<%=path%>/{{h.logo}}">
                    <img src="<%=path %>/{{h.logo}}" class="img-responsive" style="width:280px; height:300px;"/>
                </a>
                <p><a target="_blank" href="<%=path %>/house/indexHouseDetail?house.id={{h.id}}">{{h.name}}</a></p>
                <p>简介:{{h.intro}}</p>
            </div>
        </div>
        <div class="col-xs-1">
        </div>
    </div>

    <div class="row">
        <div class="col-sm-3">
        </div>
        <div class="col-sm-4">
            <nav aria-label="Page navigation" class="pull-right">
                <ul class="pagination">
                    <li ng-click="top()"><a>«</a></li>
                    <li><a class="page" ng-show="count1>=5 " ng-click="page(count1-4)">{{count1-4}}</a></li>
                    <li><a class="page" ng-show="count1>=4 " ng-click="page(count1-3)">{{count1-3}}</a></li>
                    <li><a class="page" ng-show="count1>=3 " ng-click="page(count1-2)">{{count1-2}}</a></li>
                    <li><a class="page" ng-show="count1>=2 " ng-click="page(count1-1)">{{count1-1}}</a></li>
                    <li class="active"><a class="page" ng-show="count1>0" ng-click="page(count1)" title="{{count1}}">{{count1}}</a>
                    </li>
                    <li><a class="page" ng-show="count1>0 && totalPageSize-1>= count1"
                           ng-click="page(count1+1)">{{count1+1}}</a></li>
                    <li><a class="page" ng-show="count1>0 && (totalPageSize-2) >= count1"
                           ng-click="page(count1+2)">{{count1+2}}</a></li>
                    <li><a class="page" ng-show="count1<3 && (totalPageSize-3) >= count1"
                           ng-click="page(count1+3)">{{count1+3}}</a></li>
                    <li><a class="page" ng-show="count1<2 && (totalPageSize-4) >= count1"
                           ng-click="page(count1+4)">{{count1+4}}</a></li>
                    <li ng-click="down()"><a>»</a></li>
                </ul>
            </nav>
        </div>
        <div class="col-sm-5">
        </div>
    </div>

</div>
<%@include file="../../main/banquan.jsp" %>
</body>
<script src="<%=path%>/public/js/jquery.min.js"></script>
<script src="<%=path%>/public/js/bootstrap.min.js"></script>
<script src="<%=path %>/layer-v3.1.0/layer/layer.js"></script>
<script type="text/javascript" id="my" src="<%=path%>/public/xiangcecss/js/baguetteBox.min.js"></script>
<script src="<%=path%>/index/js/index.js"></script>
<script type="text/javascript">
    (function ($) {
        var app = angular.module('myApp', []);
        app.config(function ($httpProvider) {

            $httpProvider.defaults.transformRequest = function (obj) {
                var str = [];
                for (var p in obj) {
                    str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                }
                return str.join("&");
            };

            $httpProvider.defaults.headers.post = {
                'Content-Type': 'application/x-www-form-urlencoded'
            }

        });
        app.controller('myCtrl', function ($scope, $http, $timeout) {
            $http({
                method: 'POST',
                url: $("#path").val() + "/user/queryUser"
            }).then(function successCallback(response) {
                $scope.user = response.data.user;
            }, function errorCallback(response) {
            });
            // 显示广告
            $http({
                method: 'POST',
                url: "<%=path%>/ads/adsShow",
                data: {"beginNum": 22, "endNum": 22}
            }).then(function successCallback(response) {
                $scope.ads = response.data.adsList;
                if($scope.ads[0] ==null|| $scope.ads[0] =='' || $scope.ads[0] == undefined){
                    $("#noads").removeClass("hidden");
                    $("#ads").addClass("hidden");
                }
            }, function errorCallback(response) {
            });

            function GetQueryString(name) {//获取url上的值
                var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
                var r = window.location.search.substr(1).match(reg);
                if (r != null) {
                    return unescape(r[2]);
                }
                return null;
            }

            var buildingsId = GetQueryString("buildingsId");
            $scope.total = 0;
            $scope.totalPageSize = 0;
            $scope.count1 = 1;
            $scope.likes = '';
            extracted($scope.count1);

            function extracted(x) {
                $http({
                    method: 'POST',
                    url: "<%=path%>/house/navHouse?buildings_id=" + buildingsId,
                    data: {"pageNo": x}
                }).then(function successCallback(response) {
                    $scope.total = response.data.pager.total;
                    $scope.totalPageSize = response.data.pager.totalPageSize;
                    $scope.house = response.data.pager.result;
                    $scope.count1 = response.data.pager.pageNo;
                    $timeout(function(){
                        baguetteBox.run('.tz-gallery');
                    },50);
                }, function errorCallback(response) {

                });
            }

            $scope.page = function (x) {//点击页号事件
                if ($scope.count1 == x) {
                    return;
                }
                extracted(x);
            };

            $scope.down = function () {//下一页

                if ($scope.count1 == $scope.totalPageSize) {
                    return;
                }
                extracted($scope.count1 + 1);
            };
            $scope.top = function () {//上一页

                if ($scope.count1 == 1) {
                    return;
                }
                extracted($scope.count1 - 1);
            };

            // 点击导航的事件
            $("#indexPage").click(function () {
                $('#indexPage').attr('href', '<%=path %>/buildings/indexBuildingsDetailPage?buildingsId=' + buildingsId);
            });

            $("#builDetail").click(function () {
                $('#builDetail').attr('href', '<%=path %>/buildings/navBuildingsPage?buildingsId=' + buildingsId);
            });

            $("#comment").click(function () {
                $('#comment').attr('href', '<%=path %>/comment/buildingsCommentPage?buildingsId=' + buildingsId);
            });

            $("#hisPrice").click(function () {
                $('#hisPrice').attr('href', '<%=path %>/buildings/avgPricePage?buildingsId=' + buildingsId);
            });

            $("#builActivity").click(function () {
                $('#builActivity').attr('href', '<%=path %>/activity/navActivityPage?buildingsId=' + buildingsId);
            });

            $("#employee").click(function () {
                $('#employee').attr('href', '<%=path %>/employee/navEmployeePage?buildingsId=' + buildingsId);
            });

            $("#room").click(function () {
                $('#room').attr('href', '<%=path %>/room/navRoomPage?buildingsId=' + buildingsId);
            });

            $("#message").click(function () {
                $('#message').attr('href', '<%=path %>/message/navMessagePage?buildingsId=' + buildingsId);
            });

        });
    }(jQuery));
</script>
</html>
