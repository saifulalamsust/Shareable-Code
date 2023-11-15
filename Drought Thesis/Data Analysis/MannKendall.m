function [Z pvalue conclusion] = MannKendall(x,alpha)
%MANNKENDALL 
% x : vecteur des observations de la série
% alpha : seuil critique du test
% Parametres de sortie :
% k : statistique du test
% pvalue : pvaleur du test
% conclusion (0 ou 1): vaut 0 si on accepte l'hypothène nulle et 1 so on
% rejette.
%
% H0: Il n'y a pas de tendance dans les données
% H1: Il y a une tendance dans les données

x(isnan(x)) = [];

% Statsitique de Mann-Kendall
S = 0;

n = length(x);
for i=1:n-1
    for j=i+1:n
        S = S + sign(x(j)-x(i));
    end
end

%tied groups
value=[];
t=[];
for i=1:length(x)
    if ~sum(x(i)==value) && (sum(x==x(i))>1)
       t(end+1) = sum(x==x(i));
       value(end+1) = x(i);
    end
end

%Calcul de la variance
V = 1/18*(n*(n-1)*(2*n+5) - sum(t.*(t-1).*(2*t+5)));

Z = (S - sign(S))/sqrt(V);

pvalue = 2*(1-normcdf(abs(Z),0,1));

if pvalue < alpha
    conclusion =1;%on rejette
else
    conclusion = 0;%on accepte
end