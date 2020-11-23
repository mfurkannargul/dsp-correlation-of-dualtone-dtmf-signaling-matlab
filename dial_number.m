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
silence = zeros(1600,1); %space between digits

%% VISUALIZE NUMBER PRESSED IN DIAL KEYPAD
for i = 1:numel(inputNumber) %loop for each of 12 symbols
    pressed = strfind(digits,inputNumber(i)) %find digit pressed
    toneArray(:,pressed) = sum(sin(freqArray(:,pressed)*sine)) %make it sinusoidal
    figure(1)
    sgtitle('Dial KeyPad')
    subplot(4,3,pressed)
    plot(t*1000,toneArray(:,pressed)) %make time 100ms
    title([inputNumber(i), ' Pressed']);
    ylabel('Amplitude');
    xlabel('Time (ms)');
    sound(toneArray(:,pressed)) %make it sound
    pause(0.5)
    number = [number; toneArray(:,pressed); silence]; %create number array with spaces between digits
end
n = [];
for j=1:length(number)
    n(1,j) = j; %create time array
end
figure(2)
sgtitle(inputNumber)
plot(n/8,number)
ylabel('Amplitude');
xlabel('Time (ms)');