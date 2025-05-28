<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 25. 5. 8.
  Time: 오후 3:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<script src="/app/js/evaProject/evaProjectList.js"></script>
<div id="page-wrapper">
    <div class="header">
        <h1 class="page-title">심사 프로젝트</h1>
    </div>
    <div class="page-inner">
        <form id="searchForm" name="searchForm" action="/evaProject/list.do" >
            <input type="hidden" name="currentPageNo" value=${currentPageNo}>
            <table>
                <colgroup>
                    <col style="width: 20%;" />
                    <col />
                </colgroup>
                <tbody>
                    <tr>
                        <th>심사기간</th>
                        <td><input type="date" id="startDate" name="startDate" value="${evaProjectVo.startDate}" />~<input type="date" id="endDate" name="endDate" value="${evaProjectVo.endDate}" /></td>
                    </tr>
                    <tr>
                        <th>프로젝트명</th>
                        <td><input type="text" id="projectName" name="projectName" value="${evaProjectVo.projectName}"></td>
                    </tr>
                    <tr>
                        <th>심사상태</th>
                        <td>
                            <input type="radio" name="evaCd" id="All" value="All" checked /> 전체 &nbsp;
                            <c:forEach var="code" items="${codeList}" varStatus="status">
                                <c:if test="${code.codeVal ne '00'}">
                                    <input type="radio" name="evaCd" id="${code.codeVal}" value="${code.codeVal}" <c:if test="${evaProjectVo.evaCd eq code.codeVal}">checked</c:if> > ${code.codeName} &nbsp;
                                </c:if>

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
                <col style="width: 15%;" />
                <col style="width: 15%;" />
                <col style="width: 15%" />
                <col style="width: 15%;" />
            </colgroup>
            <thead>
            <tr>
                <th>No</th>
                <th>프로젝트명</th>
                <th>심사상태</th>
                <th>심사시작일자</th>
                <th>심사종료일자</th>
                <th>심사위원단구성</th>
                <th>등록일자</th>
            </tr>
            </thead>
            <tbody>
                <c:if test="${evaProjectList.size() eq 0}">
                    <tr>
                        <td colspan="6">
                            조회된 데이터가 없습니다
                        </td>
                    </tr>
                </c:if>
                <c:forEach var="evaProj" items="#{evaProjectList}" varStatus="status">
                    <tr>
                        <td>${evaProj.rnum}</td>
                        <td><a href="/evaProject/detail.do?projectId=${evaProj.projectId}">${evaProj.projectName}</td>
                        <td>${evaProj.evaCdNm}</td>
                        <td>${evaProj.evaStartDt}</td>
                        <td>${evaProj.evaEndDt}</td>
                        <td>${evaProj.evaFormYn}</td>
                        <td>${evaProj.frstRgsrDtlDttm}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <%-- 페이징 --%>
        <c:if test="${evaProjectList.size() ne 0}">
            <div class="paging custom-pagination">
                <ui:pagination paginationInfo="${evaProjectVo}" type="text" jsFunction="fnPaging" />
            </div>
        </c:if>
    </div>
</div>
