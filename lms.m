freq=50;
phi=pi/3;
sample=20*freq;
dt=1/sample;
t=0:dt:10;
t=t';
X_s=3*sin(2*pi*freq*t+phi);
figure(1)
plot(t,X_s);
title('primary noise');
xlabel('t');
ylabel('pressure');
X_r=sin(2*pi*freq*t);
%fir filter
N=50;
W=zeros(N,1);
mu=0.0001;
Y_t=zeros();
E_t=zeros();
Xr_in=zeros(N,1);
M=length(t);
T2=zeros();
for n=1:M
    Xr_in=[X_r(n);Xr_in(1:N-1)];
    Y=sum(Xr_in.*W);
    e=X_s(n)+Y;
    W=W-mu*e*Xr_in;
    E_t(n)=e;
    Y_t(n)=Y;
    figure(3);
    plot(W,'*--');
    xlabel('Nth weight');
    n_iter=n;
    T2(n)=t(n);
end




