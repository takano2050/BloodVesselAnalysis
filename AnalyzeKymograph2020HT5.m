function varargout = AnalyzeKymograph2020HT5(varargin)
% AnalyzeKymograph2020HT5 MATLAB code for AnalyzeKymograph2020HT5.fig
%      AnalyzeKymograph2020HT5, by itself, creates a new AnalyzeKymograph2020HT5 or raises the existing
%      singleton*.
%
%      H = AnalyzeKymograph2020HT5 returns the handle to a new AnalyzeKymograph2020HT5 or the handle to
%      the existing singleton*.
%
%      AnalyzeKymograph2020HT5('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AnalyzeKymograph2020HT5.M with the given input arguments.
%
%      AnalyzeKymograph2020HT5('Property','Value',...) creates a new AnalyzeKymograph2020HT5 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AnalyzeKymograph2020HT5_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AnalyzeKymograph2020HT5_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AnalyzeKymograph2020HT5

% Last Modified by GUIDE v2.5 01-May-2020 16:45:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AnalyzeKymograph2020HT5_OpeningFcn, ...
                   'gui_OutputFcn',  @AnalyzeKymograph2020HT5_OutputFcn, ...
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


% --- Executes just before AnalyzeKymograph2020HT5 is made visible.
function AnalyzeKymograph2020HT5_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AnalyzeKymograph2020HT5 (see VARARGIN)

% Choose default command line output for AnalyzeKymograph2020HT5
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes AnalyzeKymograph2020HT5 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = AnalyzeKymograph2020HT5_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

guidata(hObject, handles);
% 








% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% --- Executes on button press in pushbutton1.
clear ALL
global IMG
global filename
global pathname
global ALLIMAGE
global num_images
global openfilename
global imageinfo
global ImageSize
global basename
global basename1  %% BASENAME TO DEFINE FOCUSMEASURE FILENAME
global BINNALLIMAGE

clear STATS
BINNALLIMAGE=[];
IMG=[];
ALLIMAGE=[];

set(handles.popupmenu4,'Value',3);
defaultdirectory=pwd;

[filename,pathname]=uigetfile('*.tif');
addpath pathname;
cd(pathname);

openfilename = fullfile(pathname,filename);
basename = strrep(filename,'.tif','');


linenumber=str2num(basename(end));
switch linenumber
    case 1
    basename1 = strrep(filename,'_LineProfile_1.tif','');
    case 2
    basename1 = strrep(filename,'_LineProfile_2.tif','');
    case 3
    basename1 = strrep(filename,'_LineProfile_3.tif','');
    case 4
    basename1 = strrep(filename,'_LineProfile_4.tif','');
    case 5
    basename1 = strrep(filename,'_LineProfile_5.tif','');
end

basename1;
set(handles.text2,'String',basename);


aaa = filename;

% set(handles.edit1,'String',aaa);

x = strrep(aaa,'.tif','');


z1_ = [x '_modified' '.tif'];
z1 = fullfile(pathname,z1_);

imageinfo = imfinfo(openfilename);
num_images = numel(imageinfo);

temp_num_images=num_images;
    
A = imread(openfilename, 1,'Info', imageinfo); 
ImageSize=size(A);

ALLIMAGE = zeros(ImageSize(1),ImageSize(2),temp_num_images);

for k = 1:temp_num_images
    ALLIMAGE(:,:,k) = imread(openfilename, k,'Info', imageinfo);
end

size(ALLIMAGE)


IMG = ALLIMAGE(:,:,1);
   
axes(handles.axes1);
minI = min(min(IMG));
maxI = max(max(IMG));
imshow(IMG,[minI maxI]);
imsize=size(IMG);

guidata(hObject, handles);



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



% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)

global IMG
global pathname
global BW2
global THRE
global Width
global stimframe;
global framespeed;
global BaselineN;
global startingframe%%  3 seconds before the stimulation 
global basename1  %% BASENAME TO DEFINE FOCUSMEASURE FILENAME
global IntensityPlot
global IntensityPlotOUT
global EndingTimeAdjusted

axes(handles.axes9);
cla

axes(handles.axes1);
minI = min(min(IMG));
maxI = max(max(IMG));
class(IMG);

imshow(IMG,[minI maxI]);

IMGI1=uint8(IMG);

HH=fspecial('gaussian',[3 3],3);
IMGI2=imfilter(IMGI1,HH);

vm=str2num(get(handles.edit21,'String'));
hm=str2num(get(handles.edit22,'String'));
IMGI=medfilt2(IMGI2,[vm hm]);

axes(handles.axes2);
minII = min(min(IMGI));
maxII = max(max(IMGI));
imshow(IMGI,[minII maxII]);

thresholdmethod=get(handles.popupmenu5,'Value');

switch thresholdmethod 
    
    case 1

        THRE=graythresh(IMGI);
        BW1 = im2bw(IMGI,THRE);
        thresholdvalue=THRE*256;
                [IMGhisto x]=imhist(IMGI);
        axes(handles.axes10);
        hold off
        imhist(IMGI);
        Ymax=max(IMGhisto);
        hold on
        XX=[thresholdvalue thresholdvalue];
        YY=[0 Ymax];
        plot(XX, YY, 'Color',[1 0 0 ]);
        hold on

    case 2 

        axes(handles.axes10);
        [IMGhisto x]=imhist(IMGI);
        plot(x,IMGhisto);
        %%%% HERE IS THE CURVEFIT, USING MYFIT.M FILE %%%%%%%%%%%%%
        A1=max(IMGhisto);
        TempHistoArray=IMGhisto(50:150);
        A2=max(TempHistoArray);
        A2positionarray=find(TempHistoArray==A2);
        A2position=50+A2positionarray(1);
        Starting = [A1  5.0  3.0 A2  A2position  10.0];
        options = optimset('Display','iter');
        % options = optimset('PlotFcns',@optimplotfval);
        Estimates=fminsearch(@myfittwogaussian,Starting,options,x,IMGhisto);
        %%%%%%%%defalut: @myfit, 
        Estimates;
        Ymax=max(IMGhisto);
        hold off
        plot(x, IMGhisto,'Color',[0 0 1]);
        axis([0 255 0 Ymax]);
        hold on
        FitCurve = Estimates(1).*exp(-0.5*((x-Estimates(2))/Estimates(3)).^2)+Estimates(4).*exp(-0.5*((x-Estimates(5))/Estimates(6)).^2);
        plot(x, FitCurve,'Color',[1 0 0]);
        hold on
        
        if Estimates(2)<Estimates(5);
            THRESHOLD=1/2*(Estimates(2)+Estimates(3)+Estimates(5)-Estimates(6));
            if THRESHOLD < Estimates(2);
                THRESHOLD=1/2*(Estimates(2)+Estimates(5));
            else
            end
            
        else
            THRESHOLD=1/2*(Estimates(5)+Estimates(6)+Estimates(2)-Estimates(3));
            
            if THRESHOLD < Estimates(5);
                THRESHOLD=1/2*(Estimates(2)+Estimates(5));
            else
            end
            
        end
        
        THRE=THRESHOLD/255;
        BW1=im2bw(IMGI,THRE);
        XX=[THRESHOLD THRESHOLD];
        YY=[0 max(IMGhisto)];
        plot(XX, YY, 'Color',[1 0 0 ]);
        thresholdvalue=THRESHOLD;
                [IMGhisto x]=imhist(IMGI);
        axes(handles.axes10);
        hold off
        imhist(IMGI);
        Ymax=max(IMGhisto);
        hold on
        XX=[thresholdvalue thresholdvalue];
        YY=[0 Ymax];
        plot(XX, YY, 'Color',[1 0 0 ]);
        hold on
        
    
        
    case 3
        axes(handles.axes10);
        hold off
        [IMGhisto x]=imhist(IMGI);
        imhist(IMGI);
        h = impoint;
        pso = getPosition(h);
        x0 = pso(1);
        % y0 = pso(2);
        THRESHOLD = x0;
        THRE=THRESHOLD/255;
        BW1=im2bw(IMGI,THRE);
        XX=[THRESHOLD THRESHOLD];
        YY=[0 max(IMGhisto)];
        plot(XX, YY, 'Color',[1 0 0 ]);
        thresholdvalue=THRESHOLD;
                [IMGhisto x]=imhist(IMGI);
        axes(handles.axes10);
        hold off
        imhist(IMGI);
        Ymax=max(IMGhisto);
        hold on
        XX=[thresholdvalue thresholdvalue];
        YY=[0 Ymax];
        plot(XX, YY, 'Color',[1 0 0 ]);
        hold on
    
            
    case 4 
        [Ahisto x]=imhist(IMGI);
        [THRE]=triangle_th(Ahisto,256);
        BW1 = im2bw(IMGI,THRE);
        thresholdvalue=THRE*256;
                [IMGhisto x]=imhist(IMGI);
        axes(handles.axes10);
        hold off
        imhist(IMGI);
        Ymax=max(IMGhisto);
        hold on
        XX=[thresholdvalue thresholdvalue];
        YY=[0 Ymax];
        plot(XX, YY, 'Color',[1 0 0 ]);
        hold on
    case 5 
        THRE=graythresh(IMGI);
        BW11 = im2bw(IMGI,THRE);
%         se = strel('disk',8);
%         se = strel('line',4,90);
        se = strel('rectangle',[8 2])
        BW1 = imclose(BW11,se);
        thresholdvalue=THRE*256;
        [IMGhisto x]=imhist(IMGI);
        axes(handles.axes10);
        hold off
        imhist(IMGI);
        Ymax=max(IMGhisto);
        hold on
        XX=[thresholdvalue thresholdvalue];
        YY=[0 Ymax];
        plot(XX, YY, 'Color',[1 0 0 ]);
        hold on

end


BW2=bwareaopen(BW1,5000);  %%% REMOVE SMALL OBJECTS LESS THAN 1000 pixels 
BW = imfill(BW2,'holes');
        

axes(handles.axes4);
imshow(BW);

imwrite(BW,'testhaji.tif','Compression','none');

LN=length(BW);
Width=zeros(1,LN);
IntensityPlot=zeros(1,LN);

for n=1:LN;
Temp1=BW(n,:);
Temp2=diff(Temp1);
Index1=find(Temp2>0);
Index2=find(Temp2<0);
Index1TF=isempty(Index1);
Index2TF=isempty(Index2);
if Index1TF==1 || Index2TF==1
    Width(n)=NaN;
    IntensityPlot(n)=NaN;
else

    Width(n)=abs(Index2(end)-Index1(1));
    
%%% Intensity of BV per line May2020 
    miniarraystart=Index1(1);
    miniarrayend=Index2(end);
    if miniarrayend>miniarraystart;
    miniarray=IMGI(n,miniarraystart:miniarrayend);
    IntensityPlot(n)=mean(miniarray);
    else
        IntensityPlot(n)=NaN;
    end
    
end
end


%%% Find a frame of stimulation minus 3 seconds , endtime 

stimframe=str2num(get(handles.edit19,'String'));
framespeed=1/str2num(get(handles.edit20,'String'))

%%% added Haji May 2020%%%%%%%%%%%%%
endingtime=floor((LN-stimframe)*framespeed)-2;  %%% 60seconds  or until the data length allows )with 2 sec rooms 
%%%%%%%%%%%%%%%%%%%%%

pointframes=zeros(3,endingtime+4); %%%% timingarraylength (by Felix) 

checkvalue=stimframe-3/framespeed;
if checkvalue < 0.5;
    startingframe=1;
else
startingframe=round(stimframe-3/framespeed);%%  3 seconds before the stimulation 
stimframe;
end

%%%% Modified by HAJI 2020_April_1st %%% Felix's timing array 

for j=1:3;
    pointframes(j,1)=startingframe;
    for i=1:3;
        pointframes(j,i+1)=round(startingframe+(i+0.5*j-1.5)/framespeed);    %%%% -3 to -2, -2 to -1, -1 to 0  
    end
end

for j=1:3;
    for i=1:endingtime;
        pointframes(j,i+4)=round(stimframe+(i+0.5*j-1)/framespeed);  %%%% 0.5 to 1.5, 1.5 to 2, etc.... 
    end
end


%%%%%%%%%%%%%%%%   INTENSITY CHECK %%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%% OPEN FOCUS MEASURE FILE %%%%%%%%%%%%%%%%% 

focusmeasurefilename = [basename1 '_focusmeasure.mat'];
openfocusmeasurefilename=fullfile(pathname,focusmeasurefilename);
A=open(openfocusmeasurefilename);
B=A.FocusMeasureResults;
size(B)

focusmethod=get(handles.popupmenu4,'Value');

switch focusmethod

    case 1 
    IntensityChange=B(:,1);
    BaseLineIntensity=B(startingframe:stimframe,1);
    
    case 2
    IntensityChange=B(:,2);
    BaseLineIntensity=B(startingframe:stimframe,2);

    case 3
    IntensityChange=B(:,3);
    BaseLineIntensity=B(startingframe:stimframe,3);

    case 4
    IntensityChange=B(:,4);
    BaseLineIntensity=B(startingframe:stimframe,4);

    case 5
    IntensityChange=mean(IMG');
    BaseLineIntensity=mean(IMG(startingframe:stimframe,:)');
end


Nstdev=str2num(get(handles.edit24,'String'));

CutOFF=(IntensityChange<(mean(BaseLineIntensity)+Nstdev*std(BaseLineIntensity)))&(IntensityChange>(mean(BaseLineIntensity)-Nstdev*std(BaseLineIntensity)));

WLength=length(Width);
Wwidth=Width;
for nnn=1:WLength;
    if CutOFF(nnn)==0;
        Wwidth(nnn)=NaN;
    else
    end
end

Wwidth;


axes(handles.axes5);
hold off
plot(IntensityChange,'Color',[1 0 0]);
yymax=max(IntensityChange);
yymin=min(IntensityChange);
yyposition=0.9*(yymax-yymin)+yymin;
text(50,yyposition,'Focus Measure');


hold on

xx=[1 LN];
yy1=[mean(BaseLineIntensity)+Nstdev*std(BaseLineIntensity) mean(BaseLineIntensity)+Nstdev*std(BaseLineIntensity)];
yy2=[mean(BaseLineIntensity)-Nstdev*std(BaseLineIntensity) mean(BaseLineIntensity)-Nstdev*std(BaseLineIntensity)];
plot(xx,yy1)
hold on
plot(xx,yy2);
hold on
xlim([1 LN]);
% plot(Wwidth,'Color',[0 1 0]);


axes(handles.axes6);
plot(Wwidth,'Color','Magenta');
yymax2=max(Wwidth);
yymin2=min(Wwidth);
yyposition2=0.9*(yymax2-yymin2)+yymin2;
text(50,yyposition2,'Width (pixels)');
xlim([1 LN]);

BaselineN=nanmean(Wwidth(startingframe:stimframe));

global WWidth;
WWidth = zeros(1,endingtime+4);
IntensityPlotOUT=zeros(1,endingtime+4);
WWidth(1)=BaselineN;
IntensityPlotOUT(1)=IntensityPlot(1);

for k=2:endingtime+4;
    WWidth(k)=nanmean(Wwidth(pointframes(1,k):pointframes(3,k)));
    IntensityPlotOUT(k)=nanmean(IntensityPlot((pointframes(1,k):pointframes(3,k))));
end


WWidthLength=length(WWidth)
EndingTimeAdjusted=WWidthLength-4
axes(handles.axes8);
% plotXX=[0 3 10 30 50];
% plotYY=[BaselineN WWidth3N WWidth10N WWidth30N WWidth50N];
hold off
% scatter(plotXX,plotYY);
timeaxis=[-3:1:EndingTimeAdjusted];
plot(timeaxis,WWidth);
ymax=max(WWidth);
ymin=min(WWidth);
textposition=0.9*(ymax-ymin)+ymin;
text(0,textposition,'Width (pixles)');
xlim ([-3 EndingTimeAdjusted+1]);


axes(handles.axes11);
hold off

WWidthN=WWidth;
WWidthL=length(WWidth);
for kk=1:WWidthL
WWidthN(kk)=(WWidth(kk)-WWidth(1))/WWidth(1);
end
plot(timeaxis,WWidthN);

ymaxN=max(WWidthN);
yminN=min(WWidthN);
textpositionN=0.9*(0.2+ymaxN-yminN)+yminN-0.1;
text(0,textpositionN,'Normalized Change (0.1=10%)');
hold on
xlim ([-3 EndingTimeAdjusted+1]);
ylim ([yminN-0.1 ymaxN+0.1]);

axes(handles.axes9);
plot(IntensityPlot);
xlim ([0 LN]);

guidata(hObject, handles);



% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% global IMG
global filename
global pathname
global stimframe;
global framespeed;
global WWidth
global IntensityPlot
global IntensityPlotOUT
global EndingTimeAdjusted



thresholdmethod=get(handles.popupmenu5,'Value');

TempSavingArray2={pathname filename stimframe 1/framespeed thresholdmethod};
TempSavingArray3={pathname filename stimframe 1/framespeed thresholdmethod};
TempSavingArray4={pathname filename stimframe 1/framespeed thresholdmethod};



for i=1:EndingTimeAdjusted+4;
    TempSavingArray2{i+5}=WWidth(i);
    TempSavingArray3{i+5}=(WWidth(i)-WWidth(1))/WWidth(1);
    TempSavingArray4{i+5}=IntensityPlotOUT(i);
end

%%%% Add Max Info
[wmax,tm]=max(WWidth);
Wmax=(wmax-WWidth(1))/WWidth(1);
WmaxT=tm-4;
TempSavingArray5={pathname filename stimframe 1/framespeed thresholdmethod Wmax WmaxT};
%%%%%


savefilename1=get(handles.edit23,'String');
% savefullfilename=fullfile(pathname,savefilename1)
savefilename2=['120points_' savefilename1];
savefilename3=['120pointsNormalized_' savefilename1];
savefilename4=['120pointsIntensity_' savefilename1];
savefilename5=['120pointsMAX_' savefilename1];

savefullfilename=fullfile(savefilename1);
savefullfilename2=fullfile(savefilename2);
savefullfilename3=fullfile(savefilename3);
savefullfilename4=fullfile(savefilename4);
savefullfilename5=fullfile(savefilename5);




if ~isempty(savefullfilename2)
xlswrite(savefullfilename2,TempSavingArray2,'Sheet1');
else
end



[success,message]=xlsappend(savefullfilename2,TempSavingArray2);
if success==1;
set(handles.text18,'String','saved');
else
set(handles.text18,'String','error');
end


if ~isempty(savefullfilename3)
xlswrite(savefullfilename3,TempSavingArray3,'Sheet1');
else
end

[success,message]=xlsappend(savefullfilename3,TempSavingArray3);
if success==1;
set(handles.text18,'String','saved');
else
set(handles.text18,'String','error');
end


if ~isempty(savefullfilename4)
xlswrite(savefullfilename4,TempSavingArray4,'Sheet1');
else
end

[success,message]=xlsappend(savefullfilename4,TempSavingArray4);
if success==1;
set(handles.text18,'String','saved');
else
set(handles.text18,'String','error');
end


if ~isempty(savefullfilename5)
xlswrite(savefullfilename5,TempSavingArray5,'Sheet1');
else
end


[success,message]=xlsappend(savefullfilename5,TempSavingArray5);
if success==1;
set(handles.text18,'String','saved');
else
set(handles.text18,'String','error');
end


guidata(hObject, handles);


function edit19_Callback(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit19 as text
%        str2double(get(hObject,'String')) returns contents of edit19 as a double


% --- Executes during object creation, after setting all properties.
function edit19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit20_Callback(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit20 as text
%        str2double(get(hObject,'String')) returns contents of edit20 as a double


% --- Executes during object creation, after setting all properties.
function edit20_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit21_Callback(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit21 as text
%        str2double(get(hObject,'String')) returns contents of edit21 as a double


% --- Executes during object creation, after setting all properties.
function edit21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit22_Callback(hObject, eventdata, handles)
% hObject    handle to edit22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit22 as text
%        str2double(get(hObject,'String')) returns contents of edit22 as a double


% --- Executes during object creation, after setting all properties.
function edit22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit23_Callback(hObject, eventdata, handles)
% hObject    handle to edit23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit23 as text
%        str2double(get(hObject,'String')) returns contents of edit23 as a double


% --- Executes during object creation, after setting all properties.
function edit23_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit23 (see GCBO)
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



function edit24_Callback(hObject, eventdata, handles)
% hObject    handle to edit24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit24 as text
%        str2double(get(hObject,'String')) returns contents of edit24 as a double


% --- Executes during object creation, after setting all properties.
function edit24_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4


% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton10.
function radiobutton10_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton10


% --- Executes on selection change in popupmenu5.
function popupmenu5_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu5


% --- Executes during object creation, after setting all properties.
function popupmenu5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function axes8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes8


% --- Executes during object creation, after setting all properties.
function text2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function text20_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
