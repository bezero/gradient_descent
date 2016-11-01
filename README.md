# gradient_descent
MATLAB, supervised learning using gradient descent  rule

[w,y_opt,E,niter] = grad_descent_fit(f_type, data) is a function that returns parameters 'w' for the selected
function type to fit the given data. It uses gradient descent method to
learn. The first column in the data file must represent input (X) and the second 
column (Y) must represent the corresponding output

f_ype:

1 - 2nd order polynomial <br>
2 - 3rd order polynomial <br>
3 - 2nd order Fourier series <br>
4 - 4th order Fourier series <br>

Output Arguments:

w        parameters of the resultant function <br>
y_out    output generated from the resultant function <br>
E        error in each itteration <br>
niter    total number of itterations 
