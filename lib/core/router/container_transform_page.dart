import 'package:expense_tracker/core/constants/dimens.dart';
import 'package:expense_tracker/core/theme/motion.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Approximates the M3 container transform from the add FAB (DESIGN §4.6):
/// the screen grows out of the bottom-end corner while its corners square
/// off. Jumps straight in when animations are disabled.
class ContainerTransformPage<T> extends CustomTransitionPage<T> {
  ContainerTransformPage({required super.child, super.key})
    : super(
        transitionDuration: Motion.containerTransform,
        reverseTransitionDuration: Motion.screen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          if (reduceMotion(context)) return child;
          final curved = CurvedAnimation(
            parent: animation,
            curve: Motion.emphasized,
          );
          return AnimatedBuilder(
            animation: curved,
            child: child,
            builder: (context, child) {
              final t = curved.value;
              return FadeTransition(
                opacity: CurvedAnimation(
                  parent: animation,
                  curve: const Interval(0, 0.4),
                ),
                child: Transform.scale(
                  scale: 0.2 + 0.8 * t,
                  alignment: AlignmentDirectional.bottomEnd.resolve(
                    Directionality.of(context),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      Dimens.radiusFab * (1 - t) * 4,
                    ),
                    child: child,
                  ),
                ),
              );
            },
          );
        },
      );
}
