import 'package:flutter/material.dart';
import 'package:leet/main.dart';
import 'package:leet/models/post.dart';
import 'package:leet/views/profile.dart';
import 'package:leet/views/trending_cover.dart';
import 'package:leet/views/audioPost.dart';
import 'package:leet/views/imagepost.dart';
import 'package:leet/views/textpost.dart';
import 'package:leet/views/videopost.dart';
import 'package:tiktoklikescroller/tiktoklikescroller.dart';

class TrendingList extends StatefulWidget {
  List<Post> posts;

  TrendingList({this.posts});

  @override
  _TrendingListState createState() => _TrendingListState();
}

class _TrendingListState extends State<TrendingList> {
  @override
  void initState() {
    super.initState();
    widget.posts = widget.posts ?? [];
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return TikTokStyleFullPageScroller(
      contentSize: widget.posts.length,
      swipeThreshold: 0.1,
      // ^ the fraction of the screen needed to scroll
      swipeVelocityThreshold: 200,
      // ^ the velocity threshold for smaller scrolls
      animationDuration: const Duration(milliseconds: 60),
      // ^ how long the animation will take
      builder: (BuildContext context, int index) {
        if (widget.posts.isEmpty) {
          return Center(
            child: Blank(width: width),
          );
        }
        if (index == 0) {
          return TrendingCover(post: widget.posts[index], country: myCountry);
        }
        int type = widget.posts[index].type;
        int repost = widget.posts[index].is_repost;
        if (repost == 1) {
          if (type == 0) {
            return TextPost(
                post_id: widget.posts[index].id,
                author_id: widget.posts[index].author_id,
                author_name: widget.posts[index].author_name,
                fontFamily: widget.posts[index].font_type,
                textColor: widget.posts[index].color,
                comments_number: widget.posts[index].comments,
                reposter_id: widget.posts[index].reposter_id,
                reposter_name: widget.posts[index].reposter_name,
                reposts_number: widget.posts[index].reposts,
                profile_pic: widget.posts[index].author_pic,
                post_time: widget.posts[index].universal,
                text: widget.posts[index].body,
                is_repost: widget.posts[index].is_repost,
                loveLikes: widget.posts[index].loveLikes,
                laughLikes: widget.posts[index].laughLikes,
                hateLikes: widget.posts[index].hateLikes,
                views: widget.posts[index].views,
                can_reply: widget.posts[index].can_reply,
                isLoved: widget.posts[index].isLoved,
                isLaughed: widget.posts[index].isLaughed,
                isHated: widget.posts[index].isHated,
                isReposted: widget.posts[index].isReposted,
                is_ad: widget.posts[index].is_ad);
          }
          if (type == 1) {
            return ImagePost(
                post_id: widget.posts[index].id,
                author_id: widget.posts[index].author_id,
                author_name: widget.posts[index].author_name,
                caption: widget.posts[index].caption,
                link: widget.posts[index].location,
                name: widget.posts[index].name,
                comments_number: widget.posts[index].comments,
                reposter_id: widget.posts[index].reposter_id,
                reposter_name: widget.posts[index].reposter_name,
                reposts_number: widget.posts[index].reposts,
                profile_pic: widget.posts[index].author_pic,
                post_time: widget.posts[index].universal,
                is_repost: widget.posts[index].is_repost,
                loveLikes: widget.posts[index].loveLikes,
                laughLikes: widget.posts[index].laughLikes,
                hateLikes: widget.posts[index].hateLikes,
                views: widget.posts[index].views,
                can_reply: widget.posts[index].can_reply,
                can_download: widget.posts[index].can_download,
                isLoved: widget.posts[index].isLoved,
                isLaughed: widget.posts[index].isLaughed,
                isHated: widget.posts[index].isHated,
                isReposted: widget.posts[index].isReposted,
                is_ad: widget.posts[index].is_ad);
          }
          if (type == 2) {
            return AudioPost(
                post_id: widget.posts[index].id,
                author_id: widget.posts[index].author_id,
                author_name: widget.posts[index].author_name,
                caption: widget.posts[index].caption,
                audioLink: widget.posts[index].location,
                profilePic: widget.posts[index].author_pic,
                name: widget.posts[index].name,
                comments_number: widget.posts[index].comments,
                reposter_id: widget.posts[index].reposter_id,
                reposter_name: widget.posts[index].reposter_name,
                reposts_number: widget.posts[index].reposts,
                profile_pic: widget.posts[index].author_pic,
                post_time: widget.posts[index].universal,
                is_repost: widget.posts[index].is_repost,
                loveLikes: widget.posts[index].loveLikes,
                laughLikes: widget.posts[index].laughLikes,
                hateLikes: widget.posts[index].hateLikes,
                views: widget.posts[index].views,
                can_reply: widget.posts[index].can_reply,
                can_download: widget.posts[index].can_download,
                isLoved: widget.posts[index].isLoved,
                isLaughed: widget.posts[index].isLaughed,
                isHated: widget.posts[index].isHated,
                isReposted: widget.posts[index].isReposted,
                is_ad: widget.posts[index].is_ad);
          }
          if (type == 3) {
            return VideoPost(
                post_id: widget.posts[index].id,
                author_id: widget.posts[index].author_id,
                author_name: widget.posts[index].author_name,
                caption: widget.posts[index].caption,
                link: widget.posts[index].location,
                name: widget.posts[index].name,
                comments_number: widget.posts[index].comments,
                reposter_id: widget.posts[index].reposter_id,
                reposter_name: widget.posts[index].reposter_name,
                reposts_number: widget.posts[index].reposts,
                profile_pic: widget.posts[index].author_pic,
                post_time: widget.posts[index].universal,
                is_repost: widget.posts[index].is_repost,
                loveLikes: widget.posts[index].loveLikes,
                laughLikes: widget.posts[index].laughLikes,
                hateLikes: widget.posts[index].hateLikes,
                views: widget.posts[index].views,
                can_reply: widget.posts[index].can_reply,
                can_download: widget.posts[index].can_download,
                isLoved: widget.posts[index].isLoved,
                isLaughed: widget.posts[index].isLaughed,
                isHated: widget.posts[index].isHated,
                isReposted: widget.posts[index].isReposted,
                is_ad: widget.posts[index].is_ad);
          }
        }

        if (type == 0) {
          return TextPost(
              post_id: widget.posts[index].id,
              author_id: widget.posts[index].author_id,
              author_name: widget.posts[index].author_name,
              fontFamily: widget.posts[index].font_type,
              textColor: widget.posts[index].color,
              comments_number: widget.posts[index].comments,
              reposter_id: widget.posts[index].reposter_id,
              reposter_name: widget.posts[index].reposter_name,
              reposts_number: widget.posts[index].reposts,
              profile_pic: widget.posts[index].author_pic,
              post_time: widget.posts[index].universal,
              text: widget.posts[index].body,
              is_repost: widget.posts[index].is_repost,
              can_reply: widget.posts[index].can_reply,
              loveLikes: widget.posts[index].loveLikes,
              laughLikes: widget.posts[index].laughLikes,
              hateLikes: widget.posts[index].hateLikes,
              views: widget.posts[index].views,
              isLoved: widget.posts[index].isLoved,
              isLaughed: widget.posts[index].isLaughed,
              isHated: widget.posts[index].isHated,
              isReposted: widget.posts[index].isReposted,
              is_ad: widget.posts[index].is_ad);
        }
        if (type == 1) {
          return ImagePost(
              post_id: widget.posts[index].id,
              author_id: widget.posts[index].author_id,
              author_name: widget.posts[index].author_name,
              caption: widget.posts[index].caption,
              link: widget.posts[index].location,
              name: widget.posts[index].name,
              comments_number: widget.posts[index].comments,
              reposter_id: widget.posts[index].reposter_id,
              reposter_name: widget.posts[index].reposter_name,
              reposts_number: widget.posts[index].reposts,
              profile_pic: widget.posts[index].author_pic,
              post_time: widget.posts[index].universal,
              is_repost: widget.posts[index].is_repost,
              loveLikes: widget.posts[index].loveLikes,
              laughLikes: widget.posts[index].laughLikes,
              hateLikes: widget.posts[index].hateLikes,
              views: widget.posts[index].views,
              can_reply: widget.posts[index].can_reply,
              can_download: widget.posts[index].can_download,
              isLoved: widget.posts[index].isLoved,
              isLaughed: widget.posts[index].isLaughed,
              isHated: widget.posts[index].isHated,
              isReposted: widget.posts[index].isReposted,
              is_ad: widget.posts[index].is_ad);
        }
        if (type == 2) {
          return AudioPost(
              post_id: widget.posts[index].id,
              author_id: widget.posts[index].author_id,
              author_name: widget.posts[index].author_name,
              caption: widget.posts[index].caption,
              audioLink: widget.posts[index].location,
              profilePic: widget.posts[index].author_pic,
              name: widget.posts[index].name,
              comments_number: widget.posts[index].comments,
              reposter_id: widget.posts[index].reposter_id,
              reposter_name: widget.posts[index].reposter_name,
              reposts_number: widget.posts[index].reposts,
              profile_pic: widget.posts[index].author_pic,
              post_time: widget.posts[index].universal,
              is_repost: widget.posts[index].is_repost,
              loveLikes: widget.posts[index].loveLikes,
              laughLikes: widget.posts[index].laughLikes,
              hateLikes: widget.posts[index].hateLikes,
              views: widget.posts[index].views,
              can_reply: widget.posts[index].can_reply,
              can_download: widget.posts[index].can_download,
              isLoved: widget.posts[index].isLoved,
              isLaughed: widget.posts[index].isLaughed,
              isHated: widget.posts[index].isHated,
              isReposted: widget.posts[index].isReposted,
              is_ad: widget.posts[index].is_ad);
        }
        if (type == 3) {
          return VideoPost(
              post_id: widget.posts[index].id,
              author_id: widget.posts[index].author_id,
              author_name: widget.posts[index].author_name,
              caption: widget.posts[index].caption,
              link: widget.posts[index].location,
              name: widget.posts[index].name,
              comments_number: widget.posts[index].comments,
              reposter_id: widget.posts[index].reposter_id,
              reposter_name: widget.posts[index].reposter_name,
              reposts_number: widget.posts[index].reposts,
              profile_pic: widget.posts[index].author_pic,
              post_time: widget.posts[index].universal,
              is_repost: widget.posts[index].is_repost,
              loveLikes: widget.posts[index].loveLikes,
              laughLikes: widget.posts[index].laughLikes,
              hateLikes: widget.posts[index].hateLikes,
              views: widget.posts[index].views,
              can_reply: widget.posts[index].can_reply,
              can_download: widget.posts[index].can_download,
              isLoved: widget.posts[index].isLoved,
              isLaughed: widget.posts[index].isLaughed,
              isHated: widget.posts[index].isHated,
              isReposted: widget.posts[index].isReposted,
              is_ad: widget.posts[index].is_ad);
        }
      },
    );
  }
}
