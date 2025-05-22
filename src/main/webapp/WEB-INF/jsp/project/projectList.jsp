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
<h2>프로젝트 목록</h2>

<!-- 검색 영역 -->
<div>
    <form id="searchForm">
        <p>
            기간:
            <input type="date" name="startdate" id="startdate">
            ~
            <input type="date" name="enddate" id="enddate">
        </p>
        <p>
            검색어:
            <input type="text" id="search-txt" name="searchTxt" placeholder="검색어를 입력하세요">
        </p>
        <p>
            상태:
            <select name="eva_state" id="eva_state">
                <option value="">--선택--</option>
                <option value="before_eva">심사 전</option>
                <option value="ing_eva">심사 중</option>
                <option value="after_eva">심사 완료</option>
            </select>
        </p>
        <p>
            <button type="button" id="search_btn">조회</button>
        </p>
    </form>
</div>

<!-- 테이블 영역 -->
<div>
    <p>
        <button type="button" id="register_btn">프로젝트 등록</button>
    </p>

    <table border="1">
        <thead>
        <tr>
            <th>프로젝트 명</th>
            <th>작성자</th>
            <th>심사 상태</th>
        </tr>
        </thead>
        <tbody>
        <c:if test="${empty projectList}">
            <tr>
                <td colspan="3">등록된 프로젝트가 없습니다.</td>
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
<div>
    <!-- 페이지 링크는 나중에 구현 -->
</div>
