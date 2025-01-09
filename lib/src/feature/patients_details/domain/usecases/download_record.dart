import 'package:d_report/src/feature/patients_details/domain/entities/case_report.dart';
import 'package:d_report/src/feature/patients_details/domain/entities/follows_detailed_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../../../../core/config/styles/documents_text_theme.dart';
import '../../../../core/helpers/helpers.dart';
import '../../../../core/network/error/failures.dart';
import '../../../../core/utils/constants/export_file_constants.dart';
import '../../../../core/utils/constants/fields_constants.dart';
import '../entities/patient.dart';

class DownloadPatientRecordUseCase {
  Future<Either<Failure, Document>> call(Patient patient, CaseReport caseReport,
      String docName, List<FollowDetailedCase>? followCases,
      [bool addDoctorSign = false,
      bool addPatDetails = false,
      String addFollows = 'Ninguno']) async {
    final image = MemoryImage(
        (await rootBundle.load(assetLogoRoute)).buffer.asUint8List());
    try {
      final pdf = Document();
      //final font = PdfFont.ttf(pdf.assetsFile, 'OpenSans-Regular.ttf');
      pdf.addPage(
        MultiPage(
          pageTheme: pageTheme,
          header: (Context context) =>
              customDocHeader(pageTheme, image, patient, caseReport),
          build: (Context context) => [
            titleDoc(caseReport.casEndFlag ?? selectorTitle),
            if (addPatDetails) moreAboutPatient(patient, caseReport),
            moreAboutCase(caseReport),
            if (addFollows != 'Ninguno' && followCases != null)
              moreAboutEvolutionCaseHeader(),
            if (addFollows != 'Ninguno' && followCases != null)
              moreAboutEvolutionCaseBody(followCases, addFollows),
            if (caseReport.casEndFlag ?? selectorTitle)
              moreAboutFinishCase(caseReport),
            if (addDoctorSign) Spacer(),
            if (addDoctorSign) signedDocument(docName),
          ],
          footer: (Context context) => customDocFooter(),
        ),
      );
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
          PageTheme pageTheme, image, Patient patient, CaseReport caseReport) =>
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
                          customTextIdentifier(patient, caseReport),
                          textAlign: TextAlign.end,
                          style: AppTextStyle.headerDecoratedBlack,
                        ),
                      )
                    ])
              ],
            )),
      );

  static String customTextIdentifier(Patient patient, CaseReport caseReport) {
    return '''${patient.getFullName()}
    Edad: ${Helper.getAgeByDateInString(patient.patBirthdayDate)} - Peso: ${Helper.writeWeight(caseReport.patWeight)} Kg
    Historia: ${caseReport.casId}
    F.I: ${Helper.getDateWithoutHour(DateTime.parse(caseReport.casEnterDate))}''';
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

  static Widget titleDoc(bool endCase) =>  Center(
      child: Column(children: [
        Container(
            child: Text(!endCase ? 'Informe de Avance:' : 'Informe de Egreso:',
                style: AppTextStyle.mediumTitleBlack),),
        SizedBox(height: spaceHeightTitle),
      ]));

  static Widget moreAboutPatient(Patient patient, CaseReport caseReport) =>
      Column(children: [
        Table(children: [
          TableRow(
              verticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                        text: 'Grupo sanguineo:',
                        style: AppTextStyle.smallTitleBlack,
                        children: [
                          TextSpan(
                            text: ' ${patient.patBloodType}.',
                            style: AppTextStyle.smallTableBlack,
                          ),
                        ])),
                RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                        text: 'Genero:',
                        style: AppTextStyle.smallTitleBlack,
                        children: [
                          TextSpan(
                            text:
                                ' ${patient.patGender == genreType[0] ? genreTypeFull[0] : patient.patGender == genreType[1] ? genreTypeFull[1] : genreTypeFull[2]}.',
                            style: AppTextStyle.smallTableBlack,
                          ),
                        ])),
                RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                        text: 'Cumpleaños:',
                        style: AppTextStyle.smallTitleBlack,
                        children: [
                          TextSpan(
                            text:
                                ' ${Helper.getDateWithoutHour(DateTime.parse(patient.patBirthdayDate))}.',
                            style: AppTextStyle.smallTableBlack,
                          ),
                        ]))
              ]),
          TableRow(
              verticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                        text: 'Peso:',
                        style: AppTextStyle.smallTitleBlack,
                        children: [
                          TextSpan(
                            text: ' ${Helper.writeWeight(caseReport.patWeight)} kgs.',
                            style: AppTextStyle.smallTableBlack,
                          )
                        ])),
                RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                        text: 'Altura:',
                        style: AppTextStyle.smallTitleBlack,
                        children: [
                          TextSpan(
                            text: '${Helper.writeHeight(caseReport.patHeight)} mts.',
                            style: AppTextStyle.smallTableBlack,
                          )
                        ])),
                RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                        text: 'Habitacion:',
                        style: AppTextStyle.smallTitleBlack,
                        children: [
                          TextSpan(
                            text: ' ${caseReport.casActualRoom}.',
                            style: AppTextStyle.smallTableBlack,
                          )
                        ]))
              ])
        ]),
        SizedBox(height: spaceHeight),
      ]);

  static Widget moreAboutCase(CaseReport caseReport) => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              textAlign: TextAlign.justify,
              text: TextSpan(children: [
                TextSpan(
                    text: 'Motivo de Consulta: ',
                    style: AppTextStyle.smallTitleBlack),
                TextSpan(
                    text:
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam',
                    style: AppTextStyle.smallBlack), // TODO CHANGE
                TextSpan(
                    text:
                        ' (${caseReport.casMethodOfEntry == 'New' ? 'Ingresado' : 'Referido'} ${Helper.getDateSMSByString(caseReport.casEnterDate, true)}).',
                    style: AppTextStyle.smallBlack),
              ]),
            ),
            SizedBox(height: spaceHeight),
            RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(children: [
                  TextSpan(
                    text: 'Examen fisico inicial: ',
                    style: AppTextStyle.smallTitleBlack,
                  ),
                  TextSpan(
                    text:
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                    style: AppTextStyle.smallBlack,
                  ),
                ])),
            SizedBox(height: spaceHeight),
            RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(children: [
                  TextSpan(
                    text: 'Sintomatologia Inicial: ',
                    style: AppTextStyle.smallTitleBlack,
                  ),
                  TextSpan(
                    text: '${caseReport.casSymptomatology}.',
                    style: AppTextStyle.smallBlack,
                  )
                ])),
            SizedBox(height: spaceHeight),
            RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(children: [
                  TextSpan(
                    text: 'Diagnostico de Ingreso: ',
                    style: AppTextStyle.smallTitleBlack,
                  ),
                  TextSpan(
                    text: '${caseReport.casDiagnosis}.',
                    style: AppTextStyle.smallBlack,
                  )
                ])),
            SizedBox(height: spaceHeight / 3),
          ]);

  static Widget moreAboutEvolutionCaseHeader() => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(
              color: PdfColors.grey,
            ),
            SizedBox(height: spaceHeight / 3),
            Text(
              'Seguimiento del Caso:\n\n',
              style: AppTextStyle.smallTitleBlack,
            )
          ]);

  static Widget moreAboutEvolutionCaseBody(
          List<FollowDetailedCase> followCases, String addFollows) =>
      ListView.builder(
          itemCount: followCases.length,
          itemBuilder: (context, index) {
            return Container(
              alignment: Alignment.topLeft,
                child: RichText(
                    textAlign: TextAlign.justify,
                    //textDirection: TextDirection.ltr,
                    text: TextSpan(children: [
                      WidgetSpan(
                        child: Container(
                          width: 5,
                          height: 5,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 2),
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: PdfColors.black),
                        ),
                      ),
                      TextSpan(
                        text: '${followCases[index].cafReportTitle}: ',
                        style: AppTextStyle.smallTitleBlack,
                      ),
                      TextSpan(
                        text: followCases[index].cafReportInfo,
                        //followCases[index].cafReportType,
                        style: AppTextStyle.smallBlack,
                      ),
                      if (addFollows == addCaseFollowType[2])
                        TextSpan(
                            text: '. De: ${followCases[index].docFullName}',
                            style: AppTextStyle.smallSubTitleBlack),
                      TextSpan(
                          text:
                              ' (${followCases[index].cafReportDate}${followCases[index].cafReportUpdateTime != followCases[index].cafReportDate ? ' - Actualizado el ${followCases[index].cafReportDate}' : null}).\n\n',
                          style: AppTextStyle.smallSubTitleBlack),
                    ])));
          });

  static Widget moreAboutFinishCase(CaseReport caseReport) => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: spaceHeight / 3),
            Divider(color: PdfColors.grey),
            SizedBox(height: spaceHeight / 3),
            Table(children: [
              TableRow(children: [
                RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(children: [
                      TextSpan(
                        text: 'Fecha de Egreso: ',
                        style: AppTextStyle.smallTitleBlack,
                      ),
                      TextSpan(
                        text: '${caseReport.casEndDate}.',
                        style: AppTextStyle.smallBlack,
                      )
                    ])),
                RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(children: [
                      TextSpan(
                        text: 'Razon de Egreso: ',
                        style: AppTextStyle.smallTitleBlack,
                      ),
                      TextSpan(
                        text: '${caseReport.casEndReason}.',
                        style: AppTextStyle.smallBlack,
                      )
                    ])),
              ])
            ]),
            SizedBox(height: spaceHeight),
            RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(children: [
                  TextSpan(
                    text: 'Diagnostico de Salida: ',
                    style: AppTextStyle.smallTitleBlack,
                  ),
                  TextSpan(
                    text: '${caseReport.casEndDiagnosis}.',
                    style: AppTextStyle.smallBlack,
                  )
                ])),
            SizedBox(height: spaceHeight),
          ]);

  static Widget signedDocument(String docName) =>
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
                        text: '\nDoc. $docName.',
                        style: AppTextStyle.smallBlack,
                      ),
                    ])),
          ],
        ),
        SizedBox(height: spaceHeight * 2),
      ]);
}
