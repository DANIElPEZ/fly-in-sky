abstract class TokenEvent{}

class GetToken extends TokenEvent{}

class SaveToken extends TokenEvent{
  final String code;
  SaveToken(this.code);
}