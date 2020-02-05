function DQPSKCode = qpskdecodef(QPSKCode, Length)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%�ú���ʵ��QPSK���
%%%%%QPSKCodeΪ�����������
%%%%%LengthΪԭʼ���еĳ���
%%%%%DQPSKCodeΪ����������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
DQPSKCode = zeros(size(QPSKCode));
% for i = 1 : Length
%     L = 2*i-1;
%     R = 2*i;
%     if QPSKCode(L)>=0 &  QPSKCode(R)>=0
%         DQPSKCode(L:R) = [1 1];
%     elseif QPSKCode(L)<=0 &  QPSKCode(R)>=0
%         DQPSKCode(L:R) = [0 1];
%     elseif QPSKCode(L)<=0 &  QPSKCode(R)<=0
%         DQPSKCode(L:R) = [0 0];
%     else
%         DQPSKCode(L:R) = [1 0];
%     end
% end
for i = 1 : Length
    L = 2*i-1;
    R = 2*i;
    if QPSKCode(L)>=0 &  QPSKCode(R)>=0
        DQPSKCode(L:R) = [QPSKCode(L) QPSKCode(R)];
    elseif QPSKCode(L)<=0 &  QPSKCode(R)>=0
        DQPSKCode(L:R) = [-QPSKCode(L) QPSKCode(R)];
    elseif QPSKCode(L)<=0 &  QPSKCode(R)<=0
        DQPSKCode(L:R) = [-QPSKCode(L) -QPSKCode(R)];
    else
        DQPSKCode(L:R) = [QPSKCode(L) -QPSKCode(R)];
    end
end