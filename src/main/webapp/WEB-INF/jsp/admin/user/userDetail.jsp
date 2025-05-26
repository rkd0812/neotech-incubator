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
        <h1 class="page-title">사용자 상세조회</h1>
        <div class="page-inner">
            <form id="detailForm" name="detailForm" action="/admin/user/update.do" method="post">
                <table>
                    <tbody>
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
                                <select id="roleCd" name="roleCd">
                                    <c:forEach var="role" items="#{codeList}" varStatus="status">
                                        <option value="${role.codeVal}" <c:if test="${userDetail.roleCd eq role.codeVal}">selected</c:if> >${role.codeName}</option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th>등록일자</th>
                            <td>${userDetail.frstRgsrDtlDttm}</td>
                        </tr>
                    </tbody>
                </table>
            </form>
            <button id="listBtn" onclick=location.href="/admin/user/list.do">목록</button>
            <button id="updateBtn">수정</button>
            <button id="deleteBtn">삭제</button>
        </div>
    </div>
</div>