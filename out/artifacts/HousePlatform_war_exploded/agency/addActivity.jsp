<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: yao
  Date: 2017/8/31
  Time: 15:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html><html>
<head>
    <title>添加活动</title>
</head>
<%
    String path = request.getContextPath();
%>
<link href="<%=path%>/public/css/bootstrap.min.css" rel="stylesheet">
<link type="text/css" rel="stylesheet" href="<%=path%>/public/jedate/skin/jedate.css">
<link href="<%=path%>/public/css/bootstrap-fileinput.css" rel="stylesheet">
<link href="<%=path%>/public/admin/css/bootstrap-datetimepicker.css" rel="stylesheet">
<script src="<%=path%>/public/angular/angular.min.js"></script>
<style type="text/css" >
    .error{
        color:red;
    }
</style>
<body ng-app="myApp" >
<input type="hidden" id="path" value="<%=path%>">
<div class="container" ng-controller="myCtrl">
    <div class=" row">
        <div class="col-lg-8 col-lg-offset-2  col-xs-12 col-md-10 col-md-offset-1   col-sm-12">
            <form class="form-horizontal"  id ="register-form" method="post" enctype="multipart/form-data">
                <input type="hidden" name="agency.id" value="${agency.id}">
                <div class="form-group" style="margin-top: 20px;">
                    <label class="col-sm-2 control-label">活动海报：</label>
                    <div class="fileinput fileinput-new col-sm-7" data-provides="fileinput"  id="exampleInputUpload">
                        <div class="fileinput-new thumbnail" style="width: 500px;height: auto;max-height:500px;">
                            <img id='picImg' style="width: 100%;height: auto;max-height: 500px;" src="<%=path%>/public/img/noimage.png" alt="" />
                        </div>
                        <div class="fileinput-preview fileinput-exists thumbnail" style="max-width: 500px; max-height: 500px;"></div>
                        <div >
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
                    <label for="title" class="col-sm-2  control-label">活动标题:</label>
                    <div class="col-sm-7  input-parent">
                        <input type="text" class="form-control" id="title" name="activity.title"  placeholder="请输入标题">
                        <span id="titleError" style="color:red;"></span><br/>
                    </div>
                </div>
                <div class="form-group">
                    <label for="district" class="col-sm-2 control-label">所属楼盘：</label>
                    <div class="col-sm-7">
                        <select class="form-control" id="district" name="buildingsPrice.id">
                            <option ng-repeat="bui in buildingsPriceList"    value="{{bui.id}}">{{bui.name}}</option>
                        </select><br/>
                    </div>
                </div>
                <div class="form-group">
                    <label for="start_time1" class="col-sm-2  control-label">开始时间:</label>
                    <div class="col-sm-7  input-parent">
                        <input size="16" type="text" class="form-control form_datetime"  id="start_time1" name="activity.start_time"style="background-color: white"   readonly ><br/>
                    </div>
                </div>
                <div class="form-group">
                    <label for="end_time1" class="col-sm-2  control-label">结束时间:</label>
                    <div class="col-sm-7  input-parent">
                            <input size="16" type="text" class="form-control form_datetime"  id="end_time1" name="activity.end_time"style="background-color: white"   readonly ><br/>
                    </div>
                </div>
                <div class="form-group">
                    <label for="content" class="col-sm-2 control-label">活动内容：</label>
                    <div class="col-sm-7">
                        <textarea  rows="5" class="form-control" id="content" name="activity.content"  ></textarea>
                    </div>
                </div>
                <div class="form-group">
                    <label for="address" class="col-sm-2  control-label">活动地址：</label>
                    <div class="col-sm-7  input-parent">
                        <input type="text" class="form-control" id="address" name="activity.address" placeholder="请输入活动地址"><br/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-2 col-sm-offset-2 " id="submit" >
                        <input type="button" class="btn btn-primary btn-lg btn-block"  ng-click="submit()" value="添加">
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
<script src="<%=path%>/public/js/jquery.min.js"></script>
<script src="<%=path%>/public/jquery-from/jquery-from.js"></script>
<script src="<%=path%>/public/js/bootstrap.min.js"></script>
<script src="<%=path%>/public/js/bootstrap-fileinput.js"></script>
<script src="<%=path %>/public/admin/js/bootstrap-datetimepicker.js"></script>
<script src="<%=path %>/public/admin/js/bootstrap-datetimepicker.zh-CN.js"></script>
<script src="<%=path%>/public/agency/js/jquery-validate.js"></script>
<script src="<%=path %>/layer-v3.1.0/layer/layer.js"></script>
<script src="<%=path%>/public/js/bootstrus-date-from.js"></script>
<script type="text/javascript">
    $(function(){
        $("#register-form").validate();
        //地址验证
        $("#address").rules('add',{
            maxlength:100,
            required:true,
            messages:{
                maxlength:'输入的信息不能超过100个字符',
                required:"请输入你的活动地址"
            }
        });
        //活动内容验证
        $("#content").rules('add',{
            maxlength:498,
            messages:{
                maxlength:'输入的信息不能超过500个字符'
            }
        });
        //验证标题
        $("#title").rules('add',{
            maxlength:20,
            required:true,
            messages:{
                maxlength:'名称长度不能超过{0}位！',
                required:'请输入活动名'
            }
        });

        //时间
        $("#end_time1").rules('add',{
            required:true,
            messages:{
                required:'请选择时间，如1993-03-29！',
            }
        });
        //时间
        $("#start_time1").rules('add',{
            required:true,
            messages:{
                required:'请选择时间，如1993-03-29！',
            }
        });
    });
</script>
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
            $http({
                method: 'POST',
                url: "<%=path%>/buildings/queryBuildingsPrice"
            }).then(function successCallback(response) {
                $scope.buildingsPriceList = response.data.buildingsPriceList;
            }, function errorCallback(response) {

            });
            $scope.submit = function () {
                if ($("#register-form").valid()==true) {
                    if( $scope.buildingsPriceList!=null&&$scope.buildingsPriceList!=''&&$scope.buildingsPriceList!=undefined){
                        var index = layer.load(0, {shade: false});//发送请求时让页面出现加载样式
                        $("#register-form").ajaxSubmit({
                            type: 'post',
                            url: '<%=path %>/activity/addActivity',
                            dataType : 'json',
                            data:$("#register-form").serialize(),
                            success: function(data) {
                                layer.close(index);//关闭加载窗口
                                if(data.controllerResult.result =='success'){
                                    layer.alert(data.controllerResult.msg, {
                                        skin: 'layui-layer-lan' //样式类名
                                        ,closeBtn: 0
                                    }, function(){
                                        window.location.reload();
                                    });
                                } else{
                                    swal(data.controllerResult.msg);
                                }
                            }
                        });
                    }else {
                        layer.ready(function(){
                            layer.open({
                                type: 2,
                                title: '请最少添加一个楼盘才可添加楼栋',
                                maxmin: true,
                                area: ['800px', '500px'],
                                content: '<%=path%>/buildings/addbuildingspage?url=activity/addAgencyActivity',
                                cancel: function(){
                                    //关闭当前窗口时就进入此方法
                                }
                            });
                        });
                    }
                }
            }
        });
    }(jQuery));
</script>

</html>
