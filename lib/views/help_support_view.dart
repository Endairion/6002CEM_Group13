import 'package:flutter/material.dart';


class HelpSupport extends StatelessWidget {
  const HelpSupport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Help and Support"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
        backgroundColor: const Color.fromRGBO(155, 214, 17, 1),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(10,30,10,10),
            padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(227, 243, 217, 1),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(227, 243, 217, 1),
                  blurRadius: 4,
                  offset: Offset(0, 4),
                )
              ],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Find more help',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Contact us through email:',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Spacer(),
                    Text(
                      'vtumpangapp@gmail.com',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green[900],
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 64),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: const Color.fromRGBO(155, 214, 17, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
              ),
              child: const Text(
                'Email Us',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'We will respond in 2-3 working days',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 16),
          Image.asset(
            'assets/prof_team.jpg',
            width: 550,
            height: 140,
          ),
          SizedBox(height: 16),
          const Text(
            'We’re here to help!',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 16),
          Image.asset(
            'assets/prof_team2.jpg',
            width: 500,
            height: 135,
          )
        ],
      ),
    );
  }
}





