<%--
  Created by IntelliJ IDEA.
  User: 娃娃鱼
  Date: 2017/9/15
  Time: 16:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
    <title>所有活动</title>
    <link rel="icon" href="<%=path %>/public/img/favicon.png" type="image/x-icon"/>
    <link rel="stylesheet" href="<%=path %>/public/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=path %>/index/css/buildings.css">
    <link rel="stylesheet" href="<%=path %>/index/css/activity.css"/>
    <link rel="stylesheet" href="<%=path %>/public/frontPage/images/BackTopStyle.css">
    <script src="<%=path%>/public/angular/angular.min.js"></script>
</head>
<style>
    a:hover{
        text-decoration: none;
    }
</style>
<body ng-app="myApp" ng-controller="myCtrl">
<%@include file="../main/toubu.jsp" %>
<div >
    <div class="container">
        <div>
            <div class="row">
            </div>
            <div id="ads">
                <div class="ads_top" style="height: 120px; width: auto" ng-repeat="a in ads">
                    <a target="_blank" href="{{a.ad_url}}">
                        <img class="img-responsive" width=100% height=100% src="<%=path %>/{{a.logo}}" alt="{{a.title}}"
                             title="{{a.title}}" />
                    </a>
                </div>
            </div>
            <div class="hidden" id="noads">
                <a target="_blank"
                   href="http://mail.qq.com/cgi-bin/qm_share?t=qm_mailme&email=shoulouwang@qq.com">
                    <img class="img-responsive" src="<%=path %>/images/timg1.jpg" title="点击投放广告" width="100%" height="auto">
                </a>
            </div>
        </div>

        <div class="top" style="margin-top: 20px;">
            <div class="row ads_top" ng-repeat="a in activitys">
                <div class="col-md-4">
                    <img ng-show="{{a.logo != null }}" src="<%=path %>/{{a.logo}}" class="img-responsive" width="360px" height="202px">
                    <img ng-show="{{a.logo == null }}" src="<%=path %>/public/admin/timg.gif" class="img-responsive" width="360px" height="202px">
                </div>
                <div class="col-md-8">
                    <h3>
                        <a href="<%=path %>/activity/activityDetail?activity.id={{a.id}}">{{a.title}}</a>
                    </h3>
                    <p ng-show="{{a.agencyPrice.name == null }}">售楼网</p>
                    <p ng-show="{{a.agencyPrice.name != null }}">{{a.agencyPrice.name}}</p>
                    <div class="xianzhi">
                        {{a.content}}
                    </div>
                    <p class="text-right">开始时间： {{a.start_time | date:'yyyy-MM-dd HH:mm'}}&nbsp;&nbsp;&nbsp;结束时间：{{a.end_time
                        | date:'yyyy-MM-dd HH:mm'}}</p>
                </div>
            </div>
        </div>

        <div class="row" ng-show="activitys != ''">
            <div class="col-sm-4">
                共 {{total}} 个活动，共{{totalPageSize}}页
            </div>
            <div class="col-sm-4 ">
                <nav aria-label="Page navigation" class="pull-right">
                    <ul class="pagination">
                        <li ng-click="top()"><a href="#top">«</a></li>
                        <li><a href="#top" class="page" ng-show="count1>=5 " ng-click="page(count1-4)">{{count1-4}}</a></li>
                        <li><a href="#top" class="page" ng-show="count1>=4 " ng-click="page(count1-3)">{{count1-3}}</a></li>
                        <li><a href="#top" class="page" ng-show="count1>=3 " ng-click="page(count1-2)">{{count1-2}}</a></li>
                        <li><a href="#top" class="page" ng-show="count1>=2 " ng-click="page(count1-1)">{{count1-1}}</a></li>
                        <li class="active"><a href="#top" class="page" ng-show="count1>0" ng-click="page(count1)"
                                              title="{{count1}}">{{count1}}</a></li>
                        <li><a href="#top" class="page" ng-show="count1>0 && totalPageSize-1>= count1"
                               ng-click="page(count1+1)">{{count1+1}}</a></li>
                        <li><a href="#top" class="page" ng-show="count1>0 && (totalPageSize-2) >= count1"
                               ng-click="page(count1+2)">{{count1+2}}</a></li>
                        <li><a href="#top" class="page" ng-show="count1<3 && (totalPageSize-3) >= count1"
                               ng-click="page(count1+3)">{{count1+3}}</a></li>
                        <li><a href="#top" class="page" ng-show="count1<2 && (totalPageSize-4) >= count1"
                               ng-click="page(count1+4)">{{count1+4}}</a></li>
                        <li ng-click="down()"><a href="#top">»</a></li>
                    </ul>
                </nav>
            </div>
            <div class="col-sm-4">
            </div>
        </div>

    </div>
</div>
<%@include file="../main/banquan.jsp" %>
</body>
<div id="elevator_item">
    <a id="elevator" onclick="return false;" title="回到顶部"></a>

    <a class="qr"></a>
    <div class="qr-popup">
        <a class="code-link"><img class="code img-responsive" src="<%=path%>/public/frontPage/images/wx.jpg"/></a>
        <span>微信公众号</span>
        <div class="arr"></div>
    </div>

    <a class="sl" target="_blank" href="http://mail.qq.com/cgi-bin/qm_share?t=qm_mailme&email=shoulouwang@qq.com"></a>
</div>

<script src="<%=path %>/public/js/jquery.min.js"></script>
<script src="<%=path %>/public/js/bootstrap.min.js"></script>
<script src="<%=path %>/layer-v3.1.0/layer/layer.js"></script>
<script src="<%=path%>/index/js/top.js"></script>
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
                url: $("#path").val()+"/user/queryUser"
            }).then(function successCallback(response) {
                $scope.user = response.data.user;
            }, function errorCallback(response) {
            });
            $http({
                method: 'POST',
                url: "<%=path%>/ads/adsShow",
                data: {"beginNum": 14, "endNum": 17}
            }).then(function successCallback(response) {
                $scope.ads = response.data.adsList;
                if($scope.ads ==null|| $scope.ads =='' || $scope.ads == undefined){
                    $("#noads").removeClass("hidden");
                    $("#ads").addClass("hidden");
                }
            }, function errorCallback(response) {

            });

            $scope.total = 0;
            $scope.totalPageSize = 0;
            $scope.activitys = "";
            $scope.count1 = 1;
            extracted($scope.count1);

            function extracted(x) {
                $http({
                    method: 'POST',
                    url: "<%=path%>/activity/activityInfo",
                    data: {"pageNo": x}
                }).then(function successCallback(response) {
                    $scope.total = response.data.pager.total;
                    $scope.totalPageSize = response.data.pager.totalPageSize;
                    $scope.activitys = response.data.pager.result;
                    $scope.count1 = response.data.pager.pageNo;
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

        });
    }(jQuery));
</script>

</html>
