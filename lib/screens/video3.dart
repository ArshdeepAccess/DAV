import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class VideoApp3 extends StatefulWidget {
  const VideoApp3({Key? key}) : super(key: key);
  @override
  _VideoApp3State createState() => _VideoApp3State();
}

class _VideoApp3State extends State<VideoApp3> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  bool _isPlaying = false;
  bool _isFullScreen = false;
  DeviceOrientation? preferredOrientation;
  Duration _currentPosition = Duration.zero;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://iafpensioners.gov.in/i/VIDEO/BRIEF_OFFICERS.mp4');
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.addListener(() {
      setState(() {
        _currentPosition = _controller.value.position;
      });
    });
  }
  String _formatDuration(Duration duration) {
    String hours = duration.inHours.toString().padLeft(2, '0');
    String minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    String seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return (duration.inHours > 0) ? '$hours:$minutes:$seconds' : '$minutes:$seconds';
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _playPause() async {
    if (_isPlaying) {
      await _controller.pause();
      setState(() {
        _isPlaying = false;
      });
    } else {
      await _controller.play();
      setState(() {
        _isPlaying = true;
      });
    }
  }

  Future<void> _seekBackward() async {
    final position = await _controller.position;
    final Duration backwardDuration = Duration(seconds: 10);
    final newPosition = position! - backwardDuration;
    if (newPosition.inMilliseconds < 0) {
      await _controller.seekTo(Duration.zero);
    } else {
      await _controller.seekTo(newPosition);
    }
  }

  Future<void> _seekForward() async {
    final position = await _controller.position;
    final Duration forwardDuration = Duration(seconds: 10);
    final newPosition = position! + forwardDuration;
    final duration = _controller.value.duration;
    if (newPosition >= duration!) {
      await _controller.seekTo(duration);
    } else {
      await _controller.seekTo(newPosition);
    }
  }

  Future<void> _toggleFullScreen() async {
    final bool isFullScreen = MediaQuery.of(context).orientation == Orientation.landscape;
    print(isFullScreen);
    print(MediaQuery.of(context).orientation);

    if (isFullScreen) {
      // Exit full screen mode
      preferredOrientation = null;
      setState(() {
        _isFullScreen = false;
      });
    } else {
      // Enter full screen mode
      final bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
      preferredOrientation = isPortrait ? DeviceOrientation.landscapeLeft : null;
      setState(() {
        _isFullScreen = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          if (preferredOrientation != null) {
            SystemChrome.setPreferredOrientations([preferredOrientation!]);
          } else {
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
              DeviceOrientation.portraitDown,
            ]);
          }
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: isPortrait ? AppBar(
              backgroundColor: Color(0xFFd3eaf2),
              title: Row(
                children: [
                  Image(
                    image: AssetImage("assets/images/dav-new-logo.png"),
                    fit: BoxFit.contain,
                    height: 60,
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('VAYU-SAMPARC'),
                  ),
                ],
              ),
            ) : null,
            body: FutureBuilder(
              future: _initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Column(
                    children: [
                      Expanded(
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Center(
                              child: AspectRatio(
                                aspectRatio: _controller.value.aspectRatio,
                                child: VideoPlayer(_controller),
                              ),
                            ),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: _seekBackward,
                                  icon: Icon(Icons.replay_10, color: Colors.white),
                                ),
                                IconButton(
                                  onPressed: _playPause,
                                  icon: Icon(
                                    _isPlaying ? Icons.pause : Icons.play_arrow,
                                    color: Colors.white,
                                  ),
                                ),
                                IconButton(
                                  onPressed: _seekForward,
                                  icon: Icon(Icons.forward_10, color: Colors.white),
                                ),
                                IconButton(
                                  onPressed: _toggleFullScreen,
                                  icon: Icon(
                                    _isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),

                            VideoProgressIndicator(
                              _controller,
                              allowScrubbing: true,
                              colors: VideoProgressColors(
                                playedColor: Colors.red,
                                backgroundColor: Colors.black,
                              ),
                              padding: EdgeInsets.only(top: 10.0),
                              // timeLabelTextStyle: TextStyle(color: Colors.white),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5.0),
                              child: Text(
                                '${_formatDuration(_currentPosition)} / ${_formatDuration(_controller.value.duration ?? Duration.zero)}',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          );
        });}
}

