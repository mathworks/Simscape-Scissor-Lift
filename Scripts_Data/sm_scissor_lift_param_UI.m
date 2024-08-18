function varargout = sm_scissor_lift_param_UI(varargin)
% SM_SCISSOR_LIFT_PARAM_UI MATLAB code for sm_scissor_lift_param_UI.fig
%      SM_SCISSOR_LIFT_PARAM_UI, by itself, creates a new SM_SCISSOR_LIFT_PARAM_UI or raises the existing
%      singleton*.
%
%      H = SM_SCISSOR_LIFT_PARAM_UI returns the handle to a new SM_SCISSOR_LIFT_PARAM_UI or the handle to
%      the existing singleton*.
%
%      SM_SCISSOR_LIFT_PARAM_UI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SM_SCISSOR_LIFT_PARAM_UI.M with the given input arguments.
%
%      SM_SCISSOR_LIFT_PARAM_UI('Property','Value',...) creates a new SM_SCISSOR_LIFT_PARAM_UI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before sm_scissor_lift_param_UI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to sm_scissor_lift_param_UI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help sm_scissor_lift_param_UI

% Last Modified by GUIDE v2.5 02-Aug-2017 16:09:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sm_scissor_lift_param_UI_OpeningFcn, ...
                   'gui_OutputFcn',  @sm_scissor_lift_param_UI_OutputFcn, ...
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




% --- Executes just before sm_scissor_lift_param_UI is made visible.
function sm_scissor_lift_param_UI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sm_scissor_lift_param_UI (see VARARGIN)

% Choose default command line output for sm_scissor_lift_param_UI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes sm_scissor_lift_param_UI wait for user response (see UIRESUME)
% uiwait(handles.LWET);
CurrLL = num2str(evalin('base','SCL_Par.Link.Length'));
%disp(CurrLL);
set(handles.LLET,'String',CurrLL);

CurrLW = num2str(evalin('base','SCL_Par.Link.Width'));
%disp(CurrLW);
set(handles.LW_Edit_Text,'String',CurrLW);

CurrLS = num2str(evalin('base','SCL_Par.Link_Sep.Outer_Outer'));
%disp(CurrLW);
set(handles.LS_Edit_Text,'String',CurrLS);

CurrIH = num2str(evalin('base','SCL_Par.Init.Platform_Height'));
%disp(CurrLW);
set(handles.IH_Edit_Text,'String',CurrIH);


% --- Outputs from this function are returned to the command line.
function varargout = sm_scissor_lift_param_UI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in LLPB_Plus.
function LLPB_Plus_Callback(hObject, eventdata, handles)
% hObject    handle to LLPB_Plus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CurrLL = evalin('base','SCL_Par.Link.Length');
CurrLW = evalin('base','SCL_Par.Link.Width');
CurrPW = evalin('base','SCL_Par.Link_Sep.Outer_Outer');
CurrIH = evalin('base','SCL_Par.Init.Platform_Height');
NewLL = num2str(CurrLL+10);
%disp(num2str(NewLL));
set(handles.LLET,'String',NewLL);

evalin('base',['SCL_Par = sm_scissor_lift_param(' num2str(NewLL) ',' num2str(CurrLW) ',' num2str(CurrPW) ',' num2str(CurrIH) ');']);
set_param(bdroot, 'SimulationCommand', 'Update');

% Copyright 2012-2024 The MathWorks, Inc.

function LLET_Callback(hObject, eventdata, handles)
% hObject    handle to LLET (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LLET as text
%        str2double(get(hObject,'String')) returns contents of LLET as a double


% --- Executes during object creation, after setting all properties.
function LLET_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LLET (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in LLPB_Minus.
function LLPB_Minus_Callback(hObject, eventdata, handles)
% hObject    handle to LLPB_Minus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CurrLL = evalin('base','SCL_Par.Link.Length');
CurrLW = evalin('base','SCL_Par.Link.Width');
CurrPW = evalin('base','SCL_Par.Link_Sep.Outer_Outer');
CurrIH = evalin('base','SCL_Par.Init.Platform_Height');
NewLL = num2str(CurrLL-10);
%disp(num2str(NewLL));
set(handles.LLET,'String',NewLL);

evalin('base',['SCL_Par = sm_scissor_lift_param(' num2str(NewLL) ',' num2str(CurrLW) ',' num2str(CurrPW) ',' num2str(CurrIH) ');']);
set_param(bdroot, 'SimulationCommand', 'Update');


% --- Executes on button press in LWPB_Plus.
function LWPB_Plus_Callback(hObject, eventdata, handles)
% hObject    handle to LWPB_Plus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CurrLL = evalin('base','SCL_Par.Link.Length');
CurrLW = evalin('base','SCL_Par.Link.Width');
CurrPW = evalin('base','SCL_Par.Link_Sep.Outer_Outer');
CurrIH = evalin('base','SCL_Par.Init.Platform_Height');
NewLW = num2str(CurrLW+2);
%disp(num2str(NewLL));
set(handles.LW_Edit_Text,'String',NewLW);

evalin('base',['SCL_Par = sm_scissor_lift_param(' num2str(CurrLL) ',' num2str(NewLW) ',' num2str(CurrPW) ',' num2str(CurrIH) ');']);
set_param(bdroot, 'SimulationCommand', 'Update');


% --- Executes on button press in LWPB_Minus.
function LWPB_Minus_Callback(hObject, eventdata, handles)
% hObject    handle to LWPB_Minus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CurrLL = evalin('base','SCL_Par.Link.Length');
CurrLW = evalin('base','SCL_Par.Link.Width');
CurrPW = evalin('base','SCL_Par.Link_Sep.Outer_Outer');
CurrIH = evalin('base','SCL_Par.Init.Platform_Height');
NewLW = num2str(CurrLW-2);
%disp(num2str(NewLL));
set(handles.LW_Edit_Text,'String',NewLW);

evalin('base',['SCL_Par = sm_scissor_lift_param(' num2str(CurrLL) ',' num2str(NewLW) ',' num2str(CurrPW) ',' num2str(CurrIH) ');']);
set_param(bdroot, 'SimulationCommand', 'Update');


function LW_Edit_Text_Callback(hObject, eventdata, handles)
% hObject    handle to LW_Edit_Text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LW_Edit_Text as text
%        str2double(get(hObject,'String')) returns contents of LW_Edit_Text as a double


% --- Executes during object creation, after setting all properties.
function LW_Edit_Text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LW_Edit_Text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in RunSim.
function RunSim_Callback(hObject, eventdata, handles)
% hObject    handle to RunSim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set_param(bdroot, 'SimulationCommand', 'start');


% --- Executes on button press in LSPB_Plus.
function LSPB_Plus_Callback(hObject, eventdata, handles)
% hObject    handle to LSPB_Plus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CurrLL = evalin('base','SCL_Par.Link.Length');
CurrLW = evalin('base','SCL_Par.Link.Width');
CurrLS = evalin('base','SCL_Par.Link_Sep.Outer_Outer');
CurrIH = evalin('base','SCL_Par.Init.Platform_Height');
NewLS = num2str(CurrLS+10);
%disp(num2str(NewLL));
set(handles.LS_Edit_Text,'String',NewLS);

evalin('base',['SCL_Par = sm_scissor_lift_param(' num2str(CurrLL) ',' num2str(CurrLW) ',' num2str(NewLS) ',' num2str(CurrIH) ');']);
set_param(bdroot, 'SimulationCommand', 'Update');


% --- Executes on button press in LSPB_Minus.
function LSPB_Minus_Callback(hObject, eventdata, handles)
% hObject    handle to LSPB_Minus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CurrLL = evalin('base','SCL_Par.Link.Length');
CurrLW = evalin('base','SCL_Par.Link.Width');
CurrLS = evalin('base','SCL_Par.Link_Sep.Outer_Outer');
CurrIH = evalin('base','SCL_Par.Init.Platform_Height');
NewLS = num2str(CurrLS-10);
%disp(num2str(NewLL));
set(handles.LS_Edit_Text,'String',NewLS);

evalin('base',['SCL_Par = sm_scissor_lift_param(' num2str(CurrLL) ',' num2str(CurrLW) ',' num2str(NewLS) ',' num2str(CurrIH) ');']);
set_param(bdroot, 'SimulationCommand', 'Update');



function LS_Edit_Text_Callback(hObject, eventdata, handles)
% hObject    handle to LS_Edit_Text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LS_Edit_Text as text
%        str2double(get(hObject,'String')) returns contents of LS_Edit_Text as a double


% --- Executes during object creation, after setting all properties.
function LS_Edit_Text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LS_Edit_Text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in IHPB_Plus.
function IHPB_Plus_Callback(hObject, eventdata, handles)
% hObject    handle to IHPB_Plus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

CurrLL = evalin('base','SCL_Par.Link.Length');
CurrLW = evalin('base','SCL_Par.Link.Width');
CurrPW = evalin('base','SCL_Par.Link_Sep.Outer_Outer');
CurrIH = evalin('base','SCL_Par.Init.Platform_Height');
NewIH = num2str(CurrIH+10);
%disp(num2str(NewLL));
set(handles.IH_Edit_Text,'String',NewIH);

evalin('base',['SCL_Par = sm_scissor_lift_param(' num2str(CurrLL) ',' num2str(CurrLW) ',' num2str(CurrPW) ',' num2str(NewIH) ');']);
set_param(bdroot, 'SimulationCommand', 'Update');


% --- Executes on button press in IHPB_Minus.
function IHPB_Minus_Callback(hObject, eventdata, handles)
% hObject    handle to IHPB_Minus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

CurrLL = evalin('base','SCL_Par.Link.Length');
CurrLW = evalin('base','SCL_Par.Link.Width');
CurrPW = evalin('base','SCL_Par.Link_Sep.Outer_Outer');
CurrIH = evalin('base','SCL_Par.Init.Platform_Height');
NewIH = num2str(CurrIH-10);
%disp(num2str(NewLL));
set(handles.IH_Edit_Text,'String',NewIH);

evalin('base',['SCL_Par = sm_scissor_lift_param(' num2str(CurrLL) ',' num2str(CurrLW) ',' num2str(CurrPW) ',' num2str(NewIH) ');']);
set_param(bdroot, 'SimulationCommand', 'Update');



function IH_Edit_Text_Callback(hObject, eventdata, handles)
% hObject    handle to IH_Edit_Text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of IH_Edit_Text as text
%        str2double(get(hObject,'String')) returns contents of IH_Edit_Text as a double


% --- Executes during object creation, after setting all properties.
function IH_Edit_Text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to IH_Edit_Text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over LLPB_Plus.
function LLPB_Plus_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to LLPB_Plus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Default_PB.
function Default_PB_Callback(hObject, eventdata, handles)
% hObject    handle to Default_PB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%disp(num2str(NewLL));

evalin('base',['SCL_Par = sm_scissor_lift_param;']);

CurrLL = evalin('base','SCL_Par.Link.Length');
CurrLW = evalin('base','SCL_Par.Link.Width');
CurrLS = evalin('base','SCL_Par.Link_Sep.Outer_Outer');
CurrIH = evalin('base','SCL_Par.Init.Platform_Height');
set(handles.LLET,'String',CurrLL);
set(handles.LW_Edit_Text,'String',CurrLW);
set(handles.LS_Edit_Text,'String',CurrLS);
set(handles.IH_Edit_Text,'String',CurrIH);

set_param(bdroot, 'SimulationCommand', 'Update');



% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over Default_PB.
function Default_PB_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to Default_PB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
