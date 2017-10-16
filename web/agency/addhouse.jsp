<%--
  Created by IntelliJ IDEA.
  User: CMY
  Date: 2017/9/6
  Time: 10:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
    <title>添加户型</title>
</head>
<link rel="stylesheet" href="<%=path %>/public/css/bootstrap.min.css">
<link href="<%=path%>/public/css/bootstrap-fileinput.css" rel="stylesheet">
<script src="<%=path%>/public/angular/angular.min.js"></script>
<link rel="stylesheet" href="<%=path%>/public/loading/css/loading.css">
<link rel="stylesheet" href="<%=path%>/public/loading/css/global.css">
<style type="text/css" >
    .error{
        color:red;
    }
</style>
<body ng-app="myApp" >
<input type="hidden" id="path" value="<%=path%>">
<div class="container" ng-controller="myCtrl">
<form class="form-horizontal"  id="register-form" enctype='multipart/form-data'>
    <div class="form-group" style="margin-top: 20px;">
        <label class="col-sm-2 control-label">户型图：</label>
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
    <input type="hidden" id="logo" name="house.logo">
    <div class="form-group">
        <label for="district" class="col-sm-2 control-label">楼盘：</label>
        <div class="col-sm-5">
            <select class="form-control" id="district" name="buildingsPrice.id">
                <option ng-repeat="bui in buildingsPriceList"    value="{{bui.id}}">{{bui.name}}</option>
            </select>
        </div>
    </div>
    <div class="form-group">
        <label for="name" class="col-sm-2 control-label">名字：</label>
        <div class="col-sm-5">
            <input type="text" class="form-control" name="house.name" id="name" placeholder="请输入户型名：" >
        </div>
    </div>
    <div class="form-group">
        <label for="intro" class="col-sm-2 control-label">简介：</label>
        <div class="col-sm-5">
            <textarea  rows="5"  class="form-control" name="house.intro" id="intro" placeholder="请输入简介" ></textarea>
        </div>
    </div>
    <div class="form-group">
        <label for="area" class="col-sm-2 control-label">面积：</label>
        <div class="col-sm-5">
            <input type="text" class="form-control" name="house.area" id="area" placeholder="请输入面积" onkeyup="this.value=(this.value.match(/^([1-9]\d*)(\.\d{0,2})?/)||[''])[0]">
        </div>
    </div>
    <div class="form-group">
        <label for="unit_price" class="col-sm-2 control-label">参考单价：</label>
        <div class="col-sm-5">
            <input type="text" class="form-control" name="house.unit_price" id="unit_price" placeholder="请输入参考单价" onkeyup="this.value=(this.value.match(/^([1-9]\d*)(\.\d{0,2})?/)||[''])[0]">
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-2 col-sm-offset-2 " id="submit" >
            <input type="button" class="btn btn-primary btn-lg btn-block"  ng-click="submit()" value="提交">
        </div>
    </div>
</form>

</div>
</body>
<script src="<%=path %>/public/js/jquery.min.js"></script>
<script src="<%=path %>/public/js/bootstrap.min.js"></script>
<script src="<%=path%>/public/js/bootstrap-fileinput.js"></script>
<script src="<%=path%>/public/jquery-from/jquery-from.js"></script>
<script src="<%=path%>/public/agency/js/jquery-validate.js"></script>
<script src="<%=path%>/public/validate/validate.js"></script>
<script src="<%=path %>/layer-v3.1.0/layer/layer.js"></script>
<script type="text/javascript" src="<%=path%>/public/loading/js/loading.js"></script>
<script type="text/javascript" src="<%=path%>/public/loading/loading3.js"></script>
<script>
    (function($){
        var app = angular.module('myApp', []);
        app.controller('myCtrl', function($scope,$http,$timeout) {
            var name = GetQueryString("buildingsi");
            var houseId = GetQueryString("houseId");
            var housename = GetQueryString("housename");
            var logo = GetQueryString("logo");
            var intro = GetQueryString("intro");
            var area = GetQueryString("area");
            var unit_price = GetQueryString("unit_price");
            var buildingsid = GetQueryString("buildingsid");
            $http({
                method: 'POST',
                url: "<%=path%>/buildings/queryBuildingsPrice"
            }).then(function successCallback(response) {
                $scope.buildingsPriceList = response.data.buildingsPriceList;
                if(name !=null&&name!='') {
                    $timeout(function(){//用jquery时不会自动渲染，只能手动渲染就调用此方法,
                        $("#district").val(name);
                    },100);
                };
                if(houseId !=null&&houseId!=''&&housename!=null&&housename!='') {
                    $timeout(function(){//用jquery时不会自动渲染，只能手动渲染就调用此方法,
                        $("#district").val(buildingsid);
                        $("#picImg").attr("src","<%=path%>/"+logo);
                        $("#id").val(houseId);
                        $("#name").val("${requestScope.housename}");
                        $("#intro").val("${requestScope.intro}");
                        $("#area").val(area);
                        $("#unit_price").val(area);
                        $("#logo").val(logo);
                    },50);
                };
            }, function errorCallback(response) {

            });
            var  frameindex= parent.layer.getFrameIndex(window.name);//当此页面被其他页面弹窗时，获取此页面元素
            $scope.submit =  function() {
                var urls = '<%=path%>/house/addhouse';
                if(houseId !=null&&houseId!=''&&housename!=null&&housename!='') {
                    urls =  '<%=path%>/house/updateHouse';
                }
                if( $scope.buildingsPriceList!=null&&$scope.buildingsPriceList!=''&&$scope.buildingsPriceList!=undefined){
                        if ($("#register-form").valid()==true) {
                            loading3();
                            $('#register-form').ajaxSubmit({
                                url: urls,
                                type: 'POST',
                                data: $("#register-form").serialize(),
                                success: function (data) {
                                    if (data.result.result == "success") {
                                        removeLoading('test');
                                        layer.alert(data.result.msg, {
                                            skin: 'layui-layer-lan' //样式类名
                                            , closeBtn: 0
                                        }, function () {
                                            if (name != null && name != '') {
                                                parent.layer.close(frameindex);//此页面被其他页面iframe弹窗时，调用此方法进行关闭
                                                parent.$('#update',parent.document).trigger('click');
                                            }
                                            if(houseId !=null&&houseId!=''&&housename!=null&&housename!='') {
                                                parent.layer.close(frameindex);//此页面被其他页面iframe弹窗时，调用此方法进行关闭
                                                parent.$('#update',parent.document).trigger('click');
                                            }
                                            window.location.reload();
                                        });
                                    } else {
                                        removeLoading('test');
                                        layer.msg(data.result.msg);
                                    }
                                }
                            });
                        }
                    }else {
                        layer.ready(function(){
                            layer.open({
                                type: 2,
                                title: '请最少添加一个楼盘才可添加员工',
                                maxmin: true,
                                area: ['800px', '500px'],
                                content: '<%=path%>/buildings/addbuildingspage?url=house/addhousepage',
                                cancel: function(){
                                    //关闭当前窗口时就进入此方法
                                }
                            });
                        });
                    }

            };
            function GetQueryString(name) {
                var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
                var r = window.location.search.substr(1).match(reg);
                if(r!=null){
                    return  unescape(r[2]);
                }
                return null;
            }
        });
    }(jQuery));
</script>
</html>
