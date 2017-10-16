<%--
  Created by IntelliJ IDEA.
  User: Master
  Date: 2017/9/8
  Time: 8:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%String path = request.getContextPath();%>
<!DOCTYPE html><html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bootstrap Fileinput Demo</title>
    <link href="<%=path%>/public/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%=path%>/public/css/bootstrap-fileinput.css" rel="stylesheet">
</head>
<body>
<div class="container">
    <div class="page-header">
        <h3>FormData图片上传</h3>
        <form id="form" enctype='multipart/form-data'>
            <div class="form-group"  >
                <div class="h4">图片预览</div>
                <div class="fileinput fileinput-new" data-provides="fileinput"  id="exampleInputUpload">
                    <div class="fileinput-new thumbnail" style="width: 200px;height: auto;max-height:150px;">
                        <img id='picImg' style="width: 100%;height: auto;max-height: 140px;" src="<%=path%>/public/img/noimage.png" alt="" />
                    </div>
                    <div class="fileinput-preview fileinput-exists thumbnail" style="max-width: 200px; max-height: 150px;"></div>
                    <div>
                        <span class="btn btn-primary btn-file">
                            <span class="fileinput-new">选择文件</span>
                            <span class="fileinput-exists">换一张</span>
                            <input type="file" name="upload" id="picID" accept="image/gif,image/jpeg,image/x-png"/>
                        </span>
                        <a href="javascript:;" class="btn btn-warning fileinput-exists" data-dismiss="fileinput">移除</a>
                    </div>
                    <input type="text" name="name"/>
                    <input type="text" name="phone"/>
                </div>
            </div>
            <button type="button" id="uploadSubmit" class="btn btn-info">提交</button>
        </form>
    </div>
</div>


<script src="<%=path%>/public/js/jquery.min.js"></script>
<script src="<%=path%>/public/js/bootstrap.min.js"></script>
<script src="<%=path%>/public/js/bootstrap-fileinput.js"></script>
<script src="<%=path%>/public/jquery-from/jquery-from.js"></script>
<script type="text/javascript">
    $(function () {
        //比较简洁，细节可自行完善

        $('#uploadSubmit').click(function () {
            $('#form').ajaxSubmit({
                url: '<%=path%>/test/uploadimg',
                type: 'POST',
                data: $("#form").serialize(),
                success: function (data) {
                    alert("提交成功");
                }
            });
        });

    })
</script>
</body>
</html>
