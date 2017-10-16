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
    <title>所有员工绩效</title>
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
                                            ng-click="onclickChange();" >设置任务量
                                    </button>

                                    <button type="button" class="btn btn-primary" data-toggle="modal"
                                            ng-click="onclickbtn();" >设置提成百分比
                                    </button>

                                    <button type="button" id="Employee" class="btn btn-primary" data-toggle="modal"
                                            ng-click="allEmployee();" >查看员工其他绩效
                                    </button>

                                    <button type="button" id="update" class="btn btn-primary" data-toggle="modal">
                                        刷新
                                    </button>

                                    <button type="button" class="btn btn-danger hidden" id="returns" data-toggle="modal"
                                            ng-click="returns();" >返回
                                    </button>
                                </th>
                                <th>
                                    <select class="form-control" style="list-style: none;" id="Tasks" name="task ">
                                        <option value="allTasks">所有任务</option>
                                        <option value="allHistoryTasks">历史布置任务</option>
                                        <option value="allNewestTasks">最新布置任务</option>
                                    </select>
                                </th>
                                <th>
                                    <select class="form-control" style="list-style: none;" id="status" name="status">
                                        <option value="2">所有状态</option>
                                        <option value="0">被冻结的任务</option>
                                        <option value="1">被激活的任务</option>
                                    </select>
                                </th>
                            </tr>
                            <tr>
                                <th><input type="checkbox" id="checkall"  ng-click="checkall()"/></th>
                                <th>员工名称</th>
                                <th>基本工资</th>
                                <th>开始时间</th>
                                <th>结束时间</th>
                                <th>提成百分比</th>
                                <th>销售量</th>
                                <th>任务量</th>
                                <th>任务状态</th>
                                <th>状态</th>
                            </tr>
                            <tbody>
                            <tr ng-repeat="a in missionPager">
                                <td>
                                    <input type="checkbox" title="{{$index}}" name="employeeId" id="employeeId"
                                           value="{{a.id}}"/>
                                </td>
                                <td>{{a.name}}</td>
                                <td>{{a.basic_salary}}</td>
                                <td>{{a.start_time | date:"yyyy-MM-dd HH:mm:ss"}}</td>
                                <td>{{a.end_time | date:"yyyy-MM-dd HH:mm:ss"}}</td>
                                <td>{{a.bonus_percent}}</td>
                                <td>{{a.coun}}</td>
                                <td>{{a.quantity}}</td>
                                <td>
                                    <span ng-show="a.coun < a.quantity" style="color: #dc2b49">未完成</span>
                                    <span ng-show="a.coun >= a.quantity" style="color: #2dc25e">完成</span>
                                </td>
                                <td>
                                    <span style="color:#2dc25e;" ng-show="{{a.status == '1' }}">已激活</span>

                                    <span style="color:red;" ng-show="{{a.status == '0' }}">已冻结</span>
                                </td>
                            </tr>
                            <tbody>
                        </table>
                        <div class="row">
                            <div class="col-sm-2">
                                共 {{total}} 个结果，共{{totalPageSize}}页
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
                <h4 class="modal-title" id="myModalLabel">设置提成百分比</h4>
            </div>
            <div class="modal-body " >
                <form class="form-horizontal" id="form-percent1">
                    <div class="form-group">
                        <label class="col-sm-2  control-label">百分比:</label>
                        <div class="col-sm-5  input-parent">
                            <input  class="form-control" id="bonus_percent" name="mission.bonus_percent"
                                    onkeyup= "this.value=(this.value.match(/\d+(\.\d{0,2})?/)||[''])[0]"
                                    oninput="if(value.length>5){
                                        this.value=value.slice(0,6);
                                    }else if((parseFloat(value)) > 100){
                                            this.value =100;
                                    }"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-2 col-sm-offset-2 " >
                            <input type="button" class="btn btn-primary btn-lg btn-block" id="submit"   value="提交">
                        </div>
                    </div>
                </form>
                <div class="modal-footer" style="border-top: 0px solid #e5e5e5;">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="quantity" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog  modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">设置任务量</h4>
                <form class="form-horizontal" id="form-quantity">
                    <div class="form-group">
                        <label class="col-sm-2  control-label">员工任务量:</label>
                        <div class="col-sm-5  input-parent">
                            <input  class="form-control" id="quantity1" name="mission.quantity" size="5" style="ime-mode:disabled"
                                    onKeyUp="this.value=this.value.replace(/[^\.\d]/g,'');this.value=this.value.replace('.','');"
                                    oninput="if(value.length>5)value=value.slice(0,5)" />
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-2 col-sm-offset-2 " >
                            <input type="button" class="btn btn-primary btn-lg btn-block" id="submit1"   value="提交">
                        </div>
                    </div>
                </form>

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
    $().ready(function() {
// 在键盘按下并释放及提交后验证提交表单
        $("#form-quantity").validate({
            rules: {
                "mission.quantity": {
                    required: true
                }
            },
            messages: {
                "mission.quantity": {
                    required: "请输入任务量"
                }
            }
        });
        $("#form-percent1").validate({
            rules: {
                "mission.bonus_percent": {
                    required: true
                }
            },
            messages: {
                "mission.bonus_percent": {
                    required: "请设置提成百分比"
                }
            }
        });
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
            $scope.missionPager = "";
            $scope.total = 0;
            $scope.totalPageSize = 0;
            $scope.count1 = 1;
            var stat = true;

            extracted($scope.count1);

            function extracted(x) {
                var index = layer.load(0, {shade: false});//发送请求时让页面出现加载样式
                var urls = "<%=path%>/mission/allmission";
                var data1 = {"pageNo": x, "status": $("#status").val(),"task":$("#Tasks").val()};
                if(stat ==false){
                    urls = "<%=path%>/mission/allEmployeeMission";
                    data1 = {"pageNo": x, "status": $("#status").val(),"emp_id": $scope.emp_id};
                }
                $http({
                    method: 'POST',
                    url: urls,
                    data: data1
                }).then(function successCallback(response) {
                    $scope.total = response.data.missionPager.total;
                    $scope.totalPageSize = response.data.missionPager.totalPageSize;
                    $scope.missionPager = response.data.missionPager.result;
                    if( $scope.missionPager ==null|| $scope.missionPager == ""){
                        $scope.count1 = response.data.missionPager.pageNo-1;
                    }else {
                        $scope.count1 = response.data.missionPager.pageNo;
                    }
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

            $("#Tasks").change(function () {//选择状态时的改变事件
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

            $scope.allEmployee = function () {//查看员工其他绩效
                if ($("input[name='employeeId']:checkbox:checked").length ==1) {
                    $scope.count = $("input[name='employeeId']:checkbox:checked").attr("title");
                    $scope.emp_id = $scope.missionPager[$scope.count].emp_id;

                    stat = false;
                    $scope.pageNo = $scope.count1;
                    $scope.status = $("#status").val();
                    $("#Employee").addClass("hidden");
                    $("#Tasks").addClass("hidden");
                    $("#returns").removeClass("hidden");
                    extracted(1);
                } else {
                    layer.msg("请选择一行！");
                }
            };

            $scope.returns = function () {//按返回时触发
                stat = true;
                $scope.count1 = $scope.pageNo;
                $("#status").val($scope.status);
                $("#Employee").removeClass("hidden");
                $("#Tasks").removeClass("hidden");
                $("#returns").addClass("hidden");
                extracted($scope.count1);
            }
            var chk_value1 = [];
            $scope.onclickbtn = function () {//设置提成百分比
                $('input[name="employeeId"]:checked').each(function () {
                    chk_value1.push($(this).val());
                });
                if (chk_value1.length == 0) {
                    layer.msg("请选择一行！");
                } else {
                    $("#myModal").modal("show");
                }
            };

            $("#submit").click(function(){//提交百分比
                if ($("#form-percent1").valid()==true) {
                    $.ajax({
                        type:'post',
                        traditional :true,
                        url:'<%=path %>/mission/updatepercent',
                        data:{"checkedIds":chk_value1,"mission.bonus_percent": $("#bonus_percent").val()} ,
                        success:function(data){
                            if(data.controllerResult.result =='success'){
                                layer.msg(data.controllerResult.msg);
                                $("#myModal").modal('hide');
                                $("#bonus_percent").val("");
                                $('#update').trigger('click');
                                chk_value1 = [];
                            }else {
                                layer.msg(data.controllerResult.msg);
                            }
                            if($("#checkall").is(':checked')==true){
                                $("#checkall").prop("checked",false);
                            }
                        }
                    });
                }
            });

            $scope.onclickChange = function () {//批量设置员工任务量
                $('input[name="employeeId"]:checked').each(function () {
                    chk_value1.push($(this).val());
                });
                if (chk_value1.length == 0) {
                    layer.msg("请选择一行！");
                } else {
                    $("#quantity").modal("show");
                }
            };
            $("#submit1").click(function(){//提交任务量
                if ($("#form-quantity").valid()==true) {
                    $.ajax({
                        type:'post',
                        traditional :true,
                        url:'<%=path %>/mission/updatequantity',
                        data:{"checkedIds":chk_value1,"mission.quantity": $("#quantity1").val()} ,
                        success:function(data){
                            if(data.controllerResult.result =='success'){
                                layer.msg(data.controllerResult.msg);
                                $("#quantity").modal('hide');
                                $('#update').trigger('click');
                                $("#quantity1").val("");
                                chk_value1 = [];
                            }else {
                                layer.msg(data.controllerResult.msg);
                            }
                            if($("#checkall").is(':checked')==true){
                                $("#checkall").prop("checked",false);
                            }
                        }
                    });

                }
            });

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
                    url:'<%=path %>/mission/updateStatus',
                    data:{"checkedIds":checkedIds,"status": updatestatus} ,
                    success:function(data){
                        $timeout(function(){//用jquery时不会自动渲染，只能手动渲染就调用此方法,
                            if(data.controllerResult.result =='success'){
                                layer.msg(data.controllerResult.msg);
                                $('#update').trigger('click');
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

