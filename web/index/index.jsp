<%--
  Created by IntelliJ IDEA.
  User: ID.LQF
  Date: 2017/8/23
  Time: 8:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String path = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
    <title>首页</title>
    <link rel="icon" href="<%=path %>/public/img/favicon.png" type="image/x-icon"/>
    <link rel="stylesheet" href="<%=path %>/public/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=path %>/public/css/index.css">
    <link rel="stylesheet" href="<%=path %>/public/frontPage/images/BackTopStyle.css">
    <link rel="stylesheet" href="<%=path%>/public/css/public.css">
    <link rel="stylesheet" href="<%=path%>/public/css/style.css">
    <style>
        .carousel-control.left {
            background-image: -webkit-linear-gradient(left, rgba(0, 0, 0, .5) 0, rgba(0, 0, 0, .0001) 100%);
            background-image: -o-linear-gradient(left, rgba(0, 0, 0, .5) 0, rgba(0, 0, 0, .0001) 100%);
            background-image: -webkit-gradient(linear, left top, right top, from(rgba(0, 0, 0, .5)), to(rgba(0, 0, 0, .0001)));
            background-image: linear-gradient(to right, rgba(0, 0, 0, .5) 0, rgba(0, 0, 0, .0001) 100%);
            filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#80000000', endColorstr='#00000000', GradientType=1);
            background-repeat: repeat-x;
        }

        .carousel-control.right {
            right: 0;
            left: auto;
            background-image: -webkit-linear-gradient(left, rgba(0, 0, 0, .0001) 0, rgba(0, 0, 0, .5) 100%);
            background-image: -o-linear-gradient(left, rgba(0, 0, 0, .0001) 0, rgba(0, 0, 0, .5) 100%);
            background-image: -webkit-gradient(linear, left top, right top, from(rgba(0, 0, 0, .0001)), to(rgba(0, 0, 0, .5)));
            background-image: linear-gradient(to right, rgba(0, 0, 0, .0001) 0, rgba(0, 0, 0, .5) 100%);
            filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#00000000', endColorstr='#80000000', GradientType=1);
            background-repeat: repeat-x;
        }

        .guide-news {
            background: white;
            padding: 10px 0;
        }
    </style>
    <script src="<%=path%>/public/angular/angular.min.js"></script>
<body ng-app="myApp" ng-controller="myCtrl">
<%@include file="../main/toubu.jsp" %>
<div class="container">
    <div class="col-xs-12">
        <div id="myCarousel" class="carousel slide">
            <!-- 轮播（Carousel）指标 -->
            <ol class="carousel-indicators">
                <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                <li data-target="#myCarousel" data-slide-to="1"></li>
                <li data-target="#myCarousel" data-slide-to="2"></li>
            </ol>
            <!-- 轮播（Carousel）项目 -->
            <div class="carousel-inner ">
                <div class="item active">
                    <a target="_blank" href="<%=path %>/activity/activityDetail?activity.id={{activitys[0].id}}">
                    <img  style="width: 1200px;height: 500px;" src="<%=path %>/{{activitys[0].logo}}" title="{{activitys[0].title}}"
                         alt="">
                    </a>
                </div>
                <div class="item">
                    <a target="_blank" href="<%=path %>/activity/activityDetail?activity.id={{activitys[1].id}}">
                    <img  style="width: 1200px;height: 500px;"  src="<%=path %>/{{activitys[1].logo}}" title="{{activitys[0].title}}"
                         alt="">
                    </a>
                </div>
                <div class="item">
                    <a target="_blank" href="<%=path %>/activity/activityDetail?activity.id={{activitys[2].id}}">
                    <img  style="width: 1200px;height: 500px;"  src="<%=path %>/{{activitys[2].logo}}" title="{{activitys[0].title}}"
                         alt="">
                    </a>
                </div>
            </div>
            <!-- 轮播（Carousel）导航 -->
            <a class="carousel-control left" href="#myCarousel"
               data-slide="prev">&lsaquo;
            </a>
            <a class="carousel-control right" href="#myCarousel"
               data-slide="next">&rsaquo;
            </a>
        </div>
    </div>
    <hr>

    <div style="margin-top: 20px;" class="col-xs-12">
        <div>
            <div>
                <a href="<%=path %>/index/buildings.jsp"><h4 style="float:right;margin-top: 30px;margin-right: 50px;">
                    更多热门楼盘>>></h4></a>
                <p style="clear: both;"></p>
            </div>
            <hr>

            <div style="margin-top: 20px;">
                <div class="col-xs-4" ng-repeat="b in buildings | limitTo : 3">
                    <div>
                        <a href="<%=path %>/buildings/indexBuildingsDetailPage?buildingsId={{b.id}}"><img class="img-responsive"
                                style="width: 300px; height: 300px;" src="<%=path %>/{{b.logo}}"></a>
                    </div>
                    <div style="text-align: left">
                        <h4>楼盘地区名称:<a href="<%=path %>/index/buildings.jsp">{{b.name}}</a></h4>
                        <h5>楼盘均价：{{b.avg_price}}元/㎡</h5>
                        <h5>开盘时间：{{b.open_date}}</h5>
                    </div>
                </div>
                <p style="clear: both;"></p>
            </div>
        </div>
    </div>
    <hr>

    <!--广告和热门户型-->

    <!--广告和最新资讯-->
    <div style="margin-top: 20px; padding-top: 20px; border-top:solid 1px #dfdfdf;" class="col-xs-12">
        <div class="col-xs-4">
            <div id="ads0" style="width: 100%">
                <a target="_blank" href="{{ads[0].ad_url}}">
                    <img src="<%=path %>/{{ads[0].logo}}" title="{{ads[0].title}}"  width="90%" height="315px;">
                </a>
            </div>
            <div class="hidden" id="noads0" style="width: 100%">
                <a target="_blank"
                   href="http://mail.qq.com/cgi-bin/qm_share?t=qm_mailme&email=shoulouwang@qq.com">
                    <img src="<%=path %>/images/timg.jpg" title="点击投放广告"  width="90%" height="315px;">
                </a>
            </div>
        </div>

        <div class="col-xs-4">
            <div id="ads1" style="width: 100%">
                <a target="_blank" href="{{ads[1].ad_url}}">
                    <img src="<%=path %>/{{ads[1].logo}}" title="{{ads[1].title}}"  width="90%"
                         height="315px;">
                </a>
            </div>
            <div class="hidden" id="noads1" style="width: 100%">
                <a target="_blank"
                   href="http://mail.qq.com/cgi-bin/qm_share?t=qm_mailme&email=shoulouwang@qq.com">
                    <img src="<%=path %>/images/timg.jpg" title="点击投放广告" width="90%" height="315px">
                </a>
            </div>
        </div>
        <div class="col-xs-4">
            <div id="ads2" style="width: 100%">
                <a target="_blank" href="{{ads[2].ad_url}}">
                    <img src="<%=path %>/{{ads[2].logo}}" title="{{ads[0].title}}"  width="90%"
                         height="315px">
                </a>
            </div>
            <div class="hidden" id="noads2" style="width: 100%">
                <a target="_blank"
                   href="http://mail.qq.com/cgi-bin/qm_share?t=qm_mailme&email=shoulouwang@qq.com">
                    <img src="<%=path %>/images/timg.jpg" title="点击投放广告" width="90%" height="315px">
                </a>
            </div>
        </div>
        <p style="clear: both;"></p>
    </div>
    <hr>

    <div style="margin-top: 20px;" class="col-xs-12">
        <div>
            <a href="<%=path %>/index/house.jsp"><h4 style="float:right;margin-top: 30px;margin-right: 50px;">
                更多热门户型>>></h4></a>
            <p style="clear: both;"></p>
        </div>
        <hr>
        <div class="item col-xs-4" ng-repeat="h in house | limitTo : 3">
            <a href="<%=path %>/house/indexHouseDetail?house.id={{h.id}}" target="_blank">
                <img class="lazy img-responsive" title="{{h.name}}户型" src="<%=path %>/{{h.logo}}" width="300" height="300"
                     style="display: block;"></a>
            <div class="design-info">
                <p class="p1"><span class="name">户型</span>{{h.name}}</p>
                <p class="p2">单价：{{h.unit_price}}元/㎡</p>
                <p class="p2">面积：{{h.area}}㎡</p>
            </div>
        </div>
    </div>
    <hr>

    <!--广告和最新资讯-->
    <div style="margin-top: 20px; padding-top: 20px; border-top:solid 1px #d0d0d0;" class="col-xs-12">
        <div class="col-xs-4">
            <div id="ads3" style="width: 100%">
                <a target="_blank" href="{{ads[3].ad_url}}">
                    <img src="<%=path %>/{{ads[3].logo}}" title="{{ads[3].title}}"  width="90%" height="315px;">
                </a>
            </div>
            <div class="hidden" id="noads3" style="width: 100%">
                <a target="_blank"
                   href="http://mail.qq.com/cgi-bin/qm_share?t=qm_mailme&email=shoulouwang@qq.com">
                    <img src="<%=path %>/images/timg.jpg" title="点击投放广告"  width="90%" height="315px;">
                </a>
            </div>
        </div>

        <div class="col-xs-4">
            <div id="ads4" style="width: 100%">
                <a target="_blank" href="{{ads[4].ad_url}}">
                    <img src="<%=path %>/{{ads[4].logo}}" title="{{ads[4].title}}" width="90%"
                         height="315px;">
                </a>
            </div>
            <div class="hidden" id="noads4" style="width: 100%">
                <a target="_blank"
                   href="http://mail.qq.com/cgi-bin/qm_share?t=qm_mailme&email=shoulouwang@qq.com">
                    <img src="<%=path %>/images/timg.jpg" title="点击投放广告"  width="90%" height="315px;">
                </a>
            </div>
        </div>
        <div class="col-xs-4">
            <div id="ads5" style="width: 100%">
                <a target="_blank" href="{{ads[5].ad_url}}">
                    <img src="<%=path %>/{{ads[5].logo}}" title="{{ads[5].title}}"  width="90%"
                         height="315px;">
                </a>
            </div>
            <div class="hidden" id="noads5" style="width: 100%">
                <a target="_blank"
                   href="http://mail.qq.com/cgi-bin/qm_share?t=qm_mailme&email=shoulouwang@qq.com">
                    <img src="<%=path %>/images/timg.jpg" title="点击投放广告"  width="90%" height="315px;">
                </a>
            </div>
        </div>
        <p style="clear: both;"></p>
    </div>
    <hr>

    <div class="guide-news row">
        <div style="background: white;">
            <a href="#"><h4 style="float:right;margin-top: 30px;margin-right: 50px;">更多热点文章>>></h4></a>
            <p style="clear: both;"></p>
        </div>
        <hr>
        <div class="tabLayer clearfix">
            <div class="pic">
                <a href="#" target="_blank" class="picbox">
                    <img src="<%=path %>/{{article[0].logo}}" class="img-responsive" width="560" height="280"
                         style="display: block;">
                </a>
                <div class="info" style="width: 560px">
                    <h3 class="text-nowrap">
                        <a href="#" target="_blank">{{article[0].title}}</a>
                    </h3>
                    <p class="con">{{article[0].abstracts}}</p>
                    <span class="date">{{article[0].created_time | date:'yyyy-MM-dd hh:mm'}}</span>
                </div>
            </div>
            <div class="row">
                <ul class="list">
                    <li>
                        <span class="num">01</span>
                        <h3 class="text-nowrap strong">
                            <a href="#" target="_blank">{{article[1].title}}</a>
                        </h3>
                        <p class="con">{{article[1].abstracts}}</p>
                        <span class="date">{{article[1].created_time | date:'yyyy-MM-dd hh:mm'}}</span>
                    </li>
                </ul>
                <ul class="list">
                    <li>
                        <span class="num">02</span>
                        <h3 class="text-nowrap strong">
                            <a href="#" target="_blank">{{article[2].title}}</a>
                        </h3>
                        <p class="con">{{article[2].abstracts}}</p>
                        <span class="date">{{article[2].created_time | date:'yyyy-MM-dd hh:mm'}}</span>
                    </li>
                </ul>
                <ul class="list">
                    <li>
                        <span class="num">03</span>
                        <h3 class="text-nowrap strong">
                            <a href="#" target="_blank">{{article[3].title}}</a>
                        </h3>
                        <p class="con">{{article[3].abstracts}}</p>
                        <span class="date">{{article[3].created_time | date:'yyyy-MM-dd hh:mm'}}</span>
                    </li>
                </ul>
                <ul class="list">
                    <li>
                        <span class="num">04</span>
                        <h3 class="text-nowrap strong">
                            <a href="#" target="_blank">{{article[4].title}}</a>
                        </h3>
                        <p class="con">{{article[4].abstracts}}</p>
                        <span class="date">{{article[4].created_time | date:'yyyy-MM-dd hh:mm'}}</span>
                    </li>
                </ul>
            </div>
        </div>
    </div>
    <hr>


    <!--广告-->
    <!--广告和最新资讯-->
    <div style="margin-top: 20px;" class="col-sm-12">
        <div class="col-xs-4">
            <div id="ads6" style="width: 100%">
                <a target="_blank" href="{{ads[6].ad_url}}">
                    <img src="<%=path %>/{{ads[6].logo}}" title="{{ads[6].title}}"  width="90%" height="315px;">
                </a>
            </div>
            <div class="hidden" id="noads6" style="width: 100%">
                <a target="_blank"
                   href="http://mail.qq.com/cgi-bin/qm_share?t=qm_mailme&email=shoulouwang@qq.com">
                    <img src="<%=path %>/images/timg.jpg" title="点击投放广告"  width="90%" height="315px;">
                </a>
            </div>
        </div>

        <div class="col-xs-4">
            <div id="ads7" style="width: 100%">
                <a target="_blank" href="{{ads[7].ad_url}}">
                    <img src="<%=path %>/{{ads[7].logo}}" title="{{ads[6].title}}"  width="90%"
                         height="315px;">
                </a>
            </div>
            <div class="hidden" id="noads7" style="width: 100%">
                <a target="_blank"
                   href="http://mail.qq.com/cgi-bin/qm_share?t=qm_mailme&email=shoulouwang@qq.com">
                    <img src="<%=path %>/images/timg.jpg" title="点击投放广告"  width="90%" height="315px;">
                </a>
            </div>
        </div>
        <div class="col-xs-4">
            <div id="ads8" style="width: 100%">
                <a target="_blank" href="{{ads[8].ad_url}}">
                    <img src="<%=path %>/{{ads[8].logo}}" title="{{ads[7].title}}"   width="90%"
                         height="315px;">
                </a>
            </div>
            <div class="hidden" id="noads8" style="width: 100%">
                <a target="_blank"
                   href="http://mail.qq.com/cgi-bin/qm_share?t=qm_mailme&email=shoulouwang@qq.com">
                    <img src="<%=path %>/images/timg.jpg" title="点击投放广告"  width="90%" height="315px;">
                </a>
            </div>
        </div>
        <p style="clear: both;"></p>
    </div>
</div>
<p style="clear: both;"></p>
<hr>
<!--版权-->
<%@include file="../main/banquan.jsp" %>

<div id="elevator_item">
    <a id="elevator" onclick="return false;" title="回到顶部"></a>

    <a class="qr"></a>
    <div class="qr-popup">
        <a class="code-link"><img class="code img-responsive" src="<%=path%>/public/frontPage/images/wx.jpg"/></a>
        <span>微信公众号</span>
        <div class="arr"></div>
    </div>

    <a class="sl" target="_blank"
       href="http://mail.qq.com/cgi-bin/qm_share?t=qm_mailme&email=shoulouwang@qq.com"></a>
</div>
</body>
<script src="<%=path%>/public/js/jquery.min.js"></script>
<script src="<%=path%>/public/js/bootstrap.min.js"></script>
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
        app.controller('myCtrl', function ($scope, $http) {
            $http({
                method: 'POST',
                url: $("#path").val() + "/user/queryUser"
            }).then(function successCallback(response) {
                $scope.user = response.data.user;
            }, function errorCallback(response) {
            });
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

            $http({
                method: 'POST',
                url: "<%=path%>/house/housePage"
            }).then(function successCallback(response) {
                $scope.house = response.data.pager.result;
            }, function errorCallback(response) {

            });

            $http({
                method: 'POST',
                url: "<%=path%>/article/articlePage",
            }).then(function successCallback(response) {
                $scope.article = response.data.pager.result;
            }, function errorCallback(response) {
            });
            // 活动
            $http({
                method: 'POST',
                url: "<%=path%>/activity/activityInfo",
                data: {"pageNo": 1}
            }).then(function successCallback(response) {
                $scope.activitys = response.data.pager.result;
            }, function errorCallback(response) {
            });
            // 显示广告
            $http({
                method: 'POST',
                url: "<%=path%>/ads/adsShow",
                data: {"beginNum": 1, "endNum": 9}
            }).then(function successCallback(response) {
                $scope.ads = response.data.adsList;
                if ($scope.ads[0] == null || $scope.ads[0] == '' || $scope.ads[0] == undefined) {
                    $("#noads0").removeClass("hidden");
                    $("#ads0").addClass("hidden");
                }
                if ($scope.ads[1] == null || $scope.ads[1] == '' || $scope.ads[1] == undefined) {
                    $("#noads1").removeClass("hidden");
                    $("#ads1").addClass("hidden");
                }
                if ($scope.ads[2] == null || $scope.ads[2] == '' || $scope.ads[2] == undefined) {
                    $("#noads2").removeClass("hidden");
                    $("#ads2").addClass("hidden");
                }
                if ($scope.ads[3] == null || $scope.ads[3] == '' || $scope.ads[3] == undefined) {
                    $("#noads3").removeClass("hidden");
                    $("#ads3").addClass("hidden");
                }
                if ($scope.ads[4] == null || $scope.ads[4] == '' || $scope.ads[4] == undefined) {
                    $("#noads4").removeClass("hidden");
                    $("#ads4").addClass("hidden");
                }
                if ($scope.ads[5] == null || $scope.ads[5] == '' || $scope.ads[5] == undefined) {
                    $("#noads5").removeClass("hidden");
                    $("#ads5").addClass("hidden");
                }
                if ($scope.ads[6] == null || $scope.ads[6] == '' || $scope.ads[6] == undefined) {
                    $("#noads6").removeClass("hidden");
                    $("#ads6").addClass("hidden");
                }
                if ($scope.ads[7] == null || $scope.ads[7] == '' || $scope.ads[7] == undefined) {
                    $("#noads7").removeClass("hidden");
                    $("#ads7").addClass("hidden");
                }
                if ($scope.ads[8] == null || $scope.ads[8] == '' || $scope.ads[8] == undefined) {
                    $("#noads8").removeClass("hidden");
                    $("#ads8").addClass("hidden");
                }
            }, function errorCallback(response) {
            });


            $http({
                method: 'POST',
                url: "<%=path%>/activity/articlePage",
            }).then(function successCallback(response) {
                $scope.article = response.data.pager.result;
            }, function errorCallback(response) {

            });
        });
    }(jQuery));
</script>
</html>
