function render(data, title, description) {
    const container = document.querySelector('.form-container');
    container.innerHTML = '';
    const titleSection = document.createElement('div');
    titleSection.className = 'inner-form center-txt';

    titleSection.innerHTML = `
        <div class="card">
            <div  class="title centered">
                <h1 id="title">${title}</h1>
            </div>
        </div>
        <div class="card">
           <div class="label centered">
                <h3> ${description}</h3>
            </div>
        </div>
      <div class="card"><h1 class="lablel">ID</h1>
      <input class="input" type="text" id="id">
      </div>
      
    `;
    const questionList = document.createElement('div');
    questionList.id = 'question-list';

    data.content.questions.forEach((question, index) => {
        const questionItem = document.createElement('div');
        questionItem.className = 'question-item';
        questionItem.innerHTML = `
            <div class="card">
                <div class="field">
                    <label class="label"><h3>Question ${index + 1}</h3></label>
                    <div class="control">
                        <p class="label question-label">${question.questionTxt} </p>
                    </div>
                </div>
                <div class="field">
                    <label class="label">Answer Options</label>
                    <div class="control">
                        ${question.options
            .map(
                (option, optIndex) => `
                                    <div class="radio">
                                        <input type="radio" name="option-${index}" value="${option.optionTxt}">
                                        <input class="input is-small" type="text" value="${option.optionTxt}" disabled>
                                    </div>
                                `
            )
            .join('')}
                    </div>
                </div>
            </div>
            <hr>
        `;
        questionList.appendChild(questionItem);

    });
    titleSection.appendChild(questionList);
    container.appendChild(titleSection);

}
function collect(){
    const title = document.querySelector('#title').innerHTML;
    const  id = document.querySelector('#id').value;
    const url = window.location.href;

    // Create a URL object
    const urlObj = new URL(url);

    // Access the URLSearchParams object
    const params = urlObj.searchParams;

    const questionsItems = document.querySelectorAll('.question-item');
    const answers_data = {
        title,
        id,
        userid:params.get('userid'),
        quizid:params.get('quizid')
    }
    const  answers = [];
    questionsItems.forEach((item, index) => {
        const question = item.querySelector('.question-label').innerHTML;
        const answerVal = item.querySelector('input[type="radio"]:checked').value;
        const answer = {}
        answer[`question${index + 1}`] = {
            question,
            answer:answerVal
        }
        answers.push(answer);
    });
    answers_data.answers = {answers};
    console.log(answers_data);
    return answers_data;
}

function renderAnalytics(data) {
    const container = document.querySelector('.analytics-container');
    let no = 0; // Counter for numbering rows
    let indexs = []

    // Map through the answers array
    const tableRows = data.answers.map((item,index) => {
        if(indexs.length > 3) indexs = []
        indexs.push(index)

        return item.content.answers.map((a) => {
            // Extract the key for the question (e.g., question1)
            console.log(index);
            const questionKey = Object.keys(a)[0];
            const question = a[questionKey].question;
            const answer = a[questionKey].answer;
            const colorChoice = ["is-info","is-warning","is-success","is-danger"]
            no += 1; // Increment the counter for row number


            // Return the row HTML
            return `
                <tr >
                    <th >${no}</th>
                    <td >${item.title}</td>
                    <td >${question}</td>
                    <td >${answer}</td>
                    <td class=${colorChoice[indexs.length -1]}>${item.s_id}</td>
                </tr>
            `;
        }).join('');
    }).join('');

    // Set the inner HTML of the container
    container.innerHTML = `
        <table class="table card is-hoverable  is-fullwidth">
            <thead class="is-dark">
                <tr class="is-dark" >
                    <th ><abbr title="No.">No.</abbr></th>
                    <th >Title</th>
                    <th >Question</th>
                    <th>Answer</th>
                    <th ><abbr title="ID">ID</abbr></th>
                </tr>
            </thead>
            <tbody class="text-col">
                ${tableRows}
            </tbody>
        </table>
    `;
}
