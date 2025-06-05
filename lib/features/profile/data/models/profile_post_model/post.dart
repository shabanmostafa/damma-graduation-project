class Post {
	int? postId;
	String? postTitle;
	String? postBody;
	dynamic mediaUrl;
	int? totalComments;
	int? totalReactions;
	List<dynamic>? comments;
	List<dynamic>? reactions;

	Post({
		this.postId, 
		this.postTitle, 
		this.postBody, 
		this.mediaUrl, 
		this.totalComments, 
		this.totalReactions, 
		this.comments, 
		this.reactions, 
	});

	factory Post.fromJson(Map<String, dynamic> json) => Post(
				postId: json['postId'] as int?,
				postTitle: json['postTitle'] as String?,
				postBody: json['postBody'] as String?,
				mediaUrl: json['mediaUrl'] as dynamic,
				totalComments: json['totalComments'] as int?,
				totalReactions: json['totalReactions'] as int?,
				comments: json['comments'] as List<dynamic>?,
				reactions: json['reactions'] as List<dynamic>?,
			);

	Map<String, dynamic> toJson() => {
				'postId': postId,
				'postTitle': postTitle,
				'postBody': postBody,
				'mediaUrl': mediaUrl,
				'totalComments': totalComments,
				'totalReactions': totalReactions,
				'comments': comments,
				'reactions': reactions,
			};
}
