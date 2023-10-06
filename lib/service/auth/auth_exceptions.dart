class UserNotFoundAuthException implements Exception {}

class MissingPasswordAuthException implements Exception {}

class InvalidLoginCredentialsAuthException implements Exception {}

class WeakPasswordAuthException implements Exception {}

class EmailAlreadyInUseAuthException implements Exception {}

class InvalidEmailAuthException implements Exception {}

// generic exceptions

class GenericAuthException implements Exception {}

class UserNotLoggedInAuthException implements Exception {}

class NotInputUserNameException implements Exception {}

class PasswordIncorrectException implements Exception {}

// google
class UserCancelLoginWithGoogleAuthException implements Exception {}
