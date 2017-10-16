<%--
  Created by IntelliJ IDEA.
  User: ID.LQF
  Date: 2017/9/8
  Time: 14:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String path = request.getContextPath();
%><!DOCTYPE html>
<html>
<head>
    <title>购房预约信息查看</title>
    <link href="<%=path %>/public/css/bootstrap.min14ed.css?v=3.3.6" rel="stylesheet">
    <link href="<%=path%>/public/css/style.min862f.css?v=4.1.0" rel="stylesheet">
    <link href="<%=path%>/public/admin/css/admincheck.css" rel="stylesheet">
    <script src="<%=path %>/public/tanchuang/sweetalert-master/dist/sweetalert-dev.js"></script>
    <link rel="stylesheet" href="<%=path %>/public/tanchuang/sweetalert-master/dist/sweetalert.css">
    <script src="<%=path%>/public/angular/angular.min.js"></script>
    <style>
        .error{
            color:red;
        }
    </style>
</head>
<body ng-app="myApp">
<div ng-controller="myCtrl">
    <input type="hidden" id="path" value="<%=path%>">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class=" table table-responsive container">

                        <table class="table table-striped">
                            <thead>
                            <th colspan="7">
                                <button type="button" class="btn btn-primary" data-toggle="modal"  ng-click="appStatus($index);">预约修改</button>
                                <button type="button" class="btn btn-primary" onclick="changeYes();">激活</button>
                                <button type="button" class="btn btn-danger" onclick="changeNo();">冻结</button>
                            </th>
                            <th>
                                <button type="button" class="btn btn-primary"  onclick="history.go(0)">刷新</button>
                            </th>
                            </thead>
                            <tr>
                                <th style="width: 20px;"><input type="checkbox"/></th>
                                <th>用户名称</th>
                                <th>用户性别</th>
                                <th>用户电话</th>
                                <th>预约看房时间</th>
                                <th>实际看房时间</th>
                                <th>预约状态</th>
                                <th>状态</th>
                            </tr>
                            <tbody>
                            <tr ng-repeat="app in appointments">
                                <td>
                                    <input type="checkbox" title="{{$index}}" name="appointmentId" id="appointmentId" value="{{app.id}}"/>
                                </td>
                                <td>{{app.userPrice.name}}</td>
                                <td>{{app.userPrice.gender }}</td>
                                <td>{{app.userPrice.phone}}</td>
                                <td>{{app.app_arrive_time | date:'yyyy-MM-dd hh:mm'}}</td>
                                <td>{{app.arrive_time | date:'yyyy-MM-dd hh:mm'}}</td>
                                <td>
                                    <span style="color:#2dc25e;" ng-show="{{app.app_status == '1' }}">已预约</span>
                                    <span style="color:#2122ff;" ng-show="{{app.app_status == '2' }}">已联系</span>
                                    <span style="color:#19e9ff;" ng-show="{{app.app_status == '3' }}">已看房</span>
                                    <span style="color:red;" ng-show="{{app.app_status == '4' }}">已购房</span>
                                </td>
                                <td>
                                    <div>
                                        <span style="color:red;" ng-show="{{app.status=='0'}}">已冻结</span>
                                        <span style="color:#2dc25e;" ng-show="{{app.status=='1'}}">已激活</span>
                                    </div>
                                </td>
                            </tr>
                            <tbody>
                        </table>

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
                        <li ng-click="top()"><a>«</a></li>
                        <li><a class="page" ng-show="count1>=5 " ng-click="page(count1-4)">{{count1-4}}</a></li>
                        <li><a class="page" ng-show="count1>=4 " ng-click="page(count1-3)">{{count1-3}}</a></li>
                        <li><a class="page" ng-show="count1>=3 " ng-click="page(count1-2)">{{count1-2}}</a></li>
                        <li><a class="page" ng-show="count1>=2 " ng-click="page(count1-1)">{{count1-1}}</a></li>
                        <li class="active"><a class="page" ng-show="count1>0" ng-click="page(count1)" title="{{count1}}">{{count1}}</a></li>
                        <li><a class="page" ng-show="count1>0 && totalPageSize-1>= count1" ng-click="page(count1+1)">{{count1+1}}</a>
                        </li>
                        <li><a class="page" ng-show="count1>0 && (totalPageSize-2) >= count1" ng-click="page(count1+2)">{{count1+2}}</a>
                        </li>
                        <li><a class="page" ng-show="count1<3 && (totalPageSize-3) >= count1" ng-click="page(count1+3)">{{count1+3}}</a>
                        </li>
                        <li><a class="page" ng-show="count1<2 && (totalPageSize-4) >= count1" ng-click="page(count1+4)">{{count1+4}}</a>
                        </li>
                        <li ng-click="down()"><a>»</a></li>
                    </ul>
                </nav>
            </div>
        </div>

        <!--修改预约状态的模态框-->
        <div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel2">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel2">修改预约状态</h4>
                    </div>
                    <div class="modal-body">
                        <form class="form-horizontal" id="register-form" method="post">
                            <input type="hidden" id="id1" name="appointment.id">
                            <div class="form-group">
                                <label for="arrive_time" class="col-sm-3 control-label">实际看房时间：</label>
                                <div class="col-sm-7">
                                    <input type="text" class="form-control form_datetime" name="appointment.arrive_time" id="arrive_time">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="app_status" class="col-sm-3 control-label">预约状态：</label>
                                <div class="col-sm-7">
                                    <select class="form-control" style="list-style: none;" id="app_status" name="appointment.app_status">
                                        <option value="1">已预约</option>
                                        <option value="2">已联系</option>
                                        <option value="3">已看房</option>
                                        <option value="4">已购房</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                                    <input type="button" class="btn btn-primary" onclick="appointmentStatus();" value="保存">
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

<form method="post" id="formid">
    <input type="hidden" name="appointment.id" id="checkedIds"/>
    <input type="hidden" name="appointment.status" id="status"/>
</form>

<script src="<%=path %>/public/js/jquery.min.js?v=2.1.4"></script>
<script src="<%=path %>/public/js/bootstrap.min.js?v=3.3.6"></script>
<script src="<%=path %>/public/js/plugins/peity/jquery.peity.min.js"></script>
<script src="<%=path %>/public/js/content.min.js?v=1.0.0"></script>
<script src="<%=path %>/public/js/plugins/iCheck/icheck.min.js"></script>
<script src="<%=path %>/public/js/demo/peity-demo.min.js"></script>
<script src="<%=path %>/layer-v3.1.0/layer/layer.js"></script>
<script src="<%=path %>/public/admin/js/bootstrap-datetimepicker.js"></script>
<script src="<%=path %>/public/admin/js/bootstrap-datetimepicker.zh-CN.js"></script>
<script>
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

            $scope.total = 0;
            $scope.totalPageSize = 0;
            $scope.appointments = "";
            $scope.count1 = 1;
            extracted($scope.count1);
            $scope.dt1 = new Date();
            $scope.dt2 = $filter("date")($scope.dt1, "yyyy-MM-dd HH:mm:ss");

            function extracted(x) {
                $http({
                    method: 'POST',
                    url: "<%=path%>/staff/appointmentJson",
                    data: {"pageNo": x}
                }).then(function successCallback(response) {
                    $scope.appointments = response.data.appPager.result;
                    $scope.total = response.data.appPager.total;
                    $scope.totalPageSize = response.data.appPager.totalPageSize;
                    $scope.count1 = response.data.appPager.pageNo;
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

            //修改预约状态
            $scope.appStatus = function (x) {
                if($("input[name='appointmentId']:checkbox:checked").length == 1) {
                    $("#myModal2").modal("show");
                    $scope.count=$("input[name='appointmentId']:checkbox:checked").attr("title");
                    $scope.arrive_time =  $filter("date")($scope.appointments[$scope.count].arrive_time, "yyyy-MM-dd HH:mm:ss");
                    $("#id1").val($scope.appointments[$scope.count].id);
                    $("#app_status").val($scope.appointments[$scope.count].app_status);
                    $("#arrive_time").val($scope.appointments[$scope.count].arrive_time);
                } else {
                    layer.msg("请选择一行!");
                }
            };

        });

    }(jQuery));

    function changeYes() { // 只能激活用户，判断等页面完成
        var chk_value = [];
        $('input[name="appointmentId"]:checked').each(function () {
            chk_value.push($(this).val());
        });
        if (chk_value.length == 0) {
            layer.msg("请选择一行!");
        } else {
            $('#checkedIds').val(chk_value);
            $('#status').val(0);
            $('#formid').prop("action", "<%=path %>/cus/appStatus").submit();
        }
    }

    function changeNo() { // 只能冻结用户，判断等页面完成
        var chk_value =[];
        $('input[name="appointmentId"]:checked').each(function(){
            chk_value.push($(this).val());
        });
        if(chk_value.length == 0) {
            layer.msg("请选择一行!");
        } else{
            $('#checkedIds').val(chk_value);
            $('#status').val(1);
            $('#formid').prop("action", "<%=path %>/cus/appStatus").submit();
        }
    }

</script>
<script>
    $(function(){
        $("#register-form").validate();

        //预约时间
        $("#arrive_time").rules('add',{
            required:true,
            messages:{
                required:'请输入预约时间',
            }
        });
    });
</script>
<script>
    function appointmentStatus() {
        $.post("<%=path %>/appointment/appointmentStatus",
            $("#register-form").serialize(),
            function (data) {
                if (data.result.result == "success") {
                    window.location.href = "<%=path %>/staff/appointment";
                } else {
                    alert(data.result.msg);
                }
            }, "json"
        );
    }
</script>
</body>
</html>
