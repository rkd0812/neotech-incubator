<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 25. 4. 28.
  Time: 오후 5:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="/app/js/admin/code/codeDetail.js"></script>
<script>
    const msg = "${msg}";
    if(msg != '') {
        alert(msg);
    }
</script>
<div id="page-wrapper">
    <div class="header">
        <h1 class="page-title">코드 상세조회</h1>
    </div>
    <div class="page-inner">
        <form id="codeInfoForm" name="codeInfoForm">
            <table>
                <tbody>
                    <tr>
                        <th>상위코드명</th>
                        <td>
                            <input type="hidden" name="preCodeName" value="${codeDetail.upperCodeName}">
                            <select id="upperCodeName" name="upperCodeName">
                            <c:forEach items="${codeGroupList}" var="grp" varStatus="status">
                                <option name="" value="${grp.upperCodeName}" <c:if test="${codeDetail.upperCodeName eq grp.upperCodeName}">selected</c:if> >${grp.upperCodeName}</option>
                            </c:forEach>
                        </td>
                    </tr>
                    <tr>
                        <th>코드값</th>
                        <td>
                            <input type="hidden" name="preCodeVal" value="${codeDetail.codeVal}">
                            <input type="text" id="codeVal" name="codeVal" value="${codeDetail.codeVal}" />
                        </td>
                    </tr>
                    <tr>
                        <th>코드명</th>
                        <td>
                            <input type="text" id="codeName" name="codeName" value="${codeDetail.codeName}" />
                        </td>
                    </tr>
                    <tr>
                        <th>등록일자</th>
                        <td>
                            ${codeDetail.frstRgsrDtlDttm}
                        </td>
                    </tr>
                </tbody>
            </table>
        </form>
        <div class="btnDiv">
            <button id="listBtn" onclick=location.href="/admin/code/list.do">목록</button>
            <button id="updateBtn">수정</button>
            <button id="deleteBtn">삭제</button>
        </div>
    </div>
</div>
