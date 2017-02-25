clc
clear all

restoredefaultpath;

% %external toolboxes used for GUI
ScriptPath='E:\Bosch\ToolBox';
SubFolders = regexp(genpath(ScriptPath),['[^;]*'],'match');
for SubFolderNo=1:length(SubFolders)
    addpath(SubFolders{SubFolderNo}, '-begin')
end

% GS-FS/ENG scripts
[ScriptPath,~,~] = fileparts(mfilename('fullpath'));
SubFolders = regexp(genpath(ScriptPath),['[^;]*'],'match');
for SubFolderNo=1:length(SubFolders)
    addpath(SubFolders{SubFolderNo}, '-begin')
end

savepath userpath
