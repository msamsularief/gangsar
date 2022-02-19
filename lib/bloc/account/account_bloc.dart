
import 'package:bloc/bloc.dart';
import 'package:klinik/api/auth.dart';
import 'package:klinik/bloc/account/account.dart';
import 'package:klinik/bloc/klinik/klinik_bloc.dart';
import 'package:klinik/models/account.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final KlinikBloc klinikBloc;

  AccountBloc({
    required this.klinikBloc,
  }) : super(AccountLoading()) {
    on<AccountEvent>((event, emit) => emit(AccountLoading()));
    on<CreateAccount>((event, emit) async {
      emit(AccountLoading());
      try {
        Account? account;
        var result = await Auth.doRegister(
          event.email,
          event.password,
          event.userName,
          event.phoneNum,
        );

        if (account != null) {
          print(account);
        } else {
          print('account is null');
          emit(AccountFailure(error: 'Error'));
        }
      } catch (e) {
        print(e);
        emit(AccountFailure(error: e.toString()));
      }
    });
  }

  @override
  void onTransition(Transition<AccountEvent, AccountState> transition) {
    super.onTransition(transition);
    print("\n$transition\n");
  }
}
