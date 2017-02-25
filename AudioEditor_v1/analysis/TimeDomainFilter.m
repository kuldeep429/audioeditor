function [FilteredAmplitude] = TimeDomainFilter(t,Amplitude,CutOff,FilterType,Order)
% Butterworth filter in the time domain
% t: time
% Amplitude: Time signal
% CutOff: Cutoff frequency of filter. If filter type is 'bandpass' then cut off frequeny must be two values
% FilterType: could be 'lowpass', 'highpass' or 'bandpass'
% Order: Order of the filter (6)


    %Frequeny extraction
    L = numel(t);
    fs = 1/(t(2)-t(1));
    f = fs*(0:(L/2))/L;

    switch lower(FilterType)
        case {'lowpass', 'lp', 'low'}
            if numel(CutOff) == 1
                CutOff = CutOff/f(end);
                [z,p,k] = butter(Order,CutOff,'low');
                [sos,g] = zp2sos(z,p,k);
            else
                error('Cutoff frequency should be one frequency')
            end
        case {'highpass', 'hp', 'high'}
            if numel(CutOff) == 1
                CutOff = CutOff/f(end);             %Normalize cutoff
                [z,p,k] = butter(Order,CutOff,'high');
                [sos,g] = zp2sos(z,p,k);
            else
                error('Cutoff frequency should be one frequency')
            end        
        case {'bandpass', 'bp', 'pass'}
            if numel(CutOff) == 2
                CutOff = CutOff/f(end);
                [z,p,k] = butter(Order,CutOff,'bandpass');
                [sos,g] = zp2sos(z,p,k);
            else
                error('Cutoff frequency should be two frequencies')
            end         
        otherwise
            error('Cannnot recognize the filter type.')
    end

    %Filtering operation
    FilteredAmplitude = filtfilt(sos,g,Amplitude); % use filtfilt instead of filter for phase-correct filtering


end