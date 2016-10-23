/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package POJO;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

/**
 *
 * @author next
 */
@Entity
@Table(name = "observaciones")
@NamedQueries({
    @NamedQuery(name = "Observaciones.findAll", query = "SELECT o FROM Observaciones o")})
public class Observaciones implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "ID_OBSERVACION")
    private Integer idObservacion;
    @Size(max = 1024)
    @Column(name = "OBSERVACION_O")
    private String observacionO;
    @JoinColumn(name = "ID_EXPEDIENTE", referencedColumnName = "ID_EXPEDIENTE")
    @ManyToOne
    private Expediente idExpediente;

    public Observaciones() {
    }

    public Observaciones(Integer idObservacion) {
        this.idObservacion = idObservacion;
    }

    public Integer getIdObservacion() {
        return idObservacion;
    }

    public void setIdObservacion(Integer idObservacion) {
        this.idObservacion = idObservacion;
    }

    public String getObservacionO() {
        return observacionO;
    }

    public void setObservacionO(String observacionO) {
        this.observacionO = observacionO;
    }

    public Expediente getIdExpediente() {
        return idExpediente;
    }

    public void setIdExpediente(Expediente idExpediente) {
        this.idExpediente = idExpediente;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idObservacion != null ? idObservacion.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Observaciones)) {
            return false;
        }
        Observaciones other = (Observaciones) object;
        if ((this.idObservacion == null && other.idObservacion != null) || (this.idObservacion != null && !this.idObservacion.equals(other.idObservacion))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "POJO.Observaciones[ idObservacion=" + idObservacion + " ]";
    }
    
}
