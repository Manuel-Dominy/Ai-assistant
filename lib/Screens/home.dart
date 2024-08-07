import 'package:ai_assistant/Screens/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';


class Homescreen extends StatefulWidget {
  Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List<message> m=[];
   TextEditingController t=TextEditingController();
  callGeminiapi()async{
    try{
      final model=GenerativeModel(model: 'gemini-pro', apiKey: dotenv.env['GOOGLE_API_KEY']!);
    final prompt=t.text.trim();
    final content=[Content.text(prompt)];
    final response=await model.generateContent(content);
    setState(() {
      m.add(message(response.text!, true));
    });
    }catch(e){
      print("Error $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    
   
   
    
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 218, 211, 211),
          body:Column(
            children: [
             Expanded(child: SizedBox(),flex:1),
              Expanded(
                flex:8,
                child: ListView.builder(itemBuilder: (context,index){
                            return Align(
                alignment: m[index].user?Alignment.centerLeft:Alignment.centerRight,
                child: Container(
                  constraints: const BoxConstraints(
                          maxWidth: 200,
                          minWidth: 100
                      ),
                  decoration: BoxDecoration(
                    color: m[index].co,
                    borderRadius: !m[index].user?BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20),topLeft: Radius.circular(20)):BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20),topRight: Radius.circular(20)),
                  ),
                  child: 
                     Padding(
                      padding: EdgeInsets.all(15),
                       child: Text(m[index].st,style: TextStyle(fontSize: 20),),
                     ),
                ),
                            );
                          },
                          itemCount:m.length,
                  ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(160, 151, 151, 1).withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                        )
                      ]
                      
                    ),
                    child: TextFormField(
                    controller: t,
                    
                    decoration:InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 30.0
                      ),
                      suffixIcon: GestureDetector(child: Icon(Icons.send),onTap: ()async {
                       message k= message(t.text,false);
                        setState(() {
                          m.add(k);
                        });
                       await callGeminiapi();
                       t.clear();
                      },
                      
                      ),
                      prefixIcon: Icon(Icons.mic,size: 35,),
                    hintText: "Message",
                    focusColor: Colors.grey,
                    border: UnderlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)),borderSide: BorderSide(width: 0.5))
                                  )),
                  ),flex: 0,),
              )
            ],
          )
    );
  }
}