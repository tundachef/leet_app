import '../env.dart';

class Post {
  final String id;
  final String views;
  final String reposts;
  final String comments;
  final int type;
  final String universal;
  final int is_ad;
  final String author_id;
  final String author_name;
  final String author_pic;
  final int is_reply;
  final String reply_to_post_id;
  final String reply_to_user_name;
  final String loveLikes;
  final String laughLikes;
  final String hateLikes;
  String body;
  int color;
  int can_download;
  int can_reply;
  String font_type;
  final int is_repost;
  String location;
  String caption;
  String reposter_id;
  String reposter_name;
  int adult_content;
  String name;
  int isLoved;
  int isReposted;
  int isLaughed;
  int isHated;

  Post(
      {this.id,
      this.views,
      this.reposts,
      this.comments,
      this.type,
      this.universal,
      this.isHated,
      this.isLaughed,
      this.isLoved,
      this.isReposted,
      this.can_download,
      this.can_reply,
      this.is_ad,
      this.author_id,
      this.author_name,
      this.author_pic,
      this.is_reply,
      this.is_repost,
      this.loveLikes,
      this.laughLikes,
      this.hateLikes,
      this.font_type,
      this.name,
      this.adult_content,
      this.body,
      this.caption,
      this.color,
      this.location,
      this.reposter_id,
      this.reposter_name,
      this.reply_to_post_id,
      this.reply_to_user_name});

  factory Post.fromJson(Map<String, dynamic> json) {
    int isrepost = int.parse(json['is_repost']);
    // print('isrepost $isrepost type is ${isrepost.runtimeType.toString()}');
    int post_type = int.parse(json['type']);
    // print('post $post_type type is ${post_type.runtimeType.toString()}');

    if (isrepost == 1) {
      //
      if (post_type == 0) {
        //text
        return Post(
            is_repost: int.parse(json['is_repost']),
            is_ad: int.parse(json['is_ad']),
            is_reply: int.parse(json['is_reply']),
            author_id: json['author_id'],
            author_name: json['author_name'],
            author_pic: '$media_url${json['author_pic']}',
            universal: json['universal'].toString(),
            views: json['views'].toString(),
            reposts: json['reposts'].toString(),
            comments: json['replies'].toString(),
            type: int.parse(json['type']),
            reply_to_post_id: json['reply_to_post_id'],
            reply_to_user_name: json['reply_to_post_name'],
            body: json['body'],
            color: int.parse(json['color']),
            font_type: json['font_type'],
            can_reply: int.parse(json['can_reply']),
            id: json['id'],
            isReposted: int.parse(json['isReposted']),
            isLoved: int.parse(json['isLoved']),
            isLaughed: int.parse(json['isLaughed']),
            isHated: int.parse(json['isHated']),
            loveLikes: json['love_likes'].toString(),
            laughLikes: json['laugh_likes'].toString(),
            hateLikes: json['hate_likes'].toString(),
            reposter_id: json['reposter_id'],
            reposter_name: json['reposter_name']);
      }

      if (post_type == 1) {
        //images
        return Post(
            is_repost: int.parse(json['is_repost']),
            is_ad: int.parse(json['is_ad']),
            is_reply: int.parse(json['is_reply']),
            author_id: json['author_id'],
            author_name: json['author_name'],
            author_pic: '$media_url${json['author_pic']}',
            universal: json['universal'],
            views: json['views'].toString(),
            reposts: json['reposts'].toString(),
            comments: json['replies'].toString(),
            type: int.parse(json['type']),
            can_reply: int.parse(json['can_reply']),
            can_download: int.parse(json['can_download']),
            reply_to_post_id: json['reply_to_post_id'],
            reply_to_user_name: json['reply_to_post_name'],
            caption: json['caption'],
            location: '$media_url${json['location']}',
            id: json['id'],
            name: json['name'],
            isReposted: int.parse(json['isReposted']),
            isLoved: int.parse(json['isLoved']),
            isLaughed: int.parse(json['isLaughed']),
            isHated: int.parse(json['isHated']),
            loveLikes: json['love_likes'].toString(),
            laughLikes: json['laugh_likes'].toString(),
            hateLikes: json['hate_likes'].toString(),
            reposter_id: json['reposter_id'],
            adult_content: int.parse(json['adult_content']),
            reposter_name: json['reposter_name']);
      }

      if (post_type == 2) {
        //audio
        return Post(
            is_repost: int.parse(json['is_repost']),
            is_ad: int.parse(json['is_ad']),
            is_reply: int.parse(json['is_reply']),
            author_id: json['author_id'],
            author_name: json['author_name'],
            author_pic: '$media_url${json['author_pic']}',
            universal: json['universal'],
            views: json['views'].toString(),
            reposts: json['reposts'].toString(),
            comments: json['replies'].toString(),
            type: int.parse(json['type']),
            can_reply: int.parse(json['can_reply']),
            can_download: int.parse(json['can_download']),
            reply_to_post_id: json['reply_to_post_id'],
            reply_to_user_name: json['reply_to_post_name'],
            caption: json['caption'],
            location: '$media_url${json['location']}',
            id: json['id'],
            name: json['name'],
            isReposted: int.parse(json['isReposted']),
            isLoved: int.parse(json['isLoved']),
            isLaughed: int.parse(json['isLaughed']),
            isHated: int.parse(json['isHated']),
            loveLikes: json['love_likes'].toString(),
            laughLikes: json['laugh_likes'].toString(),
            hateLikes: json['hate_likes'].toString(),
            reposter_id: json['reposter_id'],
            reposter_name: json['reposter_name']);
      }

      if (post_type == 3) {
        //video
        return Post(
            is_repost: int.parse(json['is_repost']),
            is_ad: int.parse(json['is_ad']),
            is_reply: int.parse(json['is_reply']),
            author_id: json['author_id'],
            author_name: json['author_name'],
            author_pic: '$media_url${json['author_pic']}',
            universal: json['universal'],
            views: json['views'].toString(),
            reposts: json['reposts'].toString(),
            comments: json['replies'].toString(),
            type: int.parse(json['type']),
            can_reply: int.parse(json['can_reply']),
            can_download: int.parse(json['can_download']),
            reply_to_post_id: json['reply_to_post_id'],
            reply_to_user_name: json['reply_to_post_name'],
            caption: json['caption'],
            location: '$media_url${json['location']}',
            adult_content: int.parse(json['adult_content']),
            id: json['id'],
            name: json['name'],
            isReposted: int.parse(json['isReposted']),
            isLoved: int.parse(json['isLoved']),
            isLaughed: int.parse(json['isLaughed']),
            isHated: int.parse(json['isHated']),
            loveLikes: json['love_likes'].toString(),
            laughLikes: json['laugh_likes'].toString(),
            hateLikes: json['hate_likes'].toString(),
            reposter_id: json['reposter_id'],
            reposter_name: json['reposter_name']);
      }
    }

    //NOT A REPOST
    if (post_type == 0) {
      //text
      return Post(
        is_repost: int.parse(json['is_repost']),
        is_ad: int.parse(json['is_ad']),
        is_reply: int.parse(json['is_reply']),
        author_id: json['author_id'],
        author_name: json['author_name'],
        author_pic: '$media_url${json['author_pic']}',
        universal: json['universal'],
        views: json['views'].toString(),
        reposts: json['reposts'].toString(),
        comments: json['replies'].toString(),
        type: int.parse(json['type']),
        reply_to_post_id: json['reply_to_post_id'],
        can_reply: int.parse(json['can_reply']),
        reply_to_user_name: json['reply_to_post_name'],
        body: json['body'],
        color: int.parse(json['color']),
        font_type: json['font_type'],
        id: json['id'],
        isReposted: int.parse(json['isReposted']),
        isLoved: int.parse(json['isLoved']),
        isLaughed: int.parse(json['isLaughed']),
        isHated: int.parse(json['isHated']),
        loveLikes: json['love_likes'].toString(),
        laughLikes: json['laugh_likes'].toString(),
        hateLikes: json['hate_likes'].toString(),
      );
    }

    if (post_type == 1) {
      //images
      return Post(
        is_repost: int.parse(json['is_repost']),
        is_ad: int.parse(json['is_ad']),
        is_reply: int.parse(json['is_reply']),
        author_id: json['author_id'],
        author_name: json['author_name'],
        author_pic: '$media_url${json['author_pic']}',
        universal: json['universal'],
        views: json['views'].toString(),
        reposts: json['reposts'].toString(),
        comments: json['replies'].toString(),
        type: int.parse(json['type']),
        can_reply: int.parse(json['can_reply']),
        can_download: int.parse(json['can_download']),
        reply_to_post_id: json['reply_to_post_id'],
        reply_to_user_name: json['reply_to_post_name'],
        caption: json['caption'],
        location: '$media_url${json['location']}',
        id: json['id'],
        name: json['name'],
        isReposted: int.parse(json['isReposted']),
        isLoved: int.parse(json['isLoved']),
        isLaughed: int.parse(json['isLaughed']),
        isHated: int.parse(json['isHated']),
        loveLikes: json['love_likes'].toString(),
        laughLikes: json['laugh_likes'].toString(),
        hateLikes: json['hate_likes'].toString(),
        adult_content: int.parse(json['adult_content']),
      );
    }

    if (post_type == 2) {
      //audio
      return Post(
        is_repost: int.parse(json['is_repost']),
        is_ad: int.parse(json['is_ad']),
        is_reply: int.parse(json['is_reply']),
        author_id: json['author_id'],
        author_name: json['author_name'],
        author_pic: '$media_url${json['author_pic']}',
        universal: json['universal'],
        views: json['views'].toString(),
        reposts: json['reposts'].toString(),
        comments: json['replies'].toString(),
        type: int.parse(json['type']),
        can_reply: int.parse(json['can_reply']),
        can_download: int.parse(json['can_download']),
        reply_to_post_id: json['reply_to_post_id'],
        reply_to_user_name: json['reply_to_post_name'],
        caption: json['caption'],
        location: '$media_url${json['location']}',
        id: json['id'],
        name: json['name'],
        isReposted: int.parse(json['isReposted']),
        isLoved: int.parse(json['isLoved']),
        isLaughed: int.parse(json['isLaughed']),
        isHated: int.parse(json['isHated']),
        loveLikes: json['love_likes'].toString(),
        laughLikes: json['laugh_likes'].toString(),
        hateLikes: json['hate_likes'].toString(),
      );
    }

    if (post_type == 3) {
      //video
      return Post(
        is_repost: int.parse(json['is_repost']),
        is_ad: int.parse(json['is_ad']),
        is_reply: int.parse(json['is_reply']),
        author_id: json['author_id'],
        author_name: json['author_name'],
        author_pic: '$media_url${json['author_pic']}',
        universal: json['universal'],
        views: json['views'].toString(),
        reposts: json['reposts'].toString(),
        comments: json['replies'].toString(),
        type: int.parse(json['type']),
        can_reply: int.parse(json['can_reply']),
        can_download: int.parse(json['can_download']),
        reply_to_post_id: json['reply_to_post_id'],
        reply_to_user_name: json['reply_to_post_name'],
        caption: json['caption'],
        location: '$media_url${json['location']}',
        adult_content: int.parse(json['adult_content']),
        id: json['id'],
        name: json['name'],
        isReposted: int.parse(json['isReposted']),
        isLoved: int.parse(json['isLoved']),
        isLaughed: int.parse(json['isLaughed']),
        isHated: int.parse(json['isHated']),
        loveLikes: json['love_likes'].toString(),
        laughLikes: json['laugh_likes'].toString(),
        hateLikes: json['hate_likes'].toString(),
      );
    }
  }
}
