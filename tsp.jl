include("permutaions.jl")
include("utils.jl")

using .Utils, .Permutations

function main()
    costs = loadcostsfromfile("cities.txt")
    cities = citiesfromcitykeys(costs)
    permutations = Permutation(collect(cities))
    cheapestjourneys = []
    lowestcost = typemax(Int)

    println("Number of permutations $(factorial(length(cities)))")

    for journey in permutations
        citypairs = journeytocitypairs(journey)
        currentcost = calculatecost(citypairs, costs)
        if currentcost < lowestcost
            cheapestjourneys = []
            push!(cheapestjourneys, journey)
            lowestcost = currentcost
        elseif currentcost == lowestcost
            push!(cheapestjourneys, journey)
        end
    end

    println("Lowest cost $lowestcost, journeys $cheapestjourneys")
end

# main()