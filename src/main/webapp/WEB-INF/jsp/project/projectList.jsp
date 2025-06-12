<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2025-04-24
  Time: 오후 2:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<script src="<c:url value="/app/js/project/projectList.js"/>"></script> <%--필수 --%>
<div id="page-wrapper">
    <div class="header">
        <h1 class="page-title">사용자 프로젝트 목록조회</h1>
    </div>

    <div class="page-inner">
        <form id="searchForm" name="searchForm" method="get" action="/project/projectList.do">
            <input type="hidden" name="currentPageNo" value="${projectVo.currentPageNo}">

            <table>
                <colgroup>
                    <col style="width: 20%;" />
                    <col />
                </colgroup>
                <tbody>
                <tr>
                    <th>심사기간</th>
                    <td>
                        <input type="date" id="startDate" name="searchStartDate" value="${projectVo.searchStartDate}" /> ~
                        <input type="date" id="endDate" name="searchEndDate" value="${projectVo.searchEndDate}" />
                        <span class="range-btn-group">
                                <button type="button" class="date_range_btn" id="dateRangeBtn" data-range="6" style="white-space: nowrap; width: 60px">7일</button>
                                <button type="button" class="date_range_btn" id="dateRangeBtn" data-range="13" style="white-space: nowrap; width: 60px">14일</button>
                                <button type="button" class="date_range_btn" id="dateRangeBtn" data-range="29" style="white-space: nowrap; width: 60px">1개월</button>
                            </span>
                    </td>
                </tr>
                <tr>
                    <th>프로젝트명</th>
                    <td><input type="text" id="projectName" name="searchProjectName" value="${projectVo.searchProjectName}"></td>
                </tr>
                <tr>
                    <th>심사상태</th>
                    <td>
                        <input type="radio" name="searchEvaCd" id="All" value="" <c:if test="${empty projectVo.searchEvaCd}">checked</c:if> /> 전체 &nbsp;
                        <input type="radio" name="searchEvaCd" id="status00" value="00" <c:if test="${projectVo.searchEvaCd eq '00'}">checked</c:if> /> 등록 &nbsp;
                        <input type="radio" name="searchEvaCd" id="status01" value="01" <c:if test="${projectVo.searchEvaCd eq '01'}">checked</c:if> /> 심사요청 &nbsp;
                        <input type="radio" name="searchEvaCd" id="status02" value="02" <c:if test="${projectVo.searchEvaCd eq '02'}">checked</c:if> /> 심사중 &nbsp;
                        <input type="radio" name="searchEvaCd" id="status03" value="03" <c:if test="${projectVo.searchEvaCd eq '03'}">checked</c:if> /> 심사완료 &nbsp;
                    </td>
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
                <col style="width: 5%;" />
                <col />
                <col style="width: 15%;" />
                <col style="width: 15%;" />
                <col style="width: 15%;" />
            </colgroup>
            <thead>
            <tr>
                <th>No</th>
                <th>프로젝트명</th>
                <th>작성자</th>
                <th>요청 일자</th>
                <th>심사상태</th>
            </tr>
            </thead>
            <tbody>
            <c:if test="${empty projectList}">
                <tr>
                    <td colspan="5" style="text-align: center;">
                        등록된 프로젝트가 없습니다.
                    </td>
                </tr>
            </c:if>
            <c:forEach var="project" items="${projectList}" varStatus="status">
                <tr>
                    <td style="text-align: center;">
                            ${(projectVo.currentPageNo - 1) * projectVo.recordCountPerPage + status.index + 1}
                    </td>
                    <td><a href="/project/projectDetail.do?projectId=${project.projectId}">${project.projectName}</a></td>
                    <td style="text-align: center;">
                        <c:choose>
                            <c:when test="${not empty project.userName}">
                                ${project.userName}
                            </c:when>
                            <c:otherwise>
                                ${project.lastChngId}
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td style="text-align: center;">${project.evaStartDtString}</td>
                    <td style="text-align: center;">
                        <c:choose>
                            <c:when test="${not empty project.codeName}">
                                ${project.codeName}
                            </c:when>
                            <c:otherwise>
                                <c:choose>
                                    <c:when test="${project.evaCd eq 'A'}">대기중</c:when>
                                    <c:when test="${project.evaCd eq '00'}">등록</c:when>
                                    <c:when test="${project.evaCd eq '01'}">심사요청</c:when>
                                    <c:when test="${project.evaCd eq '02'}">심사중</c:when>
                                    <c:when test="${project.evaCd eq '03'}">심사완료</c:when>
                                    <c:otherwise>${project.evaCd}</c:otherwise>
                                </c:choose>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <div class="btnDiv">
            <button type="button" id="registBtn">프로젝트 등록</button>
        </div>

        <!-- 페이징 영역-->
        <c:if test="${not empty projectList and projectVo.totalPageCount > 1}">
            <div class="paging custom-pagination">
                <ui:pagination paginationInfo="${projectVo}" type="text" jsFunction="fnPaging" />
            </div>
        </c:if>

    </div>
</div>