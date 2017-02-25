function [FFTArray,Frequency,WindowTime]=StartFFT(t,Amplitude)
    %FFT
    FFTParameters.WindowSize=1024;
    FFTParameters.WindowFunction='hann';
    FFTParameters.PercentageOfOverlap=25;
    FFTParameters.SpectralWeighting='none';
    FFTParameters.AmplitudeScaling='rms';
    FFTParameters.FFTMethod='average';

    for ChnNo=1:size(Amplitude,2)
        [f, ~, FFTAmplitudeArray,T] = STFT(t,Amplitude(:,ChnNo),FFTParameters);
        FFTArray{ChnNo} = 20*log10(FFTAmplitudeArray + 1e-6); % dB (min = -120 dB)
        Frequency{ChnNo}=f;
        WindowTime{ChnNo}=T;
    end
end