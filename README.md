# Everybody Codes 2026 in Lean 4

[Lord of the Wings](https://everybody.codes/event/2026/quests/), 20 quests x 3
parts, solved in Lean 4. One file per quest, one `solve` per part. The point is
learning Lean, so every part ends in a check, not just a submitted number.

```
Quests/Q01.lean     one file per quest (Q01 ... Q20)
Quests/Template.lean  copy this to start one
Inputs/2026/qNN.txt notes downloaded from the site, per your seed
PROGRESS.md         what is solved, and what each part taught you
flake.nix           Lean + Mathlib from nixpkgs' leanPackages, via lean-flakes
```

## Shell

```sh
direnv allow                     # or: nix develop
lake build                       # whole repo; Mathlib comes from the store
lean Quests/Q01.lean             # check + run #evals in one file
lake env lean Quests/Q01.lean    # same, with lake's own search path (what the LSP uses)
nix build                        # reproducible build of the package
```

The Lean VS Code extension needs `lean` and `LEAN_PATH` from this shell, so
start the editor from a direnv'd terminal. First `nix flake lock` / `nix build`
may need `--accept-flake-config` once, to trust the Mathlib cachix substituter.

## Working a quest

1. Read the part on the site, then *Download* its notes and save them to
   `Inputs/2026/qNN.txt`.
2. `cp Quests/Template.lean Quests/QNN.lean`
3. Paste the notes into `raw` (a raw string, `r#"..."#`, so newlines need no
   escaping). Uncomment `#eval numbers.length` and match it against the notes on
   the page -- Everybody Codes hides some of them.
4. Write `solve` for one note, `answer` for the aggregate. `#eval answer` in the
   infoview gives the number to submit.
5. After the site accepts it, record it: `example : answer = 123456 := by
   native_decide`. Now `lake build` fails if you ever break a solved part.
6. Tick the row in `PROGRESS.md` and name the one tactic or function you learnt.

Parts II and III only appear on the site once the previous answer is accepted,
so expect to leave those namespaces empty for a day.

## Checks, and what each one buys you

- `by decide` -- the kernel evaluates it. Trusted, and it dies on big inputs.
- `by native_decide` -- compiled code decides it. Fast, but it only proves the
  computation ran, via the `Lean.ofReduceBool` axiom (`#print axioms` shows it).
  Good enough as a receipt for a submitted answer.
- `theorem solve_spec ...` -- what you write when you want to know *why* the
  solver is right, e.g. for Quest 1 part I that `n + solve n` is a square. This
  is the rung the whole structure exists to walk you up to.

## Ladder

Pick the next rung per quest rather than per day, and prefer re-doing an old
part with a proof over opening a new quest.

0. Number out: `def`, `#eval`, the core `List`/`String` API (`lines`, `split`,
   `filterMap`, `sum`). No imports at all -- Quest 1 part I is like this.
1. Checkable: sample tests straight from the story text, `decide`,
   `native_decide`, `Option` instead of partial functions.
2. Total and indexed: `Fin` for indices, `Array`/`Dict` when lists get slow,
   well-founded recursion (`termination_by`), `deriving` for your own types.
3. Proved about your own code: `simp`, `omega`, `induction`, `rcases`, `omega`
   for the arithmetic puzzles.
4. Mathlib: `Finset` for counting, `Nat.gcd`/`Nat.Prime`/`Nat.modeq` for the
   number theory, `grump` (`#align_import`) when `Nat` is too slow.

## Toolchain notes

From [lean-flakes](https://github.com/yuanwang-wf/lean-flakes), see its README for
detail.

- `.envrc` matches your global gitignore: `git add -f .envrc` before the first
  commit, or a fresh clone has no `direnv allow` to run.
- Working on lean-flakes itself: add
  `--override-input lean-flakes path:/Users/yuanwang/workspaces/github.com/yuanwang-wf/lean-flakes`
  to the nix commands to build against your checkout instead of the pushed rev.
- Mathlib is prebuilt in the store and Lake never hits the network. `lake
  update` is not needed (`lake-manifest.json` only has to exist so plain Lake
  tooling is happy), and `MATHLIB_NO_CACHE_ON_UPDATE=1` keeps its olean cache
  out of the way.
- `import Mathlib` prints *designed for use with the module system* on each
  build. Harmless for now.
- Adding a dep that `pkgs.leanPackages` has: add it to `lean.leanDeps` in
  `flake.nix`, plus a `require` line in `lakefile.lean` and a manifest entry
  (`lake update` once with network).
- `nix flake update nixpkgs` moves Lean and Mathlib together: the flake fails
  until `lean-toolchain` matches, and only one nixpkgs rev is cached, so expect
  a long rebuild.
