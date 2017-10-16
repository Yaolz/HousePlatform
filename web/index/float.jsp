<%--
  Created by IntelliJ IDEA.
  User: 娃娃鱼
  Date: 2017/9/18
  Time: 16:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<div id="elevator_item">
    <a id="elevator" onclick="return false;" title="回到顶部"></a>

    <a class="qr"></a>
    <div class="qr-popup">
        <a class="code-link"><img class="code" src="<%=request.getContextPath()%>/public/frontPage/images/wx.jpg"/></a>
        <span>加董事长兼CEO 真真为好友吧</span>
        <div class="arr"></div>
    </div>

    <a class="sl"></a>
    <div class="sl-popup">
        <span>shoulouwang@qq.com</span>
        <span>0797-666655</span>
    </div>
</div>

<script type="text/javascript">
    $(function() {
        $(window).scroll(function(){
            var scrolltop=$(this).scrollTop();
            if(scrolltop>=200){
                $("#elevator_item").show();
            }else{
                $("#elevator_item").hide();
            }
        });
        $("#elevator").click(function(){
            $("html,body").animate({scrollTop: 0}, 500);
        });

        $(".qr").hover(function(){
            $(".qr-popup").show();
        },function(){
            $(".qr-popup").hide();
        });

        $(".sl").hover(function(){
            $(".sl-popup").show();
        },function(){
            $(".sl-popup").hide();
        });

    });
</script>
