<%--
  Created by IntelliJ IDEA.
  User: CHEN JX
  Date: 2017/8/28
  Time: 20:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%><!DOCTYPE html>
<html>
<head>
    <title>经销商基本信息</title>
    <link type="text/css" rel="stylesheet" href="<%=path %>/public/css/bootstrap.min.css">

    <link type="text/css" rel="stylesheet" href="<%=path%>/public/lightbox2-master/css/lightbox.css" />
    <link href="<%=path%>/public/css/bootstrap-fileinput.css" rel="stylesheet">
    <script src="<%=path%>/public/angular/angular.min.js"></script>
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
    <div class="form-group" style="margin-top: 20px;">
        <label class="col-sm-2 control-label">logo：</label>
        <div class="fileinput fileinput-new col-sm-7" data-provides="fileinput"  id="exampleInputUpload">
            <div class="fileinput-new thumbnail" style="width: 500px;height: auto;max-height:500px;">
                <img id='picImg' style="width: 100%;height: auto;max-height: 500px;" src="<%=path%>/{{agency.logo}}" alt="" />
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
        <label for="username" class="col-sm-2 control-label">名字：</label>
        <div class="col-sm-7">
            <input type="text" class="form-control" id="username"  name="agency.name" value="{{agency.name}}" disabled="disabled">
        </div>
    </div>
    <div class="form-group">
        <label for="leader" class="col-sm-2 control-label">负责人：</label>
        <div class="col-sm-7">
            <input type="text" class="form-control" id="leader" name="agency.leader" value="{{agency.leader}}" disabled="disabled">
        </div>
    </div>
    <div class="form-group">
        <label for="phone" class="col-sm-2 control-label">手机号：</label>
        <div class="col-sm-7">
            <input type="text" class="form-control" id="phone" name="agency.phone" value="{{agency.phone}}" disabled="disabled">
        </div>
    </div>
    <div class="form-group">
        <label for="tel" class="col-sm-2 control-label">电话：</label>
        <div class="col-sm-7">
            <input type="text" class="form-control" id="tel" name="agency.tel" value="{{agency.tel}}" disabled="disabled">
        </div>
    </div>
    <div class="form-group">
        <label for="address" class="col-sm-2 control-label">地址：</label>
        <div class="col-sm-7">
            <input type="text" class="form-control" id="address" name="agency.address"  value="{{agency.address}}" disabled="disabled">
        </div>
    </div>
    <div class="form-group">
        <label for="intro" class="col-sm-2 control-label">简介：</label>
        <div class="col-sm-7">
            <textarea  rows="5" class="form-control" id="intro" name="agency.intro" disabled="disabled">{{agency.intro}}</textarea>
        </div>
    </div>
    <div class="form-group">
        <label  class="col-sm-4 control-label">公司入驻时间：</label>
        <div class="col-sm-7">
            <label  class="col-sm-4 control-label" >{{agency.created_time | date:"yyyy-MM-dd HH:mm:ss"}}</label>
        </div>
        <input type="hidden" name="agency.created_time" value='{{agency.created_time | date:"yyyy-MM-dd HH:mm:ss"}}'>
    </div>
    <div class="form-group">
        <div class="col-sm-2 col-sm-offset-2 hidden" id="submit" >
            <input type="button" class="btn btn-primary btn-lg btn-block"  ng-click="submit($event)" value="保存">
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
<style>
    .error{
        color:red;
    }
</style>
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
                url: "<%=path%>/agency/queryAgency"
            }).then(function successCallback(response) {
                $scope.agency = response.data.agency;
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
                        url: '<%=path %>/agency/updateAgency',
                        type: 'POST',
                        data: $("#register-form").serialize(),
                        success: function (data) {
                            $timeout(function(){//用jquery时不会自动渲染，只能手动渲染就调用此方法,
//                                if (data.result.result == "success") {
                                    $scope.agency = data.agency;
                                    $("#submit").addClass("hidden");
                                    $("#imgs").addClass("hidden");
                                    $(".form-control").prop("disabled",true);
                                    $("#btn").val("编辑资料");
//                                } else {
//                                    alert(data.result.msg);
//                                }
                            },0);
                        }
                    });
                }
            };
        });
    }(jQuery));
</script>
</html>
