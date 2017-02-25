function gui = UpdateAxis(gui,ye,x,FFTArray,Frequency,WindowTime)

    %clear axes
    cla(gui.WaveformAxisChn1)
    cla(gui.WaveformAxisChn2)
    cla(gui.SpectrumDispChn1)
    cla(gui.SpectrumDispChn2)
    
    if size(ye,2)==2
        plot(gui.WaveformAxisChn1,x,ye(:,1),'Tag','Chan1Data');
        set(gui.WaveformAxisChn1,'xlim',[min(x(:)),max(x(:))]);
        
        plot(gui.WaveformAxisChn2,x,ye(:,2),'Tag','Chan2Data');
        set(gui.WaveformAxisChn2,'xlim',[min(x(:)),max(x(:))]);
        
        imagesc(gui.SpectrumDispChn1,WindowTime{1},Frequency{1},FFTArray{1});
        imagesc(gui.SpectrumDispChn2,WindowTime{2},Frequency{2},FFTArray{2});
        
    else
        plot(gui.WaveformAxisChn1,x,ye(:,1),'Tag','Chan1Data');
        set(gui.WaveformAxisChn1,'xlim',[min(x(:)),max(x(:))]);
        
        imagesc(gui.SpectrumDispChn1,WindowTime{1},Frequency{1},FFTArray{1});
    end
end