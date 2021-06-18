x=0:0.01:1;
eps=10e-2;
fun=@(x) x-x.^2 + eps*(sin(2*pi.*x/eps)/(4*pi)-sin(2*pi.*x/eps).*x./(2*pi)-cos(2*pi.*x/eps)*eps/(4*pi.^2)+eps/(4*pi.^2));
fun_ex=@(x) x-x.^2;
y = fun(x);
y_ex = fun_ex(x);
figure
subplot(2,1,1)
plot(x,y);
title(['Micro-solution'])
subplot(2,1,2)
plot(x,y_ex);
title(['Macro-solution'])