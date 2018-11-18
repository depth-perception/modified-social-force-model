clc; clear; close all;

figure('NumberTitle','off','name','小球运动录制'); 



subplot(1,2,1);
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

rectangle('Position',[-5,-5,20,20],'Curvature',[1,1]),axis equal
subplot(1,2,2);
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

rectangle('Position',[-5,-5,20,20],'Curvature',[1,1]),axis equal