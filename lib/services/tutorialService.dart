import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';


void showTutorial(List<TargetFocus> targets,context) {
    TutorialCoachMark tutorial = TutorialCoachMark(
      targets: targets , // List<TargetFocus>
      colorShadow: Color(int.parse("0xffA8A8A8")), // DEFAULT Colors.black
   
      onFinish: (){
        print("finish");
      },
      onClickTargetWithTapPosition: (target, tapDetails) {
      
      },
      onClickTarget: (target){
        
      },
      onSkip: (){
      
      }
    )..show(context:context);


  }