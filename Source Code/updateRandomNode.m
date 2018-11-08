% fnc to correct nodes in matrix memory
% ! Function completed
function [vec, delta] = updateRandomNode(MatrixMem, vec)
    indexing = unidrnd(length(vec));
    temp = vec(indexing);
    vec(indexing) = sign(MatrixMem(indexing, :) * vec);
    delta = abs(temp - vec(indexing)) / 2;