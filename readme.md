Basic info:
  copy, borrow, steal i dont care
  
  written in Julia  ".jl"
  
  to alter stuff actual code has to be changed, output is in terminal but there is no implemented terminal interaction

layout:
-struct parcel: 
    a mutable object to store the score and attributes of each child/object in a generation
    
    has constructor
    
-function fitness!:
    calculates the fitness score of each object in the current generation, default is just some random test code that can be changed for actual use
    
    precision part of the fitness function and can be used however you want
-function darwin:

   tournament style knockout for mutation of tournament winners
   
-function crossover:
    mutates 2 parent objects
    
    mutation rate is just a scalar for how much the things must change
    
    alpha is random noise to ensure diversity
    
    if the use case is changed then the crossover function has to also change
    
function breed!:

    takes the winners from the tournament and makes a new generation of children to repeat the cycle on
    
function genSample:

    specifically this use case it just populates the initial generation
    
to run:

 run the main.jl file in however way you want

to edit/use:

change the fitness function the gensSample function and the crossover function to fit your needs
