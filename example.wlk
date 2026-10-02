import wollok.game.*
 // etapa 1

class ChevroletCorsa {

var color

method color() = color

method unColor(unColor) {

color = unColor

}


method capacidad() = 4

method velocidadMaxima() = 150

method peso() = 1300

}



class RenaultKwid {

var tieneTanqueAdicional = false

method tieneTanqueAdicional() = tieneTanqueAdicional



method tieneTanqueAdicional(unBooleano) {

tieneTanqueAdicional = unBooleano

}

method capacidad() = if (tieneTanqueAdicional) 3 else 4

method velocidadMaxima() = if (tieneTanqueAdicional) 120 else 110

method peso() = 1200 + if (tieneTanqueAdicional) 150 else 0

method color() = "azul"

} 

object trafic {
  var interior = interiorComodo
  var motor = motorPulenta
  
  method interior(unInterior) {
    interior = unInterior
  }
  
  method motor(unMotor) {
    motor = unMotor
  }
  
  method capacidad() = interior.capacidad()
  
  method velocidadMaxima() = motor.velocidadMaxima()
  
  method peso() = (4000 + interior.peso()) + motor.peso()
  
  method color() = "blanco"
} 

// Interiores para la Trafic
object interiorComodo {
  method capacidad() = 5
  
  method peso() = 700
}

object interiorPopular {
  method capacidad() = 12
  
  method peso() = 1000
} 

// Motores para la Trafic
object motorPulenta {
  method velocidadMaxima() = 130
  
  method peso() = 800
}

object motorBataton {
  method velocidadMaxima() = 80
  
  method peso() = 500
} 

// Autos Especiales: 
class AutoEspecial {
  var capacidad
  var velocidadMaxima
  var peso
  var color
  
  method capacidad() = capacidad
  
  method velocidadMaxima() = velocidadMaxima
  
  method peso() = peso
  
  method color() = color
} 

class Dependencia {
  var empleados = 0
  const flota = []
 
  
  method empleados() = empleados
  
  method empleados(cantidad) {
    empleados = cantidad
  }
  
  method agregarAFlota(rodado) {
    flota.add(rodado)
  }
  
  method quitarDeFlota(rodado) {
    flota.remove(rodado)
  }
  
  method pesoTotalFlota() = flota.sum({ rodado => rodado.peso() })
  
  method estaBienEquipada() = (flota.size() >= 3) and flota.all({ rodado => rodado.velocidadMaxima() >= 100 })
  
  method capacidadTotalEnColor(color) = flota.filter({ rodado => rodado.color() == color }).sum({ rodado => rodado.capacidad() })
  
  method colorDelRodadoMasRapido() = flota.max({ rodado => rodado.velocidadMaxima() }).color()
  
  method capacidadFaltante() = (empleados - flota.sum({ rodado => rodado.capacidad() })).max(0)
  
  method esGrande() = (empleados >= 40) and (flota.size() >= 5)


// Adjunto registro de los pedidos de cada dependencia - Etapa 3
const pedidos = []

  method pedidos() = pedidos

  method agregarPedido(unPedido) {
    pedidos.add(unPedido)
  }

  method quitarPedido(unPedido) {
    pedidos.remove(unPedido)
  }

  
  method totalPasajerosEnPedidos() {
    return pedidos.sum({ pedido => pedido.cantidadPasajeros() })
  }

  
  method pedidosNoSatisfechos() {
    return pedidos.filter({ pedido => not flota.any({ auto => pedido.puedeSatisfacer(auto) })})
  }

  
  method esIncompatibleParaTodos(color) {
    return pedidos.all({ pedido => 
      pedido.coloresIncompatibles().contains(color)})
  }

  
  method relajarTodosLosPedidos() {
    pedidos.forEach({ pedido => pedido.relajar() })
  }
}
// Etapa 2 - Modelo de pedidos
class Pedido {
  var distancia
  var tiempoMaximo
  var cantidadPasajeros
  const coloresIncompatibles = #{}

  
  method distancia() = distancia
  method tiempoMaximo() = tiempoMaximo
  method cantidadPasajeros() = cantidadPasajeros
  method coloresIncompatibles() = coloresIncompatibles
  method velocidadRequerida() = distancia / tiempoMaximo

  method puedeSatisfacer(unAuto) {
    const satisfaceVelocidad = unAuto.velocidadMaxima() >= self.velocidadRequerida() + 10
    const satisfaceCapacidad = unAuto.capacidad() >= cantidadPasajeros
    
    const satisfaceColor = not coloresIncompatibles.contains(unAuto.color())

    return satisfaceVelocidad && satisfaceCapacidad && satisfaceColor
  }

  // Modificadores de tiempo
  method acelerar() {
    tiempoMaximo -= 1
  }

  method relajar() {
    tiempoMaximo += 1
  }

}