<%--
  Created by IntelliJ IDEA.
  User: Master
  Date: 2017/4/8
  Time: 10:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<style>
    .bs-docs-footer {
        padding-top: 50px;
        padding-bottom: 50px;
        margin-top: 100px;
        color: #99979c;
        text-align: center;
        background-color: #2a2730;
    }

    .bs-docs-footer a {
        color: #fff;
    }

    .bs-docs-footer-links {
        padding-left: 0;
        margin-bottom: 20px;
    }
</style>
<footer class="bs-docs-footer">
    <div class="container">
        <ul class="list-inline bs-docs-footer-links">
            <li><a href="<%=request.getContextPath()%>/index/index">首页</a></li>
            <li><a href="<%=request.getContextPath()%>/index/indexRegister">注册</a></li>
            <li><a href="<%=request.getContextPath()%>/index/indexlogin">登录</a></li>
            <li><a target="_blank" href="http://mail.qq.com/cgi-bin/qm_share?t=qm_mailme&email=shoulouwang@qq.com">联系我们</a></li>
        </ul>
        <p>如果你发现 网站 存在的问题，请发送邮件至：<a target="_blank" href="http://mail.qq.com/cgi-bin/qm_share?t=qm_mailme&email=shoulouwang@qq.com">shoulouwang@qq.com</a></p>
        <p>版权所有©2017售楼网版权所有</p>
    </div>
</footer>