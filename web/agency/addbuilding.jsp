<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: CMY
  Date: 2017/8/30
  Time: 20:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
    <title>添加楼栋</title>
    <link rel="stylesheet" href="<%=path %>/public/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=path%>/public/loading/css/global.css">
    <link rel="stylesheet" href="<%=path%>/public/loading/css/loading.css">
    <link rel="stylesheet" href="<%=path %>/jquery-pretty-radio-checkbox/css/jquery-labelauty.css">
    <script src="<%=path%>/public/angular/angular.min.js"></script>
    <style type="text/css" >
        .error{
            color:red;
        }
        a:hover{
            text-decoration: none;
        }
        ul { list-style-type: none;}
        li { display: inline-block;}
        li { margin: 10px 0;}
        input.labelauty + label { font: 12px "Microsoft Yahei";}
    </style>
</head>
<body ng-app="myApp" >
<input type="hidden" id="path" value="<%=path%>">
<div class="container" ng-controller="myCtrl">
    <form class="form-horizontal" id="register-form">
        <div class="form-group">
            <label for="district" class="col-sm-2 control-label">所属楼盘：</label>
            <div class="col-sm-5">
                <select class="form-control"   id="district"  name="buildingsPrice.id">
                    <option ng-repeat="bui in buildingsPriceList"   value="{{bui.id}}">{{bui.name}}</option>
                </select>
            </div>
        </div>
        <input type="hidden" id="id" name="building.id">
        <div class="form-group">
            <label for="name" class="col-sm-2 control-label">楼栋名称：</label>
            <div class="col-sm-5">
                <input type="text" class="form-control" name="building.name" id="name" placeholder="请输入户型名：" >
            </div>
        </div>
        <div class="form-group">
            <label for="total_floor" class="col-sm-2 control-label">总层数：</label>
            <div class="col-sm-5">
                <input type="text"  class="form-control" ng-change="floor()"  ng-model="total_floor" id="total_floor" name="building.total_floor" onKeyUp="value=(parseInt((value=value.replace(/\D/g,''))==''?'0':value,10))"  />
                <p ng-show="total_floor == 0" class="text-danger error">{{erro1}}</p>
            </div>
        </div>
        <div class="form-group">
            <label for="total_lift" class="col-sm-2 control-label">电梯数：</label>
            <div class="col-sm-5">
                <input type="text"  class="form-control" ng-change="lift()"  ng-model="total_lift" id="total_lift" name="building.total_lift" onKeyUp="value=(parseInt((value=value.replace(/\D/g,''))==''?'0':value,10))"  />
                <p ng-show="total_lift == 0" class="text-danger error">{{erro2}}</p>
            </div>
        </div>
        <div class="form-group" >
            <label  class="col-sm-2 control-label">每层户型：</label>
            <div class="col-sm-10 pre-scrollable" style="padding-left: 0px;" >
                <ul class="dowebok" id="hous">

                </ul>
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-10">
                <div class="checkbox">
                    <label ng-show="total > 0" >
                       已选{{total}}个户型
                    </label>
                    <label ng-show="total == 0" >
                        <p class="text-danger error">{{erro}}</p>
                    </label>
                </div>
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-2 col-sm-offset-2 " id="submit" >
                <input type="button" class="btn btn-primary btn-lg btn-block"  ng-click="submit()" value="提交">
            </div>
        </div>
    </form>
    <li class="col-lg-3 col-md-4 col-sm-6 hidden houses" ng-show="houses != null" ng-repeat="hou in houses">
        <img src="<%=path%>/{{hou.logo}}" style="height: 150px; width: 100%; display: block;">
        <input class="checkbox" type="checkbox" name="houseId" ng-click="count()"  value="{{hou.id}}" data-labelauty="{{hou.name}}">
    </li>
</div>
<button type="button" class="hidden" id="update"></button>
</body>
<script src="<%=path %>/public/js/jquery.min.js"></script>
<script src="<%=path %>/public/js/bootstrap.min.js"></script>
<script src="<%=path %>/layer-v3.1.0/layer/layer.js"></script>
<script src="<%=path%>/public/agency/js/jquery-validate.js"></script>
<script src="<%=path%>/public/validate/validate.js"></script>
<script type="text/javascript" src="<%=path%>/public/loading/js/loading.js"></script>
<script type="text/javascript" src="<%=path%>/public/loading/loading3.js"></script>
<script src="<%=path%>/jquery-pretty-radio-checkbox/js/jquery-labelauty1.js" type="text/javascript"></script>
<script>
    (function($){
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
            var  frameindex= parent.layer.getFrameIndex(window.name);//当此页面被其他页面弹窗时，获取此页面元素
            var buildingId = GetQueryString("buildingId");
            $scope.total_floor = 1;//初始化参数
            $scope.total_lift = 1;//初始参数
            $scope.total = 0;
            $scope.erro = "最少都需选择一个户型";
            $http({//获取楼盘下拉框值的url
                method: 'POST',
                url: "<%=path%>/buildings/queryBuildingsPrice"
            }).then(function successCallback(response) {
                $scope.buildingsPriceList = response.data.buildingsPriceList;
                if (buildingId != null && buildingId != '') {
                    queryBuilding();
                }else {
                    $timeout(function(){//用jquery时不会自动渲染，只能手动渲染就调用此方法,
                        extracted();//初始化时运行一次
                    },50);
                }
            }, function errorCallback(response) {

            });

            $("#district").change(function(){//select改变事件
                extracted();
            });

            $("#update").click(function(){//刷新数据调用此方法
                extracted();
            });

            $scope.count = function () {//选择了一个户型就重新获取一次被选中的有多少个
              $scope.total =  $("input[name='houseId']:checkbox:checked").length;
            };

            function extracted() {
                $http({
                    method: 'POST',
                    url: "<%=path%>/house/queryhouse",
                    data: {"buildings_id": $("#district").val()}
                }).then(function successCallback(response) {
                    if(response.data.result.result == 'fail'){
                        $("#hous").empty();
                        $scope.total = 0;
                        $scope.houses ='';
                    }else if(response.data.result.result == 'success'){
                        $scope.houses = response.data.houses;
                        $timeout(function(){//用jquery时不会自动渲染，只能手动渲染就调用此方法,
                            $(".houses").removeClass("hidden");//把户型的div块给去掉隐藏的clss样式
                            $("#hous").append($(".houses"));//然后把div添加到已经设置好的户型表单里
                            $(":input[class='checkbox']").labelauty();
                            if (buildingId != null && buildingId != '') {
                                $timeout(function(){//用jquery时不会自动渲染，只能手动渲染就调用此方法,
                                    $('input[name="houseId"]').each(function () {
                                        for (var i = 0, len = $scope.house_Id.length; i < len; i++) {
                                            if ($(this).val() == $scope.house_Id[i]) {
                                                $(this).prop("checked", true);
                                            }
                                        }
                                    });
                                    $scope.total = $scope.house_Id.length;
                                },50);
                            }
                        },50);
                    }
                }, function errorCallback(response) {

                });

            }
            $scope.floor = function () {
                if($scope.total_floor <1){
                    $scope.erro1 = "不能以0开头";
                }
            };
            $scope.lift = function () {
                if($scope.total_lift <1){
                    $scope.erro2 = "不能以0开头";
                }
            };
            $scope.submit =  function() {
                if($scope.buildingsPriceList!=null&&$scope.buildingsPriceList!=''&&$scope.buildingsPriceList!=undefined){
                    if ($("#register-form").valid()==true) {
                        if ($scope.houses != null && $scope.houses != '' && $scope.houses != undefined) {
                            if ($scope.total != 0) {
                                submits();
                            }
                        } else {
                            addhouse();
                        }
                    }
                }else {
                    layer.ready(function(){
                        layer.open({
                            type: 2,
                            title: '请最少添加一个楼盘才可添加楼栋',
                            maxmin: true,
                            area: ['800px', '500px'],
                            content: '<%=path%>/buildings/addbuildingspage?url=building/addbuildingpage',
                            cancel: function(){
                                //关闭当前窗口时就进入此方法
                            }
                        });
                    });
                }
            };
            function submits() {
                var urls = "<%=path%>/building/addbuilding";
                if(buildingId !=null&&buildingId!='') {
                    urls = "<%=path%>/building/updateBuilding";
                }
                if($scope.total_lift >0 && $scope.total_floor >0){
                    loading3();
                    $.post(urls,$("#register-form").serialize(),
                        function (data) {
                            if (data.controllerResult.result == 'success') {
                                removeLoading('test');
                                if(buildingId !=null&&buildingId!='') {
                                    parent.layer.close(frameindex);//此页面被其他页面iframe弹窗时，调用此方法进行关闭
                                    parent.layer.msg(data.controllerResult.msg);
                                    parent.$('#update',parent.document).trigger('click');//添加完后让父页面局部刷新
                                }
                                layer.alert(data.controllerResult.msg, {
                                    skin: 'layui-layer-lan' //样式类名
                                    , closeBtn: 0
                                }, function () {
                                    window.location.reload();
                                });
                            } else {
                                removeLoading('test');
                                layer.alert(data.controllerResult.msg, {
                                    skin: 'layui-layer-lan' //样式类名
                                    , closeBtn: 0
                                }, function () {
                                    //点击了确定按钮后执行此方法
                                });
                            }
                        }, 'json'
                    );
                }

            }
            function addhouse() {
                layer.ready(function () {
                    layer.open({
                        type: 2,
                        title: '此楼盘还没有户型，可以在此页面给楼盘添加新户型',
                        maxmin: true,
                        area: ['800px', '500px'],
                        content: '<%=path%>/house/addhousepage?buildingsi=' + $("#district").val(),
                        cancel: function () {
                            //关闭当前窗口时就进入此方法
                        }
                    });
                });
            }
            function queryBuilding() {//查询楼栋数据
                $http({//获取楼盘下拉框值的url
                    method: 'POST',
                    url: "<%=path%>/building/queryById",
                    data: {"buildingId": buildingId}
                }).then(function successCallback(response) {
                    $scope.building = response.data.building;
                    $scope.house_Id = response.data.house_Id;
                    $("#district").val($scope.building.buildingsPrice.id);
                    $("#district").attr("disabled","true");
                    $("#id").val($scope.building.id);
                    $("#name").val($scope.building.name);
                    $("#total_floor").val($scope.building.total_floor);
                    $("#total_lift").val($scope.building.total_lift);
                    $timeout(function(){//用jquery时不会自动渲染，只能手动渲染就调用此方法,
                        extracted();//初始化时运行一次
                    },50);

                }, function errorCallback(response) {

                });
            }
            function GetQueryString(name) {//获取url上的值
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
