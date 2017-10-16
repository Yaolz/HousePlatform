<%@ taglib prefix="s" uri="/struts-tags" %>
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
%><!DOCTYPE html>
<html>
<head>
    <title>经销商基本信息</title>
    <link type="text/css" rel="stylesheet" href="<%=path %>/public/css/bootstrap.min.css">

    <link type="text/css" rel="stylesheet" href="<%=path%>/public/lightbox2-master/css/lightbox.css"/>
    <link href="<%=path%>/public/css/bootstrap-fileinput.css" rel="stylesheet">
    <script src="<%=path%>/public/angular/angular.min.js"></script>
    <style type="text/css">
        .error {
            color: red;
        }
    </style>
</head>
<body ng-app="myApp" ng-controller="myCtrl">
<div class="container">
    <input type="hidden" id="path" value="<%=path%>">
    <form class="form-horizontal" id="register-form" enctype='multipart/form-data'>
        <div class="form-group" style="margin-top: 20px;">
            <label class="col-sm-2 control-label">楼盘封面：</label>
            <div class="fileinput fileinput-new col-sm-7" data-provides="fileinput" id="exampleInputUpload">
                <div class="fileinput-new thumbnail" style="width: 500px;height: auto;max-height:500px;">
                    <img id='picImg' style="width: 100%;height: auto;max-height: 500px;"
                         src="<%=path%>/public/img/noimage.png" alt=""/>
                </div>
                <div class="fileinput-preview fileinput-exists thumbnail"
                     style="max-width: 500px; max-height: 500px;">
                </div>
                <div>
                <span class="btn btn-primary btn-file ">
                    <span class="fileinput-new  ">选择文件</span>
                    <span class="fileinput-exists ">换一张</span>
                    <input class="form-control " type="file" name="upload" id="picID"
                           accept="image/gif,image/jpeg,image/x-png"/>
                </span>
                    <a href="javascript:;" class="btn btn-warning fileinput-exists " data-dismiss="fileinput">移除</a>
                </div>
            </div>
        </div>
        <input type="hidden" id="logo" name="buildings.logo">
        <input type="hidden" id="id" name="buildings.id">
        <div class="form-group">
            <label for="name" class="col-sm-2 control-label">楼盘名称：</label>
            <div class="col-sm-7">
                <input type="text" class="form-control" id="name" name="buildings.name">
            </div>
        </div>
        <div class="form-group" style="margin-left :3px">
            <label for="area" class="col-sm-2 control-label">所属区域：</label>
            <div class="col-sm-7 form-inline">
                <div class="docs-methods " id="area">
                    <div id="distpicker">
                        <div class="form-group">
                            <label class="sr-only" for="province">Province</label>
                            <select class="form-control" id="province" name="buildings.province"></select>
                        </div>
                        <div class="form-group">
                            <label class="sr-only" for="city">City</label>
                            <select class="form-control" id="city" name="buildings.city"></select>
                        </div>
                        <div class="form-group">
                            <label class="sr-only" for="district">District</label>
                            <select class="form-control" id="district" name="buildings.area"></select>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="form-group">
            <label for="address" class="col-sm-2 control-label">地址：</label>
            <div class="col-sm-7">
                <input type="text" class="form-control" id="address" name="buildings.address">
            </div>
        </div>


        <div class="form-group">
            <label for="floor_area" class="col-sm-2 control-label">占地面积：</label>
            <div class="col-sm-7">
                <input type="text" class="form-control" id="floor_area"  name="buildings.floor_area"  >
            </div>
        </div>
        <div class="form-group">
            <label for="building_area" class="col-sm-2 control-label">建筑面积：</label>
            <div class="col-sm-7">
                <input type="text" class="form-control" id="building_area" name="buildings.building_area">
            </div>
        </div>

        <div class="form-group">
            <label for="house_type" class="col-sm-2 control-label">房源类型：</label>
            <div class="col-sm-7">
                <select class="form-control" id="house_type" name="buildings.house_type">
                    <option>普通住宅</option>
                    <option>花园洋房</option>
                    <option>商品房</option>
                    <option>集资房</option>
                </select>
            </div>
        </div>
        <div class="form-group">
            <label for="building_type" class="col-sm-2 control-label">房源类型：</label>
            <div class="col-sm-7">
                <select class="form-control" id="building_type" name="buildings.building_type">
                    <option>板楼</option>
                    <option>塔楼</option>
                    <option>板塔结合</option>
                    <option>高层</option>
                    <option>普通住宅</option>
                </select>
            </div>
        </div>
        <div class="form-group">
            <label for="longitude" class="col-sm-2 control-label">经度：</label>
            <div class="col-sm-7">
                <input type="text" class="form-control" id="longitude" name="buildings.longitude">
            </div>
        </div>
        <div class="form-group">
            <label for="latitude" class="col-sm-2 control-label">纬度：</label>
            <div class="col-sm-7">
                <input type="text" class="form-control" id="latitude" name="buildings.latitude">
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-2 col-sm-offset-2 ">
                <input type="button" id="coordinate" class="btn btn-info" value="拾取坐标">
            </div>
        </div>
        <div class="form-group">
            <label for="avg_price" class="col-sm-2 control-label">楼盘均价：</label>
            <div class="col-sm-7">
                <input type="text" class="form-control" id="avg_price" name="buildings.avg_price"
                       onkeyup="this.value=(this.value.match(/^([1-9]\d*)(\.\d{0,2})?/)||[''])[0]"/>
            </div>
        </div>
        <div class="form-group">
            <label for="company" class="col-sm-2 control-label">开发公司：</label>
            <div class="col-sm-7">
                <input type="text" class="form-control" id="company" name="buildings.company">
            </div>
        </div>
        <div class="form-group">
            <label for="open_date" class="col-sm-2 control-label">开盘时间：</label>
            <div class="col-sm-7">
                <input type="text" class="form-control open_date" id="open_date" name="buildings.open_date"
                       style="background:rgba(0, 0, 0, 0);" placeholder="请输入开盘日期" readonly>
            </div>
        </div>
        <div class="form-group">
            <label for="total_rooms" class="col-sm-2 control-label">总套数：</label>
            <div class="col-sm-7">
                <input type="text" class="form-control" id="total_rooms" name="buildings.total_rooms"
                       onkeyup="this.value=this.value.replace(/\D/g,'')"/>
            </div>
        </div>
        <div class="form-group">
            <label for="reception_address" class="col-sm-2 control-label">接待地址：</label>
            <div class="col-sm-7">
                <input type="text" class="form-control" id="reception_address" name="buildings.reception_address">
            </div>
        </div>
        <div class="form-group">
            <label for="tel" class="col-sm-2 control-label">楼盘售楼电话：</label>
            <div class="col-sm-7">
                <input type="text" class="form-control" id="tel" name="buildings.tel">
            </div>
        </div>
        <div class="form-group">
            <label for="green_ratio" class="col-sm-2 control-label">绿化率：</label>
            <div class="col-sm-7">
                <input type="text" class="form-control" id="green_ratio" name="buildings.green_ratio"
                       onkeyup="this.value=(this.value.match(/\d+(\.\d{0,2})?/)||[''])[0]"
                       oninput="if(value.length>5){
                                        this.value=value.slice(0,6);
                                    }else if((parseFloat(value)) > 100){
                                            this.value =100;
                            }"/>
            </div>
        </div>
        <div class="form-group">
            <label for="plot_ratio" class="col-sm-2 control-label">容积率：</label>
            <div class="col-sm-7">
                <input type="text" class="form-control" id="plot_ratio" name="buildings.plot_ratio"
                       onkeyup="this.value=(this.value.match(/\d+(\.\d{0,2})?/)||[''])[0]"
                       oninput="if(value.length>5){
                                        this.value=value.slice(0,6);
                                    }else if((parseFloat(value)) > 100){
                                            this.value =100;
                        }"/>
            </div>
        </div>
        <div class="form-group">
            <label for="property_company" class="col-sm-2 control-label">物业公司：</label>
            <div class="col-sm-7">
                <input type="text" class="form-control" id="property_company" name="buildings.property_company">
            </div>
        </div>
        <div class="form-group">
            <label for="property_fee" class="col-sm-2 control-label">物业费：</label>
            <div class="col-sm-7">
                <input type="text" class="form-control" id="property_fee" name="buildings.property_fee"
                       onkeyup="this.value=(this.value.match(/^([1-9]\d*)(\.\d{0,2})?/)||[''])[0]"/>
            </div>
        </div>
        <div class="form-group">
            <label for="car_station" class="col-sm-2 control-label">车位数：</label>
            <div class="col-sm-7">
                <input type="text" class="form-control" id="car_station" name="buildings.car_station"
                       onkeyup="this.value=this.value.replace(/\D/g,'')"/>
            </div>
        </div>
        <div class="form-group">
            <label for="traffic" class="col-sm-2 control-label">交通状况：</label>
            <div class="col-sm-7">
                <textarea rows="5" class="form-control" id="traffic" name="buildings.traffic"></textarea>
            </div>
        </div>
        <div class="form-group">
            <label for="equipments" class="col-sm-2 control-label">周边配套：</label>
            <div class="col-sm-7">
                <textarea rows="5" class="form-control" id="equipments" name="buildings.equipments"></textarea>
            </div>
        </div>
        <div class="form-group">
            <label for="intro" class="col-sm-2 control-label">简介：</label>
            <div class="col-sm-7">
                <textarea rows="5" class="form-control" id="intro" name="buildings.intro"></textarea>
            </div>
        </div>

        <div class="form-group">
            <label for="created_time" class="col-sm-2 control-label">开工时间：</label>
            <div class="col-sm-4">
                <input type="text" class="form-control created_time" name="buildings.created_time"
                       style="background:rgba(0, 0, 0, 0);" id="created_time" placeholder="请输入楼盘开工时间" readonly>
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-2 col-sm-offset-2 " id="submit">
                <input type="button" class="btn btn-primary btn-lg btn-block" ng-click="submit()" value="提交">
            </div>
        </div>
    </form>
</div>
<div id="normalDatePicker"></div>
<div id="HiddenSomthingDatePicker"></div>
</body>
<script src="<%=path %>/public/js/jquery.min.js"></script>
<script src="<%=path %>/public/js/bootstrap.min.js"></script>
<script src="<%=path%>/public/userRegister/jedate/jedate.js"></script>
<script src="<%=path%>/public/jquery-from/jquery-from.js"></script>
<script src="<%=path %>/public/lightbox2-master/js/lightbox.min.js"></script>
<script src="<%=path%>/public/js/bootstrap-fileinput.js"></script>
<script src="<%=path%>/public/js/three/distpicker.data.js"></script>
<script src="<%=path%>/public/js/three/distpicker.js"></script>
<script src="<%=path%>/public/js/three/main.js"></script>
<script src="<%=path%>/public/agency/js/jquery-validate.js"></script>
<script src="<%=path%>/public/validate/validate.js"></script>
<script src="<%=path %>/layer-v3.1.0/layer/layer.js"></script>
<script>
    (function ($) {
        //日期选择
        if ($("#open_date").get(0)) {
            jeDate({
                dateCell: "#open_date",
                format: "YYYY-MM-DD",
                minDate: "1900-1-1",
                maxDate: "2099-12-31 23:59:59",
                ishmsVal: false
            });
        }
        ;
        if ($("#created_time").get(0)) {
            jeDate({
                dateCell: "#created_time",
                format: "YYYY-MM-DD",
                minDate: "1900-1-1",
                maxDate: "2099-12-31 23:59:59",
                ishmsVal: false
            });
        }
        ;
        $("#open_date").trigger("click");
        $("#created_time").trigger("click");
        $("body").trigger("click");
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
        app.controller('myCtrl', function($scope,$http,$timeout) {
            app.controller('myCtrl', function($scope,$http,$timeout,$filter) {
                var url = GetQueryString("url");
                var buildingsId = GetQueryString("buildingsId");
                $scope.buildings = "";
                var frameindex = parent.layer.getFrameIndex(window.name);//当此页面被其他页面弹窗时，获取此页面元素
                if (buildingsId != null && buildingsId != '') {
                    $http({
                        method: 'POST',
                        url: "<%=path%>/buildings/buildingsDetail",
                        data: {"id": buildingsId}
                    }).then(function successCallback(response) {
                        $scope.buildings = response.data.buildings;
                        $("#id").val($scope.buildings.id);//楼盘名称
                        $("#name").val($scope.buildings.name);//楼盘名称
                        $("#district").val($scope.buildings.area);//所属区域
                        $("#address").val($scope.buildings.address);//地址
                        $("#floor_area").val($scope.buildings.floor_area);//占地面积
                        $("#building_area").val($scope.buildings.building_area);//建筑面积
                        $("#house_type").val($scope.buildings.house_type);//房源类型
                        $("#building_type").val($scope.buildings.building_type);//建筑类型
                        $("#longitude").val($scope.buildings.longitude);//经度
                        $("#latitude").val($scope.buildings.latitude);//纬度
                        $("#avg_price").val($scope.buildings.avg_price);//楼盘均价
                        $("#company").val($scope.buildings.company);//开发公司

                        $("#open_date").val(date($scope.buildings.open_date));//开盘时间

                        $("#total_rooms").val($scope.buildings.total_rooms);//总套数
                        $("#reception_address").val($scope.buildings.reception_address);//接待地址
                        $("#tel").val($scope.buildings.tel);//楼盘售楼电话
                        $("#green_ratio").val($scope.buildings.green_ratio);//绿化率
                        $("#plot_ratio").val($scope.buildings.plot_ratio);//容积率
                        $("#property_company").val($scope.buildings.property_company);//物业公司
                        $("#property_fee").val($scope.buildings.property_fee);//物业费
                        $("#car_station").val($scope.buildings.car_station);//车位数
                        $("#traffic").val($scope.buildings.traffic);//交通状况
                        $("#equipments").val($scope.buildings.equipments);//周边配套
                        $("#logo").val($scope.buildings.logo);//楼盘封面
                        $("#picImg").attr("src", "<%=path%>/" + $scope.buildings.logo);//楼盘封面
                        $("#intro").val($scope.buildings.province);//简介
                        $("#province").val($scope.buildings.province);//省
                        $("#city").val($scope.buildings.city);//市
                        $("#created_time").val($filter("date")($scope.buildings.created_time, "yyyy-MM-dd HH:mm:ss"));
                    }, function errorCallback(response) {

                    });
                }
                function date(dates) {
                    var str = dates;
                    var strA = str.split(/[a-zA-Z]/);
                    var d = {}

                    d.year = strA[0].split('-')[0];
                    d.month = strA[0].split('-')[1];
                    d.day = strA[0].split('-')[2];
                    d.hour = strA[1].split(':')[0];
                    d.minute = strA[1].split(':')[1];
                    d.second = strA[1].split(':')[2];
                    d.weekday = str.match(/[a-zA-Z]/)[0];
                    return d.year + "-" + d.month + "-" + d.day;
                }

                $scope.submit = function () {
                    if ($("#register-form").valid() == true) {
                        var index = layer.load(0, {shade: false});//发送请求时让页面出现加载样式
                        var addurl = '<%=path %>/buildings/addbuildings';
                        if (buildingsId != null && buildingsId != '') {
                            addurl = '<%=path %>/buildings/updateBuildings';
                        }
                        $('#register-form').ajaxSubmit({
                            url: addurl,
                            type: 'POST',
                            data: $("#register-form").serialize(),
                            success: function (data) {
                                $timeout(function () {//用jquery时不会自动渲染，只能手动渲染就调用此方法,
                                    if (data.result.result != "fail") {
                                        layer.close(index);//关闭加载窗口
                                        layer.alert(data.result.msg, {
                                            skin: 'layui-layer-lan' //样式类名
                                            , closeBtn: 0
                                        }, function () {
                                            if (url != null && url != '') {
                                                parent.layer.close(frameindex);//此页面被其他页面iframe弹窗时，调用此方法进行关闭
                                                parent.location.href = "<%=path%>/" + url;
                                            }
                                            ;
                                            if (buildingsId != null && buildingsId != '') {
                                                parent.layer.close(frameindex);//此页面被其他页面iframe弹窗时，调用此方法进行关闭
                                                parent.layer.msg(data.result.msg);
                                                parent.$('#update', parent.document).trigger('click');//添加完后让父页面局部刷新
                                            }
                                            window.location.reload();
                                        });
                                    } else {
                                        layer.msg(data.result.msg);
                                    }
                                }, 0);
                            }
                        });
                    }
                };
                function GetQueryString(name) {//获取url上的值
                    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
                    var r = window.location.search.substr(1).match(reg);
                    if (r != null) {
                        return unescape(r[2]);
                    }
                    return null;
                }
            });
            $("#coordinate").click(function () {
                layer.ready(function () {
                    layer.open({
                        type: 2,
                        title: '获取坐标',
                        maxmin: true,
                        area: ['800px', '500px'],
                        content: 'http://api.map.baidu.com/lbsapi/getpoint/index.html"',
                        cancel: function () {
                            //关闭当前窗口时就进入此方法 ?buildingsId='+$scope.buildingsPager[$scope.count].id
                        }
                    });
                });
            });
        });
        }(jQuery));
</script>
</html>
