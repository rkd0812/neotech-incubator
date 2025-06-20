<%--
  Created by IntelliJ IDEA.
  User: yungayoung
  Date: 25. 4. 25.
  Time: 오후 4:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="/app/js/admin/user/userRegist.js"></script>
<div id="page-wrapper">
    <div class="header">
        <h1 class="page-title">사용자 등록</h1>
            <div class="page-inner">
                <form id="userRegistForm" name="userRegistForm" action="/admin/user/regist.do" method="post">
                    <table>
                        <colgroup>
                            <col style="width: 20%;" />
                            <col />
                        </colgroup>
                        <tbody>
                            <tr>
                                <th>이름</th>
                                <td>
                                    <input type="text" id="userName" name="userName" />
                                </td>
                            </tr>
                            <tr>
                                <th>이메일</th>
                                <td>
                                    <input type="hidden" name="userEmail" />
                                    <input type="text" id="userEmailId" style="width: 30%; display: inline-block;" />@<input type="text" id="userEmailDomain" style="width: 30%; display: inline-block;" />
                                    <select id="domainList" class="form-select domain-select" style="width: 30%; display: inline-block;">
                                        <option value="">직접 입력</option>
                                        <option value="naver.com">naver.com</option>
                                        <option value="google.com">google.com</option>
                                        <option value="kakao.com">kakao.com</option>
                                        <option value="daum.net">daum.net</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <th>비밀번호</th>
                                <td><input type="text" id="userPassword" name="userPassword" /></td>
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
                        </tbody>
                    </table>
                </form>
                <div class="btnDiv">
                    <button id="btnCancel" onclick=location.href="/admin/user/list.do">취소</button>
                    <button id="btnRegist">등록</button>
                </div>
            </div>
    </div>
</div>
