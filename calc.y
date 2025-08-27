/**
* Calculator
* This program scans an input equation from the console and evaluates
* it, stating any errors that come up. This calculator currently
* supports the following functionalities:
*     > Basic four functions
*     > Brackets
*     > Exponents
*     > Logarithms
*     > Roots
*     > Min/max
*     > Trigonometry
*     > Modulo
*     > Rounding/truncation
*     > Absolute value
*     > Random numbers
*     > Special constants
* The user can also type "help" for instructions on how to use the
* calculator, or "exit" to exit the program.
*
* @file: calc.y
* @author: Josh Nygaard (joshdn03@gmail.com)
* @version: 1.1
*/

%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include <math.h>
    #include <time.h>
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
%token CSC
%token SEC
%token COT
%token ASIN
%token ACOS
%token ATAN
%token ACSC
%token ASEC
%token ACOT
%token RAD
%token DEG
%token MOD
%token ROUND
%token FLOOR
%token CEIL
%token FACT
%token ABS
%token LOG
%token LN
%token COMMA
%token MIN
%token MAX
%token RAND
%token RANDINT
%token ROOT

%left PLUS MINUS
%left TIMES DIV
%right EXP
%right UMINUS

%type <val> expr
%type <val> minlist
%type <val> maxlist

%%
input : | input {
    errFlag = 0;
} line;

line : expr NEWLINE {
    if (!errFlag) {
        printf("= %g\n", $1);
    }
    printf("> ");
    errFlag = 0;
} | EXITCMD NEWLINE {
    printf("Exiting Calculator.\n");
    exit(0);
} | HELPCMD NEWLINE {
    printf(
        "===== HELP MENU =====\n"
        "1. Basic operators\n"
        "2. Brackets\n"
        "3. Exponents\n"
        "4. Logarithms\n"
        "5. Roots\n"
        "6. Min/max\n"
        "7. Trigonometry\n"
        "8. Modulo\n"
        "9. Rounding/truncating\n"
        "10. Absolute value\n"
        "11. Random numbers\n"
        "12. Special constants\n\n"
        "Type 'help <number> for details on a topic (e.g. 'help 1').\n"
        "Type 'help' to see this message again, or 'exit' to quit.\n> "
    );
} | HELPCMD NUM NEWLINE {
    if ($2 < 1 || $2 > 12 || (int)$2 != $2) {
        yyerror("Help topic not found.");
    } else {
        help((int)$2);
    }
    printf("> ");
} | RAD NEWLINE {
    trigMode = 0;
    printf("Trigonometry mode set to radians.\n> ");
} | DEG NEWLINE {
    trigMode = 1;
    printf("Trigonometry mode set to degrees.\n> ");
} | error NEWLINE {
    yyerrok;
    printf("> ");
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
    } else {
        $$ = $1 / $3;
    }
} | expr MOD expr {
    if ((int)$3 == 0) {
        yyerror("Modulo by zero");
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
} | SEC LBRACKET expr RBRACKET {
    double angle = trigMode ? $3 * M_PI / 180 : $3;
    if (cos(angle) == 0) {
        yyerror("sec(x) undefined (cos(x)=0)");
    } else {
        $$ = 1 / cos(angle);
    }
} | CSC LBRACKET expr RBRACKET {
    double angle = trigMode ? $3 * M_PI / 180 : $3;
    if (sin(angle) == 0) {
        yyerror("csc(x) undefined (sin(x)=0)");
    } else {
        $$ = 1 / sin(angle);
    }
} | COT LBRACKET expr RBRACKET {
    double angle = trigMode ? $3 * M_PI / 180 : $3;
    if (tan(angle) == 0) {
        yyerror("cot(x) undefined (tan(x)=0)");
    } else {
        $$ = 1 / tan(angle);
    }
} | ASIN LBRACKET expr RBRACKET {
    if ($3 < -1 || $3 > 1) {
        yyerror("asin(x) domain error");
    } else {
        $$ = trigMode ? asin($3) * 180 / M_PI : asin($3);
    }
} | ACOS LBRACKET expr RBRACKET {
    if ($3 < -1 || $3 > 1) {
        yyerror("acos(x) domain error");
    } else {
        $$ = trigMode ? acos($3) * 180 / M_PI : acos($3);
    }
} | ATAN LBRACKET expr RBRACKET {
    $$ = trigMode ? atan($3) * 180 / M_PI : atan($3);
} | ASEC LBRACKET expr RBRACKET {
    if (fabs($3) < 1) {
        yyerror("asec(x) domain error (|x|>=1 required)");
    } else {
        $$ = trigMode ? acos(1 / $3) * 180 / M_PI : acos(1 / $3);
    }
} | ACSC LBRACKET expr RBRACKET {
    if (fabs($3) < 1) {
        yyerror("acsc(x) domain error (|x|>=1 required)");
    } else {
        $$ = trigMode ? asin(1 / $3) * 180 / M_PI : asin(1 / $3);
    }
} | ACOT LBRACKET expr RBRACKET {
    if ($3 == 0) {
        yyerror("acot(x) undefined for x=0");
    } else {
        $$ = trigMode ? atan(1 / $3) * 180 / M_PI : atan(1 / $3);
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
    } else if (round($1) != $1) {
        yyerror("Factorials of decimals are not supported.");
    } else {
        double result = 1;
        for (int i = 1; i <= (int)$1; i++) {
            result *= i;
        }
        $$ = result;
    }
} | ABS LBRACKET expr RBRACKET {
    if ($3 < 0) {
        $$ = -$3;
    } else {
        $$ = $3;
    }
} | LN LBRACKET expr RBRACKET {
    if ($3 <= 0) {
        yyerror("Domain error - natural log input must be greater than 0.");
    } else {
        $$ = log($3);
    }
} | LOG LBRACKET expr RBRACKET {
    if ($3 <= 0) {
        yyerror("Domain error - log input must be greater than 0.");
    } else {
        $$ = log10($3);
    }
} | LOG LBRACKET expr COMMA expr RBRACKET {
    if ($3 <= 0 || $5 <= 0 || $3 == 1) {
        yyerror("Invalid base or argument for log(b, x). Base must be greater than 0 and not 1; x must be greater than 0.");
    } else {
        $$ = log($5) / log($3);
    }
} | MIN LBRACKET minlist RBRACKET {
    $$ = $3;
} | MAX LBRACKET maxlist RBRACKET {
    $$ = $3;
} | RAND LBRACKET expr COMMA expr RBRACKET {
    if ($3 > $5) {
        yyerror("The first argument of rand() must be less than or equal to the second argument.");
    } else {
        double scale = (double)rand() / RAND_MAX;
        $$ = $3 + scale * ($5 - $3);
    }
} | RANDINT LBRACKET expr COMMA expr RBRACKET {
    if (round($3) != $3 || round($5) != $5) {
        yyerror("Both arguments of randint() must be integers.");
    } else if ($3 > $5) {
        yyerror("The first argument of randint() must be less than or equal to the second argument.");
    } else {
        int l = (int)$3;
        int h = (int)$5;
        $$ = (rand() % (h - l + 1)) + l;
    }
} | ROOT LBRACKET expr COMMA expr RBRACKET {
    if ($5 == 0) {
        yyerror("Root of 0 is undefined.");
    } else if ($3 < 0 && fmod($5, 2.0) != 1.0) {
        yyerror("Even roots of negative numbers are not supported.");
    } else {
        $$ = pow($3, 1.0 / $5);
    }
};

minlist : expr {
    $$ = $1;
} | minlist COMMA expr {
    $$ = ($1 < $3) ? $1 : $3;
};

maxlist : expr {
    $$ = $1;
} | maxlist COMMA expr {
    $$ = ($1 > $3) ? $1 : $3;
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
    if (!errFlag) {
        fprintf(stderr, "ERROR: %s\n", s);
        errFlag = 1;
    }
}

/**
 * Displays a help menu topic based on what the user inputs.
 *
 * @param n: the number corresponding to the desired help topic
 */
void help(int n) {
    switch(n) {
        case 1:
            printf(
                "===== BASIC OPERATORS =====\n"
                "Use +, -, *, and / for arithmetic.\n"
                "    > Example: 3 + 4 * 2\n"
                "Operators MUST have expressions on both sides.\n"
                "    > '2 + 3 +' -> syntax error\n"
            );
            break;
        case 2:
            printf(
                "===== BRACKETS =====\n"
                "Use brackets () to control the order of operations.\n"
                "    > Example: (3 + 4) * 2\n"
                "Brackets must match.\n"
                "    > '(3 + 2' -> syntax error\n"
            );
            break;
        case 3:
            printf(
                "===== EXPONENTS ===== \n"
                "Use exponents to multiply a number times itself a\n"
                "specified number of times.\n"
                "    > Example: 3 ^ 10\n"
                "Exponents MUST have expressions on both sides.\n"
                "    > '2 ^' -> syntax error\n"
            );
            break;
        case 4:
            printf(
                "===== LOGARITHMS =====\n"
                "Use logarithms to calculate the exponent need to reach\n"
                "a number from its base.\n"
                "1. Natural logarithm (base e): ln(x)\n"
                "    > Example: ln(2.71821) ≈ 1\n"
                "    > Note: x must be greater than 0.\n"
                "2. Common logarithm (base 10): log(x)\n"
                "    > Example: log(100) = 2\n"
                "    > Note: x must be greater than 0.\n"
                "3. Logarithm with custom base: log(b, x)\n"
                "    > Example: log(2, 8) = 3\n"
                "    > Note: Base b must be greater than 0 and not 1. x\n"
                "      must be greater than 0.\n"
                "Syntax errors will occur if the arguments are invalid.\n"
                "Use brackets around the arguments: log(2, 8)\n"
            );
            break;
        case 5:
            printf(
                "===== ROOTS =====\n"
                "Roots are used to calculate a number that, when raised\n"
                "to a certain power, equals the original number.\n\n"
                "Available functions:\n"
                "    > sqrt(x): calculates the square root of x.\n"
                "        > Example: sqrt(16) = 4\n"
                "    > root(x, n)L calculates the nth root of x,\n"
                "        > Example: root(27, 3) = 3\n\n"
                "Notes:\n"
                "    > The second argument of root(x, n) must not be 0.\n"
                "    > Even roots of negative numbers are not supported.\n"
                "        > 'root(-8, 2)' -> syntax error\n"
                "    > Odd roots of negative numbers are allowed.\n"
                "        > Example: root(-8, 3) = -2\n"
                "    > Use brackets around arguments: sqrt(16)\n"
            );
            break;
        case 6:
            printf(
                "===== MIN/MAX =====\n"
                "The min function calculates the minimum number in a\n"
                "provided list of numbers.\n"
                "    > Example: min(2, 5, 1, 7) = 1\n"
                "Similarly, the max function calculates the maximum\n"
                "number in a provided list of numbers.\n"
                "    > Example: max(2, 5, 1, 7) = 7\n"
                "Number list must be comma-separated.\n"
                "    > 'max(2 8)' -> syntax error\n"
                "Use brackets around the arguments: max(2, 8)\n"
            );
            break;
        case 7:
            printf(
                "===== TRIGONOMETRY =====\n"
                "Trigonometric functions relate angles to ratios of\n"
                "sides in a right triangle.\n\n"
                "Available functions:\n"
                "    > sin(x), cos(x), tan(x)\n"
                "    > sec(x) = 1/cos(x), csc(x) = 1/sin(x), cot(x) = 1/tan(x)\n"
                "    > Inverse functions: asin(x), acos(x), atan(x)\n"
                "    > Inverse sec/csc/cot: asec(x), acsc(x), acot(x)\n\n"
                "Examples:\n"
                "    > sin(0) = 0, cos(0) = 1, tan(0) = 0\n"
                "    > sec(0) = 1, csc(pi/2) = 1, cot(pi/4) = 1\n"
                "    > asin(1) = pi/2, acos(0) = pi/2\n\n"
                "By default, all angles are in radians. You can toggle modes:\n"
                "    > Type 'rad' to use radians\n"
                "    > Type 'deg' to use degrees\n"
                "Example using degrees: deg 90 -> sin(90) = 1\n\n"
                "Notes:\n"
                "    > Functions automatically convert degrees to radians if 'deg' mode is active.\n"
                "    > Use brackets around the arguments: sin(90), asec(2)\n"
            );
            break;
        case 8:
            printf(
                "===== Modulo =====\n"
                "Return the number remaining from a division.\n"
                "    > Example: 5 % 2 = 1\n"
                "Modulos MUST have expressions on both sides.\n"
                "    > '5 %' -> syntax error\n"
            );
            break;
        case 9:
            printf(
                "===== ROUNDING/TRUNCATING =====\n"
                "These functions allow you to adjust numbers to their\n"
                "nearest integer or limit their decimal portion.\n\n"
                "Available functions:\n"
                "    > round(x): rounds x to the nearest integer.\n"
                "        > Example: round(2.3) = 2\n"
                "    > ceil(x): adjusts x to the next integer up.\n"
                "        > Example: ceil(2.3) = 3\n"
                "    > floor(x): adjusts x to the next integer down.\n"
                "        > Example: floor(2.7) = 2\n\n"
                "Notes:\n"
                "    > These functions only affect the numeric value of x;\n"
                "      they do not change the type of the result.\n"
                "    > Use them to simplify numbers or control precision\n"
                "      in calculations.\n"
                "    > Use brackets around arguments: floor(2.7)\n"
            );
            break;
        case 10:
            printf(
                "===== ABSOLUTE VALUE =====\n"
                "Returns the distance from 0 of an expression.\n"
                "    > Example: abs(-5) = 5\n"
            );
            break;
        case 11:
            printf(
                "===== RANDOM NUMBERS =====\n"
                "These functions generate random numbers within a\n"
                "specified range.\n\n"
                "Available functions:\n"
                "    > rand(x, y): returns a random decimal number between\n"
                "      x and y (inclusive).\n"
                "        > Example: rand(1, 5) might return 3.472\n"
                "    > randint(x, y): returns a random integer between x\n"
                "      and y\n"
                "        > Example: randint(1, 5) might return 2\n\n"
                "Notes:\n"
                "    > For randint(), both arguments must be integers.\n"
                "        > 'randint(2.2, 5.5)' -> syntax error\n"
                "    > The first argument for both functions must be less\n"
                "      than or equal to the second argument.\n"
                "        > 'rand(5, 2)' -> syntax error\n"
            );
            break;
        default:
            printf(
                "===== SPECIAL CONSTANTS =====\n"
                "Special constants are available in this calculator:\n"
                "    > pi ≈ 3.14159\n"
                "        > Represents the ratio of a circle's circumference\n"
                "          to its diameter.\n"
                "    > e ≈ 2.71828\n"
                "        > Represents Euler's constant, the base of natural\n"
                "          logarithms,\n\n"
                "Notes:\n"
                "    > Use these constants just like regular numbers in\n"
                "      your expressions.\n"
                "    > They can be combined with operators, functions, and\n"
                "      other numbers.\n"
                "        > Example: sin(pi / 2) = 1\n"
            );
            break;
    }
}

/**
* Main function - prints a welcome message and then parses through all
* input until the user exits the program.
*/
int main(int argc, char** argv) {
    srand(time(NULL));

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
