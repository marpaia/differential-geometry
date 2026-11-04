# Style

Conventions for every module in the library. The aim is that a statement in Lean reads as it does in the book, and that a reader who knows the book can find their way around without knowing Mathlib.

## Modules

* One module per concept, named for the concept: `Surfaces/TangentPlane.lean`, `Surfaces/GaussBonnet/Local.lean`. Module names are CamelCase words, never numbers or abbreviations, so that imports need no `«…»`.
* Every module is added to the root `DifferentialGeometry.lean`, in reading order.
* A module begins with `module`, its imports, a module docstring, `@[expose] public section`, any `open scoped`, and `namespace DifferentialGeometry`. It ends with `end DifferentialGeometry`.

## Imports

* Imports are `public import`, one per line, library modules first and then Mathlib modules in alphabetical order.
* Each import is the narrowest Mathlib file that provides what is used, never `Mathlib` itself, and it carries a comment naming what it is used for:

  ```lean
  public import Mathlib.Analysis.InnerProductSpace.Defs /- ⟪x, y⟫ -/
  ```

## Module docstrings

* The docstring is `/-! # Title` followed by an account of the mathematics at the level of the book: what the objects are, what the theorem says, and how the proof goes. It is the place for prose; declarations below it carry only short docstrings.
* Formulas are set in backticks on their own indented line:

  ```
    `K = (LN - M²) / (EG - F²)`,
  ```

* Every definition and theorem taken from a book cites it by name and number, in parentheses: `(Pressley, Definition 6.1.1)`, `(do Carmo, Section 4-5)`. A name in the book is set in italics the first time it appears: *geodesic curvature*.
* Where the library departs from the book, or chooses a Mathlib notion over the book's, the docstring says so and says why. Where Mathlib lacks something the proof needs, the docstring says that too.
* Other modules are referred to by their last name component: `GaussianCurvature`, not a path.

## Declarations

* Every declaration has a docstring. For a named object it begins with the name in bold and then the formula: `/-- **The area element** `dA = ‖σᵤ × σᵥ‖` -/`. For a quantity that is just a letter in the book, the docstring is the formula: `/-- `E = σᵤ · σᵤ` -/`.
* Every field of a structure has a docstring. A definition with numbered parts in the book numbers its fields the same way: `/-- Part 4: `σ` is one-to-one -/`.
* A definition is the book's formula where the book gives one, and a Mathlib predicate where the book gives a property. `K` is `(LN - M²) / (EG - F²)`, and smoothness is `ContDiffOn ℝ ∞ σ U`.
* Each structure has a namespace of the same name, and quantities that belong to it are defined there with a `variable`, so that they are used with dot notation: `σ.normal q`, `P.inside`, `frame.curl q`.

## Names

* A quantity that is a letter in the book keeps the letter: `E`, `F`, `G`, `L`, `M`, `N`, `K`. Otherwise definitions are camelCase words: `areaElement`, `geodesicCurvature`, `exteriorAngle`.
* Predicates begin with `Is`: `IsSmoothSurface`, `IsPositivelyOriented`, `IsUnitSpeed`.
* A theorem with a name in the book takes that name in snake_case: `gauss_bonnet`, `hopf_umlaufsatz`. Any other theorem is named in Mathlib's style, for the shape of its statement: `areaElement_eq_sqrt`, `curl_eq_K_mul_areaElement`, `finrank_tangentPlane`.
* Hypotheses are named for what they say, as words joined by underscores, never with an `h` prefix: `q_in_U`, `open_O`, `smooth_f`, `unit_speed`, `compact`.
* Variables follow the book: `σ` for a patch, `q` for a parameter in `U`, `p` for a point of `S`, `c` for a curve in the plane and `γ` for its image on the surface, `P` for a polygon, `T` for a triangulation.

## Notation

* Notation is declared once, in `Notation.lean`, and is `scoped` to the namespace.
* A statement uses the notation of the book wherever it exists: `σᵤ`, `⟪a, b⟫`, `√`, `∑ j`, `∫ s in (0)..ℓ`.

## Statements and proofs

* A module may state a theorem whose proof is `sorry`. The statement is the deliverable until the proof is; it is complete, with every hypothesis the proof will need.
* A proof, when written, follows the argument of the book step by step, with `have` naming each step as the book does:

  ```lean
  obtain ⟨frame⟩ := σ.nonempty_orthonormalFrame
  have turning := P.hopf_umlaufsatz unit_speed frame
  have rotation := frame.rotationAround_eq_totalCurvature P
  linarith
  ```

* Helpers used by a single proof are `private`.

## Formatting

* Lines are at most 100 characters, and the Mathlib linter set is on, so `lake build` reports style problems. `lake lint` runs the Batteries environment linters.
* Comments describe the library as it is. They do not describe how it used to be.
