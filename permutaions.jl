module Permutations

export Permutation

struct Permutation{A<:AbstractVector}
    a::A
    n::Int
    p::AbstractVector{Int}
    i::Int
end

function Permutation(a::Vector)
    a = copy(a)
    n = length(a)
    p = collect(0:n)
    i = 1
    Permutation(a, n, p, i)
end

function Base.iterate(self::Permutation)
    copy(self.a), self
end

function Base.iterate(self::Permutation, state::Permutation)
    a = copy(state.a)
    n = state.n
    p = copy(state.p)
    i = state.i
    if i < n
        p[i+1] -= 1
        j = isodd(i) ? p[i+1] : 0
        swap!(a, j, i)
        i = 1
        while p[i+1] == 0
            p[i+1] = i
            i += 1
        end
        a, Permutation(a, n, p, i)
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