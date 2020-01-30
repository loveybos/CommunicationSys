%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%Version1.0
%%%%(2,1,3)��������
%%%%����QPSK���ƣ����(���漰���Ҳ�)
%%%%viterbi����(ϵͳ����)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc,close all,clear all

CodeNum = 5;%������Ŀ
CodeLength = CodeNum + 3;%���β���غ��ԭʼ�����г���
OriCode=(sign(randn(1,CodeNum))+1)/2;      %����ԭʼ��0��1��Ϣ����
OriCode=[OriCode 0 0 0] ;                  %���β����ʹ�����״̬����

ConCode = ConEncode(OriCode, CodeLength)      %3�׾������
QPSKCode = QPSKEncode(ConCode, CodeLength);      %QPSK����(�����������)

a = 0.26;             %��������W
p = 10*log10(a);      %����������Wת��ΪdBW
NoiseSeq = wgn(1,2*CodeLength,p);             %�������Ը�˹������
RecCode = QPSKCode + NoiseSeq;               %���źż���

DQPSKCode = QPSKDecode(RecCode, CodeLength);     %QPSK���
% Decoder = Viterbi(DQPSKCode, CodeLength);      %�Լ�дά�ر����뺯��

trellis = poly2trellis(3,[7 5]);%��ConEncode�������뷽ʽ����һ��
% TRcode = convenc(OriCode,trellis);%����ϵͳ�Դ�trellis�ľ�����뺯��
tblen = 2;
Decoder = vitdec(DQPSKCode,trellis,tblen,'trunc','hard');%�Դ����뺯��