import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:respi_track/custom_icons_icons.dart';

class GradientIcon extends StatelessWidget {
  GradientIcon(
      this.icon,
      this.size,
      this.gradient,
      this.title
      );

  final IconData icon;
  final double size;
  final Gradient gradient;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          ShaderMask(
            child: Icon(
              icon,
              size: size,
              color: Colors.white,
            ),
            shaderCallback: (Rect bounds) {
              final Rect rect = Rect.fromLTRB(0, 0, size * 0.9, size * 0.85);
              return gradient.createShader(rect);
            },
          ),
          SizedBox(
            height: 3,
          ),
          Text(title, style: TextStyle(color:Colors.white.withOpacity(0.6))),
        ]
    );
  }
}

class graphIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GradientIcon(
      CustomIcons.graph,
      27.0,
      LinearGradient(
        colors: <Color>[
          Colors.indigo,
          Colors.orange,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      "General",
    );
  }
}

class symptomIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GradientIcon(
      Icons.sick_outlined,
      27.0,
      LinearGradient(
        colors: <Color>[
          Colors.orange,
          Colors.indigo,
        ],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      ),
      "Symptom",
    );
  }
}

class routineIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GradientIcon(
      CustomIcons.inhalator__1_,
      27.0,
      LinearGradient(
        colors: <Color>[
          Colors.orange,
          Colors.orange,
        ],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      ),
      "Routine",
    );
  }
}

class acuteIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GradientIcon(
      CustomIcons.inhalator__1_,
      27.0,
      LinearGradient(
        colors: <Color>[
          Colors.indigo,
          Colors.indigo,
        ],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      ),
      "Acute",
    );
  }
}