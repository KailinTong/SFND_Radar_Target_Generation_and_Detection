# SFND_Radar_Target_Generation_and_Detection


#### 1. FMCW Waveform Design
Using the given system requirements, design a FMCW waveform. Find its Bandwidth (B), chirp time (Tchirp) and slope of the chirp.

```Matlab
c = 3 * 10^8; % speed of light
r_res = 1; % range resolution
r_max = 200; % max range

B = c / (2 * r_res);
Tchirp = 5.5 * 2 * r_max / c;
slope = B / Tchirp;
```

#### 2. Simulation Loop
Simulate Target movement and calculate the beat or mixed signal for every timestamp.

```Matlab
for i=1:length(t)         
    
    
    % *%TODO* :
    %For each time stamp update the Range of the Target for constant velocity. 
    R = R0+v*t(i);
    % *%TODO* :
    %For each time sample we need update the transmitted and
    %received signal. 
    tau = 2*R/c;
    Tx(i) = cos(2*pi*(fc*t(i)+slope*t(i)^2/2));
    Rx(i) = cos(2*pi*(fc*(t(i)-tau)+slope*(t(i)-tau)^2/2));

    % *%TODO* :
    %Now by mixing the Transmit and Receive generate the beat signal
    %This is done by element wise matrix multiplication of Transmit and
    %Receiver Signal
    Mix(i) = Tx(i) .* Rx(i);

end
```

#### 3. Range FFT (1st FFT)

Implement the Range FFT on the Beat or Mixed Signal and plot the result.

```Matlab
for i=1:length(t)         
    
    
    % *%TODO* :
    %For each time stamp update the Range of the Target for constant velocity. 
    R = R0+v*t(i);
    % *%TODO* :
    %For each time sample we need update the transmitted and
    %received signal. 
    tau = 2*R/c;
    Tx(i) = cos(2*pi*(fc*t(i)+slope*t(i)^2/2));
    Rx(i) = cos(2*pi*(fc*(t(i)-tau)+slope*(t(i)-tau)^2/2));

    % *%TODO* :
    %Now by mixing the Transmit and Receive generate the beat signal
    %This is done by element wise matrix multiplication of Transmit and
    %Receiver Signal
    Mix(i) = Tx(i) .* Rx(i);

end
```
![result](https://github.com/KailinTong/SFND_Radar_Target_Generation_and_Detection/blob/main/image/1dfft.png)

#### 4. 2D CFAR
Implement the 2D CFAR process on the output of 2D FFT operation, i.e the Range Doppler Map.

Selection of Training, Guard cells and offset.
```Matlab
Tr = 10;
Td = 5;
Gr = 5;
Gd = 2;
offset=1.4;
```

Firstly, I generate a zero threshold matrix.
Then I loop the start point of sliding window over the whole pad.
Similar to the exercise solution, I only use leading training cells for simplicity

```Matlab
threshold = zeros(size(RDM));   
for row = 1:(Nr/2-(Gr+Tr+1))
    noise_level = 0;
    for col = 1:(Nd-(Gd+Td+1))
        noise_level = sum(sig_fft2(row:row+Tr-1,col:col+Td-1));
        noise_level = 10*log10(noise_level) + offset;
        signal = RDM(row+Tr+Gr, col+Td+Gd);
        
        if signal > noise_level
            threshold(row+Tr+Gr, col+Td+Gd) = 1;
        end
    end
end
```

Finally, plot the result.



![result](https://github.com/KailinTong/SFND_Radar_Target_Generation_and_Detection/blob/main/image/cfar.png)
