<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2025-04-16
  Time: 오후 3:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<script>
    const msg = "${msg}";
    if(msg != '') {
        alert(msg);
    }
</script>
<script src="<c:url value="/app/js/admin/user/userList.js"/>"></script>
<div id="page-wrapper">
    <div class="header">
        <h1 class="page-title">
            사용자 관리
        </h1>
    </div>
    <div class="page-inner">
        <form id="searchForm" name="searchForm" action="/admin/user/list.do">
            <input type="hidden" name="currentPageNo" value=${currentPageNo}>
            <table>
                <colgroup>
                    <col style="width: 20%;" />
                    <col />
                </colgroup>
                <tbody>
                    <tr>
                        <th>기간</th>
                        <td>
                            <input type="date" id="startDate" name="startDate" value="${userVo.startDate}" style="width: 25%;" /> ~
                            <input type="date" id="endDate" name="endDate" value="${userVo.endDate}" style="width: 25%;" />
                            <span class="range-btn-group">
                                <button type="button" class="date_range_btn" id="dateRangeBtn" data-range="6" style="white-space: nowrap; width: 60px">7일</button>
                                <button type="button" class="date_range_btn" id="dateRangeBtn" data-range="13" style="white-space: nowrap; width: 60px">14일</button>
                                <button type="button" class="date_range_btn" id="dateRangeBtn" data-range="29" style="white-space: nowrap; width: 60px">1개월</button>
                            </span>
                        </td>
                    </tr>
                    <tr>
                        <th>이메일</th>
                        <td><input type="text" name="userEmail" value="${userVo.userEmail}" /></td>
                    </tr>
                    <tr>
                        <th>권한</th>
                        <td>
                            <input type="radio" name="roleCd" id="All" value="All" checked="checked" /> 전체 &nbsp;
                            <c:forEach var="role" items="#{codeList}" varStatus="status">
                            <input type="radio" id="${role.codeVal}" name="roleCd" value="${role.codeVal}" <c:if test="${userVo.roleCd eq role.codeVal}">checked</c:if > > ${role.codeName} &nbsp;
                            </c:forEach>
                        </td>
                    </tr>
                </tbody>
            </table>
        </form>
        <button id="initBtn">초기화</button>
        <button id="searchBtn">검색</button>
        <table>
            <colgroup>
                <col style="width: 10%;" />
                <col />
                <col />
                <col />
            </colgroup>
            <thead>
                <tr>
                    <th>No</th>
                    <th>이메일</th>
                    <th>권한</th>
                    <th>등록일자</th>
                </tr>
            </thead>
            <tbody>
                <c:if test="${userList.size() eq 0}">
                    <tr>
                        <td colspan="4">
                            조회된 데이터가 없습니다
                        </td>
                    </tr>
                </c:if>
                <c:forEach var="user" items="${userList}" varStatus="status">
                    <tr>
                        <td>${user.rnum}</td>
                        <td>
                            <a href="/admin/user/detail.do?userEmail=${user.userEmail}" class="userEmail">${user.userEmail}</a>
                        </td>
                        <td>${user.roleCdNm}</td>
                        <td>${user.frstRgsrDtlDttm}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <c:if test="${userList.size() ne 0}">
            <div class="paging custom-pagination">
                <ui:pagination paginationInfo="${userVo}" type="text" jsFunction="fnPaging" />
            </div>
        </c:if>
        <button id="registBtn">등록</button>
    </div>
</div>
