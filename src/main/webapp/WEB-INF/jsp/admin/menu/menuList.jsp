<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2025-04-24
  Time: 오후 2:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<script src="/app/js/admin/menu/menuList.js"></script>
<script>
    const msg = "${msg}";
    if(msg != '') {
        alert(msg);
    }
</script>
<div id="page-wrapper">
    <div class="header">
        <h1 class="page-title">메뉴 관리</h1>
    </div>
    <div class="page-inner">
        <form id="searchForm" name="searchForm" action="/admin/menu/list.do" >
            <input type="hidden" name="currentPageNo" value=${currentPageNo}>
            <table>
                <colgroup>
                    <col style="width: 20%;"/>
                    <col />
                </colgroup>
                <tbody>
                    <tr>
                        <th>기간</th>
                        <td>
                            <input type="date" id="startDate" name="startDate" value="${menuVo.startDate}" min="2025-01-01" /> ~
                            <input type="date" id="endDate" name="endDate" value="${menuVo.endDate}" min="2025-01-01" />
                            <span class="range-btn-group">
                                <button type="button" class="date_range_btn" id="dateRangeBtn" data-range="6" style="white-space: nowrap; width: 60px">7일</button>
                                <button type="button" class="date_range_btn" id="dateRangeBtn" data-range="13" style="white-space: nowrap; width: 60px">14일</button>
                                <button type="button" class="date_range_btn" id="dateRangeBtn" data-range="29" style="white-space: nowrap; width: 60px">1개월</button>
                            </span>
                        </td>
                    </tr>
                    <tr>
                        <th>메뉴명</th>
                        <td><input type="text" id="menuName" name="menuName" value="${menuVo.menuName}" /></td>
                    </tr>
                </tbody>
            </table>
        </form>
        <div class="btnDiv">
            <button id="initBtn">초기화</button>
            <button id="searchBtn">검색</button>
        </div>
        <table>
            <colgroup>
                <col style="width: 10%;" />
                <col />
                <col />
                <col />
                <col style="width: 20%;" />
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
                    <td colspan="5">
                        조회된 데이터가 없습니다
                    </td>
                </tr>
            </c:if>
                <c:forEach var="menu" items="${menuList}" varStatus="status">
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
        <div class="btnDiv">
            <button id="registBtn">등록</button>
        </div>
    </div>
    <c:if test="${menuList.size() ne 0}">
        <div class="paging custom-pagination">
            <ui:pagination paginationInfo="${menuVo}" type="text" jsFunction="fnPaging" />
        </div>
    </c:if>
</div>
