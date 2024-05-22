### Plan 1:
#### Acá se muestra la interacción del modulo ante un deposito.
### Plan 2:
#### Acá se muestra la interacción del modulo ante un intento de retiro con
#### fondos insuficientes y un retiro efectuado.
### Plan 3:
#### Acá se muestra la interacción del modulo ante el error de pin 3 veces
#### mostrando las alartas de advertencia y bloqueo.



### Copilaciones:
#### Para copilar el plan 1 con el modulo conductual
    make copile
#### Para copilar el plan 2 con el modulo conductual
    make copile2
#### Para copilar el plan 3 con el modulo conductual
    make copile3

#### Para copilar el plan 1 con el modulo sintetizado
    make copile4
#### Para copilar el plan 2 con el modulo sintetizado
    make copile5
#### Para copilar el plan 3 con el modulo sintetizado
    make copile6

### ejecuciones
#### Para ejecutar el script de yosys
    yosys tellermachine.ys
#### Para ejecutar lo copilado
    make run

##### NOTA: el comando run también elimita el archivo vcd generado y el vpp
##### esto debido a que así se puede ejecutar los archivos recien copilados
##### y así probando que se llega al mismo resultado.