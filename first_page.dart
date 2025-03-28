import 'package:codeflutter/main.dart';
import 'package:codeflutter/sign_up_page.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink.shade200,
                  shadowColor: Colors.black.withOpacity(0.3),
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: const BorderSide(color: Colors.white, width: 2),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 100),
                ),
                child: SizedBox(
                  width: 70,
                  height: 40,
                  child: Center(
                    child: const Text(
                      'LOGIN',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink.shade200,
                  shadowColor: Colors.black.withOpacity(0.3),
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: const BorderSide(color: Colors.white, width: 2),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 100),
                ),
                child: SizedBox(
                  width: 70,
                  height: 40,
                  child: Center(
                    child: const Text(
                      'JOIN',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}

//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // 배경
//           Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [
//                   Color(0xFFFFAFAF),
//                   Color(0xFFFFBABA),
//                   Color(0xFFFFC5C5),
//                 ],
//               ),
//             ),
//           ),
//           // 점 패턴 (하단)
//           Positioned.fill(
//             child: CustomPaint(
//               painter: DotPatternPainter(),
//             ),
//           ),
//           // 버튼들
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Padding(
//               padding: const EdgeInsets.only(bottom: 50.0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   CustomButton(text: "LOGIN", page: const LoginPage()),
//                   const SizedBox(height: 10),
//                   CustomButton(text: "JOIN", page: const SignUpPage()),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// class DotPatternPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()..color = Colors.white.withOpacity(0.5);
//     double spacing = 20.0;
//
//     for (double y = size.height * 0.7; y < size.height; y += spacing) {
//       for (double x = 0; x < size.width; x += spacing) {
//         canvas.drawCircle(Offset(x, y), 2, paint);
//       }
//     }
//   }
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }
// class CustomButton extends StatefulWidget {
//   final String text;
//   final Widget page;
//
//   const CustomButton({super.key, required this.text, required this.page});
//
//   @override
//   _CustomButtonState createState() => _CustomButtonState();
// }
//
// class _CustomButtonState extends State<CustomButton> {
//   bool isPressed = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTapDown: (_) => setState(() => isPressed = true),
//       onTapUp: (_) {
//         setState(() => isPressed = false);
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => widget.page),
//         );
//       },
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 150),
//         width: 150,
//         height: 50,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(25),
//           border: Border.all(color: Colors.white, width: 2),
//           gradient: LinearGradient(
//             colors: isPressed
//                 ? [Color(0xFFFF8F8F), Color(0xFFFFAFAF)] // 눌렀을 때 색 반전
//                 : [Color(0xFFFFAFAF), Color(0xFFFF8F8F)],
//           ),
//           boxShadow: [
//             if (!isPressed)
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.2),
//                 offset: const Offset(0, 3),
//                 blurRadius: 5,
//               ),
//           ],
//         ),
//         child: Center(
//           child: Text(
//             widget.text,
//             style: const TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//               fontSize: 18,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
