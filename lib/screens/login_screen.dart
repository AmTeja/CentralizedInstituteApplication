import 'package:cia/config/theme.dart';
import 'package:cia/cubits/cubits.dart';
import 'package:cia/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: LoginScreen());

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
              repeat: ImageRepeat.repeat,
              opacity: 0.6,
              image: AssetImage('assets/images/login_bg.jpeg'),
            )
        ),
        child: Scaffold(
            backgroundColor: Colors.white.withOpacity(0.9),
            body: BlocProvider(
              create: (_) => LoginCubit(context.read<AuthRepository>(),),
              child: loginForm(),)
        ),
      ),
    );
  }

  Widget loginForm() {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.redAccent,
              content: Text(state.errorMessage.toString())));
        }
      },
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 32.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                flex: 3,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Centralized Institute Application", style: Theme.of(context).textTheme.headline2!.copyWith(color: primaryColor),),
                        const SizedBox(height: 20.0,),
                        Text("Welcome", style: Theme.of(context).textTheme.headline1,),
                        const SizedBox(height: 20.0,),
                        Text("Fill in Email and Password to continue.\nContact department for generation of new user.", style: Theme.of(context).textTheme.headline6,),
                      ],
                    ),)),
              Expanded(
                flex: 4,
                  child: Column(
                    children:  [
                       const _EmailInput(),
                      const SizedBox(height: 20,),
                      const _PasswordInput(),
                      const SizedBox(height: 20,),
                      _LoginButton(formState: formKey,)
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (previous, current) => previous.email != current.email,
        builder: (context, state) {
          return TextFormField(
            onChanged: (email) {context.read<LoginCubit>().emailChanged(email);},
            validator: (val) {
              if(val!.isEmpty) return "Email cannot be empty";
              if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val)) return "Invalid email format!";
              return null;
            },
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              prefixIcon: Icon(Icons.account_box, color: Color(0xFF3B3B3B),),
              label: Text("Email"),
            ),
          );
        });
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (previous, current) => previous.password != current.password,
        builder: (context, state) {
          return TextFormField(
            maxLength: 32,
            obscureText: true,
            validator: (val) {
              if(val!.isEmpty) return "Password cannot be empty!";
              return null;
            },
            onChanged: (password) => context.read<LoginCubit>().passwordChanged(password),
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              prefixIcon: Icon(Icons.password, color: Color(0xFF3B3B3B),),
              // suffixIcon:  isPassEmpty ? null : IconButton(
              //     onPressed: () {setState(() { obscureText = !obscureText; });},
              //     color: const Color(0xFF3B3B3B),
              //     icon: Icon(!obscureText ? Icons.visibility : Icons.visibility_off)),
              label: Text("Password"),
            ),
          );
        });
  }
}


class _LoginButton extends StatelessWidget {

  final GlobalKey<FormState> formState;

  const _LoginButton({Key? key, required this.formState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (previous, current) => previous.password != current.password,
        builder: (context, state) {
          return state.status == LoginStatus.submitting
              ? const CircularProgressIndicator()
              : ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: primaryColor,
                  onPrimary: Colors.white,
                  textStyle: Theme.of(context).textTheme.headline3,
                  fixedSize: const Size(250, 50),
                  shape: const StadiumBorder()
              ),
              onPressed: () {
                if(!formState.currentState!.validate()){
                  // return;
                }
                context.read<LoginCubit>().logInWithCredentials();
              },
              child: const Text("Login"));
        });
  }
}
