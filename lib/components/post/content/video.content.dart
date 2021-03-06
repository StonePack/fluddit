import 'package:fluddit/bloc/index.dart';
import 'package:fluddit/components/index.dart';
import 'package:fluddit/widgets/conditional.widget.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:video_player/video_player.dart';

class VideoContent extends StatefulWidget {
  const VideoContent({
    Key? key,
    required this.constraints,
    required this.url,
  }) : super(key: key);

  final BoxConstraints constraints;
  final String url;

  @override
  _VideoContentState createState() => _VideoContentState();
}

class _VideoContentState extends State<VideoContent> {
  late VideoPlayerController _controller;
  bool isMuted = false;

  final ComponentController component = Get.find();

  @override
  void initState() {
    isMuted = GetStorage().read('autoMute');

    super.initState();
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then(
        (_) {
          setState(() {
            _controller.play();
            _controller.setVolume(isMuted ? 0 : 100);
            _controller.setLooping(true);
          });
        },
      );
  }

  void toggleMute() {
    setState(() => isMuted = !isMuted);
    _controller.setVolume(isMuted ? 0 : 100);
  }

  @override
  Widget build(BuildContext context) {
    return ConditionalWidget(
      condition: _controller.value.isInitialized,
      trueWidget: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: widget.constraints.maxHeight - 115,
            child: Center(
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _controller.value.isPlaying
                              ? _controller.pause()
                              : _controller.play();
                        });
                      },
                      icon: Icon(
                        _controller.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                      ),
                    ),
                    IconButton(
                      onPressed: toggleMute,
                      icon: Icon(
                        isMuted ? Icons.volume_off : Icons.volume_up,
                      ),
                    ),
                  ],
                ),
                VideoProgressIndicator(
                  _controller,
                  allowScrubbing: true,
                  colors: VideoProgressColors(
                    playedColor: Theme.of(context).primaryColor,
                  ),
                  padding: EdgeInsets.zero,
                ),
              ],
            ),
          )
        ],
      ),
      falseWidget: const LoadingIndicator(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
