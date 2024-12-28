<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sql" uri="jakarta.tags.sql" %>
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

        .form-container {
            display: flex;
            justify-content: center;
            width: 100%;


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
        .suc{
            color: lawngreen;
            text-align: center;
        }
    </style>
</head>
<body>
<%
    String id = request.getParameter("userid");
    String quiz_id = request.getParameter("quizid");
    System.out.println(id + " " + quiz_id);
 %>
<div class="notification is-danger error-notification">
    <button class="delete"></button>
    <p id="error-message"></p>
</div>
<section class="section">
    <div class="container">
        <div class="nav-title">
            <h1 class="title">Quiz  Builder</h1>
            <div class="nav-button">
                <button class="dark-mode-toggle" onclick="toggleDarkMode()">
                    <i id="theme-icon" class="fas fa-moon"></i>
                </button>
                <button class="button is-dark cta-button " id="sub-btn" onclick="submitAnswer()">
                    Submit
                </button>
            </div>
        </div>
        <div class="form-container">

        </div>
    </div>

</section>
<script src="render.js" ></script>
<script >
    let data;
    fetch(`http://localhost:8080/quiz_app_war_exploded/get-quiz?qid=<%=quiz_id%>&id=<%=id%>`, {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json',
        },
    }).then(res => res.json())
        .then(json => {
            data = json;
            console.log(data); // Log the fetched data
            render(data,data.title,data.description);
        })
        .catch(err => console.error("Error fetching quiz data:", err));

    function toggleDarkMode() {
        const body = document.body;
        const themeIcon = document.getElementById('theme-icon');
        const currentTheme = body.getAttribute('data-theme');
        const newTheme = currentTheme === 'dark' ? '' : 'dark';

        body.setAttribute('data-theme', newTheme);
        themeIcon.className = newTheme === 'dark' ? 'fas fa-sun' : 'fas fa-moon';
    }

    function submitAnswer(){
        const errorMessage = document.querySelector('#error-message');
        const answerData = collect();
        console.log(answerData);
        if(answerData.id === 0){
            errorMessage.innerText = "Please fill the Id field";
            errorMessage.style.display = "block";
            return;
        }
        for (const answer of answerData.answers.answers) {
            if (answer.answer === "" || answer.answer === null) {
                errorMessage.innerText = "Please fill the answer field on question " + answer.question + " ";
                errorMessage.style.display = "block";
                return;
            }
        }
        fetch(`http://localhost:8080/quiz_app_war_exploded/submit-answer`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({answerData})
        }).then(res => res.json())
            .then(json => {
                if (json.success){
                    document.querySelector('.inner-form').display =" none";
                    const form = document.querySelector('.form-container');
                    const btn = document.querySelector('#sub-btn');
                    btn.style.display = "none";
                    form.innerHTML = `
                    <div class="card suc" >
                        <h1 class="title" style="color: lawngreen">Thank you for submitting your answers</h1>
                    </div>`;

                }
            }).catch(err => console.error("Error fetching quiz data:", err))
    }
</script>
</body>
</html>
