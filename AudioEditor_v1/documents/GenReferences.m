clc
clear all;
disp(['Start merging of BibTeX entries.']) 

% get all files with .paper.pdf
PublicationFolder='C:\(5.1)-Publikationen vor 2013';
FileList = rdir([PublicationFolder '\**\*.paper.pdf']); % recursive using **\
fid=fopen(fullfile(PublicationFolder,'publications.bib'),'wt');
fprintf(fid,'% This file was created with GenerateReference.\n');
fprintf(fid,'% Version of %s,\n',date);   

NoOfBibTeXEntries=0; 
for FileNo=1:numel(FileList);    
    FileName=FileList(FileNo).name;
    [pathstr, name] = fileparts(FileName); 
    BibFileName = fullfile(pathstr, strcat(name,'.bib'));

%   read text in file
    if exist(BibFileName, 'file')
        NoOfBibTeXEntries=NoOfBibTeXEntries+1;
        BibTeXEntry=textread(BibFileName,'%s', 'delimiter', '\n', 'whitespace', '');

        EntryStartPos=strfind(BibTeXEntry,'@');
        CommentLines=strfind(BibTeXEntry,'%');
        for LineNo=1:length(BibTeXEntry);      
    %         remove comment lines
            if ~strcmp(int2str(CommentLines{LineNo}),'1');
                fprintf(fid,'%s \n',BibTeXEntry{LineNo});
            end

    %       add line with pdf-file to BibTeX-entry
            if strcmp(int2str(EntryStartPos{LineNo}),'1');
               ModifiedFileName=regexprep(FileName, '\', '\\\');
               ModifiedFileName=regexprep(ModifiedFileName, ':', '\\:');
               fprintf(fid,'  file={:%s:PDF},\n',ModifiedFileName);   
            end        
        end
    else
        warning('BibTeX file ''%s'' does not exist.', BibFileName)
    end
end

fclose all;
disp(['Sucessfully merged ' int2str(NoOfBibTeXEntries) ' BibTeX entries to publications.bib.']) 
% Export BibTeX file to html
%! c:\Weichware\JabRef\JabRef -o c:\ertl\publications\publications.html,enhanced -n true c:\ertl\publications\publications.bib
%disp('Sucessfully exported BibTeX file to publications.html.') 
