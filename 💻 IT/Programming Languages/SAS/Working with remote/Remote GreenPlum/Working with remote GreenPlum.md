Необходимые условия:
* должна быть прописана переменная окружения GPLOAD_HOME, которая смотрит в каталог gpfdist
* при подключении необходимо указывать адрес и порт, на которых работает утилита gpfdist
* при подключении необходимо устанавливать опцию подключения search_path на название схемы, к которой есть права за запись, там будут создаваться временные внешние таблицы (это можно делать при подключении к библиотеке, в опции `dbconinit`, либо установить один раз через команду `alter role <username> set search_path=schemaname`, такой метод больше подойдет для техучеток)
```SAS
LIBNAME xLOCAL1x      /* Max length must be 8 characters */
    '/path/to/folder'
;




LIBNAME xGPSCHMx
    GREENPLM
    SERVER     = 'xGREENPLUM.SERVER.RUx'
    PORT       = x5555x
    USER       = 'GREENPLUM_USER'
    PASSWORD   = 'PASSWORD_FOR_GREENPLUM_USER'
    DATABASE   = 'GREENPLUM_SCHEME'
    dbconinit  = 'SET search_path to <schema name>; commit;'
    connection = global
;




DATA xGPSCHMx.xGPFDIST_TABLEx (
    /* v----------------------------- SETTINGS ----------------------------v */
    BL_HOST     = 'GPFDIST.SERVER.RUx'
    BL_PORT     = 'x5555x/'    /* Yes, '/' is needed                         */
    BL_FORMAT   = 'CSV'        /* Auto-converts .sas into 'CSV' or 'TEXT'    */
    BL_USE_PIPE = YES          /*  Don't create temporary files. May crash   */
    /* ^----------------------------- SETTINGS ----------------------------^ */
    
    /* v------------------- SETTINGS (always stay same) -------------------v */
    BULKLOAD    = YES          /* Always stays the same */
    BL_PROTOCOL = gpfdists     /* Always stays the same */
    BL_QUOTE    = '\001'       /* For russian smbols to work properly */
    BL_ESCAPE   = OFF          /* For russian smbols to work properly */
    BL_ENCODING = 'ISO_8859_5' /* For russian smbols to work properly */
    /* ^------------------- SETTINGS (always stay same) -------------------^ */
);
    SET xLOCAL1x.xLOCAL_TABLEx;
RUN;
```