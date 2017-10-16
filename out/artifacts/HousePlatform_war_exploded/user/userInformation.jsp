
<%--
  Created by IntelliJ IDEA.
  User: ID.LQF
  Date: 2017/8/29
  Time: 8:44
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
    <title>首页</title>
    <link type="text/css" rel="stylesheet" href="<%=path %>/public/css/bootstrap.min.css">
    <link href="<%=path%>/public/css/bootstrap-fileinput.css" rel="stylesheet">
    <script src="<%=path%>/public/angular/angular.min.js"></script>
    <style>
        .error{
            color:red;
        }
    </style>
</head>
<body ng-app="myApp" ng-controller="myCtrl">
<div class="container">
<input type="hidden" id="path" value="<%=path%>">
<form class="form-horizontal " id="register-form" enctype='multipart/form-data'>
    <div class="form-group">
        <div class="col-sm-2 col-sm-offset-2 ">
            <input type="button" id="btn" class="btn btn-primary btn-lg btn-block"  ng-click="save($event)" value="编辑资料">
        </div>
    </div>
    <input type="hidden" name="user.headicon" value="{{user.headicon}}">
    <div class="form-group" style="margin-top: 20px;">
        <label class="col-sm-2 control-label">头像：</label>
        <div class="fileinput fileinput-new col-sm-7" data-provides="fileinput"  id="exampleInputUpload">
            <div class="fileinput-new thumbnail" style="width: 500px;height: auto;max-height:500px;">
                <img id='picImg' style="width: 100%;height: auto;max-height: 500px;" src="<%=path%>/{{user.headicon}}" alt="" />
            </div>
            <div class="fileinput-preview fileinput-exists thumbnail" style="max-width: 500px; max-height: 500px;"></div>
            <div id="imgs"  class="hidden">
                <span class="btn btn-primary btn-file ">
                    <span class="fileinput-new  ">选择文件</span>
                    <span class="fileinput-exists ">换一张</span>
                    <input  class="form-control " type="file" name="upload" id="picID" accept="image/gif,image/jpeg,image/x-png"/>
                </span>
                <a href="javascript:;" class="btn btn-warning fileinput-exists " data-dismiss="fileinput" >移除</a>
            </div>
        </div>
    </div>
    <div class="form-group">
    <label for="name" class="col-sm-2 control-label">姓名：</label>
    <div class="col-sm-7">
        <input type="text" class="form-control" id="name" name="user.name" style="background:rgba(0, 0, 0, 0);" value="{{user.name}}" disabled="disabled">
    </div>
    </div>
    <div class="form-group">
        <label for="nickname" class="col-sm-2 control-label">昵称：</label>
        <div class="col-sm-7">
            <input type="text" class="form-control" id="nickname" name="user.nickname" style="background:rgba(0, 0, 0, 0);" value="{{user.nickname}}" disabled="disabled">
        </div>
    </div>

    <div class="form-group">
        <label for="gender" class="col-sm-2 control-label">性别：</label>
        <div class="col-sm-7">
            <select class="form-control" name="user.gender" id="gender" style="background:rgba(0, 0, 0, 0);" disabled="disabled">
                <option value="男">男</option>
                <option value="女">女</option>
            </select>
        </div>
    </div>
    <div class="form-group">
        <label for="email1" class="col-sm-2 control-label">邮箱：</label>
        <div class="col-sm-7">
            <input type="email" class="form-control" id="email1" name="user.email" style="background:rgba(0, 0, 0, 0);" value="{{user.email}}" disabled="disabled" readonly>
        </div>
    </div>
    <div class="form-group">
        <label for="phone" class="col-sm-2 control-label">手机：</label>
        <div class="col-sm-7">
            <input type="text" class="form-control" id="phone" name="user.phone" style="background:rgba(0, 0, 0, 0);" value="{{user.phone}}" disabled="disabled">
        </div>
    </div>
    <div class="form-group">
        <label for="qq" class="col-sm-2 control-label">Q Q：</label>
        <div class="col-sm-7">
            <input type="text" class="form-control" id="qq" name="user.qq" style="background:rgba(0, 0, 0, 0);" value="{{user.qq}}" disabled="disabled">
        </div>
    </div>
    <div class="form-group">
        <label for="wechat" class="col-sm-2 control-label">微信号：</label>
        <div class="col-sm-7">
            <input type="text" class="form-control" id="wechat" name="user.wechat" style="background:rgba(0, 0, 0, 0);" value="{{user.wechat}}" disabled="disabled">
        </div>
    </div>

    <div class="form-group">
        <div class="col-sm-2 col-sm-offset-2 hidden" id="submit" >
            <input type="button" class="btn btn-primary btn-lg btn-block"  ng-click="submit($event)" <%--onclick="save();"--%> value="保存">
        </div>
    </div>
</form>
</div>
</body>
<script src="<%=path %>/public/js/jquery.min.js"></script>
<script src="<%=path %>/public/js/bootstrap.min.js"></script>
<script src="<%=path%>/public/jquery-from/jquery-from.js"></script>
<script src="<%=path %>/public/lightbox2-master/js/lightbox.min.js"></script>
<script src="<%=path%>/public/js/bootstrap-fileinput.js"></script>
<script src="<%=path%>/public/agency/js/jquery-validate.js"></script>
<script src="<%=path%>/public/validate/validate.js"></script>
<script>
    (function($){
        $(".form-control").prop("disabled",true);
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
            $http({
                method: 'POST',
                url: "<%=path%>/user/informationJson"
            }).then(function successCallback(response) {
                $scope.user = response.data.user;
                $timeout(function(){
                    $("#gender").val($scope.user.gender);
                },200);

            }, function errorCallback(response) {

            });

            $scope.save = function ($event) {
                if ($("#register-form").valid()==true) {
                    if(($(".form-control").prop("disabled"))==true){
                        $("#imgs").removeClass("hidden");
                        $(".form-control").prop("disabled",false);
                        $($event.target).val("取消编辑");
                        $("#submit").removeClass("hidden");
                    }else {
                        $("#imgs").addClass("hidden");
                        $("#submit").addClass("hidden");
                        $(".form-control").prop("disabled",true);
                        $($event.target).val("编辑资料");
                    }
                }
            };
            $scope.submit =  function($event) {
                if ($("#register-form").valid()==true) {//校验通过则返回true,不通过则false：
                    $('#register-form').ajaxSubmit({
                        url: '<%=path %>/user/save',
                        type: 'POST',
                        data: $("#register-form").serialize(),
                        success: function (data) {
                            $timeout(function(){//用jquery时不会自动渲染，只能手动渲染就调用此方法,
                                $scope.user = data.user;
                                $("#gender").val(data.user.gender);
                                $("#submit").addClass("hidden");
                                $("#imgs").addClass("hidden");
                                $(".form-control").prop("disabled",true);
                                $("#btn").val("编辑资料");
                            },0);
                        }
                    });
                }
            };
        });
    }(jQuery));
</script>
</html>
