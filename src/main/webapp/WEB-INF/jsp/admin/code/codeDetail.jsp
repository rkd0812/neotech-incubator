<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 25. 4. 28.
  Time: 오후 5:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>코드 상세조회</title>
    <c:import charEncoding="utf-8" url="/layout/cmmnlib.do" />
    <script src="/app/js/admin/code/codeDetail.js"></script>
</head>
<body>
<%--<%@ include file="/WEB-INF/jsp/navBar/navBar.jsp"%>--%>
<script>
    const msg = "${msg}";
    if(msg != '') {
        alert(msg);
    }
</script>
<div id="page-wrapper">
    <div class="header">
        <h1 class="page-header">코드 상세조회</h1>
    </div>
    <div class="page-inner" style="text-align: center;">
        <form id="detailForm" name="detailForm" action="/admin/code/update.do" method="post">
            <table style="width: 700px; border: solid 1px black; margin: 0 auto; text-align: center;">
                <tbody>
                    <tr>
                        <th>코드분류</th>
                        <td>
                            <input type="hidden" name="preCodeName" value="${codeDetail.codeName}">
                            <select id="codeName" name="codeName">
                            <c:forEach items="${codeGroupList}" var="grp" varStatus="status">
                                <option value="${grp.codeName}" <c:if test="${codeDetail.codeName eq grp.codeName}">selected</c:if> >${grp.codeName}</option>
                            </c:forEach>
                        </td>
                    </tr>
                    <tr>
                        <th>코드값</th>
                        <td>
                            <input type="hidden" name="preCodeVal" value="${codeDetail.codeVal}">
                            <input type="text" id="codeVal" name="codeVal" value="${codeDetail.codeVal}" />
                        </td>
                    </tr>
                    <tr>
                        <th>코드명</th>
                        <td>
                            <input type="text" id="codeKr" name="codeKr" value="${codeDetail.codeKr}" />
                        </td>
                    </tr>
                    <tr>
                        <th>등록일자</th>
                        <td>
                            ${codeDetail.frstRgsrDtlDttm}
                        </td>
                    </tr>
                </tbody>
            </table>
        </form>
        <button id="listBtn" onclick=location.href="/admin/code/list.do">목록</button>
        <button id="updateBtn">수정</button>
        <button id="deleteBtn">삭제</button>
    </div>
</div>
</body>
</html>
