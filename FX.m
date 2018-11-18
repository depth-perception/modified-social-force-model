 function fx=FX(cir,N,C,site,Vx,Vy)

% N=8;
% C=[0,0,20,20,30,30,40,40;0,10,0,10,-10,20,0,10;20,20,30,30,40,40,60,60;0,10,-10,20,0,10,0,10];
% site=[10;3];
% Vx=1;
% Vy=0;

R=10;
B=eyes(cir,site,Vx,Vy);
A=sensor(B,site,N,C,Vx,Vy);
for i=1:180
    if A(1,i)==R
        P1=A(2:3,i);
        break
    end
end
for j=1:180
    if A(1,181-j)==R
        P2=A(2:3,181-j);
        break
    end
end
P=(P1+P2)/2;
if P~=site
    X=P(1)-site(1);
    Y=P(2)-site(2);
    d=sqrt(X^2+Y^2);
    Vx=X/d;
    Vy=Y/d;
else
    Vx=Vx;
    Vy=Vy;
end
fx=[Vx;Vy;P(1);P(2)];



% d=101*ones(N,1);
% d1=zeros(N,1);
% d2=zeros(N,1);
% k=zeros(N,1);
% b=zeros(N,1);
% x=zeros(N,1);
% y=zeros(N,1);
% 
% V0=[Vx,Vy];
% vi=null(V0);
% Vi=vi;
% l=site+10*Vi;
% l2=site-10*Vi;
% 
% syms x1 x2 y1 y2
% K1=(y2-y1)/(x2-x1);
% B1=(x1*y2 - x2*y1)/(x1 - x2);
% 
% if l(1)~=site(1)
% syms x1 x2 y1 y2
% K1=(y2-y1)/(x2-x1);
% B1=(x1*y2 - x2*y1)/(x1 - x2);
% k1=subs(K1,{x1,y1,x2,y2},{l(1),l(2),site(1),site(2)});
% b1=subs(B1,{x1,y1,x2,y2},{l(1),l(2),site(1),site(2)});
% k2=subs(K1,{x1,y1,x2,y2},{l2(1),l2(2),site(1),site(2)});
% b2=subs(B1,{x1,y1,x2,y2},{l2(1),l2(2),site(1),site(2)});
% 
% for i=1:N
%     syms x1 x2 y1 y2
% K1=(y2-y1)/(x2-x1);
% B1=(x1*y2 - x2*y1)/(x1 - x2);
%     k(i)=subs(K1,{x1,y1,x2,y2},{C(1,i),C(2,i),C(3,i),C(4,i)});
%     b(i)=subs(B1,{x1,y1,x2,y2},{C(1,i),C(2,i),C(3,i),C(4,i)});
%     %x(i)=l(1);
%     %y(i)=k(i)*x(i)+b(i);
%     x(i)=-(b1 - b(i))/(k1 - k(i));
%     y(i)=-(b1*k(i) - b(i)*k1)/(k1 - k(i));
%     if x(i)<C(1,i) && x(i)>C(3,i) || x(i)>C(1,i) && x(i)<C(3,i)
%         d1(i)=(x(i)-site(1))^2+(y(i)-site(2))^2;
%         if d1(i)>100
%             d1(i)=101;
%         end
%     end
% end
% 
% 
% for a=1:N
%     syms x1 x2 y1 y2
% K1=(y2-y1)/(x2-x1);
% B1=(x1*y2 - x2*y1)/(x1 - x2);
%     k(a)=subs(K1,{x1,y1,x2,y2},{C(1,a),C(2,a),C(3,a),C(4,a)});
%     b(a)=subs(B1,{x1,y1,x2,y2},{C(1,a),C(2,a),C(3,a),C(4,a)});
%     %x(a)=l(1);
%     %y(a)=k(i)*x(i)+b(i);
%     x(a)=-(b2 - b(a))/(k2 - k(a));
%     y(a)=-(b2*k(a) - b(a)*k2)/(k2 - k(a));
%     if x(a)<C(1,a) && x(a)>C(3,a) || x(a)>C(1,a) && x(a)<C(3,a)
%         d2(a)=(x(a)-site(1))^2+(y(a)-site(2))^2;
%         if d2(a)>100
%             d2(a)=101;
%         end
%     end
% end
% 
% else
%     for i=1:N
%         syms x1 x2 y1 y2
% K1=(y2-y1)/(x2-x1);
% B1=(x1*y2 - x2*y1)/(x1 - x2);
%     k(i)=subs(K1,{x1,y1,x2,y2},{C(1,i),C(2,i),C(3,i),C(4,i)});
%     b(i)=subs(B1,{x1,y1,x2,y2},{C(1,i),C(2,i),C(3,i),C(4,i)});
%     x(i)=l(1);
%     y(i)=k(i)*x(i)+b(i);
%     if x(i)<C(1,i) && x(i)>C(3,i) || x(i)>C(1,i) && x(i)<C(3,i)
%         d1(i)=(x(i)-site(1))^2+(y(i)-site(2))^2;
%         if d1(i)>100
%             d1(i)=101;
%         end
%     end
% end
% 
% 
% for a=1:N
%     syms x1 x2 y1 y2
% K1=(y2-y1)/(x2-x1);
% B1=(x1*y2 - x2*y1)/(x1 - x2);
%     k(a)=subs(K1,{x1,y1,x2,y2},{C(1,a),C(2,a),C(3,a),C(4,a)});
%     b(a)=subs(B1,{x1,y1,x2,y2},{C(1,a),C(2,a),C(3,a),C(4,a)});
%     x(a)=l(1);
%     y(a)=k(i)*x(i)+b(i);
%     if x(a)<C(1,a) && x(a)>C(3,a) || x(a)>C(1,a) && x(a)<C(3,a)
%         d2(a)=(x(a)-site(1))^2+(y(a)-site(2))^2;
%         if d2(a)>100
%             d2(a)=101;
%         end
%     end
% end
% end
% 
% 
% for j=1:N
%     if d1(j)==101
%         X1=l(1);
%         Y1=l(2);
%     else
%         syms x1 x2 y1 y2
%         K1=(y2-y1)/(x2-x1);
%         B1=(x1*y2 - x2*y1)/(x1 - x2);
%         k(j)=subs(K1,{x1,y1,x2,y2},{C(1,j),C(2,j),C(3,j),C(4,j)});
%         b(j)=subs(B1,{x1,y1,x2,y2},{C(1,j),C(2,j),C(3,j),C(4,j)});
%         x1=-(b(j) - (b(j) + site(2)*k(j)^2 + site(1)*k(j) + k(j)*(100*k(j)^2 - b(j)^2 - site(1)^2*k(j)^2 + 2*site(2)*b(j) - site(2)^2 + 2*site(1)*site(2)*k(j) - 2*site(1)*b(j)*k(j) + 100)^(1/2))/(k(j)^2 + 1))/k(j);
%         y1=(b(j) + site(2)*k(j)^2 + site(1)*k(j) + k(j)*(100*k(j)^2 - b(j)^2 - site(1)^2*k(j)^2 + 2*site(2)*b(j) - site(2)^2 + 2*site(1)*site(2)*k(j) - 2*site(1)*b(j)*k(j) + 100)^(1/2))/(k(j)^2 + 1);
%         x2= -(b(j) - (b(j) + site(2)*k(j)^2 + site(1)*k(j) - k(j)*(100*k(j)^2 - b(j)^2 - site(1)^2*k(j)^2 + 2*site(2)*b(j) - site(2)^2 + 2*site(1)*site(2)*k(j) - 2*site(1)*b(j)*k(j) + 100)^(1/2))/(k(j)^2 + 1))/k(j);
%         y2= (b(j) + site(2)*k(j)^2 + site(1)*k(j) - k(j)*(100*k(j)^2 - b(j)^2 - site(1)^2*k(j)^2 + 2*site(2)*b(j) - site(2)^2 + 2*site(1)*site(2)*k(j) - 2*site(1)*b(j)*k(j) + 100)^(1/2))/(k(j)^2 + 1);
%         
%         cosa=((x1-site(1))*Vx+(y1-site(2))*Vy)/(sqrt((x1-site(1))^2+(y1-site(2))^2)*sqrt(Vx^2+Vy^2));
%         cosb=((x2-site(1))*Vx+(y2-site(2))*Vy)/(sqrt((x2-site(1))^2+(y2-site(2))^2)*sqrt(Vx^2+Vy^2));
%         
%         if cosa>0
%             X1=x1;
%             Y1=y1;
%             break
%         elseif cosb>0
%             X1=x2;
%             Y1=y2;
%             break
%         end
%     
%     end
% end
% 
% 
% 
% 
% for j2=1:N
%     if d2(j2)~=101
%         syms x1 x2 y1 y2
%         K1=(y2-y1)/(x2-x1);
%         B1=(x1*y2 - x2*y1)/(x1 - x2);
%         k(j2)=subs(K1,{x1,y1,x2,y2},{C(1,j2),C(2,j2),C(3,j2),C(4,j2)});
%         b(j2)=subs(B1,{x1,y1,x2,y2},{C(1,j2),C(2,j2),C(3,j2),C(4,j2)});
%         x3=-(b(j2) - (b(j2) + site(2)*k(j2)^2 + site(1)*k(j2) + k(j2)*(100*k(j2)^2 - b(j2)^2 - site(1)^2*k(j2)^2 + 2*site(2)*b(j2) - site(2)^2 + 2*site(1)*site(2)*k(j2) - 2*site(1)*b(j2)*k(j2) + 100)^(1/2))/(k(j2)^2 + 1))/k(j2);
%         y3=(b(j2) + site(2)*k(j2)^2 + site(1)*k(j2) + k(j2)*(100*k(j2)^2 - b(j2)^2 - site(1)^2*k(j2)^2 + 2*site(2)*b(j2) - site(2)^2 + 2*site(1)*site(2)*k(j2) - 2*site(1)*b(j2)*k(j2) + 100)^(1/2))/(k(j2)^2 + 1);
%         x4= -(b(j2) - (b(j2) + site(2)*k(j2)^2 + site(1)*k(j2) - k(j2)*(100*k(j2)^2 - b(j2)^2 - site(1)^2*k(j2)^2 + 2*site(2)*b(j2) - site(2)^2 + 2*site(1)*site(2)*k(j2) - 2*site(1)*b(j2)*k(j2) + 100)^(1/2))/(k(j2)^2 + 1))/k(j2);
%         y4= (b(j2) + site(2)*k(j2)^2 + site(1)*k(j2) - k(j2)*(100*k(j2)^2 - b(j2)^2 - site(1)^2*k(j2)^2 + 2*site(2)*b(j2) - site(2)^2 + 2*site(1)*site(2)*k(j2) - 2*site(1)*b(j)*k(j2) + 100)^(1/2))/(k(j2)^2 + 1);
%         
%         cosc=((x3-site(1))*Vx+(y3-site(2))*Vy)/(sqrt((x3-site(1))^2+(y3-site(2))^2)*sqrt(Vx^2+Vy^2));
%         cosd=((x4-site(1))*Vx+(y4-site(2))*Vy)/(sqrt((x4-site(1))^2+(y4-site(2))^2)*sqrt(Vx^2+Vy^2));
%         
%         if cosc>0
%             X2=x3;
%             Y2=y3;
%             break
%         elseif cosd>0
%             X2=x4;
%             Y2=y4;
%             break
%         end
%     else
%         X2=l2(1);
%         Y2=l2(2);
%     end
% end
% P=([X1;Y1]+[X2;Y2])./2;
% 
% xx1=P(1)-site(1);
% yy1=P(2)-site(2);
% Vx1=xx1/(sqrt(xx1^2+yy1^2));
% Vy1=yy1/(sqrt(xx1^2+yy1^2));
% fx=[Vx1;Vy1;P];
%                             


% function fx=FX(N,J,site,Vx,Vy)
% 
% % n=zeros(1,2)
% % 
% % xx1=cos(85/180*pi)+Vx;
% % yy1=sin(85/180*pi)+Vy;
% % xx2=cos(-85/180*pi)+Vx;
% % yy2=sin(-85/180*pi)+Vy;
% % [b1,k1]=solve('k1*site(1)-site(2)+b1=0','k1*xx1-yy1+b1=0');
% % [b2,k2]=solve('k2*site(1)-site(2)+b2=0','k2*xx2-yy2+b2=0');
% % 
% % for i=1:N
% %     [b(i),k(i)]=solve('k(i)*C(1,i)-C(2,i)+b(i)=0','k(i)*C(3,i)-C(4,i)+b(i)=0');
% %     if k(i)~=k1
% %         S = solve('y=k1*x+b1','y=k(i)*x+b(i)','x','y');
% %         x1=S.x;
% %         y1=S.y;
% %         if site(1)<xx1 && site(1)<=x1 || site(1)>xx1 && site(1)>=x1
% %             n(1)=i;
% %             break;
% %         else
% %             continue;
% %         end
% %     else
% %         continue;
% %     end
% % 
% % end
% % 
% % for j=1:N
% %     [b(j),k(j)]=solve('k(j)*C(1,j)-C(2,j)+b(j)=0','k(j)*C(3,j)-C(4,j)+b(j)=0');
% %     if k(j)~=k2
% %         S = solve('y=k2*x+b2','y=k(j)*x+b(j)','x','y');
% %         x2=S.x;
% %         y2=S.y;
% %         if site(1)<xx2 && site(1)<=x2 || site(1)>xx2 && site(1)>=x2
% %             n(2)=j;
% %             break;
% %         else
% %             continue;
% %         end
% %     else
% %         continue;
% %     end
% % 
% % end
% 
% cosj=zeros(N,1);
% COSj=zeros(N,2);
% 
% for i=1:N
%     xj=J(1,i)-site(1);
%     yj=J(2,i)-site(2);
%     cosj(i)=(xj*Vx+yj*Vy)/(sqrt(xj^2+yj^2)*sqrt(Vx^2+Vy^2));
%     if cosj(i)<=0
%         cosj(i)=0;
%     end
%     COSj(i,:)=[cosj(i),i];
% end
% 
% B=sortrows(COSj,-1);
% 
% o=B(1,2);
% p=B(2,2);
% 
% P=(J(:,o)+J(:,p))./2;
% 
% x1=P(1)-site(1);
% y1=P(2)-site(2);
% Vx1=x1/(sqrt(x1^2+y1^2));
% Vy1=y1/(sqrt(x1^2+y1^2));
% fx=[Vx1;Vy1;P];
