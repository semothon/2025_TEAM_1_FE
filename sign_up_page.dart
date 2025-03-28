import 'package:flutter/material.dart';
import 'package:codeflutter/main.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _idController = TextEditingController(); // 아이디 입력 필드
  final _passwordController = TextEditingController(); // 비밀번호 입력 필드
  final _nickNameController = TextEditingController(); // 이메일 입력 필드

  void _signup() {
    final id = _idController.text;
    final password = _passwordController.text;
    final nickname = _nickNameController.text;

    // 모든 입력 필드를 검사하여 비어있으면 경고
    if (id.isEmpty || password.isEmpty || nickname.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("모든 항목을 입력해주세요")),
      );
    } else if (!_isValidId(id)) {
      // 아이디에 영어만 허용
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("아이디는 영어만 입력 가능합니다")),
      );
    } else if (!_isValidId(nickname)) {
      // 닉네임에 영어만 허용
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("닉네임을 영어로 지어주세요!")),
      );
    } else {
      // 아이디와 비밀번호를 저장 (로그인 화면에서 확인할 수 있게)
      LoginPage.addUserData(id, password,nickname);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("회원가입이 완료되었습니다")),
      );

      // 회원가입 후 로그인 화면으로 돌아가기
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }
  bool _isValidId(String id) {
    final idRegex = RegExp(r'^[a-zA-Z]+$');
    return idRegex.hasMatch(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        backgroundColor: Colors.pink.shade200,),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.pink.shade200, Colors.yellow.shade50],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0), // 전체 패딩 설정
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // 화면 중앙 정렬
              children: [
                Container(
                  padding: EdgeInsets.all(4.5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white,width: 1.5),
                    borderRadius: BorderRadius.circular(21),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Join",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            color: Colors.brown,

                          ),
                        ),
                        SizedBox(height: 16),
                        TextField(
                          controller: _idController, // 아이디 입력 필드
                          decoration: InputDecoration(
                              labelText: "ID",
                              labelStyle: TextStyle(color: Colors.pink)),
                        ),
                        TextField(
                         controller: _passwordController, // 비밀번호 입력 필드
                          decoration: InputDecoration(labelText: "PW",labelStyle: TextStyle(color: Colors.pink)),
                          obscureText: true, // 비밀번호는 텍스트가 보이지 않게 함
                        ),
                        TextField(
                          controller: _nickNameController, // 닉네임 입력 필드
                          decoration: InputDecoration(
                              labelText: "Nickname",
                              labelStyle: TextStyle(color: Colors.pink)),
                        ),
                        SizedBox(height: 16), // 간격


                        ElevatedButton(
                          onPressed: _signup,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pink.shade200,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              // 테두리 꾸미기 side: BorderSide(color: Colors.black, width: 2),

                            ),
                            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 180),
                          ),
                          child: Text(
                            "Sign up",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
