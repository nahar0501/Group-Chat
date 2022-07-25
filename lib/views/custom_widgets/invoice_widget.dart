import 'package:chat_app/models/invoice_model/invoice_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controllers/add_invoices_cubit/invoices_controller_cubit.dart';

class InvoiceWidget extends StatelessWidget {
  InvoiceModel invoiceModel;
   InvoiceWidget({required  this.invoiceModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.6),
          borderRadius: BorderRadius.circular(5.0),
        image: DecorationImage(
          image: AssetImage("assets/images/invoicebg.jpg"),
          fit: BoxFit.cover
        )
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Invoice Number',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Text(
                "${invoiceModel.invoiceData.invoiceno}",
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
            ],
          ),
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Sender Name',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Text(
                invoiceModel.invoiceData.senderName
                    .toString(),
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
            ],
          ),
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Receiver Name',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Text(
                invoiceModel.invoiceData.recieverName,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: (){
                  final _txtSender=TextEditingController(text:invoiceModel.invoiceData.senderName);
                  final _txtReciever=TextEditingController(text: invoiceModel.invoiceData.recieverName);
                  final _txtInvoiceNo=TextEditingController(text: invoiceModel.invoiceData.invoiceno.toString());
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        content: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: Column(
                            children: [
                              TextField(
                                controller: _txtInvoiceNo,
                                decoration: InputDecoration(
                                    hintText: "Enter invoice no.",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20))),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextField(
                                controller: _txtSender,
                                decoration: InputDecoration(
                                    hintText: "Enter Total amount.",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20))),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextField(
                                controller: _txtReciever,
                                decoration: InputDecoration(
                                    hintText: "Enter Withdrawn amount",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20))),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    if(_txtInvoiceNo.text.isEmpty || _txtSender.text.isEmpty || _txtReciever.text.isEmpty)
                                    {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text("please fill all fields"))
                                      );
                                    }
                                    else
                                    {
                                      var data= InvoiceData(
                                          invoiceno: int.parse(_txtInvoiceNo.text),
                                          senderName: _txtSender.text,
                                          recieverName: _txtReciever.text
                                      );
                                      context.read<InvoicesControllerCubit>().updateInvoice(
                                          InvoiceModel(
                                              id: invoiceModel.id,
                                              invoiceData: data)
                                      );
                                    }
                                  }, child: Text("update invoice")),
                            ],
                          ),
                        ),
                      ));

                },
                child: const Icon(
                  Icons.edit,
                  color: Colors.green,
                ),
              ),
              InkWell(
                onTap: () async {

                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        content: const SizedBox(
                          height: 30,
                          child:const Center(child:Text("Do you want to delete?")),
                        ),
                        actions: [
                          MaterialButton(onPressed: (){
                            context.read<InvoicesControllerCubit>().deleteInvoice(invoiceModel.id);
                          },child: Text("Yes"),),
                          MaterialButton(onPressed: (){
                            Navigator.pop(context);
                          },child: Text("No"),),
                        ],
                      ));

                },
                child: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
