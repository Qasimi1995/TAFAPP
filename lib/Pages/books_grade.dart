import 'package:chem/localization/localization_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'books_page.dart';

class Books_Grade extends StatefulWidget {
  const Books_Grade({Key? key}) : super(key: key);

  @override
  Books_GradeState createState() => Books_GradeState();
}

class Books_GradeState extends State<Books_Grade> {
   int numb = 1;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          getTranslated(context, 'Books'),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                color: Colors.orange,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/Icons/Chem_books.svg',
                    height: 40.0,
                    width: 40.0,
                  ),
                  Text(
                    getTranslated(context, 'Books'),
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  )
                ],
              ),
            ),
          ),
          //Title Listile

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.orange,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(
                    '1',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                title: Text('کتاب های کیمیا صنف اول',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Books_page(value:numb)));
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.orange,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(
                    '2',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                title: Text(
                  'Grade 1',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {},
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.orange,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(
                    '3',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                title: Text('Grade 1',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {},
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.orange,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(
                    '4',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                title: Text('Grade 1',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {},
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.orange,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(
                    '5',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                title: Text('Grade 1',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {},
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.orange,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(
                    '6',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                title: Text('Grade 1',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {},
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.orange,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(
                    '7',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                title: Text('Grade 1',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {},
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.orange,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(
                    '8',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                title: Text('Grade 1',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {},
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.orange,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(
                    '9',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                title: Text('Grade 1',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {},
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.orange,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(
                    '10',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                title: Text('Grade 1',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {},
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.orange,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(
                    '11',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                title: Text('Grade 1',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {},
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.orange,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(
                    '12',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                title: Text('Grade 1',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
