function out = pncodef(coeff,reg)

N=2^length(reg)-1;     %����
for k=1:N           %����һ�����ڵ�m�������
    a1=mod(sum(reg.*coeff(1:length(coeff)-1)),2);   %����ϵ��
    out(k)=reg(1);     %�Ĵ������λ���
    reg=[reg(2:length(reg)),a1]; %�Ĵ���λ��
end
end
%Ҳ������primpoly��r�����ɱ�ԭ����ʽ
