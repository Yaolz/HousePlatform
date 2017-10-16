<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 娃娃鱼
  Date: 2017/9/6
  Time: 20:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%><!DOCTYPE html>
<html>
<head>
    <title>楼盘详情</title>
    <link href="<%=path %>/public/css/bootstrap.min.css" rel="stylesheet"/>
</head>

<style type="text/css">
    .carousel {
        position: absolute;
        top: 100px;
        width: 100%;
    }
</style>

<body>
<nav class="navbar navbar-default">
    <div class="container">
        <div class="navbar-header">
            <p align="center">
                查看楼盘详情
            </p>
        </div>
    </div>
</nav>

<div class="container">
    <div class="row">
        <div class="col-md-8 col-md-offset-2">
            <div class="row">
                <div class="col-md-7">
                    <c:choose>
                        <c:when test="${buildings.logo == null  }">
                            <img style="width: 400px;height: auto;"
                                 src="<%=path %>/public/admin/timg.gif"/>
                        </c:when>
                        <c:otherwise>
                            <a data-toggle="modal" href="#image" class="btn btn-large">
                                <img src="<%=path %>/${buildings.logo }" alt="${buildings.name }"
                                     title="${buildings.name }" width="400px;"/>
                            </a>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="col-md-5">
                    <div><h2>${buildings.name }</h2></div>
                    <div>${buildings.agency.name }楼盘
                    </div>
                    <div style="border-top: 1px #CCC dotted;">
                        <address>
                            <strong>${buildigns.address }</strong><br>
                            建筑类型：${buildings.building_type }<br>
                            开盘时间：<fmt:formatDate value="${buildings.open_date }" pattern="yyyy-MM-dd"/><br>
                            <abbr title="Phone">电话:</abbr>${buildings.tel }
                        </address>
                    </div>
                </div>
            </div>
            <div style="height: 30px;">
            </div>
            <table class="table table-bordered">
                <thead>
                <th colspan="2">${buildings.agency.name }</th>
                </thead>
                <tr>
                    <th width="20%">楼盘名：</th>
                    <td>${buildings.name }</td>
                </tr>
                <tr>
                    <th>地址：</th>
                    <td>${buildings.address }</td>
                </tr>
                <tr>
                    <th>区域：</th>
                    <td>${buildings.area }</td>
                </tr>
                <tr>
                    <th>占地面积：</th>
                    <td>${buildings.floor_area }</td>
                </tr>
                <tr>
                    <th>建筑面积：</th>
                    <td>${buildings.building_area }</td>
                </tr>
                <tr>
                    <th>房源类型：</th>
                    <td>${buildings.house_type }</td>
                </tr>
                <tr>
                    <th>建筑类型：</th>
                    <td>${buildings.building_type }</td>
                </tr>

                <tr>
                    <th>楼盘均价：</th>
                    <td>${buildings.avg_price }</td>
                </tr>
                <tr>
                    <th>开发公司</th>
                    <td>${buildings.company }</td>
                </tr>
                <tr>
                    <th>开盘时间：</th>
                    <td><fmt:formatDate value="${buildings.open_date }" pattern="yyyy-MM-dd"/></td>
                </tr>
                <tr>
                    <th>总套数：</th>
                    <td>${buildings.total_rooms }</td>
                </tr>
                <tr>
                    <th>楼盘售楼电话：</th>
                    <td>${buildings.tel }</td>
                </tr>
                <tr>
                    <th>绿化率：</th>
                    <td>${buildings.green_ratio }</td>
                </tr>
                <tr>
                    <th>容积率：</th>
                    <td>${buildings.plot_ratio }</td>
                </tr>
                <tr>
                    <th>物业公司：</th>
                    <td>${buildings.property_company }</td>
                </tr>
                <tr>
                    <th>物业费：</th>
                    <td>${buildings.property_fee }</td>
                </tr>
                <tr>
                    <th>车位数：</th>
                    <td>${buildings.car_station }</td>
                </tr>
                <tr>
                    <th>交通类型：</th>
                    <td>${buildings.traffic }</td>
                </tr>
                <tr>
                    <th>周边配套：</th>
                    <td>${buildings.equipments }</td>
                </tr>
                <tr>
                    <th>创建时间：</th>
                    <td><fmt:formatDate value="${buildings.created_time }" pattern="yyyy-MM-dd HH:mm"/></td>
                </tr>
                <tr>
                    <th>简介：</th>
                    <td>${buildings.intro }</td>
                </tr>
                <tr>
                    <th>状态：</th>
                    <td>可用</td>
                </tr>
            </table>
            <input type="hidden" id="longitude" value="${requestScope.buildings.longitude}">
            <input type="hidden" id="latitude" value="${requestScope.buildings.latitude}">
            <div id="map" style="width: 700px;height: 500px;"></div>
        </div>
    </div>
</div>

<div id="image" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <!-- 模态框 -->
            <div id="myCarousel" class="carousel slide" style="width: 500px;height: 335px;">
                <!-- 轮播（Carousel）指标 -->
                <ol class="carousel-indicators">
                    <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                    <li data-target="#myCarousel" data-slide-to="1"></li>
                    <li data-target="#myCarousel" data-slide-to="2"></li>
                </ol>
                <!-- 轮播（Carousel）项目 -->
                <div class="carousel-inner">
                    <div class="item active" style="width: 500px;height: 335px;">
                        <img src="<%=path %>/public/admin/photo_icon.png" width="100%" height="100%">
                    </div>
                    <c:forEach items="${buildings.buildingsImgSet }" var="b">
                    <div class="item" style="width: 500px;height: 335px;">
                        <img src="<%=path %>/${b.img_path }" width="100%" height="100%">
                    </div>
                    </c:forEach>
                </div>
                <!-- 轮播（Carousel）导航 -->
                <a class="carousel-control left" href="#myCarousel"
                   data-slide="prev">‹</a>
                <a class="carousel-control right" href="#myCarousel"
                   data-slide="next">›</a>
            </div>
        </div>
    </div>
</div>
<script src="<%=path %>/public/js/jquery.min.js"></script>
<script src="<%=path%>/public/js/bootstrap.min.js"></script>
<script src="http://api.map.baidu.com/api?v=2.0&ak=KjEQlPmSO1aM6G9cFGCQd7WL0arGC6zE"></script>
<script type="text/javascript">
    var map = new BMap.Map("map");    // 创建Map实例
    var point = new BMap.Point($("#longitude"),$("#latitude")); // 经纬度  将经纬度id赋值到此处
    map.centerAndZoom(point, 13);  // 初始化地图,设置中心点坐标和地图级别
    map.addControl(new BMap.MapTypeControl());   //添加地图类型控件
    map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放
    var marker = new BMap.Marker(point);  // 创建标注
    map.addOverlay(marker);               // 将标注添加到地图中
    marker.setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画
</script>
</body>
</html>
