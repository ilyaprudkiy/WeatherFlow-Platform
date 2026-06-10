import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/buttons/app_buttons.dart';
import '../../../../navigation/navigation.dart';
import '../cubit/auth_cubit.dart';

class SignUpScreenWidget extends StatefulWidget {
  const SignUpScreenWidget({super.key});

  @override
  State<SignUpScreenWidget> createState() => _SignUpScreenWidgetState();
}

class _SignUpScreenWidgetState extends State<SignUpScreenWidget> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomPaint(
          painter: BackgroundPainter(),
          child: Stack(
            children: [
              BlocConsumer<AuthCubit, AuthState>(
                listener: _onChangeSignUpState,
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Positioned(
                          height: 70,
                          top: 200,
                          right: 100,
                          child: TextCreateAccountWidget()),
                      AppButtonTextField(
                        controller: _emailController,
                        color: Colors.cyan,
                        hintText: 'Email',
                        icon: Icons.email,
                        prefixIconColor: Colors.blue.shade800,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      AppButtonTextField(
                        controller: _passwordController,
                        color: Colors.cyan,
                        hintText: 'Password',
                        icon: Icons.lock_open_outlined,
                        prefixIconColor: Colors.blue.shade800,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      AppButtonTextField(
                        controller: _repeatPasswordController,
                        color: Colors.blueAccent,
                        hintText: 'Repeat password',
                        icon: Icons.password_outlined,
                        prefixIconColor: Colors.blue.shade800,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Positioned(
                          child: ButtonSignUpWidget(
                        email: _emailController,
                        password: _passwordController,
                        repeatPassword: _repeatPasswordController,
                      )),
                    ],
                  );
                },
              )
            ],
          ),
        ));
  }

  void _onChangeSignUpState(BuildContext context, AuthState state) {
    if (state is ErrorState) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(state.message),
        behavior: SnackBarBehavior.floating,
      ));
    } else if (state is AuthorizedState) {
      final nextScreen = MainNavigationRouteNames.weatherScreen;
      Navigator.of(context).pushReplacementNamed(nextScreen);
    }
  }
}

class TextCreateAccountWidget extends StatelessWidget {
  const TextCreateAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Create account',
      style: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 27,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final paint = Paint();

    Path mainBackground = Path();
    mainBackground.lineTo(width, 0);
    mainBackground.lineTo(width, height * 0.65);
    mainBackground.cubicTo(width * 0.8, height * 0.8, width * 0.5, height * 0.8,
        width * 0.45, height);
    mainBackground.lineTo(0, height);

    paint.color = Colors.blue.shade800;
    canvas.drawPath(mainBackground, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class ButtonSignUpWidget extends StatelessWidget {
  final TextEditingController password;
  final TextEditingController email;
  final TextEditingController repeatPassword;

  const ButtonSignUpWidget(
      {super.key,
      required this.email,
      required this.password,
      required this.repeatPassword});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return Container(
        height: 60,
        width: 200,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: ElevatedButton(
            onPressed: () {
              cubit.signUp(email.text, password.text, repeatPassword.text);
            },
            child: Text('Sign up',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ))));
  }
}
