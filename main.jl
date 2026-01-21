import Random
mutable struct parcel
    attributes::Vector{Float64}
    score::Float32
    function parcel(attrs)
        new(attrs,0)  # now allowed
    end
end
# ,n.length,", " ,n.width,", " ,n.height,", "for (i, x) in enumerate(arrx)
Base.show(io::IO, p::parcel) = begin
    for (i,x) in enumerate(p.attributes) print(io, "x{",i,"}: ",x,", ")end
    print(io, "score ",p.score,")")
    end
Base.show(io::IO, p::Vector{parcel}) =begin
    println("------------------------------------------------------")
    for n in p 
        println(io,n)
    end
    println("------------------------------------------------------")
end
Base.isless(a::parcel, b::parcel) = isless(a.score, b.score)
Base.:(==)(a::parcel, b::parcel) = a.score == b.score

#=
3𝑥𝑥1 + 2𝑥𝑥2 + 4𝑥𝑥3
subject to 𝑥𝑥1 + 𝑥𝑥2 + 2𝑥𝑥3 ≤ 4
2𝑥𝑥1 + 3𝑥𝑥3 ≤ 5
2𝑥𝑥1 + 𝑥𝑥2 + 3𝑥𝑥3 ≤7
=#

function fitness!(children,precision)
    for (p) in children
        #some random fitness function
        x=p.attributes
        z=x[1]*5+4*x[2]
        c=falses(5)
        c[1]=x[1]*6+x[2]*4<=24+precision
        c[2]=x[1]+2*x[2]<=6+precision
        c[3]=-x[1]+x[2]<=1+precision

        c[4]=0<=x[1]
        c[5]=0<=x[2]
        p.score=z

        for ci in c
            if (ci==false) 
                p.score=(-z) 
                continue
            end
        end 
        #some random fitness function end
    end

    sort!(children, by = x -> x.score,rev=true)
    #sort!(children, by = x -> x.score)

end
function darwin(children,n)
    surviors=Vector{parcel}()
    for _ in 1:length(children)
        group=rand(children,div(n,2) ) 
        winner=maximum(group)
        push!(surviors,winner)
        #popat!(children,findfirst(isequal(winner),children))
    end
    return surviors
end

function crossover(parent1, parent2,mutation_rate=1)
    alpha = rand()
    mix=(p1,p2)->(alpha * p1 + (1-alpha)* p2+(rand()* 2*mutation_rate - mutation_rate ))
    child1 = parcel([mix(p1,p2) for (p1,p2) in zip(parent1.attributes,parent2.attributes)])
    child2 = parcel([mix(p2,p1) for (p1,p2) in zip(parent1.attributes,parent2.attributes)])
    return child1, child2
end
function breed!(winners,population,mutation_rate=1)
    #population[1]=children[1]
    
    sort!(population, by = x -> x.score,rev=false)
    for i in 3:2:length(winners)
        population[i],population[i-1]=crossover(winners[i],winners[i-1],mutation_rate)
    end
end
function genSample(n)
    population=Vector{parcel}()
    for x in 1:n
        #println(length+width+height)
        atts=rand(Float32,2)
        push!(population,parcel(atts))
    end

    return population
end
function main(generations=10,n=30)
    population=genSample(n)
    println("------------------ population")
    println(population)
    for i in 1:generations
        precision=(generations/(generations*i*i))
        for i in 1:10
            fitness!(population,5*precision)        
            #println(population[1])     
            winners=darwin(population,n)
            breed!(winners,population,0.01+precision)
        end
    end
    fitness!(population,0)
    #println(population)
    sort!(population, by = x -> x.score,rev=true)#keep best at pos 1
    println(population[1])
end
main(10)



