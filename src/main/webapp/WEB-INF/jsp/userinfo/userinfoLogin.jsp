<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2025-04-29
  Time: 오후 2:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>로그인</title>
    <c:import charEncoding="utf-8" url="/layout/cmmnlib.do" />
    <script src="/app/js/userinfo/userinfoLogin.js"></script>
</head>
<body>
<h1>로고</h1>

<div>
    <form id="userLogin" action="/userinfo/login.do" method="post">
        <table>
            <tr>
                <td>이메일 : </td>
                <td><input type="email" id="userEmail" name="userEmail" value="${userEmail}" placeholder="이메일을 입력하세요" required></td>
            </tr>
            <tr>
                <td>비밀번호 : </td>
                <td><input type="password" id="userPassword" name="userPassword" placeholder="비밀번호를 입력하세요" required></td>
            </tr>
            <tr>
                <td colspan="2">
                    <button type="submit" id="loginBtn">로그인</button>
                    <button type="button" id="registerBtn">회원가입</button>
                </td>
            </tr>
        </table>
    </form>

</div>
</body>
</html>
