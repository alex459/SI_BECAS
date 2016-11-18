
//escribir un mensaje en un elemento mediente el id
function mostrarMensajeAlEnfocar(id_elemento, mensaje) {
    document.getElementById(id_elemento.toString()).innerHTML = mensaje.toString();
}

//limpiar el mensaje de un elemento por su id
function ocultarMensajeAlEnfocar(id_elemento) {
    document.getElementById(id_elemento.toString()).innerHTML = "";
}

//validar las entradas de los formularios para que
//solo acepten caracteres alfanumericos
function validarAlfanumerico(id_del_input, e, numero_de_caracteres) {

    key = e.keyCode || e.which;
    tecla = String.fromCharCode(key).toLowerCase();
    letras = "áéíóúabcdefghijklmnñopqrstuvwxyz1234567890";
    especiales = [];

    tecla_especial = false
    for (var i in especiales) {
        if (key == especiales[i]) {
            tecla_especial = true;
            break;
        }
    }
    if (letras.indexOf(tecla) == -1 && !tecla_especial)
        return false;
    if (document.getElementById(id_del_input.toString()).value.length > numero_de_caracteres)
        return false;
}

//validar las entradas de los formularios para que
//solo acepte texto
function validarTexto(id_del_input, e, numero_de_caracteres) {
    key = e.keyCode || e.which;
    tecla = String.fromCharCode(key).toLowerCase();
    letras = "áéíóúabcdefghijklmnñopqrstuvwxyz";
    especiales = [8, 37, 39, 46];

    tecla_especial = false
    for (var i in especiales) {
        if (key == especiales[i]) {
            tecla_especial = true;
            break;
        }
    }
    if (letras.indexOf(tecla) == -1 && !tecla_especial)
        return false;
    if (document.getElementById(id_del_input.toString()).value.length > numero_de_caracteres)
        return false;
}

//validar las entradas de los formularios para que
//solo acepte numeros
function validarNumeros(id_del_input, e, numero_de_caracteres) {
    key = e.keyCode || e.which;
    tecla = String.fromCharCode(key).toLowerCase();
    letras = "1234567890";
    especiales = [8, 37, 39, 46];

    tecla_especial = false
    for (var i in especiales) {
        if (key == especiales[i]) {
            tecla_especial = true;
            break;
        }
    }
    if (letras.indexOf(tecla) == -1 && !tecla_especial)
        return false;
    if (document.getElementById(id_del_input.toString()).value.length > numero_de_caracteres)
        return false;
}

function clavesIguales(id_elemento, id_clave1, id_clave2) {    
    var clave1 = document.getElementById(id_clave1.toString()).value.toString();
    var clave2 = document.getElementById(id_clave2.toString()).value.toString();
    document.getElementById(id_elemento.toString()).innerHTML = "";
    if(clave1==clave2){
        document.getElementById(id_elemento.toString()).innerHTML = "Clave correcta.";
    }else{
        document.getElementById(id_elemento.toString()).innerHTML = "La clave no es la misma. repita la clave.";
    }    
}


function ValidarCamposVacios(ids_elementos) {    
    var elementos = new Array();
    var elementos = ids_elementos.toString().split(',');    
    var exito = true;
    for(var a in elementos){        
        if(document.getElementById(elementos[a].toString()).value.length<=0){
            exito=false;            
        }       
    }
    alert("RESULTADO "+exito);
    return exito;
}

