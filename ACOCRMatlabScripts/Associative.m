function Pfinal = Associative(Pfinal)
    
%Associative memory there is no neural network. The objective is to take
%the initial input(P1) and produce a second one (P2) where this one is more
%close to the actual prototype.

load('PerfectArial.mat'); %Variable is called Perfect after loading ( 1-9 and then 0 column )

for i=2:500 %since there is no value for the first Wp , we need to start at i=2
    Wp = Perfect(i-1) * pinv(Pfinal(i-1)); %Wp = T * pinv(P)
    Pfinal(i) = Wp * Pfinal(i);            %P2 = Wp * P1 % same index.
end