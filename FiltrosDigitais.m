function varargout = FiltrosDigitais(varargin)
% UNTITLED1 MATLAB code for untitled1.fig
%      UNTITLED1, by itself, creates a new UNTITLED1 or raises the existing
%      singleton*.
%
%      H = UNTITLED1 returns the handle to a new UNTITLED1 or the handle to
%      the existing singleton*.
%
%      UNTITLED1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNTITLED1.M with the given input arguments.
%
%      UNTITLED1('Property','Value',...) creates a new UNTITLED1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitled1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitled1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help untitled1

% Last Modified by GUIDE v2.5 23-Mar-2017 00:00:46
%   Desenvolvido por: AndreMonteiro
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %   %%%%%   %%  %   %%    %%%%  %%%%%   %%
    %   %   %   %  %%   %  %  % %   %%%     %%
    %   %   %   %   %   %%    %  %  %%%%%   %%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitled1_OpeningFcn, ...
                   'gui_OutputFcn',  @untitled1_OutputFcn, ...
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


% --- Executes just before untitled1 is made visible.
function untitled1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to untitled1 (see VARARGIN)

% Choose default command line output for untitled1
handles.output = hObject;
global metodo;
metodo = 1;
global janela;
janela = 2;
global fs;
fs = 8000;
global fc;
fc = 1500;
global fp;
fp = 1000;
global fr;
fr = 3000;
global ap;
ap = 2;
global ar;
ar = 20;

calculo(handles);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes untitled1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = untitled1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in p.
function p_Callback(hObject, eventdata, handles)
% hObject    handle to p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
calculo(hObject,handles);


function calculo(handles)
global metodo;
global fc;
global fs;
global fp;
global fr;
global janela;
global ar;
global ap;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f1=50; 
f2=500; 
f3=2000 ;
f4=1500;
t=0:1:1000;
x=6*sin((2*pi*f1*t/fs))+4*sin((2*pi*f2*t/fs))+0.5*sin((2*pi*f3*t/fs))+3*sin((2*pi*f4*t/fs));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

N=length(x);
K=0:N-1;
T=N/fs;
freq=K/T;
cutOff=ceil(N/2);
m = 1;

switch(metodo)
    case 1
        fc= (fc*2)/fs;
        n= fir1(janela-1,fc,'low', hamming(janela));
    case 2
        fc= (fc*2)/fs;
        n= fir1(janela-1,fc,'low', blackman(janela));
    case 3
        Wp =fp/(fs/2);
        Wr =fr/(fs/2);
        [N,Wn]=buttord(Wp,Wr,ap,ar);
        [n,m] = butter(N,Wn);
    case 4
        Wp =fp/(fs/2);
        Wr =fr/(fs/2);
        [N,Ws] = cheb1ord(Wp,Wr,ap,ar,'s');
        [n,m] = cheby1(N,ap,Ws);
    case 5
        Wp =fp/(fs/2);
        Wr =fr/(fs/2);
        [N,Ws] = cheb2ord(Wp,Wr,ap,ar,'s');
        [n,m] = cheby2(N,ar,Ws);
    case 6
        Wp =fp/(fs/2);
        Wr =fr/(fs/2);
        [N,Wp] = ellipord(Wp,Wr,ap,ar);
        [n,m] = ellip(N,ap,ar,Wp);
end

resposta = filter(n,m,x);
resposta = fftn(resposta)/N;

[H,w]= freqz(n,m);

axes(handles.axes2);
plot(w*fs/(2*pi),20*log10(abs(H)));
xlabel('rad/s');
ylabel('Módulo');
title('Módulo Filtro');

axes(handles.axes1);
plot(freq(1:cutOff),abs(resposta(1:cutOff)));
xlabel('Frequência');
ylabel('Módulo');
title('Sinal Filtrado');

% --- Executes when selected object is changed in group1.
function group1_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in group1 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
global metodo;
switch get(eventdata.NewValue,'Tag') % Get Tag of selected object.
    case 'tgbFIR'
        set(handles.group2,'Visible','on');
        set(handles.group3,'Visible','off');
        set(handles.panel2,'Visible','off');
        set(handles.panel1,'Visible','on');
        set(handles.rdbHam,'Value',1);
        metodo = 1;
    case 'tgbIIR'
        set(handles.group2,'Visible','off');
        set(handles.group3,'Visible','on');
        set(handles.panel2,'Visible','on');
        set(handles.panel1,'Visible','off');
        set(handles.rdbBut,'Value',1);
        metodo = 3;
end
calculo(handles);

% --- Executes when selected object is changed in group2.
function group2_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in group2 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
global metodo;
global janela;
switch get(eventdata.NewValue,'Tag') % Get Tag of selected object.
    case 'rdbHam'
        metodo = 1;
    case 'rdbBlack'
        janela = 4;
        set(handles.slider4,'Value',4);
        set(handles.t,'String','4');
        metodo = 2;      
end
calculo(handles);

% --- Executes when selected object is changed in group3.
function group3_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in group3 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
global metodo;
switch get(eventdata.NewValue,'Tag') % Get Tag of selected object.
    case 'rdbBut'
        metodo = 3;
    case 'rdbCheb1'
        metodo = 4;
    case 'rdbCheb2'
        metodo = 5;
    case 'rdbEli'
        metodo = 6;
end
calculo(handles);

% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global janela;
janela = get(handles.slider4,'Value');
calculo(handles);
set(handles.t,'String',get(handles.slider4,'Value'));

% --- Executes on slider movement.
function slider5_Callback(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global fs;
fs = get(handles.slider5,'Value');
set(handles.t4,'String',get(handles.slider5,'Value'));
set(handles.t10,'String',get(handles.slider5,'Value'));
set(handles.slider10,'Value',get(handles.slider5,'Value'));
calculo(handles);

% --- Executes on slider movement.
function slider7_Callback(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global fc;
fc = get(handles.slider7,'Value');
set(handles.t7,'String',get(handles.slider7,'Value'));
calculo(handles);

% --- Executes on slider movement.
function slider8_Callback(hObject, eventdata, handles)
% hObject    handle to slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global fp;
fp = get(handles.slider8,'Value');
set(handles.t8,'String',get(handles.slider8,'Value'));
calculo(handles);

% --- Executes on slider movement.
function slider9_Callback(hObject, eventdata, handles)
% hObject    handle to slider9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global fr;
fr = get(handles.slider9,'Value');
set(handles.t9,'String',get(handles.slider9,'Value'));
calculo(handles);




% --- Executes on slider movement.
function slider10_Callback(hObject, eventdata, handles)
% hObject    handle to slider10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global fs;
fs = get(handles.slider10,'Value');
set(handles.t10,'String',get(handles.slider10,'Value'));
set(handles.t4,'String',get(handles.slider10,'Value'));
set(handles.slider5,'Value',get(handles.slider10,'Value'));
calculo(handles);


% --- Executes on slider movement.
function slider11_Callback(hObject, eventdata, handles)
% hObject    handle to slider11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global ap;
ap = get(handles.slider11,'Value');
set(handles.t11,'String',get(handles.slider11,'Value'));
calculo(handles);


% --- Executes on slider movement.
function slider12_Callback(hObject, eventdata, handles)
% hObject    handle to slider12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global ar;
ar = get(handles.slider12,'Value');
set(handles.t12,'String',get(handles.slider12,'Value'));
calculo(handles);

%%----------------------------------------------------------------------------------%%
%   Desenvolvido por: AndreMonteiro
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %   %%%%%   %%  %   %%    %%%%  %%%%%   %%
    %   %   %   %  %%   %  %  % %   %%%     %%
    %   %   %   %   %   %%    %  %  %%%%%   %%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    

% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes during object creation, after setting all properties.
function slider5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes during object creation, after setting all properties.
function slider7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes during object creation, after setting all properties.
function slider9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes during object creation, after setting all properties.
function slider8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes during object creation, after setting all properties.
function slider10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes during object creation, after setting all properties.
function slider11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes during object creation, after setting all properties.
function slider12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

%   Desenvolvido por: AndreMonteiro
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %   %%%%%   %%  %   %%    %%%%  %%%%%   %%
    %   %   %   %  %%   %  %  % %   %%%     %%
    %   %   %   %   %   %%    %  %  %%%%%   %%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
