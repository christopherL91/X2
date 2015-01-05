      *Example COBOL program
       IDENTIFICATION DIVISION.
       PROGRAM-ID. hello_world.
       DATA DIVISION.
        WORKING-STORAGE SECTION.
        01 N PIC A(100).
       PROCEDURE DIVISION.
       DISPLAY "Hello world".
       ACCEPT N.
       STOP RUN.