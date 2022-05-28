function varargout = luas(varargin)
% LUAS MATLAB code for luas.fig
%      LUAS, by itself, creates a new LUAS or raises the existing
%      singleton*.
%
%      H = LUAS returns the handle to a new LUAS or the handle to
%      the existing singleton*.
%
%      LUAS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LUAS.M with the given input arguments.
%
%      LUAS('Property','Value',...) creates a new LUAS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before luas_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to luas_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help luas

% Last Modified by GUIDE v2.5 28-May-2022 12:40:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @luas_OpeningFcn, ...
                   'gui_OutputFcn',  @luas_OutputFcn, ...
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


% --- Executes just before luas is made visible.
function luas_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to luas (see VARARGIN)

% Choose default command line output for luas
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes luas wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = luas_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
open=guidata(gcbo);
[namafile]=uigetfile({'*.jpg;*.bmp;*.tif'},'openimage');
if ~isequal(namafile,0)
    handles.I=imread(fullfile(namafile));
    handles.img = imresize(handles.I,[300,300]);
    hasil = handles.img;
    guidata(hObject,handles);
    set(open.figure1,'CurrentAxes',open.axes1);
    set(imagesc(hasil));colormap('gray');
    set(open.axes1,'Userdata',hasil);
else
    return;
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
open=guidata(gcbo);
A =(get(open.axes1,'Userdata'));
gry = rgb2gray(A); 
set(open.figure1,'CurrentAxes',open.axes2);
set(imagesc(gry));
set(open.axes2,'Userdata',gry);

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
open=guidata(gcbo);
C =(get(open.axes2,'Userdata'));
K = im2bw(C,0.95);
R = imcomplement(K);
L = bwareaopen (R,100);
set(open.figure1,'CurrentAxes',open.axes3);
set(imagesc(L));
set(open.axes3,'Userdata',L);


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
open=guidata(gcbo);
O =(get(open.axes3,'Userdata'));
[label,n] = bwlabel(O);
N = label2rgb(label);
set(open.figure1,'CurrentAxes',open.axes4);
set(imagesc(N));
set(open.axes4,'Userdata',N);

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
open=guidata(gcbo);
O =(get(open.axes3,'Userdata'));
[label,n] = bwlabel(O);
N = label2rgb(label);
set(open.figure1,'CurrentAxes',open.axes5);
set(imagesc(N));
set(open.axes5,'Userdata',N);
stats = regionprops(label,'Area','Centroid');
for k = 1:n
    area = stats(k).Area;
    centroid= stats(k).Centroid;
    text(centroid(1),centroid(2)-12,num2str(k),'color','k',...
        'FontSize',12,'FontWeight','bold');
    text(centroid(1)-12,centroid(2)+12,num2str(area),'color','k',...
        'FontSize',12,'FontWeight','bold');
end

function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
open=guidata(gcbo);
O =(get(open.axes3,'Userdata'));
area = bwarea(O);
perim = bwperim(O);
perimeter = sum (sqrt(sum(area,2)));
set(open.edit1,'string',perimeter);
set(open.edit2,'string',bwarea(perim));

function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
