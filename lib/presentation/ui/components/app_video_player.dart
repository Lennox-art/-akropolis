import 'dart:io';

import 'package:akropolis/data/utils/duration_style.dart';
import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class CachedVideoPlayer extends StatefulWidget {
  final File file;
  final bool autoPlay;
  final bool showControls;
  final Function()? onComplete;

  const CachedVideoPlayer({
    super.key,
    required this.file,
    required this.autoPlay,
    this.showControls = false,
    this.onComplete,
  });

  @override
  State<CachedVideoPlayer> createState() => _CachedVideoPlayerState();
}

class _CachedVideoPlayerState extends State<CachedVideoPlayer> {
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;
  bool _isComplete = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    try {
      // Check cache and get the video file
      // Initialize the video player

      _videoController = VideoPlayerController.file(widget.file);
      await _videoController!.initialize();

      _chewieController = ChewieController(
        videoPlayerController: _videoController!,
        autoPlay: widget.autoPlay,
        looping: false,
        allowMuting: true,
        allowPlaybackSpeedChanging: true,
        showControls: widget.showControls,
      );
      _videoController!.addListener(() {
        if(_videoController!.value.isCompleted && !_isComplete) {
          _isComplete = true;
          widget.onComplete?.call();
        }

        if(_videoController!.value.isPlaying) {
          _isComplete = false;
        }
      });

      setState(() => _isLoading = false);
    } catch (e) {
      debugPrint("Error loading video: $e");
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_chewieController == null || _videoController == null) {
      return const Center(child: Icon(Icons.error, size: 50, color: Colors.red));
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 300, // Fixed height
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: _videoController?.value.size.width ?? 0,
          height: _videoController?.value.size.height ?? 0,
          child: Chewie(
            controller: _chewieController!,
          ),
        ),
      ),
    );

  }
}

class VideoPlayerControls extends StatelessWidget {
  const VideoPlayerControls({
    required this.isPlaying,
    required this.progress,
    required this.videoDuration,
    required this.play,
    required this.pause,
    required this.onSeek,
    super.key,
  });

  final bool isPlaying;
  final Duration progress;
  final Duration videoDuration;
  final Function() play;
  final Function() pause;
  final Function(Duration) onSeek;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Slider(
            value: progress.inSeconds.toDouble(),
            min: 0,
            max: videoDuration.inSeconds.toDouble(),
            onChanged: (value) => onSeek(Duration(seconds: value.toInt())),
            inactiveColor: Colors.grey,
            activeColor: Colors.white,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Visibility(
                visible: isPlaying,
                replacement: IconButton(
                  onPressed: play,
                  icon: const Icon(Icons.play_arrow),
                ),
                child: IconButton(
                  onPressed: pause,
                  icon: const Icon(Icons.pause),
                ),
              ),
              Text(
                "${progress.format(DurationStyle.FORMAT_MM_SS)}/${videoDuration.format(DurationStyle.FORMAT_MM_SS)}",
              ),
            ],
          ),
        ],
      ),
    );
  }
}