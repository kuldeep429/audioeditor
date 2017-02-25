%% ------------------------------------------------------------------------
%% the timer callback function definition
function plotMarker(...
    obj, ...            % refers to the object that called this function (necessary parameter for all callback functions)
    eventdata, ...      % this parameter is not used but is necessary for all callback functions
    player, ...         % we pass the audioplayer object to the callback function
    figHandle, ...      % pass the figure handle also to the callback function
    plotdata,...
    TimeDisp,...
    Fs,...
    Nochn)           % finally, we pass the data necessary to draw the new marker

% check if sound is playing, then only plot new marker
if strcmp(player.Running, 'on')
    
    % get the currently playing sample
    x = player.CurrentSample*Fs^-1;
    
    % plot the new marker
    if Nochn ==2
        % get the handle of current marker and delete the marker
        hMarker1 = findobj(figHandle{1}, 'Tag', 'ChnLine');
        hMarker2 = findobj(figHandle{2}, 'Tag', 'ChnLine');
        delete(hMarker1);
        delete(hMarker2);
        
        plot(figHandle{1},repmat(x, size(plotdata{1})), plotdata{1}, 'r', 'Tag', 'ChnLine');
        plot(figHandle{2},repmat(x, size(plotdata{1})), plotdata{2}, 'r', 'Tag', 'ChnLine');
    else
        hMarker1 = findobj(figHandle{1}, 'Tag', 'ChnLine');
        delete(hMarker1);
        plot(figHandle{1},repmat(x, size(plotdata{1})), plotdata{1}, 'r', 'Tag', 'ChnLine');
    end
    
    set(TimeDisp,'String',[sprintf('%0.2f', x),'s'])
end
