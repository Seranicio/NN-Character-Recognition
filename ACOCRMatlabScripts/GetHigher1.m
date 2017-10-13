function output = GetHigher1(output)

for i=1:500
   aux = max(output(:,i));
   for j=1:10
       if(aux > output(j,i))
            output(j,i) = 0;
       else
            output(j,i) = 1;
       end
   end
end