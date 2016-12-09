<div class="col-md-2">
    <ul id="sidebar" class="nav nav-pills nav-stacked" style="max-width: 200px;">
        <li><a href="#/">Datos personales</a></li>
        <li><a href="#/laboral">Informaci�n laboral</a></li>
        <li><a href="#/educacion">Educaci�n</a></li>
        <li><a href="#/cargos">Cargos desempe�ados</a></li>
        <li><a href="#/oferta">Informaci�n de beca</a></li>
        <li><a href="#/referencias">Referencias personales</a></li>
        <li  class="active"><a href="#/documentos">Adjuntar documentos</a></li>
    </ul>
</div>  

<div class="col-md-10">
    <div class="row">   
        <div class="row">
            <div class="col-md-3">
                <label for="textinput">Acciones</label>
            </div>
        </div>  
        <div class="col-md-3">
            <div class = "panel panel-default" style="padding: 10px;">
                <button type="submit" class="btn btn-success">
                    <span class="glyphicon glyphicon-file"></span> 
                    Exportar
                </button>
                <button type="submit" class="btn btn-success">
                    <span class="glyphicon glyphicon-print"></span> 
                    Imprimir
                </button>
            </div>
        </div> 
    </div>
    <fieldset class="custom-border">
        <legend class="custom-border">Documentaci�n</legend>

        <div class="row">   
            <div class="col-md-6">
                <label class="text-danger">Adjuntar los siguientes documentos</label><br><br>
            </div> 
        </div>                            
        <div class="row">
            <div class="col-md-6">
                <label>SOLICITUD DE BECA FIRMADA: </label>
                <input type="hidden" value="id"><br>
            </div>
            <div class="col-md-5">
                <div class="row">
                    <input name="solicitudFirmada" type="file" accept="application/pdf"><br>
                </div>                               
            </div>      
        </div>       
        <div class="row">
            <div class="col-md-6">
                <label>DICTAMEN DEL JEFE DEL DEPARTAMENTO O ESCUELA QUE MANIFIESTA ELECCION POR CONCURSO DE OPOSICI�N: </label>
                <input type="hidden" value="id"><br>
            </div>
            <div class="col-md-5">
                <div class="row">
                    <input name="dictamenJefe" type="file" accept="application/pdf"><br>
                </div>                               
            </div>      
        </div>
        <div class="row">
            <div class="col-md-6">
                <label>T�TULO ACAD�MICO: </label>
                <input type="hidden" value="id"><br>
            </div>
            <div class="col-md-5">
                <div class="row">
                    <input name="tituloAcademico" type="file" accept="application/pdf"><br>
                </div>                               
            </div>      
        </div>
        <div class="row">
            <div class="col-md-6">
                <label>PARTIDA DE NACIMIENTO: </label>
                <input type="hidden" value="id"><br>
            </div>
            <div class="col-md-5">
                <div class="row">
                    <input name="partida" type="file" accept="application/pdf"><br>
                </div>                               
            </div>      
        </div>
        <div class="row">
            <div class="col-md-6">
                <label>DUI: </label>
                <input type="hidden" value="id"><br>
            </div>
            <div class="col-md-5">
                <div class="row">
                    <input name="dui" type="file" accept="application/pdf"><br>
                </div>                               
            </div>      
        </div>
        <div class="row">
            <div class="col-md-6">
                <label>CURR�CULUM VITAE: </label>
                <input type="hidden" value="id"><br>
            </div>
            <div class="col-md-5">
                <div class="row">
                    <input name="curriculo" type="file" accept="application/pdf"><br>
                </div>                               
            </div>      
        </div>
        <div class="row">
            <div class="col-md-6">
                <label>NOTAS GLOBALES: </label>
                <input type="hidden" value="id"><br>
            </div>
            <div class="col-md-5">
                <div class="row">
                    <input name="notas" type="file" accept="application/pdf"><br>
                </div>                               
            </div>      
        </div>
        <div class="row">
            <div class="col-md-6">
                <label>CERTIFICADO DE SALUD: </label>
                <input type="hidden" value="id"><br>
            </div>
            <div class="col-md-5">
                <div class="row">
                    <input name="certificado" type="file" accept="application/pdf"><br>
                </div>                               
            </div>      
        </div>
        <div class="row">
            <div class="col-md-6">
                <label>PODER JUDICIAL OTORGADO A SU APODERADO: </label>
                <input type="hidden" value="id"><br>
            </div>
            <div class="col-md-5">
                <div class="row">
                    <input name="poder" type="file" accept="application/pdf"><br>
                </div>                               
            </div>      
        </div>
        
        

        <div>
            <input type="hidden" name="user" ng-value="{{user}}">
            <input type="hidden" name="nombre1" ng-value = "data.nombre" >
            <input type="hidden" name="nombre2" ng-value = "data.nombre2">
            <input type="hidden" name="apellido1" ng-value ="data.apellido1">
            <input type="hidden" name="apellido2" ng-value ="data.apellido2">
            <input type="hidden" name="fechaNacimiento" ng-value="data.fecha_nacimiento">
            <input type="hidden" name="departamentoNacimiento" ng-value="data.departamento_nacimiento">
            <input type="hidden" name="municipioNacimiento" ng-value="data.municipio_nacimiento">
            <input type="hidden" name="genero" ng-value="data.genero">
            <input type="hidden" name="direccion" ng-value="data.direccion">
            <input type="hidden" name="departamentoDireccion" ng-value="data.departamento_direccion">
            <input type="hidden" name="municipioDireccion" ng-value="data.municipio_direccion">
            <input type="hidden" name="telCasa" ng-value="data.tel_casa">
            <input type="hidden" name="telMovil" ng-value="data.tel_movil">
            <input type="hidden" name="telOficina" ng-value="data.tel_oficina">

            <input type="hidden" name="profesion" ng-value="data.profesion">
            <input type="hidden" name="cargo" ng-value="data.cargo">
            <input type="hidden" name="unidad" ng-value="data.unidad">
            <input type="hidden" name="facultad" ng-value="data.facultad">
            <input type="hidden" name="fechaContratacion" ng-value="data.fecha_contratacion">

            <input type="hidden" name="beneficios" ng-value="data.beneficios">

            <input type="hidden" name="nombre1R1" ng-value = "data.nombre1R1" >
            <input type="hidden" name="nombre2R1" ng-value = "data.nombre2R1" >
            <input type="hidden" name="apellido1R1" ng-value = "data.apellido1R1" >
            <input type="hidden" name="apellido2R1" ng-value = "data.apellido2R1" >
            <input type="hidden" name="direccionR1" ng-value = "data.direccionR1" >
            <input type="hidden" name="departamentoR1" ng-value = "data.departamentoR1" >
            <input type="hidden" name="municipioR1" ng-value = "data.municipioR1" >
            <input type="hidden" name="telefonoR1" ng-value = "data.telefonoR1" >

            <input type="hidden" name="nombre1R2" ng-value = "data.nombre1R2" >
            <input type="hidden" name="nombre2R2" ng-value = "data.nombre2R2" >
            <input type="hidden" name="apellido1R2" ng-value = "data.apellido1R2" >
            <input type="hidden" name="apellido2R2" ng-value = "data.apellido2R2" >
            <input type="hidden" name="direccionR2" ng-value = "data.direccionR2" >
            <input type="hidden" name="departamentoR2" ng-value = "data.departamentoR2" >
            <input type="hidden" name="municipioR2" ng-value = "data.municipioR2" >
            <input type="hidden" name="telefonoR2" ng-value = "data.telefonoR2" >

            <input type="hidden" name="nombre1R3" ng-value = "data.nombre1R3" >
            <input type="hidden" name="nombre2R3" ng-value = "data.nombre2R3" >
            <input type="hidden" name="apellido1R3" ng-value = "data.apellido1R3" >
            <input type="hidden" name="apellido2R3" ng-value = "data.apellido2R3" >
            <input type="hidden" name="direccionR3" ng-value = "data.direccionR3" >
            <input type="hidden" name="departamentoR3" ng-value = "data.departamentoR3" >
            <input type="hidden" name="municipioR3" ng-value = "data.municipioR3" >
            <input type="hidden" name="telefonoR3" ng-value = "data.telefonoR3" >

            <div class="row" ng-repeat="x in data.educacion">
                <input type="hidden" name="{{x.tipo}}" ng-value="aux.auxTipoEdu[$index +1]">
                <input type="hidden" name="{{x.grado}}" ng-value="aux.auxGradoEdu[$index +1]">
                <input type="hidden" name="{{x.institucion}}" ng-value="aux.auxInstitucionEdu[$index +1]">
                <input type="hidden" name="{{x.anyo}}" ng-value="aux.auxAnyoEdu[$index +1]"><br>
            </div>
            <div class="row" ng-repeat="x in data.proyectos">
                <input type="hidden" name="{{x.titulo}}" ng-value="aux.auxTituloProy[$index +1]">
                <input type="hidden" name="{{x.publicado}}" ng-value="aux.auxPublicado[$index +1]">
            </div>
            <div class="row" ng-repeat="x in data.idiomas">
                <input type="hidden" name="{{x.idioma}}" ng-value="aux.auxIdioma[$index +1]">
                <input type="hidden" name="{{x.nivelHabla}}" ng-value="aux.auxNivelHabla[$index +1]">
                <input type="hidden" name="{{x.nivelLectura}}" ng-value="aux.auxNivelLectura[$index +1]">
                <input type="hidden" name="{{x.nivelEscritura}}" ng-value="aux.auxNivelEscritura[$index +1]"><br>
            </div>
            <div class="row" ng-repeat="x in data.asociaciones">
                <input type="hidden" name="{{x.asociacion}}" ng-value="aux.auxAsociacion[$index +1]">
            </div>
            <div class="row" ng-repeat="x in data.cargos">
                <input type="hidden" name="{{x.lugar}}" ng-value="aux.auxLugar[$index +1]">
                <input type="hidden" name="{{x.cargo}}" ng-value="aux.auxCargo[$index +1]">
                <input type="hidden" name="{{x.fechaInicio}}" ng-value="aux.auxFechaInicio[$index +1]">
                <input type="hidden" name="{{x.fechaFin}}" ng-value="aux.auxFechaFin[$index +1]">
                <input type="hidden" name="{{x.responsabilidades}}" ng-value="aux.auxResponsabilidades[$index +1]">
            </div>
            <div class="row" ng-repeat="x in data.programas">
                <input type="hidden" name="{{x.semestre}}" ng-value="{{$index + 1}}">
                <input type="hidden" name="{{x.programa}}" ng-value="aux.auxPrograma[$index +1]">
            </div>
        </div>
    </fieldset>            
    <div class="row">
        <div class="col-md-4 col-lg-offset-4">
            <a href=""><button id="button1id" name="regresar" class="btn btn-primary">Regresar</button></a>                        
            <input type="submit" name="enviar" class="btn btn-success" value="Enviar">
            <a href=""><button id="button2id" name="cancelar" class="btn btn-danger">Cancelar</button></a>
        </div>
    </div></br>
</div> 
</br>