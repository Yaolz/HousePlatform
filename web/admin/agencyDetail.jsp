<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%><!DOCTYPE html>
<html>
<head>
    <title>经销商</title>
</head>
<link href="<%=path%>/public/css/bootstrap.min.css" rel="stylesheet">
<link href="<%=path%>/public/admin/css/admincheck.css" rel="stylesheet">
<script src="<%=path%>/public/angular/angular.min.js"></script>
<body>
<div class="container">
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox float-e-margins">
                <div class="row">
                    <div class="col-xs-1">
                    </div>
                    <div class="col-xs-10 text-center" style="border: 1px solid #d7d4f0;">
                        <p class="text-center" style="font-size: 22px;font-family:楷体;">
                            经销商名称：${requestScope.agency.name }</p>
                        <div class="col-xs-4">
                            <c:choose>
                                <c:when test="${requestScope.agency.logo == null  }">
                                    <img style="width: 280px;height: 200px;"
                                         src="<%=path %>/public/admin/timg.gif"/>
                                </c:when>
                                <c:otherwise>
                                    <img style="width: 280px;height: 200px;"
                                         src="<%=path %>/${requestScope.agency.logo }"/>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="col-xs-8">
                            <table class="table table-bordered" style="height: 200px;width: 629.5px;">
                                <tr>
                                    <th style="width:100px;">邮箱：</th>
                                    <td>${requestScope.agency.email }</td>
                                </tr>
                                <tr>
                                    <th>固定电话：</th>
                                    <td>${requestScope.agency.phone }</td>
                                </tr>
                                <tr>
                                    <th> 负责人姓名：</th>
                                    <td>${requestScope.agency.leader }</td>
                                </tr>
                                <tr>
                                    <th>负责人电话：</th>
                                    <td>${requestScope.agency.phone }</td>
                                </tr>
                                <tr>
                                    <th> 创建时间：</th>
                                    <td>${requestScope.agency.created_time }</td>
                                </tr>
                            </table>
                        </div>
                        <p class="text-left">简介：${requestScope.agency.intro }</p>
                        <p class="text-right">地址：${requestScope.agency.address }</p>
                    </div>
                    <div class="col-xs-1">
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script src="<%=path%>/public/js/jquery.min.js"></script>
<script src="<%=path%>/public/js/bootstrap.min.js"></script>
<script src="<%=path %>/public/admin/js/tableCheckbox.js"></script>
</html>

