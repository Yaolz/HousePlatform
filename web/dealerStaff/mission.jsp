<%--
  Created by IntelliJ IDEA.
  User: ID.LQF
  Date: 2017/9/4
  Time: 19:51
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
    <title>绩效查看</title>
    <link href="<%=path %>/public/css/bootstrap.min14ed.css?v=3.3.6" rel="stylesheet">
    <link href="<%=path%>/public/css/style.min862f.css?v=4.1.0" rel="stylesheet">
    <link href="<%=path%>/public/admin/css/admincheck.css" rel="stylesheet">
    <script src="<%=path%>/public/angular/angular.min.js"></script>
</head>
<body ng-app="myApp">
<div ng-controller="myCtrl">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h4 style="float: left">绩效查看</h4>
                        <div class="col-sm-4">
                            <select class="form-control" style="list-style: none;" id="status" name="status">
                                <option value="2">查看所有状态</option>
                                <option value="0">被冻结的任务</option>
                                <option value="1">被激活的任务</option>
                            </select>
                        </div>
                        <div class="ibox-tools">
                            <a class="collapse-link">
                                <i class="fa fa-chevron-up"></i>
                            </a>
                        </div>
                        <button style="float: right" type="button" class="btn btn-primary"  onclick="history.go(0)">刷新</button>
                    </div>
                    <div class="ibox-content">
                        <div class="table-responsive">
                            <table class="table table-striped">
                                <thead>
                                <tr>
                                    <th>开始时间</th>
                                    <th>结束时间</th>
                                    <th>提成百分比</th>
                                    <th>销售量</th>
                                    <th>任务量</th>
                                    <th>任务状态</th>
                                    <th>状态</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr ng-repeat="a in missions">
                                    <td>{{a.start_time | date:"yyyy-MM-dd HH:mm:ss"}}</td>
                                    <td>{{a.end_time | date:"yyyy-MM-dd HH:mm:ss"}}</td>
                                    <td>{{a.bonus_percent}}</td>
                                    <td>{{a.coun}}</td>
                                    <td>{{a.quantity}}</td>
                                    <td>
                                        <span ng-show="a.coun < a.quantity" style="color: #dc2b49">未完成</span>
                                        <span ng-show="a.coun >= a.quantity" style="color: #2dc25e">完成</span>
                                    </td>
                                    <td>
                                        <span style="color:#2dc25e;" ng-show="{{a.status == '1' }}">已激活</span>

                                        <span style="color:red;" ng-show="{{a.status == '0' }}">已冻结</span>
                                    </td>
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
                        <li ><a class="page" ng-show="count1>0" ng-click="page(count1)" title="{{count1}}">{{count1}}</a></li>
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
            $scope.missions="";
            $scope.count1=1;
            extracted($scope.count1);

            function extracted(x) {
                $http({
                    method: 'POST',
                    url:  "<%=path%>/mission/allEmployeeMission",
                    data: {"pageNo": x,"status": $("#status").val()}
                }).then(function successCallback(response) {
                    $scope.missions = response.data.missionPager.result;
                    $scope.total = response.data.missionPager.total;
                    $scope.totalPageSize = response.data.missionPager.totalPageSize;
                    $scope.count1 = response.data.missionPager.pageNo;
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

            $("#status").change(function () {//选择状态时的改变事件
                extracted(1);
            });

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
