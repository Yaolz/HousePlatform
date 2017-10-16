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
    <title>所有留言</title>
</head>
<link href="<%=path%>/public/css/bootstrap.min.css" rel="stylesheet">
<link href="<%=path%>/public/admin/css/admincheck.css" rel="stylesheet">
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
    table{
        width:100px;
        table-layout:fixed;/* 只有定义了表格的布局算法为fixed，下面td的定义才能起作用。 */
        min-height: 0.01%;
        overflow-x: auto;
        max-width: 100%;
        margin-bottom: 20px;
    }
    td{
        width:100%;
        word-break:keep-all;/* 不换行 */
        white-space:nowrap;/* 不换行 */
        overflow:hidden;/* 内容超出宽度时隐藏超出部分的内容 */
        text-overflow:ellipsis;/* 当对象内文本溢出时显示省略标记(...) ；需与overflow:hidden;一起使用*/
    }

    .wrap{white-space:normal; width:90%; }
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
                                    <th colspan="6">
                                        <button type="button" class="btn btn-primary" data-toggle="modal"
                                                ng-click="onclickbtn();" >回复留言
                                        </button>

                                        <button type="button" id="update" class="btn btn-primary" data-toggle="modal">
                                            刷新
                                        </button>
                                    </th>
                                    <th>
                                        <select class="form-control" style="list-style: none;" id="status" name="status">
                                            <option value="2">查看所有状态</option>
                                            <option value="0">未回复的留言</option>
                                            <option value="1">已回复的留言</option>
                                        </select>
                                    </th>
                                    <th>
                                        <select class="form-control"   id="district1" name="buildingsPrice.id">
                                            <option  value="所有楼盘">所有楼盘</option>
                                            <option ng-repeat="bui in buildingsPriceList"   value="{{bui.id}}">{{bui.name}}</option>
                                        </select>
                                    </th>
                                </tr>
                                <tr>
                                    <th><input type="checkbox" id="checkall"  ng-click="checkall()"/></th>
                                    <th>留言用户</th>
                                    <th>留言楼盘</th>
                                    <th>留言时间</th>
                                    <th>回复时间</th>
                                    <th >留言内容</th>
                                    <th>查看详情</th>
                                    <th>状态</th>
                                </tr>
                            </thead>
                            <tbody id="table">
                            <tr ng-repeat="a in messagePager" ng-click="showMenu()">
                                <td style="width: 10px">
                                    <input type="radio" title="{{$index}}" name="employeeId" id="employeeId"
                                           value="{{a.id}}"/>
                                </td>
                                <td title="{{a.userPrice.name}}">{{a.userPrice.name}}</td>
                                <td title="{{a.buildingsPrice.name}}">{{a.buildingsPrice.name}}</td>
                                <td title="{{a.leave_time | date:'yyyy-MM-dd HH:mm:ss'}}">{{a.leave_time | date:"yyyy-MM-dd HH:mm:ss"}}</td>
                                <td title="{{a.reply_time | date:'yyyy-MM-dd HH:mm:ss'}}">{{a.reply_time | date:"yyyy-MM-dd HH:mm:ss"}}</td>
                                <td title="{{a.content}}">{{a.content}}</td>
                                <td> <button type="button" class="btn btn-primary" ng-click="changeNo($index);">查看详情</button></td>
                                <td>
                                    <span style="color:#2dc25e;" ng-show="{{a.status == '1' }}">已回复</span>

                                    <span style="color:red;" ng-show="{{a.status == '0' }}">未回复</span>
                                </td>
                            </tr>
                            </tbody>
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
<div class="modal fade col-sm-10" id="particulars" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog  modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">查看详情</h4>
                <div class="media">
                    <div class="media-left">
                        <a href="javascript:;">
                            <img class="media-object"  src="" id="userLogo"  style="width: 64px; height: 64px;">
                        </a>
                    </div>
                    <div class="media-body " style="width: 500px">
                        <h4 class="media-heading" id="userName"></h4>
                        <p id="userContent" class="lead" ></p>
                    </div>
                </div>
                <div class="media">
                    <div class="media-left">
                        <a href="javascript:;">
                            <img class="media-object" src=""  id="buildingsLogo"  style="width: 64px; height: 64px;">
                        </a>
                    </div>
                    <div class="media-body " style="width: 500px">
                        <p id="buildingsReply" class="lead"></p>
                    </div>
                </div>
                <div class="modal-footer" style="border-top: 0px solid #e5e5e5;">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="message" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog  modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">回复留言</h4>
                <form class="form-message" id="form-message">
                    <input type="hidden" id="id" name="message.id">
                    <div class="form-group">
                        <label for="reply" class="col-sm-2 control-label">回复内容：</label>
                        <div class="col-sm-7">
                            <textarea  rows="5" class="form-control" id="reply" name="message.reply"  ></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-2 col-sm-offset-2 " >
                            <input type="button" class="btn btn-primary btn-lg btn-block" id="submit1" value="提交">
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
<script src="<%=path %>/layer-v3.1.0/layer/layer.js"></script>
<script src="<%=path%>/public/agency/js/jquery-validate.js"></script>
<script type="text/javascript">


        $("#form-message").validate({
            maxlength:4000,
            rules: {
                "message.reply": {
                    required: true
                }
            },
            messages: {
                "message.reply": {
                    required: "请输入你的留言",
                    maxlength:"字数不能超过4000"
                }
            }
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
            $scope.messagePager = "";
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
                },100);
            }, function errorCallback(response) {

            });

            function extracted(x) {
                var index = layer.load(0, {shade: false});//发送请求时让页面出现加载样式
                var urls = "<%=path%>/message/allmessage";
                var data1 = {"pageNo": x, "status": $("#status").val(),"buildings_id":$("#district1").val()};
                $http({
                    method: 'POST',
                    url: urls,
                    data: data1
                }).then(function successCallback(response) {
                    $scope.total = response.data.messagePager.total;
                    $scope.totalPageSize = response.data.messagePager.totalPageSize;
                    $scope.messagePager = response.data.messagePager.result;
                    $scope.count1 = response.data.messagePager.pageNo;
                    layer.close(index);//关闭加载窗口
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

            $scope.changeNo = function (x) { // 查看详情
                $("#buildingsLogo").attr("src","<%=path%>/"+$scope.messagePager[x].buildingsPrice.logo);
                if($scope.messagePager[x].reply ==null||$scope.messagePager[x].reply==''){
                    $("#buildingsReply").text("你还未进行回复");
                }else {
                    $("#buildingsReply").text("回复内容："+$scope.messagePager[x].reply);
                }
                $("#userLogo").attr("src","<%=path%>/"+$scope.messagePager[x].userPrice.headicon);
                $("#userContent").text("留言内容："+$scope.messagePager[x].content);
                $("#userName").text("用户名称："+$scope.messagePager[x].userPrice.name);
                $("#particulars").modal("show");

            };

            $scope.onclickbtn = function () {//回复内容
                if ($("input[name='employeeId']:checked").length == 1) {
                    $scope.count = $("input[name='employeeId']:checked").attr("title");
                    $("#reply").val($scope.messagePager[$scope.count].reply);
                    $("#id").val($scope.messagePager[$scope.count].id);
                    $("#message").modal("show");
                }else {
                    layer.msg("请选择一行！");
                }
            };

            $("#submit1").click(function(){//回复内容的提交按钮事件
                if ($("#form-message").valid()==true) {
                    $.ajax({
                        type:'post',
                        traditional :true,
                        url:'<%=path %>/message/updateMessageAgency',
                        data:$("#form-message").serialize(),
                        success:function(data){
                            if(data.result.result =='success'){
                                $timeout(function(){
                                    $scope.messagePager[$scope.count].reply = data.message.reply;
                                    $scope.messagePager[$scope.count].status = data.message.status;
                                    $scope.messagePager[$scope.count].reply_time = data.message.reply_time;
                                },50);
                                $("#message").modal('hide');
                                layer.msg(data.result.msg);
                            }else {
                                layer.msg(data.result.msg);
                            }
                        }
                    });
                }
            });

            $scope.showMenu = function () {//点击tr行的时候就把单选框给设置程被选状态
                var tru =  $("#table").children("tr").eq(this.$index).find("td").eq(0).find("input");
                if( tru.is(':checked')==true){
                    tru.prop("checked",false);
                }else {
                    tru.prop("checked", true);
                }
            };

            $("#update").click(function(){//刷新数据调用此方法
                extracted($scope.count1);
            });

        });
    }(jQuery));
</script>
</html>

