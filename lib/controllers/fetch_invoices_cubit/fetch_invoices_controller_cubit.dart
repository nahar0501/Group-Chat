import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../models/invoice_model/invoice_model.dart';

part 'fetch_invoices_controller_state.dart';

class FetchInvoicesControllerCubit extends Cubit<FetchInvoicesControllerState> {
  FetchInvoicesControllerCubit() : super(FetchInvoicesControllerInitial()){
    fetchInvoices();
  }

  fetchInvoices()async
  {
    try{
      List<InvoiceModel> invoices=[];
      String id=FirebaseAuth.instance.currentUser!.uid;
      emit(FetchInvoicesControllerLoading());
      var ref= FirebaseFirestore.instance.collection("Invoices").doc(id).collection("myInvoices").orderBy("invoiceno").snapshots();
      
      ref.listen((event) {
        invoices.clear();
        for(var d in event.docs)
        {
          String id=d.id;
          var data=InvoiceData.fromRawJson(jsonEncode(d.data()));
          invoices.add(InvoiceModel(id: id, invoiceData: data));
        }
        emit(FetchInvoicesControllerLoaded(Invoices: invoices));
      });

    }catch(e)
    {
      if(e is SocketException)
      {
        emit(FetchInvoicesControllerError(err: e.message));
      }
      if(e is FirebaseException)
      {
        emit(FetchInvoicesControllerError(err: e.message.toString()));
      }
    }
  }
}
