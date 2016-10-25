package POJO;

import java.util.Date;


public class SolicitudDeBeca {

    
    private Integer idSolicitud;
    private Integer idUsuario;
    private Integer idExpediente;
    private Integer idOfertaBeca;
    private Date fechaSolicitud;
    private String beneficios;        

    /**
     * @return the idSolicitud
     */
    public Integer getIdSolicitud() {
        return idSolicitud;
    }

    /**
     * @param idSolicitud the idSolicitud to set
     */
    public void setIdSolicitud(Integer idSolicitud) {
        this.idSolicitud = idSolicitud;
    }

    /**
     * @return the idUsuario
     */
    public Integer getIdUsuario() {
        return idUsuario;
    }

    /**
     * @param idUsuario the idUsuario to set
     */
    public void setIdUsuario(Integer idUsuario) {
        this.idUsuario = idUsuario;
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
     * @return the idOfertaBeca
     */
    public Integer getIdOfertaBeca() {
        return idOfertaBeca;
    }

    /**
     * @param idOfertaBeca the idOfertaBeca to set
     */
    public void setIdOfertaBeca(Integer idOfertaBeca) {
        this.idOfertaBeca = idOfertaBeca;
    }

    /**
     * @return the fechaSolicitud
     */
    public Date getFechaSolicitud() {
        return fechaSolicitud;
    }

    /**
     * @param fechaSolicitud the fechaSolicitud to set
     */
    public void setFechaSolicitud(Date fechaSolicitud) {
        this.fechaSolicitud = fechaSolicitud;
    }

    /**
     * @return the beneficios
     */
    public String getBeneficios() {
        return beneficios;
    }

    /**
     * @param beneficios the beneficios to set
     */
    public void setBeneficios(String beneficios) {
        this.beneficios = beneficios;
    }
    
    
    
}
