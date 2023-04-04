import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({
    Key? key,
    this.width,
    this.height,
    this.borderRadius = 6,
    this.contentPadding,
    required this.imageProvider,
    this.tags,
    this.title,
    this.description,
    this.footer,
    this.color = Colors.white,
  }) : super(key: key);

  final double? width;
  final double? height;
  final double borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final ImageProvider imageProvider;
  final List<Widget>? tags;
  final Color color;
  final Widget? title;
  final Widget? description;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: color,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(borderRadius),
              topRight: Radius.circular(borderRadius),
            ),
            child: Image(
              image: imageProvider,
              width: width,
              height: height,
              fit: BoxFit.cover,
            ),
          ),
          if (title != null || description != null || tags != null || footer != null)
            Padding(
              padding: contentPadding ?? const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (title != null) ListTile(title: title),
                  if (description != null) ListTile(title: description),
                  if (tags != null)
                    Wrap(
                      spacing: 12,
                      runSpacing: 10,
                      children: tags!,
                    ),
                  if (footer != null) ListTile(title: footer),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
