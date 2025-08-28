/**
 * Calc Scanner
 * This code scans the input and assigns it to tokens. If there are any
 * unknown tokens, it will throw errors.
 *
 * @file: calc.l
 * @author: Josh Nygaard (joshdn03@gmail.com)
 * @version: 1.1
 */

%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <math.h>
    #include "calc.tab.h"
%}

%%
[ \t\r] { ; }

[0-9]+\.[0-9]+ {
    yylval.val = atof(yytext);
    return NUM;
}
[0-9]+ {
    yylval.val = atof(yytext);
    return NUM;
}
"\n" { return NEWLINE; }

"help" { return HELPCMD; }
"exit" { return EXITCMD; }

"+"     { return PLUS; }
"-"     { return MINUS; }
"*"     { return TIMES; }
"/"     { return DIV; }
"^"     { return EXP; }
"("     { return LBRACKET; }
")"     { return RBRACKET; }

"rad"   { return RAD; }
"deg"   { return DEG; }
"sin"   { return SIN; }
"cos"   { return COS; }
"tan"   { return TAN; }
"csc"   { return CSC; }
"sec"   { return SEC; }
"cot"   { return COT; }
"asin"  { return ASIN; }
"acos"  { return ACOS; }
"atan"  { return ATAN; }
"asec"  { return ASEC; }
"acsc"  { return ACSC; }
"acot"  { return ACOT; }

"e" {
    yylval.val = M_E;
    return NUM;
}
"pi" {
    yylval.val = M_PI;
    return NUM;
}

"%"         { return MOD; }
"round"     { return ROUND; }
"floor"     { return FLOOR; }
"ceil"      { return CEIL; }
"!"         { return FACT; }
"abs"       { return ABS; }
"log"       { return LOG; }
"ln"        { return LN; }
","         { return COMMA; }
"min"       { return MIN; }
"max"       { return MAX; }
"rand"      { return RAND; }
"randint"   { return RANDINT; }
"sqrt"      { return SQRT; }
"root"      { return ROOT; }

. {
    extern int errFlag;
    if (!errFlag) {
        char buf[80];
        snprintf(buf, sizeof(buf), "SYNTAX ERROR: Unexpected \"%s\" found", yytext);
        yyerror(buf);
    }
}
%%
