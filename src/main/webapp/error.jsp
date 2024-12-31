"<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quiz Form Builder</title>
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
            --card-bg-color: #212A37;
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
        .inner-form{
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            gap: 10px;
            padding: 20px;
            width: 50%;

        }

        @media (max-width: 768px) {
            .inner-form{
                width: 100%;
            }
        }

        .analytics-container {
            display: flex;
            justify-content: center;
            width: 100%;
            color: var(--text-color);


        }
        .question-list{
            width: 100%;
        }
        .centered{
            text-align: center;
        }
        .question-item {
            margin-bottom: 20px;
            width: 100%;
        }

        .delete-btn {
            background: transparent;
            border: none;
            color: var(--text-color);
            cursor: pointer;
        }

        .delete-btn:hover {
            color: red;
        }
        .nav-title{
            display: flex;
            width: 100%;
            bottom: 20px;
            justify-content: space-between;
            align-items: center;
        }
        .label, .title {
            color: var(--text-color);
        }
        .label{
            font-size: 1rem;
            font-weight: bold;
        }
        .delete-answer-group{
            display: flex;
            justify-content: space-between;
            align-items: center;
            width: 100%;
            flex-wrap: wrap;
            gap: 30px;
            padding: 10px;
        }
        .answer-ipt{
            display: flex;
            flex-direction: row;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }
        .radio{
            display: flex;
            flex-direction: row;
            gap: 10px;
            justify-content: center;
            align-items: center;

        }
        .control{
            gap: 10px;
            display: grid;
            grid-template-columns: 1fr 1fr;
        }
        .card{
            padding: 20px;
            width: 100%;
            box-shadow: 10px 10px 10px rgba(0, 0, 0, 0.2);
            border: none;
            color: var(--text-color);
        }
        .fields{
            width: 100%;
        }
        .count{
            display: inline-block;
            font-size: small;
            margin-left: 10px;
        }
        .nav-title{
            position: sticky;
            z-index: 100;
            top: 10px;

        }
        .nav-button{
            display: flex;
            gap: 10px;
            align-items: center;;
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
            display: none;
        }
        .table th, .table td {
            color: var(--text-color); /* Applies the text color to headers and cells */
        }


    </style>
</head>
<body>



<section class="section">
    <div class="container">
        <div class="nav-title">
            <h1 class="title">Quiz  Builder</h1>
            <div class="nav-button">
                <button class="dark-mode-toggle" onclick="toggleDarkMode()">
                    <i id="theme-icon" class="fas fa-moon"></i>
                </button>
            </div>
        </div>
        <div class="analytics-container ">
            <div class="card suc" >
                <h1 class="title" style="color: red">Error Occured</h1>
                <a href="dashboard.jsp">Go Back</a>
            </div>`
        </div>
    </div>

</section>

<script >



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
"