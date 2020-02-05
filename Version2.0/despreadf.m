function DespreadCode = despreadf(DataCode,PnCode) %Ω‚¿©

Datalen = length(DataCode);
Pnlen = length(PnCode);
n = Datalen / Pnlen;
DespreadArray =reshape(DataCode,[Pnlen,n]);
DespreadCode = PnCode * DespreadArray; %æÿ’Ûœ‡≥À