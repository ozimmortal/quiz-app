
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Quiz Builder</title>
    <link
            rel="stylesheet"
            href="https://cdn.jsdelivr.net/npm/bulma@1.0.2/css/bulma.min.css"
    >
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg==" crossorigin="anonymous" referrerpolicy="no-referrer" />


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
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .card {
            background: var(--card-bg-color);
            border: 1px solid var(--text-color);
            width: 100%;
            max-width: 400px;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
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
            position: fixed;
            top: 1rem;
            right: 1rem;
            background: none;
            border: none;
            font-size: 1.5rem;
            cursor: pointer;
            color: var(--text-color);
        }
        .label,.title{
            color: var(--text-color);
        }
        .error-notification{
            margin-top: 1rem;
            margin-left: 50%;
            margin-right: 50%;
            position: absolute;
            z-index:100;
            top: 1.5rem;
            padding: 1rem;
            width: 270px;
        }
    </style>
</head>
<body>
<c:if test="${param.error != null}">
    <div class="notification is-danger error-notification">
        <button class="delete"></button>
        <p>Invalid username or password</p>
    </div>
</c:if>
    <button class="dark-mode-toggle" onclick="toggleDarkMode()">
        <i id="theme-icon" class="fas fa-moon"></i>
    </button>

    <div class="card">
        <h1 class="title has-text-centered">Register</h1>
        <form method="post" action="${pageContext.request.contextPath}/register">
            <div class="field">
                <label class="label">Full Name</label>
                <div class="control">
                    <input class="input" type="text" placeholder="Enter your full name" required name="name">
                </div>
            </div>

            <div class="field">
                <label class="label">Email</label>
                <div class="control">
                    <input class="input" type="email" placeholder="Enter your email" required name="email">
                </div>
            </div>

            <div class="field">
                <label class="label">Password</label>
                <div class="control">
                    <input class="input" type="password" placeholder="Enter your password" required name="password">
                </div>
            </div>

            <div class="field">
                <label class="label">Confirm Password</label>
                <div class="control">
                    <input class="input" type="password" placeholder="Confirm your password" required name="confirmPassword">
                </div>
            </div>

            <div class="field">
                <button type="submit" class="button cta-button is-fullwidth">Register</button>
            </div>

            <p class="has-text-centered">
                Already have an account? <a href="login.jsp"> Login here.</a>
            </p>
        </form>
    </div>

    <!-- Font Awesome Icons -->

    <script>
        function toggleDarkMode() {
            const body = document.body;
            const themeIcon = document.getElementById('theme-icon');
            const currentTheme = body.getAttribute('data-theme');
            const newTheme = currentTheme === 'dark' ? '' : 'dark';

            body.setAttribute('data-theme', newTheme);
            themeIcon.className = newTheme === 'dark' ? 'fas fa-sun' : 'fas fa-moon';
        }
    </script>
</body>
</html>
