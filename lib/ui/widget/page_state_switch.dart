import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wan_android/config/resource_mananger.dart';

import 'skeleton.dart';

/// 结果页
/// 无数据  网络连接失败
enum PageStateType { error, empty, loading, content }

class PageStateLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}

class PageStateListSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    return SkeletonProfileCard();
    return SkeletonCardList(
      itemPadding: 5,
      hasImage: false,
    );
    return ListView(
      children: <Widget>[
        SkeletonCard(
          hasImage: false,
        ),
        SkeletonCard(
          isCircularImage: false,
        ),
        SkeletonCard(isBottomLinesActive: false),
        SkeletonCard(isBottomLinesActive: true),
      ],
    );
  }
}

class PageStateError extends StatelessWidget {
  final String message;
  final Widget image;
  final Widget buttonText;
  final VoidCallback onPressed;

  PageStateError(
      {this.image, this.message, this.buttonText, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          image ?? Icon(IconFonts.pageError, size: 80, color: Colors.grey[500]),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 150),
            child: Text(
              message ?? '加载失败',
              style: Theme.of(context)
                  .textTheme
                  .body1
                  .copyWith(color: Colors.grey),
            ),
          ),
          PageStateButton(
            child: buttonText,
            onPressed: onPressed,
          )
        ],
      ),
    );
  }
}

class PageStateEmpty extends PageStateError {
  PageStateEmpty(
      {image: const Icon(
        IconFonts.pageEmpty,
        size: 100,
        color: Colors.grey,
      ),
      message: "空空如也",
      buttonText,
      onPressed})
      : super(
            image: image,
            message: message,
            buttonText: buttonText,
            onPressed: onPressed);
}

class PageStateUnAuthorized extends PageStateError {
  PageStateUnAuthorized({
    image: const Icon(
      IconFonts.pageUnAuthorized,
      size: 100,
      color: Colors.grey,
    ),
    message: "未登录",
    buttonText: const Text('登录', style: TextStyle(letterSpacing: 5)),
    onPressed,
  }) : super(
            image: image,
            message: message,
            buttonText: buttonText,
            onPressed: onPressed);
}

class PageStateButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  const PageStateButton({@required this.onPressed, this.child});

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      child: child ??
          Text(
            '重试',
            style: TextStyle(letterSpacing: 5),
          ),
      textColor: Colors.grey,
      onPressed: onPressed,
      highlightedBorderColor: Theme.of(context).splashColor,
    );
  }
}