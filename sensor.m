  function A=sensor(B,site,N,C,Vx,Vy)

% site=[5,6];
% N=8;
% C=[0,0,20,20,30,30,40,40;0,10,0,10,-10,20,0,10;20,20,30,30,40,40,60,60;0,10,-10,20,0,10,0,10];
% Vx=1;
% Vy=0;

A=zeros(3,180);
distance=zeros(1,N);
R=10;
point=zeros(N,2);
pointend=B';

for i=1:180
    for j=1:N
        intersection=JD(site,pointend(i,:),C(1:2,j),C(3:4,j));
        if isempty(intersection)
            distance(j)=R;
            point(j,:)=pointend(i,:);
        else
            distance(j)=sqrt((intersection(1)-site(1))^2+(intersection(2)-site(2))^2);
            point(j,:)=intersection;
        end
        
    end
    [x,y]= find(distance==min(distance));
    ipoint=point(y,:);
    A(1,i)=min(distance);
    A(2,i)=ipoint(1,1);
    A(3,i)=ipoint(1,2);
end