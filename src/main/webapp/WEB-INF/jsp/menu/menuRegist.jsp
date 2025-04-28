<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 25. 4. 28.
  Time: 오전 10:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>메뉴 등록</title>
    <c:import charEncoding="utf-8" url="/layout/cmmnlib.do" />
    <script src="/app/js/menu/menuRegist.js"></script>
</head>
<body>
<h4>메뉴 등록</h4>
<div class="wrap" style="text-align: center;">
    <form id="registForm" name="registForm" action="/menu/regist.do" method="post">
        <table style="width: 700px; border: solid 1px black; margin: 0 auto; text-align: center;">
            <colgroup>

            </colgroup>
            <tbody>
                <tr>
                    <th>메뉴명</th>
                    <td><input type="text" id="menuName" name="menuName" /></td>
                </tr>
                <tr>
                    <th>메뉴레벨</th>
                    <td><input type="text" id="menuLevel" name="menuLevel" /></td>
                </tr>
            </tbody>
        </table>
    </form>
    <button id="btnCancel" onclick=location.href="/menu/list.do">취소</button>
    <button id="btnRegist">등록</button>
</div>
</body>
</html>
