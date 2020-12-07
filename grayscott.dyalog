 ⎕IO←0
 ⍝ Discrete Laplacian
 lapl←(⊃(+/1 ¯1(⌽+⊖)¨⊂)-(⊂4∘×))
 ⍝ Gray-Scott update
 diffa←{dt×(da×lapl ⍺)+(-⍺×⍵*2)+f×1-⍺}
 diffb←{dt×(db×lapl ⍵)+(⍺×⍵*2)-⍵×k+f}
 update←{⍵+(⊃⍵[0])((⊂diffa),(⊂diffb))⊃⍵[1]}
 ⍝ Parameters
 dt da db f k←1.0 0.16 0.08 0.060 0.062
 ⍝ Initialization
 N←200
 A←0.8+0.2×?N N⍴0
 A[((N÷2)-10)+⍳20;((N÷2)-10)+⍳20]←0.5
 B←0.2×?N N⍴0
 B[((N÷2)-10)+⍳20;((N÷2)-10)+⍳20]←0.25
 ⍝ Run
 steps←10000
 Ap Bp←(update⍣steps)A B
 ⍝ ' ⌺'[Ap>0.5]
 ⍝ Export to image file
 mat2pbm←{'P1'(⍕⌽⍴⍵),⍕¨↓⍵>0.5}  ⍝ black and white
 mat2pgm←{'P2'(⍕⌽⍴⍵),(⊂'255'),⍕¨↓⌊255×⍵}  ⍝ grayscale
 (⊂mat2pbm Ap)⎕NPUT'img.pnm'1
