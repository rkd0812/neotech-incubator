<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2025-04-16
  Time: 오후 3:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>tiles</title>
    <link href="<c:url value="/assets/lib/bootstrap-5.3.5-dist/css/bootstrap-grid.min.css"/>"  rel="stylesheet" />
    <link href="<c:url value="/assets/lib/bootstrap-5.3.5-dist/css/bootstrap-reboot.min.css"/>"  rel="stylesheet" />
    <link href="<c:url value="/assets/lib/bootstrap-5.3.5-dist/css/bootstrap-utilities.min.css"/>"  rel="stylesheet" />
    <link href="<c:url value="/assets/lib/bootstrap-5.3.5-dist/css/bootstrap.min.css"/>"  rel="stylesheet" />

    <script src="<c:url value="/assets/lib/jquery/jquery-3.7.1.min.js" />"></script>
    <script src="<c:url value="/assets/lib/bootstrap-5.3.5-dist/js/bootstrap.bundle.min.js" />"></script>
    <script src="<c:url value="/assets/lib/bootstrap-5.3.5-dist/js/bootstrap.min.js" />"></script>

    <style>
        /* GOOGLE FONTS */
        @import url("https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap");

        /* VARIABLES CSS */
        :root {
            /*--nav--width: 92px;*/
            --nav--width: 180px;
            /* Colores */
            --first-color: #0c5df4;
            --bg-color: #12192c;
            --sub-color: #b6cefc;
            --white-color: #fff;

            /* Fuente y tipografia */
            --body-font: 'Poppins', sans-serif;
            --normal-font-size: 1rem;
            --small-font-size: .875rem;

            /* z index */
            --z-fixed: 100;
        }

        /* BASE */
        *, ::before, ::after {
            box-sizing: border-box;
        }

        body {
            position: relative;
            margin: 0;
            padding: 2rem 0 0 6.75rem;
            font-family: var(--body-font);
            font-size: var(--normal-font-size);
            transition: .5s;
        }

        h1 {
            margin: 0;
        }

        ul {
            margin: 0;
            padding: 0;
            list-style: none;
        }

        a {
            text-decoration: none;
        }

        /* l NAV */
        .l-navbar {
            position: fixed;
            top: 0;
            left: 0;
            width: var(--nav--width);
            height: 100vh;
            /*background-color: var(--bg-color);*/
            background-color: rgba(248, 249, 250);
            color: var(--white-color);
            padding: 100PX 1.5rem 2rem;
            transition: .5s;
            z-index: var(--z-fixed);
            align-items: center;
        }

        .navbar {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            /*height: 60px;*/
            height: 100px;
            z-index: 999;
            padding-left: 2rem;
            padding-right: 2rem;
        }

        /* NAV */
        .nav {
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            overflow: hidden;
        }

        .nav__brand {
            color: var(--bg-color);
            display: grid;
            grid-template-columns: max-content max-content;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }

        .nav__toggle {
            font-size: 1.25rem;
            padding: .75rem;
            cursor: pointer;
        }

        .nav__logo {
            color: var(--white-color);
            font-weight: 600;
        }

        .nav__link {
            display: grid;
            grid-template-columns: max-content max-content;
            align-items: center;
            column-gap: .75rem;
            padding: .75rem;
            /*color: var(--white-color);*/
            color: var(--bg-color);
            border-radius: .5rem;
            margin-bottom: 1rem;
            transition: .3s;
            cursor: pointer;
        }

        .nav__link:hover {
            background-color: var(--first-color);
        }

        .nav__icon {
            font-size: 1.25rem;
        }

        .nav_name {
            font-size: var(--small-font-size);
        }

        /* Expander menu */
        .expander {
            width: calc(var(--nav--width) + 9.25rem);
        }

        /* Add padding body*/
        .body-pd {
            padding: 2rem 0 0 16rem;
        }

        /* Active links menu */
        .active {
            background-color: var(--first-color);
            color: var(--white-color);
        }

        /* COLLAPSE */
        .collapse {
            grid-template-columns: 20px max-content 1fr;
        }

        .collapse__link {
            justify-self: flex-end;
            transition: .5s;
        }

        .collapse__menu {
            display: none;
            padding: .75rem 2.25rem;
        }

        .collapse__sublink {
            color: var(--sub-color);
            font-size: var(--small-font-size);
            white-space: nowrap;
        }

        .collapse__sublink:hover {
            color: var(--white-color);
        }

        /* Show collapse */
        .showCollapse {
            display: block;
        }

        /* Rotate icon */
        .rotate {
            transform: rotate(180deg);
            transition: .5s;
        }

        .collapse:not(.show) {
             display: grid;
        }

        .page-title {
            font-size: 2.5rem;
            font-weight: bold;
            color: #2c3e50;
            border-left: 6px solid #3498db;
            padding-left: 16px;
            margin-bottom: 24px;
            font-family: 'Pretendard', 'Noto Sans KR', sans-serif;
            letter-spacing: -0.5px;
        }

        #page-wrapper {
            padding-top: 100px;
            padding-left: 130px;
        }

        table {
            width: 70%;
            margin: 30px auto;
            border-collapse: collapse;
            background-color: #ffffff;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            border-radius: 8px;
            overflow: hidden;
            font-family: 'Noto Sans KR', sans-serif;
            font-size: 16px;
            color: #333;
        }

        th, td {
            padding: 16px;
            border-bottom: 1px solid #e0e0e0;
            text-align: center;
        }

        th {
            background-color: #f5f7fa;
            font-weight: 600;
            color: #2c3e50;
            width: 180px;
        }

        td input[type="text"],
        td input[type="date"] {
            padding: 8px 12px;
            border: 1px solid #ccc;
            border-radius: 4px;
            width: 45%;
            font-size: 14px;
        }

        td input[type="radio"] {
            margin-right: 6px;
        }

        td {
            vertical-align: middle;
        }

        input[type="radio"] + label {
            margin-right: 12px;
            cursor: pointer;
        }

        h5.comment-title {
            font-size: 18px;
            font-weight: 600;
            color: #2c3e50;
            margin-top: 40px;
            margin-bottom: 16px;
            text-align: left;
            border-left: 4px solid #3498db;
            padding-left: 12px;
            /*background-color: #f5f7fa;*/
            display: inline-block;
            border-radius: 4px;
        }

    </style>
</head>
<body id="body-pd">
    <div class="wrap">
        <tiles:insertAttribute name="navBar" />
        <tiles:insertAttribute name="sideBar" />
        <tiles:insertAttribute name="body" />
    </div>
</body>




<%--<body>--%>
<%--<div class="wrap">--%>
<%--    <tiles:insertAttribute name="navBar" />--%>
<%--    <div class="container-fluid">--%>
<%--        <div class="row flex-nowrap">--%>
<%--            <tiles:insertAttribute name="sideBar" />--%>
<%--            <div class="col py-3">--%>
<%--                <tiles:insertAttribute name="body" />--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</div>--%>
<%--</body>--%>
</html>