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
    <title>Title</title>
</head>
<link href="<%=path%>/public/css/bootstrap.min.css" rel="stylesheet">
<link href="<%=path%>/public/admin/css/bootstrap-datetimepicker.css" rel="stylesheet">
<script src="<%=path%>/public/angular/angular.min.js"></script>
<style>
    .error{
        color:red;
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
                <a target="_blank" href="{{ads[0].ad_url}}">
                    <img src="<%=path %>/{{ads[0].logo}}" style="width:975px; height: 280px;margin-top: 20px;" title="{{ads[0].title}}">
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
                    <a href="<%=path %>/buildings/indexBuildingsDetailPage?buildingsId={{employee[0].buildingsPrice.id}}">楼盘首页</a>
                </li>
                <li role="presentation">
                    <a href="<%=path %>/buildings/navBuildingsPage?buildingsId={{employee[0].buildingsPrice.id}}">楼盘详情</a>
                </li>
                <li role="presentation">
                    <a href="<%=path %>/activity/navActivityPage?buildingsId={{employee[0].buildingsPrice.id}}">楼盘活动</a>
                </li>
                <li role="presentation">
                    <a href="<%=path %>/buildings/avgPricePage?buildingsId={{employee[0].buildingsPrice.id}}">历史价格</a>
                </li>
                <li role="presentation">
                    <a href="<%=path %>/house/navHousePage?buildingsId={{employee[0].buildingsPrice.id}}">户型图</a>
                </li>
                <li role="presentation">
                    <a href="<%=path %>/comment/buildingsCommentPage?buildingsId={{employee[0].buildingsPrice.id}}">楼盘点评</a>
                </li>
                <li role="presentation"  class="active">
                    <a  href="<%=path %>/employee/navEmployeePage?buildingsId={{employee[0].buildingsPrice.id}}">销售员</a>
                </li>
                <li role="presentation">
                    <a href="<%=path %>/room/navRoomPage?buildingsId={{employee[0].buildingsPrice.id}}">在线看房</a>
                </li>
                <li role="presentation">
                    <a href="<%=path %>/message/navMessagePage?buildingsId={{employee[0].buildingsPrice.id}}">留言</a>
                </li>
            </ul>
        </div>
        <div class="col-xs-1">
        </div>
    </div>

    <div class="row" style="margin-top: 30px;">
        <div class="col-xs-1">
        </div>
        <div class="col-xs-10">
            <div class="col-xs-4" ng-repeat="e in employee | limitTo : 6" style="margin-top: 20px;">
                <img src="<%=path %>/{{e.headicon}}" style="width:280px; height:300px;"/>
                <p>{{e.name}}</p>
                <p>简介:{{e.intro}}</p>
                <p>电话:{{e.phone}}</p>
                <p>QQ:{{e.qq}}</p>
                <a type="button" class="btn btn-danger" style="width: 100px" ng-show="${sessionScope.user != null}" data-toggle="modal"  ng-click="appointment($index);">预 约</a>
                <a type="button" class="btn btn-primary" style="width: 100px" ng-show="${sessionScope.user == null}" data-toggle="modal"  ng-click="notAppointment();">预 约</a>
            </div>
        </div>
        <div class="col-xs-1">
        </div>
    </div>
    <div class="row" style="margin-top: 40px;">
        <div class="col-sm-6">
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
    <!--填写预约信息-->
    <div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel2">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel2">预约信息</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" id="register-form" method="post">
                        <input type="hidden" id="emp_id" name="appointment.employeePrice.id">
                        <input type="hidden" id="agency_id" name="appointment.agencyPrice.id"/>
                        <div class="form-group">
                            <label for="emp_name" class="col-sm-3 control-label">负责人：</label>
                            <div class="col-sm-7">
                                <input type="text" class="form-control" name="customer.phone" id="emp_name" readonly>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="gender" class="col-sm-3 control-label">性别：</label>
                            <div class="col-sm-7">
                                <input type="text" class="form-control" name="customer.phone" id="gender" readonly>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="phone" class="col-sm-3 control-label">手机：</label>
                            <div class="col-sm-7">
                                <input type="text" class="form-control" name="customer.phone" id="phone" readonly>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="app_arrive_time" class="col-sm-3 control-label">预约时间：</label>
                            <div class="col-sm-7">
                                <input type="text" class="form-control form_datetime" name="appointment.app_arrive_time" style="background:rgba(0, 0, 0, 0);" id="app_arrive_time" placeholder="请选择预约时间">
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                                <input type="button" class="btn btn-primary" onclick="appointment();" value="保存">
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

</div>
<%@include file="../../main/banquan.jsp" %>
</body>
<script src="<%=path%>/public/js/jquery.min.js"></script>
<script src="<%=path%>/public/js/bootstrap.min.js"></script>
<script src="<%=path %>/public/admin/js/bootstrap-datetimepicker.js"></script>
<script src="<%=path %>/public/admin/js/bootstrap-datetimepicker.zh-CN.js"></script>
<script src="<%=path %>/layer-v3.1.0/layer/layer.js"></script>
<script src="<%=path%>/index/js/index.js"></script>
<script src="<%=path%>/public/agency/js/jquery-validate.js"></script>
<script type="text/javascript">
    $('.form_datetime').datetimepicker({
        language: 'zh-CN',
        format: 'yyyy-mm-dd hh:ii',
        weekStart: 1,
        todayBtn: 1,
        autoclose: 1,
        todayHighlight: 1,
        startView: 2,
        minView: 2,
        forceParse: 0
    });
    $('#app_arrive_time').datetimepicker('setStartDate', new Date);//让时间只能选择当天时间以后的时间
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
        app.controller('myCtrl', function ($scope, $http, $timeout,$filter) {

            $http({
                method: 'POST',
                url: $("#path").val()+"/user/queryUser"
            }).then(function successCallback(response) {
                $scope.user = response.data.user;
            }, function errorCallback(response) {
            });

            $scope.total = 0;
            $scope.totalPageSize = 0;
            $scope.count1 = 1;
            extracted($scope.count1);

            // 显示广告
            $http({
                method: 'POST',
                url: "<%=path%>/ads/adsShow",
                data: {"beginNum": 24, "endNum": 24}
            }).then(function successCallback(response) {
                $scope.ads = response.data.adsList;
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

            function extracted(x) {
                var buildingsId = GetQueryString("buildingsId");
                $http({
                    method: 'POST',
                    url: "<%=path%>/employee/indexEmployee?buildings_id=" + buildingsId,
                    data: {"pageNo": x}
                }).then(function successCallback(response) {
                    $scope.total = response.data.employeePager.total;
                    $scope.totalPageSize = response.data.employeePager.totalPageSize;
                    $scope.employee = response.data.employeePager.result;
                    $scope.count1 = response.data.employeePager.pageNo;
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

            //登入时客户的预约
            $scope.appointment = function (x) {
                $("#myModal2").modal("show");
                $("#emp_id").val($scope.employee[x].id);
                $("#emp_name").val($scope.employee[x].name);
                $("#gender").val($scope.employee[x].gender);
                $("#phone").val($scope.employee[x].phone);
                $("#agency_id").val($scope.employee[x].agencyPrice.id);
            };

            //未登入时客户的预约提示，提示用户登入
            $scope.notAppointment = function () {
                layer.ready(function(){
                    layer.open({
                        type: 2,
                        title: '登入',
                        maxmin: true,
                        area: ['800px', '500px'],
                        content: $("#path").val()+'/index/indexlogin?url='+window.location.href,
                        cancel: function(){
                            //关闭当前窗口时就进入此方法
                        }
                    });
                });
            };

        });
    }(jQuery));
</script>
<script>
    $(function(){
        $("#register-form").validate();

        //预约时间
        $("#app_arrive_time").rules('add',{
            required:true,
            messages:{
                required:'请输入预约时间'
            }
        });
    });
</script>
<script>
    function appointment() {
        if ($("#register-form").valid()==true) {
            $.post("<%=path %>/appointment/appoint",
                $("#register-form").serialize(),
                function (data) {
                    if (data.result.result == "success") {
                        layer.alert("预约成功", {
                            skin: 'layui-layer-lan' //样式类名
                            , closeBtn: 0
                        }, function () {
                            window.location.reload();
                        });
                    } else {
                        layer.msg("你已经预约过了！");
                    }
                }, "json"
            );
        }
    }
</script>
</html>
