classdef ClassParameterFilter
   properties
        Lowpass = ClassParameterLowpass
        Highpass = ClassParameterHighpass
        Bandpass = ClassParameterBandpass
   end
   
   methods
       function obj = ClassParameterFilter() % constructor            
       end
   end
    
end