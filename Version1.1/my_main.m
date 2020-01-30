%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Version1.1
%%% (2,1,3)��������
%%% ��֯������QPSK����(���漰���Ҳ�)
%%% ��˹�������ŵ�(0.26W)
%%% ������⽻֯
%%% viterbi����(ϵͳ����)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc,close all,clear all
%%
CodeNum = 5;%������Ŀ
CodeLen = CodeNum + 3;%���β���غ��ԭʼ�����г���
OriCode=(sign(randn(1,CodeNum)) + 1) / 2;      %����ԭʼ��0��1��Ϣ����
OriCode=[OriCode 0 0 0] ;                  %���β����ʹ�����״̬����
%%
ConCode = ConEncode(OriCode,CodeLen);      %(2,1,3)�������
InterlaceCode = interlace(ConCode,4,4);       %��֯(�����С���Բ�����)
QPSKCode = QPSKEncode(InterlaceCode,CodeLen);   %QPSK����(�����������)
TransLen = length(QPSKCode);
%%
a = 0.26;             %��������W
p = 10 * log10(a);      %����������Wת��ΪdBW
NoiseSeq = wgn(1,TransLen,p);             %�������Ը�˹������
RecCode = QPSKCode + NoiseSeq;               %���źż���
%%
DQPSKCode = QPSKDecode(RecCode,CodeLen);     %QPSK���
deinterlacecode = deinterlace(DQPSKCode,4,4);%�⽻֯

% Decoder = Viterbi(DQPSKCode, CodeLen);      %�Լ�дά�ر����뺯��

trellis = poly2trellis(3,[7 5]);%��ConEncode�������뷽ʽ����һ��
% TRcode = convenc(OriCode,trellis);%����ϵͳ�Դ�trellis�ľ�����뺯��
tblen = 2;
Decoder = vitdec(deinterlacecode,trellis,tblen,'trunc','hard');%�Դ����뺯��