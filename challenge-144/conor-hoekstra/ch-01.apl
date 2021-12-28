factors ← ∪⍳∨⊢
isPrime ← 2≤≢∘factors

⍝ Solution
2 17⍴{⍵/⍨((2 3∊⍨≢)∧∧/)¨(isPrime¨¯1↓factors)¨⍵} ⍳100

⍝ Output
 4  6  9 10 14 15 21 22 25 26 33 34 35 38 39 46 49
51 55 57 58 62 65 69 74 77 82 85 86 87 91 93 94 95
