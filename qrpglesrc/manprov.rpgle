
     FMANPROVFM CF   E             WORKSTN SFILE(SUBFILEPRV:RRN)
     F                                     INFDS(INFDS)
     FBENPRV    UF A E           K DISK
     *********************DECLARACIONES***********************************
     DINFDS            DS
     DRRN                             4  0
     DIDKEY            S              9S 0

     C                   DOW       *IN12 = '0'
     C                   EXSR      DSPSFL
     C                   IF        *IN12 = '1'
     C                   LEAVE
     C                   ENDIF
     C                   IF        *IN06
     C                   EXSR      SRADD
     C                   ELSE
     C                   EXSR      LEESFL
     C                   ENDIF
     C                   SETON                                        05
     C                   EXSR      CLRSFL
     C                   EXSR      FILSFL
     C                   EXSR      DSPSFL
     C                   ENDDO

     C                   seton                                        LR
     ****************************************************************
     ************      Llena el subfile     *********************
     C     FILSFL        BEGSR
     C                   SETOFF                                           45
     C     *LOVAL        SETLL     BENRPRV
     C                   DOU       %EOF
     C                   READ      BENRPRV
     C                   IF        NOT %EOF
     C                   EVAL      VARIDPRV = IDPRV
     C                   EVAL      VARNOMPRV = NOMPRV
     C                   ADD       1             RRN
     C                   WRITE     SUBFILEPRV
     C                   ENDIF
     C                   ENDDO
     C                   ENDSR
     **************************************************************
     C     LEESFL        BEGSR
     C                   READC     SUBFILEPRV
     C                   DOW       NOT %EOF()
     C                   SELECT
     C     VAROPC        WHENEQ    2
     C     VAROPC        WHENEQ    4
     C     VAROPC        WHENEQ    5
     C                   EXSR      VIEWSR
     C                   Z-ADD     *BLANKS       VAROPC
     C                   OTHER
     C                   EVAL      MENSAJE = 'OPCION INCORRECTA'
     C                   ENDSL
     C                   READC     SUBFILEPRV

     C                   ENDDO
     C                   ENDSR
     *************** limpia y apaga el control subfile************
       BEGSR *INZSR;
       *IN50 = *OFF;
       *IN51 = *OFF;
       *IN52 = *OFF;
       *IN45 = *OFF;
       //LIMPIO LOS VALORES DE CONTROL
        RRN = *ZEROS;
        EXSR  CLRSFL;
        EXSR  FILSFL;

       ENDSR;
     ******************************************************************
     *******************Limpia el subfile ****************************
       BEGSR CLRSFL;
        RRN=0;
        *IN50 = *ON;
       //MOSTRAR EL HEADER
        WRITE SUBFCTLPRV;
       //SE APAGA EL INDICADOR DE LIMPIEZA
        *IN50 = *OFF;

       ENDSR;
     ******************************************************************
       BEGSR SRADD;
        DOW *IN12 = *OFF;

           EXFMT PANTINSERT;

           IF *IN01 = '1';
              EXSR VALIDAR;
           IF SALIDA = '';
              EXSR INSERTAR;
              LEAVE;
           ENDIF;
           ENDIF;
       ENDDO;
           *IN01 = *OFF;
           *IN12 = *OFF;

       ENDSR;
     *******************************************************************
     C     DSPSFL        BEGSR
     C                   SETON                                        5152
     C                   IF        RRN <= *ZEROS
     C                   SETOFF                                       52
     C                   ENDIF
     C*                  EVAL      FUNCIONES = 'F6=CREAR, F12=CANCELAR'
     C                   WRITE     FOOTER
     C                   EXFMT     SUBFCTLPRV
     C                   SETOFF                                       5152
     C                   ENDSR

     *******************************************************************
     C     VALIDAR       BEGSR
     C                   EVAL      SALIDA = ''
     C                   IF        IDPRVP = 0
     C                   EVAL      SALIDA = 'ERROR: El id no puede ser 0'
     C                   LEAVESR
     C                   ENDIF

     C                   IF        NOMPRVP = *BLANKS
     C                   EVAL      SALIDA = 'ERROR: El nombre esta vacio'
     C                   LEAVESR
     C                   ENDIF


     C                   IF        SALIDA = ''
     C                   EVAL      IDKEY = IDPRVP
     C     IDKEY         CHAIN     BENPRV
     C                   IF        %FOUND(BENPRV)
     C                   EVAL      SALIDA = 'ERROR: Codigo ya existe.'
     C                   ENDIF
     C                   ENDIF

     C                   ENDSR
     ************************VER REGISTRO***************************
     C     VIEWSR        BEGSR

     C     VARIDPRV      CHAIN     BENRPRV
     C                   EVAL      IDPRVPVIW = VARIDPRV
     C                   EVAL      NOMPRVPVIW = VARNOMPRV
     C     *IN12         DOWEQ     *OFF
     C                   EXFMT     PANTVIEW
     C                   ENDDO
     C                   SETOFF                                       12
     C                   ENDSR
     ***************************************************************
     C     INSERTAR      BEGSR
     C                   EVAL      IDPRV = IDPRVP
     C                   EVAL      NOMPRV = NOMPRVP
     C                   WRITE     BENRPRV
     C                   EVAL      SALIDA = 'Registro insertado.'
     C                   ENDSR


