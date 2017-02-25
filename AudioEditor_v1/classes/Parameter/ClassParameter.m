classdef ClassParameter
   properties
        Echo = ClassParameterEcho
        Filter = ClassParameterFilter
        Amplify = ClassParameterAmplify
        Noise = ClassParameterNoise
   end
   
   methods
       function obj = ClassParameter(varargin) % constructor
       end
       function [obj,ObjFound] = FindObj(Structure,ObjName)
          ObjFound = 0;
          [obj,ObjFound]= GetTreeNode(Structure,ObjName,ObjFound);
           
           function [obj,ObjFound] = GetTreeNode(Structure,ObjName,ObjFound)
               if isobject(Structure) ||  isstruct(Structure)
                   NodeName=fieldnames(Structure);
                   for NodeNo=1:numel(NodeName)
%                        Node(NodeNo).Name=NodeName{NodeNo};
                       Name = NodeName{NodeNo};
                       if ObjFound==0
                           obj='';
                       end
                       if strcmp(Name,ObjName)
                           obj = eval(['Structure.' Name]);
                           ObjFound =1;
                           return
                       end
                       SubStructure=eval(['Structure.' NodeName{NodeNo}]);
                       if (isobject(SubStructure) || isstruct(SubStructure)) && ObjFound==0
                           [obj,ObjFound]=GetTreeNode(SubStructure,ObjName,ObjFound);
                       end
                       if ObjFound==1
                           break
                       end
                   end
               else
                   obj=[];
               end
               if ObjFound==1
                   return
               end
           end
           
       end
   end
    
end