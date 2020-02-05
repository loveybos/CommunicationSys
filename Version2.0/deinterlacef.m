function [delace_code] = deinterlacef(input,lace_depth,lace_width)
%lace_depth 交织深度,lace_width 交织宽度
%与交织过程区别，行列顺序不同，其余部分相同

L = length(input);
lace_size = lace_width * lace_depth;

if L > lace_size             %适应交织矩阵小的情况
    zero_num = lace_size - rem(L,lace_size);%补偿0，构成最小公倍数，自己理解
    input = [input,zeros(size(1:zero_num))];
end
L = length(input);

input = [input,zeros(size(1:lace_size - L))];%同时适应交织矩阵大和相等情况
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

delace_code = reshape(temp_block,[1,L]);%reshape读取方式为按列读取