**free
ctl-opt dftactgrp(*no) actgrp(*caller);
dcl-f PROVMANTF workstn indds(dsplyInd) sfile(SUBFILE:recordNumber)  prefix('FM_');

dcl-ds dsplyInd qualified;
   exit ind pos(3);
   subfEnd ind pos(45);
   clrSubf ind pos(50);
   sflDspCtl ind pos(51);
   sflDsp ind pos(52);
end-ds;

dcl-s recordNumber zoned(4) inz;

main();
*inlr = '1';

dcl-proc main;

  FM_fecha = %char(%date():*eur);

  dow not dsplyInd.exit;
    clearSubfile();
    cargaSubfile();
    displaySubfile();
  enddo;

end-proc;

dcl-proc clearSubfile;
  clear recordNumber;
  dsplyInd.clrSubf = *on;
  write SUBFILECTL;
  dsplyInd.clrSubf = *off;
end-proc;

dcl-proc cargaSubfile;

  dcl-s codigoProvincia int(10);
  dcl-s nombreProvincia varchar(30);

  dsplyInd.subfEnd = *off;

  exec sql
    close Cursor_Provincias;

  exec sql
    declare Cursor_Provincias cursor for
      select id_provincia, nombre_provincia
      from PROVINCIAS
      for read only;

  exec sql
    open Cursor_Provincias;

  dow sqlcode = *zeros;

    exec sql
      fetch next from Cursor_Provincias
        into :codigoProvincia, :nombreProvincia;

    if sqlcode = *zeros and recordNumber < 9999;
      FM_CODIGO = codigoProvincia;
      FM_NOMBRE = nombreProvincia;
      recordNumber += 1;
      write SUBFILE;
    else;
      leave;
    endif;

  enddo;
  
end-proc;

dcl-proc displaySubfile;
  dsplyInd.sflDsp = *on;
  dsplyInd.sflDspCtl = *on;

  if recordNumber <= 0;
    dsplyInd.sflDsp = *off;
  endif;

  exfmt SUBFILECTL;
  
  dsplyInd.sflDsp = *off;
  dsplyInd.sflDspCtl = *off;
end-proc;


