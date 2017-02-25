function [t,ye,FFTArray,Frequency,WindowTime] = InitiateEchoEffect(y,Fs,Parameter)

    Delay = Parameter.Echo.Delay;
    Alpha = Parameter.Echo.EchoAmplitudeFactor;
    ye = echo_file(y,Delay,Alpha);
    TotalTime = numel(ye(:,1))*(Fs)^-1;
    t= 0:(Fs)^-1:(TotalTime-(Fs)^-1);
    [FFTArray,Frequency,WindowTime] = StartFFT(t,ye);
    
end