import 'package:flutter/material.dart';

class ErrorPage extends StatefulWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ErrorPageState createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _imageAnimation;

  @override
  void initState() {
    super.initState();

    // Configura la animación
    _controller = AnimationController(vsync: this);
    final imageTween = Tween<double>(begin: 0, end: 1);
    const imageDuration = Duration(milliseconds: 500);
    const textDuration = Duration(milliseconds: 500);
    const imageCurve = Curves.easeInOut;

    _imageAnimation = imageTween.animate(
      CurvedAnimation(parent: _controller, curve: imageCurve),
    );

    _controller.duration = imageDuration + textDuration;
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Página no encontrada'),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Opacity(
              opacity: _imageAnimation.value,
              child: Image.asset(
                'assets/images/error.gif',
                height: 200,
              ),
            );
          },
        ),
      ),
    );
  }
}
