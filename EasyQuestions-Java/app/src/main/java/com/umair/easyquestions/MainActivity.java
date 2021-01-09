package com.umair.easyquestions;

import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;

import android.annotation.SuppressLint;
import android.content.DialogInterface;
import android.os.Bundle;
import android.widget.Button;
import android.widget.ProgressBar;
import android.widget.TextView;
import android.widget.Toast;


public class MainActivity extends AppCompatActivity {
    Button trueBtn,falseBtn;
    TextView textQuestion, quizPoints;
    ProgressBar quizPB;

    int questionIndex;
    int quizQuestion;
    int userPoints;
    private QuizModel[] questions = new  QuizModel[]{

            new QuizModel(R.string.q1, true),
            new QuizModel(R.string.q2, true),
            new QuizModel(R.string.q3, true),
            new QuizModel(R.string.q4, true),
            new QuizModel(R.string.q5, false),
            new QuizModel(R.string.q6, false),
            new QuizModel(R.string.q7, true),
            new QuizModel(R.string.q8, false),
            new QuizModel(R.string.q9, true),
            new QuizModel(R.string.q10, false)
    };
           int userProgress = (int) Math.ceil(100/questions.length);

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        textQuestion = findViewById(R.id.textQuestions);
        quizPoints = findViewById(R.id.quizStats);
        quizPB = findViewById(R.id.answersPB);
        trueBtn = findViewById(R.id.trueAnswer);
        falseBtn = findViewById(R.id.falseAnswer);

        trueBtn.setOnClickListener(v -> {
            userResult(true);
            nextQuestion();

        });
        falseBtn.setOnClickListener(v -> {
            userResult(false);
            nextQuestion();
        });

        QuizModel q1 = questions[questionIndex];
        quizQuestion = q1.getQuestion();
        textQuestion.setText(quizQuestion);

    }
    //Display next question
    @SuppressLint("SetTextI18n")
    private  void  nextQuestion(){
        questionIndex = (questionIndex +1) % 10;

        if (questionIndex == 0){
            AlertDialog.Builder quizAlert = new AlertDialog.Builder(this);
            quizAlert.setCancelable(false);
            quizAlert.setTitle("You finished the Quiz !");
            quizAlert.setMessage("Your final score is:"+userPoints);
            quizAlert.setPositiveButton("Ok", (dialog, which) -> finish());
            quizAlert.show();
        }

        quizQuestion = questions[questionIndex].getQuestion();
        textQuestion.setText(quizQuestion);
        quizPB.incrementProgressBy(userProgress);
        quizPoints.setText(userPoints+ "/10");

    }
    //Show user Result
    private void userResult(boolean userScore){
        boolean currentQuestion = questions[questionIndex].isAnswer();

        if(currentQuestion == userScore){
            Toast.makeText(this, R.string.correctAnswerToast, Toast.LENGTH_SHORT).show();
            userPoints = userPoints + 1;
        }
        else {
            Toast.makeText(this, R.string.wrongAnswerToast, Toast.LENGTH_SHORT).show();
        }

    }
}