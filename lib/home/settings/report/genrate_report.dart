import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'dart:io';

import 'package:tram_win_10/common/entities/data_entity.dart';
import 'package:tram_win_10/global.dart';



class GenrateReport {




  Future<void> SavePdf(String name) async {
    final Document pdf = Document(deflate: zlib.encode);
    List<RecordingDataEntity> data = await Global.dataBaseService.getRecordingsForName(name);

    final ByteData IR_LOGO =
    await rootBundle.load("assets/images/indian_railways_logo.png");
    Uint8List ir_logo = (IR_LOGO).buffer.asUint8List();
    final ByteData RKI_LOGO = await rootBundle.load("assets/images/logo3.png");
    Uint8List rki_logo = (RKI_LOGO).buffer.asUint8List();

    pdf.addPage(
      MultiPage(
        pageTheme: PageTheme(
          pageFormat: PdfPageFormat.a4.copyWith( // Set paper size to A4
            marginBottom: 0.2 * PdfPageFormat.cm,
          ),
          orientation: PageOrientation.landscape,
        ),
        header: (final context) {
          return PdfHeader(ir_logo, rki_logo, name);
        },
        footer: (final context) {
          return PdfFooter();
        },

        build: (Context context) {
          return [
            buildDataTable(data),
          ];
        },
      ),
    );

    await Printing.sharePdf(bytes: await pdf.save(), filename: '$name.pdf');

  }

  Widget buildDataTable(List<RecordingDataEntity> data) {
    return Column(children: [
      for (int index = 1; index < data.length; index++)
        Container(
            margin: EdgeInsets.only(bottom: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(child: DataCell(index.toString())),
                Expanded(child: DataCell((int.parse(data[index].actual_distance.toString())/100000).toStringAsFixed(3)+"km")),
                Expanded(child: DataCell((int.parse(data[index].relative_distance.toString())/100000).toStringAsFixed(3)+"km")),
                Expanded(child: DataCell(data[index].date_time.toString()),flex: 2),
                Expanded(child: DataCell(data[index].gauge.toString())),
                Expanded(child: DataCell(data[index].level.toString())),
                Expanded(child: DataCell(data[index].gradient.toString())),
                Expanded(child: DataCell(data[index].twist.toString())),
                Expanded(child: DataCell(data[index].temp.toString())),
                Expanded(child: DataCell(data[index].latitude.toString())),
                Expanded(child: DataCell(data[index].longitude.toString())),
              ],
            )),
    ]);
  }
}

class PdfFooter extends StatelessWidget{
  @override
  Widget build(Context context){
    return Column(children: [
      Container(
          height: 2,
          color: PdfColors.red,
          margin: EdgeInsets.only(bottom:4)),
      Container(
          padding: EdgeInsets.only(left: 12,right: 12),
          margin: EdgeInsets.only(bottom: 12),
          child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:
              [
                Text("1"),
                Text("Robokrit India Private limited"),
              ]

          ))
    ]);
  }
}

class PdfHeader extends StatelessWidget{
  final String date;
  final Uint8List ir_logo;
  final Uint8List rki_logo;

  PdfHeader(this.ir_logo,this.rki_logo ,this.date);

  @override
  Widget build(Context context) {

    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Center(
          child: Container(
              height: 72, width: 72, child: Image(MemoryImage(ir_logo))),
        ),
        Center(
            child: Column(children: [
              Text("T R A M (Track Measuring System)",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: PdfColors.red)),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("ZONE: ${Global.storageService.getZone()},"),
                    SizedBox(width: 4),
                    Text("DIV: ${Global.storageService.getDiv()},"),
                    SizedBox(width: 4),
                    Text("SEC: ${Global.storageService.getSec()}"),

                  ]),

              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children:[Text('Date: $date,'),
                    SizedBox(width: 4),
                    Text("Device: ${Global.storageService.getDesignatiton()}"),]),
              Text("Operator Name : ${Global.storageService.getOperatorName()} (${Global.storageService.getDesignatiton()})")
            ])),
        Center(
          child: Container(
              height: 72, width: 72, child: Image(MemoryImage(rki_logo))),
        ),
      ]),
      Container(
        margin: EdgeInsets.only(top: 16),
        height: 1,),
      Container(
        color: PdfColors.red,
        padding: EdgeInsets.only(left: 8),
        height: 24,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(child: HeaderCell("S. No.")),
            Expanded(child: HeaderCell("A-distance")),
            Expanded(child: HeaderCell("R-distance")),
            Expanded(child:  HeaderCell("Date        Time"),flex: 2),
            Expanded(child: HeaderCell("Gauge")),
            Expanded(child: HeaderCell("Level")),
            Expanded(child: HeaderCell("Grnt")),
            Expanded(child: HeaderCell("Twist")),
            Expanded(child: HeaderCell("Temp")),
            Expanded(child:HeaderCell("Lat")),
            Expanded(child:HeaderCell("Long"))
          ],
        ),
      ),
      Container(
          height: 1,
          margin: EdgeInsets.only(bottom: 12)),
    ]);

  }

}

class HeaderCell extends StatelessWidget {
  final String text;

  HeaderCell(this.text);

  @override
  Widget build(Context context) {
    return Container(
      margin: EdgeInsets.only(right: 1),
      child: Center(
        child: Text(
          text,
          style: TextStyle(fontWeight: FontWeight.bold,color:PdfColors.white),
        ),
      ),
    );
  }


}

class DataCell extends StatelessWidget {
  final String text;

  DataCell(this.text);

  @override
  Widget build(Context context) {
    return Container(
      margin: EdgeInsets.only(right: 1),
      child: Center(
        child: Text(text),
      ),
    );
  }

}

