

%{
#include <stdio.h>
#include <math.h>
#include <stdlib.h>


extern void yyerror(const char* err);
extern FILE *yyin;
extern FILE *yyout;
extern int yylex();
  extern int yyparse();
    extern int yylineno;
%}

%error-verbose

%union{
	int intval;
	float floatval;
	char charval;
}

%token T_eof   0 "end of file"
%token T_IF   "IF"
%token T_ELSE  "ELSE"
%token T_STARTMAIN "STARTMAIN"
%token T_FOR   "FOR"
%token T_FUNCTION  "FUNCTION"
%token T_PROGRAM  "PROGRAM"
%token T_semicolon  ";"
%token T_komma ","
%token T_openagk "{"
%token T_closeagk "}"
%token T_openpar "["
%token T_closepar "]"
%token T_boolean "true or false"
%token <intval> T_intident "intnumber"
%token T_int "INT"
%token T_VARS "VARS"
%token T_float "FLOAT"
%token <floatval> T_floatident "floatnumber"
%token T_ws "kena"
%token T_telia "."
%token T_ELSEIF "ELSEIF"
%token T_ANDOP "&&"
%token T_OROP "||"
%token T_NOT "!"
%token T_adop  "+ or -"
%token T_equop " == or != "
%token T_end "ENDFUNCTION"
%token T_mulop "* or / or  % or ^"
%token T_char "CHAR"
%token T_ENDMAIN "ENDMAIN"
%token T_return "RETURN"
%token <charval> T_charident "charnumber"
%token T_pin "PINAKAS"
%token T_open "("
%token T_close ")"
%token T_relop "< or > or <= or >="
%token T_ASSIGN "="
%token T_TO "TO"
%token T_STEP "STEP"
%token T_BREAK "BREAK"
%token T_ENDFOR "ENDFOR"
%token T_SWITCH "SWITCH"
%token T_WHILE "WHILE"
%token T_colon ":"
%token T_CASE "CASE" /**/
%token T_PRINT "PRINT"
%token T_ENDWHILE "ENDWHILE"
%token T_ENDIF "ENDIF"
%token T_THEN "THEN"
%token T_ENDSWITCH "ENDSWITCH"
%token T_DEFAULT "DEFAULT"
%token T_STRUCT "STRUCT"
%token T_ENDSTRUCT "ENDSTRUCT"
%token T_TYPEDEF "TYPEDEF"
%token T_string "string"

%%

Arxiko_programma: T_PROGRAM onoma {printf("\n");} swma_programmatos ;

onoma: T_charident ;

dilosi_domis: T_STRUCT onoma {printf("\n");} dilwsi_metavlitis T_ENDSTRUCT
  |T_TYPEDEF T_STRUCT onoma {printf("\n");} dilwsi_metavlitis {printf("\n");} onoma T_ENDSTRUCT
  ;


swma_programmatos : dilosi_domis Functions  main_function
   | dilosi_domis main_function
   | main_function 
   ;

Functions : T_FUNCTION onoma T_open P1 T_close swma_Function T_return T_charident {printf("\n");} T_end ;

P1 : %empty
   | V1 P1
   ;

V1 : tupos_metavlitis d
   | tupos_metavlitis d T_komma
   ;

d  : onoma | pinakas;


pinakas :T_pin ;

tupos_metavlitis : T_int
                 | T_float
                 | T_char
                 ;

swma_Function : dilwsi_metavlitis entoles_programmatos
             | dilwsi_metavlitis
             | %empty
             ;

dilwsi_metavlitis : T_VARS tropos_dilwsis T_semicolon ;

tropos_dilwsis : tupos_metavlitis P2 ;

P2 : V2
   | V2 P2
   ;
V2 : d
   | d T_komma | T_komma d G
   ;

G  : %empty
   ;

entoles_programmatos : entoles_anathesis loipes_entoles
                     |entoles_anathesis
                     | loipes_entoles
                     | %empty
                     ;

entoles_anathesis : cock ;
cock: vcock|vcock cock ;
vcock:metavliti T_ASSIGN ekfrasi T_semicolon ;

metavliti : d ;

main_function: T_STARTMAIN dilwsi_metavlitis entoles_programmatos T_ENDMAIN
 |  T_STARTMAIN entoles_programmatos T_ENDMAIN
 ;

ekfrasi : apli_ekfrasi
        | suntheti_ekfrasi
        ;

apli_ekfrasi : metavliti
             | arithmos
             // | sunartisi
             ;

arithmos: T_intident
  | T_floatident
  ;

A: metavliti
  | arithmos
  ;

suntheti_ekfrasi :  A  k ;

k : Vk
  | Vk k
  ;

Vk:  T_adop A
  |  T_mulop A
  ;




loipes_entoles : dick /* entoles_vroxou entoles_elegxou entoles_ekt
               | entoles_vroxou entoles_ekt
               | entoles_elegxou entoles_ekt
               | entoles_vroxou  entoles_elegxou
               | entoles_ekt
               | entoles_vroxou
               | entoles_elegxou
               | %empty
               ;  */


dick: Q |Q dick ;

Q:entoles_vroxou entoles_elegxou entoles_ekt
               | entoles_vroxou entoles_ekt
               | entoles_elegxou entoles_ekt
               | entoles_vroxou  entoles_elegxou
               | entoles_ekt
               | entoles_vroxou
               | entoles_elegxou
               //| %empty  ;//






entoles_vroxou : for_entoles
                | while_entoles
                ;

for_entoles : T_FOR counter T_colon T_ASSIGN noumero T_TO giwta T_STEP noumero {printf("\n");} entoles_programmatos L T_ENDFOR ;

giwta:T_intident | T_charident ;

noumero: T_intident;

counter:metavliti ;

while_entoles: T_WHILE T_open synthiki T_close {printf("\n");} entoles_programmatos L T_ENDWHILE ;


//telestes: telestes_sygkrisis
 | telestes_logikis
 ;//

telestes_sygkrisis: T_relop
 | T_equop
 ;

telestes_logikis: T_ANDOP
 | T_OROP
 ; 

L: %empty
 | Vl L
 ;

Vl : T_BREAK T_semicolon ;

entoles_ekt : T_PRINT T_open T_string X T_close T_semicolon ;

X: %empty | joe X  ;

joe:   T_komma d  ;


entoles_elegxou: if_entoles
               | switch_entoles
               | if_entoles switch_entoles
               ;

if_entoles: T_IF T_open synthiki T_close T_THEN {printf("\n");} entoles_programmatos elseif else L T_ENDIF ;

synthiki: P 
        | T   ;
	     
 P: A telestes_sygkrisis A ;
 T: %empty 
  | J T
  ;
 J: P telestes_logikis P 
  | telestes_logikis P
  ;


elseif: %empty                 
 //| T_ELSEIF  entoles_programmatos//
      | T_ELSEIF  entoles_programmatos elseif
      ;

 else: %empty
     | T_ELSE entoles_programmatos
     ;

 switch_entoles: T_SWITCH  T_open ekfrasi  T_close {printf("\n");} case  T_ENDSWITCH ;

case: M L
    | M L case
    | M L default 
    ;

M: T_CASE T_open ekfrasi T_close T_colon {printf("\n");} entoles_programmatos ;

default: T_DEFAULT T_colon entoles_programmatos ;

%%

int main(int argc, char *argv[]) {
     int token;
     if(argc>1){
       yyin=fopen(argv[1],"r");
       if(yyin==NULL){
         perror ("error open");
         return -1;
       }
     }

			yyparse();

     fclose(yyin);
     return 0;
}
