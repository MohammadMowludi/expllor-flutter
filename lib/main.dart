import 'package:flutter/material.dart';
import 'package:flutter_application_5/screens/searchpage.dart';

void main() {
  runApp(Application());
}

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SearchScreen() ,
      ),
    );
    }}
      
     
      
//      theme: ThemeData(
//        textTheme: TextTheme(
//          headline4: TextStyle(
//            fontFamily: 'GB',
//            color: Color.fromARGB(255, 238, 235, 235),
//            fontSize: 18,
//            fontWeight: FontWeight.bold,
//             
//          )
//        ),
//       elevatedButtonTheme: ElevatedButtonThemeData(
//         style: ElevatedButton.styleFrom(
//      primary: Color(0xffF35383),
//    shape: RoundedRectangleBorder(
//      borderRadius: BorderRadius.circular(13)
//    ),
//    textStyle: TextStyle(
//      fontFamily: 'GB',fontWeight: FontWeight.w700,fontSize: 16
//    )
//   ),
//        )
//      ),
//     debugShowCheckedModeBanner: false,
//      home: splashscreen(),
//    );
//  }
//}
//class splashscreen extends StatelessWidget {
//  const splashscreen({Key? key}) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      decoration: const BoxDecoration(
//        image: DecorationImage(
//          repeat: ImageRepeat.repeat,
//          image: AssetImage('images/pattern1.png'),
//        ),
//      ),
//          child: Scaffold(
//      backgroundColor: Colors.transparent,
//      body: Stack(
//        alignment: AlignmentDirectional.center,
//          children: [
//            Padding(
//              padding: const EdgeInsets.symmetric(horizontal: 7),
//              child: Center(
//                child: Container(
//                  width: 155,
//                  height: 77,
//                  child: Image(
//                  image: AssetImage('images/logo_splash.png'),
//                ),
//                )
//              ),
//            ),
//            Positioned(
//              bottom: 30,
//              child: Column(
//                children: [
//                  Text('from',style: TextStyle(
//                    fontWeight: FontWeight.bold,
//                    fontSize: 21,
//                    color: Color.fromARGB(255, 143, 149, 150)
//                  ),),
//                  Text('E.D company',style: TextStyle(
//                    fontWeight: FontWeight.bold,
//                    fontSize: 19,
//                    color: Color.fromARGB(255, 7, 181, 211)),),
//                     Center(
//                       child: TextButton(onPressed: (){
//                       Navigator.push(
//                                 context,
//                                MaterialPageRoute(builder: (context) => const loginscreen()),
//                                
//                              );
//                              automaticallyImplyLeading: false;
//                              }, child: Text('',style:TextStyle(color: Colors.amber),)),
//                     )
//                ],
//              ),
//              
//            )
//          ],
//
//        
//        ),
//     ),
//    );
//     
//        
//        
//     
//  }
//}
//
  