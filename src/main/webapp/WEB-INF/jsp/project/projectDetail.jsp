<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2025-06-16
  Time: 오전 9:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="<c:url value="/app/js/project/projectDetail.js"/>"></script>

<div id="page-wrapper">
    <div class="header">
        <h1 class="page-title">프로젝트 상세 조회</h1>
    </div>

    <div class="page-inner">
        <table>
            <colgroup>
                <col style="width: 20%;" />
                <col style="width: 25%;" />
                <col style="width: 20%;" />
                <col style="width: 35%;" />
            </colgroup>
            <tbody>
            <%-- 심사 결과와 상태 --%>
            <tr>
                <th>심사 결과</th>
                <td>
                    <c:choose>
                        <c:when test="${not empty project.scoreFin}">
                            <span class="score-value">${project.scoreFin}점</span>
                        </c:when>
                        <c:otherwise>
                            <span class="score-pending">평가 대기중</span>
                        </c:otherwise>
                    </c:choose>
                </td>
                <th>심사 상태</th>
                <td>
                    <c:choose>
                        <c:when test="${project.evaCd eq 'A'}">대기중</c:when>
                        <c:when test="${project.evaCd eq '00'}">등록</c:when>
                        <c:when test="${project.evaCd eq '01'}">심사요청</c:when>
                        <c:when test="${project.evaCd eq '02'}">심사중</c:when>
                        <c:when test="${project.evaCd eq '03'}">심사완료</c:when>
                        <c:otherwise>${project.evaCd}</c:otherwise>
                    </c:choose>
                </td>
            </tr>

            <%-- 프로젝트명 --%>
            <tr>
                <th>프로젝트명</th>
                <td colspan="3">${project.projectName}</td>
            </tr>

            <%-- 팀 구성원 --%>
            <tr>
                <th>팀 구성원</th>
                <td colspan="2">
                    <span>${loginUser.userName}</span>
                </td>
                <td>
                    <button type="button" id="viewMemberBtn">구성원 보기</button>
                </td>
            </tr>

            <%-- 설명 --%>
            <tr>
                <th>설명</th>
                <td colspan="3">
                    <div class="project-description">
                        <c:choose>
                            <c:when test="${not empty project.projectDetail}">
                                ${project.projectDetail}
                            </c:when>
                            <c:otherwise>
                                <span class="no-content">설명이 없습니다.</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </td>
            </tr>

            <%-- URL --%>
            <tr>
                <th>URL</th>
                <td colspan="3">
                    <c:choose>
                        <c:when test="${not empty project.url}">
                            <a href="${project.url}" target="_blank" class="project-url">${project.url}</a>
                        </c:when>
                        <c:otherwise>
                            <span class="no-content">URL이 없습니다.</span>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>

            <%-- 첨부파일 --%>
            <tr>
                <th>첨부파일</th>
                <td colspan="2">
                    <c:choose>
                        <c:when test="${not empty project.attachmentName}">
                            <span class="attachment-name">${project.attachmentName}</span>
                        </c:when>
                        <c:otherwise>
                            <span class="no-content">첨부파일이 없습니다.</span>
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <c:if test="${not empty project.attachmentName}">
                        <button type="button" id="downloadBtn" onclick="downloadFile('${project.projectId}')">다운로드</button>
                    </c:if>
                </td>
            </tr>

            <%-- 등록 정보 --%>
            <tr>
                <th>등록자</th>
                <td>${project.lastChngId}</td>
                <th>등록일시</th>
                <td>${project.frstRgsrDtlDttmString}</td>
            </tr>

            <%-- 최종 수정 정보 --%>
            <tr>
                <th>최종 수정자</th>
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
                <th>최종 수정일시</th>
                <td>${project.lastChngDtlDttmString}</td>
            </tr>
            </tbody>
        </table>

        <%-- 버튼 영역 --%>
        <div class="btnDiv">
            <button type="button" id="listBtn">목록</button>
            <button type="button" id="updateBtn">수정</button>
            <button type="button" id="requestEvaBtn">심사요청</button>
            <button type="button" id="deleteBtn">삭제</button>
        </div>

        <input type="hidden" id="projectEvaCd" value="${project.evaCd}" />
        <input type="hidden" id="projectId" value="${project.projectId}" />

        <form id="deleteForm" method="post" action="/project/deleteProject.do" style="display: none;">
            <input type="hidden" name="projectId" value="${project.projectId}" />
        </form>
    </div>
</div>