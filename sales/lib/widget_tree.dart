import 'package:flutter/material.dart';
import 'package:sales/auth.dart';
import 'package:sales/pages/login_register.dart';
import 'package:sales/pages/home.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State <WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree>{
  @override
  Widget build(BuildContext context){
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return HomePage();
        }
        else {
          return const LoginPage();
        }
      },
    );
  }
}

class MyBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  MyBottomNavigationBar({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Container(
              height: 25,
              width: 25,
              child: SvgPicture.asset('assets/loop-svgrepo-com.svg'),
            ),
            label: 'API kald',
          ),
          BottomNavigationBarItem(
            icon: Container(
              height: 25,
              width: 25,
              child: SvgPicture.asset('assets/double-x.svg'),
            ),
            label: 'Logout',
          ),
        ],
      ),
    );
  }
}
