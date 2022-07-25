part of 'invoices_controller_cubit.dart';

abstract class InvoicesControllerState {}

class InvoicesControllerInitial extends InvoicesControllerState {}
class InvoicesControllerLoading extends InvoicesControllerState {}
class InvoicesControllerAdded extends InvoicesControllerState {}
class InvoicesControllerUpdating extends InvoicesControllerState {}
class InvoicesControllerUpdated extends InvoicesControllerState {}
class InvoicesControllerDeleting extends InvoicesControllerState {}
class InvoicesControllerDeleted extends InvoicesControllerState {}
class InvoicesControllerLoaded extends InvoicesControllerState {
  List<InvoiceModel> invoices;
  InvoicesControllerLoaded({required this.invoices});
}
class InvoicesControllerError extends InvoicesControllerState {
  String err;
  InvoicesControllerError({required this.err});
}
