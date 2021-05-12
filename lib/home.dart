import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:open_mike/message.dart';
import 'package:web3dart/web3dart.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Client httpClient;
  Web3Client ethClient;
  List<Message> messages = [];

  final myAddress = '0x3533b652A89CAC9d9EAcA82DA53123C7d9FeA3ce';

  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    httpClient = Client();
    ethClient = Web3Client('HTTP://127.0.0.1:7545', httpClient);

    getMessages();
    super.initState();
  }

  Future<DeployedContract> loadContract() async {
    String abi = await rootBundle.loadString("assets/abi.json");
    String contractAddress = "0xa3E0598A95ED63F39534b87BE39Fd4f7290f9Fc3";

    final contract = DeployedContract(ContractAbi.fromJson(abi, "OpenMike"), EthereumAddress.fromHex(contractAddress));
    return contract;
  }

  Future<void> getMessages() async {
    messages.clear();
    final contract = await loadContract();
    final ethFunction = contract.function("postsCount");
    final result = await ethClient.call(contract: contract, function: ethFunction, params: []);
    List<dynamic> res = result;
    BigInt num = res[0];
    for (int i = 0; i < num.toInt(); i++) {
      final ethFunction1 = contract.function("mess");
      var bigNum = BigInt.from(i);
      final result1 = await ethClient.call(contract: contract, function: ethFunction1, params: [bigNum]);
      List<dynamic> res1 = result1;
      setState(() {
        messages.add(Message(description: res1[0], likes: res1[1], address: res1[2], messId: i));
      });
    }
  }

  Future<void> likeMessage(int id) async {
    EthPrivateKey credentials = EthPrivateKey.fromHex("f101480620d427e452b9c1c6cfbdbaf14e5a3063fb58c6c719a15f0a647f23a5");

    DeployedContract contract = await loadContract();
    final ethFunction = contract.function("Likemessage");
    BigInt bigId = BigInt.from(id);
    final result = await ethClient.sendTransaction(credentials, Transaction.callContract(contract: contract, function: ethFunction, parameters: [bigId]));
    print(result);
    print("Message likes");
    getMessages();
  }

  Future<void> postMessage(String message) async {
    EthPrivateKey credentials = EthPrivateKey.fromHex("f101480620d427e452b9c1c6cfbdbaf14e5a3063fb58c6c719a15f0a647f23a5");

    DeployedContract contract = await loadContract();
    final ethFunction = contract.function("createMessage");
    final result = await ethClient.sendTransaction(credentials, Transaction.callContract(contract: contract, function: ethFunction, parameters: [message]));
    print(result);
    print("Message likes");
    getMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Open Mike',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        ),
        //leading: Container(),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: ListView.builder(
          itemBuilder: (context, index) {
            Message mess = messages[index];
            return InkWell(
              onTap: () {
                likeMessage(mess.messId);
              },
              child: postBox("...." + mess.address.toString().substring(35), mess.description, context, mess.likes, mess.messId),
            );
          },
          itemCount: messages.length != 0 ? messages.length : 0,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          return showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black54),
                      ),
                      padding: EdgeInsets.all(20),
                      child: TextFormField(
                        maxLines: 10,
                        controller: messageController,
                        decoration: InputDecoration(
                          hintText: 'Enter something to post ....',
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        postMessage(messageController.text);
                        Navigator.pop(context);
                        messageController.clear();
                      },
                      child: Text(
                        'Post',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        elevation: 5,
        child: Icon(Icons.create),
      ),
    );
  }
}

Widget postBox(String user, String post, BuildContext context, BigInt likes, int id) {
  return Container(
    padding: EdgeInsets.only(bottom: 25),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: Colors.lightBlueAccent,
          radius: 25,
          child: Text(
            user[user.length - 1].toUpperCase(),
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(width: 20),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black54, width: 1),
            borderRadius: BorderRadius.circular(12),
          ),
          width: MediaQuery.of(context).size.width * (0.7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
              ),
              SizedBox(height: 10),
              Text(
                post,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(width: 1, color: Colors.black26),
                      ),
                    ),
                    width: 250,
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          Text(
                            likes.toString(),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.black38,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Like',
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(width: 10),
                          Icon(
                            Icons.thumb_up,
                            size: 16,
                            color: ThemeData.light().primaryColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    ),
  );
}
