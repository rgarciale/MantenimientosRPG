**free
ctl-opt NoMain Option(*SrcStmt);

//----------------------------------------------------------------------
//   Imported Procedures
//----------------------------------------------------------------------

/include qinclude,TESTCASE
/include qinclude,ASSERT
/include qinclude,TEMPLATES



//----------------------------------------------------------------------
//   Test Procedures
//----------------------------------------------------------------------

dcl-proc test_case1_add_records export;
  dcl-pi *n extproc(*dclcase);
  end-pi;

  
  dcl-s resultado char(3) inz; 

  exec sql
    delete from provincias;
  
  exec sql
    insert into provincias (id_provincia, nombre_provincia)
    values
      (1, 'San José'),
      (2, 'Alajuela'),
      (3, 'Cartago'),
      (4, 'Heredia'),
      (5, 'Guanacaste'),
      (6, 'Puntarenas'),
      (7, 'Limón');

  assert(*on:'OK');
end-proc;
