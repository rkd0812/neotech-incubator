<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2025-04-24
  Time: 오후 4:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>프로젝스 상세 조회</title>
    <c:import charEncoding="utf-8" url="/layout/cmmnlib.do" />
    <script src="/app/js/project/projectDetail.js"></script>
</head>
<body>
<!--  프로젝트 상세 조회 메인 컨텐츠 -->
<div id ="content_002">

    <!-- 프로젝트 상세 테이블 -->
    <div id="pro_detail">
        <caption>프로젝트 상세 조회</caption>
        <table border="1">
            <tbody>
            <tr>
                <th>심사 결과</th>
<%--                <td>${project.scoreFin}</td>--%>
                <th>심사 상태</th>
<%--                <td>${project.evaCd}</td>--%>
            </tr>
            <tr>
                <th>프로젝트 명</th>
                <td>
<%--                    <input type="text" id="pro_name" value=${projectDetail.projectName}>--%>
                </td>
            </tr>
            <tr>
                <th>팀 구성원</th>
                <td>
                    ${projectDetail.groupId}
                </td>
                <td>
                    <button type="button" id="team_add_btn">추가</button>
                </td>
            </tr>
            <tr>
                <th>설명</th>
                <td>
                    <input type="text" id="explain" value=${projectDetail.projectDetail}>
                </td>
            </tr>
            <tr>
                <th>Demo(url/lib)</th>
                <td>
                    <input type="text" id="url" value=${projectDetail.url}>
                    <button type="button" id="demo_btn">추가</button>
                </td>
            </tr>
            <tr>
                <th>첨부파일</th>
                <td>
                    <input type="text" id='attachment' value=${projectDetail.attachmentId}>
                    <button type="button" id="file_upload">첨부파일</button>
                    <button type="button" id="file_download">다운로드</button>
                </td>
            </tr>
            </tbody>
        </table>
    </div>

    <!-- 프로젝트 댓글 테이블 -->
    <div id="pro_comment">
        <table>
            <tr>
                <td>작성자</td>
            </tr>
            <tr>
                <td>내용</td>
                <td>
                    <textarea id="comment" placeholder="댓글입력"></textarea>
                </td>
            </tr>
        </table>
    </div>

    <!-- 버튼 -->
    <div id="pro_detail_btns">
        <button type="button" id="pro_modify">수정</button>
        <button type="button" id="pro_delete">삭제</button>
        <button type="button" id="pro_eva">심사요청</button>
    </div>
</div>
</body>
</html>
