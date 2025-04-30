<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2025-04-24
  Time: 오후 2:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>메뉴 관리</title>
    <c:import charEncoding="utf-8" url="/layout/cmmnlib.do" />
    <script src="/app/js/admin/menu/menuList.js"></script>
</head>
<body>
<%@ include file="/WEB-INF/jsp/navBar/navBar.jsp"%>

<div id="page-wrapper">
    <div class="header">
        <h1 class="page-header">메뉴 목록조회</h1>
    </div>
    <div id="page-inner" style="text-align: center;">
        <form id="searchForm" name="searchForm" action="/admin/menu/list.do" >
            <table style="width: 700px; border: solid 1px black; margin: 0 auto; text-align: center;">
                <colgroup>

                </colgroup>
                <tbody>
                    <tr>
                        <th>메뉴</th>
                        <td><input type="text" id="menuName" name="menuName" value="${menuVo.menuName}" /></td>
                    </tr>
                </tbody>
            </table>
        </form>
        <button id="initBtn">초기화</button>
        <button id="searchBtn">검색</button>
        <table style="width: 700px; border: solid 1px black; margin: 0 auto; text-align: center;">
            <colgroup>
            </colgroup>
            <thead>
                <tr>
                    <th>메뉴명</th>
                    <th>메뉴레벨</th>
                </tr>
            </thead>
            <tbody>
            <c:if test="${menuList.size() eq 0}">
                <tr>
                    <td colspan="2">
                        조회된 데이터가 없습니다
                    </td>
                </tr>
            </c:if>
                <c:forEach var="menu" items="#{menuList}" varStatus="status">
                    <tr>
                        <td><a href="/admin/menu/detail.do?menuId=${menu.menuId}">${menu.menuName}</a></td>
                        <td>${menu.menuLevel}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <button id="registBtn">등록</button>
    </div>
</div>

</body>
</html>
