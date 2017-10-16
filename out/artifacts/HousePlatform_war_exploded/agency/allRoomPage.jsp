<%--
  Created by IntelliJ IDEA.
  User: yao
  Date: 2017/9/25
  Time: 8:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html><html>
<%
    String path = request.getContextPath();
%>
<head>
    <title>所有留言</title>
</head>
<link href="<%=path%>/public/css/bootstrap.min.css" rel="stylesheet">
<link href="<%=path%>/public/admin/css/admincheck.css" rel="stylesheet">
<link rel="stylesheet" href="<%=path%>/public/xiangcecss/css/baguetteBox.min.css">
<script src="<%=path%>/public/angular/angular.min.js"></script>
<style type="text/css">
    <%--cut样式主要用于把多出的字给截断--%>
    .cut {
        overflow:hidden;
        text-overflow:ellipsis;
        white-space: nowrap;
    }
    .error{
        color:red;
    }
</style>
<style>
    .btn-primary {
        background-color: #1ab394;
        border-color: #1ab394;
        color: #FFF;
    }
</style>
<body ng-app="myApp">
<input type="hidden" id="path" value="<%=path%>">
<input type="hidden"  id="agency-phone" value="${sessionScope.agency.phone}" />
<input type="hidden" id="agency-name"  value="${sessionScope.agency.name}" />
<div ng-controller="myCtrl">
    <div class="container">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class=" table table-responsive container">
                        <table class="table table-striped ">
                            <thead>
                            <tr>
                                <th colspan="3">
                                    <button type="button" class="btn btn-primary"
                                            ng-click="onclickbtn();" >修改状态
                                    </button>
                                    <button type="button" class="btn btn-primary"
                                            ng-click="changeNo();" >查看业主信息
                                    </button>
                                    <button type="button" id="update" class="btn btn-primary" >
                                        刷新
                                    </button>
                                </th>
                                <th >
                                    <select class="form-control"   id="buildings" name="buildingsPrice.id">
                                        <option  value="所有楼盘">所有楼盘</option>
                                        <option ng-repeat="bui in buildingsPriceList"   value="{{bui.id}}">{{bui.name}}</option>
                                    </select>
                                </th>
                                <th  ng-show="buildingPrices != null" >
                                    <select class="form-control"   id="buildingId" >
                                        <option  value="所有楼栋">所有楼栋</option>
                                        <option  ng-repeat="bui in buildingPrices"   value="{{bui.id}}">{{bui.name}}</option>
                                    </select>
                                </th>
                                <th >
                                    <select class="form-control" style="list-style: none;" id="sale_status" name="sale_status">
                                        <option value="5">查看所有状态</option>
                                        <option value="0">待售</option>
                                        <option value="1">销售中</option>
                                        <option value="2">已预定</option>
                                        <option value="3">已售</option>
                                        <option value="4">保留</option>
                                    </select>
                                </th>
                            </tr>
                            <tr>
                                <th><input type="checkbox" id="checkall"  ng-click="checkall()"/></th>
                                <th>房号</th>
                                <th>所属楼盘</th>
                                <th>所属楼栋</th>
                                <th>房间户型</th>
                                <th>有无业主</th>
                                <th >销售状态</th>
                            </tr>
                            </thead>
                            <tbody class="tz-gallery">
                            <tr ng-repeat="a in RoomPager" ng-click="showMenu()">
                                <td style="width: 10px">
                                    <input type="checkbox" title="{{$index}}" name="employeeId" id="employeeId"
                                           value="{{a.id}}"/>
                                </td>
                                <td >{{a.name}}</td>
                                <td >{{a.building.buildingsPrice.name}}</td>
                                <td >{{a.building.name}}</td>
                                <td ><a class="btn btn-success" href="<%=path%>/{{a.house.logo}}" alt="<%=path%>/{{a.house.logo}}">查看</a></td>
                                <td>
                                    <span style="color:#dc000b;" ng-show="{{a.count >= 1 }}">已有业主</span></td>
                                    <span style="color:#070707;" ng-show="{{a.count == 0 }}">暂无业主</span></td>
                                <td>
                                    <span style="color:#49ff20;" ng-show="{{a.sale_status == '0' }}">待售</span>
                                    <span style="color:#CC9900;" ng-show="{{a.sale_status == '1' }}">销售中</span>
                                    <span style="color:#3232c2;" ng-show="{{a.sale_status == '2' }}">已预定</span>
                                    <span style="color:red;" ng-show="{{a.sale_status == '3' }}">已售</span>
                                    <span style="color:rgba(194,59,178,0.97);" ng-show="{{a.sale_status == '4' }}">保留</span>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                        <div class="row">
                            <div class="col-sm-3">
                                共 {{total}} 个结果，共{{totalPageSize}}页
                            </div>
                            <div class="col-lg-3">
                                <div class="input-group">
                                   <span class="input-group-btn">
                                       <button class="btn btn-default"  type="button">第</button>
                                   </span>
                                    <input type="text" class="form-control" id="pageNo" placeholder="请输入页号" onKeyUp="value=(parseInt((value=value.replace(/\D/g,''))==''?'0':value,10))">
                                    <span class="input-group-btn">
                                        <button class="btn btn-default"   type="button">页</button>
                                        <button class="btn btn-default"  ng-click="like();"  type="button">确定</button>
                                    </span>
                                </div><!-- /input-group -->
                            </div>
                            <div class="col-sm-5">
                                <nav aria-label="Page navigation" class="pull-right">
                                    <ul class="pagination">
                                        <li ng-click="top()"><a>«</a></li>
                                        <li><a class="page" ng-show="count1>=5 " ng-click="page(count1-4)">{{count1-4}}</a></li>
                                        <li><a class="page" ng-show="count1>=4 " ng-click="page(count1-3)">{{count1-3}}</a></li>
                                        <li><a class="page" ng-show="count1>=3 " ng-click="page(count1-2)">{{count1-2}}</a></li>
                                        <li><a class="page" ng-show="count1>=2 " ng-click="page(count1-1)">{{count1-1}}</a></li>
                                        <li class="active"><a class="page" ng-show="count1>0" ng-click="page(count1)" title="{{count1}}">{{count1}}</a></li>
                                        <li><a class="page" ng-show="count1>0 && totalPageSize-1>= count1" ng-click="page(count1+1)">{{count1+1}}</a></li>
                                        <li><a class="page" ng-show="count1>0 && (totalPageSize-2) >= count1" ng-click="page(count1+2)">{{count1+2}}</a></li>
                                        <li><a class="page" ng-show="count1<3 && (totalPageSize-3) >= count1" ng-click="page(count1+3)">{{count1+3}}</a></li>
                                        <li><a class="page" ng-show="count1<2 && (totalPageSize-4) >= count1" ng-click="page(count1+4)">{{count1+4}}</a></li>
                                        <li ng-click="down()"><a>»</a></li>
                                    </ul>
                                </nav>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade col-sm-10" id="particulars" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog  modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">查看详情</h4>
                <div class="modal-body form-horizontal" >
                    <dl class="dl-horizontal">
                        <dt >姓名:</dt>
                        <dd id="name"></dd>
                        <dt >性别:</dt>
                        <dd id="gender"></dd>
                        <dt>邮箱:</dt>
                        <dd id="email"></dd>
                        <dt>手机号:</dt>
                        <dd id="phone"></dd>
                        <dt>生日:</dt>
                        <dd id="birthday"></dd>
                        <dt >身份证号:</dt>
                        <dd id="identity_id"></dd>
                        <dt>联系地址:</dt>
                        <dd id="address"></dd>
                        <dt>客户类型:</dt>
                        <dd id="customer_type"></dd>
                        <dt>共同购房人姓名:</dt>
                        <dd id="together"></dd>
                        <dt>电子版购房合同路径:</dt>
                        <dd id="contract"></dd>
                        <dt>zip版电子档案路径:</dt>
                        <dd id="archives"></dd>
                        <dt>添加时间:</dt>
                        <dd id="created_time"></dd>
                        <dt>负责员工:</dt>
                        <dd id="emp_name"></dd>
                    </dl>
                </div>
                <div class="modal-footer" style="border-top: 0px solid #e5e5e5;">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog  modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">销售状态</h4>
                <div class="form-group">
                    <label for="sale_status1" class="col-sm-2 control-label">销售状态：</label>
                    <div class="col-sm-7">
                        <select class="form-control" style="list-style: none;" id="sale_status1" name="sale_status">
                            <option value="0">待售</option>
                            <option value="1">销售中</option>
                            <option value="2">已预定</option>
                            <option value="3">已售</option>
                            <option value="4">保留</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-2 col-sm-offset-2 " >
                        <input type="button" class="btn btn-primary btn-lg btn-block" id="submit1" value="提交">
                    </div>
                </div>
                <div class="modal-footer" style="border-top: 0px solid #e5e5e5;">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script src="<%=path%>/public/js/jquery.min.js"></script>
<script src="<%=path%>/public/js/bootstrap.min.js"></script>
<script src="<%=path %>/layer-v3.1.0/layer/layer.js"></script>
<script src="<%=path%>/public/agency/js/jquery-validate.js"></script>
<script type="text/javascript" id="my" src="<%=path%>/public/xiangcecss/js/baguetteBox.min.js"></script>
<script type="text/javascript">
    //    $(".form_datetime").datetimepicker({format: 'yyyy-mm-dd hh:ii'});
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
        app.controller('myCtrl', function ($scope, $http, $timeout,$filter) {
            $scope.RoomPager = "";
            $scope.total = 0;
            $scope.totalPageSize = 0;
            $scope.count1 = 1;
            $scope.buildingPrices =null;


            $http({
                method: 'POST',
                url: "<%=path%>/buildings/queryBuildingsPrice"
            }).then(function successCallback(response) {
                $scope.buildingsPriceList = response.data.buildingsPriceList;
                $timeout(function(){
                    extracted($scope.count1,$("#buildingId").val());
                },100);
            }, function errorCallback(response) {

            });

            $scope.like = function () {
               if( parseFloat($("#pageNo").val())> $scope.totalPageSize){
                   return;
               }else if(parseFloat($("#pageNo").val())< 1){
                   return;
               }else {
                   extracted(parseFloat($("#pageNo").val()),$("#buildingId").val());
               }
            };

            function building() {
                $http({
                    method: 'POST',
                    url: "<%=path%>/building/allBuildingPrice",
                    data:{"buildingsId":$("#buildings").val()}
                }).then(function successCallback(response) {
                    $scope.buildingPrices = response.data.buildingPrices;
                }, function errorCallback(response) {

                });
            }

            function extracted(x,building) {
                var index = layer.load(0, {shade: false});//发送请求时让页面出现加载样式
                var urls = "<%=path%>/room/allRoom";
                var data1 = {"pageNo": x, "sale_status": $("#sale_status").val(),"buildings_id":$("#buildings").val(),"buildingId":building};
                $http({
                    method: 'POST',
                    url: urls,
                    data: data1
                }).then(function successCallback(response) {
                    $scope.total = response.data.pager.total;
                    $scope.totalPageSize = response.data.pager.totalPageSize;
                    $scope.RoomPager = response.data.pager.result;
                    if( $scope.RoomPager ==null|| $scope.RoomPager == ""){
                        if($scope.count1!=1){
                            $scope.count1 = response.data.pager.pageNo-1;
                        }
                    }else {
                        $scope.count1 = response.data.pager.pageNo;
                    }
                    if($("#checkall").is(':checked')==true){
                        $("#checkall").prop("checked",false);
                    }
                    $timeout(function(){
                        baguetteBox.run('.tz-gallery');
                    },50);
                    layer.close(index);//关闭加载窗口
                }, function errorCallback(response) {

                });
            }

            $("#update").click(function(){//刷新数据调用此方法
                if( $("#buildingId").val()== undefined || $("#buildingId").val() ==''|| $("#buildingId").val()==null){
                    extracted($scope.count1,'');
                }else {
                    extracted($scope.count1,$("#buildingId").val());
                }
            });

            $("#sale_status").change(function () {//选择销售状态时的改变事件
               if( $("#buildingId").val()== undefined || $("#buildingId").val() ==''|| $("#buildingId").val()==null){
                   extracted(1,'');
               }else {
                   extracted(1,$("#buildingId").val());
               }
            });

            $("#buildings").change(function () {//选择楼盘时的改变事件
                if($("#buildings").val()== '所有楼盘'){
                    $("#buildingId").val("所有楼栋");
                    $scope.buildingPrices =null;
                    extracted(1,$("#buildingId").val());
                }else {
                    building();
                    extracted(1,$("#buildingId").val());
                }
            });

            $("#buildingId").change(function () {//选择楼栋时的改变事件
                extracted(1,$("#buildingId").val());
            });
            $scope.page = function (x) {//点击页号事件
                if ($scope.count1 == x) {
                    return;
                }
                if( $("#buildingId").val()== undefined || $("#buildingId").val() ==''|| $("#buildingId").val()==null){
                    extracted(x,'');
                }else {
                    extracted(x,$("#buildingId").val());
                }
            };

            $scope.down = function () {//下一页
                if ($scope.count1 == $scope.totalPageSize) {
                    return;
                }
                if( $("#buildingId").val()== undefined || $("#buildingId").val() ==''|| $("#buildingId").val()==null){
                    extracted($scope.count1 + 1,'');
                }else {
                    extracted($scope.count1 + 1,$("#buildingId").val());
                }
            };
            $scope.top = function () {//上一页
                if ($scope.count1 == 1) {
                    return;
                }
                if( $("#buildingId").val()== undefined || $("#buildingId").val() ==''|| $("#buildingId").val()==null){
                    extracted($scope.count1 - 1,'');
                }else {
                    extracted($scope.count1 - 1,$("#buildingId").val());
                }
            };

            $scope.changeNo = function () { // 查看详情
                if ($("input[name='employeeId']:checkbox:checked").length ==1) {
                    $scope.count = $("input[name='employeeId']:checkbox:checked").attr("title");
                    $http({
                        method: 'POST',
                        url: "<%=path%>/staff/queryBySale",
                        data:{"roomId": $scope.RoomPager[$scope.count].id}
                    }).then(function successCallback(response) {
                        if(response.data.customer!=null){
                            $scope.customer=response.data.customer;
                            $("#name").html($scope.customer.name);
                            $("#gender").html($scope.customer.gender);
                            $("#birthday").html($filter("date")($scope.customer.birthday, "yyyy-MM-dd HH:mm:ss"));
                            $("#identity_id").html($scope.customer.identity_id);
                            $("#email").html($scope.customer.email);
                            $("#phone").html($scope.customer.phone);
                            $("#address").html($scope.customer.address);
                            $("#customer_type").html($scope.customer.customer_type);
                            $("#together").html($scope.customer.together);
                            var path ="<%=path%>";
                            if($scope.customer.contract ==null ||$scope.customer.contract ==''){
                                $("#contract").html('暂时还未上传合同');
                            }else {
                                $("#contract").html('<a href = "'+path+'/download/down?name='+$scope.customer.contract+'">下载合同</a>');
                            }
                            if($scope.customer.archives ==null ||$scope.customer.archives ==''){
                                $("#archives").html('暂时还未上传文档');
                            }else {
                                $("#archives").html('<a href = "'+path+'/download/down?name='+$scope.customer.archives+'">下载档案</a>');
                            }
                            $("#created_time").html($filter("date")($scope.customer.created_time, "yyyy-MM-dd HH:mm:ss"));
                            $("#emp_name").html($scope.customer.employeePrice.name);
                            $("#particulars").modal("show");
                        }else {
                            layer.msg("暂时还无业主信息！");
                        }
                    }, function errorCallback(response) {

                    });
                } else {
                    layer.msg("请选择一行！");
                }

            };


            $scope.checkall=function () {//全选和取消全选
                if($("#checkall").is(':checked')==true){
                    $("input[name='employeeId']").prop("checked",true);
                }else {
                    $("input[name='employeeId']").prop("checked", false);
                }
            };

            var chk_value1 = [];
            $scope.onclickbtn = function () {//修改状态
                $('input[name="employeeId"]:checked').each(function () {
                    chk_value1.push($(this).val());
                });
                if (chk_value1.length == 0) {
                    layer.msg("请选择一行！");
                } else {
                    $("#myModal").modal("show");
                }
            };

            $("#submit1").click(function(){//回复内容的提交按钮事件
                $.ajax({
                    type:'post',
                    traditional :true,
                    url:'<%=path %>/room/updateSaleStatus',
                    data:{"sale_status": $("#sale_status1").val(),"chk_value1":chk_value1},
                    success:function(data){
                        if(data.controllerResult.result =='success'){
                            $("#myModal").modal('hide');
                            $('#update').trigger('click');
                            chk_value1 = [];
                            layer.msg(data.controllerResult.msg);
                        }else {
                            layer.msg(data.controllerResult.msg);
                        }
                    }
                });
            });

        });
    }(jQuery));
</script>
</html>

