BIN_LIB=DEV
APP_BNDDIR=
LIBL=$(BIN_LIB)

INCDIR=""
BNDDIR=*NONE
PREPATH=/QSYS.LIB/$(BIN_LIB).LIB
SHELL=/QOpenSys/usr/bin/qsh

$(PREPATH)/MANPROV.MODULE: $(PREPATH)/MANPROVFM.FILE

.logs:
	mkdir .logs
.evfevent:
	mkdir .evfevent
library:
	-system -q "CRTLIB LIB($(BIN_LIB))"




$(PREPATH)/MANPROV.MODULE: qrpglesrc/manprov.rpgle
	liblist -c $(BIN_LIB);\
	liblist -a $(LIBL);\
	system "CRTRPGMOD MODULE($(BIN_LIB)/MANPROV) SRCSTMF('qrpglesrc/manprov.rpgle') OPTION(*EVENTF) DBGVIEW(*SOURCE) TGTRLS(*CURRENT) TGTCCSID(*JOB)" > .logs/manprov.splf || \
	(system "CPYTOSTMF FROMMBR('$(PREPATH)/EVFEVENT.FILE/MANPROV.MBR') TOSTMF('.evfevent/manprov.evfevent') DBFCCSID(*FILE) STMFCCSID(1208) STMFOPT(*REPLACE)"; $(SHELL) -c 'exit 1')



$(PREPATH)/MANPROVFM.FILE: qfilsrc/manprovfm.dspf
	-system -qi "CRTSRCPF FILE($(BIN_LIB)/QTMPSRC) RCDLEN(112) CCSID(*JOB)"
	system "CPYFRMSTMF FROMSTMF('qfilsrc/manprovfm.dspf') TOMBR('$(PREPATH)/QTMPSRC.FILE/MANPROVFM.MBR') MBROPT(*REPLACE)"
	liblist -c $(BIN_LIB);\
	liblist -a $(LIBL);\
	system "CRTDSPF FILE($(BIN_LIB)/MANPROVFM) SRCFILE($(BIN_LIB)/QTMPSRC) SRCMBR(MANPROVFM) OPTION(*EVENTF)" > .logs/manprovfm.splf || \
	(system "CPYTOSTMF FROMMBR('$(PREPATH)/EVFEVENT.FILE/MANPROVFM.MBR') TOSTMF('.evfevent/manprovfm.evfevent') DBFCCSID(*FILE) STMFCCSID(1208) STMFOPT(*REPLACE)"; $(SHELL) -c 'exit 1')



$(PREPATH)/PROVINCIAS.FILE: qsqlsrc/PROVINCIAS-tabla_provincias.sql
	liblist -c $(BIN_LIB);\
	liblist -a $(LIBL);\
	system "RUNSQLSTM SRCSTMF('qsqlsrc/PROVINCIAS-tabla_provincias.sql') COMMIT(*NONE)" > .logs/provincias.splf






$(PREPATH)/%.BNDDIR: 
	-system -q "CRTBNDDIR BNDDIR($(BIN_LIB)/$*)"
	-system -q "ADDBNDDIRE BNDDIR($(BIN_LIB)/$*) OBJ($(patsubst %.SRVPGM,(*LIBL/% *SRVPGM *IMMED),$(notdir $^)))"




