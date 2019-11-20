function VC=VCF(A,B)
N = length(A);
VC = cconv(A,conj(fliplr([B B B])),N*3);
end