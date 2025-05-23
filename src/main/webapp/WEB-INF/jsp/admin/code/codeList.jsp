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
        <h1 class="page-title">코드 목록조회</h1>
    </div>
    <div class="page-inner" style="text-align: center;">
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
                        <td><input type="date" id="startDate" name="startDate" value="${codeVo.startDate}">~<input type="date" id="endDate" name="endDate" value="${codeVo.endDate}"></td>
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
<%--                        <td>${status.count}</td>--%>
                        <td>${code.rnum}</td>
                        <td>${code.upperCodeName}</td>
                        <td><a href="/admin/code/detail.do?upperCodeName=${code.upperCodeName}&codeVal=${code.codeVal}">${code.codeVal}</a></td>
                        <td>${code.codeName}</td>
                        <td>${code.frstRgsrDtlDttm}</td>
                    </tr></a>
                </c:forEach>
            </tbody>
        </table>
        <button id="registBtn">등록</button>

<%--        <div id="pagination" style="display: flex; justify-content: center; align-items: center;">--%>
<%--            <nav aria-label="Page navigation example">--%>
<%--                <ul class="pagination">--%>
<%--                    <li class="page-item">--%>
<%--                        <a class="page-link" href="#" aria-label="Previous">--%>
<%--                            <span aria-hidden="true">&laquo;</span>--%>
<%--                        </a>--%>
<%--                    </li>--%>
<%--                    <li class="page-item"><a class="page-link" href="#">1</a></li>--%>
<%--                    <li class="page-item"><a class="page-link" href="#">2</a></li>--%>
<%--                    <li class="page-item"><a class="page-link" href="#">3</a></li>--%>
<%--                    <li class="page-item">--%>
<%--                        <a class="page-link" href="#" aria-label="Next">--%>
<%--                            <span aria-hidden="true">&raquo;</span>--%>
<%--                        </a>--%>
<%--                    </li>--%>
<%--                </ul>--%>
<%--            </nav>--%>
<%--        </div>--%>
        <c:if test="${codeList.size() ne 0}">
            <div id="pagination">
                <ui:pagination paginationInfo="${codeVo}" type="text" jsFunction="fnPaging"/>
            </div>
        </c:if>
    </div>
</div>
<script>

</script>
