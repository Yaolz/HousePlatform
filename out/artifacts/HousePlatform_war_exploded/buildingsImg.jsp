<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="zh">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>楼盘相册</title>
	<link href="http://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="<%=path%>/public/xiangcecss/css/htmleaf-demo.css">
	<link rel="stylesheet" href="<%=path%>/public/xiangcecss/css/baguetteBox.min.css">
	<link rel="stylesheet" href="<%=path%>/public/xiangcecss/css/gallery-grid.css">
	<script src="<%=path%>/public/angular/angular.min.js"></script>
</head>
<body ng-app="myApp">
	<div ng-controller="myCtrl" class="htmleaf-container">
		<div class="container gallery-container">
		    <div class="tz-gallery">
		        <div class="row" id="top">
					<div class="col-sm-6 col-md-3" style="height: 400px"  ng-show="result == 'success'" ng-repeat="b in buildingsImgPager">
						<a class="lightbox" href="<%=path%>/{{b.img_path}}">
							<img src="<%=path%>/{{b.img_path}}" alt="Sky">
						</a>
					</div>
		            <h3  ng-show="result == 'fail'">相册里什么都没有。。。</h3>
		        </div>
				<div class="row" ng-show="result == 'success'">
					<div class="col-sm-4">
						共 {{total}} 张图片，共{{totalPageSize}}页
						<a href="#top"  class="btn btn-primary btn-lg active" role="button">返回顶部</a>
					</div>
					<div class="col-sm-5">
						<nav aria-label="Page navigation" class="pull-right">
							<ul class="pagination">
								<li ng-click="top()"><a href="#top">«</a></li>
								<li><a class="page" ng-show="count1>=5 " ng-click="page(count1-4)">{{count1-4}}</a></li>
								<li><a class="page" ng-show="count1>=4 " ng-click="page(count1-3)">{{count1-3}}</a></li>
								<li><a class="page" ng-show="count1>=3 " ng-click="page(count1-2)">{{count1-2}}</a></li>
								<li><a class="page" ng-show="count1>=2 " ng-click="page(count1-1)">{{count1-1}}</a></li>
								<li class="active"><a class="page" ng-show="count1>0" ng-click="page(count1)" title="{{count1}}">{{count1}}</a></li>
								<li><a href="#top" class="page" ng-show="count1>0 && totalPageSize-1>= count1" ng-click="page(count1+1)">{{count1+1}}</a></li>
								<li><a href="#top" class="page" ng-show="count1>0 && (totalPageSize-2) >= count1" ng-click="page(count1+2)">{{count1+2}}</a></li>
								<li><a href="#top" class="page" ng-show="count1<3 && (totalPageSize-3) >= count1" ng-click="page(count1+3)">{{count1+3}}</a></li>
								<li><a href="#top" class="page" ng-show="count1<2 && (totalPageSize-4) >= count1" ng-click="page(count1+4)">{{count1+4}}</a></li>
								<li ng-click="down()"><a href="#top">»</a></li>
							</ul>
						</nav>
					</div>
				</div>
		    </div>

		</div>
	</div>
	<script src="<%=path%>/public/js/jquery.min.js"></script>
	<script src="<%=path %>/layer-v3.1.0/layer/layer.js"></script>
	<script type="text/javascript" id="my" src="<%=path%>/public/xiangcecss/js/baguetteBox.min.js"></script>
	<script type="text/javascript">

        (function($){
            var path = "<%=path%>/";
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
            app.controller('myCtrl', function($scope,$http,$timeout) {
                $scope.total = 0;
                $scope.totalPageSize = 0;
                $scope.count1 = 1;
				$scope.result = "";

                $scope.id = GetQueryString("buildingsId");
                extracted($scope.count1);

                function extracted(x) {
                    var index = layer.load(0, {shade: false});//发送请求时让页面出现加载样式
                    $http({
                        method: 'POST',
                        url: "<%=path%>/buildingsImg/allBuildingImg",
                        data: {"pageNo": x, "buildingsid":  $scope.id}
                    }).then(function successCallback(response) {

                        $scope.buildingsImgPager = response.data.buildingsImgPager.result;
                        $timeout(function(){
                            baguetteBox.run('.tz-gallery');
                        },100);
                        $scope.total = response.data.buildingsImgPager.total;
                        $scope.totalPageSize = response.data.buildingsImgPager.totalPageSize;
                        $scope.count1 = response.data.buildingsImgPager.pageNo;
                        $scope.result = response.data.controllerResult.result;
                        layer.close(index);//关闭加载窗口
                    }, function errorCallback(response) {

                    });
                }

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
                function GetQueryString(name) {//获取url上的值
                    var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
                    var r = window.location.search.substr(1).match(reg);
                    if(r!=null){
                        return  unescape(r[2]);
                    }
                    return null;
                }
            });
        }(jQuery));
	</script>
</body>
</html>