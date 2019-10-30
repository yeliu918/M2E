function [ H_est,P_est,F_est,U ] = M2E_ADMM(X,H_est,P_est,F_est,U,size_vec,options,centroidF)
%%  Take the parameters
R=size_vec(4);
alpha=options.alpha;
mu=options.mu;
rho=1.15;
mu_max=options.mu_max;

%% Unfolding the tensor of data X into 3 matrices X1 X2 and X3
X1=tens2mat(X,1);
X2=tens2mat(X,2);
X3=tens2mat(X,3);

%% ***********  MAIN  LOOP *****************
%% update H
    D=kat_rao(F_est,P_est);
    DtD=(F_est'*F_est).*(P_est'*P_est);
    A=DtD+mu/2*eye(R);
    L=max(eigs(2*A));
    B=2*X1*D+mu*P_est-U;
    H_est = H_est-(2*H_est*A-B)/L;
    
    %% update P
    E=kat_rao(F_est,H_est);
    EtE=(F_est'*F_est).*(H_est'*H_est);
    A=EtE+mu/2*eye(R);
    L=max(eigs(2*A));
    B=2*X2*E+mu*H_est+U;
    P_est=P_est-(2*P_est*A-B)/L;
    
    %% update U
    U=U+mu*(H_est-P_est);  
    
    %% update mu
    mu=min(rho*mu,mu_max);
    
    %% update F
    J=kat_rao(P_est,H_est);
    JtJ=(P_est'*P_est).*(H_est'*H_est);
    A=JtJ + alpha * eye(R);
    L=max(eigs(2*A));
    B=2 * X3 * J + 2 * alpha* centroidF;
    F_est=F_est-(2*F_est*A-B)/L;    
end

