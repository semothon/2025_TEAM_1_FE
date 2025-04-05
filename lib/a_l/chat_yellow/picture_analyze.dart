//사진 분석 기다리는 화면 6페이지
//사진 분석 완료되면 다음 화면으로 이동 가능한 버튼 띄우면 될 듯
import 'package:flutter/material.dart';
import 'package:semoton_front/a_l/chat_yellow/check_score.dart';
import '../../network/api_service.dart';

class PictureAnalyze extends StatefulWidget {
  final String missionTitle;
  final String uploadedUrl;

  const PictureAnalyze(this.missionTitle, this.uploadedUrl, {super.key});

  @override
  State<PictureAnalyze> createState() => _PictureAnalyzeState();
}

class _PictureAnalyzeState extends State<PictureAnalyze> {
  final ApiService apiService = ApiService();
  String stdUrl = "https://demo-bucket-605134439665.s3.ap-northeast-2.amazonaws.com/KakaoTalk_20250406_050058157_01.jpg";
  String landmarkName = "";
  int? score;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    landmarkName = widget.missionTitle;
    analyzePicture();
  }

  Future<void> analyzePicture() async {
    try {
      final result = await apiService.submitQuestWithImages(
        landmarkName,
        stdUrl,
        widget.uploadedUrl,
      );

      setState(() {
        score = result['score'];
        isLoading = false;
      });
    } catch (e) {
      print('Error analyzing picture: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              'assets/chat_home.png',
              fit: BoxFit.fitWidth,
            ),
          ),

          // 상단 미션 위젯
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: CustomMissionWidget(),
          ),

          // 중앙 분석 메시지
          Positioned(
            top: 250,
            left: 20,
            right: 20,
            child: isLoading ? const Analyze() :
            Center(child: Text('사진 분석 완료! 점수: $score', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
          ),

          // 결과 확인 버튼
          if (!isLoading)
            Positioned(
              top: 600,
              left: 20,
              right: 20,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CheckScore(widget.missionTitle, score!)),
                  );
                },
                child: const Text('다음 화면으로 넘어가기'),
              ),
            ),
        ],
      ),
    );
  }
}


//상단 퀘스트 바
class CustomMissionWidget extends StatelessWidget {
  const CustomMissionWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        // 배경 컨테이너
        Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 60),
          decoration: BoxDecoration(
            color: Colors.pink.shade200,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5,
                offset: Offset(2, 2),
              ),
            ],
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  children: [
                    TextSpan(
                      text: "MISSION\n",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
                    ),
                    TextSpan(
                      text: "도서관 앞 동상과 함께 사진 찍기",
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // 좌우 둥근 장식
        Positioned( //좌측 장식
          left: -15,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.pink.shade200,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned( // 우측 장식
          right: -15,
          child: Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: Colors.pink.shade200,
              shape: BoxShape.circle,
            ),
          ),
        ),

        // 위아래 흰색 선
        Positioned(
          left: 20,
          right: 20,
          top: 0.01,
          child: Divider(
            color: Colors.white54,
            thickness: 2,
          ),
        ),
        Positioned(
          left: 20,
          right: 20,
          bottom: 0.01,
          child: Divider(
            color: Colors.white54,
            thickness: 2,
          ),
        ),
      ],
    );
  }
}

//사진 분석 화면
class Analyze extends StatelessWidget {
  const Analyze({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35),
            border: Border.all(color: Colors.white70, width: 4),
            color: Colors.transparent,
          ),
          child: Container(
            width: 410,
            height: 165,
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8
                ),
              ],
            ),
            child: Center
              (child: Text('...사진 분석 중...',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xff9B4A4A),
              ),
            ),
            ),
          ),
        )
      ],
    );
  }
}
