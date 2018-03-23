function varargout = untitled1(varargin)
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

% Last Modified by GUIDE v2.5 19-Mar-2017 14:05:44

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
f1=1000; % freqüência dentro da banda de passagem
f2=3000; % freqüência dentro da banda de rejeição
t=0:1:1000;
fs=8000;
x = 4*sin((2*pi*f1*t/fs)) + sin((2*pi*f2*t/fs)); % Sinal com ruído
fc = 1750; 

N=length(x);
K=0:N-1;
T=N/fs;
freq=K/T;
cutOff=ceil(N/2);
fc= (fc*2)/fs;
wc=fc;

filtro= fir1(1,wc,'low', hamming(2));

resposta = filter(filtro,1,x);

resposta = fftn(resposta)/N;

[H,w]= freqz(filtro,1);

axes(handles.axes2);
plot(w*fs/(2*pi),20*log10(abs(H)));
xlabel('rad/s');
ylabel('Módulo');
title('Janela Hamming - Módulo');

axes(handles.axes1);
plot(freq(1:cutOff),abs(resposta(1:cutOff)));
xlabel('Frequência');
ylabel('Módulo');
title('Sinal Filtrado');

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


function calculo(hObject,handles)
f1=1000;
f2=3000;
t=0:1:1000;
fs = get(handles.t4,'Value');
x = 4*sin((2*pi*f1*t/fs)) + sin((2*pi*f2*t/fs)); 
fc = get(handles.t7,'Value');

N=length(x);
K=0:N-1;
T=N/fs;
freq=K/T;

cutOff=ceil(N/2);
fc= (fc*2)/fs;
wc=fc;

a = get(hObject,'Value');

filtro= fir1((a-1),wc,'low', hamming(a));

resposta = filter(filtro,1,x);

resposta = fftn(resposta)/N;

[H,w]= freqz(filtro,1);

axes(handles.axes2);
plot(w*fs/(2*pi),20*log10(abs(H)));
xlabel('rad/s');
ylabel('Módulo');
title('Janela Hamming - Módulo');


set(handles.t,'String',a);
set(handles.t,'Value',a);

axes(handles.axes1);
plot(freq(1:cutOff),abs(resposta(1:cutOff)));
xlabel('Frequência');
ylabel('Módulo');
title('Sinal Filtrado');


function calculo2(hObject,handles)
f1=1000;
f2=3000;
t=0:1:1000;
fs = get(hObject,'Value');
x = 4*sin((2*pi*f1*t/fs)) + sin((2*pi*f2*t/fs)); 
fc = get(handles.t7,'Value'); 

N=length(x);
K=0:N-1;
T=N/fs;
freq=K/T;

cutOff=ceil(N/2);
fc= (fc*2)/fs;
wc=fc;

a = get(handles.t,'Value');

filtro= fir1((a-1),wc,'low', hamming(a));

resposta = filter(filtro,1,x);

resposta = fftn(resposta)/N;

[H,w]= freqz(filtro,1);

axes(handles.axes2);
plot(w*fs/(2*pi),20*log10(abs(H)));
xlabel('rad/s');
ylabel('Módulo');
title('Janela Hamming - Módulo');

set(handles.t4,'String',fs);
set(handles.t4,'Value',fs);
axes(handles.axes1);
plot(freq(1:cutOff),abs(resposta(1:cutOff)));
xlabel('Frequência');
ylabel('Módulo');
title('Sinal Filtrado');


function calculo3(hObject,handles)
f1=1000;
f2=3000;
t=0:1:1000;
fs = get(handles.t4,'Value');
x = 4*sin((2*pi*f1*t/fs)) + sin((2*pi*f2*t/fs)); 
fc = get(hObject,'Value'); 
set(handles.t7,'String',fc);
set(handles.t7,'Value',fc);

N=length(x);
K=0:N-1;
T=N/fs;
freq=K/T;

cutOff=ceil(N/2);
fc= (fc*2)/fs;
wc=fc;

a = get(handles.t,'Value');

filtro= fir1((a-1),wc,'low', hamming(a));

resposta = filter(filtro,1,x);

resposta = fftn(resposta)/N;

[H,w]= freqz(filtro,1);

axes(handles.axes2);
plot(w*fs/(2*pi),20*log10(abs(H)));
xlabel('rad/s');
ylabel('Módulo');
title('Janela Hamming - Módulo');


axes(handles.axes1);
plot(freq(1:cutOff),abs(resposta(1:cutOff)));
xlabel('Frequência');
ylabel('Módulo');
title('Sinal Filtrado');


% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.t,'String',get(handles.slider4,'Value'));
calculo(hObject,handles);


% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider5_Callback(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.t4,'String',get(handles.slider5,'Value'));
calculo2(hObject,handles);


% --- Executes during object creation, after setting all properties.
function slider5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider6_Callback(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider7_Callback(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.t7,'String',get(handles.slider7,'Value'));
calculo3(hObject,handles);


% --- Executes during object creation, after setting all properties.
function slider7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
