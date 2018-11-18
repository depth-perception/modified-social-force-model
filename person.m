function B=person(N,C0)
%生成模拟人
b=0.2*ones(1,N); %生成模拟小球半径

S=C0; %生产区域大小
B=zeros(5,N);%生成模拟人信息
%以上是给定的条件，根据你自己的数据给出
%不过根据半径数据的大小，N不能太大
%要不然可能要化很多时间，或者找不到填充位置进入死循环

%定义个体坐标
p=b(1)+(S-2*b(1)).*rand(1,2);%差生一个随机点
A=p';%第一点坐标记录进矩阵A中
plot([0 40 40 0 0],[0 0 40 40 0]);hold on %画区域方框
for ii=2:N
    p=b(ii)+(S-2*b(ii)).*rand(1,2);%产生一个新随机点
    while any((A(1,:)-p(1)).^2+(A(2,:)-p(2)).^2<((b(1:ii-1)+b(ii)).^2))
        p=b(ii)+(S-2*b(ii)).*rand(1,2);
    end %根据距离判断新的点是否和所有旧的点距离都满足条件
        %如果有一点不满足条件，重新生成随机点，知道完全满足条件
    A(1,ii)=p(1);
    A(2,ii)=p(2);%保存新的点到矩阵A中
end
hold off
axis equal
axis([0 40 0 40]);
B(1,:)=A(1,:);
B(2,:)=A(2,:);

%生产模拟人重量
weightave=50;
u1=5;
for i=1:N
    m=normrnd(weightave,u1);
    B(3,i)=m;
end

%生成模拟人方向
for i=1:N
        vox=1;
        voy=0;
    B(4,i)=vox;
    B(5,i)=voy;
end
B=[B;b];