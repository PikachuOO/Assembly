; ******************* yval.asm ******************
;
         ORG   0100H
         JMP   start
x        DD    1.0
deltax   DD    0.1
y        DD    0.0
c        DD    2.0
space    DB    '     ', '$'
title    DB    "    x       y=x*x-2", '$'
title2   DB    " -------   --------", '$'
;
%include "..\mymacro\dispf.mac"
%include "..\mymacro\newline.mac"
%include "..\mymacro\dispchr.mac"
%include "..\mymacro\dispstr.mac"
;
start:
       FINIT                 ;浮點堆疊初始化
       CALL  heading         ;列印表頭
       MOV   CX, 11          ;列印15列的表格
loop2:
       CALL  yval            ;y=x*x-c
       CALL  prnline         ;印出一列
       CALL  xval            ;x=x+deltax
       LOOP  loop2
;
       MOV   AX, 4c00H
       INT   21H             ;返回作業系統
xval:
       FLD   DWORD [x]       ;TOS=x
       FADD  DWORD [deltax]  ;TOS=x+deltax
       FSTP  DWORD [x]       ;x=x+deltax
       RET
yval:
       FLD   DWORD [x]       ;TOS=x
       FMUL  DWORD [x]       ;TOS=x*x
       FSUB  DWORD [c]       ;TOS=x*x-c
       FSTP  DWORD [y]       ;y=TOS=x*x-c
       RET
heading:
       dispstr  title           ;列印表頭
       newline
       dispstr  title2          ;列印表頭
       newline
       RET
prnline:
       dispf   x, 4          ;列印x,四位小數
       dispstr space         ;空白
       dispf   y, 4          ;列印x,四位小數
       newline               ;換列
       RET
