function varargout = cue_time(varargin)
% CUE_TIME MATLAB code for cue_time.fig
%      CUE_TIME, by itself, creates a new CUE_TIME or raises the existing
%      singleton*.
%
%      H = CUE_TIME returns the handle to a new CUE_TIME or the handle to
%      the existing singleton*.
%
%      CUE_TIME('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CUE_TIME.M with the given input arguments.
%
%      CUE_TIME('Property','Value',...) creates a new CUE_TIME or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before cue_time_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to cue_time_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help cue_time

% Last Modified by GUIDE v2.5 22-May-2015 23:07:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @cue_time_OpeningFcn, ...
                   'gui_OutputFcn',  @cue_time_OutputFcn, ...
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


% --- Executes just before cue_time is made visible.
function cue_time_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to cue_time (see VARARGIN)

% Choose default command line output for cue_time
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes cue_time wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = cue_time_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_loadCue.
function pushbutton_loadCue_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_loadCue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isfield(handles,'pathname')
    path = [handles.pathname '*.mat'];
    [filename,pathname,index] = uigetfile(path);
else
    [filename,pathname,index] = uigetfile('*.mat');
end
if index
    str = [pathname filename];
    handles.pathname = pathname;
    handles.cueTime = importdata(str);
    set(handles.edit_cueFile,'string',filename);
else
    set(handles.edit_cueFile,'string','No file yet!');
end
guidata(hObject, handles);

function edit_cueFile_Callback(hObject, eventdata, handles)
% hObject    handle to edit_cueFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_cueFile as text
%        str2double(get(hObject,'String')) returns contents of edit_cueFile as a double


% --- Executes during object creation, after setting all properties.
function edit_cueFile_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_cueFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_loadMovie.
function pushbutton_loadMovie_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_loadMovie (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isfield(handles,'pathname')
    path = [handles.pathname '*.wmv'];
    [filename,pathname,index] = uigetfile(path);
else
    [filename,pathname,index] = uigetfile('*.wmv');
end
if index
    str = [pathname filename];
    handles.pathname = pathname;
    movieD = VideoReader(str);
    handles.movieDuration = movieD.Duration;
    movieTime = dir(str);
    TimeOff = movieTime.date(end-7:end);
    set(handles.edit_movieFile,'string',filename);
    
    hour = str2num(TimeOff(1:2));
    minute = str2num(TimeOff(4:5));
    second = str2num(TimeOff(7:8));
    
    handles.TimeOFF  = hour*3600+minute*60+second;
    
else
    set(handles.edit_movieFile,'string','No file yet!');
end
guidata(hObject, handles);


function edit_movieFile_Callback(hObject, eventdata, handles)
% hObject    handle to edit_movieFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_movieFile as text
%        str2double(get(hObject,'String')) returns contents of edit_movieFile as a double


% --- Executes during object creation, after setting all properties.
function edit_movieFile_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_movieFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CueTime = handles.cueTime(:,4:6);
CueTime = CueTime(:,1)*3600+CueTime(:,2)*60+CueTime(:,3);%cue开始的时间，转换为秒
TimeOFF = handles.TimeOFF;%movie 结束的时间，转换为秒
Duration = handles.movieDuration;  %movie 的长度（s）

 CueOn = round(CueTime+Duration-TimeOFF); %cue在视频中开始的时间（s）

CueMinue = floor(CueOn/60);
CueSec = mod(CueOn,60);
cue = [CueMinue CueSec];
% CueMinue = num2str(CueMinue);
% CueSec = num2str(CueSec);
% CueOnset = [CueMinue,':',CueSec];
% set(handles.edit_CueOnTime,'string',CueOnset);

assignin('base','cue',cue);



function edit_CueOnTime_Callback(hObject, eventdata, handles)
% hObject    handle to edit_CueOnTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_CueOnTime as text
%        str2double(get(hObject,'String')) returns contents of edit_CueOnTime as a double


% --- Executes during object creation, after setting all properties.
function edit_CueOnTime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_CueOnTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
