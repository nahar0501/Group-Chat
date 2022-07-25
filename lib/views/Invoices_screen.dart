
import 'package:chat_app/models/invoice_model/invoice_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controllers/add_invoices_cubit/invoices_controller_cubit.dart';
import '../controllers/fetch_invoices_cubit/fetch_invoices_controller_cubit.dart';
import 'custom_widgets/invoice_widget.dart';

class InvoicesScreen extends StatelessWidget {
  final _txtInvoiceNo = TextEditingController();
  final _txtSender = TextEditingController();
  final _txtReciever = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<FetchInvoicesControllerCubit, FetchInvoicesControllerState>(
        listener: (context, state) {
          // TODO: implement listener
          if(state is FetchInvoicesControllerLoading)
            {
              print("loading");
            }

          if(state is FetchInvoicesControllerError)
            {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.err))
              );
            }
        },
        builder: (context, state) {
          if(state is InvoicesControllerLoading)
          {
            return const  Center(
              child: CircularProgressIndicator(),
            );
          }
          if(state is FetchInvoicesControllerLoaded) {
            return ListView.builder(
              itemCount: state.Invoices.length,
              itemBuilder: (context, index) {
                return InvoiceWidget(invoiceModel: state.Invoices[index],);
              },
            );
          }
          return  const Center(
            child: Text("Something went wrong"),
          );



        },
      ),
      floatingActionButton: BlocListener<InvoicesControllerCubit, InvoicesControllerState>(
  listener: (context, state) {
    // TODO: implement listener
    if(state is InvoicesControllerAdded)
      {
        Navigator.pop(context);
        print("invoice created");
      }
    if(state is InvoicesControllerDeleted)
      {

      }
    if(state is InvoicesControllerUpdating)
      {
        print("updating invoice");
      }
    if(state is InvoicesControllerUpdated)
      {
        Navigator.pop(context);
        print("invoice updated");
      }
    if(state is InvoicesControllerLoading)
      {
        print("adding Invoice");
      }
  },
  child: FloatingActionButton(
        backgroundColor: Colors.yellow.shade800,
        onPressed: () {
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
                                hintText: "sender name",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20))),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                            controller: _txtReciever,
                            decoration: InputDecoration(
                                hintText: "reciever name",
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
                                    context.read<InvoicesControllerCubit>().addInvoice(data);
                                  }
                              }, child: Text("Add invoice")),
                        ],
                      ),
                    ),
                  ));
        },
        child: Icon(Icons.add),
      ),
),
    );
  }
}
