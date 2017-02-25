function cl_out = findAttrValue(obj,attr,attrName,varargin)

NumberOfClass = numel(obj);

for ClassNo=1:NumberOfClass
    Class = obj(ClassNo);
    SubClass = Class.SubEffect;
    for SubClassNo = 1:numel(SubClass)
        PropertiesNames = properties(SubClass(SubClassNo));
        [foundObj,cl_out] = ComparePropertiesName(PropertiesNames,SubClass(SubClassNo));
        if foundObj
            return
        else
            cl_out = '';
        end
    end    
end

    function [foundObj,obj] = ComparePropertiesName(PropertiesNames,obj)
        foundObj = 0;
        for ProNo = 1:numel(PropertiesNames)
            if strcmp(PropertiesNames(ProNo),attr) && eval(['strcmp(obj.', attr ',' , 'attrName', ')'])
            foundObj = 1;
            break
            end
        end        
    end

end