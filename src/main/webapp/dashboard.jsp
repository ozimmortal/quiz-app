<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quiz Builder Dashboard</title>
    <link
            rel="stylesheet"
            href="https://cdn.jsdelivr.net/npm/bulma@1.0.2/css/bulma.min.css"
    >
    <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"
            integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg=="
            crossorigin="anonymous"
            referrerpolicy="no-referrer"
    />
    <style>
        :root {
            --background-color: #fff;
            --text-color: #000;
            --card-bg-color: #fff;
            --cta-button-bg: #000;
            --cta-button-text: #fff;
        }
        [data-theme="dark"] {
            --background-color: #000;
            --text-color: #fff;
            --card-bg-color: #333;
            --cta-button-bg: #fff;
            --cta-button-text: #000;
        }
        body {
            background-color: var(--background-color);
            color: var(--text-color);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .navbar {
            background: var(--background-color);
        }
        .card {
            background: var(--card-bg-color);
            border: 1px solid var(--text-color);
        }
        .cta-button {
            background: var(--cta-button-bg);
            color: var(--cta-button-text);
            font-weight: bold;
        }
        .cta-button:hover {
            opacity: 0.8;
        }
        .dark-mode-toggle {
            cursor: pointer;
        }
        .main-container {

            display: flex;
            flex-direction: column;
            align-items: normal;
            justify-content: normal;
        }
        .label, .title {
            color: var(--text-color);
        }
        .welcome-container {
            display: flex;
            align-items: center;
            flex-direction: row;
            padding-left: 30px;
            margin: 20px;
            border-bottom: 1px solid var(--text-color);
            gap: 10px;
        }
        .create-btn {
            width: 170px;
            height: 45px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        @media only screen and (max-width: 600px) {
            .btn-label {
                display: none;
            }
            .create-btn {
                width: 40px;
                height: 40px;
                border-radius: 50%;
            }
        }
        .navbar-brand{
            margin-left: 10px;
            font-size: 2rem;
            margin-top: 10px;
            font-weight: bold;
            color: var(--text-color);
        }
    </style>
</head>
<body>
<%
    response.setHeader("Pragma", "no-cache");
    response.setHeader("Expires", "0");
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    String id = (String) session.getAttribute("id");
    if (id == null) {
        response.sendRedirect("login.jsp");
        return;
    }

%>
<sql:setDataSource var="dataSource" driver="com.mysql.cj.jdbc.Driver"
                   url="jdbc:mysql://localhost:3306/quiz"
                   user="root" password="oliy2627" />
<sql:query dataSource="${dataSource}" var="result">
    SELECT * FROM users WHERE id = ?
    <sql:param value="${id}" />
</sql:query>

<nav class="navbar">
    <div class="navbar-brand">
       <h2 class="title">Quiz Builder</h2>
    </div>
    <div class="navbar-end">
        <div class="navbar-item">
            <span class="icon dark-mode-toggle" onclick="toggleDarkMode()">
                <i class="fas fa-moon"></i>
            </span>
        </div>
        <div class="navbar-item has-dropdown is-hoverable">
            <a class="navbar-link">
                <span class="icon">
                    <i class="fas fa-user-circle"></i>
                </span>
            </a>
            <div class="navbar-dropdown is-right">
                <a class="navbar-item">
                    <span class="icon">
                        <i class="fas fa-user-circle"></i>
                    </span>
                    ${result.rows[0].name}
                </a>
                <a class="navbar-item" href="#about">
                    <span class="icon">
                        <i class="fas fa-info-circle"></i>
                    </span>
                    About
                </a>
                <a class="navbar-item" href="${pageContext.request.contextPath}/logout">
                    <span class="icon">
                        <i class="fas fa-sign-out-alt"></i>
                    </span>
                    Logout
                </a>
            </div>
        </div>
    </div>
</nav>

<section class="section main-container">
    <div class="welcome-container">
        <h1 class="title">Dashboard</h1>
        <a href="create-quiz.jsp" class="button is-dark create-btn">
            <span class="btn-label">Create Quiz</span>
            <span class="icon">
                <i class="fas fa-plus"></i>
            </span>
        </a>
    </div>
    <div class="columns is-multiline is-variable is-4 content-container">
        <sql:query dataSource="${dataSource}" var="result">
            SELECT * FROM quizzes WHERE userid = ?
            <sql:param value="${id}" />
        </sql:query>

        <c:forEach items="${result.rows}" var="quiz">
            <div class="column is-4">
                <div class="card">
                    <div class="card-content">
                        <p class="title is-4">${quiz.title}</p>
                        <p class="subtitle is-6">${quiz.description}</p>
                    </div>
                    <footer class="card-footer">
                        <a href="${pageContext.request.contextPath}/quiz.jsp?userid=<%=id%>&quizid=${quiz.qid}"
                           class="card-footer-item has-text-weight-bold">View Quiz</a>
                        <a href="${pageContext.request.contextPath}/analytics.jsp?userid=<%=id%>&quizid=${quiz.qid}"
                           class="card-footer-item has-text-weight-bold">View Analytics</a>
                    </footer>
                </div>
            </div>
        </c:forEach>
    </div>
</section>

<script>
    function toggleDarkMode() {
        const body = document.body;
        const currentTheme = body.getAttribute('data-theme');
        body.setAttribute('data-theme', currentTheme === 'dark' ? '' : 'dark');
        const toggleIcon = document.querySelector('.dark-mode-toggle i');
        toggleIcon.classList.toggle('fa-moon');
        toggleIcon.classList.toggle('fa-sun');
    }
</script>
</body>
</html>
