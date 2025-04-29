<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2025-04-25
  Time: 오후 4:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>사용자 목록</title>
    <c:import charEncoding="utf-8" url="/layout/cmmnlib.do" />
    <script src="/app/js/userinfo/userinfoList.js"></script>
</head>
<body>
<input type="hidden" id="messageValue" value="${message}">

<h1>로고</h1>

<table border="1">
    <thead>
    <tr>
        <th>이메일</th>
        <th>비밀번호</th>
        <th>권한코드</th>
        <th>권한자</th>
    </tr>
    </thead>
    <tbody id="alluserinfo">
    <c:forEach items="${userinfoList}" var="user">
        <tr>
            <td><a href="/userinfo/userDetail.do?userEmail=${user.userEmail}">${user.userEmail}</a></td>
            <td>${user.userPassword}</td>
            <td>${user.roleCd}</td>
            <td>${user.codeKr}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<button id="rgsbtn">유저등록</button>
</body>
</html>
