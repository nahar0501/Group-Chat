part of 'fetch_invoices_controller_cubit.dart';

abstract class FetchInvoicesControllerState {}

class FetchFetchInvoicesControllerInitial extends FetchInvoicesControllerState {}

class FetchInvoicesControllerInitial extends FetchInvoicesControllerState {}
class FetchInvoicesControllerLoading extends FetchInvoicesControllerState {}
class InvoiceControllerAdded extends FetchInvoicesControllerState {}
class FetchInvoicesControllerLoaded extends FetchInvoicesControllerState {
  List<InvoiceModel> Invoices;
  FetchInvoicesControllerLoaded({required this.Invoices});
}
class FetchInvoicesControllerError extends FetchInvoicesControllerState {
  String err;
  FetchInvoicesControllerError({required this.err});
}
