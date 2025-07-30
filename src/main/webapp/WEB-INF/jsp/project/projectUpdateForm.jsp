<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2025-06-20
  Time: 오후 1:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="<c:url value="/app/js/project/projectUpdateForm.js"/>"></script>

<div id="page-wrapper">
    <div class="header">
        <h1 class="page-title">프로젝트 수정</h1>
    </div>

    <div class="page-inner">
        <form id="projectForm" method="post" action="/project/insertProjectUpdate.do" enctype="multipart/form-data">
            <input type="hidden" name="projectId" value="${project.projectId}" />

            <input type="hidden" id="teamMemberEmails" name="teamMemberEmails" value="${project.teamMemberEmails}" />
            <input type="hidden" id="teamMemberNames" name="teamMemberNames" value="${project.teamMemberNames}" />

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
                    <td colspan="3">
                        <input type="text" name="projectName" value="${project.projectName}" class="form-control" />
                    </td>
                </tr>
                <tr>
                    <th>팀 구성원</th>
                    <td>
                        <span>팀장 : ${loginUser.userName}</span><br>
                        <div id="selectedMembers" style="margin-top: 10px;"></div>
                    </td>
                    <td>
                        <button type="button" onclick="openPopup()">팀원 추가</button><br><br>
                        <button type="button" onclick="clearAllTeamMembers()">전체 삭제</button>
                    </td>
                </tr>
                <%-- 설명 --%>
                <tr>
                    <th>설명</th>
                    <td colspan="3">
                        <textarea name="projectDetail"
                                  class="form-control"
                                  rows="5" maxlength="1000"
                                  style="width: 100%; height: 250px; resize: none; overflow: auto;"
                                  placeholder="프로젝트 설명을 입력하세요">${project.projectDetail}</textarea>
                    </td>
                </tr>

                <%-- URL --%>
                <tr>
                    <th>URL</th>
                    <td colspan="3">
                        <input type="url" name="url" value="${project.url}" class="form-control" placeholder="http://example.com" />
                    </td>
                </tr>

                <!-- 첨부파일 부분을 이렇게 수정 -->
                <tr>
                    <th>첨부파일</th>
                    <td colspan="3">
                        <!-- 현재 파일 표시 및 삭제 -->
                        <c:choose>
                            <c:when test="${project.hasFile()}">
                                <div id="currentFileDisplay" style="display: flex; align-items: center; margin-bottom: 15px; padding: 10px; background-color: #f8f9fa; border-radius: 4px;">
                                    <span style="color: #007bff; font-weight: bold; margin-right: 15px;">${project.displayFileName}</span>
                                    <button type="button" onclick="deleteCurrentFile()"
                                            style="padding: 5px 10px; background-color: #dc3545; color: white; border: none; border-radius: 3px; cursor: pointer;">
                                        삭제
                                    </button>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div id="currentFileDisplay" style="color: #6c757d; font-style: italic; margin-bottom: 15px; display: none;">
                                    현재 첨부된 파일이 없습니다.
                                </div>
                            </c:otherwise>
                        </c:choose>

                        <!-- 파일 업로드 -->
                        <div>
                            <label style="font-weight: bold; margin-bottom: 5px; display: block;">파일 추가:</label>
                            <input type="file" id="fileInput" name="uploadFile" accept=".pdf,.doc,.docx,.txt,.jpg,.jpeg,.png,.zip"
                                   style="margin-bottom: 8px;" />
                            <button type="button" id="removeNewFileBtn" onclick="removeSelectedFile()"
                                    style="margin-left: 10px; display: none;">삭제</button>
                            <input type="hidden" id="deleteFile" name="deleteFile" value="false" />
                            <div id="fileInfo" style="color: #666; font-size: 12px;">
                                파일을 선택해주세요. (최대 50MB)
                            </div>
                        </div>
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
                <button type="button" id="updateBtn">수정</button>
                <button type="button" id="cancleBtn">취소</button>
                <button type="button" id="deleteBtn">삭제</button>
            </div>
        </form>

        <input type="hidden" id="projectEvaCd" value="${project.evaCd}" />
        <input type="hidden" id="projectId" value="${project.projectId}" />

        <form id="deleteForm" method="post" action="/project/deleteProject.do" style="display: none;">
            <input type="hidden" name="projectId" value="${project.projectId}" />
        </form>
    </div>
</div>


<script type="text/javascript">
    var existingTeamMemberNames = "${project.teamMemberNames}";
    var existingTeamMemberEmails = "${project.teamMemberEmails}";
</script>