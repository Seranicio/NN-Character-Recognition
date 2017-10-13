function myclassify(Pfinal,actfunction,learnfunction)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                       %
%  My Classifer -> NN that classify drawn digits 0-9    %
%                                                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

W=rand(10,256); %gera matriz 10x256 aleatória no int (0 1)
b=rand(10,1);

target_arrays= [[1 0 0 0 0 0 0 0 0 0];[0 1 0 0 0 0 0 0 0 0];[0 0 1 0 0 0 0 0 0 0];[0 0 0 1 0 0 0 0 0 0];[0 0 0 0 1 0 0 0 0 0];[0 0 0 0 0 1 0 0 0 0];[0 0 0 0 0 0 1 0 0 0];[0 0 0 0 0 0 0 1 0 0];[0 0 0 0 0 0 0 0 1 0];[0 0 0 0 0 0 0 0 0 1]];

%Target build
T= [];
A= T;
for i=1:10
    for j=1:50
        T= [A target_arrays(1:10,i)];
        A= T;
    end
end

if(actfunction == "purelin")
    net = linearlayer(0,0); %linearlayer(inputDelays,widrowHoffLR)
elseif(actfunction == "logsig")
    net = linearlayer(0,0.1); %linearlayer(inputDelays,widrowHoffLR)
else %hardlim
    net = perceptron; %linearlayer(inputDelays,widrowHoffLR)
end

net = configure(net,Pfinal,T);
net.IW{1,1}= W;
net.b{1,1}= b;

net.performParam.lr = 0.5; % learning rate
net.trainParam.epochs = 1000; % maximum epochs
%net.trainParam.show = 35; % show
%net.trainParam.goal = 1e-6; % goal=objective
if(actfunction == "logsig")
    net.performFcn = 'sse'; % criterion
end

%activate function
if(actfunction == "hardlim")
    net.layers{1}.transferFcn='hardlim';
elseif(actfunction == "purelin")
    net.layers{1}.transferFcn='purelin';
elseif(actfunction == "logsig")
    net.layers{1}.transferFcn='logsig';
end

%learning method
if(learnfunction == "learngd")
    net.inputWeights{1}.learnFcn='learngd';
elseif(learnfunction == "learngdm")    
    net.inputWeights{1}.learnFcn='learngdm';
elseif(learnfunction == "learnh")
    net.inputWeights{1}.learnFcn='learnh';
elseif(learnfunction == "learnhd")
    net.inputWeights{1}.learnFcn='learnhd';
elseif(learnfunction == "learnwh")
    net.inputWeights{1}.learnFcn='learnwh';
else
    net.inputWeights{1}.learnFcn='learnp';
end

%training validation -> since we dividing Inputs for validation the NN will
%be weaker since the nº of drawn 0-9 is lower and sometimes can't learn all
%number's drawings.
if(actfunction == "hardlim")
    net.divideFcn = 'dividerand';
    net.divideMode='sample';
    net.divideParam.trainRatio = 70/100;
    net.divideParam.valRatio = 15/100;
    net.divideParam.testRatio = 15/100;
end

%training
net = train(net,Pfinal,T);

%testing network
output = sim(net,Pfinal);

%Getting higher value of each column for purelin or logsig
if(actfunction == "purelin" || actfunction == "logsig")
    output = GetHigher1(output);
end


output_class = classify_Array(output); %classify_Array(output_data,print_boolean)

%saving workspace
%output_class will have the number result.
save DataClassify.mat output_class net;



