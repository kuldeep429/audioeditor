clc
clear all
% function = GenFunctionDocumentation()

%  matlab.desktop.editor.openAndGoToLine('fullpath and filename',linenumber)
% hEditor = matlab.desktop.editor.getActive;
% hEditor.goToLine(line_number)

disp(['Start documentation of user defined matlab functions.'])

%% I/O
ThisFileName = mfilename('fullpath');
[ThisFolder,~,~] = fileparts(ThisFileName);
MatlabPath=fileparts(ThisFolder); % one level up
FileList = rdir([MatlabPath '\**\*.m']); % recursive using **\

mmFileName=fullfile(ThisFolder,'matlab function documentation.mm');
SubFolderPath = regexp(genpath(MatlabPath),['[^;]*'],'match');
SubFolderName = strrep(SubFolderPath,[MatlabPath '\'],'');
for PathNo=1:numel(SubFolderPath)
    SubFolder(PathNo).Path=SubFolderPath{PathNo};
    SubFolder(PathNo).Name=SubFolderName{PathNo};
    SubFolder(PathNo).Functions.Index=[];
    SubFolder(PathNo).Scripts.Index=[];
end

%% get file informations
NumberOfFiles=numel(FileList);
disp(['    Status: ' num2str(NumberOfFiles) ' m-files available in folder ' MatlabPath '.'])
for FileNo = 1: NumberOfFiles
    FileList(FileNo).IsCalling=[];
    FileList(FileNo).IsUsedBy=[];    
    FileList(FileNo).FullFile=fullfile(FileList(FileNo).name);
    [FileList(FileNo).FilePath,FileList(FileNo).FileName] = fileparts(FileList(FileNo).FullFile);
    % set hyperlink
    Link=strrep(FileList(FileNo).FullFile,' ','%20');
    Link=strrep(Link,'\','/');
    Link=strrep(Link,'C:/','');    
%     FileList(FileNo).Link=['LINK="../../../' Link '"'];
    FileList(FileNo).Link=['LINK="../../../' Link '"'];
    % search for functions
    FileList(FileNo).IsFunction=isfunction(FileList(FileNo).FileName);
    % assing file to subfolder
    for PathNo=1:numel(SubFolder)
        if strcmp(SubFolder(PathNo).Path,FileList(FileNo).FilePath)
            switch FileList(FileNo).IsFunction
                case true
                    SubFolder(PathNo).Functions.Index=[SubFolder(PathNo).Functions.Index FileNo];
                case false
                    SubFolder(PathNo).Scripts.Index=[SubFolder(PathNo).Scripts.Index FileNo];
            end            
        end
    end
end
FileList = rmfield(FileList,'name');
FileList = rmfield(FileList,'date');
FileList = rmfield(FileList,'bytes');
FileList = rmfield(FileList,'isdir');
FileList = rmfield(FileList,'datenum');


for FileNo = 1:NumberOfFiles
    disp(['    Check dependencies in file ' int2str(FileNo) '/' int2str(NumberOfFiles) ': ' FileList(FileNo).FileName])    
    CalledFunctions = matlab.codetools.requiredFilesAndProducts(FileList(FileNo).FullFile,'toponly');
    for CalledFunctionNo=1:numel(CalledFunctions)
        Index = find(strcmp({FileList.FullFile}, CalledFunctions{CalledFunctionNo})==1);
        if Index ~= FileNo
            FileList(FileNo).IsCalling=[FileList(FileNo).IsCalling Index];        
        end
    end
end    
    
%     FileText = fileread(FileList(FileNo).FullFile);
%     for FunctionNo=1:numel(FunctionList)
%         if ~strcmp(FunctionList(FunctionNo).FileName,FileList(FileNo).FileName)
%             % search for lines including the function name
%             expr = ['[^\n]*' FunctionList(FunctionNo).FileName '(' '[^\n]*']; % each line is separated by a newline ('\n')
%             LineString = regexp(FileText,expr,'match');
%             
% %             expr = ['[^\n]*' FunctionList(FunctionNo).FileName '(' '[^\n]*']; % each line is separated by a newline ('\n')
% %             expr='PowerPoint(\w+)';
% %             LineString = regexp(FileText,expr)
%             for LineNo=1:numel(LineString)                
%                 CommentPos=strfind(LineString{LineNo},'%');
%                 FunctionPos=strfind(LineString{LineNo},[FunctionList(FunctionNo).FileName '(']);
%                 CommentPos<FunctionPos
%                 if CommentPos<FunctionPos
%                     disp(['--- Commented function call of ' FunctionList(FunctionNo).FileName])
%                 else
%                     disp(['+++ Valid function call of ' FunctionList(FunctionNo).FileName])
%                 end
% %                 continue
%             end
%         end
%     end
% end

%% assign IsUsedBy: check if function is used in the files in FileList
for FunctionFileNo=1:NumberOfFiles%50:51 %1:numel(FileList)
    if FileList(FunctionFileNo).IsFunction
        for FileNo=1:NumberOfFiles
            Index = find(FileList(FileNo).IsCalling == FunctionFileNo);            
            if ~isempty(Index)
                 FileList(FunctionFileNo).IsUsedBy=[FileList(FunctionFileNo).IsUsedBy FileNo];
            end
        end
    end
end

%% generate freemind file
fid=fopen(mmFileName,'wt');
fprintf(fid,'<map version="1.0.1">\n');
    fprintf(fid,'<node TEXT="GS-FS NVH matlab functions">\n'); 
        % functions
        fprintf(fid,'<node TEXT="functions" FOLDED="false" POSITION="right"> \n'); 
        for PathNo = 1:numel(SubFolderName)
            if ~isempty(SubFolder(PathNo).Functions.Index)
                fprintf(fid,'<node TEXT="%s">\n',SubFolder(PathNo).Name);
                for IndexNo = 1:numel(SubFolder(PathNo).Functions.Index)
                    FileNo=SubFolder(PathNo).Functions.Index(IndexNo);
                    if FileList(FileNo).IsFunction
                        if isempty(FileList(FileNo).IsUsedBy)
                            ColorText='COLOR="#cc0033"';
                        else
                            ColorText='';
                        end
                        fprintf(fid,'<node %s TEXT="%s" %s >\n',FileList(FileNo).Link,FileList(FileNo).FileName,ColorText);                    
                            % is used by node                      
                            if ~isempty(FileList(FileNo).IsUsedBy)
                                fprintf(fid,'<node TEXT="%s" FOLDED="false" >\n','is used by');
                                for IsUsedByNo=1:numel(FileList(FileNo).IsUsedBy)
                                    IsUsedByFileNo=FileList(FileNo).IsUsedBy(IsUsedByNo);
                                    fprintf(fid,'<node %s TEXT="%s"/>\n',FileList(IsUsedByFileNo).Link,FileList(IsUsedByFileNo).FileName);                    
                                end                            
                                fprintf(fid,'</node>\n');
                            end                        
                            % is calling node
                            if ~isempty(FileList(FileNo).IsCalling)
                                fprintf(fid,'<node TEXT="%s" FOLDED="true" >\n','is calling');
                                for IsCallingNo=1:numel(FileList(FileNo).IsCalling)
                                    IsCallingFileNo=FileList(FileNo).IsCalling(IsCallingNo);
                                    fprintf(fid,'<node %s TEXT="%s"/>\n',FileList(IsCallingFileNo).Link,FileList(IsCallingFileNo).FileName);                    
                                end
                                fprintf(fid,'</node>\n');
                            end
                        fprintf(fid,'</node>\n');
                    end
                end             
                fprintf(fid,'</node>\n');
            end
        end
        fprintf(fid,'</node>\n');
        % scripts
        fprintf(fid,'<node TEXT="scripts" FOLDED="false" POSITION="left"> \n'); 
        for PathNo = 1:numel(SubFolderName)
            if ~isempty(SubFolder(PathNo).Scripts.Index)
                fprintf(fid,'<node TEXT="%s">\n',SubFolder(PathNo).Name);
                for IndexNo = 1:numel(SubFolder(PathNo).Scripts.Index)
                    FileNo=SubFolder(PathNo).Scripts.Index(IndexNo);
                    if ~FileList(FileNo).IsFunction
                        fprintf(fid,'<node %s TEXT="%s">\n',FileList(FileNo).Link,FileList(FileNo).FileName);                    
                            % is used by node                      
                            if ~isempty(FileList(FileNo).IsUsedBy)
                                fprintf(fid,'<node TEXT="%s" FOLDED="false" >\n','is used by');
                                for IsUsedByNo=1:numel(FileList(FileNo).IsUsedBy)
                                    IsUsedByFileNo=FileList(FileNo).IsUsedBy(IsUsedByNo);
                                    fprintf(fid,'<node %s TEXT="%s"/>\n',FileList(IsUsedByFileNo).Link,FileList(IsUsedByFileNo).FileName);                    
                                end                            
                                fprintf(fid,'</node>\n');
                            end                        
                        fprintf(fid,'</node>\n');
                    end
                end             
                fprintf(fid,'</node>\n');
            end
        end
        fprintf(fid,'</node>\n'); 
    fprintf(fid,'</node>\n');
fprintf(fid,'</map>\n');
fclose all;
winopen(mmFileName)
