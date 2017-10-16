<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <title>楼盘首页</title>
</head>
<link href="<%=path%>/public/css/bootstrap.min.css" rel="stylesheet">
<script src="<%=path%>/public/angular/angular.min.js"></script>
<script src="<%=path %>/public/tanchuang/sweetalert-master/dist/sweetalert-dev.js"></script>
<link rel="stylesheet" href="<%=path %>/public/tanchuang/sweetalert-master/dist/sweetalert.css">
<style>
    table {
        margin: auto;
        width: 95%;
    }

    table tr {
        height: 40px;
        align: center;
    }

    table tr th {
        font-family: "微软雅黑 Light";
        font-size: 16px;
        color: #666;
        width: 100px;
    }

    table tr td {
        align: left;
    }
</style>
<body ng-app="myApp" ng-controller="myCtrl">
<%@include file="../../main/toubu.jsp" %>
<div class="container">
    <div class="row">
        <div class="col-xs-1">
        </div>
        <div class="col-xs-10">
            <div>
                <img src="<%=path %>/public/admin/buildings1.jpg" class="img-responsive" style="width:975px; height: 280px;margin-top: 20px;">
                <div class="carousel-caption" style="margin-bottom: 200px;">
                    <a href="#">广告1</a>
                </div>
            </div>
            <ul class="nav nav-tabs" style="margin-top:20px;">
                <li role="presentation" class="active">
                    <a href="<%=path %>/buildings/indexBuildingsDetailPage?buildingsId={{buildings.id}}">楼盘首页</a>
                </li>
                <li role="presentation">
                    <a href="<%=path %>/buildings/navBuildingsPage?buildingsId={{buildings.id}}">楼盘详情</a>
                </li>
                <li role="presentation">
                    <a href="<%=path %>/activity/navActivityPage?buildingsId={{buildings.id}}">楼盘活动</a>
                </li>
                <li role="presentation">
                    <a href="<%=path %>/buildings/avgPricePage?buildingsId={{buildings.id}}">历史价格</a>
                </li>
                <li role="presentation">
                    <a href="<%=path %>/house/navHousePage?buildingsId={{buildings.id}}">户型图</a>
                </li>
                <li role="presentation">
                    <a href="<%=path %>/comment/buildingsCommentPage?buildingsId={{buildings.id}}">楼盘点评</a>
                </li>
                <li role="presentation">
                    <a href="<%=path %>/employee/navEmployeePage?buildingsId={{buildings.id}}">销售员</a>
                </li>
                <li role="presentation">
                    <a href="<%=path %>/room/navRoomPage?buildingsId={{buildings.id}}">在线看房</a>
                </li>
                <li role="presentation">
                    <a id="message" href="/message/navMessagePage?buildingsId={{buildings.id}}">留言</a>
                </li>
            </ul>
        </div>
        <div class="col-xs-1">
        </div>
    </div>

    <div class="row">
        <div class="col-xs-1">
        </div>
        <div class="col-xs-10" style="border: 1px solid #d7d4f0;">
            <div class="col-xs-4" style="display:block; margin:10px auto;">
                <img style="width: 280px;height: 200px;"
                     src="<%=path %>/{{buildings.logo}}" class="img-responsive"/>
            </div>

            <div class="col-xs-8">
                <table>
                    <tr>
                        <th>楼盘名称</th>
                        <td>{{buildings.name}}</td>

                    </tr>
                    <tr>
                        <th>楼盘均价</th>
                        <td>{{buildings.avg_price}}</td>
                    </tr>
                    <tr>
                        <th>开发公司</th>
                        <td>{{buildings.company}}</td>
                    </tr>
                    <tr>
                        <th>区域</th>
                        <td>{{buildings.area}}</td>
                    </tr>
                    <tr>
                        <th>地址</th>
                        <td>{{buildings.address}}</td>
                    </tr>
                    <tr>
                        <th>售楼电话</th>
                        <td>{{buildings.tel}}</td>
                    </tr>
                    <div>
                        <input type="hidden" value="{{buildings.id}}" id="buildsId">
                        <c:if test="${requestScope.like == null }">
                            <td align="right">
                                <a type="button" class="btn btn-danger" style="width: 80px;height: 35px"
                                   ng-show="${sessionScope.user == null}" data-toggle="modal" ng-click="appointment();">点&nbsp;&nbsp;&nbsp;&nbsp;赞</a>
                                <a type="button" href="javascript:void(0);" onclick="like();"
                                   style="width: 80px;height: 35px" class="btn btn-danger likeBtn"
                                   ng-show="${sessionScope.user != null}">点&nbsp;&nbsp;&nbsp;&nbsp;赞</a>
                            </td>
                        </c:if>
                        <c:if test="${requestScope.like != null }">
                            <td align="right">
                                <a type="button" href="javascript:void(0);" onclick="like();"
                                   style="width: 80px;height: 35px" class="btn btn-danger likeBtn">已&nbsp;&nbsp;&nbsp;&nbsp;点&nbsp;&nbsp;&nbsp;&nbsp;赞</a>
                            </td>
                        </c:if>
                    </div>
                </table>
            </div>
        </div>
        <div class="col-xs-1">
        </div>
    </div>

    <div class="row">
        <div class="col-xs-1">
        </div>
        <div class="col-xs-10">
            <div><h3><a target="_blank" href="<%=path %>/activity/activityDetail?activity.id={{activity.id}}">{{activity.title}}</a></h3></div>
            <div>
                <img src="<%=path %>/{{activity.logo}}" class="img-responsive" style="width:975px; height:400px;"/>
            </div>
            <div><h4>{{activity.start_time | date:'yyyy-MM-dd hh:mm'}}</h4></div>
            <div><h6>{{activity.content}}</h6></div>
        </div>
        <div class="col-xs-1">
        </div>
    </div>

    <div class="row">
        <div class="col-xs-1">
        </div>
        <div class="col-xs-10">
            <div><h3>楼盘效果图</h3></div>
            <div>
                <img src="<%=path %>/{{buildings.logo}}" class="img-responsive" style="width:975px; height:400px;"/>
            </div>
        </div>
        <div class="col-xs-1">
        </div>
    </div>

    <div class="row" style="margin-top: 20px;">
        <div class="col-xs-1">
        </div>
        <div class="col-xs-10">
            <div class="col-xs-4" ng-repeat="e in employee | limitTo:3" style="text-decoration: none">
                <img src="<%=path %>/{{e.headicon}}" class="img-responsive" style="width:310px; height:250px;"/>
                <p>{{e.name}}</p>
                <p>{{e.des}}</p>
            </div>
        </div>
        <div class="col-xs-1">
        </div>
    </div>

</div>
<%@include file="../../main/banquan.jsp" %>
</body>
<script src="<%=path%>/public/js/jquery.min.js"></script>
<script src="<%=path%>/public/js/bootstrap.min.js"></script>
<script src="<%=path %>/layer-v3.1.0/layer/layer.js"></script>
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
            var buildingsId = GetQueryString("buildingsId");

            $http({
                method: 'POST',
                url: $("#path").val() + "/user/queryUser"
            }).then(function successCallback(response) {
                $scope.user = response.data.user;
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

            $http({
                method: 'POST',
                url: "<%=path%>/buildings/indexBuildingsDetail?buildingsId=" + buildingsId,
            }).then(function successCallback(response) {
                $scope.buildings = response.data.buildings;
            }, function errorCallback(response) {
            });

            $http({
                method: 'POST',
                url: "<%=path%>/activity/buildingsActivity?buildings_id=" + buildingsId,
            }).then(function successCallback(response) {
                $scope.activity = response.data.activity;
            }, function errorCallback(response) {
            });

            $http({
                method: 'POST',
                url: "<%=path%>/employee/indexEmployee?buildings_id=" + buildingsId,
            }).then(function successCallback(response) {
                $scope.employee = response.data.employeePager.result;
            }, function errorCallback(response) {

            });

            //....
            $scope.appointment = function () {
                swal({
                    title: '需登入之后才能点赞',
                    text: "请登入",
                    confirmButtonColor: '#3085d6',
                    confirmButtonText: '确定'
                })
            };


        });
    }(jQuery));


    /**
     * 点赞
     */
    function like() {
        var buildsId = $("#buildsId").val();
        $.post("/like/addLike",
            {"buildingsId": buildsId},
            function (data) {
                if (data.result.result === 'success') {
                    if (data.result.msg === '取消成功') {
                        $(".likeBtn").text("点赞");
                    } else {
                        $(".likeBtn").text("已点赞");
                    }
                } else {
                }
            }, "json"
        );
    }

</script>
</html>
