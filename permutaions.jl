module Permutations

export Permutation

struct Permutation{T}
    a::Vector{T}
    n::Int
    p::Vector{Int}
    i::Int
end

function Permutation(A::Vector)
    a = copy(A)
    n = length(a)
    p = collect(0:n)
    i = 1
    Permutation(a, n, p, i)
end

function Base.iterate(self::Permutation)
    copy(self.a), (self.a, self.n, self.p, self.i)
end

function Base.iterate(self::Permutation, state)
    a = state[1]
    n = state[2]
    p = state[3]
    i = state[4]
    if i < n
        p[i+1] -= 1
        j = isodd(i) ? p[i+1] : 0
        swap!(a, j, i)
        i = 1
        while p[i+1] == 0
            p[i+1] = i
            i += 1
        end
        copy(a), (a, n, p, i)
    else
        nothing
    end
end

function swap!(v::Vector, a::Int, b::Int)
    tmp = v[a+1]
    v[a+1] = v[b+1]
    v[b+1] = tmp
    nothing
end
end