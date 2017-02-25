function Interfacedata = creatdata()
% clear all
Interfacedata=ClassInterfacedata;

%%
%Effect
EffectNo=1;
Interfacedata.Effects(EffectNo).EffectName='Amplitude';

SubEffectNo = 0;

SubEffectNo = SubEffectNo+1;
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectName = 'Amplify';

ProNo=0;
ProNo=ProNo+1;
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).Name='Left gain';
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).TargetParameter='';
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).Type='slider';
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).InitialValue={[0 -96 50],'slidebar'}; % slider {initial,mini,max}
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).ReadAs={'Number','slidebar'};

ProNo=ProNo+1;
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).Name='Right gain';
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).TargetParameter='';
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).Type='slider';
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).InitialValue={[0 -96 50],'slidebar'}; % slider {initial,mini,max}
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).ReadAs={'Number','slidebar'};

%%
EffectNo=2;
Interfacedata.Effects(EffectNo).EffectName='Echo';

SubEffectNo = 0;

SubEffectNo = SubEffectNo+1;
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectName = 'Mono echo';

ProNo=0;
ProNo=ProNo+1;
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).Name='Delay(ms)';
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).TargetParameter='Parameter.Echo.Delay';
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).Type='edit';
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).InitialValue={'0','edit'}; % slider {initial,mini,max}
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).ReadAs={'Number','edit'};

ProNo=ProNo+1;
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).Name='Echo ampl. factor';
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).TargetParameter='Parameter.Echo.EchoAmplitudeFactor';
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).Type='edit';
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).InitialValue={'1','edit'}; % slider {initial,mini,max}
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).ReadAs={'Number','edit'};

%%
EffectNo=3;
Interfacedata.Effects(EffectNo).EffectName='Filter';

SubEffectNo = 0;

SubEffectNo = SubEffectNo+1;
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectName = 'Lowpass';

ProNo=0;
ProNo=ProNo+1;
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).Name='Filter type';
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).TargetParameter='';
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).Type='popupmenu';
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).Value={'Butterworth','Chebyshev','Gaussian','Bessel'};
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).InitialValue={1,'popupmenu'}; % slider {initial,mini,max}
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).ReadAs={'Text','edit'};

ProNo=ProNo+1;
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).Name='Heigher cutoff (Hz)';
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).TargetParameter='';
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).Type='edit';
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).InitialValue={'0','edit'}; % slider {initial,mini,max}
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).ReadAs={'Number','edit'};


SubEffectNo = SubEffectNo+1;
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectName = 'Highpass';

ProNo=0;
ProNo=ProNo+1;
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).Name='Filter type';
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).TargetParameter='';
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).Type='popupmenu';
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).Value={'Butterworth','Chebyshev','Gaussian','Bessel'};
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).InitialValue={1,'popupmenu'}; % slider {initial,mini,max}
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).ReadAs={'Text','edit'};

ProNo=ProNo+1;
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).Name='lower cutoff (Hz)';
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).TargetParameter='';
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).Type='edit';
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).InitialValue={'0','edit'}; % slider {initial,mini,max}
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).ReadAs={'Number','edit'};

SubEffectNo = SubEffectNo+1;
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectName = 'Bandpass';

ProNo=0;
ProNo=ProNo+1;
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).Name='Filter type';
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).TargetParameter='';
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).Type='popupmenu';
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).Value={'Butterworth','Chebyshev','Gaussian','Bessel'};
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).InitialValue={1,'popupmenu'}; % slider {initial,mini,max}
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).ReadAs={'Text','edit'};

ProNo=ProNo+1;
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).Name='lower cutoff (Hz)';
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).TargetParameter='';
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).Type='edit';
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).InitialValue={'0','edit'}; % slider {initial,mini,max}
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).ReadAs={'Number','edit'};

ProNo=ProNo+1;
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).Name='Heigher cutoff (Hz)';
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).TargetParameter='';
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).Type='edit';
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).InitialValue={'0','edit'}; % slider {initial,mini,max}
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).ReadAs={'Number','edit'};

%%
EffectNo=4;
Interfacedata.Effects(EffectNo).EffectName='Noise';

SubEffectNo = 0;

SubEffectNo = SubEffectNo+1;
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectName = 'Noise profile';

ProNo=0;
ProNo=ProNo+1;
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).Name='Start time';
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).TargetParameter='';
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).Type='edit';
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).InitialValue={'0','edit'}; % slider {initial,mini,max}
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).ReadAs={'Number','edit'};

ProNo=ProNo+1;
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).Name='End time';
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).TargetParameter='';
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).Type='edit';
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).InitialValue={'1','edit'}; % slider {initial,mini,max}
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).ReadAs={'Number','edit'};

ProNo=ProNo+1;
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).Name='Noise reduction intensity';
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).TargetParameter='';
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).Type='edit';
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).InitialValue={'1','edit'}; % slider {initial,mini,max}
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).ReadAs={'Number','edit'};

%%
SubEffectNo = SubEffectNo+1;
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectName = 'Reduce noise';

ProNo=0;
ProNo=ProNo+1;
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).Name='Start time';
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).TargetParameter='';
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).Type='edit';
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).InitialValue={'0','edit'}; % slider {initial,mini,max}
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).ReadAs={'Number','edit'};

ProNo=ProNo+1;
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).Name='End time';
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).TargetParameter='';
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).Type='edit';
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).InitialValue={'1','edit'}; % slider {initial,mini,max}
Interfacedata.Effects(EffectNo).SubEffect(SubEffectNo).SubEffectProperties(ProNo).ReadAs={'Number','edit'};


%%
% %%
% EffectNo=3;
% Interfacedata.Effects(EffectNo).EffectName='Hard Limiting';
% 
% 
% %%
% EffectNo=3;
% Interfacedata.Effects(EffectNo).EffectName='Normalization';
% 
% 
% %%
% EffectNo=4;
% Interfacedata.Effects(EffectNo).EffectName='Delay';
% 
% 
% %%
% EffectNo=5;
% Interfacedata.Effects(EffectNo).EffectName='Fade';




end