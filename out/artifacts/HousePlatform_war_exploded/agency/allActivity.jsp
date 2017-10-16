<%--
  Created by IntelliJ IDEA.
  User: yao
  Date: 2017/9/13
  Time: 8:40
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
<link href="<%=path%>/public/admin/css/admincheck.css" rel="stylesheet">
<link href="<%=path%>/public/css/bootstrap-fileinput.css" rel="stylesheet">
<link href="<%=path%>/public/admin/css/bootstrap-datetimepicker.css" rel="stylesheet">
<script src="<%=path%>/public/angular/angular.min.js"></script>
<style type="text/css" >
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
<div ng-controller="myCtrl">
    <div class="container">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class=" table table-responsive container">
                        <table class="table table-striped">
                            <tr>
                                <th colspan="5">
                                    <button type="button" class="btn btn-primary" ng-click="changeYes();">激活</button>

                                    <button type="button" class="btn btn-primary" ng-click="changeNo();">冻结</button>

                                    <button type="button" class="btn btn-primary" ng-click="onclickChange($index);" >活动修改
                                    </button>

                                    <button type="button" class="btn btn-primary"  ng-click="onclickbtn($index);" >查看详情
                                    </button>
                                    <button type="button" id="update" class="btn btn-primary" data-toggle="modal">
                                        刷新
                                    </button>
                                </th>
                                <th>
                                    <select class="form-control"   id="district1" name="buildingsPrice.id">
                                        <option  value="所有楼盘">所有楼盘</option>
                                        <option ng-repeat="bui in buildingsPriceList"   value="{{bui.id}}">{{bui.name}}</option>
                                    </select>
                                </th>
                                <th>
                                    <select class="form-control" style="list-style: none;" id="status" name="status">
                                        <option value="3">所有活动</option>
                                        <option value="1">已激活活动</option>
                                        <option value="0">已冻结活动</option>
                                    </select>
                                </th>
                            </tr>
                            <tr>
                                <th><input type="checkbox" id="checkall"  ng-click="checkall()"/></th>
                                <th>标题</th>
                                <th>所属楼盘</th>
                                <th>开始时间</th>
                                <th>结束时间</th>
                                <th>活动地址</th>
                                <th>状态</th>
                            </tr>
                            <tbody>
                            <tr ng-repeat="a in activitys">
                                <td>
                                    <input type="checkbox" title="{{$index}}" name="activityId" id="activityId"
                                           value="{{a.id}}"/>
                                </td>
                                <td>{{a.title}}</td>
                                <td>{{a.buildingsPrice.name}}</td>
                                <td>{{a.start_time | date:"yyyy-MM-dd HH:mm:ss"}}</td>
                                <td>{{a.end_time | date:"yyyy-MM-dd HH:mm:ss"}}</td>
                                <td>{{a.address}}</td>
                                <td>
                                    <span style="color:#2dc25e;" ng-show="{{a.status == '1' }}">已激活</span>

                                    <span style="color:red;" ng-show="{{a.status == '0' }}">已冻结</span>
                                </td>
                            </tr>
                            <tbody>
                        </table>

                        <div class="row">
                            <div class="col-sm-2">
                                共 {{total}} 个活动，共{{totalPageSize}}页
                            </div>
                            <div class="col-sm-10">
                                <nav aria-label="Page navigation" class="pull-right">
                                    <ul class="pagination">
                                        <li ng-click="top()"><a>«</a></li>
                                        <li><a class="page" ng-show="count1>=5 " ng-click="page(count1-4)">{{count1-4}}</a></li>
                                        <li><a class="page" ng-show="count1>=4 " ng-click="page(count1-3)">{{count1-3}}</a></li>
                                        <li><a class="page" ng-show="count1>=3 " ng-click="page(count1-2)">{{count1-2}}</a></li>
                                        <li><a class="page" ng-show="count1>=2 " ng-click="page(count1-1)">{{count1-1}}</a></li>
                                        <li><a class="page" ng-show="count1>0" ng-click="page(count1)"
                                               title="{{count1}}">{{count1}}</a></li>
                                        <li><a class="page" ng-show="count1>0 && totalPageSize-1>= count1"
                                               ng-click="page(count1+1)">{{count1+1}}</a></li>
                                        <li><a class="page" ng-show="count1>0 && (totalPageSize-2) >= count1"
                                               ng-click="page(count1+2)">{{count1+2}}</a></li>
                                        <li><a class="page" ng-show="count1<3 && (totalPageSize-3) >= count1"
                                               ng-click="page(count1+3)">{{count1+3}}</a></li>
                                        <li><a class="page" ng-show="count1<2 && (totalPageSize-4) >= count1"
                                               ng-click="page(count1+4)">{{count1+4}}</a></li>
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
                <h4 class="modal-title" id="myModalLabel">活动详情</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label class="col-sm-3  control-label">图片:</label>
                    <div class="col-sm-9  input-parent">
                        <div class="form-group">
                            <div id="preview1">
                                <img id="logo" border="0" width="180" height="auto">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3  control-label">标题:</label>
                    <div class="col-sm-9  input-parent">
                        <p id="title"></p>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3  control-label">所属楼盘:</label>
                    <div class="col-sm-9  input-parent">
                        <p id="buildingsPrice"></p>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3  control-label">开始时间:</label>
                    <div class="col-sm-9  input-parent">
                        <p id="start_time"></p>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3  control-label">结束时间:</label>
                    <div class="col-sm-9  input-parent">
                        <p id="end_time"></p>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3  control-label">活动内容:</label>
                    <div class="col-sm-9  input-parent">
                        <p id="content"></p>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-3  control-label">活动地址:</label>
                    <div class="col-sm-9  input-parent">
                        <p id="address"></p>
                    </div>
                </div>
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
                <h4 class="modal-title">活动修改</h4>
            </div>
            <form  class="form-horizontal" id="register-form" enctype="multipart/form-data">
                <input type="hidden" id="emid" name="activity.id">
                <input type="hidden" name="agencyPrice.id" value="${agency.id}">
                <input type="hidden" name="buildingsPrice.id" id="buildingsId"/><br/>
                <input type="hidden" id="buildingsName"  name="buildingsPrice.name">
                <div class="form-group" style="margin-top: 20px;">
                    <label class="col-sm-2 control-label">活动图片：</label>
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
                        <label class="col-sm-2  control-label">标题:</label>
                        <div class="col-sm-7  input-parent">
                            <input class="form-control" id="title1" name="activity.title"/><br/>
                        </div>
                    </div>
                    <input type="hidden" class="form-control" id="logo1" name="activity.logo"/><br/>
                    <div class="form-group">
                        <label for="district" class="col-sm-2 control-label">所属楼盘：</label>
                        <div class="col-sm-7">
                            <input disabled class="form-control" id="district"/>
                            <br/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="start_time1" class="col-sm-2  control-label">开始时间:</label>
                        <div class="col-sm-7  input-parent">
                            <input size="16" type="text" class="form-control form_datetime" value="2017-09-9 14:00"
                                   id="start_time1" name="activity.start_time" style="background-color: white"
                                   readonly><br/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="end_time1" class="col-sm-2  control-label">结束时间:</label>
                        <div class="col-sm-7  input-parent">
                            <input size="16" type="text" class="form-control form_datetime" value="2017-09-9 14:00"
                                   id="end_time1" name="activity.end_time" style="background-color: white"
                                   readonly><br/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="content" class="col-sm-2  control-label">活动内容：</label>
                        <div class="col-sm-7 ">
                            <textarea id="content1" class="form-control" rows="5" name="activity.content" placeholder="活动内容"></textarea><br/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2  control-label">活动地址:</label>
                        <div class="col-sm-7  input-parent">
                            <input class="form-control" id="address1" name="activity.address"/><br/>
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

<form action="" method="post" id="formid">
    <input type="hidden" name="checkedIds" id="checkedIds"/>
    <input type="hidden" name="activity.status" id="statu"/>
</form>

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
            $scope.activitys = "";
            $scope.total = 0;
            $scope.totalPageSize = 0;
            $scope.count1 = 1;

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
                    url: "<%=path%>/activity/pagerByStatus",
                    data: {"pageNo": x, "status": $("#status").val(),"buildings_id": $("#district1").val()}
                }).then(function successCallback(response) {
                    $scope.total = response.data.pager.total;
                    $scope.totalPageSize = response.data.pager.totalPageSize;
                    $scope.activitys = response.data.pager.result;
                    $scope.count1 = response.data.pager.pageNo;
                    layer.close(index);//关闭加载窗口
                    if($("#checkall").is(':checked')==true){
                        $("#checkall").prop("checked",false);
                    }
                }, function errorCallback(response) {

                });
            }

            $("#status").change(function () {//select改变事件
                extracted(1);
            });

            $("#district1").change(function () {//选择楼盘时的改变事件
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

            $("#submit").click(function(){
                if ($("#register-form").valid()==true) {
                    var index = layer.load(0, {shade: false});
                    $("#register-form").ajaxSubmit({
                        type: 'post', // 提交方式 get/post
                        url: '<%=path %>/activity/activityChange', // 需要提交的 url
                        dataType: 'json',
                        data: $("#register-form").serialize(),
                        success: function (data) { // data 保存提交后返回的数据，一般为 json 数据
                            if(data.controllerResult.result =='success'){
                                $("#exists").trigger("click");
                                layer.close(index);
                                $("#modalChange").modal('hide');
                                layer.msg(data.controllerResult.msg);
                                $timeout(function(){//用jquery时不会自动渲染，只能手动渲染就调用此方法,
                                    $scope.activitys[$scope.count] = data.activity;
                                    $scope.activitys[$scope.count].status=1;
                                },0);
                            } else{
                                layer.msg(data.controllerResult.msg);
                            }

                        }
                    });
                }
            });

            $scope.onclickbtn = function (x) {//根据传进来的数字来取集合的数据
                if ($("input[name='activityId']:checkbox:checked").length == 1) {
                    $("#myModal").modal("show");
                    $scope.count = $("input[name='activityId']:checkbox:checked").attr("title");
                    $("#logo").attr("src","");
                    $("#logo").attr("src","<%=path %>/" + $scope.activitys[$scope.count].logo);
                    <%--document.getElementById("logo").src = "<%=path %>/" + $scope.activitys[$scope.count].logo;--%>
                    $("#title").text($scope.activitys[$scope.count].title);
                    $("#buildingsPrice").text($scope.activitys[$scope.count].buildingsPrice.name);
                    $("#address").text($scope.activitys[$scope.count].address);
                    $("#content").text($scope.activitys[$scope.count].content);
                    $("#start_time").text(date($scope.activitys[$scope.count].start_time));
                    $("#end_time").text(date($scope.activitys[$scope.count].end_time));
                } else {
                    layer.msg("请选择一行！");
                }
            };
            $scope.onclickChange = function (x) {//活动修改
                if ($("input[name='activityId']:checkbox:checked").length == 1) {
                    $("#modalChange").modal("show");
                    $scope.count = $("input[name='activityId']:checkbox:checked").attr("title");
                    $("#emid").val($scope.activitys[$scope.count].id);
                    $("#picImg").attr("src","");
                    $("#picImg").attr("src","<%=path %>/" + $scope.activitys[$scope.count].logo);
                    <%--document.getElementById("picImg").src = "<%=path %>/" + $scope.activitys[$scope.count].logo;--%>
                    $("#logo1").val($scope.activitys[$scope.count].logo);
                    $("#title1").val($scope.activitys[$scope.count].title);
                    $("#district").val($scope.activitys[$scope.count].buildingsPrice.name);
                    $("#buildingsId").val($scope.activitys[$scope.count].buildingsPrice.id);
                    $("#buildingsName").val($scope.activitys[$scope.count].buildingsPrice.name);
                    $("#content1").val($scope.activitys[$scope.count].content);

                    $("#start_time1").val(date($scope.activitys[$scope.count].start_time));
                    $("#end_time1").val(date($scope.activitys[$scope.count].end_time));

                    $("#address1").val($scope.activitys[$scope.count].address);
                } else {
                    layer.msg("请选择一行！");
                }
            };

            $scope.checkall=function () {//全选和取消全选
                if($("#checkall").is(':checked')==true){
                    $("input[name='activityId']").prop("checked",true);
                }else {
                    $("input[name='activityId']").prop("checked", false);
                }
            };

            $scope.changeYes= function() { // 只能激活用户，判断等页面完成
                var chk_value = [];
                $('input[name="activityId"]:checked').each(function () {
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
                $('input[name="activityId"]:checked').each(function () {
                    chk_value.push($(this).val());
                });
                if (chk_value.length == 0) {
                    layer.msg("请选择一行！");
                } else {
                    status(0,chk_value);
                }
            };

            $("#update").click(function(){//刷新数据调用此方法
                var buildingsID = $("#district1").val();
                $http({
                    method: 'POST',
                    url: "<%=path%>/buildings/queryBuildingsPrice"
                }).then(function successCallback(response) {
                    $scope.buildingsPriceList = response.data.buildingsPriceList;
                    $timeout(function(){
                      $("#district1").val(buildingsID);
                        if($("#district1").val()==""||$("#district1").val() ==null){
                            $("#district1").val("所有楼盘");
                        }
                    },100);
                    $timeout(function(){
                        extracted($scope.count1);
                    },300);
                }, function errorCallback(response) {

                });
            });
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
            function status(updatestatus,checkedIds) {
                $.ajax({
                    type:'post',
                    traditional :true,
                    url:'<%=path %>/activity/agencyStatus',
                    data:{"checkedIds":checkedIds,"pageNo": $scope.count1, "updatestatus": updatestatus,"buildings_id": $("#district1").val(),"status": $("#status").val()} ,
                    success:function(data){
                        $timeout(function(){//用jquery时不会自动渲染，只能手动渲染就调用此方法,
                            if(data.controllerResult.result =='success'){
                                layer.msg(data.controllerResult.msg);
                                $scope.total = data.pager.total;
                                $scope.totalPageSize = data.pager.totalPageSize;
                                $scope.activitys = data.pager.result;
                                $scope.count1 = data.pager.pageNo;
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
<script>
    $(function(){
        $("#register-form").validate();
        //地址验证
        $("#address1").rules('add',{
            maxlength:100,
            required:true,
            messages:{
                maxlength:'输入的信息不能超过100个字符',
                required:"请输入你的活动地址"
            }
        });
        //活动内容验证
        $("#content1").rules('add',{
            maxlength:498,
            messages:{
                maxlength:'输入的信息不能超过500个字符'
            }
        });
        //验证标题
        $("#title1").rules('add',{
            maxlength:20,
            required:true,
            messages:{
                maxlength:'名称长度不能超过{0}位！',
                required:'请输入活动名'
            }
        });

        //时间
        $("#end_time1").rules('add',{
            required:true,
            messages:{
                required:'请选择时间，如1993-03-29！',
            }
        });
        //时间
        $("#start_time1").rules('add',{
            required:true,
            messages:{
                required:'请选择时间，如1993-03-29！',
            }
        });
    });
</script>
</html>
