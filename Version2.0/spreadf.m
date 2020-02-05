function SpreadCode = spreadf(DataCode,PnCode)

Datalen = length(DataCode);
Pnlen = length(PnCode);
SpreadArray =DataCode' * PnCode;
k = 1;
SpreadCode = zeros(1,Datalen * Pnlen);
for i = 1:Datalen
    for j = 1:Pnlen
        SpreadCode(k) = SpreadArray(i,j);%也可以直接用reshape函数
        k = k + 1;
    end
end
end