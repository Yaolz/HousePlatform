<%--
  Created by IntelliJ IDEA.
  User: yao
  Date: 2017/8/28
  Time: 10:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
%><!DOCTYPE html>
<html>
<head>
    <title>Title</title>
</head>
<link href="<%=path%>/public/css/bootstrap.min.css" rel="stylesheet">
<link href="<%=path%>/public/css/style.min.css" rel="stylesheet">
<link href="<%=path%>/public/admin/css/admincheck.css" rel="stylesheet">

<script src="<%=path%>/public/angular/angular.min.js"></script>
<body ng-app="myApp">
<div ng-controller="myCtrl">
    <div class="wrapper wrapper-content">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class=" table table-responsive container">
                        <table class="table table-striped">
                            <thead>
                            <th colspan="5">
                                <button type="button" class="btn btn-primary" onclick="detail();">查看详情</button>
                            </th>
                            <th>
                                <button class="btn btn-primary" onclick="window.location.reload(true);">刷新</button>
                            </th>
                            </thead>
                            <tr>
                                <th><input type="checkbox"/></th>
                                <th>发布方</th>
                                <th>标题</th>
                                <th>地址</th>
                                <th>开始时间</th>
                                <th>结束时间</th>
                            </tr>
                            <tbody>
                            <tr ng-repeat="a in activitys">
                                <td>
                                    <input type="checkbox" name="activityId" id="activityId" value="{{a.id}}"/>
                                </td>
                                <td>
                                    <p ng-show="{{a.agencyPrice.name == null }}">售楼网</p>
                                    <p ng-show="{{a.agencyPrice.name != null }}">{{a.agencyPrice.name}}</p>
                                </td>
                                <td>{{a.title}}</td>
                                <td>{{a.address}}</td>
                                <td>{{a.start_time | date:'yyyy-MM-dd hh:mm'}}</td>
                                <td>{{a.end_time | date:'yyyy-MM-dd hh:mm'}}</td>
                            </tr>
                            <tbody>
                        </table>

                        <div class="row">
                            <div class="col-sm-2">
                                共 {{total}} 个活动，共{{totalPageSize}}页
                            </div>
                            <div class="col-sm-10">
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
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<form target="_blank" method="post" id="formid">
    <input type="hidden" name="activity.id" id="checkedIds"/>
</form>
</body>
<script src="<%=path%>/public/js/jquery.min.js"></script>
<script src="<%=path%>/public/js/bootstrap.min.js"></script>
<script src="<%=path %>/layer-v3.1.0/layer/layer.js"></script>
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
                if($scope.count1==x){
                    return;
                }
                extracted(x);
            };

            $scope.down = function() {//下一页

                if($scope.count1==$scope.totalPageSize){
                    return;
                }
                extracted($scope.count1+1);
            };
            $scope.top = function () {//上一页

                if ($scope.count1 == 1) {
                    return;
                }
                extracted($scope.count1-1);
            };

        });
    }(jQuery));
</script>

<script>
    function detail() {
        var chk_value = [];
        $('input[name="activityId"]:checked').each(function () {
            chk_value.push($(this).val());
        });
        if (chk_value.length == 1) {
            $('#checkedIds').val(chk_value);
            $('#formid').prop("action", "<%=path %>/activity/activityDetail").submit();
        } else {
          layer.msg("请选择一行！");
        }
    }
</script>
</html>
