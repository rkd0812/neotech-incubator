<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2025-04-24
  Time: 오후 2:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="<c:url value="/app/js/project/projectList.js"/>"></script> <%--필수 --%>
<div id="page-wrapper">
    <div class="header">
        <h1 class="page-title">사용자 프로젝트 목록조회</h1>
    </div>
    <!-- 검색 영역 -->
    <div class="page-inner">
        <form id="searchForm" method="get" action="/project/projectList.do" style="text-align: center;">
            <!-- 페이징 정보 유지를 위한 hidden 필드 추가 -->
            <input type="hidden" name="currentPageNo" id="currentPageNo" value="${empty paging.paginationInfo.currentPageNo ? 1 : paging.paginationInfo.currentPageNo}">
            <!-- 실제 검색에 사용되는 hidden 필드 (조회 버튼 눌렀을 때만 값이 설정됨) -->
            <input type="hidden" name="searchStartDate" id="hiddenStartDate" value="${paging.searchStartDate}">
            <input type="hidden" name="searchEndDate" id="hiddenEndDate" value="${paging.searchEndDate}">
            <input type="hidden" name="searchProjectName" id="hiddenProjectName" value="${paging.searchProjectName}">
            <input type="hidden" name="searchEvaCd" id="hiddenSearchEvaCd" value="${paging.searchEvaCd}">

            <table>
                <tbody>
                    <tr>
                        <th style="width: 20%;">기간</th>
                        <td style="display: flex; align-items: center; justify-content: center; gap: 10px; flex-wrap: nowrap;">
                            <input type="date" id="startDate" class="date-input-short" style="width: 25%;" value="">
                            ~
                            <input type="date" id="endDate" class="date-input-short" style="width: 25%;" value="">
                            <span class="range-btn-group">
                                <button type="button" class="date_range_btn" id="dateRangeBtn" data-range="6" style="white-space: nowrap; width: 60px">7일</button>
                                <button type="button" class="date_range_btn" id="dateRangeBtn" data-range="13" style="white-space: nowrap; width: 60px">14일</button>
                                <button type="button" class="date_range_btn" id="dateRangeBtn" data-range="29" style="white-space: nowrap; width: 60px">1개월</button>
                            </span>
                        </td>

                        </tr>
                    <tr>
                        <th style="width: 20%;">프로젝트명</th>
                        <td>
                            <input type="text" style="width: 430px;"  id="projectName" value="">
                        </td>
                    </tr>
                        <th style="width: 20%;">심사상태</th>
                    <td>
                        <!-- 라디오 버튼으로 변경 - 같은 name을 가져야 하나만 선택됨 -->
                        <label style="margin-right: 15px">
                            <input type="radio" name="displayEvaCd" value="" id="allStatus" checked> 전체
                        </label>
                        <label style="margin-right: 15px">
                            <input type="radio" name="displayEvaCd" value="00" id="status00"> 등록
                        </label>
                        <label style="margin-right: 15px">
                            <input type="radio" name="displayEvaCd" value="01" id="status01"> 심사요청
                        </label>
                        <label style="margin-right: 15px">
                            <input type="radio" name="displayEvaCd" value="02" id="status02"> 심사중
                        </label>
                        <label style="margin-right: 15px">
                            <input type="radio" name="displayEvaCd" value="03" id="status03"> 심사완료
                        </label>
                    </td>
                </tbody>
            </table>

            <div style="width: 1000px; margin: 10px auto; text-align: center;">
                <button type="button" id="resetBtn">초기화</button>

                <button type="button" id="searchBtn">조회</button>
            </div>

        </form>


        <!-- 테이블 영역 -->
        <div class="table-area">
            <table>
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
                <c:choose>
                    <c:when test="${empty projectList}">
                        <tr>
                            <td colspan="5">등록된 프로젝트가 없습니다.</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <!-- 방법 1: 가장 안전한 방법 - 단순하게 status.index 사용 -->
                        <c:forEach var="project" items="${projectList}" varStatus="status">
                            <tr>
                                <td>
                                    ${(paging.paginationInfo.currentPageNo - 1) * paging.paginationInfo.recordCountPerPage + status.index + 1}
                                    <!-- 프로젝트 ID는 숨김 처리 -->
                                    <span style="display: none;" data-project-id="${project.projectId}"></span>
                                </td>
                                <td>
                                    <a href="/project/projectDetail.do?projectId=${project.projectId}">
                                            ${project.projectName}
                                    </a>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty project.userName}">
                                            ${project.userName}
                                        </c:when>
                                        <c:otherwise>
                                            ${project.lastChngId}
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${project.evaStartDtString}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty project.codeName}">
                                            ${project.codeName}
                                        </c:when>
                                        <c:otherwise>
                                            <!-- 코드명이 없을 때 기본값 표시 -->
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
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>

        <div style="text-align: center; margin-top: 30px; margin-bottom: 20px;" >
            <button type="button" id="registBtn">프로젝트 등록</button>
        </div>

        <!-- 페이징 영역 -->
        <div class="paging-area" style="text-align: center; margin: 20px 0;">
            <c:if test="${not empty paging.paginationInfo and paging.paginationInfo.totalPageCount > 1}">
                <div class="pagination" style="display: inline-block;">

                    <!-- 맨 처음 페이지 -->
                    <c:if test="${paging.paginationInfo.currentPageNo > 1}">
                        <a href="javascript:void(0)" onclick="goToPage(${paging.paginationInfo.firstPageNo})"
                           style="display: inline-block; padding: 8px 12px; margin: 0 2px;
                                  border: 1px solid #ddd; text-decoration: none; color: #333;">
                            ≪
                        </a>
                    </c:if>

                    <!-- 이전 페이지 -->
                    <c:if test="${paging.paginationInfo.currentPageNo > 1}">
                        <a href="javascript:void(0)" onclick="goToPage(${paging.paginationInfo.currentPageNo - 1})"
                           style="display: inline-block; padding: 8px 12px; margin: 0 2px;
                                  border: 1px solid #ddd; text-decoration: none; color: #333;">
                            ＜
                        </a>
                    </c:if>

                    <!-- 페이지 번호들 -->
                    <c:forEach var="pageNumber" begin="${paging.paginationInfo.firstPageNoOnPageList}" end="${paging.paginationInfo.lastPageNoOnPageList}">
                        <c:choose>
                            <c:when test="${pageNumber == paging.paginationInfo.currentPageNo}">
                                <span style="display: inline-block; padding: 8px 12px; margin: 0 2px;
                                             border: 1px solid #007bff; background-color: #007bff;
                                             color: white; font-weight: bold;">${pageNumber}</span>
                            </c:when>
                            <c:otherwise>
                                <a href="javascript:void(0)" onclick="goToPage(${pageNumber})"
                                   style="display: inline-block; padding: 8px 12px; margin: 0 2px;
                                          border: 1px solid #ddd; text-decoration: none; color: #333;">
                                        ${pageNumber}
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>

                    <!-- 다음 페이지 -->
                    <c:if test="${paging.paginationInfo.currentPageNo < paging.paginationInfo.totalPageCount}">
                        <a href="javascript:void(0)" onclick="goToPage(${paging.paginationInfo.currentPageNo + 1})"
                           style="display: inline-block; padding: 8px 12px; margin: 0 2px;
                                  border: 1px solid #ddd; text-decoration: none; color: #333;">
                            ＞
                        </a>
                    </c:if>

                    <!-- 맨 마지막 페이지 -->
                    <c:if test="${paging.paginationInfo.currentPageNo < paging.paginationInfo.totalPageCount}">
                        <a href="javascript:void(0)" onclick="goToPage(${paging.paginationInfo.lastPageNo})"
                           style="display: inline-block; padding: 8px 12px; margin: 0 2px;
                                  border: 1px solid #ddd; text-decoration: none; color: #333;">
                            ≫
                        </a>
                    </c:if>
                </div>

                <!-- 페이징 정보 -->
                <div style="margin-top: 10px; color: #666; font-size: 14px;">
                    총 ${paging.paginationInfo.totalRecordCount}개
                    (${paging.paginationInfo.currentPageNo} / ${paging.paginationInfo.totalPageCount} 페이지)
                </div>
            </c:if>
        </div>

    </div>
</div>