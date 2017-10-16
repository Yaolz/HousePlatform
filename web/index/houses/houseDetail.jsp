<%--
  Created by IntelliJ IDEA.
  User: yao
  Date: 2017/9/16
  Time: 8:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%
    String path = request.getContextPath();
%>
<head>
    <title>Title</title>
</head>
<link href="<%=path%>/public/css/bootstrap.min.css" rel="stylesheet">

<body>
<%@include file="../../main/toubu.jsp" %>
<div class="container">
    <div class="row">
        <div class="col-xs-1">
        </div>
        <div class="col-xs-10">
            <div>
                <a target="_blank" href="http://www.baidu.com">
                    <img src="<%=path %>/public/admin/buildings1.jpg"
                         style="width:975px; height: 280px;margin-top: 20px;">
                </a>
            </div>
        </div>
        <div class="col-xs-1">
        </div>
    </div>

    <div class="row" style="margin-top: 20px">
        <div class="col-xs-1">
        </div>
        <div class="col-xs-10">
            <div class="col-xs-12">
                <div class="col-xs-6">
                    <img src="<%=path %>/${requestScope.house.logo}" width="450px" height="300px">
                </div>
                <div class="col-xs-1"></div>
                <div class="col-xs-5">
                    <h3>${requestScope.house.name}</h3>
                    <h5><a href="">${house.buildingsPrice.name}</a></h5>
                    <p>
                        建筑面积:${requestScope.house.area}㎡
                    </p>
                    <p>
                        参考单价:${requestScope.house.unit_price}元/平米
                    </p>
                    <p>
                        户型简介：${requestScope.house.intro}
                    </p>
                </div>
            </div>
        </div>
        <div class="col-xs-1">
        </div>
    </div>

</div>
<%@include file="../../main/banquan.jsp" %>
</body>
<script src="<%=path%>/public/js/jquery.min.js"></script>
<script src="<%=path%>/public/js/bootstrap.min.js"></script>
<script src="<%=path %>/layer-v3.1.0/layer/layer.js"></script>
<script src="<%=path%>/index/js/index.js"></script>
</html>
