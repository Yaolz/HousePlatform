<%--
  Created by IntelliJ IDEA.
  User: ID.LQF
  Date: 2017/9/4
  Time: 20:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
    String path = request.getContextPath();
%><!DOCTYPE html>
<html>
<head>
    <title>房屋业主信息</title>
    <link rel="shortcut icon" href="favicon.ico">
    <link href="<%=path %>/public/css/bootstrap.min14ed.css?v=3.3.6" rel="stylesheet">
    <link href="<%=path %>/public/css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
    <link href="<%=path %>/public/css/plugins/iCheck/custom.css" rel="stylesheet">
    <link href="<%=path %>/public/css/animate.min.css" rel="stylesheet">
    <link href="<%=path %>/public/css/style.min862f.css?v=4.1.0" rel="stylesheet">
    <script src="<%=path%>/public/angular/angular.min.js"></script>
</head>
<body ng-app="myApp">
<div ng-controller="myCtrl">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h4 style="float: left">房屋业主信息</h4>
                        <div class="ibox-tools">
                            <a class="collapse-link">
                                <i class="fa fa-chevron-up"></i>
                            </a>
                        </div>
                        <button style="float: right" type="button" class="btn btn-primary"  onclick="history.go(0)">刷新</button>
                        <p style="clear: both;"></p>
                    </div>
                    <div class="ibox-content">
                        <div class="table-responsive">
                            <table class="table table-striped">
                                <thead>
                                <tr>
                                    <th>业主姓名</th>
                                    <th>业主性别</th>
                                    <th>业主电话</th>
                                    <th>所住楼盘</th>
                                    <th>所住房号</th>
                                    <th>购买时间</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr ng-repeat="sale in sales">
                                    <td><h4>{{sale.customer.name}}</h4></td>
                                    <td><h4>{{sale.customer.gender}}</h4></td>
                                    <td><h4>{{sale.customer.phone }}</h4></td>
                                    <td><h4>{{sale.room.building.name }}</h4></td>
                                    <td><h4>{{sale.room.name }}</h4></td>
                                    <td><h4>{{sale.sale_time | date:'yyyy-MM-dd hh:mm'}}</h4></td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-sm-2">
                共 {{total}} 个用户，共{{totalPageSize}}页
            </div>
            <div class="col-sm-10">
                <nav aria-label="Page navigation" class="pull-right">
                    <ul class="pagination">
                        <li  ng-click="top()"><a >«</a></li>
                        <li><a class="page" ng-show="count1>=5 " ng-click="page(count1-4)">{{count1-4}}</a></li>
                        <li><a class="page" ng-show="count1>=4 " ng-click="page(count1-3)">{{count1-3}}</a></li>
                        <li><a class="page" ng-show="count1>=3 " ng-click="page(count1-2)">{{count1-2}}</a></li>
                        <li><a class="page" ng-show="count1>=2 " ng-click="page(count1-1)">{{count1-1}}</a></li>
                        <li class="active"><a class="page" ng-show="count1>0" ng-click="page(count1)" title="{{count1}}">{{count1}}</a></li>
                        <li><a class="page" ng-show="count1>0 && totalPageSize-1>= count1" ng-click="page(count1+1)"  >{{count1+1}}</a></li>
                        <li><a class="page" ng-show="count1>0 && (totalPageSize-2) >= count1" ng-click="page(count1+2)"  >{{count1+2}}</a></li>
                        <li><a class="page" ng-show="count1<3 && (totalPageSize-3) >= count1" ng-click="page(count1+3)"  >{{count1+3}}</a></li>
                        <li><a class="page" ng-show="count1<2 && (totalPageSize-4) >= count1" ng-click="page(count1+4)"  >{{count1+4}}</a></li>
                        <li   ng-click="down()"><a >»</a></li>
                    </ul>
                </nav>
            </div>
        </div>

    </div>
</div>
<script src="<%=path %>/public/js/jquery.min.js?v=2.1.4"></script>
<script src="<%=path %>/public/js/bootstrap.min.js?v=3.3.6"></script>
<script src="<%=path %>/public/js/plugins/peity/jquery.peity.min.js"></script>
<script src="<%=path %>/public/js/content.min.js?v=1.0.0"></script>
<script src="<%=path %>/public/js/plugins/iCheck/icheck.min.js"></script>
<script src="<%=path %>/public/js/demo/peity-demo.min.js"></script>
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
        app.controller('myCtrl', function($scope,$http,$timeout) {

            $scope.total=0;
            $scope.totalPageSize=0;
            $scope.sales="";
            $scope.count1=1;
            extracted($scope.count1);

            function extracted(x) {
                $http({
                    method: 'POST',
                    url: "<%=path%>/staff/sellRecordJson",
                    data: {"pageNo": x }
                }).then(function successCallback(response) {
                    $scope.sales = response.data.salePager.result;
                    $scope.total = response.data.salePager.total;
                    $scope.totalPageSize = response.data.salePager.totalPageSize;
                    $scope.count1 = response.data.salePager.pageNo;
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
</body>
</html>
