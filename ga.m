parents_g=ini_valueP;
i=1;
j=1;
col=13;
boys=zeros(50,col-1);
girls=zeros(50,col-1);
while i<=100
    j=ceil(i/2);
    if ~isempty(find(parents_g(i,:)==0,1))
        first_line=find(parents_g(i,:)==0,1)-1;  
    else
        first_line=12;
    end
    if ~isempty(find(parents_g(i+1,:)==0,1))
        second_line=find(parents_g(i+1,:)==0,1)-1;
    else
        second_line=12;
    end
        same_value=intersect(parents_g(i,1:first_line),parents_g(i+1,1:second_line));
    if(first_line>second_line)
       diff1=setdiff(parents_g(i,1:first_line),same_value);%large size
       diff2=setdiff(parents_g(i+1,1:second_line),same_value);%small size
    else
       diff1=setdiff(parents_g(i,1:first_line),same_value);%small size
       diff2=setdiff(parents_g(i+1,1:second_line),same_value);%large size
    end
    an=[same_value(1,:),diff1(1,:)];
    boys(j,1:size(an,2))=an;
    an=[same_value(1,:),diff2(1,:)];
    girls(j,1:size(an,2))=an;
    diff1_size=length(diff1);
    diff2_size=length(diff2); 
    if diff2_size<diff1_size
        diff_exchange=floor(length(diff2)/2);
    else
        diff_exchange=floor(length(diff1)/2);
    end     
       exchange_temp=boys(j,first_line-diff_exchange+1:first_line);
       boys(j,first_line-diff_exchange+1:first_line)=girls(j,second_line-diff_exchange+1:second_line);
       girls(j,second_line-diff_exchange+1:second_line)=exchange_temp;
       [M_boy,col_boy]=size(boys);
       [M_girl,col_girl]=size(girls);  
   i=i+2;
end
%evaluate the kids by boys and girls separately
%boys
fit_score=ones(50,13);
for i=1:50
    indices_B(:,i)=crossvalind('Kfold',(size(boys,1)),10);%80个1-10
    for k=1:10%交叉验证k=10，10个包轮流作为测试集        
        test=(indices_B == k); %/获得test集元素在数据集中对应的单元编号
        train=~test;%train集元素的编号为非test元素的编号
        test_data=boys(train(:,i),:);%test样本集
        test_target=boys(test(:,i),:);
        data_temp_cvtrain=data_temp(train(:,i),:);
        data_temp_cvtest=data_temp(test(:,i),:); 
        grnn;    
    end
end
fit_all=[fit_scoreP;fit_score];
sample_all=[parents_g;boys];
%girls
fit_score=ones(50,13);
for i=1:50
    indices_G(:,i)=crossvalind('Kfold',(size(girls,1)),10);%80个1-10
    for k=1:10%交叉验证k=10，10个包轮流作为测试集        
        test = (indices_G == k); %/获得test集元素在数据集中对应的单元编号
        train = ~test;%train集元素的编号为非test元素的编号
        test_data=girls(train(:,i),:);%test样本集
        test_target=girls(test(:,i),:);
        data_temp_cvtrain=data_temp(train(:,i),:);
        data_temp_cvtest=data_temp(test(:,i),:);
        grnn;
    end
end
fit_all=[fit_all;fit_score];
sample_all=[sample_all;girls];
for i=1:13
    [Y,Index_o]=sort(fit_all(:,i));
    F(i).matrix=sample_all(Index_o(1:100),:);
    F(i).fit_score=fit_all(Index_o(1:100),i);
end
GA_iteration;
    


     
