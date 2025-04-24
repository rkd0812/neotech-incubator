<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2025-04-16
  Time: 오후 3:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>사용자 목록</title>
    <c:import charEncoding="utf-8" url="/layout/cmmnlib.do" />
    <script src="/app/js/user/userDetail.js"></script>
</head>
<body>
    <h4>사용자 상세조회</h4>
    <div class="wrap" style="text-align: center;">
        <table style="width: 700px; border: solid 1px black; margin: 0 auto; text-align: center;">
            <tbody>
                <tr>
                    <th>이메일</th>
                    <td>${userDetail.userEmail}</td>
                </tr>
                <tr>
                    <th>비밀번호</th>
                    <td>${userDetail.userPassword}</td>
                </tr>
                <tr>
                    <th>권한</th>
                    <td>${userDetail.roleCd}</td>
                </tr>
            </tbody>
        </table>
        <button id="listBtn" onclick=location.href="/user/list.do">목록</button>
        <button id="updateBtn" onclick=location.href="">수정</button>
        <button id="deleteBtn" onclick=location.href="">삭제</button>
    </div>
</body>
</html>
