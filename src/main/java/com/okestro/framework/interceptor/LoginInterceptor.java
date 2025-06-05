package com.okestro.framework.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

public class LoginInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession(false);
        String requestURI = request.getRequestURI();

        if (requestURI.contains("/loginForm.do") ||
            requestURI.contains("/login.do") ||
            requestURI.contains("/registForm.do") ||
            requestURI.contains("/registerUserInfo.do") ||
            requestURI.contains("/checkEmailDuplicate.do")) {
            return true; // true → 요청을 계속 진행하도록 허용
        }

        if (session == null || session.getAttribute("loginUser") == null) {
            response.sendRedirect("/userinfo/loginForm.do");
            return false; // false → 요청 처리 중단
        }

        return true;
    }

    
}