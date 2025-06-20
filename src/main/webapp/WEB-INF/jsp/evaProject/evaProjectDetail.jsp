<%@ page import="com.okestro.app.userinfo.UserInfoVo" %><%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 25. 5. 8.
  Time: 오후 4:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="<c:url value="/app/js/evaProject/evaProjectDetail.js"/>"></script>
<%
    UserInfoVo loginUser = (UserInfoVo) session.getAttribute("loginUser");
    String userEmail = (String) session.getAttribute("userEmail");
    String roleCd = (String) session.getAttribute("roleCd");
%>

<div id="page-wrapper">
    <div class="header">
        <h1 class="page-title">심사 프로젝트 상세</h1>
    </div>
    <div class="page-inner">
        <table>
            <colgroup>
                <col style="width: 20%;" />
                <col style="width: 30%;" />
                <col style="width: 20%;" />
                <col style="width: 30%;" />
            </colgroup>
            <tbody>
                <form id="evaProjInfoForm" name="evaProjInfoForm" action="/evaProject/update.do" method="post">
                    <tr>
                        <c:if test="${evaProjectDetail.evaCd ne 03}">
                            <th>심사상태</th>
                            <td colspan="3">${evaProjectDetail.evaCdNm}</td>
                        </c:if>
                        <c:if test="${evaProjectDetail.evaCd eq 03}">
                            <th>심사상태</th>
                            <td>${evaProjectDetail.evaCdNm}</td>
                            <th>심사결과</th>
                            <td>${evaProjectDetail.scoreFin} 점</td>
                        </c:if>
                    </tr>
                    <tr>
                        <th>프로젝트명</th>
                        <td colspan="3">${evaProjectDetail.projectName}</td>
                    </tr>
                    <tr>
                        <th>팀 구성원</th>
                        <td colspan="3">${evaProjectDetail.userGroupId}</td>
                    </tr>
                    <tr>
                        <th>프로젝트 설명</th>
                        <td colspan="3"><textarea style="width: 100%;" readonly>${evaProjectDetail.projectDetail}</textarea></td>
                    </tr>
                    <tr>
                        <th>url</th>
                        <td colspan="3"><a href="${evaProjectDetail.url}" target="_blank">${evaProjectDetail.url}</td>
                    </tr>
                    <c:if test="${attachmentDetailList.size() ne 0}">
                        <tr>
                            <th>첨부파일</th>
                            <td colspan="3">
                                <ul style="list-style-type: none;">
                                    <c:forEach items="${attachmentDetailList}" var="attach" varStatus="status">
                                        <li>${attach.attachmentName}</li>
                                    </c:forEach>
                                </ul>
                            </td>
                        </tr>
                    </c:if>
                </form>
                <tr>
                    <th>심사위원단</th>
                    <td colspan="3">
                        <c:if test="${evaProjectDetail.evaGroupId eq null and evaProjectDetail.evaCd eq '01' and roleCd eq 'C'}"><button id="evaGroupBtn">구성</button></c:if>
                        ${evaProjectDetail.evaGroupId}
                    </td>
                </tr>
            </tbody>
        </table>
        <div class="btnDiv">
            <button id="listBtn" onclick=location.href="/evaProject/list.do">목록</button>
            <c:if test="${evaProjectDetail.evaFormYn eq 'Y' and evaProjectDetail.evaCd eq '01'}"><button id="evaBtn">심사하기</button></c:if>
        </div>

        <c:if test="${commentList.size() ne 0}">
            <div class="div-comment">
                <h5 class="comment-title">댓글</h5>
            </div>
            <table>
                <colgroup>
                    <col style="width: 10%;" />
                    <col />
                    <col style="width: 20%;" />
                    <col style="width: 20%;" />
<%--                    <col style="width: 12%;" />--%>
                </colgroup>
                <thead>
                    <th>No</th>
                    <th>내용</th>
                    <th>작성자</th>
                    <th>시간</th>
                </thead>
                <tbody>
                    <c:forEach items="${commentList}" var="cmt" varStatus="status">
                        <tr>
                            <td style="text-align: center;">${status.count}</td>
                            <td>${cmt.commentContent}</td>
                            <td style="text-align: center;">
                                <input type="hidden" id="userEmail" value="${cmt.frstRgsrId}" />
                                ${cmt.userName}
                            </td>
                            <td style="text-align: center;">${cmt.frstRgsrDtlDttm}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
<%--            <button id="updateBtn" style="margin-bottom: 0.1rem;">수정</button>--%>
<%--            <button id="deleteBtn" style="margin-top: 0.1rem;">삭제</button>--%>
        </c:if>

    </div>
</div>
