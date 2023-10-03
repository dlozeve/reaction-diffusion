⟨PBM,PPM⟩←•Import"../bqn-graphics/pnm.bqn"
⟨Inferno,Magma,Viridis⟩←•Import"../bqn-graphics/colormaps.bqn"

# Parameters
dt‿da‿db‿f‿k←⟨1.0,0.16,0.08,0.060,0.062⟩
n←500  # image size
m←10  # seed size at the center of the image

# Discrete Laplacian
Lapl←(+´∘∾1‿¯1(⌽⋈⌽˘)¨<)-4⊸×
# Gray-Scott update
UpdateA←{𝕨+dt×(da×Lapl 𝕨)+(-𝕨×𝕩⋆2)+f×1-𝕨}
UpdateB←{𝕩+dt×(db×Lapl 𝕩)+(𝕨×𝕩⋆2)-𝕩×k+f}
Update←(UpdateA⋈UpdateB)´

# Initialization
a←n‿n⥊1
Mask←{𝕩‿𝕩↑(-𝕨‿𝕨+𝕩÷2)↑(2×𝕨‿𝕨)⥊1}
b←(m Mask n)⌈0.1×n‿n•rand.Range 0

# Run
Step←{stepsize 𝕊 i‿a‿b:
  •term.OutRaw"."
  •term.Flush @
  ap‿bp←Update⍟stepsize a‿b
  ("out/step"∾(¯5↑∾•Fmt¨5-⊸↑i)∾".pnm")•file.Chars (PPM ⌊255×>Inferno¨1-a)∾@+10
  (i+1)‿ap‿bp
}

50 Step•_while_(600⊸>∘⊑⊢) 0‿a‿b
•Out""
