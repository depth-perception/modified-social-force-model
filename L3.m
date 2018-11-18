% clear
clc; clear; close all;
 
figure('NumberTitle','off','name','小球运动录制'); 

set(gca,'nextplot','replacechildren','box','off','color','w','xgrid','off');


N=10;%定义模拟人个数
n=8;%定义障碍物个数
nj=10;%定义节点个数
C0=[5,10];%定义模拟人生成区域
%定义通道
C=[0,0,20,20,30,30,40,40;0,10,0,10,-10,20,0,10;20,20,30,30,40,40,60,60;0,10,-10,20,0,10,0,10];
C1=[0;0];
C2=[0;10];
C3=[20;10];
C4=[20;0];
C5=[30;20];
C6=[30;-10];
C7=[40;10];
C8=[40;0];
C9=[60;10];
C10=[60;0];
J=[0,0,20,20,30,30,40,40,60,60;0,10,10,0,20,-10,10,0,10,0];

%产生模拟人信息
A=person(N,C0);
siteX=A(1,:);%定义模拟人x位置
siteY=A(2,:);%定义模拟人y位置
site=[siteX;siteY];
% Circle=cell{1,N};
% for ii=1:N
%     Circle(ii)=circle(site(ii,:));
% end
M=A(3,:);%定义模拟人质量
Vx=A(4,:);%定义模拟人x方向向量
Vy=A(5,:);%定义模拟人y方向向量
R=A(6,:);%定义模拟人肩宽
Fz=zeros(2,N);%定义模拟人合力
v0 =zeros(2,N);%定义模拟人（每次循环的）初速度
Vq=zeros(2,N);%定义模拟人期望速度
Fc=zeros(2,N);
% Fw=zeros(2,N);

dt = 0.05;%定义模拟循环一次的实际间隔时间
ts=0.5;%定义模拟人延迟时间（即反应时间）
V1=1.21;%定义模拟人期望速率
Ai=2000;%定义模拟人之间的作用强度
Bi=0.08;%定义模拟人之间的影响范围
Aw=10;%定义模拟人与障碍物的作用强度
Bw=0.3;%定义模拟人与障碍物的影响范围
rij=4;%定义模拟人之间作用力产生的心理范围
riw=2.5;%定义模拟人与墙之间作用力产生的心理范围
k=40000;%定义模拟人之间接触后产生的挤压力的正压力系数
K=60000;%滑动摩擦力系数
uij=0.1;%行人运动各向异性参数
P=zeros(2,N);%定义模拟人目标方向点

h = animatedline('color','w','linewidth',0.0001,'marker','.','markersize',25,'MarkerEdgeColor','r','MaximumNumPoints',N);
line([C1(1),C4(1)],[C1(2),C4(2)],'linewidth',10,'color','b');
line([C2(1),C3(1)],[C2(2),C3(2)],'linewidth',10,'color','b');
line([C3(1)-0.5,C5(1)+0.5],[C3(2)-0.5,C5(2)+0.5],'linewidth',10,'color','b');
line([C4(1)-0.5,C6(1)+0.5],[C4(2)+0.5,C6(2)-0.5],'linewidth',10,'color','b');
line([C5(1)-0.5,C7(1)+0.5],[C5(2)+0.5,C7(2)-0.5],'linewidth',10,'color','b');
line([C6(1)-0.5,C8(1)+0.5],[C6(2)-0.5,C8(2)+0.5],'linewidth',10,'color','b');
line([C7(1),C9(1)],[C7(2),C9(2)],'linewidth',10,'color','b');
line([C8(1),C10(1)],[C8(2),C10(2)],'linewidth',10,'color','b');
hold on;


% LOOP
for T=1:750
    for i=1:N
        
        cir=circle(site(:,i));
        
        
        %计算驱动力
        a=Fz(:,i)./M(i);
        t = dt;
        Vit= v0(:,i) + a .* t;
        Vq(:,i)=[V1*Vx(i);V1*Vy(i)];
        if abs(Vit(1))>abs(Vq(1,i)) &&Vit(1)*Vq(1,i)>=0
            Vit(1)=Vq(1,i);
        elseif abs(Vit(1))>abs(Vq(1,i)) &&Vit(1)*Vq(1,i)<0
            Vit(1)=-Vq(1,i);
        end
        if abs(Vit(2))>abs(Vq(2,i)) &&Vit(2)*Vq(2,i)>=0
            Vit(2)=Vq(2,i);
        elseif abs(Vit(2))>abs(Vq(2,i)) &&Vit(2)*Vq(2,i)<0
            Vit(2)=-Vq(2,i);
        end
        v0(:,i)=Vit;
        fq=M(i)*(Vq(:,i)-Vit)/ts; 
        Fq(:,i)=[fq(1);fq(2)];

        
        %计算与人的作用力
        for j=1:N
            if i~=j
 
                x=siteX(i)-siteX(j);
                y=siteY(i)-siteY(j);
                dij=sqrt(x^2+y^2);
                Vjx=x/dij;
                Vjy=y/dij;
                lij=R(i)+R(j);
                
                cosxj=(Vx(i)*Vjx+Vy(i)*Vjy)/(sqrt(Vx(i)^2+Vy(i)^2)*sqrt(Vjx^2+Vjy^2));
                wj=uij+(1-uij)*(1+cosxj)/2;
                
                if rij>dij && lij<dij   %人与人进入不舒服范围产生的心理排斥力
                    fh=Ai*exp((lij-dij)/Bi)*wj;
                    Fh(:,j)=[fh*Vjx;fh*Vjy];
                elseif rij>dij && lij>=dij  %人与人之间接触产生的挤压力和心理排斥力
                    fh=Ai*exp((lij-dij)/Bi)*wj+k*(lij-dij);
                    Vp1=[-Vjy;Vjx];
                    Vi1=sum((v0(:,j)-v0(:,i)).*Vp1);
                    fh2=K*(lij-dij)*Vi1;
                    Fh(:,j)=[fh*Vjx;fh*Vjy]+fh2*Vp1;
                    Fc(:,j)=Fh(:,j);
                elseif rij<=dij  %人与人之间距离较远，不发生力
                    Fh(:,j)=[0;0];
                end
            end
        end
        Fj(i,:)=sum(Fh');
        if abs(Fj(i,1))>6000 && Fj(i,1)>0
            Fj(i,1)=6000;
        elseif abs(Fj(i,1))>6000 && Fj(i,1)<0
            Fj(i,1)=-6000;
        end
        if abs(Fj(i,2))>6000 && Fj(i,2)>0
            Fj(i,2)=6000;
        elseif abs(Fj(i,2))>6000 && Fj(i,2)<0
            Fj(i,2)=-6000;
        end
% Fj=[0;0];
        
        %计算与障碍物的作用力
                
         Fw(:,i)=FW(n,C,site(:,i),v0(:,i),R(i));
        
        
        %计算合力
        Fz(1,i)=Fq(1,i)+Fj(i,1)+Fw(1,i);
        Fz(2,i)=Fq(2,i)+Fj(i,2)+Fw(2,i);
        
        %更新行人信息        

        ax=Fz(1,i)./M(i);
        ay=Fz(2,i)./M(i);
        siteX(i)=ax./2.*t.^2+v0(1,i).*t+siteX(i);
        siteY(i)=ay./2.*t.^2+v0(2,i).*t+siteY(i);
        
        if siteX(i)<20
            if siteY(i)<0
                siteY(i)=0;
            elseif siteY(i)>10
                siteY(i)=10;
            end
        end
         if siteX(i)>40
            if siteY(i)<0
                siteY(i)=0;
            elseif siteY(i)>10
                siteY(i)=10;
            end
         end
        
        
        site(:,i)=[siteX(i);siteY(i)];
        
        fx=FX(cir,n,C,site(:,i),Vx(i),Vy(i));
        Vx(i)=fx(1);
        Vy(i)=fx(2);
        P(1,i)=fx(3);
        P(2,i)=fx(4);
        
%         if siteX(i)>30.5
%         xi=P(1)-siteX(i);
%         yi=P(2)-siteY(i);
%         l=sqrt(xi^2+yi^2);
%         Vx(i)=xi/l;
%         Vy(i)=yi/l;
%         elseif siteX(i)<=30.5
%             Vx(i)=Vx(i);
%             Vy(i)=Vy(i);
%         end

             
    end
    
            for c=1:N
                addpoints(h,siteX(c),siteY(c));
                drawnow;
            end
        axis([0 70 -15 25]);
        
end
drawnow;
