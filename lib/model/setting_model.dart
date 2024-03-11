import 'package:tic_tac_toe_app/controller/setting_controller.dart';

class SettingModel {
  final GridOpt gridOpt;
  final AlignOpt alignOpt;
  final MarkerOpt player1Marker;
  final ColorOpt player1Color;
  final MarkerOpt player2Marker;
  final ColorOpt player2Color;
  final TurnOpt firstPlayer;

  SettingModel({
      required this.gridOpt,
      required this.alignOpt,
      required this.player1Marker,
      required this.player1Color,
      required this.player2Marker,
      required this.player2Color,
      required this.firstPlayer,
    });
}
