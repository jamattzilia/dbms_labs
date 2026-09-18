# Laboratory Work No. 1

**Subject:** Number systems. Transfer numbers from one number system to another. Arithmetic in the number systems.

**Purpose:** To acquire the skills of operations in different number systems.

**Variant: 6**

## Task

Complete the table by converting each of the four given numbers into the remaining number systems:

| № | Decimal number | Binary number | Octal number | Hexadecimal number |
|---|---|---|---|---|
| 1 | 654.27 | | | |
| 2 | | 1100001010101 | | |
| 3 | | | 632 | |
| 4 | | | | 5AD |

## Solution

### 1. Number 654.27(10)

**Converting the integer part (654) to binary — division-by-base method:**

| Division | Quotient | Remainder |
|---|---|---|
| 654 : 2 | 327 | 0 |
| 327 : 2 | 163 | 1 |
| 163 : 2 | 81 | 1 |
| 81 : 2 | 40 | 1 |
| 40 : 2 | 20 | 0 |
| 20 : 2 | 10 | 0 |
| 10 : 2 | 5 | 0 |
| 5 : 2 | 2 | 1 |
| 2 : 2 | 1 | 0 |
| 1 : 2 | 0 | 1 |

Reading the remainders bottom to top: **654(10) = 1010001110(2)**

**Converting the fractional part (0.27) to binary — multiplication-by-base method:**

| Multiplication | Result | Digit |
|---|---|---|
| 0.27 × 2 | 0.54 | 0 |
| 0.54 × 2 | 1.08 | 1 |
| 0.08 × 2 | 0.16 | 0 |
| 0.16 × 2 | 0.32 | 0 |
| 0.32 × 2 | 0.64 | 0 |
| 0.64 × 2 | 1.28 | 1 |
| 0.28 × 2 | 0.56 | 0 |
| 0.56 × 2 | 1.12 | 1 |
| 0.12 × 2 | 0.24 | 0 |
| 0.24 × 2 | 0.48 | 0 |

**0.27(10) ≈ 0.0100010100(2)**

Total: **654.27(10) = 1010001110.0100010100(2)**

**Converting to octal** (same approach, division/multiplication by 8):

654 : 8 = 81, rem. 6; 81 : 8 = 10, rem. 1; 10 : 8 = 1, rem. 2; 1 : 8 = 0, rem. 1 → **654(10) = 1216(8)**

0.27×8=2.16→2; 0.16×8=1.28→1; 0.28×8=2.24→2; 0.24×8=1.92→1 → **0.27(10) ≈ 0.2121(8)**

**654.27(10) = 1216.2121(8)**

**Converting to hexadecimal** (division/multiplication by 16):

654 : 16 = 40, rem. 14(E); 40 : 16 = 2, rem. 8; 2 : 16 = 0, rem. 2 → **654(10) = 28E(16)**

0.27×16=4.32→4; 0.32×16=5.12→5; 0.12×16=1.92→1; 0.92×16=14.72→E → **0.27(10) ≈ 0.451E(16)**

**654.27(10) = 28E.451E(16)**

### 2. Number 1100001010101(2)

**Converting to decimal** (summing positional values):

1100001010101(2) = 1·2¹²+1·2¹¹+0·2¹⁰+0·2⁹+0·2⁸+0·2⁷+1·2⁶+0·2⁵+1·2⁴+0·2³+1·2²+0·2¹+1·2⁰
= 4096+2048+64+16+4+1 = **6229(10)**

**Converting to octal** (grouping into 3 bits from the right, padded with zeros on the left):

001 100 001 010 101 → 1 4 1 2 5 → **14125(8)**

Check: 1·8⁴+4·8³+1·8²+2·8+5 = 4096+2048+64+16+5 = 6229 ✓

**Converting to hexadecimal** (grouping into 4 bits from the right):

0001 1000 0101 0101 → 1 8 5 5 → **1855(16)**

Check: 1·16³+8·16²+5·16+5 = 4096+2048+80+5 = 6229 ✓

### 3. Number 632(8)

**Converting to decimal:**

632(8) = 6·8² + 3·8¹ + 2·8⁰ = 384 + 24 + 2 = **410(10)**

**Converting to binary** (each octal digit → 3 bits):

6 = 110, 3 = 011, 2 = 010 → **110011010(2)**

Check: 1·256+1·128+0+0+1·16+1·8+0+1·2+0 = 256+128+16+8+2 = 410 ✓

**Converting to hexadecimal** (grouping the binary code into 4 bits):

0001 1001 1010 → 1 9 A → **19A(16)**

Check: 1·256+9·16+10 = 256+144+10 = 410 ✓

### 4. Number 5AD(16)

**Converting to decimal:**

5AD(16) = 5·16² + 10·16¹ + 13·16⁰ = 1280 + 160 + 13 = **1453(10)**

**Converting to binary** (each hexadecimal digit → 4 bits):

5 = 0101, A = 1010, D = 1101 → 0101 1010 1101 → **10110101101(2)** (leading zero dropped)

Check: 1024+256+128+32+8+4+1 = 1453 ✓

**Converting to octal** (grouping the binary code into 3 bits):

010 110 101 101 → 2 6 5 5 → **2655(8)**

Check: 2·512+6·64+5·8+5 = 1024+384+40+5 = 1453 ✓

## Final table (Variant 6)

| № | Decimal number | Binary number | Octal number | Hexadecimal number |
|---|---|---|---|---|
| 1 | 654.27 | 1010001110.0100010100 | 1216.2121 | 28E.451E |
| 2 | 6229 | 1100001010101 | 14125 | 1855 |
| 3 | 410 | 110011010 | 632 | 19A |
| 4 | 1453 | 10110101101 | 2655 | 5AD |

## Conclusion

This laboratory work reinforced the skills of converting numbers between the decimal, binary, octal, and hexadecimal number systems: using the division/multiplication-by-base method, as well as the "shortcut" methods of grouping binary digits by 3 (for octal) and by 4 (for hexadecimal).
