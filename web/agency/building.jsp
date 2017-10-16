<%--
  Created by IntelliJ IDEA.
  User: CMY
  Date: 2017/8/30
  Time: 9:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%><!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>楼栋详情</title>
    <link href="<%=path%>/public/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="<%=path%>/public/xiangcecss/css/htmleaf-demo.css">
    <link rel="stylesheet" href="<%=path%>/public/xiangcecss/css/baguetteBox.min.css">
    <link rel="stylesheet" href="<%=path%>/public/xiangcecss/css/gallery-grid.css">
    <script src="<%=path%>/public/angular/angular.min.js"></script>
</head>
<body ng-app="myApp" ng-controller="myCtrl">
<div  class="container">
    <dl class="dl-horizontal">
        <dt>所属楼盘:</dt>
        <dd >{{building.buildingsPrice.name}}</dd>
        <dt>楼栋名:</dt>
        <dd >{{building.name}}</dd>
        <dt >总层数:</dt>
        <dd >{{building.total_floor}}</dd>
        <dt>电梯数:</dt>
        <dd >{{building.total_lift}}</dd>
        <dt>每层多少户:</dt>
        <dd >{{building.floor_rooms}}</dd>
        <dt>总户数:</dt>
        <dd >{{building.total_room}}</dd>
    </dl>
</div>
<div class="container gallery-container">

    <h1>楼栋户型</h1>


    <div class="tz-gallery">

        <div class="row">

            <div class="col-sm-6 col-md-4" ng-repeat="h in houses">
                <div class="thumbnail">
                    <a class="lightbox" href="<%=path%>/{{h.logo}}">
                        <img src="<%=path%>/{{h.logo}}" alt="Park">
                    </a>
                    <div class="caption">
                        <h3>{{h.name}}</h3>
                        <p>{{h.intro}}</p>
                        <p class="text-danger">{{h.area}}/㎡</p>
                        <p class="text-danger">{{h.unit_price}}元/㎡</p>
                    </div>
                </div>
            </div>
        </div>

    </div>

</div>
</body>
<script src="<%=path %>/public/js/jquery.min.js"></script>
<script src="<%=path %>/public/js/bootstrap.min.js"></script>
<script type="text/javascript" id="my" src="<%=path%>/public/xiangcecss/js/baguetteBox.min.js"></script>
<script>
    (function($){
        var app = angular.module('myApp', []);
        app.config(function($httpProvider){
            $httpProvider.defaults.transformRequest = function(obj){
                var str = [];
                for(var p in obj){
                    str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                }
                return str.join("&");
            };

            $httpProvider.defaults.headers.post = {
                'Content-Type': 'application/x-www-form-urlencoded'
            }

        });
        app.controller('myCtrl', function ($scope, $http, $timeout) {
            var buildingId = GetQueryString("buildingId");
            $http({//获取楼盘下拉框值的url
                method: 'POST',
                url: "<%=path%>/building/queryById",
                data: {"buildingId": buildingId,"status":4}
            }).then(function successCallback(response) {
                $scope.building = response.data.building;
                $scope.houses = response.data.building.houses;
                $timeout(function(){
                    baguetteBox.run('.tz-gallery');
                },100);
            }, function errorCallback(response) {

            });
            function GetQueryString(name) {//获取url上的值
                var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
                var r = window.location.search.substr(1).match(reg);
                if(r!=null){
                    return  unescape(r[2]);
                }
                return null;
            }
        });
    }(jQuery));
</script>
</html>
