<%--
  Created by IntelliJ IDEA.
  User: yao
  Date: 2017/9/16
  Time: 10:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<%
    String path = request.getContextPath();
%>
<head>
    <title>在线看房</title>
</head>
<link href="<%=path%>/public/css/bootstrap.min.css" rel="stylesheet">
<script src="<%=path%>/public/angular/angular.min.js"></script>
<style>
    span {
        margin-right: 10px;
    }

    em {
        font-style: normal;
        font-weight: normal;
    }


    .yishou {
        display: inline-block;
        width: 18px;
        height: 18px;
        border: 1px solid red;
        margin-right: 8px;
        vertical-align: -6px;
        background-color: red;
    }
    .on-sale {
        display: inline-block;
        width: 18px;
        height: 18px;
        border: 1px solid #CC9900;
        margin-right: 8px;
        vertical-align: -6px;
        background-color: #CC9900;
    }
    .daishou {
        display: inline-block;
        width: 18px;
        height: 18px;
        border: 1px solid #49ff20;
        margin-right: 8px;
        vertical-align: -6px;
        background-color: #49ff20;
    }
    .yiyuding {
        display: inline-block;
        width: 18px;
        height: 18px;
        border: 1px solid #3232c2;
        margin-right: 8px;
        vertical-align: -6px;
        background-color: #3232c2;
    }


</style>

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
                    <img src="<%=path %>/images/timg1.jpg" title="点击投放广告" width="100%" height="280px;">
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
                <li role="presentation" >
                    <a id="builActivity" href="">楼盘活动</a>
                </li>
                <li role="presentation">
                    <a id="hisPrice" href="">历史价格</a>
                </li>
                <li role="presentation">
                    <a id="building" href="">户型图</a>
                </li>
                <li role="presentation" >
                    <a id="comment" href="">楼盘点评</a>
                </li>
                <li role="presentation">
                    <a id="employee" href="">销售员</a>
                </li>
                <li role="presentation" class="active">
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

    <div class="row" style="margin-top:20px;">
        <div class="col-xs-1"></div>
        <div class="col-xs-10">
            <div class="col-sm-3">
                <select  class="form-control" style="width: 185px;" id="buildingId" name="buildingId">
                    <option  ng-repeat="b in building" value="{{b.id}}">{{b.name}}</option>
                </select>
            </div>
            <div class="col-sm-9">
                <span>
                    <i  class="daishou"></i>
                    <em>待售</em>
                </span>
                <span>
                    <i  class="on-sale"></i>
                    <em>销售中</em>
                </span>
                <span>
                    <i  class="yiyuding"></i>
                    <em>已预定</em>
                </span>
                <span>
                    <i  class="yishou"></i>
                    <em>已售</em>
                </span>
            </div>

            <div style="margin-top: 40px;">
                <table class="table">
                    <div class="row">
                        <tr>
                            <div class="col-xs-2 table_room" style="border: solid 1px #e7e7e7">
                                房号
                            </div>
                            <div class="col-xs-2 table_room" style="border: solid 1px #e7e7e7">
                                房号
                            </div>
                            <div class="col-xs-2 table_room" style="border: solid 1px #e7e7e7">
                                房号
                            </div>
                            <div class="col-xs-2 table_room" style="border: solid 1px #e7e7e7">
                                房号
                            </div>
                            <div class="col-xs-2 table_room" style="border: solid 1px #e7e7e7">
                                房号
                            </div>
                            <div class="col-xs-2 table_room" style="border: solid 1px #e7e7e7">
                                房号
                            </div>
                        </tr>
                        <tr>
                            <div ng-repeat="r in room">
                                <div class="col-xs-2 table_room" ng-show="{{r.sale_status == '0' }}" style="border: solid 1px #49ff20;background-color: #dff0d8"  >
                                    {{r.name}}
                                </div>
                                <div class="col-xs-2 table_room" ng-show="{{r.sale_status == '1' }}" style="border: solid 1px #CC9900;background-color: #f2dede" >
                                    {{r.name}}
                                </div>
                                <div class="col-xs-2 table_room" style="border: solid 1px #3232c2;background-color: #f2dede" ng-show="{{r.sale_status == '2' }}">
                                    {{r.name}}
                                </div>
                                <div class="col-xs-2 table_room" style="border: solid 1px red;background-color: #f2dede" ng-show="{{r.sale_status == '3' }}">
                                    {{r.name}}
                                </div>
                                <div class="col-xs-2 table_room" style="border: solid 1px red;background-color: #f2dede" ng-show="{{r.sale_status == '4' }}">
                                    {{r.name}}
                                </div>
                            </div>
                        </tr>
                    </div>
                </table>
            </div>
        </div>
        <div class="col-xs-1"></div>
    </div>
    <div class="container">
        <div class="row">
            <div class="col-sm-3 col-sm-offset-1">
                共 {{total}}个房间，共{{totalPageSize}}页
            </div>
            <div class="col-lg-3">
                <div class="input-group">
                   <span class="input-group-btn">
                       <button class="btn btn-default"  type="button">第</button>
                   </span>
                    <input type="text" class="form-control" id="pageNo" placeholder="请输入页号" onKeyUp="value=(parseInt((value=value.replace(/\D/g,''))==''?'0':value,10))">
                    <span class="input-group-btn">
                        <button class="btn btn-default"   type="button">页</button>
                        <button class="btn btn-default"  ng-click="like();"  type="button">确定</button>
                    </span>
                </div><!-- /input-group -->
            </div>
            <div class="col-sm-4">
                <nav aria-label="Page navigation" class="pull-right">
                    <ul class="pagination">
                        <li ng-click="top()"><a>«</a></li>
                        <li><a class="page" ng-show="count1>=5 " ng-click="page(count1-4)">{{count1-4}}</a></li>
                        <li><a class="page" ng-show="count1>=4 " ng-click="page(count1-3)">{{count1-3}}</a></li>
                        <li><a class="page" ng-show="count1>=3 " ng-click="page(count1-2)">{{count1-2}}</a></li>
                        <li><a class="page" ng-show="count1>=2 " ng-click="page(count1-1)">{{count1-1}}</a></li>
                        <li class="active"><a class="page" ng-show="count1>0" ng-click="page(count1)" title="{{count1}}">{{count1}}</a></li>
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
            $scope.total = 0;
            $scope.totalPageSize = 0;
            $scope.count1 = 1;
            $http({
                method: 'POST',
                url: $("#path").val()+"/user/queryUser"
            }).then(function successCallback(response) {
                $scope.user = response.data.user;
            }, function errorCallback(response) {
            });
            // 显示广告
            $http({
                method: 'POST',
                url: "<%=path%>/ads/adsShow",
                data: {"beginNum": 25, "endNum": 25}
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
            $http({
                method: 'POST',
                url: "<%=path%>/building/allBuilding?buildingsId=" + buildingsId,
            }).then(function successCallback(response) {
                $scope.building = response.data.pager.result;
                $timeout(function () {
                    extracted($scope.count1);
                }, 300);
            }, function errorCallback(response) {

            });

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

            $scope.like = function () {
                if( parseFloat($("#pageNo").val())> $scope.totalPageSize){
                    return;
                }else if(parseFloat($("#pageNo").val())< 1){
                    return;
                }else {
                    extracted(parseFloat($("#pageNo").val()),$("#buildingId").val());
                }
            };

            function extracted(x) {
                $http({
                    method: 'POST',
                    url: "<%=path%>/room/navRoom",
                    data: {"pageNo": x, "buildingId": $("#buildingId").val()}
                }).then(function successCallback(response) {
                    $scope.total = response.data.pager.total;
                    $scope.totalPageSize = response.data.pager.totalPageSize;
                    $scope.room = response.data.pager.result;
                    $scope.count1 = response.data.pager.pageNo;
                }, function errorCallback(response) {

                });
            }

            $("#buildingId").change(function () {//选择状态时的改变事件
                extracted(1);
            });

            // 点击导航的事件
            $("#indexPage").click(function(){
                $('#indexPage').attr('href','<%=path %>/buildings/indexBuildingsDetailPage?buildingsId=' + buildingsId);
            });

            $("#builDetail").click(function(){
                $('#builDetail').attr('href','<%=path %>/buildings/navBuildingsPage?buildingsId=' + buildingsId);
            });

            $("#comment").click(function(){
                $('#comment').attr('href','<%=path %>/comment/buildingsCommentPage?buildingsId=' + buildingsId);
            });

            $("#hisPrice").click(function(){
                $('#hisPrice').attr('href','<%=path %>/buildings/avgPricePage?buildingsId=' + buildingsId);
            });

            $("#building").click(function(){
                $('#building').attr('href','<%=path %>/house/navHousePage?buildingsId=' + buildingsId);
            });

            $("#employee").click(function(){
                $('#employee').attr('href','<%=path %>/employee/navEmployeePage?buildingsId=' + buildingsId);
            });

            $("#builActivity").click(function(){
                $('#builActivity').attr('href','<%=path %>/activity/navActivityPage?buildingsId=' + buildingsId);
            });
            $("#message").click(function(){
                $('#message').attr('href','<%=path %>/message/navMessagePage?buildingsId=' + buildingsId);
            });

        });

    }(jQuery));
</script>
</html>
