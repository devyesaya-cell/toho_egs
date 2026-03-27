import os

def gen_drawio():
    dark_colors = [
        ("cardBackground", "#1E241E"),
        ("cardBorder", "#1AFFFFFF"),
        ("titleColor", "#FFFFFF"),
        ("subtitleColor", "#8AFFFFFF"),
        ("labelColor", "#69F0AE"),
        ("inputFill", "#0DFFFFFF"),
        ("inputBorder", "#3DFFFFFF"),
        ("inputFocusedBorder", "#00FF00"),
        ("inputHintText", "#3DFFFFFF"),
        ("inputTextColor", "#FFFFFF"),
        ("inputIconColor", "#8AFFFFFF"),
        ("dropdownBackground", "#1E241E"),
        ("modeButtonSelectedBackground", "#00C853"),
        ("primaryButtonBackground", "#00C853"),
        ("primaryButtonText", "#000000"),
        ("pageBackground", "#0F1410"),
        ("surfaceColor", "#1E293B"),
        ("textOnSurface", "#FFFFFF"),
        ("textSecondary", "#B0BEC5"),
        ("loadingIndicatorColor", "#2ECC71"),
        ("appBarBackground", "#0F1410"),
        ("appBarForeground", "#FFFFFF"),
        ("appBarAccent", "#2ECC71"),
        ("iconBoxBackground", "#1E3A2A"),
        ("iconBoxIcon", "#2ECC71"),
        ("menuBackground", "#0F1410"),
        ("menuBorder", "#1E3A2A"),
        ("menuSelectedBackground", "#1E3A2A"),
        ("menuSelectedIcon", "#2ECC71"),
        ("dateTimeGradientStart", "#1E3A2A"),
        ("dateTimeGradientEnd", "#0F1410"),
        ("cardSurface", "#1E293B"),
        ("cardBorderColor", "#1E3A2A"),
        ("dialogBackground", "#1E293B"),
        ("dividerColor", "#1E3A2A"),
    ]

    light_colors = [
        ("cardBackground", "#FFFBF5"),
        ("cardBorder", "#FFD9A0"),
        ("titleColor", "#3E2723"),
        ("subtitleColor", "#795548"),
        ("labelColor", "#E65100"),
        ("inputFill", "#FFF3E0"),
        ("inputBorder", "#FFCC80"),
        ("inputFocusedBorder", "#F57C00"),
        ("inputHintText", "#BCAAA4"),
        ("inputTextColor", "#3E2723"),
        ("inputIconColor", "#795548"),
        ("dropdownBackground", "#FFF8EF"),
        ("modeButtonSelectedBackground", "#F57C00"),
        ("primaryButtonBackground", "#F57C00"),
        ("primaryButtonText", "#FFFFFF"),
        ("pageBackground", "#FFF8F0"),
        ("surfaceColor", "#FFFFFF"),
        ("textOnSurface", "#3E2723"),
        ("textSecondary", "#8D6E63"),
        ("loadingIndicatorColor", "#F57C00"),
        ("appBarBackground", "#FFF8F0"),
        ("appBarForeground", "#3E2723"),
        ("appBarAccent", "#F57C00"),
        ("iconBoxBackground", "#FFE0B2"),
        ("iconBoxIcon", "#F57C00"),
        ("menuBackground", "#FFF3E0"),
        ("menuBorder", "#FFD9A0"),
        ("menuSelectedBackground", "#FFE0B2"),
        ("menuSelectedIcon", "#F57C00"),
        ("dateTimeGradientStart", "#FFE0B2"),
        ("dateTimeGradientEnd", "#FFF3E0"),
        ("cardSurface", "#FFFFFF"),
        ("cardBorderColor", "#FFCC80"),
        ("dialogBackground", "#FFFBF5"),
        ("dividerColor", "#FFCC80"),
    ]

    xml = ['<mxfile version="22.1.2" type="device">', '<diagram id="diagram1" name="AppTheme">', 
           '<mxGraphModel dx="1200" dy="1200" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="1200" pageHeight="1600" math="0" shadow="0">',
           '<root>',
           '<mxCell id="0" />',
           '<mxCell id="1" parent="0" />']

    # Swimlanes
    xml.append(f'<mxCell id="dark_theme" value="DARK THEME (GREEN)" style="swimlane;whiteSpace=wrap;html=1;fillColor=#1E241E;fontColor=#FFFFFF;startSize=40;strokeColor=#1AFFFFFF;" vertex="1" parent="1"><mxGeometry x="50" y="50" width="300" height="{len(dark_colors)*60+60}" as="geometry" /></mxCell>')
    xml.append(f'<mxCell id="light_theme" value="LIGHT THEME (ORANGE)" style="swimlane;whiteSpace=wrap;html=1;fillColor=#FFFBF5;fontColor=#3E2723;startSize=40;strokeColor=#FFD9A0;" vertex="1" parent="1"><mxGeometry x="400" y="50" width="300" height="{len(light_colors)*60+60}" as="geometry" /></mxCell>')

    # Add dark colors
    y_offset = 60
    for i, (name, hex_c) in enumerate(dark_colors):
        # determine text color based on hex
        t_color = "#FFFFFF" if not hex_c in ["#00FF00", "#00C853", "#FFFFFF", "#2ECC71"] else "#000000"
        node_id = f"dark_{i}"
        xml.append(f'<mxCell id="{node_id}" value="{name}&#10;{hex_c}" style="rounded=1;whiteSpace=wrap;html=1;fillColor={hex_c};fontColor={t_color};strokeColor=#FFFFFF;" vertex="1" parent="dark_theme"><mxGeometry x="30" y="{y_offset}" width="240" height="40" as="geometry" /></mxCell>')
        y_offset += 50

    # Add light colors
    y_offset = 60
    for i, (name, hex_c) in enumerate(light_colors):
        t_color = "#000000" if hex_c not in ["#3E2723", "#F57C00", "#795548", "#8D6E63", "#E65100"] else "#FFFFFF"
        node_id = f"light_{i}"
        xml.append(f'<mxCell id="{node_id}" value="{name}&#10;{hex_c}" style="rounded=1;whiteSpace=wrap;html=1;fillColor={hex_c};fontColor={t_color};strokeColor=#000000;" vertex="1" parent="light_theme"><mxGeometry x="30" y="{y_offset}" width="240" height="40" as="geometry" /></mxCell>')
        y_offset += 50

    xml.extend(['</root>', '</mxGraphModel>', '</diagram>', '</mxfile>'])
    
    out_dir = r"c:\apps\toho_EGS\docs"
    if not os.path.exists(out_dir):
        os.makedirs(out_dir)
        
    with open(os.path.join(out_dir, "app_theme.drawio"), "w") as f:
        f.write("\\n".join(xml))

if __name__ == "__main__":
    gen_drawio()
    print("Done generating c:\\apps\\toho_EGS\\docs\\app_theme.drawio")
