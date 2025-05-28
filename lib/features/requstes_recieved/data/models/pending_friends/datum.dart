class Datum {
	int? requestId;
	DateTime? requestDate;
	int? senderId;
	String? senderFirstName;
	String? senderLastName;
	String? senderProfileImageUrl;

	Datum({
		this.requestId, 
		this.requestDate, 
		this.senderId, 
		this.senderFirstName, 
		this.senderLastName, 
		this.senderProfileImageUrl, 
	});

	factory Datum.fromJson(Map<String, dynamic> json) => Datum(
				requestId: json['requestId'] as int?,
				requestDate: json['requestDate'] == null
						? null
						: DateTime.parse(json['requestDate'] as String),
				senderId: json['senderId'] as int?,
				senderFirstName: json['senderFirstName'] as String?,
				senderLastName: json['senderLastName'] as String?,
				senderProfileImageUrl: json['senderProfileImageUrl'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'requestId': requestId,
				'requestDate': requestDate?.toIso8601String(),
				'senderId': senderId,
				'senderFirstName': senderFirstName,
				'senderLastName': senderLastName,
				'senderProfileImageUrl': senderProfileImageUrl,
			};
}
