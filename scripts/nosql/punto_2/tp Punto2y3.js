db.Vuelo.find({}).pretty()
// Punto 1


// Punto 2
var anio = "2020"
var ciudad = "Buenos Aires"

db.Vuelo.find(
    {partida:{$gte:ISODate(anio+"-01-01"),$lt:ISODate(anio+"-12-31")},ciudadDestino:ciudad}
    
    ).pretty()//.count()
// Punto 3 
var fecha = "2020-05-21" 
db.Vuelo.find(
    {partida:{$gte:ISODate(fecha)}}
    
    ).pretty()//.count()
  
  
  
  
    
  