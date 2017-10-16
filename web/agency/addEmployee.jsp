<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>添加员工</title>
</head>
<%
    String path = request.getContextPath();
%>
<link href="<%=path%>/public/css/bootstrap.min.css" rel="stylesheet">
<link href="<%=path%>/public/css/bootstrap-fileinput.css" rel="stylesheet">
<script src="<%=path%>/public/angular/angular.min.js"></script>
<link rel="stylesheet" href="<%=path%>/public/loading/css/loading.css">
<link rel="stylesheet" href="<%=path%>/public/loading/css/global.css">
<style>
    .btn-primary {
        background-color: #1ab394;
        border-color: #1ab394;
        color: #FFF;
    }
</style>
<body ng-app="myApp">
<input type="hidden" id="path" value="<%=path%>">
<div class="container" ng-controller="myCtrl">
    <input type="hidden"  id="agency-phone" value="${sessionScope.agency.phone}" />
    <input type="hidden" id="agency-name"  value="${sessionScope.agency.name}" />
        <form class="form-horizontal" style="margin-top: 20px;" id ="register-form"  enctype="multipart/form-data">
            <input type="hidden" name="agencyPrice.id" value="${sessionScope.agency.id}" />
            <div class="form-group" style="margin-top: 20px;">
                <label class="col-sm-2 control-label">头像：</label>
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
                <label for="district" class="col-sm-2 control-label">楼盘：</label>
                <div class="col-sm-5">
                    <select class="form-control" id="district" name="buildingsPrice.id">
                        <option ng-repeat="bui in buildingsPriceList"    value="{{bui.id}}">{{bui.name}}</option>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label for="username" class="col-sm-2  control-label">姓名：</label>
                <div class="col-sm-5  input-parent">
                    <input type="text" class="form-control" id="username" name="employee.name"  placeholder="请输入姓名">
                    <span id="titleError" style="color:red;"></span>
                </div>
            </div>
            <div class="form-group">
                <label for="email" class="col-sm-2  control-label">邮箱：</label>
                <div class="col-sm-5  input-parent">
                    <input type="text" class="form-control" id="email" name="employee.email" placeholder="请输入邮箱">
                </div>
            </div>
            <div class="form-group">
                <label for="phone" class="col-sm-2  control-label">电话号码：</label>
                <div class="col-sm-5  input-parent">
                    <input type="text" class="form-control" id="phone" name="employee.phone" placeholder="请输入电话号码">
                </div>
            </div>
            <div class="form-group">
                <label for="qq" class="col-sm-2  control-label">qq：</label>
                <div class="col-sm-5  input-parent">
                    <input type="text" class="form-control" id="qq" name="employee.qq" placeholder="请输入qq">
                </div>
            </div>
            <div class="form-group">
                <label for="wechat" class="col-sm-2  control-label">微信：</label>
                <div class="col-sm-5  input-parent">
                    <input type="text" class="form-control" id="wechat" name="employee.wechat" placeholder="请输入微信">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2  control-label">性别：</label>
                <div class="col-sm-5  input-parent">
                    <select class="form-control" name="employee.gender">
                        <option>男</option>
                        <option>女</option>
                        <option>其他</option>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label for="basic_salary" class="col-sm-2  control-label">基本工资：</label>
                <div class="col-sm-5  input-parent">
                    <input type="text" class="form-control" id="basic_salary" name="employee.basic_salary" placeholder="请输入基本工资" onkeyup="this.value=(this.value.match(/^([1-9]\d*)(\.\d{0,2})?/)||[''])[0]">
                </div>
            </div>
            <div class="form-group">
                <label for="des" class="col-sm-2  control-label">描述：</label>
                <div class="col-sm-5  input-parent">
                    <textarea rows="5" type="text" class="form-control" id="des" name="employee.des"  placeholder="请输入描述"></textarea>
                </div>
            </div>
            <div class="form-group">
                <label for="exp" class="col-sm-2  control-label">工作经验：</label>
                <div class="col-sm-5  input-parent">
                    <textarea rows="5" type="text" class="form-control" id="exp" name="employee.exp"  placeholder="请输入工作经验"></textarea>
                </div>
            </div>
            <div class="form-group">
                <label for="intro" class="col-sm-2  control-label">简介：</label>
                <div class="col-sm-5  input-parent">
                    <textarea rows="5" type="text" class="form-control" id="intro" name="employee.intro"  placeholder="请输入个人简介"></textarea>
                </div>
            </div>
            <div class="form-group">
                <label for="address" class="col-sm-2  control-label">居住地址：</label>
                <div class="col-sm-5  input-parent">
                    <input type="text" class="form-control" id="address" name="employee.address" placeholder="请输入居住地址">
                </div>
            </div>
            <div class="form-group">
                <label for="birthday" class="col-sm-2  control-label">入职时间：</label>
                <div class="col-sm-4  input-parent">
                    <input type="text" class="form-control " name="employee.created_time" style="background:rgba(0, 0, 0, 0);" id="birthday" placeholder="请输入员工入职时间" readonly>
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
<script src="<%=path%>/public/js/jquery.min.js"></script>
<script src="<%=path%>/public/js/bootstrap.min.js"></script>
<script src="<%=path %>/layer-v3.1.0/layer/layer.js"></script>
<script  src="<%=path%>/public/userRegister/jedate/jedate.js"></script>
<script src="<%=path%>/public/js/bootstrap-fileinput.js"></script>
<script src="<%=path%>/public/jquery-from/jquery-from.js"></script>
<script src="<%=path%>/public/agency/js/jquery-validate.js"></script>
<script src="<%=path%>/public/validate/validate.js"></script>
<script type="text/javascript" src="<%=path%>/public/loading/js/loading.js"></script>
<script type="text/javascript" src="<%=path%>/public/loading/loading3.js"></script>
<script type="text/javascript">
    (function($){
//        日期选择
        if($("#birthday").get(0)){
            jeDate({
                dateCell:"#birthday",
                format:"YYYY-MM-DD",
                minDate:"1900-1-1",
                maxDate:"2099-12-31 23:59:59",
                ishmsVal:false
            });
        };
        $("#birthday").trigger("click");
        $("body").trigger("click");
        var app = angular.module('myApp', []);
        app.controller('myCtrl', function($scope,$http,$timeout) {
            $http({
                method: 'POST',
                url: "<%=path%>/buildings/queryBuildingsPrice"
            }).then(function successCallback(response) {
                $scope.buildingsPriceList = response.data.buildingsPriceList;
            }, function errorCallback(response) {
            });

            $scope.submit =  function() {
                    if( $scope.buildingsPriceList!=null&&$scope.buildingsPriceList!=''&&$scope.buildingsPriceList!=undefined){
                        if ($("#register-form").valid()==true) {
                            loading3();
                            $('#register-form').ajaxSubmit({
                                url: '<%=path%>/employee/addEmployee',
                                type: 'POST',
                                data: $("#register-form").serialize(),
                                success: function (data) {
                                    if (data.controllerResult.result != "fail") {
                                        removeLoading('test');
                                        layer.alert(data.controllerResult.msg, {
                                            skin: 'layui-layer-lan' //样式类名
                                            , closeBtn: 0
                                        }, function () {
                                            window.location.reload();
                                        });
                                    } else {
                                        removeLoading('test');
                                        layer.msg(data.controllerResult.msg);
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
                                content: '<%=path%>/buildings/addbuildingspage?url=employee/addEmployeePage',
                                cancel: function(){
                                    //关闭当前窗口时就进入此方法
                                }
                            });
                        });
                    }

            };

        });

    }(jQuery));
</script>
</html>
