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
<h1>회원 등록</h1>

<form id="userForm" action="/userinfo/registerUserInfo.do" method="post">
    <table>
        <tr>
            <td>이메일 : </td>
            <td><input type="email" id="userEmail" name="userEmail" placeholder="이메일을 입력하세요." required></td>
            <button type="button" id="checkemailBtn">중복확인</button>
        </tr>
        <tr>
            <td>비밀번호 : </td>
            <td><input type="password" id="userPassword" name="userPassword" placeholder="비밀번호를 입력하세요." required></td>
        </tr>
        <tr>
            <td>비밀번호 확인 : </td>
            <td><input type="password" id="passwordConfirm" name="passwordConfirm" placeholder="비밀번호를 입력하세요."  required></td>
        </tr>
        <tr>
            <td colspan="2">
                * 10~16자리 영문/숫자 또는 영문/숫자/특수문자[!@#$%^&*()]혼용
            </td>
        </tr>
        <tr>
<%--            <td>권한:</td>--%>
<%--            <td>--%>
<%--                <select name="roleCd">--%>
<%--                    <option value="a">A (일반)</option>--%>
<%--                    <option value="b">B (심사자)</option>--%>
<%--                    <option value="c">C (심사장)</option>--%>
<%--                    <option value="zz">ZZ (시스템)</option>--%>
<%--                </select>--%>
<%--                <select name="codeKr">--%>
<%--                    <c:forEach items="${roleList} var=role">--%>
<%--                        <option value="${role.codeCd}">${role.codeCd} (${role.codeKr}</option>--%>
<%--                    </c:forEach>--%>
<%--                </select>--%>
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
