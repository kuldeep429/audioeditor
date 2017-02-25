classdef ClassMotherProperties
    properties
        TargetParameter@char
        Name@char
        Value@cell
        Type@char
        InitialValue
        ReadAs
        Callback
        NumberOfBox@double =1;
        SplitStr@cell
        DynamicUpdateSource@char
        NewBox@char = 'No';
        NewBoxTitle@char
    end
    
    methods
        function obj = ClassMotherProperties() % constructor  
        end
        function obj = set.Type(obj,type)
            AvailableKeyWords = {'pushbutton','togglebutton','checkbox','radiobutton','edit','text','listbox','popupmenu','slider'};
            switch type
                case AvailableKeyWords
                    obj.Type = type;
                otherwise
                    error('Type must in one of them: pushbutton,togglebutton,checkbox,radiobutton,edit,text,listbox,popupmenu','slider');
            end
        end        
        function obj=set.ReadAs(obj,value)
            if numel(value)<2 || numel(value)>2
                error('Invalid syntex. Use syntex: {Text/Number/Logic/None, Type(pushbutton,edit etc.)}')
            else
                AvailableKeyWords = {'Text','Number','Logic',''};
                Style = value{2};
                InValue = value{1};
                if isempty(Style)
                    error('Type(second arg) cannot be empty')
                else
                    switch Style
                        case 'pushbuttonTemp' %Temp change
                            if ~isempty(InValue)
                                error('pushbutton ReadAs must be empty');
                            else
                                obj.ReadAs = InValue;
                            end
                        otherwise
                            switch InValue
                                case AvailableKeyWords
                                    obj.ReadAs = InValue;
                                otherwise
                                    error('Type must be either Text,Number or Logic');
                            end
                    end
                end
            end
        end
        function obj=set.InitialValue(obj,value)
            if numel(value)<2 || numel(value)>2
                error('Invalid syntex. Use syntex: {InitialValue, Type(pushbutton,edit etc.)}')
            else
                Style = value{2};
                InValue = value{1};
                switch Style
                    case 'edit'
                        if ~ischar(InValue)
                            error( ['Intital value must be char ' Style]);
                        else
                            obj.InitialValue = InValue;
                        end
                    case 'pushbutton'
                        obj.InitialValue = 0;
                    otherwise
                        if ~isnumeric(InValue)
                            error(['Intital value must be numeric for ' Style]);
                        else
                            obj.InitialValue = InValue;
                        end
                end
            end
        end
        
        function obj=set.NewBox(obj,InValue)
            AvailableKeyWords = {'Yes','No'};
            switch InValue
                case AvailableKeyWords
                    obj.NewBox = InValue;
                otherwise
                    error('NewBox value must be either Yes or No' );
            end
        end
    end
    
end