import 'package:flutter/material.dart';
import 'package:practice/firestore.dart';
import 'package:practice/main.dart';
import 'package:page_transition/page_transition.dart';
import 'package:video_player/video_player.dart';
import 'package:practice/second.dart';
import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class feedback extends StatefulWidget {
  const feedback({Key? key}) : super(key: key);

  @override
  State<feedback> createState() => _feedbackState();
}

class _feedbackState extends State<feedback> {

  final _controller = TextEditingController();
  final _controller1 = TextEditingController();


  final VideoPlayerController videoPlayerController =
  VideoPlayerController.asset("assets/drive.mp4");
  ChewieController? chewieController;

  final CollectionReference _feedbacks=
      FirebaseFirestore.instance.collection('feedbacks');
  late String name;
  late String feedback;

  @override
  void initState() {
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: 9 / 20,
      autoPlay: true,
      looping: true,
      autoInitialize: true,
      showControls: false,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller1.dispose();
    videoPlayerController.dispose();
    chewieController!.dispose();
    _controller.dispose();
    super.dispose();
  }

  bool click = true;
  bool _validate = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }

        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.black,
          body: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Expanded(
                  child: Chewie(
                    controller: chewieController!,
                  )),
              Container(color: Colors.black54),
              Positioned(
                top: 30,
                left: 10,
                height: 55,
                width: 55,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: IconButton(
                      onPressed: (){
                        Navigator.pushAndRemoveUntil(context, PageTransition(
                            type: PageTransitionType.leftToRightWithFade,
                            childCurrent: widget,
                            duration: const Duration(milliseconds: 600),
                            reverseDuration: const Duration(milliseconds: 600),
                            child: const second()) , (r) => false );
                      },
                      iconSize: 30,
                      icon: Image.asset('assets/arrow-left.png')),
                ),
              ),

              Positioned(
                top: 30,
                left: 160,
                height: 55,
                width: 55,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: IconButton(
                      onPressed: (){
                        Navigator.pushAndRemoveUntil(context, PageTransition(
                            type: PageTransitionType.fade,
                            childCurrent: widget,
                            duration: const Duration(milliseconds: 800),
                            reverseDuration: const Duration(milliseconds: 800),
                            child: const firestore()) , (r) => false );
                      },
                      iconSize: 30,
                      icon: Image.asset('assets/note.png')),
                ),
              ),

              Positioned(
                top: 30,
                right: 10,
                height: 55,
                width: 55,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: IconButton(
                      onPressed: (){
                        Navigator.pushAndRemoveUntil(context, PageTransition(
                            type: PageTransitionType.fade,
                            childCurrent: widget,
                            duration: const Duration(milliseconds: 600),
                            reverseDuration: const Duration(milliseconds: 600),
                            child: const home()) , (r) => false );
                      },
                      iconSize: 35,
                      icon: Image.asset('assets/home.png')),
                ),
              ),
              Center(
                child: Padding(
                  padding:  const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children:   <Widget>[
                      const SizedBox(
                        height: 95,
                      ),
                      const Text(
                        'Feedbacks\n\nShare your thoughts: ',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'travel',
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                          letterSpacing: 1,
                          height: 0.7,
                        ),
                      ),
                      const SizedBox(height: 30,),
                      TextField(

                        onChanged: (value){
                          name=value;
                        },
                        controller: _controller,

                        decoration: const InputDecoration(
                          hintText: 'Enter your name',
                          hintStyle: TextStyle(
                            fontFamily: 'travel',
                            color: Colors.white,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            borderSide: BorderSide(color: Colors.white, width: 1, strokeAlign: BorderSide.strokeAlignCenter,),
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
                          icon: Icon(Icons.account_circle_outlined, size: 35,),
                          iconColor: Colors.white,

                        ),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                      const SizedBox(height: 20,),
                      TextField(
                        onChanged: (value){
                          feedback=value;
                        },
                        controller: _controller1,
                        maxLength: 20,
                        maxLines: 2,
                        expands: false,
                        decoration: const InputDecoration(
                          hintText: "What's on your mind ?",
                          hintStyle: TextStyle(
                            letterSpacing: 0.4,
                            fontFamily: 'travel',
                            color: Colors.white,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            borderSide: BorderSide(color: Colors.white, width: 1, strokeAlign: BorderSide.strokeAlignCenter,),
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
                          icon: Icon(Icons.edit_note_sharp, size: 40,),
                          iconColor: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      SizedBox(
                          width: double.maxFinite,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                            ),
                            onPressed: () async{
                              if(_controller.text.isEmpty ? _validate = true : _validate = false || _controller1.text.isEmpty ? _validate = true : _validate = false)
                                {

                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const AlertDialog(
                                          backgroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(40.0)),
                                            side: BorderSide(color: Colors.red),
                                          ),
                                          alignment: Alignment.center,
                                          icon: Icon(Icons.thumb_down_off_alt_outlined),
                                          iconColor: Colors.red,
                                          title: Text('Error!',
                                            style: TextStyle(
                                              fontFamily: 'Gloss',
                                              color: Colors.red,
                                              letterSpacing: 3,
                                              fontSize: 30,
                                            ),),
                                          content: Text('Please fill up both the fields to submit',
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.orange,
                                              letterSpacing: 1,
                                              fontFamily: 'Gloss',
                                            ),),
                                        );
                                      });
                                }
                              else {
                                EasyLoading.show(status: 'Uploading to Firebase');
                                await _feedbacks.add({
                                "name": name,
                                "feedback": feedback,
                              }).then((value) {
                                  EasyLoading.dismiss();
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const AlertDialog(
                                          backgroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(40.0)),
                                            side: BorderSide(color: Colors.blue),
                                          ),
                                          alignment: Alignment.center,
                                          icon: Icon(Icons.thumb_up_alt_outlined),
                                          iconColor: Colors.blue,
                                          title: Text('Success!',
                                            style: TextStyle(
                                              fontFamily: 'Gloss',
                                              color: Colors.blue,
                                              letterSpacing: 3,
                                              fontSize: 30,
                                            ),),
                                          content: Text('Your feedback has been recorded',
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.cyan,
                                              letterSpacing: 1,
                                              fontFamily: 'Gloss',
                                            ),),
                                        );
                                      });
                                }

                              );
                                _controller.clear();
                                _controller1.clear();
                              }
                            },
                            child: const Text(
                              'Submit Feedback',
                              style: TextStyle(
                                fontFamily: 'Gloss',
                                fontSize: 27,
                                color: Colors.white,
                                letterSpacing: 0.5,
                              ),
                            ),
                          )),
                      SizedBox(
                        width: double.maxFinite,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                          onPressed: () {
                            _controller.clear();
                            _controller1.clear();
                          },
                          child: const Text(
                            'Reset text fields',
                            style: TextStyle(
                              fontFamily: 'Gloss',
                              fontSize: 27,
                              color: Colors.black87,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 50)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}