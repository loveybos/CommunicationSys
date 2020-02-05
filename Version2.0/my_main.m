%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Version 2.0
%%% (2,1,3)卷积码编码
%%% 交织
%%% 扩频(不是高速率的伪随机码，而是将基带信号延长)
%%% 高斯白噪声信道(1W)
%%% 解扩
%%% 解交织
%%% viterbi译码(系统函数)
%%% BER分析
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc,close all,clear all
%% 基带数字信号
CodeNum = 97;%码字数目
CodeLen = CodeNum + 3;%添加尾比特后的原始码序列长度
OriCode = (sign(randn(1,CodeNum)) + 1) / 2;      %产生原始的0或1信息序列
OriCode = [OriCode 0 0 0] ;                  %添加尾比特使编码后状态归零
%% 卷积编码
ConCode = conencodef(OriCode,CodeLen);      %(2,1,3)卷积编码
%% 交织
InterlaceCode = interlacef(ConCode,20,10);       %交织(矩阵大小可以不符合)
InterlaceCode = 2 * InterlaceCode - 1; %变为双极性
%% 直接扩频调制
coeff=[1 0 1 1];  %抽头系数，取决于本原多项式
reg = [1 1 1];%寄存器初始状态
PnCode = pncodef(coeff,reg);
PnCode = 2 * PnCode - 1;%变为双极性
SpreadCode = spreadf(InterlaceCode,PnCode);%扩频调制
%% QPSK映射
% QPSKCode = qpskencodef(SpreadCode,CodeLen);   %QPSK调制(不与正弦相乘)
TransLen = length(SpreadCode);
%% 加高斯白噪声
a = 1;             %噪声功率W
p = 10 * log10(a);      %将噪声功率W转换为dBW
NoiseSeq = wgn(1,TransLen,p);             %产生加性高斯白噪声
RecCode = SpreadCode + NoiseSeq;               %给信号加噪
%% QPSK解调
% DQPSKCode = qpskdecodef(RecCode,CodeLen);     %QPSK解调
%% 解扩
DespreadCode = despreadf(RecCode,PnCode);%扩频调制
%% 解交织
Deinterlacecode = deinterlacef(DespreadCode,10,20);%解交织
%% 判决
for i=1:length(Deinterlacecode)    %附加一个强行判决
    if Deinterlacecode(i) > 0    
        Deinterlacecode(i) = 1;
    else 
        Deinterlacecode(i) = 0;
    end
end
%% 维特比译码
% Decoder = Viterbi(DQPSKCode, CodeLen);      %自己写维特比译码函数

trellis = poly2trellis(3,[7 5]);%与ConEncode卷积码编码方式保持一致
% TRcode = convenc(OriCode,trellis);%利用系统自带trellis的卷积编码函数
tblen = 2;
Decoder = vitdec(Deinterlacecode,trellis,tblen,'trunc','hard');%自带译码函数
%% 误码率分析
ErrorNum = sum(abs(Decoder - OriCode));
BERate = ErrorNum / CodeNum