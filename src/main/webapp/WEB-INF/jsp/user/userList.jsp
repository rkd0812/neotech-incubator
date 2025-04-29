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
    <script src="/app/js/user/userList.js"></script>
</head>
<body>
    <h4>사용자 목록조회</h4>
    <div class="wrap" style="text-align: center;">
        <form id="searchForm" name="searchForm" action="/user/list.do">
            <table style="width: 700px; border: solid 1px black; margin: 0 auto; text-align: center; ">
                <colgroup>
                    <col style="width: 30%;">
                    <col style="width: auto;">
                </colgroup>
                <tbody>
                    <tr>
                        <th>이메일</th>
                        <td><input type="text" name="userEmail" value="${userVo.userEmail}" /></td>
                    </tr>
                    <tr>
                        <th>권한</th>
                        <td>
                            <input type="radio" name="roleCd" id="All" value="All" checked="checked" /> 전체 &nbsp;
                            <c:forEach var="role" items="#{codeList}" varStatus="status">
                            <input type="radio" id="${role.codeVal}" name="roleCd" value="${role.codeVal}" <c:if test="${userVo.roleCd eq role.codeVal}">checked</c:if > > ${role.codeKr} &nbsp;
                            </c:forEach>
                        </td>
                    </tr>
                </tbody>
            </table>
        </form>
        <button id="initBtn">초기화</button>
        <button id="searchBtn">검색</button>
        <table style="width: 700px; border: solid 1px black; margin: 0 auto; text-align: center;">
            <colgroup>
                <col style="width: 20%;">
                <col style="width: 60%;">
                <col style="width: auto;">
            </colgroup>
            <thead>
                <tr>
                    <th>No</th>
                    <th>이메일</th>
                    <th>권한</th>
                </tr>
            </thead>
            <tbody>
            <c:if test="${userList.size() eq 0}">
                <tr>
                    <td colspan="3">
                        조회된 데이터가 없습니다
                    </td>
                </tr>
            </c:if>
                <c:forEach var="user" items="${userList}" varStatus="status">
                    <tr>
                        <td>${status.count}</td>
                    <td>
                        <a href="/user/detail.do?userEmail=${user.userEmail}" class="userEmail">${user.userEmail}</a>
                    </td>
                        <td>${user.codeKr}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <button id="registBtn">등록</button>
    </div>
</body>
</html>
