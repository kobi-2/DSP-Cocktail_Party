function [S,W] = ica(x, iter, eps=1e-16)
  [x_, m] = preprocess(x);
  N = size(x)(1);
  W = zeros(N,N);
  
  for i = 1:N
    w = rand(N,1);
    for j = 1:iter
      w_new = newW(w, x_);
      w_new -= W(:, 1:i)*(w_new'*W(:,1:i))';
      w_new = w_new/norm(w_new);
      
      dot = w_new*w';
      if(abs(1-dot) < eps)
        w = w_new;
        break
      endif
      
      w = w_new;
    endfor
    W(:,i) = w;
  endfor
  
  S = W*x_;
endfunction

function A = g(X)
  A = tanh(X);
endfunction

function A = g_(x)
  A = 1 - g(x).*g(x);
endfunction

function [x_, m] = preprocess(x)
  %centering the data
  m = mean(x, 2);
  x_ = x - m;
  
  %whitening 
  [E, val] = eig(cov(x_'), "vector");
  val = 1./sqrt(val);
  D = diag(val);
  x_ = real(E*D*E'*x_);
endfunction
 
function n = norm(X)
  n = sqrt(sum(X.*X));
endfunction

function w_ = newW(w, x)
  w_ = mean(x.*(g(w'*x)), 2) - w.*mean(g_(w'*x));
  w_ = w_/norm(w_);
endfunction




  

