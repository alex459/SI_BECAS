package POJO;
import java.io.InputStream;
import java.util.Date;

public class Documento{

    private Integer idDocumento;
    private TipoDocumento idTipoDocumento;
    private Expediente idExpediente;    
    private InputStream documentoDigital;    
    private Date fechaSolicitud;    
    private String observacion;    
    private Date fechaIngreso;    
    private String estadoDocumento;

    /**
     * @return the idDocumento
     */
    public Integer getIdDocumento() {
        return idDocumento;
    }

    /**
     * @param idDocumento the idDocumento to set
     */
    public void setIdDocumento(Integer idDocumento) {
        this.idDocumento = idDocumento;
    }

    /**
     * @return the idTipoDocumento
     */
    public TipoDocumento getIdTipoDocumento() {
        return idTipoDocumento;
    }

    /**
     * @param idTipoDocumento the idTipoDocumento to set
     */
    public void setIdTipoDocumento(TipoDocumento idTipoDocumento) {
        this.idTipoDocumento = idTipoDocumento;
    }

    /**
     * @return the idExpediente
     */
    public Expediente getIdExpediente() {
        return idExpediente;
    }

    /**
     * @param idExpediente the idExpediente to set
     */
    public void setIdExpediente(Expediente idExpediente) {
        this.idExpediente = idExpediente;
    }

    /**
     * @return the documentoDigital
     */
    public InputStream getDocumentoDigital() {
        return documentoDigital;
    }

    /**
     * @param documentoDigital the documentoDigital to set
     */
    public void setDocumentoDigital(InputStream documentoDigital) {
        this.documentoDigital = documentoDigital;
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
     * @return the observacionO
     */
    public String getObservacion() {
        return observacion;
    }

    /**
     * @param observacion the observacionO to set
     */
    public void setObservacion(String observacion) {
        this.observacion = observacion;
    }

    /**
     * @return the fechaIngreso
     */
    public Date getFechaIngreso() {
        return fechaIngreso;
    }

    /**
     * @param fechaIngreso the fechaIngreso to set
     */
    public void setFechaIngreso(Date fechaIngreso) {
        this.fechaIngreso = fechaIngreso;
    }

    /**
     * @return the estadoDocumento
     */
    public String getEstadoDocumento() {
        return estadoDocumento;
    }

    /**
     * @param estadoDocumento the estadoDocumento to set
     */
    public void setEstadoDocumento(String estadoDocumento) {
        this.estadoDocumento = estadoDocumento;
    }
        
}
