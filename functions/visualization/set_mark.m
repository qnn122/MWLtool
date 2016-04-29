A = 1:9:size(T,1);
x = T(A(k):A(k)+8);
%set(gca,'XGrid','on');
%set(gca,'Xtick',mark);
mark = [];
for t=1:9
    mark = [mark; info.mark(t)];
    temp = info.mark(t+1:end);
    mark = [mark; round((temp(1)+mark(end))/2)];    
end
mark = [mark;info.mark(end)];
mark = round(mark.*info.ts);

hold on
ix = 0;
for i=1:2:length(mark)-2
    ix = ix + 1;
    A = mark(i):mark(i+1);
    harea = area(A,repmat([ylimit(2) ylimit(1)],length(A),1)*x(ix));
    set(harea, 'FaceColor','y','EdgeColor','None')
    alpha(0.2)
    harea = area(A,repmat([ylimit(1) ylimit(2)],length(A),1)*x(ix));
    set(harea, 'FaceColor','y','EdgeColor','None')
    alpha(0.2)
end

A = mark(end)-1:round(size(hb_data.frontal.raw,2)*info.ts);
harea = area(A,repmat([ylimit(2) ylimit(1)],length(A),1)*x(ix));
set(harea, 'FaceColor','y','EdgeColor','None')
alpha(0.2)
harea = area(A,repmat([ylimit(1) ylimit(2)],length(A),1)*x(ix));
set(harea, 'FaceColor','y','EdgeColor','None')
alpha(0.2)

ix = 0;
for i=1:2:length(mark)-2
    ix = ix + 1;
    A = mark(i):mark(i+1)-1;
    harea = area(A,repmat([ylimit(2) ylimit(1)],length(A),1)*(~x(ix)));
    set(harea, 'FaceColor', 'g','EdgeColor','None')
    alpha(0.2)
    harea = area(A,repmat([ylimit(1) ylimit(2)],length(A),1)*(~x(ix)));
    set(harea, 'FaceColor', 'g','EdgeColor','None')
    alpha(0.2)
end
A = mark(end)-1:round(size(hb_data.frontal.raw,2)*info.ts);
harea = area(A,repmat([ylimit(2) ylimit(1)],length(A),1)*(~x(ix)));
set(harea, 'FaceColor','g','EdgeColor','None')
alpha(0.2)
harea = area(A,repmat([ylimit(1) ylimit(2)],length(A),1)*(~x(ix)));
set(harea, 'FaceColor','g','EdgeColor','None')
alpha(0.2)