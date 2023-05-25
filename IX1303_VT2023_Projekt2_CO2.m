%--------------------------------------------------------------------------
% IX1303-VT2023: PROJEKTUPPGIFT 2, CO2 mätning
%
% Detta är en template.
% Ni ska fylla i koden som efterfrågas och svara på frågorna.
% Notera att alla svar på frågor måste skrivas på raden som börjar med "%".
%--------------------------------------------------------------------------

clearvars, clc

%----- SKRIV KOD: Fyll i data-filens namn (ta med .csv, .txt, eller liknande) -----
filename="co2_data.csv";
TABLE=readtable(filename);

%----- SKRIV KOD: Fyll i namnen på de kolumner som innehåller tid och data (dvs byt ut XXXXXX) -----
% Namnen på dessa kolumner finns oftast i csv filen. Men, om ni har
% läst in tabellen TABLE kan du se listan av kolumner genom att skriva 
% "T.Properties.VariableNames" i kommand-prompten. 
% Notera att när man arbetar med data någon annan skapat krävs ofta lite
% detektivarbete för att förstå exakt vad alla värden beskriver!
T = [ TABLE.Date_1];  % T ska vara en vektor med tiden för olika C02 mätningar
y = [ TABLE.CO2 ];    % y ska vara en vektor med data från CO2 mätningar 
nan_idx = isnan(y) | isnan(T);
y_clean = y(~nan_idx & y > -99);
T_clean = T(~nan_idx & y > -99);

%----- SKRIV KOD: Skapa en minstakvadrat anpassning av y(t) till en rät linje -----
% Rät linjens ekvation är y = kx + m
% y = CO2 data
% x = tiden

% Sätter upp matrisen X som innehåller ettor i första kolumn 
% (ettor motsvarar konstanttermen i ekvationen)
% och i andra kolumn är det tid-värden som kommer bli x-axeln
X = [ones(length(T_clean), 1), T_clean];

% Räknar ut koefficienterna med normala ekvationen
constant = (X' * X) \ (X' * y_clean);

% Sätter upp linjens ekvation
m = constant(1);
k = constant(2);
y_fit = m + k*T_clean;

%----- SKRIV KOD: Rita både mätdata och anpassningen i samma graf. -----
figure
plot(T_clean, y_clean, '.', T_clean, y_fit, '-','LineWidth', 2)
xlabel('Tid')
ylabel('CO2')
legend('Mätdata', 'Linjär anpassning')

%----- SKRIV KOD: Skapa en minstakvadrat anpassning av y(t) till ett andragradspolynom -----
% Sätter upp matrisen X som innehåller ettor i första kolumn (ettor motsvarar konstanttermen i polynomet)
% och i andra kolumn är det tid-värden och i tredje kolumn 
% blir det tid-värden upphöjt till två - då det är andragradsekvation
X2 = [ones(length(T_clean), 1), T_clean, T_clean.^2];

% Räknar ut koefficienterna med normala ekvationen
constant2 = (X2' * X2) \ (X2' * y_clean);

% Skapar anpassningen av andragradspolynomet
a = constant2(1);
b = constant2(2);
c = constant2(3);
y_fit2 = a + b*T_clean + c*T_clean.^2;

%----- SKRIV KOD: Rita både mätdata och anpassningen i samma graf. -----
figure
plot(T_clean, y_clean, '.', T_clean, y_fit2, '-','LineWidth', 2)
xlabel('Tid')
ylabel('CO2')
legend('Mätdata', 'Andragradspolynom anpassning')

%----- SKRIV KOD: Skapa en minstakvadrat anpassning av y(t) till ett tredjegradspolynom -----
% Sätter upp matrisen X som innehåller ettor i första kolumn (ettor motsvarar konstanttermen i polynomet)
% och i andra kolumn är det tid-värden och i tredje kolumn 
% blir det tid-värden upphöjt till två och i den fjärde kolumn
% blir det tid-värden upphöjt till tre - då det är tredjegradsekvation
X3 = [ones(length(T_clean), 1), T_clean, T_clean.^2, T_clean.^3];

% Räknar ut koefficienterna med normala ekvationen
constant3 = (X3' * X3) \ (X3' * y_clean);

% Skapar anpassningen av tredjegradspolynomet
a = constant3(1);
b = constant3(2);
c = constant3(3);
d = constant3(4);
y_fit3 = a + b*T_clean + c*T_clean.^2 + d*T_clean.^3;

%----- SKRIV KOD: Rita både mätdata och anpassningen i samma graf. -----
figure
plot(T_clean, y_clean, '.', T_clean, y_fit3, '-','LineWidth', 2)
xlabel('Tid')
ylabel('CO2')
legend('Mätdata', 'Tredjegradspolynom anpassning')

% _____________________________________________________________________________________________________

% Frågor:
% 1. Beskriv med egna ord hur de tre kurvorna beskriver. 
% Framför allt, blir lösningen lite eller mycket bättre när vi går från en rät linje till en andragradsfunktion? 
% Blir den mycket bättre när vi går från en andragradsfunktion till en tredjegradsfunktion?
% SVAR: Rät linje: Den räta linjen är en linjär anpassning av CO2-mätdata över tiden. 
% Den beskriver förändringen av CO2-nivåerna, som en konstant ökning eller
% minskning över tiden. 

% Andragradspolynom: Det andragradspolynom som anpassas till CO2-mätdata 
% över tiden ger en kurva som kan ha en mer böjd form. 
% Den beskriver förändringen i CO2-nivåerna som ett ej konstant,
% utan på ett mer komplext sätt (t,ex i procent)

% Tredjegradspolynom: Det tredjegradspolynom som anpassas till CO2-mätdata 
% ger en ännu mer böjd kurva. 
% Detta beskriver förändringen i CO2-nivåerna som 
% en ännu mer komplex och icke-linjär förändring över tiden.

% Lösningen blir bättre när vi går från en rät linje till en andragradspolynom 
% eftersom den andragradsanpassade kurvan har möjlighet att beskriva mer komplexa former 
% än en linje. Skillnaden mellan en andragrads- och tredjegradspolynom blir mindre betydande. 
% Övergången från en andragrads- till en tredjegradspolynom ger en något mer böjd kurva, 
% men den kan vara överanpassad till de givna mätdata och kan inte nödvändigtvis generalisera 
% korrekt utanför intervallet för givna mätningar.

% ___________________________________________________________________________________________________

% 2. Kan man använda dessa anpassningar för att uppskatta utsläppen om 2 år? Motivera ditt svar.
% SVAR: Nej, dessa anpassningar kan inte på ett tillförlitligt sätt 
% användas för att uppskatta utsläppen om 2 år.
% Anpassningarna är baserade på de befintliga CO2-mätningarna 
% och kan inte nödvändigtvis extrapolera på ett tillförlitligt sätt utanför 
% intervallet för de tillgängliga mätningarna. Utöver detta, när man ser på
% grafen så ser man en stor skilland mellan uppskattade data och det
% verkliga datan. 

%_______________________________________________________________________________________________________

% 3. Kan man använda dessa anpassningar för att uppskatta utsläppen om 50 år? Motivera ditt svar.
% SVAR: Nej, dessa anpassningar kan inte användas för att uppskatta utsläppen om 50 år 
% på ett tillförlitligt sätt. Anpassningarna är baserade på de befintliga CO2-mätningarna 
% och kan inte förutsäga framtida förändringar i utsläppsmönstren, 
% som kan vara beroende av olika faktorer såsom politik, teknologiska framsteg 
% och samhällsförändringar. För att göra en tillförlitlig prognos om utsläppen om 50 år 
% behövs mer sofistikerade modeller och noggranna analyser av olika påverkande faktorer.










