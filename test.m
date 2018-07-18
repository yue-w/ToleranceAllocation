% 
% function items = test()
%     person.attr = "person";
%     person.name = " ";
%     person.age = 0;
%     items(10) = person;
%     for i = 1:10
%         items(i).name = int2str(i);
%         items(i).age = i;
%     end
%     
% end

function process = test()
    process.lb = 0;
    process.hb = 1;
end