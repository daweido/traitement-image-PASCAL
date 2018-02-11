UNIT manipulationBasiques;
//Binarisation
//HisTOgramme
//TransFORmation en niveau de gris
//Zoom
//Recadrage dynamique
INTERFACE
USES
  crt, sysutils,ES;
TYPE
  HisTOgramme = ARRAY[0..255] OF INT64;
VAR
  Seuil : INTEGER;
  hist : HisTOgramme;
  grey,bin : Image;

PROCEDURE calcHisTOSeuilGrisBin(VAR seuil : INTEGER; VAR grey,bin,img : IMAGE;VAR hist : hisTOgramme);
{---------------------------convertVersGris----------------------------------}
FUNCTION convertVersGris(img : Image): Image;
{----------------------------Binarisation--------------------------------------}
FUNCTION calculSeuil(hist : hisTOgramme;img : IMAGE) : INTEGER;
Function binariseImage(img : Image;VAR Seuil:integer) : Image;
PROCEDURE opeBin(VAR binarise : image; Seuil : INTEGER);
{-------------------------------Zoom*2-----------------------------------------}
FUNCTION zoomeX2 (img:image):image;
{-------------------------------Zoom/2-----------------------------------------}
FUNCTION zoomeSur2 (img:image):image;
{----------------------------HisTOgramme--------------------------------------}
FUNCTION calculeHist(img : Image): HisTOgramme;
procedure iniHisTO(VAR lumi : HisTOgramme;img : IMAGE);
PROCEDURE entreeHisTO(VAR lumi : HisTOgramme;img : IMAGE);
procedure ecritureHist(img : IMAGE);
{-----------------------------recadrageDynamique-------------------------------}
FUNCTION dynCropImage(img : image):image; //l'image en niveau de gris
PROCEDURE maximini(VAR maxi,mini : INTEGER;img : IMAGE);
{-----------------------------renFORceContraste--------------------------------}
FUNCTION renFORceContraste(img : image) : image;
PROCEDURE ctr1(VAR ictr : Image; img : Image;i,j : Integer);
{-----------------------------------flou--------------------------------------}
FUNCTION flou(img : image) : image;
PROCEDURE blur1(VAR blur : image;img : image;i,j : Integer);
{-----------------------------------erode--------------------------------------}
FUNCTION sortieErode(VAR seuil : INTEGER; VAR grey,bin : IMAGE;img : IMAGE;VAR hist : hisTOgramme) : Image;
FUNCTION erode (bin : Image): Image;
{--------------------------------dilateImage-----------------------------------}
FUNCTION sortiedilateImage(VAR seuil : INTEGER; VAR grey,bin : IMAGE;img : IMAGE;VAR hist : hisTOgramme) : Image;
FUNCTION dilateImage ( bin : Image ) : Image;
{--------------------------------Segmentation-----------------------------------}
FUNCTION sortieSegmentation(VAR seuil : INTEGER; VAR grey,bin : IMAGE;img : IMAGE;VAR hist : hisTOgramme) : Image;
FUNCTION MAXI(bin : Image; i,j : integer) : INTEGER;
FUNCTION segmentation(bin : Image): Image;

IMPLEMENTATION
PROCEDURE calcHisTOSeuilGrisBin(VAR seuil : INTEGER; VAR grey,bin,img : IMAGE;VAR hist : hisTOgramme);
BEGIN
  hist := calculeHist(img);
  seuil := calculSeuil(hist,img);
  WRITELN('SEUILCALC = ',seuil);
  readkey;
  grey := convertVersGris(img);
  bin := BinariseImage(grey,Seuil);
END;

{----------------------------convertVersGris---------------------------------}
FUNCTION convertVersGris(img : Image): Image;
VAR
      hy,wx,nbr : integer;
      gris : Image;
BEGIN
  gris.magic := img.magic;
  gris.height := img.height;
  gris.width := img.width;
  gris.max := img.max;
  setlength(gris.body,gris.height,gris.width);
  FOR hy := 0 TO img.height -1 DO
	BEGIN
    	FOR wx := 0 TO img.width -1 DO BEGIN
         	nbr :=ROUND(0.3*img.body[hy,wx].r + 0.59*img.body[hy,wx].g + 0.11*img.body[hy,wx].b);
         	gris.body[hy,wx].r := nbr;
         	gris.body[hy,wx].g := nbr;
         	gris.body[hy,wx].b := nbr;
      END;
   	END;
    convertVersGris := gris;
END;

{----------------------------binarisation--------------------------------------}
FUNCTION binariseImage(img : Image;VAR Seuil:integer) : Image;
VAR
  binarise : IMAGE;
BEGIN
  binarise := img;
  seuil := calculSeuil(hist,img);
  opeBin(binarise,Seuil);
  binariseImage := binarise;
END;

FUNCTION calculSeuil(hist : hisTOgramme;img : IMAGE) : INTEGER;
VAR
  i,seuils : integer;
  px,seu : INT64;
  hyu : hisTOgramme;
BEGIN
  hyu := hist;
  seu := 0;
  px := (img.height*img.width) div 2;
  FOR i := 0 TO 255 DO BEGIN
  	seu := seu + hyu[i];
  	IF (seu > px) THEN BEGIN
      seuils := i;
      break;
    END;
  END;
  calculSeuil := seuils;
END;

PROCEDURE opeBin(VAR binarise : image; Seuil : INTEGER);
VAR
  i,j : INTEGER;
BEGIN
  WRITELN(seuil);
  readkey;
  For i := 0 TO binarise.height-1 DO BEGIN
    FOR j := 0 TO binarise.width-1 DO BEGIN
      IF (binarise.body[i,j].r < seuil) THEN BEGIN
        binarise.body[i,j].r := 0;
        binarise.body[i,j].g := 0;
        binarise.body[i,j].b := 0;
      END
      ELSE BEGIN
        binarise.body[i,j].r := 255;
        binarise.body[i,j].g := 255;
        binarise.body[i,j].b := 255;
      END;
      WRITELN(binarise.body[i,j].r);
    END;
  END;
  readkey;
END;

{-------------------------------Zoom*2-----------------------------------------}
FUNCTION zoomeX2 (img:image):image;
VAR
  izoom:image;
  i,j:integer;
BEGIN
  izoom := img;
	izoom.height := img.height*2;
	izoom.width := img.width*2;
	setlength(izoom.body,izoom.height,izoom.width);
	FOR i := 0 TO izoom.height-1 DO BEGIN
		FOR j := 0 TO izoom.width-1 DO BEGIN
			izoom.body[i,j].r := img.body[i div 2,j div 2].r;
			izoom.body[i,j].g := img.body[i div 2,j div 2].g;
			izoom.body[i,j].b := img.body[i div 2,j div 2].b;
		END;
  END;
	zoomeX2 := izoom;
END;
{-------------------------------Zoom/2-----------------------------------------}
FUNCTION zoomeSur2 (img:image):image;
VAR
  izoom:image;
	i,j:integer;
BEGIN
  izoom := img;
	izoom.height := img.height div 2;
	izoom.width := img.width div 2;
	setlength(izoom.body,izoom.height,izoom.width);
	FOR i := 0 TO izoom.height-1 DO BEGIN
    FOR j := 0 TO izoom.width-1 DO BEGIN
			izoom.body[i,j].r := img.body[i*2,j*2].r;
			izoom.body[i,j].g := img.body[i*2,j*2].g;
			izoom.body[i,j].b := img.body[i*2,j*2].b;
		END;
  END;
	zoomeSur2:=izoom;
END;

{----------------------------HisTOgramme--------------------------------------}
FUNCTION calculeHist(img : Image): HisTOgramme;
VAR
  lumi : HisTOgramme;
BEGIN
  iniHisTO(lumi,img);
  entreeHisTO(lumi,img);
  calculeHist := lumi;
END;

procedure iniHisTO(VAR lumi : HisTOgramme;img : IMAGE);
VAR
  lu : INTEGER;
BEGIN
  FOR lu := 0 TO 255 DO lumi[lu] := 0;
END;

PROCEDURE entreeHisTO(VAR lumi : HisTOgramme;img : IMAGE);
VAR
  i,j,pe : INTEGER;
BEGIN
  FOR j:=0 TO img.height-1 DO BEGIN
    FOR i:=0 TO img.width-1 DO BEGIN
        pe := img.body[j,i].r;
        lumi[pe] := lumi[pe] + 1;
      END;
  END;
END;

procedure ecritureHist(img : IMAGE);
VAR
  i : INTEGER;
  ecriture : hisTOgramme;
BEGIN
  ecriture := calculeHist(img);
  FOR i := 0 TO 255 DO BEGIN
    IF ecriture[i] <> 0 THEN WRITELN(i,'    ',ecriture[i]);
  END;
END;

{-----------------------------recadrageDynamique-------------------------------}
FUNCTION dynCropImage(img : image) : IMAGE; //l'image en niveau de gris
VAR
  dyn : IMAGE;
  del : real;
  l,d,mini,maxi : integer;
BEGIN
  maxi := 0;
  mini := 0;
  dyn := img;
  maximini(maxi,mini,img);
  FOR l := 0 TO img.height -1 DO BEGIN
    FOR d := 0 TO img.width -1 DO BEGIN
      del := (255/(maxi-mini));
      del := del*(img.body[l,d].r-mini);
      dyn.body[l,d].r := round(del);
      dyn.body[l,d].g := round(del);
      dyn.body[l,d].b := round(del);
    END;
  END;
  dynCropImage := dyn;
END;

PROCEDURE maximini(VAR maxi,mini : INTEGER;img : IMAGE);
VAR
  lisTO : hisTOgramme;
  i: INTEGER;
BEGIN
  lisTO := calculeHist(img);
  FOR i := 0 TO 255 DO BEGIN
    IF lisTO[i] <> 0 THEN BEGIN
    IF (maxi < lisTO[i]) THEN BEGIN
        maxi := i; //Sortie de MAX
      END;
      IF(mini > lisTO[i]) THEN BEGIN
        mini := i; //Sortie de MIN
      END;
    END;
  END;
END;
{-----------------------------renFORceContraste--------------------------------}
FUNCTION renFORceContraste(img : image) : image;
VAR
	i,j : integer;
	ictr : image;
BEGIN
  ictr := img;
	FOR i := 1 TO ictr.height-2 DO BEGIN
		FOR j := 1 TO ictr.width-2 DO BEGIN
      ctr1(ictr,img,i,j);
		END;
  END;
  renFORceContraste := ictr;
END; // Fin de la fonction RenFORcement Contraste

PROCEDURE ctr1(VAR ictr : Image; img : Image;i,j : Integer);
VAR
  red,green,blue :Integer;
BEGIN
  red := (img.body[i,j].r * 5) - (img.body[i,j-1].r + img.body[i-1,j].r + img.body[i+1,j].r + img.body[i,j+1].r);
  //IF (red <= 0) THEN red := 0
  //ELSE IF(red >= 255) THEN red := 255;
  ictr.body[i,j].r := red;
  green := (img.body[i,j].g * 5) - (img.body[i,j-1].g + img.body[i-1,j].g + img.body[i+1,j].g + img.body[i,j+1].g);
  //IF (green <= 0) THEN green := 0
  //ELSE IF (green >= 255) THEN green := 255;
  ictr.body[i,j].g := green;
  blue := (img.body[i,j].b * 5) - (img.body[i,j-1].b + img.body[i-1,j].b + img.body[i+1,j].b + img.body[i,j+1].b);
  //IF (blue <= 0) THEN blue := 0
  //ELSE IF(blue >= 255) THEN blue := 255;
  ictr.body[i,j].b := blue;
END;
{-----------------------------------flou--------------------------------------}
FUNCTION flou(img : image) : image;
VAR
	i,j : integer;
  blur : image;
BEGIN
  blur := img;
	FOR i := 1 TO blur.height-2 DO BEGIN
		FOR j := 1 TO blur.width-2 DO BEGIN
	     blur1(blur,img,i,j);
		END;
  END;
  flou := blur;
END;

PROCEDURE blur1(VAR blur : image;img : image;i,j : Integer);
VAR
  red,green,blue :Integer;
BEGIN
  red := (img.body[i,j].r + img.body[i-1,j-1].r + img.body[i,j-1].r + img.body[i+1,j-1].r + img.body[i-1,j].r + img.body[i+1,j].r + img.body[i-1,j+1].r + img.body[i,j+1].r + img.body[i+1,j+1].r) div 9;
  IF(red <= 0) THEN
    red := 0
  ELSE IF(red >= 255) THEN
    red := 255;

  blur.body[i,j].r := red;
  green := (img.body[i,j].g + img.body[i-1,j-1].g + img.body[i,j-1].g + img.body[i+1,j-1].g + img.body[i-1,j].g + img.body[i+1,j].g + img.body[i-1,j+1].g + img.body[i,j+1].g + img.body[i+1,j+1].g) div 9;

  IF(green <= 0) THEN
    green := 0
  ELSE IF(green >= 255) THEN
    green := 255;

  blur.body[i,j].g := green;
  blue := (img.body[i,j].b + img.body[i-1,j-1].b + img.body[i,j-1].b + img.body[i+1,j-1].b + img.body[i-1,j].b + img.body[i+1,j].b + img.body[i-1,j+1].b + img.body[i,j+1].b + img.body[i+1,j+1].b) div 9;

  IF(blue <= 0) THEN
    blue := 0
  ELSE IF(blue >= 255) THEN
    blue := 255;

  blur.body[i,j].b := blue;
END;

{-----------------------------------erode--------------------------------------}
FUNCTION sortieErode(VAR seuil : INTEGER; VAR grey,bin : IMAGE;img : IMAGE;VAR hist : hisTOgramme) : Image;
BEGIN
  calcHisTOSeuilGrisBin(seuil,grey,bin,img,hist);
  //sortieErode := grey;
  sortieErode := erode(bin);
END;

FUNCTION erode (bin : Image): Image;
VAR
  k,l,i,j : integer;
	Ero : image;
BEGIN
  Ero.magic := bin.magic;
	Ero.height := bin.height;
	Ero.width := bin.width;
	Ero.max := bin.max;
  setlength(Ero.body,Ero.height,Ero.width);
  FOR i:=1 TO Ero.height-2 DO
    FOR j:=1 TO Ero.width-2 DO BEGIN
      IF (bin.body[i,j].r = 0) THEN	BEGIN //quand rencontre un pixel noir
        FOR k := i- 1 TO i+ 1 DO BEGIN
          FOR l := j- 1 TO j+ 1 DO BEGIN
            Ero.body[k,l].r := 0;	//mettre les pixels auTOur en noir
            Ero.body[k,l].g := 0;
            Ero.body[k,l].b := 0;
          END;
        END;
      END
      ELSE BEGIN
        Ero.body[i,j].r := bin.body[i,j].r;
        Ero.body[i,j].g := bin.body[i,j].g;
        Ero.body[i,j].b := bin.body[i,j].b;
      END;
  END;
  erode := Ero;
END;


{--------------------------------dilateImage-----------------------------------}
FUNCTION sortiedilateImage(VAR seuil : INTEGER; VAR grey,bin : IMAGE;img : IMAGE;VAR hist : hisTOgramme) : Image;
BEGIN
  calcHisTOSeuilGrisBin(seuil,grey,bin,img,hist);
  sortiedilateImage := dilateImage(bin);
END;

FUNCTION dilateImage ( bin : Image ) : Image;
VAR
  k,l,i,j : integer;
	Dil : image;
BEGIN
  Dil.magic := bin.magic;
	Dil.height := bin.height;
	Dil.width := bin.width;
	Dil.max := bin.max;
  setlength(Dil.body,Dil.height,Dil.width);
  FOR i:=1 TO Dil.height-2 DO
    FOR j:=1 TO Dil.width-2 DO BEGIN
      IF (bin.body[i,j].r = 255) THEN	BEGIN//quand rencontre un pixel noir
          FOR k := i- 1 TO i+ 1 DO BEGIN
            FOR l := j- 1 TO j+ 1 DO BEGIN
              Dil.body[k,l].r := 255;	//mettre les pixels auTOur en noir
              Dil.body[k,l].g := 255;
              Dil.body[k,l].b := 255;
            END;
          END;
      END
      ELSE BEGIN
        Dil.body[i,j].r := bin.body[i,j].r;
        Dil.body[i,j].g := bin.body[i,j].g;
        Dil.body[i,j].b := bin.body[i,j].b;
      END;
  END;
  dilateImage := Dil;
END;

{--------------------------------Segmentation-----------------------------------}
FUNCTION MAXI(bin : Image; i,j : integer):integer; // trouver la couleur la plus présente auTOur d'un pixel ( en le comptant lui même )
// change les VARiable de MAXI dans la parenthese aussi.
VAR
MAX,n,b,k,l : integer;
BEGIN
  n := 0;
  b := 0;
	FOR k := i- 1 TO i+ 1 DO BEGIN
    FOR l := j- 1 TO j+ 1 DO BEGIN
			IF (bin.body[i,j].r = 0) THEN
        n := n +1
      ELSE
        b := b +1;
		END;
	END;
	IF (b > n) THEN
    MAX := 255
	ELSE
    MAX := 0;
	MAXI := MAX;
END;

FUNCTION sortieSegmentation(VAR seuil : INTEGER; VAR grey,bin : IMAGE;img : IMAGE;VAR hist : hisTOgramme) : Image;
BEGIN
  calcHisTOSeuilGrisBin(seuil,grey,bin,img,hist);
  sortieSegmentation := segmentation(bin);
END;

FUNCTION segmentation(bin : Image): Image;
VAR
  k,l,i,j,mix : integer;
	Seg : image;
BEGIN
  seg.magic := bin.magic;
	seg.height := bin.height;
	seg.width := bin.width;
	seg.max := bin.max;
  setlength(seg.body,seg.height,seg.width);
  FOR i := 1 TO seg.height-2 DO BEGIN
    FOR j := 1 TO seg.width-2 DO  BEGIN
      mix := MAXI(bin,i,j);
      WRITELN(mix);
    //  WRITELN(mix);
      //readkey;// appelle la fonction MAXI
		    {FOR k := i- 1 TO i+ 1 DO BEGIN
          FOR l := j- 1 TO j+ 1 DO BEGIN
            Seg.body[k,l].r := mix;
            Seg.body[k,l].g := mix;
            Seg.body[k,l].b := mix;
          END;
        END;}
      IF (MIX = 0) THEN BEGIN// si le noir est le plus présent

        FOR k := i- 1 TO i+ 1 DO BEGIN
          FOR l := j- 1 TO j+ 1 DO BEGIN
            Seg.body[k,l].r := 0;	//mettre les pixels auTOur en noir
            Seg.body[k,l].g := 0;
            Seg.body[k,l].b := 0;
            END;
        END;
      END
      ELSE BEGIN
        FOR k := i- 1 TO i+ 1 DO BEGIN
          FOR l := j- 1 TO j+ 1 DO BEGIN
            Seg.body[k,l].r := 255;	//mettre les pixels auTOur en noir
            Seg.body[k,l].g := 255;
            Seg.body[k,l].b := 255;
          END;
        END;
      END;
    END;
  END;
  segmentation := Seg;
END;

END.
