clc;
clear all;
close all;

%% Parametreler
sigma = 32;    alpha = 0.1;    beta = 0.5;     mu = 2;
n = 500;       Xcenter =110;   Ycenter = 58;   r =10;
iter = 200;

%% 
% img=imread('tile.tif');
% 
% img = im2double(img);
[filename, pathname] = uigetfile({'*.jpg;*.JPG','JPG Files (*.jpg, *JPG)';...
    '*.tif;*.TIF','TIF Files (*.tif, *.TIF)';... 
    '*.bmp;*.BMP','BMP Files (*.bmp, *.BMP)';...
    '*.gif;*.GIF','GIF Files (*.gif, *.GIF)';...
    '*.*','All Files(*.*)'},'Select the input file');
x=imread(strcat(pathname,filename));
if (size(x,3)>1)%RGB resmi gri skalaya çek
    try
        x=rgb2gray(x);
    catch
        x=sum(double(x),3)/3;
    end
end
img=x;
smooth_img = img;

imshow(smooth_img,'InitialMagnification','fit');
hold on;

A = zeros(n);
for i = 0:n-1
    A(i+1 ,:) = circshift([(-2*alpha - 6*beta) (alpha + 4*beta) (-beta) zeros(1,n-5) (-beta) (alpha + 4*beta)] ,i);
end

I = eye(n);

%% merkez noktanın etrafında r yarıçaplı daire çiz
teta =  linspace(0,360,n);
X(:, 1) = r .* cosd(teta) + Xcenter;
X(:, 2) = r .* sind(teta) + Ycenter;

plot(X(:,1), X(:,2), 'b' , 'LineWidth',2);

%% Geliştirme
while sigma >= 1
    
    smooth_img = imgaussfilt(img, sigma);
    
    %potential energy
    [XX, YY] = imgradientxy(smooth_img);
    P = 1 ./ (1 + mu .* sqrt(XX.^2 + YY.^2));
    
    [Fext_x, Fext_y] = imgradientxy(P);

    Fext_x = -Fext_x;
    Fext_y = -Fext_y;

    %quiver(Fext_x, Fext_y);

    for i = 1:iter

        X = egri(A,X,sigma,I,Fext_x,Fext_y);
        plot(X(:,1), X(:,2),'Color', [0.3 0.3 0.3]);
        drawnow;
        Text = ['Sigma:', num2str(sigma) , '   ' ,'ITR: ',num2str(i)];
        title(Text);
    end
    sigma = sigma / 2;
end
L=X;
%% sonuç
plot(X(:,1), X(:,2), 'r.', 'LineWidth',1);
%%
figure,imshow(x,'InitialMagnification','fit');
hold on;
plot(L(:,1), L(:,2), 'r.', 'LineWidth',1);