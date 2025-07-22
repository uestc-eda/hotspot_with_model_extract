%% This script generates thermal system matrices G, C, B, L
%% It also computes A, A_bar for usage of GDP, etc.

[G,C,B,L] = gcbl_gen();

[A, A_bar] = a_mat_gen(G, C, B);


