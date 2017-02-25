function [t,y,FFTArray,Frequency,WindowTime] = InitiateFilter(Amplitude,Fs,Parameter,Filter)

    Order = 6;
    NoChn = size(Amplitude,2);
    TotalTime = numel(Amplitude(:,1))*(Fs)^-1;
    t= 0:(Fs)^-1:(TotalTime-(Fs)^-1);
    t = t(:);
    
    switch lower(Filter)
        case 'lowpass'
            CutOff = Parameter.HigherCutOff;            
        case 'bandpass'
            CutOff = [Parameter.LowerCutOff,Parameter.HigherCutOff];
        case 'highpass'
            CutOff = Parameter.LowerCutOff;
        otherwise
            error('Undefined filter')
    end
    y = zeros(size(Amplitude,1),NoChn);
    for Ch=1:NoChn
        y(:,Ch) = TimeDomainFilter(t,Amplitude(:,Ch),CutOff,Filter,Order);
    end
    [FFTArray,Frequency,WindowTime] = StartFFT(t,y);
end