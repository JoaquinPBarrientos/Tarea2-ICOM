%---------P1--------------
% Abrir archivo profesor
m = open('music02.mat');
m_derecho = (m.y(:,1));
fm = (m.Fs)/8;
mt = m_derecho(1:100000,1);

%---------P2--------------
N =length(mt);
mf = fft(mt);
mf = mf(1:N/2 + 1);
psd_mf = (1/(fm*N)* abs(mf).^2);
freq = 0:fm/N:fm/2;

figure; 
plot(freq,10*log10(psd_mf))
grid on
title('Periodograma')
xlabel('Frecuencia (Hz)')
ylabel('Potencia/Frecuencia (dB/Hz)')

%---------P3--------------
fs = 100*fm;
tx = [0:1/fm:(length(mt)-1)/fm];
[mi,tmi] = resample(mt,tx,fs);

%---------P4--------------
Ni =length(mt);
mif = fft(mi);
mif = mif(1:Ni/2 + 1);
psd_mif = (1/(fm*Ni)* abs(mif).^2);
freq = 0:fm/Ni:fm/2;

figure; 
plot(freq,10*log10(psd_mif))
grid on
title('Periodograma')
xlabel('Frecuencia (Hz)')
ylabel('Potencia/Frecuencia (dB/Hz)')

%---------P5--------------
% Modulación AM DSB-TC
A = 1;
fc =20*fm;
k = 1; 
tmi = transpose(tmi);
c = cos(2*pi*fc*tmi);
st = A*(1+k.*mi).*c;
t = 1:length(st);
figure;
plot(t,st)
%---------P6--------------
st = st(1:1000);
t = 1:length(st);
figure;
plot(t,st)





