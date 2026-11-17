import Lake
open Lake DSL

package Quests

-- Tag must match nixpkgs' mathlib; lake never fetches it (the store paths are
-- injected), but it must be declared for lake to put it on the search path.
require "leanprover-community" / "mathlib" @ git "v4.35.0"

@[default_target]
lean_lib Quests where
  -- One file per quest: Quests/Q01.lean, Quests/Q02.lean, ... plus Template.lean.
  -- `.submodules`, not `.andSubmodules`: there is no root `Quests.lean`, every
  -- module lives in Quests/.
  globs := #[.submodules `Quests]
