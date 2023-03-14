struct Permutations
    a
    n
    p
    i
end

function Permutations(a::Vector)
    a = copy(a)
    n = length(a)
    p = collect(0:n)
    i = 1
    Permutations(a, n, p, i)
end

function Base.iterate(self::Permutations)
    copy(self.a), self
end

function Base.iterate(self::Permutations, state::Permutations)
    a = copy(state.a)
    n = state.n
    p = copy(state.p)
    i = state.i
    if i < n
        p[i+1] -= 1
        j = isodd(i) ? p[i+1] : 0
        swap!(a, j + 1, i + 1)
        i = 1
        while p[i+1] == 0
            p[i+1] = self.i
            i += 1
        end
        a, Permutations(a, n, p, i)
    else
        nothing
    end
end

function swap!(v::Vector, a::Number, b::Number)
    tmp = v[a]
    v[a] = v[b]
    v[b] = tmp
    nothing
end