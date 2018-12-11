function varargout = AlarmSystem(varargin)



gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AlarmSystem_OpeningFcn, ...
                   'gui_OutputFcn',  @AlarmSystem_OutputFcn, ...
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



% --- Executes just before AlarmSystem is made visible.
function AlarmSystem_OpeningFcn(hObject, eventdata, handles, varargin)



handles.output = hObject;

guidata(hObject, handles);



% --- Outputs from this function are returned to the command line.
function varargout = AlarmSystem_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;


function timercallback(obj, event,handles) 
str=datestr(now, 'HH:MM:SS');
set(handles.edit1, 'String',str);


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
global videostart save monitor sound quit1 p;
%imaqhwinfo
vid=videoinput('macvideo',1);
sources=vid.Source;
set(vid,'SelectedSourceName');
selectedsrc=getselectedsource(vid);
get(selectedsrc);

set(vid,'TriggerRepeat',Inf);
set(vid,'FramesPerTrigger',1);
set(vid,'FrameGrabInterval',1);
set(vid,'ReturnedColorSpace','rgb'); 
vidRes=get(vid,'VideoResolution');
width=vidRes(1);
height=vidRes(2);
nBands=get(vid,'NumberOfBands');
axes(handles.axes1);
hImage=image(zeros(vidRes(2),vidRes(1),nBands));
preview(vid,hImage)

flag = 0;
writerObj = 0;
count = 0;
p = 0;
sound = 0;
save = 0;
videostart = 1;
filenameS = 'RealVideo';
writerObj = VideoWriter( [filenameS '.avi'] );         
writerObj.FrameRate = 8;
%open(writerObj);
t=timer('TimerFcn',{@timercallback,handles},'ExecutionMode', 'fixedSpacing', 'Period', 0.001);
start(t)

str = 30;
set(handles.edit2, 'String',str);

while (1)
   
   if save == 1
        open(writerObj);
        frame = getsnapshot(vid);
        writeVideo(writerObj,frame);
        flag = 1;
        
   end
   if save == 0 && flag == 1
        close(writerObj);
   end
   
   if sound == 1
        [y,Fs]=audioread('warningsound.WAV'); 
        p=audioplayer(y,Fs);
        play(p);
        pause(5);
   end
   
   if monitor == 1
        if (vid==0)
            msgbox('please start camera');
            return;
        end
        if rem(count,5) == 0
            mframe = getsnapshot(vid);
            level = graythresh(mframe);  
            a = im2bw(mframe,level);     

        elseif rem(count,5)== 3
              mframe1=getsnapshot(vid);
              level=graythresh(mframe1);
              b=im2bw(mframe1,level);
              z=imabsdiff(a,b);      
              x=sum(z(:));           
              s=x./(640*480);           
                if s<0.035                   
                    a=b;
                else

                            imwrite(mframe1,'monitor.jpg','jpg')
                            DataPath=['/Users/zhangzhongyong/Documents/MATLAB', filesep,'monitor.jpg']; %The path of the file you send
                            MailAddress='zl472416584@gmail.com';
                            password='ZL81789466';
                            setpref('Internet','E_mail',MailAddress);
                            setpref('Internet','SMTP_Server','smtp.gmail.com');
                            setpref('Internet','SMTP_Username',MailAddress);
                            setpref('Internet','SMTP_Password',password);
                            props=java.lang.System.getProperties;
                            props.setProperty('mail.smtp.auth','true');


                            props.setProperty('mail.smtp.socketFactory.class', 'javax.net.ssl.SSLSocketFactory');   
                            props.setProperty('mail.smtp.socketFactory.fallback', 'false');   
                            props.setProperty('mail.smtp.port', '465');   
                            props.setProperty('mail.smtp.socketFactory.port', '465'); 

                            subject='Attention:Intruder Alarm!';
                            content='Attention:Intruder Alarm!';
                            sendmail('lz1504@nyu.edu',subject,content,DataPath); %The email account you want to send, we can change it to any account
                   
                end
        end
        count = count + 1;
    end
    if quit1 == 1
        break;
        delete(vid);
        delete(hObject);

        close all;
        
    end
    pause(0.5);
end





% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global  videostart save
if videostart == 0
    msgbox('please start camera');
else
    save = 1;
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global  videostart save
if videostart == 0
    msgbox('please start camera');
else
    save = 0;
end

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global videostart monitor

if videostart == 0
    msgbox('please start camera');
else
    monitor = 1;
end



% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global  videostart ;
if videostart == 0
    msgbox('please start camera');
else
   password1;
end








% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)

global  quit1 ;
password3;
delete(handles.figure1);


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global videostart sound;

if videostart == 0
    msgbox('please start camera');
else
    sound = 1;
end



% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1
set(gca, 'vis', 'off');


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
global  videostart save monitor quit1 ;
videostart = 0
save = 0;
monitor = 0;
quit1 = 0;

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


% --- Executes on key press with focus on figure1 or any of its controls.
function figure1_WindowKeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
 keyPressed = eventdata.Key;
 if strcmpi(keyPressed,'q') == 0
     % set focus to the button
     uicontrol(handles.pushbutton8);
     % call the callback
     pushbutton8_Callback(handles.pushbutton8,[],handles);
 end
 
 
 function password1()
 global p monitor sound;
 J = inputdlg('PLEASE ENTER THE PASSWORD TO PROCEED');
 j = str2double(J);
 password = 123;             % SET IT HERE MANUALLY
 if isempty(j) == 1
    j = 456;
 end
 if (j == password)
        uiwait(msgbox('Password Correct !!'));
                monitor=0;
                sound=0;
                
 else 
 while (j ~= 123)
      if (j == password)
            uiwait(msgbox('Password Correct !!'));
            monitor=0;
            sound=0;
            stop(p);
            break;
      else
            uiwait(errordlg('Incorrect Password !!'));
            J = inputdlg('PLEASE ENTER THE PASSWORD TO PROCEED');
            j = str2double(J);
            if isempty(j) == 1
                j = 456;
            end
      end 
end
 uiwait(msgbox('Password Correct !!'));
end




function password3()
global quit1;
J = inputdlg('PLEASE ENTER THE PASSWORD TO PROCEED');
j = str2double(J);
password = 123;% SET IT HERE MANUALLY
if isempty(j) == 1
    j = 456;
end
if (j == password)
    uiwait(msgbox('Password Correct !!'));
        quit1 = 1;
        pause(1);
else 
while (j ~= 123)
    if (j == password)
        uiwait(msgbox('Password Correct !!'));

        break;
    else
        uiwait(errordlg('Incorrect Password !!'));
        J = inputdlg('PLEASE ENTER THE PASSWORD TO PROCEED');
        j = str2double(J);
        if isempty(j) == 1
            j = 456;
        end
    end 
end
 uiwait(msgbox('Password Correct !!'));
end

function pushbutton6_KeyPressFcn(hObject, eventdata, handles)
%empty

function pushbutton8_KeyPressFcn(hObject, eventdata, handles)    
%empty
