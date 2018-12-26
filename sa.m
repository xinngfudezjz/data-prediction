clear;
clc;
tic;
data=xlsread('Blend1.xlsx');
data_temp=data; 
[row,col]=size(data);
fit_score=ones(100,col);
counter=0;
pos_sol=zeros(col,col);
ini_size=zeros(1,100);
ini_value=zeros(100,col-1);
data_bin=1-isnan(data_temp);
m=size(data_temp,1);
for i=1:m
    if sum(isnan(data_temp(i,:)))>0
        data_temp(i,:)=[];
        i=i-1;
        m=m-1;
    end
    if i==m
        break;
    end
end
new_data=zeros(size(data_temp,1),col);

        
ti=100;
tc=ti;
for i=1:100
ini_size(1,i)=randsample(col-1,1);
end
for i=1:100
ini_value(i,1:ini_size(1,i))=randsample(col,ini_size(1,i));
end
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
    [M,col_new]=size(new_data);
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
        grnn;
    end
    fit_scoreP=fit_score;
    ini_valueP=ini_value;
    %best_score(:,i)=min(fit_score(i,:));
end
sa_iteration;
 for i=1:100
best_score(:,i)=min(fit_score(i,:));
end
best_score(:,i)=min(fit_score(i,:));
T=toc;
