function AudioEditor()
close all
clear all
Interfacedata = creatdata();
gui = creatgui(Interfacedata);

    function gui= creatgui(Interfacedata)
        %% Construct GUI fig
        gui.Window = figure( ...
            'Name', 'Audio Editor', ... 
            'NumberTitle', 'off', ...
            'Menubar','none',...
            'Toolbar', 'figure', ...
            'HandleVisibility', 'on', 'Position',[200 136 1024 450]);
        %% Setting background
        gui.BackgroundLayer0_VBox = uix.VBoxFlex('Parent', gui.Window,'Padding',0, 'Spacing', 2);
        
        gui.BackgroundVBox1 = uix.HBoxFlex('Parent', gui.BackgroundLayer0_VBox,'Padding',1, 'Spacing', 2);
        gui.BackgroundVBox2 = uix.HBoxFlex('Parent', gui.BackgroundLayer0_VBox,'Padding',1, 'Spacing', 5);
        gui.BackgroundVBox3 = uix.Panel('Parent', gui.BackgroundLayer0_VBox,'Padding',2);
        
        set(gui.BackgroundLayer0_VBox,'Heights',[-1,-0.25,30])
        
        %% Working on first vertical box
        % Effects and file tab
        gui.ParentTab = uix.TabPanel('Parent', gui.BackgroundVBox1,'Padding',1);
        gui.FileTab = uix.Panel('Parent', gui.ParentTab);
        gui.EffectTab = uix.Panel('Parent', gui.ParentTab);
        gui.ParentTab.TabTitles = {'Files', 'Effects'};
        
        %File tab
        gui.FileVBox = uix.VBox('Parent', gui.FileTab,'Padding',0);
        gui.ImportControlBox = uix.Panel('Parent', gui.FileVBox,'Padding',0);        
        gui.FileDisplayBox = uix.Panel('Parent', gui.FileVBox,'Padding',0);
        set(gui.FileVBox,'Heights',[25,-1]);
        
        %File tab Inco setting
        gui.FileTabHButtons = uix.HButtonBox('Parent',gui.ImportControlBox,'Spacing',2);
        g=readfig('import.png');
        uicontrol('Parent', gui.FileTabHButtons, 'CData',g,'Callback', @ImportFile);
        g=readfig('delete.png');
        uicontrol('Parent', gui.FileTabHButtons, 'CData',g, 'Callback', @RemoveFile);
        set( gui.FileTabHButtons, 'ButtonSize', [20 20], 'Spacing', 5,'HorizontalAlignment','left' );
        
        % Waveform and spectrum display tab
        gui.ParentDisplayTab = uix.TabPanel('Parent', gui.BackgroundVBox1,'Padding',1);
        gui.WaveformDispVBox = uix.VBox('Parent', gui.ParentDisplayTab,'Padding',0);
        gui.SpectrumDispVBox = uix.VBox('Parent', gui.ParentDisplayTab);
        gui.ParentDisplayTab.TabTitles = {'Waveform', 'Spectrum'};
        
        set(gui.BackgroundVBox1,'Widths',[200,-1]);
        
        %% Working with second vertical box
        gui.PlayControlPanel = uix.Panel('Parent',gui.BackgroundVBox2,'Padding',1);
        gui.TimeDisplayPanel = uix.Panel('Parent',gui.BackgroundVBox2,'Padding',1);
        gui.OtherControlPnael = uix.Panel('Parent',gui.BackgroundVBox2,'Padding',1);
        
        set(gui.BackgroundVBox2,'Widths',[199,150,-1]);
        
        %% Add PlayControlButtons
        gui.HButtonsParent = uix.HButtonBox('Parent',gui.PlayControlPanel,'Spacing',3);
        g=readfig('Play.jpg');
        uicontrol('Parent', gui.HButtonsParent, 'CData',g, 'Callback',@PlaySound);
        g=readfig('pause.jpg');
        uicontrol('Parent', gui.HButtonsParent, 'CData',g,'Callback',@PauseSound);
        g=readfig('stop.jpg');
        uicontrol('Parent', gui.HButtonsParent, 'CData',g, 'Callback',@StopSound);
        set( gui.HButtonsParent, 'ButtonSize', [50 50], 'Spacing', 5 );
        
        %% Time display
        gui.TimeDisplayPanelHBox= uix.HButtonBox('Parent',gui.TimeDisplayPanel,'Spacing',2);
        uicontrol('Parent',gui.TimeDisplayPanelHBox,'style','Text','String','Time:','FontSize', 12,...
            'FontWeight','bold','HorizontalAlignment','right');
        gui.TimeDispay = uicontrol('Parent',gui.TimeDisplayPanelHBox,'Style','Text','String','0s','FontSize', 12,...
            'FontWeight','bold','HorizontalAlignment','left');
        
        %% Waveform tab
        gui.WaveformDisp1 = uix.Panel('Parent', gui.WaveformDispVBox);
        gui.WaveformDisp2 = uix.Panel('Parent', gui.WaveformDispVBox);
        
        gui.WaveformAxisChn1 = axes('Parent', gui.WaveformDisp1,'Box','on','ylim',[-2,2],'xlim',[0,10],...
            'XGrid','on','YGrid','on','FontSize',7); %'PlotBoxAspectRatio',[3,1,0.75]
        %set(gca,'BoxStyle','tight');
        gui.WaveformAxisChn2 = axes('Parent', gui.WaveformDisp2,'Box','on','ylim',[-2,2],'xlim',[0,10],...
            'XGrid','on','YGrid','on','FontSize',7);
        
        %% Spectrum tab
        gui.SpectrumDisp1 = uicontainer('Parent', gui.SpectrumDispVBox);
        gui.SpectrumDisp2 = uicontainer('Parent', gui.SpectrumDispVBox);
        
        gui.SpectrumDispChn1 = axes('Parent', gui.SpectrumDisp1,'Box','on','ylim',[-2,2],'xlim',[0,10],...
            'XGrid','on','YGrid','on','FontSize',7); %'PlotBoxAspectRatio',[3,1,0.75]
        %set(gca,'BoxStyle','tight');
        gui.SpectrumDispChn2 = axes('Parent', gui.SpectrumDisp2,'Box','on','ylim',[-2,2],'xlim',[0,10],...
            'XGrid','on','YGrid','on','FontSize',7);
        
        
        %% Effects
        TotalEffectsNo = numel(Interfacedata.Effects);
        % Creat Checkbox tree
        import uiextras.jTree.*
        gui.EffectTree.t = Tree('Parent',gui.EffectTab,'RootVisible','off','MouseClickedCallback',{@ShowParameterBox,Interfacedata});
        gui.EffectTree.EffectRoot = TreeNode('Name','Effects','Parent',gui.EffectTree.t);%
        for EffectNo = 1:TotalEffectsNo            
            EffectName = Interfacedata.Effects(EffectNo).EffectName;
            gui.EffectTree.EffectsNode{EffectNo} = TreeNode('Name',EffectName,'Parent',gui.EffectTree.EffectRoot);
            SubEffects = Interfacedata.Effects(EffectNo).SubEffect;
            for SubEffect = 1:numel(SubEffects)
                SubEffectName = Interfacedata.Effects(EffectNo).SubEffect(SubEffect).SubEffectName;
                TreeNode('Name',SubEffectName,'Parent',gui.EffectTree.EffectsNode{EffectNo});
%                 gui.EffectTree.EffectsNode{EffectNo}.SubEffect{SubEffect} = TreeNode('Name',SubEffectName,'Parent',gui.EffectTree.EffectsNode{EffectNo});
            end                        
        end       
    end

%% Callbacks
    function ShowParameterBox(varargin)
        persistent chk
        if isempty(chk)
            chk = 1;
            pause(0.2); %Add a delay to distinguish single click from a double click
            if chk == 1            
                fprintf(1,'\nI am doing a single-click.\n\n');
                chk = [];
            end
        else
            chk = [];
            fprintf(1,'\nI am doing a double-click.\n\n');
            
            CalledEffect = varargin{2};
            Data = varargin{3};
            
            AllEffectNames = {Data.Effects(1:end).EffectName};
            EffectName = CalledEffect.Nodes.Name;
            
            SubEffectClass = findAttrValue(Data.Effects,'SubEffectName',EffectName);
            
            if ~isempty(SubEffectClass)
                Properties = SubEffectClass.SubEffectProperties;
                
                % Build property window
                gui.popupwindow.fig = figure('Name', EffectName, ...
                    'NumberTitle', 'off', ...
                    'Menubar','none',...
                    'HandleVisibility', 'on');
                
                gui.popupwindow.VBox = uix.VBox('Parent',gui.popupwindow.fig);
                
                gui.popupwindow.HBox1 = uix.HBox('Parent',gui.popupwindow.VBox);
                gui.popupwindow.LeftVBox = uix.VBox('Parent',gui.popupwindow.HBox1,'Spacing',6);
                gui.popupwindow.RightVBox = uix.VBox('Parent',gui.popupwindow.HBox1,'Spacing',6);
                
                gui.popupwindow.HBox2 = uix.HButtonBox('Parent',gui.popupwindow.VBox,'Spacing',6);
                set(gui.popupwindow.VBox,'Heights',[-1,30]);
                
                for ProNo = 1:numel(Properties)
                    Target = Properties(ProNo).TargetParameter;
                    Name =  Properties(ProNo).Name;
                    Value = Properties(ProNo).Value;
                    InitialValue = Properties(ProNo).InitialValue;
                    Type = Properties(ProNo).Type;
                    uicontrol('Parent',gui.popupwindow.LeftVBox,'Style','Text','String',Name,'HorizontalAlignment','left');
                    switch lower(Type)
                        case 'slider'
                            gui.popupwindow.PrameterValues(ProNo)= uicontrol('Parent',gui.popupwindow.RightVBox,'Style',Type,'Value',InitialValue(1),'min',InitialValue(2),'max',InitialValue(3), 'UserData',Target);
                        case 'edit'
                            gui.popupwindow.PrameterValues(ProNo)= uicontrol('Parent',gui.popupwindow.RightVBox,'Style',Type,'string',InitialValue, 'UserData',Target);
                        case 'popupmenu'
                            gui.popupwindow.PrameterValues(ProNo)= uicontrol('Parent',gui.popupwindow.RightVBox,'Style',Type,'string',Value, 'Value',InitialValue,'UserData',Target);
                        otherwise
                            gui.popupwindow.PrameterValues(ProNo)= uicontrol('Parent',gui.popupwindow.RightVBox,'Style',Type,'Value',InitialValue, 'UserData',Target);
                    end
                end
                set(gui.popupwindow.LeftVBox,'Heights',ones(1,ProNo)*20);
                set(gui.popupwindow.RightVBox,'Heights',ones(1,ProNo)*20);
                set(gui.popupwindow.fig,'Position',[500 400 300 (30*ProNo)+30])
                
                %             gui.EffectWindowButton = uix.HButtonBox('Parent',gui.popupwindow.VBox,'Spacing',3);
                uicontrol('Parent',gui.popupwindow.HBox2,'String','Compute','Callback',{@Compute,EffectName});
                uicontrol('Parent',gui.popupwindow.HBox2,'String','Cancel','Callback',@CancleButtonCall)
            else
                % nothing
            end
        end
    end
    
    %%
    function ImportFile(varargin)      
        [FileName,PathName] = uigetfile();
        FullfileName = [PathName,FileName];
        
        hold(gui.WaveformAxisChn1,'off')
        hold(gui.WaveformAxisChn2,'off')
        
        % Time
        [Amplitude,Fs]= audioread(FullfileName);
        gui.Data.ImportedFile.Time.Amplitude = Amplitude;
        gui.Data.ImportedFile.Time.Fs = Fs;
        TotalTime = numel(Amplitude(:,1))*(Fs)^-1;
        t= 0:(Fs)^-1:(TotalTime-(Fs)^-1);
        gui.Data.ImportedFile.Time.t=t;
        
        [FFTArray,Frequency,WindowTime]=StartFFT(t,Amplitude);
        
        gui.Data.ImportedFile.FFT.Amplitude = FFTArray;
        gui.Data.ImportedFile.FFT.f = Frequency;
        gui.Data.ImportedFile.FFT.WindowTime = WindowTime;
        
        if size(Amplitude,2)==1
            gui.Data.ImportedFile.NoChn = 1;
        else
            gui.Data.ImportedFile.NoChn = 2;
        end
        
        import uiextras.jTree.*
        gui.SelectedFile.Tree = Tree('Parent', gui.FileDisplayBox,'RootVisible','off','MouseClickedCallback',{@UpdateGraph});
        gui.SelectedFile.FileRoot = TreeNode('Name','File','Parent',gui.SelectedFile.Tree);%
        gui.SelectedFile.FilesNode = TreeNode('Name',FileName,'Parent',gui.SelectedFile.FileRoot);
    end
    %%
    function UpdateGraph(varargin)
        persistent chk
        if isempty(chk)
            chk = 1;
            pause(0.2); %Add a delay to distinguish single click from a double click
            if chk == 1
                fprintf(1,'\nI am doing a single-click.\n\n');
                chk = [];
            end
        else
            chk = [];
            fprintf(1,'\nI am doing a double-click.\n\n');
            
            ParentTree = varargin{1};
            Event = varargin{2};
            AllData = gui.Data;
            SelectedFileName = Event.Nodes.Name;
            AllNodeName = {ParentTree.Root.Children.Children(1:end).Name};
            
            Pos=0;
            for NodeNo = 1:numel(AllNodeName)
                if strcmp(SelectedFileName,AllNodeName{NodeNo})
                    Pos=NodeNo;
                    break
                end
            end
            
            SelectedNodeData = AllData(Pos).ImportedFile; 
            gui = UpdateAxis(gui,SelectedNodeData.Time.Amplitude,SelectedNodeData.Time.t,SelectedNodeData.FFT.Amplitude,SelectedNodeData.FFT.f,SelectedNodeData.FFT.WindowTime);            
            set(gui.TimeDispay,'String',['0.00','s'])
        end
    end
%%
    function PlaySound(varargin)
        plotdata1 = [gui.WaveformAxisChn1.YLim(1):0.1:gui.WaveformAxisChn1.YLim(2)]; 
        hold(gui.WaveformAxisChn1,'on')
        delete(findobj(gui.WaveformAxisChn1, 'Tag', 'ChnLine1'))
        plot(gui.WaveformAxisChn1,zeros(size(plotdata1)), plotdata1, 'r','Tag','ChnLine'); % plot the marker
        
        plotdata2 = [gui.WaveformAxisChn2.YLim(1):0.1:gui.WaveformAxisChn2.YLim(2)]; 
        hold(gui.WaveformAxisChn2,'on')
        delete(findobj(gui.WaveformAxisChn2, 'Tag', 'ChnLine2'))
        plot(gui.WaveformAxisChn2,zeros(size(plotdata2)), plotdata2, 'r','Tag','ChnLine'); % plot the marker
        
        Chan1Data = findobj(gui.WaveformAxisChn1,'Tag','Chan1Data');
        Chan2Data = findobj(gui.WaveformAxisChn2,'Tag','Chan2Data');
        
        %check for valid handle
        [y,x]=checkValidHandle(Chan1Data,Chan2Data);
        
        % Sampling frequency
        Fs = 1/(x(2)-x(1));

        % instantiate the audioplayer object
        gui.player = audioplayer(y, Fs);
        
        % setup the timer for the audioplayer object
        gui.player.TimerFcn = {@plotMarker, gui.player,...
            {gui.WaveformAxisChn1,gui.WaveformAxisChn2}, {plotdata1,plotdata2},gui.TimeDispay,Fs,gui.Data.ImportedFile.NoChn}; % timer callback function (defined below)
        gui.player.TimerPeriod = 0.01; % period of the timer in seconds
        
        % start playing the audio
        % this will move the marker over the audio plot at intervals of 0.01 s
        play(gui.player);
    end

    function PauseSound(varargin)
        pause(gui.player);
    end

    function StopSound(varargin)
        stop(gui.player);
    end
%%
    function Compute(varargin)
        % Stop player
%         if strcmp(gui.player.Running, 'on')
%             stop(gui.player)
%         end
        set(gui.popupwindow.fig,'Visible','off')
        drawnow
        Parameter = ClassParameter;
        ValidFieldsIdx = ~isvalid(gui.popupwindow.PrameterValues);
        gui.popupwindow.PrameterValues(ValidFieldsIdx)=[];
        for ParNo = 1: numel(gui.popupwindow.PrameterValues)
            Target = gui.popupwindow.PrameterValues(ParNo).UserData;
            Style = gui.popupwindow.PrameterValues(ParNo).Style;
            
            switch lower(Style)
                case 'edit'
                    Value = str2double(gui.popupwindow.PrameterValues(ParNo).String);
                case 'popupmenu'
                    Indx = gui.popupwindow.PrameterValues(ParNo).Value;
                    String = gui.popupwindow.PrameterValues(ParNo).String;
                    Value = String{Indx};
                otherwise
                    Value = gui.popupwindow.PrameterValues(ParNo).Value;
            end            
            eval([Target,'=','Value',';']);
        end 
        
        Chan1Data = findobj(gui.WaveformAxisChn1,'Tag','Chan1Data');
        Chan2Data = findobj(gui.WaveformAxisChn2,'Tag','Chan2Data');
        
        [y,x]=checkValidHandle(Chan1Data,Chan2Data);
        
        Fs = 1/(x(2)-x(1));
        
        Effect = varargin{3};
        [SubEffectClass,FoundFlag] = FindObj(Parameter,Effect);
        if FoundFlag
            switch lower(Effect)
                case 'mono echo'
                    [t,y,FFTArray,Frequency,WindowTime] = InitiateEchoEffect(y,Fs,Parameter);
                case 'lowpass'
                    [t,y,FFTArray,Frequency,WindowTime] = InitiateFilter(y,Fs,SubEffectClass,Effect);
                case 'highpass'
                    [t,y,FFTArray,Frequency,WindowTime] = InitiateFilter(y,Fs,SubEffectClass,Effect);
                case 'bandpass'
                    [t,y,FFTArray,Frequency,WindowTime] = InitiateFilter(y,Fs,SubEffectClass,Effect);
                otherwise
                    error('Undefined Effect')
            end
            gui = UpdateAxis(gui,y,t,FFTArray,Frequency,WindowTime);
            close(gui.popupwindow.fig)
        end
    end

    %% Check for valid handle
    function [y,x]=checkValidHandle(Chan1Data,Chan2Data)
        %check for valid handle
        if ~isempty(Chan1Data)&& ~isempty(Chan2Data)
            y=[Chan1Data.YData(:),Chan2Data.YData(:)];
            x = Chan2Data.XData;
        elseif ~isempty(Chan1Data)
            y=Chan1Data.YData(:);
            x = Chan1Data.XData;
        elseif ~isempty(Chan2Data)
            y=Chan2Data.YData(:);
            x = Chan2Data.XData;
        end
    end
end