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
        <h1 class="page-title">프로젝트 목록</h1>
    </div>
    <!-- 검색 영역 -->
    <div class="page-inner">
        <form id="searchForm">
            <input type="hidden" id="pageNum" name="pageNum" value="${paging.pageNum}">
            <input type="hidden" id="pageSize" name="pageSize" value="${paging.pageSize}">
            <table>
                <tbody>
                    <tr>
                        <th>기간:</th>
                        <td>
                            <input type="date" name="startDate" id="startDate" value="${param.startDate}">
                            ~
                            <input type="date" name="endDate" id="endDate" value="${param.endDate}">
                        </td>
                        </tr>
                    <tr>
                        <th>검색어:</th>
                        <td>
                            <input type="text" id="projectName" name="projectName" placeholder="프로젝트명 입력" value="${param.projectName}">
                        </td>
                    </tr>
                        <th>상태:</th>
                        <td>
                            <select name="evaCd" id="evaCd">
                                <option value="">--선택--</option>
                                <option value="01" ${param.evaCd eq '01' ? 'selected' : ''}>심사 전</option>
                                <option value="02" ${param.evaCd eq '02' ? 'selected' : ''}>심사 중</option>
                                <option value="03" ${param.evaCd eq '03' ? 'selected' : ''}>심사 완료</option>
                            </select>
                        </td>
                    <button type="button" id="search_btn">조회</button>
                </tbody>
            </table>

        </form>


        <!-- 테이블 영역 -->
        <div class="table-area">
            <p>
                <button type="button" id="register_btn">프로젝트 등록</button>
            </p>

            <table border="1">
                <thead>
                <tr>
                    <th>프로젝트 명</th>
                    <th>작성자</th>
                    <th>심사 시작일</th>
                    <th>심사 종료일</th>
                    <th>심사 상태</th>
                </tr>
                </thead>
                <tbody>
                <c:if test="${empty projectList}">
                    <tr>
                        <td colspan="5">등록된 프로젝트가 없습니다.</td>
                    </tr>
                </c:if>
                <c:if test="${not empty projectList}">
                    <c:forEach var="project" items="${projectList}">
                        <tr>
                            <td>
                                <a href="/project/projectDetail.do?projectId=${project.projectId}">
                                        ${project.projectName}
                                </a>
                            </td>
                            <td>${project.lastChngId}</td>
                            <td>${project.evaStartDtString}</td>
                            <td>${project.evaEndDtString}</td>
                            <td>
                                <c:if test="${project.evaCd eq '01'}">심사 전</c:if>
                                <c:if test="${project.evaCd eq '02'}">심사 중</c:if>
                                <c:if test="${project.evaCd eq '03'}">심사 완료</c:if>
                                <c:if test="${project.evaCd ne '01' and project.evaCd ne '02' and project.evaCd ne '03'}">
                                    ${project.evaCd}
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </c:if>
                </tbody>
            </table>
        </div>

        <!-- 페이징 영역 -->
        <div class="paging-area">
            <c:if test="${not empty paging && paging.totalPages > 0}">
                <ul class="pagination">
                    <!-- 처음으로 버튼 -->
                    <c:if test="${paging.pageNum > 1}">
                        <li>
                            <a href="javascript:void(0);" onclick="goPage(1)">처음</a>
                        </li>
                    </c:if>

                    <!-- 이전 버튼 -->
                    <c:if test="${paging.pageNum > 1}">
                        <li>
                            <a href="javascript:void(0);" onclick="goPage(${paging.pageNum - 1})">이전</a>
                        </li>
                    </c:if>

                    <!-- 페이지 번호 -->
                    <c:forEach begin="${Math.max(1, paging.pageNum - 2)}" end="${Math.min(paging.totalPages, paging.pageNum + 2)}" var="i">
                        <li class="${paging.pageNum eq i ? 'active' : ''}">
                            <a href="javascript:void(0);" onclick="goPage(${i})">${i}</a>
                        </li>
                    </c:forEach>

                    <!-- 다음 버튼 -->
                    <c:if test="${paging.pageNum < paging.totalPages}">
                        <li>
                            <a href="javascript:void(0);" onclick="goPage(${paging.pageNum + 1})">다음</a>
                        </li>
                    </c:if>

                    <!-- 마지막으로 버튼 -->
                    <c:if test="${paging.pageNum < paging.totalPages}">
                        <li>
                            <a href="javascript:void(0);" onclick="goPage(${paging.totalPages})">마지막</a>
                        </li>
                    </c:if>
                </ul>

                <div class="page-info">
                    총 ${paging.totalCount}건, ${paging.pageNum}/${paging.totalPages} 페이지
                </div>
            </c:if>
        </div>
    </div>
</div>