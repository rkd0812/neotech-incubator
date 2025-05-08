<%--
  Created by IntelliJ IDEA.
  User: yungayoung
  Date: 25. 4. 25.
  Time: 오후 4:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>사용자 등록</title>
    <c:import charEncoding="utf-8" url="/layout/cmmnlib.do" />
    <script src="/app/js/admin/user/userRegist.js"></script>
</head>
<body>
<%--<%@ include file="/WEB-INF/jsp/navBar/navBar.jsp"%>--%>

<div id="page-wrapper">
    <div class="header">
        <h1 class="page-header">사용자 등록</h1>
            <div class="page-inner" style="text-align: center;">
                <form id="registForm" name="registForm" action="/admin/user/regist.do" method="post">
                    <table style="width: 700px; border: solid 1px black; margin: 0 auto; text-align: center;">
                        <tbody>
                            <tr>
                                <th>이메일</th>
                                <td><input type="text" id="userEmail" name="userEmail" /></td>
                            </tr>
                            <tr>
                                <th>비밀번호</th>
                                <td><input type="text" id="userPassword" name="userPassword" /></td>
                            </tr>
                            <tr>
                                <th>권한</th>
                                <td>
                                    <select id="roleCd" name="roleCd">
                                        <c:forEach var="role" items="#{codeList}" varStatus="status">
                                            <option value="${role.codeVal}" <c:if test="${userDetail.roleCd eq role.codeVal}">selected</c:if> >${role.codeKr}</option>
                                        </c:forEach>
                                    </select>
                                 </td>
                            </tr>
                        </tbody>
                    </table>
                </form>
                <button id="btnCancel" onclick=location.href="/admin/user/list.do">취소</button>
                <button id="btnRegist">등록</button>
            </div>
    </div>
</div>
</body>
</html>
