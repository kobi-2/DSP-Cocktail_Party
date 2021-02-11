printf('Starting...\n');
printf('Reading audio files...');

%Audio files
file1 = "Audios/Bangla.wav";
file2 =  "Audios/English.wav";
file3 = "Audios/Spanish.wav";

%denotes number of samples to be read
noOfSamples = [1, 440000];

[s1, sampling_rate_1] = audioread(file1, noOfSamples);
[s2, sampling_rate_2] = audioread(file2, noOfSamples);
[s3, sampling_rate_3] = audioread(file3, noOfSamples);

%s1, s2, s3 each has 2 columns of the same values. so removing 1 column.
s1(:,2) = [];
s2(:,2) = [];
s3(:,2) = [];

printf('Done \n');

%{
printf('Starting noise reduction...');
%performing noise reduction on input side...

[s1,~] = WienerNoiseReduction(s1,sampling_rate_1,size(s1));
audiowrite('noisereduced_before_1.wav',s1,sampling_rate_1);

[s2,~] = WienerNoiseReduction(s2,sampling_rate_2,size(s2)); 
audiowrite('noisereduced_before_2.wav',s2,sampling_rate_2);

[s3,~] = WienerNoiseReduction(s3,sampling_rate_3,size(s3)); 
audiowrite('noisereduced_before_3.wav',s3,sampling_rate_3);
printf('Done \n');
%}

printf('Starting mixing audio sources...');

%Mixing sources
S = [s1'; s2'; s3'];

% The Mixing Matrix:
A = [0.8, 0.4, 0.2; 
0.4, 0.8, 0.5;
0.2, 0.5, 0.8];

%Mixed source = Mixing Matrix * Sources
X = A*S;

printf('Done \n');
printf('Now calling ICA...');

%calling ICA Function:
[S_, W] = ica(X, 5000, 1e-16);


printf('Done \n');
printf('Writing mixed and separatd sources to files...');


%Saving Mixed Audios
%centering the audio files for better playing the audio in the audio player
X = X - mean(X, 2);
audiowrite('mixedaudio1.wav', X(1,:)', sampling_rate_1);
audiowrite('mixedaudio2.wav', X(2, :)', sampling_rate_2);
audiowrite('mixedaudio3.wav', X(3, :)', sampling_rate_3);

%Saving audios seperated by the ICA Function
audiowrite('separatedaudio1.wav', S_(1,:)', sampling_rate_1);
audiowrite('separatedaudio2.wav', S_(2,:)', sampling_rate_2);
audiowrite('separatedaudio3.wav', S_(3,:)', sampling_rate_3);



printf('Done \n');
printf('Now going for noise reduction...');


%Applying Noise Reduction Filter on the output of the seperated audio files. 
[x,fs] = audioread('separatedaudio1.wav');
[out_1,~] = WienerNoiseReduction(x,fs,size(x));
audiowrite('noisereduced1.wav',out_1(1:size(x)),fs);

[x,fs] = audioread('separatedaudio2.wav');
[out_2,~] = WienerNoiseReduction(x,fs,size(x)); 
audiowrite('noisereduced2.wav',out_2(1:size(x)),fs);

[x,fs] = audioread('separatedaudio3.wav');
[out_3,~] = WienerNoiseReduction(x,fs,size(x)); 
audiowrite('noisereduced3.wav',out_3(1:size(x)),fs);



printf('Done \n');
printf('Writing these to files is done...\n');
printf('Starting subplotting...');


%Visualization
subplot(4, 3, 1);
plot(s1, 'r');
title('Source 1');

subplot(4, 3, 2);
plot(s2, 'b');
title('Source 2');

subplot(4, 3, 3);
plot(s3, 'g');
title('Source 3');


subplot(4, 3, 4);
plot(X(1,:), 'r');
title('Mixed Audio 1');
%ylim([-3,3])

subplot(4, 3, 5);
plot(X(2,:), 'b');
title('Mixed Audio 2');
%ylim([-3, 3]);

subplot(4, 3, 6);
plot(X(3,:), 'g');
title('Mixed Audio 2');
%ylim([-3, 3]);


subplot(4, 3, 7);
plot(S_(1,:), 'r');
title('ICA Separtion 1');

subplot(4, 3, 8);
plot(S_(2,:), 'b');
title('ICA Separtion 2');

subplot(4, 3, 9);
plot(S_(3,:), 'g');
title('ICA Separtion 3');


subplot(4, 3, 10);
plot(out_1, 'r');
title('Noise Reduction 1');

subplot(4, 3, 11);
plot(out_2, 'b');
title('Noise Reduction 2');

subplot(4, 3, 12);
plot(out_3, 'g');
title('Noise Reduction 3');


printf('Done \n');
printf('Program run completed.\n');

