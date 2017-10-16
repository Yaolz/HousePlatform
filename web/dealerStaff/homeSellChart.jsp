<%--
  Created by IntelliJ IDEA.
  User: ID.LQF
  Date: 2017/9/4
  Time: 20:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%>
<html>
<head>
    <title>房屋销售图表查看</title>
    <link rel="shortcut icon" href="favicon.ico">
    <link href="<%=path %>/public/css/bootstrap.min14ed.css?v=3.3.6" rel="stylesheet">
    <link href="<%=path %>/public/css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
    <link href="<%=path %>/public/css/plugins/iCheck/custom.css" rel="stylesheet">
    <link href="<%=path %>/public/css/animate.min.css" rel="stylesheet">
    <link href="<%=path %>/public/css/style.min862f.css?v=4.1.0" rel="stylesheet">
    <script src="<%=path %>/public/tanchuang/sweetalert-master/dist/sweetalert-dev.js"></script>
    <link rel="stylesheet" href="<%=path %>/public/tanchuang/sweetalert-master/dist/sweetalert.css">
    <script src="<%=path%>/public/angular/angular.min.js"></script>
    <link href="<%=path%>/public/admin/css/bootstrap-datetimepicker.css" rel="stylesheet">
    <style>
        .error{
            color:red;
        }
    </style>
</head>
<body ng-app="myApp">
<input type="hidden" id="path" value="<%=path%>">
<div ng-controller="myCtrl">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">

                    <table class="table table-striped">
                        <thead>
                        <%--<th colspan="2">--%>
                        <%--</th>--%>
                        <th>
                            <button type="button" class="btn btn-primary"  onclick="history.go(0)">刷新</button>
                        </th>
                        </thead>
                        <tr>
                            <th>房屋名称</th>
                            <th>销售状态</th>
                            <th>所属楼栋</th>
                        </tr>
                        <tbody>
                        <tr ng-repeat="room in rooms">
                            <td>{{room.name}}</td>
                            <td>{{room.sale_status }}</td>
                            <td>{{room.building.name}}</td>
                        </tr>
                        <tbody>
                    </table>

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

<form method="post" id="formid">
    <input type="hidden" name="sale.id" id="checkedIds"/>
    <input type="hidden" name="sale.status" id="status"/>
</form>


<script src="<%=path %>/public/js/jquery.min.js?v=2.1.4"></script>
<script src="<%=path %>/public/js/bootstrap.min.js?v=3.3.6"></script>
<script src="<%=path %>/public/js/plugins/peity/jquery.peity.min.js"></script>
<script src="<%=path %>/public/js/content.min.js?v=1.0.0"></script>
<script src="<%=path %>/public/js/plugins/iCheck/icheck.min.js"></script>
<script src="<%=path %>/public/js/demo/peity-demo.min.js"></script>
<script src="<%=path%>/public/agency/js/jquery-validate.js"></script>
<script src="<%=path %>/public/admin/js/bootstrap-datetimepicker.js"></script>
<script src="<%=path %>/public/admin/js/bootstrap-datetimepicker.zh-CN.js"></script>
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
            $scope.rooms="";
            $scope.count1=1;
            extracted($scope.count1);

            function extracted(x) {
                $http({
                    method: 'POST',
                    url: "<%=path%>/room/roomPageJson",
                    data: {"pageNo": x }
                }).then(function successCallback(response) {
                    $scope.rooms = response.data.pager.result;
                    $scope.total = response.data.pager.total;
                    $scope.totalPageSize = response.data.pager.totalPageSize;
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
</body>
</html>
