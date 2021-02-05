# Geo-Transformation   
A MATLAB program that replicates the functionality of the built in geometric transformation [fitgeotrans](https://www.mathworks.com/help/images/ref/fitgeotrans.html)   
Control points are manually selected using MATLABS [control point selection tool.](https://www.mathworks.com/help/images/ref/cpselect.html)    
This program calculates the affine2D matrix by manipulating the formula (x' = A * x )   
where x' is the set of fixed points,   
x is the set of moving points,   
and A is the affine 2D matrix.     
Since we have the control points, we can calculate the matrix A by (A = x' * x^-1 )   
Then for every pixel in the moving image we map it into the desired orientation.   

# Example
Target Orientation:        
![Target Image](/BrainProtonDensitySliceBorder20.png)    

Moving Image:    
![Moving Image](/BrainProtonDensitySliceR10X13Y17.png)   

My program:   
![Comparison](/fixedImage.PNG)   
