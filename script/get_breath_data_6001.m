

% Script for acquiring breath data signals
  % Uses National Instruments DAQ USB 6001
% David Kerr 11 November 2016

%% Set input channel and parameters on NI USB-6001
s = daq.createSession('ni');
s.DurationInSeconds = 15;
s.Rate = 100;
s.addAnalogInputChannel('Dev3','ai0', 'Voltage');
s.Channels.TerminalConfig = 'SingleEnded'
while(1)
%% Start acquisition process
G = input('\nPress <Enter> to start acquisition: ', 's');
data = startForeground(s);
codedata = data;

%% Pre-process the waveform data and plot graph
% A = smooth(codedata);  % smooth with a moving average filter (5)
% msig = median(A);
% A = A-msig;             % subtract median (was mean) to remove offset
% % Time Domain Plot
% time = 0:0.01:9.99;       % 1000 samples over a 10 second window
% figure; plot(time,A,'black')
% xlabel('Time (Seconds)')
% ylabel('Pressure (mBar)')
% title('Pressure-Time Graph')

%% Save the data to a named csv file
filnam = input('\nPlease enter data file name: ', 's')
csvwrite(filnam, codedata);

end
