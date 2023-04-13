import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:page_transition/page_transition.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:practice/second.dart';
import 'main.dart';


class first extends StatefulWidget {
  const first({Key? key}) : super(key: key);

  
  @override
  State<first> createState() => _firstState();
}



class _firstState extends State<first> {

  @override
  void initState() {
    super.initState();
  }

  bool click = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: ()
              {
                Navigator.pushAndRemoveUntil(context, PageTransition(
                    type: PageTransitionType.leftToRightWithFade,
                    duration: const Duration(milliseconds: 600),
                    reverseDuration: const Duration(milliseconds: 600),
                    child: const home()) , (r) => false );
              },
              iconSize: 10,
              icon: Image.asset('assets/arrow-left.png')),
          backgroundColor: Colors.grey[800],
          toolbarHeight: 60.2,
          toolbarOpacity: 0.9,
          title:  const Text(
            "Middle",
            style: TextStyle(
              fontFamily: 'stencil',
              fontSize: 33,
              letterSpacing: 4,
              color: Colors.orangeAccent,
            ),
          ),
          elevation: 0,
          titleSpacing: 60,
          actions: [
            IconButton(
                onPressed: (){
                  Navigator.pushAndRemoveUntil(context, PageTransition(
                      type: PageTransitionType.rightToLeftWithFade,
                      childCurrent: widget,
                      duration: const Duration(milliseconds: 600),
                      reverseDuration: const Duration(milliseconds: 600),
                      child: const second()) , (r) => false );
                },
                iconSize: 40,
                icon: Image.asset('assets/arrow-right.png')),
          ],
        ),
        body: Container(
          decoration:  BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.brown.shade300,
                Colors.blueGrey.shade500,
                const Color(0xFF174B73),
              ],
                stops: const [
                  0.2,
                  0.48,
                  0.3,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )
          ),
          alignment: Alignment.center,
          child: Column(
            children: [
            FullScreenWidget(
            backgroundColor: Colors.brown[300],
            child: SizedBox(
              height: 200,
              child: Hero(
                tag: "customBackground",
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(66),
                  child: Image.asset(
                    "assets/books1.jpg",
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
          ),
              const Divider(
                height: 5,
                thickness: 3,
                color: Color(0xFFffb347),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(width: 10.0, height: 134),
                  const Text(
                    'Be',
                    style: TextStyle(fontSize: 45.0,
                    fontFamily: 'Gloss',
                    color: Color(0xFFffb347)),
                  ),
                  const SizedBox(width: 10.0, height: 10.0),
                  DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 40,
                      fontFamily: 'Gloss',
                    ),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        RotateAnimatedText('Driven',
                        textStyle: const TextStyle(
                          letterSpacing: 3,
                          fontFamily: 'Silly',
                          color: Colors.lightBlue,)
                        ),
                        RotateAnimatedText('Patient',
                            textStyle: const TextStyle(
                              letterSpacing: 3,
                              fontFamily: 'Soda',
                              color: Colors.lightBlue,)
                        ),
                        RotateAnimatedText('Determined',
                            textStyle: const TextStyle(
                              letterSpacing: 4,
                              fontFamily: 'stencil',
                              color: Colors.lightBlue,)
                        ),
                      ],
                      repeatForever: true,
                      onTap: () {},
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 5,
                thickness: 3,
                color: Colors.lightBlue,
              ),
              FullScreenWidget(
                backgroundColor: const Color(0xFF468FC0),
                child: SizedBox(
                  height: 230,
                  child: Hero(
                    tag: "customBackground",
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(66),
                      child: Image.asset(
                        "assets/temple.jpg",
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30,),
            ],
          ),
        ),
        floatingActionButton: SizedBox(
          height: 70,
          width: 60,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: FloatingActionButton(
                backgroundColor: Colors.blue,
                onPressed: () {
                  setState(() {
                    final player = AudioPlayer();
                    player.play(AssetSource('bell.mp3'));
                    click = !click;
                  });
                },
                child: Icon((click == false)? Icons.temple_hindu_sharp: Icons.temple_hindu_outlined, color: Colors.white, size: 45,),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,),
    );
  }
}
