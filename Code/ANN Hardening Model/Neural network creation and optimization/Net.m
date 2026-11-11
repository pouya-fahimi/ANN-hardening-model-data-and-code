
%load('F13.mat');

R2=CleanF2;
for i=1:14

RN(:,i)=(R2(:,i)-min(R2(:,i)))/(max(R2(:,i))-min(R2(:,i)));

end


y=RN(:,14);
x=RN(:,1:13);
yy=y';
xx=x';



net = fitnet([35 35 35 35 35]);

net.divideParam.trainRatio = 80/100;
net.divideParam.valRatio = 20/100;
net.divideParam.testRatio = 0/100;

%net.inputs{1}.processFcns={'removeconstantrows'};
%net.outputs{2}.processFcns={'removeconstantrows'};

 net.input.processFcns = { }; % Remove normalization
 net.output.processFcns= { }; 


[net,tr] = train (net,xx,yy);



ytrain=net(xx(:,tr.trainInd))*(max(R2(:,14))-min(R2(:,14)))+min(R2(:,14));

ytrainTrue=yy(:,tr.trainInd)*(max(R2(:,14))-min(R2(:,14)))+min(R2(:,14));

ERtr(1)=sqrt(mean((ytrain(1,:)-ytrainTrue(1,:)).^2));


yVal=net(xx(:,tr.valInd))*(max(R2(:,14))-min(R2(:,14)))+min(R2(:,14));

yValTrue=yy(:,tr.valInd)*(max(R2(:,14))-min(R2(:,14)))+min(R2(:,14));

ERval(1)=sqrt(mean((yVal(1,:)-yValTrue(1,:)).^2));


figure

plot(ytrainTrue,ytrain,'x');hold on;

plot(yValTrue,yVal,'o');

plot(-2:2,-2:2);hold off;
