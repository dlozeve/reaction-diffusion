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
 N←500
 A←N N⍴1
 B←0.1×?N N⍴0
 B[((N÷2)-10)+⍳20;((N÷2)-10)+⍳20]←1
 ⍝ Run
 steps←20000
 Ap Bp←(update⍣steps)A B
 ⍝ ' ⌺'[Ap>0.5]
 ⍝ Export to image file
 mat2pbm←{'P1'(⍕⌽⍴⍵),⍕¨↓⍵>0.5}  ⍝ black and white
 mat2pgm←{'P2'(⍕⌽⍴⍵),(⊂'255'),⍕¨↓⌊255×⍵}  ⍝ grayscale
 (⊂mat2pbm Ap)⎕NPUT'img.pnm'1
