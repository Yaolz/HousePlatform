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
<html>
<head>
    <title>添加楼栋</title>
</head>
<body>
<div align="center">
    <form class="form-horizontal" action="<%=path%>/buildings/addbuildings">
        <input type="hidden" name="agency.id" value="${agency.id }"/>
        <select name="buildingsPrice.id">
            <c:forEach items="${requestScope.buildingsList}" var="b">
                <option value="b.id">${b.name}</option>
            </c:forEach>
        </select>

        <div class="input-group col-xs-4">
            <span class="input-group-addon">&nbsp;&nbsp;姓&nbsp;&nbsp;名:&nbsp;&nbsp;</span>
            <input type="text" class="form-control"  name="buildings.name" placeholder="请输入姓名" >
        </div>

        <div class="input-group col-xs-4">
            <span class="input-group-addon">&nbsp;&nbsp;面&nbsp;&nbsp;积:&nbsp;&nbsp;</span>
            <input type="text" class="form-control"  name="buildings.area" placeholder="请输入面积" >
        </div>
        <div class="input-group col-xs-4">
            <span class="input-group-addon">&nbsp;&nbsp;地&nbsp;&nbsp;址:&nbsp;&nbsp;</span>
            <input type="text" class="form-control"  name="buildings.address" placeholder="请输入地址" >
        </div>
        <div class="input-group col-xs-4">
            <span class="input-group-addon">楼层面积</span>
            <input type="text" class="form-control"  name="buildings.floor_area" placeholder="请输入楼层面积" >
        </div>
        <div class="input-group col-xs-4">
            <span class="input-group-addon">楼栋面积</span>
            <input type="text" class="form-control"  name="buildings.building" placeholder="请输入楼层面积" >
        </div>
        <div class="input-group col-xs-4">
            <span class="input-group-addon">&nbsp;&nbsp;户&nbsp;&nbsp;型:&nbsp;&nbsp;</span>
            <input type="text" class="form-control"  name="buildings.house_type" placeholder="请输入户型" >
        </div>
        <div class="input-group col-xs-4">
            <span class="input-group-addon">楼栋类型</span>
            <input type="text" class="form-control"  name="building_type" placeholder="请输入楼栋类型" >
        </div>
        <div class="input-group col-xs-4">
            <span class="input-group-addon">&nbsp;&nbsp;纬&nbsp;&nbsp;度:&nbsp;&nbsp;</span>
            <input type="text" class="form-control"  name="buildings.latitude" placeholder="请输入纬度" >
        </div>
        <div class="input-group col-xs-4">
            <span class="input-group-addon">&nbsp;&nbsp;经&nbsp;&nbsp;度:&nbsp;&nbsp;  </span>
            <input type="text" class="form-control"  name="buildings.longitude" placeholder="请输入经度" >
        </div>
        <div class="input-group col-xs-4">
            <span class="input-group-addon">楼盘均价</span>
            <input type="text" class="form-control"  name="buildings.avg_price" placeholder="请输入楼盘均价" >
        </div>
        <div class="input-group col-xs-4">
            <span class="input-group-addon">开发公司</span>
            <input type="text" class="form-control"  name="buildings.company" placeholder="请输入开发公司" >
        </div>
        <div class="input-group col-xs-4">
            <span class="input-group-addon">开盘时间</span>
            <input type="text" class="form-control"  name="buildings.open_date" placeholder="请输入开盘时间" >
        </div>
        <div class="input-group col-xs-4">
            <span class="input-group-addon">&nbsp;&nbsp;总套数&nbsp;&nbsp;</span>
            <input type="text" class="form-control"  name="buildings.total_rooms" placeholder="请输入总套数" >
        </div>
        <div class="input-group col-xs-4">
            <span class="input-group-addon">招待地点</span>
            <input type="text" class="form-control"  name="buildings.reception_address" placeholder="请输入招待地点" >
        </div>
        <div class="input-group col-xs-4">
            <span class="input-group-addon">&nbsp;&nbsp;电&nbsp;&nbsp;话:&nbsp;&nbsp;</span>
            <input type="text" class="form-control"  name="buildings.tel" placeholder="请输入电话" >
        </div>
        <div class="input-group col-xs-4">
            <span class="input-group-addon">&nbsp;&nbsp;绿化率&nbsp;&nbsp;</span>
            <input type="text" class="form-control"  name="buildings.green_ratio" placeholder="请输入绿化率" >
        </div>
        <div class="input-group col-xs-4">
            <span class="input-group-addon">&nbsp;&nbsp;容积率&nbsp;&nbsp;</span>
            <input type="text" class="form-control"  name="buildings.plot_ratio" placeholder="请输入容积率" >
        </div>
        <div class="input-group col-xs-4">
            <span class="input-group-addon">物业公司</span>
            <input type="text" class="form-control"  name="buildings.property_company" placeholder="请输入物业公司" >
        </div>
        <div class="input-group col-xs-4">
            <span class="input-group-addon">&nbsp;&nbsp;物业费&nbsp;&nbsp;</span>
            <input type="text" class="form-control"  name="buildings.property_fee" placeholder="请输入物业费" >
        </div>
        <div class="input-group col-xs-4">
            <span class="input-group-addon">&nbsp;&nbsp;车位数&nbsp;&nbsp;</span>
            <input type="text" class="form-control"  name="buildings.car_station" placeholder="请输入车位数" >
        </div>
        <div class="input-group col-xs-4">
            <span class="input-group-addon">交通状况</span>
            <input type="text" class="form-control"  name="buildings.traffic" placeholder="请输入交通状况" >
        </div>
        <div class="input-group col-xs-4">
            <span class="input-group-addon">周边配套</span>
            <input type="text" class="form-control"  name="buildings.equipments" placeholder="请输入周边配套" >
        </div>
        <div class="input-group col-xs-4">
            <span class="input-group-addon">&nbsp;&nbsp;&nbsp;&nbsp;logo&nbsp;&nbsp;&nbsp;&nbsp;</span>
            <input type="text" class="form-control"  name="buildings.logo" placeholder="请输入logo" >
        </div>
        <div class="input-group col-xs-4">
            <span class="input-group-addon">&nbsp;&nbsp;简&nbsp;&nbsp;介:&nbsp;&nbsp;</span>
            <input type="text" class="form-control"  name="buildings.intro" placeholder="请输入简介" >
        </div>
        <div class="input-group col-xs-4">
            <span class="input-group-addon">创建时间</span>
            <input type="text" class="form-control"  name="buildings.created_time" placeholder="请输入创建时间" >
        </div>



        <button type="submit" class="btn btn-primary">保存</button>
    </form>
    </form>
</div>

</body>
<link href="<%=path%>/public/css/bootstrap.min.css" rel="stylesheet">
<link href="<%=path%>/public/agency/css/public.css" rel="stylesheet">
<link href="<%=path%>/public/agency/css/validator.css" rel="stylesheet">
<link href="<%=path%>/public/agency/css/completer.css" rel="stylesheet">
<link href="<%=path%>/public/agency/jedate/skin/jedate.css" rel="stylesheet">
<link href="<%=path%>/public/agency/css/date.css" type="text/css" rel="stylesheet">
<link href="<%=path%>/public/agency/css/magic-check.css" rel="stylesheet" >
<link href="<%=path%>/public/agency/css/jquery-ui.css" rel="stylesheet">
<link href="<%=path%>/public/agency/css/index.css" rel="stylesheet">
<script src="<%=path%>/public/js/jquery.min.js"></script>
<script src="<%=path%>/public/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=path%>/public/agency/jedate/jedate.js"></script>
<script type="text/javascript" src="<%=path%>/public/agency/js/date.js"></script>
<script type="text/javascript" src="<%=path%>/public/agency/js/jquery-validate.js"></script>
<script type="text/javascript" src="<%=path%>/public/agency/js/validator.js"></script>
<script type="text/javascript" src="<%=path%>/public/agency/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="<%=path%>/public/agency/js/index.js"></script>
</html>
