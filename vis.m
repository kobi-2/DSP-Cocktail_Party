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

printf('source viz Done \n');

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

printf('mixed source viz Done \n');

subplot(4, 3, 7);
plot(S_(3,:), 'r');
title('ICA Separtion 1');

subplot(4, 3, 8);
plot(S_(2,:), 'b');
title('ICA Separtion 2');

subplot(4, 3, 9);
plot(S_(1,:), 'g');
title('ICA Separtion 3');

printf('ica source viz Done \n');

subplot(4, 3, 10);
plot(out_3, 'r');
title('Noise Reduction 1');

subplot(4, 3, 11);
plot(out_2, 'b');
title('Noise Reduction 2');

subplot(4, 3, 12);
plot(out_1, 'g');
title('Noise Reduction 3');

printf('noise reduc source viz Done \n');
