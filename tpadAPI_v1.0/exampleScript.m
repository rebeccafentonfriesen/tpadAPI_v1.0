%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Example Script to call all API functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% initialize connection to TPaD:
[port,dimensions] = connect2tpad();

%% create friction map:

%create space vector x, in units mm
positionLength  = dimensions(1); %should be 19200
micronsPerCount = dimensions(2); %should be 5.3 
fs = 1/(micronsPerCount*1e-3);   %spatial sampling frequency
x = (0:positionLength-1)*micronsPerCount*1e-3; %position array in mm units

%make a texture map     
map = sin(2*pi*0.5*x) + 1*sin(2*pi*3.5*x);

%increase texture amplitude to maximum tpad range
map = map/max(map)*(2^15-1);

%plot texture
figure(1)
plot(x,map)
xlabel('position (mm)'); ylabel('friction level');

%% load map onto TPaD:
%note: friction range is 0 <= DCfriction+roughness < 2^16. Values beyond
%this range will be capped to allowable range before being sent to TPaD.  

DCfriction = 2^15;
gradient = zeros(length(map),1); %filler for now...

[result] = loadData(port,DCfriction,gradient,map);


%% stream in some data from tpad at 125 Hz for 5 seconds
[data,time] = getData(port,5);

dt = (time(2)-time(1));
vel = diff(data(:,1))/dt;

figure(2)
subplot(2,1,1); plot(time,data(:,1)); xlabel('time'); ylabel('position')
subplot(2,1,2); plot(time(2:end),vel);xlabel('time'); ylabel('velocity')


