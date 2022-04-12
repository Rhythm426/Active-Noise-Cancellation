%impulse response
freq=5;
phi=pi/3;
sample=20*freq;
dt=1/sample;
t=0:dt:10;
t=t';
X_ps=3*sin(2*pi*freq*t+phi);%primary signal noise
plot(t,X_ps);
%secondary path impulse response
A=2;
zeta=0.05;
Wn=20;
wd=sqrt(1-zeta^2);
phil=pi/3;
Y_sec_Ir=A*exp(-zeta*Wn*t);
figure(6)
plot(t,Y_sec_Ir);
title('Impulse Response of secondary source');
xlabel('t');
ylabel('pressure');
Xr=sin(2*pi*freq*t);

N=60;%filter size
W=zeros(N,1);%vector
mu=0.00001;%learning rate
Xr_in=zeros(N,1);%convolving parameter input to Fir
M=length(t);
Y_t=zeros();
E_t=zeros();
Xfr=zeros(N,1);%Xfr=Xr*secd.path
Xr_2=zeros(M,1);%store all refernce value over given time
%X_ps=3*sin(2*pi*freq*t+phi);
Yf=zeros(M,1);%o/p of fir
T2=zeros();
for n=1:M%convolving for entire time span using fir(n)
    Xr_in=[Xr(n);Xr_in(1:N-1)];%total size equal to fir(n)
    Y=sum(Xr_in.*W);%o/p of fir_conv sum
    Xr_2=[Xr(n);Xr_2(1:M-1)];%conv step 01
    sz=size(Y);
    disp(sz);
    Xfr_n=sum(Xr_2.*Y_sec_Ir);%conv step 2
     %ys=y*sec_ir
    Yf=[Y;Yf(1:M-1)];%o/p fir filter
    Ys=sum(Yf.*Y_sec_Ir);%conv. sum
    e=X_ps(n)+Ys;%error mic
    Xfr=[Xfr_n;Xfr(1:N-1)];
    W=W-mu*e*Xfr;%update weights
    E_t(n)=e;%error in time
    Y_t(n)=Ys;%output to the fir
    figure(3)
    plot(W,'*--');
    title('weight vector of fxlms')
    xlabel('Nth Weight');
    n_iter=n;
    T2(n)=t(n);
     
end

figure(2)
subplot(2,1,1)
plot(t,X_ps,'b',T2,E_t,'r');
xlabel('time');
title('error and noise')
legend('p.noise','error')

subplot(2,1,2);
plot(T2,Y_t,'r');
title('output of Fir')
xlabel('time');

     







     





