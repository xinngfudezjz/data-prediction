
for j2=1:col
      if(isempty(find(j2==ini_value(i,:))))
           net = newgrnn(test_data',data_temp_cvtrain(:,j2)');
           temp = sim(net,test_target');
           temp=temp';
           fit_score(i,j2)=sum((data_temp_cvtest(:,j2)-temp).^2)/sum(data_temp_cvtest(:,j2).^2);
      end
  end