import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:myhive/db/boxes.dart';
import 'package:myhive/models/recipient_mod.dart';
import 'package:myhive/widgets/my_alert_dialog.dart';

class RecipientScreen extends StatefulWidget {
  const RecipientScreen({super.key});

  @override
  State<RecipientScreen> createState() => _RecipientScreenState();
}

class _RecipientScreenState extends State<RecipientScreen> {
  TextEditingController nameCon = TextEditingController();
  TextEditingController numberCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Recipient"),
      ),
      body: Column(
        children: [
          TextField(
            controller: nameCon,
            decoration: const InputDecoration(
              label: Text("Name")
            ),
          ),
          const SizedBox(height: 10,),
          TextField(
            controller: numberCon,
            decoration: const InputDecoration(
                label: Text("Number")
            ),
          ),
          const SizedBox(height: 10,),
          ElevatedButton(onPressed: (){
            //add recipient
            final recipient = RecipientModel(name: nameCon.text, number: numberCon.text);
            final box = Boxes.getData();
            box.add(recipient);
            // recipient.save();
            nameCon.clear();
            numberCon.clear();
          }, child: const Text("Save")),
          const Divider(),
          Expanded(
            child: ValueListenableBuilder<Box<RecipientModel>>(
                valueListenable: Boxes.getData().listenable(),
                builder: (context,box,_){
                  List<RecipientModel> data = box.values.toList();
                  return  ListView.builder(
                    itemCount: data.length,
                      itemBuilder: (context, index){
                      RecipientModel recipient = data[index];
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(child: Text("$index"),),
                          title: Text(recipient.name),
                          subtitle: Text(recipient.number),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(onPressed: (){
                                nameCon.text = recipient.name;
                                numberCon.text = recipient.number;
                                myAlertDialog(context,title: const Text("Update"),content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextField(
                                      controller: nameCon,
                                      decoration: const InputDecoration(
                                          label: Text("Name")
                                      ),
                                    ),
                                    const SizedBox(height: 10,),
                                    TextField(
                                      controller: numberCon,
                                      decoration: const InputDecoration(
                                          label: Text("Number")
                                      ),
                                    ),
                                  ],
                                ),
                                  action: [
                                    TextButton(onPressed: (){
                                      Navigator.pop(context);
                                    }, child: const Text("Cancel")),
                                    TextButton(onPressed: (){
                                      recipient.name = nameCon.text;
                                      recipient.number = numberCon.text;
                                      recipient.save();
                                      nameCon.clear();numberCon.clear();
                                      Navigator.pop(context);
                                    }, child: const Text("Update")),
                                  ]
                                );

                              }, icon: const Icon(CupertinoIcons.pencil)),
                              IconButton(onPressed: ()async{
                                await recipient.delete();
                              }, icon: const Icon(CupertinoIcons.delete,color: CupertinoColors.systemRed,)),
                            ],
                          ),
                        ),
                      );
                      }
                  );
                }
            ),
          )
        ],
      ),
    );
  }
}
