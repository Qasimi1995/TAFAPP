import 'dart:isolate';
import 'dart:ui';

import 'package:advance_pdf_viewer_fork/advance_pdf_viewer_fork.dart';
import 'package:chem/localization/localization_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class Book_details extends StatefulWidget {
  final String book_detail;
  const Book_details({Key? key, required this.book_detail}) : super(key: key);

  @override
  _Book_detailsState createState() => _Book_detailsState();
}

class _Book_detailsState extends State<Book_details> {
  bool loading = true;
  PDFDocument? pdfDocument;
  double progress = 0;

  ReceivePort _receivePort = ReceivePort();

  static downloadingCallback(id, status, progress){
    //Looking up for a send port
    SendPort? sendPort =  IsolateNameServer.lookupPortByName("downloading");
    //sending the data
    sendPort?.send([id, status, progress]);

  }

  //Getting PDF and convert to PDFDocument using below function
  Future pdf_load() async {
    pdfDocument = await PDFDocument.fromURL(widget.book_detail);
    setState(() {
      loading = false;
    });
  }

  //All functions get called using initState
  @override
  void initState() {
    // TOO: implement initState
    super.initState();

    //register a send port for the other isolate
    IsolateNameServer.registerPortWithName(_receivePort.sendPort, "downloading");
    //listening for the data coming from other isolates
    _receivePort.listen((message) {
      setState(() {
        progress=message[2];
      });
    });
    FlutterDownloader.registerCallback(downloadingCallback);


    pdf_load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          getTranslated(context, 'Math_Forms_Reader'),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) =>
            orientation == Orientation.portrait ? Vertical() : Landscape(),
      ),
    );
  }

  Widget Vertical() {
    return Center(
      child: Container(
        child: Column(
          children: [
            Container(
                height: MediaQuery.of(context).size.height * 0.7,
                child: loading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : PDFViewer(document: pdfDocument!)),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: ElevatedButton.icon(
                onPressed: () async {
                  // Respond to button press
                  final status = await Permission.storage.request();
                  if (status.isGranted) {
                    final externalDirectory =
                     await getExternalStorageDirectory();
                      FlutterDownloader.enqueue(
                      url: widget.book_detail,
                      savedDir: externalDirectory!.path,
                      fileName: "Download",
                      showNotification: true,
                      openFileFromNotification: true,
                    );
                  } else {
                    print('permission denied');
                  }
                },
                icon: Icon(Icons.download, size: 18),
                label: Text(getTranslated(context, 'Download_PDF')),
              ),

            ),
            SizedBox(
              height: 5,
            ),
            //Text("$progress", style: TextStyle(fontSize: 30,),)

          ],
        ),
      ),
    );
  }

  Widget Landscape() {
    return Center(
      child: Container(
        child: Column(
          children: [
            Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 0.8,
                child: loading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : PDFViewer(document: pdfDocument!)),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: ElevatedButton.icon(
                  onPressed: () async {
                    // Respond to button press
                    final status = await Permission.storage.request();
                    if (status.isGranted) {
                      final externalDirectory =
                      await getExternalStorageDirectory();
                      final id = FlutterDownloader.enqueue(
                        url: widget.book_detail,
                        savedDir: externalDirectory!.path,
                        fileName: "Download",
                        showNotification: true,
                        openFileFromNotification: true,
                        
                      );
                    } else {
                      print('permission denied');
                    }
                  },
                icon: Icon(Icons.download, size: 18),
                label: Text(getTranslated(context, 'Download_PDF')),
              ),
            )
          ],
        ),
      ),
    );
  }
}
