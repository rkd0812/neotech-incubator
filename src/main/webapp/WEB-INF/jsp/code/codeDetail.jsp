<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 25. 4. 28.
  Time: 오후 5:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>코드 상세조회</title>
    <c:import charEncoding="utf-8" url="/layout/cmmnlib.do" />
    <script src="/app/js/code/codeDetail.js"></script>
</head>
<h4>코드 상세조회</h4>
<body>
    <div class="wrap" style="text-align: center;">
        <form id="detailForm" name="detailForm" action="/code/update.do" method="post">
            <table style="width: 700px; border: solid 1px black; margin: 0 auto; text-align: center;">
                <tbody>
                    <tr>
                        <th>코드분류</th>
                        <td>
                            <input type="text" id="codeName" name="codeName" value="${codeDetail.codeName}" />
                        </td>
                    </tr>
                    <tr>
                        <th>코드값</th>
                        <td>
                            <input type="text" id="codeVal" name="codeVal" value="${codeDetail.codeVal}" />
                        </td>
                    </tr>
                    <tr>
                        <th>코드명</th>
                        <td>
                            <input type="text" id="codeKr" name="codeKr" value="${codeDetail.codeKr}" />
                        </td>
                    </tr>
                </tbody>
            </table>
        </form>
        <button id="listBtn" onclick=location.href="/code/list.do">목록</button>
        <button id="updateBtn">수정</button>
        <button id="deleteBtn">삭제</button>
    </div>
</body>
</html>
