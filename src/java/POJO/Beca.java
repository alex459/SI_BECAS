package POJO;

import java.util.Date;


public class Beca{

    
    private Integer idBeca;
    private Integer idExpediente;    
    private Date fechaInicio;    
    private Date fechaFin;

    /**
     * @return the idBeca
     */
    public Integer getIdBeca() {
        return idBeca;
    }

    /**
     * @param idBeca the idBeca to set
     */
    public void setIdBeca(Integer idBeca) {
        this.idBeca = idBeca;
    }

    /**
     * @return the idExpediente
     */
    public Integer getIdExpediente() {
        return idExpediente;
    }

    /**
     * @param idExpediente the idExpediente to set
     */
    public void setIdExpediente(Integer idExpediente) {
        this.idExpediente = idExpediente;
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

    
    
}
