<%--
  Created by IntelliJ IDEA.
  User: yao
  Date: 2017/9/13
  Time: 8:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%
    String path = request.getContextPath();
%>
<head>
    <title>Title</title>
</head>
<link href="<%=path%>/public/css/bootstrap.min.css" rel="stylesheet">
<link href="<%=path%>/public/admin/css/admincheck.css" rel="stylesheet">
<script src="<%=path%>/public/angular/angular.min.js"></script>
<style type="text/css" >
    .error{
        color:red;
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
<div ng-controller="myCtrl">
    <div class="container">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class=" table table-responsive container">
                        <table class="table table-striped">
                            <tr>
                                <th colspan="5">
                                    <button type="button" class="btn btn-primary" ng-click="changeYes();">激活</button>

                                    <button type="button" class="btn btn-primary" ng-click="changeNo();">冻结</button>

                                    <button type="button" class="btn btn-primary" ng-click="onclickChange($index);" >楼栋修改
                                    </button>

                                    <button type="button" class="btn btn-primary"  ng-click="onclickbtn($index);" >查看详情
                                    </button>
                                    <button type="button" id="update" class="btn btn-primary" data-toggle="modal">
                                        刷新
                                    </button>
                                </th>
                                <th>
                                    <select class="form-control"   id="district1" name="buildingsPrice.id">
                                        <option  value="所有楼盘">所有楼盘</option>
                                        <option ng-repeat="bui in buildingsPriceList"   value="{{bui.id}}">{{bui.name}}</option>
                                    </select>
                                </th>
                                <th>
                                    <select class="form-control" style="list-style: none;" id="status" name="status">
                                        <option value="3">所有楼栋</option>
                                        <option value="1">已激活楼栋</option>
                                        <option value="0">已冻结楼栋</option>
                                    </select>
                                </th>
                            </tr>
                            <tr>
                                <th><input type="checkbox" id="checkall"  ng-click="checkall()"/></th>
                                <th>楼栋名</th>
                                <th>所属楼盘</th>
                                <th>总层数</th>
                                <th>电梯数</th>
                                <th>每层多少户</th>
                                <th>总户数</th>
                                <th>状态</th>
                            </tr>
                            <tbody>
                            <tr ng-repeat="a in buildingPager">
                                <td>
                                    <input type="checkbox" title="{{$index}}" name="activityId" id="activityId"
                                           value="{{a.id}}"/>
                                </td>
                                <td>{{a.name}}</td>
                                <td>{{a.buildingsPrice.name}}</td>
                                <td>{{a.total_floor}}</td>
                                <td>{{a.total_lift}}</td>
                                <td>{{a.floor_rooms}}</td>
                                <td>{{a.total_room}}</td>
                                <td>
                                    <span style="color:#2dc25e;" ng-show="{{a.status == '1' }}">已激活</span>

                                    <span style="color:red;" ng-show="{{a.status == '0' }}">已冻结</span>
                                </td>
                            </tr>
                            <tbody>
                        </table>

                        <div class="row">
                            <div class="col-sm-2">
                                共 {{total}} 栋楼，共{{totalPageSize}}页
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

</body>
<script src="<%=path%>/public/js/jquery.min.js"></script>
<script src="<%=path%>/public/js/bootstrap.min.js"></script>
<script src="<%=path %>/layer-v3.1.0/layer/layer.js"></script>
<script src="<%=path%>/public/agency/js/jquery-validate.js"></script>
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
            $scope.buildingPager = "";
            $scope.total = 0;
            $scope.totalPageSize = 0;
            $scope.count1 = 1;

            $http({
                method: 'POST',
                url: "<%=path%>/buildings/queryBuildingsPrice"
            }).then(function successCallback(response) {
                $scope.buildingsPriceList = response.data.buildingsPriceList;
                $timeout(function(){
                    extracted($scope.count1);
                },300);
            }, function errorCallback(response) {

            });

            function extracted(x) {
                var index = layer.load(0, {shade: false});//发送请求时让页面出现加载样式
                $http({
                    method: 'POST',
                    url: "<%=path%>/building/allAgencyBuilding",
                    data: {"pageNo": x, "status": $("#status").val(),"buildings_id": $("#district1").val()}
                }).then(function successCallback(response) {
                    $scope.total = response.data.pager.total;
                    $scope.totalPageSize = response.data.pager.totalPageSize;
                    $scope.buildingPager = response.data.pager.result;
                    $scope.count1 = response.data.pager.pageNo;
                    layer.close(index);//关闭加载窗口
                    if($("#checkall").is(':checked')==true){
                        $("#checkall").prop("checked",false);
                    }
                }, function errorCallback(response) {

                });
            }

            $("#status").change(function () {//select改变事件
                extracted(1);
            });

            $("#district1").change(function () {//选择楼盘时的改变事件
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

            $scope.onclickbtn = function (x) {//楼栋查看
                if ($("input[name='activityId']:checkbox:checked").length == 1) {
                    $scope.count = $("input[name='activityId']:checkbox:checked").attr("title");
                    layer.ready(function(){
                        layer.open({
                            type: 2,
                            title: '修改楼栋信息',
                            maxmin: true,
                            area: ['800px', '500px'],
                            content: '<%=path%>/agency/building.jsp?buildingId='+$scope.buildingPager[$scope.count].id,
                            cancel: function(){
                                //关闭当前窗口时就进入此方法 ?buildingsId='+$scope.buildingsPager[$scope.count].id
                            }
                        });
                    });
                } else {
                    layer.msg("请选择一行！");
                }
            };
            $scope.onclickChange = function (x) {//楼栋修改
                if ($("input[name='activityId']:checkbox:checked").length == 1) {
                    $scope.count = $("input[name='activityId']:checkbox:checked").attr("title");
                    layer.ready(function(){
                        layer.open({
                            type: 2,
                            title: '修改楼栋信息',
                            maxmin: true,
                            area: ['800px', '500px'],
                            content: '<%=path%>/building/addbuildingpage?buildingId='+$scope.buildingPager[$scope.count].id,
                            cancel: function(){
                                //关闭当前窗口时就进入此方法 ?buildingsId='+$scope.buildingsPager[$scope.count].id
                            }
                        });
                    });
                } else {
                    layer.msg("请选择一行！");
                }
            };

            $scope.checkall=function () {//全选和取消全选
                if($("#checkall").is(':checked')==true){
                    $("input[name='activityId']").prop("checked",true);
                }else {
                    $("input[name='activityId']").prop("checked", false);
                }
            };

            $scope.changeYes= function() { // 只能激活用户，判断等页面完成
                var chk_value = [];
                $('input[name="activityId"]:checked').each(function () {
                    chk_value.push($(this).val());
                });
                if (chk_value.length == 0) {
                    layer.msg("请选择一行！");
                } else {
                    status(1,chk_value);
                }
            };

            $scope.changeNo = function () { // 只能冻结用户，判断等页面完成
                var chk_value = [];
                $('input[name="activityId"]:checked').each(function () {
                    chk_value.push($(this).val());
                });
                if (chk_value.length == 0) {
                    layer.msg("请选择一行！");
                } else {
                    status(0,chk_value);
                }
            };

            $("#update").click(function(){//刷新数据调用此方法
                var buildingsID = $("#district1").val();
                $http({
                    method: 'POST',
                    url: "<%=path%>/buildings/queryBuildingsPrice"
                }).then(function successCallback(response) {
                    $scope.buildingsPriceList = response.data.buildingsPriceList;
                    $timeout(function(){
                      $("#district1").val(buildingsID);
                        if($("#district1").val()==""||$("#district1").val() ==null){
                            $("#district1").val("所有楼盘");
                        }
                        $timeout(function(){
                            extracted($scope.count1);
                        },50);
                    },50);
                }, function errorCallback(response) {

                });
            });
            function status(updatestatus,checkedIds) {
                $.ajax({
                    type:'post',
                    traditional :true,
                    url:'<%=path %>/building/updateStatus',
                    data:{"checkedIds":checkedIds,"pageNo": $scope.count1,"updatestatus":updatestatus,"buildings_id": $("#district1").val(),"status": $("#status").val()} ,
                    success:function(data){
                        $timeout(function(){//用jquery时不会自动渲染，只能手动渲染就调用此方法,
                            if(data.controllerResult.result =='success'){
                                layer.msg(data.controllerResult.msg);
                                $scope.total = data.pager.total;
                                $scope.totalPageSize = data.pager.totalPageSize;
                                $scope.buildingPager = data.pager.result;
                                $scope.count1 = data.pager.pageNo;
                            }else {
                                layer.msg(data.controllerResult.msg);
                            }
                            if($("#checkall").is(':checked')==true){
                                $("#checkall").prop("checked",false);
                            }
                        },0);
                    }
                });
            }

        });

    }(jQuery));
</script>
</html>
