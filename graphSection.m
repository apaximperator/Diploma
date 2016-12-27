fid = fopen('psf.txt');
s = zeros( 151, 17 );
fgetl( fid );
k = 1;
while ~feof( fid )
    ln = fgetl( fid );
    l = sscanf(ln, '%f',18);
    s( k, 9:17 ) = l(2:2:18);    
    for i = 2:8
        if i == 5
            ln = fgetl( fid );
            l = sscanf(ln, '%f',18);
            s( k, 1:8 ) = l(18:-2:4);
        else
            fgetl( fid );
        end
    end
    %s(k,:)
    fgetl( fid );
    k = k + 1;
end
r = -1:1/8:1;

figure(1)
k = 0;
%// Create handles to access/modify data.
hSurf = plot( r, reshape(s(k+1,:), [1, 17]) );
hold on
plot( r, zeros(1,17) , '-g');



%// Set up name to create animated gif.
filename = 'gif2.gif';
axis([-1 1 -0.5 1])
%// Just a loop
while k < 150

    %// IMPORTANT part. Update the Z data
    a = reshape(s( k+1, : ), [1, 17]);
    %plot( r, a );
    set(hSurf,'YData', a);
    drawnow
    
    frame = getframe(1);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    if k == 0;
        imwrite(imind,cm,filename,'gif', 'Loopcount',inf);
    else
        imwrite(imind,cm,filename,'gif','WriteMode','append');
    end

    pause(.1)

    k = k+1;
end

hold off