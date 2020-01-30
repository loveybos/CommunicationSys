%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%Version1.0
%%%%(2,1,3)卷积码编码
%%%%简易QPSK调制，解调(不涉及正弦波)
%%%%viterbi译码(系统函数)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc,close all,clear all

CodeNum = 5;%码字数目
CodeLength = CodeNum + 3;%添加尾比特后的原始码序列长度
OriCode=(sign(randn(1,CodeNum))+1)/2;      %产生原始的0或1信息序列
OriCode=[OriCode 0 0 0] ;                  %添加尾比特使编码后状态归零

ConCode = ConEncode(OriCode, CodeLength)      %3阶卷积编码
QPSKCode = QPSKEncode(ConCode, CodeLength);      %QPSK调制(不与正弦相乘)

a = 0.26;             %噪声功率W
p = 10*log10(a);      %将噪声功率W转换为dBW
NoiseSeq = wgn(1,2*CodeLength,p);             %产生加性高斯白噪声
RecCode = QPSKCode + NoiseSeq;               %给信号加噪

DQPSKCode = QPSKDecode(RecCode, CodeLength);     %QPSK解调
% Decoder = Viterbi(DQPSKCode, CodeLength);      %自己写维特比译码函数

trellis = poly2trellis(3,[7 5]);%与ConEncode卷积码编码方式保持一致
% TRcode = convenc(OriCode,trellis);%利用系统自带trellis的卷积编码函数
tblen = 2;
Decoder = vitdec(DQPSKCode,trellis,tblen,'trunc','hard');%自带译码函数