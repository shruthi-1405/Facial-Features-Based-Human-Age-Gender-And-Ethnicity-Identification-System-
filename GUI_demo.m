function varargout = GUI_demo(varargin)
% GUI_DEMO MATLAB code for GUI_demo.fig
%      GUI_DEMO, by itself, creates a new GUI_DEMO or raises the existing
%      singleton*.
%
%      H = GUI_DEMO returns the handle to a new GUI_DEMO or the handle to
%      the existing singleton*.
%
%      GUI_DEMO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_DEMO.M with the given input arguments.
%
%      GUI_DEMO('Property','Value',...) creates a new GUI_DEMO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_demo_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_demo_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  folder_age "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_demo

% Last Modified by GUIDE v2.5 31-May-2022 21:19:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_demo_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_demo_OutputFcn, ...
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


% --- Executes just before GUI_demo is made visible.
function GUI_demo_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_demo (see VARARGIN)

% folder_age default command line output for GUI_demo
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_demo wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_demo_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in folder_race.
function folder_race_Callback(hObject, eventdata, handles)

global img;
[FileName,PathName] = uigetfile('*.jpg;*.png;*.bmp;*.jfif','Select an image');
img=imread(strcat(PathName,FileName));
axis(handles.display1);
imshow(img);

function folder_race_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in folder_gender.
function folder_gender_Callback(hObject, eventdata, handles)

global img;
[FileName,PathName] = uigetfile('*.jpg;*.png;*.bmp;*.jfif','Select an image');
img=imread(strcat(PathName,FileName));
axes(handles.display1);
imshow(img);

function folder_gender_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in folder_age.
function folder_age_Callback(hObject, eventdata, handles)

global img;
[FileName,PathName] = uigetfile('*.jpg;*.png;*.bmp;*.jfif','Select an image');
img=imread(strcat(PathName,FileName));
axes(handles.display1);
imshow(img);



% --- Executes on button press in webcam_race.
function webcam_race_Callback(hObject, eventdata, handles)

global img;
vid=videoinput('winvideo',1);
set(vid,'ReturnedColorSpace','RGB');
img=getsnapshot(vid);
axes(handles.display1);
imshow(img);

function webcam_gender_Callback(hObject, eventdata, handles)

global img;
vid=videoinput('winvideo',1);
set(vid,'ReturnedColorSpace','RGB');
img=getsnapshot(vid);
axes(handles.display1);
imshow(img);


function webcam_age_Callback(hObject, eventdata, handles)

global img;
vid=videoinput('winvideo',1);
set(vid,'ReturnedColorSpace','RGB');
img=getsnapshot(vid);
axes(handles.display1);
imshow(img);



function folder_age_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes during object deletion, before destroying properties.
function folder_age_DeleteFcn(hObject, eventdata, handles)



% --- Executes when figure1 is resized.
function figure1_SizeChangedFcn(hObject, eventdata, handles)



% --- Executes on button press in load_race.
function load_race_Callback(hObject, eventdata, handles)

global net_ethnicity;
load('net_ethnicity_col.mat');
f=msgbox("Successfully loaded");


% --- Executes on button press in load_gender.
function load_gender_Callback(hObject, eventdata, handles)
global net_gen;
global net_age;
load ('net2.mat');
f=msgbox("Successfully loaded");





% --- Executes on button press in load_age.
function load_age_Callback(hObject, eventdata, handles)

global net;
load('net_age_Resnet.mat');
f=msgbox("Successfully loaded");





function Output_Race_Callback(hObject, eventdata, handles)

 global img;
 global net_ethnicity;
FDetect = vision.CascadeObjectDetector;
BB = step(FDetect,img);
figure,
imshow(img); hold on
for i = 1:size(BB,1)
    rectangle('Position',BB(i,:),'LineWidth',5,'LineStyle','-','EdgeColor','r');
end
title('Face Detection');
hold off;
class_out=[]
face=[]
for i=1:size(BB,1)
    face{i} = imresize(imcrop(img,BB(i,:)),[200 200 ]);
    class_out{i}=classify(net_ethnicity,face{i});
    subplot(1,size(BB,1),i);
    imshow(uint8(face{i})); 
    title(string(class_out{i}));
end



% --- Executes during object creation, after setting all properties.
function load_race_CreateFcn(hObject, eventdata, handles)



% --- Executes on button press in output_age.
function output_age_Callback(hObject, eventdata, handles)

global img;
global net;
FDetect = vision.CascadeObjectDetector;
BB = step(FDetect,img);
figure,

imshow(img); hold on
for i = 1:size(BB,1)
    rectangle('Position',BB(i,:),'LineWidth',5,'LineStyle','-','EdgeColor','r');
end
title('Face Detection');
hold off;
class_out=[]
face=[]
for i=1:size(BB,1)
    face{i} = imresize(imcrop(img,BB(i,:)),[200 200 ]);
    class_out{i}=classify(net,face{i});
    subplot(1,size(BB,1),i);
    imshow(uint8(face{i})); 
    title(string(class_out{i}));
end

function output_gender_Callback(hObject, eventdata, handles)

 global net_age;
 global net_gen;
 global img;



if( ~exist( 'net_vgg', 'var' ) )
 net_vgg = VGGFaceNotop();
end

if( ~exist( 'net_age', 'var' ) || ~exist( 'net_gen', 'var' ) || ~exist( 'net_att', 'var' ) )
 load('net2.mat');
end

detector = buildDetector();
[bbox bbimg faces bbfaces] = detectFaceParts(detector,img,2);
figure;
images = zeros( 224, 224, 3, size(faces,1), 'single' );
for i=1:size(faces,1)
 img = single(faces{i});
 img = imresize( img, [224, 224] )/255;
 images(:,:,:,i) = img;
end
left = bbox(:,1);
[dummy, ind] = sort(left);
[age, gen] = est_age_gender( net_vgg, net_age, net_gen,images );

for i=1:size(bbfaces,1)
   t = sprintf('Gender : %s ', gen(ind(i)));
  
 subplot(1,size(bbfaces,1),i);
 imshow(uint8(faces{ind(i)})); 
 title(t);
end
