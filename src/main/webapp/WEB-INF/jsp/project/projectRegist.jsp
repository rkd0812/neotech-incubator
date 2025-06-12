<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2025-06-11
  Time: 오후 5:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<script src="<c:url value="/app/js/project/projectRegist.js"/>"></script> <%--필수 --%>
<div id="page-wrapper">
    <div class="header">
        <h1 class="page-title">프로젝트 등록</h1>
    </div>

    <div class="page-inner">
        <!-- 메시지 표시 -->
        <c:if test="${not empty message}">
            <div class="alert alert-success">${message}</div>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-error">${errorMessage}</div>
        </c:if>

        <form id="projectForm" method="post" action="/project/insertProject.do">
            <!-- 저장 or 심사요청 구분 -->
            <input type="hidden" id="actionType" name="actionType" value="save" />

            <table class="form-table">
                <colgroup>
                    <col style="width: 20%;" />
                    <col style="width: 30%;" />
                    <col style="width: 20%;" />
                    <col style="width: 30%;" />
                </colgroup>
                <tbody>
                <tr>
                    <th>프로젝트명 *</th>
                    <td>
                        <input type="text" id="projectName" name="projectName"
                               value="${projectVo.projectName}"
                               placeholder="프로젝트명을 입력하세요"
                               maxlength="100" required />
                    </td>
                </tr>
                <tr>
                    <th>팀 구성원</th>
                    <td>
                        <span>${loginUser.userName}</span>
                        <button type="button">팀원 추가</button>
                    </td>
                </tr>
                <tr>
                    <th>설명</th>
                    <td colspan="3">
                        <textarea id="projectDetail" name="projectDetail"
                                  placeholder="프로젝트 설명을 입력하세요"
                                  rows="5" maxlength="1000"
                                  style="width: 100%;">${projectVo.projectDetail}</textarea>
                        <div><span id="charCount">0</span> / 1000자</div>
                    </td>
                </tr>
                <tr>
                    <th>URL</th>
                    <td colspan="3">
                        <input type="text" id="url" name="url"
                               value="${projectVo.url}"
                               placeholder="https://example.com"
                               maxlength="200" style="width: 80%;" />
                    </td>
                </tr>
                <tr>
                    <th>첨부파일</th>
                    <td>
                        <input type="file" id="attachmentFile" name="attachmentFile" />
                        <div>※ 10MB 이하 파일만 가능</div>
                    </td>
                </tr>
                </tbody>
            </table>

            <div class="btnDiv">
                <button type="button" id="listBtn">목록</button>
                <button type="button" id="saveBtn">저장</button>
                <button type="button" id="submitBtn">등록 및 심사요청</button>
            </div>
        </form>
    </div>
</div>