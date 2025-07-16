function [G,C,B] = GCB_model_extract()
%Get G,C,B matrix from HotSopt

output_path = 'hete_thermal_matrices/';
name_of_chip = '16_hetecore_3';
t_budget = 0.001; 

%Amatrix in HotSpot is G matrix
Gmatrixcolptr_path = 'Amatrixcolptr';
Gmatrixnzval_path = 'Amatrixnzval';
Gmatrixrowind_path = 'Amatrixrowind';
Gmatrixcolptr = importdata(Gmatrixcolptr_path);
Gmatrixnzval = importdata(Gmatrixnzval_path);
Gmatrixrowind = importdata(Gmatrixrowind_path);
NEWGmatrixcolptr=[];
All_grids = length(Gmatrixcolptr)-1;
for i=1:All_grids
    for j=1:Gmatrixcolptr(i+1)-Gmatrixcolptr(i)
        NEWGmatrixcolptr = [NEWGmatrixcolptr, i];
    end
end
Gmatrixrowind = (Gmatrixrowind + 1)';
Gmatrix = sparse(Gmatrixrowind,NEWGmatrixcolptr,Gmatrixnzval);

Cmatrix_path = 'Cmatrix';
Cmatrix = importdata(Cmatrix_path);
Cmatrix = diag(Cmatrix);
Cmatrix = sparse(Cmatrix);

Bmatrix_path = 'Bmatrix';
Bmatrix = importdata(Bmatrix_path);

G = Gmatrix;
C = Cmatrix;
B = Bmatrix(:,49:64);
A = full(B'*(G\B));
save(strcat(output_path,name_of_chip,'_A.mat'), 'A');
Ac = full(- (C \ G));
Bc = full(C \ B) ;
Cc = full(B');
Dc = zeros(size(A,1), size(A,1));
[~,N,L,~] = c2dm(Ac,Bc,Cc,Dc,t_budget);
A_bar = L*N;

save(strcat(output_path,name_of_chip,'_A_',string(t_budget*1000),'ms.mat'), 'A_bar');

end