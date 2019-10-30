function [ H_est,F_est ] = M2E_initial(size_vec,H_init,F_init,seed)
I=size_vec(1);
K=size_vec(3);
R=size_vec(4);

% rng(seed, 'state');


randn('state',seed);

if isempty(H_init)
    H_est=randn(I,R);
    if isempty(F_init)
        F_est=randn(K,R);
    else
        F_est=F_init;
    end
else
    H_est=H_init;
    if isempty(F_init)
        F_est=randn(K,R);
    else
        F_est=F_init;
    end
end
end

