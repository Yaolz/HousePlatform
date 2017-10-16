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
    <title>Title</title>
    <link href="<%=path%>/public/css/bootstrap.min.css" rel="stylesheet">
    <script src="<%=path%>/public/angular/angular.min.js"></script>
</head>
<style>
    .audit-order-filter li {
        float: left;
        display: inline;
        width: 68px;
        height: 22px;
        margin-right: 15px;
        border-radius: 2px;
        border-width: 1px;
        border-style: solid;
        text-align: center;
        line-height: 22px;
        cursor: pointer;
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
                <li role="presentation">
                    <a id="builActivity" href="">楼盘活动</a>
                </li>
                <li role="presentation">
                    <a id="hisPrice" href="">历史价格</a>
                </li>
                <li role="presentation">
                    <a id="building" href="">户型图</a>
                </li>
                <li role="presentation" class="active">
                    <a href="">楼盘点评</a>
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

    <div class="row" id="content" style="margin-top:20px;">
        <div class="col-xs-1"></div>
        <div class="col-xs-10">
            <form id="form">
                <textarea class="form-control" rows="3" name="comment.content" style="height: 200px;"
                          placeholder="请输入您的看法......"></textarea>
                <input type="hidden" name="userPrice.id" id="user" value="${user.id}"/>
                <input style="margin-top: 10px;" type="button" class="btn btn-default" value="发表评论" ng-click="add();"/>
            </form>
            <div style="margin-top:30px; border: solid 1px #d1d1d1;border-radius:10px;">
                <div class="media" style="margin-top: 30px;margin-left: 10px; padding-bottom:20px; border-bottom:1px dashed #e2e2e2;" ng-repeat="com in comment">
                    <div class="media-left">
                        <img class="media-object" src="<%=path%>/{{com.userPrice.headicon}}" alt="80x80" data-holder-rendered="true" style="width: 64px; height: 64px;">
                    </div>
                    <div class="media-body" >
                        <h4 class="media-heading">{{com.userPrice.name}}</h4>
                        <p>{{com.comment_time | date:'yyyy-MM-dd HH:mm'}}</p>
                        {{com.content}}
                    </div>
                </div>
        </div>
        </div>
        <div class="col-xs-1"></div>
    </div>
    <div class="row" ng-show="comment != ''">
        <div class="col-sm-4">
            共 {{total}}条评论，共{{totalPageSize}}页
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
<%@include file="../../main/banquan.jsp" %>

<script src="<%=path%>/public/js/jquery.min.js"></script>
<script src="<%=path%>/public/js/bootstrap.min.js"></script>
<script src="<%=path %>/layer-v3.1.0/layer/layer.js"></script>
<script src="<%=path%>/index/js/index.js"></script>
<script>
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
                data: {"beginNum": 23, "endNum": 23}
            }).then(function successCallback(response) {
                $scope.ads = response.data.adsList;
                if ($scope.ads[0] == null || $scope.ads[0] == '' || $scope.ads[0] == undefined) {
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
            $scope.comment = "";
            $scope.count1 = 1;
            extracted($scope.count1);

            function extracted(x) {
                $http({
                    method: 'POST',
                    url: "<%=path%>/comment/buildingsComment?buildingsId=" + buildingsId,
                    data: {"page": x}
                }).then(function successCallback(response) {
                    $scope.total = response.data.commentPager.total;
                    $scope.totalPageSize = response.data.commentPager.totalPageSize;
                    $scope.comment = response.data.commentPager.result;
                    $scope.count1 = response.data.commentPager.pageNo;
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

            $scope.add = function () {
                var user = $("#user").val();
                if (user == null || user.trim() == "") {
                    layer.msg("请登录后评论！")
                    return;
                }
                $.post("<%=path %>/comment/addComments?buildingsPrice.id=" + buildingsId,
                    $("#form").serialize(),
                    function (data) {
                        if (data.result.result == 'success') {
                            layer.alert('评论成功！', {
                                skin: 'layui-layer-lan' //样式类名
                                , closeBtn: 0
                            }, function () {
                                window.location.reload();
                            });
                        } else {
                            layer.msg("失败！");
                        }
                    }, 'json'
                );
            }

            // 点击导航的事件
            $("#indexPage").click(function () {
                $('#indexPage').attr('href', '<%=path %>/buildings/indexBuildingsDetailPage?buildingsId=' + buildingsId);
            });

            $("#builDetail").click(function () {
                $('#builDetail').attr('href', '<%=path %>/buildings/navBuildingsPage?buildingsId=' + buildingsId);
            });

            $("#builActivity").click(function () {
                $('#builActivity').attr('href', '<%=path %>/activity/navActivityPage?buildingsId=' + buildingsId);
            });

            $("#hisPrice").click(function () {
                $('#hisPrice').attr('href', '<%=path %>/buildings/avgPricePage?buildingsId=' + buildingsId);
            });

            $("#building").click(function () {
                $('#building').attr('href', '<%=path %>/house/navHousePage?buildingsId=' + buildingsId);
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
</body>
</html>
