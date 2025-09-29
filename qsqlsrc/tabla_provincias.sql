--*******************************************************************--
-- NOMBRE DE LA TABLA: BENPRV                                        --
-- DESCRIPCION:                                                      --
--     TABLA DE CATALOGO DE PROVINCIAS                               --
-- OBJETIVO:                                                         --
--     ALMACENAR EL CATALOGO DE LAS PROVINCIAS                       --
-- USO DE LOS DATOS:                                                 --
--      TABLA CATALOGO.                                              --
--===================================================================--
-- HECHO POR: KEVIN CASTRILLO J.                                     --
-- FECHA: 01/08/2025.                                                --
-- DESCRIPCION: BASE DE DATOS BANCARIA                               --
--*******************************************************************--

CREATE OR REPLACE TABLE BENPRV (
      ID_PROVINCIA FOR COLUMN IDPRV INTEGER NOT NULL,
      NOMBRE_PROVINCIA FOR COLUMN NOMPRV NVARCHAR(30) NOT NULL UNIQUE,
      CONSTRAINT PK_BENPRV PRIMARY KEY (IDPRV)
) RCDFMT BENRPRV;

RENAME TABLE BENPRV TO BEN_PROVINCIACR FOR SYSTEM NAME BENPRV;

LABEL ON TABLE BENPRV IS 'TABLA DE PROVINCIA SISTEMA';
COMMENT ON TABLE BENPRV IS 'TABLA DE CATALOGO DE PROVINCIAS';

LABEL ON COLUMN BENPRV (
      IDPRV IS 'ID PROVINCIA',
      NOMPRV IS 'NOMBRE PROVINCIA'
);

LABEL ON COLUMN BENPRV (
      IDPRV TEXT IS 'ID PROVINCIA',
      NOMPRV TEXT IS 'NOMBRE PROVINCIA'
);

COMMENT ON COLUMN BENPRV (
      IDPRV IS 'COMENTARIO ID PROVINCIA',
      NOMPRV IS 'COMENTARIO NOMBRE PROVINCIA'
);
