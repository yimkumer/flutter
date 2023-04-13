import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'feedback.dart';
import 'first.dart';

class second extends StatefulWidget {
  const second({Key? key}) : super(key: key);


  @override
  State<second> createState() => _secondState();
}

class _secondState extends State<second> {

  final player = AudioPlayer();
  final player1 = AudioPlayer();
  final player2 = AudioPlayer();
  bool isPlaying = false;
  bool isPlaying1 = false;
  bool isPlaying2 = false;
  Duration duration=Duration.zero;
  Duration position=Duration.zero;
  Duration duration1=Duration.zero;
  Duration position1=Duration.zero;
  Duration duration2=Duration.zero;
  Duration position2=Duration.zero;

  String formatTime(int seconds) {
    return '${(Duration(seconds: seconds))}'.split('.')[0].padLeft(8, '0');
  }

  @override
  void initState() {
    super.initState();

    player.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

    player1.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying1 = state == PlayerState.playing;
      });
    });

    player2.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying2 = state == PlayerState.playing;
      });
    });

    player.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    player1.onDurationChanged.listen((newDuration) {
      setState(() {
        duration1 = newDuration;
      });
    });

    player2.onDurationChanged.listen((newDuration) {
      setState(() {
        duration2 = newDuration;
      });
    });

    player.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });

    player1.onPositionChanged.listen((newPosition) {
      setState(() {
        position1 = newPosition;
      });
    });

    player2.onPositionChanged.listen((newPosition) {
      setState(() {
        position2 = newPosition;
      });
    });

  }
  bool click = true;
  bool click1 =true;
  bool click2 =true;

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
            player.stop();
            player1.stop();
            player2.stop();
            Navigator.pushAndRemoveUntil(context, PageTransition(
                type: PageTransitionType.leftToRightWithFade,
                duration: const Duration(milliseconds: 600),
                reverseDuration: const Duration(milliseconds: 600),
                child: const first()) , (r) => false );
          },
              iconSize: 10,
              icon: Image.asset('assets/arrow-left.png')),
          backgroundColor: const Color(0xFF232c43),
          title: const Text(
            "END",
            style: TextStyle(
              fontFamily: 'stencil',
              fontSize: 34,
              letterSpacing: 2,
              color: Colors.white,
            ),
          ),
          elevation: 0,
          titleSpacing: 80,
          actions: [
            IconButton(
                onPressed: (){
                  player.stop();
                  player1.stop();
                  player2.stop();
                  Navigator.pushAndRemoveUntil(context, PageTransition(
                      type: PageTransitionType.rightToLeftWithFade,
                      childCurrent: widget,
                      duration: const Duration(milliseconds: 600),
                      reverseDuration: const Duration(milliseconds: 600),
                      child: const feedback()) , (r) => false );
                },
                iconSize: 40,
                icon: Image.asset('assets/arrow-right.png')),
          ],
        ),
        body: Container(
          decoration:  const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0xFF232c40),
                Color(0xFF353a5f),
              ],
                stops: [
                  0.4,
                  1.0,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )
          ),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 240,
                  width: 270,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(110),
                    child: Image.asset(
                      "assets/stars.jpg",
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                const Text("Artist : Benson Boone",
                style: TextStyle(
                  fontFamily: 'soda',
                  letterSpacing: 3,
                  fontSize: 28,
                  color: Colors.white,
                ),),
                const SizedBox(height: 18,),
                const Text("Song : In the Stars",
                  style: TextStyle(
                    fontFamily: 'soda',
                    letterSpacing: 3,
                    fontSize: 27,
                    color: Colors.white,
                  ),),
                const SizedBox(height: 20,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 26.5,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            backgroundColor: const Color(0xFFFF2E4C),
                            radius: 25,
                            child: IconButton(
                              icon: Icon((click == false)? Icons.favorite_sharp: Icons.favorite_border, color: Colors.white, size: 30,),
                              onPressed: (){
                                setState(() {
                                  click = !click;
                                  final player = AudioPlayer();
                                  player.play(AssetSource('pop.mp3'));
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 30,),
                        CircleAvatar(
                          radius: 26.5,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            backgroundColor: const Color(0xFFFF2E4C),
                            radius: 25,
                            child: IconButton(
                              color: Colors.white,
                              icon: Icon(
                                isPlaying ? Icons.pause : Icons.play_arrow,
                                size: 30,
                              ),
                              onPressed: (){
                                if(isPlaying)
                                {
                                  player.pause();
                                }
                                else{
                                  player.play(AssetSource('stars.mp3'));
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 30,),
                        CircleAvatar(
                          radius: 26.5,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            backgroundColor: const Color(0xFFFF2E4C),
                            radius: 25,
                            child: IconButton(
                              color: Colors.white,
                              icon:const Icon(
                                Icons.stop,
                                size: 30,
                              ),
                              onPressed: (){
                                player.stop();
                              },
                            ),
                          ),
                        ),

                      ],
                    ),
                    const SizedBox(height: 10,),
                    Slider(
                      activeColor: Colors.red,
                      min: 0,
                      max: duration.inSeconds.toDouble(),
                      value: position.inSeconds.toDouble(),
                      onChanged: (value) {
                        final position = Duration(seconds: value.toInt());
                        player.seek(position);
                        player.resume();
                      },
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(formatTime(position.inSeconds),
                            style: const TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                            ),),
                          Text(formatTime((duration - position).inSeconds),
                            style: const TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                            ),),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 18,
                      thickness: 3,
                      color: Colors.deepOrangeAccent,
                    ),
                    const Text('Lyrics',
                      style: TextStyle(
                        fontFamily: 'Soda',
                        letterSpacing: 3,
                        fontSize: 35,
                        color: Colors.orange,
                      ),),
                    const Divider(
                      height: 18,
                      thickness: 3,
                      color: Colors.deepOrangeAccent,
                    ),
                    SizedBox(
                      width: 350,
                      height:460,
                      child: DefaultTextStyle(
                        style: const TextStyle(
                          fontFamily: 'Bright',
                          fontSize: 20,
                          letterSpacing: 1,
                          color: Colors.white,
                          height: 1.9,
                        ),
                        textAlign: TextAlign.center,
                        child: AnimatedTextKit(
                          animatedTexts: [
                            TyperAnimatedText("I'm still holdin' on to everything that's dead and gone\n"
                                "I don't wanna say goodbye cause this one means forever\n"
                                "Now you're in the stars and six-feets never felt so far\n"
                                "Here I am alone between the heavens and the embers \n"
                                "Oh, it hurts so hard For a million different reasons \n"
                                "You took the best of my heart, Left the rest in pieces... ",
                              speed: const Duration(milliseconds: 120),
                            ),
                          ],
                          displayFullTextOnTap: true,
                          stopPauseOnTap: true,
                          repeatForever: true,
                          onTap: () {},
                        ),
                      ),
                    ),
                    const Divider(
                      height: 20,
                      thickness: 3,
                      color: Colors.deepOrangeAccent,
                    ),
                    SizedBox(
                      height: 240,
                      width:270,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(110),
                        child: Image.asset(
                          "assets/pic.jpg",
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    const Text("Artist : Arijit Singh",
                      style: TextStyle(
                        fontFamily: 'soda',
                        letterSpacing: 3,
                        fontSize: 28,
                        color: Colors.white,
                      ),),
                    const SizedBox(height: 15,),
                    const Text("Song : Kesariya",
                      style: TextStyle(
                        fontFamily: 'soda',
                        letterSpacing: 4,
                        fontSize: 27,
                        color: Colors.white,
                      ),),
                    const SizedBox(height: 20,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 26.5,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                backgroundColor: const Color(0xFFFF2E4C),
                                radius: 25,
                                child: IconButton(
                                  icon: Icon((click1 == false)? Icons.favorite_sharp: Icons.favorite_border, color: Colors.white, size: 30,),
                                  onPressed: (){
                                    setState(() {
                                      final player = AudioPlayer();
                                      player.play(AssetSource('pop.mp3'));
                                      click1 = !click1;
                                    });
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 30,),
                            CircleAvatar(
                              radius: 26.5,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                backgroundColor: const Color(0xFFFF2E4C),
                                radius: 25,
                                child: IconButton(
                                  color: Colors.white,
                                  icon: Icon(
                                    isPlaying1 ? Icons.pause : Icons.play_arrow,
                                    size: 30,
                                  ),
                                  onPressed: (){
                                    if(isPlaying1)
                                    {
                                      player1.pause();
                                    }
                                    else{
                                      player1.play(AssetSource('Kesariya.mp3'));
                                    }
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 30,),
                            CircleAvatar(
                              radius: 26.5,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                backgroundColor: const Color(0xFFFF2E4C),
                                radius: 25,
                                child: IconButton(
                                  color: Colors.white,
                                  icon:const Icon(
                                    Icons.stop,
                                    size: 30,
                                  ),
                                  onPressed: (){
                                    player1.stop();
                                  },
                                ),
                              ),
                            ),

                          ],
                        ),
                        const SizedBox(height: 10,),
                        Slider(
                          activeColor: Colors.red,
                          min: 0,
                          max: duration1.inSeconds.toDouble(),
                          value: position1.inSeconds.toDouble(),
                          onChanged: (value) {
                            final position = Duration(seconds: value.toInt());
                            player1.seek(position);
                            player1.resume();
                          },
                        ),
                        Container(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(formatTime(position1.inSeconds),
                                style: const TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                ),),
                              Text(formatTime((duration1 - position1).inSeconds),
                                style: const TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                ),),
                            ],
                          ),
                        ),
                        const Divider(
                          height: 18,
                          thickness: 3,
                          color: Colors.deepOrangeAccent,
                        ),
                        const Text('Lyrics',
                          style: TextStyle(
                            fontFamily: 'Soda',
                            letterSpacing: 3,
                            fontSize: 35,
                            color: Colors.orange,
                          ),),
                        const Divider(
                          height: 18,
                          thickness: 3,
                          color: Colors.deepOrangeAccent,
                        ),
                        SizedBox(
                          width: 350,
                          height:580,
                          child: DefaultTextStyle(
                            style: const TextStyle(
                              fontFamily: 'Bright',
                              fontSize: 20,
                              letterSpacing: 2,
                              color: Colors.white,
                              height: 2.0,
                            ),
                            textAlign: TextAlign.center,
                            child: AnimatedTextKit(
                              animatedTexts: [
                                TyperAnimatedText("Mujhko itna bataye koi..\nKaise tujhse dil na lagaye koi\n"
                            "Rabba ne tujhko banane mein\n"
                                    "Kardi hai husn ki khaali tijoriyan\nKajal ki siyahi se likhi Hai tune jaane\nKitno ki love storiyan\n"
                            "Kesariya tera ishq hai piya \nRang jaaun jo main hath lagaun\nDin beete saara teri fikr mein\nRain saari teri khair manaun, Kesariya tera....",
                                  speed: const Duration(milliseconds: 180),
                                ),
                              ],
                              displayFullTextOnTap: true,
                              stopPauseOnTap: true,
                              repeatForever: true,
                              onTap: () {},
                            ),
                          ),
                        ),
                        const Divider(
                          height: 0,
                          thickness: 3,
                          color: Colors.deepOrangeAccent,
                        ),
                        SizedBox(
                          height: 240,
                          width:270,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(110),
                            child: Image.asset(
                              "assets/arcadexmann.jpg",
                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        const Text("Artist : Duncan & Gajendra ",
                          style: TextStyle(
                            fontFamily: 'soda',
                            letterSpacing: 2,
                            fontSize: 28,
                            color: Colors.white,
                          ),),
                        const SizedBox(height: 15,),
                        const Text("Song :  Arcade X Mann mera",
                          style: TextStyle(
                            fontFamily: 'soda',
                            letterSpacing: 3,
                            fontSize: 27,
                            color: Colors.white,
                          ),),
                        const SizedBox(height: 20,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 26.5,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    backgroundColor: const Color(0xFFFF2E4C),
                                    radius: 25,
                                    child: IconButton(
                                      icon: Icon((click2 == false)? Icons.favorite_sharp: Icons.favorite_border, color: Colors.white, size: 30,),
                                      onPressed: (){
                                        setState(() {
                                          final player = AudioPlayer();
                                          player.play(AssetSource('pop.mp3'));
                                          click2 = !click2;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 30,),
                                CircleAvatar(
                                  radius: 26.5,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    backgroundColor: const Color(0xFFFF2E4C),
                                    radius: 25,
                                    child: IconButton(
                                      color: Colors.white,
                                      icon: Icon(
                                        isPlaying2 ? Icons.pause : Icons.play_arrow,
                                        size: 30,
                                      ),
                                      onPressed: (){
                                        if(isPlaying2)
                                        {
                                          player2.pause();
                                        }
                                        else{
                                          player2.play(AssetSource('arcadeXmannmera.mp3'));
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 30,),
                                CircleAvatar(
                                  radius: 26.5,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    backgroundColor: const Color(0xFFFF2E4C),
                                    radius: 25,
                                    child: IconButton(
                                      color: Colors.white,
                                      icon:const Icon(
                                        Icons.stop,
                                        size: 30,
                                      ),
                                      onPressed: (){
                                        player2.stop();
                                      },
                                    ),
                                  ),
                                ),

                              ],
                            ),
                            const SizedBox(height: 10,),
                            Slider(
                              activeColor: Colors.red,
                              min: 0,
                              max: duration2.inSeconds.toDouble(),
                              value: position2.inSeconds.toDouble(),
                              onChanged: (value) {
                                final position = Duration(seconds: value.toInt());
                                player2.seek(position);
                                player2.resume();
                              },
                            ),
                            Container(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(formatTime(position2.inSeconds),
                                    style: const TextStyle(
                                      fontSize: 24,
                                      color: Colors.white,
                                    ),),
                                  Text(formatTime((duration2 - position2).inSeconds),
                                    style: const TextStyle(
                                      fontSize: 24,
                                      color: Colors.white,
                                    ),),
                                ],
                              ),
                            ),
                            const Divider(
                              height: 18,
                              thickness: 3,
                              color: Colors.deepOrangeAccent,
                            ),
                            const Text('Lyrics',
                              style: TextStyle(
                                fontFamily: 'Soda',
                                letterSpacing: 3,
                                fontSize: 35,
                                color: Colors.orange,
                              ),),
                            const Divider(
                              height: 18,
                              thickness: 3,
                              color: Colors.deepOrangeAccent,
                            ),
                            SizedBox(
                              width: 350,
                              height:1000,
                              child: DefaultTextStyle(
                                style: const TextStyle(
                                  fontFamily: 'Bright',
                                  fontSize: 20,
                                  letterSpacing: 1,
                                  color: Colors.white,
                                  height: 2.0,
                                ),
                                textAlign: TextAlign.center,
                                child: AnimatedTextKit(
                                  animatedTexts: [
                                    TyperAnimatedText(
                                      "I'm afraid of all I am..\n"
                                          "My mind feels like a foreign land..\nSilence ringing inside my head..\n"
                                          "Please carry me, carry me, carry me home..\n"
                                          "I've spent all of the love I saved,\n"
                                        "We were always a losing game\n"
                                          "Small town boy in a big arcade\n"
                                          "I got addicted to a losing game\n\n"
                                          "Kabhi Mera tha par ab begana hai ye\n"
                                          "Deewana deewana samjhe na ho..\n"
                                          "Saari raat aahein bharta\n"
                                    "Pal pal yaadon me marta\n"
                                    "Maane na meri mann mera\n"
                                    "Thode thode hosh madhoshi si hai\n"
                                    "Neend behoshi si hai\n"
                                          "Aane kuch bhi na man mera\nKabhi mera tha par ab begana hai ye\nDeewana deewana samjhe na ho..",
                                      speed: const Duration(milliseconds: 130),
                                    ),
                                  ],
                                  displayFullTextOnTap: true,
                                  stopPauseOnTap: true,
                                  repeatForever: true,
                                  onTap: () {},
                                ),
                              ),
                            ),
                            const Divider(
                              height: 17,
                              thickness: 3,
                              color: Colors.deepOrangeAccent,
                            ),
                  ],
                ),
              ],
            ),
          ],
            ),
        ]),
      )
      ),
    ));
  }
}
