<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2025-04-25
  Time: 오후 4:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>회원 등록</title>
    <c:import charEncoding="utf-8" url="/layout/cmmnlib.do" />
    <script src="/app/js/userinfo/registForm.js"></script>

<body>
<h1>로고</h1>

<form id="userForm" action="/userinfo/registerUserInfo.do" method="post">
    <table>
        <tr>
            <td>이메일 : </td>
            <td><input type="text" id="userEmail"  placeholder="이메일을 입력하세요.">
            <span>@</span>
                <input type="text" id="userDomain" name="userDomain">
                <select id="domainList">
                    <option value="">직접 입렵</option>
                    <option value="naver.com">naver.com</option>
                    <option value="googel.com">googel.com</option>
                    <option value="kakao.com">kakao.com</option>
                    <option value="daum.net">daum.net</option>
                </select>
                <input type="hidden" id="dbEmail" name="userEmail">
                <button type="button" id="checkemailBtn">중복확인</button>
            </td>
        </tr>
        <tr>
            <td>비밀번호 : </td>
            <td><input type="password" id="userPassword" name="userPassword" placeholder="비밀번호를 입력하세요."></td>
        </tr>
        <tr>
            <td>비밀번호 확인 : </td>
            <td><input type="password" id="passwordConfirm" name="passwordConfirm" placeholder="비밀번호를 입력하세요."></td>
        </tr>
        <tr>
            <td colspan="2">
                * 10~16자리 영문/숫자 또는 영문/숫자/특수문자[!@#$%^&*()]혼용
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <button type="button" id="registerBtn">회원 등록</button>
            </td>
        </tr>
    </table>
    <input type="hidden" name="roleCd" value="A">
</form>
</body>
</html>
