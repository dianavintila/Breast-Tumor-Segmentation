function varargout = chestionar(varargin)
% CHESTIONAR MATLAB code for chestionar.fig
%      CHESTIONAR, by itself, creates a new CHESTIONAR or raises the existing
%      singleton*.
%
%      H = CHESTIONAR returns the handle to a new CHESTIONAR or the handle to
%      the existing singleton*.
%
%      CHESTIONAR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CHESTIONAR.M with the given input arguments.
%
%      CHESTIONAR('Property','Value',...) creates a new CHESTIONAR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before chestionar_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to chestionar_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help chestionar

% Last Modified by GUIDE v2.5 15-Jan-2020 18:35:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @chestionar_OpeningFcn, ...
                   'gui_OutputFcn',  @chestionar_OutputFcn, ...
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


% --- Executes just before chestionar is made visible.
function chestionar_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to chestionar (see VARARGIN)

% Choose default command line output for chestionar
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes chestionar wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = chestionar_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in afisare.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to afisare (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
mase=0;
calcificari=0;
forma=0;
contururi=0;
structura=0;
formac=0;
benign=0;
focare=0;
difuz=0;
izolat=0;

%Forma 30%
if get(handles.neregulata,'Value') % 50%
    forma=15;
 end
if get(handles.rotunda,'Value') % 20%
    forma=6;
 end
if get(handles.ovala,'Value') % 20%
    forma=6;
 end
if get(handles.lobulata,'Value') % 10%
    forma=3;
end
 %Contururi 65%
if get(handles.microlobulate,'Value') % 30%
    contururi=19.5;
 end
if get(handles.sterse,'Value') % 30%
    contururi=19.5;
 end
if get(handles.spiculatii,'Value') % 30%
    contururi=19.5;
 end
if get(handles.circumscrise,'Value') % 10%
    contururi=6.5;
end
 %Structura 5%
if get(handles.omogena,'Value') % 90%
    structura=4.5;
 end
if get(handles.neomogena,'Value') % 10%
    structura=0.5;
end
mase=forma+contururi+structura;
mase=(mase*34)/100;
 % Calcificari 66%
if get(handles.benign,'Value') % 0%
    benign=0;
end
if get(handles.difuz,'Value') % 8%
    difuz=5.28;
 end
if get(handles.izolate,'Value') % 2%
    izolat=1.32;
end
 %Focare 30%
 if get(handles.focare_alte_forme,'Value') % 8%
    focare=27;
 end
if get(handles.focare_rotunde,'Value') % 2%
    focare=3;
end
 %Forma 60%
if get(handles.forma_rotunda,'Value') % 0%
    formac=0;
 end
if get(handles.inelare,'Value') % 5%
    formac=3;
end
 if get(handles.pulverente,'Value') % 60%
     formac=36;
 end
if get(handles.forma_neregulata,'Value') % 10%
    formac=6;
 end
if get(handles.liniare_regulate,'Value') % 5%
    formac=3;
 end
if get(handles.liniare_neregulate,'Value') % 20%
    formac=12;
end
 if get(handles.arborescente,'Value') % 0%
     formac=0;
 end
calcificari=benign+difuz+izolat+focare+formac;
calcificari=(calcificari*66)/100;

risc=mase+calcificari;
textLabel=sprintf('%.2f%%',risc);
set(handles.afisare, 'String', textLabel);
