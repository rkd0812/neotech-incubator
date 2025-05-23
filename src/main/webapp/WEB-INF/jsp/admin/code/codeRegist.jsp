<%--
    Created by IntelliJ IDEA.
    User: admin
    Date: 25. 4. 28.
    Time: 오후 4:03
    To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="/app/js/admin/code/codeRegist.js"></script>
<div id="page-wrapper">
    <div class="header">
        <h1 class="page-header">코드 등록</h1>
    </div>
    <div class="page-inner" style="text-align: center;">
        <form id="registForm" name="registForm" action="/admin/code/regist.do" method="post">
            <table>
                <colgroup></colgroup>
                <tbody>
                    <tr>
                        <th>상위코드명</th>
                        <td><input type="text" id="upperCodeName" name="upperCodeName" /></td>
                    </tr>
                    <tr>
                        <th>코드값</th>
                        <td><input type="text" id="codeVal" name="codeVal" /></td>
                    </tr>
                    <tr>
                        <th>코드명</th>
                        <td><input type="text" id="codeName" name="codeName" /></td>
                    </tr>
                </tbody>
            </table>
        </form>
        <button id="btnCancel" onclick=location.href="/admin/code/list.do">취소</button>
        <button id="btnRegist">등록</button>
    </div>
</div>
