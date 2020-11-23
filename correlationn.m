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
digits = '123456789*0#'; %digits to be used
inputNumber = input('Dial a Phone Number: ','s'); %get input
number = [];
silence = zeros(1600,1);

%% VISUALIZE NUMBER PRESSED
for i = 1:numel(inputNumber) %loop for each of 12 symbols
    pressed = strfind(digits,inputNumber(i)) %find digit pressed
    toneArray(:,pressed) = sum(sin(freqArray(:,pressed)*sine)) %make it sinusoidal
    number = [number; toneArray(:,pressed); silence]; %create graph of number with silence between digits
end
n = [];
for j=1:length(number)
    n(1,j) = j;
end
figure(1)
sgtitle(inputNumber)
plot(n/8,number)
ylabel('Amplitude');
xlabel('Time (ms)');

%% DISPLAY CORRELATION BETWEEN NUMBER AND EACH DIGIT
for i=1:4
    digit = sum(sin(freqArray(:,i)*sine)); %take digit signal
    [correlation, lag] = xcorr(number, digit); %compute signal similarities
    correlationNormalized = correlation./max(abs(correlation(:))); %normalize
    figure(2)
    subplot(2,2,i)
    plot(abs(lag/Fs*900),correlationNormalized,'k')
    title(['Correlation Between Number Dialled and Digit of " ',symbol{i},' "']);
    ylabel('Normalized Amplitude');
    xlabel('Time (ms)');
end
for i=1:4
    digit = sum(sin(freqArray(:,(i+4))*sine)); %take digit signal
    [correlation, lag] = xcorr(number, digit); %compute signal similarities
    correlationNormalized = correlation./max(abs(correlation(:))); %normalize
    figure(3)
    subplot(2,2,i)
    plot(abs(lag/Fs*900),correlationNormalized,'k')
    title(['Correlation Between Number Dialled and Digit of " ',symbol{i+4},' "']);
    ylabel('Normalized Amplitude');
    xlabel('Time (ms)');
end
for i=1:4
    digit = sum(sin(freqArray(:,(i+8))*sine)); %take digit signal
    [correlation, lag] = xcorr(number, digit); %compute signal similarities
    correlationNormalized = correlation./max(abs(correlation(:))); %normalize
    figure(4)
    subplot(2,2,i)
    plot(abs(lag/Fs*900),correlationNormalized,'k')
    title(['Correlation Between Number Dialled and Digit of " ',symbol{i+8},' "']);
    ylabel('Normalized Amplitude');
    xlabel('Time (ms)');
end