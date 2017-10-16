<%--
  Created by IntelliJ IDEA.
  User: Animo
  Date: 2017-06-23
  Time: 10:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%>
<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title> - 百度Web Uploader</title>
    <meta name="keywords" content="">
    <meta name="description" content="">

    <link rel="shortcut icon" href="favicon.ico">
    <link rel="stylesheet" type="text/css" href="<%=path%>/public/css/upimage/webuploader.css">
    <link rel="stylesheet" type="text/css" href="<%=path%>/public/css/upimage/demo/webuploader-demo.css">
    <link href="<%=path%>/public/css/upimage/style.css?v=4.1.0" rel="stylesheet">

</head>

<body class="gray-bg">

<div class="row">
    <div class="col-sm-12">
        <div class="ibox float-e-margins">
            <div class="ibox-title">
                <h5>上传楼盘图片</h5>
                <div class="ibox-tools">
                    <a class="collapse-link">
                        <i class="fa fa-chevron-up"></i>
                    </a>
                    <a class="dropdown-toggle" data-toggle="dropdown" href="form_file_upload.html#">
                        <i class="fa fa-wrench"></i>
                    </a>
                    <a class="close-link">
                        <i class="fa fa-times"></i>
                    </a>
                </div>
            </div>
            <div class="ibox-content">
                <div class="page-container">
                    <p>您可以尝试文件拖拽，使用QQ截屏工具，然后激活窗口后粘贴，或者点击添加图片按钮</p>
                    <div id="uploader" class="wu-example">
                        <div class="queueList">
                            <div id="dndArea" class="placeholder">
                                <div id="filePicker"></div>
                                <p>或将照片拖到这里，单次最多可选300张</p>
                            </div>
                        </div>
                        <div class="statusBar" style="display:none;">
                            <div class="progress">
                                <span class="text">0%</span>
                                <span class="percentage"></span>
                            </div>
                            <div class="info"></div>
                            <div class="btns">
                                <div id="filePicker2"></div>
                                <div class="uploadBtn">开始上传</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- 全局js -->
<script src="<%=path %>/public/js/jquery.min.js"></script>

<!-- Web Uploader -->
<script type="text/javascript">
    // 添加全局站点信息
    function GetQueryString(name) {//获取url上的值
        var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if(r!=null){
            return  unescape(r[2]);
        }
        return null;
    }
    var id = GetQueryString("buildingsId");
    var PATH='<%=path%>/buildingsImg/updateBuildingImg?buildings.id='+id;
    var BASE_URL = '<%=path%>/js/webuploader';
</script>
<script src="<%=path %>/layer-v3.1.0/layer/layer.js"></script>
<script src="<%=path%>/public/uploadingImg/webuploader/webuploader.js"></script>
<script src="<%=path%>/public/uploadingImg/demo/webuploader-demo.js"></script>




</body>

</html>
