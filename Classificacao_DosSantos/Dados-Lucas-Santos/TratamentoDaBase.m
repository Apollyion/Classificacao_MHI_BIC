% Identificação de níveis de propensão de estudantes de engenharia de
% universidades públicas à depressão com base em dados socio-econômicos
% Formulários: WHOQOL-BREF e ISM (Inventário de Saúde Mental)
% Lucas dos Santos Fonseca, 402578, Eng. Elétrica, UFC - Sobral

clear all
close all
clc

%% Tratamento da base de dados sociodemográficos

SocioDemografico = table2array(importdata('SocioDemograficoBruto.   mat'));

% Tópico 1 - Sexo
% 1 Mulher, 2 Homem
SocioDemografico(SocioDemografico(:,1)==2,1)=0; % Substitui homem = 2 por homem = 0. Mulher = 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% BINARIZANDO %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Binarizar colunas: 3,4,8,9,10,26,27

% Tópico 3 - Raça
% 1 Parda, 2 Preto, 3 Branco, 4 Amarelo, 5 Nao sabe
mt_raca = [SocioDemografico(:,3)==1,SocioDemografico(:,3)==2,SocioDemografico(:,3)==3,SocioDemografico(:,3)==4,SocioDemografico(:,3)==5];

% Tópico 4 - Situação Civil
% 1 Solteiro, 2 Casado, 3 União Estável, 4 Viuvo
mt_civil = [SocioDemografico(:,4)==1,SocioDemografico(:,4)==2,SocioDemografico(:,4)==3,SocioDemografico(:,4)==4];

% Tópico 8 - Reside com
% 1 Familiares, 2 Sozinho, 3 República, 4 Amigos/Colegas
mt_reside = [SocioDemografico(:,8)==1,SocioDemografico(:,8)==2,SocioDemografico(:,8)==3,SocioDemografico(:,8)==4];

% Tópico 9 - Religiao
% 1 Católica, 2 Evangélica, 3 Testemunha de Jeová, 4 Espírita, 5 Outros
mt_religiao = [SocioDemografico(:,9)==1,SocioDemografico(:,9)==2,SocioDemografico(:,9)==3,SocioDemografico(:,9)==4,SocioDemografico(:,9)==5];

% Tópico 10 - Curso
% Ciências Biológicas e da Saúde = ciencias biologicas, zootecnia, enfermagem, ed. física
mt_bioesaude = [SocioDemografico(:,10)==1,SocioDemografico(:,10)==5,SocioDemografico(:,10)==7,SocioDemografico(:,10)==9];
mt_bioesaude = sum(mt_bioesaude,2);

% Negócios e Administração= ciencias contábeis e administração
mt_negoceadm = [SocioDemografico(:,10)==2,SocioDemografico(:,10)==6];
mt_negoceadm = sum(mt_negoceadm,2);

% Humanidades e Ciências Sociais = letras, pedagogia, história, filosofia, direito, geografia, ciencias sociais
mt_humanesociais = [SocioDemografico(:,10)==3,SocioDemografico(:,10)==4,SocioDemografico(:,10)==10,SocioDemografico(:,10)==8,SocioDemografico(:,10)==11,SocioDemografico(:,10)==12,SocioDemografico(:,10)==17];
mt_humanesociais = sum(mt_humanesociais,2);

% Exatas e Tecnologia = matemática, eng civil, computação, física, química e Sup.Const.Edificio
mt_exatetec = [SocioDemografico(:,10)==14,SocioDemografico(:,10)==15,SocioDemografico(:,10)==18,SocioDemografico(:,10)==19,SocioDemografico(:,10)==13,SocioDemografico(:,10)==16];
mt_exatetec = sum(mt_exatetec,2);

% Tópico 16 - Turno
% 1 Matutino, 2 Vespertino, 3 Somente noturno, 4 Integral
mt_turno = [SocioDemografico(:,26)==1,SocioDemografico(:,26)==2,SocioDemografico(:,26)==3,SocioDemografico(:,26)==4];

% Tópico 17 - Transporte
% 1 A pé/carona,bicicleta, 2 Coletivo, 3 Próprio, 4 Táxi/Moto-táxi
mt_transporte = [SocioDemografico(:,27)==1,SocioDemografico(:,27)==2,SocioDemografico(:,27)==3,SocioDemografico(:,27)==4];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%% APAGANDO %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Apagar colunas: 15,16,17,18,19,21,31,32,33,34,35,36,37,38,42,52,53,54,56,57,58,59,60,61,62,63,64,65 
% 
% vt_apagar = sort([15,16,17,18,19,21,31,32,33,34,35,36,37,38,42,52,53,54,56,57,58,59,60,61,62,63,64,65],'descend');
% 
% for i=1:length(vt_apagar)
%     SocioDemografico(:,vt_apagar(i))=[];
% end

SocioDemo = [SocioDemografico(:,1:2) mt_raca mt_civil SocioDemografico(:,7) mt_reside mt_religiao mt_bioesaude mt_negoceadm mt_humanesociais mt_exatetec SocioDemografico(:,11:14) SocioDemografico(:,20) SocioDemografico(:,22:25)];
SocioDemo = [SocioDemo mt_turno mt_transporte SocioDemografico(:,28:30) SocioDemografico(:,39:41) SocioDemografico(:,43:51) SocioDemografico(:,55) SocioDemografico(:,66:67)];

%                      |---------------- raça ---------------|------------ Situação Civil ---------------|
% sexo | idade | Pardo | Preto | Branco | Amarelo | Nao sabe | Solteiro | Casado | União Estável | Viúvo |
%   1      2       3       4        5        6         7           8         9          10          11 

%             |-------------------- Reside com -------------------|---------------------------- Religião ---------------------------|
% Freq Viagem | Familiares | Sozinho | República | Amigos/Colegas | Católica | Evangélica | Testemunha de Jeová | Espírita | Outros |
%   12              13          14        15             16            17          18                19              20        21  

% |-------------------------- Cursos -------------------------------|
% Biológicas e Saúde | Negoc e Adm | Human e Sociais | Exatas e Tec | Semestre | Qt. Discip | Já reprovou | Curso estressante | 
%         22               23              24               25           26          27           28               29         

%             |------------ Motivo afast. -------------|----------------------- Turno ----------------------|
% Afastamento | Saude | Financeiro | Trabalho | Outros | Matutino | Vespertino | Somente noturno | Integral | 
%     30          31        32          33        34        35          36              37            38     

% |----------------------- Transporte ------------------------|
% A pé/carona,bicicleta | Coletivo | Próprio | Táxi/Moto-táxi | Ativ. Profis | Ativ. Academic | Bolsa/Auxilio | 
%           39               40        41           42              43             44               45        

% 
% Faz ativ fisica | Freq ativ fisica | Horas lazer | Dormir | Ficar com familia | Ouvir musica | Assistir filme | 
%     46                   47              48          49            50               51               52        

% 
% Passear/viajar| Ler | Ativ Fisica | Outras | Uso de medicam | Uso de subst| Freq subst | Horas Sono 
%      53          54       55          56         57               58           59      |     60  

