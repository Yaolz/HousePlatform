package com.ht.filter;

import javax.servlet.*;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 
 * 
 *输入.jsp自动跳转到首页
 */
public class ManageFilter implements Filter{

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletResponse resp = (HttpServletResponse)response;
		resp.sendRedirect("/index.jsp"); // 输入.jsp页面则跳转到指定的这个页面。
		chain.doFilter(request, response);
	}

	@Override
	public void destroy() {
		
	}

}
