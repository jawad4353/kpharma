import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';





class Myroute extends PageRouteBuilder{
  final Widget child;
  Random ob=new Random();
  var o,Random_element ,
      Directions=[AxisDirection.up,AxisDirection.down,AxisDirection.left,AxisDirection.right];

  Myroute(this.child):super(pageBuilder:(BuildContext, Animation , Animatio )=>child ){
    Random_element=ob.nextInt(4);
  }

  Duration get transitionDuration => Duration(milliseconds: 400);

  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    var T=Tween<Offset>(begin: Getoffset(Random_element),end: Offset.zero);
    var T1=Tween<double>(begin: 3.0,end: 1.0);
    return SlideTransition(
        child: child,
        position: animation.drive(T.chain(CurveTween(curve: Curves.bounceInOut))));
  }

  Offset Getoffset(Random_element){
    switch(Random_element) {
      case 0:
        o = Offset(0, -1);
        break;
      case 1:
        o = Offset(0, 1);
        break;
      case 2 :
        o = Offset(1, 0);
        break;
      case 3:
        o = Offset(-1, 0);
        break;
    }
    return o;
  }
}



