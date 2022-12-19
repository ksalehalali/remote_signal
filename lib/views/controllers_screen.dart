import 'dart:math';

import 'package:flutter/material.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:slider_controller/slider_controller.dart';

class ControllersScreen extends StatefulWidget {
  const ControllersScreen({Key? key}) : super(key: key);

  @override
  State<ControllersScreen> createState() => _ContrllersScreenState();
}

class _ContrllersScreenState extends State<ControllersScreen> {
  void initState() {
    super.initState();
    openSignalRConnection();
    createRandomId();
  }

  bool btn1Pressed = false;
  bool btn2Pressed = false;
  int percent = 0;
  int showPercent =0;
  int currentUserId = 0;
  //generate random user id
  createRandomId() {
    Random random = Random();
    currentUserId = random.nextInt(999999);
  }

  ScrollController chatListScrollController = new ScrollController();
  TextEditingController messageTextController = TextEditingController();
  submitMessageFunction(bool btn1 ,bool btn2 , int percent) async {
    await connection.invoke('SendMessage', args: ["kh23aled",112, "mes2sage",btn1Pressed,btn2Pressed,percent]);
    Future.delayed(const Duration(milliseconds: 500), () {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(centerTitle: true,title: const Text("Controllers",style: TextStyle(fontSize: 18),),),
        body: Center(
      child: Container(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){
              btn1Pressed = !btn1Pressed;
              print("btn1 =$btn1Pressed");
              submitMessageFunction(btn1Pressed, btn2Pressed, percent);
            },
              style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all(Colors.blue[700]),
                foregroundColor:
                MaterialStateProperty.all(Colors.white),
                padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 32)),
              ), child: const Text("Button 1",style: TextStyle(fontSize: 16),),
            ),
            const SizedBox(height: 40,),
            ElevatedButton(onPressed: (){
              btn2Pressed = !btn2Pressed;
              print("btn2 =$btn2Pressed");

              submitMessageFunction(btn1Pressed, btn2Pressed, percent);

            }, child: const Text("Button 2",style: TextStyle(fontSize: 16),

            ),
              style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all(Colors.blue[700]),
                foregroundColor:
                MaterialStateProperty.all(Colors.white),
                padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(
                        vertical: 12, horizontal: 32)),
              ),
            ),
            const SizedBox(height: 90,),

      Column(
        children: [
          Center(child: Text("$showPercent %",style: const TextStyle(fontSize: 19,fontWeight: FontWeight.bold),),),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SliderController(
              value: percent.toDouble(),
              onChanged: (value) {
                print('slider value : $value');
                percent = value.toInt();

                submitMessageFunction(btn1Pressed, btn2Pressed, percent);
              },
            ),
          ),
        ],
      )
          ],
        ),
      ),
    ));
  }

  //set url and configs
  final connection = HubConnectionBuilder()
      .withUrl(
      'http://172.20.10.3:5000/chatHub',
      HttpConnectionOptions(
        logging: (level, message) => print(message),
      ))
      .build();

  //connect to signalR
  Future<void> openSignalRConnection() async {
    await connection.start();
    connection.on('ReceiveMessage', (message) {
      print(message![0]['btn1_pressed']);
      print(message[0]['btn2_pressed']);
      print(message[0]['percent']);
      setState(() {
        showPercent =message[0]['percent'];
      });

    });
    //await connection.invoke('JoinUSer', args: ['user', currentUserId]);
  }
}
