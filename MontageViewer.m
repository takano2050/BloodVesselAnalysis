function varargout = MontageViewer(varargin)
% MONTAGEVIEWER MATLAB code for MontageViewer.fig
%      MONTAGEVIEWER, by itself, creates a new MONTAGEVIEWER or raises the existing
%      singleton*.
%
%      H = MONTAGEVIEWER returns the handle to a new MONTAGEVIEWER or the handle to
%      the existing singleton*.
%
%      MONTAGEVIEWER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MONTAGEVIEWER.M with the given input arguments.
%
%      MONTAGEVIEWER('Property','Value',...) creates a new MONTAGEVIEWER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MontageViewer_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MontageViewer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MontageViewer

% Last Modified by GUIDE v2.5 05-May-2020 20:10:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MontageViewer_OpeningFcn, ...
                   'gui_OutputFcn',  @MontageViewer_OutputFcn, ...
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


% --- Executes just before MontageViewer is made visible.
function MontageViewer_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MontageViewer (see VARARGIN)

% Choose default command line output for MontageViewer
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MontageViewer wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MontageViewer_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global IMG
global filename
global pathname
global ALLIMAGE
global num_images
global openfilename
global imageinfo
global ImageSize0
global basename
global minI
global maxI

ALLIMAGE=[];
IMG=[];
A=[];

h1=figure(MontageViewer);
set(h1, 'HandleVisibility', 'off');
close all ;
set(h1, 'HandleVisibility', 'on');

axes(handles.axes1);
cla

% set(handles.slider1,'SliderStep',[0.01 0.1]);
set(handles.slider1,'Min',0);
set(handles.slider1,'Max',1);



defaultdirectory=pwd;

[filename,pathname]=uigetfile('*.tif');
addpath pathname;
cd(pathname);

openfilename = fullfile(pathname,filename);
basename = strrep(filename,'.tif','');
imageinfo = imfinfo(openfilename);
num_images = numel(imageinfo);

temp_num_images=num_images;
    
A = imread(openfilename, 1,'Info', imageinfo); 
ImageSize0=size(A)

ALLIMAGE = zeros(ImageSize0(1),ImageSize0(2),temp_num_images);
for k = 1:temp_num_images
    ALLIMAGE(:,:,k) = imread(openfilename, k,'Info', imageinfo);
end

IMG= ALLIMAGE(:,:,1);

axes(handles.axes1);
minI = min(min(IMG));
maxI = max(max(IMG));
imshow(IMG,[minI maxI]);



set(handles.text9,'String',basename);
set(handles.edit5,'String',num2str(num_images));
set(handles.slider1,'Min',0);
set(handles.slider1,'Max',1);
set(handles.slider1,'SliderStep',[1/(num_images-1) 10/(num_images-1)]);


guidata(hObject, handles);





% Hints: get(hObject,'String') returns contents of pushbutton1 as text
%        str2double(get(hObject,'String')) returns contents of pushbutton1 as a double



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



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)

h1=figure(MontageViewer);
set(h1, 'HandleVisibility', 'off');
close all ;
set(h1, 'HandleVisibility', 'on');

axes(handles.axes1);
cla
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
global IMG
global filename
global pathname
global ALLIMAGE
global num_images
global openfilename
global imageinfo
global ImageSize0
global basename
global minI
global maxI
% 
% minI = min(min(IMG));
% maxI = max(max(IMG));

a=get(handles.slider1,'Value');
b=round(a*(num_images-1)+1);

set(handles.edit8,'String',num2str(b));


IMGI= ALLIMAGE(:,:,b);

axes(handles.axes1);

imshow(IMGI,[minI maxI]);


guidata(hObject, handles);




% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
global IMG
global filename
global pathname
global ALLIMAGE
global num_images
global openfilename
global imageinfo
global ImageSize0
global basename
global minI
global maxI
global p

hh=figure('Name',basename,'NumberTitle','on');


rown=str2num(get(handles.edit2,'String'));
columnn=str2num(get(handles.edit3,'String'));
startcellnumber=str2num(get(handles.edit7,'String'));
skipframe=str2num(get(handles.edit4,'String'));

plotnumber=rown*columnn;
plotendnumber=startcellnumber+(plotnumber-1)*skipframe;

averagen=str2num(get(handles.edit1,'String'));

%%%% PANEL FUNCTION %% downloaded from mathworks.  panel.m  It' better than
%%%% subplot 
p = panel(hh);
p.pack(rown,columnn);
p.de.margin = 0;

tempid=[startcellnumber:skipframe:plotendnumber];
count=1;

for m=1:rown;
     for n=1:columnn;
        
        nnn=tempid(count)+averagen-1; 
        if nnn<= num_images;    
    
        p(m,n).select();
        
        tempIMG=mean(ALLIMAGE(:,:,tempid(count):nnn),3);
        imshow(tempIMG,[minI maxI])
        text(20, 20, num2str(tempid(count)),'Color',[0 1 1]);

        else
                 
        end
        
        count=count+1;
     end
     
end
guidata(hObject, handles);
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
global p
global basename
global pathname

montagefilename=[basename '_montage']
savefilename = fullfile(pathname,montagefilename);

p.export(savefilename,  '-rp');

guidata(hObject, handles);
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
