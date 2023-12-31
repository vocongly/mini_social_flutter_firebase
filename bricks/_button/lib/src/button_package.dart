import 'package:flutter/material.dart';

import 'base_button.dart';

class ButtonBrick {
  Widget base({
    required VoidCallback onPressed,
    required String content,
    double height = 48,
    required TextStyle textStyle,
    TextOverflow textOverflow = TextOverflow.ellipsis,
    int maxLines = 1,
    required Color contentColor,
    required Color backgroundColor,
    bool disable = false,
    required Color disableContentColor,
    required Color disableBackgroundColor,
    bool isBorder = false,
    double borderRadius = 16,
    double borderWidth = 1,
    Color? borderColor,
    List<BoxShadow>? boxShadow,
    String? preIconUrl,
    double iconSize = 24,
    bool isDirection = false,
    bool isFixedWidth = false,
    bool isExpandedContent = false,
    double betweenItemSpacing = 8,
    double horizontalPadding = 0,
    Alignment alignment = Alignment.center,
  }) {
    return BaseButton(
      onPressed: onPressed,
      content: content,
      height: height,
      textStyle: textStyle,
      textOverflow: textOverflow,
      maxLines: maxLines,
      contentColor: contentColor,
      backgroundColor: backgroundColor,
      disable: disable,
      disableContentColor: disableContentColor,
      disableBackgroundColor: disableBackgroundColor,
      isBorder: isBorder,
      borderRadius: borderRadius,
      borderWidth: borderWidth,
      borderColor: borderColor,
      boxShadow: boxShadow,
      preIconUrl: preIconUrl,
      iconSize: iconSize,
      isDirection: isDirection,
      isFixedWidth: isFixedWidth,
      isExpandedContent: isExpandedContent,
      horizontalPadding: horizontalPadding,
      betweenItemSpacing: betweenItemSpacing,
      alignment: alignment,
    );
  }

  Widget primary({
    required VoidCallback onPressed,
    required String content,
    double height = 48,
    required TextStyle textStyle,
    TextOverflow textOverflow = TextOverflow.ellipsis,
    int maxLines = 1,
    required Color contentColor,
    required Color backgroundColor,
    bool disable = false,
    required Color disableContentColor,
    required Color disableBackgroundColor,
    double borderRadius = 16,
    List<BoxShadow>? boxShadow,
    String? preIconUrl,
    double iconSize = 24,
    bool isDirection = false,
    bool isFixedWidth = false,
    bool isExpandedContent = false,
    double betweenItemSpacing = 8,
    double horizontalPadding = 0,
    Alignment alignment = Alignment.center,
  }) {
    return BaseButton(
      onPressed: onPressed,
      content: content,
      height: height,
      textStyle: textStyle,
      textOverflow: textOverflow,
      maxLines: maxLines,
      contentColor: contentColor,
      backgroundColor: backgroundColor,
      disable: disable,
      disableContentColor: disableContentColor,
      disableBackgroundColor: disableBackgroundColor,
      borderRadius: borderRadius,
      boxShadow: boxShadow,
      preIconUrl: preIconUrl,
      iconSize: iconSize,
      isDirection: isDirection,
      isFixedWidth: isFixedWidth,
      isExpandedContent: isExpandedContent,
      horizontalPadding: horizontalPadding,
      betweenItemSpacing: betweenItemSpacing,
      alignment: alignment,
    );
  }

  Widget secondary({
    required VoidCallback onPressed,
    required String content,
    double height = 48,
    required TextStyle textStyle,
    TextOverflow textOverflow = TextOverflow.ellipsis,
    int maxLines = 1,
    required Color contentColor,
    Color backgroundColor = Colors.transparent,
    bool disable = false,
    required Color disableContentColor,
    double borderRadius = 16,
    double borderWidth = 1,
    Color? borderColor,
    List<BoxShadow>? boxShadow,
    String? preIconUrl,
    double iconSize = 24,
    bool isDirection = false,
    bool isFixedWidth = false,
    bool isExpandedContent = false,
    double betweenItemSpacing = 8,
    double horizontalPadding = 0,
    Alignment alignment = Alignment.center,
  }) {
    return BaseButton(
      onPressed: onPressed,
      content: content,
      height: height,
      textStyle: textStyle,
      textOverflow: textOverflow,
      maxLines: maxLines,
      contentColor: contentColor,
      backgroundColor: backgroundColor,
      disable: disable,
      disableContentColor: disableContentColor,
      disableBackgroundColor: backgroundColor,
      isBorder: true,
      borderRadius: borderRadius,
      borderWidth: borderWidth,
      borderColor: borderColor,
      boxShadow: boxShadow,
      preIconUrl: preIconUrl,
      iconSize: iconSize,
      isDirection: isDirection,
      isFixedWidth: isFixedWidth,
      isExpandedContent: isExpandedContent,
      horizontalPadding: horizontalPadding,
      betweenItemSpacing: betweenItemSpacing,
      alignment: alignment,
    );
  }

  Widget text({
    required VoidCallback onPressed,
    required String content,
    double height = 48,
    required TextStyle textStyle,
    required Color contentColor,
    bool disable = false,
    required Color disableContentColor,
    List<BoxShadow>? boxShadow,
    bool isDirection = false,
    double betweenItemSpacing = 8,
    double horizontalPadding = 0,
    String? preIconUrl
  }) {
    return BaseButton(
      onPressed: onPressed,
      content: content,
      height: height,
      preIconUrl: preIconUrl,
      textStyle: textStyle,
      contentColor: contentColor,
      backgroundColor: Colors.transparent,
      disable: disable,
      disableContentColor: disableContentColor,
      disableBackgroundColor: Colors.transparent,
      isBorder: false,
      boxShadow: boxShadow,
      isDirection: isDirection,
      isFixedWidth: true,
      horizontalPadding: horizontalPadding,
      betweenItemSpacing: betweenItemSpacing,
    );
  }
}
