/-
  Everybody Codes 2026 -- Quest N: <title>
  https://everybody.codes/event/2026/quests/N

  Copy to `Quests/QNN.lean`, fill in the four `sorry`s, `lake build` stays green.
  The workflow (and the two answer slots) is in README.md.
-/
import Mathlib

/-! ## Input

Save the site's *Download* button output to `Inputs/2026/qNN.txt`, then paste it
between `r#"` and `"#` (a raw string keeps newlines and needs no escaping).
Check `numbers.length` against the number of notes you can see on the page --
Everybody Codes hides some of them. -/

def raw : String := r#""#

/-- Any run of digits is one note, so comma- and newline-separated both work. -/
def numbers : List Nat := (raw.split (fun c => !c.isDigit)).toList.filterMap (fun s => s.toString.toNat?)

-- #eval numbers.length -- how many notes did I actually paste?

/-! ## Part I -/

namespace PartI

-- def solve (n : Nat) : Nat := sorry   -- one note -> the part's per-note value
-- def answer : Nat := (numbers.map solve).sum

-- example : solve 10 = 6 := by native_decide   -- a worked example from the story
-- example : answer = 123456 := by native_decide -- what you submitted on the site

end PartI

/-! ## Part II

Unlocks on the site after Part I is accepted. -/

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
