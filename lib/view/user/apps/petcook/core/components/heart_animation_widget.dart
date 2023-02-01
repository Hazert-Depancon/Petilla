import 'package:flutter/material.dart';

class HeartAnimatonWidget extends StatefulWidget {
  const HeartAnimatonWidget({
    super.key,
    required this.child,
    required this.isAnimating,
    this.duration = const Duration(milliseconds: 150),
    this.onEnd,
  });

  final Widget child;
  final bool isAnimating;
  final Duration duration;
  final VoidCallback? onEnd;

  @override
  State<HeartAnimatonWidget> createState() => _HeartAnimatonWidgetState();
}

class _HeartAnimatonWidgetState extends State<HeartAnimatonWidget> with SingleTickerProviderStateMixin {
  late AnimationController controller;

  late Animation<double> scale;

  @override
  void initState() {
    super.initState();
    final halfDuration = widget.duration.inMilliseconds ~/ 2;
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: halfDuration),
    );
    scale = Tween<double>(begin: 1, end: 1.2).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant HeartAnimatonWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isAnimating != oldWidget.isAnimating) {
      doAnimation();
    }
  }

  Future doAnimation() async {
    if (widget.isAnimating) {
      await controller.forward();
      await controller.reverse();
      await Future.delayed(const Duration(milliseconds: 400));

      if (widget.onEnd != null) {
        widget.onEnd!();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scale,
      child: widget.child,
    );
  }
}
