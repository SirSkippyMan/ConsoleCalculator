# Calculator

A powerful **console-based calculator** that evaluates complex mathematical expressions with detailed error handling, supporting a wide range of functions, constants, and trigonometric calculations.

---

## Features

### Basic Arithmetic

* Addition (`+`), Subtraction (`-`), Multiplication (`*`), Division (`/`)
* Exponents (`^`) and Brackets (`()`)
* Modulo: `mod` (`%`)

### Special Functions

* Square root: `sqrt(x)`
* Nth root: `root(x, n)`
* Rounding and truncating: `round(x)`, `ceil(x)`, `floor(x)`
* Factorials: `x!` (**non-negative integers only**)
* Absolute value: `abs(x)`
* Logarithms:

  * Natural logarithm: `ln(x)`
  * Base-10 logarithm: `log(x)`
  * Custom base: `log(base, x)`

### Trigonometry

* Primary functions: `sin(x)`, `cos(x)`, `tan(x)`
* Reciprocal functions: `sec(x) = 1/cos(x)`, `csc(x) = 1/sin(x)`, `cot(x) = 1/tan(x)`
* Inverse functions: `asin(x)`, `acos(x)`, `atan(x)`
* Inverse reciprocal: `asec(x)`, `acsc(x)`, `acot(x)`
* Toggle between **radians** and **degrees** using `rad` or `deg`

### Random Numbers

* Decimal: `rand(min, max)`
* Integer: `randint(min, max)`

### Constants

* `pi` ≈ 3.14159
* `e` ≈ 2.71828

### Interactive Commands

* `help` — shows usage instructions
* `exit` — exits the program

---

## Usage

1. **Compile the program** (if not already compiled):

   ```bash
   make
   ```

2. **Run the calculator**:

   ```bash
   ./calc
   ```

3. **Enter expressions**:

   ```text
   > 1 + 1
   = 2
   > sqrt(16)
   = 4
   > sin(90)
   = 1
   > root(27, 3)
   = 3
   > log(2, 8)
   = 3
   > 5!
   = 120
   ```

4. **Toggle trig mode**:

   ```text
   > deg   # Degrees mode
   > rad   # Radians mode
   ```

5. **Type `help` at any time** for detailed instructions, or `exit` to quit.

---

## Example Expressions

```text
> 6 * (8.4 - 3.5) / 2.3
> 3 ^ 10
> sin(180)
> cos(pi / 4)
> tan(45)
> sec(0)
> csc(pi / 2)
> cot(pi / 4)
> asin(1)
> acos(0)
> atan(1)
> asec(2)
> acsc(1)
> acot(1)
> sqrt(16)
> root(27, 3)
> round(2.3)
> ceil(4.1)
> floor(5.9)
> 5 % 2
> 10!
> log(100)
> log(2, 8)
```

---

## Error Handling

* **Unmatched brackets**: `5 - (4 - 3`
* **Division by zero**: `5 / 0`
* **Negative square roots**: `sqrt(-1)`
* **Invalid roots**: `root(-8, 2)` (even roots of negative numbers are unsupported)
* **Incomplete expressions**: `3 + 2 +`
* **Invalid characters**: `5 + x`
* **Invalid factorials**: `-10.5!`

All errors are reported immediately, and invalid expressions are ignored.

---

## Notes

* Factorials only support **non-negative integers**.
* Trigonometry calculations are affected by the current **trig mode**.
* Reciprocal and inverse trig functions require **domain checks** (e.g., `asec(x)` requires |x| ≥ 1).
* Input is read continuously until `exit` is typed.

---

## Author

**Josh Nygaard**  
[joshdn03@gmail.com](mailto:joshdn03@gmail.com)

Version: 1.1
