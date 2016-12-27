fid = fopen('psf.txt');
s = zeros( 151, 9, 9 );
fgetl( fid );
k = 1;
while ~feof( fid )
    for i = 1:8
        ln = fgetl( fid );
        l = sscanf(ln, '%f',18);
        s( k, :, i ) = l(2:2:18);
    end
    s( k, :, 9 ) = s( k, :, 1 );
    fgetl( fid );
    k = k + 1;
end
r = 0:1/8:1;
x = zeros(9,9);
y = zeros(9,9);
for i = 0:8
    x(:,i+1) = cos(i*pi/4) * r;
    y(:,i+1) = sin(i*pi/4) * r;
end


figure(1)
k = 0;
ang=0:0.01:2*pi; 
xp=cos(ang);
yp=sin(ang);
plot(xp,yp)
hold on

a = reshape(s( k+1, : ), [9, 9]);
[val idx ] = max(a); 
[val idx2 ] = max(max(a));
m = idx(idx2);
n = idx2;
hPlot = plot( x(m,n), y(m,n),'or','MarkerSize',5,'MarkerFaceColor','r' );
axis([-1 1 -1 1])
%// Set up name to create animated gif.
filename = 'gif1.gif';

%// Just a loop
while k < 151

    %// IMPORTANT part. Update the Z data
    a = reshape(s( k+1, : ), [9, 9]);
    [val idx ] = max(a); 
    [val idx2 ] = max(max(a));
    m = idx(idx2);
    n = idx2;

    
    set(hPlot,'XData',x(m,n),'YData',y(m,n));
drawnow
    
    frame = getframe(1);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    if k == 0;
        imWrite(imind,cm,filename,'gif', 'Loopcount',inf);
    else
        imWrite(imind,cm,filename,'gif','WriteMode','append');
    end
 pause(.1)

    k = k+1;
end

hold off
