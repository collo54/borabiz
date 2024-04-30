class PreferenceModel {
  PreferenceModel({
    required this.unsubscribedEmail,
  });
  final bool unsubscribedEmail;

  Map<String, dynamic> toMap() {
    return {
      'email_unsubscribed': unsubscribedEmail,
    };
  }

  factory PreferenceModel.fromMap(Map<String, dynamic> data) {
    final bool unsubEmail = data['email_unsubscribed'] as bool;

    return PreferenceModel(
      unsubscribedEmail: unsubEmail,
    );
  }
}
