class TokenState{
  TokenState({required this.tokenAccess});
  final String tokenAccess;

  factory TokenState.initial(){
    return TokenState(tokenAccess: '');
  }

  TokenState copyWith({
    String? tokenAccess,
  }){
    return TokenState(
      tokenAccess: tokenAccess ?? this.tokenAccess,
    );
  }
}