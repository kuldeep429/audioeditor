function [f, FFTAmplitude, FFTAmplitudeArray,t] = STFT(t,Amplitude,FFTParameters)
    % optional WindowFunction: 'rectangular' , 'hann', 'hamming' , 'blackman' , 'gauss',  'flattop' , 'blackmanharris'
    % standard WindowFunction: hann

    if nargin < 3
        FFTParameters=ClassParameterFFTAnalysis;
    end
    if isempty(t) 
        error('empty time vector in function STFT')
    end
    if isempty(Amplitude)
        error('empty amplitude vector in function STFT')
    end        

    t=t(:);                     % ensure column vectors
    Amplitude=Amplitude(:);     % ensure column vectors

    dt=t(2)-t(1);
    SamplingFrequency=1/dt;
    N=numel(t);

    % divide data into the window segments
    NWindow=2^nextpow2(FFTParameters.WindowSize);
    if ( NWindow < 3 ) || ( NWindow > N )
        error(['Window size of ' num2str(NWindow) ' is larger than the sample size N=' num2str(N)]);
    end

    f=SamplingFrequency/2*linspace(0,1,NWindow/2);
    [alpha, WindowFunction]=GetWindowFunction(NWindow,FFTParameters.WindowFunction);

    deltaN=floor((1-FFTParameters.PercentageOfOverlap/100)*NWindow);
    NoOfWindows=floor((N-NWindow)/deltaN)+1;
    FFTAmplitudeArray=zeros(NoOfWindows,NWindow/2);

    for WindowNo=1:NoOfWindows
        WindowStartPos=(WindowNo-1)*deltaN+1;
        WindowAmplitude=Amplitude(WindowStartPos:WindowStartPos+NWindow-1);
        WindowAmplitude=WindowFunction.*WindowAmplitude;
        WindowFFTAmplitude=fft(WindowAmplitude,NWindow)/NWindow;
        FFTAmplitudeArray(WindowNo,:)=(alpha)*2*abs(WindowFFTAmplitude(1:NWindow/2));
    end

    switch lower(FFTParameters.FFTMethod)
        case 'average' %quadratic mean value
            FFTAmplitude=sqrt(sum(FFTAmplitudeArray.^2,1)/NoOfWindows);
        case 'peak hold'
            FFTAmplitude=max(FFTAmplitudeArray);
        otherwise
            error('Type of averaging is undefined.')
    end

    switch lower(FFTParameters.AmplitudeScaling)
        case 'rms'
         FFTAmplitude=FFTAmplitude/sqrt(2);
    end

    f=f(:);
    FFTAmplitude=FFTAmplitude(:);
    t = (NWindow/2:deltaN:NWindow/2+(NoOfWindows-1)*deltaN)/SamplingFrequency;
end

function [alpha, Window] = GetWindowFunction(N,WindowFunction)

    switch lower(WindowFunction)
%__________________________________________________________________________
% None Filter
        case 'rectangular'
            alpha = 1;
            Window=ones(N,1);

%__________________________________________________________________________
% Hann Filter
        case  'hann'
            a0=0.5;
            for n=1:N
                omega(n)=a0*(1-cos(2*pi*(n-1)/N));
            end
            alpha = 1/a0;
            Window=omega;

%__________________________________________________________________________
% Hamming Filter
        case  'hamming'
            a0=0.54;
            for n=1:N
                omega(n)=a0-0.46*cos(2*pi*(n-1)/N);
            end
            alpha = 1/a0;
            Window=omega;

%__________________________________________________________________________
% Flattop Window
        case  'flattop'
            % parameter identical with HEAD ArtemiS SUITE:
%             a0=0.5;
%             a1=0.97;
%             a2=0.654;
%             a3=0.2;
%             a4=0.02;
%             for n=1:N
%                 omega(n)=a0-a1*cos(2*pi*n/(N-1))+a2*cos(4*pi*n/(N-1))-a3*cos(6*pi*n/(N-1))+a4*cos(8*pi*n/(N-1));
%             end
            
            a0=0.21557895;
            a1=0.41663158;
            a2=0.277263158;
            a3=0.083578947;
            a4=0.006947368;
            for n=1:N
                omega(n)=a0-a1*cos(2*pi*(n-1)/N)+a2*cos(4*pi*(n-1)/N)-a3*cos(6*pi*(n-1)/N)+a4*cos(8*pi*(n-1)/N);
            end
            alpha = 1/a0;
            Window=omega;
%__________________________________________________________________________
% Blackman Filter
        case  'blackman'
            a0=0.42659;
            a1=0.49656;
            a2=0.076849;
            for n=1:N
                omega(n)=a0-a1*cos(2*pi*(n-1)/N)+a2*cos(4*pi*(n-1)/N);
            end
            alpha = 1/a0;
            Window=omega;

%__________________________________________________________________________
% Blackman-Harris Filter
        case  'blackmanharris'
            a0=0.35875;
            a1=0.48829;
            a2=0.14128;
            a3=0.01168;
            for n=1:N
                omega(n)=a0-a1*cos(2*pi*(n-1)/N)+a2*cos(4*pi*(n-1)/N)-a3*cos(6*pi*(n-1)/N);
            end
            alpha = 1/a0;
            Window=omega;

%__________________________________________________________________________
% Gauss Window Filter
        case  'gauss'
            for n=1:N
                omega(n)=exp(-1/2*(3*(n-1-N/2)/(N/2))^2);
            end
            alpha = 1/.43;
            Window=omega;

        otherwise
            error(['Undefined window function: ' WindowFunction ' . Use a defined window function: rectangular, hann, hamming, blackman, gauss, flattop, blackmanharris']);
    end
    Window=Window(:);
end