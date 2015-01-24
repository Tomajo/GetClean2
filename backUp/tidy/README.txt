 
y-train.txt o y_test.txt conté info de l'activitat. del 1 al 6, veure activity labels.

x_train i X_test conté info dels accelerometres

Hem de matxambrar y_train amb y_test i despres ajuntar amb X_train i X_test

subject test te info sobre els individuus.

Farem un data.frame que tingui:

-columna1: subject_test
-columna2: y=activitat. la posarem en numeric, però farem un factor de les 5 coses.
-columna3: x les dades en si del telefon y del giroscopi etc.