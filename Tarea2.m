% Abrir archivo profesor
m = open('music02.mat');
m_derecho = (m.y(:,1));
f_m = (m.Fs)/8;
m_derecho = m_derecho(1:1000,1);

