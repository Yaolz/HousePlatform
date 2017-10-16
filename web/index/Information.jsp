<%--
Created by IntelliJ IDEA.
User: yao
Date: 2017/9/12
Time: 20:06
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
<link rel="stylesheet" href="<%=path %>/index/css/buildings.css">
<link rel="stylesheet" href="<%=path %>/jquery-pretty-radio-checkbox/css/jquery-labelauty.css">
<link rel="stylesheet" href="<%=path %>/public/frontPage/images/BackTopStyle.css">
<script src="<%=path%>/public/angular/angular.min.js"></script>
<style>
    a:hover {
        text-decoration: none;
    }

    .item-desc {
        width: 710px;
        height: 60px;
        overflow: hidden;
        position: relative;
    }

    .item-desc::after {
        content: " ..... ";
        bottom: 5px;
        right: 3px;
        position: absolute;
        background-color: #fff;
    }

    ul {
        list-style-type: none;
    }

    li {
        display: inline-block;
    }

    li {
        margin: 10px 0;
        margin-right: 5px;
    }

    input.labelauty + label {
        font: 12px "Microsoft Yahei";
    }
</style>
<body ng-app="myApp" ng-controller="myCtrl">
<%@include file="../main/toubu.jsp" %>
<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <div class="col-lg-1"></div>
            <div class="container col-lg-10">

                <div class="row">
                    <div class="col-lg-7">
                        <div id="ads0" style="width: 100%">
                            <a target="_blank" href="{{ads[0].ad_url}}">
                                <img src="<%=path %>/{{ads[0].logo}}" title="{{ads[0].title}}" class="img-responsive" width="100%"
                                     height="auto">
                            </a>
                        </div>
                        <div class="hidden" id="noads0" style="width: 100%">
                            <a target="_blank"
                               href="http://mail.qq.com/cgi-bin/qm_share?t=qm_mailme&email=shoulouwang@qq.com">
                                <img src="<%=path %>/images/timg.jpg" title="点击投放广告" class="img-responsive" width="100%" height="520px;">
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-5">
                        <div id="ads1" style="width: 100%">
                            <a target="_blank" href="{{ads[1].ad_url}}">
                                <img src="<%=path %>/{{ads[1].logo}}" title="{{ads[1].title}}" class="img-responsive" width="100%"
                                     height="250px;">
                            </a>
                        </div>
                        <div class="hidden" id="noads1" style="width: 100%">
                            <a target="_blank"
                               href="http://mail.qq.com/cgi-bin/qm_share?t=qm_mailme&email=shoulouwang@qq.com">
                                <img src="<%=path %>/images/timg.jpg" title="点击投放广告" class="img-responsive" width="100%" height="250px;">
                            </a>
                        </div>
                        <br/>
                        <div id="ads2" style="width: 100%">
                            <a target="_blank" href="{{ads[2].ad_url}}">
                                <img src="<%=path %>/{{ads[2].logo}}" title="{{ads[2].title}}" class="img-responsive" width="100%"
                                     height="250px;">
                            </a>
                        </div>
                        <div class="hidden" id="noads2" style="width: 100%">
                            <a target="_blank"
                               href="http://mail.qq.com/cgi-bin/qm_share?t=qm_mailme&email=shoulouwang@qq.com">
                                <img src="<%=path %>/images/timg.jpg" title="点击投放广告" class="img-responsive" width="100%" height="250px;">
                            </a>
                        </div>
                    </div>
                </div>

                <div class="row"  style="margin-top: 20px;">
                    <div class="col-lg-6 col-lg-offset-6 col-sm-12 col-sm-offset-0 col-md-8 col-md-offset-4">
                        <div class="input-group">
                            <input type="text" id="like" class="form-control" placeholder="查找文章...">
                            <span class="input-group-btn">
                    <button class="btn btn-default" type="button" ng-click="like()">搜索</button>
                  </span>
                        </div>
                        <div class="input-group">
                            <button type="button" style="color: #dc000b" id="none" ng-click="none()" class="close hidden">
                                取消&times;
                            </button>
                        </div>
                    </div>
                </div>

                <div class="find_kuang top">
                    <div class="row top_xuxian">
                        <div class="col-xs-2">
                            <h3 class="text-center">类型分类</h3>
                        </div>
                        <div class="col-xs-10">
                            <ul class="dowebok">
                                <li><input class="radio" type="radio" name="typeId" ng-click="find($event)" checked="checked" value=" "
                                           data-labelauty="不限"></li>
                                <li ng-repeat="type in articleType">
                                    <input class="radio" type="radio" name="typeId" ng-click="find($event)" value="{{type.id}}" data-labelauty="{{type.name}}">
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>

                <div class="row" style="margin-top: 20px;" ng-repeat="a in article">
                    <div class="col-lg-4">
                        <img ng-show="{{a.logo != null }}" src="<%=path %>/{{a.logo}}" class="img-responsive"
                             style="width: 296px;height: 180px;"/>
                        <img ng-show="{{a.logo == null }}" src="<%=path %>/public/1.png" class="img-responsive"
                             style="width: 220px;height: 180px;"/>
                    </div>
                    <div class="col-lg-8">
                        <h4><a href="<%=path %>/article/articleDetail?article.id={{a.id}}">{{a.title}}</a></h4>
                        <p class="text-left">类别：{{a.articleType.name}}</p>
                        <p style="margin-left: 20px;">简介：{{a.abstracts}}</p>
                        <p class="item-desc">
                            &nbsp;&nbsp; &nbsp;{{a.content}}
                        </p>
                        <p class="text-right">发表时间：{{a.created_time | date:'yyyy-MM-dd HH:mm'}}</p>
                    </div>
                </div>


                <div class="row" ng-show="article != ''">
                    <div class="col-sm-4">
                        共 {{total}} 个文章，共{{totalPageSize}}页
                    </div>
                    <div class="col-sm-4 ">
                        <nav aria-label="Page navigation" class="pull-right">
                            <ul class="pagination">
                                <li ng-click="top()"><a href="#top">«</a></li>
                                <li><a href="#top" class="page" ng-show="count1>=5 " ng-click="page(count1-4)">{{count1-4}}</a>
                                </li>
                                <li><a href="#top" class="page" ng-show="count1>=4 " ng-click="page(count1-3)">{{count1-3}}</a>
                                </li>
                                <li><a href="#top" class="page" ng-show="count1>=3 " ng-click="page(count1-2)">{{count1-2}}</a>
                                </li>
                                <li><a href="#top" class="page" ng-show="count1>=2 " ng-click="page(count1-1)">{{count1-1}}</a>
                                </li>
                                <li class="active"><a href="#top" class="page" ng-show="count1>0"
                                                      ng-click="page(count1)"
                                                      title="{{count1}}">{{count1}}</a></li>
                                <li><a href="#top" class="page" ng-show="count1>0 && totalPageSize-1>= count1"
                                       ng-click="page(count1+1)">{{count1+1}}</a></li>
                                <li><a href="#top" class="page" ng-show="count1>0 && (totalPageSize-2) >= count1"
                                       ng-click="page(count1+2)">{{count1+2}}</a></li>
                                <li><a href="#top" class="page" ng-show="count1<3 && (totalPageSize-3) >= count1"
                                       ng-click="page(count1+3)">{{count1+3}}</a></li>
                                <li><a href="#top" class="page" ng-show="count1<2 && (totalPageSize-4) >= count1"
                                       ng-click="page(count1+4)">{{count1+4}}</a></li>
                                <li ng-click="down()"><a href="#top">»</a></li>
                            </ul>
                        </nav>
                    </div>
                    <div class="col-sm-4">
                    </div>
                </div>
                <div ng-show="article == ''">
                    <p>该类别暂无相关文章</p>
                </div>

            </div>
            <div class="col-lg-1"></div>
        </div>
    </div>
</div>
<%@include file="../main/banquan.jsp" %>
<div id="elevator_item">
    <a id="elevator" onclick="return false;" title="回到顶部"></a>

    <a class="qr"></a>
    <div class="qr-popup">
        <a class="code-link"><img class="code" src="<%=path%>/public/frontPage/images/wx.jpg"/></a>
        <span>微信公众号</span>
        <div class="arr"></div>
    </div>

    <a class="sl" target="_blank" href="http://mail.qq.com/cgi-bin/qm_share?t=qm_mailme&email=shoulouwang@qq.com"></a>
</div>

</body>
<script src="<%=path%>/public/js/jquery.min.js"></script>
<script src="<%=path%>/public/js/bootstrap.min.js"></script>
<script src="<%=path %>/layer-v3.1.0/layer/layer.js"></script>
<script src="<%=path%>/jquery-pretty-radio-checkbox/js/jquery-labelauty.js" type="text/javascript"></script>
<script src="<%=path%>/index/js/top.js"></script>
<script src="<%=path%>/index/js/index.js"></script>
<script type="text/javascript">
    $(function () {

    });
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
            $http({
                method: 'POST',
                url: $("#path").val() + "/user/queryUser"
            }).then(function successCallback(response) {
                $scope.user = response.data.user;

            }, function errorCallback(response) {
            });
            //显示文章类别
            $http({
                method: 'POST',
                url: "<%=path%>/type/showType"
            }).then(function successCallback(response) {
                $scope.articleType = response.data.articleTypes;
                setTimeout(function () {
                    $(":input[class='radio']").labelauty();
                }, 100);
            }, function errorCallback(response) {
            });
            // 显示广告
            $http({
                method: 'POST',
                url: "<%=path%>/ads/adsShow",
                data: {"beginNum": 11, "endNum": 13}
            }).then(function successCallback(response) {
                $scope.ads = response.data.adsList;
                if ($scope.ads[0] == null || $scope.ads[0] == '' || $scope.ads[0] == undefined) {
                    $("#noads0").removeClass("hidden");
                    $("#ads0").addClass("hidden");
                }
                if ($scope.ads[1] == null || $scope.ads[1] == '' || $scope.ads[1] == undefined) {
                    $("#noads1").removeClass("hidden");
                    $("#ads1").addClass("hidden");
                }
                if ($scope.ads[2] == null || $scope.ads[2] == '' || $scope.ads[2] == undefined) {
                    $("#noads2").removeClass("hidden");
                    $("#ads2").addClass("hidden");
                }
            }, function errorCallback(response) {
            });

            $scope.total = 0;
            $scope.totalPageSize = 0;
            $scope.article = "";
            $scope.count1 = 1;
            $scope.likes = '';
            $scope.typeId = '';
            extracted($scope.count1);

            function extracted(x) {
                $http({
                    method: 'POST',
                    url: "<%=path%>/article/articleIndex",
                    data: {
                        "pageNo": x,
                        "like": $scope.likes,
                        "typeId": $scope.typeId
                    }
                }).then(function successCallback(response) {
                    $scope.total = response.data.pager.total;
                    $scope.totalPageSize = response.data.pager.totalPageSize;
                    $scope.article = response.data.pager.result;
                    $scope.count1 = response.data.pager.pageNo;
                }, function errorCallback(response) {
                });
            }

            $scope.find = function(event) {
                $scope.typeId = $(event.target).attr('value')
                extracted(1);
            }

            $scope.like = function () {//点击搜索时
                $scope.likes = $("#like").val();
                $("#none").removeClass("hidden");
                $("#none").html("'" + $scope.likes + "'&times;");
                extracted(1);
            };

            $scope.none = function () {
                $scope.likes = '';
                $("#start_time").addClass("hidden");
                $("#none").text("");
                $("#like").val("");
                extracted(1);
            };

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
        });
    }(jQuery));
</script>
</html >
