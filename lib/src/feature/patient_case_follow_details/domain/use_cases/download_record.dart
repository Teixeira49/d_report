import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../../../../core/config/styles/documents_text_theme.dart';
import '../../../../core/helpers/helpers.dart';
import '../../../../core/network/error/failures.dart';
import '../../../../core/utils/constants/export_file_constants.dart';
import '../entities/downloader_config.dart';
import '../entities/follows_detailed_case.dart';

class DownloadCaseFollowRecordUseCase {
  Future<Either<Failure, Document>> call(FollowDetailedCase followDetailedCase,
      DownloaderConfig downloaderConfig, String patName,
      [Map<String, dynamic>? patDetails]) async {
    final image = MemoryImage(
        (await rootBundle.load(assetLogoRoute)).buffer.asUint8List());

    try {
      final pdf = Document();

      pdf.addPage(MultiPage(
        pageTheme: pageTheme,
        header: (Context context) => customDocHeader(
            pageTheme, image, followDetailedCase, patName, patDetails),
        build: (Context context) => [
          titleDoc(),
          bodyDocDataDetails(followDetailedCase),
          if (patDetails != null && downloaderConfig.addPatientDetails)
            bodyDocPatientDetails(patDetails),
          bodyDocFollowDesc(followDetailedCase),
          if (downloaderConfig.addDoctorSign) Spacer(),
          if (downloaderConfig.addDoctorSign) signedDocument(followDetailedCase)
        ],
        footer: (Context context) => customDocFooter(),
      ));

      return Right(pdf);
    } catch (e) {
      return Left(LocalProcessFailure(e.toString()));
    }
  }

  final pageTheme = const PageTheme(
    pageFormat: PdfPageFormat.a4,
    orientation: PageOrientation.portrait,
    //buildBackground: (context) {
    //}
  );

  static Widget customDocHeader(
          PageTheme pageTheme,
          image,
          FollowDetailedCase followDetailedCase,
          String patName,
          Map<String, dynamic>? patDetails) =>
      Header(
        padding: const EdgeInsets.symmetric(vertical: 0.10),
        child: Container(
            padding: const EdgeInsets.all(spaceHeight),
            child: Table(
              children: [
                TableRow(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      Expanded(
                          flex: 1,
                          child: Image(
                            image,
                            fit: BoxFit.cover,
                            width: pageTheme.pageFormat.availableWidth *
                                proportionImage,
                            height: pageTheme.pageFormat.availableWidth *
                                proportionImage,
                          )),
                      Expanded(
                        flex: 2,
                        child: Text(headerName,
                            textAlign: TextAlign.center,
                            style: AppTextStyle.mainTitleBlack),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          customTextIdentifier(
                              followDetailedCase, patName, patDetails),
                          textAlign: TextAlign.end,
                          style: AppTextStyle.headerDecoratedBlack,
                        ),
                      )
                    ])
              ],
            )),
      );

  static String customTextIdentifier(FollowDetailedCase followDetailedCase,
      String patName, Map<String, dynamic>? patDetails) {
    return '''$patName
    ${patDetails != null ? 'Edad: ${Helper.getAgeByDateInString(patDetails['birthday'])} - Peso: ${Helper.writeWeightByInt(patDetails['patWeight'])} Kg' : 'Re. Seguimiento'}
    Historia: ${followDetailedCase.cafId}
    F.S: ${Helper.cutDateByString(followDetailedCase.cafReportDate)}''';
  }

  static Widget customDocFooter() => Footer(
          trailing: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: Text(
                'Reporte emitido el:\n${Helper.getDateWithoutHour(DateTime.now())} ',
                textAlign: TextAlign.end)),
        Container(
          height: spaceSizeQRBar,
          width: spaceSizeQRBar,
          child: BarcodeWidget(
            barcode: Barcode.qrCode(),
            data: footerQRData,
          ),
        ),
      ]));

  static Widget titleDoc() => Center(
        child: Column(children: [
          Container(
              child: Text('Informe Evolutivo:',
                  style: AppTextStyle.mediumTitleBlack)),
          SizedBox(height: spaceHeightTitle)
        ]),
      );

  static Widget bodyDocPatientDetails(Map<String, dynamic> patDetails) =>
      Column(children: [
        Bullet(
          text: "Detalles del Paciente:",
          textAlign: TextAlign.justify,
          style: AppTextStyle.smallTitleBlack,
        ),
        SizedBox(height: spaceHeight),
        Table(children: [
              TableRow(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    Flexible(
                        flex: 1,
                        child: RichText(
                            textAlign: TextAlign.justify,
                            text: TextSpan(
                                text: 'Altura: ',
                                style: AppTextStyle.smallTitleBlack,
                                children: [
                                  TextSpan(
                                    text:
                                        '${Helper.writeHeightByInt(patDetails['patHeight'])} mts',
                                    style: AppTextStyle.smallBlack,
                                  )
                                ]))),
                    Flexible(
                        flex: 1,
                        child: RichText(
                            textAlign: TextAlign.justify,
                            text: TextSpan(
                                text: 'Peso: ',
                                style: AppTextStyle.smallTitleBlack,
                                children: [
                                  TextSpan(
                                    text:
                                        '${Helper.writeWeightByInt(patDetails['patWeight'])} kg',
                                    style: AppTextStyle.smallBlack,
                                  )
                                ]))),
                    Flexible(
                        flex: 1,
                        child: RichText(
                            textAlign: TextAlign.justify,
                            text: TextSpan(
                                text: 'Grupo Sanguineo: ',
                                style: AppTextStyle.smallTitleBlack,
                                children: [
                                  TextSpan(
                                    text: '${patDetails['bloodType']}',
                                    style: AppTextStyle.smallBlack,
                                  )
                                ]))),
                  ])
            ]),
        SizedBox(height: spaceHeight / 1.5),
        Divider(
          color: PdfColors.grey,
        ),
        SizedBox(height: spaceHeight / 1.5),
          ]);

  static Widget bodyDocDataDetails(FollowDetailedCase followDetailedCase) =>
      Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Bullet(
              text: "Informacion del Caso Seguido:",
              textAlign: TextAlign.justify,
              style: AppTextStyle.smallTitleBlack,
            ),
            SizedBox(height: spaceHeight),
            RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(children: [
                  TextSpan(
                    text: "Paciente: ",
                    style: AppTextStyle.smallTitleBlack,
                  ),
                  TextSpan(
                    text: followDetailedCase.docFullName,
                    style: AppTextStyle.smallBlack,
                  ),
                  TextSpan(
                    text: "\n\nFecha de Emision: ",
                    style: AppTextStyle.smallTitleBlack,
                  ),
                  TextSpan(
                    text: followDetailedCase.cafReportDate,
                    style: AppTextStyle.smallBlack,
                  ),
                  if (followDetailedCase.cafReportDate ==
                      followDetailedCase.cafReportUpdateTime)
                    TextSpan(
                        text:
                            ' (Actualizado: El ${(followDetailedCase.cafReportUpdateTime)})',
                        style: AppTextStyle.smallBlack),
                  TextSpan(
                    text: "\n\nAutor del Reporte: ",
                    style: AppTextStyle.smallTitleBlack,
                  ),
                  TextSpan(
                    text: followDetailedCase.docFullName,
                    style: AppTextStyle.smallBlack,
                  ),
                ])),
            SizedBox(height: spaceHeight / 1.5),
            Divider(
              color: PdfColors.grey,
            ),
            SizedBox(height: spaceHeight / 1.5),
          ]);

  static Widget bodyDocFollowDesc(FollowDetailedCase followDetailedCase) =>
      Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Bullet(
              text: "Informacion sobre Evolucion del Caso:",
              textAlign: TextAlign.justify,
              style: AppTextStyle.smallTitleBlack,
            ),
            SizedBox(height: spaceHeight),
            RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(children: [
                  TextSpan(
                    text: "Titulo: ",
                    style: AppTextStyle.smallTitleBlack,
                  ),
                  TextSpan(
                    text: followDetailedCase.cafReportTitle,
                    style: AppTextStyle.smallBlack,
                  ),
                  TextSpan(
                    text: "\n\nDescripcion: ",
                    style: AppTextStyle.smallTitleBlack,
                  ),
                  TextSpan(
                    text: followDetailedCase.cafReportInfo,
                    style: AppTextStyle.smallBlack,
                  ),
                ])),
          ]);

  static Widget signedDocument(FollowDetailedCase followDetailedCase) =>
      Column(mainAxisSize: MainAxisSize.min, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                    text: 'Firmado: ',
                    style: AppTextStyle.smallTitleBlack,
                    children: [
                      TextSpan(
                        text: '\nDoc. ${followDetailedCase.docFullName}',
                        style: AppTextStyle.smallBlack,
                      ),
                      TextSpan(
                        text: ' (${followDetailedCase.docSpecialty}).',
                        style: AppTextStyle.smallBlack,
                      )
                    ])),
          ],
        ),
        SizedBox(height: spaceHeight * 2),
      ]);
}
