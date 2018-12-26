Ti=100;
Tc=Ti;
iall=1;
while Tc>0&&iall<=5
    changesubfe;
    for i=1:100
        for j=1:col-1
            if(ini_value(i,j)==0)
                break;
            else
            counter=counter+1;
            end
            new_data(:,counter)=data_temp(:,ini_value(i,j));
            new_data=new_data(:,1:counter);
        end
        counter=0;
        [M,N]=size(new_data);
        indices(:,i)=crossvalind('Kfold',(size(new_data,1)),10);%80个1-10
        for k=1:10%交叉验证k=10，10个包轮流作为测试集        
            test = (indices == k); %/获得test集元素在数据集中对应的单元编号
            train = ~test;%train集元素的编号为非test元素的编号
            test_data=new_data(train(:,i),:);%test样本集
            test_target=new_data(test(:,i),:);
            data_temp_cvtrain=data_temp(train(:,i),:);
            data_temp_cvtest=data_temp(test(:,i),:);
            %grnn;
            %train_target:80 valid
            %test_data :720 train
            fit_score(i,:)=ones(1,col);
            grnn;
        end
        cc=fit_score-fit_scoreP;
        for c1=1:size(cc,1)
            if sum(cc(c1,:))>=0
                fit_scoreP(c1,:)=fit_score(c1,:);
                ini_valueP(c1,:)=ini_value(c1,:);
                Tc=Ti;
            else
                    P_acc=exp(-min(cc(c1,:))/Tc);
                if rand(1)<P_acc
                    fit_scoreP(c1,:)=fit_score(c1,:);
                    ini_valueP(c1,:)=ini_value(c1,:);
                    Tc=Ti;
                else
                    Tc=Tc-1;
                end
            end
        end
    end
    iall=iall+1;
end