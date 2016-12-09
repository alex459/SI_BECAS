package POJO;

import java.util.Date;


public class Cargo {

    private Integer idCargo;    
    private Integer idDetalleUsuario;    
    private String nombreCargo;    
    private Date fechaInicio;    
    private Date fechaFin;    
    private String lugar;
    private String responsabilidades;


    /**
     * @return the idCargo
     */
    public Integer getIdCargo() {
        return idCargo;
    }

    /**
     * @param idCargo the idCargo to set
     */
    public void setIdCargo(Integer idCargo) {
        this.idCargo = idCargo;
    }

    /**
     * @return the idDetalleUsuario
     */
    public Integer getIdDetalleUsuario() {
        return idDetalleUsuario;
    }

    /**
     * @param idDetalleUsuario the idDetalleUsuario to set
     */
    public void setIdDetalleUsuario(Integer idDetalleUsuario) {
        this.idDetalleUsuario = idDetalleUsuario;
    }

    /**
     * @return the nombreCargo
     */
    public String getNombreCargo() {
        return nombreCargo;
    }

    /**
     * @param nombreCargo the nombreCargo to set
     */
    public void setNombreCargo(String nombreCargo) {
        this.nombreCargo = nombreCargo;
    }

    /**
     * @return the fechaInicio
     */
    public Date getFechaInicio() {
        return fechaInicio;
    }

    /**
     * @param fechaInicio the fechaInicio to set
     */
    public void setFechaInicio(Date fechaInicio) {
        this.fechaInicio = fechaInicio;
    }

    /**
     * @return the fechaFin
     */
    public Date getFechaFin() {
        return fechaFin;
    }

    /**
     * @param fechaFin the fechaFin to set
     */
    public void setFechaFin(Date fechaFin) {
        this.fechaFin = fechaFin;
    }

    /**
     * @return the lugar
     */
    public String getLugar() {
        return lugar;
    }

    /**
     * @param lugar the lugar to set
     */
    public void setLugar(String lugar) {
        this.lugar = lugar;
    }

    
    public String getResponsabilidades() {
        return responsabilidades;
    }

    public void setResponsabilidades(String responsabilidades) {
        this.responsabilidades = responsabilidades;
    }
    
    
}
