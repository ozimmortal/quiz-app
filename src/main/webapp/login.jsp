
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Quiz Builder</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.9.4/css/bulma.min.css">
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
    </style>
</head>
<body>
    <button class="dark-mode-toggle" onclick="toggleDarkMode()">
        <i id="theme-icon" class="fas fa-moon"></i>
    </button>

    <div class="card">
        <h1 class="title has-text-centered">Login</h1>
        <form>
            <div class="field">
                <label class="label">Email</label>
                <div class="control">
                    <input class="input" type="email" placeholder="Enter your email" required>
                </div>
            </div>

            <div class="field">
                <label class="label">Password</label>
                <div class="control">
                    <input class="input" type="password" placeholder="Enter your password" required>
                </div>
            </div>

            <div class="field">
                <button type="submit" class="button cta-button is-fullwidth">Login</button>
            </div>

            <p class="has-text-centered">
                <a href="#">Forgot Password?</a>
            </p>
        </form>
    </div>

    <!-- Font Awesome Icons -->
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
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
