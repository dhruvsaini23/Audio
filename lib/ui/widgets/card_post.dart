import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:social_media_app/app/configs/colors.dart';
import 'package:social_media_app/app/configs/theme.dart';
import 'package:social_media_app/app/resources/constant/named_routes.dart';
import 'package:social_media_app/data/post_model.dart';
import 'package:social_media_app/ui/widgets/custom_bottom_sheet_comments.dart';

import 'clip_status_bar.dart';

class CardPost extends StatelessWidget {
  final PostModel post;

  const CardPost({required this.post, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      margin: const EdgeInsets.only(bottom: 24),
      child: Stack(
        children: [
          _buildImageCover(),
          _buildImageGradient(),
          Positioned(
            height: 375,
            width: 85,
            right: 0,
            top: 25,
            child: Transform.rotate(
              angle: 3.14,
              child: ClipPath(
                clipper: ClipStatusBar(),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: ColoredBox(
                    color: AppColors.whiteColor.withOpacity(0.3),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 75,
            right: 20,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                ..._itemStatus(
                    "assets/images/like_button.png", post.like, context),
                const SizedBox(height: 10),
                ..._itemStatus(
                    "assets/images/ic_message.png", post.comment, context)
              ],
            ),
          ),
          _buildItemPublisher(context),
          Row(
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Row(
                  children: [
                    const SizedBox(width: 15),
                    const Icon(Icons.play_circle_fill, color: Colors.black45, size: 50),
                    const SizedBox(width: 2),
                    Image.asset("assets/images/sound_wave.png", width: 300),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Align _buildImageGradient() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 230,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.2),
              Colors.black.withOpacity(0.6),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildImageCover() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.brown,
        borderRadius: BorderRadius.circular(30),
    )
    );
      /*Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            post.picture,
          ),
        ),
      ),
    ); */
  }

  Container _buildItemPublisher(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 18, right: 40, bottom: 110),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () =>
                Navigator.of(context).pushNamed(NamedRoutes.profileScreen),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    post.imgProfile,
                    width: 32,
                    height: 32,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  post.name,
                  style: AppTheme.whiteTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: AppTheme.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Look at how I sing!",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTheme.whiteTextStyle.copyWith(
              fontSize: 12,
              fontWeight: AppTheme.regular,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            post.hashtags.join(" "),
            style: AppTheme.whiteTextStyle.copyWith(
              color: AppColors.whiteColor,
              fontSize: 12,
              fontWeight: AppTheme.medium,
            ),
          ),
        ],
      ),
    );
  }

  _itemStatus(String icon, String text, BuildContext context) => [
        GestureDetector(
          onTap: icon == "assets/images/ic_message.png"
              ? () => customBottomSheetComments(context)
              : () {},
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: AppColors.whiteColor.withOpacity(0.5),
              borderRadius: BorderRadius.circular(30),
              image: DecorationImage(
                scale: 2.3,
                image: AssetImage(icon),
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          text,
          style: AppTheme.whiteTextStyle.copyWith(
            fontSize: 12,
            fontWeight: AppTheme.regular,
          ),
        ),
      ];
}
