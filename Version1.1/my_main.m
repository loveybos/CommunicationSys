%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Version1.1
%%% (2,1,3)卷积码编码
%%% 交织，简易QPSK调制(不涉及正弦波)
%%% 高斯白噪声信道(0.26W)
%%% 解调，解交织
%%% viterbi译码(系统函数)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc,close all,clear all
%%
CodeNum = 5;%码字数目
CodeLen = CodeNum + 3;%添加尾比特后的原始码序列长度
OriCode=(sign(randn(1,CodeNum)) + 1) / 2;      %产生原始的0或1信息序列
OriCode=[OriCode 0 0 0] ;                  %添加尾比特使编码后状态归零
%%
ConCode = ConEncode(OriCode,CodeLen);      %(2,1,3)卷积编码
InterlaceCode = interlace(ConCode,4,4);       %交织(矩阵大小可以不符合)
QPSKCode = QPSKEncode(InterlaceCode,CodeLen);   %QPSK调制(不与正弦相乘)
TransLen = length(QPSKCode);
%%
a = 0.26;             %噪声功率W
p = 10 * log10(a);      %将噪声功率W转换为dBW
NoiseSeq = wgn(1,TransLen,p);             %产生加性高斯白噪声
RecCode = QPSKCode + NoiseSeq;               %给信号加噪
%%
DQPSKCode = QPSKDecode(RecCode,CodeLen);     %QPSK解调
deinterlacecode = deinterlace(DQPSKCode,4,4);%解交织

% Decoder = Viterbi(DQPSKCode, CodeLen);      %自己写维特比译码函数

trellis = poly2trellis(3,[7 5]);%与ConEncode卷积码编码方式保持一致
% TRcode = convenc(OriCode,trellis);%利用系统自带trellis的卷积编码函数
tblen = 2;
Decoder = vitdec(deinterlacecode,trellis,tblen,'trunc','hard');%自带译码函数