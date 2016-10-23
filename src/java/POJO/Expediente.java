/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package POJO;

import java.io.Serializable;
import java.util.Set;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

/**
 *
 * @author next
 */
@Entity
@Table(name = "expediente")
@NamedQueries({
    @NamedQuery(name = "Expediente.findAll", query = "SELECT e FROM Expediente e")})
public class Expediente implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "ID_EXPEDIENTE")
    private Integer idExpediente;
    @Size(max = 10)
    @Column(name = "ESTADO_EXPEDIENTE")
    private String estadoExpediente;
    @JoinColumn(name = "ID_PROGRESO", referencedColumnName = "ID_PROGRESO")
    @ManyToOne
    private Progreso idProgreso;
    @OneToMany(mappedBy = "idExpediente")
    private Set<SolicitudDeBeca> solicitudDeBecaSet;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idExpediente")
    private Set<Documento> documentoSet;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idExpediente")
    private Set<Beca> becaSet;
    @OneToMany(mappedBy = "idExpediente")
    private Set<Observaciones> observacionesSet;

    public Expediente() {
    }

    public Expediente(Integer idExpediente) {
        this.idExpediente = idExpediente;
    }

    public Integer getIdExpediente() {
        return idExpediente;
    }

    public void setIdExpediente(Integer idExpediente) {
        this.idExpediente = idExpediente;
    }

    public String getEstadoExpediente() {
        return estadoExpediente;
    }

    public void setEstadoExpediente(String estadoExpediente) {
        this.estadoExpediente = estadoExpediente;
    }

    public Progreso getIdProgreso() {
        return idProgreso;
    }

    public void setIdProgreso(Progreso idProgreso) {
        this.idProgreso = idProgreso;
    }

    public Set<SolicitudDeBeca> getSolicitudDeBecaSet() {
        return solicitudDeBecaSet;
    }

    public void setSolicitudDeBecaSet(Set<SolicitudDeBeca> solicitudDeBecaSet) {
        this.solicitudDeBecaSet = solicitudDeBecaSet;
    }

    public Set<Documento> getDocumentoSet() {
        return documentoSet;
    }

    public void setDocumentoSet(Set<Documento> documentoSet) {
        this.documentoSet = documentoSet;
    }

    public Set<Beca> getBecaSet() {
        return becaSet;
    }

    public void setBecaSet(Set<Beca> becaSet) {
        this.becaSet = becaSet;
    }

    public Set<Observaciones> getObservacionesSet() {
        return observacionesSet;
    }

    public void setObservacionesSet(Set<Observaciones> observacionesSet) {
        this.observacionesSet = observacionesSet;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idExpediente != null ? idExpediente.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Expediente)) {
            return false;
        }
        Expediente other = (Expediente) object;
        if ((this.idExpediente == null && other.idExpediente != null) || (this.idExpediente != null && !this.idExpediente.equals(other.idExpediente))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "POJO.Expediente[ idExpediente=" + idExpediente + " ]";
    }
    
}
