function DespreadCode = despreadf(DataCode,PnCode) %����

Datalen = length(DataCode);
Pnlen = length(PnCode);
n = Datalen / Pnlen;
DespreadArray =reshape(DataCode,[Pnlen,n]);
DespreadCode = PnCode * DespreadArray; %�������