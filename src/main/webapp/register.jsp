
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Quiz Builder</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@1.0.2/css/bulma.min.css">
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

        .label, .title {
            color: var(--text-color);
        }

        .error-notification {
            margin-top: 1rem;
            margin-left: 50%;
            margin-right: 50%;
            position: relative;
            z-index: 100;
            top: 1rem;
            padding: 1rem;
            width: 270px;
            background-color: #ff3860;
            color: #fff;
            border-radius: 4px;
        }

        input[type="password"], input[type="email"] {
            width: calc(100% - 30px);
        }

        .toggle-password {
            background: none;
            border: none;
            position: relative;
            left: -30px;
            cursor: pointer;
        }

        .field {
            position: relative;
        }

        .help.is-danger {
            color: red;
        }

        .help.is-success {
            color: green;
        }
    </style>
</head>
<body>
    <button class="dark-mode-toggle" onclick="toggleDarkMode()">
        <i id="theme-icon" class="fas fa-moon"></i>
    </button>

    <div class="card">
        <h1 class="title has-text-centered">Register</h1>
        <form id="registrationForm" method="post" action="${pageContext.request.contextPath}/register">
            <div class="field">
                <label class="label">Full Name</label>
                <div class="control">
                    <input class="input" type="text" placeholder="Enter your full name" required name="name">
                </div>
            </div>

            <div class="field">
                <label class="label">Email</label>
                <div class="control">
                    <input class="input" type="email" placeholder="Enter your email" required name="email" id="email">
                </div>
                <p id="emailError" class="help is-danger" style="display:none;"></p>
            </div>

            <div class="field">
                <label class="label">Password</label>
                <div class="control">
                    <input class="input" type="password" placeholder="Enter your password" required name="password" id="password">
                    <button type="button" class="toggle-password" onclick="togglePassword('password')">
                        <i class="fas fa-eye"></i>
                    </button>
                </div>
            </div>

            <div class="field">
                <label class="label">Confirm Password</label>
                <div class="control">
                    <input class="input" type="password" placeholder="Confirm your password" required name="confirmPassword" id="confirmPassword">
                    <button type="button" class="toggle-password" onclick="togglePassword('confirmPassword')">
                        <i class="fas fa-eye"></i>
                    </button>
                </div>
                <p id="passwordError" class="help is-danger" style="display:none;"></p>
            </div>

            <div class="field">
                <button type="submit" class="button cta-button is-fullwidth">Register</button>
            </div>

            <p class="has-text-centered">
                Already have an account? <a href="login.jsp"> Login here.</a>
            </p>
        </form>

        <c:if test="${param.error != null}">
            <div class="notification is-danger error-notification" style="display: none;">
                <p>Invalid username or password</p>
            </div>
        </c:if>
    </div>

    <script>
        document.getElementById('registrationForm').addEventListener('submit', function(event) {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            const passwordError = document.getElementById('passwordError');
            const email = document.getElementById('email').value;
            const emailError = document.getElementById('emailError');
            const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

            let valid = true;

            if (password !== confirmPassword) {
                passwordError.textContent = 'Passwords do not match';
                passwordError.style.display = 'block';
                valid = false;
            } else {
                passwordError.style.display = 'none';
            }

            if (!emailPattern.test(email)) {
                emailError.textContent = 'Invalid email address';
                emailError.style.display = 'block';
                valid = false;
            } else {
                emailError.style.display = 'none';
            }

            if (!valid) {
                event.preventDefault();
            }
        });

        document.getElementById('email').addEventListener('input', function() {
            const email = this.value;
            const emailError = document.getElementById('emailError');
            const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

            if (!emailPattern.test(email)) {
                emailError.textContent = 'Invalid email address';
                emailError.style.display = 'block';
            } else {
                emailError.style.display = 'none';
            }
        });

        function togglePassword(fieldId) {
            const field = document.getElementById(fieldId);
            const type = field.type === 'password' ? 'text' : 'password';
            field.type = type;

            const icon = field.nextElementSibling.querySelector('i');
            icon.className = type === 'password' ? 'fas fa-eye' : 'fas fa-eye-slash';
        }

        function toggleDarkMode() {
            const body = document.body;
            const themeIcon = document.getElementById('theme-icon');
            const currentTheme = body.getAttribute('data-theme');
            const newTheme = currentTheme === 'dark' ? '' : 'dark';

            body.setAttribute('data-theme', newTheme);
            themeIcon.className = newTheme === 'dark' ? 'fas fa-sun' : 'fas fa-moon';

            localStorage.setItem('theme', newTheme);
        }

        window.addEventListener('load', () => {
            const storedTheme = localStorage.getItem('theme');
            if (storedTheme) {
                document.body.setAttribute('data-theme', storedTheme);
                const themeIcon = document.getElementById('theme-icon');
                themeIcon.className = storedTheme === 'dark' ? 'fas fa-sun' : 'fas fa-moon';
            }
        });

        window.addEventListener('load', () => {
            const urlParams = new URLSearchParams(window.location.search);
            const error = urlParams.get('error');
            if (error) {
                document.querySelector('.error-notification').style.display = 'block';
            }
        });
    </script>
</body>
</html>
