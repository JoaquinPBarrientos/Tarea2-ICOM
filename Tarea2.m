%---------P1--------------
% Abrir archivo profesor
m = open('music02.mat');
m_derecho = (m.y(:,1));
f_m = (m.Fs)/8;
m_t = m_derecho(1:1000,1);


%---------P2--------------
N =length(m_t);
xdft = fft(m_t);
xdft =xdft(1:N/2 + 1);
psdx = (1/(f_m*N)* abs(xdft).^2);
freq = 0:f_m/N:f_m/2;

figure; 
plot(freq,10*log10(psdx))
grid on
title('Periodograma ')
xlabel('Frecuencia (Hz)')
ylabel('Potencia/Frecuencia (dB/Hz)')

%---------P3--------------
tx = [0:1/f_m:(length(m_t)-1)/f_m];
[mi,tmi] = resample(m_t,tx,100*f_m);


%---------P4--------------
N =length(m_t);
xdft1 = fft(mi);
xdft1 =xdft1(1:N/2 + 1);
psdx1 = (1/(f_m*N)* abs(xdft1).^2);
freq = 0:f_m/N:f_m/2;

figure;
plot(freq,10*log10(psdx1))
grid on
title('Periodograma ')
xlabel('Frecuencia (Hz)')
ylabel('Potencia/Frecuencia (dB/Hz)')

%---------P5--------------
%Tenemos mi y tmi
A_c = 1;
f_c = 20*f_m
s_n = A_c*(1+1.5*m_t)*cos(2*pi*m_t*t)

