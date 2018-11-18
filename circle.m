  function A=circle(site)

% site=[1,1];
 
pointend=zeros(360,2);
R=10;
V0=[0,1];
V1=[1,0];
s=acos(dot(V0,V1)/(norm(V0)*norm(V1)))-pi/2;
k=pi/180;
for i=1:360
    s=s+k;
    pointend(i,1)=cos(s)*R+site(1);
    pointend(i,2)=sin(s)*R+site(2);
end

A=pointend;