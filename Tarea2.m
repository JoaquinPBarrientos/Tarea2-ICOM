%---------P1--------------
% Abrir archivo profesor
m = open('music02.mat');
m_derecho = (m.y(:,1));
fm = (m.Fs)/8;
mt = m_derecho(1:100000,1);
tiledlayout(1,2);

nexttile
tc = 1:length(m_derecho);
plot(tc,m_derecho);
title('Señal Original completa')
xlabel('m(t)')
ylabel('tiempo (t)')


nexttile
t = 1:length(mt);
plot(t,mt);
title('Señal Original 1000 primeros puntos')
xlabel('m(t)')
ylabel('tiempo (t)')


%---------P2--------------
N = length(mt);
mf = fft(mt);
mf = mf(1:N/2 + 1);
psd_mf = (1/(fm*N)* abs(mf).^2);
freq = 0:fm/N:fm/2;



figure; 
plot(freq,10*log10(psd_mf))
grid on
title('PSD de M(f)')
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
title('PSD de Mi(f)')
xlabel('Frecuencia (Hz)')
ylabel('Potencia/Frecuencia (dB/Hz)')

%---------P5--------------
% Modulación AM DSB-TC
A = 1;
fc = 20*fm;
k = 1; 
tmi = transpose(tmi);
c = cos(2*pi*fc*tmi);
st = A*(1+k.*mi).*c;
t = 1:length(st);

figure;
plot(t,st)
title('Onda modulada AM DSB-TC')
ylabel('s(t)')
xlabel('tiempo (t)')
%---------P6--------------
st1 = st(1:1000);
t = 1:length(st1);
figure;
plot(t,st1)
title('Onda modulada AM DSB-TC primeras 1000 muestras')
ylabel('s(t)')
xlabel('tiempo (t)')
%---------P7--------------
Ns = length(st);
stf = fft(st);
stf = stf(1:Ns/2 + 1);
psd_stf = (1/(fm*Ns)* abs(stf).^2);
freq = 0:m.Fs/Ns:m.Fs/2;

figure; 
plot(freq,10*log10(psd_stf))
grid on
title('PSD de S(f) con AM DSB-TC')
xlabel('Frecuencia (Hz)')
ylabel('Potencia/Frecuencia (dB/Hz)')

%---------P8--------------

%-----------------------
% Modulación AM DSB-SC
A = 1;
fc = 20*fm;
k = 1; 
tmi = transpose(tmi);
csc = cos(2*pi*fc*tmi);
csc = transpose(csc);
stsc = mi.*csc * A;

%-----------------------
stsc1 = stsc(1:1000);
t = 1:length(stsc1);
figure;
plot(t,stsc1)
title('Onda modulada AM DSB-SC primeras 1000 muestras')
ylabel('s(t)')
xlabel('tiempo (t)')
%-----------------------
Ns = length(stsc);
stscf = fft(stsc);
stscf = stf(1:Ns/2 + 1);
psd_stscf = (1/(fm*Ns)* abs(stscf).^2);
freq = 0:m.Fs/Ns:m.Fs/2;

figure; 
plot(freq,10*log10(psd_stscf))
grid on
title('PSD de S(f) con AM DSB-SC ')
xlabel('Frecuencia (Hz)')
ylabel('Potencia/Frecuencia (dB/Hz)')

%---------P9--------------
mu = 0;
%sigma = 0.4199969;
sigma = 0.42005;
senal_n = normrnd(mu,sigma,size(st));

figure;
histogram(senal_n);
grid on
title('Distribución de la señal de ruido')

Ps = bandpower(st);
%Pn = Ps/12.59;
Pn = bandpower(senal_n);

SNR = 10*log(Ps/Pn);
%---------P10-------------
% Diodo
V1 = st;
for t = 1:length(V1)
    if V1(t) < 0
        V1(t) = 0;
    end
end

miout = lowpass(V1,6000,m.Fs);


[mout, t] = resample(miout, tmi, fm);
mout = 2*mout;

figure;
plot(1:length(mout),mout);
grid on
title('Señal recuperada')
ylabel('x(t)')
xlabel('tiempo (t)')

%---------P11-------------
tiledlayout(2,2);

nexttile
t = 1:length(mt);
plot(t,mt);
title('Señal original')
ylabel('m(t)')
xlabel('tiempo (t)')

nexttile
tout = 1:length(mout);
plot(tout,mout);
title('Señal recuperada')
ylabel('mout(t)')
xlabel('tiempo (t)')

nexttile
mfs = fft(m_derecho);
mfss = fftshift(mfs);
Nt = length(mfss);
freqt = -m.Fs/2:m.Fs/Nt:m.Fs/2-2/m.Fs;
plot(freqt,abs(mfss));
xlabel('Frecuencia (Hz)')
ylabel('|M(f)|')

nexttile
moutf = fft(mout);
moutfs = fftshift(moutf);
Nout = length(moutfs);
freqout = -m.Fs/2:m.Fs/Nout:m.Fs/2-2/m.Fs;
plot(freqout,abs(moutfs));
xlabel('Frecuencia (Hz)')
ylabel('|Mout(f)|')
xlim([-6000 6000])
ylim([0 10000])
%---------P12-------------
% Creamos .mat
save('IntroCom-secuencias-grupo1','st','stsc','mout')

