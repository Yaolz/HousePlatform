<%--
  Created by IntelliJ IDEA.
  User: Master
  Date: 2017/9/11
  Time: 19:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%String path = request.getContextPath();%><!DOCTYPE html>
<html>
<head>
    <title>Title</title>
</head>
<body>
<script language="javascript" type="text/javascript">
    // 以下方式直接跳转
    window.location.href='<%=path%>/index/index';
    // 以下方式定时跳转
    setTimeout("javascript:location.href='hello.html'", 5000);
</script>
</body>
</html>
