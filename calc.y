/**
* Calculator
* This program scans an input equation from the console and evaluates
* it, stating any errors that come up. This calculator currently
* supports the following functionalities:
*     > Brackets
*     > Exponents
*     > Addition
*     > Subtraction
*     > Multiplication
*     > Division
*     > Special functions: sqrt, mod, floor, ceil, round
*     > Trig functions: sin, cos, tan
*           > Toggle between radians and degrees
*     > Integers or decimals
*     > Positive or negative numbers
* The user can also type "help" for instructions on how to use the
* calculator, or "exit" to exit the program.
*
* @file: calc.y
* @author: Josh Nygaard (joshdn03@gmail.com)
* @version: 1.0
*/

%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include <math.h>
    #include "calc.tab.h"

    int yylex(void);
    void yyerror(const char* s);

    int errFlag = 0; // Evaluation should not print if there are any errors present.
    int trigMode = 0; // 0 for radians, 1 for degrees
%}

%union {
    double val;
}

%token <val> NUM
%token PLUS
%token MINUS
%token TIMES
%token DIV
%token EXP
%token LBRACKET
%token RBRACKET
%token NEWLINE
%token EXITCMD
%token HELPCMD
%token SQRT
%token SIN
%token COS
%token TAN
%token RAD
%token DEG
%token MOD
%token ROUND
%token FLOOR
%token CEIL
%token FACT

%left PLUS MINUS
%left TIMES DIV
%right EXP
%right UMINUS

%type <val> expr

%%
input : | input line;

line : expr NEWLINE {
    if (!errFlag) {
        printf("= %g\n> ", $1);
    }
    errFlag = 0;
} | EXITCMD NEWLINE {
    printf("Exiting Calculator.\n");
    exit(0);
} | HELPCMD NEWLINE {
    printf(
        "===== HELP =====\n"
        "This calculator evaluates math expressions entered into the\n"
        "console.\n\n"
        "Examples:\n"
        "\t> 1 + 1\n"
        "\t> (-5 + 4) - 3\n"
        "\t> 5 + 4 + 3 + 2 + 1\n"
        "\t> 6 * (8.4 - 3.5) / 2.3\n"
        "\t> 3 ^ 10\n"
        "\t> sin(180)\n"
        "\t> sqrt(16)\n"
        "\t> e * pi\n"
        "\t> round(2.3)\n"
        "\t> ceil(4.1)\n"
        "\t> floor(5.9)\n"
        "\t> 5 %% 2\n"
        "\t> 10!\n\n"
        "Supported features:\n"
        "\t> Brackets: ()\n"
        "\t> Exponents: ^\n"
        "\t> Operators: +, -, *, /\n"
        "\t> Square root: sqrt\n"
        "\t> Trigonometry: sin, cos, tan\n"
        "\t> Modulo: %%\n"
        "\t> Truncation: floor, ceil\n"
        "\t> Rounding: round\n"
        "\t> Special constants: e ≈ 2.7183, pi ≈ 3.14159\n"
        "\t> Factorials: !\n"
        "\t> Integers and decimals\n"
        "\t> Positive and negative numbers\n"
        "Note: Trigonometry functions are available in both radians\n"
        "and degrees. You can switch to one or the other by simply\n"
        "typing 'rad' or 'deg', respectively.\n\n"
        "Common syntax errors:\n"
        "\t> Unmatched brackets:\t\t5 - (4 - 3\n"
        "\t> Division by zero:\t\t5 / 0\n"
        "\t> Negative square roots:\tsqrt(-1)\n"
        "\t> Incomplete expressions:\t3 + 2 +\n"
        "\t> Unrecognized characters:\t5 + x\n"
        "\t> Invalid factorials:\t\t-10.5!\n\n"
        "Type 'exit' to quit, or 'help' to see this\n"
        "message again.\n> "
    );

} | RAD NEWLINE {
    trigMode = 0;
    printf("Trigonometry mode set to radians.\n> ");
} | DEG NEWLINE {
    trigMode = 1;
    printf("Trigonometry mode set to degrees.\n> ");
} | error NEWLINE {
    errFlag = 1;
    yyerrok;
    printf("> ");
    errFlag = 0;
};

expr : NUM {
    $$ = $1;
} | expr PLUS expr {
    $$ = $1 + $3;
} | expr MINUS expr {
    $$ = $1 - $3;
} | expr TIMES expr {
    $$ = $1 * $3;
} | expr DIV expr {
    if ($3 == 0) {
        yyerror("Division by zero");
        printf("> ");
    } else {
        $$ = $1 / $3;
    }
} | expr MOD expr {
    if ((int)$3 == 0) {
        yyerror("Modulo by zero");
        printf("> ");
    } else {
        $$ = fmod($1, $3);
    }
} | expr EXP expr {
    $$ = pow($1, $3);
} | MINUS expr %prec UMINUS {
    $$ = -$2;
} | PLUS expr %prec UMINUS {
    $$ = $2;
} | LBRACKET expr RBRACKET {
    $$ = $2;
} | SQRT LBRACKET expr RBRACKET {
    if ($3 < 0) {
        yyerror("Negative square roots are not supported.");
        printf("> ");
    } else {
        $$ = sqrt($3);
    }
} | SIN LBRACKET expr RBRACKET {
    if (trigMode) {
        $$ = sin($3 * M_PI / 180);
    } else {
        $$ = sin($3);
    }
} | COS LBRACKET expr RBRACKET {
    if (trigMode) {
        $$ = cos($3 * M_PI / 180);
    } else {
        $$ = cos($3);
    }
} | TAN LBRACKET expr RBRACKET {
    if (trigMode) {
        $$ = tan($3 * M_PI / 180);
    } else {
        $$ = tan($3);
    }
} | ROUND LBRACKET expr RBRACKET {
    $$ = round($3);
} | FLOOR LBRACKET expr RBRACKET {
    $$ = floor($3);
} | CEIL LBRACKET expr RBRACKET {
    $$ = ceil($3);
} | expr FACT {
    if ($1 < 0) {
        yyerror("Negative factorials are not supported.");
        printf("> ");
    } else if (round($1) != $1) {
        yyerror("Factorials of decimals are not supported.");
        printf("> ");
    } else {
        double result = 1;
        for (int i = 1; i <= (int)$1; i++) {
            result *= i;
        }
        $$ = result;
    }
};
%%

int yywrap() {
    return 1;
}

/**
* Prints errors if they come up.
*
* @param s: the error message
*/
void yyerror(const char* s) {
    errFlag = 1;
    fprintf(stderr, "ERROR: %s\n", s);
}

/**
* Main function - prints a welcome message and then parses through all
* input until the user exits the program.
*/
int main(int argc, char** argv) {
    printf(
        "Welcome to Calculator.\n"
        "Enter equations into the console, and the evaluation will be\n"
        "printed.\n\n"
        "Type 'help' for help.\n"
        "Type 'exit' to exit.\n> "
    );
    
    while (1) {
        yyparse();
    }

    return 0;
}