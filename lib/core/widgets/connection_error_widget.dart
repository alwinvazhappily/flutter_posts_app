import 'package:flutter/material.dart';
import 'package:flutter_posts_app/core/constants/typedef_constants.dart';

class ConnectionErrorWidget extends StatelessWidget {
  final BuildContext context;
  final String title;
  final String description;
  final Widget? button;
  final String? btnText;
  final VoidCallback press;

  const ConnectionErrorWidget({
    required this.context,
    this.title = 'Oops!',
    required this.description,
    this.button,
    this.btnText,
    required this.press,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: RC.w16 * RH.widthMultiplier!,
          vertical: RC.h8 * RH.heightMultiplier!,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.displayLarge,
            ),
            SizedBox(height: RC.h16 * RH.heightMultiplier!),
            Text(
              description,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: RC.h32 * RH.heightMultiplier!),
            button ??
                ElevatedButton(
                  onPressed: press,
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(
                        double.infinity,
                        RC.h48 * RH.heightMultiplier!,
                      ),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                        Radius.circular(RC.h8 * RH.heightMultiplier!),
                      ))),
                  child: Text(
                    btnText ?? "Retry".toUpperCase(),
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSecondary),
                  ),
                ),
            SizedBox(height: RC.h16 * RH.heightMultiplier!),
          ],
        ),
      ),
    );
  }
}
