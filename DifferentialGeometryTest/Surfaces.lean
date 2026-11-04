import DifferentialGeometry

/-!
# Surfaces

The main statements of `DifferentialGeometry.Surfaces`, used from outside the library the way a
downstream file would use them: the names are reached by opening the namespace, and the notation
by opening it as a scope.
-/

open DifferentialGeometry
open scoped DifferentialGeometry Real

/-- Local Gauss–Bonnet, `Σⱼ ∫ κg ds + ∫∫_R K dA + Σⱼ δⱼ = 2π` -/
example {S : Set ℝ³} {σ : SurfacePatch S} {P : σ.Polygon} (unit_speed : P.IsUnitSpeed) :
    P.totalGeodesicCurvature + P.totalCurvature + ∑ j, P.exteriorAngle j = 2 * π :=
  P.gauss_bonnet unit_speed

/-- Global Gauss–Bonnet, `∫∫_S K dA = 2π χ` -/
example {S : Set ℝ³} (T : Triangulation S) (smooth : IsSmoothSurface S) (compact : IsCompact S) :
    T.totalCurvature = 2 * π * T.eulerNumber :=
  T.gauss_bonnet smooth compact

/-- The patch notation prints back as `σᵤ`, `σᵥ`, and `σᵤᵥ` rather than as `partialU`. -/
example {S : Set ℝ³} (σ : SurfacePatch S) (q : ℝ²) : σᵤᵥ q = ∂ᵥ σᵤ q := by
  guard_target =ₛ σᵤᵥ q = σᵤᵥ q
  rfl
