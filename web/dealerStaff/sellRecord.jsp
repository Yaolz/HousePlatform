<%--
  Created by IntelliJ IDEA.
  User: ID.LQF
  Date: 2017/8/28
  Time: 8:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
    String path = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
    <title>销售记录信息</title>
    <link rel="shortcut icon" href="favicon.ico">
    <link href="<%=path %>/public/css/bootstrap.min14ed.css?v=3.3.6" rel="stylesheet">
    <link href="<%=path %>/public/css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
    <link href="<%=path %>/public/css/plugins/iCheck/custom.css" rel="stylesheet">
    <link href="<%=path %>/public/css/animate.min.css" rel="stylesheet">
    <link href="<%=path %>/public/css/style.min862f.css?v=4.1.0" rel="stylesheet">
    <script src="<%=path %>/public/tanchuang/sweetalert-master/dist/sweetalert-dev.js"></script>
    <link rel="stylesheet" href="<%=path %>/public/tanchuang/sweetalert-master/dist/sweetalert.css">
    <script src="<%=path%>/public/angular/angular.min.js"></script>
    <link href="<%=path%>/public/admin/css/bootstrap-datetimepicker.css" rel="stylesheet">
    <style>
        .error{
            color:red;
        }
    </style>
</head>
<body ng-app="myApp">
<input type="hidden" id="path" value="<%=path%>">
<div ng-controller="myCtrl">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">

                    <table class="table table-striped">
                        <thead>
                        <th colspan="6">
                            <button type="button" class="btn btn-primary" data-toggle="modal"  ng-click="check($index);" >查看资料</button>
                            <button type="button" class="btn btn-primary" data-toggle="modal"  ng-click="recompose($index);" >修改资料</button>
                            <button type="button" class="btn btn-primary" onclick="changeYes();">激活</button>
                            <button type="button" class="btn btn-danger" onclick="changeNo();">冻结</button>
                        </th>
                        <th>
                            <button type="button" class="btn btn-primary"  onclick="history.go(0)">刷新</button>
                        </th>
                        </thead>
                        <tr>
                            <th style="width: 20px;"><input type="checkbox"/></th>
                            <th>客户名称</th>
                            <th>销售单价</th>
                            <th>销售折扣</th>
                            <th>销售总价</th>
                            <th>销售时间</th>
                            <th>状态</th>
                        </tr>
                        <tbody>
                        <tr ng-repeat="sale in sales">
                            <td>
                                <input type="checkbox" title="{{$index}}" name="saleId" id="saleId" value="{{sale.id}}"/>
                            </td>
                            <td>{{sale.customer.name}}</td>
                            <td>{{sale.unit_price }}</td>
                            <td>{{sale.discount}}</td>
                            <td>{{sale.total_cost}}</td>
                            <td>{{sale.sale_time | date:'yyyy-MM-dd hh:mm'}}</td>
                            <td>
                                <span style="color:#2dc25e;" ng-show="{{sale.status == '1' }}">已激活</span>

                                <span style="color:red;" ng-show="{{sale.status == '0' }}">已冻结</span>
                            </td>
                        </tr>
                        <tbody>
                    </table>

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
                        <li ><a class="page" ng-show="count1>0" ng-click="page(count1)" title="{{count1}}">{{count1}}</a></li>
                        <li><a class="page" ng-show="count1>0 && totalPageSize-1>= count1" ng-click="page(count1+1)"  >{{count1+1}}</a></li>
                        <li><a class="page" ng-show="count1>0 && (totalPageSize-2) >= count1" ng-click="page(count1+2)"  >{{count1+2}}</a></li>
                        <li><a class="page" ng-show="count1<3 && (totalPageSize-3) >= count1" ng-click="page(count1+3)"  >{{count1+3}}</a></li>
                        <li><a class="page" ng-show="count1<2 && (totalPageSize-4) >= count1" ng-click="page(count1+4)"  >{{count1+4}}</a></li>
                        <li   ng-click="down()"><a >»</a></li>
                    </ul>
                </nav>
            </div>
        </div>

        <!--查看销售记录信息的模态框-->
        <div class="modal fade" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel1">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel1">查看销售记录信息</h4>
                    </div>
                    <div class="modal-body">
                        <form class="form-horizontal" id="changeType" method="post">
                            <input type="hidden" name="sales.id" id="id"/>
                            <div class="form-group">
                                <label for="cus_name" class="col-sm-3 control-label">客户姓名：</label>
                                <div class="col-sm-7">
                                    <input type="text" class="form-control" style="background:rgba(0, 0, 0, 0);" id="cus_name" readonly>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="cus_gender" class="col-sm-3 control-label">客户性别：</label>
                                <div class="col-sm-7">
                                    <input type="text" class="form-control" style="background:rgba(0, 0, 0, 0);" id="cus_gender" readonly>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="cus_phone" class="col-sm-3 control-label">客户手机：</label>
                                <div class="col-sm-7">
                                    <input type="text" class="form-control" style="background:rgba(0, 0, 0, 0);" id="cus_phone" readonly>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="cus_address" class="col-sm-3 control-label">客户地址：</label>
                                <div class="col-sm-7">
                                    <input type="text" class="form-control" style="background:rgba(0, 0, 0, 0);" id="cus_address" readonly>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="room_buliding_name" class="col-sm-3 control-label">所属楼栋：</label>
                                <div class="col-sm-7">
                                    <input type="email" class="form-control" style="background:rgba(0, 0, 0, 0);" id="room_buliding_name" readonly>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="room_name" class="col-sm-3 control-label">客户房号：</label>
                                <div class="col-sm-7">
                                    <input type="text" class="form-control" style="background:rgba(0, 0, 0, 0);" id="room_name" readonly>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="unit_price1" class="col-sm-3 control-label">销售单价：</label>
                                <div class="col-sm-7">
                                    <input type="text" class="form-control" style="background:rgba(0, 0, 0, 0);" id="unit_price1" readonly>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="discount1" class="col-sm-3 control-label">销售折扣：</label>
                                <div class="col-sm-7">
                                    <input type="text" class="form-control" style="background:rgba(0, 0, 0, 0);" id="discount1" readonly>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="total_cost1" class="col-sm-3 control-label">销售总价：</label>
                                <div class="col-sm-7">
                                    <input type="text" class="form-control" style="background:rgba(0, 0, 0, 0);" id="total_cost1" readonly>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="sale_time1" class="col-sm-3 control-label">销售时间：</label>
                                <div class="col-sm-7">
                                    <input type="text" class="form-control <%--form_datetime--%>" style="background:rgba(0, 0, 0, 0);" id="sale_time1" readonly>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-primary" data-dismiss="modal">关闭</button>
                                </div>
                            </div>
                        </form>
                    </div>

                </div>
            </div>
        </div>

        <!--修改销售记录信息的模态框-->
        <div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel2">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel2">修改销售记录信息</h4>
                    </div>
                    <div class="modal-body">
                        <form class="form-horizontal" id="register-form" method="post">
                            <input type="hidden" name="sale.id" id="id1"/>

                            <div class="form-group">
                                <label for="cus_name1" class="col-sm-3 control-label">客户姓名：</label>
                                <div class="col-sm-7">
                                    <input type="text" class="form-control" id="cus_name1" readonly="readonly">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="cus_gender1" class="col-sm-3 control-label">客户性别：</label>
                                <div class="col-sm-7">
                                    <input type="text" class="form-control" id="cus_gender1" readonly="readonly">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="cus_phone1" class="col-sm-3 control-label">客户手机：</label>
                                <div class="col-sm-7">
                                    <input type="text" class="form-control" id="cus_phone1" readonly>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="cus_address1" class="col-sm-3 control-label">客户地址：</label>
                                <div class="col-sm-7">
                                    <input type="text" class="form-control" id="cus_address1" readonly>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="room_buliding_name1" class="col-sm-3 control-label">所属楼栋：</label>
                                <div class="col-sm-7">
                                    <input type="text" class="form-control" id="room_buliding_name1" readonly>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="room_name1" class="col-sm-3 control-label">客户房号：</label>
                                <div class="col-sm-7">
                                    <input type="text" class="form-control" id="room_name1" readonly>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="unit_price" class="col-sm-3 control-label">销售单价：</label>
                                <div class="col-sm-7">
                                    <input type="text" class="form-control" name="sale.unit_price" id="unit_price">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="discount" class="col-sm-3 control-label">销售折扣：</label>
                                <div class="col-sm-7">
                                    <input type="text" class="form-control" name="sale.discount" id="discount">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="total_cost" class="col-sm-3 control-label">销售总价：</label>
                                <div class="col-sm-7">
                                    <input type="text" class="form-control" name="sale.total_cost" id="total_cost">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="sale_time" class="col-sm-3 control-label">销售时间：</label>
                                <div class="col-sm-7">
                                    <input type="text" class="form-control form_datetime" name="sale.sale_time" id="sale_time">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                                    <input type="button" class="btn btn-primary" onclick="sellSave();" value="保存"/>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<form method="post" id="formid">
    <input type="hidden" name="sale.id" id="checkedIds"/>
    <input type="hidden" name="sale.status" id="status"/>
</form>


<script src="<%=path %>/public/js/jquery.min.js?v=2.1.4"></script>
<script src="<%=path %>/public/js/bootstrap.min.js?v=3.3.6"></script>
<script src="<%=path %>/public/js/plugins/peity/jquery.peity.min.js"></script>
<script src="<%=path %>/public/js/content.min.js?v=1.0.0"></script>
<script src="<%=path %>/public/js/plugins/iCheck/icheck.min.js"></script>
<script src="<%=path %>/public/js/demo/peity-demo.min.js"></script>
<%--<script  src="<%=path%>/public/userRegister/jedate/jedate.js"></script>--%>
<script src="<%=path%>/public/agency/js/jquery-validate.js"></script>
<script src="<%=path %>/public/admin/js/bootstrap-datetimepicker.js"></script>
<script src="<%=path %>/public/admin/js/bootstrap-datetimepicker.zh-CN.js"></script>
<script>
    $('.form_datetime').datetimepicker({
        language: 'zh-CN',
        format: 'yyyy-mm-dd hh:ii',
        weekStart: 1,
        todayBtn: 1,
        autoclose: 1,
        todayHighlight: 1,
        startView: 2,
        minView: 2,
        forceParse: 0
    });

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
            $scope.sales="";
            $scope.count1=1;
            extracted($scope.count1);
            $scope.dt1 = new Date();
            $scope.dt2 = $filter("date")($scope.dt1, "yyyy-MM-dd HH:mm:ss");

            function extracted(x) {
                $http({
                    method: 'POST',
                    url: "<%=path%>/staff/sellRecordJson",
                    data: {"pageNo": x }
                }).then(function successCallback(response) {
                    $scope.sales = response.data.salePager.result;
                    $scope.total = response.data.salePager.total;
                    $scope.totalPageSize = response.data.salePager.totalPageSize;
                    $scope.count1 = response.data.salePager.pageNo;
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

            //查看
            $scope.check = function (x) {
                if($("input[name='saleId']:checkbox:checked").length == 1) {
                    $("#myModal1").modal("show");
                    $scope.count = $("input[name='saleId']:checkbox:checked").attr("title");
                    $http({
                        method: 'POST',
                        url: "<%=path%>/cus/queryCustomer",
                        data: {"id": $scope.sales[$scope.count].customer.id}
                    }).then(function successCallback(response) {
                        $scope.customer = response.data.customer;
                        $scope.sale_time =  $filter("date")($scope.sales[$scope.count].sale_time, "yyyy-MM-dd HH:mm:ss");
                        $("#id").val($scope.sales[$scope.count].id);
                        $("#unit_price1").val($scope.sales[$scope.count].unit_price);
                        $("#discount1").val($scope.sales[$scope.count].discount);
                        $("#total_cost1").val($scope.sales[$scope.count].total_cost);
                        $("#sale_time1").val($scope.sale_time);
                        $("#created_time").val($scope.sales[$scope.count].created_time);
                        $("#cus_name").val($scope.customer.name);
                        $("#cus_gender").val($scope.customer.gender);
                        $("#cus_phone").val($scope.customer.phone);
                        $("#cus_address").val($scope.customer.address);
                        $("#room_name").val($scope.sales[$scope.count].room.name);
                        $("#room_buliding_name").val($scope.sales[$scope.count].room.building.name);
                    }, function errorCallback(response) {

                    });
                } else {
                    swal({
                        title: '请选择一行',
                        text: "请选择一行",
                        type: 'error',
                    })
                }

            };

            //修改
            $scope.recompose = function (x) {
                if($("input[name='saleId']:checkbox:checked").length == 1) {
                    $("#myModal2").modal("show");
                    $scope.count=$("input[name='saleId']:checkbox:checked").attr("title");
                    $http({
                        method: 'POST',
                        url: "<%=path%>/cus/queryCustomer",
                        data: {"id": $scope.sales[$scope.count].customer.id}
                    }).then(function successCallback(response) {
                        $scope.customer = response.data.customer;
                        $scope.sale_time =  $filter("date")($scope.sales[$scope.count].sale_time, "yyyy-MM-dd HH:mm:ss");
                        $("#id1").val($scope.sales[$scope.count].id);
                        $("#agency_id").val($scope.sales[$scope.count].agency_id);
                        $("#customer_id").val($scope.sales[$scope.count].customer_id);
                        $("#emp_id").val($scope.sales[$scope.count].emp_id);
                        $("#room_id").val($scope.sales[$scope.count].room_id);
                        $("#unit_price").val($scope.sales[$scope.count].unit_price);
                        $("#discount").val($scope.sales[$scope.count].discount);
                        $("#total_cost").val($scope.sales[$scope.count].total_cost);
                        $("#sale_time").val($scope.sale_time);
                        $("#created_time1").val($scope.sales[$scope.count].created_time);
                        $("#cus_name1").val($scope.customer.name);
                        $("#cus_gender1").val($scope.customer.gender);
                        $("#cus_phone1").val($scope.customer.phone);
                        $("#cus_address1").val($scope.customer.address);
                        $("#room_name1").val($scope.sales[$scope.count].room.name);
                        $("#room_buliding_name1").val($scope.sales[$scope.count].room.building.name);
                    }, function errorCallback(response) {

                    });
                } else {
                    swal({
                        title: '请选择一行',
                        text: "请选择一行",
                        type: 'error',
                    })
                }

            };

        });

    }(jQuery));

    function changeYes() {
        var chk_value = [];
        $('input[name="saleId"]:checked').each(function () {
            chk_value.push($(this).val());
        });
        if (chk_value.length == 0) {
            swal("请选择一行！");
        } else {
            $('#checkedIds').val(chk_value);
            $('#status').val(0);
            $('#formid').prop("action", "<%=path %>/cus/saleStatus").submit();
        }
    }

    function changeNo() {
        var chk_value =[];
        $('input[name="saleId"]:checked').each(function(){
            chk_value.push($(this).val());
        });
        if(chk_value.length == 0) {
            swal("请选择一行！");
        } else{
            $('#checkedIds').val(chk_value);
            $('#status').val(1);
            $('#formid').prop("action", "<%=path %>/cus/saleStatus").submit();
        }
    }

</script>
<script>
    $(function(){
        $("#register-form").validate();

        //销售时间
//        if($("#sale_time").get(0)){
//            jeDate({
//                dateCell:"#sale_time",
//                format:"YYYY-MM-DD",
//                minDate:"1900-1-1",
//                maxDate:"2099-12-31 23:59:59",
//                ishmsVal:false
//            });
//        };
//        $("#sale_time").trigger("click");
//        $("body").trigger("click");
        $("#sale_time").rules('add',{
            required:true,
//            date:true,
            messages:{
                required:'请选择时间，如1993-03-29！',
//                date:'时间格式不正确'
            }

        });
        //参考单价
        $("#unit_price").rules('add',{
            required:true,
            maxlength:10,
            unit_price:true,
            messages:{
                required:'请输入参考单价！',
                maxlength:'超出了范围！',
                unit_price:'单价输入错误'
            }
        });
        //参考总价
        $("#total_cost").rules('add',{
            required:true,
            maxlength:10,
            total_cost:true,
            messages:{
                required:'请输入参考单价！',
                maxlength:'超出了范围！',
                total_cost:'总价输入有误'
            }
        });
        //销售折扣
        $("#discount").rules('add',{
            required:true,
            maxlength:10,
            discount:true,
            messages:{
                required:'请输入参考单价！',
                maxlength:'超出了范围！',
                discount:'销售折扣输入错误'
            }
        });
        //销售时间
        $.validator.addMethod('date',function(value,element){
            var date = /^(19|20)\d{2}-(1[0-2]|0?[1-9])-(0?[1-9]|[1-2][0-9]|3[0-1])$/;
            return this.optional(element)||(date.test(value));
        });
        //参考单价
        $.validator.addMethod('unit_price',function(value,element){
            var unit_price =  /^[0-9]*$/;
            return this.optional(element)||(unit_price.test(value));
        });
        //参考总价
        $.validator.addMethod('total_cost',function(value,element){
            var total_cost =  /^[0-9]*$/;
            return this.optional(element)||(total_cost.test(value));
        });
        //销售折扣
        $.validator.addMethod('discount',function(value,element){
            var discount =  /^[0-9]*$/;
            return this.optional(element)||(discount.test(value));
        });
    });
</script>
<script>
    function sellSave() {
        if ($("#register-form").valid()==true) {
            $.post("<%=path %>/cus/sellSave",
                $("#register-form").serialize(),
                function (data) {
                    if (data.result.result == "success") {
                        window.location.href= "<%=path %>/dealerStaff/sellRecord.jsp";
                    } else {
                        alert(data.result.msg);
                    }
                }, "json"
            );
        }
    }
</script>
</body>
</html>
