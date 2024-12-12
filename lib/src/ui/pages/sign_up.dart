import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pr_11/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final SupabaseClient supabase = Supabase.instance.client;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  void register() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final nickname = nicknameController.text.trim();
    final phone = phoneController.text.trim();

    try {
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
      );

      final userId = response.user?.id;

      if (userId != null) {
        await _sendAdditionalData(userId, email, password, nickname, phone);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Регистрация успешна!')),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка: User ID не найден')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка регистрации: $e')),
      );
    }
  }

  Future<void> _sendAdditionalData(String userId, String email, String password, String nickname, String phone) async {
    const String backendUrl = 'https://192.168.100.38:8080/register';
    final Dio dio = Dio();

    try {
      final response = await dio.post(
        backendUrl,
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
        data: {
          'user_id': userId,
          'email': email,
          'password_hash': password,
          'username': nickname,
          'phone': phone,
          'image': ''
        },
      );

      if (response.statusCode == 200) {
        print('Данные успешно отправлены на бэкенд');
      } else {
        throw Exception('Ошибка при отправке данных: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      // Обработка ошибок Dio
      final errorMessage = e.response != null
          ? e.response?.data.toString()
          : e.message;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка отправки данных: $errorMessage')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(
        child: Text('Регистрация', style: TextStyle(color: Color.fromRGBO(76, 23, 0, 1.0),
          fontSize: 28,
          fontWeight: FontWeight.w600,)),
      )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nicknameController,
              decoration: InputDecoration(labelText: 'Никнейм'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Пароль'),
              obscureText: true,
            ),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: 'Телефон'),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: register,
              child: Text('Зарегистрироваться'),
            ),
          ],
        ),
      ),
    );
  }
}
