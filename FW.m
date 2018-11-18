

 function fw=FW(N,C,site,v0,R)

% N=8;
% C=[0,0,20,20,30,30,40,40;0,10,0,10,-10,20,0,10;20,20,30,30,40,40,60,60;0,10,-10,20,0,10,0,10];
% site=[10;1];
% v0=[1,0];
% R=0.2;


d=zeros(N,1);
riw=2.5;
Aw=10;
Bw=0.3;
K=6000;
k=4000;
fwz=zeros(N,2);
fw=zeros(1,2);


for i=1:N
    d(i)=abs(det([C(3:4,i)-C(1:2,i),site-C(1:2,i)]))/norm(C(3:4,i)-C(1:2,i));
end

Vi=sqrt(v0(1)^2+v0(2)^2);
Vix=v0(1)/Vi;
Viy=v0(2)/Vi;

for j=1:N
    if riw>=d(j)
        if C(1,j)~=C(3,j)
            x1=C(1,j);
            y1=C(2,j);
            x2=C(3,j);
            y2=C(4,j);
            k1=(y2-y1)/(x2-x1);
            b1=(x1*y2 - x2*y1)/(x1 - x2);
            if k1~=0
                k2=-1/k1;
                b2=site(2)-k2*site(1);
                x1=-(b1 - b2)/(k1 - k2);
                y1=-(b1*k2 - b2*k1)/(k1 - k2);
            else
                x1=site(1);
                y1=b1;
            end
        else
            x1=C(1,j);
            y1=site(2);
        end
        if x1<C(1,j) && x1<C(3,j) || x1>C(1,j) && x1>C(3,j)
            fw1=[0,0];
            fw2=[0,0];
        else
            xx1=x1-site(1);
            yy1=y1-site(2);
            Vx=xx1/(sqrt(xx1^2+yy1^2));
            Vy=yy1/(sqrt(xx1^2+yy1^2));
            Vi=-[Vx,Vy];
            fw1=(Aw*exp((R-d(j))/Bw)+k*(R-d(j)))*Vi;
            vj=null(Vi);
            Vj=-vj';
            fw2=K*(R-d(j))*Vj;
        end
        fwz(j,:)=fw1+fw2;
         elseif riw<d(j)
             fwz(j,:)=[0,0];
    end
            
    
    
%     if riw>=d(j) 
%                 if C(2,j)-C(4,j)<=0  %障碍物为水平墙
%                     if site(1)>=C(1,j) && site(1)>=C(3,j) || site(1)<=C(1,j) && site(1)<=C(3,j)
%                         fw1=[0,0];
%                         fw2=[0,0];
%                     else
%                     if site(2)-C(2,j)>0
%                         fw1=[0,Aw*exp((R-d(j))/Bw)];
%                         if d(j)<=R 
%                             fw2=[-K*(R-d(j))*Vix,k*(R-d(j))];
%                         elseif d(j)>R
%                             fw2=[0,0];
%                         end
%                     elseif site(2)-C(2,j)<0
%                         fw1=[0,-Aw*exp((R-d(j))/Bw)];
%                         if d(j)<=R 
%                             fw2=[-K*(R-d(j))*Vix,-k*(R-d(j))];
%                         elseif d(j)>R
%                             fw2=[0,0];
%                         end
%                     end
%                     end
%                 end
%                 if C(1,j)-C(3,j)>=0   %障碍物为竖直墙
%                     if site(2)>=C(2,j) && site(2)>=C(4,j) || site(2)<=C(2,j) && site(2)<=C(4,j)
%                         fw1=[0,0];
%                         fw2=[0,0];
%                     else
%                      if site(1)-C(1,j)>0
%                         fw1=[Aw*exp((R-d(j))/Bw),0];
%                         if d(j)<=R 
%                             fw2=[k*(R-d(j)),-K*(R-d(j))*Viy];
%                         elseif d(j)>R
%                             fw2=[0,0];
%                         end
%                     elseif site(1)-C(1,j)<0
%                         fw1=[-Aw*exp((R-d(j))/Bw),0];
%                         if d(j)<=R 
%                             fw2=[-k*(R-d(j)),-K*(R-d(j))*Viy];
%                         elseif d(j)>R
%                             fw2=[0,0];
%                         end
%                      end
%                     end
%                 end
%             fwz(i,:)=fw1+fw2;
%         elseif riw<d(j)
%             fwz(i,:)=[0,0];
%             end
            u=sum(fwz);
            fw=fw+u;
end
fw=fw';


