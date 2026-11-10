# Style

Conventions for every module in the library. The aim is that a statement in Lean reads as it does in the book, and that a reader who knows the book can find their way around without knowing Mathlib.

## Modules

* One module per concept, named for the concept: `Manifolds/SmoothManifold.lean`, `Surfaces/RegularSurface.lean`. Module names are CamelCase words, never numbers or abbreviations, so that imports need no `«…»`.
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

* Every definition and theorem taken from a book cites it by name and number, in parentheses: `(do Carmo, Section 2-2, Definition 1)`, `(Lee, Smooth Manifolds, p. 12)`. A name in the book is set in italics the first time it appears: *regular surface*.
* Where the library departs from the book, or chooses a Mathlib notion over the book's, the docstring says so and says why. Where Mathlib lacks something the proof needs, the docstring says that too.
* Other modules are referred to by their last name component: `GaussianCurvature`, not a path.

## Declarations

* Every declaration has a docstring. For a named object it begins with the name in bold, then the citation, then the statement: `/-- **Smoothly compatible charts** (Lee, Smooth Manifolds, p. 12). The transition map from `φ` to `ψ` and the one from `ψ` to `φ` are both smooth. -/`.
* Every field of a structure has a docstring that states the condition in words: `/-- `U` is open -/`. Where the module docstring enumerates the parts of a definition, the fields do not repeat the numbers; a reader of a field should not need to remember the enumeration.
* A definition is the book's formula where the book gives one, and a Mathlib predicate where the book gives a property. The transition map is `ψ ∘ φ⁻¹`, and smoothness is `ContDiffOn ℝ ∞`.
* A property made of several conditions is a `structure ... : Prop` with one named field per condition, never a conjunction: `IsTopologicalManifold`, `IsSmoothAtlas`, `IsMaximalSmoothAtlas`. A proof then reaches each condition by name, `manifold.smoothStructure.covers`, instead of by `.1` and `.2`.
* Each structure has a namespace of the same name, and quantities that belong to it are defined there with a `variable`, so that they are used with dot notation: `φ.U`, `φ.transition ψ`, `surface.A`.
* When the book's definitions build on one another, the structures do too, each adding exactly the data and conditions its definition adds: `ClosedCurve extends RegularCurve`, `SimpleClosedCurve extends ClosedCurve`, `IsMaximalSmoothAtlas extends IsSmoothAtlas`, `RegularSurface extends SmoothManifold 2 S`. Data such as a period `T` or a smooth structure `A` makes a structure; a property with no new data, such as convexity, is a predicate in the namespace of the structure it describes, reached by dot notation from every structure that extends it: `α.IsConvex`.
* Every structure that extends a structure of maps has its own `CoeFun`, so that `α t` works at every level of the chain.

## Names

* A quantity that is a letter in the book keeps the letter, in its plain form: `U`, `A`, never a script letter. Otherwise definitions are camelCase words: `transition`, `smoothStructure`.
* Predicates begin with `Is`: `IsLocallyEuclidean`, `IsTopologicalManifold`, `IsSmoothAtlas`.
* A theorem with a name in the book takes that name in snake_case. Any other theorem is named in Mathlib's style, for the shape of its statement: `isMaximalSmoothAtlas_smoothStructure`.
* Hypotheses are named for what they say, as words joined by underscores, never with an `h` prefix: `p_in_U`, `open_U`, `smooth`, `manifold`.
* Variables follow the book: `M` for the space, `φ` and `ψ` for charts, `U` for a coordinate domain, `p` for a point of `M`, `q` for a parameter in `ℝ^n`, `A` for an atlas or smooth structure, `S` for a surface, `α` for a curve, `I` for its interval, `t` for a parameter in `I`.

## Notation

* Notation is declared once and is `scoped` to the `DifferentialGeometry` namespace. General notation belongs in `Notation.lean`; notation for an area belongs in its own module, such as `Manifolds/Notation.lean`, which imports the definitions it needs. Keep any associated pretty-printer with the notation.
* A statement uses the notation of the book wherever it exists: `ℝ^n`, `φ⁻¹`, `ψ ∘ φ⁻¹`, `φ '' U` for `φ(U)`.

## Statements and proofs

* A module may state a theorem whose proof is `sorry`. The statement is the deliverable until the proof is; it is complete, with every hypothesis the proof will need.
* A proof, when written, follows the argument of the book step by step, with `have` naming each step as the book does, and ends with the one-line tactic that combines them.
* Helpers used by a single proof are `private`.

## Formatting

* Lines are at most 100 characters, and the Mathlib linter set is on, so `lake build` reports style problems. `lake lint` runs the Batteries environment linters.
* Comments describe the library as it is. They do not describe how it used to be.
