function class = classify_Array(data)

class = [];

unknown_counter = 0;
right_classification_counter = 0;

target_arrays= [[1 0 0 0 0 0 0 0 0 0];[0 1 0 0 0 0 0 0 0 0];[0 0 1 0 0 0 0 0 0 0];[0 0 0 1 0 0 0 0 0 0];[0 0 0 0 1 0 0 0 0 0];[0 0 0 0 0 1 0 0 0 0];[0 0 0 0 0 0 1 0 0 0];[0 0 0 0 0 0 0 1 0 0];[0 0 0 0 0 0 0 0 1 0];[0 0 0 0 0 0 0 0 0 1]];

for i=1:length(data)
    if(isequal(data(:,i),target_arrays(1:10,1)))
        %disp("input -> represents: " + "1");
        class = [class,1];
    elseif(isequal(data(:,i),target_arrays(1:10,2)))
        %disp("input -> represents: " + "2");
        class = [class,2];
    elseif(isequal(data(:,i),target_arrays(1:10,3)))
        %disp("input -> represents: " + "3");
        class = [class,3];
    elseif(isequal(data(:,i),target_arrays(1:10,4)))
        %disp("input -> represents: " + "4");
        class = [class,4];
    elseif(isequal(data(:,i),target_arrays(1:10,5)))
        %disp("input -> represents: " + "5");
        class = [class,5];
    elseif(isequal(data(:,i),target_arrays(1:10,6)))
        %disp("input -> represents: " + "6");
        class = [class,6];
    elseif(isequal(data(:,i),target_arrays(1:10,7)))
        %disp("input -> represents: " + "7");
        class = [class,7];
    elseif(isequal(data(:,i),target_arrays(1:10,8)))
        %disp("input -> represents: " + "8");
        class = [class,8];
    elseif(isequal(data(:,i),target_arrays(1:10,9)))
        %disp("input -> represents: " + "9");
        class = [class,9];
    elseif(isequal(data(:,i),target_arrays(1:10,10)))
        %disp("input -> represents: " + "0");
        class = [class,0];
    else
        %disp("Input was a " + floor(i/50) + " with this NN output");
        %disp(data(:,i));
        %disp("Input with no Class");
        class = [class,-1];
        unknown_counter = unknown_counter +1;
    end
end

result = 1:500;

%this extraction of results only works for the input i'm giving don't use
%for another input.
%Input : 0-50 = 1 | 51 - 100 = 2 | ... | 451 - 500 = 0.
for i=1:10
    for j=(i-1)*50 + 1 :(i-1)*50 + 50
        if(i == 10 && class(j) == 0)
            right_classification_counter = right_classification_counter +1;
            continue;
        end       
        if(class(j) == i)
            right_classification_counter = right_classification_counter +1;
        end
    end
end

bad_class = (length(data) - (unknown_counter + right_classification_counter));

disp("Simulation Results");
disp("Nº without class: " + unknown_counter);
disp("Nº bad class: " + bad_class);
disp("Nº right classification: " + right_classification_counter);
disp("Efficiency % of network: " + (100 - ((unknown_counter+bad_class)/length(data) * 100)) + "%");