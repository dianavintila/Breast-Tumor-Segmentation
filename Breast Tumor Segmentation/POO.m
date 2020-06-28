function varargout = POO(varargin)
% POO MATLAB code for POO.fig
%      POO, by itself, creates a new POO or raises the existing
%      singleton*.
%
%      H = POO returns the handle to a new POO or the handle to
%      the existing singleton*.
%
%      POO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in POO.M with the given input arguments.
%
%      POO('Property','Value',...) creates a new POO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before POO_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to POO_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help POO

% Last Modified by GUIDE v2.5 15-Jan-2020 12:20:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @POO_OpeningFcn, ...
                   'gui_OutputFcn',  @POO_OutputFcn, ...
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


% --- Executes just before POO is made visible.
function POO_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to POO (see VARARGIN)

% Choose default command line output for POO
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes POO wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = POO_OutputFcn(~, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in kmeans.
function kmeans_Callback(~, ~, handles)
% hObject    handle to kmeans (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global imkmeans1 ak1 imkmeans2 ak2
axes(handles.axes3);
T1=imkmeans1;
tumor1=ak1;
imshow(T1);
title('\fontsize{18}\color[rgb]{0.635 0.078 0.184} Stadiu pretratament')
axes(handles.axes4);
T2=imkmeans2;
tumor2=ak2;
imshow(T2);
title('\fontsize{18}\color[rgb]{0.635 0.078 0.184} Stadiu post-tratament')

textLabel = sprintf('Tumoarea gasitã are o arie de %f mm\xB2.',tumor1);
set(handles.arie1, 'String', textLabel);

textLabel = sprintf('Tumoarea gasitã are o arie de %f mm\xB2.',tumor2);
set(handles.arie2, 'String', textLabel);

if (tumor1>tumor2) 
    textLabel = sprintf('Tumoarea s-a micsorat, tratamentul îsi face efectul ceea ce confirmã continuarea acestuia.',tumor2); 
    set(handles.observatii, 'String', textLabel);
else 
    textLabel = sprintf('Tumoarea a evoluat în sens negativ, aceasta si-a extins suprafata, fapt ce sustine cã tratamentul nu functioneazã. Se vor încerca si alte variante de tratament.');
    set(handles.observatii, 'String', textLabel);
end



% --- Executes on button press in incarca1.
function incarca1_Callback(~, ~, handles)
% hObject    handle to incarca1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im1
[path,user_cancel]=imgetfile();
if user_cancel
    msgbox(sprintf('Selectie invalida!'),'Error','Warn');
    return
end
im1=imread(path);
im1=im2double(im1);
im1=imresize(im1,[1080 720]);
axes(handles.axes1);
imshow(im1);
title('\fontsize{18}\color[rgb]{0.635 0.078 0.184} Mamografia pretratament')


% --- Executes on button press in incarca2.
function incarca2_Callback(~, ~, handles)
% hObject    handle to incarca2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im2
[path,user_cancel]=imgetfile();
if user_cancel
    msgbox(sprintf('Selectie invalida!'),'Error','Warn');
    return
end
im2=imread(path);
im2=im2double(im2);
im2=imresize(im2,[1080 720]);
axes(handles.axes2);
imshow(im2);
title('\fontsize{18}\color[rgb]{0.635 0.078 0.184} Mamografia post-tratament')

% --- Executes on button press in sterge.
function sterge_Callback(~, ~, handles)
% hObject    handle to sterge (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
im=ones(4000,2500);
axes(handles.axes1);
imshow(im);
axes(handles.axes2);
imshow(im);
axes(handles.axes3);
imshow(im);
axes(handles.axes4);
imshow(im);
textLabel = sprintf('');
set(handles.arie1, 'String', textLabel);
textLabel = sprintf('');
set(handles.arie2, 'String', textLabel);
textLabel = sprintf('');
set(handles.observatii, 'String', textLabel);
clear;
clc;


% --- Executes on button press in togglebutton1.
function togglebutton1_Callback(~, ~, ~)
% hObject    handle to togglebutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton1


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in fcm.
function fcm_Callback(~, ~, handles)
% hObject    handle to fcm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global imfuzzy1 afcm1 imfuzzy2 afcm2
axes(handles.axes3);
T1=imfuzzy1;
tumor1=afcm1;
imshow(T1);
title('\fontsize{18}\color[rgb]{0.635 0.078 0.184} Stadiu pretratament')
axes(handles.axes4);
T2=imfuzzy2;
tumor2=afcm2;
imshow(T2);
title('\fontsize{18}\color[rgb]{0.635 0.078 0.184} Stadiu post-tratament')

textLabel = sprintf('Tumoarea gasitã are o arie de %f mm\xB2.',tumor1);
set(handles.arie1, 'String', textLabel);

textLabel = sprintf('Tumoarea gasitã are o arie de %f mm\xB2.',tumor2);
set(handles.arie2, 'String', textLabel);

if (tumor1>tumor2) 
    textLabel = sprintf('Tumoarea s-a micsorat, tratamentul îsi face efectul ceea ce confirmã continuarea acestuia.',tumor2); 
    set(handles.observatii, 'String', textLabel);
else 
    textLabel = sprintf('Tumoarea a evoluat în sens negativ, aceasta si-a extins suprafata, fapt ce sustine cã tratamentul nu functioneazã. Se vor încerca si alte variante de tratament.');
    set(handles.observatii, 'String', textLabel);
end


% --- Executes on button press in treshold.
function treshold_Callback(hObject, eventdata, handles)
% hObject    handle to treshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global imthres1 afcmtresh1 imthres2 afcmtresh2 
axes(handles.axes3);
T1=imthres1;
tumor1=afcmtresh1;
imshow(T1);
title('\fontsize{18}\color[rgb]{0.635 0.078 0.184} Stadiu pretratament')
axes(handles.axes4);
T2=imthres2;;
tumor2=afcmtresh2;
imshow(T2);
title('\fontsize{18}\color[rgb]{0.635 0.078 0.184} Stadiu post-tratament')

textLabel = sprintf('Tumoarea gasitã are o arie de %f mm\xB2.',tumor1);
set(handles.arie1, 'String', textLabel);

textLabel = sprintf('Tumoarea gasitã are o arie de %f mm\xB2.',tumor2);
set(handles.arie2, 'String', textLabel);

if (tumor1>tumor2) 
    textLabel = sprintf('Tumoarea s-a micsorat, tratamentul îsi face efectul ceea ce confirmã continuarea acestuia.',tumor2); 
    set(handles.observatii, 'String', textLabel);
else 
    textLabel = sprintf('Tumoarea a evoluat în sens negativ, aceasta si-a extins suprafata, fapt ce sustine cã tratamentul nu functioneazã. Se vor încerca si alte variante de tratament.');
    set(handles.observatii, 'String', textLabel);
end


% --- Executes on button press in prelucreaza.
function prelucreaza_Callback(hObject, eventdata, handles)
% hObject    handle to prelucreaza (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im1 im2 imkmeans1 ak1 imthres1 afcmtresh1 imfuzzy1 afcm1 imkmeans2 ak2 imthres2 afcmtresh2 imfuzzy2 afcm2
[imkmeans1,ak1,imthres1,afcmtresh1,imfuzzy1,afcm1]=output(im1);
[imkmeans2,ak2,imthres2,afcmtresh2,imfuzzy2,afcm2]=output(im2);
msgbox(sprintf('Operatiune completã!'),'Info','Warn');


% --- Executes on button press in help.
function help_Callback(hObject, eventdata, handles)
% hObject    handle to help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox({'1. Incarca mamografiile';'2. Apasa "Prelucreaza datele" si asteapta pana la mesajul de finalizare';'3. Apasa pe tipul de algoritm dorit pentru a vedea rezultatul';'4. Pentru a putea vedea riscul ca tumoarea sã fie malignã apãsati "Stadializarea tumorii" si completati chestionarul';'5. Optional, puteti sterge mamografiile si sa incarcati altele';'6. Repetati pasii 1, 2, 3 si 4 pentru a vedea rezultatele'},'HELP','help');


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run('chestionar.m');
