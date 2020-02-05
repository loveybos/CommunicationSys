function QPSKCode = qpskencodef(ConCode, Length)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%该函数实现QPSK调制
%%%%%ConCode为要调制的序列
%%%%%Length为原始序列的长度
%%%%%QPSKCode为调制好的序列
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
QPSKCode = zeros(size(ConCode));
for i = 1 : Length
    L = 2*i-1;
    R = 2*i;
    if ConCode(L:R) == [1 1]
        QPSKCode(L:R) = [1 1];
    elseif ConCode(L:R) == [0 1]
        QPSKCode(L:R) = [-1 1];
    elseif ConCode(L:R) == [0 0]
        QPSKCode(L:R) = [-1 -1];
    else
        QPSKCode(L:R) = [1 -1];
    end
end
        
        