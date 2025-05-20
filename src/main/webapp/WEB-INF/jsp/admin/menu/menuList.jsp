<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2025-04-24
  Time: 오후 2:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="/app/js/admin/menu/menuList.js"></script>
<script>
    const msg = "${msg}";
    if(msg != '') {
        alert(msg);
    }
</script>
<div id="page-wrapper">
    <div class="header">
        <h1 class="page-header">메뉴 목록조회</h1>
    </div>
    <div id="page-inner" style="text-align: center;">
        <form id="searchForm" name="searchForm" action="/admin/menu/list.do" >
            <table style="width: 700px; border: solid 1px black; margin: 0 auto; text-align: center;">
                <colgroup>
                    <col style="width: 30%;"/>
                    <col style="width: auto;" />
                </colgroup>
                <tbody>
                    <tr>
                        <th>기간</th>
                        <td><input type="date" id="startDate" name="startDate" value="${menuVo.startDate}">~<input type="date" id="endDate" name="endDate" value="${menuVo.endDate}"></td>
                    </tr>
                    <tr>
                        <th>메뉴명</th>
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
                    <th>No</th>
                    <th>메뉴명</th>
                    <th>상위메뉴</th>
                    <th>메뉴레벨</th>
                    <th>등록일자</th>
                </tr>
            </thead>
            <tbody>
            <c:if test="${menuList.size() eq 0}">
                <tr>
                    <td colspan="4">
                        조회된 데이터가 없습니다
                    </td>
                </tr>
            </c:if>
                <c:forEach var="menu" items="#{menuList}" varStatus="status">
                    <tr>
                        <td>${status.count}</td>
                        <td><a href="/admin/menu/detail.do?menuId=${menu.menuId}">${menu.menuName}</a></td>
                        <td>${menu.upperMenuName}</td>
                        <td>${menu.menuLevel}</td>
                        <td>${menu.frstRgsrDtlDttm}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <button id="registBtn">등록</button>
    </div>
</div>
