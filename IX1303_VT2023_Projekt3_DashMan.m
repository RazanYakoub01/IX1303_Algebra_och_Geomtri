%--------------------------------------------------------------------------
% IX1303-VT2023: PROJEKTUPPGIFT 3, Streckgubben
%
% Detta är en template.
% Ni ska fylla i koden som efterfrågas och svara på frågorna.
% Notera att alla svar på frågor måste skrivas på raden som börjar med "%".
%--------------------------------------------------------------------------

clearvars, clc

filename = 'dashman.gif';
TimePerFrame = 0.05;
BoundingBox = [-1,1,-1,1]*14; % Om gubben hamnar utanför skärmen, så ändra här!
NumberOfTimeSteps = 50;

%------------------
% SKAPA MATRISERNA
%------------------
%----- SKRIV KOD: Skapa den matris som beskriver den efterfrågade avbildningen -----
% Skapa matrisen för den efterfrågade avbildningen

% Skapa transformationsmatriser
rotationMatrix = @(theta) [cos(theta), -sin(theta), 0; sin(theta), cos(theta), 0; 0, 0, 1];
translationMatrix = @(dx, dy) [1, 0, dx; 0, 1, dy; 0, 0, 1];
scalingMatrix = @(scale) [scale, 0, 0; 0, scale, 0; 0, 0, 1];

% Definiera värden för rotation, translation och skalning
rotationAngle = pi/8;
dx = 0; % Ingen translation i x-axeln ? bör den inte endast flytta i y-axel ? 
dy = -15/NumberOfTimeSteps; % Translaterar uppåt
scale = 1 + (3 / NumberOfTimeSteps); % Förstorar mellan 1 och 4 gånger

% Skapa transformationsmatriser med de angivna värdena
rotationMatrix = rotationMatrix(rotationAngle);
translationMatrix = translationMatrix(dx, dy);
scalingMatrix = scalingMatrix(scale);

% Skapa den sammansatta transformationsmatrisen
A = scalingMatrix * rotationMatrix * translationMatrix;
%------------------------------
% SKAPA STRECKGUBBEN, DASH-MAN
%------------------------------

D=DashMan();

%-----------------------------------
% SKAPA FÖRSTA BILDEN I ANIMERINGEN
%-----------------------------------
figure(1);
clf; hold on;
axis equal
axis(BoundingBox)
set(gca,'visible','off')

plotDashMan(D); % Här ritar vi Dash-man som han ser ut från början
addFrameToGif(filename, 1, TimePerFrame)

%-----------------------------------------------------
% Loopa över alla bilder i animeringen, från 2 till 50
%-----------------------------------------------------
for i = 2:50
%----- SKRIV KOD: Transformera alla DASH-MAN's kroppsdelar -----
% Här ska du uppdatera punkter i D, dvs alla punkter i huvudet, kroppen osv.

% Transformera huvudet
D.head = A * D.head;

% Transformera munnen
D.mouth = A * D.mouth;

% Transformera kroppen
D.body = A * D.body;

% Transformera benen
D.legs = A * D.legs;

% Transformera armarna
D.arms = A * D.arms;


  hold off
  plotDashMan(D); % Här ritar vi Dash-man som han ser ut efter transformationen
  axis equal
  axis(BoundingBox)
  set(gca,'visible','off')
  addFrameToGif(filename, i, TimePerFrame)
end


% Frågor:
% 1.Varför innehåller sista raden i D.head bara ettor?
% SVAR: 
% Den sista raden i D.head innehåller bara ettor för att representera den homogena koordinaten. 
% I geometriska transformationer används homogena koordinater 
% för att utföra matematiska operationer enklare och effektivare.

% 2.Beskriv skillnaden i gubbens rörelse över flera varv (d.v.s banan gubben rör sig längs) när man translaterar uppåt, neråt, åt höger eller vänster?
% SVAR:  
% Skillnaden i gubbens rörelse bör bero på riktningen av translationen. 
% Om man translaterar gubben uppåt borde dess rörelse att vara uppåt längs banan. 
% Om man translaterar gubben neråt borde dess rörelse att vara neråt längs banan. 
% På samma sätt borde en translation åt höger eller vänster 
% att resultera i en rörelse åt höger eller vänster längs banan.

% 3.Om man flyttar gubben en sträcka dx=0.1 per steg, och vi tar 50 steg med kombinerad translation och rotation, varför har gubben inte flyttats 50*0.1 åt höger?
% SVAR:  
% Gubben har inte flyttats exakt 50 * 0.1 åt höger 
% på grund av rotationskomponenten. Rotationen kan ändra rörelseriktningen 
% och resultera i en avvikelse från en ren horisontell förflyttning. 
% Det kan leda till att gubben har en bana som inte är helt horisontell.
