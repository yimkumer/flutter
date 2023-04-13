import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:page_transition/page_transition.dart';
import 'package:practice/splash.dart';
import 'package:practice/first.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( MaterialApp(
    home: const Splash(),
    debugShowCheckedModeBanner: false,
    builder: EasyLoading.init(),
  ));
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..animationStyle = EasyLoadingAnimationStyle.scale
    ..maskType = EasyLoadingMaskType.black
    ..indicatorType = EasyLoadingIndicatorType.cubeGrid
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 60.0
    ..radius = 10.0
    ..userInteractions = true
    ..dismissOnTap = false;
}

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();

}

class _homeState extends State<home> {


  Timer? _timer;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
    overlays: [SystemUiOverlay.top],
    );
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    super.initState();
  }

  int num = 0;
  bool click = true;

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            "BEGINNING",
            style: TextStyle(
                fontSize: 40,
                letterSpacing: 4,
                color: Colors.redAccent,
                fontFamily: 'stencil',
            ),
            textAlign: TextAlign.left,
          ),
          elevation: 0,
          backgroundColor: const Color(0xFF001930),
          toolbarHeight: 60.2,
          toolbarOpacity: 0.9,
          actions: [
            IconButton(
                onPressed: (){
                  Navigator.pushAndRemoveUntil(context, PageTransition(
                      type: PageTransitionType.rightToLeftWithFade,
                      childCurrent: widget,
                      duration: const Duration(milliseconds: 600),
                      reverseDuration: const Duration(milliseconds: 600),
                      child: const first()) , (r) => false );
                },
                iconSize: 40,
                icon: Image.asset('assets/arrow-right.png')),
          ],
        ),
        body:Container(
          decoration:  const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xFF204E65),
              Color(0xFF192138),
            ],
              stops: [
                0.02,
                1.0,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children:  [
              FullScreenWidget(
                backgroundColor: Colors.black26,
                child: SizedBox(
                  height: 240,
                  width: 355,
                  child: Hero(
                    tag: "customBackground",
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Image.asset(
                        "assets/dog.jpg",
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),
              ),
               const Divider(
                height: 14,
                thickness: 2,
                color: Colors.blue,
              ),
              const Icon(Icons.ac_unit_sharp, color: Colors.yellowAccent, size: 30,),
      SizedBox(
      width: 340,
      height:50,
      child: DefaultTextStyle(
      style: const TextStyle(
          fontFamily: 'Gloss',
          fontSize: 18,
          letterSpacing: 3,
          color: Colors.yellowAccent,
      ),
      textAlign: TextAlign.center,
      child: AnimatedTextKit(
      animatedTexts: [
      TyperAnimatedText("Lady Elanor, stumbled across the 'Marianet of Hollow'",
            speed: const Duration(milliseconds: 90)
      ),
      ],
          displayFullTextOnTap: true,
          stopPauseOnTap: true,
      repeatForever: true,
      onTap: () {},
          ),
       ),
      ),
              const Icon(Icons.account_circle_outlined, color: Colors.orange, size: 30,),
              SizedBox(
                width: 340,
                height:50,
                child: DefaultTextStyle(
                  style: const TextStyle(
                    fontFamily: 'Gloss',
                    fontSize: 18,
                    letterSpacing: 3,
                    color: Colors.orange,
                  ),
                  textAlign: TextAlign.center,
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TyperAnimatedText("The 'Fallen Soul of Ember's', gaze soon began to follow",
                          speed: const Duration(milliseconds: 90)
                      ),
                    ],
                    displayFullTextOnTap: true,
                    stopPauseOnTap: true,
                    repeatForever: true,
                    onTap: () {},
                  ),
                ),
              ),
              const Icon(Icons.account_balance_outlined, color: Colors.blue, size: 30,),
              SizedBox(
                width: 340,
                height:50,
                child: DefaultTextStyle(
                  style: const TextStyle(
                    fontFamily: 'Gloss',
                    fontSize: 18,
                    letterSpacing: 3,
                    color: Colors.blue,
                  ),
                  textAlign: TextAlign.center,
                  child: AnimatedTextKit(
                    animatedTexts: [
                      FadeAnimatedText("'Is my life, worth the value of my Kingdom ?' ~ she asked"),
                    ],
                    repeatForever: true,
                    onTap: () {},
                  ),
                ),
              ),
              const Icon(Icons.add_alert_outlined, color: Colors.red, size: 30,),
              SizedBox(
                width: 340,
                height:90,
                child: DefaultTextStyle(
                  style: const TextStyle(
                    fontFamily: 'Soda',
                    fontSize: 19,
                    letterSpacing: 3,
                    color: Colors.red,
                  ),
                  textAlign: TextAlign.center,
                  child: AnimatedTextKit(
                    animatedTexts: [
                      FadeAnimatedText("He spoke'th no word, but swung his blade and the lady breath'ed her last"),
                    ],
                    repeatForever: true,
                    onTap: () {},
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.health_and_safety_outlined, color: Colors.white, size: 25,),
                  const SizedBox(width: 5,),
                  const Text("Counter :",
                    style: TextStyle(
                      fontFamily: 'Gloss',
                      fontSize: 30,
                      letterSpacing: 3,
                      color: Colors.white,
                    ),),
                  const SizedBox(width: 5,),
                  Text("$num",
                    style: const TextStyle(
                      fontSize: 25,
                      color: Colors.red,
                    ),),
                ],
              ),
            ],
          ),
        ),
        floatingActionButton: SizedBox(
          height: 70,
          width: 60,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: FloatingActionButton(
              backgroundColor: Colors.red,
              onPressed: () {
                setState(() {
                  final player = AudioPlayer();
                  player.play(AssetSource('interface.wav'));
                  num += 1;
                  click = !click;
                });
              },
              child: Icon((click == false)? Icons.heart_broken_outlined: Icons.favorite_border, color: Colors.white, size: 45,)
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}




