v0 = transpose([0 0 0 0 0 0 0]);
v1 = transpose([1 0 0 1 1 0 1]);
v2 = transpose([0 1 0 1 1 0 1]);
v3 = transpose([1 1 0 0 1 1 0]);
v4 = transpose([0 0 1 0 1 1 1]);
v5 = transpose([1 0 1 1 0 1 0]);
v6 = transpose([0 1 1 1 1 0 0]);
v7 = transpose([1 1 1 0 0 0 1]);

A=[v1 v2 v3 v4 v5 v6 v7];
% A=mod(A,2);
R=rref(A);
% R=mod(R,2);
rref(transpose([v1 v2 v4]))