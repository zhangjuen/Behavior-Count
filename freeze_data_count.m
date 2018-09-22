clear;clc;
[filename pathname index] = uigetfile('*.mat');
if index
    str = [pathname filename];
    Data_ = load(str);
    data = Data_.AnalysisData.Drinking; %取drinking数据
    s = size(data);
    l = s(1);
    
    if l>2        %判断是否有drinking
     %  figure;
     %  stairs(data(:,1),data(:,2));
     %  set(gca,'ylim',[0 2]);
    %   set(gca,'YTick',[0 1 2]);
    
       for i = 1:9
    
           n = max(find(data(:,1)<=20*i));
           n = n - mod(n,2) + 1; %偶数转成大1的奇数
           dataT = data(1:n,1);
           if dataT(n)>20*i
               dataT(n) = 20*i;               
           end
           freeze_time(i) = sum(dataT(3:2:n)-dataT(2:2:n-1)); %每20s累积freeze
       end
       
       %freeze_time(9) = sum(data(3:2:end,1) - data(2:2:end-1,1));
       
          freeze(1) = freeze_time(1);
          freeze(2:9) = freeze_time(2:9) - freeze_time(1:8); % 每20s freeze
          freeze(10) = freeze_time(9);% total freeze
          freeze = freeze';
          freeze = round(freeze*100)/100;%保留2位小数
      % [filename pathname index] = uiputfile('*.mat');
      % if index
      % str = [pathname filename];
     %  save(str,'freeze');
     %  end
       
    end
    
end     