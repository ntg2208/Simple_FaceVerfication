function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%   
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 29-Nov-2018 14:25:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
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


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)
% Add path
matCaffe       = '../../caffe';
pdollarToolbox = '../../toolbox-master';
MTCNN          = '../../MTCNNv1';
addpath(genpath(matCaffe));
addpath(genpath(pdollarToolbox));
addpath(genpath(MTCNN));

axes(handles.axes2);
set(gca,'xtick',[],'ytick',[]);

axes(handles.axes3);
set(gca,'xtick',[],'ytick',[]);

axes(handles.axes4);
set(gca,'xtick',[],'ytick',[]);

axes(handles.axes5);
set(gca,'xtick',[],'ytick',[]);

axes(handles.axes9);
set(gca,'xtick',[],'ytick',[]);

axes(handles.axes10);
set(gca,'xtick',[],'ytick',[]);
imshow('GuiImg.jpg');


% Choose default command line output for gui
axes(handles.axes2);
vid = videoinput('winvideo',1,'YUY2_640x480');

vid.ReturnedColorspace = 'rgb';

hImage = image(zeros(480,640,3),'Parent',handles.axes2);

preview(vid,hImage);

handles.output = vid;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


% --- Executes during object deletion, before destroying properties.
function axes2_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure

delete(hObject);


% --- Executes on button press in cap1_but.
function cap1_but_Callback(hObject, eventdata, handles)
% hObject    handle to cap1_but (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.pic1 = getsnapshot(handles.output);

handles.face1 = facedetect2(handles.pic1);

axes(handles.axes3);
imshow(handles.face1);
% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in cmp_but.
function cmp_but_Callback(hObject, eventdata, handles)
% hObject    handle to cmp_but (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
result = cmp(handles.face1,handles.face2);
if result == 1
    img = imread('True.jpg');
else
    img = imread('Different.png');
end
axes(handles.axes5);
imshow(img);



% --- Executes on button press in cap2_but.
function cap2_but_Callback(hObject, eventdata, handles)
% hObject    handle to cap2_but (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.pic2 = getsnapshot(handles.output);

handles.face2 = facedetect2(handles.pic2);

handles.id = 0;

axes(handles.axes4);
imshow(handles.face2);

handles.id = studentID(handles.pic2);
handles.id = insertText(0.94*ones(150,450),[50 30],num2str(handles.id),'BoxOpacity',0,'FontSize',75);

axes(handles.axes9);
imshow(handles.id);

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function axes3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes3


% --- Executes on button press in but_exit.
function but_exit_Callback(hObject, eventdata, handles)
% hObject    handle to but_exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close;
