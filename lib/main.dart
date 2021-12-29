import 'package:flutter/material.dart';
import 'package:quiz_app/question.dart';
import 'package:quiz_app/quiz_bank.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => {runApp(const QuizApp())};

class QuizApp extends StatelessWidget {
  const QuizApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: SafeArea(child: QuizPage())),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}


class _QuizPageState extends State<QuizPage> {
  QuizBank quizBank = QuizBank();
  List<Icon> listIcon = [];

  void checkAns(bool userPickedAns){
    bool correctAns = quizBank.getQuestionAns();



    setState(() {

      if(quizBank.isFinished() == true){
        Alert(
          context:  context,
          title: 'Finished',
          desc: 'You\'ve reached the end of the quiz.',
        ).show();
        quizBank.reset();
        listIcon = [];
      }else{
        if(correctAns == userPickedAns){
          listIcon.add(Icon(Icons.check,color: Colors.green,));
        }else{
          listIcon.add(Icon(Icons.close,color: Colors.red,));
        }
        quizBank.getNextQuestion();
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children:<Widget> [
        Expanded(
          flex: 7,
          child: Center(

            child: Text(
              quizBank.getQuestionTitle(),
              style: TextStyle(
                fontSize: 22,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Expanded(

          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: FlatButton(
              color: Colors.green,

              child: Text("True",textAlign: TextAlign.center, style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold

              ),),
              onPressed: (){
                checkAns(true);
              },
            ),
          ),
        ),
        Expanded(

          child: Padding(
            padding: EdgeInsets.all(5),
            child: FlatButton(
              color: Colors.red,

              child: Text("False",textAlign: TextAlign.center, style: TextStyle(
                color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),),
              onPressed: (){
                checkAns(false);
              },

            ),
          ),
        ),
        Row(
          children: listIcon
        )


      ],
    );
  }
}
