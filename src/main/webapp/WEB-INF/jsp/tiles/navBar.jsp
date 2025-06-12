<%@ page import="com.okestro.app.userinfo.UserInfoVo" %><%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2025-04-16
  Time: 오후 3:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    UserInfoVo loginUser = (UserInfoVo) session.getAttribute("loginUser");
    String userEmail = (String) session.getAttribute("userEmail");
    String userName = (String) session.getAttribute("userName");
    String codeName = (String) session.getAttribute("codeName");
%>

<div class="navbar bg-body-tertiary" >
    <div style="display: flex; justify-content: center;">
        <img src="/assets/img/logo_02.png" style="height: 90px;" onclick="location.href='/project/projectList.do';">
    </div>
    <c:if test="${loginUser ne null}">
        <div>
            <span><strong><%=userName%></strong> (<%=codeName%>)</span> &nbsp;
            <button class="btn btn-outline-primary" type="button" onclick="location.href='/userinfo/userDetail.do?userEmail=<%=userEmail%>'">내 정보</button>
            <button class="btn btn-outline-primary" type="button" onclick="location.href='/userinfo/logout.do'">로그아웃</button>
        </div>
    </c:if>
</div>


<%--<div class="navbar bg-body-tertiary">--%>
<%--    <div class="container-fluid">--%>
<%--        <a class="navbar-brand">Navbar</a>--%>
<%--        <form class="d-flex" role="search">--%>
<%--            <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search"/>--%>
<%--            <button class="btn btn-outline-success" type="submit">Search</button>--%>
<%--        </form>--%>
<%--    </div>--%>
<%--</div>--%>

