import 'package:web3dart/credentials.dart';

class Message {
  String description;
  BigInt likes;
  EthereumAddress address;
  int messId;

  Message({this.description, this.address, this.likes, this.messId});
}
