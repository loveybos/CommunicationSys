function Decoder = Viterbi(ConCode,Length)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%�ú���ʵ��ά�ر�����
%%%%ConCodeΪ����ľ����
%%%%LengthΪԭʼ���еĳ���
%%%%DecoderΪ�������������
%%%%S0->00,S1->10,S2->01,S3->11
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    RecSeq = ConCode;
    Decoder = zeros(1,Length);      %�洢ά�ر�����������
    D = zeros(1,4);                 %��¼����ĳһ״̬ʱ���ۼƺ�������
    DTemp = D;
    RouteS0 = zeros(1,2*Length);    %��¼����S0״̬��������·��
    RouteS1 = zeros(1,2*Length);    %��¼����S1״̬��������·��
    RouteS2 = zeros(1,2*Length);    %��¼����S2״̬��������·��
    RouteS3 = zeros(1,2*Length);    %��¼����S3״̬��������·��                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            = zeros(1,2*Length);
  
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%���ȵõ�����·��
    for k = 1 : Length
        if k == 1                   %��S0״̬��ʼ���룬��һ��ֻ���¼��S0״̬��
            D(1) = RecSeq(1) + RecSeq(2);%S1״̬��S2״̬ʱ�ĺ�������
            D(2) = abs(RecSeq(1)-1) + abs(RecSeq(2)-1);
        elseif k == 2                %�ڵڶ�ʱ�̵������״̬��·���ֱ�ΪS0->S0
            DTemp = D;               %S0->S1,S1->S2,S1->S3
            DS0_S0 = RecSeq(3) + RecSeq(4);
            DS0_S1 = abs(RecSeq(3)-1) + abs(RecSeq(4)-1);
            DS1_S2 = abs(RecSeq(3)-1) + RecSeq(4);
            DS1_S3 = RecSeq(3) + abs(RecSeq(4)-1);
            D(1) = DTemp(1) + DS0_S0;
            D(2) = DTemp(1) + DS0_S1;
            D(3) = DTemp(2) + DS1_S2;
            D(4) = DTemp(2) + DS1_S3;
            RouteS0(1:4) = [0 0 0 0];
            RouteS1(1:4) = [0 0 1 0];
            RouteS2(1:4) = [1 0 0 1];
            RouteS3(1:4) = [1 0 1 1];
        else
            %%%%�ӵ�3ʱ�̿�ʼ����·����ѡ��
            %%�������һʱ�̵���ʱ�̵�һ���������룬����ÿһ״̬��������·��
            DS0_S0 = RecSeq(2*k-1) + RecSeq(2*k);  
            DS2_S0 = abs(RecSeq(2*k-1)-1) + abs(RecSeq(2*k)-1);
            DS0_S1 = DS2_S0;
            DS2_S1 = DS0_S0;
            DS1_S2 = abs(RecSeq(2*k-1)-1) + RecSeq(2*k);
            DS3_S2 = RecSeq(2*k-1) + abs(RecSeq(2*k)-1);
            DS1_S3 = DS3_S2;
            DS3_S3 = DS1_S2;
            
            %%����ԭ����·�����ۼƺ�������
            RS0Temp = RouteS0(1:2*k-2);
            RS1Temp = RouteS1(1:2*k-2);
            RS2Temp = RouteS2(1:2*k-2);
            RS3Temp = RouteS3(1:2*k-2);
            DTemp = D;
            
            %%ͨ���Ƚ����õ��µ�·�����ۼƺ�������
            if (DTemp+DS0_S0 <= DTemp(3)+DS2_S0)
                D(1) = DTemp(1) + DS0_S0;
                RouteS0(1:2*k) = [RS0Temp 0 0];
            else
                D(1) = DTemp(3) + DS2_S0;
                RouteS0(1:2*k) = [RS2Temp 0 0];
            end
            
            if (DTemp(1)+DS0_S1 <= DTemp(3)+DS2_S1)
                D(2) = DTemp(1) + DS0_S1;
                RouteS1(1:2*k) = [RS0Temp 1 0];
            else
                D(2) = DTemp(3) + DS2_S1;
                RouteS1(1:2*k) = [RS2Temp 1 0];
            end
            
            if (DTemp(2)+DS1_S2 <= DTemp(4)+DS3_S2)
                D(3) = DTemp(2) + DS1_S2;
                RouteS2(1:2*k) = [RS1Temp 0 1];
            else
                D(3) = DTemp(4) + DS3_S2;
                RouteS2(1:2*k) = [RS3Temp 0 1];
            end
            
            if (DTemp(2)+DS1_S3 <= DTemp(4)+DS3_S3)
                D(4) = DTemp(2) + DS1_S3;
                RouteS3(1:2*k) = [RS1Temp 1 1];
            else
                D(4) = DTemp(4) + DS3_S3;
                RouteS3(1:2*k) = [RS3Temp 1 1];
            end
        end
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%��������·����״̬ת��ͼ������õ�����
    for m = 1 : Length
        if (m == 1)
            if (RouteS0(1) == 0)
                Decoder(1) = 0;
            else
                Decoder(1) = 1;
            end
        elseif (m == 2)
                if (RouteS0(3) == 0)
                    Decoder(2) = 0;
                else
                    Decoder(2) = 1;
                end
        else
            L1 = 2*m - 3;
            R1 = 2*m - 2;
            L2 = 2*m - 1;
            R2 = 2*m;
            if ((RouteS0(L1:R1)==[0 0]|RouteS0(L1:R1)==[0 1]) & RouteS0(L2:R2)==[0 0])
                Decoder(m) = 0;
            elseif ((RouteS0(L1:R1)==[1 0]|RouteS0(L1:R1)==[1 1]) & RouteS0(L2:R2)==[0 1])
                Decoder(m) = 0;
            else
                Decoder(m) = 1;
            end
        end
    end
  
