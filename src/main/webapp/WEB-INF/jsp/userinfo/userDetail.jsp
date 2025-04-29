<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2025-04-28
  Time: 오후 4:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>유저 상세 정보</title>
    <c:import charEncoding="utf-8" url="/layout/cmmnlib.do" />
    <script src="/app/js/userinfo/userDetail.js"></script>
</head>
<body>
<div>
    <table border="1">
        <tr>
            <td>이메일</td>
            <td>${userInfo.userEmail}</td>
        </tr>
        <tr>
            <td>비밀번호</td>
            <td>${userInfo.userPassword}</td>
        </tr>
        <tr>
            <td>권한코드</td>
            <td>${userInfo.roleCd}</td>
        </tr>
        <tr>
            <td>권한명</td>
            <td>${userInfo.codeKr}</td>
        </tr>
    </table>
</div>
<div>
    <button id="updateBtn">수정</button>
    <button id="deleteBtn">삭제</button>
    <button id="listBtn">목록</button>
</div>
    <form id="deleteForm" action="/userinfo/deleteUserInfo.do" method="post">
        <input type="hidden" name="userEmail" value="${userInfo.userEmail}">
    </form>
<div>


</div>
</body>
</html>
