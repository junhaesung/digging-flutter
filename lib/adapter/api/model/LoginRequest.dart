class LoginRequest {
  final IdProviderType idProviderType;
  final String idProviderUserId;

  LoginRequest({
    required this.idProviderType,
    required this.idProviderUserId,
  });

  Map<String, dynamic> toMap() {
    return {
      'idProviderType': idProviderType.name(),
      'idProviderUserId': idProviderUserId,
    };
  }
}

enum IdProviderType { UUID }

extension IdProviderTypes on IdProviderType {
  String name() {
    switch (this) {
      case IdProviderType.UUID:
        return "UUID";
    }
  }
}
