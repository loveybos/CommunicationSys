# CommunicationSys
##Version 1
          `卷积码编码解码 QPSK调制解调`<br>
1> 随机生成基带数字信号0，1<br>
2> 对基带数字信号卷积编码<br>
3> 简易QPSK调制：只将卷积码两两映射为+1和-1，不与正弦信号相乘，<br>
```
  11->+1+1; 01->-1+1; 00->-1-1; 10->+1-1
 ```
 4> 产生0dBW的高斯白噪声，叠加到QPSK信号上(`此时白噪声功率1W，信号最大幅值也为1，误码率高`)<br>
 5> 简易QPSK解调：门限0判决<br>
 6> 卷积码Viterbi译码<br>
