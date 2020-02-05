function out = pncodef(coeff,reg)

N=2^length(reg)-1;     %周期
for k=1:N           %计算一个周期的m序列输出
    a1=mod(sum(reg.*coeff(1:length(coeff)-1)),2);   %反馈系数
    out(k)=reg(1);     %寄存器最低位输出
    reg=[reg(2:length(reg)),a1]; %寄存器位移
end
end
%也可以由primpoly（r）生成本原多项式
