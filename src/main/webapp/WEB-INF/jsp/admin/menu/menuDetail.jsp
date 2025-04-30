<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 25. 4. 28.
  Time: 오전 10:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>메뉴 상세</title>
    <c:import charEncoding="utf-8" url="/layout/cmmnlib.do" />
    <script src="<c:url value="/app/js/admin/menu/menuDetail.js"/>"></script>
</head>
<body>
<%@ include file="/WEB-INF/jsp/navBar/navBar.jsp"%>

<div id="page-wrapper">
    <div class="header">
        <h1 class="page-header">메뉴 상세</h1>
    </div>
    <div class="page-inner" style="text-align: center;">
        <form id="detailForm" name="detailForm" action="/admin/menu/update.do" method="post">
            <table style="width: 700px; border: solid 1px black; margin: 0 auto; text-align: center;">
                <colgroup>
                </colgroup>
                <thead>
                    <tr>
                        <th>메뉴아이디</th>
                        <td>
                            <input type="text" id="menuId" name="menuId" value="${menuDetail.menuId}" readonly="readonly" />
                        </td>
                    </tr>
                    <tr>
                        <th>메뉴명</th>
                        <td>
                            <input type="text" id="menuName" name="menuName" value="${menuDetail.menuName}">
                        </td>
                    </tr>
                    <tr>
                        <th>메뉴레벨</th>
                        <td>
                            <input type="text" id="menuLevel" name="menuLevel" value="${menuDetail.menuLevel}">
                        </td>
                    </tr>
                    <tr>
                        <th>등록일자</th>
                        <td><fmt:formatDate value="${menuDetail.frstRgsrDtlDttm}" pattern="y-MM-d" type="date"/></td>
                    </tr>
                </thead>
            </table>
        </form>
        <button id="listBtn" onclick=location.href="/admin/menu/list.do">목록</button>
        <button id="updateBtn">수정</button>
        <button id="deleteBtn">삭제</button>
    </div>
</div>
</body>
</html>
