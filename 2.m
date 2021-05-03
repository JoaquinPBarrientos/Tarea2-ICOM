%---------P1--------------
% Abrir archivo profesor
m = open('music02.mat');
m_derecho = (m.y(:,1));
f_m = (m.Fs)/8;
m_t = m_derecho(1:100000,1);


%---------P2--------------
N =length(m_t);
m_f = fft(m_t);
m_f = m_f(1:N/2 + 1);
psd_mf = (1/(f_m*N)* abs(m_f).^2);
freq = 0:f_m/N:f_m/2;

figure; 
plot(freq,10*log10(psd_mf))
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
xdft1 = xdft1(1:N/2 + 1);
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
f_c = f_m/2-1;
s_t = modulate(mi,f_c,f_m,'amdsb-tc');
%---------P6--------------
s_t1 = s_t(1:1000,1)

plot(1:1:1000,s_t1)

%---------P7--------------
N =length(s_t);
xdft1 = fft(s_t);
xdft1 =xdft1(1:N/2 + 1);
psdx1 = (1/(m.Fs*N)* abs(xdft1).^2);
freq = 0:m.Fs/N:m.Fs/2;

figure;
plot(freq,10*log10(psdx1))
grid on
title('Periodograma ')
xlabel('Frecuencia (Hz)')
ylabel('Potencia/Frecuencia (dB/Hz)')

%---------P8--------------

A_c = 1;
f_c = f_m/2-1;
s_t = modulate(mi,f_c,f_m);
s_t1 = s_t(1:1000,1)
plot(1:1:1000,s_t1)


N =length(s_t);
xdft1 = fft(s_t);
xdft1 =xdft1(1:N/2 + 1);
psdx1 = (1/(m.Fs*N)* abs(xdft1).^2);
freq = 0:m.Fs/N:m.Fs/2;

figure;
plot(freq,10*log10(psdx1))
grid on
title('Periodograma ')
xlabel('Frecuencia (Hz)')
ylabel('Potencia/Frecuencia (dB/Hz)')

%---------P9--------------
mu = 0;
sigma = 11;
senal_2 = normrnd(mu,sigma,size(s_t));
psd_senal_2 = periodogram(senal_2,rectwin(length(senal_2)),length(senal_2),m.Fs);





