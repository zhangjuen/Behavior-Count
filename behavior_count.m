function varargout = behavior_count(varargin)
% BEHAVIOR_COUNT M-file for behavior_count.fig
%      BEHAVIOR_COUNT, by itself, creates a new BEHAVIOR_COUNT or raises the existing
%      singleton*.
%
%      H = BEHAVIOR_COUNT returns the handle to a new BEHAVIOR_COUNT or the handle to
%      the existing singleton*.
%
%      BEHAVIOR_COUNT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BEHAVIOR_COUNT.M with the given input arguments.
%
%      BEHAVIOR_COUNT('Property','Value',...) creates a new BEHAVIOR_COUNT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before behavior_count_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to behavior_count_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help behavior_count

% Last Modified by GUIDE v2.5 12-May-2015 11:30:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @behavior_count_OpeningFcn, ...
                   'gui_OutputFcn',  @behavior_count_OutputFcn, ...
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


% --- Executes just before behavior_count is made visible.
function behavior_count_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to behavior_count (see VARARGIN)

% Choose default command line output for behavior_count
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes behavior_count wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = behavior_count_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbuttonEating.
function pushbuttonEating_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonEating (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Start = length(get(handles.pushbuttonStart,'Visible'));%判断Start是否按下，按下为off，3，没按为on,2.
if Start == 2
    display('Press Start button fist!');
    return;
end

EatingTime = get(handles.editEatingTime,'string');
EatingTime = str2num(EatingTime);
EatingNum = get(handles.editEatingNum,'string');
EatingNum = str2num(EatingNum);


tocA = 0; tocB = 0;  TimePlot = [0 0];
E_color = get(handles.pushbuttonEating,'BackgroundColor');
if E_color == [1 1 0]  
    tocA = toc;
    if tocA > handles.MovieDuration    %判断是否超出movie长度
        return;
    end
    set(handles.pushbuttonEating,'BackgroundColor',[1 0 0 ]);
    handles.tocA = tocA;
    TimePlot = [tocA 1];
    handles.Eating = [handles.Eating;TimePlot];
   
elseif E_color == [1 0 0 ]
    tocB = toc;
    if tocB > handles.MovieDuration      %判断是否超出movie长度
        tocB = handles.MovieDuration;      
    end
    set(handles.pushbuttonEating,'BackgroundColor',[1 1 0 ]);
    EatingNum = EatingNum +1;
    EatingTime = EatingTime + tocB - handles.tocA;
    set(handles.editEatingTime,'string',num2str(EatingTime));
    set(handles.editEatingNum,'string',num2str(EatingNum));
    TimePlot = [tocB 0];
    handles.Eating = [handles.Eating;TimePlot];
    
end

%set(handles.axesEating,'UserData',stairs(handles.Eating(:,1),handles.Eating(:,2)));

stairs(handles.axesEating,handles.Eating(:,1),handles.Eating(:,2));
set(handles.axesEating,'YLim',[0 2]);
set(handles.axesEating,'xLim',[0 handles.MovieDuration]);
hold on;
guidata(hObject, handles);


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pushbuttonEating.
function pushbuttonEating_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to pushbuttonEating (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbuttonDrinking.
function pushbuttonDrinking_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonDrinking (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Start = length(get(handles.pushbuttonStart,'Visible'));%判断Start是否按下，按下为off，3，没按为on,2.
if Start == 2
    display('Press Start button fist!');
    return;
end
DrinkingTime = get(handles.editDrinkingTime,'string');
DrinkingTime = str2num(DrinkingTime);
DrinkingNum = str2num(get(handles.editDrinkingNum,'string'));


tocA = 0; tocB = 0;  TimePlot = [0 0];
E_color = get(handles.pushbuttonDrinking,'BackgroundColor');
if E_color == [1 1 0]
    tocA = toc;
        if tocA > handles.MovieDuration
        return;
    end
    set(handles.pushbuttonDrinking,'BackgroundColor',[1 0 0 ]);
    handles.tocA = tocA;
    TimePlot = [tocA 1];
    handles.Drinking = [handles.Drinking;TimePlot];
   
elseif E_color == [1 0 0 ]
    tocB = toc;
        if tocB > handles.MovieDuration
        tocB = handles.MovieDuration;          
    end
    set(handles.pushbuttonDrinking,'BackgroundColor',[1 1 0 ]);
    DrinkingNum = DrinkingNum +1;
    DrinkingTime = DrinkingTime + tocB - handles.tocA;
    set(handles.editDrinkingTime,'string',num2str(DrinkingTime));
    set(handles.editDrinkingNum,'string',num2str(DrinkingNum));
    TimePlot = [tocB 0];
    handles.Drinking = [handles.Drinking;TimePlot];
    
end

stairs(handles.axesDrinking,handles.Drinking(:,1),handles.Drinking(:,2));
set(handles.axesDrinking,'YLim',[0 2]);
set(handles.axesDrinking,'xLim',[0 handles.MovieDuration]);
hold on;
guidata(hObject, handles);







% --- Executes on key press with focus on figure1 and none of its controls.
function figure1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)




function editEatingTime_Callback(hObject, eventdata, handles)
% hObject    handle to editEatingTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editEatingTime as text
%        str2double(get(hObject,'String')) returns contents of editEatingTime as a double


% --- Executes during object creation, after setting all properties.
function editEatingTime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editEatingTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editEatingNum_Callback(hObject, eventdata, handles)
% hObject    handle to editEatingNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editEatingNum as text
%        str2double(get(hObject,'String')) returns contents of editEatingNum as a double


% --- Executes during object creation, after setting all properties.
function editEatingNum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editEatingNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonStart.
function pushbuttonStart_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tic;
clc; 
set(handles.pushbuttonStop,'Visible','on');
set(handles.pushbuttonStart,'Visible','off');
%所有变量归0，清空。
set(handles.editEatingTime,'string','0');
set(handles.editEatingNum,'string','0');
cla(handles.axesEating);
handles.Eating = [0 0];
set(handles.pushbuttonEating,'BackgroundColor',[1 1 0 ]);

set(handles.editDrinkingTime,'string','0');
set(handles.editDrinkingNum,'string','0');
cla(handles.axesDrinking);
handles.Drinking = [0 0];
set(handles.pushbuttonDrinking,'BackgroundColor',[1 1 0 ]);

set(handles.editDiggingTime,'string','0');
set(handles.editDiggingNum,'string','0');
cla(handles.axesDigging);
handles.Digging = [0 0];
set(handles.pushbuttonDigging,'BackgroundColor',[1 1 0 ]);

set(handles.editWalkingTime,'string','0');
set(handles.editWalkingNum,'string','0');
cla(handles.axesWalking);
handles.Walking = [0 0];
set(handles.pushbuttonWalking,'BackgroundColor',[1 1 0 ]);

set(handles.editJumpingTime,'string','0');
set(handles.editJumpingNum,'string','0');
cla(handles.axesJumping);
handles.Jumping = [0 0];
set(handles.pushbuttonJumping,'BackgroundColor',[1 1 0 ]);

set(handles.editRearingTime,'string','0');
set(handles.editRearingNum,'string','0');
cla(handles.axesRearing);
handles.Rearing = [0 0];
set(handles.pushbuttonRearing,'BackgroundColor',[1 1 0 ]);

% handles.MovieDuration = str2num(get(handles.editMovieDuration,'string')) * 60;
handles.MovieDuration = str2num(get(handles.editMovieDuration,'string'));
handles.tocA = 0;

guidata(hObject, handles);





function editDrinkingTime_Callback(hObject, eventdata, handles)
% hObject    handle to editDrinkingTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editDrinkingTime as text
%        str2double(get(hObject,'String')) returns contents of editDrinkingTime as a double


% --- Executes during object creation, after setting all properties.
function editDrinkingTime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editDrinkingTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editDrinkingNum_Callback(hObject, eventdata, handles)
% hObject    handle to editDrinkingNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editDrinkingNum as text
%        str2double(get(hObject,'String')) returns contents of editDrinkingNum as a double


% --- Executes during object creation, after setting all properties.
function editDrinkingNum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editDrinkingNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonStop.
function pushbuttonStop_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonStop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbuttonStart,'Visible','on');
set(handles.pushbuttonStop,'Visible','off');

AnalysisData.Eating = handles.Eating;
AnalysisData.Drinking = handles.Drinking;
AnalysisData.Digging = handles.Digging;
AnalysisData.Walking = handles.Walking;
AnalysisData.Jumping = handles.Jumping;
AnalysisData.Rearing = handles.Rearing;

EatingTime = str2num(get(handles.editEatingTime,'string'));
EatingNum = str2num(get(handles.editEatingNum,'string'));
AnalysisData.TimeNum = [EatingTime EatingNum];

DrinkingTime = str2num(get(handles.editDrinkingTime,'string'));
DrinkingNum = str2num(get(handles.editDrinkingNum,'string'));
TimeNum = [DrinkingTime DrinkingNum];
AnalysisData.TimeNum = [AnalysisData.TimeNum;TimeNum];

DiggingTime = str2num(get(handles.editDiggingTime,'string'));
DiggingNum = str2num(get(handles.editDiggingNum,'string'));
TimeNum = [DiggingTime DiggingNum];
AnalysisData.TimeNum = [AnalysisData.TimeNum;TimeNum];

WalkingTime = str2num(get(handles.editWalkingTime,'string'));
WalkingNum = str2num(get(handles.editWalkingNum,'string'));
TimeNum = [WalkingTime WalkingNum];
AnalysisData.TimeNum = [AnalysisData.TimeNum;TimeNum];

JumpingTime = str2num(get(handles.editJumpingTime,'string'));
JumpingNum = str2num(get(handles.editJumpingNum,'string'));
TimeNum = [JumpingTime JumpingNum];
AnalysisData.TimeNum = [AnalysisData.TimeNum;TimeNum];

RearingTime = str2num(get(handles.editRearingTime,'string'));
RearingNum = str2num(get(handles.editRearingNum,'string'));
TimeNum = [RearingTime RearingNum];
AnalysisData.TimeNum = [AnalysisData.TimeNum;TimeNum];
handles.AnalysisData = AnalysisData;

% [filename filepath index] = uiputfile('*.mat');
% if index
%     str = [filepath filename];
%     save(str,'AnalysisData');
% else
%     save AnalysisData AnalysisData;
% end
guidata(hObject, handles);
% clear all;



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


% --- Executes on button press in pushbuttonDigging.
function pushbuttonDigging_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonDigging (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Start = length(get(handles.pushbuttonStart,'Visible'));%判断Start是否按下，按下为off，3，没按为on,2.
if Start == 2
    display('Press Start button fist!');
    return;
end
DiggingTime = get(handles.editDiggingTime,'string');
DiggingTime = str2num(DiggingTime);
DiggingNum = get(handles.editDiggingNum,'string');
DiggingNum = str2num(DiggingNum);

tocA = 0; tocB = 0;  TimePlot = [0 0];
E_color = get(handles.pushbuttonDigging,'BackgroundColor');
if E_color == [1 1 0]
    tocA = toc;
    if tocA > handles.MovieDuration
        return;
    end
    
    set(handles.pushbuttonDigging,'BackgroundColor',[1 0 0 ]);
    handles.tocA = tocA;
    TimePlot = [tocA 1];
    handles.Digging = [handles.Digging;TimePlot];
   
elseif E_color == [1 0 0 ]
    tocB = toc;
    if tocB > handles.MovieDuration
        tocB = handles.MovieDuration;          
    end
    set(handles.pushbuttonDigging,'BackgroundColor',[1 1 0 ]);
    DiggingNum = DiggingNum +1;
    DiggingTime = DiggingTime + tocB - handles.tocA;
    set(handles.editDiggingTime,'string',num2str(DiggingTime));
    set(handles.editDiggingNum,'string',num2str(DiggingNum));
    TimePlot = [tocB 0];
    handles.Digging = [handles.Digging;TimePlot];
    
end
stairs(handles.axesDigging,handles.Digging(:,1),handles.Digging(:,2));
set(handles.axesDigging,'YLim',[0 2]);
set(handles.axesDigging,'xLim',[0 handles.MovieDuration]);
hold on;
guidata(hObject, handles);




function editDiggingTime_Callback(hObject, eventdata, handles)
% hObject    handle to editDiggingTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editDiggingTime as text
%        str2double(get(hObject,'String')) returns contents of editDiggingTime as a double


% --- Executes during object creation, after setting all properties.
function editDiggingTime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editDiggingTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editDiggingNum_Callback(hObject, eventdata, handles)
% hObject    handle to editDiggingNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editDiggingNum as text
%        str2double(get(hObject,'String')) returns contents of editDiggingNum as a double


% --- Executes during object creation, after setting all properties.
function editDiggingNum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editDiggingNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonWalking.
function pushbuttonWalking_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonWalking (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Start = length(get(handles.pushbuttonStart,'Visible'));%判断Start是否按下，按下为off，3，没按为on,2.
if Start == 2
    display('Press Start button fist!');
    return;
end
WalkingTime = get(handles.editWalkingTime,'string');
WalkingTime = str2num(WalkingTime);
WalkingNum = get(handles.editWalkingNum,'string');
WalkingNum = str2num(WalkingNum);

tocA = 0; tocB = 0;  TimePlot = [0 0];
E_color = get(handles.pushbuttonWalking,'BackgroundColor');
if E_color == [1 1 0]
    tocA = toc;
        if tocA > handles.MovieDuration
        return;
    end
    set(handles.pushbuttonWalking,'BackgroundColor',[1 0 0 ]);
    handles.tocA = tocA;
    TimePlot = [tocA 1];
    handles.Walking = [handles.Walking;TimePlot];
   
elseif E_color == [1 0 0 ]
    tocB = toc;
       if tocB > handles.MovieDuration
        tocB = handles.MovieDuration;          
    end
    set(handles.pushbuttonWalking,'BackgroundColor',[1 1 0 ]);
    WalkingNum = WalkingNum +1;
    WalkingTime = WalkingTime + tocB - handles.tocA;
    set(handles.editWalkingTime,'string',num2str(WalkingTime));
    set(handles.editWalkingNum,'string',num2str(WalkingNum));
    TimePlot = [tocB 0];
    handles.Walking = [handles.Walking;TimePlot];
    
end
stairs(handles.axesWalking,handles.Walking(:,1),handles.Walking(:,2));
set(handles.axesWalking,'YLim',[0 2]);
set(handles.axesWalking,'xLim',[0 handles.MovieDuration]);
hold on;
guidata(hObject, handles);



function editWalkingTime_Callback(hObject, eventdata, handles)
% hObject    handle to editWalkingTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editWalkingTime as text
%        str2double(get(hObject,'String')) returns contents of editWalkingTime as a double


% --- Executes during object creation, after setting all properties.
function editWalkingTime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editWalkingTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editWalkingNum_Callback(hObject, eventdata, handles)
% hObject    handle to editWalkingNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editWalkingNum as text
%        str2double(get(hObject,'String')) returns contents of editWalkingNum as a double


% --- Executes during object creation, after setting all properties.
function editWalkingNum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editWalkingNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonJumping.
function pushbuttonJumping_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonJumping (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Start = length(get(handles.pushbuttonStart,'Visible'));%判断Start是否按下，按下为off，3，没按为on,2.
if Start == 2
    display('Press Start button fist!');
    return;
end
JumpingTime = get(handles.editJumpingTime,'string');
JumpingTime = str2num(JumpingTime);
JumpingNum = get(handles.editJumpingNum,'string');
JumpingNum = str2num(JumpingNum);

tocA = 0; tocB = 0;  TimePlot = [0 0];
E_color = get(handles.pushbuttonJumping,'BackgroundColor');
if E_color == [1 1 0]
    tocA = toc;
        if tocA > handles.MovieDuration
        return;
    end
    
    set(handles.pushbuttonJumping,'BackgroundColor',[1 0 0 ]);
    handles.tocA = tocA;
    TimePlot = [tocA 1];
    handles.Jumping = [handles.Jumping;TimePlot];
   
elseif E_color == [1 0 0 ]
    tocB = toc;
    if tocB > handles.MovieDuration
        tocB = handles.MovieDuration;          
    end
    set(handles.pushbuttonJumping,'BackgroundColor',[1 1 0 ]);
    JumpingNum = JumpingNum +1;
    JumpingTime = JumpingTime + tocB - handles.tocA;
    set(handles.editJumpingTime,'string',num2str(JumpingTime));
    set(handles.editJumpingNum,'string',num2str(JumpingNum));
    TimePlot = [tocB 0];
    handles.Jumping = [handles.Jumping;TimePlot];
    
end
stairs(handles.axesJumping,handles.Jumping(:,1),handles.Jumping(:,2));
set(handles.axesJumping,'YLim',[0 2]);
set(handles.axesJumping,'xLim',[0 handles.MovieDuration]);
hold on;
guidata(hObject, handles);



function editJumpingTime_Callback(hObject, eventdata, handles)
% hObject    handle to editJumpingTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editJumpingTime as text
%        str2double(get(hObject,'String')) returns contents of editJumpingTime as a double


% --- Executes during object creation, after setting all properties.
function editJumpingTime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editJumpingTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editJumpingNum_Callback(hObject, eventdata, handles)
% hObject    handle to editJumpingNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editJumpingNum as text
%        str2double(get(hObject,'String')) returns contents of editJumpingNum as a double


% --- Executes during object creation, after setting all properties.
function editJumpingNum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editJumpingNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonRearing.
function pushbuttonRearing_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonRearing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Start = length(get(handles.pushbuttonStart,'Visible'));%判断Start是否按下，按下为off，3，没按为on,2.
if Start == 2
    display('Press Start button fist!');
    return;
end
RearingTime = get(handles.editRearingTime,'string');
RearingTime = str2num(RearingTime);
RearingNum = get(handles.editRearingNum,'string');
RearingNum = str2num(RearingNum);

tocA = 0; tocB = 0;  TimePlot = [0 0];
E_color = get(handles.pushbuttonRearing,'BackgroundColor');
if E_color == [1 1 0] %判断是否超出movie长度
    tocA = toc;
        if tocA > handles.MovieDuration
        return;
    end
    
    set(handles.pushbuttonRearing,'BackgroundColor',[1 0 0 ]);
    handles.tocA = tocA;
    TimePlot = [tocA 1];
    handles.Rearing = [handles.Rearing;TimePlot];
   
elseif E_color == [1 0 0 ]
    tocB = toc;
        if tocB > handles.MovieDuration
        tocB = handles.MovieDuration;          
    end
    set(handles.pushbuttonRearing,'BackgroundColor',[1 1 0 ]);
    RearingNum = RearingNum +1;
    RearingTime = RearingTime + tocB - handles.tocA;
    set(handles.editRearingTime,'string',num2str(RearingTime));
    set(handles.editRearingNum,'string',num2str(RearingNum));
    TimePlot = [tocB 0];
    handles.Rearing = [handles.Rearing;TimePlot];
    
end

stairs(handles.axesRearing,handles.Rearing(:,1),handles.Rearing(:,2));
set(handles.axesRearing,'YLim',[0 2]);
set(handles.axesRearing,'xLim',[0 handles.MovieDuration]);
hold on;
guidata(hObject, handles);

function editRearingTime_Callback(hObject, eventdata, handles)
% hObject    handle to editRearingTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editRearingTime as text
%        str2double(get(hObject,'String')) returns contents of editRearingTime as a double


% --- Executes during object creation, after setting all properties.
function editRearingTime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editRearingTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editRearingNum_Callback(hObject, eventdata, handles)
% hObject    handle to editRearingNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editRearingNum as text
%        str2double(get(hObject,'String')) returns contents of editRearingNum as a double


% --- Executes during object creation, after setting all properties.
function editRearingNum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editRearingNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function editMovieDuration_Callback(hObject, eventdata, handles)
% hObject    handle to editMovieDuration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editMovieDuration as text
%        str2double(get(hObject,'String')) returns contents of editMovieDuration as a double


% --- Executes during object creation, after setting all properties.
function editMovieDuration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editMovieDuration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on figure1 or any of its controls.
function figure1_WindowKeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
key_input = eventdata.Key;
if length(key_input)>1 %如果不是字母或数字键，（空格，回车，ctrl，shift等），结束这个函数；
    return;
end


if key_input == 'E'||key_input == 'e'
        pushbuttonEating_Callback(hObject, eventdata, handles);
     elseif key_input == 'D'||key_input == 'd'
        pushbuttonDrinking_Callback(hObject, eventdata, handles);
    elseif key_input == 'G'||key_input == 'g'
        pushbuttonDigging_Callback(hObject, eventdata, handles);
    elseif key_input == 'W'||key_input == 'w'
        pushbuttonWalking_Callback(hObject, eventdata, handles);
    elseif key_input == 'J'||key_input == 'j'
        pushbuttonJumping_Callback(hObject, eventdata, handles);     
        elseif key_input == 'R'||key_input == 'r'
        pushbuttonRearing_Callback(hObject, eventdata, handles);
    else
     return;
end



function edit_behaviorThreshold_Callback(hObject, eventdata, handles)
% hObject    handle to edit_behaviorThreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_behaviorThreshold as text
%        str2double(get(hObject,'String')) returns contents of edit_behaviorThreshold as a double


% --- Executes during object creation, after setting all properties.
function edit_behaviorThreshold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_behaviorThreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_FilterSection.
function pushbutton_FilterSection_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_FilterSection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pushbuttonStop_Callback(hObject, eventdata, handles)
guidata(hObject, handles);
AnalysisData = handles.AnalysisData;
behaviorThreshold = str2num(get(handles.edit_behaviorThreshold,'string'));
sectionDuration = str2num(get(handles.edit_sectionDuration,'string'));
MovieDuration = str2num(get(handles.editMovieDuration,'string'));

data = AnalysisData.Drinking;

if size(data,1)>2%判断有behavior出现
    %%%%%%%%%%%filt data
    behaviorDuration = data(3:2:end,1)-data(2:2:end-1,1);
    index = find(behaviorDuration>=behaviorThreshold);
    data_filt = zeros(size(data))-1;
    data_filt(index*2,:) = data(index*2,:);
    data_filt(index*2+1,:) = data(index*2+1,:);
    index = find(data_filt(:,1)==-1);
    data_filt(index,:) = [];
    
%     figure;
%     d = [0,0;data_filt];
%     stairs(d(:,1),d(:,2));
%     set(gca,'YLim',[0 2]);
%     set(gca,'xLim',[0 handles.MovieDuration]);
    
    %%%%%%%%%%%section data
    sectionNum = round(MovieDuration/sectionDuration);
    
    for i = 1:sectionNum
        n = max(find(data_filt(:,1)<=sectionDuration*i));
           n = n + mod(n,2); %奇数转成大1的偶数,behavior在section时间点上发生
           dataT = data_filt(1:n,1);
           if dataT(n)>sectionDuration*i
               dataT(n) = sectionDuration*i;               
           end
           data_cumulate(i) = sum(dataT(2:2:n)-dataT(1:2:n-1)); %累积behavior
    end
     data_section(1) = data_cumulate(1);
     data_section(2:sectionNum) = diff(data_cumulate);
     data_section(sectionNum+1) = data_cumulate(sectionNum);% total behavior
     data_section = data_section';
     data_section = round(data_section*100)/100;%保留2位小数
     assignin('base','data_section',data_section);
else
    display('No behavior');
end

function edit_sectionDuration_Callback(hObject, eventdata, handles)
% hObject    handle to edit_sectionDuration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_sectionDuration as text
%        str2double(get(hObject,'String')) returns contents of edit_sectionDuration as a double


% --- Executes during object creation, after setting all properties.
function edit_sectionDuration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_sectionDuration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function pushbutton_FilterSection_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_FilterSection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
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
    handles.AnalysisData = importdata(str);
    set(handles.edit_fileName,'string',filename);
else
    set(handles.edit_fileName,'string','Null');
end
guidata(hObject, handles);


function edit_fileName_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fileName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fileName as text
%        str2double(get(hObject,'String')) returns contents of edit_fileName as a double


% --- Executes during object creation, after setting all properties.
function edit_fileName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fileName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
