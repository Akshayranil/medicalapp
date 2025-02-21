import 'package:flutter/material.dart';
import 'package:week7/profilepage/profile_page.dart';



class SlideScreen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        
          
             Padding(
              padding: EdgeInsets.only(right: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => SlideScreen3()));
                    },
                    child: Text('Skip >>',style: TextStyle(fontSize: 18),)),
                    ]),
            ),
            
        Image.asset('assets/images/exercise.jpg'),
        SizedBox(
          height: 30,
        ),
        Text(
          'The pain you feel today will be the ',
          style: TextStyle(
            fontSize: 20,
            fontStyle: FontStyle.italic,
          ),
        ),
        Text(
          'strength you feel tommorow... ',
          style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
        ),
      ]),
    );
  }
}

class SlideScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
              padding: EdgeInsets.only(right: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => SlideScreen3()));
                    },
                    child: Text('Skip >>',style: TextStyle(fontSize: 18),)),
                    ]),
            ),
          Image.asset('assets/images/tablets.jpg'),
          SizedBox(
            height: 30,
          ),
          Text('Taking your medication as prescribed is ',
              style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic)),
          Text(' like keeping your daily appointment ',
              style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic)),
          Text(' with your health....!',
              style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic)),
        ],
      ),
    );
  }
}

class SlideScreen3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset('assets/images/stethascope.webp'),
        SizedBox(
          height: 30,
        ),
        Text('Your health is our priority,',
            style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic)),
        Text(' we care about your life....',
            style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic)),
        SizedBox(
          height: 60,
        ),
        ElevatedButton.icon(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => MyProfile()));
            },
            label: Text(
              'Get Started',
              style: TextStyle(color: Colors.white, fontSize: 23),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              minimumSize: Size(200, 60),
            )),
      ]),
    );
  }
}
