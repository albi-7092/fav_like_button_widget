import 'package:flutter/material.dart';

class fav extends StatefulWidget {
  final VoidCallback callback;

  const fav({super.key, required this.callback});

  @override
  State<fav> createState() => _favState();
}

class _favState extends State<fav> with SingleTickerProviderStateMixin {
  bool isfinished = false;
  AnimationController? ctrl;
  Animation<Color?>? colorAnimaton;
  Animation<double>? sizeAnimation;

  @override
  void initState() {
    ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    ctrl!.addStatusListener((value) {
      setState(() {
        if (value == AnimationStatus.completed) {
          isfinished = true;
        } else {
          isfinished = false;
        }
      });
    });
    colorAnimaton = ColorTween(
      begin: const Color.fromARGB(255, 103, 89, 89),
      end: Colors.red,
    ).animate(ctrl!);

    sizeAnimation = TweenSequence([
      TweenSequenceItem(
        tween: Tween(begin: 50.0, end: 60.0)
            .chain(CurveTween(curve: Curves.easeInCirc)),
        weight: 30.0,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 60.0, end: 50.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50.0,
      ),
    ]).animate(ctrl!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: ctrl!,
      builder: (BuildContext context, child) {
        return GestureDetector(
          onTap: () {
            print('button clicked');
            if (isfinished == false) {
              ctrl!.forward();
            } else {
              ctrl!.reverse();
            }
          },
          child: Icon(
            Icons.favorite,
            color: colorAnimaton!.value,
            size: sizeAnimation!.value,
          ),
        );
      },
    );
  }
}
