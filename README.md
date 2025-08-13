# Calculator

A console-based calculator program that evaluates mathematical expressions and provides detailed error handling.

---

## Features

* Supports **basic arithmetic**:

  * Addition (`+`), Subtraction (`-`), Multiplication (`*`), Division (`/`)
* **Exponents**: `^`
* **Brackets**: `()`
* **Special functions**:

  * Square root: `sqrt(...)`
  * Modulo: `mod` (`%%`)
  * Rounding: `round(...)`
  * Floor and Ceil: `floor(...)`, `ceil(...)`
  * Factorials: `!`
* **Trigonometry functions**:

  * `sin(...)`, `cos(...)`, `tan(...)`
  * Toggle between **radians** and **degrees** using `rad` or `deg`
* Handles **positive/negative numbers** and **decimals**
* Supports mathematical **constants**: `e` ≈ 2.7183, `pi` ≈ 3.14159
* Interactive commands:

  * `help` — shows usage instructions
  * `exit` — exits the program

---

## Usage

1. Compile the program (if not already compiled):

   ```bash
   gcc calc.y -o calculator -lm
   ```

   > Note: Linking with `-lm` is necessary for math functions.

2. Run the calculator:

   ```bash
   ./calculator
   ```

3. Enter any valid mathematical expression:

   ```text
   > 1 + 1
   = 2
   > sqrt(16)
   = 4
   > sin(90)
   = 1
   ```

4. Toggle trig mode:

   ```text
   > deg   # Degrees mode
   > rad   # Radians mode
   ```

5. Type `help` at any time for instructions, or `exit` to quit.

---

## Example Expressions

```text
> 6 * (8.4 - 3.5) / 2.3
> 3 ^ 10
> sin(180)
> sqrt(16)
> round(2.3)
> ceil(4.1)
> floor(5.9)
> 5 %% 2
> 10!
```

---

## Error Handling

* **Unmatched brackets**: `5 - (4 - 3`
* **Division by zero**: `5 / 0`
* **Negative square roots**: `sqrt(-1)`
* **Incomplete expressions**: `3 + 2 +`
* **Invalid characters**: `5 + x`
* **Invalid factorials**: `-10.5!`

All errors are reported immediately, and invalid expressions are ignored.

---

## Author

**Josh Nygaard**
[joshdn03@gmail.com](mailto:joshdn03@gmail.com)

Version: 1.0

---

## Notes

* Factorials only support **non-negative integers**.
* Trigonometry calculations are affected by the current **trig mode**.
* Input is read continuously until `exit` is typed.
