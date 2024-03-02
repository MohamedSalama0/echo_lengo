import 'package:flutter/material.dart';
import 'package:learning_letters_easy/presentation/shared_widgets/static_letters.dart';
import 'package:video_player/video_player.dart';

class ContentScreen extends StatefulWidget {
  const ContentScreen({super.key, this.isEnglish = true});
  final bool isEnglish;

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  late final PageController _pageController = PageController();
  static const String enVidPath = 'assets/videos/en';
  static const String arVidPath = 'assets/videos/ar';
  List<String> paths = [];
  @override
  void initState() {
    super.initState();
    paths = letters();
  }

  List<String> letters() {
    List<String> paths = [];
    if (widget.isEnglish) {
      for (String letter in lettersEnglish) {
        paths.add('$enVidPath/$letter.mp4');
      }
    }
    for (int letter =1; letter<=28; letter++) {
      paths.add('$arVidPath/ar$letter.mp4');
    }
    return paths;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_rounded, color: Colors.white)),
      ),
      body: PageView(
        controller: _pageController,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        children: [
          ...List.generate(
            paths.length,
            (i) => Stack(
              alignment: AlignmentDirectional.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                VideoSection(vid: paths[i]),
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: 12,
                    bottom: 25,
                    end: 12,
                  ),
                  child: Align(
                    alignment: widget.isEnglish
                        ? AlignmentDirectional.centerStart
                        : AlignmentDirectional.centerEnd,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.isEnglish
                              ? 'English Alpha${i + 1}'
                              : 'حرف رقم${i + 1}',
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          widget.isEnglish
                              ? 'English Lesson no*${i + 1}'
                              : 'درس رقم ${i + 1}',
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class VideoSection extends StatefulWidget {
  const VideoSection({super.key, required this.vid});

  final String vid;
  @override
  State<VideoSection> createState() => _VideoSectionState();
}

class _VideoSectionState extends State<VideoSection> {
  late VideoPlayerController _controller;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    _controller = VideoPlayerController.asset(widget.vid)
      ..initialize().then((_) {
        setState(() {
          loading = false;
        });
        // _controller.setLooping(true);
        setState(() {
          if (_controller.value.isPlaying && _controller.value.isCompleted) {
            _controller.pause();
          } else {
            _controller.play();
          }
        });
      });
    // });
  }

  @override
  void dispose() {
    _controller.dispose();
    print('dispose');
    super.dispose();
  }

  @override
  void deactivate() {
    print('deactivate');
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: !loading && _controller.value.isInitialized
          ? InkWell(
              onTap: () {
                if (_controller.value.isPlaying) {
                  _controller.pause();
                } else {
                  _controller.play();
                }
              },
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(
                  _controller,
                ),
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
