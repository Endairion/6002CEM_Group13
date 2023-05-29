import 'package:flutter/material.dart';

class OngoingTripDetails extends StatelessWidget {
  const OngoingTripDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black87,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 65,
        title: Text(
          'Trip Details',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Container(
          width: size.width,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 12,
                ),
                GestureDetector(
                  onTap: () {
                    print("Clicked on Map");
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20), // Image border
                    child: Image.asset(
                      'assets/trips_nearby.png',
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  'Route Details',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.limeAccent.shade700,
                          ),
                          borderRadius: new BorderRadius.circular(30.0),
                          color: Colors.limeAccent[700],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'S',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    SizedBox(
                      width: 300,
                      child: Text(
                        'Address aksjdhkasd asjhd kajsdh asdhja sdkjashd kajsdh akjsdhaks dhkajs',
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: new BorderRadius.circular(30.0),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '1',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    SizedBox(
                      width: 300,
                      child: Text(
                        'Address aksjdhkasd asjhd kajsdh asdhja sdkjashd kajsdh akjsdhaks dhkajs',
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.green.shade900,
                          ),
                          borderRadius: new BorderRadius.circular(30.0),
                          color: Colors.green[900],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'D',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    SizedBox(
                      width: 300,
                      child: Text(
                        'Address aksjdhkasd asjhd kajsdh asdhja sdkjashd kajsdh akjsdhaks dhkajs',
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  width: double.infinity,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: new BorderRadius.circular(10),
                    color: Colors.grey[200],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.black87,
                                    size: 24,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text('Distance: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),),
                                  Text('0.0km'),
                                ],
                              ),
                            ),
                            Container(
                              width: 152,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.add_location_outlined,
                                    color: Colors.black87,
                                    size: 24,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text('Total Stops: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),),
                                  Text('1'),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.schedule,
                                    color: Colors.black87,
                                    size: 24,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text('ETA Time: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),),
                                  Text('00 min'),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.airline_seat_recline_normal,
                                    color: Colors.black87,
                                    size: 24,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text('Remaining Seats: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),),
                                  Text('2'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  'Passengers:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  width: double.infinity,
                  height: 130,
                  decoration: BoxDecoration(
                    borderRadius: new BorderRadius.circular(10),
                    color: Colors.grey[200],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.white,
                              child: Padding(
                                padding:
                                    const EdgeInsets.all(4), // Border radius
                                child: ClipOval(
                                    child: Image.asset('assets/app_logo.png')),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Container(
                              width: 150,
                              child: Text(
                                'Elizabeth Tan',
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            Container(
                              width: 110,
                              child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      side: BorderSide(
                                    width: 2.0,
                                    color: Colors.lightGreen,
                                  ),
                                  backgroundColor: Colors.white),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.done,
                                        color: Colors.lightGreen,
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text('Pickup',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.lightGreen,
                                      ),),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          width: 100,
                          height: 30,
                          child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.warning,
                                    color: Colors.amber,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Text('Report',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  width: double.infinity,
                  height: 130,
                  decoration: BoxDecoration(
                    borderRadius: new BorderRadius.circular(10),
                    color: Colors.grey[200],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.white,
                              child: Padding(
                                padding:
                                const EdgeInsets.all(4), // Border radius
                                child: ClipOval(
                                    child: Image.asset('assets/app_logo.png')),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Container(
                              width: 150,
                              child: Text(
                                'Elizabeth Tan',
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            Container(
                              width: 110,
                              child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      side: BorderSide(
                                        width: 2.0,
                                        color: Colors.lightGreen,
                                      ),
                                      backgroundColor: Colors.white),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.done,
                                        color: Colors.lightGreen,
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text('Pickup',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.lightGreen,
                                        ),),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          width: 100,
                          height: 30,
                          child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.warning,
                                    color: Colors.amber,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Text('Report',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  width: double.infinity,
                  height: 130,
                  decoration: BoxDecoration(
                    borderRadius: new BorderRadius.circular(10),
                    color: Colors.grey[200],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.white,
                              child: Padding(
                                padding:
                                const EdgeInsets.all(4), // Border radius
                                child: ClipOval(
                                    child: Image.asset('assets/app_logo.png')),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Container(
                              width: 150,
                              child: Text(
                                'Elizabeth Tan',
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            Container(
                              width: 110,
                              child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      side: BorderSide(
                                        width: 2.0,
                                        color: Colors.lightGreen,
                                      ),
                                      backgroundColor: Colors.white),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.done,
                                        color: Colors.lightGreen,
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text('Pickup',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.lightGreen,
                                        ),),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          width: 100,
                          height: 30,
                          child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.warning,
                                    color: Colors.amber,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Text('Report',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),),
                                ],
                              )),
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
