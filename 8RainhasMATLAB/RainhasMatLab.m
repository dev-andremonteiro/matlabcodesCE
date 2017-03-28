function varargout = RainhasMatLab(varargin)
% UNTITLED MATLAB code for untitled.fig
%      UNTITLED, by itself, creates a new UNTITLED or raises the existing
%      singleton*.
%
%      H = UNTITLED returns the handle to a new UNTITLED or the handle to
%      the existing singleton*.
%
%      UNTITLED('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNTITLED.M with the given input arguments.
%
%      UNTITLED('Property','Value',...) creates a new UNTITLED or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitled_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitled_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help untitled

% Last Modified by GUIDE v2.5 28-Mar-2017 15:34:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitled_OpeningFcn, ...
                   'gui_OutputFcn',  @untitled_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

function untitled_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;
set(handles.axes1,'Visible','off');
guidata(hObject, handles);

function varargout = untitled_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function btnOk_Callback(hObject, eventdata, handles)
global N;
global R;

N = str2num(get(handles.numeroTabuleiro,'String'));

data = get(handles.tabela,'data');
data = {};
set(handles.tabela, 'data', data);

set(handles.titulo,'String',[num2str(N),' Rainhas']);

set(handles.panel2,'Visible','on');
set(handles.panel1,'Visible','off');
setN(N,handles);
 
 R = imread('rainha.png');
 set(handles.axes2,'Visible','on');
 axes(handles.axes2);
 imshow(R);
 
 set(handles.axes3,'Visible','on');
 axes(handles.axes3);
 imshow(R);
 
 set(handles.axes4,'Visible','on');
 axes(handles.axes4);
 imshow(R);
 
 set(handles.axes5,'Visible','on');
 axes(handles.axes5);
 imshow(R);

 set(handles.axes6,'Visible','on');
 axes(handles.axes6);
 imshow(R);
 
 
 if(N > 5)
     set(handles.axes7,'Visible','on');
     axes(handles.axes7);
     imshow(R);
     
     if(N > 6)
         set(handles.axes8,'Visible','on');
         axes(handles.axes8);
         imshow(R);
         
         if(N > 7)
             set(handles.axes9,'Visible','on');
             axes(handles.axes9);
             imshow(R);
             
             if(N > 8)
                 set(handles.axes10,'Visible','on');
                 axes(handles.axes10);
                 imshow(R);
                 
                 if(N > 9)
                     set(handles.axes11,'Visible','on');
                     axes(handles.axes11);
                     imshow(R);
                     
                     if(N > 10)
                         set(handles.axes12,'Visible','on');
                         axes(handles.axes12);
                         imshow(R);
                         
                         if(N > 11)
                             set(handles.axes13,'Visible','on');
                             axes(handles.axes13);
                             imshow(R);
                             
                             if(N > 12)
                                 set(handles.axes14,'Visible','on');
                                 axes(handles.axes14);
                                 imshow(R);
                                 
                                 if(N > 13)
                                     set(handles.axes15,'Visible','on');
                                     axes(handles.axes15);
                                     imshow(R);
                                     
                                 end
                             end
                         end
                     end
                 end
             end
         end
     end
     
 end

function montar_tabuleiro(hObject,x,y)
x = x - 1;
y = y - 1;
set(hObject, 'position', [131+(x*10),50.84615384615387-(y*3.846),7.6,3]);
 axes(hObject);

 
function setN(a,handles)  
 set(handles.axes1,'Visible','on');
 I = imread('Xadrez.png');
 axes(handles.axes1);
 imshow(I);
 global N;
 N = a;
 X2 = imcrop(I,[0 0 (700-((14-N)*50)) (700-((14-N)*50))]);
 axes(handles.axes1);
 imshow(X2);
 set(handles.axes1, 'position', [129.8,0.38461538461538464+((14-N)*3.846),140.2-((14-N)*10),53.92307692307693-((14-N)*3.846)]);

function btnIniciar_Callback(hObject, eventdata, handles)
global N;
global pop;
global nGer;

taxa_mut = str2num(get(handles.txtTaxaMutacao,'String'));                % Taxa de mutação
taxa_rec = str2num(get(handles.txtTaxaRecombinacao,'String'));           % Taxa de recombinação
tamanhoPop = str2num(get(handles.txtTamanhoPopulacao,'String'));         % Tamanho da população

set(handles.txtTaxaMutacao,'Enable','off');
set(handles.txtTaxaRecombinacao,'Enable','off');
set(handles.txtTamanhoPopulacao,'Enable','off');
set(handles.txtNumeroGeracao,'Enable','off');
set(handles.checkbox1,'Enable','off');
set(handles.btnProximo,'Visible','on');
set(handles.checkbox1,'Enable','off');
set(handles.checkbox2,'Enable','off');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
numRec = ceil(((tamanhoPop * taxa_rec)/100)); % Calcula número de indivíduos gerados por recombinação
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1:tamanhoPop
    d = DNA(N);
    individuos(i) = d;
end

pop = Populacao(individuos,taxa_mut,numRec);
pop.updateDados;
sair = pop.checar_fim(0);
addTabela(pop.geracao,pop.fit_media,pop.fit_menor(pop.geracao).fitness,handles);

opcao1 = get(handles.checkbox1,'Value');
opcao2 = get(handles.checkbox2,'Value');

if(sair == 1)
    if(opcao1 == 0)
        set(handles.btnProximo,'Enable','on');
        if(opcao2 == 1)
            nGer = str2num(get(handles.txtNumeroGeracao,'String'));
        else
            nGer = 0;
        end
        
    else
        if(opcao2 == 1)
            nGer = str2num(get(handles.txtNumeroGeracao,'String'));
        else
            nGer = 0;
        end
        
        while(sair == 1)
            sair = proximaGeracao(0,nGer,handles);
        end
        set(handles.titulo,'String',[num2str(N),' Rainhas  FINALIZADO']);
        gerarTabuleiro(N,pop.fit_menor(pop.geracao),handles);
        
    end
end




function s = proximaGeracao(graph,nGer,handles)
global N;
global pop;


pop.selecao_roda;
pop.nova_populacao;
s = pop.checar_fim(nGer);
addTabela(pop.geracao,pop.fit_media,pop.fit_menor(pop.geracao).fitness,handles);
if(graph == 1)
    gerarTabuleiro(N,pop.fit_menor(pop.geracao),handles);
end



function addTabela(ger,fm,mf,handles)
data = get(handles.tabela,'data');
data(end+1,:) = {ger,fm,mf};
set(handles.tabela, 'data', data);




function gerarTabuleiro(N,mf,handles)
montar_tabuleiro(handles.axes2,mf.genes(1),1);
montar_tabuleiro(handles.axes3,mf.genes(2),2);
montar_tabuleiro(handles.axes4,mf.genes(3),3);
montar_tabuleiro(handles.axes5,mf.genes(4),4);
montar_tabuleiro(handles.axes6,mf.genes(5),5);
if(N > 5)
    montar_tabuleiro(handles.axes7,mf.genes(6),6);
   if(N > 6)
       montar_tabuleiro(handles.axes8,mf.genes(7),7);
       if(N > 7)
           montar_tabuleiro(handles.axes9,mf.genes(8),8);
           if(N > 8)
               montar_tabuleiro(handles.axes10,mf.genes(9),9);
               if(N > 9)
                   montar_tabuleiro(handles.axes11,mf.genes(10),10);
                   if(N > 10)
                       montar_tabuleiro(handles.axes12,mf.genes(11),11);
                       if(N > 11)
                           montar_tabuleiro(handles.axes13,mf.genes(12),12);
                           if(N > 12)
                               montar_tabuleiro(handles.axes14,mf.genes(13),13);
                               if(N > 13)
                                   montar_tabuleiro(handles.axes15,mf.genes(14),14);
                               end
                           end
                       end
                   end
               end
           end
       end
   end
end

function tabela_CellSelectionCallback(hObject, eventdata, handles)
global N;
global pop;

if ~isempty(eventdata.Indices)
    handles.currentCell=eventdata.Indices;
    guidata(hObject,handles);
    Indices=handles.currentCell;
    gerarTabuleiro(N,pop.fit_menor(Indices(1)),handles);
 end



function slider3_Callback(hObject, eventdata, handles)
set(handles.numeroTabuleiro,'String',get(handles.slider3,'Value'));

function checkbox2_Callback(hObject, eventdata, handles)
if(get(handles.checkbox2,'Value') == 1)
    set(handles.txtNumeroGeracao,'Enable','on');
else
    set(handles.txtNumeroGeracao,'Enable','off');
end

function checkbox1_Callback(hObject, eventdata, handles)
if(get(handles.checkbox1,'Value') == 0)
    set(handles.btnProximo,'Visible','on');
else
    set(handles.btnProximo,'Visible','off');
end

function btnProximo_Callback(hObject, eventdata, handles)
global nGer;
global N;
s = proximaGeracao(1,nGer,handles);
if(s == 0)
    set(handles.btnProximo,'Enable','off');
    set(handles.titulo,'String',[num2str(N),' Rainhas  FINALIZADO']);
end

    

%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

function txtTamanhoPopulacao_Callback(hObject, eventdata, handles)
function txtTamanhoPopulacao_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function txtNumeroGeracao_Callback(hObject, eventdata, handles)
function txtNumeroGeracao_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function txtTaxaRecombinacao_Callback(hObject, eventdata, handles)
function txtTaxaRecombinacao_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function txtTaxaMutacao_Callback(hObject, eventdata, handles)
function txtTaxaMutacao_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function slider3_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
