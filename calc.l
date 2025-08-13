/**
 * Calc Scanner
 * This code scans the input and assigns it to tokens. If there are any
 * unknown tokens, it will throw errors.
 *
 * @file: calc.l
 * @author: Josh Nygaard (joshdn03@gmail.com)
 * @version: 1.0
 */

%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <math.h>
    #include "calc.tab.h"
%}

%%
[ \t\r] {
    ;
}
[0-9]+\.[0-9]+ {
    yylval.val = atof(yytext);
    return NUM;
}
[0-9]+ {
    yylval.val = atof(yytext);
    return NUM;
}
"+" {
    return PLUS;
}
"-" {
    return MINUS;
}
"*" {
    return TIMES;
}
"/" {
    return DIV;
}
"^" {
    return EXP;
}
"(" {
    return LBRACKET;
}
")" {
    return RBRACKET;
}
"\n" {
    return NEWLINE;
}
"help" {
    return HELPCMD;
}
"exit" {
    return EXITCMD;
}
"rad" {
    return RAD;
}
"deg" {
    return DEG;
}
"sqrt" {
    return SQRT;
}
"sin" {
    return SIN;
}
"cos" {
    return COS;
}
"tan" {
    return TAN;
}
"e" {
    yylval.val = M_E;
    return NUM;
}
"pi" {
    yylval.val = M_PI;
    return NUM;
}
"%" {
    return MOD;
}
"round" {
    return ROUND;
}
"floor" {
    return FLOOR;
}
"ceil" {
    return CEIL;
}
"!" {
    return FACT;
}


. {
    printf("SYNTAX ERROR: Unexpected \"%s\" found\n", yytext);
}
%%