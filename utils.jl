struct CityKey
    startcity
    endcity
end

cityfrom(citypair) = CityKey(citypair[1], citypair[2])

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

citiesfromcitykeys(costs::Dict) = Set(
    collect(Iterators.flatten([[x.startcity, x.endcity] for x in keys(costs)])))

