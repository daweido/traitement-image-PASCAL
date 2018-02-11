UNIT create;
{$i-}
INTERFACE
USES
  crt, sysutils,math;
TYPE
  tabCrea = ARRAY OF ARRAY OF STRING;

PROCEDURE nomcreafichier(VAR fichier : TEXT;nom_fichieri : STRING);
PROCEDURE creecroix(VAR fichier : TEXT; x,y,epaisseur : longint; nom_fichieri : STRING);
PROCEDURE cre(VAR fichier : TEXT; x,y,epaisseur : longint;nom_fichieri : STRING);
PROCEDURE crea_ecriture(nom_fichieri : STRING; x,y,epaisseur : longint;VAR fichier : TEXT);
FUNCTION verIF_x(VAR x : STRING): longint;
PROCEDURE img_banner;
FUNCTION verIF_x_pos(x1 : longint): BOOLEAN;
FUNCTION verIF_x_pos1(VAR x1 : longint;VAR x : STRING): longint;
FUNCTION verIF_y(VAR y : STRING): longint;
FUNCTION verIF_y_pos(y1 : longint): BOOLEAN;
FUNCTION verIF_y_pos1(VAR y1 : longint;VAR y : STRING): longint;
FUNCTION verIF_e(VAR epaiss : STRING;x,y : longint): longint;
FUNCTION verIF_e_pos(epaiss1 : longint): BOOLEAN;
FUNCTION verIF_e_pos1(VAR epaiss1 : longint;VAR epaiss : STRING;x,y : longint): longint;
FUNCTION verIF_e_possi(epaiss1,x,y : longint) : BOOLEAN;
PROCEDURE ecriTab(x,y,epaisseur : longint;VAR fichier : TEXT);
PROCEDURE ecridnsfiche(x,y,epaisseur,x1 : longint;VAR fichier : TEXT;VAR tabcre : tabCrea);
PROCEDURE Pair(VAR xTruePair,epaisseurTruePair, yTruePair : BOOLEAN; x,y, epaisseur : longint);
PROCEDURE IFpairx(xcompt,xe,y,x1 : longint;VAR tabcre : tabCrea; xTruePair,epaisseurTruePair : BOOLEAN);
PROCEDURE creationcroix(x,epaisseur,x1,y : longint;VAR fichier : TEXT;VAR tabcre : tabCrea);
PROCEDURE creationcroiy(y,epaisseur,x,x1 : longint;VAR fichier : TEXT;VAR tabcre : tabCrea);
PROCEDURE IFpairy(ycompt,ye,x1 : longint;VAR tabcre : tabCrea; yTruePair,epaisseurTruePair : BOOLEAN);



IMPLEMENTATION

PROCEDURE img_banner;
BEGIN
  WRITELN('  ______');
  WRITELN(' /\__  _\');
  WRITELN(' \/_/\ \/     ___ ___      __       __      __');
  WRITELN('    \ \ \   /'' __` __`\  /''__`\   /''_ `\  /''__`\');
  WRITELN('     \_\ \__/\ \/\ \/\ \/\ \L\.\_/\ \L\ \/\  __/');
  WRITELN('     /\_____\ \_\ \_\ \_\ \__/.\_\ \____ \ \____\');
  WRITELN('     \/_____/\/_/\/_/\/_/\/__/\/_/\/___L\ \/____/');
  WRITELN('                                    /\____/');
  WRITELN('                                    \_/__/');
END;

FUNCTION verIF_x(VAR x : STRING): longint;
VAR
  x1 : longint;
  cor : BOOLEAN;
BEGIN
  cor := TryStrToInt(x,x1);
  WHILE (cor = FALSE) DO BEGIN
    ClrScr;
    img_banner;
    WRITELN('Veuillez entrer la largeur de l''image souhaitee en pixels :');
    WRITELN('');
    WRITELN('ERREUR : Entree Invalide');
    WRITELN('La valeur entree n''est pas que des chIFfres');
    WRITELN('Veuillez reesayer');
    READLN(x);
    cor := TryStrToInt(x,x1);
  END;
  x1 := verIF_x_pos1(x1,x);
  verIF_x := x1;
END;

FUNCTION verIF_x_pos(x1 : longint): BOOLEAN;
BEGIN
  If (x1 < 0) THEN
    verIF_x_pos := FALSE
  ELSE
    verIF_x_pos := TRUE;
END;

FUNCTION verIF_x_pos1(VAR x1 : longint;VAR x : STRING): longint;
VAR
  xTest : BOOLEAN;
BEGIN
  xTest := verIF_x_pos(x1);
  WHILE (xTest = FALSE) DO BEGIN
    ClrScr;
    img_banner;
    WRITELN('Veuillez entrer la largeur de l''image souhaitee en pixels :');
    WRITELN('');
    WRITELN('ERREUR : Entree Invalide');
    WRITELN('Largeur de l''image est invalide');
    WRITELN('Veuillez reesayer');
    READLN(x);
    x1 := verIF_x(x);
    xTest := verIF_x_pos(x1);
  END;
  verIF_x_pos1 := x1;
END;

FUNCTION verIF_y(VAR y : STRING): longint;
VAR
  y1 : longint;
  cor : BOOLEAN;
BEGIN
  cor := TryStrToInt(y,y1);
  WHILE (cor = FALSE) DO BEGIN
    ClrScr;
    img_banner;
    WRITELN('Veuillez entrer la hauteur de l''image souhaitee en pixels :');
    WRITELN('');
    WRITELN('ERREUR : Entree Invalide');
    WRITELN('La valeur entree n''est pas que des chIFfres');
    WRITELN('Veuillez reesayer');
    READLN(y);
    cor := TryStrToInt(y,y1);
  END;
  y1 := verIF_y_pos1(y1,y);
  verIF_y := y1;
END;

FUNCTION verIF_y_pos(y1 : longint): BOOLEAN;
BEGIN
  If (y1 < 0) THEN
    verIF_y_pos := FALSE
  ELSE
    verIF_y_pos := TRUE;
END;

FUNCTION verIF_y_pos1(VAR y1 : longint;VAR y : STRING): longint;
VAR
  yTest : BOOLEAN;
BEGIN
  yTest := verIF_y_pos(y1);
  WHILE (yTest = FALSE) DO BEGIN
    ClrScr;
    img_banner;
    WRITELN('Veuillez entrer la hauteur de l''image souhaitee en pixels :');
    WRITELN('');
    WRITELN('ERREUR : Entree Invalide');
    WRITELN('Hauteur de l''image est invalide');
    WRITELN('Veuillez reesayer');
    READLN(y);
    y1 := verIF_y(y);
    yTest := verIF_y_pos(y1);
  END;
  verIF_y_pos1 := y1;
END;

PROCEDURE cre(VAR fichier : TEXT; x,y,epaisseur : longint;nom_fichieri : STRING);
BEGIN
  nomcreafichier(fichier,nom_fichieri);
  creecroix(fichier,x,y,epaisseur,nom_fichieri);
END;

PROCEDURE creeCroix(VAR fichier : TEXT; x,y,epaisseur : longint; nom_fichieri : STRING);
BEGIN
  rewrite(fichier);
  crea_ecriture(nom_fichieri,x,y,epaisseur,fichier);
  ecriTab(x,y,epaisseur,fichier);
  close(fichier);
END;

PROCEDURE nomcreafichier(VAR fichier : TEXT;nom_fichieri : STRING);
BEGIN
  ASSIGN(fichier,nom_fichieri);
END;

PROCEDURE crea_ecriture(nom_fichieri : STRING; x,y,epaisseur : longint;VAR fichier : TEXT);
BEGIN
  WRITELN(fichier,'P3');
  WRITELN(fichier,'#',nom_fichieri);
  WRITELN(fichier, x,' ',y);
  WRITELN(fichier,'1');
END;


FUNCTION verIF_e(VAR epaiss : STRING;x,y : longint): longint;
VAR
  epaiss1 : longint;
  cor : BOOLEAN;
BEGIN
  cor := TryStrToInt(epaiss,epaiss1);
  WHILE (cor = FALSE) DO BEGIN
    ClrScr;
    img_banner;
    WRITELN('Veuillez entrer l''epaisseur de la croix souhaitee en pixels :');
    WRITELN('');
    WRITELN('ERREUR : Entree Invalide');
    WRITELN('La valeur entree n''est pas que des chIFfres');
    WRITELN('Veuillez reesayer');
    READLN(epaiss);
    cor := TryStrToInt(epaiss,epaiss1);
  END;
  epaiss1 := verIF_e_pos1(epaiss1,epaiss,x,y);
  verIF_e := epaiss1;
END;

FUNCTION verIF_e_pos(epaiss1 : longint): BOOLEAN;
BEGIN
  If (epaiss1 < 0) THEN
    verIF_e_pos := FALSE
  ELSE
    verIF_e_pos := TRUE;
END;

FUNCTION verIF_e_possi(epaiss1,x,y : longint) : BOOLEAN;
VAR
  mini : longint;
BEGIN
  mini := min(x,y);
  IF (epaiss1 >= mini) THEN
    verIF_e_possi := FALSE
  ELSE
    verIF_e_possi := TRUE;
  END;

FUNCTION verIF_e_pos1(VAR epaiss1 : longint;VAR epaiss : STRING;x,y : longint): longint;
VAR
  eTest, pTest : BOOLEAN;
BEGIN
  eTest := verIF_e_pos(epaiss1);
  pTest := verIF_e_possi(epaiss1,x,y);
  WHILE (eTest = FALSE) or (pTest = FALSE) DO BEGIN
    ClrScr;
    img_banner;
    WRITELN('Veuillez entrer l''epaisseur de la croix souhaitee en pixels :');
    WRITELN('');
    WRITELN('ERREUR : Entree Invalide');
    WRITELN('L''epaisseur de l''image est invalide');
    WRITELN('Veuillez reesayer');
    READLN(epaiss);
    epaiss1 := verIF_e(epaiss,x,y);
    pTest := verIF_e_possi(epaiss1,x,y);
    eTest := verIF_e_pos(epaiss1);
  END;
  verIF_e_pos1 := epaiss1;
END;

PROCEDURE ecriTab(x,y,epaisseur : longint;VAR fichier : TEXT);
VAR
  tabCre : tabCrea;
  i,j,x1 : longint;
BEGIN
  x1 := (3*((x*2)-1)+2);
  setlength(tabCre,y,x1);
  FOR i := 0 TO y-1 DO BEGIN
    FOR j := 0 TO x1-1 DO
    BEGIN
      IF (j mod 2 = 1) THEN
        tabcre[i,j] := ' '
      ELSE
        tabcre[i,j] := '1';
    END;
  END;
  creationcroix(x,epaisseur,x1,y,fichier,tabcre);
  creationcroiy(y,epaisseur,x,x1,fichier,tabcre);
  ecridnsfiche(x,y,epaisseur,x1,fichier,tabcre);
END;

PROCEDURE ecridnsfiche(x,y,epaisseur,x1 : longint;VAR fichier : TEXT;VAR tabcre : tabCrea);
VAR
  i1,j1 : longint;
BEGIN
  FOR i1 := 0 to y-1 DO BEGIN
    FOR j1 := 0 to x1-1 DO BEGIN
      IF j1 = (x1-1) THEN
        WRITELN(fichier,tabcre[i1,j1])
      ELSE
        WRITE(fichier,tabcre[i1,j1]);
    END;
  END;
END;

PROCEDURE creationcroix(x,epaisseur,x1,y : longint;VAR fichier : TEXT;VAR tabcre : tabCrea);
VAR
 xcompt,xe: longint;
 xTruePair,epaisseurTruePair,yTruePair : BOOLEAN;
BEGIN
  xcompt := x div 2;
  xcompt := (3*((xcompt*2)-1)+2);
  xe := epaisseur div 2;
  xe := (3*((xe*2)-1)+2);
  Pair(xTruePair,epaisseurTruePair,yTruePair,x,y,epaisseur);
  IFpairx(xcompt,xe,y,x1,tabcre,xTruePair,epaisseurTruePair);
END;

PROCEDURE Pair(VAR xTruePair,epaisseurTruePair, yTruePair : BOOLEAN; x,y, epaisseur : longint);
BEGIN
  IF (x mod 2 = 0) THEN
    xTruePair := TRUE
  ELSE
    xTruePair := FALSE;

  IF (y mod 2 = 0) THEN
    yTruePair := TRUE
  ELSE
    yTruePair := FALSE;
  IF (epaisseur mod 2 = 0) THEN
    epaisseurTruePair := TRUE
  ELSE
    epaisseurTruePair := FALSE;
END;

PROCEDURE IFpairx(xcompt,xe,y,x1 : longint;VAR tabcre : tabCrea; xTruePair,epaisseurTruePair : BOOLEAN);
VAR
  j2, i2 : longint;
BEGIN
  IF ((xTruePair = TRUE) AND (epaisseurTruePair = TRUE)) or ((xTruePair = FALSE) AND (epaisseurTruePair = TRUE)) THEN BEGIN
    FOR i2 := 0 TO y-1 DO
    FOR j2 := ((xcompt)-(xe)) TO ((xcompt)+(xe)) DO IF tabCre[i2,j2] ='1' THEN tabCre[i2,j2] := '0';
  END
  ELSE IF (xTruePair = TRUE) AND (epaisseurTruePair = FALSE) THEN BEGIN
      FOR i2 := 0 TO y-1 DO
      FOR j2 := ((xcompt)-(xe)) TO ((xcompt)+(xe)+6) DO IF tabCre[i2,j2] ='1' THEN tabCre[i2,j2] := '0';
  END
  ELSE BEGIN
    FOR i2 := 0 TO y-1 DO
      FOR j2 := ((xcompt)-(xe)-1) TO ((xcompt)+(xe)+6) DO
        IF tabCre[i2,j2] ='1' THEN
          tabCre[i2,j2] := '0';
  END;
END;

PROCEDURE creationcroiy(y,epaisseur,x,x1 : longint;VAR fichier : TEXT;VAR tabcre : tabCrea);
VAR
 ycompt,ye: longint;
 yTruePair,epaisseurTruePair,xTruePair : BOOLEAN;
BEGIN
  ycompt := y div 2;
  ye := epaisseur div 2;
  Pair(xTruePair,epaisseurTruePair,yTruePair,x,y,epaisseur);
  IFpairy(ycompt,ye,x1,tabcre,yTruePair,epaisseurTruePair);
END;

PROCEDURE IFpairy(ycompt,ye,x1 : longint;VAR tabcre : tabCrea; yTruePair,epaisseurTruePair : BOOLEAN);
VAR
  j2, i2 : longint;
BEGIN
  IF ((yTruePair = TRUE) AND (epaisseurTruePair = TRUE)) or ((yTruePair = FALSE) AND (epaisseurTruePair = TRUE)) THEN BEGIN
    FOR i2 := ((ycompt)-(ye)) TO ((ycompt)+(ye)-1) DO
      FOR j2 := 0 TO x1 DO
        IF tabCre[i2,j2] ='1' THEN
          tabCre[i2,j2] := '0';
  END
  ELSE IF (yTruePair = TRUE) AND (epaisseurTruePair = FALSE) THEN BEGIN
      FOR i2 := ((ycompt)-(ye)) TO ((ycompt)+(ye)) DO
        FOR j2 := 0 TO x1-1 DO
          IF tabCre[i2,j2] ='1' THEN
            tabCre[i2,j2] := '0';
  END
  ELSE BEGIN
    FOR i2 := ((ycompt)-(ye)) TO ((ycompt)+(ye)) DO
      FOR j2 := 0 TO x1-1 DO
        IF tabCre[i2,j2] ='1' THEN
          tabCre[i2,j2] := '0';
  END;
END;

END.
