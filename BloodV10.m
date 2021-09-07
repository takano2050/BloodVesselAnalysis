function varargout = BloodV10(varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BloodV10 MATLAB code for BloodV10.fig 
%   This code is written to draw vertical lines to measure width of the blood
%   vessles captured by two-photon microsocpy 
%                                   by Haji Takano @ CHOP/UPENN
%                                   April 2019
%   1.  Draw region of interest (polygon), double click to close the polygon.
%   2.  Right clock to accept the region. 
%   3.  Typein number of line to draw (default = 5 lines) 
%   4.  It draws number of line defined in 3. plus 2 more lines 
%   5.  It ignores the lines at both edges 
%   6.  It creates kymogram for each line
%   7.  It also saves snapshot of line positions. 
%   8.  Use the other code for analyzing kymogram images generated here. 
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BloodV10, by itself, creates a new BloodV10 or raises the existing
%      singleton*.
%
%      H = BloodV10 returns the handle to a new BloodV10 or the handle to
%      the existing singleton*.
%
%      BloodV10('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BloodV10.M with the given input arguments.
%
%      BloodV10('Property','Value',...) creates a new BloodV10 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before BloodV10_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to BloodV10_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help BloodV10

% Last Modified by GUIDE v2.5 05-May-2020 09:03:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @BloodV10_OpeningFcn, ...
                   'gui_OutputFcn',  @BloodV10_OutputFcn, ...
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


% --- Executes just before BloodV10 is made visible.
function BloodV10_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to BloodV10 (see VARARGIN)

% Choose default command line output for BloodV10
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes BloodV10 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = BloodV10_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

guidata(hObject, handles);


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% --- Executes on button press in pushbutton1.
% clear all
global IMG
global filename
global pathname
global ALLIMAGE
global num_images
global openfilename
global imageinfo
global ImageSize0
global basename
global MaxProjection
global defaultdirectory
global IMG1
global BW
global BW1 
global BW2
global IMGI

A=[];
B=[];
C=[];
CenterLine=[];
stats=[];
IMG=[];
IMG1=[];
IMGI=[];
BW=[];
BW1=[];
BW2=[];
LLF=[];
LL=[];
LLFILL=[];
LLBW=[];
BWW2=[];
BWLOGIC2=[];
ImageSize=[];
ImageSize0=[];
ALLIMAGE=[];



h3=figure(BloodV10);
set(h3, 'HandleVisibility', 'off');
close all ;
set(h3, 'HandleVisibility', 'on');

axes(handles.axes1);
cla

axes(handles.axes4);
cla

axes(handles.axes5);
cla


defaultdirectory=pwd;

[filename,pathname]=uigetfile('*.tif');
addpath pathname;
cd(pathname);

openfilename = fullfile(pathname,filename);
basename = strrep(filename,'.tif','');
set(handles.text2,'String',basename);


imageinfo = imfinfo(openfilename);
num_images = numel(imageinfo);

temp_num_images=num_images;

    
A = imread(openfilename, 1,'Info', imageinfo); 
ImageSize0=size(A)

ALLIMAGE = zeros(ImageSize0(1),ImageSize0(2),temp_num_images);
for k = 1:temp_num_images
    ALLIMAGE(:,:,k) = imread(openfilename, k,'Info', imageinfo);
end

IMG100 = ALLIMAGE(:,:,1:20);

% MaxProjection=max(IMG100,[],3);
MaxProjection=mean(IMG100,3);
IMG=medfilt2(MaxProjection);
axes(handles.axes1);
minI = min(min(IMG));
maxI = max(max(IMG));
imshow(IMG,[minI maxI]);
hold on

set(handles.edit17,'String',num2str(num_images));
set(handles.edit16,'String',num2str(num_images));

axes(handles.axes4);
cla
axes(handles.axes5);
cla

%%%%%%%%%%%%%%%% Threshold May 2020

if get(handles.radiobutton9,'Value')==1
IMGI2=uint8(IMG)
IMGI1=padarray(IMGI2,[1,0],255,'both');  %% Add white lines on top and bottom of images.
else

IMGI1=uint8(IMG);%% Convert to 8 bit image 
end


%%%%%%%%%%%%%%%%%%%TEST
HH=fspecial('gaussian',[3 3],3);
IMGI2=imfilter(IMGI1,HH);
IMGI=medfilt2(IMGI2,[3 3]);

ImageSize0=size(IMGI)


if get(handles.radiobutton8,'Value')==0;
    
[Ahisto x]=imhist(IMGI);
[THRE]=triangle_th(Ahisto,256);
BW1 = im2bw(IMGI,THRE);

else
        axes(handles.axes5);
        hold off
        [IMGhisto x]=imhist(IMGI);
        imhist(IMGI);
        h = impoint;
        pso = getPosition(h);
        x0 = pso(1);
        % y0 = pso(2);
        THRESHOLD = x0;
        THRE2=THRESHOLD/255;
        
        BW1=im2bw(IMGI,THRE2);
        
        XX=[THRESHOLD THRESHOLD];
        YY=[0 max(IMGhisto)];
        plot(XX, YY, 'Color',[1 0 0 ]);
        thresholdvalue=THRESHOLD;
        [IMGhisto x]=imhist(IMGI);
        axes(handles.axes5);
        hold off
        imhist(IMGI);
        Ymax=max(IMGhisto);
        hold on
        XX=[thresholdvalue thresholdvalue];
        YY=[0 Ymax];
        plot(XX, YY, 'Color',[1 0 0 ]);
end

    



BW2=bwareaopen(BW1,5000);  %%% REMOVE SMALL OBJECTS LESS THAN 1000 pixels 
BW = imfill(BW2,'holes');


axes(handles.axes1);
M=0.4*BW;
green=cat(3,0*ones(ImageSize0(1),ImageSize0(2)),1*ones(ImageSize0(1),ImageSize0(2)),0*ones(ImageSize0(1),ImageSize0(2)));
h=imshow(green);
set(h,'AlphaData',M);

% axes(handles.axes4);
% imshow(BW);

guidata(hObject, handles);


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)


global filename
global pathname
global num_images
global openfilename
global imageinfo
global IMG_eq
global ImageSize0
global NumberOfSegment
global SegmentIndex
global CC
global ALLIMAGE
global IMG
global BW1
global BW2
global BW
global IMG1
global IMGI
global THRE
global basename

A=[];
B=[];
C=[];
CenterLine=[];
stats=[];
LLF=[];
LL=[];
LLFILL=[];
LLBW=[];
BWW2=[];
BWLOGIC2=[];
ImageSize=[];

axes(handles.axes4);
cla

cla(handles.axes5,'reset');
cla(handles.axes5);

h3=figure(BloodV10);
minI = min(min(IMGI));
maxI = max(max(IMGI));
axes(handles.axes1);

%%%%%%%%%%%%%%%%Original 
% IMGI=padarray(IMGI1,[1,0],255,'both');  %% Add white lines on top and bottom of images.
ImageSize=size(IMGI);
% THRE=graythresh(IMGI1);%%% Determine Threshold Value (before padding).
% 
% BW1 = im2bw(IMGI,THRE);%%% Binarize the image
% imwrite(BW1,'temp1.tif','Compression','none');
% BW3 = imfill(BW1,'holes');%% Fill Holes in the Binary Image
% imwrite(BW3,'temp2.tif','Compression','none');
% se = strel('disk',10);
% BW = imclose(BW3,se);
% % imwrite(BW3,'temp3.tif','Compression','none');
% % BW = imclearborder(BW2,8);
% imwrite(BW,'temp4.tif','Compression','none');
% % % BW=imbinarize(IMG);


BWW=edge(BW, 'canny_old'); %% Detect Edge based on Binarized Blood Vessel
size(BWW)
% BWW=edge(BW, 'Prewitt'); %% Alternative Edge Method 
imwrite(BWW,'temp5.tif','Compression','none');
h_im = imshow(IMGI,[minI maxI]);

M=0.4*BW;
green=cat(3,0*ones(ImageSize0(1),ImageSize0(2)),1*ones(ImageSize0(1),ImageSize0(2)),0*ones(ImageSize0(1),ImageSize0(2)));
h2=imshow(green);
set(h2,'AlphaData',M);


[BW2,xii,yii]= roipoly;  %%% Determine Region 
x00=min(xii);
y00=min(yii);
xwidth=max(xii)-min(xii);
yheight=max(yii)-min(yii);
ROI=[x00 y00 xwidth yheight];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%FOCUS MEASURE FUNCTION HERE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

FocusMeasure=zeros(num_images,4);
for kk=1:4
    
    
for k = 1:num_images
      
    IMGT=ALLIMAGE(:,:,k);
    
        switch kk
            case 1 
            FocusMeasure(k,kk)=fmeasure(IMGT,'VOLA',ROI);   
            case 2
            FocusMeasure(k,kk)=fmeasure(IMGT,'HELM',ROI);
            case 3
            FocusMeasure(k,kk)=fmeasure(IMGT, 'SFIL',ROI);
%             FocusMeasure(k,kk)=fmeasure(IMGT, 'TENG',ROI);
            case 4
            FocusMeasure(k,kk)=fmeasure(IMGT, 'TENV',ROI);
            
        end
               
 end
 FocusMeasureResults=FocusMeasure(:,kk);   
end

FocusMeasureResults=FocusMeasure;
focusfilename=[basename '_focusmeasure.mat'];
savefocusfilename=fullfile(pathname,focusfilename);
save(savefocusfilename,'FocusMeasureResults')


axes(handles.axes1);
hold on
scatter(x00,y00,'O');
scatter(x00,y00+yheight,'O');
scatter(x00+xwidth,y00,'O');
scatter(x00+xwidth,y00+yheight,'O');
scatter(xii,yii,'x');
%%%%%%%%%%%%%%%%%%%%%%%%%%%FOCUS MEAURE END %%%%%%%%%%%%%%%%%%%%%%%%

size(BW2)

BWLOGIC=BWW&BW2;  %%% Identify Overlap Polygon ROI and Edge of Blood Vessel 
% imshow(BWLOGIC)
% imshow(BWW)
imwrite(BWLOGIC,'test2.tif','Compression','none');
stats = regionprops(BWLOGIC,'PixelList');%%% Connected LOGIC becomes an ROI
size(stats)
A=stats(1).PixelList;%%% First ROI supposed to be the left edge 
B=stats(2).PixelList;%%% Second ROI supposed to be the right edge 

LengthA=length(A);
LengthB=length(B);
AAA=A;
BBB=B;

if LengthA<LengthB; %%% A should be longer than B
    A=BBB;
    B=AAA;
    LengthA=length(A);
    LengthB=length(B);
else
end

%% FINDING MIDDLE LINE

for k = 1:LengthA;
    for kk=1:LengthB
    tempDistance(kk)=(B(kk,2)-A(k,2))^2+(B(kk,1)-A(k,1))^2; % try to find closest B(:,2) to A(k,2);
    end
    
    tempDistanceMin=min(tempDistance);

    tempIndex=find(tempDistance==tempDistanceMin);
    tempIndex=tempIndex(1);
    
    CenterLine(k,1)=1/2*(A(k,1)+B(tempIndex,1));
    CenterLine(k,2)=1/2*(A(k,2)+B(tempIndex,2));
    
end

% if get(handles.radiobutton8,'Value')==0;
Ctemp(:,1)=CenterLine(:,1);
Ctemp(:,2)=CenterLine(:,2);

%%%%%%%%%%%   C spline fit vs polyfit 
Csorted=sortrows(Ctemp,2);%%% sort row by colum 2(y value)
Cx=Csorted(:,2);
Cy=Csorted(:,1); %%% xy swap 
Cxmin=min(Cx);
Cxmax=max(Cx);
Cxx=Cxmin:0.5:Cxmax;
% Cyy=interp1(Cx,Cy,Cxx,'cubic');
p=polyfit(Cx,Cy,5);
Cyy=polyval(p,Cxx);

C(:,1)=Cyy;
C(:,2)=Cxx;

%%%%%%%%%%%%%%%
% else
% C(:,1)=CenterLine(:,1);
% C(:,2)=CenterLine(:,2);
% end


axes(handles.axes4);
set(handles.axes4,'Ydir','reverse')
set(handles.axes4,'xtick',[])
set(handles.axes4,'ytick',[])
axis image
imshow(IMG,[minI maxI]);
M=0.4*BW;
green=cat(3,0*ones(ImageSize0(1),ImageSize0(2)),1*ones(ImageSize0(1),ImageSize0(2)),0*ones(ImageSize0(1),ImageSize0(2)));
h4=imshow(green);
set(h4,'AlphaData',M);

hold on

scatter(A(:,1),A(:,2))
hold on
scatter(B(:,1),B(:,2));
hold on
scatter(C(:,1),C(:,2));
hold on

% xlim([0 ImageSize(2)]) 
% ylim([0 ImageSize(1)])

% imshow(IMG,[minI maxI]);
% MM=0*ones(ImageSize(1),ImageSize(2));
% alpha(1);




% % % axes(handles.axes4);
% % % 
% % % axis image
% % % imshow(IMG,[minI maxI]);
% % % hold on
% % % % plot(A(:,1),A(:,2),'X','MarkerSize',4,'Color',[1 0 0])
% % % scatter(A(:,1),A(:,2),'O')
% % % 
% % % hold on
% % % plot(B(:,1),B(:,2),'V','MarkerSize',4,'Color',[0 1 0]);
% % % hold on
% % % plot(C(:,1),C(:,2),'O','MarkerSize',4,'Color',[0 0 1]);
% % % hold on
% % % set(handles.axes4,'Ydir','reverse')
% % % set(handles.axes4,'xtick',[])
% % % set(handles.axes4,'ytick',[])
% % % xlim([1 ImageSize(2)]) 
% % % ylim([1 ImageSize(1)])

BB=B;
AA=A;
CC=C;

LengthCC=length(CC)
LengthBB=length(BB)
LengthAA=length(AA)

%%%%% Define Lines to Draw 

NumberOfSegment=str2num(get(handles.edit14,'String'))+1; %%% Make 1 extra lines and do not use the first line
SegmentInterval=floor((LengthCC-5)/NumberOfSegment)
% ImageSize

for i=1:NumberOfSegment;
segmentindex= 1 + (i-1)*SegmentInterval;
referenceX=mean(CC((segmentindex+3):(segmentindex+5),1))
referenceY=mean(CC((segmentindex+3):(segmentindex+5),2))
[LineSegmentX0(i),LineSegmentY0(i),LineSegmentX1(i),LineSegmentY1(i)]=perpendicularline(ImageSize(2),ImageSize(1),CC(segmentindex,1), CC(segmentindex,2), referenceX, referenceY)
end

axes(handles.axes5);
imshow(IMG,[minI maxI]);
% M5=0.4*BW;
% green=cat(3,0*ones(ImageSize0(1),ImageSize0(2)),1*ones(ImageSize0(1),ImageSize0(2)),1*ones(ImageSize0(1),ImageSize0(2)));
% h5=imshow(green);
% set(h5,'AlphaData',M5);

for iii=2:NumberOfSegment;
 
    
X1=[];
Y1=[];
I=[];
h1=[];
h2=[];
LineProfile=[];
TempWidth=[];
TempLineProfile=[];

h1=figure;
h2=axes;
BACKGROUND=zeros(ImageSize(1),ImageSize(2));
imshow(BACKGROUND);
set(h1,'Visible', 'on'); 

set(h2,'Ydir','reverse');
set(h2,'xtick',[]);
set(h2,'ytick',[]);
set(h2,'color','black');
axis image;
set(h2,'Units','pixels'); 
set(h2,'Position',[0 0 ImageSize(2) ImageSize(1)] ) ;
xlim([0 ImageSize(2)]) ;
ylim([0 ImageSize(1)]);
line([LineSegmentX0(iii),LineSegmentX1(iii)],[LineSegmentY0(iii),LineSegmentY1(iii)],'LineWidth',2,'Color','white');
 
ImageSize
LLF=getframe(h2);

LL=LLF.cdata;
size(LL)

LLFILL0=padarray(LL,[1,0],0,'pre');%%% Unknown Reason There is one pixel off for row (Y direction)

LLFILL=LLFILL0;
LLBW=im2bw(LLFILL);
BWW2=edge(BW2, 'canny_old');

size(LLBW)
size(BW2)
BWLOGIC2=BWW2&LLBW;

imshow(BWLOGIC2);

stats1 = regionprops(BWLOGIC2,'PixelList');
A1=stats1(1).PixelList;
A1(1,:);
B1=stats1(2).PixelList;
B1(1,:);
X1=[A1(1,1) B1(1,1)];
Y1=[A1(1,2) B1(1,2)];
close(h1)

axes(handles.axes5);
% hold on
set(handles.axes5,'Ydir','reverse')
set(handles.axes5,'xtick',[])
set(handles.axes5,'ytick',[])
axis image
xlim([0 ImageSize(2)]) 
ylim([0 ImageSize(1)])
line([X1(1),X1(2)],[Y1(1),Y1(2)],'LineWidth',1,'Color','green');
text(X1(2),Y1(2),num2str(iii-1),'Color','green');
hold on

NumberOfFrameS=get(handles.edit16,'String');
    
NumberOfFrame=str2num(NumberOfFrameS);

for ii=1:NumberOfFrame;

IMGT = ALLIMAGE(:,:,ii);
LineProfile(ii,:)=improfile(IMGT, X1, Y1);

end

I= mat2gray(LineProfile);

h3=figure;
set(h3, 'Visible', 'on')
imshow(I)
TempSegmentNumberS=num2str(iii-1);
TempSaveFilename=[basename '_LineProfile_' TempSegmentNumberS '.tif'];
SaveFileName=fullfile(pathname,TempSaveFilename)
imwrite(I, SaveFileName,'Compression','none','WriteMode','overwrite');

end

fignew = figure('Visible','on'); % Invisible figure

newAxes = copyobj(handles.axes5,fignew); % Copy the appropriate axes
set(newAxes,'Unit','normalized');
colormap gray;
PPP=get(newAxes,'Position') % The original position is copied too, so adjust it.
set(newAxes,'Position',[ 0 0 1 1]); % Make it visible upon loading

TempSaveFilename2=[basename '_LinePosition' '.tif'];
SaveFileName2=fullfile(pathname,TempSaveFilename2)
saveas(fignew,SaveFileName2,'tif');

guidata(hObject, handles);


function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit14 as text
%        str2double(get(hObject,'String')) returns contents of edit14 as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit15 as text
%        str2double(get(hObject,'String')) returns contents of edit15 as a double


% --- Executes during object creation, after setting all properties.
function edit15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit16_Callback(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit16 as text
%        str2double(get(hObject,'String')) returns contents of edit16 as a double


% --- Executes during object creation, after setting all properties.
function edit16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton7.
function radiobutton7_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit17_Callback(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function edit17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton8.
function radiobutton8_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton8


% --- Executes during object creation, after setting all properties.
function text17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in radiobutton9.
function radiobutton9_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton9
