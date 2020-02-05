function [delace_code] = deinterlacef(input,lace_depth,lace_width)
%lace_depth ��֯���,lace_width ��֯���
%�뽻֯������������˳��ͬ�����ಿ����ͬ

L = length(input);
lace_size = lace_width * lace_depth;

if L > lace_size             %��Ӧ��֯����С�����
    zero_num = lace_size - rem(L,lace_size);%����0��������С���������Լ����
    input = [input,zeros(size(1:zero_num))];
end
L = length(input);

input = [input,zeros(size(1:lace_size - L))];%ͬʱ��Ӧ��֯������������
L = length(input);

n_block = ceil(L / lace_size);
temp_block = zeros(lace_depth,lace_width * n_block);

p = 1;
for i = 1:n_block
    for j = 1:lace_depth
        for k = 1:lace_width
            temp_block(j,lace_width*(i-1)+k) = input(p);
            p = p + 1;
        end
    end
end

delace_code = reshape(temp_block,[1,L]);%reshape��ȡ��ʽΪ���ж�ȡ