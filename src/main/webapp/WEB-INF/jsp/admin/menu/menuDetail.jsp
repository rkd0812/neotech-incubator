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
<script src="<c:url value="/app/js/admin/menu/menuDetail.js"/>"></script>
<script>
    const msg = "${msg}";
    if(msg != '') {
        alert(msg);
    }
</script>
<div id="page-wrapper">
    <div class="header">
        <h1 class="page-title">메뉴 상세</h1>
    </div>
    <div class="page-inner">
        <form id="menuInfoForm" name="menuInfoForm">
            <table>
                <colgroup>
                    <col style="width: 20%;" />
                    <col />
                </colgroup>
                <thead>
                    <tr>
                        <th>메뉴명</th>
                        <td>
                            <input type="hidden" id="menuId" name="menuId" value="${menuDetail.menuId}">
                            <input type="text" id="menuName" name="menuName" value="${menuDetail.menuName}">
                        </td>
                    </tr>
                    <tr>
                        <th>상위메뉴</th>
                        <td>
                            <select id="upperMenuId" name="upperMenuId">
                                <option value="">선택안함</option>
                                <c:forEach items="${menuList}" var="menu" varStatus="status">
                                    <c:if test="${menuDetail.menuName ne menu.menuName}">
                                        <option value="${menu.menuId}" <c:if test="${menu.menuId eq menuDetail.upperMenuId}">selected</c:if> >${menu.menuName}</option>
                                    </c:if>
                                </c:forEach>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th>메뉴레벨</th>
                        <td>${menuDetail.menuLevel}</td>
                    </tr>
                    <tr>
                        <th>등록일자</th>
                        <td>${menuDetail.frstRgsrDtlDttm}</td>
                    </tr>
                </thead>
            </table>
        </form>
        <div class="btnDiv">
            <button id="listBtn" onclick=location.href="/admin/menu/list.do">목록</button>
            <button id="updateBtn">수정</button>
            <button id="deleteBtn">삭제</button>
        </div>
    </div>
</div>
