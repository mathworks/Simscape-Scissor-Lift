function varargout = Scissor_Jack_Param_GUI(varargin)
% SCISSOR_JACK_PARAM_GUI MATLAB code for Scissor_Jack_Param_GUI.fig
%      SCISSOR_JACK_PARAM_GUI, by itself, creates a new SCISSOR_JACK_PARAM_GUI or raises the existing
%      singleton*.
%
%      H = SCISSOR_JACK_PARAM_GUI returns the handle to a new SCISSOR_JACK_PARAM_GUI or the handle to
%      the existing singleton*.
%
%      SCISSOR_JACK_PARAM_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SCISSOR_JACK_PARAM_GUI.M with the given input arguments.
%
%      SCISSOR_JACK_PARAM_GUI('Property','Value',...) creates a new SCISSOR_JACK_PARAM_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Scissor_Jack_Param_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Scissor_Jack_Param_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2012 The MathWorks, Inc.

% Edit the above text to modify the response to help Scissor_Jack_Param_GUI

% Last Modified by GUIDE v2.5 13-Feb-2012 15:33:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Scissor_Jack_Param_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Scissor_Jack_Param_GUI_OutputFcn, ...
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




% --- Executes just before Scissor_Jack_Param_GUI is made visible.
function Scissor_Jack_Param_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Scissor_Jack_Param_GUI (see VARARGIN)

% Choose default command line output for Scissor_Jack_Param_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Scissor_Jack_Param_GUI wait for user response (see UIRESUME)
% uiwait(handles.LWET);
CurrLL = num2str(evalin('base','Scissor_Lift_Param.Link.Length'));
%disp(CurrLL);
set(handles.LLET,'String',CurrLL);

CurrLW = num2str(evalin('base','Scissor_Lift_Param.Link.Width'));
%disp(CurrLW);
set(handles.LW_Edit_Text,'String',CurrLW);


% --- Outputs from this function are returned to the command line.
function varargout = Scissor_Jack_Param_GUI_OutputFcn(hObject, eventdata, handles) 
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
CurrLL = evalin('base','Scissor_Lift_Param.Link.Length');
NewLL = num2str(CurrLL+10);
%disp(num2str(NewLL));
set(handles.LLET,'String',NewLL);

evalin('base',['Scissor_Lift_Param.Link.Length = ' NewLL ';']);
evalin('base','Scissor_Lift_Param.Roller.Init_Pos_Target = Scissor_Lift_Param.Link.Length-2;'); % cm 
evalin('base','Scissor_Lift_Param.Crossbar.Init_Angle_Target = asin(Scissor_Lift_Param.Roller.Init_Pos_Target/Scissor_Lift_Param.Link.Length)*180/pi-90;');

set_param(bdroot, 'SimulationCommand', 'Update');


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
CurrLL = evalin('base','Scissor_Lift_Param.Link.Length');
NewLL = num2str(CurrLL-10);
%disp(num2str(NewLL));
set(handles.LLET,'String',NewLL);

evalin('base',['Scissor_Lift_Param.Link.Length = ' NewLL ';']);
evalin('base','Scissor_Lift_Param.Roller.Init_Pos_Target = Scissor_Lift_Param.Link.Length-2;'); % cm 
evalin('base','Scissor_Lift_Param.Crossbar.Init_Angle_Target = asin(Scissor_Lift_Param.Roller.Init_Pos_Target/Scissor_Lift_Param.Link.Length)*180/pi-90;');

set_param(bdroot, 'SimulationCommand', 'Update');


% --- Executes on button press in LWPB_Plus.
function LWPB_Plus_Callback(hObject, eventdata, handles)
% hObject    handle to LWPB_Plus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CurrLW = evalin('base','Scissor_Lift_Param.Link.Width');
NewLW = num2str(CurrLW+5);
%disp(num2str(NewLL));
set(handles.LW_Edit_Text,'String',NewLW);

evalin('base',['Scissor_Lift_Param.Link.Width = ' NewLW ';']);

set_param(bdroot, 'SimulationCommand', 'Update');


% --- Executes on button press in LWPB_Minus.
function LWPB_Minus_Callback(hObject, eventdata, handles)
% hObject    handle to LWPB_Minus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CurrLW = evalin('base','Scissor_Lift_Param.Link.Width');
NewLW = num2str(CurrLW-5);
%disp(num2str(NewLL));
set(handles.LW_Edit_Text,'String',NewLW);

evalin('base',['Scissor_Lift_Param.Link.Width = ' NewLW ';']);

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
