function ConCode = conencodef(OrigiSeq, Length)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%该函数实现卷积编码
%%%%其中OrigiSeq为要编码的原始序列，并且已经添加了尾比特
%%%%Length为原始序列的长度
%%%%ConCode为编好的码字
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


ConCode1 = mod(conv(OrigiSeq, [1,1,1]), 2);%上支路卷积编码输出
ConCode2 = mod(conv(OrigiSeq, [1,0,1]), 2);%下支路卷积编码输出
ConCode1 = ConCode1(1:Length);
ConCode2 = ConCode2(1:Length);
ConCode = zeros(1,2*Length);
    for j = 1 : Length
        ConCode(2*j-1) = ConCode1(j);
        ConCode(2*j) = ConCode2(j);
    end