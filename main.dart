import 'package:flutter/material.dart';
import 'package:codeflutter/sign_up_page.dart';
import 'package:codeflutter/first_page.dart';
import 'package:codeflutter/home_page.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstPage(),
    );
  }
}

// 로그인 화면
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  _LoginPageState createState() => _LoginPageState();
  static void addUserData(String id, String password,String nickname) {
    _LoginPageState._userData[id] = password;
  }
}

class _LoginPageState extends State<LoginPage> {
  final _idController = TextEditingController(); // 아이디 입력을 위한 컨트롤러
  final _passwordController = TextEditingController(); // 비밀번호 입력을 위한 컨트롤러
  //final _nicknameController = TextEditingController(); // 닉네임 입력 컨트롤러

  // 임시 저장소 (아이디와 비밀번호를 저장하는 곳)
  static final Map<String, String> _userData = {}; // 아이디와 비밀번호를 저장하는 static 변수

  // 로그인 처리 함수
  void _login() {
    final id = _idController.text; // 사용자가 입력한 아이디
    final password = _passwordController.text; // 사용자가 입력한 비밀번호

    // 아이디가 영어만 포함되어 있는지 확인
    if (!_isValidId(id)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("아이디는 영어만 입력 가능합니다")),
      );
      return;
    }

    if (_userData.containsKey(id)) {
      // 아이디가 존재하면 비밀번호 확인
      if (_userData[id] == password) {
        // 비밀번호가 맞으면 홈 페이지로 이동
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        // 비밀번호가 틀리면 오류 메시지 출력
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("비밀번호가 일치하지 않습니다")),
        );
      }
    } else {
      // 아이디가 존재하지 않으면 오류 메시지 출력
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("존재하지 않는 아이디입니다")),
      );
    }
  }

  // 아이디가 영어만 포함하는지 체크하는 함수
  bool _isValidId(String id) {
    final idRegex = RegExp(r'^[a-zA-Z]+$');
    return idRegex.hasMatch(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(),
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
                      "LOGIN",
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
                SizedBox(height: 16), // 간격


                ElevatedButton(
                  onPressed: _login, // 로그인 버튼 눌렀을 때 _login 함수 실행
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink.shade200,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      // 테두리 꾸미기 side: BorderSide(color: Colors.black, width: 2),

                    ),
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 180),
                  ),
                  child: Text(
                      "Start",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                  ],
                ),
                ),
                ),
                SizedBox(height: 16),


                TextButton(
                  onPressed: () {
                    // 회원가입 화면으로 이동
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage()),
                    );
                  },
                  child: Text(
                    "회원가입 하기",
                    style: TextStyle(color: Colors.grey),
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

////////되돌아가기 버튼///////
class CustomBackButton extends StatelessWidget {
  final VoidCallback? onPressed; // 버튼 클릭 시 동작 (기본값: 이전 화면으로 이동)

  const CustomBackButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 14.0),
      child: GestureDetector(
        onTap: onPressed ?? () => Navigator.pop(context), // 기본 동작: 이전 화면으로 이동
        child: Container(
          padding: const EdgeInsets.all(0.5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white70, width: 1),
            color: Colors.transparent, // 배경 투명
          ),
          child: const Icon(
            Icons.arrow_circle_left_outlined,
            size: 37,
            color: Colors.white70,
          ),
        ),
      ),
    );
  }
}
///////////////////////////////////////