import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chat_app/models/invoice_model/invoice_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'invoices_controller_state.dart';

class InvoicesControllerCubit extends Cubit<InvoicesControllerState> {
  InvoicesControllerCubit() : super(InvoicesControllerInitial());


  addInvoice(InvoiceData invoice)async
  {
    try{
      String id=FirebaseAuth.instance.currentUser!.uid;
      emit(InvoicesControllerLoading());
      await FirebaseFirestore.instance.collection("Invoices").doc(id).collection("myInvoices").add(invoice.toJson());
      emit(InvoicesControllerAdded());

    }catch(e)
    {
      if(e is SocketException)
        {
          emit(InvoicesControllerError(err: e.message));
        }
      if(e is FirebaseException)
        {
          emit(InvoicesControllerError(err: e.message.toString()));
        }
    }

  }

  updateInvoice(InvoiceModel invoice)async
  {
    try{
      emit(InvoicesControllerUpdating());
      String id=FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance.collection("Invoices").doc(id).collection("myInvoices").doc(invoice.id).update(invoice.invoiceData.toJson());
      emit(InvoicesControllerUpdated());

    }catch(e)
    {
      if(e is SocketException)
      {
        emit(InvoicesControllerError(err: e.message));
      }
      if(e is FirebaseException)
      {
        emit(InvoicesControllerError(err: e.message.toString()));
      }
    }

  }
  deleteInvoice(String id)async
  {
    try{
      emit(InvoicesControllerDeleting());
      String uid=FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance.collection("Invoices").doc(uid).collection("myInvoices").doc(id).delete();
      emit(InvoicesControllerDeleted());

    }catch(e)
    {
      if(e is SocketException)
      {
        emit(InvoicesControllerError(err: e.message));
      }
      if(e is FirebaseException)
      {
        emit(InvoicesControllerError(err: e.message.toString()));
      }
    }

  }
}
