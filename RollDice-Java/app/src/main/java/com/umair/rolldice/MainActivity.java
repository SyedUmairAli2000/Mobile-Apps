package com.umair.rolldice;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;

import android.widget.Button;
import android.widget.ImageView;

import java.util.Random;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        int [] diceImage = {R.drawable.dice1,R.drawable.dice2,R.drawable.dice3,R.drawable.dice4,R.drawable.dice5,R.drawable.dice6};

        ImageView diceOne = findViewById(R.id.dice1);
        ImageView diceTwo = findViewById(R.id.dice2);
        Button btn = findViewById(R.id.rollDiceBtn);
        btn.setOnClickListener(v -> {

            Random rndObj = new Random();
            int randomNumber = rndObj.nextInt(6);
             diceOne.setImageResource(diceImage[randomNumber]);

             randomNumber = rndObj.nextInt(6);
             diceTwo.setImageResource(diceImage[randomNumber]);
        });
    }
}