<%--
  Created by IntelliJ IDEA.
  User: yao
  Date: 2017/9/16
  Time: 10:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html><html>
<%
    String path = request.getContextPath();
%>
<html>
<head>
    <title>Title</title>
    <script src="<%=path%>/public/angular/angular.min.js"></script>
    <link href="<%=path %>/public/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="<%=path %>/index/css/buildings.css">
    <style>
        table {
            margin: auto;
            width: 95%;
        }

        table tr {
            height: 50px;
            align: center;
        }

        table tr th {
            font-family: "微软雅黑 Light";
            font-size: 16px;
            color: #666;
            width: 150px;
        }

        table tr td {
            align: left;
        }
    </style>
</head>
<body ng-app="myApp" ng-controller="myCtrl">
<%@include file="../../main/toubu.jsp" %>
<div class="container">
    <div class="row">
        <div class="col-xs-1">
        </div>
        <div class="col-xs-10">
            <div id="ads">
                <a target="_blank" href="{{ads[0].ad_url}}">
                    <img src="<%=path %>/{{ads[0].logo}}" title="{{ads[0].title}}" class="img-responsive" width="100%" height="280px;">
                </a>
            </div>
            <div class="hidden" id="noads">
                <a target="_blank"
                   href="http://mail.qq.com/cgi-bin/qm_share?t=qm_mailme&email=shoulouwang@qq.com">
                    <img src="<%=path %>/images/timg1.jpg" title="点击投放广告" class="img-responsive" width="100%" height="280px;">
                </a>
            </div>
            <ul class="nav nav-tabs" style="margin-top:20px;">
                <li role="presentation">
                    <a href="<%=path %>/buildings/indexBuildingsDetailPage?buildingsId={{buildings.id}}">楼盘首页</a>
                </li>
                <li role="presentation" class="active">
                    <a href="<%=path %>/buildings/navBuildingsPage?buildingsId={{buildings.id}}">楼盘详情</a>
                </li>
                <li role="presentation">
                    <a href="<%=path %>/activity/navActivityPage?buildingsId={{buildings.id}}">楼盘活动</a>
                </li>
                <li role="presentation">
                    <a href="<%=path %>/buildings/avgPricePage?buildingsId={{buildings.id}}">历史价格</a>
                </li>
                <li role="presentation">
                    <a href="<%=path %>/house/navHousePage?buildingsId={{buildings.id}}">户型图</a>
                </li>
                <li role="presentation">
                    <a href="<%=path %>/comment/buildingsCommentPage?buildingsId={{buildings.id}}">楼盘点评</a>
                </li>
                <li role="presentation">
                    <a href="<%=path %>/employee/navEmployeePage?buildingsId={{buildings.id}}">销售员</a>
                </li>
                <li role="presentation">
                    <a href="<%=path %>/room/navRoomPage?buildingsId={{buildings.id}}">在线看房</a>
                </li>
                <li role="presentation">
                    <a href="<%=path %>/message/navMessagePage?buildingsId={{buildings.id}}">留言</a>
                </li>
            </ul>
        </div>
        <div class="col-xs-1">
        </div>
    </div>

    <div class="row">
        <div class="col-xs-1">
        </div>
        <div class="col-xs-10">
            <div class="col-md-9">
                <div>
                    <h3>基本信息</h3>
                    <div class="buildings_detail">
                        <table>
                            <tr>
                                <th>楼盘名称:</th>
                                <td>{{buildings.name}}</td>
                            </tr>
                            <tr>
                                <th>楼盘均价:</th>
                                <td>{{buildings.avg_price}}&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:"  style="color: red;"  id="loanAll">房款计算</a></td>
                            </tr>
                            <tr>
                                <th>开发公司</th>
                                <td>{{buildings.company}}</td>
                            </tr>
                            <tr>
                                <th>区域</th>
                                <td>{{buildings.area}}</td>
                            </tr>
                            <tr>
                                <th>地址</th>
                                <td>{{buildings.address}}</td>
                            </tr>
                            <tr>
                                <th>售楼电话</th>
                                <td>{{buildings.tel}}</td>
                            </tr>
                            <tr>
                                <th>楼盘图片</th>
                                <td>
                                    <a href="#" ng-click="examine();">
                                        楼盘相册
                                    </a>
                                </td>
                            </tr>
                            <tr>
                                <th>开盘时间</th>
                                <td>{{buildings.open_date}}</td>
                            </tr>
                        </table>
                    </div>
                </div>
                <div>
                    <h3>销售信息</h3>
                    <div class="buildings_detail">
                        <table>
                            <tr>
                                <th>房源类型</th>
                                <td>{{buildings.house_type}}</td>
                            </tr>
                            <tr>
                                <th>建筑类型</th>
                                <td>{{buildings.building_type}}</td>
                            </tr>
                            <tr>
                                <th>占地面积</th>
                                <td>{{buildings.floor_area}}</td>
                            </tr>
                            <tr>
                                <th>总套数</th>
                                <td>{{buildings.total_rooms}}</td>
                            </tr>
                            <tr>
                                <th>绿化率</th>
                                <td>{{buildings.green_ratio}}</td>
                            </tr>
                            <tr>
                                <th>容积率</th>
                                <td>{{buildings.plot_ratio}}</td>
                            </tr>
                            <tr>
                                <th>物业公司</th>
                                <td>{{buildings.property_company}}</td>
                            </tr>
                            <tr>
                                <th>物业费</th>
                                <td>{{buildings.property_fee}}</td>
                            </tr>
                            <tr>
                                <th>车位数</th>
                                <td>{{buildings.car_station}}</td>
                            </tr>
                            <tr>
                                <th>交通类型</th>
                                <td>{{buildings.traffic}}</td>
                            </tr>
                            <tr>
                                <th>周边配套</th>
                                <td>{{buildings.equipments}}</td>
                            </tr>
                            <tr>
                                <th>简介</th>
                                <td>{{buildings.intro}}</td>
                            </tr>

                        </table>
                    </div>
                </div>
                <input type="hidden" id="longitude" value="${requestScope.buildings.longitude}">
                <input type="hidden" id="latitude" value="${requestScope.buildings.latitude}">
                <div id="map" style="width: 500px;height: 400px; margin-top: 20px;"></div>
            </div>
            <div class="col-md-3" class="buildings_detail">
                <div style="margin-top: 20px;">
                    <h4>看过本盘的人还看</h4>
                </div>
                <div  ng-repeat="b in buildingsMore | limitTo : 5">
                    <img src="<%=path %>/{{b.logo}}" width="100%"/>
                    <p><a target="_blank" href="<%=path %>/history/addHistory?buildingsId={{b.id}}&userId={{user.id}}">{{b.name}}</a></p>
                </div>
            </div>
        </div>
        <div class="col-xs-1">
        </div>
    </div>

</div>
<%@include file="../../main/banquan.jsp" %>
</body>
<script src="<%=path %>/public/js/jquery.min.js"></script>
<script src="<%=path%>/public/js/bootstrap.min.js"></script>
<script src="<%=path %>/layer-v3.1.0/layer/layer.js"></script>
<script src="<%=path%>/index/js/index.js"></script>
<script src="http://api.map.baidu.com/api?v=2.0&ak=KjEQlPmSO1aM6G9cFGCQd7WL0arGC6zE"></script>
<script type="text/javascript">
    var map = new BMap.Map("map");    // 创建Map实例
    var point = new BMap.Point(114.93932, 25.826707); // 经纬度  将经纬度id赋值到此处
    map.centerAndZoom(point, 13);  // 初始化地图,设置中心点坐标和地图级别
    map.addControl(new BMap.MapTypeControl());   //添加地图类型控件
    map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放
    var marker = new BMap.Marker(point);  // 创建标注
    map.addOverlay(marker);               // 将标注添加到地图中
    marker.setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画

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
                url: $("#path").val()+"/user/queryUser"
            }).then(function successCallback(response) {
                $scope.user = response.data.user;
            }, function errorCallback(response) {
            });
            $http({
                method: 'POST',
                url: "<%=path%>/ads/adsShow",
                data: {"beginNum": 18, "endNum": 18}
            }).then(function successCallback(response) {
                $scope.ads = response.data.adsList;
                if($scope.ads[0] ==null|| $scope.ads[0] =='' || $scope.ads[0] == undefined){
                    $("#noads").removeClass("hidden");
                    $("#ads").addClass("hidden");
                }
            }, function errorCallback(response) {
            });
            var buildingsId = GetQueryString("buildingsId");
            $http({
                method: 'POST',
                url: "<%=path%>/buildings/indexBuildingsDetail?buildingsId=" + buildingsId,
            }).then(function successCallback(response) {
                $scope.buildings = response.data.buildings;
            }, function errorCallback(response) {
            });

            $http({
                method: 'POST',
                url: "<%=path%>/buildings/indexBuildings",
                data: {"like":"","area":"赣州市",
                    "avg_price":"0","house_type":" "}
            }).then(function successCallback(response) {
                $scope.buildingsMore = response.data.pager.result;
            }, function errorCallback(response) {
            });

            $scope.examine = function () {//楼盘修改信息
                layer.ready(function(){
                    layer.open({
                        type: 2,
                        title: '楼盘相册',
                        maxmin: true,
                        area: ['1000px', '600px'],
                        content: '<%=path%>/buildingsImg.jsp?buildingsId='+buildingsId,
                        cancel: function(){
                            //关闭当前窗口时就进入此方法 ?buildingsId='+$scope.buildingsPager[$scope.count].id
                        }
                    });
                });
            };
            function GetQueryString(name) {//获取url上的值
                var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
                var r = window.location.search.substr(1).match(reg);
                if (r != null) {
                    return unescape(r[2]);
                }
                return null;
            }

            $("#loanAll").click(function () {
                layer.open({
                    type: 2,
                    title: '贷款计算',
                    maxmin: true,
                    area: ['1000px', '500px'],
                    content:"<%=path %>/Loan/loanAll.html",
                    cancel: function(){
                        //关闭当前窗口时就进入此方法
                    }
                });
            });
        });
    }(jQuery));

</script>
</html>
