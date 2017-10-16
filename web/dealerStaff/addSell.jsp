<%--
  Created by IntelliJ IDEA.
  User: ID.LQF
  Date: 2017/8/31
  Time: 20:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%><!DOCTYPE html>
<html>
<head>
    <title>销售记录添加页面</title>
    <link rel="stylesheet" href="<%=path %>/public/css/bootstrap.min.css">
</head>
<body>
<form class="form-horizontal" id="form" style="margin-top: 20px;">
    <div class="form-group">
        <label for="inputGender3" class="col-sm-3 control-label">客户编号：</label>
        <div class="col-sm-7">
            <input type="text" class="form-control" name="customer.gender" id="inputGender3" placeholder="请输入客户的编号">
        </div>
    </div>
    <div class="form-group">
        <label for="birthday" class="col-sm-3 control-label">销售时间：</label>
        <div class="col-sm-7">
            <input type="text" class="form-control" name="customer.birthday" style="background:rgba(0, 0, 0, 0);" id="birthday" placeholder="请输入销售时间" readonly>
        </div>
    </div>
    <div class="form-group">
        <label for="inputIdentity3" class="col-sm-3 control-label">销售单价：</label>
        <div class="col-sm-7">
            <input type="text" class="form-control" name="customer.identity_id" id="inputIdentity3" placeholder="请输入销售单价">
        </div>
    </div>
    <div class="form-group">
        <label for="inputPhone3" class="col-sm-3 control-label">房屋编号：</label>
        <div class="col-sm-7">
            <input type="text" class="form-control" name="customer.phone" id="inputPhone3" placeholder="请输入房屋编号">
        </div>
    </div>
    <div class="form-group">
        <label for="inputAddress3" class="col-sm-3 control-label">销售折扣：</label>
        <div class="col-sm-7">
            <input type="text" class="form-control" name="customer.address" id="inputAddress3" placeholder="请输入销售折扣">
        </div>
    </div>
    <div class="form-group">
        <label for="introduce3" class="col-sm-3 control-label">销售总价：</label>
        <div class="col-sm-7">
            <input type="text" class="form-control" name="customer.address" id="introduce3" placeholder="请输入销售总价">
        </div>
    </div>
    <div class="form-group">
        <label for="inputTogether3" class="col-sm-3 control-label">员工编号：</label>
        <div class="col-sm-7">
            <input type="text" class="form-control" name="customer.together" id="inputTogether3" placeholder="请输入员工编号" >
        </div>
    </div>
    <label class="col-md-3"></label>
    <button class="btn btn-primary col-sm-3" data-toggle="modal" data-target="#myModal" style="margin-top: 10px;margin-bottom: 20px;">取消添加</button>
    <button class="btn btn-primary col-sm-3" data-toggle="modal" data-target="#myModal" style="margin-top: 10px;margin-left: 40px;margin-bottom: 20px;" onclick="add();">确认添加</button>
</form>
</body>
<script src="<%=path %>/public/js/jquery.min.js"></script>
<script src="<%=path %>/public/js/bootstrap.min.js"></script>
</html>
