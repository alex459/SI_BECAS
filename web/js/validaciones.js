
function mostrarMensajeAlEnfocar(id_del_mensaje, mensaje) {
    //document.getElementById(id_de_ayuda).value=mensaje	
    //alert(mensaje);
    document.getElementById(id_del_mensaje.toString()).innerHTML = mensaje.toString();

}

function ocultarMensajeAlEnfocar(id_del_mensaje) {
    //document.getElementById(id_de_ayuda).value=mensaje	
    //alert(mensaje);
    document.getElementById(id_del_mensaje.toString()).innerHTML = "";

}

function validarAlfanumerico(id_del_input, e, numero_de_caracteres) {
    
    key = e.keyCode || e.which;
    tecla = String.fromCharCode(key).toLowerCase();
    letras = "áéíóúabcdefghijklmnñopqrstuvwxyz1234567890";
    especiales = [];

    tecla_especial = false
    for(var i in especiales) {
        if(key == especiales[i]) {
            tecla_especial = true;
            break;
        }
    }
    if(letras.indexOf(tecla) == -1 && !tecla_especial)
        return false;
    if(document.getElementById(id_del_input.toString()).value.length>numero_de_caracteres)
        return false;
}

function validarTexto(id_del_input, e, numero_de_caracteres) {
    key = e.keyCode || e.which;
    tecla = String.fromCharCode(key).toLowerCase();
    letras = "áéíóúabcdefghijklmnñopqrstuvwxyz";
    especiales = [8, 37, 39, 46];

    tecla_especial = false
    for(var i in especiales) {
        if(key == especiales[i]) {
            tecla_especial = true;
            break;
        }
    }
    if(letras.indexOf(tecla) == -1 && !tecla_especial)
        return false;  
    if(document.getElementById(id_del_input.toString()).value.length>numero_de_caracteres)
        return false;
}

function validarNumeros(id_del_input, e, numero_de_caracteres) {
    key = e.keyCode || e.which;
    tecla = String.fromCharCode(key).toLowerCase();
    letras = "1234567890";
    especiales = [8, 37, 39, 46];

    tecla_especial = false
    for(var i in especiales) {
        if(key == especiales[i]) {
            tecla_especial = true;
            break;
        }
    }
    if(letras.indexOf(tecla) == -1 && !tecla_especial)
        return false; 
    if(document.getElementById(id_del_input.toString()).value.length>numero_de_caracteres)
        return false;
}

function clavesIguales(id_mensaje, id_clave1, id_clave2) {
    
    if(document.getElementById(id_clave1.toString()).equals(document.getElementById(id_clave2.toString()))  ){
        document.getElementById(id_mensaje.toString()).innerHTML = "La clave es correcta.";  
    }else{
        document.getElementById(id_mensaje.toString()).innerHTML = "La clave no es igual. Repita la primera clave.";  
    }    
    
}

