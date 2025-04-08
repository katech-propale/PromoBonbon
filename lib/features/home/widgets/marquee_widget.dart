import 'package:flutter/material.dart';

class MarqueeWidget extends StatefulWidget {
  final String text;
  final TextStyle textStyle;
  final double speed;
  final double pauseAfterRound;

  const MarqueeWidget({
    super.key,
    required this.text,
    required this.textStyle,
    this.speed = 60,
    this.pauseAfterRound = 1.0,
  });

  @override
  _MarqueeWidgetState createState() => _MarqueeWidgetState();
}

class _MarqueeWidgetState extends State<MarqueeWidget>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _animationController;
  double _containerWidth = 0;
  double _textWidth = 0;
  Duration _duration = const Duration(seconds: 20);

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _animationController = AnimationController(
      vsync: this,
      duration: _duration,
    );

    _animationController.addListener(() {
      _scrollToPosition();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculateWidths();
      _startAnimation();
    });
  }

  void _calculateWidths() {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: widget.text, style: widget.textStyle),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);

    _textWidth = textPainter.width;
    _containerWidth = context.size?.width ?? 300;

    // Ajuster la durée en fonction de la longueur du texte et de la vitesse
    _duration =
        Duration(milliseconds: (_textWidth * 1000 / widget.speed).round());
    _animationController.duration = _duration;

    setState(() {});
  }

  void _startAnimation() {
    _animationController.repeat();
  }

  void _scrollToPosition() {
    if (!_scrollController.hasClients) return;

    // Calculer la position basée sur l'animation
    final position = _animationController.value * (_textWidth + 50);

    // Défiler en continu
    if (position <= _textWidth + _containerWidth) {
      _scrollController.jumpTo(position);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _containerWidth,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: _scrollController,
        physics: const NeverScrollableScrollPhysics(),
        child: Row(
          children: [
            // Répéter le texte pour créer un effet continu
            Text(widget.text, style: widget.textStyle),
            const SizedBox(width: 50), // Espace entre les répétitions
            Text(widget.text, style: widget.textStyle),
          ],
        ),
      ),
    );
  }
}
