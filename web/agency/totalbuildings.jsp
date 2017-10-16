<%--
  Created by IntelliJ IDEA.
  User: yao
  Date: 2017/9/13
  Time: 8:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html><html>
<%
    String path = request.getContextPath();
%>
<head>
    <title>Title</title>
</head>
<link href="<%=path%>/public/css/bootstrap.min.css" rel="stylesheet">
<link href="<%=path%>/public/admin/css/admincheck.css" rel="stylesheet">
<link href="<%=path%>/public/css/bootstrap-fileinput.css" rel="stylesheet">
<link href="<%=path%>/public/admin/css/bootstrap-datetimepicker.css" rel="stylesheet">
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
    dd, dt {
        line-height: 2.42857143;
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
                        <table class="table table-striped">
                            <tr>
                                <th colspan="8">
                                    <button type="button" class="btn btn-primary" ng-click="changeYes();">激活</button>

                                    <button type="button" class="btn btn-primary" ng-click="changeNo();">冻结</button>

                                    <button type="button" class="btn btn-primary" data-toggle="modal"
                                            ng-click="onclickChange();" >楼盘修改
                                    </button>

                                    <button type="button" class="btn btn-primary" data-toggle="modal"
                                            ng-click="onclickbtn();" >查看详情
                                    </button>

                                    <button type="button" class="btn btn-primary" data-toggle="modal"
                                            ng-click="examine();" >查看楼盘相册
                                    </button>

                                    <button type="button" class="btn btn-primary" data-toggle="modal"
                                            ng-click="uploadingImg();" >上传楼盘图片
                                    </button>

                                    <button type="button" id="update" class="btn btn-primary" data-toggle="modal">
                                        刷新
                                    </button>
                                </th>
                                <th>
                                    <select class="form-control" style="list-style: none;" id="status" name="status">
                                        <option value="3">所有楼盘</option>
                                        <option value="1">已激活楼盘</option>
                                        <option value="0">已冻结楼盘</option>
                                    </select>
                                </th>
                            </tr>
                            <tr>
                                <th><input type="checkbox" id="checkall"  ng-click="checkall()"/></th>
                                <th>楼盘名称</th>
                                <th>所属区域</th>
                                <th>开盘时间</th>
                                <th>售楼电话</th>
                                <th>楼盘均价</th>
                                <th>接待地址</th>
                                <th>房源类型</th>
                                <th>状态</th>
                            </tr>
                            <tbody>
                            <tr ng-repeat="a in buildingsPager">
                                <td>
                                    <input type="checkbox" title="{{$index}}" name="employeeId" id="employeeId"
                                           value="{{a.id}}"/>
                                </td>
                                <td>{{a.name}}</td>
                                <td>{{a.area}}</td>
                                <td>{{a.open_date | date:"yyyy-MM-dd HH:mm:ss"}}</td>
                                <td>{{a.tel}}</td>
                                <td>{{a.avg_price}}</td>
                                <td>{{a.reception_address}}</td>
                                <td>{{a.house_type}}</td>
                                <td>
                                    <span style="color:#2dc25e;" ng-show="{{a.status == '1' }}">已激活</span>

                                    <span style="color:red;" ng-show="{{a.status == '0' }}">已冻结</span>
                                </td>
                            </tr>
                            <tbody>
                        </table>
                        <div class="row">
                            <div class="col-sm-2">
                                共 {{total}} 个楼盘，共{{totalPageSize}}页
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

<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">楼盘详情</h4>
            </div>
            <div class="modal-body form-horizontal" >
                <dl class="dl-horizontal">
                    <dt>楼盘名称:</dt>
                    <dd id="name"></dd>
                    <dt >所属区域:</dt>
                    <dd id="area"></dd>
                    <dt >地址:</dt>
                    <dd id="address"></dd>
                    <dt>占地面积:</dt>
                    <dd id="floor_area"></dd>
                    <dt>建筑面积:</dt>
                    <dd id="building_area"></dd>
                    <dt>房源类型:</dt>
                    <dd id="house_type"></dd>
                    <dt >建筑类型:</dt>
                    <dd id="building_type"></dd>
                    <dt>经度:</dt>
                    <dd id="longitude"></dd>
                    <dt>纬度:</dt>
                    <dd id="latitude"></dd>
                    <dt>楼盘均价:</dt>
                    <dd id="avg_price"></dd>
                    <dt>开发公司:</dt>
                    <dd id="company"></dd>
                    <dt>开盘时间:</dt>
                    <dd id="open_date"></dd>
                    <dt>总套数:</dt>
                    <dd id="total_rooms"></dd>
                    <dt>接待地址:</dt>
                    <dd id="reception_address"></dd>
                    <dt>售楼电话:</dt>
                    <dd id="tel"></dd>
                    <dt>绿化率:</dt>
                    <dd id="green_ratio"></dd>
                    <dt>容积率:</dt>
                    <dd id="plot_ratio"></dd>
                    <dt>物业公司:</dt>
                    <dd id="property_company"></dd>
                    <dt>物业费:</dt>
                    <dd id="property_fee"></dd>
                    <dt>车位数:</dt>
                    <dd id="car_station"></dd>
                    <dt>交通状况:</dt>
                    <dd id="traffic"></dd>
                    <dt>周边配套:</dt>
                    <dd id="equipments"></dd>
                    <dt>楼盘封面:</dt>
                    <dd ><img id="logo" border="0" width="180" height="auto"></dd>
                    <dt>楼盘介绍:</dt>
                    <dd id="intro"></dd>
                </dl>
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
<script src="<%=path %>/public/js/jQuery.form.min.js"></script>
<script src="<%=path %>/public/admin/js/bootstrap-datetimepicker.js"></script>
<script src="<%=path %>/public/admin/js/bootstrap-datetimepicker.zh-CN.js"></script>
<script src="<%=path%>/public/js/bootstrap-fileinput.js"></script>
<script src="<%=path %>/layer-v3.1.0/layer/layer.js"></script>
<script src="<%=path%>/public/agency/js/jquery-validate.js"></script>
<script type="text/javascript">
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
        app.controller('myCtrl', function ($scope, $http, $timeout) {
            $scope.buildingsPager = "";
            $scope.total = 0;
            $scope.totalPageSize = 0;
            $scope.count1 = 1;


            extracted($scope.count1);

            function extracted(x) {
                var index = layer.load(0, {shade: false});//发送请求时让页面出现加载样式
                $http({
                    method: 'POST',
                    url: "<%=path%>/buildings/allBuildings",
                    data: {"pageNo": x, "status": $("#status").val()}
                }).then(function successCallback(response) {
                    $scope.total = response.data.buildingsPager.total;
                    $scope.totalPageSize = response.data.buildingsPager.totalPageSize;
                    $scope.buildingsPager = response.data.buildingsPager.result;
                    $scope.count1 = response.data.buildingsPager.pageNo;
                    layer.close(index);//关闭加载窗口
                    if($("#checkall").is(':checked')==true){
                        $("#checkall").prop("checked",false);
                    }
                }, function errorCallback(response) {

                });
            }

            $("#status").change(function () {//选择状态时的改变事件
                extracted(1);
            });

            $("#district").change(function () {//选择状态时的改变事件
                extracted(1);
            });
            $scope.page = function (x) {//点击页号事件
                if ($scope.count1 == x) {
                    return;
                }
                extracted(x);
            };

            $scope.down = function () {//下一页

                if ($scope.count1 == $scope.totalPageSize) {
                    return;
                }
                extracted($scope.count1 + 1);
            };
            $scope.top = function () {//上一页

                if ($scope.count1 == 1) {
                    return;
                }
                extracted($scope.count1 - 1);
            };
            $scope.onclickbtn = function () {//根据传进来的数字来取集合的数据
                if ($("input[name='employeeId']:checkbox:checked").length == 1) {
                    $("#myModal").modal("show");
                    $scope.count = $("input[name='employeeId']:checkbox:checked").attr("title");
                    $("#name").text($scope.buildingsPager[$scope.count].name);
                    $("#area").text($scope.buildingsPager[$scope.count].area);
                    $("#address").text($scope.buildingsPager[$scope.count].address);
                    $("#floor_area").text($scope.buildingsPager[$scope.count].floor_area);
                    $("#building_area").text($scope.buildingsPager[$scope.count].building_area);
                    $("#house_type").text($scope.buildingsPager[$scope.count].house_type);
                    $("#building_type").text($scope.buildingsPager[$scope.count].building_type);
                    $("#longitude").text($scope.buildingsPager[$scope.count].longitude);
                    $("#latitude").text($scope.buildingsPager[$scope.count].latitude);
                    $("#avg_price").html($scope.buildingsPager[$scope.count].avg_price);
                    $("#company").html($scope.buildingsPager[$scope.count].company);

                    $("#open_date").html(date($scope.buildingsPager[$scope.count].open_date));//时间转换函数

                    $("#total_rooms").text($scope.buildingsPager[$scope.count].total_rooms);
                    $("#reception_address").text($scope.buildingsPager[$scope.count].reception_address);
                    $("#tel").text($scope.buildingsPager[$scope.count].tel);
                    $("#green_ratio").text($scope.buildingsPager[$scope.count].green_ratio);
                    $("#plot_ratio").text($scope.buildingsPager[$scope.count].plot_ratio);
                    $("#property_company").text($scope.buildingsPager[$scope.count].property_company);
                    $("#property_fee").text($scope.buildingsPager[$scope.count].property_fee);
                    $("#car_station").text($scope.buildingsPager[$scope.count].car_station);
                    $("#traffic").text($scope.buildingsPager[$scope.count].traffic);
                    $("#equipments").text($scope.buildingsPager[$scope.count].equipments);
                    $("#logo").attr("src","<%=path%>/"+$scope.buildingsPager[$scope.count].logo);
                    $("#intro").text($scope.buildingsPager[$scope.count].intro);
                } else {
                    layer.msg("请选择一行！");
                }
            };
            $scope.onclickChange = function () {//楼盘修改信息
                if ($("input[name='employeeId']:checkbox:checked").length ==1) {
                    $scope.count = $("input[name='employeeId']:checkbox:checked").attr("title");
                    layer.ready(function(){
                        layer.open({
                            type: 2,
                            title: '修改楼盘信息',
                            maxmin: true,
                            area: ['800px', '500px'],
                            content: '<%=path%>/buildings/addbuildingspage?buildingsId='+$scope.buildingsPager[$scope.count].id,
                            cancel: function(){
                                //关闭当前窗口时就进入此方法 ?buildingsId='+$scope.buildingsPager[$scope.count].id
                            }
                        });
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
            $scope.changeYes= function() { // 只能激活用户，判断等页面完成
                var chk_value = [];
                $('input[name="employeeId"]:checked').each(function () {
                    chk_value.push($(this).val());
                });
                if (chk_value.length == 0) {
                    layer.msg("请选择一行！");
                } else {
                    status(1,chk_value);
                }
            };

            $scope.changeNo = function () { // 只能冻结用户，判断等页面完成
                var chk_value = [];
                $('input[name="employeeId"]:checked').each(function () {
                    chk_value.push($(this).val());
                });
                if (chk_value.length == 0) {
                    layer.msg("请选择一行！");
                } else {
                    status(0,chk_value);
                }
            };
            $scope.uploadingImg = function () {//上传图片
                $scope.count = $("input[name='employeeId']:checkbox:checked").attr("title");
                if ($("input[name='employeeId']:checkbox:checked").length ==1) {
                    layer.ready(function(){
                        layer.open({
                            type: 2,
                            title: '上传图片',
                            maxmin: true,
                            area: ['800px', '500px'],
                            content: '<%=path%>/form_webuploader.jsp?buildingsId='+$scope.buildingsPager[$scope.count].id,
                            cancel: function(){
                                //关闭当前窗口时就进入此方法 ?buildingsId='+$scope.buildingsPager[$scope.count].id
                            }
                        });
                    });
                } else {
                    layer.msg("请选择一行！");
                }
            };
            $scope.examine = function () {//查看楼盘相册
                $scope.count = $("input[name='employeeId']:checkbox:checked").attr("title");
                if ($("input[name='employeeId']:checkbox:checked").length ==1) {
                    layer.ready(function(){
                        layer.open({
                            type: 2,
                            title: '楼盘相册',
                            maxmin: true,
                            area: ['800px', '500px'],
                            content: '<%=path%>/buildingsImg.jsp?buildingsId='+$scope.buildingsPager[$scope.count].id,
                            cancel: function(){
                                //关闭当前窗口时就进入此方法 ?buildingsId='+$scope.buildingsPager[$scope.count].id
                            }
                        });
                    });
                } else {
                    layer.msg("请选择一行！");
                }
            };

            $("#update").click(function(){//刷新数据调用此方法
                extracted($scope.count1);
            });

            function date(dates) {
                var str = dates;
                var strA = str.split(/[a-zA-Z]/);
                var d = {}

                d.year = strA[0].split('-')[0];
                d.month = strA[0].split('-')[1];
                d.day = strA[0].split('-')[2];
                d.hour = strA[1].split(':')[0];
                d.minute = strA[1].split(':')[1];
                d.second = strA[1].split(':')[2];
                d.weekday = str.match(/[a-zA-Z]/)[0];
                return d.year+"-"+d.month+"-"+d.day;
            }

            function status(updatestatus,checkedIds) {
                $.ajax({
                    type:'post',
                    traditional :true,
                    url:'<%=path %>/buildings/updatestatus',
                    data:{"checkedIds":checkedIds,"pageNo": $scope.count1, "updatestatus": updatestatus,"status": $("#status").val()} ,
                    success:function(data){
                        $timeout(function(){//用jquery时不会自动渲染，只能手动渲染就调用此方法,
                            if(data.controllerResult.result =='success'){
                                layer.msg(data.controllerResult.msg);
                                $scope.total = data.buildingsPager.total;
                                $scope.totalPageSize = data.buildingsPager.totalPageSize;
                                $scope.buildingsPager = data.buildingsPager.result;
                                $scope.count1 = data.buildingsPager.pageNo;
                            }else {
                                layer.msg(data.controllerResult.msg);
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
</html>

