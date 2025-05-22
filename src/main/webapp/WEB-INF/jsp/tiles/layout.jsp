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
            --nav--width: 92px;

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
            /*top: 10vh;*/
            left: 0;
            width: var(--nav--width);
            height: 100vh;
            /*background-color: var(--bg-color);*/
            background-color: rgba(248, 249, 250);
            color: var(--white-color);
            padding: 1.5rem 1.5rem 2rem;
            transition: .5s;
            z-index: var(--z-fixed);
        }

        .navbar {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            transition: .5s;
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