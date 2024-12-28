<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link
            rel="stylesheet"
            href="https://cdn.jsdelivr.net/npm/bulma@1.0.2/css/bulma.min.css"
    >
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg==" crossorigin="anonymous" referrerpolicy="no-referrer" />

    <title>Quizz Builder</title>

    <style>
        *{
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Roboto', sans-serif;
            overflow-y: hidden;

        }
        :root {
            --background-color: #efefef;
            --text-color: #000000;
            --card-bg-color: #efefef;
            --cta-button-bg: #000;
            --cta-button-text: #efefef;
        }

        [data-theme="dark"] {
            --background-color: #000;
            --text-color: #efefef;
            --card-bg-color: #333;
            --cta-button-bg: #efefef;
            --cta-button-text: #000;
        }

        body {
            background-color: var(--background-color);
            color: var(--text-color);
        }
        .hero {
            background: var(--background-color);
            color: var(--text-color);
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
            cursor: pointer;
            padding: 0.5rem;
            margin: 0.5rem;
        }

        .dark-mode-toggle .icon {
            font-size: 1.5rem;
            color: var(--text-color);
        }
        .title{
            color: var(--text-color);
        }
    </style>
</head>
<body>
<%

    if (session.getAttribute("id") != null){
        response.sendRedirect("dashboard.jsp");
    }


%>
<button class="dark-mode-toggle" onclick="toggleDarkMode()">
        <span id="darkModeIcon" class="icon">
            <i class="fas fa-moon"></i>
        </span>
</button>
<!-- Hero Section -->
<section class="hero is-fullheight">
    <div class="hero-body">
        <div class="container has-text-centered">
            <h1 class="title is-1 first">Build Quizzes Effortlessly</h1>
            <p class="subtitle is-4">
                Create engaging quizzes in minutes and track your results instantly.
            </p>
            <a href="login.jsp" class="button cta-button is-large">Get Started Now</a>
        </div>
    </div>

</section>

<script>
    function toggleDarkMode() {
        const body = document.body;
        const currentTheme = body.getAttribute('data-theme');
        const icon = document.getElementById('darkModeIcon');

        if (currentTheme === 'dark') {
            body.setAttribute('data-theme', '');
            icon.innerHTML = '<i class="fas fa-moon"></i>';
        } else {
            body.setAttribute('data-theme', 'dark');
            icon.innerHTML = '<i class="fas fa-sun"></i>';
        }
    }
</script>
</body>
</html>