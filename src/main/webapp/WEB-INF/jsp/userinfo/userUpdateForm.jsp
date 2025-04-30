<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2025-04-28
  Time: 오후 4:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>사용자 정보 수정</title>
    <c:import charEncoding="utf-8" url="/layout/cmmnlib.do" />
    <script src="/app/js/userinfo/userUpdateForm.js"></script>
</head>
<body>
<h1>사용자 정보 수정</h1>
<div>
    <form id="updateForm" action="/userinfo/updateUserInfo.do" method="post">
        <table>
            <tr>
                <td>이메일 : </td>
                <td>${userInfo.userEmail}</td>
            </tr>
            <tr>
                <td>비밀번호 : </td>
                <td><input type="password" id="userPassword" name="userPassword" value="${userInfo.userPassword}" required></td>
            </tr>
            <tr>
                <td>비밀번호 확인 : </td>
                <td><input type="password" id="passwordConfirm" value="${userInfo.userPassword}" required></td>
            </tr>
            <tr>
                <td colspan="2">
                    * 10~16자리 영문/숫자 또는 영문/숫자/특수문자[!@#$%^&*()]혼용
                </td>
            </tr>
            <tr>
                <td>권한:</td>
                <td>
                    <select name="roleCd" id="roleCd">
                        <option value="A" ${userInfo.roleCd eq 'A' ? 'selected' : ''}>A (일반)</option>
                        <option value="B" ${userInfo.roleCd eq 'B' ? 'selected' : ''}>B (심사자)</option>
                        <option value="C" ${userInfo.roleCd eq 'C' ? 'selected' : ''}>C (심사장)</option>
                        <option value="ZZ" ${userInfo.roleCd eq 'ZZ' ? 'selected' : ''}>ZZ (시스템)</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <button type="button" id="updateSubmitBtn">수정</button>
                    <button type="button" id="cancelBtn">취소</button>
                </td>
            </tr>
        </table>
        <!-- 이메일은 변경할 수 없으므로 hidden으로 처리하고 id 추가 -->
        <input type="hidden" id="hiddenUserEmail" name="userEmail" value="${userInfo.userEmail}">
    </form>
</div>
</body>
</html>
