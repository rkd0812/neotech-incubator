<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2025-06-23
  Time: 오후 4:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script> <%-- 뭐가 문제인지 파악 --%>
<script src="<c:url value="/app/js/project/selectProjectTeam.js"/>"></script> <%--필수 --%>
<!DOCTYPE html>
<html>
<head>
    <title>팀원 선택</title>
</head>
<body>
<h2>팀 구성원 선택</h2>

<table border="1" style="width: 100%; border-collapse: collapse;">
    <tr>
        <th style="width: 10%; padding: 8px;">선택</th>
        <th style="width: 30%; padding: 8px;">이름</th>
        <th style="width: 60%; padding: 8px;">이메일</th>
    </tr>

    <!-- DB에서 가져온 실제 사용자 데이터 -->
    <c:forEach var="user" items="${userList}">
        <tr>
            <td style="text-align: center; padding: 8px;">
                <input type="checkbox" name="member"
                       value="${user.userEmail}"
                       data-name="${user.userName}">
            </td>
            <td style="padding: 8px;">${user.userName}</td>
            <td style="padding: 8px;">${user.userEmail}</td>
        </tr>
    </c:forEach>

    <!-- 데이터가 없을 때 -->
    <c:if test="${empty userList}">
        <tr>
            <td colspan="3" style="text-align: center; padding: 20px;">
                등록된 사용자가 없습니다.
            </td>
        </tr>
    </c:if>
</table>

<br>
<div style="text-align: center;">
    <button type="button" id="selectBtn" style="padding: 8px 20px; margin-right: 10px;">선택 완료</button>
    <button type="button" id="cancelBtn" style="padding: 8px 20px;">취소</button>
</div>
</body>
</html>