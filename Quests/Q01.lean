/-
  Everybody Codes 2026 -- Quest 1: The Coneservation
  https://everybody.codes/event/2026/quests/1

  Part I is worked as the reference; II and III are yours (they unlock on the
  site once the previous answer is accepted). Same shape as `Template.lean`.

  Part I needs nothing but core Lean, so this file imports nothing; uncomment
  `import Mathlib` below when you want it (`Finset`, `Nat.Prime`, ...).
-/

-- import Mathlib

/-! ## Input

Outposts of the first defensive ring, each with how many enchanted pine cones it
still has. Save the site's *Download* to `Inputs/2026/q01.txt` and paste the
contents between `r#"` and `"#`. -/

def raw : String := r#""#

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
