<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: yao
  Date: 2017/8/31
  Time: 17:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%><!DOCTYPE html>
<html>
<head>
    <title>管理员信息</title>
    <link type="text/css" rel="stylesheet" href="<%=path %>/public/css/bootstrap.min.css">

    <link type="text/css" rel="stylesheet" href="<%=path%>/public/lightbox2-master/css/lightbox.css"/>
    <link href="<%=path%>/public/css/bootstrap-fileinput.css" rel="stylesheet">
    <script src="<%=path %>/public/tanchuang/sweetalert-master/dist/sweetalert-dev.js"></script>
    <link rel="stylesheet" href="<%=path %>/public/tanchuang/sweetalert-master/dist/sweetalert.css">
    <script src="<%=path%>/public/angular/angular.min.js"></script>
</head>
<body ng-app="myApp" ng-controller="myCtrl" class="container">
<form class="form-horizontal" id="form" method="post">
    <div class="form-group" style="margin-top: 25px;">
        <div class="col-sm-1 col-sm-offset-2 ">
            <input type="button" id="btn" class="btn btn-primary btn-lg btn-block" ng-click="save($event)" value="编辑资料"
                   style="width: 100px;"/>
        </div>
        <div class="col-sm-1">
            <button type="button" class="btn btn-primary btn-lg btn-block" data-toggle="modal" data-target="#myModal"
                    style="width: 100px;height: 46px;margin-left:20px;">修改密码
            </button>
        </div>
    </div>
    <div class="form-group" style="margin-top: 20px;">
        <label class="col-sm-4 control-label"></label>
        <div class="col-sm-5">
            <input type="hidden" class="form-control" name="admin.id" value="${admin.id}"/>
        </div>
    </div>
    <div class="form-group">
        <label for="name" class="col-sm-2 control-label">网站名：</label>
        <div class="col-sm-7">
            <input type="text" class="form-control" id="name" name="admin.name" value="{{admin.name}}"
                   disabled="disabled">
        </div>
    </div>
    <div class="form-group">
        <label for="email" class="col-sm-2 control-label">邮箱：</label>
        <div class="col-sm-7">
            <input type="text" class="form-control" id="email" name="admin.email" value="{{admin.email}}"
                   disabled="disabled">
        </div>
    </div>
    <div class="form-group">
        <label for="phone" class="col-sm-2 control-label">官方电话：</label>
        <div class="col-sm-7">
            <input type="text" class="form-control" id="phone" name="admin.phone" value="{{admin.phone}}" maxlength="11"
                   disabled="disabled">
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-2 col-sm-offset-2 hidden" id="submit">
            <input type="button" class="btn btn-primary btn-lg btn-block" ng-click="submit($event)" value="保存">
        </div>
    </div>
</form>

<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">修改密码</h4>
            </div>
            <div class="modal-body">
                <form id="pwdChange" method="post">
                    <input type="hidden" name="admin.id" value="{{admin.id}}"/>
                    <div class="form-group">
                        <label class="col-sm-2  control-label">原密码:</label>
                        <div class="col-sm-10  input-parent">
                            <input type="password" name="oldpwd" id="oldpwd" onchange="checkPwd();" placeholder="请输入密码" /><br/>
                        </div><br/>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2  control-label">新密码:</label>
                        <div class="col-sm-10  input-parent">
                            <input id="pwd" type="password" name="admin.pwd" placeholder="请输入密码" minlength="6"/>
                            <p id="errorPwd" style="color: red"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2  control-label">确认密码:</label>
                        <div class="col-sm-10  input-parent">
                            <input id="rePwd" type="password" placeholder="请输入确认密码" minlength="6"/>
                            <p id="errorRePwd" style="color: red"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2  control-label"></label>
                        <div class="col-sm-3  input-parent">
                            <input type="button" class="btn btn-primary" value="修改" onclick="changePwd();"/>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer" style="border-top: 0px solid #e5e5e5;">
                <button type="button" class="btn btn-primary" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>

</body>
<script src="<%=path %>/public/js/jquery.min.js"></script>
<script src="<%=path %>/public/js/bootstrap.min.js"></script>
<script src="<%=path%>/public/jquery-from/jquery-from.js"></script>
<script src="<%=path %>/public/lightbox2-master/js/lightbox.min.js"></script>
<script src="<%=path%>/public/js/bootstrap-fileinput.js"></script>
<script src="<%=path %>/layer-v3.1.0/layer/layer.js"></script>
<script>
    (function ($) {
        $(".form-control").prop("disabled", true);
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
                url: "<%=path%>/admin/queryInfo"
            }).then(function successCallback(response) {
                $scope.admin = response.data.admin;
            }, function errorCallback(response) {

            });

            $scope.save = function ($event) {
                if (($(".form-control").prop("disabled")) == true) {
                    $("#imgs").removeClass("hidden");
                    $(".form-control").prop("disabled", false);
                    $($event.target).val("取消编辑");
                    $("#submit").removeClass("hidden");
                } else {
                    $("#submit").addClass("hidden");
                    $(".form-control").prop("disabled", true);
                    $($event.target).val("编辑资料");
                }
            };
            $scope.submit = function ($event) {
                $('#form').ajaxSubmit({
                    url: '<%=path %>/admin/updateAdmin',
                    type: 'POST',
                    data: $("#form").serialize(),
                    success: function (data) {
                        $timeout(function () {//用jquery时不会自动渲染，只能手动渲染就调用此方法,
                            if (data.controllerResult.result == "success") {
                                $scope.admin = data.admin;
                                $("#submit").addClass("hidden");
                                $(".form-control").prop("disabled", true);
                                $("#btn").val("编辑资料");
                            } else {
                                layer.msg(data.controllerResult.msg);
                            }
                        }, 0);
                    }
                });
            };

        });
    }(jQuery));

    function checkPwd() {
        $.post("<%=path %>/admin/checkPwd?admin.id=${admin.id}",
            $("#oldpwd").serialize(),
            function (data) {
                if (data.controllerResult.result == 'success') {

                } else {
                    layer.msg("密码错误");
                    $("#oldpwd").val("");
                }
            }, 'json'
        );
    }

    $(document).ready(function () {
        $("#pwd").blur(function () {
            var pwd = $("#pwd").val();
            var errorPwd = $("#errorPwd");
            if (pwd.length <= 0) {
                errorPwd.text("密码不能为空，请输入密码");
            }
        });
    });
    $(document).ready(function () {
        $("#rePwd").blur(function () {
            var rePwd = $("#rePwd").val();
            var pwd = $("#pwd").val();
            var errorRePwd = $("#errorRePwd");
            if (rePwd.length <= 0) {
                errorRePwd.text("确认密码不能为空，请输入密码");
            } else if (rePwd != pwd) {
                errorRePwd.text("确认密码不正确，请重新输入");
            }
        });
    });
    function changePwd() {
        $.post("<%=path %>/admin/changePwd",
            $("#pwdChange").serialize(),
            function (data) {
                if (data.controllerResult.result == 'success') {
                    window.location.reload(true);
                }
            }, 'json'
        );
    }

</script>
</html>
