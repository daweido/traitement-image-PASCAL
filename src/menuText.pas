UNIT menuText;

INTERFACE
{$i-}
USES
  crt, sysutils,create,ES,manipulationBasiques;
VAR
    fichier : TEXT;
    img : IMAGE;
PROCEDURE ouverture(nom_fichieri : STRING);
PROCEDURE Bienvenue;
PROCEDURE ModIF_fichier(VAR modcr : STRING;VAR fichier : TEXT);
PROCEDURE entree_nom_fichier(VAR modcr : STRING;VAR fichier : TEXT;VAR img : IMAGE);
PROCEDURE menu_mod(nom_fichieri : STRING);
FUNCTION choix_mod(nom_fichieri : STRING): STRING;
PROCEDURE choix(VAR modcr, nom_fichieri : STRING;VAR fichier : TEXT);
PROCEDURE choix_menu_mod(c : STRING; VAR modcr : STRING;VAR fichier : TEXT;VAR img : IMAGE;nom_fichieri : string);
PROCEDURE welcome(VAR modcr : STRING);
FUNCTION verIF_welcome(modcr : STRING):STRING;
FUNCTION verIF_ext(nom_fichieri : STRING): BOOLEAN;
PROCEDURE ext_correct(VAR nom_fichieri : STRING);
PROCEDURE nom_creation(VAR nom_fichieri: STRING);
PROCEDURE entree_nom_fichiercrea(VAR modcr : STRING;VAR fichier : TEXT);
PROCEDURE cr_parametres(VAR x,y,epaisseur : longint);
PROCEDURE image_banner;
FUNCTION largeur: longint;
FUNCTION hauteur : longint;
FUNCTION epaisser(x,y : longint):longint;
PROCEDURE fincre(fincrea, nom_fichieri :STRING; VAR modcr : STRING);
PROCEDURE readfincrea(VAR fincrea : STRING; nom_fichieri : STRING; x,y,epaisseur : longint);
PROCEDURE menu_crea(nom_fichieri : STRING; x,y,epaisseur : longint; VAR modcr : STRING);
PROCEDURE Sortie;
PROCEDURE one(nom_fichieri : STRING;VAR modcr : STRING;VAR fichier : TEXT;VAR img : IMAGE;VAR c : STRING);
PROCEDURE two(VAR seuil : INTEGER; VAR grey,bin,img : IMAGE;VAR hist : histogramme;nom_fichieri : STRING;VAR modcr : STRING;VAR fichier : TEXT;VAR c : STRING);
PROCEDURE three(nom_fichieri : STRING;VAR modcr : STRING;VAR fichier : TEXT;VAR img : IMAGE;VAR c : STRING);
PROCEDURE four(nom_fichieri : STRING;VAR modcr : STRING;VAR fichier : TEXT;VAR img : IMAGE;VAR c : STRING);
PROCEDURE five(nom_fichieri : STRING;VAR modcr : STRING;VAR fichier : TEXT;VAR img : IMAGE;VAR c : STRING);
PROCEDURE six(nom_fichieri : STRING;VAR modcr : STRING;VAR fichier : TEXT;VAR img : IMAGE;VAR c : STRING);
PROCEDURE seven(nom_fichieri : STRING;VAR modcr : STRING;VAR fichier : TEXT;VAR img : IMAGE;VAR c : STRING);
PROCEDURE eight(nom_fichieri : STRING;VAR modcr : STRING;VAR fichier : TEXT;VAR img : IMAGE;VAR c : STRING);
PROCEDURE nine(VAR hist : histogramme;nom_fichieri : STRING;VAR modcr : STRING;VAR fichier : TEXT;VAR img : IMAGE;VAR c : STRING);
PROCEDURE ten(nom_fichieri : STRING;VAR modcr : STRING;VAR fichier : TEXT;VAR img : IMAGE;VAR c : STRING);
PROCEDURE eleven(nom_fichieri : STRING;VAR modcr : STRING;VAR fichier : TEXT;VAR img : IMAGE;VAR c : STRING);
PROCEDURE twelve(nom_fichieri : STRING;VAR modcr : STRING;VAR fichier : TEXT;VAR img : IMAGE;VAR c : STRING);
PROCEDURE thirteen(nom_fichieri : STRING;VAR modcr : STRING;VAR fichier : TEXT;VAR img : IMAGE;VAR c : STRING);
PROCEDURE fourteen(VAR modcr : STRING;VAR fichier : TEXT;VAR img : IMAGE);
PROCEDURE sortieSave;

IMPLEMENTATION

PROCEDURE image_banner;
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

PROCEDURE welcome(VAR modcr : STRING);
BEGIN
  ClrScr;
  image_banner;
  WRITELN('Bienvenue dans le programme Image.');
	WRITELN('Voulez vous modIFier une image ou creer une image ?');
  WRITELN('(1 a 3)');
	WRITELN('1. Modfication');
  WRITELN('2. Creation');
  WRITELN('3. Quitter');
	READLN(modcr);
  modcr := verIF_welcome(modcr);
END;

PROCEDURE nom_creation(VAR nom_fichieri: STRING);
BEGIN
  WHILE (verIF_ext(nom_fichieri) = FALSE) DO BEGIN
    ClrScr;
    image_banner;
    WRITELN('Veuillez entrer le nom du fichier que vous voulez créer');
    WRITELN('De FORme : nom_du_fichier.ppm');
    WRITELN('');
    WRITELN('ERREUR : Entree Invalide');
    WRITELN('L''extension de votre fichier n''est pas supporte.');
    WRITELN('Veuillez reesayer');
    READLN(nom_fichieri);
    ext_correct(nom_fichieri);
  END;

END;
FUNCTION verIF_ext(nom_fichieri : STRING): BOOLEAN;
VAR
  i, l : INTEGER;
  ext : STRING;
BEGIN
  l := length(nom_fichieri);
  ext := '';
  FOR i := l DOWNTO (l-3) DO
    ext := ext + nom_fichieri[i];
  IF (ext = 'mpp.') THEN
    verIF_ext := TRUE
  ELSE IF (nom_fichieri = 'retour') or (nom_fichieri = 'Retour') THEN
    verIF_ext := TRUE
  ELSE
    verIF_ext := FALSE;
END;

PROCEDURE choix(VAR modcr, nom_fichieri : STRING;VAR fichier : TEXT);
BEGIN
  ClrScr;
  Bienvenue;
  verIF_welcome(modcr);
  IF (modcr = '1') THEN
    ModIF_fichier(modcr,fichier)
  ELSE IF (modcr = '2') THEN
    entree_nom_fichiercrea(modcr,fichier)
  ELSE
    sortie;
END;

{---------------------------------Sorties---------------------------------------}
PROCEDURE Sortie;
BEGIN
  ClrScr;
  image_banner;
  WRITELN('');
  WRITELN('Merci d''avoir utilise le programme Image');
  writeln('Fait par David RIGAUX et Soner CAVUSOGLU');
  Writeln('A tres bientot !');
  WRITELN('');
END;

PROCEDURE sortieSave;
BEGIN
  ClrScr;
  image_banner;
  WRITELN('');
  WRITELN('Sauvegarde reussie !');
  WRITELN('Merci d''avoir utilise le programme Image');
  writeln('Fait par David RIGAUX et Soner CAVUSOGLU');
  Writeln('A tres bientot !');
  WRITELN('');
END;

FUNCTION verIF_welcome(modcr : STRING):STRING;
BEGIN
  IF (modcr <> '1') and (modcr <> '2') and (modcr <> '3') THEN BEGIN
    REPEAT
      ClrScr;
      Bienvenue;
    	WRITELN('Voulez vous modIFier une image ou creer une image ?');
      WRITELN('(1 a 3)');
    	WRITELN('1. Modfication');
      WRITELN('2. Creation');
      WRITELN('3. Quitter');
      WRITELN('');
      WRITELN('ERREUR : Entree Invalide');
      WRITELN('Veuillez reesayer');
      READLN(modcr);
    UNTIL ((modcr = '1') or (modcr = '2') or (modcr = '3'));
  END;
  verIF_welcome := modcr;
END;

PROCEDURE ouverture(nom_fichieri : STRING);
BEGIN
  WRITELN(nom_fichieri);
END;

PROCEDURE ext_correct(VAR nom_fichieri : STRING);
BEGIN
    WHILE (verIF_ext(nom_fichieri) = FALSE) DO
    BEGIN
      ClrScr;
      image_banner;
      WRITELN('Veuillez entrer le nom du fichier que vous voulez modIFier');
      WRITELN('De FORme : nom_du_fichier.ppm');
      WRITELN('');
      WRITELN('ERREUR : Entree Invalide');
      WRITELN('L''extension de votre fichier n''est pas supporte.');
      WRITELN('Veuillez reesayer');
      READLN(nom_fichieri);
      verIF_ext(nom_fichieri);
    END;
END;

PROCEDURE Bienvenue;
BEGIN
  image_banner;
  WRITELN('Bienvenue dans le programme Image.')
END;

PROCEDURE entree_nom_fichier(VAR modcr : STRING;VAR fichier : TEXT;VAR img : IMAGE);
VAR
  nom_fichieri,c : STRING;
BEGIN
  ClrScr;
  image_banner;
  WRITELN('Entré entree_nom_fichier');
  WRITELN('Veuillez entrer le nom du fichier que vous voulez modIFier');
  WRITELN('De FORme : nom_du_fichier.ppm');
  READLN(nom_fichieri);
  ext_correct(nom_fichieri);
  IF (nom_fichieri = 'Retour') or (nom_fichieri = 'retour') THEN BEGIN
    ClrScr;
    Welcome(modcr);
    choix(modcr,nom_fichieri,fichier);
  END
  ELSE BEGIN
    img := chargeImage(fichier,nom_fichieri);
    nomNomfichier(nom_fichieri,nom);
    menu_mod(nom_fichieri);
    c := choix_mod(nom_fichieri);
    choix_menu_mod(c,modcr,fichier,img,nom_fichieri);
  END;
END;

PROCEDURE entree_nom_fichiercrea(VAR modcr : STRING;VAR fichier : TEXT);
VAR
  nom_fichieri : STRING;
  x,y,epaisseur : longint;
BEGIN
  x:= 0;
  y := 0;
  epaisseur := 0;
  ClrScr;
  image_banner;
  WRITELN('Veuillez entrer le nom du fichier que vous voulez créer');
  WRITELN('De FORme : nom_du_fichier.ppm');
  READLN(nom_fichieri);
  nom_creation(nom_fichieri);
  IF (nom_fichieri = 'Retour') or (nom_fichieri = 'retour') THEN BEGIN
    ClrScr;
    Welcome(modcr);
    choix(modcr,nom_fichieri,fichier);
  END
  ELSE BEGIN
    cr_parametres(x,y,epaisseur);
    cre(fichier,x,y,epaisseur,nom_fichieri);
    menu_crea(nom_fichieri,x,y,epaisseur,modcr);
  END;
END;

{---------------------------------Menus---------------------------------------}
PROCEDURE menu_mod(nom_fichieri : STRING);
BEGIN
  ClrScr;
  image_banner;
  WRITELN('Image ',nom_fichieri,' charge.');
  WRITELN('Veuillez choisir l''option (1..15) que vous voulez appliquer a votre image :');
  WRITELN('  1.  Convertir l''image en niveaux de gris');
  WRITELN('  2.  Binariser l''image');
  WRITELN('  3.  Realiser un Zoom x2 sur l''image');
  WRITELN('  4.  Realise un De-zoom x2 sur l''image');
  WRITELN('  5.  Affiche un Histogramme');
  WRITELN('  6.  Realise un Recadrage dynamique');
  WRITELN('  7.  Realise un RenFORcement de contraste');
  WRITELN('  8.  Realise un Flou');
  WRITELN('  9.  Realise une Erosion');
  WRITELN('  10. Realise une Dilatation');
  WRITELN('  11. Realise une Segmentation');
  WRITELN('  12. Applique l''operateur de Chanda');
  WRITELN('  13. Enregistrer...');
  WRITELN('  14. Retour');
  WRITELN('  15. Quitter');
END;

PROCEDURE menu_modFais(nom_fichieri,fais : STRING);
BEGIN
  ClrScr;
  image_banner;
  WRITELN('Image ',nom_fichieri,' charge.');
  WRITELN(fais);
  WRITELN('Veuillez choisir l''option (1..15) que vous voulez appliquer a votre image :');
  WRITELN('  1.  Convertir l''image en niveaux de gris');
  WRITELN('  2.  Binariser l''image');
  WRITELN('  3.  Realiser un Zoom x2 sur l''image');
  WRITELN('  4.  Realise un De-zoom x2 sur l''image');
  WRITELN('  5.  Affiche un Histogramme');
  WRITELN('  6.  Realise un Recadrage dynamique');
  WRITELN('  7.  Realise un RenFORcement de contraste');
  WRITELN('  8.  Realise un Flou');
  WRITELN('  9.  Realise une Erosion');
  WRITELN('  10. Realise une Dilatation');
  WRITELN('  11. Realise une Segmentation');
  WRITELN('  12. Applique l''operateur de Chanda');
  WRITELN('  13. Enregistrer...');
  WRITELN('  14. Retour');
  WRITELN('  15. Quitter');
END;

PROCEDURE menuSave;
BEGIN
  ClrScr;
  image_banner;
  WRITELN('Veuillez choisir l''option (1..4) de sauvegarde pour votre image :');
  WRITELN('  1.  Enregistrer (Ecrasement) et quitter');
  WRITELN('  2.  Enregister sous...');
  WRITELN('  3.  Retour');
  WRITELN('  4.  Quitter');
END;

FUNCTION verIFs : STRING;
VAR
  s : STRING;
BEGIN
  READLN(s);
  WHILE (s <> '1') and (s <> '2') and (s <> '3') and (s <> '4') DO BEGIN
    menuSave;
    WRITELN('');
    WRITELN('ERREUR : Entree Invalide');
    WRITELN('Option entree est invalide');
    WRITELN('Veuillez reesayer');
    READLN(s);
  END;
  verIFs := s;
END;

FUNCTION largeur: longint;
var
  x : STRING;
  x1 : longint;
BEGIN
    ClrScr;
    image_banner;
    WRITELN('Veuillez entrer la largeur de l''image souhaitee en pixels :');
    READLN(x);
    x1 := verIF_x(x);
    Largeur := x1;
END;

FUNCTION hauteur : longint;
VAR
  y : STRING;
  y1 : longint;
BEGIN
  ClrScr;
  image_banner;
  WRITELN('Veuillez entrer la hauteur de l''image souhaitee en pixels :');
  READLN(y);
  y1 := verIF_y(y);
  hauteur := y1;
END;

FUNCTION epaisser(x,y : longint):longint;
VAR
  epaiss : STRING;
  epaiss1 : longint;
BEGIN
  ClrScr;
  image_banner;
  WRITELN('Veuillez entrer l''epaisseur de la croix souhaitee en pixels :');
  READLN(epaiss);
  epaiss1 := verIF_e(epaiss,x,y);
  epaisser := epaiss1;
END;

PROCEDURE cr_parametres(VAR x,y,epaisseur : longint);
BEGIN
  x := largeur;
  y := hauteur;
  epaisseur := epaisser(x,y);
END;

PROCEDURE menu_crea(nom_fichieri : STRING; x,y,epaisseur : longint; VAR modcr : STRING);
VAR
  fincrea : STRING;
BEGIN
  ClrScr;
  image_banner;
  WRITELN('Image ',nom_fichieri,' creee !');
  WRITELN('');
  WRITELN('Avec une hateur de ',y,', une largeur de ',x,' et la croix avec une epaisseur de ',epaisseur,'.');
  WRITELN('');
  WRITELN('Veuillez choisir l''option (1..3) que vous voulez appliquer ');
  WRITELN(' 1. ModIFier l''image');
  WRITELN(' 2. Retour a l''accueil');
  WRITELN(' 3. Quitter');
  READLN(fincrea);
  readfincrea(fincrea,nom_fichieri,x,y,epaisseur);
  fincre(fincrea,nom_fichieri,modcr);
END;

PROCEDURE readfincrea(VAR fincrea : STRING; nom_fichieri : STRING; x,y,epaisseur : longint);
BEGIN
  WHILE NOT(fincrea = '1') and NOT(fincrea = '2') and NOT(fincrea = '3') DO BEGIN
    ClrScr;
    image_banner;
    WRITELN('Image ',nom_fichieri,' creee !');
    WRITELN('');
    WRITELN('Avec une hateur de ',x,', une largeur de ',y,' et une croix d''une epaisseur de ',epaisseur,' pixels.');
    WRITELN('Veuillez choisir l''option (1..3) que vous voulez appliquer ');
    WRITELN(' 1. ModIFier l''image');
    WRITELN(' 2. Retour a l''accueil');
    WRITELN(' 3. Quitter');
    WRITELN('');
    WRITELN('ERREUR : Entree Invalide');
    WRITELN('Option entree est invalide');
    WRITELN('Veuillez reesayer');
    READLN(fincrea);
  END;
END;

PROCEDURE fincre(fincrea, nom_fichieri :STRING; VAR modcr : STRING);
VAR
  c : STRING;
BEGIN
  IF fincrea = '1' THEN BEGIN
    WRITELN('Ouvrir fichier ',nom_fichieri);
    menu_mod(nom_fichieri);
    c := choix_mod(nom_fichieri);
    choix_menu_mod(c,modcr,fichier,img,nom_fichieri);

  END
  ELSE IF fincrea = '2' THEN BEGIN
    welcome(modcr);
    choix(modcr,nom_fichieri,fichier);
  END
  ELSE
    Sortie;
END;

PROCEDURE choix_menu_mod(c : STRING; VAR modcr : STRING;VAR fichier : TEXT;VAR img : IMAGE;nom_fichieri : string);
BEGIN
  IF c = '1' THEN
    one(nom_fichieri,modcr,fichier,img,c)
  ELSE IF c = '2' THEN
    two(seuil,grey,bin,img,hist,nom_fichieri,modcr,fichier,c)
  ELSE IF c = '3' THEN
    three(nom_fichieri,modcr,fichier,img,c)
  ELSE IF c = '4' THEN
    four(nom_fichieri,modcr,fichier,img,c)
  ELSE IF c = '5' THEN
    five(nom_fichieri,modcr,fichier,img,c)
  ELSE IF c = '6' THEN
    six(nom_fichieri,modcr,fichier,img,c)
  ELSE IF c = '7' THEN
    seven(nom_fichieri,modcr,fichier,img,c)
  ELSE IF c = '8' THEN
    eight(nom_fichieri,modcr,fichier,img,c)
  ELSE IF c = '9' THEN
    nine(hist,nom_fichieri,modcr,fichier,img,c)
  ELSE IF c = '10' THEN
    ten(nom_fichieri,modcr,fichier,img,c)
  ELSE IF c = '11' THEN
    eleven(nom_fichieri,modcr,fichier,img,c)
  ELSE IF c = '12' THEN
    twelve(nom_fichieri,modcr,fichier,img,c)
  ELSE IF c = '13' THEN
    thirteen(nom_fichieri,modcr,fichier,img,c)
  ELSE IF c = '14' THEN
    fourteen(modcr,fichier,img)
  ELSE
    Sortie;
END;

PROCEDURE choixSave(s : STRING;nom_fichieri : STRING;VAR modcr : STRING;VAR fichier : TEXT;VAR img : IMAGE;VAR c : STRING );
BEGIN
  IF s = '1' THEN sauvegardeImage(img ,nom)
  ELSE IF s = '2' THEN BEGIN
    ClrScr;
    image_banner;
    WRITELN('Veuillez entrer le nom du fichier dans le quel vous voulez enregistrer l''image : ');
    WRITELN('De FORme : nom_du_fichier.ppm');
    enregSous(img,nom)
  END
  ELSE IF s = '3' THEN BEGIN
    menu_mod(nom_fichieri);
    c := choix_mod(nom_fichieri);
    choix_menu_mod(c,modcr,fichier,img,nom_fichieri);
  END
  ELSE Sortie;
END;

FUNCTION choix_mod(nom_fichieri: STRING): STRING;
VAR
  c : STRING;
BEGIN
  READLN(c);
  WHILE (c <> '1') and (c <> '2') and (c <> '3') and (c <> '4') and (c <> '5') and (c <> '6') and (c <> '7') and (c <> '8') and (c <> '9') and (c <> '10') and (c <> '11') and (c <> '12') and (c <> '13') and (c <> '14') and (c <> '15') DO
  BEGIN
    menu_mod(nom_fichieri);
    WRITELN('');
    WRITELN('ERREUR : Entree Invalide');
    WRITELN('Option entree est invalide');
    WRITELN('Veuillez reesayer');
    READLN(c);
  END;
  choix_mod := c;
END;

PROCEDURE ModIF_fichier(VAR modcr : STRING;VAR fichier : TEXT);
BEGIN
  entree_nom_fichier(modcr,fichier,img);
END;

{---------------------------------Options---------------------------------------}
PROCEDURE one(nom_fichieri : STRING;VAR modcr : STRING;VAR fichier : TEXT;VAR img : IMAGE;VAR c : STRING);
VAR
  fais : string;
BEGIN
  fais := 'Conversion de l''image en niveaux de gris reussie !';
  img := convertVersGris(img);
  menu_modFais(nom_fichieri,fais);
  c := choix_mod(nom_fichieri);
  choix_menu_mod(c,modcr,fichier,img,nom_fichieri);
END;

PROCEDURE two(VAR seuil : INTEGER; VAR grey,bin,img : IMAGE;VAR hist : histogramme;nom_fichieri : STRING;VAR modcr : STRING;VAR fichier : TEXT;VAR c : STRING);
  VAR
    fais : string;
BEGIN
  fais := 'Binarisation reussie !';
  calcHistoSeuilGrisBin(seuil,grey,bin,img,hist);
  img := bin;
  menu_modFais(nom_fichieri,fais);
  c := choix_mod(nom_fichieri);
  choix_menu_mod(c,modcr,fichier,img,nom_fichieri);
END;

PROCEDURE three(nom_fichieri : STRING;VAR modcr : STRING;VAR fichier : TEXT;VAR img : IMAGE;VAR c : STRING);
  VAR
    fais : string;
BEGIN
  fais := 'Zoomage *2 reussie !';
  img := zoomeX2(img);
  menu_modFais(nom_fichieri,fais);
  c := choix_mod(nom_fichieri);
  choix_menu_mod(c,modcr,fichier,img,nom_fichieri);
END;

PROCEDURE four(nom_fichieri : STRING;VAR modcr : STRING;VAR fichier : TEXT;VAR img : IMAGE;VAR c : STRING);
  VAR
    fais : string;
BEGIN
  fais := 'Dezoomage *2 reusis !';
  img := zoomeSur2(img);
  menu_modFais(nom_fichieri,fais);
  c := choix_mod(nom_fichieri);
  choix_menu_mod(c,modcr,fichier,img,nom_fichieri);
END;

PROCEDURE five(nom_fichieri : STRING;VAR modcr : STRING;VAR fichier : TEXT;VAR img : IMAGE;VAR c : STRING);
BEGIN
  ClrScr;
  image_banner;
  WRITELN('');
  WRITELN('Histogramme de l''image ',nom_fichieri,' :');
  ecritureHist(img);
  WRITELN('Appuyez sur une touche pour retourner au menu...');
  readkey;
  menu_mod(nom_fichieri);
  c := choix_mod(nom_fichieri);
  choix_menu_mod(c,modcr,fichier,img,nom_fichieri);
END;

PROCEDURE six(nom_fichieri : STRING;VAR modcr : STRING;VAR fichier : TEXT;VAR img : IMAGE;VAR c : STRING);
  VAR
    fais : string;
BEGIN
  fais := 'Recadrage dynamique reussis !';
  img := dynCropImage(img);
  menu_modFais(nom_fichieri,fais);
  c := choix_mod(nom_fichieri);
  choix_menu_mod(c,modcr,fichier,img,nom_fichieri);
END;

PROCEDURE seven(nom_fichieri : STRING;VAR modcr : STRING;VAR fichier : TEXT;VAR img : IMAGE;VAR c : STRING);
  VAR
    fais : string;
BEGIN
  fais := 'RenFORcement du contraste reussie !';
  img := renFORceContraste(img);
  menu_modFais(nom_fichieri,fais);
  c := choix_mod(nom_fichieri);
  choix_menu_mod(c,modcr,fichier,img,nom_fichieri);
END;

PROCEDURE eight(nom_fichieri : STRING;VAR modcr : STRING;VAR fichier : TEXT;VAR img : IMAGE;VAR c : STRING);
  VAR
    fais : string;
BEGIN
  fais := 'Floutage reussis !';
  img := flou(img);
  menu_modFais(nom_fichieri,fais);
  c := choix_mod(nom_fichieri);
  choix_menu_mod(c,modcr,fichier,img,nom_fichieri);
END;

PROCEDURE nine(VAR hist : histogramme;nom_fichieri : STRING;VAR modcr : STRING;VAR fichier : TEXT;VAR img : IMAGE;VAR c : STRING);
  VAR
    fais : string;
BEGIN
  fais := 'Erosion sur image reussis !';
  img := sortieErode(seuil,grey,bin,img,hist);
  menu_modFais(nom_fichieri,fais);
  c := choix_mod(nom_fichieri);
  choix_menu_mod(c,modcr,fichier,img,nom_fichieri);
END;

PROCEDURE ten(nom_fichieri : STRING;VAR modcr : STRING;VAR fichier : TEXT;VAR img : IMAGE;VAR c : STRING);
  VAR
    fais : string;
BEGIN
  fais := 'Dilatation sur image reussis !';
  img := sortiedilateImage(seuil,grey,bin,img,hist);
  menu_modFais(nom_fichieri,fais);
  c := choix_mod(nom_fichieri);
  choix_menu_mod(c,modcr,fichier,img,nom_fichieri);
END;

PROCEDURE eleven(nom_fichieri : STRING;VAR modcr : STRING;VAR fichier : TEXT;VAR img : IMAGE;VAR c : STRING);
  VAR
    fais : string;
BEGIN
  fais := 'Segmentation reussis !';
  img := sortieSegmentation(seuil,grey,bin,img,hist);
  menu_modFais(nom_fichieri,fais);
  c := choix_mod(nom_fichieri);
  choix_menu_mod(c,modcr,fichier,img,nom_fichieri);
END;

PROCEDURE twelve(nom_fichieri : STRING;VAR modcr : STRING;VAR fichier : TEXT;VAR img : IMAGE;VAR c : STRING);
  VAR
    fais : string;
BEGIN
  fais := 'Operation de Chanda reussis !';
  //img :=
  menu_modFais(nom_fichieri,fais);
  c := choix_mod(nom_fichieri);
  choix_menu_mod(c,modcr,fichier,img,nom_fichieri);
END;

PROCEDURE thirteen(nom_fichieri : STRING;VAR modcr : STRING;VAR fichier : TEXT;VAR img : IMAGE;VAR c : STRING);
VAR
  s : STRING;
BEGIN
  menuSave;
  s := verIFs;
  choixSave(s,nom_fichieri,modcr,fichier,img,c);
  sortieSave;
END;

PROCEDURE fourteen(VAR modcr : STRING;VAR fichier : TEXT;VAR img : IMAGE);
BEGIN
  entree_nom_fichier(modcr,fichier,img);
END;

END.
