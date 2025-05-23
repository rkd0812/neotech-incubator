<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 25. 5. 8.
  Time: 오후 4:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="<c:url value="/app/js/evaProject/evaProjectDetail.js"/>"></script>
<div id="page-wrapper">
    <div class="header">
        <h1 class="page-title">심사 프로젝트 상세</h1>
    </div>
    <div class="page-inner" style="text-align: center;">
        <table>
            <colgroup>
            </colgroup>
            <tbody>
                <form id="detailForm" name="detailForm" action="/evaProject/update.do" method="post">
                    <tr>
                        <th>심사상태</th>
                        <td>${evaProjectDetail.evaCdNm}</td>
                        <c:if test="${evaProjectDetail.evaCd eq 03}">
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
                        <td colspan="3"><a href="${evaProjectDetail.url}">${evaProjectDetail.url}</td>
                    </tr>
                    <c:if test="${attachmentDetailList.size() ne 0}">
                        <tr>
                            <th>첨부파일</th>
                            <td>
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
                    <td>
                        <c:if test="${evaProjectDetail.evaGroupId eq null and evaProjectDetail.evaCd eq '01'}"><button id="evaGroupBtn">구성</button></c:if>
                        ${evaProjectDetail.evaGroupId}
                    </td>
                </tr>
            </tbody>
        </table>
        <button id="listBtn" onclick=location.href="/evaProject/list.do">목록</button>
        <c:if test="${evaProjectDetail.evaFormYn eq 'Y' and evaProjectDetail.evaCd eq '01'}"><button id="evaBtn">심사하기</button></c:if>

        <c:if test="${commentList.size() ne 0}">
            <h5 class="comment-title">댓글</h5>
            <table>
                <thead>
                    <th>No</th>
                    <th>내용</th>
                    <th>작성자</th>
                    <th>시간</th>
                </thead>
                <tbody>
                    <c:forEach items="${commentList}" var="cmt" varStatus="status">
                        <tr>
                            <td>${status.count}</td>
                            <td>${cmt.commentContent}</td>
                            <td>${cmt.frstRgsrId}</td>
                            <td>${cmt.frstRgsrDtlDttm}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>

    </div>
</div>
