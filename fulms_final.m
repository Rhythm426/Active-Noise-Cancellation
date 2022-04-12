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
N=60;
mu=power(10,-5.1);
M=length(t);
Aw=zeros(1,N);
Bw=zeros(1,N);
x_buf=zeros(N,1);
y_buf=zeros(M,1);
y_buf_last=zeros(N,1);
y_buf_vector_last=zeros(1,N);
r_buf=zeros(1,N);
r_buf1=zeros(1,N);
r_1=zeros(M,1);
r_2=zeros(M,1);
E_t=zeros();
y_signal=zeros(M,1);
x_buf1=zeros(N,1);
control_signal=zeros();
T2=zeros();
for n=1:M
         x_buf=[Xr(n);x_buf(1:end-1)];%storing refernce signal
   
         r_1=[Xr(n);r_1(1:M-1)];
         r=sum(r_1.*Y_sec_Ir);%convultion with secondary impulse response
         r_buf=[r,r_buf(1:end-1)];
         y_sig=sum(Aw*x_buf(1:N))+sum(Bw*y_buf_last);
         %disp(y_sig);
         y_signal=[y_sig;y_signal(1:end-1)];
         %sz1=size(y_sig);
         %disp(sz1);
         y_buf=[y_sig;y_buf(1:M-1)];
         r1=sum(y_buf.*Y_sec_Ir);
    %disp(r1);
         r_buf1=[r1,r_buf1(1:end-1)];
         e=X_ps(n)+r1;


    %sz=size(Xr(n));
    %disp(sz);
   
    %sz1=size(r_1);
    %disp(sz1);
    
    %sz=size(u);
    %disp(sz);
    
    %y_buf=[y_signal;y_buf(1:N)];
    %sz1=size(y_buf);
    %disp(sz1);

    Aw=Aw-mu*e*r_buf;
    Bw=Bw-mu*e*y_buf_vector_last;
    y_buf_last=y_buf(1:N);
    y_buf_vector_last=r_buf1(1:N);
    E_t(n)=e;
    %sz1=size(r_buf1);
    %disp(r_buf1);
    %r1=sum(r_2*Y_sec_Ir);
    plot(y_signal,'*--');
    n_iter=n;
    control_signal(n)=y_sig;
    T2(n)=t(n);
    


end
figure(2)
%subplot(2,1,1)
plot(t,X_ps,'b',T2,E_t,'r');
title(  'Waveform Obtained by FuLMS Algorithm ' ) ;
xlabel ( ' time [ second ] ' ) ;
ylabel ( 'Pressure ' ) ;
