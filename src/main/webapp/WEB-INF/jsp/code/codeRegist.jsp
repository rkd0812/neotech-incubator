<%--
    Created by IntelliJ IDEA.
    User: admin
    Date: 25. 4. 28.
    Time: 오후 4:03
    To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>코드 등록</title>
    <c:import charEncoding="utf-8" url="/layout/cmmnlib.do" />
    <script src="/app/js/code/codeRegist.js"></script>
</head>
<body>
<h4>코드 등록</h4>
<div class="wrap" style="text-align: center;">
    <form id="registForm" name="registForm" action="/code/regist.do" method="post">
        <table style="width: 700px; border: solid 1px black; margin: 0 auto; text-align: center;">
            <colgroup></colgroup>
            <tbody>
                  <tr>
                      <th>코드명</th>
                      <td><input type="text" id="codeKr" name="codeKr" /></td>
                  </tr>
                  <tr>
                      <th>코드값</th>
                      <td><input type="text" id="codeVal" name="codeVal" /></td>
                  </tr>
                  <tr>
                      <th>코드값설명</th>
                      <td><input type="text" id="codeName" name="codeName" /></td>
                  </tr>
            </tbody>
        </table>
    </form>
    <button id="btnCancel" onclick=location.href="/code/list.do">취소</button>
    <button id="btnRegist">등록</button>
</div>
</body>
</html>
