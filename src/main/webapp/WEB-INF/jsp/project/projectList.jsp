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
        <form id="searchForm"style="text-align: center;">
            <table style="width: 1000px; border: solid 1px black; margin: 0 auto; text-align: center;">
                <tbody>
                    <tr>
                        <th>기간</th>
                        <td>
                            <input type="date" name="searchStartDate" id="startDate" value="${param.searchStartDate}">
                            ~
                            <input type="date" name="searchEndDate" id="endDate" value="${param.searchEndDate}">
                        </td>
                        </tr>
                    <tr>
                        <th>프로젝트 명</th>
                        <td>
                            <input type="text" id="projectName" name="searchProjectName" placeholder="프로젝트명 입력" value="${param.searchProjectName}">
                        </td>
                    </tr>
                        <th>심사 상태</th>
                    <td>
                        <label style="margin-right: 15px;">
                            <input type="checkbox" id="allStatus"
                            ${empty paramValues.searchEvaCd ? 'checked' : ''}> 전체
                        </label>
                        <label style="margin-right: 15px;">
                            <input type="checkbox" name="searchEvaCd" value="01" id="status01"
                                   <c:if test="${not empty searchVo.searchEvaCd and searchVo.searchEvaCd.contains('01')}">checked</c:if>> 심사요청
                        </label>
                        <label style="margin-right: 15px;">
                            <input type="checkbox" name="searchEvaCd" value="02" id="status02"
                                   <c:if test="${not empty searchVo.searchEvaCd and searchVo.searchEvaCd.contains('02')}">checked</c:if>> 심사중
                        </label>
                        <label>
                            <input type="checkbox" name="searchEvaCd" value="03" id="status03"
                                   <c:if test="${not empty searchVo.searchEvaCd and searchVo.searchEvaCd.contains('03')}">checked</c:if>> 심사 완료
                        </label>
                    </td>
                </tbody>
            </table>

            <div style="width: 1000px; margin: 10px auto; text-align: center;">
                <button type="button" id="search_btn" style="
                    background-color: #007bff;
                    color: white;
                    border: none;
                    padding: 8px 16px;
                    border-radius: 4px;
                    cursor: pointer;
                    font-size: 14px;">조회</button>
            </div>

        </form>


        <!-- 테이블 영역 -->
        <div class="table-area">
            <table border="1">
                <thead>
                <tr>
                    <th>No</th>
                    <th>프로젝트 명</th>
                    <th>작성자</th>
                    <th>요청 일자</th>
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
                    <c:forEach var="project" items="${projectList}" varStatus="status">
                        <tr>
                            <td>${project.projectId}</td>
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
                                        <c:choose>
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
                </c:if>
                </tbody>
            </table>
        </div>

        <!-- 페이징 영역 -->
        <div class="paging-area">

        </div>

        <div style="text-align: center; margin-top: 30px; margin-bottom: 20px;">
            <button type="button" id="register_btn" style="
                background-color: #28a745;
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 4px;
                cursor: pointer;
                font-size: 16px;
            ">프로젝트 등록</button>
        </div>
    </div>
</div>