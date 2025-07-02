package com.crm.interceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.HandlerInterceptor;

public class LoginInterceptor implements HandlerInterceptor {
    
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        // 获取请求的URL
        String url = request.getRequestURI();
        
        // 登录相关的URL放行
        if (url.contains("/login") || url.contains("/static/")) {
            return true;
        }
        
        // 检查用户是否已登录
        Object user = request.getSession().getAttribute("user");
        if (user == null) {
            // 未登录则重定向到登录页面
            response.sendRedirect(request.getContextPath() + "/login");
            return false;
        }
        
        return true;
    }
} 