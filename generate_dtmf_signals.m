close all, clc, clear

%% INITIALIZE VARIABLES
symbol = {'1','2','3','4','5','6','7','8','9','*','0','#'};
lowFreqGroup = [697, 770, 852, 941]; %frequencies in rows
highFreqGroup = [1209, 1336, 1477]; %frequencies in columns
freqArray = [];
for i = 1:4
    for j = 1:3
        freqArray = [freqArray [lowFreqGroup(i); highFreqGroup(j)]]; %create pairs
    end
end
Fs = 8e3; %sampling frequency
N = 8e2; %tones of 100ms
t = (0:N-1)/Fs; %time
sine = 2*pi*t; %sine formula
toneArray = zeros(N, size(freqArray,2)); %array of N*12 for graph

%% VISUALIZE AND SOUND DIGIT SYMBOLS
for i = 1:12 %loop for each of 12 symbols
    toneArray(:,i) = sum(sin(freqArray(:,i)*sine)); %make it sinusoidal
    subplot(4,3,i);
    plot(t*1000,toneArray(:,i)); %make time 100ms
    title(['DTMF Signal for "', symbol{i},'"']);
    ylabel('Amplitude');
    xlabel('Time (ms)');
    sound(toneArray(:,i)) %make it sound
    pause(0.5)
end