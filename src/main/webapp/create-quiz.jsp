<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="true" errorPage="error.jsp" %>
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
            gap: 20px;
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

        .question-item {
            margin-bottom: 20px;
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
            box-shadow: 10px 10px 10px rgba(0, 0, 0, 0.2);
            border: none;
        }
        .fields{
            width: 100%;


        }
        .center-txt{
            text-align: center;
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
<section class="section">
    <div class="container">
        <div class="nav-title">
            <h1 class="title">Quiz  Builder</h1>
            <div class="nav-button">
                <button class="dark-mode-toggle" onclick="toggleDarkMode()">
                    <i id="theme-icon" class="fas fa-moon"></i>
                </button>
                <button class="button is-dark cta-button" onclick="onSave()">
                    Save
                </button>
            </div>
        </div>


        <div class="form-container">
            <div class="inner-form">
            <div id="question-list">
                <div class="field fields" id="meta-title">
                    <label class="label"><strong class="label"> Title <i class="count">1</i></strong></label>
                    <div class="">
                        <input class="input" type="text" placeholder="Enter your title" required>
                    </div>
                </div>
                <div class="field fields" id="meta-description">
                    <label class="label"><strong class="label">Description</strong></label>
                    <div class="">
                        <input class="input" type="text" placeholder="Enter your description" required>
                    </div>
                </div>
                
                <hr>
                <!-- Questions will be dynamically added here -->
                <div class="question-item" id="question-0">
                <div class="card" >
                    <div class="field" >
                        <label class="label"><h3> Question</h3></label>
                        <div class="control">
                            <input class="input" type="text" id="question-txt" placeholder="Enter your question" required>
                        </div>
                    </div>
                    <div class="field">
                        <label class="label">Answer Options</label>
                        <div class="control">
                            <div class="radio">
                                <input type="radio" name="option-0" id="1" checked/>
                                <input class="input is-small" type="text" placeholder="Enter your Options" id="t-1">
                            </div>
                            <div class="radio">
                                <input type="radio" name="option-0"  id="2"/>
                                <input class="input is-small" type="text" placeholder="Enter your Options" id="t-2">
                            </div>
                            <div class="radio">
                                <input type="radio" name="option-0"  id="3"/>
                                <input class="input is-small" type="text" placeholder="Enter your Options" id="t-3">
                            </div>
                            <div class="radio">
                                <input type="radio" name="option-0" id="4"/>
                                <input class="input is-small" type="text" placeholder="Enter your Options" id="t-4">
                            </div>
                        </div>
                    </div>
                    <div class="field is-grouped delete-answer-group">
                        <button class="delete-btn" onclick="deleteQuestion(0)">
                    <span class="icon">
                        <i class="fas fa-trash"></i>
                    </span>
                            Delete Question
                        </button>

                    </div>
                </div>
                <hr>
            </div>
            </div>
            <button class="button is-dark cta-button" onclick="addQuestion()">
                <span class="icon">
                    <i class="fas fa-plus"></i>
                </span>
                <span>Add Question</span>
            </button>
            </div>
        </div>
    </div>
</section>
<script>
    let questionCount = 1;

    function addQuestion() {
        questionCount++;
        const questionList = document.getElementById('question-list');
        const questionItem = document.createElement('div');
        questionItem.className = 'question-item';
        questionItem.id = `question-${questionCount}`;
        document.querySelector('.count').innerHTML = questionCount.toString();

        questionItem.innerHTML = `
        <div class="card">
            <div class="field">
                <label class="label"><h3> Question </h3></label>
                <div class="control">
                    <input class="input" type="text" id="question-txt" placeholder="Enter your question" required>
                </div>
            </div>
            <div class="field">
                <label class="label">Answer Options</label>
                <div class="control">
                    <div class="radio">
                        <input type="radio" id="1" name="option-${questionCount}" checked />
                        <input class="input is-small" id="t-1" type="text" placeholder="Enter your Options" required>
                     </div>
                     <div class="radio">
                        <input type="radio" name="option-${questionCount}"  />
                        <input class="input is-small" type="text" placeholder="Enter your Options" required>
                     </div>
                     <div class="radio">
                        <input type="radio" name="option-${questionCount}" />
                        <input class="input is-small" type="text" placeholder="Enter your Options" required>
                     </div>
                     <div class="radio">
                        <input type="radio"  name="option-${questionCount}" />
                        <input class="input is-small" type="text" placeholder="Enter your Options" required>
                     </div>
                </div>
            </div>
            <div class="field is-grouped delete-answer-group">
                <button class="delete-btn" onclick="deleteQuestion(${questionCount})">
                    <span class="icon">
                        <i class="fas fa-trash"></i>
                    </span>
                    Delete Question
                </button>

            </div>
            </div>
            <hr>
        `;

        questionList.appendChild(questionItem);
    }

    function deleteQuestion(questionId) {
        const questionItem = document.getElementById(`question-${questionId}`);
        questionItem.remove();
    }
    function toggleDarkMode() {
        const body = document.body;
        const themeIcon = document.getElementById('theme-icon');
        const currentTheme = body.getAttribute('data-theme');
        const newTheme = currentTheme === 'dark' ? '' : 'dark';

        body.setAttribute('data-theme', newTheme);
        themeIcon.className = newTheme === 'dark' ? 'fas fa-sun' : 'fas fa-moon';
    }
    let data = {};
    function onSave(){
        console.log("ss");
        const title = document.getElementById('meta-title').querySelector('input').value;
        const description = document.getElementById('meta-description').querySelector('input').value;
        if(title === '' || description === '' ){
            alert("Please fill all the fields");
            return;
        }
        const questionsElement = document.querySelectorAll('.question-item');
        const questions = [];
        questionsElement.forEach(question => {
            const questionTxt = question.querySelector('#question-txt').value;
            const options = [];
            const optionsElement = question.querySelectorAll('.radio');
            
            optionsElement.forEach(option => {
                const optionTxt = option.querySelector('.input').value;
                const isChecked = option.querySelector('input[type="radio"]').checked;
                options.push({optionTxt, isChecked});
            });

            questions.push({questionTxt, options});
        })
        const id = Math.random().toString(36).substring(2, 15) + Math.random().toString(36).substring(2, 15);
        console.log(id);
        data = {
            title,
            description,
            id,
            content:{
                questions
            }
        };
        fetch('/quiz_app_war_exploded/create-quiz', {
            method: 'POST',
            body: JSON.stringify({ data }), // Stringify the entire data object
            headers: {
                'Content-Type': 'application/json',
            },
        }).then(response => {
            window.location.href = '/quiz_app_war_exploded/dashboard.jsp';
        })
        console.log(data);
    }
</script>
</body>
</html>
