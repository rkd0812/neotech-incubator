<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2025-04-28
  Time: 오후 4:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="<c:url value="/app/js/userinfo/userDetail.js"/>"></script> <%-- 필수 --%>
<div>
    <h2>사용자 상세 정보</h2>
    <table border="1">
        <tr>
            <td>이메일</td>
            <td id="displayEmail">${userInfo.userEmail}</td>
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
    <form id="updateForm" action="/userinfo/updateForm.do" method="get" style="display:inline;">
        <input type="hidden" name="userEmail" value="${userInfo.userEmail}">
        <button type="submit">수정</button>
    </form>
    <button id="deleteBtn">회원탈퇴</button>
    <form method="get" action="/project/projectList.do" style="display: inline;">
        <button type="submit" id="listBtn">HOME</button>
    </form>

</div>
<form id="deleteForm" action="/userinfo/deleteUserInfo.do" method="post">
    <input type="hidden" name="userEmail" value="${userInfo.userEmail}">
</form>
<%--</body>--%>
<%--</html>--%>
