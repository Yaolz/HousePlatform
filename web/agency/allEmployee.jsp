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
                                <th colspan="7">
                                    <button type="button" class="btn btn-primary" ng-click="changeYes();">激活</button>

                                    <button type="button" class="btn btn-primary" ng-click="changeNo();">冻结</button>

                                    <button type="button" class="btn btn-primary" data-toggle="modal"
                                            ng-click="onclickChange();" >员工修改
                                    </button>

                                    <button type="button" class="btn btn-primary" data-toggle="modal"
                                            ng-click="onclickbtn();" >查看详情
                                    </button>
                                    <input type="button" title="可进行批量操作" class="btn btn-primary" data-toggle="modal" ng-click="allMission();"  value="添加任务">
                                    <button type="button" id="update" class="btn btn-primary">
                                        刷新
                                    </button>

                                </th>
                                <th>
                                    <select class="form-control"   id="district" name="buildingsPrice.id">
                                        <option  value="所有楼盘">所有楼盘</option>
                                        <option ng-repeat="bui in buildingsPriceList"   value="{{bui.id}}">{{bui.name}}</option>
                                    </select>
                                </th>
                                <th>
                                    <select class="form-control" style="list-style: none;" id="status" name="status">
                                        <option value="3">所有员工</option>
                                        <option value="1">已激活员工</option>
                                        <option value="0">已冻结员工</option>
                                    </select>
                                </th>
                            </tr>
                            <tr>
                                <th><input type="checkbox" id="checkall"  ng-click="checkall()"/></th>
                                <th>姓名</th>
                                <th>性别</th>
                                <th>电话</th>
                                <th>是否有任务</th>
                                <th>基本工资</th>
                                <th>所属楼盘</th>
                                <th>入职时间</th>
                                <th>状态</th>
                            </tr>
                            <tbody>
                            <tr ng-repeat="a in employee">
                                <td>
                                    <input type="checkbox" title="{{$index}}" name="employeeId" id="employeeId"
                                           value="{{a.id}}"/>
                                </td>
                                <td>{{a.name}}</td>
                                <td>{{a.gender}}</td>
                                <td>{{a.phone}}</td>
                                <td>
                                    <span ng-show="a.missionBean == null  || {{(a.missionBean.end_time | date:'yyyy-MM-dd HH:mm:ss') < dt2}}">暂无任务</span>
                                    <span style="color: #dc2b49" ng-show="a.missionBean != null && {{(a.missionBean.end_time | date:'yyyy-MM-dd HH:mm:ss') > dt2}} ">已有任务</span>
                                </td>
                                <td>{{a.basic_salary}}</td>
                                <td>{{a.buildingsPrice.name}}</td>
                                <td>{{a.created_time | date:"yyyy-MM-dd HH:mm:ss"}}</td>
                                <td>
                                    <span style="color:#2dc25e;" ng-show="{{a.status == '1' }}">已激活</span>

                                    <span style="color:red;" ng-show="{{a.status == '0' }}">已冻结</span>
                                </td>
                            </tr>
                            <tbody>
                        </table>
                        <div class="row">
                            <div class="col-sm-2">
                                共 {{total}} 个用户，共{{totalPageSize}}页
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
                <h4 class="modal-title" id="myModalLabel">员工详情</h4>
            </div>
            <div class="modal-body form-horizontal" >
                <dl class="dl-horizontal">
                    <dt>所属楼盘:</dt>
                    <dd id="loupan"></dd>
                    <dt >姓名:</dt>
                    <dd id="name"></dd>
                    <dt >性别:</dt>
                    <dd id="gender"></dd>
                    <dt>邮箱:</dt>
                    <dd id="email"></dd>
                    <dt>电话:</dt>
                    <dd id="phone"></dd>
                    <dt>QQ:</dt>
                    <dd id="qq"></dd>
                    <dt >微信号:</dt>
                    <dd id="wechat"></dd>
                    <dt>基本工资:</dt>
                    <dd id="basic_salary"></dd>
                    <dt>入职时间:</dt>
                    <dd id="created_time"></dd>
                    <dt>描述:</dt>
                    <dd id="des"></dd>
                    <dt>工作经验:</dt>
                    <dd id="exp"></dd>
                    <dt>简介:</dt>
                    <dd id="intro"></dd>
                    <dt>居住地址:</dt>
                    <dd id="address"></dd>
                    <dt >正在执行的任务</dt>
                    <dd id="mission" >
                        <dt >任务量:</dt>
                        <dd style="color: #dc3e3b" id="quantity"></dd>
                        <dt >当前提成百分比:</dt>
                        <dd style="color: #dc3e3b" id="bonus_percent"></dd>
                        <dt >任务开始时间:</dt>
                        <dd style="color: #dc3e3b" id="start_time"></dd>
                        <dt >结束时间:</dt>
                        <dd style="color: #dc3e3b" id="end_time"></dd>
                    </dd>
                </dl>
                <div class="modal-footer" style="border-top: 0px solid #e5e5e5;">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>
</div>


<div class="modal fade" id="modalChange" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog  modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <form class="form-horizontal" id="register-form" enctype="multipart/form-data">
                <input type="hidden" id="emid" name="employee.id">
                <input type="hidden" id="headicon" name="employee.headicon">
                <div class="form-group" style="margin-top: 20px;">
                    <label class="col-sm-2 control-label">员工头像：</label>
                    <div class="fileinput fileinput-new col-sm-7" data-provides="fileinput"  id="exampleInputUpload">
                        <div class="fileinput-new thumbnail" style="width: 300px;height: auto;max-height:300px;">
                            <img id='picImg' style="width: 100%;height: auto;max-height: 500px;" src="" alt="" />
                        </div>
                        <div class="fileinput-preview fileinput-exists thumbnail" style="max-width: 300px; max-height: 300px;"></div>
                        <div >
                            <span class="btn btn-primary btn-file ">
                                <span class="fileinput-new  ">选择文件</span>
                                <span class="fileinput-exists ">换一张</span>
                                <input  class="form-control " type="file"   name="upload" id="picID" accept="image/gif,image/jpeg,image/x-png"/>
                            </span>
                            <a href="javascript:;" id="exists" class="btn btn-warning fileinput-exists " data-dismiss="fileinput" >移除</a>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label for="loupan1" class="col-sm-2  control-label">所属楼盘:</label>
                    <div class="col-sm-5  input-parent">
                        <input class="form-control" id="loupan1" name="employee.buildingsPrice.name" disabled/><br/>
                    </div>
                </div>
                <input type="hidden" id="buildingsId" name="employee.buildingsPrice.id">
                <div class="form-group">
                    <label for="name1" class="col-sm-2  control-label">姓名:</label>
                    <div class="col-sm-5  input-parent">
                        <input class="form-control" id="name1" name="employee.name"/><br/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2  control-label">性别:</label>
                    <div class="col-sm-5  input-parent">
                        <select id="gender1" name="employee.gender" class="form-control">
                            <option value="男">男</option>
                            <option value="女">女</option>
                        </select><br/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2  control-label">电话:</label>
                    <div class="col-sm-5  input-parent">
                        <input  class="form-control" id="phone1" name="employee.phone" maxlength="11"/><br/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2  control-label">QQ:</label>
                    <div class="col-sm-5  input-parent">
                        <input class="form-control"  id="qq1"name="employee.qq"/><br/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2  control-label">微信号:</label>
                    <div class="col-sm-5  input-parent">
                        <input class="form-control"  id="wechat1" name="employee.wechat"/><br/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2  control-label">基本工资:</label>
                    <div class="col-sm-5  input-parent">
                        <input class="form-control"  id="basic_salary1"name="employee.basic_salary"/><br/>
                    </div>
                </div>
                <div class="form-group">
                    <label for="created_time1" class="col-sm-2  control-label">入职时间:</label>
                    <div class="col-sm-5  input-parent">
                        <input size="16" type="text" class="form-control form_datetime" id="created_time1" name="employee.created_time" style="background-color: white"   readonly ><br/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2  control-label">描述:</label>
                    <div class="col-sm-5  input-parent">
                        <textarea  class="form-control" id="des1" name="employee.des"></textarea><br/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2  control-label">工作经验:</label>
                    <div class="col-sm-5 input-parent">
                        <textarea  class="form-control" id="exp1" name="employee.exp"> </textarea><br/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2  control-label">简介:</label>
                    <div class="col-sm-5  input-parent">
                        <textarea  class="form-control"  id="intro1" name="employee.intro"></textarea><br/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2  control-label">居住地址:</label>
                    <div class="col-sm-5  input-parent">
                        <input  class="form-control" id="address1" name="employee.address"/><br/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-2 col-sm-offset-2 " >
                        <input type="button" class="btn btn-primary btn-lg btn-block" id="submit"   value="修改">
                    </div>
                </div>
            </form>
            <div class="modal-footer" style="border-top: 0px solid #e5e5e5;">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="addMission" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog  modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">设置任务</h4>
                <form class="form-horizontal" id="add-form">
                    <div class="form-group">
                        <label class="col-sm-2  control-label">员工任务量:</label>
                        <div class="col-sm-5  input-parent">
                            <input  class="form-control" id="quantity1" name="mission.quantity" size="5" style="ime-mode:disabled"
                                    onKeyUp="this.value=this.value.replace(/[^\.\d]/g,'');this.value=this.value.replace('.','');"
                                    oninput="if(value.length>5)value=value.slice(0,5)" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2  control-label">开始时间:</label>
                        <div class="col-sm-5  input-parent">
                            <input type="text"  class="form-control form_datetime" id="start_time1" name="mission.start_time" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2  control-label">结束时间:</label>
                        <div class="col-sm-5  input-parent">
                            <input type="text"  class="form-control form_datetime" id="end_time1" name="mission.end_time"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2  control-label">提成百分比:</label>
                        <div class="col-sm-5  input-parent">
                            <input  class="form-control" id="bonus_percent1" name="mission.bonus_percent"
                                    onkeyup= "this.value=(this.value.match(/\d+(\.\d{0,2})?/)||[''])[0]"
                                    oninput="if(value.length>5){
                                        this.value=value.slice(0,6);
                                    }else if((parseFloat(value)) > 100){
                                            this.value =100;
                                    }"/>
                        </div>
                    </div>
                    <input type="hidden" name="chk_value" id="chk_value1"/>
                    <div class="form-group">
                        <div class="col-sm-2 col-sm-offset-2 " >
                            <input type="button" class="btn btn-primary btn-lg btn-block" id="submit1"   value="添加">
                        </div>
                    </div>
                </form>
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
<script src="<%=path%>/public/js/bootstrus-date-from.js"></script>
<script src="<%=path%>/public/js/bootstrap-fileinput.js"></script>
<script src="<%=path %>/layer-v3.1.0/layer/layer.js"></script>
<script src="<%=path%>/public/agency/js/jquery-validate.js"></script>
<script type="text/javascript">
    var employee_name;
    var employee_phone;

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
            $scope.employee = "";
            $scope.total = 0;
            $scope.totalPageSize = 0;
            $scope.count1 = 1;
            $scope.dt1 = new Date();
            $scope.dt2 = $filter("date")($scope.dt1, "yyyy-MM-dd HH:mm:ss");

            $http({
                method: 'POST',
                url: "<%=path%>/buildings/queryBuildingsPrice"
            }).then(function successCallback(response) {
                $scope.buildingsPriceList = response.data.buildingsPriceList;
                $timeout(function(){
                    extracted($scope.count1);
                },300);
            }, function errorCallback(response) {

            });

            function extracted(x) {
                var index = layer.load(0, {shade: false});//发送请求时让页面出现加载样式
                $http({
                    method: 'POST',
                    url: "<%=path%>/employee/pagerByStatus",
                    data: {"pageNo": x, "status": $("#status").val(),"buildings_id": $("#district").val()}
                }).then(function successCallback(response) {
                    $scope.total = response.data.employeePager.total;
                    $scope.totalPageSize = response.data.employeePager.totalPageSize;
                    $scope.employee = response.data.employeePager.result;
                    $scope.count1 = response.data.employeePager.pageNo;
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
                    $("#name").text($scope.employee[$scope.count].name);
                    $("#loupan").text($scope.employee[$scope.count].buildingsPrice.name);
                    $("#gender").text($scope.employee[$scope.count].gender);
                    $("#email").text($scope.employee[$scope.count].email);
                    $("#phone").text($scope.employee[$scope.count].phone);
                    $("#qq").text($scope.employee[$scope.count].qq);
                    $("#wechat").text($scope.employee[$scope.count].wechat);
                    $("#basic_salary").text($scope.employee[$scope.count].basic_salary);
                    $("#created_time").text($filter("date")($scope.employee[$scope.count].created_time, "yyyy-MM-dd HH:mm:ss"));
                    $("#des").html($scope.employee[$scope.count].des);
                    $("#exp").html($scope.employee[$scope.count].exp);
                    $("#intro").html($scope.employee[$scope.count].intro);
                    $("#address").text($scope.employee[$scope.count].address);
                    if($scope.employee[$scope.count].missionBean!=null){
                        $("#quantity").text($scope.employee[$scope.count].missionBean.quantity);
                        $("#start_time").text($filter("date")($scope.employee[$scope.count].missionBean.start_time, "yyyy-MM-dd HH:mm:ss"));
                        $("#end_time").text($filter("date")($scope.employee[$scope.count].missionBean.end_time, "yyyy-MM-dd HH:mm:ss"));
                        $("#bonus_percent").text($scope.employee[$scope.count].missionBean.bonus_percent);
                        $("#start_time").removeClass("hidden");
                        $("#end_time").removeClass("hidden");
                        $("#bonus_percent").removeClass("hidden");
                    }else {
                        $("#quantity").text("暂无任务");
                        $("#start_time").addClass("hidden");
                        $("#end_time").addClass("hidden");
                        $("#bonus_percent").addClass("hidden");
                    }
                } else {
                    layer.msg("请选择一行！");
                }
            };
            $scope.onclickChange = function () {//员工修改信息
                if ($("input[name='employeeId']:checkbox:checked").length ==1) {
                    $("#modalChange").modal("show");
                    $scope.count = $("input[name='employeeId']:checkbox:checked").attr("title");
                    if($scope.employee[$scope.count].headicon ==''||$scope.employee[$scope.count].headicon == null){
                        $("#picImg").attr("src","");
                        $("#picImg").attr("src","<%=path%>/public/img/noimage.png");
                    }else {
                        $("#picImg").attr("src","<%=path%>/" +$scope.employee[$scope.count].headicon);
                    }
                    $("#headicon").val($scope.employee[$scope.count].headicon);
                    $("#emid").val($scope.employee[$scope.count].id);
                    employee_name = $scope.employee[$scope.count].name;//当员工修改回原来的名称时就会用到此变量进行判断
                    $("#name1").val($scope.employee[$scope.count].name);
                    $("#gender1").val($scope.employee[$scope.count].gender);
                    employee_phone =$scope.employee[$scope.count].phone;//当员工用回自己原来的手机号码时就会判断此手机没有被注册过
                    $("#phone1").val($scope.employee[$scope.count].phone);
                    $("#qq1").val($scope.employee[$scope.count].qq);
                    $("#wechat1").val($scope.employee[$scope.count].wechat);
                    $("#basic_salary1").val($scope.employee[$scope.count].basic_salary);
                    $("#created_time1").val($filter("date")($scope.employee[$scope.count].created_time, "yyyy-MM-dd HH:mm:ss"));
                    $("#des1").html($scope.employee[$scope.count].des);
                    $("#exp1").html($scope.employee[$scope.count].exp);
                    $("#intro1").html($scope.employee[$scope.count].intro);
                    $("#address1").val($scope.employee[$scope.count].address);
                    $("#buildingsId").val($scope.employee[$scope.count].buildingsPrice.id);
                    $("#loupan1").val($scope.employee[$scope.count].buildingsPrice.name);
                } else {
                    layer.msg("请选择一行！");
                }
            };
            //格式化时间
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
                return d.year+"-"+d.month+"-"+d.day+" "+d.hour+":"+d.minute;
            }
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
            }

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
            var chk_value1 = [];
           $scope.allMission = function () {
               if($("input[name='employeeId']:checkbox:checked").length >=1){
                   var fals = true;
                   $('input[name="employeeId"]:checkbox:checked').each(function () {
                       chk_value1.push($(this).val());
                       $scope.count = $(this).attr("title");
                       if($scope.employee[$scope.count].missionBean!=null){
                           $scope.end_time =  $filter("date")($scope.employee[$scope.count].missionBean.end_time, "yyyy-MM-dd HH:mm:ss");
                           if($scope.dt2< $scope.end_time){
                               fals = false;
                           }
                       }
                   });
                   if(fals ==false){
                       layer.msg("已经有任务的不能添加，只能进行修改！");
                   }
                   if(fals){
                       var curDate1 = new Date();
                       $("#quantity1").val("");
                       $('#start_time1').val($filter("date")(new Date, "yyyy-MM-dd HH:mm:ss"));
                       $('#end_time1').val($filter("date")(new Date(new Date((curDate1/1000+86400)*1000)), "yyyy-MM-dd HH:mm:ss"));
                       $("#bonus_percent1").val("");
                       $("#addMission").modal("show");
                   }
               }else {
                   layer.msg("请选择一行");
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

            $("#submit1").click(function() {//添加任务
                if(chk_value1!=null&&chk_value1!=undefined&& chk_value1!=""){
                    if ($("#add-form").valid()==true) {
                        $('#chk_value1').val(chk_value1);
                        $("#add-form").ajaxSubmit({
                            type: 'post', // 提交方式 get/post
                            url: '<%=path %>/mission/addmission', // 需要提交的 url
                            dataType : 'json',
                            data:$("#add-form").serialize(),
                            success: function(data) { // data 保存提交后返回的数据，一般为 json 数据
                                if(data.controllerResult.result =='success'){
                                    layer.msg(data.controllerResult.msg);
                                    $("#addMission").modal('hide');
                                    $('#update').trigger('click');
                                    $('#chk_value1').val("");
                                    chk_value1 = [];
                                } else{
                                    layer.msg(data.controllerResult.msg);
                                }
                            }
                        });
                    }
                }
            });

            $("#submit").click(function(){//员工修改
               if ($("#register-form").valid()==true) {
                   var index = layer.load(0, {shade: false});
                   $("#register-form").ajaxSubmit({
                       type: 'post', // 提交方式 get/post
                       url: '<%=path %>/employee/employeeChange', // 需要提交的 url
                       dataType : 'json',
                       data:$("#register-form").serialize(),
                       success: function(data) { // data 保存提交后返回的数据，一般为 json 数据
                           // 此处可对 data 作相关处理
                           if(data.controllerResult.result =='success'){
                               $("#exists").trigger("click");
                               layer.close(index);
                               $("#modalChange").modal('hide');
                               layer.msg(data.controllerResult.msg);
                               $timeout(function(){//用jquery时不会自动渲染，只能手动渲染就调用此方法,
                                   $scope.employee[$scope.count] = data.employee;
                               },0);
                               <%--window.location.href="<%=path %>/employee/allEmployeePage"--%>
                           } else{
                               layer.msg(data.controllerResult.msg);
                           }
                       }
                   });
               }
           });
            function status(updatestatus,checkedIds) {
                $.ajax({
                    type:'post',
                    traditional :true,
                    url:'<%=path %>/employee/status',
                    data:{"checkedIds":checkedIds,"pageNo": $scope.count1, "updatestatus": updatestatus,"buildings_id": $("#district").val(),"status": $("#status").val()} ,
                    success:function(data){
                        $timeout(function(){//用jquery时不会自动渲染，只能手动渲染就调用此方法,
                            if(data.controllerResult.result =='success'){
                                layer.msg(data.controllerResult.msg);
                                $scope.total = data.employeePager.total;
                                $scope.totalPageSize = data.employeePager.totalPageSize;
                                $scope.employee = data.employeePager.result;
                                $scope.count1 = data.employeePager.pageNo;
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
    $().ready(function() {
// 在键盘按下并释放及提交后验证提交表单
        $("#add-form").validate({
            rules: {
                "mission.quantity": {
                    required: true
                },
                "mission.start_time": {
                    required: true
                },
                "mission.end_time": {
                    required: true
                },
                "mission.bonus_percent": {
                    required: true
                }
            },
            messages: {
                "mission.quantity": {
                    required: "请输入任务量"
                },
                "mission.start_time": {
                    required: "请设置开始时间"
                },
                "mission.end_time": {
                    required: "请设置结束时间"
                },
                "mission.bonus_percent": {
                    required: "请设置提成百分比"
                }
            }
        });
    });
</script>
<script>
    $(function(){

        //表单验证
        $("#register-form").validate();

        //地址验证
        $("#address1").rules('add',{
            maxlength:100,
            messages:{
                maxlength:'输入的信息不能超过100个字符'
            }
        });

        //生日
        $("#created_time1").rules('add',{
            required:true,
            messages:{
                required:'请选择时间，如1993-03-29！',
            }

        });

        //简介验证
        $("#intro1").rules('add',{
            maxlength:498,
            messages:{
                maxlength:'输入的信息不能超过500个字符'
            }
        });

        //用户名
        $("#name1").rules('add',{
            required:true,
            maxlength:20,
            remote: {
                type: "post",
                url: $("#path").val()+"/index/queryName",
                dataType: "json",   //返回格式为json
                async: true,//请求是否异步，默认为异步，这也是ajax重要特性
                data: {
                    name: function() {
                        return $("#name1").val();
                    }
                },
                dataFilter: function(data) {
                    var jsonstr = eval("("+data+")");
                    if (jsonstr.trues == "true") {
                        if(employee_name == $("#name1").val()){
                            return true;
                        }
                        return false;
                    }else if(jsonstr.trues == "false"){
                        if($("#agency-name")!=null&&$("#agency-name")!=undefined&&$("#agency-name")!=''&&$("#agency-name").val()==$("#name1").val()){
                            return false;
                        }
                        return true;
                    }
                }
            },
            messages:{
                required:'请输入名称！',
                maxlength:'名称不能大于{0}位！',
                remote:"该名称正在被使用！"
            }
        });
        //手机
        $("#phone1").rules('add',{
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
                        return $("#phone1").val();
                    }
                },
                dataFilter: function(data) {
                    var jsonstr = eval("("+data+")");
                    if (jsonstr.trues == "true") {
                        if(employee_phone ==$("#phone1").val()){
                            return true;
                        }
                        return false;
                    }else if(jsonstr.trues == "false"){
                        if($("#agency-phone")!=null&&$("#agency-phone")!=undefined&&$("#agency-phone")!=''&&$("#agency-phone").val()==$("#phone1").val()){
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

        //员工的工作经验长度限制
        $("#exp1").rules('add',{
            maxlength:50,
            messages:{
                maxlength:'只能输入50个字符'
            }
        });

        //员工的个人说明长度限制
        $("#des1").rules('add',{
            maxlength:100,
            messages:{
                maxlength:'只能输入100个字符'
            }
        });

        //qq验证qq多少位数
        $("#qq1").rules('add',{
            maxlength:11,
            minlength:5,
            digits:true,
            messages:{
                maxlength:'qq最长为11位',
                minlength:'qq最短为5位',
                digits:'只能输入qq号码'
            }
        });



        //微信验证
        $("#wechat1").rules('add',{
            maxlength:20,
            minlength:6,
            messages:{
                maxlength:'输入的字符不能超过20位',
                minlength:'最少输入6位'
            }
        });

        //基本工资验证
        $("#basic_salary1").rules('add',{
            required:true,
            maxlength:8,
            messages:{
                required:'请输入该员工的基本工资',
                maxlength:'你输入数字过大！'
            }
        });


        //手机验证规则
        $.validator.addMethod('phone',function(value,element){
            var phone = /^1[3|4|5|7|8][0-9]\d{8}$/;
            return this.optional(element)||(phone.test(value));
        });
        //生日验证规则
        $.validator.addMethod('date',function(value,element){
            var date = /^(19|20)\d{2}-(1[0-2]|0?[1-9])-(0?[1-9]|[1-2][0-9]|3[0-1])$/;
            return this.optional(element)||(date.test(value));
        });

    })
</script>
</html>
