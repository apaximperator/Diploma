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

k = 0;
%// Create handles to access/modify data.
hSurf = surf( x, y, reshape(s(k+1,:,:), [9, 9]) );
colorbar
t = text(3, 3, '');
%// Set up name to create animated gif.
filename = 'gif2.gif';
v = 0.09;
%// Just a loop
while k < 151

    %// IMPORTANT part. Update the Z data
    a = reshape(s( k+1 ,: , : ), [9, 9]);
    set(hSurf,'ZData', a);
    colorbar
    v = v + 0.1;
    time = sprintf('T = %f ', v);
    set(t,'String',time);
    %// Set limits so the graph looks nice.
    zlim([-0.2 1])
    drawnow

    %// Capture frame to write to gif.
    frame = getframe(1);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    if k == 0;
        imwrite(imind,cm,filename,'gif', 'Loopcount',inf);
    else
        imwrite(imind,cm,filename,'gif','WriteMode','append');
    end

    %pause(.001)

    k = k+1;
end