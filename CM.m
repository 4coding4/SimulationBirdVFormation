function [CM]=CM(pos,k)
    
    CM=[0;0;0];
    
    for i=1:length(pos)
        
        CM=CM+pos{i}(:,k);
        
    end
    
    CM=CM/length(pos);
    
end