function varargout = interfata(varargin)
% INTERFATA MATLAB code for interfata.fig
%      INTERFATA, by itself, creates a new INTERFATA or raises the existing
%      singleton*.
%
%      H = INTERFATA returns the handle to a new INTERFATA or the handle to
%      the existing singleton*.
%
%      INTERFATA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INTERFATA.M with the given input arguments.
%
%      INTERFATA('Property','Value',...) creates a new INTERFATA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before interfata_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to interfata_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help interfata

% Last Modified by GUIDE v2.5 26-Dec-2019 16:35:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @interfata_OpeningFcn, ...
                   'gui_OutputFcn',  @interfata_OutputFcn, ...
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


% --- Executes just before interfata is made visible.
function interfata_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to interfata (see VARARGIN)

% Choose default command line output for interfata
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes interfata wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = interfata_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in incarca_RMN.
function incarca_RMN_Callback(hObject, eventdata, handles)
% hObject    handle to incarca_RMN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im im2
[path,user_cancel]=imgetfile();
if user_cancel
    msgbox(sprintf('Selectie invalida!'),'Error','Warn');
    return
end
im=imread(path);
im2=im;
im=im2double(im);
axes(handles.axes2);
imshow(im);
title('\fontsize{18}\color[rgb]{0.635 0.078 0.184} RMN-ul pacientului')

% --- Executes on button press in evidentiaza_tumoare.
function evidentiaza_tumoare_Callback(~, eventdata, handles)
% hObject    handle to evidentiaza_tumoare (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im tumor im2
bw=im2bw(im,0.7); %convertesc imaginea intr-o imagine binara
etichete=bwlabel(bw); %returneaza matricea etichetelor 
stats= regionprops(etichete, 'Solidity','Area'); %returneaza masuratorile pentru setul de propietati
densitate=[stats.Solidity];
suprafata=[stats.Area];

high_dense_area = densitate>0.5;
suprafata_maxima=max(suprafata(high_dense_area));
eticheta_tumoare= find(suprafata==suprafata_maxima);
tumor=ismember(etichete,eticheta_tumoare);

se=strel('square',5); %creeaza un element de structurare patrat a carui lungime este 5 pixeli
tumor=imdilate(tumor,se); %dilata imaginea 
axes(handles.axes3);
%imshow(tumor,[]);
I = im2double(im2);                   
I=rgb2gray(I);
T=Kmeans(I);
imshow(T);
title('\fontsize{18}\color[rgb]{0.635 0.078 0.184} Tumoarea izolata')
axes(handles.axes4);
[B,L]=bwboundaries(tumor,'noholes'); %urmareste limitele exterioare ale obiectului
imshow(im,[])
hold on
for i=1:length(B)  %desenez marginea tumorii
    plot(B{i}(:,2),B{i}(:,1),'y','linewidth',1.45)
end
title('\fontsize{18}\color[rgb]{0.635 0.078 0.184} Tumoarea detectata')
hold off


% --- Executes on button press in aria.
function aria_Callback(hObject, eventdata, handles)
% hObject    handle to aria (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pixel=0.264;
global tumor
[n,m]=size(tumor);
aria=0;
for i=1:n
    for j=1:m
        if (tumor(i,j)==1) aria=aria+1;
        end
    end
end
aria=sqrt(aria)*pixel;
textLabel = sprintf('Tumoarea gasitã au o arie de %f mm\xB2.',aria);
set(handles.text6, 'String', textLabel);


% --- Executes on button press in type.
function type_Callback(hObject, eventdata, handles)
% hObject    handle to type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load('training.mat');
global im2
  im2=imresize(im2,5);
  im2=rgb2gray(im2);
  im2=im2double(im2);
  [~,S,~]=svd(im2);
  sigmas=diag(S);
  NewV=norm(sigmas);
  N=abs(BaseNormV-NewV);
  B=abs(BaseBenignV-NewV);
  M=abs(BaseMalignV-NewV);
  V=[N B M];
  P=min(V);
  if (P==N)
    msgbox(sprintf('RMN-ul este normal, chiar daca prezinta anumite calcificatii!'),'Clasificarea tumorii','help');
  end
  if (P==B)
    msgbox(sprintf('Tumoarea gasita in MRI este benigna!'),'Clasificarea tumorii','help');
  end
  if (P==M)
    msgbox(sprintf('Tumoarea gasita in MRI este maligna!'),'Clasificarea tumorii','warn');
  end


% --- Executes on button press in sterge.
function sterge_Callback(hObject, eventdata, handles)
% hObject    handle to sterge (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
im=ones(256,256);
axes(handles.axes2);
imshow(im);
axes(handles.axes3);
imshow(im);
axes(handles.axes4);
imshow(im);
textLabel = sprintf('Aria tumorii');
set(handles.text6, 'String', textLabel);
clear;
clc;
