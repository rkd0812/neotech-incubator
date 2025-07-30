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
        <form id="projectForm" method="post" action="/project/saveProject.do" enctype="multipart/form-data">
            <input type="hidden" id="teamMemberEmails" name="teamMemberEmails" />
            <input type="hidden" id="teamMemberNames" name="teamMemberNames" />

            <table class="form-table">
                <colgroup>
                    <col style="width: 20%;" />
                    <col style="width: 30%;" />
                    <col style="width: 20%;" />
                    <col style="width: 30%;" />
                </colgroup>
                <tbody>
                <tr>
                    <th>프로젝트명</th>
                    <td colspan="3">
                        <input type="text" id="projectName" name="projectName"
                               value="${projectVo.projectName}"
                               placeholder="프로젝트명을 입력하세요"
                               maxlength="100" required />
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
                <tr>
                    <th>설명</th>
                    <td colspan="3">
                        <textarea id="projectDetail" name="projectDetail"
                                  placeholder="프로젝트 설명을 입력하세요"
                                  rows="5" maxlength="1000"
                                  style="width: 100%; height: 250px; resize: none; overflow: auto;">${projectVo.projectDetail}</textarea>
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
                    <td colspan="3">
                        <input type="file" id="fileInput" name="uploadFile" accept=".pdf,.doc,.docx,.txt,.jpg,.jpeg,.png,.zip" />
                        <button type="button" id="removeFileBtn" onclick="removeSelectedFile()" style="margin-left: 10px; display: none;">삭제</button>
                        <div id="fileInfo" style="margin-top: 5px; color: #666; font-size: 12px;">
                            파일을 선택해주세요. (최대 50MB)
                        </div>
                    </td>
                </tr>
                </tbody>
            </table>

            <div class="btnDiv">
                <button type="button" id="listBtn" class="btn-secondary">목록</button>
                <button type="submit" id="saveBtn" class="btn-primary">등록</button>
            </div>
        </form>
    </div>
</div>