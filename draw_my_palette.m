function []=draw_my_palette(C,pts_per_patch,my_palette)

low=1;
high=pts_per_patch;
color_row=1;

while high < size(C,2)
    
    if color_row > size(my_palette,1)
        color_row=1;
    end
    
    curve=C(:,low:high);
   
    plot3(curve(1,:),curve(2,:),curve(3,:),'color',my_palette(color_row,:))
    
     
    low=high;
    high=high+(pts_per_patch-1);
    color_row=color_row+1;
    
end
end