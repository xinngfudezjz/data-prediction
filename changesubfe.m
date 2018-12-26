for ic=1:size(ini_value,1)
    mc=randsample(3,1);
    switch mc
        case {1} %add one more feature
            pos_0=find(ini_value(ic,:)==0,1);
            if ~isempty(pos_0)
                ini_value(ic,pos_0)=randsample(col,1);
            end
            while sum(ini_value(ic,1:pos_0-1)==ini_value(ic,pos_0))>0
                ini_value(ic,pos_0)=randsample(col,1);
            end
        case {2} %delete one existed feature
            pos_0=find(ini_value(ic,:)==0,1);
            if isempty(pos_0)
                pos_0=col;
            end
            if(pos_0~=2)
            pos_change=randsample(pos_0-1,1);
            if pos_change==1
                ini_value(ic,:)=[ini_value(ic,2:size(ini_value,2)),0];
            else
                ini_value(ic,:)=[ini_value(ic,1:pos_change-1),ini_value(ic,pos_change+1:size(ini_value,2)),0];
            end
            end
        case {3} %change one existed feature
            pos_0=find(ini_value(ic,:)==0,1);
            if isempty(pos_0)
                pos_0=col;
            end
            pos_change=randsample(pos_0-1,1);
            ini_value(ic,pos_change)=randsample(col,1);
            if pos_change==1
                while sum(ini_value(ic,2:pos_0-1)==ini_value(ic,pos_change))>0
                    ini_value(ic,pos_change)=randsample(col,1);
                end
            else
                while sum([ini_value(ic,1:pos_change-1),ini_value(ic,pos_change+1:pos_0-1)]==ini_value(ic,pos_change))>0
                    ini_value(ic,pos_change)=randsample(col,1);
                end
            end
    end
end
        
    