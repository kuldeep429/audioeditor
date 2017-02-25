function [Node]= GenStructureDocumentation(Structure)

%     Node.Node=[];    
    
    disp(['Start documentation of struture ' inputname(1) ' (' class(Structure) ')'])
    Node.Node=GetTreeNode(Structure);  
    Node.Name=inputname(1);
    Node.Class=class(Structure);
%     Node.Value=[];    
    GenFreemindFile(Node);    
end

function [Node]= GetTreeNode(Structure)        
    
    if isobject(Structure) ||  isstruct(Structure)
%         NodeName=properties(Structure);
        NodeName=fieldnames(Structure);
        for NodeNo=1:numel(NodeName)                    
            Node(NodeNo).Name=NodeName{NodeNo};
            SubStructure=eval(['Structure.' NodeName{NodeNo}]);
            Node(NodeNo).Class=class(SubStructure);
%             Node(PropertyNo).Value=[];
            Node(NodeNo).Node=[];            
            disp(['Adding node ' Node(NodeNo).Name ' ('  Node(NodeNo).Class ')'])
            if isobject(SubStructure) || isstruct(SubStructure)
                Node(NodeNo).Node=GetTreeNode(SubStructure);
            end
        end
    else
        Node=[];
    end
end

function [Node]= GetTreeNodeTest(Structure)
    if isobject(Structure) || isstruct(Structure)
%         NodeName=properties(Structure);
        NodeName=fieldnames(Structure);    
        NoOfNodes=numel(NodeName);
    else
        NodeName=1;
        NoOfNodes=1;
    end
    
    for NodeNo=1:NoOfNodes
        % Name, Class, Value, Node
            Node(NodeNo).Name=NodeName{NodeNo};
            
            Node(PropertyNo).Class=class(SubStructure);
%             Node(PropertyNo).Value=[];
            Node(PropertyNo).Node=[];
            
            SubStructure=eval(['Structure.' NodeName{NodeNo}]);
            if isobject(SubStructure) || isstruct(SubStructure)
                Node(PropertyNo).Node=GetTreeNode(SubStructure);
            end                        
            
        
    end
end

function [Node]= GetTreeNodeVersion1(Structure)        
    
    if isobject(Structure)
        Property=properties(Structure);
        for PropertyNo=1:numel(Property)                    
            Node(PropertyNo).Name=Property{PropertyNo};
            SubStructure=eval(['Structure.' Property{PropertyNo}]);
            Node(PropertyNo).Class=class(SubStructure);
%             Node(PropertyNo).Value=[];
            if isobject(SubStructure)
                Node(PropertyNo).Node=GetTreeNode(SubStructure);
            else
                Node(PropertyNo).Node=[];
            end                        
        end
    elseif isstruct(Structure)
   
    end
end

function []= GenFreemindFile(Node)    
    
    ThisFileName = mfilename('fullpath');
    [ThisFolder,~,~] = fileparts(ThisFileName);
%     mmFileName=fullfile(ThisFolder,['documentation of structure ' Node.Name '.mm']);    
    mmFileName=fullfile(ThisFolder,[Node.Name '.mm']);    
    
    fid=fopen(mmFileName,'wt');
    fprintf(fid,'<map version="1.0.1">\n');       
    AddFreemindNode(fid,Node)
    fprintf(fid,'</map>\n');
    fclose all;
    winopen(mmFileName)
end

function []= AddFreemindNode(fid,Node)
    NoOfNodes=numel(Node);
    for NodeNo=1:NoOfNodes
        Format.Line1=Node(NodeNo).Name;
        Format.Line2=Node(NodeNo).Class;
        Format.Color='#ffffff';
        switch Node(NodeNo).Class
            case 'struct'
% %                 Format.Color='#ffffff';
                Format.Color='#cc0000';
            otherwise
%                 Format.Color='#ff6666';
                Format.Color='#000000';
        end        
        
        if numel(Node(NodeNo).Node)==0       %~isfield(Node,'Node')              
            Format.IsEndNode=true;
            FormatFreemindNode(fid,Format)
        else
            Format.IsEndNode=false;
            FormatFreemindNode(fid,Format);
            AddFreemindNode(fid,Node(NodeNo).Node)
            fprintf(fid,'</node>\n');        
        end
    end     
end

function []= FormatFreemindNode(fid,Format)
% <b><font color="#3333ff">Report </font></b>(<font color="#cc0000">struct</font>)
    fprintf(fid,'<node>');
    fprintf(fid,'<richcontent TYPE="NODE"><html>');
      fprintf(fid,'<body>');
        fprintf(fid,'<p style="text-align: center">');
          fprintf(fid,'<b><font color="#3333ff">%s </font></b>(<font color="%s">%s</font>)', Format.Line1, Format.Color, Format.Line2);
        fprintf(fid,'</p>');
      fprintf(fid,'</body>');
    fprintf(fid,'</html>');
    fprintf(fid,'</richcontent>');

    if Format.IsEndNode
        fprintf(fid,'</node>');
    end 
end