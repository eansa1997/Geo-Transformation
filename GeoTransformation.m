function GeoTransformation()
    movingImg = imread('BrainProtonDensitySliceR10X13Y17.png');
    
    % points manually selected by control point selection tool
    fixedPnt = [92 45 1; 137.68 48.9 1; 100 54.93 1; 110 59 1; 86.8 100 1; 136.9 101.68 1; 95.93 158.93 1; 124.93 153.18 1; 112.0625 219.8125 1];
    movingPnt = [120.18 57.93 1; 164.81 70.93 1; 125.93 69.93 1; 135.18 75.81 1; 105.06 111.93 1; 154.68 122.18 1; 104.06 172.06 1; 133.93 170.93 1; 108.81 235.06 1];
    
    fixedImage = transform(fixedPnt, movingPnt, movingImg);
    figure, imshowpair(movingImg,fixedImage,'montage');
end

function I = transform(fixed_pts, moving_pts, movingImg)
    % setup output image
    [r,c,d] = size(movingImg);
    imgClass = class(movingImg);
    I = zeros([r,c,d], imgClass);
    
%     This code used to validate my custom goeTransform function using
%     built in function, remove 1 from points [x y 1] -> [x y]
%     affine = fitgeotrans(moving_pts, fixed_pts,'Similarity');
%     affineMatrix = affine.T;
%     disp(affineMatrix);

    % calcute affine transformation matrix
    affineMatrix = geoTransform(moving_pts, fixed_pts);
    disp(affineMatrix);

    % For every pixel in the moving image, calculate the fixed points, then
    % write the RGB data into the output image using fixed points,
    % vectorize color dimensions
    % Ignore out of bound indices (anything less than 1)
    for i = 1:r
        for j = 1:c
            xPrime = affineMatrix*[i;j;1]   ;
            if (xPrime(1) >= 1 && xPrime(2) >= 1)
                xPrime(1) = round(xPrime(1));
                xPrime(2) = round(xPrime(2));
                
                I(xPrime(1), xPrime(2),:) = movingImg(i,j,:);
            end
        end
    end
end

function A = geoTransform(movingPts, fixedPts)
    % Following formula is the affine transformation
    % x' = Ax 
    % where A is the affine transformation matrix, x' is fixed points, x is
    % moving points.
    % We want the matrix A
    % Using linear algebra we get 
    % A = x' / x
    % A = x' * x^-1
    % Matlab syntax for matrix / or \ is 
    % A / B = A * B^-1
    % A \ B = A^-1 * B
    A = movingPts \ fixedPts ;
end













