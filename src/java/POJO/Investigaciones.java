package POJO;

public class Investigaciones{

    
    private Integer idInvestigacion;
    private Integer idDetalleUsuario;
    private String tituloInvestigacion;
    private Boolean publicado;

    /**
     * @return the idInvestigacion
     */
    public Integer getIdInvestigacion() {
        return idInvestigacion;
    }

    /**
     * @param idInvestigacion the idInvestigacion to set
     */
    public void setIdInvestigacion(Integer idInvestigacion) {
        this.idInvestigacion = idInvestigacion;
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
     * @return the tituloInvestigacion
     */
    public String getTituloInvestigacion() {
        return tituloInvestigacion;
    }

    /**
     * @param tituloInvestigacion the tituloInvestigacion to set
     */
    public void setTituloInvestigacion(String tituloInvestigacion) {
        this.tituloInvestigacion = tituloInvestigacion;
    }

    /**
     * @return the publicado
     */
    public Boolean getPublicado() {
        return publicado;
    }

    /**
     * @param publicado the publicado to set
     */
    public void setPublicado(Boolean publicado) {
        this.publicado = publicado;
    }
    
    
}
