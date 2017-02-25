function yee=echo_file(xin,delay,alpha)
%
% echo a file by adding a delayed and scaled version of a signal to itself

% create a reverberant speech file with a single echo of fixed delay and
% gain
%
% Inputs:
%   xin: signal array to which echo is added
%   delay: delay in samples of echo
%   alpha: scaling factor for echo
%
% Output:
%   ye: echoed signal

% determine number of samples in original (unechoed) signal
    [nsamp,Chan]=size(xin);

% create sum of original plus scaled and delayed speech file
    for ChanNo = 1:Chan
        ye=[xin(:,ChanNo)', zeros(1,delay)];
        ye(delay:delay+nsamp-1)=ye(delay:delay+nsamp-1)+xin(:,ChanNo)'*alpha;
        yee{ChanNo,:}=ye;
    end
    yee=cell2mat(yee)';
end