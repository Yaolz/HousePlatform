package com.ht.interceptor;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;

import java.util.Map;

/**
 * Created by 娃娃鱼 on 2017/8/28.
 *判断用户未登录时跳转到登录页面
 */
public class UserLoginInterceptor extends AbstractInterceptor {
    @Override
    public String intercept(ActionInvocation invocation) throws Exception {
        ActionContext actionContext = invocation.getInvocationContext(); // 获取action上下文对象
        Map<String, Object> session = actionContext.getSession();
        if(session.get("user") != null) {
            String result = invocation.invoke();
            return result;
        } else {
            return "login";
        }
    }
}
