PROGRAM traitementImage;
USES
	menuText,crt,create,manipulationBasiques,ES;
VAR
	nom_fichieri,modcr : STRING;
{$i-}
{-----------------------------Proc_aide--------------------------------}
PROCEDURE aide;
VAR
	ligne : STRING;
	help1 : Text;
BEGIN
	ligne := '';
	ASSIGN(help1,'help');
	reset(help1);
	IF (IOResult <> 0) THEN
		writeln('Le fichier d''aide n''existe pas')
	ELSE BEGIN
		REPEAT
			WRITELN(ligne);
			READLN(help1,ligne);
		UNTIL eof(help1);
	close(help1);
	END;
END;

{------------------------------Proc_menu------------------------------------}
PROCEDURE menu(VAR modcr : STRING);
BEGIN
	welcome(modcr);
	choix(modcr,nom_fichieri,fichier);
END;

{--------------------------Proc_ordre_param-----------------------------}
PROCEDURE ordre;
BEGIN
	IF (PARAMSTR(1) <> '-i') or (PARAMSTR(1) <> '-O') or (PARAMSTR(1) <> '-c') THEN BEGIN
		WRITELN('ERREUR : Vous avez entre une mauvaise commande.');
		WRITELN('Pour avoir de l''aide tapez ./p -h ');
	END;
END;

{-----------------------------Programme Princ-------------------------------}
BEGIN
modcr := '';
{-------------------------------Commandes--------------------------------}
	IF PARAMSTR(1) = '-h' THEN BEGIN //Affiche une aide
		ClrScr;
		aide;
	END
	ELSE IF PARAMSTR(1) = '-i' THEN BEGIN
		WRITELN('-i');
	END
	ELSE IF PARAMSTR(1) = '-o' THEN BEGIN
		WRITELN('-o');
	END
	ELSE IF PARAMSTR(1) = '-c' THEN BEGIN
		WRITELN('-c');
	END
	ELSE IF PARAMSTR(1) = '' THEN
		menu(modcr)
	ELSE BEGIN
		WRITELN('ERREUR : Vous avez entre une mauvaise commande.');
		WRITELN('Pour avoir de l''aide tapez ./p -h ');
	END;

	{ELSE IF PARAMSTR(1) = '-g' THEN
	BEGIN
		WRITELN('-g');
	END
	ELSE IF PARAMSTR(1) = '-b' THEN
	BEGIN
		WRITELN('-b');
	END
	ELSE IF PARAMSTR(1) = '-z' THEN
	BEGIN
		WRITELN('-z');
	END
	ELSE IF PARAMSTR(1) = '-Z' THEN
	BEGIN
		WRITELN('-Z');
	END
	ELSE IF PARAMSTR(1) = '-r' THEN
	BEGIN
		WRITELN('-r');
	END
	ELSE IF PARAMSTR(1) = '-rc' THEN
	BEGIN
		WRITELN('-rc');
	END
	ELSE IF PARAMSTR(1) = '-f' THEN
	BEGIN
		WRITELN('-f');
	END
	ELSE IF PARAMSTR(1) = '-e' THEN
	BEGIN
		WRITELN('-e');
	END
	ELSE IF PARAMSTR(1) = '-d' THEN
	BEGIN
		WRITELN('-d');
	END
	ELSE IF PARAMSTR(1) = '-s' THEN
	BEGIN
		WRITELN('-s');
	END
	ELSE IF PARAMSTR(1) = '-ch' THEN
	BEGIN
		WRITELN('-ch');
	END}
END.
