function ConCode = conencodef(OrigiSeq, Length)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%�ú���ʵ�־������
%%%%����OrigiSeqΪҪ�����ԭʼ���У������Ѿ������β����
%%%%LengthΪԭʼ���еĳ���
%%%%ConCodeΪ��õ�����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


ConCode1 = mod(conv(OrigiSeq, [1,1,1]), 2);%��֧·����������
ConCode2 = mod(conv(OrigiSeq, [1,0,1]), 2);%��֧·����������
ConCode1 = ConCode1(1:Length);
ConCode2 = ConCode2(1:Length);
ConCode = zeros(1,2*Length);
    for j = 1 : Length
        ConCode(2*j-1) = ConCode1(j);
        ConCode(2*j) = ConCode2(j);
    end