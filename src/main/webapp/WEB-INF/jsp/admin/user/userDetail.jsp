<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2025-04-16
  Time: 오후 3:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="/app/js/admin/user/userDetail.js"></script>
<script>
    const msg = "${msg}";
    if(msg != '') {
        alert(msg);
    }
</script>
<div id="page-wrapper">
    <div class="header">
        <h1 class="page-title">사용자 상세</h1>
        <div class="page-inner">
            <form id="detailForm" name="detailForm" action="/admin/user/update.do" method="post">
                <table>
                    <colgroup>
                        <col style="width: 20%;" />
                        <col />
                    </colgroup>
                    <tbody>
                        <tr>
                            <th>이름</th>
                            <td>${userDetail.userName}</td>
                        </tr>
                        <tr>
                            <th>이메일</th>
                            <input type="hidden" id="userEmail" name="userEmail" value="${userDetail.userEmail}">
                            <td>${userDetail.userEmail}</td>
                        </tr>
                        <tr>
                            <th>비밀번호</th>
                            <td><input type="text" id="userPassword" name="userPassword" value="${userDetail.userPassword}" /></td>
                        </tr>
                        <tr>
                            <th>권한</th>
                            <td>
                                <c:if test="${userDetail.delYn eq 'Y'}">
                                    ${userDetail.roleCdNm}
                                </c:if>
                                <c:if test="${userDetail.delYn ne 'Y'}">
                                    <select id="roleCd" name="roleCd">
                                        <c:forEach var="role" items="#{codeList}" varStatus="status">
                                            <option value="${role.codeVal}" <c:if test="${userDetail.roleCd eq role.codeVal}">selected</c:if> >${role.codeName}</option>
                                        </c:forEach>
                                    </select>
                                </c:if>
                            </td>
                        </tr>
                        <tr>
                            <th>가입일자</th>
                            <td>${userDetail.frstRgsrDtlDttm}</td>
                        </tr>
                        <tr>
                            <th>탈퇴여부</th>
                            <td>${userDetail.delYn}</td>
                        </tr>
                        <c:if test="${userDetail.delYn eq 'Y'}">
                            <tr>
                                <th>탈퇴일자</th>
                                <td>${userDetail.quitDtlDttm}</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </form>
            <div class="btnDiv">
                <button id="listBtn" onclick=location.href="/admin/user/list.do">목록</button>
                <c:if test="${userDetail.delYn ne 'Y'}">
                    <button id="updateBtn">수정</button>
                    <button id="deleteBtn">삭제</button>
                </c:if>
            </div>
        </div>
    </div>
</div>