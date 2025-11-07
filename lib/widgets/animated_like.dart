import 'package:flutter/material.dart';

class AnimatedLike extends StatefulWidget {
  final bool isLiked;
  const AnimatedLike({super.key, required this.isLiked});

  @override
  State<AnimatedLike> createState() => _AnimatedLikeState();
}

class _AnimatedLikeState extends State<AnimatedLike>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctr;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();

    _ctr = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    _scaleAnim = CurvedAnimation(
      parent: _ctr,
      curve: Curves.elasticOut,
    );

    // Start slightly scaled if already liked
    if (widget.isLiked) {
      _ctr.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(covariant AnimatedLike oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Only animate when like state changes
    if (widget.isLiked != oldWidget.isLiked) {
      if (!_ctr.isAnimating) {
        _ctr.forward(from: 0.0).then((_) => _ctr.reverse(from: 1.0));
      }
    }
  }

  @override
  void dispose() {
    _ctr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween(begin: 1.0, end: 1.2).animate(_scaleAnim),
      child: Icon(
        widget.isLiked ? Icons.favorite : Icons.favorite_border,
        color: widget.isLiked ? Colors.red : Colors.grey,
      ),
    );
  }
}
