import 'package:flutter/material.dart';
import 'package:pollution/view/component/pollution_appbar.dart';
import 'package:pollution/view/component/pollution_input_dialog.dart';
import 'package:pollution/view/component/pollution_typography.dart';

class PollutionHomeDetailView extends StatefulWidget {
  const PollutionHomeDetailView({super.key});

  @override
  State<PollutionHomeDetailView> createState() => _PollutionHomeDetailViewState();
}

class _PollutionHomeDetailViewState extends State<PollutionHomeDetailView> {
  void _registerCharacterName(msg) {}

  void _registerCharacterDetail(msg) {}

  void _registerCharacterSystemContents(msg) {}

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PollutionAppbarBackground(
        appBarActions: [],
        appBarHeight: 60,
        appBarTitle: '캐릭터 챗봇 내용 수정',
      ),
      body: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.background,
              Theme.of(context).colorScheme.onBackground,
            ],
              begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                height: 24,
              ),
            ),
            SliverToBoxAdapter(
              child: InkWell(
                onTap: () {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => PollutionInputDialog(
                      maxLine: 1,
                      onRegister: (msg) {
                        _registerCharacterName(msg);
                      },
                      hintText: '캐릭터 이름을 입력하세요.',
                      initialText: '',
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 24),
                  width: width,
                  height: 60,
                  color: Colors.white.withOpacity(0.1),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          '캐릭터 이름',
                          style: PollutionTextStyle.p16_w400.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 16,
              ),
            ),
            SliverToBoxAdapter(
              child: InkWell(
                onTap: () {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => PollutionInputDialog(
                      maxLine: 1,
                      onRegister: (msg) {
                        _registerCharacterDetail(msg);
                      },
                      hintText: '캐릭터 설명을 입력하세요.',
                      initialText: '',
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 24),
                  width: width,
                  height: 60,
                  color: Colors.white.withOpacity(0.1),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          '캐릭터 설명',
                          style: PollutionTextStyle.p16_w400.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 16,
              ),
            ),
            SliverToBoxAdapter(
              child: InkWell(
                onTap: () {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => PollutionInputDialog(
                      maxLine: 10,
                      onRegister: (msg) {
                        _registerCharacterSystemContents(msg);
                      },
                      hintText: '캐릭터 시스템 컨텐츠를 입력하세요.',
                      initialText: '',
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 24),
                  width: width,
                  height: 500,
                  color: Colors.white.withOpacity(0.1),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '캐릭터 시스템 컨텐츠를 입력하세요.',
                            style: PollutionTextStyle.p16_w400.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
