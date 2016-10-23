/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package POJO;

import java.io.Serializable;
import java.util.Date;
import java.util.Set;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

/**
 *
 * @author next
 */
@Entity
@Table(name = "solicitud_de_beca")
@NamedQueries({
    @NamedQuery(name = "SolicitudDeBeca.findAll", query = "SELECT s FROM SolicitudDeBeca s")})
public class SolicitudDeBeca implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "ID_SOLICITUD")
    private Integer idSolicitud;
    @Column(name = "FECHA_SOLICITUD")
    @Temporal(TemporalType.DATE)
    private Date fechaSolicitud;
    @Size(max = 1024)
    @Column(name = "BENEFICIOS")
    private String beneficios;
    @OneToMany(mappedBy = "idSolicitud")
    private Set<ProgramaEstudio> programaEstudioSet;
    @JoinColumn(name = "ID_OFERTA_BECA", referencedColumnName = "ID_OFERTA_BECA")
    @ManyToOne(optional = false)
    private OfertaBeca idOfertaBeca;
    @JoinColumn(name = "ID_USUARIO", referencedColumnName = "ID_USUARIO")
    @ManyToOne
    private Usuario idUsuario;
    @JoinColumn(name = "ID_EXPEDIENTE", referencedColumnName = "ID_EXPEDIENTE")
    @ManyToOne
    private Expediente idExpediente;
    @OneToMany(mappedBy = "idSolicitud")
    private Set<Referencias> referenciasSet;

    public SolicitudDeBeca() {
    }

    public SolicitudDeBeca(Integer idSolicitud) {
        this.idSolicitud = idSolicitud;
    }

    public Integer getIdSolicitud() {
        return idSolicitud;
    }

    public void setIdSolicitud(Integer idSolicitud) {
        this.idSolicitud = idSolicitud;
    }

    public Date getFechaSolicitud() {
        return fechaSolicitud;
    }

    public void setFechaSolicitud(Date fechaSolicitud) {
        this.fechaSolicitud = fechaSolicitud;
    }

    public String getBeneficios() {
        return beneficios;
    }

    public void setBeneficios(String beneficios) {
        this.beneficios = beneficios;
    }

    public Set<ProgramaEstudio> getProgramaEstudioSet() {
        return programaEstudioSet;
    }

    public void setProgramaEstudioSet(Set<ProgramaEstudio> programaEstudioSet) {
        this.programaEstudioSet = programaEstudioSet;
    }

    public OfertaBeca getIdOfertaBeca() {
        return idOfertaBeca;
    }

    public void setIdOfertaBeca(OfertaBeca idOfertaBeca) {
        this.idOfertaBeca = idOfertaBeca;
    }

    public Usuario getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(Usuario idUsuario) {
        this.idUsuario = idUsuario;
    }

    public Expediente getIdExpediente() {
        return idExpediente;
    }

    public void setIdExpediente(Expediente idExpediente) {
        this.idExpediente = idExpediente;
    }

    public Set<Referencias> getReferenciasSet() {
        return referenciasSet;
    }

    public void setReferenciasSet(Set<Referencias> referenciasSet) {
        this.referenciasSet = referenciasSet;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idSolicitud != null ? idSolicitud.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof SolicitudDeBeca)) {
            return false;
        }
        SolicitudDeBeca other = (SolicitudDeBeca) object;
        if ((this.idSolicitud == null && other.idSolicitud != null) || (this.idSolicitud != null && !this.idSolicitud.equals(other.idSolicitud))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "POJO.SolicitudDeBeca[ idSolicitud=" + idSolicitud + " ]";
    }
    
}
