file_names= ['1.mat','2.mat','3.mat','4.mat','5.mat','6.mat','7.mat','8.mat','9.mat' , "0.mat"];

%loading data to a single matrix
Pfinal = [];
for i=1:10
   load(file_names(i));
   Pfinal = [Pfinal P];
end

%Calling options for each NN :

%Associative memory -> Activation finction -> linear function without bias
%                      Learning function -> Pseudo-inverse (pinv) ºsee Associative.mº
%                                        -> Iterative Hebb’s rule (learnh or learnhd (with decaying weight) )

%associative value:
associative_act = 0;

if(associative_act == 1)
   Pfinal = Associative(Pfinal);
end

%myclassify(Pfinal,"purelin","learngd");
%myclassify(Pfinal,"logsig","learngd");
myclassify(Pfinal,"hardlim","learnp");

%Final Classification of simulation output can be accessed in
%DataClassify.mat , variable named = output_class

%-----------------------------------------------------------------------------------------------------

%Adaline (linearlayer) -> Activation finction -> linear function (pirelin or logsig)
%                         Learning function -> Widrow-Hoff ( learnwh ) or LMSE (Least Mean Square)

%Perceptron -> Activation finction -> binary activation functions( hardlim , hardlims )
%              Learning function -> Rule with learning coeficient ( learnp )