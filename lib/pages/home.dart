import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  Map locationData = {};
  
  @override
  Widget build(BuildContext context) {
    
    locationData = locationData.isNotEmpty ? locationData: ModalRoute.of(context).settings.arguments; //gets arguments from loading screen
    
    //set background depending on city and night/day time
    String cityLower = locationData['location'].toString().toLowerCase().replaceAll(' ', '_');
    String bgImage = locationData['isDaytime'] ? cityLower + '_day.png' : cityLower + '_night.png';
    Color contrastText = locationData['isDaytime'] ? Colors.black : Colors.white;

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$bgImage'),
              fit: BoxFit.cover,
            )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    locationData['location'],
                    style: TextStyle(
                      fontSize: 30,
                      letterSpacing: 2,
                      color: contrastText,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                locationData['time'],
                style: TextStyle(
                  fontSize: 50,
                  color: contrastText,
                )
              ),
              
              FlatButton.icon(
                onPressed: () async {
                  dynamic result = await Navigator.pushNamed(context, '/location');
                  setState(() {
                    locationData = {
                      'time': result['time'],
                      'location': result['location'],
                      'isDaytime': result['isDaytime'],
                      'flag': result['flag'],
                    };
                  });
                }, 
                icon: Icon(
                  Icons.edit_location, 
                  color: contrastText,
                ), 
                label: Text(
                  'Edit Location',
                  style: TextStyle(
                    color: contrastText,
                  )
                )
              ),
            ],
          ),
        )
      ),
    );
  }
}