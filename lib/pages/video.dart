import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Video extends StatefulWidget {
  Video({this.link, this.detalle});
  final String link;
  final String detalle;

  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
  YoutubePlayerController _controller;

  void runYoutubePlayer(){
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.link),
      flags: YoutubePlayerFlags(
        enableCaption: false,
        isLive: false,
        autoPlay: false,
      )
    );
  }

  @override
  void initState() { 
    runYoutubePlayer();
    super.initState();
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() { 
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller
      ),
      builder: (context, player){
        return Scaffold(
          backgroundColor: Colors.black87,
          appBar: AppBar(),
          body: Container(
            child: Column(
              children: <Widget>[
                player,
                SizedBox(height: 10.0),
                Text('Detalle:', style: TextStyle(color: Colors.white)),
                SizedBox(height: 10.0),
                Container(
                  width: 300,
                  height: 200,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white54
                  ),
                  child: Text(widget.detalle),
                )
              ],
            ),
          ),
        );
      }, 
    );
  }
}