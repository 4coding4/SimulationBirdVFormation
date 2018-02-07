function [CML]=CML(pos,k,a)

%  for a=1:length(pos)
%      a
%      pos{a}(:,k)
%  end


%per ogni indivisuo ho un CML diverso ma essendo vicini sarà simile
    pos_a=pos{a}(:,k);
    distanza=5;
    CML=[0;0;0];
    contatore=0;
   
    
    for i=1:length(pos)
        
        if ( norm( pos_a - pos{i}(:,k) ) <distanza)            
            CML=CML+pos{i}(:,k);
            contatore=contatore+1;
        end
    end
    
    CML=CML/(contatore); %niente -1 perché deve calcolare anche la distanza del primo individuo
    
end