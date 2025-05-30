<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 25. 4. 28.
  Time: 오후 3:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<script src="/app/js/admin/code/codeList.js"></script>
<script>
    const msg = "${msg}";
    if(msg != '') {
        alert(msg);
    }
</script>
<div id="page-wrapper">
    <div class="header">
        <h1 class="page-title">코드 관리</h1>
    </div>
    <div class="page-inner">
        <form id="searchForm" name="searchForm" action="/admin/code/list.do">
            <input type="hidden" name="currentPageNo" value=${currentPageNo}>
            <table>
                <colgroup>
                    <col style="width: auto;" />
                    <col style="width: auto;" />
                </colgroup>
                <tbody>
                    <tr>
                        <th>기간</th>
                        <td>
                            <input type="date" id="startDate" name="startDate" value="${codeVo.startDate}" style="width: 25%;" /> ~
                            <input type="date" id="endDate" name="endDate" value="${codeVo.endDate}" style="width: 25%;" />
                            <span class="range-btn-group">
                                <button type="button" class="date_range_btn" id="dateRangeBtn" data-range="6" style="white-space: nowrap; width: 60px">7일</button>
                                <button type="button" class="date_range_btn" id="dateRangeBtn" data-range="13" style="white-space: nowrap; width: 60px">14일</button>
                                <button type="button" class="date_range_btn" id="dateRangeBtn" data-range="29" style="white-space: nowrap; width: 60px">1개월</button>
                            </span>
                        </td>
                    </tr>
                    <tr>
                        <th>상위코드명</th>
                        <td><input type="text" id="upperCodeName" name="upperCodeName" value="${codeVo.upperCodeName}" /></td>
                    </tr>
                </tbody>
            </table>
        </form>
        <button id="initBtn">초기화</button>
        <button id="searchBtn">검색</button>
        <table>
            <colgroup>
            </colgroup>
            <thead>
                <tr>
                    <th>No</th>
                    <th>상위코드명</th>
                    <th>코드값</th>
                    <th>코드명</th>
                    <th>등록일자</th>
                </tr>
            </thead>
            <tbody>
                <c:if test="${codeList.size() eq 0}">
                    <tr>
                        <td colspan="5">
                            조회된 데이터가 없습니다
                        </td>
                    </tr>
                </c:if>
                <c:forEach var="code" items="${codeList}" varStatus="status">
                    <a><tr>
                        <td>${code.rnum}</td>
                        <td>${code.upperCodeName}</td>
                        <td><a href="/admin/code/detail.do?upperCodeName=${code.upperCodeName}&codeVal=${code.codeVal}">${code.codeVal}</a></td>
                        <td>${code.codeName}</td>
                        <td>${code.frstRgsrDtlDttm}</td>
                    </tr></a>
                </c:forEach>
            </tbody>
        </table>
        <c:if test="${codeList.size() ne 0}">
            <div class="paging custom-pagination">
                <ui:pagination paginationInfo="${codeVo}" type="text" jsFunction="fnPaging" />
            </div>
        </c:if>
        <button id="registBtn">등록</button>

        <%-- 페이징 --%>
<%--        <c:if test="${codeList.size() ne 0}">--%>
<%--            <div id="pagination">--%>
<%--                <nav>--%>
<%--                    <ul class="pagination">--%>
<%--                        <li class="page-item">--%>
<%--                            <a class="page-link" href="#" aria-label="Previous" onclick="fnPaging(${firstPageNoOnPageList})">--%>
<%--                                <span aria-hidden="true">&laquo;</span>--%>
<%--                            </a>--%>
<%--                        </li>--%>
<%--                        <c:forEach var="i" begin="1" end="${totalPageCount}">--%>
<%--                            <li class="page-item"><a class="page-link" href="#" onclick="fnPaging(${i}); return false;">${i}</a></li>--%>
<%--                        </c:forEach>--%>
<%--                        <li class="page-item">--%>
<%--                            <a class="page-link" href="#" aria-label="Next" onclick="fnPaging(${lastPageNoOnPageList})">--%>
<%--                                <span aria-hidden="true">&raquo;</span>--%>
<%--                            </a>--%>
<%--                        </li>--%>
<%--                    </ul>--%>
<%--                </nav>--%>
<%--            </div>--%>
<%--        </c:if>--%>
    </div>
</div>
<script>

</script>
