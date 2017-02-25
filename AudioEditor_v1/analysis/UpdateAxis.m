function gui = UpdateAxis(gui,ye,x,FFTArray,Frequency,WindowTime)

    %clear axes
    cla(gui.WaveformAxisChn1)
    cla(gui.WaveformAxisChn2)
    cla(gui.SpectrumDispChn1)
    cla(gui.SpectrumDispChn2)

    if size(ye,2)==2
        %Make settings
        set(gui.WaveformAxisChn1,'Visible','on'); set(gui.WaveformAxisChn2,'Visible','on');
        set(gui.SpectrumDispChn1,'Visible','on'); set(gui.SpectrumDispChn2,'Visible','on');
        set(gui.WaveformDispVBox,'Heights',[-1,-1]); set(gui.SpectrumDispVBox,'Heights',[-1,-1]);

        plot(gui.WaveformAxisChn1,x,ye(:,1),'Tag','Chan1Data');
        set(gui.WaveformAxisChn1,'xlim',[min(x(:)),max(x(:))]);

        plot(gui.WaveformAxisChn2,x,ye(:,2),'Tag','Chan2Data');
        set(gui.WaveformAxisChn2,'xlim',[min(x(:)),max(x(:))]);

        imagesc(gui.SpectrumDispChn1,WindowTime{1},Frequency{1},FFTArray{1}');
        imagesc(gui.SpectrumDispChn2,WindowTime{2},Frequency{2},FFTArray{2}');
        set(gui.SpectrumDispChn1,'YDir','normal')
        set(gui.SpectrumDispChn2,'YDir','normal')
        c1 = colorbar(gui.SpectrumDispChn1);
        c2 = colorbar(gui.SpectrumDispChn2);
        c1.Label.String = 'dB';
        c2.Label.String = 'dB';
    else
        set(gui.WaveformAxisChn2,'Visible','off');
        set(gui.WaveformDispVBox,'Heights',[-1,0]);

        plot(gui.WaveformAxisChn1,x,ye(:,1),'Tag','Chan1Data');
        set(gui.WaveformAxisChn1,'xlim',[min(x(:)),max(x(:))]);

        set(gui.SpectrumDispChn2,'Visible','off')
        set(gui.SpectrumDispVBox,'Heights',[-1,0]);

        imagesc(gui.SpectrumDispChn1,WindowTime{1},Frequency{1},FFTArray{1}');
        set(gui.SpectrumDispChn1,'YDir','normal')
        c = colorbar(gui.SpectrumDispChn1);
        c.Label.String = 'dB';
    end
end