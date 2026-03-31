import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:terpiez/models/terpiez_type.dart';

class TerpiezDetailsScreen extends StatefulWidget {
  const TerpiezDetailsScreen({
    super.key,
    required this.terpiezType,
    required this.heroTag,
  });

  final TerpiezType terpiezType;
  final String heroTag;

  @override
  State<TerpiezDetailsScreen> createState() => _TerpiezDetailsScreenState();
}

class _TerpiezDetailsScreenState extends State<TerpiezDetailsScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(widget.terpiezType.name),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Stack(
              fit: StackFit.expand,
              children: [
                IgnorePointer(
                  child: CustomPaint(
                    painter: _DetailsBackgroundPainter(
                      progress: _controller.value,
                    ),
                  ),
                ),
                child!,
              ],
            );
          },
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isLandscape = constraints.maxWidth > constraints.maxHeight;

              return SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight - 48,
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 560),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.78),
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.45),
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x22000000),
                              blurRadius: 24,
                              offset: Offset(0, 16),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 28,
                            vertical: 32,
                          ),
                          // Switches between vertical and horizontal presentation
                          // so the details stay readable after rotation.
                          child: Flex(
                            direction:
                                isLandscape ? Axis.horizontal : Axis.vertical,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  right: isLandscape ? 28 : 0,
                                  bottom: isLandscape ? 0 : 24,
                                ),
                                child: Hero(
                                  tag: widget.heroTag,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primaryContainer,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(24),
                                      child: Icon(
                                        widget.terpiezType.icon,
                                        size: 96,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimaryContainer,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      widget.terpiezType.name,
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.w700,
                                          ),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      'A rare Terpiez encounter is active nearby.',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            color: Colors.black87,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _DetailsBackgroundPainter extends CustomPainter {
  const _DetailsBackgroundPainter({
    required this.progress,
  });

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final basePaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color.lerp(
            const Color(0xFFE8F6E8),
            const Color(0xFFDFF1FF),
            0.5 + 0.5 * math.sin(progress * math.pi * 2),
          )!,
          Color.lerp(
            const Color(0xFFF7F4DA),
            const Color(0xFFE9FFF6),
            0.5 + 0.5 * math.cos(progress * math.pi * 2),
          )!,
        ],
      ).createShader(rect);
    canvas.drawRect(rect, basePaint);

    _paintOrb(
      canvas,
      size,
      center: Offset(
        size.width * (0.18 + 0.08 * math.sin(progress * math.pi * 2)),
        size.height * (0.24 + 0.06 * math.cos(progress * math.pi * 2)),
      ),
      radius: size.shortestSide * 0.34,
      color: const Color(0x6647B36D),
    );
    _paintOrb(
      canvas,
      size,
      center: Offset(
        size.width * (0.78 + 0.05 * math.cos(progress * math.pi * 2.3)),
        size.height * (0.22 + 0.08 * math.sin(progress * math.pi * 2.1)),
      ),
      radius: size.shortestSide * 0.28,
      color: const Color(0x5556A8F5),
    );
    _paintOrb(
      canvas,
      size,
      center: Offset(
        size.width * (0.54 + 0.06 * math.sin(progress * math.pi * 1.7)),
        size.height * (0.78 + 0.05 * math.cos(progress * math.pi * 1.5)),
      ),
      radius: size.shortestSide * 0.32,
      color: const Color(0x55FFD166),
    );

    final wavePaint = Paint()
      ..color = const Color(0x22FFFFFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    for (var i = 0; i < 3; i++) {
      final path = Path();
      final yBase = size.height * (0.35 + i * 0.18);
      path.moveTo(0, yBase);
      for (double x = 0; x <= size.width; x += 12) {
        final y = yBase +
            math.sin((x / size.width) * math.pi * 2 + progress * math.pi * 4 + i) *
                10;
        path.lineTo(x, y);
      }
      canvas.drawPath(path, wavePaint);
    }
  }

  void _paintOrb(
    Canvas canvas,
    Size size, {
    required Offset center,
    required double radius,
    required Color color,
  }) {
    final orbPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          color,
          color.withValues(alpha: 0),
        ],
      ).createShader(
        Rect.fromCircle(center: center, radius: radius),
      );
    canvas.drawCircle(center, radius, orbPaint);
  }

  @override
  bool shouldRepaint(covariant _DetailsBackgroundPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
