
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

<input type="hidden" id="path" value="<%=path%>">
<form class="form-horizontal " id="register-form" enctype='multipart/form-data'>
    <div class="form-group">
        <div class="col-sm-2 col-sm-offset-2 ">
            <input type="button" id="btn" class="btn btn-primary btn-lg btn-block"  ng-click="save($event)" value="编辑资料">
        </div>
    </div>
    <input type="hidden" name="employee.headicon" value="{{employee.headicon}}">
    <div class="form-group" style="margin-top: 20px;">
        <label class="col-sm-2 control-label">头像：</label>
        <div class="fileinput fileinput-new col-sm-7" data-provides="fileinput"  id="exampleInputUpload">
            <div class="fileinput-new thumbnail" style="width: 500px;height: auto;max-height:500px;">
                <img id='picImg' style="width: 100%;height: auto;max-height: 500px;" src="<%=path%>/{{employee.headicon}}" alt="" />
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
        <label for="inputName3" class="col-sm-2 control-label">昵称：</label>
        <div class="col-sm-7">
            <input type="text" class="form-control" id="inputName3" name="employee.name" style="background:rgba(0, 0, 0, 0);" value="{{employee.name}}" disabled="disabled">
        </div>
    </div>
    <div class="form-group">
        <label for="gender" class="col-sm-2 control-label">性别：</label>
        <div class="col-sm-7">
            <select class="form-control" name="employee.gender" id="gender" style="background:rgba(0, 0, 0, 0);" disabled="disabled">
                <option value="男">男</option>
                <option value="女">女</option>
            </select>
        </div>
    </div>
    <div class="form-group">
        <label for="email1" class="col-sm-2 control-label">邮箱：</label>
        <div class="col-sm-7">
            <input type="email" class="form-control" id="email1" name="employee.email" style="background:rgba(0, 0, 0, 0);" value="{{employee.email}}" disabled="disabled" readonly>
        </div>
    </div>
    <div class="form-group">
        <label for="phone" class="col-sm-2 control-label">手机：</label>
        <div class="col-sm-7">
            <input type="text" class="form-control" id="phone" name="employee.phone" style="background:rgba(0, 0, 0, 0);" value="{{employee.phone}}" disabled="disabled">
        </div>
    </div>
    <div class="form-group">
        <label for="qq" class="col-sm-2 control-label">Q Q：</label>
        <div class="col-sm-7">
            <input type="text" class="form-control" id="qq" name="employee.qq" style="background:rgba(0, 0, 0, 0);" value="{{employee.qq}}" disabled="disabled">
        </div>
    </div>
    <div class="form-group">
        <label for="wechat" class="col-sm-2 control-label">微信号：</label>
        <div class="col-sm-7">
            <input type="text" class="form-control" id="wechat" name="employee.wechat" style="background:rgba(0, 0, 0, 0);" value="{{employee.wechat}}" disabled="disabled">
        </div>
    </div>
    <div class="form-group">
        <label for="basic_salary" class="col-sm-2 control-label">工资：</label>
        <div class="col-sm-7">
            <input type="text" class="form-control" id="basic_salary" name="employee.basic_salary" style="background:rgba(0, 0, 0, 0);" value="{{employee.basic_salary}}" disabled="disabled">
        </div>
    </div>
    <div class="form-group">
        <label for="address" class="col-sm-2 control-label">地址：</label>
        <div class="col-sm-7">
            <input type="text" class="form-control" id="address" name="employee.address" style="background:rgba(0, 0, 0, 0);" value="{{employee.address}}" disabled="disabled">
        </div>
    </div>
    <div class="form-group">
        <label for="intro" class="col-sm-2 control-label">简介：</label>
        <div class="col-sm-7">
            <textarea class="form-control" rows="3" id="intro" name="employee.intro" style="background:rgba(0, 0, 0, 0);" value="{{employee.intro}}" disabled="disabled">{{employee.intro}}</textarea>
        </div>
    </div>
    <div class="form-group">
        <label for="exp" class="col-sm-2 control-label">工作经验：</label>
        <div class="col-sm-7">
            <textarea class="form-control" rows="3" id="exp" name="employee.exp" style="background:rgba(0, 0, 0, 0);" value="{{employee.exp}}" disabled="disabled">{{employee.exp}}</textarea>
        </div>
    </div>
    <div class="form-group">
        <label for="des" class="col-sm-2 control-label">个人描述：</label>
        <div class="col-sm-7">
            <textarea class="form-control" rows="3" id="des" name="employee.des" style="background:rgba(0, 0, 0, 0);" value="{{employee.des}}" disabled="disabled">{{employee.des}}</textarea>
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-2 col-sm-offset-2 hidden" id="submit" >
            <input type="button" class="btn btn-primary btn-lg btn-block"  ng-click="submit($event)" value="保存">
        </div>
    </div>
</form>

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
                url: "<%=path%>/staff/staffCenterJson"
            }).then(function successCallback(response) {
                $scope.employee = response.data.employee;
                $timeout(function(){
                    $("#gender").val($scope.employee.gender);
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
                        url: '<%=path %>/staff/save',
                        type: 'POST',
                        data: $("#register-form").serialize(),
                        success: function (data) {
                            $timeout(function(){//用jquery时不会自动渲染，只能手动渲染就调用此方法,
                                $scope.employee = data.employee;
//                                $("#gender").val(data.employee.gender);
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
