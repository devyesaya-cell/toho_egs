import 'dart:io';

void main() {
  final darkColors = [
        {"name": "cardBackground", "hex": "#1A2235"},
        {"name": "cardBorder", "hex": "#2A3750"},
        {"name": "titleColor", "hex": "#FFFFFF"},
        {"name": "subtitleColor", "hex": "#8A94A6"},
        {"name": "labelColor", "hex": "#00BCD4"},
        {"name": "inputFill", "hex": "#222B40"},
        {"name": "inputBorder", "hex": "#2A3040"},
        {"name": "inputFocusedBorder", "hex": "#00BCD4"},
        {"name": "inputHintText", "hex": "#8A94A6"},
        {"name": "inputTextColor", "hex": "#FFFFFF"},
        {"name": "inputIconColor", "hex": "#8A94A6"},
        {"name": "dropdownBackground", "hex": "#1A2235"},
        {"name": "dropdownIcon", "hex": "#00BCD4"},
        {"name": "modeButtonSelectedBackground", "hex": "#00BCD4"},
        {"name": "primaryButtonBackground", "hex": "#00BCD4"},
        {"name": "primaryButtonText", "hex": "#0D1118"},
        {"name": "pageBackground", "hex": "#0D1118"},
        {"name": "surfaceColor", "hex": "#1A2235"},
        {"name": "textOnSurface", "hex": "#FFFFFF"},
        {"name": "textSecondary", "hex": "#8A94A6"},
        {"name": "loadingIndicatorColor", "hex": "#00BCD4"},
        {"name": "appBarBackground", "hex": "#1C2030"},
        {"name": "appBarForeground", "hex": "#FFFFFF"},
        {"name": "appBarAccent", "hex": "#00BCD4"},
        {"name": "iconBoxBackground", "hex": "#222B40"},
        {"name": "iconBoxIcon", "hex": "#00BCD4"},
        {"name": "menuBackground", "hex": "#0D1118"},
        {"name": "menuBorder", "hex": "#2A3750"},
        {"name": "menuSelectedBackground", "hex": "#1C2030"},
        {"name": "menuSelectedIcon", "hex": "#00BCD4"},
        {"name": "dateTimeGradientStart", "hex": "#1A2235"},
        {"name": "dateTimeGradientEnd", "hex": "#0D1118"},
        {"name": "cardSurface", "hex": "#1A2235"},
        {"name": "cardBorderColor", "hex": "#2A3750"},
        {"name": "dialogBackground", "hex": "#1A2235"},
        {"name": "dividerColor", "hex": "#2A3040"},
        {"name": "mapGrid", "hex": "#162032"}
  ];

  final lightColors = [
        {"name": "cardBackground", "hex": "#FFFFFF"},
        {"name": "cardBorder", "hex": "#00BCD4"},
        {"name": "titleColor", "hex": "#1A1A2E"},
        {"name": "subtitleColor", "hex": "#7A8290"},
        {"name": "labelColor", "hex": "#00BCD4"},
        {"name": "inputFill", "hex": "#F5F7FA"},
        {"name": "inputBorder", "hex": "#D0D4DA"},
        {"name": "inputFocusedBorder", "hex": "#00BCD4"},
        {"name": "inputHintText", "hex": "#7A8290"},
        {"name": "inputTextColor", "hex": "#1A1A2E"},
        {"name": "inputIconColor", "hex": "#7A8290"},
        {"name": "dropdownBackground", "hex": "#FFFFFF"},
        {"name": "dropdownIcon", "hex": "#00BCD4"},
        {"name": "modeButtonSelectedBackground", "hex": "#00BCD4"},
        {"name": "primaryButtonBackground", "hex": "#00BCD4"},
        {"name": "primaryButtonText", "hex": "#FFFFFF"},
        {"name": "pageBackground", "hex": "#E8ECF0"},
        {"name": "surfaceColor", "hex": "#FFFFFF"},
        {"name": "textOnSurface", "hex": "#1A1A2E"},
        {"name": "textSecondary", "hex": "#7A8290"},
        {"name": "loadingIndicatorColor", "hex": "#00BCD4"},
        {"name": "appBarBackground", "hex": "#FFFFFF"},
        {"name": "appBarForeground", "hex": "#1A1A2E"},
        {"name": "appBarAccent", "hex": "#00BCD4"},
        {"name": "iconBoxBackground", "hex": "#F5F7FA"},
        {"name": "iconBoxIcon", "hex": "#00BCD4"},
        {"name": "menuBackground", "hex": "#FFFFFF"},
        {"name": "menuBorder", "hex": "#D0D4DA"},
        {"name": "menuSelectedBackground", "hex": "#F5F7FA"},
        {"name": "menuSelectedIcon", "hex": "#00BCD4"},
        {"name": "dateTimeGradientStart", "hex": "#F5F7FA"},
        {"name": "dateTimeGradientEnd", "hex": "#FFFFFF"},
        {"name": "cardSurface", "hex": "#FFFFFF"},
        {"name": "cardBorderColor", "hex": "#00BCD4"},
        {"name": "dialogBackground", "hex": "#FFFFFF"},
        {"name": "dividerColor", "hex": "#D0D4DA"},
        {"name": "mapGrid", "hex": "#D5DCE4"}
  ];

  List<String> xml = [
    '<mxfile version="22.1.2" type="device">', 
    '<diagram id="diagram1" name="AppTheme">', 
    '<mxGraphModel dx="1200" dy="1200" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="1200" pageHeight="2300" math="0" shadow="0">',
    '<root>',
    '<mxCell id="0" />',
    '<mxCell id="1" parent="0" />'
  ];

  int darkH = darkColors.length * 60 + 60;
  int lightH = lightColors.length * 60 + 60;

  xml.add('<mxCell id="dark_theme" value="DARK THEME (SCADA)" style="swimlane;whiteSpace=wrap;html=1;fillColor=#1C2030;fontColor=#FFFFFF;startSize=40;strokeColor=#2A3750;" vertex="1" parent="1"><mxGeometry x="50" y="50" width="300" height="$darkH" as="geometry" /></mxCell>');
  xml.add('<mxCell id="light_theme" value="LIGHT THEME (SCADA)" style="swimlane;whiteSpace=wrap;html=1;fillColor=#F5F7FA;fontColor=#1A1A2E;startSize=40;strokeColor=#D0D4DA;" vertex="1" parent="1"><mxGeometry x="400" y="50" width="300" height="$lightH" as="geometry" /></mxCell>');

  int yOffset = 60;
  for (int i=0; i<darkColors.length; i++) {
    String name = darkColors[i]["name"]!;
    String hex = darkColors[i]["hex"]!;
    String tColor = ["#00BCD4", "#FFFFFF"].contains(hex) ? "#000000" : "#FFFFFF";
    xml.add('<mxCell id="dark_$i" value="$name&#10;$hex" style="rounded=1;whiteSpace=wrap;html=1;fillColor=$hex;fontColor=$tColor;strokeColor=#FFFFFF;" vertex="1" parent="dark_theme"><mxGeometry x="30" y="$yOffset" width="240" height="40" as="geometry" /></mxCell>');
    yOffset += 50;
  }

  yOffset = 60;
  for (int i=0; i<lightColors.length; i++) {
    String name = lightColors[i]["name"]!;
    String hex = lightColors[i]["hex"]!;
    String tColor = ["#1A1A2E", "#7A8290"].contains(hex) ? "#FFFFFF" : "#000000";
    xml.add('<mxCell id="light_$i" value="$name&#10;$hex" style="rounded=1;whiteSpace=wrap;html=1;fillColor=$hex;fontColor=$tColor;strokeColor=#000000;" vertex="1" parent="light_theme"><mxGeometry x="30" y="$yOffset" width="240" height="40" as="geometry" /></mxCell>');
    yOffset += 50;
  }

  xml.addAll(['</root>', '</mxGraphModel>', '</diagram>', '</mxfile>']);
  
  final dir = Directory('c:/apps/toho_EGS/docs');
  if (!dir.existsSync()) {
    dir.createSync(recursive: true);
  }
  final file = File('c:/apps/toho_EGS/docs/app_theme.drawio');
  file.writeAsStringSync(xml.join('\n'));
  print('Done');
}
