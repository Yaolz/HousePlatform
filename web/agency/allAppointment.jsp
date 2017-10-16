<%--
  Created by IntelliJ IDEA.
  User: yao
  Date: 2017/9/13
  Time: 8:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html><html>
<%
    String path = request.getContextPath();
%>
<head>
    <title>所有预约</title>
</head>
<link href="<%=path%>/public/css/bootstrap.min.css" rel="stylesheet">
<link href="<%=path%>/public/admin/css/admincheck.css" rel="stylesheet">
<link rel="stylesheet" href="<%=path%>/public/xiangcecss/css/baguetteBox.min.css">
<script src="<%=path%>/public/angular/angular.min.js"></script>
<style type="text/css">
    <%--cut样式主要用于把多出的字给截断--%>
    .cut {
        overflow:hidden;
        text-overflow:ellipsis;
        white-space: nowrap;
    }
    .error{
        color:red;
    }
    dd, dt {
        line-height: 2.42857143;
    }
</style>
<style>
    .btn-primary {
        background-color: #1ab394;
        border-color: #1ab394;
        color: #FFF;
    }
</style>
<body ng-app="myApp">
<input type="hidden" id="path" value="<%=path%>">
<input type="hidden"  id="agency-phone" value="${sessionScope.agency.phone}" />
<input type="hidden" id="agency-name"  value="${sessionScope.agency.name}" />
<div ng-controller="myCtrl">
    <div class="container">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class=" table table-responsive container">
                        <table class="table table-striped">
                            <tr>
                                <th colspan="5">
                                    <button type="button" id="update" class="btn btn-primary" data-toggle="modal">
                                        刷新
                                    </button>
                                </th>
                                <th>
                                    <select class="form-control" style="list-style: none;" id="app_status" name="app_status ">
                                        <option value="0">所有预约状态</option>
                                        <option value="1">已预约</option>
                                        <option value="2">已联系</option>
                                        <option value="3">已看房</option>
                                        <option value="4">已购房</option>
                                    </select>
                                </th>
                                <th>
                                    <select class="form-control" style="list-style: none;" id="status" name="status">
                                        <option value="2">查看所有状态</option>
                                        <option value="0">冻结的</option>
                                        <option value="1">激活的</option>
                                    </select>
                                </th>
                            </tr>
                            <tr>
                                <th>预约用户</th>
                                <th>预约的员工</th>
                                <th>预约看房时间</th>
                                <th>真实看房时间</th>
                                <th>预约户型</th>
                                <th>预约状态</th>
                                <th>状态</th>
                            </tr>
                            <tbody>
                            <tr class="tz-gallery" ng-repeat="a in appointmentPager">
                                <td>{{a.userPrice.name}}</td>
                                <td>{{a.employeePrice.name}}</td>
                                <td>{{a.app_arrive_time | date:"yyyy-MM-dd HH:mm:ss"}}</td>
                                <td>{{a.arrive_time | date:"yyyy-MM-dd HH:mm:ss"}}</td>
                                <td><a class="btn btn-success" href="<%=path%>/{{a.house.logo}}" alt="<%=path%>/{{a.house.logo}}">查看</a></td>
                                <td>
                                    <span style="color:#2dc25e;" ng-show="{{a.app_status == '1' }}">已预约</span>
                                    <span style="color:#2122ff;" ng-show="{{a.app_status == '2' }}">已联系</span>
                                    <span style="color:#e8ff6d;" ng-show="{{a.app_status == '3' }}">已看房</span>
                                    <span style="color:red;" ng-show="{{a.app_status == '4' }}">已购房</span>
                                </td>
                                <td>
                                    <span style="color:#2dc25e;" ng-show="{{a.status == '1' }}">已激活</span>

                                    <span style="color:red;" ng-show="{{a.status == '0' }}">已冻结</span>
                                </td>
                            </tr>
                            <tbody>
                        </table>
                        <div class="row">
                            <div class="col-sm-2">
                                共 {{total}} 个结果，共{{totalPageSize}}页
                            </div>
                            <div class="col-sm-5">
                                <nav aria-label="Page navigation" class="pull-right">
                                    <ul class="pagination">
                                        <li ng-click="top()"><a>«</a></li>
                                        <li><a class="page" ng-show="count1>=5 " ng-click="page(count1-4)">{{count1-4}}</a></li>
                                        <li><a class="page" ng-show="count1>=4 " ng-click="page(count1-3)">{{count1-3}}</a></li>
                                        <li><a class="page" ng-show="count1>=3 " ng-click="page(count1-2)">{{count1-2}}</a></li>
                                        <li><a class="page" ng-show="count1>=2 " ng-click="page(count1-1)">{{count1-1}}</a></li>
                                        <li class="active"><a class="page" ng-show="count1>0" ng-click="page(count1)" title="{{count1}}">{{count1}}</a></li>
                                        <li><a class="page" ng-show="count1>0 && totalPageSize-1>= count1" ng-click="page(count1+1)">{{count1+1}}</a></li>
                                        <li><a class="page" ng-show="count1>0 && (totalPageSize-2) >= count1" ng-click="page(count1+2)">{{count1+2}}</a></li>
                                        <li><a class="page" ng-show="count1<3 && (totalPageSize-3) >= count1" ng-click="page(count1+3)">{{count1+3}}</a></li>
                                        <li><a class="page" ng-show="count1<2 && (totalPageSize-4) >= count1" ng-click="page(count1+4)">{{count1+4}}</a></li>
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
</body>
<script src="<%=path%>/public/js/jquery.min.js"></script>
<script src="<%=path%>/public/js/bootstrap.min.js"></script>
<script src="<%=path %>/layer-v3.1.0/layer/layer.js"></script>
<script type="text/javascript" id="my" src="<%=path%>/public/xiangcecss/js/baguetteBox.min.js"></script>
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
            $scope.appointmentPager = "";
            $scope.total = 0;
            $scope.totalPageSize = 0;
            $scope.count1 = 1;
            extracted($scope.count1);

            function extracted(x) {
                var index = layer.load(0, {shade: false});//发送请求时让页面出现加载样式
                var urls = "<%=path%>/appointment/AllApp";
                var data1 = {"pageNo": x, "status": $("#status").val(),"app_status":$("#app_status").val()};
                $http({
                    method: 'POST',
                    url: urls,
                    data: data1
                }).then(function successCallback(response) {
                    $scope.total = response.data.appointmentPager.total;
                    $scope.totalPageSize = response.data.appointmentPager.totalPageSize;
                    $scope.appointmentPager = response.data.appointmentPager.result;
                    $scope.count1 = response.data.appointmentPager.pageNo;
                    layer.close(index);//关闭加载窗口
                    $timeout(function(){
                        baguetteBox.run('.tz-gallery');
                    },50);
                }, function errorCallback(response) {

                });
            }

            $("#update").click(function(){//刷新数据调用此方法
                extracted($scope.count1);
            });

            $("#status").change(function () {//选择状态时的改变事件
                extracted(1);
            });

            $("#app_status").change(function () {//选择状态时的改变事件
                extracted(1);
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

        });
    }(jQuery));
</script>
</html>

