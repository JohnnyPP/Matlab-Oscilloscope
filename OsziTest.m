function varargout = OsziTest(varargin)
% OSZITEST MATLAB code for OsziTest.fig
%      OSZITEST, by itself, creates a new OSZITEST or raises the existing
%      singleton*.
%
%      H = OSZITEST returns the handle to a new OSZITEST or the handle to
%      the existing singleton*.
%
%      OSZITEST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OSZITEST.M with the given input arguments.
%
%      OSZITEST('Property','Value',...) creates a new OSZITEST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before OsziTest_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to OsziTest_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help OsziTest

% Last Modified by GUIDE v2.5 24-Aug-2011 14:00:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @OsziTest_OpeningFcn, ...
                   'gui_OutputFcn',  @OsziTest_OutputFcn, ...
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


% --- Executes just before OsziTest is made visible.
function OsziTest_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to OsziTest (see VARARGIN)

% Choose default command line output for OsziTest
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
set(handles.pushbutton2,'Enable','off');                                        %disables plot RAW data button
set(handles.pushbutton3,'Enable','off');                                        %disables plot scaled data button
set(handles.pushbutton4,'Enable','off');                                        %disables calculate statistics button
set(handles.spectra,'Enable','off');                                            %disables spectra button
set(handles.pushbutton6,'Enable','off');                                        %disables find peaks button


% UIWAIT makes OsziTest wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = OsziTest_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile('*.csv','Select the Oszi data file');           %opens file dialog for choosing the csv raw Oszi data
FullPath = strcat(PathName, FileName); %Concatenate strings horizontally
oszipath(FullPath);

textdataLocal = evalin('base','textdata');
set(handles.text1,'String',[textdataLocal(:,1); 'Path ' FullPath]);                                 %displays Oscilloscope settings

Channel1Name = get(handles.edit2,'String');                                     %gets the title from the editbox
assignin('base', 'Channel1Name', Channel1Name);                                 %sends channel name to workspace

Channel2Name = get(handles.edit3,'String');                                     %gets the title from the editbox
assignin('base', 'Channel2Name', Channel2Name);                                 %sends channel name to workspace

Channel3Name = get(handles.edit4,'String');                                     %gets the title from the editbox
assignin('base', 'ChannelName', Channel3Name);                                 %sends channel name to workspace

Channel4Name = get(handles.edit5,'String');                                     %gets the title from the editbox
assignin('base', 'Channel1Name', Channel4Name);                                 %sends channel name to workspace

set(handles.text19,'String', FileName); 
set(handles.pushbutton2,'Enable','on');                                        %enables plot RAW data button
set(handles.pushbutton3,'Enable','on');                                        %enables plot scaled data button


[col1, col2] = size(textdataLocal)



switch col2
    case 2
        NumberOfChannels=1;
        set(handles.popupmenu1,'String', {'Channel 1'});
        set(handles.checkbox1,'Enable','off');
        set(handles.edit3,'Enable','off');
        set(handles.edit4,'Enable','off');
        set(handles.edit5,'Enable','off');
        set(handles.ScaleFactorCh2,'Enable','off');
        set(handles.ScaleFactorCh3,'Enable','off');
        set(handles.ScaleFactorCh4,'Enable','off');
      
    case 3
        NumberOfChannels=2;
        set(handles.popupmenu1,'String', {'Channel 1' 'Channel 2'});
        set(handles.edit4,'Enable','off');
        set(handles.edit5,'Enable','off');
        set(handles.ScaleFactorCh3,'Enable','off');
        set(handles.ScaleFactorCh4,'Enable','off');
        
    case 4
        NumberOfChannels=3;
        set(handles.popupmenu1,'String', {'Channel 1' 'Channel 2' 'Channel 3'});
        set(handles.edit5,'Enable','off');
        set(handles.ScaleFactorCh4,'Enable','off');
 
    case 5
        NumberOfChannels=4;
        set(handles.popupmenu1,'String', {'Channel 1' 'Channel 2' 'Channel 3' 'Channel 4'});
end

assignin('base', 'NumberOfChannels', NumberOfChannels);  

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)                      %plots RAW data
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
dataLocal = evalin('base','data');                                              %gets data form the workspace
NumberOfChannels = evalin('base','NumberOfChannels');  


switch NumberOfChannels
    
    case 1
        
        figure(11);
        plot(dataLocal(:,1),dataLocal(:,2));
        title({get(handles.edit2,'String')});          
        xlabel('Time [s]');
        ylabel('Voltage [V]');
        set(gcf,'Name','RAW Channel 1','NumberTitle','off');
        
    case 2
    
         if get(handles.checkbox1,'Value'); 

            figure(10);
            set(gcf,'Name','RAW Multiplot','NumberTitle','off');
            subplot(2,1,1); 
            plot(dataLocal(:,1),dataLocal(:,2));
            title({get(handles.edit2,'String')});          
            xlabel('Time [s]');
            ylabel('Voltage [V]'); 

            subplot(2,1,2); 
            plot(dataLocal(:,1),dataLocal(:,3));
            title({get(handles.edit3,'String')});
            xlabel('Time [s]');
            ylabel('Voltage [V]');


        else

            figure(11);
            plot(dataLocal(:,1),dataLocal(:,2));
            title({get(handles.edit2,'String')});          
            xlabel('Time [s]');
            ylabel('Voltage [V]');
            set(gcf,'Name','RAW Channel 1','NumberTitle','off');

            figure(12);
            plot(dataLocal(:,1),dataLocal(:,3));
            title({get(handles.edit3,'String')});
            xlabel('Time [s]');
            ylabel('Voltage [V]');
            set(gcf,'Name','RAW Channel 2','NumberTitle','off');

         end
        
    case 3
        
         if get(handles.checkbox1,'Value'); 

            figure(10);
            set(gcf,'Name','RAW Multiplot','NumberTitle','off');
            subplot(3,1,1); 
            plot(dataLocal(:,1),dataLocal(:,2));
            title({get(handles.edit2,'String')});          
            xlabel('Time [s]');
            ylabel('Voltage [V]'); 

            subplot(3,1,2); 
            plot(dataLocal(:,1),dataLocal(:,3));
            title({get(handles.edit3,'String')});
            xlabel('Time [s]');
            ylabel('Voltage [V]');   

            subplot(3,1,3); 
            plot(dataLocal(:,1),dataLocal(:,4));
            title({get(handles.edit4,'String')});
            xlabel('Time [s]');
            ylabel('Voltage [V]');  

        else

            figure(11);
            plot(dataLocal(:,1),dataLocal(:,2));
            title({get(handles.edit2,'String')});          
            xlabel('Time [s]');
            ylabel('Voltage [V]');
            set(gcf,'Name','RAW Channel 1','NumberTitle','off');

            figure(12);
            plot(dataLocal(:,1),dataLocal(:,3));
            title({get(handles.edit3,'String')});
            xlabel('Time [s]');
            ylabel('Voltage [V]');
            set(gcf,'Name','RAW Channel 2','NumberTitle','off');


            figure(13);
            plot(dataLocal(:,1),dataLocal(:,4));
            title({get(handles.edit4,'String')});
            xlabel('Time [s]');
            ylabel('Voltage [V]');
            set(gcf,'Name','RAW Channel 3','NumberTitle','off');

        end
    
    
    case 4
        
        if get(handles.checkbox1,'Value'); 

            figure(10);
            set(gcf,'Name','RAW Multiplot','NumberTitle','off');
            subplot(4,1,1); 
            plot(dataLocal(:,1),dataLocal(:,2));
            title({get(handles.edit2,'String')});          
            xlabel('Time [s]');
            ylabel('Voltage [V]'); 

            subplot(4,1,2); 
            plot(dataLocal(:,1),dataLocal(:,3));
            title({get(handles.edit3,'String')});
            xlabel('Time [s]');
            ylabel('Voltage [V]');   

            subplot(4,1,3); 
            plot(dataLocal(:,1),dataLocal(:,4));
            title({get(handles.edit4,'String')});
            xlabel('Time [s]');
            ylabel('Voltage [V]');  

            subplot(4,1,4);
            plot(dataLocal(:,1),dataLocal(:,5));
            title({get(handles.edit5,'String')});
            xlabel('Time [s]');
            ylabel('Voltage [V]');   


        else

            figure(11);
            plot(dataLocal(:,1),dataLocal(:,2));
            title({get(handles.edit2,'String')});          
            xlabel('Time [s]');
            ylabel('Voltage [V]');
            set(gcf,'Name','RAW Channel 1','NumberTitle','off');

            figure(12);
            plot(dataLocal(:,1),dataLocal(:,3));
            title({get(handles.edit3,'String')});
            xlabel('Time [s]');
            ylabel('Voltage [V]');
            set(gcf,'Name','RAW Channel 2','NumberTitle','off');


            figure(13);
            plot(dataLocal(:,1),dataLocal(:,4));
            title({get(handles.edit4,'String')});
            xlabel('Time [s]');
            ylabel('Voltage [V]');
            set(gcf,'Name','RAW Channel 3','NumberTitle','off');


            figure(14);
            plot(dataLocal(:,1),dataLocal(:,5));
            title({get(handles.edit5,'String')});
            xlabel('Time [s]');
            ylabel('Voltage [V]');
            set(gcf,'Name','RAW Channel 4','NumberTitle','off');
        end
    
   
    
end


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


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)                      %scaling data
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

NumberOfChannels = evalin('base','NumberOfChannels');  


switch NumberOfChannels
    
    case 1
        
        dataLocal = evalin('base','data');
        dataLocalShift = dataNullShiftFunction(dataLocal);
        textdataLocal = evalin('base','textdata');
        TimeScale = textdataLocal{7,1};                                          %getting time scale pro division X scale


        tempNumeric = sscanf(TimeScale, ['Horizontal Scale,' '%f' ',' '%f' ',' '%f' ',' '%f']);
        TimeValue = tempNumeric(1);


        YscaleFactorCh1=(get(handles.ScaleFactorCh1,'String'));



        YscaleFactorCh1NumericUnit = textscan(YscaleFactorCh1, ['%f %s']);
        YscaleFactorCh1Numeric = YscaleFactorCh1NumericUnit{1};
        YscaleFactorCh1Unit = YscaleFactorCh1NumericUnit{2};
        assignin('base', 'YscaleFactorCh1Numeric', YscaleFactorCh1Numeric);

                                                                
        figure(21);
        set(gcf,'Name','ScaledData Channel 1','NumberTitle','off');
        plot((dataLocalShift(:,1)),dataLocalShift(:,2)*YscaleFactorCh1Numeric);         
        title({get(handles.edit2,'String')});
        xlabel('Time [s]');
        ylabelConcentratedCh1String = evalin('base','ylabelConcentratedCh1String');
        ylabel(ylabelConcentratedCh1String);
        
    case 2
        
        dataLocal = evalin('base','data');
        dataLocalShift = dataNullShiftFunction(dataLocal);
        textdataLocal = evalin('base','textdata');
        TimeScale = textdataLocal{7,1};             %getting time scale pro division X scale


        tempNumeric = sscanf(TimeScale, ['Horizontal Scale,' '%f' ',' '%f' ',' '%f' ',' '%f']);
        TimeValue = tempNumeric(1);


        YscaleFactorCh1=(get(handles.ScaleFactorCh1,'String'));
        YscaleFactorCh2=(get(handles.ScaleFactorCh2,'String'));


        YscaleFactorCh1NumericUnit = textscan(YscaleFactorCh1, ['%f %s']);
        YscaleFactorCh1Numeric = YscaleFactorCh1NumericUnit{1};
        YscaleFactorCh1Unit = YscaleFactorCh1NumericUnit{2};
        assignin('base', 'YscaleFactorCh1Numeric', YscaleFactorCh1Numeric);

        YscaleFactorCh2NumericUnit = textscan(YscaleFactorCh2, ['%f %s']);
        YscaleFactorCh2Numeric = YscaleFactorCh2NumericUnit{1};
        YscaleFactorCh2Unit = YscaleFactorCh2NumericUnit{2};
        assignin('base', 'YscaleFactorCh2Numeric', YscaleFactorCh2Numeric);

      
        if get(handles.checkbox1,'Value');                                               %plots multiplots

                figure(20);
                set(gcf,'Name','ScaledData Multiplot','NumberTitle','off');
                subplot(2,1,1);



                plot((dataLocalShift(:,1)),dataLocalShift(:,2)*YscaleFactorCh1Numeric);
                title({get(handles.edit2,'String')});
                xlabel('Time [s]');
                YlabelConcentrated = ['Stage error [' YscaleFactorCh1Unit ']'];
                ylabelConcentratedCh1String = [YlabelConcentrated{1} YlabelConcentrated{2} YlabelConcentrated{3}];
                ylabel(ylabelConcentratedCh1String);
                assignin('base', 'ylabelConcentratedCh1String', ylabelConcentratedCh1String);


                subplot(2,1,2); 
                plot((dataLocalShift(:,1)),dataLocalShift(:,3)*YscaleFactorCh2Numeric); 
                title({get(handles.edit3,'String')});
                xlabel('Time [s]');
                YlabelConcentrated = ['Stage error [' YscaleFactorCh2Unit ']'];
                ylabelConcentratedCh2String = [YlabelConcentrated{1} YlabelConcentrated{2} YlabelConcentrated{3}];
                ylabel(ylabelConcentratedCh2String);
                assignin('base', 'ylabelConcentratedCh2String', ylabelConcentratedCh2String);

               
        else                                                                           %plots separate plots

                figure(21);
                set(gcf,'Name','ScaledData Channel 1','NumberTitle','off');
                plot((dataLocalShift(:,1)),dataLocalShift(:,2)*YscaleFactorCh1Numeric);         
                title({get(handles.edit2,'String')});
                xlabel('Time [s]');
                ylabelConcentratedCh1String = evalin('base','ylabelConcentratedCh1String');
                ylabel(ylabelConcentratedCh1String);

                figure(22);
                set(gcf,'Name','ScaledData Channel 2','NumberTitle','off');
                plot((dataLocalShift(:,1)),dataLocalShift(:,3)*YscaleFactorCh2Numeric);         
                title({get(handles.edit3,'String')});
                xlabel('Time [s]');
                ylabelConcentratedCh2String = evalin('base','ylabelConcentratedCh2String');
                ylabel(ylabelConcentratedCh2String);

        end

    case 3
        
        dataLocal = evalin('base','data');
        dataLocalShift = dataNullShiftFunction(dataLocal);
        textdataLocal = evalin('base','textdata');
        TimeScale = textdataLocal{7,1};             %getting time scale pro division X scale


        tempNumeric = sscanf(TimeScale, ['Horizontal Scale,' '%f' ',' '%f' ',' '%f' ',' '%f']);
        TimeValue = tempNumeric(1);


        YscaleFactorCh1=(get(handles.ScaleFactorCh1,'String'));
        YscaleFactorCh2=(get(handles.ScaleFactorCh2,'String'));
        YscaleFactorCh3=(get(handles.ScaleFactorCh3,'String'));
    


        YscaleFactorCh1NumericUnit = textscan(YscaleFactorCh1, ['%f %s']);
        YscaleFactorCh1Numeric = YscaleFactorCh1NumericUnit{1};
        YscaleFactorCh1Unit = YscaleFactorCh1NumericUnit{2};
        assignin('base', 'YscaleFactorCh1Numeric', YscaleFactorCh1Numeric);

        YscaleFactorCh2NumericUnit = textscan(YscaleFactorCh2, ['%f %s']);
        YscaleFactorCh2Numeric = YscaleFactorCh2NumericUnit{1};
        YscaleFactorCh2Unit = YscaleFactorCh2NumericUnit{2};
        assignin('base', 'YscaleFactorCh2Numeric', YscaleFactorCh2Numeric);

        YscaleFactorCh3NumericUnit = textscan(YscaleFactorCh3, ['%f %s']);
        YscaleFactorCh3Numeric = YscaleFactorCh3NumericUnit{1};
        YscaleFactorCh3Unit = YscaleFactorCh3NumericUnit{2};
        assignin('base', 'YscaleFactorCh3Numeric', YscaleFactorCh3Numeric);

        if get(handles.checkbox1,'Value');                                               %plots multiplots

                figure(20);
                set(gcf,'Name','ScaledData Multiplot','NumberTitle','off');
                subplot(3,1,1);

                plot((dataLocalShift(:,1)),dataLocalShift(:,2)*YscaleFactorCh1Numeric);
                title({get(handles.edit2,'String')});
                xlabel('Time [s]');
                YlabelConcentrated = ['Stage error [' YscaleFactorCh1Unit ']'];
                ylabelConcentratedCh1String = [YlabelConcentrated{1} YlabelConcentrated{2} YlabelConcentrated{3}];
                ylabel(ylabelConcentratedCh1String);
                assignin('base', 'ylabelConcentratedCh1String', ylabelConcentratedCh1String);


                subplot(3,1,2); 
                plot((dataLocalShift(:,1)),dataLocalShift(:,3)*YscaleFactorCh2Numeric); 
                title({get(handles.edit3,'String')});
                xlabel('Time [s]');
                YlabelConcentrated = ['Stage error [' YscaleFactorCh2Unit ']'];
                ylabelConcentratedCh2String = [YlabelConcentrated{1} YlabelConcentrated{2} YlabelConcentrated{3}];
                ylabel(ylabelConcentratedCh2String);
                assignin('base', 'ylabelConcentratedCh2String', ylabelConcentratedCh2String);

                subplot(3,1,3); 
                plot((dataLocalShift(:,1)),dataLocalShift(:,4)*YscaleFactorCh3Numeric);         
                title({get(handles.edit4,'String')});
                xlabel('Time [s]');
                YlabelConcentrated = ['Stage error [' YscaleFactorCh3Unit ']'];
                ylabelConcentratedCh3String = [YlabelConcentrated{1} YlabelConcentrated{2} YlabelConcentrated{3}];
                ylabel(ylabelConcentratedCh3String);
                assignin('base', 'ylabelConcentratedCh3String', ylabelConcentratedCh3String);


        else                                                                           %plots separate plots

                figure(21);
                set(gcf,'Name','ScaledData Channel 1','NumberTitle','off');
                plot((dataLocalShift(:,1)),dataLocalShift(:,2)*YscaleFactorCh1Numeric);         
                title({get(handles.edit2,'String')});
                xlabel('Time [s]');
                ylabelConcentratedCh1String = evalin('base','ylabelConcentratedCh1String');
                ylabel(ylabelConcentratedCh1String);

                figure(22);
                set(gcf,'Name','ScaledData Channel 2','NumberTitle','off');
                plot((dataLocalShift(:,1)),dataLocalShift(:,3)*YscaleFactorCh2Numeric);         
                title({get(handles.edit3,'String')});
                xlabel('Time [s]');
                ylabelConcentratedCh2String = evalin('base','ylabelConcentratedCh2String');
                ylabel(ylabelConcentratedCh2String);

                figure(23);
                set(gcf,'Name','ScaledData Channel 3','NumberTitle','off');
                plot((dataLocalShift(:,1)),dataLocalShift(:,4)*YscaleFactorCh3Numeric);         
                title({get(handles.edit4,'String')});
                xlabel('Time [s]');
                ylabelConcentratedCh3String = evalin('base','ylabelConcentratedCh3String');
                ylabel(ylabelConcentratedCh3String);

        end
    case 4
        

        dataLocal = evalin('base','data');
        dataLocalShift = dataNullShiftFunction(dataLocal);
        textdataLocal = evalin('base','textdata');
        TimeScale = textdataLocal{7,1};             %getting time scale pro division X scale


        tempNumeric = sscanf(TimeScale, ['Horizontal Scale,' '%f' ',' '%f' ',' '%f' ',' '%f']);
        TimeValue = tempNumeric(1);


        YscaleFactorCh1=(get(handles.ScaleFactorCh1,'String'));
        YscaleFactorCh2=(get(handles.ScaleFactorCh2,'String'));
        YscaleFactorCh3=(get(handles.ScaleFactorCh3,'String'));
        YscaleFactorCh4=(get(handles.ScaleFactorCh4,'String'));


        YscaleFactorCh1NumericUnit = textscan(YscaleFactorCh1, ['%f %s']);
        YscaleFactorCh1Numeric = YscaleFactorCh1NumericUnit{1};
        YscaleFactorCh1Unit = YscaleFactorCh1NumericUnit{2};
        assignin('base', 'YscaleFactorCh1Numeric', YscaleFactorCh1Numeric);

        YscaleFactorCh2NumericUnit = textscan(YscaleFactorCh2, ['%f %s']);
        YscaleFactorCh2Numeric = YscaleFactorCh2NumericUnit{1};
        YscaleFactorCh2Unit = YscaleFactorCh2NumericUnit{2};
        assignin('base', 'YscaleFactorCh2Numeric', YscaleFactorCh2Numeric);

        YscaleFactorCh3NumericUnit = textscan(YscaleFactorCh3, ['%f %s']);
        YscaleFactorCh3Numeric = YscaleFactorCh3NumericUnit{1};
        YscaleFactorCh3Unit = YscaleFactorCh3NumericUnit{2};
        assignin('base', 'YscaleFactorCh3Numeric', YscaleFactorCh3Numeric);

        YscaleFactorCh4NumericUnit = textscan(YscaleFactorCh4, ['%f %s']);
        YscaleFactorCh4Numeric = YscaleFactorCh4NumericUnit{1};
        YscaleFactorCh4Unit = YscaleFactorCh4NumericUnit{2};
        assignin('base', 'YscaleFactorCh4Numeric', YscaleFactorCh4Numeric);

        if get(handles.checkbox1,'Value');                                               %plots multiplots

                figure(20);
                set(gcf,'Name','ScaledData Multiplot','NumberTitle','off');
                subplot(4,1,1);



                plot((dataLocalShift(:,1)),dataLocalShift(:,2)*YscaleFactorCh1Numeric);
                title({get(handles.edit2,'String')});
                xlabel('Time [s]');
                YlabelConcentrated = ['Stage error [' YscaleFactorCh1Unit ']'];
                ylabelConcentratedCh1String = [YlabelConcentrated{1} YlabelConcentrated{2} YlabelConcentrated{3}];
                ylabel(ylabelConcentratedCh1String);
                assignin('base', 'ylabelConcentratedCh1String', ylabelConcentratedCh1String);


                subplot(4,1,2); 
                plot((dataLocalShift(:,1)),dataLocalShift(:,3)*YscaleFactorCh2Numeric); 
                title({get(handles.edit3,'String')});
                xlabel('Time [s]');
                YlabelConcentrated = ['Stage error [' YscaleFactorCh2Unit ']'];
                ylabelConcentratedCh2String = [YlabelConcentrated{1} YlabelConcentrated{2} YlabelConcentrated{3}];
                ylabel(ylabelConcentratedCh2String);
                assignin('base', 'ylabelConcentratedCh2String', ylabelConcentratedCh2String);

                subplot(4,1,3); 
                plot((dataLocalShift(:,1)),dataLocalShift(:,4)*YscaleFactorCh3Numeric);         
                title({get(handles.edit4,'String')});
                xlabel('Time [s]');
                YlabelConcentrated = ['Stage error [' YscaleFactorCh3Unit ']'];
                ylabelConcentratedCh3String = [YlabelConcentrated{1} YlabelConcentrated{2} YlabelConcentrated{3}];
                ylabel(ylabelConcentratedCh3String);
                assignin('base', 'ylabelConcentratedCh3String', ylabelConcentratedCh3String);

                subplot(4,1,4);
                plot((dataLocalShift(:,1)),dataLocalShift(:,5)*YscaleFactorCh4Numeric);         
                title({get(handles.edit5,'String')});
                xlabel('Time [s]');
                YlabelConcentrated = ['Stage error [' YscaleFactorCh4Unit ']'];
                ylabelConcentratedCh4String = [YlabelConcentrated{1} YlabelConcentrated{2} YlabelConcentrated{3}];
                ylabel(ylabelConcentratedCh4String);
                assignin('base', 'ylabelConcentratedCh4String', ylabelConcentratedCh4String);


        else                                                                           %plots separate plots

                figure(21);
                set(gcf,'Name','ScaledData Channel 1','NumberTitle','off');
                plot((dataLocalShift(:,1)),dataLocalShift(:,2)*YscaleFactorCh1Numeric);         
                title({get(handles.edit2,'String')});
                xlabel('Time [s]');
                ylabelConcentratedCh1String = evalin('base','ylabelConcentratedCh1String');
                ylabel(ylabelConcentratedCh1String);

                figure(22);
                set(gcf,'Name','ScaledData Channel 2','NumberTitle','off');
                plot((dataLocalShift(:,1)),dataLocalShift(:,3)*YscaleFactorCh2Numeric);         
                title({get(handles.edit3,'String')});
                xlabel('Time [s]');
                ylabelConcentratedCh2String = evalin('base','ylabelConcentratedCh2String');
                ylabel(ylabelConcentratedCh2String);

                figure(23);
                set(gcf,'Name','ScaledData Channel 3','NumberTitle','off');
                plot((dataLocalShift(:,1)),dataLocalShift(:,4)*YscaleFactorCh3Numeric);         
                title({get(handles.edit4,'String')});
                xlabel('Time [s]');
                ylabelConcentratedCh3String = evalin('base','ylabelConcentratedCh3String');
                ylabel(ylabelConcentratedCh3String);

                figure(24);
                set(gcf,'Name','ScaledData Channel 4','NumberTitle','off');
                plot((dataLocalShift(:,1)),dataLocalShift(:,5)*YscaleFactorCh1Numeric);        
                title({get(handles.edit5,'String')});
                xlabel('Time [s]');
                ylabelConcentratedCh4String = evalin('base','ylabelConcentratedCh4String');
                ylabel(ylabelConcentratedCh4String);


        end
end
 set(handles.pushbutton4,'Enable','on');                                        %enables calculate statistics button




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


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)                               %calculate the statistics from the time series data
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
NumberOfChannels = evalin('base','NumberOfChannels');  


switch NumberOfChannels
    
    case 1
    
        dataLocal = evalin('base','data');
        textdataLocal = evalin('base','textdata');
        TimeScale = textdataLocal{7,1};                                                         %getting time scale pro division X scale


        YscaleFactorCh1Numeric = evalin('base','YscaleFactorCh1Numeric');

        channel1 = dataLocal(:,2)*YscaleFactorCh1Numeric;                                                    %separate channels data for trimming INF

        channel1Trim = channel1(isfinite(channel1));                                            %trimming INF


        % mean

        meanChannel1 = mean(channel1Trim);

        meanConcentrated = [meanChannel1];


        % standard deviation

        stdChannel1 = std(channel1Trim);


        stdConcentrated = [stdChannel1];


        %skewness


        skewChannel1 = skewness(channel1Trim);

        skewConcentrated = [skewChannel1];


        %kurtosis


        kurtChannel1 = kurtosis(channel1Trim);


        kurtConcentrated = [kurtChannel1];

        % minumum value

        minChannel1 = min(channel1Trim);


        minConcentrated = [minChannel1];



        % maximum value

        maxChannel1 = max(channel1Trim);


        maxConcentrated = [maxChannel1];

        % number of elements in each array


        numChannel1 = numel(channel1Trim);


        numConcentrated = [numChannel1];

        statisticsConcentrated = [meanConcentrated; stdConcentrated; 3*stdConcentrated; skewConcentrated; kurtConcentrated; minConcentrated; maxConcentrated; numConcentrated];



        if get(handles.checkbox2,'Value');                                              %if Histogram is clicked plot histograms and calculate  the statistics

            if get(handles.checkbox3,'Value'); 

                rowHeaders = {'Mean','Std dev','3 Std dev', 'Skewness','Kurtosis', 'Min', 'Max', 'Elements'};

                %set the row labels
                set(handles.uitable3,'RowName',rowHeaders);

                %do the same for the column headers
                columnHeaders = [{get(handles.edit2,'String')}];

                set(handles.uitable3,'ColumnName',columnHeaders);



                %now populate the table with the above values
                set(handles.uitable3,'data',statisticsConcentrated);

                h = waitbar(0,'Calculating optimal histogram bin width. Please Wait...');
                setAlwaysOnTop(h,true);

                figure(30);
                set(gcf,'Name','Optimum bin width histograms Multiplot','NumberTitle','off');

                set(h,'windowstyle','modal');
                optN = sshist(channel1Trim); histfit(channel1Trim,optN);                    %sshist function calculates optimal number of histogram bins optN
                title({get(handles.edit2,'String')});
                ylabelConcentratedCh1String = evalin('base','ylabelConcentratedCh1String');
                xlabel(ylabelConcentratedCh1String);
                ylabel('Number of elements');

                waitbar(1);


                close(h);
            else

                rowHeaders = {'Mean','Std dev','3 Std dev', 'Skewness','Kurtosis', 'Min', 'Max', 'Elements'};

                %set the row labels
                set(handles.uitable3,'RowName',rowHeaders);

                %do the same for the column headers
                columnHeaders = [{get(handles.edit2,'String')}];

                set(handles.uitable3,'ColumnName',columnHeaders);



                %now populate the table with the above values
                set(handles.uitable3,'data',statisticsConcentrated);

                h = waitbar(0,'Calculating histograms. Please Wait...');
                setAlwaysOnTop(h,true);

                figure(31);
                set(gcf,'Name','Histograms Multiplot','NumberTitle','off');

                set(h,'windowstyle','modal');
                histfit(channel1Trim,20);                    
                title({get(handles.edit2,'String')});
                ylabelConcentratedCh1String = evalin('base','ylabelConcentratedCh1String');
                xlabel(ylabelConcentratedCh1String);
                ylabel('Number of elements');

                waitbar(1);

                close(h);
            end
                %else calculate only the statistics
        else


            rowHeaders = {'Mean','Std dev','3 Std dev', 'Skewness','Kurtosis', 'Min', 'Max', 'Elements'};

                                                                                        %set the row labels
            set(handles.uitable3,'RowName',rowHeaders);
                                                                                        %do the same for the column headers
            columnHeaders = {'Channel 1'};
            set(handles.uitable3,'ColumnName',columnHeaders);
                                                                                        %now populate the table with the above values
            set(handles.uitable3,'data',statisticsConcentrated);
        end
        
    case 2
        
        dataLocal = evalin('base','data');
        textdataLocal = evalin('base','textdata');
        TimeScale = textdataLocal{7,1};                                                         %getting time scale pro division X scale


        YscaleFactorCh1Numeric = evalin('base','YscaleFactorCh1Numeric');
        YscaleFactorCh2Numeric = evalin('base','YscaleFactorCh2Numeric');
       

        channel1 = dataLocal(:,2)*YscaleFactorCh1Numeric;                                                    %separate channels data for trimming INF
        channel2 = dataLocal(:,3)*YscaleFactorCh2Numeric;
      

        channel1Trim = channel1(isfinite(channel1));                                            %trimming INF
        channel2Trim = channel2(isfinite(channel2));
    

        % mean

        meanChannel1 = mean(channel1Trim);
        meanChannel2 = mean(channel2Trim);
        
        meanConcentrated = [meanChannel1 meanChannel2];


        % standard deviation

        stdChannel1 = std(channel1Trim);
        stdChannel2 = std(channel2Trim);
       
        stdConcentrated = [stdChannel1 stdChannel2];


        %skewness


        skewChannel1 = skewness(channel1Trim);
        skewChannel2 = skewness(channel2Trim);
    
        skewConcentrated = [skewChannel1 skewChannel2];


        %kurtosis


        kurtChannel1 = kurtosis(channel1Trim);
        kurtChannel2 = kurtosis(channel2Trim);
    
        kurtConcentrated = [kurtChannel1 kurtChannel2];

        % minumum value

        minChannel1 = min(channel1Trim);
        minChannel2 = min(channel2Trim);
     

        minConcentrated = [minChannel1 minChannel2];



        % maximum value

        maxChannel1 = max(channel1Trim);
        maxChannel2 = max(channel2Trim);
      

        maxConcentrated = [maxChannel1 maxChannel2];

        % number of elements in each array


        numChannel1 = numel(channel1Trim);
        numChannel2 = numel(channel2Trim);
      


        numConcentrated = [numChannel1 numChannel2];

        statisticsConcentrated = [meanConcentrated; stdConcentrated; 3*stdConcentrated; skewConcentrated; kurtConcentrated; minConcentrated; maxConcentrated; numConcentrated];



        if get(handles.checkbox2,'Value');                                              %if Histogram is clicked plot histograms and calculate  the statistics

            if get(handles.checkbox3,'Value'); 

                rowHeaders = {'Mean','Std dev','3 Std dev', 'Skewness','Kurtosis', 'Min', 'Max', 'Elements'};

                %set the row labels
                set(handles.uitable3,'RowName',rowHeaders);

                %do the same for the column headers
                columnHeaders = [{get(handles.edit2,'String')} {get(handles.edit3,'String')}];

                set(handles.uitable3,'ColumnName',columnHeaders);



                %now populate the table with the above values
                set(handles.uitable3,'data',statisticsConcentrated);

                h = waitbar(0,'Calculating optimal histogram bin width. Please Wait...');
                setAlwaysOnTop(h,true);

                figure(30);
                set(gcf,'Name','Optimum bin width histograms Multiplot','NumberTitle','off');
                subplot(2,1,1);
                set(h,'windowstyle','modal');
                optN = sshist(channel1Trim); histfit(channel1Trim,optN);                    %sshist function calculates optimal number of histogram bins optN
                title({get(handles.edit2,'String')});
                ylabelConcentratedCh1String = evalin('base','ylabelConcentratedCh1String');
                xlabel(ylabelConcentratedCh1String);
                ylabel('Number of elements');

                waitbar(1/2);
                %set(h,'windowstyle','modal');

                subplot(2,1,2);
                optN = sshist(channel2Trim); histfit(channel2Trim,optN);
                title({get(handles.edit3,'String')});
                ylabelConcentratedCh2String = evalin('base','ylabelConcentratedCh2String');
                xlabel(ylabelConcentratedCh2String);
                ylabel('Number of elements');

                waitbar(1); 
               

         
                close(h);
            else

                rowHeaders = {'Mean','Std dev','3 Std dev', 'Skewness','Kurtosis', 'Min', 'Max', 'Elements'};

                %set the row labels
                set(handles.uitable3,'RowName',rowHeaders);

                %do the same for the column headers
                columnHeaders = [{get(handles.edit2,'String')} {get(handles.edit3,'String')}];

                set(handles.uitable3,'ColumnName',columnHeaders);



                %now populate the table with the above values
                set(handles.uitable3,'data',statisticsConcentrated);

                h = waitbar(0,'Calculating histograms. Please Wait...');
                setAlwaysOnTop(h,true);

                figure(31);
                set(gcf,'Name','Histograms Multiplot','NumberTitle','off');
                subplot(2,1,1);
                set(h,'windowstyle','modal');
                histfit(channel1Trim,20);                    %sshist function calculates optimal number of histogram bins optN
                title({get(handles.edit2,'String')});
                ylabelConcentratedCh1String = evalin('base','ylabelConcentratedCh1String');
                xlabel(ylabelConcentratedCh1String);
                ylabel('Number of elements');

                waitbar(1/4);


                subplot(2,1,2);
                histfit(channel2Trim,20);
                title({get(handles.edit3,'String')});
                ylabelConcentratedCh2String = evalin('base','ylabelConcentratedCh2String');
                xlabel(ylabelConcentratedCh2String);
                ylabel('Number of elements');

                waitbar(1); 
                close(h);
            end
                %else calculate only the statistics
        else


            rowHeaders = {'Mean','Std dev','3 Std dev', 'Skewness','Kurtosis', 'Min', 'Max', 'Elements'};

                                                                                        %set the row labels
            set(handles.uitable3,'RowName',rowHeaders);
                                                                                        %do the same for the column headers
            columnHeaders = {'Channel 1','Channel 2'};
            set(handles.uitable3,'ColumnName',columnHeaders);
                                                                                        %now populate the table with the above values
            set(handles.uitable3,'data',statisticsConcentrated);
        end
        
    case 3
        
        dataLocal = evalin('base','data');
        textdataLocal = evalin('base','textdata');
        TimeScale = textdataLocal{7,1};                                                         %getting time scale pro division X scale


        YscaleFactorCh1Numeric = evalin('base','YscaleFactorCh1Numeric');
        YscaleFactorCh2Numeric = evalin('base','YscaleFactorCh2Numeric');
        YscaleFactorCh3Numeric = evalin('base','YscaleFactorCh3Numeric');
     

        channel1 = dataLocal(:,2)*YscaleFactorCh1Numeric;                                                    %separate channels data for trimming INF
        channel2 = dataLocal(:,3)*YscaleFactorCh2Numeric;
        channel3 = dataLocal(:,4)*YscaleFactorCh3Numeric; 
      

        channel1Trim = channel1(isfinite(channel1));                                            %trimming INF
        channel2Trim = channel2(isfinite(channel2));
        channel3Trim = channel3(isfinite(channel3));
     

        % mean

        meanChannel1 = mean(channel1Trim);
        meanChannel2 = mean(channel2Trim);
        meanChannel3 = mean(channel3Trim);
    

        meanConcentrated = [meanChannel1 meanChannel2 meanChannel3];


        % standard deviation

        stdChannel1 = std(channel1Trim);
        stdChannel2 = std(channel2Trim);
        stdChannel3 = std(channel3Trim);

        stdConcentrated = [stdChannel1 stdChannel2 stdChannel3];


        %skewness


        skewChannel1 = skewness(channel1Trim);
        skewChannel2 = skewness(channel2Trim);
        skewChannel3 = skewness(channel3Trim);
   

        skewConcentrated = [skewChannel1 skewChannel2 skewChannel3];


        %kurtosis


        kurtChannel1 = kurtosis(channel1Trim);
        kurtChannel2 = kurtosis(channel2Trim);
        kurtChannel3 = kurtosis(channel3Trim);
 

        kurtConcentrated = [kurtChannel1 kurtChannel2 kurtChannel3];

        % minumum value

        minChannel1 = min(channel1Trim);
        minChannel2 = min(channel2Trim);
        minChannel3 = min(channel3Trim);
  

        minConcentrated = [minChannel1 minChannel2 minChannel3];



        % maximum value

        maxChannel1 = max(channel1Trim);
        maxChannel2 = max(channel2Trim);
        maxChannel3 = max(channel3Trim);
    

        maxConcentrated = [maxChannel1 maxChannel2 maxChannel3];

        % number of elements in each array


        numChannel1 = numel(channel1Trim);
        numChannel2 = numel(channel2Trim);
        numChannel3 = numel(channel3Trim);


        numConcentrated = [numChannel1 numChannel2 numChannel3];

        statisticsConcentrated = [meanConcentrated; stdConcentrated; 3*stdConcentrated; skewConcentrated; kurtConcentrated; minConcentrated; maxConcentrated; numConcentrated];



        if get(handles.checkbox2,'Value');                                              %if Histogram is clicked plot histograms and calculate  the statistics

            if get(handles.checkbox3,'Value'); 

                rowHeaders = {'Mean','Std dev','3 Std dev', 'Skewness','Kurtosis', 'Min', 'Max', 'Elements'};

                %set the row labels
                set(handles.uitable3,'RowName',rowHeaders);

                %do the same for the column headers
                columnHeaders = [{get(handles.edit2,'String')} {get(handles.edit3,'String')} {get(handles.edit4,'String')}];

                set(handles.uitable3,'ColumnName',columnHeaders);



                %now populate the table with the above values
                set(handles.uitable3,'data',statisticsConcentrated);

                h = waitbar(0,'Calculating optimal histogram bin width. Please Wait...');
                setAlwaysOnTop(h,true);

                figure(30);
                set(gcf,'Name','Optimum bin width histograms Multiplot','NumberTitle','off');
                subplot(3,1,1);
                set(h,'windowstyle','modal');
                optN = sshist(channel1Trim); histfit(channel1Trim,optN);                    %sshist function calculates optimal number of histogram bins optN
                title({get(handles.edit2,'String')});
                ylabelConcentratedCh1String = evalin('base','ylabelConcentratedCh1String');
                xlabel(ylabelConcentratedCh1String);
                ylabel('Number of elements');

                waitbar(1/3);
                %set(h,'windowstyle','modal');

                subplot(3,1,2);
                optN = sshist(channel2Trim); histfit(channel2Trim,optN);
                title({get(handles.edit3,'String')});
                ylabelConcentratedCh2String = evalin('base','ylabelConcentratedCh2String');
                xlabel(ylabelConcentratedCh2String);
                ylabel('Number of elements');

                waitbar(2/3); 
                %set(h,'windowstyle','modal');

                subplot(3,1,3);
                optN = sshist(channel3Trim); histfit(channel3Trim,optN);
                title({get(handles.edit4,'String')});
                ylabelConcentratedCh3String = evalin('base','ylabelConcentratedCh3String');
                xlabel(ylabelConcentratedCh3String);
                ylabel('Number of elements');

          
                waitbar(3/3);
                close(h);
            else

                rowHeaders = {'Mean','Std dev','3 Std dev', 'Skewness','Kurtosis', 'Min', 'Max', 'Elements'};

                %set the row labels
                set(handles.uitable3,'RowName',rowHeaders);

                %do the same for the column headers
                columnHeaders = [{get(handles.edit2,'String')} {get(handles.edit3,'String')} {get(handles.edit4,'String')} {get(handles.edit5,'String')}];

                set(handles.uitable3,'ColumnName',columnHeaders);



                %now populate the table with the above values
                set(handles.uitable3,'data',statisticsConcentrated);

                h = waitbar(0,'Calculating histograms. Please Wait...');
                setAlwaysOnTop(h,true);

                figure(31);
                set(gcf,'Name','Histograms Multiplot','NumberTitle','off');
                subplot(3,1,1);
                set(h,'windowstyle','modal');
                histfit(channel1Trim,20);                    %sshist function calculates optimal number of histogram bins optN
                title({get(handles.edit2,'String')});
                ylabelConcentratedCh1String = evalin('base','ylabelConcentratedCh1String');
                xlabel(ylabelConcentratedCh1String);
                ylabel('Number of elements');

                waitbar(1/3);


                subplot(3,1,2);
                histfit(channel2Trim,20);
                title({get(handles.edit3,'String')});
                ylabelConcentratedCh2String = evalin('base','ylabelConcentratedCh2String');
                xlabel(ylabelConcentratedCh2String);
                ylabel('Number of elements');

                waitbar(2/3); 


                subplot(3,1,3);
                histfit(channel3Trim,20);
                title({get(handles.edit4,'String')});
                ylabelConcentratedCh3String = evalin('base','ylabelConcentratedCh3String');
                xlabel(ylabelConcentratedCh3String);
                ylabel('Number of elements');

                waitbar(3/3);


                close(h);
            end
                %else calculate only the statistics
        else


            rowHeaders = {'Mean','Std dev','3 Std dev', 'Skewness','Kurtosis', 'Min', 'Max', 'Elements'};

                                                                                        %set the row labels
            set(handles.uitable3,'RowName',rowHeaders);
                                                                                        %do the same for the column headers
            columnHeaders = {'Channel 1','Channel 2','Channel 3'};
            set(handles.uitable3,'ColumnName',columnHeaders);
                                                                                        %now populate the table with the above values
            set(handles.uitable3,'data',statisticsConcentrated);
        end
        
    case 4

        dataLocal = evalin('base','data');
        textdataLocal = evalin('base','textdata');
        TimeScale = textdataLocal{7,1};                                                         %getting time scale pro division X scale


        YscaleFactorCh1Numeric = evalin('base','YscaleFactorCh1Numeric');
        YscaleFactorCh2Numeric = evalin('base','YscaleFactorCh2Numeric');
        YscaleFactorCh3Numeric = evalin('base','YscaleFactorCh3Numeric');
        YscaleFactorCh4Numeric = evalin('base','YscaleFactorCh4Numeric');

        channel1 = dataLocal(:,2)*YscaleFactorCh1Numeric;                                                    %separate channels data for trimming INF
        channel2 = dataLocal(:,3)*YscaleFactorCh2Numeric;
        channel3 = dataLocal(:,4)*YscaleFactorCh3Numeric; 
        channel4 = dataLocal(:,5)*YscaleFactorCh4Numeric;

        channel1Trim = channel1(isfinite(channel1));                                            %trimming INF
        channel2Trim = channel2(isfinite(channel2));
        channel3Trim = channel3(isfinite(channel3));
        channel4Trim = channel4(isfinite(channel4));

        % mean

        meanChannel1 = mean(channel1Trim);
        meanChannel2 = mean(channel2Trim);
        meanChannel3 = mean(channel3Trim);
        meanChannel4 = mean(channel4Trim);

        meanConcentrated = [meanChannel1 meanChannel2 meanChannel3 meanChannel4];


        % standard deviation

        stdChannel1 = std(channel1Trim);
        stdChannel2 = std(channel2Trim);
        stdChannel3 = std(channel3Trim);
        stdChannel4 = std(channel4Trim);

        stdConcentrated = [stdChannel1 stdChannel2 stdChannel3 stdChannel4];


        %skewness


        skewChannel1 = skewness(channel1Trim);
        skewChannel2 = skewness(channel2Trim);
        skewChannel3 = skewness(channel3Trim);
        skewChannel4 = skewness(channel4Trim);

        skewConcentrated = [skewChannel1 skewChannel2 skewChannel3 skewChannel4];


        %kurtosis


        kurtChannel1 = kurtosis(channel1Trim);
        kurtChannel2 = kurtosis(channel2Trim);
        kurtChannel3 = kurtosis(channel3Trim);
        kurtChannel4 = kurtosis(channel4Trim);

        kurtConcentrated = [kurtChannel1 kurtChannel2 kurtChannel3 kurtChannel4];

        % minumum value

        minChannel1 = min(channel1Trim);
        minChannel2 = min(channel2Trim);
        minChannel3 = min(channel3Trim);
        minChannel4 = min(channel4Trim);

        minConcentrated = [minChannel1 minChannel2 minChannel3 minChannel4];



        % maximum value

        maxChannel1 = max(channel1Trim);
        maxChannel2 = max(channel2Trim);
        maxChannel3 = max(channel3Trim);
        maxChannel4 = max(channel4Trim);

        maxConcentrated = [maxChannel1 maxChannel2 maxChannel3 maxChannel4];

        % number of elements in each array


        numChannel1 = numel(channel1Trim);
        numChannel2 = numel(channel2Trim);
        numChannel3 = numel(channel3Trim);
        numChannel4 = numel(channel4Trim);


        numConcentrated = [numChannel1 numChannel2 numChannel3 numChannel4];

        statisticsConcentrated = [meanConcentrated; stdConcentrated; 3*stdConcentrated; skewConcentrated; kurtConcentrated; minConcentrated; maxConcentrated; numConcentrated];



        if get(handles.checkbox2,'Value');                                              %if Histogram is clicked plot histograms and calculate  the statistics

            if get(handles.checkbox3,'Value'); 

                rowHeaders = {'Mean','Std dev','3 Std dev', 'Skewness','Kurtosis', 'Min', 'Max', 'Elements'};

                %set the row labels
                set(handles.uitable3,'RowName',rowHeaders);

                %do the same for the column headers
                columnHeaders = [{get(handles.edit2,'String')} {get(handles.edit3,'String')} {get(handles.edit4,'String')} {get(handles.edit5,'String')}];

                set(handles.uitable3,'ColumnName',columnHeaders);



                %now populate the table with the above values
                set(handles.uitable3,'data',statisticsConcentrated);

                h = waitbar(0,'Calculating optimal histogram bin width. Please Wait...');
                setAlwaysOnTop(h,true);

                figure(30);
                set(gcf,'Name','Optimum bin width histograms Multiplot','NumberTitle','off');
                subplot(2,2,1);
                set(h,'windowstyle','modal');
                optN = sshist(channel1Trim); histfit(channel1Trim,optN);                    %sshist function calculates optimal number of histogram bins optN
                title({get(handles.edit2,'String')});
                ylabelConcentratedCh1String = evalin('base','ylabelConcentratedCh1String');
                xlabel(ylabelConcentratedCh1String);
                ylabel('Number of elements');

                waitbar(1/4);
                %set(h,'windowstyle','modal');

                subplot(2,2,2);
                optN = sshist(channel2Trim); histfit(channel2Trim,optN);
                title({get(handles.edit3,'String')});
                ylabelConcentratedCh2String = evalin('base','ylabelConcentratedCh2String');
                xlabel(ylabelConcentratedCh2String);
                ylabel('Number of elements');

                waitbar(2/4); 
                %set(h,'windowstyle','modal');

                subplot(2,2,3);
                optN = sshist(channel3Trim); histfit(channel3Trim,optN);
                title({get(handles.edit4,'String')});
                ylabelConcentratedCh3String = evalin('base','ylabelConcentratedCh3String');
                xlabel(ylabelConcentratedCh3String);
                ylabel('Number of elements');

                waitbar(3/4);
                %set(h,'windowstyle','modal');

                subplot(2,2,4);
                optN = sshist(channel4Trim); histfit(channel4Trim,optN);
                title({get(handles.edit5,'String')});
                ylabelConcentratedCh4String = evalin('base','ylabelConcentratedCh4String');
                xlabel(ylabelConcentratedCh4String);
                ylabel('Number of elements');

                waitbar(4/4);
                %set(h,'windowstyle','modal');
                close(h);
            else

                rowHeaders = {'Mean','Std dev','3 Std dev', 'Skewness','Kurtosis', 'Min', 'Max', 'Elements'};

                %set the row labels
                set(handles.uitable3,'RowName',rowHeaders);

                %do the same for the column headers
                columnHeaders = [{get(handles.edit2,'String')} {get(handles.edit3,'String')} {get(handles.edit4,'String')} {get(handles.edit5,'String')}];

                set(handles.uitable3,'ColumnName',columnHeaders);



                %now populate the table with the above values
                set(handles.uitable3,'data',statisticsConcentrated);

                h = waitbar(0,'Calculating histograms. Please Wait...');
                setAlwaysOnTop(h,true);

                figure(31);
                set(gcf,'Name','Histograms Multiplot','NumberTitle','off');
                subplot(2,2,1);
                set(h,'windowstyle','modal');
                histfit(channel1Trim,20);                    %sshist function calculates optimal number of histogram bins optN
                title({get(handles.edit2,'String')});
                ylabelConcentratedCh1String = evalin('base','ylabelConcentratedCh1String');
                xlabel(ylabelConcentratedCh1String);
                ylabel('Number of elements');

                waitbar(1/4);


                subplot(2,2,2);
                histfit(channel2Trim,20);
                title({get(handles.edit3,'String')});
                ylabelConcentratedCh2String = evalin('base','ylabelConcentratedCh2String');
                xlabel(ylabelConcentratedCh2String);
                ylabel('Number of elements');

                waitbar(2/4); 


                subplot(2,2,3);
                histfit(channel3Trim,20);
                title({get(handles.edit4,'String')});
                ylabelConcentratedCh3String = evalin('base','ylabelConcentratedCh3String');
                xlabel(ylabelConcentratedCh3String);
                ylabel('Number of elements');

                waitbar(3/4);


                subplot(2,2,4);
                histfit(channel4Trim,20);
                title({get(handles.edit5,'String')});
                ylabelConcentratedCh4String = evalin('base','ylabelConcentratedCh4String');
                xlabel(ylabelConcentratedCh4String);
                ylabel('Number of elements');

                waitbar(4/4);

                close(h);
            end
                %else calculate only the statistics
        else


            rowHeaders = {'Mean','Std dev','3 Std dev', 'Skewness','Kurtosis', 'Min', 'Max', 'Elements'};

                                                                                        %set the row labels
            set(handles.uitable3,'RowName',rowHeaders);
                                                                                        %do the same for the column headers
            columnHeaders = {'Channel 1','Channel 2','Channel 3','Channel 4'};
            set(handles.uitable3,'ColumnName',columnHeaders);
                                                                                        %now populate the table with the above values
            set(handles.uitable3,'data',statisticsConcentrated);
        end
end
set(handles.spectra,'Enable','on');                                             %enables spectra button


% --- Executes on button press in spectra.
function spectra_Callback(hObject, eventdata, handles)                           %calculates FFT
% hObject    handle to spectra (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

NumberOfChannels = evalin('base','NumberOfChannels');  


switch NumberOfChannels
    
    case 1
        
        dataLocal = evalin('base','data');
        textdataLocal = evalin('base','textdata');
        TimeScale = textdataLocal{7,1};                                                 %getting time scale pro division X scale


        tempNumeric = sscanf(TimeScale, ['Horizontal Scale,' '%f' ',' '%f' ',' '%f' ',' '%f']);
        TimeValue = tempNumeric(1);

        YscaleFactorCh1Numeric = evalin('base','YscaleFactorCh1Numeric');


        channel1 = dataLocal(:,2)*YscaleFactorCh1Numeric;                                            %separate channels data for trimming INF


        channel1Trim = channel1(isfinite(channel1));                                    %trimming INF's and NaN's



        SampleInterval = textdataLocal{9,1};                                            %getting Sample Interval form oszi settings 
        tempNumeric = sscanf(SampleInterval, ['Sample Interval,' '%f' ',' '%f' ',' '%f' ',' '%f']);
        Fs = 1/tempNumeric(1);


        RecordLength = textdataLocal{10,1};                                             %getting record length 
        tempNumeric = sscanf(RecordLength, ['Record Length,' '%f' ',' '%f' ',' '%f' ',' '%f']);
        L = tempNumeric(1);




        T = 1/Fs;                                                                       % Sample time
        t = (0:L-1)*T;                                                                  % Time vector         [recovers time series from above set values]


        figure(40);
        set(gcf,'Name','FFT Multiplot','NumberTitle','off');

                                                                                %channel 1
        [freqF, amplF] = FFTChannel(channel1Trim, L, Fs, handles);
        assignin('base', 'freqChannel1', freqF);
        assignin('base', 'amplChannel1', amplF);
        ChannelName = {get(handles.edit2,'String')};
        yLabelFFTCh1Title = ['Single-Sided Amplitude Spectrum of ' ChannelName];
        yLabelFFTCh1TitleConcentrated = [yLabelFFTCh1Title{1} yLabelFFTCh1Title{2}];
        title(yLabelFFTCh1TitleConcentrated);
        
    case 2
        
        dataLocal = evalin('base','data');
        textdataLocal = evalin('base','textdata');
        TimeScale = textdataLocal{7,1};                                                 %getting time scale pro division X scale


        tempNumeric = sscanf(TimeScale, ['Horizontal Scale,' '%f' ',' '%f' ',' '%f' ',' '%f']);
        TimeValue = tempNumeric(1);

        YscaleFactorCh1Numeric = evalin('base','YscaleFactorCh1Numeric');
        YscaleFactorCh2Numeric = evalin('base','YscaleFactorCh2Numeric');
      
        channel1 = dataLocal(:,2)*YscaleFactorCh1Numeric;                                            %separate channels data for trimming INF
        channel2 = dataLocal(:,3)*YscaleFactorCh2Numeric;

        channel1Trim = channel1(isfinite(channel1));                                    %trimming INF's and NaN's
        channel2Trim = channel2(isfinite(channel2));


        SampleInterval = textdataLocal{9,1};                                            %getting Sample Interval form oszi settings 
        tempNumeric = sscanf(SampleInterval, ['Sample Interval,' '%f' ',' '%f' ',' '%f' ',' '%f']);
        Fs = 1/tempNumeric(1);


        RecordLength = textdataLocal{10,1};                                             %getting record length 
        tempNumeric = sscanf(RecordLength, ['Record Length,' '%f' ',' '%f' ',' '%f' ',' '%f']);
        L = tempNumeric(1);




        T = 1/Fs;                                                                       % Sample time
        t = (0:L-1)*T;                                                                  % Time vector         [recovers time series from above set values]


        figure(40);
        set(gcf,'Name','FFT Multiplot','NumberTitle','off');

        subplot(2,1,1);                                                                         %channel 1
        [freqF, amplF] = FFTChannel(channel1Trim, L, Fs, handles);
        assignin('base', 'freqChannel1', freqF);
        assignin('base', 'amplChannel1', amplF);
        ChannelName = {get(handles.edit2,'String')};
        yLabelFFTCh1Title = ['Single-Sided Amplitude Spectrum of ' ChannelName];
        yLabelFFTCh1TitleConcentrated = [yLabelFFTCh1Title{1} yLabelFFTCh1Title{2}];
        title(yLabelFFTCh1TitleConcentrated);


        subplot(2,1,2);                                                                         %channel 2

        [freqF, amplF] = FFTChannel(channel2Trim, L, Fs, handles);
        assignin('base', 'freqChannel2', freqF);
        assignin('base', 'amplChannel2', amplF);
        ChannelName = {get(handles.edit3,'String')};
        yLabelFFTCh2Title = ['Single-Sided Amplitude Spectrum of ' ChannelName];
        yLabelFFTCh2TitleConcentrated = [yLabelFFTCh2Title{1} yLabelFFTCh2Title{2}];
        title(yLabelFFTCh2TitleConcentrated);

    case 3
        
        dataLocal = evalin('base','data');
        textdataLocal = evalin('base','textdata');
        TimeScale = textdataLocal{7,1};                                                 %getting time scale pro division X scale


        tempNumeric = sscanf(TimeScale, ['Horizontal Scale,' '%f' ',' '%f' ',' '%f' ',' '%f']);
        TimeValue = tempNumeric(1);

        YscaleFactorCh1Numeric = evalin('base','YscaleFactorCh1Numeric');
        YscaleFactorCh2Numeric = evalin('base','YscaleFactorCh2Numeric');
        YscaleFactorCh3Numeric = evalin('base','YscaleFactorCh3Numeric');


        channel1 = dataLocal(:,2)*YscaleFactorCh1Numeric;                                            %separate channels data for trimming INF
        channel2 = dataLocal(:,3)*YscaleFactorCh2Numeric;
        channel3 = dataLocal(:,4)*YscaleFactorCh3Numeric; 
 

        channel1Trim = channel1(isfinite(channel1));                                    %trimming INF's and NaN's
        channel2Trim = channel2(isfinite(channel2));
        channel3Trim = channel3(isfinite(channel3));
  


        SampleInterval = textdataLocal{9,1};                                            %getting Sample Interval form oszi settings 
        tempNumeric = sscanf(SampleInterval, ['Sample Interval,' '%f' ',' '%f' ',' '%f' ',' '%f']);
        Fs = 1/tempNumeric(1);


        RecordLength = textdataLocal{10,1};                                             %getting record length 
        tempNumeric = sscanf(RecordLength, ['Record Length,' '%f' ',' '%f' ',' '%f' ',' '%f']);
        L = tempNumeric(1);




        T = 1/Fs;                                                                       % Sample time
        t = (0:L-1)*T;                                                                  % Time vector         [recovers time series from above set values]


        figure(40);
        set(gcf,'Name','FFT Multiplot','NumberTitle','off');

        subplot(3,1,1);                                                                         %channel 1
        [freqF, amplF] = FFTChannel(channel1Trim, L, Fs, handles);
        assignin('base', 'freqChannel1', freqF);
        assignin('base', 'amplChannel1', amplF);
        ChannelName = {get(handles.edit2,'String')};
        yLabelFFTCh1Title = ['Single-Sided Amplitude Spectrum of ' ChannelName];
        yLabelFFTCh1TitleConcentrated = [yLabelFFTCh1Title{1} yLabelFFTCh1Title{2}];
        title(yLabelFFTCh1TitleConcentrated);


        subplot(3,1,2);                                                                         %channel 2

        [freqF, amplF] = FFTChannel(channel2Trim, L, Fs, handles);
        assignin('base', 'freqChannel2', freqF);
        assignin('base', 'amplChannel2', amplF);
        ChannelName = {get(handles.edit3,'String')};
        yLabelFFTCh2Title = ['Single-Sided Amplitude Spectrum of ' ChannelName];
        yLabelFFTCh2TitleConcentrated = [yLabelFFTCh2Title{1} yLabelFFTCh2Title{2}];
        title(yLabelFFTCh2TitleConcentrated);


        subplot(3,1,3);                                                                         %channel 3

        [freqF, amplF] = FFTChannel(channel3Trim, L, Fs, handles);
        assignin('base', 'freqChannel3', freqF);
        assignin('base', 'amplChannel3', amplF);
        ChannelName = {get(handles.edit4,'String')};
        yLabelFFTCh3Title = ['Single-Sided Amplitude Spectrum of ' ChannelName];
        yLabelFFTCh3TitleConcentrated = [yLabelFFTCh3Title{1} yLabelFFTCh3Title{2}];
        title(yLabelFFTCh3TitleConcentrated);


        
    case 4
        
        dataLocal = evalin('base','data');
        textdataLocal = evalin('base','textdata');
        TimeScale = textdataLocal{7,1};                                                 %getting time scale pro division X scale


        tempNumeric = sscanf(TimeScale, ['Horizontal Scale,' '%f' ',' '%f' ',' '%f' ',' '%f']);
        TimeValue = tempNumeric(1);

        YscaleFactorCh1Numeric = evalin('base','YscaleFactorCh1Numeric');
        YscaleFactorCh2Numeric = evalin('base','YscaleFactorCh2Numeric');
        YscaleFactorCh3Numeric = evalin('base','YscaleFactorCh3Numeric');
        YscaleFactorCh4Numeric = evalin('base','YscaleFactorCh4Numeric');

        channel1 = dataLocal(:,2)*YscaleFactorCh1Numeric;                                            %separate channels data for trimming INF
        channel2 = dataLocal(:,3)*YscaleFactorCh2Numeric;
        channel3 = dataLocal(:,4)*YscaleFactorCh3Numeric; 
        channel4 = dataLocal(:,5)*YscaleFactorCh4Numeric;

        channel1Trim = channel1(isfinite(channel1));                                    %trimming INF's and NaN's
        channel2Trim = channel2(isfinite(channel2));
        channel3Trim = channel3(isfinite(channel3));
        channel4Trim = channel4(isfinite(channel4));


        SampleInterval = textdataLocal{9,1};                                            %getting Sample Interval form oszi settings 
        tempNumeric = sscanf(SampleInterval, ['Sample Interval,' '%f' ',' '%f' ',' '%f' ',' '%f']);
        Fs = 1/tempNumeric(1);


        RecordLength = textdataLocal{10,1};                                             %getting record length 
        tempNumeric = sscanf(RecordLength, ['Record Length,' '%f' ',' '%f' ',' '%f' ',' '%f']);
        L = tempNumeric(1);




        T = 1/Fs;                                                                       % Sample time
        t = (0:L-1)*T;                                                                  % Time vector         [recovers time series from above set values]


        figure(40);
        set(gcf,'Name','FFT Multiplot','NumberTitle','off');

        subplot(4,1,1);                                                                         %channel 1
        [freqF, amplF] = FFTChannel(channel1Trim, L, Fs, handles);
        assignin('base', 'freqChannel1', freqF);
        assignin('base', 'amplChannel1', amplF);
        ChannelName = {get(handles.edit2,'String')};
        yLabelFFTCh1Title = ['Single-Sided Amplitude Spectrum of ' ChannelName];
        yLabelFFTCh1TitleConcentrated = [yLabelFFTCh1Title{1} yLabelFFTCh1Title{2}];
        title(yLabelFFTCh1TitleConcentrated);


        subplot(4,1,2);                                                                         %channel 2

        [freqF, amplF] = FFTChannel(channel2Trim, L, Fs, handles);
        assignin('base', 'freqChannel2', freqF);
        assignin('base', 'amplChannel2', amplF);
        ChannelName = {get(handles.edit3,'String')};
        yLabelFFTCh2Title = ['Single-Sided Amplitude Spectrum of ' ChannelName];
        yLabelFFTCh2TitleConcentrated = [yLabelFFTCh2Title{1} yLabelFFTCh2Title{2}];
        title(yLabelFFTCh2TitleConcentrated);


        subplot(4,1,3);                                                                         %channel 3

        [freqF, amplF] = FFTChannel(channel3Trim, L, Fs, handles);
        assignin('base', 'freqChannel3', freqF);
        assignin('base', 'amplChannel3', amplF);
        ChannelName = {get(handles.edit4,'String')};
        yLabelFFTCh3Title = ['Single-Sided Amplitude Spectrum of ' ChannelName];
        yLabelFFTCh3TitleConcentrated = [yLabelFFTCh3Title{1} yLabelFFTCh3Title{2}];
        title(yLabelFFTCh3TitleConcentrated);


        subplot(4,1,4);                                                                         %channel 4

        [freqF, amplF] = FFTChannel(channel4Trim, L, Fs, handles);
        assignin('base', 'freqChannel4', freqF);
        assignin('base', 'amplChannel4', amplF);
        ChannelName = {get(handles.edit5,'String')};
        yLabelFFTCh4Title = ['Single-Sided Amplitude Spectrum of ' ChannelName];
        yLabelFFTCh4TitleConcentrated = [yLabelFFTCh4Title{1} yLabelFFTCh4Title{2}];
        title(yLabelFFTCh4TitleConcentrated);
end

set(handles.pushbutton6,'Enable','on');                                             %enables find peak button


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)                      %finds peaks in the FFT spectrum
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

NumberOfChannels = evalin('base','NumberOfChannels');  


switch NumberOfChannels
    
    case 1
       
        list=get(handles.popupmenu1,'String');                                          %gets the choosen string from the channels popupmenu
        val=get(handles.popupmenu1,'Value');
        str=list{val};


        switch str                                                                      %choose the channel for calculations 
            case 'Channel 1'
               freqChannelLocal = evalin('base','freqChannel1');
               amplChannelLocal = evalin('base','amplChannel1');
               [freqPeak, amplPeak] = findChannelPeaks(freqChannelLocal, amplChannelLocal, handles);
               ChannelName = {get(handles.edit2,'String')};
               yLabelFFTCh1Title = ['Single-Sided Amplitude Spectrum of ' ChannelName];
               yLabelFFTCh1TitleConcentrated = [yLabelFFTCh1Title{1} yLabelFFTCh1Title{2}];
               title(yLabelFFTCh1TitleConcentrated);
               set(gcf,'Name','Figure 1','NumberTitle','off');

               columnHeaders = {'Ch1 Freq [Hz]', 'Ch1 Ampl'};
               peaksChannel1 = [freqPeak, amplPeak];                                    %peaks found by findpeaks algorythm
                                                                                        %user defined peaks added by data cursor
               hold on
                                                                                        %Initially, the xy list of points is empty.
               xy = [];
               n = 0;                                                                        
               but = 1;
               while but == 1
                    [xi,yi,but] = ginput(1);                                            %gets cursor positions
                    plot(xi,yi,'ro')
                    n = n+1;
                    xy(n,:) = [xi yi];
               end
               hold off;
               figureHandleCh1 = gcf;
               assignin('base', 'figureHandleCh1', figureHandleCh1);

               peaksChannel1Concentrated = [peaksChannel1; xy];                         %concentrates the peaks found by findpeaks function and the peaks added by the user
               peaksChannel1ConcentratedSorted = sortrows(peaksChannel1Concentrated,1)  %sort all peaks with respect to the index

               set(handles.uitable2,'ColumnName',columnHeaders);
               set(handles.uitable2,'data',peaksChannel1ConcentratedSorted);




        end
    
        
    case 2
        
        list=get(handles.popupmenu1,'String');                                          %gets the choosen string from the channels popupmenu
        val=get(handles.popupmenu1,'Value');
        str=list{val};


        switch str                                                                      %choose the channel for calculations 
            case 'Channel 1'
               freqChannelLocal = evalin('base','freqChannel1');
               amplChannelLocal = evalin('base','amplChannel1');
               [freqPeak, amplPeak] = findChannelPeaks(freqChannelLocal, amplChannelLocal, handles);
               ChannelName = {get(handles.edit2,'String')};
               yLabelFFTCh1Title = ['Single-Sided Amplitude Spectrum of ' ChannelName];
               yLabelFFTCh1TitleConcentrated = [yLabelFFTCh1Title{1} yLabelFFTCh1Title{2}];
               title(yLabelFFTCh1TitleConcentrated);
               set(gcf,'Name','Figure 1','NumberTitle','off');

               columnHeaders = {'Ch1 Freq [Hz]', 'Ch1 Ampl'};
               peaksChannel1 = [freqPeak, amplPeak];                                    %peaks found by findpeaks algorythm
                                                                                        %user defined peaks added by data cursor
               hold on
                                                                                        %Initially, the xy list of points is empty.
               xy = [];
               n = 0;                                                                        
               but = 1;
               while but == 1
                    [xi,yi,but] = ginput(1);                                            %gets cursor positions
                    plot(xi,yi,'ro')
                    n = n+1;
                    xy(n,:) = [xi yi];
               end
               hold off;
               figureHandleCh1 = gcf;
               assignin('base', 'figureHandleCh1', figureHandleCh1);

               peaksChannel1Concentrated = [peaksChannel1; xy];                         %concentrates the peaks found by findpeaks function and the peaks added by the user
               peaksChannel1ConcentratedSorted = sortrows(peaksChannel1Concentrated,1)  %sort all peaks with respect to the index

               set(handles.uitable2,'ColumnName',columnHeaders);
               set(handles.uitable2,'data',peaksChannel1ConcentratedSorted);



            case 'Channel 2'
               
               freqChannelLocal = evalin('base','freqChannel2');
               amplChannelLocal = evalin('base','amplChannel2');
               [freqPeak, amplPeak] = findChannelPeaks(freqChannelLocal, amplChannelLocal, handles);
               ChannelName = {get(handles.edit3,'String')};
               yLabelFFTCh2Title = ['Single-Sided Amplitude Spectrum of ' ChannelName];
               yLabelFFTCh2TitleConcentrated = [yLabelFFTCh2Title{1} yLabelFFTCh2Title{2}];
               title(yLabelFFTCh2TitleConcentrated);
               set(gcf,'Name','Figure 2','NumberTitle','off');



               columnHeaders = {'Ch2 Freq [Hz]', 'Ch2 Ampl'};
               peaksChannel2 = [freqPeak, amplPeak];


               hold on
                                                                                        % Initially, the xy list of points is empty.
               xy = [];
               n = 0;                                                                        
               but = 1;
               while but == 1
                    [xi,yi,but] = ginput(1);                                            %gets cursor positions
                    plot(xi,yi,'ro')
                    n = n+1;
                    xy(n,:) = [xi yi];
               end
               hold off;

               peaksChannel2Concentrated = [peaksChannel2; xy];                         %concentrates the peaks found by findpeaks function and the peaks added by the user
               peaksChannel2ConcentratedSorted = sortrows(peaksChannel2Concentrated,1)

               set(handles.uitable3Ch2,'ColumnName',columnHeaders);
               set(handles.uitable3Ch2,'data',peaksChannel2ConcentratedSorted);
               
               figure(5);
                ax = zeros(4,1);
                for i = 1:2
                    ax(i)=subplot(2,1,i);
                end

                % Now copy contents of each figure over to destination figure
                % Modify position of each axes as it is transferred

                for i = 1:2
                    figure(i)
                    h = get(gcf,'Children');
                    newh = copyobj(h,5)
                    for j = 1:length(newh)
                        posnewh = get(newh(j),'Position');
                        possub = get(ax(i),'Position');
                        set(newh(j),'Position',...
                        [posnewh(1) possub(2) posnewh(3) possub(4)])
                    end
                    delete(ax(i));
                end

                figure(5);
        end       
    case 3
        
        list=get(handles.popupmenu1,'String');                                          %gets the choosen string from the channels popupmenu
        val=get(handles.popupmenu1,'Value');
        str=list{val};


        switch str                                                                      %choose the channel for calculations 
            case 'Channel 1'
               freqChannelLocal = evalin('base','freqChannel1');
               amplChannelLocal = evalin('base','amplChannel1');
               [freqPeak, amplPeak] = findChannelPeaks(freqChannelLocal, amplChannelLocal, handles);
               ChannelName = {get(handles.edit2,'String')};
               yLabelFFTCh1Title = ['Single-Sided Amplitude Spectrum of ' ChannelName];
               yLabelFFTCh1TitleConcentrated = [yLabelFFTCh1Title{1} yLabelFFTCh1Title{2}];
               title(yLabelFFTCh1TitleConcentrated);
               set(gcf,'Name','Figure 1','NumberTitle','off');

               columnHeaders = {'Ch1 Freq [Hz]', 'Ch1 Ampl'};
               peaksChannel1 = [freqPeak, amplPeak];                                    %peaks found by findpeaks algorythm
                                                                                        %user defined peaks added by data cursor
               hold on
                                                                                        %Initially, the xy list of points is empty.
               xy = [];
               n = 0;                                                                        
               but = 1;
               while but == 1
                    [xi,yi,but] = ginput(1);                                            %gets cursor positions
                    plot(xi,yi,'ro')
                    n = n+1;
                    xy(n,:) = [xi yi];
               end
               hold off;
               figureHandleCh1 = gcf;
               assignin('base', 'figureHandleCh1', figureHandleCh1);

               peaksChannel1Concentrated = [peaksChannel1; xy];                         %concentrates the peaks found by findpeaks function and the peaks added by the user
               peaksChannel1ConcentratedSorted = sortrows(peaksChannel1Concentrated,1)  %sort all peaks with respect to the index

               set(handles.uitable2,'ColumnName',columnHeaders);
               set(handles.uitable2,'data',peaksChannel1ConcentratedSorted);



            case 'Channel 2'
               freqChannelLocal = evalin('base','freqChannel2');
               amplChannelLocal = evalin('base','amplChannel2');
               [freqPeak, amplPeak] = findChannelPeaks(freqChannelLocal, amplChannelLocal, handles);
               ChannelName = {get(handles.edit3,'String')};
               yLabelFFTCh2Title = ['Single-Sided Amplitude Spectrum of ' ChannelName];
               yLabelFFTCh2TitleConcentrated = [yLabelFFTCh2Title{1} yLabelFFTCh2Title{2}];
               title(yLabelFFTCh2TitleConcentrated);
               set(gcf,'Name','Figure 2','NumberTitle','off');



               columnHeaders = {'Ch2 Freq [Hz]', 'Ch2 Ampl'};
               peaksChannel2 = [freqPeak, amplPeak];


               hold on
                                                                                        % Initially, the xy list of points is empty.
               xy = [];
               n = 0;                                                                        
               but = 1;
               while but == 1
                    [xi,yi,but] = ginput(1);                                            %gets cursor positions
                    plot(xi,yi,'ro')
                    n = n+1;
                    xy(n,:) = [xi yi];
               end
               hold off;

               peaksChannel2Concentrated = [peaksChannel2; xy];                         %concentrates the peaks found by findpeaks function and the peaks added by the user
               peaksChannel2ConcentratedSorted = sortrows(peaksChannel2Concentrated,1)

               set(handles.uitable3Ch2,'ColumnName',columnHeaders);
               set(handles.uitable3Ch2,'data',peaksChannel2ConcentratedSorted);

            case 'Channel 3'
                
               freqChannelLocal = evalin('base','freqChannel3');
               amplChannelLocal = evalin('base','amplChannel3');
               [freqPeak, amplPeak] = findChannelPeaks(freqChannelLocal, amplChannelLocal, handles);
               ChannelName = {get(handles.edit4,'String')};
               yLabelFFTCh3Title = ['Single-Sided Amplitude Spectrum of ' ChannelName];
               yLabelFFTCh3TitleConcentrated = [yLabelFFTCh3Title{1} yLabelFFTCh3Title{2}];
               title(yLabelFFTCh3TitleConcentrated);
               set(gcf,'Name','Figure 3','NumberTitle','off');

               columnHeaders = {'Ch3 Freq [Hz]', 'Ch3 Ampl'};
               peaksChannel3 = [freqPeak, amplPeak];

               hold on
                                                                                        % Initially, the xy list of points is empty.
               xy = [];
               n = 0;                                                                        
               but = 1;
               while but == 1
                    [xi,yi,but] = ginput(1);                                            %gets cursor positions
                    plot(xi,yi,'ro')
                    n = n+1;
                    xy(n,:) = [xi yi];
               end
               hold off;

               peaksChannel3Concentrated = [peaksChannel3; xy];                         %concentrates the peaks found by findpeaks function and the peaks added by the user
               peaksChannel3ConcentratedSorted = sortrows(peaksChannel3Concentrated,1)


               set(handles.uitable4Ch3,'ColumnName',columnHeaders);
               set(handles.uitable4Ch3,'data',peaksChannel3ConcentratedSorted);


                figure(5);
                ax = zeros(4,1);
                for i = 1:3
                    ax(i)=subplot(3,1,i);
                end

                % Now copy contents of each figure over to destination figure
                % Modify position of each axes as it is transferred

                for i = 1:3
                    figure(i)
                    h = get(gcf,'Children');
                    newh = copyobj(h,5)
                    for j = 1:length(newh)
                        posnewh = get(newh(j),'Position');
                        possub = get(ax(i),'Position');
                        set(newh(j),'Position',...
                        [posnewh(1) possub(2) posnewh(3) possub(4)])
                    end
                    delete(ax(i));
                end

                figure(5);


        end
        
    case 4

        list=get(handles.popupmenu1,'String');                                          %gets the choosen string from the channels popupmenu
        val=get(handles.popupmenu1,'Value');
        str=list{val};


        switch str                                                                      %choose the channel for calculations 
            case 'Channel 1'
               freqChannelLocal = evalin('base','freqChannel1');
               amplChannelLocal = evalin('base','amplChannel1');
               [freqPeak, amplPeak] = findChannelPeaks(freqChannelLocal, amplChannelLocal, handles);
               ChannelName = {get(handles.edit2,'String')};
               yLabelFFTCh1Title = ['Single-Sided Amplitude Spectrum of ' ChannelName];
               yLabelFFTCh1TitleConcentrated = [yLabelFFTCh1Title{1} yLabelFFTCh1Title{2}];
               title(yLabelFFTCh1TitleConcentrated);
               set(gcf,'Name','Figure 1','NumberTitle','off');

               columnHeaders = {'Ch1 Freq [Hz]', 'Ch1 Ampl'};
               peaksChannel1 = [freqPeak, amplPeak];                                    %peaks found by findpeaks algorythm
                                                                                        %user defined peaks added by data cursor
               hold on
                                                                                        %Initially, the xy list of points is empty.
               xy = [];
               n = 0;                                                                        
               but = 1;
               while but == 1
                    [xi,yi,but] = ginput(1);                                            %gets cursor positions
                    plot(xi,yi,'ro')
                    n = n+1;
                    xy(n,:) = [xi yi];
               end
               hold off;
               figureHandleCh1 = gcf;
               assignin('base', 'figureHandleCh1', figureHandleCh1);

               peaksChannel1Concentrated = [peaksChannel1; xy];                         %concentrates the peaks found by findpeaks function and the peaks added by the user
               peaksChannel1ConcentratedSorted = sortrows(peaksChannel1Concentrated,1)  %sort all peaks with respect to the index

               set(handles.uitable2,'ColumnName',columnHeaders);
               set(handles.uitable2,'data',peaksChannel1ConcentratedSorted);



            case 'Channel 2'
               freqChannelLocal = evalin('base','freqChannel2');
               amplChannelLocal = evalin('base','amplChannel2');
               [freqPeak, amplPeak] = findChannelPeaks(freqChannelLocal, amplChannelLocal, handles);
               ChannelName = {get(handles.edit3,'String')};
               yLabelFFTCh2Title = ['Single-Sided Amplitude Spectrum of ' ChannelName];
               yLabelFFTCh2TitleConcentrated = [yLabelFFTCh2Title{1} yLabelFFTCh2Title{2}];
               title(yLabelFFTCh2TitleConcentrated);
               set(gcf,'Name','Figure 2','NumberTitle','off');



               columnHeaders = {'Ch2 Freq [Hz]', 'Ch2 Ampl'};
               peaksChannel2 = [freqPeak, amplPeak];


               hold on
                                                                                        % Initially, the xy list of points is empty.
               xy = [];
               n = 0;                                                                        
               but = 1;
               while but == 1
                    [xi,yi,but] = ginput(1);                                            %gets cursor positions
                    plot(xi,yi,'ro')
                    n = n+1;
                    xy(n,:) = [xi yi];
               end
               hold off;

               peaksChannel2Concentrated = [peaksChannel2; xy];                         %concentrates the peaks found by findpeaks function and the peaks added by the user
               peaksChannel2ConcentratedSorted = sortrows(peaksChannel2Concentrated,1)

               set(handles.uitable3Ch2,'ColumnName',columnHeaders);
               set(handles.uitable3Ch2,'data',peaksChannel2ConcentratedSorted);

            case 'Channel 3'
               freqChannelLocal = evalin('base','freqChannel3');
               amplChannelLocal = evalin('base','amplChannel3');
               [freqPeak, amplPeak] = findChannelPeaks(freqChannelLocal, amplChannelLocal, handles);
               ChannelName = {get(handles.edit4,'String')};
               yLabelFFTCh3Title = ['Single-Sided Amplitude Spectrum of ' ChannelName];
               yLabelFFTCh3TitleConcentrated = [yLabelFFTCh3Title{1} yLabelFFTCh3Title{2}];
               title(yLabelFFTCh3TitleConcentrated);
               set(gcf,'Name','Figure 3','NumberTitle','off');

               columnHeaders = {'Ch3 Freq [Hz]', 'Ch3 Ampl'};
               peaksChannel3 = [freqPeak, amplPeak];

               hold on
                                                                                        % Initially, the xy list of points is empty.
               xy = [];
               n = 0;                                                                        
               but = 1;
               while but == 1
                    [xi,yi,but] = ginput(1);                                            %gets cursor positions
                    plot(xi,yi,'ro')
                    n = n+1;
                    xy(n,:) = [xi yi];
               end
               hold off;

               peaksChannel3Concentrated = [peaksChannel3; xy];                         %concentrates the peaks found by findpeaks function and the peaks added by the user
               peaksChannel3ConcentratedSorted = sortrows(peaksChannel3Concentrated,1)


               set(handles.uitable4Ch3,'ColumnName',columnHeaders);
               set(handles.uitable4Ch3,'data',peaksChannel3ConcentratedSorted);

            case 'Channel 4'
               freqChannelLocal = evalin('base','freqChannel4');
               amplChannelLocal = evalin('base','amplChannel4');
               [freqPeak, amplPeak] = findChannelPeaks(freqChannelLocal, amplChannelLocal, handles);
               ChannelName = {get(handles.edit5,'String')};
               yLabelFFTCh4Title = ['Single-Sided Amplitude Spectrum of ' ChannelName];
               yLabelFFTCh4TitleConcentrated = [yLabelFFTCh4Title{1} yLabelFFTCh4Title{2}];
               title(yLabelFFTCh4TitleConcentrated);

               set(gcf,'Name','Figure 4','NumberTitle','off');

               columnHeaders = {'Ch4 Freq [Hz]', 'Ch4 Ampl'};
               peaksChannel4 = [freqPeak, amplPeak];

               hold on
                                                                                        % Initially, the xy list of points is empty.
               xy = [];
               n = 0;                                                                        
               but = 1;
               while but == 1
                    [xi,yi,but] = ginput(1);                                            %gets cursor positions
                    plot(xi,yi,'ro')
                    n = n+1;
                    xy(n,:) = [xi yi];
               end
               hold off;

               peaksChannel4Concentrated = [peaksChannel4; xy];                         %concentrates the peaks found by findpeaks function and the peaks added by the user
               peaksChannel4ConcentratedSorted = sortrows(peaksChannel4Concentrated,1)

               set(handles.uitable5Ch4,'ColumnName',columnHeaders);
               set(handles.uitable5Ch4,'data',peaksChannel4ConcentratedSorted);


                figure(5);
                ax = zeros(4,1);
                for i = 1:4
                    ax(i)=subplot(4,1,i);
                end

                % Now copy contents of each figure over to destination figure
                % Modify position of each axes as it is transferred

                for i = 1:4
                    figure(i)
                    h = get(gcf,'Children');
                    newh = copyobj(h,5)
                    for j = 1:length(newh)
                        posnewh = get(newh(j),'Position');
                        possub = get(ax(i),'Position');
                        set(newh(j),'Position',...
                        [posnewh(1) possub(2) posnewh(3) possub(4)])
                    end
                    delete(ax(i));
                end

                figure(5)

        end
end


% --- Executes during object creation, after setting all properties.
function MinPeakHeightedit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MinPeakHeightedit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function MinPeakDistanceedit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MinPeakDistanceedit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function [freqF, amplF] = FFTChannel(ChannelF, RecordLenghtF, SampleIntervalF, handles)     %calculates and plots the FFT spectrum for a given channel, recordlenght, and sample interval


y = ChannelF;
NFFT = 2^nextpow2(RecordLenghtF);                                               % Next power of 2 from length of y
Y = fft(y,NFFT)/RecordLenghtF;
f = SampleIntervalF/2*linspace(0,1,NFFT/2+1);

freqF=f;
amplF=2*abs(Y(1:NFFT/2+1));
semilogy(freqF,amplF); 


xlabel('Frequency (Hz)');
ylabel('|Y(f)|');

function [freqPeak, amplPeak] = findChannelPeaks(freqChannel, amplChannel, handles)     %finds and plots found peaks in the FFT spectrum

mph = str2num(get(handles.MinPeakHeightedit6,'String'));
mpd = str2num(get(handles.MinPeakDistanceedit7,'String'));
 
freqCol = tocol(freqChannel);                                                   %changes rows to columns for the findpeaks function
figure;
       
[pks,locs]=findpeaks(amplChannel,'MINPEAKHEIGHT',mph,'minpeakdistance',mpd);
semilogy(freqCol,amplChannel,'DisplayName','ampl','YDataSource','ampl'); 
hold on;
semilogy(freqCol(locs),pks,'o','markerfacecolor',[1 0 0]);

xlabel('Frequency (Hz)');
ylabel('|Y(f)|');
freqPeak = freqCol(locs);
amplPeak =pks;

function dataNullShift = dataNullShiftFunction(data)

NumberOfChannels = evalin('base','NumberOfChannels');  


switch NumberOfChannels
    
    case 1
        textdataLocal = evalin('base','textdata');
        RecordLength = textdataLocal{10,1};                                             %getting record length 
        tempNumeric = sscanf(RecordLength, ['Record Length,' '%f' ',' '%f' ',' '%f' ',' '%f']);
        L = tempNumeric(1);
        i = find(~isnan(data(:,2)));
        dataTrim=data(i(1):L,1:2);
        assignin('base', 'dataTrim', dataTrim);
        shift=abs(dataTrim(1,1));
        dataNullShift=[dataTrim(:,1)+shift,dataTrim(:,2)];
        
    case 2
        
        textdataLocal = evalin('base','textdata');
        RecordLength = textdataLocal{10,1};                                             %getting record length 
        tempNumeric = sscanf(RecordLength, ['Record Length,' '%f' ',' '%f' ',' '%f' ',' '%f']);
        L = tempNumeric(1);
        i = find(~isnan(data(:,2)));
        dataTrim=data(i(1):L,1:3);
        assignin('base', 'dataTrim', dataTrim);
        shift=abs(dataTrim(1,1));
        dataNullShift=[dataTrim(:,1)+shift,dataTrim(:,2),dataTrim(:,3)];
        
    case 3
        
        textdataLocal = evalin('base','textdata');
        RecordLength = textdataLocal{10,1};                                             %getting record length 
        tempNumeric = sscanf(RecordLength, ['Record Length,' '%f' ',' '%f' ',' '%f' ',' '%f']);
        L = tempNumeric(1);
        i = find(~isnan(data(:,2)));
        dataTrim=data(i(1):L,1:4);
        assignin('base', 'dataTrim', dataTrim);
        shift=abs(dataTrim(1,1));
        dataNullShift=[dataTrim(:,1)+shift,dataTrim(:,2),dataTrim(:,3),dataTrim(:,4)];
        
    case 4
        textdataLocal = evalin('base','textdata');
        RecordLength = textdataLocal{10,1};                                             %getting record length 
        tempNumeric = sscanf(RecordLength, ['Record Length,' '%f' ',' '%f' ',' '%f' ',' '%f']);
        L = tempNumeric(1);
        i = find(~isnan(data(:,2)));
        dataTrim=data(i(1):L,1:5);
        assignin('base', 'dataTrim', dataTrim);
        shift=abs(dataTrim(1,1));
        dataNullShift=[dataTrim(:,1)+shift,dataTrim(:,2),dataTrim(:,3),dataTrim(:,4),dataTrim(:,5)];
end



% --- Executes during object creation, after setting all properties.
function ScaleFactorCh1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ScaleFactorCh1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function ScaleFactorCh4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ScaleFactorCh4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function ScaleFactorCh3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ScaleFactorCh3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes during object creation, after setting all properties.
function ScaleFactorCh2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ScaleFactorCh2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in help.
function help_Callback(hObject, eventdata, handles)
% hObject    handle to help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

helpdlg(sprintf('The program is designed for evaluating voltage time series acquired by Tektronix digital phosphor oscilloscope (DPO). Up to one million data samples may be evaluated. The software has been tested on oscilloscope model DPO4034 with firmware version 2.58. \n\nThe software should be used from top to bottom and from left to right. Usage pattern is shown below. \n\n 1. Load Oszi Data button loads the raw csv oscilloscope data into the memory for further calculations. After successful data load procedure in the Oscilloscope Settings panel all the oscilloscope settings are listed. \n\n 2. In the Channel Name panel it is possible to change the names of the channels. Additionally, in Scale Factor panel it is also possible to change the scaling factor for the channels. The recommended values are: 1 V / 5 nm and  1 V / 50 nrad for X, Y, Z and RX, RY, RZ channels, respectively. \n\n 3. Plot RAW data button plots the original data contained in the csv file. Active Multi Plot check box assures the data to be plotted in one figure. \n\n 4. Plot Scaled Data button plots the data scaled by the scaling factors taken from the Scaled Factor panel. Active Multi Plot check box assures the data to be plotted in one figure. \n\n 5. Calculate Statistics button calculates the statistics from the scaled data and displays it in the table. For Channels X, Y, Z the statistics: Mean, Std dev, 3 Std dev, Min, Max are calculated in nm and for  RX, RY, RZ in nrad. When additionally Histogram check box is active the histograms will also be plotted. Once Optimal Bin Width check box is activated the program calculates optimal bin with. The calculations may take some time and the progress bar will be displayed. When Optimal Bin Width is not active the histograms will be displayed with bin width equal to 20. \n\n 6. Spectra button calculates and plots Single-Sided Amplitude Spectra of the scaled data. \n\n 7. Find Spectra Peaks panel allows finding of the peaks in the spectrum for one channel at a time. Two parameters are used: \n\n a) MINPEAKHEIGHT Minimum peak height Specify the minimum peak height as a real-valued scalar. findpeaks only returns peaks that exceed the MINPEAKHEIGHT. Sometimes, specifying a minimum peak height reduces processing time. Default: -Inf \n\n b) MINPEAKDISTANCE Minimum peak separation Specify the minimum peak distance, or minimum separation between peaks as a positive integer. You can use the MINPEAKDISTANCE option to specify that the algorithm ignore small peaks that occur in the neighborhood of a larger peak. When you specify a value for MINPEAKDISTANCE, the algorithm initially identifies all the peaks in the input data and sorts those peaks in descending order. Beginning with the largest peak, the algorithm ignores all identified peaks not separated by more than the value of MINPEAKDISTANCE. Default: 1 \n\n 8. Find Peaks button activates the find peaks procedure. It is also possible to choose additional peaks with left click of the mouse button. The right mouse button cancels the find peaks procedure and displays results in the Channels Peak Positions panel tables.'));

% --- Executes during object creation, after setting all properties.
function uitable3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uitable3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function MinPeakDistanceedit7_Callback(hObject, eventdata, handles)
% hObject    handle to MinPeakDistanceedit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MinPeakDistanceedit7 as text
%        str2double(get(hObject,'String')) returns contents of MinPeakDistanceedit7 as a double



function MinPeakHeightedit6_Callback(hObject, eventdata, handles)
% hObject    handle to MinPeakHeightedit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MinPeakHeightedit6 as text
%        str2double(get(hObject,'String')) returns contents of MinPeakHeightedit6 as a double


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double



function ScaleFactorCh1_Callback(hObject, eventdata, handles)
% hObject    handle to ScaleFactorCh1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ScaleFactorCh1 as text
%        str2double(get(hObject,'String')) returns contents of ScaleFactorCh1 as a double



function ScaleFactorCh2_Callback(hObject, eventdata, handles)
% hObject    handle to ScaleFactorCh2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ScaleFactorCh2 as text
%        str2double(get(hObject,'String')) returns contents of ScaleFactorCh2 as a double



function ScaleFactorCh3_Callback(hObject, eventdata, handles)
% hObject    handle to ScaleFactorCh3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ScaleFactorCh3 as text
%        str2double(get(hObject,'String')) returns contents of ScaleFactorCh3 as a double



function ScaleFactorCh4_Callback(hObject, eventdata, handles)
% hObject    handle to ScaleFactorCh4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ScaleFactorCh4 as text
%        str2double(get(hObject,'String')) returns contents of ScaleFactorCh4 as a double


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2


% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3
