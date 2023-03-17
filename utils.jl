module Utils

export loadcostsfromfile, citiesfromcitykeys, journeytocitypairs, calculatecost, CityKey
isequal, hash


struct CityKey
    startcity
    endcity
end

Base.isequal(a::CityKey, b::CityKey) = a.startcity == b.startcity && a.endcity == b.endcity

Base.hash(citykey::CityKey) = hash(citykey.startcity) + hash(citykey.endcity)

citykeyfrom(citypair) = CityKey(citypair[1], citypair[2])

reversekey(citykey::CityKey) = CityKey(citykey.endcity, citykey.startcity)

function stringtodictentry(input)
    startcity, endcity, distance = split(input)
    (CityKey(startcity, endcity), parse(Int, distance))
end

function loadcostsfromfile(filename)
    costs = Dict()
    for line in eachline(filename)
        dictentry = stringtodictentry(line)
        costs[dictentry[1]] = dictentry[2]
    end
    costs
end

citiesfromcitykeys(costs::Dict) = Set(collect(Iterators.flatten([[x.startcity, x.endcity] for x in keys(costs)])))

function journeytocitypairs(journey::Vector)
    cities = collect(journey)
    result = []
    while length(cities) > 1
        first = popfirst!(cities)
        second = cities[1]
        push!(result, (first, second))
    end
    result
end


function calculatecost(citypairs::Vector, costs::Dict)
    sum(map(citypairs) do p
        key = citykeyfrom(p)
        get(costs, key) do
            costs[reversekey(key)]
        end
    end)
end

end