%define a               qword [ebp+8]
%define b               qword [ebp+16]
%define c               qword [ebp+24]
%define root1           dword [ebp+32]
%define root2           dword [ebp+36]
%define disc            qword [ebp-8]
%define one_over_2a     qword [ebp-16]
section .data align=4
MinusFour       dw      -4

; No es necesario repetir la declaración de la sección .data ni crear un grupo DGROUP.
; Solo declara una vez las secciones que necesitas.

section .text

        global  _quadratic
_quadratic:
        push    ebp
        mov     ebp, esp
        sub     esp, 16         ; allocate 2 doubles (disc & one_over_2a)
        push    ebx             ; must save original ebx

        fild    word [MinusFour]; stack -4
        fld     a               ; stack: a, -4
        fld     c               ; stack: c, a, -4
        fmulp   st1             ; stack: a*c, -4
        fmulp   st1             ; stack: -4*a*c
        fld     b
        fld     b               ; stack: b, b, -4*a*c
        fmulp   st1             ; stack: b*b, -4*a*c
        faddp   st1             ; stack: b*b - 4*a*c
        ftst                    ; test with 0
        fstsw   ax
        sahf
        jb      no_real_solutions ; if disc < 0, no real solutions
        fsqrt                   ; stack: sqrt(b*b - 4*a*c)
        fstp    disc            ; store and pop stack
        fld1                    ; stack: 1.0
        fld     a               ; stack: a, 1.0
        fscale                  ; stack: a * 2^(1.0) = 2*a, 1
        fdivp   st1             ; stack: 1/(2*a)
        fst     one_over_2a     ; stack: 1/(2*a)
        fld     b               ; stack: b, 1/(2*a)
        fld     disc            ; stack: disc, b, 1/(2*a)
        fsubrp  st1             ; stack: disc - b, 1/(2*a)
        fmulp   st1             ; stack: (-b + disc)/(2*a)
        mov     ebx, root1
        fstp    qword [ebx]     ; store in *root1
        fld     b               ; stack: b
        fld     disc            ; stack: disc, b
        fchs                    ; stack: -disc, b
        fsubrp  st1             ; stack: -disc - b
        fmul    one_over_2a     ; stack: (-b - disc)/(2*a)
        mov     ebx, root2
        fstp    qword [ebx]     ; store in *root2
        mov     eax, 1          ; return value is 1
        jmp     short quit

no_real_solutions:
        ffree   st0             ; dump disc off stack
        mov     eax, 0          ; return value is 0

quit:
        pop     ebx
        mov     esp, ebp
        pop     ebp
        ret