%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Version 2.0
%%% (2,1,3)��������
%%% ��֯
%%% ��Ƶ(���Ǹ����ʵ�α����룬���ǽ������ź��ӳ�)
%%% ��˹�������ŵ�(1W)
%%% ����
%%% �⽻֯
%%% viterbi����(ϵͳ����)
%%% BER����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc,close all,clear all
%% ���������ź�
CodeNum = 97;%������Ŀ
CodeLen = CodeNum + 3;%���β���غ��ԭʼ�����г���
OriCode = (sign(randn(1,CodeNum)) + 1) / 2;      %����ԭʼ��0��1��Ϣ����
OriCode = [OriCode 0 0 0] ;                  %���β����ʹ�����״̬����
%% �������
ConCode = conencodef(OriCode,CodeLen);      %(2,1,3)�������
%% ��֯
InterlaceCode = interlacef(ConCode,20,10);       %��֯(�����С���Բ�����)
InterlaceCode = 2 * InterlaceCode - 1; %��Ϊ˫����
%% ֱ����Ƶ����
coeff=[1 0 1 1];  %��ͷϵ����ȡ���ڱ�ԭ����ʽ
reg = [1 1 1];%�Ĵ�����ʼ״̬
PnCode = pncodef(coeff,reg);
PnCode = 2 * PnCode - 1;%��Ϊ˫����
SpreadCode = spreadf(InterlaceCode,PnCode);%��Ƶ����
%% QPSKӳ��
% QPSKCode = qpskencodef(SpreadCode,CodeLen);   %QPSK����(�����������)
TransLen = length(SpreadCode);
%% �Ӹ�˹������
a = 1;             %��������W
p = 10 * log10(a);      %����������Wת��ΪdBW
NoiseSeq = wgn(1,TransLen,p);             %�������Ը�˹������
RecCode = SpreadCode + NoiseSeq;               %���źż���
%% QPSK���
% DQPSKCode = qpskdecodef(RecCode,CodeLen);     %QPSK���
%% ����
DespreadCode = despreadf(RecCode,PnCode);%��Ƶ����
%% �⽻֯
Deinterlacecode = deinterlacef(DespreadCode,10,20);%�⽻֯
%% �о�
for i=1:length(Deinterlacecode)    %����һ��ǿ���о�
    if Deinterlacecode(i) > 0    
        Deinterlacecode(i) = 1;
    else 
        Deinterlacecode(i) = 0;
    end
end
%% ά�ر�����
% Decoder = Viterbi(DQPSKCode, CodeLen);      %�Լ�дά�ر����뺯��

trellis = poly2trellis(3,[7 5]);%��ConEncode�������뷽ʽ����һ��
% TRcode = convenc(OriCode,trellis);%����ϵͳ�Դ�trellis�ľ�����뺯��
tblen = 2;
Decoder = vitdec(Deinterlacecode,trellis,tblen,'trunc','hard');%�Դ����뺯��
%% �����ʷ���
ErrorNum = sum(abs(Decoder - OriCode));
BERate = ErrorNum / CodeNum