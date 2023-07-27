%-----------  setting the standers :   ------------

sample_rate_FS = 4200;
Channel = 1;
bits = 16;

R = audiorecorder(sample_rate_FS, bits, Channel);

period_of_recording = 7;

%-----------  Start recording :    -----------


disp('Recording Started Automatically ......');

%-----------  Waiting until the recording is complete -----------

recordblocking(R, period_of_recording);

%-----------  Stop recording :    -----------

disp('Recording Stopped Automatically');


%-----------  Collecting the Data of the audio :    -----------

retrieving_data = getaudiodata(R);
sound(retrieving_data, sample_rate_FS, bits);


% -------- note : (length(retrieving_data)-1)/sample_rate_FS --------
% ------      == period_of_recording to to increase accuracy -----------

t = 0:1/sample_rate_FS:(length(retrieving_data)-1)/sample_rate_FS;


% -------- subplot 2 rows & one column and the first entry --------

subplot(2, 1, 1);


plot(t, retrieving_data, 'Linewidth', 1.5);
xlabel('time (in sec)');
ylabel('Amplitude');
title('Time Domain Plot');

n = length(retrieving_data);

%-----------  The frequency range and the  ---------------
%-------Fourier transform of the recorded signal are computed  --------
%----using fft and stored in F and Y respectively.  -----------

F = 0:(n-1)*sample_rate_FS/n;  % descret signal 

% ---------- command to increas the resulation (Optinal)-----------
Y = fft(retrieving_data, n);

%----------- The shifted frequency range and shifted Fourier transform ----
%--------  are computed using fftshift and stored in F_shifted ---------
%----------------------  and y_shifted respectively.   -------------------


F_shifted = (-n/2:n/2-1)*(sample_rate_FS/n);
y_shifted = fftshift(Y);


% -------------  The absolute value of the shifted Fourier transform ------
% --------   is computed and stored in AY_shifted -----------------

AY_shifted = abs(y_shifted);
subplot(2, 1, 2);
plot(F_shifted, AY_shifted, 'Linewidth', 1.5);

xlabel('Frequency (in Hz)');
ylabel('Amplitude');
title('Frequency Domain ');
 

% -------------   Saving the Recorded File --------------
Filename = 'Recorded Sound.wav';
audiowrite(Filename, retrieving_data, sample_rate_FS);

