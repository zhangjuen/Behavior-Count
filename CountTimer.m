function varargout = CountTimer(varargin)
% COUNTTIMER MATLAB code for CountTimer.fig
%      COUNTTIMER, by itself, creates a new COUNTTIMER or raises the existing
%      singleton*.
%
%      H = COUNTTIMER returns the handle to a new COUNTTIMER or the handle to
%      the existing singleton*.
%
%      COUNTTIMER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COUNTTIMER.M with the given input arguments.
%
%      COUNTTIMER('Property','Value',...) creates a new COUNTTIMER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CountTimer_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CountTimer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CountTimer

% Last Modified by GUIDE v2.5 02-Sep-2018 19:53:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CountTimer_OpeningFcn, ...
                   'gui_OutputFcn',  @CountTimer_OutputFcn, ...
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


% --- Executes just before CountTimer is made visible.
function CountTimer_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CountTimer (see VARARGIN)

% Choose default command line output for CountTimer
totalTrial = str2double(get(handles.edit_trialNum,'string'));

setappdata(handles.pushbutton_start,'behaviorTime',ones(100,totalTrial)*-1);

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CountTimer wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CountTimer_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_start.
function pushbutton_start_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str = get(hObject,'string');
if strcmp(str,'Start')
set(hObject,'string','stop','BackgroundColor','r');
setappdata(handles.pushbutton_start,'TrialTic',tic);
setappdata(handles.pushbutton_start,'CountMode',0);
trialNow = str2double(get(handles.text_trialNow,'string'));
behaviorTime = getappdata(handles.pushbutton_start,'behaviorTime');
behaviorTime(:,trialNow) = -1;
setappdata(handles.pushbutton_start,'behaviorTime',behaviorTime);
else%stop mode
    set(hObject,'string','Start','BackgroundColor',[0.94 0.94 0.94]);
end

% --- Executes on button press in pushbutton_count.
function pushbutton_count_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_count (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
startMode = get(handles.pushbutton_start,'string');
if strcmp(startMode,'Start')
    display('Press Start button fist!');
    return;
end
TrialTimeNow = toc(getappdata(handles.pushbutton_start,'TrialTic'));
if getappdata(handles.pushbutton_start,'CountMode')
    set(handles.pushbutton_count,'Backgroundcolor',[0.94 0.94 0.94]);
    setappdata(handles.pushbutton_start,'CountMode',0)
else
    set(handles.pushbutton_count,'Backgroundcolor','b');
    setappdata(handles.pushbutton_start,'CountMode',1);
end


behaviorTime = getappdata(handles.pushbutton_start,'behaviorTime');
trialNow = str2double(get(handles.text_trialNow,'string'));
index = find(behaviorTime(:,trialNow)==-1,1);
behaviorTime(index,trialNow) = TrialTimeNow;
setappdata(handles.pushbutton_start,'behaviorTime',behaviorTime);
guidata(hObject, handles);

% --- Executes on key press with focus on figure1 or any of its controls.
function figure1_WindowKeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
key_input = eventdata.Key;
if length(key_input)>1 %如果不是字母或数字键，（空格，回车，ctrl，shift等），结束这个函数；
    return;
end


if key_input == 'D'||key_input == 'd'
       pushbutton_count_Callback(hObject, eventdata, handles)
else
     return;
end



function edit_trialNum_Callback(hObject, eventdata, handles)
% hObject    handle to edit_trialNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_trialNum as text
%        str2double(get(hObject,'String')) returns contents of edit_trialNum as a double


% --- Executes during object creation, after setting all properties.
function edit_trialNum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_trialNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_trialAdd.
function pushbutton_trialAdd_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_trialAdd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
trialNow = str2double(get(handles.text_trialNow,'string'))+1;
trialNow = min(trialNow,str2double(get(handles.edit_trialNum,'string')));
set(handles.text_trialNow,'string',trialNow);
set(handles.pushbutton_start,'string','Start','BackgroundColor',[0.94 0.94 0.94]);

% --- Executes on button press in pushbutton_trialMinus.
function pushbutton_trialMinus_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_trialMinus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
trialNow = str2double(get(handles.text_trialNow,'string'))-1;
trialNow = max(trialNow,1);
set(handles.text_trialNow,'string',trialNow);
set(handles.pushbutton_start,'string','Start','BackgroundColor',[0.94 0.94 0.94]);

% --- Executes on button press in pushbutton_Reset.
function pushbutton_Reset_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text_trialNow,'string',1);
totalTrial = str2double(get(handles.edit_trialNum,'string'));
setappdata(handles.pushbutton_start,'behaviorTime',ones(100,totalTrial)*-1);
set(handles.pushbutton_start,'string','Start','BackgroundColor',[0.94 0.94 0.94]);


% --- Executes on button press in pushbutton_Analysis.
function pushbutton_Analysis_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
behaviorTime = getappdata(handles.pushbutton_start,'behaviorTime');
Threshold = 1;
TimeMax = 20;
behaviorTime(behaviorTime>20) = 20 ;
behaviorDur = zeros(size(behaviorTime,2),1);
for i = 1:size(behaviorTime,2)
    behaviorNow = behaviorTime(:,i);
    index = find(behaviorNow>-1,1,'last');
    if isempty(index)
        continue;
    end    
    behaviorNow(index+1:end) = [];
    if mod(index,2)==1
        behaviorNow = [behaviorNow;TimeMax];
    end
    Duration = behaviorNow(2:2:end)-behaviorNow(1:2:end-1);
    Duration(Duration<Threshold) = [];
    behaviorDur(i) = sum(Duration);
end
assignin('base','behaviorDur',behaviorDur);
assignin('base','behaviorTime',behaviorTime);
set(handles.pushbutton_start,'string','Start','BackgroundColor',[0.94 0.94 0.94]);
    
