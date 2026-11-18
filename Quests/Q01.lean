/-
  Everybody Codes 2026 -- Quest 1: The Coneservation
  https://everybody.codes/event/2026/quests/1

  Part I is worked as the reference; II and III are yours (they unlock on the
  site once the previous answer is accepted). Same shape as `Template.lean`.

  `solve` is core Lean; `Mathlib` is imported only for the two spec theorems
  under Part I (`Nat.le_sqrt`, `omega`, `nlinarith`).
-/

import Mathlib

/-! ## Input

Outposts of the first defensive ring, each with how many enchanted pine cones it
still has. Save the site's *Download* to `Inputs/2026/q01.txt` and paste the
contents between `r#"` and `"#`. -/

def raw : String := r#"1,2,3,4,5,6,7,8,9,10,11,12,18,20,24,28,30,33,34,35,36,40,41,42,44,46,48,50,53,54,55,56,57,60,61,62,68,70,71,73,78,79,80,81,83,86,90,95,96,100,150,165,193,198,202,235,256,281,295,307,314,324,345,361,372,382,410,546,547,578,591,595,605,606,614,628,640,645,653,662,667,670,714,718,750,766,788,794,807,817,867,873,890,891,903,930,937,947,958,979"#

/-- Any run of digits is one note, so comma- and newline-separated both work. -/
def numbers : List Nat := (raw.split (fun c => !c.isDigit)).toList.filterMap (fun s => s.toString.toNat?)

-- #eval numbers.length -- did I paste every note? The site hides some.

/-! ## Part I

Every outpost must fill a square on a grid with *all* of its cones, so it needs
exactly enough fresh cones to reach the next perfect square: 10 -> 16 - 10 = 6. -/

namespace PartI

/-- `Nat.sqrt` is core Lean: the largest `k` with `k * k ≤ n`. Shifting by one
    makes the square strictly above `n`, which is also correct when `n` already
    is a square (`Nat.sqrt 15 = 3`, so 16 needs 0 more). `solve 0 = 1`, i.e. a
    0-cone outpost is sent to the 1 x 1, the smallest legal formation. -/
def solve (n : Nat) : Nat := (Nat.sqrt (n - 1) + 1) ^ 2 - n

/-- The submitted answer is the total over every outpost. -/
def answer : Nat := (numbers.map solve).sum

/-- The story's example notes: 3,11,12,16,24,25 -> 1 + 5 + 4 + 0 + 1 + 0. -/
example : ([3, 11, 12, 16, 24, 25].map solve).sum = 11 := by native_decide

/-! The `example` above only covers six pasted notes. These two theorems say what
`solve` means for every `n`: the side `Nat.sqrt (n-1) + 1` really is the least
`k >= 1` with `k * k >= n`, so the cones bought are exactly `k^2 - n`. -/

/-- Adding `solve n` cones lands exactly on a square. The `Nat.le_sqrt` bridge
    (`m <= Nat.sqrt n <-> m * m <= n`) is what lets `omega` reach past `Nat.sqrt`;
    `Nat.add_sub_of_le` is where the `k^2 >= n` bound pays for the truncated
    subtraction in `solve`. -/
theorem solve_is_square (n : Nat) : n + solve n = (Nat.sqrt (n - 1) + 1) ^ 2 := by
  have h : n ≤ (Nat.sqrt (n - 1) + 1) ^ 2 := by
    rw [Nat.pow_two]
    by_contra hlt
    -- a square above `n` would already fit inside `n - 1`, so it was never the next one
    have hsq : (Nat.sqrt (n - 1) + 1) * (Nat.sqrt (n - 1) + 1) ≤ n - 1 := by omega
    have hcontra : Nat.sqrt (n - 1) + 1 ≤ Nat.sqrt (n - 1) := Nat.le_sqrt.mpr hsq
    omega
  exact Nat.add_sub_of_le h

/-- No smaller side can hold `n` cones, so `solve` never buys a spare cone.
    `1 <= k` is a real hypothesis, not a formality: the smallest legal formation
    is the 1 x 1, and `n = 0, k = 0` is a counterexample without it. -/
theorem solve_is_smallest (n k : Nat) (hk1 : 1 ≤ k) (hk : n ≤ k * k) :
    Nat.sqrt (n - 1) + 1 ≤ k := by
  by_contra h
  have hle : k ≤ Nat.sqrt (n - 1) := by omega
  have hsq : k * k ≤ n - 1 := Nat.le_trans (Nat.mul_le_mul hle hle) (Nat.sqrt_le (n - 1))
  have hpos : 1 ≤ k * k := by nlinarith
  omega

-- Paste what the site accepted, then keep it here as a machine-checked record.
-- example : answer = 123456 := by native_decide

#eval answer

end PartI

/-! ## Part II

Second defensive ring, second formation type. Read the quest page once Part I is
accepted. -/

namespace PartII

-- def solve (n : Nat) : Nat := sorry
-- def answer : Nat := (numbers.map solve).sum
-- example : answer = 123456 := by native_decide

end PartII

/-! ## Part III -/

namespace PartIII

-- def solve (n : Nat) : Nat := sorry
-- def answer : Nat := (numbers.map solve).sum
-- example : answer = 123456 := by native_decide

end PartIII
