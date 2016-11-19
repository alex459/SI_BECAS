package POJO;

import java.sql.Timestamp;




public class Bitacora {

    
    private Integer idBitacora;
    private Integer idAccion;
    private Integer idUsuario;
    private Timestamp fechaBitacora;
    private String descripcion;
    private String sqlScript;

    /**
     * @return the idBitacora
     */
    public Integer getIdBitacora() {
        return idBitacora;
    }

    /**
     * @param idBitacora the idBitacora to set
     */
    public void setIdBitacora(Integer idBitacora) {
        this.idBitacora = idBitacora;
    }

    /**
     * @return the idAccion
     */
    public Integer getIdAccion() {
        return idAccion;
    }

    /**
     * @param idAccion the idAccion to set
     */
    public void setIdAccion(Integer idAccion) {
        this.idAccion = idAccion;
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
     * @return the fechaBitacora
     */
    public Timestamp getFechaBitacora() {
        return fechaBitacora;
    }

    /**
     * @param fechaBitacora the fechaBitacora to set
     */
    public void setFechaBitacora(Timestamp fechaBitacora) {
        this.fechaBitacora = fechaBitacora;
    }

    /**
     * @return the descripcion
     */
    public String getDescripcion() {
        return descripcion;
    }

    /**
     * @param descripcion the descripcion to set
     */
    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    /**
     * @return the sqlScript
     */
    public String getSqlScript() {
        return sqlScript;
    }

    /**
     * @param sqlScript the sqlScript to set
     */
    public void setSqlScript(String sqlScript) {
        this.sqlScript = sqlScript;
    }

    
    
    
}
