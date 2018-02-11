UNIT ES;
INTERFACE
{$i-}
{$mode objfpc}
USES
  crt, sysutils;
TYPE  pixel = RECORD
  r,g,b: INTEGER;
  END;
TYPE Image = RECORD
  magic : STRING;
  commentaire : STRING;
  width : INTEGER;
  height: INTEGER;
  max : byte;
  body : ARRAY OF ARRAY OF PIXEL;
  END;
VAR
{----------------------------Chargement----------------------------------------}
fichier : TEXT;
img,charge : Image;
nom : STRING;


FUNCTION chargeImage(VAR fichier : TEXT; VAR nom_fichieri : STRING) : Image;
FUNCTION sauvegardeImage(img : Image; nom : STRING) : INTEGER;
PROCEDURE nomNomfichier(nom_fichieri : STRING; VAR nom : STRING);
PROCEDURE four_params(VAR charge : IMAGE;VAR fichier : TEXT);
PROCEDURE enregSous(img : Image; VAR nom : STRING);
FUNCTION verifnomSous : STRING;
PROCEDURE LoopS(VAR nomB,ext : STRING;ex : INTEGER);



IMPLEMENTATION
{----------------------------Chargement----------------------------------------}
PROCEDURE im_banner;
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

PROCEDURE fichier_non_existant(VAR nom_fichieri : STRING);
BEGIN
  ClrScr;
  im_banner;
  WRITELN('Veuillez entrer le nom du fichier que vous voulez modifier');
  WRITELN('De FORme : nom_du_fichier.ppm');
  WRITELN('');
  WRITELN('ERREUR : Entree Invalide');
  WRITELN('Le fichier n''existe pas');
  WRITELN('Veuillez reesayer');
  READLN(nom_fichieri);
END;

PROCEDURE tabImage(VAR charge : IMAGE;VAR fichier : TEXT);
var
  i,j : INTEGER;
BEGIN
  setlength(charge.body,charge.height,charge.width);
  FOR i:=0 TO charge.height-1 DO
  FOR j:=0 TO charge.width-1 DO
  BEGIN
      READ(fichier,charge.body[i,j].r);
      READ(fichier,charge.body[i,j].g);
      READ(fichier,charge.body[i,j].b);
  END;
END;


PROCEDURE yx_strTOint(VAR charge : IMAGE;bphy, bpwx : STRING);
BEGIN
  charge.height := StrToInt(bphy);
  charge.width := StrToInt(bpwx);
END;

Procedure calc_xy(l3: STRING;VAR charge : IMAGE);
VAR
  ll3, i : INTEGER;
  bpwx,bphy : STRING;
BEGIN
  bpwx :='';
  bphy :='';
  i := 1;
  ll3 := length(l3);
  REPEAT
    bpwx := bpwx + l3[i];
    i := i +1;
  UNTIL (l3[i] = ' ');
  i := i+1;
  REPEAT
    bphy := bphy + l3[i];
    i := i +1;
  UNTIL (i = ll3+1);
  yx_strTOint(charge,bphy,bpwx);
END;

PROCEDURE four_params(VAR charge : IMAGE;VAR fichier : TEXT);
VAR
  l2,l3 : STRING;
BEGIN
  READLN(fichier,charge.magic);
  READLN(fichier,l2);
  IF l2[1] = '#' THEN BEGIN
    READLN(fichier,l3);
    READLN(fichier,charge.max);
  END
  ELSE BEGIN
    l3 := l2;
    l2 := '';
    READLN(fichier,charge.max);
  END;
  calc_xy(l3,charge);
END;

Procedure ouverture_fichier(VAR charge : IMAGE; VAR  nom_fichieri : STRING; VAR  fichier : TEXT);
BEGIN
  assign(fichier,nom_fichieri);
  {$I+}
  TRY
    reset(fichier);
    four_params(charge,fichier);
    tabImage(charge,fichier);
    close(fichier);
  EXCEPT
    on E: EInOutError DO BEGIN
      fichier_non_existant(nom_fichieri);
      ouverture_fichier(charge,nom_fichieri,fichier);
    END;
  END;
END;

FUNCTION chargeImage(VAR fichier : TEXT; VAR nom_fichieri : STRING) : Image;
VAR
  charge : Image;
BEGIN
  ouverture_fichier(charge,nom_fichieri,fichier);
  chargeImage := charge;
END;


FUNCTION verif_right(nom_fichieri : STRING): BOOLEAN;
VAR
  i, l : INTEGER;
  ext : STRING;
BEGIN
  l := length(nom_fichieri);
  ext := '';
  FOR i := l DOwnTO (l-3) DO
    ext := ext + nom_fichieri[i];
  IF (ext = 'mpp.') THEN
    verif_right := TRUE
  ELSE IF (nom_fichieri = 'reTOur') or (nom_fichieri = 'ReTOur') THEN
    verif_right := TRUE
  ELSE
    verif_right := FALSE;
END;

PROCEDURE ext_right(VAR nom_fichieri : STRING);
BEGIN
    WHILE (verif_right(nom_fichieri) = FALSE) DO BEGIN
      ClrScr;
      im_banner;
      WRITELN('Veuillez entrer le nom du fichier que vous voulez modifier');
      WRITELN('De FORme : nom_du_fichier.ppm');
      WRITELN('');
      WRITELN('ERREUR : Entree Invalide');
      WRITELN('L''extension de votre fichier n''est pas supporte.');
      WRITELN('Veuillez reesayer');
      READLN(nom_fichieri);
      verif_right(nom_fichieri);
    END;
END;

PROCEDURE nomNomfichier(nom_fichieri : STRING; VAR nom : STRING);
BEGIN
  nom := nom_fichieri;
END;

{----------------------------Sauvegarde----------------------------------------}
PROCEDURE SortieA;
BEGIN
  ClrScr;
  im_banner;
  WRITELN('');
  WRITELN('Merci d''avoir utilise le programme Image');
  writeln('Fait par David RIGAUX et Soner CAVUSOGLU');
  Writeln('A tres bienTOt !');
  WRITELN('');
END;

PROCEDURE erreurReecriture(nom : STRING);
BEGIN
  ClrScr;
  im_banner;
  WRITELN('Erreur : Sauvegarde du fichier ',nom,' echouee');
  WRITELN('Appuyez sur n''importe quelle TOuche pour quitter...');
  readkey;
  SortieA;
END;

PROCEDURE writeInFile(img : IMAGE;VAR fichier : Text);
var
  i,j : INTEGER;
BEGIN
  writeln(fichier,img.magic);
  IF img.commentaire <> '' THEN
    writeln(fichier,img.commentaire);

  writeln(fichier,img.width,' ',img.height);
  writeln(fichier,img.max);
  For i := 0 TO img.height-1 DO BEGIN
    FOR j := 0 TO img.width-1 DO BEGIN
      WRITELN(fichier,img.body[i,j].r,' ',img.body[i,j].g,' ',img.body[i,j].b);
    END;
  END;
END;

PROCEDURE enregSous(img : Image; VAR nom : STRING);
BEGIN
  nom := verifnomSous;
  sauvegardeImage(img,nom);
END;

FUNCTION verifnomSous : STRING;
VAR
  nomB,ext : STRING;
  ex,i : INTEGER;
BEGIN
    READLN(nomB);
    ext := '';
    ex := length(nomB);
    FOR i := ex DOwnTO ex-3 DO
      ext := ext + nomB[i];
    WHILE ext <> 'mpp.' DO
      LoopS(nomB,ext,ex);
    verifnomSous := nomB;
END;

PROCEDURE LoopS(VAR nomB,ext : STRING;ex : INTEGER);
VAR i : INTEGER;
BEGIN
  ClrScr;
  im_banner;
  WRITELN('Veuillez entrer le nom du fichier dans le quel vous voulez enregistrer l''image : ');
  WRITELN('De FORme : nom_du_fichier.ppm');
  WRITELN('');
  WRITELN('ERREUR : Entree Invalide');
  WRITELN('L''extension de votre fichier n''est pas supporte.');
  WRITELN('Veuillez reesayer');
  READLN(nomB);
  ext := '';
  ex := length(nomB);
  FOR i := ex DOwnTO ex-3 DO
    ext := ext + nomB[i];
END;

FUNCTION sauvegardeImage(img : Image; nom : STRING) : INTEGER;
VAR
  fichier : TEXT;
BEGIN
  assign(fichier,nom);
  {$I+}
  TRY
    rewrite(fichier);
    writeInFile(img,fichier);
    close(fichier);
    sauvegardeImage := 1;
  EXCEPT
    on E: EInOutError DO BEGIN
      erreurReecriture(nom);
      sauvegardeImage := 0;
    END;
  END;
END;

END.
