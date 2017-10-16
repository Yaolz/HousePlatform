<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%><!DOCTYPE html>
<html>
<head>
    <title>Title</title>
</head>
<link href="<%=path%>/public/css/bootstrap.min.css" rel="stylesheet">
<link href="<%=path%>/public/admin/css/admincheck.css" rel="stylesheet">
<style>
    * {
        list-style: none;
    }

    .agency_ul ul {
        height: 35px;
        font-family: "楷体";
        font-size: 20px;
        border-bottom: 1px solid #d7d4f0;
    }

    .agency_div {
        height: 40%;
        border-left: 1px solid #d7d4f0;
        padding-top: 18.5px;
    }

</style>
<body>
<%@include file="main/toubu.jsp" %>
<div class="container">
    <div class="row">
        <div class="col-md-10 col-md-offset-1">
            <div class="row">
                <div class="col-md-6">
                    <c:choose>
                        <c:when test="${agency.logo == null  }">
                            <img style="width: 400px;height: auto;"
                                 src="<%=path %>/public/admin/timg.gif"/>
                        </c:when>
                        <c:otherwise>
                            <a href="#">
                                <img src="<%=path %>/${agency.logo }" alt="${agency.name }"
                                     title="${agency.name }" width="400px;"/>
                            </a>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="col-md-6">
                    <div><h1>我是经销商</h1></div>
                    <div>老板</div>
                    <div style="border-top: 1px #CCC dotted;">
                        <address>
                            <strong>经销商地址</strong><br>
                            邮箱：${agency.email }<br>
                            <abbr title="Phone">服务热线:</abbr>${agency.tel }
                        </address>
                    </div>
                    <div width="70%">
                        经销商描述：23456789dfghjk
                    </div>
                </div>
            </div>
            <div style="height: 30px;">
            </div>
            <c:forEach items="${buildings}"></c:forEach>
            <div class="col-md-10">
                <div class="row">
                    <div class="col-md-5">
                        <c:choose>
                            <c:when test="${buildings.logo == null  }">
                                <img style="width: 250px;height: auto;"
                                     src="<%=path %>/public/admin/timg.gif"/>
                            </c:when>
                            <c:otherwise>
                                <a href="#">
                                    <img src="<%=path %>/${buildings.logo }" alt="${buildings.name }"
                                         title="${buildings.name }" width="250px;"/>
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="col-md-7">
                        <div><h1>我是楼盘</h1></div>
                        <div>老板</div>
                        <div style="border-top: 1px #CCC dotted;">
                            <address>
                                <strong>楼盘地址</strong><br>
                                邮箱：2333@qq.com<br>
                                <abbr title="Phone">电话:</abbr>${buildings.tel }
                            </address>
                        </div>
                        <div width="70%">
                            价格：很便宜
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-2">
                放各种楼盘的广告
            </div>
        </div>
    </div>
</div>
</div>
</body>
<script src="<%=path%>/public/js/jquery.min.js"></script>
<script src="<%=path%>/public/js/bootstrap.min.js"></script>
</html>
