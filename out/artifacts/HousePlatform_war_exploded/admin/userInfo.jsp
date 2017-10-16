<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="table table-responsive container">
                        <table class="table table-striped" id="myTable">
                            <thead>
                            <th colspan="7">
                                <button type="button" class="btn btn-primary" onclick="changeYes()">激活</button>
                                <button type="button" class="btn btn-primary" onclick="changeNo();">冻结</button>
                                <button type="button" class="btn btn-primary" data-toggle="modal"
                                        ng-click="onclickbtn($index);">查看详情
                                </button>
                            </th>
                            <td>
                                <button class="btn btn-primary" onclick="window.location.reload(true);">刷新</button>
                            </td>
                            </thead>
                            <tr>
                                <th><input type="checkbox"></th>
                                <th>邮箱</th>
                                <th>电话</th>
                                <th>微信号</th>
                                <th>昵称</th>
                                <th>姓名</th>
                                <th>性别</th>
                                <th>状态</th>
                            </tr>
                            <tbody>
                            <tr ng-repeat="u in users">
                                <td>
                                    <input type="checkbox" title="{{$index}}" name="userId" id="userId"
                                           value="{{u.id}}"/>
                                </td>
                                <td>{{u.email}}</td>
                                <td>{{u.phone}}</td>
                                <td>{{u.wechat}}</td>
                                <td>{{u.nickname}}</td>
                                <td>{{u.name}}</td>
                                <td>{{u.gender}}</td>
                                <td>
                                    <span ng-show="{{u.status == '1' }}">已激活</span>

                                    <span ng-show="{{u.status == '0' }}" style="color:red;">已冻结</span>
                                </td>
                            </tr>
                            </tbody>
                        </table>

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

    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">用户详情</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label class="col-sm-2  control-label">邮箱:</label>
                        <div class="col-sm-10  input-parent">
                            <p id="email"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2  control-label">微信号:</label>
                        <div class="col-sm-10  input-parent">
                            <p id="wechat"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2  control-label">昵称:</label>
                        <div class="col-sm-10  input-parent">
                            <p id="nickname"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2  control-label">姓名:</label>
                        <div class="col-sm-10  input-parent">
                            <p id="name"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2  control-label">性别:</label>
                        <div class="col-sm-10  input-parent">
                            <p id="gender"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2  control-label">生日:</label>
                        <div class="col-sm-10  input-parent">
                            <p id="birthday"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2  control-label">电话:</label>
                        <div class="col-sm-10  input-parent">
                            <p id="phone"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2  control-label">qq:</label>
                        <div class="col-sm-10  input-parent">
                            <p id="qq"></p>
                        </div>
                    </div>
                </div>
                <div class="modal-footer" style="border-top: 0px solid #e5e5e5;">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>
</div>
<form action="" method="post" id="formid">
    <input type="hidden" name="userId" id="checkedIds"/>
    <input type="hidden" name="user.status" id="status"/>
</form>
</body>
<script src="<%=path%>/public/js/jquery.min.js"></script>
<script src="<%=path%>/public/js/bootstrap.min.js"></script>
<script src="<%=path %>/public/admin/js/tableCheckbox.js"></script>
<script src="<%=path %>/layer-v3.1.0/layer/layer.js"></script>
<script type="text/javascript">

    $("#myTable").tableCheck("warning");

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
            $scope.users = "";
            $scope.count1 = 1;
            extracted($scope.count1);

            function extracted(x) {
                $http({
                    method: 'POST',
                    url: "<%=path%>/user/userAlljson",
                    data: {"pageNo": x}
                }).then(function successCallback(response) {
                    $scope.total = response.data.userPager.total;
                    $scope.totalPageSize = response.data.userPager.totalPageSize;
                    $scope.users = response.data.userPager.result;
                    $scope.count1 = response.data.userPager.pageNo;
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

            $scope.onclickbtn = function (x) {//根据传进来的数字来取集合的数据
                if ($("input[name='userId']:checkbox:checked").length == 1) {
                    $("#myModal").modal("show");
                    $scope.count = $("input[name='userId']:checkbox:checked").attr("title");
                    $("#id").text($scope.users[$scope.count].id);
                    $("#email").text($scope.users[$scope.count].email);
                    $("#wechat").text($scope.users[$scope.count].wechat);
                    $("#nickname").text($scope.users[$scope.count].nickname);
                    $("#name").text($scope.users[$scope.count].name);
                    $("#gender").text($scope.users[$scope.count].gender);
                    $("#birthday").text($scope.users[$scope.count].birthday);
                    $("#phone").text($scope.users[$scope.count].phone);
                    $("#qq").text($scope.users[$scope.count].qq);
                } else {
                    layer.msg("请选择一行！");
                }
            };
        });
    }(jQuery));

    function changeYes() { // 冻结用户
        var chk_value = [];
        $('input[name="userId"]:checked').each(function () {
            chk_value.push($(this).val());
        });
        if (chk_value.length == 0) {
            layer.msg("请选择一行!");
        } else {
            $('#checkedIds').val(chk_value);
            $('#status').val(0);
            layer.alert('激活成功！', {
                skin: 'layui-layer-lan' //样式类名
                , closeBtn: 0
            }, function () {
                $('#formid').prop("action", "<%=path %>/user/status").submit();
            });
        }
    }

    function changeNo() { // 激活用户
        var chk_value = [];
        $('input[name="userId"]:checked').each(function () {
            chk_value.push($(this).val());
        });
        if (chk_value.length == 0) {
            layer.msg("请选择一行!")
        } else {
            $('#checkedIds').val(chk_value);
            $('#status').val(1);
            layer.alert('冻结成功！', {
                skin: 'layui-layer-lan' //样式类名
                , closeBtn: 0
            }, function () {
                $('#formid').prop("action", "<%=path %>/user/status").submit();
            });
        }
    }
</script>
</html>

