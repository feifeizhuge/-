# 充电曲线的绘制
##曾经在实习的时候，给我的一个小任务

Ojective:  
1. 有一个充电曲线，请你用少的点去重新描绘这个曲线，同时减少信息的损失。

Methode:
方法很简单，也效果很好。接下来介绍代码的核心思路

```matlab
%%Part one: Changing threshold
% initialisation 
x1  = power_downsampling(1);
outlier_index = [];

% iterator
for i=2:length(power_downsampling)

    x2 = power_downsampling(i);
    if abs(x1-x2) > threshold
        x1 = x2;
        outlier_index(end+1)=i;
    end
    
end

```

`power_downsampling` 是我们的原始数据，我们将他的第一个点`power_downsampling(1)`作为我们的第一个flag点，让它去和下一个点比较，
判断二者的差值：  

大于阈值： 保存flag点的index，并更新flag点，令下一个点作为新的flag点。

小于阈值： 保持当先的flag点，并比较接下来的点。

遍历所有的点，记录被选中的index。

![image](https://github.com/feifeizhuge/charging-curve-reconstruction/edit/master/reconstructed curve.)
