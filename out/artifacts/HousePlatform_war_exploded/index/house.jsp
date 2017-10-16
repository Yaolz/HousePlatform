<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 娃娃鱼
  Date: 2017/9/15
  Time: 15:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
    <title>户型大全</title>
    <link rel="stylesheet" href="<%=path %>/public/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=path %>/index/css/buildings.css">
    <link rel="stylesheet" href="<%=path %>/jquery-pretty-radio-checkbox/css/jquery-labelauty.css">
    <link rel="stylesheet" href="<%=path %>/public/frontPage/images/BackTopStyle.css">
    <script src="<%=path%>/public/angular/angular.min.js"></script>
</head>
<style>
    a:hover {
        text-decoration: none;
    }

    ul {
        list-style-type: none;
    }

    li {
        display: inline-block;
    }

    li {
        margin: 10px 0;
    }

    input.labelauty + label {
        font: 12px "Microsoft Yahei";
    }
</style>
<body ng-app="myApp" ng-controller="myCtrl">
<%@include file="../main/toubu.jsp" %>
<div class="container">
    <div class="row">
        <div class="col-lg-6 col-lg-offset-6 col-sm-12 col-sm-offset-0 col-md-8 col-md-offset-4">
            <div class="input-group">
                <input type="text" id="like" class="form-control" placeholder="查找户型...">
                <span class="input-group-btn">
                    <button class="btn btn-default" type="button" ng-click="like()">搜索</button>
                  </span>
            </div>
            <div class="input-group">
                <button type="button" style="color: #dc000b" id="none" ng-click="none()" class="close hidden">
                    取消&times;
                </button>
            </div>
        </div>
    </div>
    <div class="find_kuang top">
        <div class="row top_xuxian">
            <div class="col-xs-2">
                <h3 class="text-center">户型价格</h3>
            </div>
            <div class="col-xs-10">
                <ul class="dowebok">
                    <li><input class="radio" type="radio" name="prices" checked="checked" value="0"
                               data-labelauty="不限"></li>
                    <li><input class="radio" type="radio" name="prices" value="1000,10000"
                               data-labelauty="1000-10000"></li>
                    <li><input class="radio" type="radio" name="prices" value="10000,15000"
                               data-labelauty="10000-15000"></li>
                    <li><input class="radio" type="radio" name="prices" value="15000,20000"
                               data-labelauty="15000-20000"></li>
                    <li><input class="radio" type="radio" name="prices" value="20000,30000"
                               data-labelauty="20000-30000"></li>
                    <li><input class="radio" type="radio" name="prices" value="30000" data-labelauty="30000以上"></li>
                </ul>
            </div>
        </div>
        <div class="row top_xuxian">
            <div class="col-xs-2">
                <h3 class="text-center">户型面积</h3>
            </div>
            <div class="col-xs-10">
                <ul class="dowebok">
                    <li><input class="radio" type="radio" name="areas" checked="checked" value="0" data-labelauty="不限">
                    </li>
                    <li><input class="radio" type="radio" name="areas" value="30,80" data-labelauty="30-80"></li>
                    <li><input class="radio" type="radio" name="areas" value="80,150" data-labelauty="80-150"></li>
                    <li><input class="radio" type="radio" name="areas" value="150,300" data-labelauty="150-300"></li>
                    <li><input class="radio" type="radio" name="areas" value="300" data-labelauty="300以上"></li>
                </ul>
            </div>
        </div>
    </div>

    <div class="row top">
        <!--  这里放楼盘信息 -->
        <div class="col-md-9" style="border: solid 1px #c8c8c8">
            <div class="row top" style="border-bottom: 1px #CCC dotted;padding-bottom: 20px;" ng-repeat="h in house">
                <div class="col-sm-6">
                    <img src="<%=path %>/{{h.logo}}" class="img-responsive" width="400px;" height="240px">
                </div>
                <div class="col-sm-3">
                    <div>
                        <h1>
                            <a href="<%=path %>/house/indexHouseDetail?house.id={{h.id}}">{{h.name}}</a>
                        </h1>
                        <span ng-show="{{h.status==1}}" style="color: red">可售</span>
                        <span ng-show="{{h.status==0}}" style="color: red">已下架</span>
                    </div>
                    <p><a href="<%=path %>/history/addHistory?buildingsId={{b.id}}&userId={{user.id}}">{{h.buildingsPrice.name}}楼盘</a>
                    </p>
                    <div>
                        <address>
                            建筑面积：{{h.area}}㎡<br>
                            <p title="Phone">简介:{{h.intro}}</p>
                        </address>
                    </div>
                </div>
                <div class="col-sm-3">
                    <h1 style="color: red">{{h.unit_price}}元</h1>
                </div>
            </div>
        </div>
        <!--  放其他东西 -->
        <div class="col-md-3">
            <div style="border: solid 1px #c8c8c8; margin-bottom: 20px;">
                <div><h4>&nbsp;最受关注楼盘</h4></div>
                <div ng-repeat="b in buildings | limitTo : 10" class="text-center">
                    {{b.area}}&nbsp;&nbsp;
                    <a target="_blank" href="<%=path %>/history/addHistory?buildingsId={{b.id}}&userId={{user.id}}">{{b.name}}</a>&nbsp;&nbsp;
                    <span style="color:red;">{{b.avg_price}}元/㎡</span>
                </div>
            </div>
            <div id="img1">
                <a target="_blank" href="{{ads[0].ad_url}}">
                    <img src="<%=path %>/{{ads[0].logo}}" title="{{ads[0].title}}" class="img-responsive" width="100%" height="auto">
                </a>
            </div>
            <div class="hidden" id="img2">
                <a target="_blank"
                   href="http://mail.qq.com/cgi-bin/qm_share?t=qm_mailme&email=shoulouwang@qq.com">
                    <img src="<%=path %>/images/timg.jpg" title="点击投放广告" class="img-responsive" width="100%" height="auto">
                </a>
            </div>
        </div>

        <div class="row" ng-show="house != ''">
            <div class="col-sm-4">
                共 {{total}} 个户型，共{{totalPageSize}}页
            </div>
            <div class="col-sm-4 ">
                <nav aria-label="Page navigation" class="pull-right">
                    <ul class="pagination">
                        <li ng-click="top()"><a href="#top">«</a></li>
                        <li><a href="#top" class="page" ng-show="count1>=5 " ng-click="page(count1-4)">{{count1-4}}</a>
                        </li>
                        <li><a href="#top" class="page" ng-show="count1>=4 " ng-click="page(count1-3)">{{count1-3}}</a>
                        </li>
                        <li><a href="#top" class="page" ng-show="count1>=3 " ng-click="page(count1-2)">{{count1-2}}</a>
                        </li>
                        <li><a href="#top" class="page" ng-show="count1>=2 " ng-click="page(count1-1)">{{count1-1}}</a>
                        </li>
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
    <div id="elevator_item">
        <a id="elevator" onclick="return false;" title="回到顶部"></a>

        <a class="qr"></a>
        <div class="qr-popup">
            <a class="code-link"><img class="code" src="<%=path%>/public/frontPage/images/wx.jpg"/></a>
            <span>微信公众号</span>
            <div class="arr"></div>
        </div>

        <a class="sl" target="_blank"
           href="http://mail.qq.com/cgi-bin/qm_share?t=qm_mailme&email=shoulouwang@qq.com"></a>
    </div>

    <script src="<%=path %>/public/js/jquery.min.js"></script>
    <script src="<%=path %>/public/js/bootstrap.min.js"></script>
    <script src="<%=path %>/layer-v3.1.0/layer/layer.js"></script>
    <script src="<%=path%>/jquery-pretty-radio-checkbox/js/jquery-labelauty.js" type="text/javascript"></script>
    <script src="<%=path%>/index/js/index.js"></script>
    <script type="text/javascript">
        $(function () {
            $(":input[class='radio']").labelauty();
        });

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
//广告
                $http({
                    method: 'POST',
                    url: "<%=path%>/ads/adsShow",
                    data: {"beginNum": 10, "endNum": 10}
                }).then(function successCallback(response) {
                    $scope.ads = response.data.adsList;
                    if($scope.ads[0] ==null|| $scope.ads[0] =='' || $scope.ads[0] == undefined){
                        $("#noads").removeClass("hidden");
                        $("#ads").addClass("hidden");
                    }
                    if($scope.ads[0] ==null|| $scope.ads[0] =='' || $scope.ads[0] == undefined){
                        $("#img2").removeClass("hidden");
                        $("#img1").addClass("hidden");
                    }
                }, function errorCallback(response) {

                });

                $http({
                    method: 'POST',
                    url: $("#path").val() + "/user/queryUser"
                }).then(function successCallback(response) {
                    $scope.user = response.data.user;
                }, function errorCallback(response) {
                });
                $scope.total = 0;
                $scope.totalPageSize = 0;
                $scope.house = "";
                $scope.count1 = 1;
                $scope.likes = "";
                extracted($scope.count1);

                function extracted(x) {
                    $http({
                        method: 'POST',
                        url: "<%=path%>/house/indexHouse",
                        data: {
                            "pageNo": x,
                            "like": $scope.likes,
                            "areas": $("input[name='areas']:checked").val(),
                            "prices": $("input[name='prices']:checked").val()
                        }
                    }).then(function successCallback(response) {
                        $scope.total = response.data.pager.total;
                        $scope.totalPageSize = response.data.pager.totalPageSize;
                        $scope.house = response.data.pager.result;
                        $scope.count1 = response.data.pager.pageNo;
                    }, function errorCallback(response) {

                    });
                }

                $http({
                    method: 'POST',
                    url: "<%=path%>/buildings/indexBuildings",
                    data: {
                        "like": "", "area": "赣州市",
                        "avg_price": "0", "house_type": " "
                    }
                }).then(function successCallback(response) {
                    $scope.buildings = response.data.pager.result;
                }, function errorCallback(response) {
                });

                $(".radio").click(function () {
                    extracted(1);
                });

                $scope.like = function () {//点击搜索时
                    $scope.likes = $("#like").val();
                    $("#none").removeClass("hidden");
                    $("#none").html("'" + $scope.likes + "'&times;");
                    extracted(1);
                };

                $scope.none = function () {
                    $scope.likes = '';
                    $("#start_time").addClass("hidden");
                    $("#none").text("");
                    $("#like").val("");
                    extracted(1);
                };

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

</body>
</html>
