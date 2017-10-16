<%--
  Created by IntelliJ IDEA.
  User: ID.LQF
  Date: 2017/8/28
  Time: 8:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
    String path = request.getContextPath();
%><!DOCTYPE html>
<html>
<head>
    <title>所有客户</title>
    <link href="<%=path%>/public/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%=path%>/public/admin/css/admincheck.css" rel="stylesheet">
    <script src="<%=path%>/public/angular/angular.min.js"></script>
    <link href="<%=path%>/public/admin/css/bootstrap-datetimepicker.css" rel="stylesheet">
    <style>
        .error{
            color: #ff1236;
        }
        .btn-primary {
            background-color: #1ab394;
            border-color: #1ab394;
            color: #FFF;
        }
    </style>
</head>
<body ng-app="myApp">
<input type="hidden" id="path" value="<%=path%>">
<div ng-controller="myCtrl">
    <div class="container">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class=" table table-responsive container">
                        <table class="table table-striped">
                            <thead>
                            <th colspan="9">
                                <button type="button" class="btn btn-primary" ng-click="changeYes();">激活</button>
                                <button type="button" class="btn btn-primary" ng-click="changeNo();">冻结</button>
                                <button type="button" class="btn btn-primary"   ng-click="recompose();">修改资料</button>
                                <button type="button" class="btn btn-primary"   ng-click="contract();">购房合同上传</button>
                                <button type="button" class="btn btn-primary"   ng-click="archives();">档案上传</button>
                                <button type="button" class="btn btn-primary"   ng-click="DownloadContract();">购房合同下载</button>
                                <button type="button" class="btn btn-primary"   ng-click="DownloadArchives();">档案下载</button>
                                <button type="button" class="btn btn-primary"  id="update" >刷新</button>
                            </th>
                            <th>
                                <select class="form-control"   id="district" name="buildingsPrice.id">
                                    <option  value="所有楼盘">所有楼盘</option>
                                    <option ng-repeat="bui in buildingsPriceList"   value="{{bui.id}}">{{bui.name}}</option>
                                </select>
                            </th>
                            <th>
                                <select class="form-control" style="list-style: none;" id="status" name="status">
                                    <option value="3">所有客户</option>
                                    <option value="1">已激活客户</option>
                                    <option value="0">已冻结客户</option>
                                </select>
                            </th>
                            </thead>
                            <tr>
                                <th ><input type="checkbox" id="checkall"  ng-click="checkall()"/></th>
                                <th>客户名称</th>
                                <th>客户性别</th>
                                <th>客户生日</th>
                                <th>身份证号</th>
                                <th>客户邮箱</th>
                                <th>客户地址</th>
                                <th>联系方式</th>
                                <th>预约类型</th>
                                <th>合租人</th>
                                <th>状态</th>
                            </tr>
                            <tbody>
                            <tr ng-repeat="cus in customers">
                                <td>
                                    <input type="checkbox" title="{{$index}}" name="cusCheckId" id="cusCheckId" value="{{cus.id}}"/>
                                </td>
                                <td>{{cus.name}}</td>
                                <td>{{cus.gender}}</td>
                                <td>{{cus.birthday | date:'yyyy-MM-dd '}}</td>
                                <td>{{cus.identity_id}}</td>
                                <td>{{cus.email}}</td>
                                <td>{{cus.address }}</td>
                                <td>{{cus.phone}}</td>
                                <td>{{cus.customer_type}}</td>
                                <td>{{cus.together}}</td>
                                <td>
                                    <span style="color:#2dc25e;" ng-show="{{cus.status == '1' }}">已激活</span>

                                    <span style="color:red;" ng-show="{{cus.status == '0' }}">已冻结</span>
                                </td>
                            </tr>
                            <tbody>
                        </table>
                    </div>
                </div>
            </div>

        </div>

        <div class="row">
            <div class="col-sm-2">
                共 {{total}} 个用户，共{{totalPageSize}}页
            </div>
            <div class="col-sm-10">
                <nav aria-label="Page navigation" class="pull-right">
                    <ul class="pagination">
                        <li  ng-click="top()"><a >«</a></li>
                        <li><a class="page" ng-show="count1>=5 " ng-click="page(count1-4)">{{count1-4}}</a></li>
                        <li><a class="page" ng-show="count1>=4 " ng-click="page(count1-3)">{{count1-3}}</a></li>
                        <li><a class="page" ng-show="count1>=3 " ng-click="page(count1-2)">{{count1-2}}</a></li>
                        <li><a class="page" ng-show="count1>=2 " ng-click="page(count1-1)">{{count1-1}}</a></li>
                        <li class="active"><a class="page" ng-show="count1>0" ng-click="page(count1)" title="{{count1}}">{{count1}}</a></li>
                        <li><a class="page" ng-show="count1>0 && totalPageSize-1>= count1" ng-click="page(count1+1)"  >{{count1+1}}</a></li>
                        <li><a class="page" ng-show="count1>0 && (totalPageSize-2) >= count1" ng-click="page(count1+2)"  >{{count1+2}}</a></li>
                        <li><a class="page" ng-show="count1<3 && (totalPageSize-3) >= count1" ng-click="page(count1+3)"  >{{count1+3}}</a></li>
                        <li><a class="page" ng-show="count1<2 && (totalPageSize-4) >= count1" ng-click="page(count1+4)"  >{{count1+4}}</a></li>
                        <li   ng-click="down()"><a >»</a></li>
                    </ul>
                </nav>
            </div>
        </div>

        <!--修改客户信息的模态框-->
        <div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel2">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel2">修改客户信息</h4>
                    </div>
                    <div class="modal-body">
                        <form class="form-horizontal" id="register-form" method="post">
                            <input type="hidden" id="id1" name="customer.id">
                            <input type="hidden" name="customer.email" id="email1"/>
                            <input type="hidden" id="statu1" name="customer.status">
                            <div class="form-group">
                                <label for="name" class="col-sm-3 control-label">姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名：</label>
                                <div class="col-sm-7">
                                    <input type="text" class="form-control" name="customer.name" id="name">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="gender1" class="col-sm-3 control-label">性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别：</label>
                                <div class="col-sm-7">
                                    <select class="form-control" name="customer.gender" id="gender1">
                                        <option>男</option>
                                        <option>女</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="birthday" class="col-sm-3 control-label">生&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日：</label>
                                <div class="col-sm-7">
                                    <input type="text" class="form-control form_datetime" name="customer.birthday" style="background:rgba(0, 0, 0, 0);" id="birthday" placeholder="请输入客户的生日" readonly>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="identity_id" class="col-sm-3 control-label">身&nbsp;&nbsp;份&nbsp;&nbsp;证&nbsp;&nbsp;&nbsp;&nbsp;号：</label>
                                <div class="col-sm-7">
                                    <input type="text" class="form-control" name="customer.identity_id" id="identity_id">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="phone" class="col-sm-3 control-label">手&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;机：</label>
                                <div class="col-sm-7">
                                    <input type="text" class="form-control" name="customer.phone" id="phone">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="address1" class="col-sm-3 control-label">联&nbsp;&nbsp;系&nbsp;&nbsp;地&nbsp;&nbsp;址：</label>
                                <div class="col-sm-7">
                                    <input type="text" class="form-control" name="customer.address" id="address1">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="customer_type1" class="col-sm-3 control-label">客&nbsp;&nbsp;户&nbsp;&nbsp;类&nbsp;&nbsp;型：</label>
                                <div class="col-sm-7">
                                    <select class="form-control" name="customer.customer_type" id="customer_type1">
                                        <option>预约客户</option>
                                        <option>预定客户</option>
                                        <option>购房客户</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="together1" class="col-sm-3 control-label">共&nbsp;&nbsp;同&nbsp;&nbsp;购&nbsp;&nbsp;房&nbsp;&nbsp;人：</label>
                                <div class="col-sm-7">
                                    <input type="text" class="form-control" name="customer.together" id="together1">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                                    <input type="button" class="btn btn-primary" id="cusSave"  value="保存">
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!--电子版购房合同上传-->
        <div class="modal fade" id="myModal3" tabindex="-1" role="dialog" aria-labelledby="myModalLabel3">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel3">电子版购房合同上传</h4>
                    </div>
                    <div class="modal-body">
                        <form class="form-horizontal" id="register-form3" method="post">
                            <input type="hidden" id="id3" name="customer.id">
                            <input type="hidden" id="contract3" name="customer.contract">
                            <div class="form-group">
                                <label for="picID" class="col-sm-3 control-label">上传 ：</label>
                                <div class="fileinput fileinput-new col-sm-7" data-provides="fileinput"  id="exampleInputUpload">
                                    <div id="imgs">
                                    <span class="btn btn-file ">
                                        <input  class="form-control " type="file" name="upload" id="picID" />
                                    </span>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                                    <input type="button" class="btn btn-primary"  ng-click="contractAjax($event)" value="上传">
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!--zip版电子档案上传-->
        <div class="modal fade" id="myModal4" tabindex="-1" role="dialog" aria-labelledby="myModalLabel4">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel4">zip版电子档案上传</h4>
                    </div>
                    <div class="modal-body">
                        <form class="form-horizontal" id="register-form4" method="post">
                            <input type="hidden" id="id4" name="customer.id">
                            <input type="hidden" id="archives" name="customer.archives">
                            <div class="form-group">
                                <label for="picID" class="col-sm-3 control-label">上传 ：</label>
                                <div class="fileinput fileinput-new col-sm-7" data-provides="fileinput"  id="exampleInputUpload1">
                                    <div>
                                    <span class="btn btn-file ">
                                        <input  class="form-control " type="file" name="upload1" />
                                    </span>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                                    <input type="button" class="btn btn-primary"  ng-click="archivesAjax($event)" value="上传">
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

<script src="<%=path %>/public/js/jquery.min.js"></script>
<script src="<%=path%>/public/jquery-from/jquery-from.js"></script>
<script src="<%=path %>/public/js/bootstrap.min.js"></script>
<script src="<%=path%>/public/agency/js/jquery-validate.js"></script>
<script src="<%=path %>/layer-v3.1.0/layer/layer.js"></script>
<script src="<%=path %>/public/admin/js/bootstrap-datetimepicker.js"></script>
<script src="<%=path %>/public/admin/js/bootstrap-datetimepicker.zh-CN.js"></script>
<script>
    $('.form_datetime').datetimepicker({
        language: 'zh-CN',
        format: 'yyyy-mm-dd',
        weekStart: 1,
        todayBtn: 1,
        autoclose: 1,
        todayHighlight: 1,
        startView: 2,
        minView: 2,
        forceParse: 0
    });
    $('#birthday').datetimepicker('setEndDate',new Date());
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
        app.controller('myCtrl', function($scope,$http,$timeout,$filter) {

            $scope.total=0;
            $scope.totalPageSize=0;
            $scope.customers="";
            $scope.count1=1;
            $scope.dt1 = new Date();
            $scope.dt2 = $filter("date")($scope.dt1, "yyyy-MM-dd");

            $http({
                method: 'POST',
                url: "<%=path%>/buildings/queryBuildingsPrice"
            }).then(function successCallback(response) {
                $scope.buildingsPriceList = response.data.buildingsPriceList;
                $timeout(function(){
                    extracted($scope.count1);
                },100);
            }, function errorCallback(response) {

            });

            function extracted(x) {
                var index = layer.load(0, {shade: false});//发送请求时让页面出现加载样式
                $http({
                    method: 'POST',
                    url: "<%=path%>/cus/cusCheckJson",
                    data: {"pageNo": x,"status": $("#status").val(),"buildings_id": $("#district").val()}
                }).then(function successCallback(response) {
                    $scope.customers = response.data.cusPager.result;
                    $scope.total = response.data.cusPager.total;
                    $scope.totalPageSize = response.data.cusPager.totalPageSize;
                    $scope.count1 = response.data.cusPager.pageNo;
                    layer.close(index);//关闭加载窗口
                    if($("#checkall").is(':checked')==true){
                        $("#checkall").prop("checked",false);
                    }
                }, function errorCallback(response) {

                });

            }

            $scope.page = function (x) {//点击页号事件
                if($scope.count1==x){
                    return;
                }
                extracted(x);
            };

            $scope.down = function() {//下一页
                if($scope.count1==$scope.totalPageSize){
                    return;
                }
                extracted($scope.count1+1);
            };
            $scope.top = function () {//上一页

                if ($scope.count1 == 1) {
                    return;
                }
                extracted($scope.count1-1);
            };

            //修改资料
            $scope.recompose = function () {
                if($("input[name='cusCheckId']:checkbox:checked").length == 1) {
                    $("#myModal2").modal("show");
                    $scope.count=$("input[name='cusCheckId']:checkbox:checked").attr("title");
                    $scope.birthday =  $filter("date")($scope.customers[$scope.count].birthday, "yyyy-MM-dd");
                    $("#id1").val($scope.customers[$scope.count].id);
                    $("#name").val($scope.customers[$scope.count].name);
                    $("#gender1").val($scope.customers[$scope.count].gender);
                    $("#birthday").val($scope.birthday);
                    $("#identity_id").val($scope.customers[$scope.count].identity_id);
                    $("#email1").val($scope.customers[$scope.count].email);
                    $("#phone").val($scope.customers[$scope.count].phone);
                    $("#address1").val($scope.customers[$scope.count].address);
                    $("#customer_type1").val($scope.customers[$scope.count].customer_type);
                    $("#together1").val($scope.customers[$scope.count].together);
                    $("#created_time").val($scope.customers[$scope.count].created_time);
                    $("#statu1").val($scope.customers[$scope.count].status);
                } else {
                    layer.msg("请选择一行!");
                }
            };

            //电子版购房合同上传
            $scope.contract = function () {
                if($("input[name='cusCheckId']:checkbox:checked").length == 1) {
                    $("#myModal3").modal("show");
                    $scope.count=$("input[name='cusCheckId']:checkbox:checked").attr("title");
                    $("#id3").val($scope.customers[$scope.count].id);
                    $("#contract3").val($scope.customers[$scope.count].contract);
                } else {
                    layer.msg("请选择一行!");
                }
            };
            //电子版购房合同下载
            $scope.DownloadContract = function () {
                if($("input[name='cusCheckId']:checkbox:checked").length == 1) {
                    $scope.count=$("input[name='cusCheckId']:checkbox:checked").attr("title");
                    if($scope.customers[$scope.count].contract!= null && $scope.customers[$scope.count].contract!= ''){
                        window.location.href="<%=path%>/download/down?name="+$scope.customers[$scope.count].contract;
                    }else if($scope.customers[$scope.count].contract == null && $scope.customers[$scope.count].contract == ''){
                        layer.msg("此客户还无合同可下载!");
                    }else {
                        layer.msg("此客户还无合同可下载!");
                    }
                } else {
                    layer.msg("请选择一行!");
                }
            };

            //zip版电子档案上传
            $scope.archives = function () {
                if($("input[name='cusCheckId']:checkbox:checked").length == 1) {
                    $("#myModal4").modal("show");
                    $scope.count=$("input[name='cusCheckId']:checkbox:checked").attr("title");
                    $("#id4").val($scope.customers[$scope.count].id);
                    $("#archives4").val($scope.customers[$scope.count].archives);
                } else {
                    layer.msg("请选择一行!");
                }
            };
            //zip版电子档案下载
            $scope.DownloadArchives = function () {
                if($("input[name='cusCheckId']:checkbox:checked").length == 1) {
                    $scope.count=$("input[name='cusCheckId']:checkbox:checked").attr("title");
                    if($scope.customers[$scope.count].archives!= null && $scope.customers[$scope.count].archives!= ''){
                        window.location.href="<%=path%>/download/down?name="+$scope.customers[$scope.count].archives;
                    }else if($scope.customers[$scope.count].archives == null && $scope.customers[$scope.count].archives == ''){
                        layer.msg("此客户还无文档可下载!");
                    }else {
                        layer.msg("此客户还无文档可下载!");
                    }
                } else {
                    layer.msg("请选择一行!");
                }
            };
            //电子版购房合同上传ajax
            $scope.contractAjax = function() {
                $('#register-form3').ajaxSubmit({
                    url: '<%=path %>/cus/contract',
                    type: 'POST',
                    data: $("#register-form3").serialize(),
                    success: function (data) {
                        $("#myModal3").modal("hide");
                        $timeout(function(){//用jquery时不会自动渲染，只能手动渲染就调用此方法,
                            if(data.result.result =='success'){
                                $scope.customers[$scope.count].contract = data.customer.contract;
                                layer.msg(data.result.msg);
                            }else {

                            }
                        },0);
                    }
                });
            };

            //  zip版电子档案上传ajax
            $scope.archivesAjax = function() {
                $('#register-form4').ajaxSubmit({
                    url: '<%=path %>/cus/archives',
                    type: 'POST',
                    data: $("#register-form4").serialize(),
                    success: function (data) {
                        $("#myModal4").modal("hide");
                        $timeout(function(){//用jquery时不会自动渲染，只能手动渲染就调用此方法,
                            if(data.result.result =='success'){
                                $scope.customers[$scope.count].archives =data.customer.archives;
                                layer.msg(data.result.msg);
                            }else {
                                layer.msg(data.result.msg);
                            }
                        },0);
                    }
                });
            };
            $scope.checkall=function () {//全选和取消全选
                if($("#checkall").is(':checked')==true){
                    $("input[name='cusCheckId']").prop("checked",true);
                }else {
                    $("input[name='cusCheckId']").prop("checked", false);
                }
            };


            $("#cusSave").click(function(){//修改信息返回修改后的信息
                if ($("#register-form").valid()==true) {
                    $.post("<%=path %>/cus/cusSave",
                        $("#register-form").serialize(),
                        function (data) {
                            if(data.result.result =='success'){
                                $timeout(function() {//用jquery时不会自动渲染，只能手动渲染就调用此方法,
                                    $("#myModal2").modal('hide');
                                    $scope.customers[$scope.count] = data.customer;
                                    layer.msg(data.result.msg);
                                },0);
                            }else {
                                layer.msg(data.result.msg);
                            }
                        }, "json"
                    );
                }
            });
            $scope.changeYes= function() { // 只能激活用户，判断等页面完成
                var chk_value = [];
                $('input[name="cusCheckId"]:checked').each(function () {
                    chk_value.push($(this).val());
                });
                if (chk_value.length == 0) {
                    layer.msg("请选择一行！");
                } else {
                    status(1,chk_value);
                }
            };

            $("#status").change(function () {//选择状态时的改变事件
                extracted(1);
            });
            $("#district").change(function () {//选择楼盘时的改变事件
                extracted(1);
            });
            $scope.changeNo = function () { // 只能冻结用户，判断等页面完成
                var chk_value = [];
                $('input[name="cusCheckId"]:checked').each(function () {
                    chk_value.push($(this).val());
                });
                if (chk_value.length == 0) {
                    layer.msg("请选择一行！");
                } else {
                    status(0,chk_value);
                }
            };
            $("#update").click(function(){//刷新数据调用此方法
                var buildingsID = $("#district").val();
                $http({
                    method: 'POST',
                    url: "<%=path%>/buildings/queryBuildingsPrice"
                }).then(function successCallback(response) {
                    $scope.buildingsPriceList = response.data.buildingsPriceList;
                    $timeout(function(){
                        $("#district").val(buildingsID);
                        if($("#district").val()==""||$("#district").val() ==null){
                            $("#district").val("所有楼盘");
                        }
                    },100);
                    $timeout(function(){
                        extracted($scope.count1);
                    },300);
                }, function errorCallback(response) {

                });
                extracted($scope.count1);
            });
            function status(updatestatus,checkedIds) {
                $.ajax({
                    type:'post',
                    traditional :true,
                    url:'<%=path %>/cus/updateStatus',
                    data:{"checkedIds":checkedIds,"pageNo": $scope.count1, "updatestatus": updatestatus,"buildings_id": $("#district").val(),"status": $("#status").val()} ,
                    success:function(data){
                        $timeout(function(){//用jquery时不会自动渲染，只能手动渲染就调用此方法,
                            if(data.result.result =='success'){
                                layer.msg(data.result.msg);
                                $scope.customers = data.cusPager.result;
                                $scope.total = data.cusPager.total;
                                $scope.totalPageSize = data.cusPager.totalPageSize;
                                $scope.count1 = data.cusPager.pageNo;
                            }else {
                                layer.msg(data.result.msg);
                            }
                            if($("#checkall").is(':checked')==true){
                                $("#checkall").prop("checked",false);
                            }
                        },0);
                    }
                });
            }
        });
    }(jQuery));

</script>
<script>
    $(function(){
        $("#register-form").validate();
        //姓名
        $("#name").rules('add',{
            required:true,
            messages:{
                required:'请输入姓名',
            }
        });
        //生日
        if($("#birthday").get(0)){
            jeDate({
                dateCell:"#birthday",
                format:"YYYY-MM-DD",
                minDate:"1900-1-1",
                maxDate:jeDate.now(0),
                ishmsVal:false
            });
        };
        $("#birthday").trigger("click");
        $("body").trigger("click");
        $("#birthday").rules('add',{
            required:true,
//            date:true,
            messages:{
                required:'请选择时间，如1993-03-29！',
//                date:'时间格式不正确'
            }
        });
        //身份证号验证规则
        $("#identity_id").rules('add',{
            required:true,
            maxlength:18,
            minlength:17,
//            identity_id:true,
            messages:{
                required:'请输入身份证号',
                maxlength:'身份证号输入错误',
                minlength:'身份证号输入错误',
//                identity_id: "输入的身份证格式不正确"
            }
        });
        //手机
        $("#phone").rules('add',{
            required:true,
            rangelength:[11,11],
            digits:true,
            phone:true,
            remote: {
                type: "post",
                url: $("#path").val()+"/index/queryByPhone",
                dataType: "json",   //返回格式为json
                async: true,//请求是否异步，默认为异步，这也是ajax重要特性
                data: {
                    phone: function() {
                        return $("#phone").val();
                    }
                },
                dataFilter: function(data) {
                    var jsonstr = eval("("+data+")");
                    if (jsonstr.trues == "true") {
                        return false;
                    }else if(jsonstr.trues == "false"){
                        if($("#agency-phone")!=null&&$("#agency-phone")!=undefined&&$("#agency-phone")!=''&&$("#agency-phone").val()==$("#phone").val()){
                            return false;
                        }
                        return true;
                    }
                }
            },
            messages:{
                required:'请输入您的手机号！',
                rangelength:'请输入正确的手机号！',
                digits:'请输入正确的手机号！',
                phone:'请输入正确的手机号！',
                remote:"该手机号已被注册过了！"
            }
        });
        //生日验证规则
        $.validator.addMethod('date',function(value,element){
            var date = /^(19|20)\d{2}-(1[0-2]|0?[1-9])-(0?[1-9]|[1-2][0-9]|3[0-1])$/;
            return this.optional(element)||(date.test(value));
        });
        //身份证号验证规则
        $.validator.addMethod('identity_id',function(value,element){
            var identity_id =   / ^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|X)$/;
            return this.optional(element)||(identity_id.test(value));
        });
        //手机验证规则
        $.validator.addMethod('phone',function(value,element){
            var phone = /^1[3|4|5|7|8][0-9]\d{8}$/;
            return this.optional(element)||(phone.test(value));
        });
    });
</script>
</body>
</html>
