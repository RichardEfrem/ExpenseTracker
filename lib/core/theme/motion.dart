import 'package:flutter/material.dart';

/// Motion tokens (DESIGN §4.6).
abstract final class Motion {
  static const screen = Duration(milliseconds: 300);
  static const containerTransform = Duration(milliseconds: 350);
  static const sheet = Duration(milliseconds: 300);
  static const countUp = Duration(milliseconds: 400);
  static const chartGrow = Duration(milliseconds: 500);
  static const rowCollapse = Duration(milliseconds: 200);
  static const saveCheck = Duration(milliseconds: 300);
  static const undoWindow = Duration(seconds: 5);

  static const emphasized = Curves.easeInOutCubicEmphasized;
  static const emphasizedDecelerate = Easing.emphasizedDecelerate;
  static const sheetSpring = SpringDescription(
    mass: 1,
    stiffness: 400,
    damping: 30,
  );
}

/// True when the system "Remove animations" setting is on; every animation
/// then jumps to its end state.
bool reduceMotion(BuildContext context) =>
    MediaQuery.maybeDisableAnimationsOf(context) ?? false;

/// [duration], or zero when [reduceMotion] is on.
Duration motionDuration(BuildContext context, Duration duration) =>
    reduceMotion(context) ? Duration.zero : duration;

/// M3 vertical shared-axis push: incoming page fades in while rising 30 dp,
/// outgoing page fades out while lifting.
class VerticalSharedAxisTransitionsBuilder extends PageTransitionsBuilder {
  const VerticalSharedAxisTransitionsBuilder();

  @override
  Duration get transitionDuration => Motion.screen;

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (reduceMotion(context)) return child;
    final enter = CurvedAnimation(parent: animation, curve: Motion.emphasized);
    final exit = CurvedAnimation(
      parent: secondaryAnimation,
      curve: Motion.emphasized,
    );
    return FadeTransition(
      opacity: Tween<double>(
        begin: 1,
        end: 0,
      ).animate(CurvedAnimation(parent: exit, curve: const Interval(0, 0.35))),
      child: SlideTransition(
        position: Tween(
          begin: Offset.zero,
          end: const Offset(0, -0.04),
        ).animate(exit),
        child: FadeTransition(
          opacity: CurvedAnimation(
            parent: enter,
            curve: const Interval(0.3, 1),
          ),
          child: SlideTransition(
            position: Tween(
              begin: const Offset(0, 0.04),
              end: Offset.zero,
            ).animate(enter),
            child: child,
          ),
        ),
      ),
    );
  }
}
